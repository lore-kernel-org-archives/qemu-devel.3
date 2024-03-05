Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BDEC54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdW-0008RQ-4B; Tue, 05 Mar 2024 06:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdU-0008Kk-70
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:04 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdR-0002px-2m
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:03 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-565a2c4cc1aso645123a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636819; x=1710241619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkKUFn7AWxVAg35b06t0kYYg99FgIPb4F94cJxfsPG8=;
 b=inzMcji3PJuLy0CU2J88vhdw7h9e2ZaR1IM00d4JpWmiPQ4TOF61osHWewP2CkXFWe
 0Mm41wdwbJkSgEbwLtftzcXcTV7aFXn5WBowf0QlY1tY9EMl+oeC5u8e/9k/IdZgvN79
 mT36qV9nhCaE17YreUxoK54kI1GwY2nfc79ugZpmg0XQeGx78fLAOXsw3gn9vsE3AkAh
 u7B5fKyNAFK1CXxvC470Pf7yOnXiklEgWfFQ/A09Yd7sp5Z3oQetF0ng2HnBgclk/BJD
 QBXGXc2/mLgxrgVfr1mIGm8focr8JkciYh+4HBBByuoA/9vuaN6C6WS6NQiE/bttjn9O
 g6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636819; x=1710241619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkKUFn7AWxVAg35b06t0kYYg99FgIPb4F94cJxfsPG8=;
 b=TscpMjVEuSJIKa04GWDb4Hpiy5EoRAzbeZNQoxxaLyZ4CpnW0keYOTZ5//Y06i2BtY
 H/tGm6P3BE2q+AHWbrnkcga/P9i2Y1lN1+UAkDF+1w3DndZX7/EF5Q2idhjS8+PngqSx
 WqGVUoZHWWWsLtw1bNcxsXwkqfjdk/IzGeIO2FpAsQsbCfC+HEg5R06TvVpzOLAZkezO
 UiMh+VAbG9I5IX/Dtv9Ni7aGZ5q/W9CmNCmqIqgh3fWFMq9zU9zbXwUjk/FLkYeRSrf3
 UWsMvdTnSNc50DkUxdVF5j7MPB4K/4YCqhcUAndP2PuhKTnWepefN0fn17RVTl4KNYNI
 2EHw==
X-Gm-Message-State: AOJu0Yzc7kkl9QoBkz95I3RGfdF2jFdNpxvU0/axqcOO6tWDOgtu2ijt
 0C8ATrybvqSocncISqYJi2fsXWLfnl6m892AO5kyBrBUWp72K5BAvPyF51p83qtzYuo4rQGB/aL
 q
X-Google-Smtp-Source: AGHT+IEwFl/elkE4HvyH8BuWmLMrnoyGgvBOP4nNnPd+Y2uNxL7sS041q7tYghus8EYRydx4ddn27g==
X-Received: by 2002:a05:6402:cac:b0:566:1694:7090 with SMTP id
 cn12-20020a0564020cac00b0056616947090mr8407475edb.11.1709636819024; 
 Tue, 05 Mar 2024 03:06:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 y26-20020a056402135a00b0056694006fa7sm5714070edw.70.2024.03.05.03.06.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 08/12] ui/cocoa: Let the platform toggle fullscreen
Date: Tue,  5 Mar 2024 12:06:03 +0100
Message-ID: <20240305110608.21618-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.998, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It allows making the window full screen by clicking full screen button
provided by the platform (the left-top green button) and save some code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-6-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 420 ++++++++++++++++++++++++-----------------------------
 1 file changed, 187 insertions(+), 233 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index a2e52ceabc..20d73098e2 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -308,20 +308,17 @@ static void handleAnyDeviceErrors(Error * err)
 */
 @interface QemuCocoaView : NSView
 {
+    NSTrackingArea *trackingArea;
     QEMUScreen screen;
-    NSWindow *fullScreenWindow;
-    float cx,cy,cw,ch,cdx,cdy;
     pixman_image_t *pixman_image;
     QKbdState *kbd;
     BOOL isMouseGrabbed;
-    BOOL isFullscreen;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
 - (void) ungrabMouse;
-- (void) toggleFullScreen:(id)sender;
 - (void) setFullGrab:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (bool) handleEvent:(NSEvent *)event;
@@ -337,8 +334,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
  */
 - (BOOL) isMouseGrabbed;
 - (BOOL) isAbsoluteEnabled;
-- (float) cdx;
-- (float) cdy;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
 @end
@@ -399,46 +394,43 @@ - (BOOL) isOpaque
     return YES;
 }
 
