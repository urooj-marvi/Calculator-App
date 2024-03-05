import 'package:calculatorapp/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> Buttons = [
    'C',
    'Del',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: Buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer='';
                          });
                        },
                        buttonText: Buttons[index],
                        color: Colors.green,
                        textcolor: Colors.white,
                      );
                    }
                    // Delete Button
                    else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);

                          });
                        },
                        buttonText: Buttons[index],
                        color: Colors.red,
                        textcolor: Colors.white,
                      );
                    }
                    // Equal Button
                    else if (index == Buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPresses();
                          });
                        },
                        buttonText: Buttons[index],
                        color: Colors.deepPurple,
                        textcolor: Colors.white,
                      );
                    }

                    // rest of Buttons
                    else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += Buttons[index];
                          });
                        },
                        buttonText: Buttons[index],
                        color: isOperator(Buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textcolor: isOperator(Buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPresses() {
    String FinalQuestion = userQuestion;
    FinalQuestion= FinalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(FinalQuestion);
    ContextModel cm= ContextModel();
    double eval= exp.evaluate(EvaluationType.REAL, cm);
    userAnswer=eval.toString();
  }
}
