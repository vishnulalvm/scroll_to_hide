import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that hides its child when the user scrolls down and shows it again when the user scrolls up.
/// This behavior is commonly used to hide elements like a bottom navigation bar to provide a more immersive user experience.
class ScrollToHide extends StatefulWidget {
  /// Creates a `ScrollToHide` widget.
  ///
  /// The [child], [scrollController], and [height] parameters are required.
  /// The [duration] parameter is optional and defaults to 300 milliseconds.
  ///
  /// The [child] is the widget that you want to hide/show based on the scroll direction.
  ///
  /// The [scrollController] is the `ScrollController` that is connected to the scrollable widget in your app.
  /// This is used to track the scroll position and determine whether to hide or show the child widget.
  ///
  /// The [height] is the initial height of the child widget. When the widget is hidden, its height will be animated to 0.
  const ScrollToHide({
    Key? key,
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 300),
    required this.height,
  }) : super(key: key);

  /// The widget that you want to hide/show based on the scroll direction.
  final Widget child;

  /// The `ScrollController` that is connected to the scrollable widget in your app.
  /// This is used to track the scroll position and determine whether to hide or show the child widget.
  final ScrollController scrollController;

  /// The duration of the animation when the child widget is hidden or shown.
  final Duration duration;

  /// The initial height of the child widget. When the widget is hidden, its height will be animated to 0.
  final double height;

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool isShown = true;

  @override
  void initState() {
    widget.scrollController.addListener(listen);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isShown ? widget.height : 0,
      child: Wrap(
        children: [
          widget.child,
        ],
      ),
    );
  }

  /// Shows the child widget if it is currently hidden.
  void show() {
    if (!isShown) {
      setState(() => isShown = true);
    }
  }

  /// Hides the child widget if it is currently shown.
  void hide() {
    if (isShown) {
      setState(
        () => isShown = false,
      );
    }
  }

  void listen() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }
}