-- (BOOL) screenContainsPoint:(NSPoint) p
+- (void) removeTrackingRect
 {
-    return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < screen.height);
+    if (trackingArea) {
+        [self removeTrackingArea:trackingArea];
+        [trackingArea release];
+        trackingArea = nil;
+    }
 }
 
-/* Get location of event and convert to virtual screen coordinate */
-- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
+- (void) frameUpdated
 {
-    NSWindow *eventWindow = [ev window];
-    // XXX: Use CGRect and -convertRectFromScreen: to support macOS 10.10
-    CGRect r = CGRectZero;
-    r.origin = [ev locationInWindow];
-    if (!eventWindow) {
-        if (!isFullscreen) {
-            return [[self window] convertRectFromScreen:r].origin;
-        } else {
-            CGPoint locationInSelfWindow = [[self window] convertRectFromScreen:r].origin;
-            CGPoint loc = [self convertPoint:locationInSelfWindow fromView:nil];
-            if (stretch_video) {
-                loc.x /= cdx;
-                loc.y /= cdy;
-            }
-            return loc;
-        }
-    } else if ([[self window] isEqual:eventWindow]) {
-        if (!isFullscreen) {
-            return r.origin;
-        } else {
-            CGPoint loc = [self convertPoint:r.origin fromView:nil];
-            if (stretch_video) {
-                loc.x /= cdx;
-                loc.y /= cdy;
-            }
-            return loc;
-        }
-    } else {
-        return [[self window] convertRectFromScreen:[eventWindow convertRectToScreen:r]].origin;
+    [self removeTrackingRect];
+
+    if ([self window]) {
+        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
+                                        NSTrackingMouseEnteredAndExited |
+                                        NSTrackingMouseMoved;
+        trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame]
+                                                    options:options
+                                                      owner:self
+                                                   userInfo:nil];
+        [self addTrackingArea:trackingArea];
+        [self updateUIInfo];
     }
 }
 
+- (void) viewDidMoveToWindow
+{
+    [self resizeWindow];
+    [self frameUpdated];
+}
+
+- (void) viewWillMoveToWindow:(NSWindow *)newWindow
+{
+    [self removeTrackingRect];
+}
+
 - (void) hideCursor
 {
     if (!cursor_hide) {
@@ -518,36 +510,25 @@ - (void) drawRect:(NSRect) rect
     }
 }
 
-- (void) setContentDimensions
+- (NSSize) screenSafeAreaSize
 {
-    COCOA_DEBUG("QemuCocoaView: setContentDimensions\n");
+    NSSize size = [[[self window] screen] frame].size;
+    NSEdgeInsets insets = [[[self window] screen] safeAreaInsets];
+    size.width -= insets.left + insets.right;
+    size.height -= insets.top + insets.bottom;
+    return size;
+}
 
-    if (isFullscreen) {
-        cdx = [[NSScreen mainScreen] frame].size.width / (float)screen.width;
-        cdy = [[NSScreen mainScreen] frame].size.height / (float)screen.height;
+- (void) resizeWindow
+{
+    [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
 
-        /* stretches video, but keeps same aspect ratio */
-        if (stretch_video == true) {
-            /* use smallest stretch value - prevents clipping on sides */
-            if (MIN(cdx, cdy) == cdx) {
-                cdy = cdx;
-            } else {
-                cdx = cdy;
-            }
-        } else {  /* No stretching */
-            cdx = cdy = 1;
-        }
-        cw = screen.width * cdx;
-        ch = screen.height * cdy;
-        cx = ([[NSScreen mainScreen] frame].size.width - cw) / 2.0;
-        cy = ([[NSScreen mainScreen] frame].size.height - ch) / 2.0;
-    } else {
-        cx = 0;
-        cy = 0;
-        cw = screen.width;
-        ch = screen.height;
-        cdx = 1.0;
-        cdy = 1.0;
+    if (!stretch_video) {
+        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
+        [[self window] center];
+    } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
+        [[self window] setContentSize:[self screenSafeAreaSize]];
+        [[self window] center];
     }
 }
 
@@ -571,9 +552,10 @@ - (void) updateUIInfoLocked
         CGDirectDisplayID display = [[description objectForKey:@"NSScreenNumber"] unsignedIntValue];
         NSSize screenSize = [[[self window] screen] frame].size;
         CGSize screenPhysicalSize = CGDisplayScreenSize(display);
+        bool isFullscreen = ([[self window] styleMask] & NSWindowStyleMaskFullScreen) != 0;
         CVDisplayLinkRef displayLink;
 
-        frameSize = isFullscreen ? screenSize : [self frame].size;
+        frameSize = isFullscreen ? [self screenSafeAreaSize] : [self frame].size;
 
         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
             CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
@@ -620,31 +602,19 @@ - (void) updateUIInfo
     });
 }
 
-- (void)viewDidMoveToWindow
-{
-    [self updateUIInfo];
-}
-
 - (void) switchSurface:(pixman_image_t *)image
 {
     COCOA_DEBUG("QemuCocoaView: switchSurface\n");
 
     int w = pixman_image_get_width(image);
     int h = pixman_image_get_height(image);
-    /* cdx == 0 means this is our very first surface, in which case we need
-     * to recalculate the content dimensions even if it happens to be the size
-     * of the initial empty window.
-     */
-    bool isResize = (w != screen.width || h != screen.height || cdx == 0.0);
 
-    int oldh = screen.height;
-    if (isResize) {
+    if (w != screen.width || h != screen.height) {
         // Resize before we trigger the redraw, or we'll redraw at the wrong size
         COCOA_DEBUG("switchSurface: new size %d x %d\n", w, h);
         screen.width = w;
         screen.height = h;
-        [self setContentDimensions];
-        [self setFrame:NSMakeRect(cx, cy, cw, ch)];
+        [self resizeWindow];
         [self updateBounds];
     }
 
@@ -654,51 +624,6 @@ - (void) switchSurface:(pixman_image_t *)image
     }
 
     pixman_image = image;
-
-    // update windows
-    if (isFullscreen) {
-        [[fullScreenWindow contentView] setFrame:[[NSScreen mainScreen] frame]];
-        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:NO animate:NO];
-    } else {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
-        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:YES animate:NO];
-    }
-
-    if (isResize) {
-        [normalWindow center];
-    }
-}
-
-- (void) toggleFullScreen:(id)sender
-{
-    COCOA_DEBUG("QemuCocoaView: toggleFullScreen\n");
-
-    if (isFullscreen) { // switch from fullscreen to desktop
-        isFullscreen = FALSE;
-        [self ungrabMouse];
-        [self setContentDimensions];
-        [fullScreenWindow close];
-        [normalWindow setContentView: self];
-        [normalWindow makeKeyAndOrderFront: self];
-        [NSMenu setMenuBarVisible:YES];
-    } else { // switch from desktop to fullscreen
-        isFullscreen = TRUE;
-        [normalWindow orderOut: nil]; /* Hide the window */
-        [self grabMouse];
-        [self setContentDimensions];
-        [NSMenu setMenuBarVisible:NO];
-        fullScreenWindow = [[NSWindow alloc] initWithContentRect:[[NSScreen mainScreen] frame]
-            styleMask:NSWindowStyleMaskBorderless
-            backing:NSBackingStoreBuffered
-            defer:NO];
-        [fullScreenWindow setAcceptsMouseMovedEvents: YES];
-        [fullScreenWindow setHasShadow:NO];
-        [fullScreenWindow setBackgroundColor: [NSColor blackColor]];
-        [self setFrame:NSMakeRect(cx, cy, cw, ch)];
-        [[fullScreenWindow contentView] addSubview: self];
-        [fullScreenWindow makeKeyAndOrderFront:self];
-    }
 }
 
 - (void) setFullGrab:(id)sender
@@ -812,8 +737,6 @@ - (bool) handleEventLocked:(NSEvent *)event
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     InputButton button;
     int keycode = 0;
-    // Location of event in virtual screen coordinates
-    NSPoint p = [self screenLocationOfEvent:event];
     NSUInteger modifiers = [event modifierFlags];
 
     /*
@@ -1007,50 +930,6 @@ - (bool) handleEventLocked:(NSEvent *)event
                 qkbd_state_key_event(kbd, keycode, false);
             }
             return true;
-        case NSEventTypeMouseMoved:
-            if (isAbsoluteEnabled) {
-                // Cursor re-entered into a window might generate events bound to screen coordinates
-                // and `nil` window property, and in full screen mode, current window might not be
-                // key window, where event location alone should suffice.
-                if (![self screenContainsPoint:p] || !([[self window] isKeyWindow] || isFullscreen)) {
-                    if (isMouseGrabbed) {
-                        [self ungrabMouse];
-                    }
-                } else {
-                    if (!isMouseGrabbed) {
-                        [self grabMouse];
-                    }
-                }
-            }
-            return [self handleMouseEvent:event];
-        case NSEventTypeLeftMouseDown:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:true];
-        case NSEventTypeRightMouseDown:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:true];
-        case NSEventTypeOtherMouseDown:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:true];
-        case NSEventTypeLeftMouseDragged:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:true];
-        case NSEventTypeRightMouseDragged:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:true];
-        case NSEventTypeOtherMouseDragged:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:true];
-        case NSEventTypeLeftMouseUp:
-            if (!isMouseGrabbed && [self screenContainsPoint:p]) {
-                /*
-                 * In fullscreen mode, the window of cocoaView may not be the
-                 * key window, therefore the position relative to the virtual
-                 * screen alone will be sufficient.
-                 */
-                if(isFullscreen || [[self window] isKeyWindow]) {
-                    [self grabMouse];
-                }
-            }
-            return [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:false];
-        case NSEventTypeRightMouseUp:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:false];
-        case NSEventTypeOtherMouseUp:
-            return [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:false];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
@@ -1083,61 +962,118 @@ - (bool) handleEventLocked:(NSEvent *)event
     }
 }
 
-- (bool) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
-{
-    /* Don't send button events to the guest unless we've got a
-     * mouse grab or window focus. If we have neither then this event
-     * is the user clicking on the background window to activate and
-     * bring us to the front, which will be done by the sendEvent
-     * call below. We definitely don't want to pass that click through
-     * to the guest.
-     */
-    if (!isMouseGrabbed && ![[self window] isKeyWindow]) {
-        return false;
-    }
-
-    qemu_input_queue_btn(dcl.con, button, down);
-
-    return [self handleMouseEvent:event];
-}
-
-- (bool) handleMouseEvent:(NSEvent *)event
+- (void) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
 {
     if (!isMouseGrabbed) {
-        return false;
+        return;
     }
 
-    if (isAbsoluteEnabled) {
-        NSPoint p = [self screenLocationOfEvent:event];
+    with_bql(^{
+        qemu_input_queue_btn(dcl.con, button, down);
+    });
 
-        /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
-         * The check on screenContainsPoint is to avoid sending out of range values for
-         * clicks in the titlebar.
-         */
-        if ([self screenContainsPoint:p]) {
-            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
-            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
+    [self handleMouseEvent:event];
+}
+
+- (void) handleMouseEvent:(NSEvent *)event
+{
+    if (!isMouseGrabbed) {
+        return;
+    }
+
+    with_bql(^{
+        if (isAbsoluteEnabled) {
+            CGFloat d = (CGFloat)screen.height / [self frame].size.height;
+            NSPoint p = [event locationInWindow];
+
+            /* Note that the origin for Cocoa mouse coords is bottom left, not top left. */
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x * d, 0, screen.width);
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y * d, 0, screen.height);
+        } else {
+            qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, [event deltaX]);
+            qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, [event deltaY]);
         }
-    } else {
-        qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
-        qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
+
+        qemu_input_event_sync();
+    });
+}
+
+- (void) mouseExited:(NSEvent *)event
+{
+    if (isAbsoluteEnabled && isMouseGrabbed) {
+        [self ungrabMouse];
+    }
+}
+
+- (void) mouseEntered:(NSEvent *)event
+{
+    if (isAbsoluteEnabled && !isMouseGrabbed) {
+        [self grabMouse];
+    }
+}
+
+- (void) mouseMoved:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) mouseDown:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:true];
+}
+
+- (void) rightMouseDown:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:true];
+}
+
+- (void) otherMouseDown:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:true];
+}
+
+- (void) mouseDragged:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) rightMouseDragged:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) otherMouseDragged:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) mouseUp:(NSEvent *)event
+{
+    if (!isMouseGrabbed) {
+        [self grabMouse];
     }
 
-    qemu_input_event_sync();
+    [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:false];
+}
 
-    return true;
+- (void) rightMouseUp:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:false];
+}
+
+- (void) otherMouseUp:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:false];
 }
 
 - (void) grabMouse
 {
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
 
-    if (!isFullscreen) {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
-        else
-            [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
-    }
+    if (qemu_name)
+        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
+    else
+        [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
     [self hideCursor];
     CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
     isMouseGrabbed = TRUE; // while isMouseGrabbed = TRUE, QemuCocoaApp sends all events to [cocoaView handleEvent:]
@@ -1147,15 +1083,14 @@ - (void) ungrabMouse
 {
     COCOA_DEBUG("QemuCocoaView: ungrabMouse\n");
 
-    if (!isFullscreen) {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
-        else
-            [normalWindow setTitle:@"QEMU"];
-    }
+    if (qemu_name)
+        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
+    else
+        [normalWindow setTitle:@"QEMU"];
     [self unhideCursor];
     CGAssociateMouseAndMouseCursorPosition(TRUE);
     isMouseGrabbed = FALSE;
+    [self raiseAllButtons];
 }
 
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
@@ -1166,8 +1101,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
 }
 - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
 - (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
-- (float) cdx {return cdx;}
-- (float) cdy {return cdy;}
 - (QEMUScreen) gscreen {return screen;}
 
 /*
@@ -1181,6 +1114,15 @@ - (void) raiseAllKeys
         qkbd_state_lift_all_keys(kbd);
     });
 }
+
+- (void) raiseAllButtons
+{
+    with_bql(^{
+        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_LEFT, false);
+        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_RIGHT, false);
+        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_MIDDLE, false);
+    });
+}
 @end
 
 
@@ -1195,7 +1137,6 @@ @interface QemuCocoaAppController : NSObject
 {
 }
 - (void)doToggleFullScreen:(id)sender;
-- (void)toggleFullScreen:(id)sender;
 - (void)showQEMUDoc:(id)sender;
 - (void)zoomToFit:(id) sender;
 - (void)displayConsole:(id)sender;
@@ -1237,7 +1178,8 @@ - (id) init
             exit(1);
         }
         [normalWindow setAcceptsMouseMovedEvents:YES];
-        [normalWindow setTitle:@"QEMU"];
+        [normalWindow setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
+        [normalWindow setTitle:qemu_name ? [NSString stringWithFormat:@"QEMU %s", qemu_name] : @"QEMU"];
         [normalWindow setContentView:cocoaView];
         [normalWindow makeKeyAndOrderFront:self];
         [normalWindow center];
@@ -1307,10 +1249,21 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
     [cocoaView updateUIInfo];
 }
 
+- (void)windowDidEnterFullScreen:(NSNotification *)notification
+{
+    [cocoaView grabMouse];
+}
+
+- (void)windowDidExitFullScreen:(NSNotification *)notification
+{
+    [cocoaView resizeWindow];
+    [cocoaView ungrabMouse];
+}
+
 - (void)windowDidResize:(NSNotification *)notification
 {
     [cocoaView updateBounds];
-    [cocoaView updateUIInfo];
+    [cocoaView frameUpdated];
 }
 
 /* Called when the user clicks on a window's close button */
@@ -1326,6 +1279,14 @@ - (BOOL)windowShouldClose:(id)sender
     return NO;
 }
 
+- (NSApplicationPresentationOptions) window:(NSWindow *)window
+                                     willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions;
+
+{
+    return (proposedOptions & ~(NSApplicationPresentationAutoHideDock | NSApplicationPresentationAutoHideMenuBar)) |
+           NSApplicationPresentationHideDock | NSApplicationPresentationHideMenuBar;
+}
+
 /*
  * Called when QEMU goes into the background. Note that
  * [-NSWindowDelegate windowDidResignKey:] is used here instead of
@@ -1345,14 +1306,7 @@ - (void) windowDidResignKey: (NSNotification *)aNotification
  */
 - (void) doToggleFullScreen:(id)sender
 {
-    [self toggleFullScreen:(id)sender];
-}
-
-- (void)toggleFullScreen:(id)sender
-{
-    COCOA_DEBUG("QemuCocoaAppController: toggleFullScreen\n");
-
-    [cocoaView toggleFullScreen:sender];
+    [normalWindow toggleFullScreen:sender];
 }
 
 - (void) setFullGrab:(id)sender
@@ -1403,6 +1357,7 @@ - (void)zoomToFit:(id) sender
     if (stretch_video == true) {
         [sender setState: NSControlStateValueOn];
     } else {
+        [cocoaView resizeWindow];
         [sender setState: NSControlStateValueOff];
     }
 }
@@ -2049,8 +2004,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     /* if fullscreen mode is to be used */
     if (opts->has_full_screen && opts->full_screen) {
-        [NSApp activateIgnoringOtherApps: YES];
-        [controller toggleFullScreen: nil];
+        [normalWindow toggleFullScreen: nil];
     }
     if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
         [controller setFullGrab: nil];
-- 
2.41.0


