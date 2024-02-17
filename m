Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EA9C54764
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIit-0007Su-Mh; Sat, 17 Feb 2024 06:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIis-0007Sl-By
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:10 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIip-0002g4-LQ
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:10 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e11a779334so1810877b3a.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708168746; x=1708773546;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AMmJ7PeJfRPtYjwIp0Qs5NxA0dzRU5BTR7yYaBxY2Zo=;
 b=IXB1DD4+ZguaPF16IfNIBZsUUvSUi5bQhGr8LYX+tat2dwWAzZrU7fSLO2/vEkJgml
 7rlvM4Rntw8iDtNZ6IzU8hkN4FFMwfSOEJu3cN0sbLx4FM6VDtPQPXebER5QXO221tym
 i9LAJcxa496HqApda8E/rfjyPt/UYH3XgSNb+W5f7+P0lCwLMaLgJJ2mxooNtg4c750u
 307h2/2MacpB+JaHquthBTl1PW56b+QDd5INgXOrTnjKux7WMWh3cICf0iIG6mbWuQIM
 E4mrDb68FiLuWT852NGE8MLUjlcfNGEXelOd0J32JrpfbB5h76I6+XBgOxYgEvhyqjNE
 Xlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708168746; x=1708773546;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMmJ7PeJfRPtYjwIp0Qs5NxA0dzRU5BTR7yYaBxY2Zo=;
 b=T9rTWj+7MkJp6AhPLM7iKRtkJU6dVob1HBoG0KiWMDXUYieKQ8h8owglwVNEDCJNqv
 BEy+pb4wRjFKpnPtvx8FtUuka3o8mGczc9T/JyHMi6h6rbwR1Rn1icO83BG+2MuWLnYX
 M75Golih0ixP1Avbrml5EU+v6YAEq3HWCZ4JCh5D9ZQdqW/M1gdx6mx340FGlub8v6Vx
 EUe68Qt1KrKiik0orVYQN7T/vRUqeLRPnea9jkkHQcSehqP1sx0jFOJXBOlXJcmLOg/j
 AaS8RmNWxJ8kTQcLk90N/3w9fSuP78wIpYEv1MT2nfEaklof1jEduKc9W4nnYXkUXb1F
 OBEw==
X-Gm-Message-State: AOJu0YzNpxQeyX9lzmFLzrsmAqs/fXI3/PDh8d45k2TZKHO6TFjNcVBe
 igneomuyKBYSwOekCykF1uLniPPPqY0VKScOWOPBUDRapN3maC+CST8OmXIPhl4=
X-Google-Smtp-Source: AGHT+IH1pSIMBR67MJGbZOnwVycT5r67qzo8rBU5jjjKgD2eknCir8gyX11icmkCcTE8p3WuvmxCpA==
X-Received: by 2002:a05:6a00:1898:b0:6e0:3d93:1bea with SMTP id
 x24-20020a056a00189800b006e03d931beamr12569530pfh.0.1708168746188; 
 Sat, 17 Feb 2024 03:19:06 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 g14-20020aa7874e000000b006dddd5cc47csm1428794pfo.157.2024.02.17.03.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:19:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 17 Feb 2024 20:18:49 +0900
Subject: [PATCH v11 3/6] ui/cocoa: Let the platform toggle fullscreen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-cocoa-v11-3-0a17a7e534d4@daynix.com>
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It allows making the window full screen by clicking full screen button
provided by the platform (the left-top green button) and save some code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 423 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 207 insertions(+), 216 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index b26669160300..0ebe0f326373 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -303,20 +303,17 @@ static void handleAnyDeviceErrors(Error * err)
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
@@ -332,8 +329,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
  */
 - (BOOL) isMouseGrabbed;
 - (BOOL) isAbsoluteEnabled;
-- (float) cdx;
-- (float) cdy;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
 @end
@@ -391,46 +386,43 @@ - (BOOL) isOpaque
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
@@ -510,36 +502,43 @@ - (void) drawRect:(NSRect) rect
     }
 }
 
-- (void) setContentDimensions
+- (NSSize) fixZoomedFullScreenSize:(NSSize)proposedSize
 {
-    COCOA_DEBUG("QemuCocoaView: setContentDimensions\n");
+    NSSize size;
 
-    if (isFullscreen) {
-        cdx = [[NSScreen mainScreen] frame].size.width / (float)screen.width;
-        cdy = [[NSScreen mainScreen] frame].size.height / (float)screen.height;
+    size.width = (CGFloat)screen.width * proposedSize.height;
+    size.height = (CGFloat)screen.height * proposedSize.width;
 
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
+    if (size.width < size.height) {
+        size.width /= screen.height;
+        size.height = proposedSize.height;
     } else {
-        cx = 0;
-        cy = 0;
-        cw = screen.width;
-        ch = screen.height;
-        cdx = 1.0;
-        cdy = 1.0;
+        size.width = proposedSize.width;
+        size.height /= screen.width;
+    }
+
+    return size;
+}
+
+- (NSSize) screenSafeAreaSize
+{
+    NSSize size = [[[self window] screen] frame].size;
+    NSEdgeInsets insets = [[[self window] screen] safeAreaInsets];
+    size.width -= insets.left + insets.right;
+    size.height -= insets.top + insets.bottom;
+    return size;
+}
+
+- (void) resizeWindow
+{
+    [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
+
+    if (!stretch_video) {
+        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
+        [[self window] center];
+    } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
+        [[self window] setContentSize:[self fixZoomedFullScreenSize:[self screenSafeAreaSize]]];
+        [[self window] center];
     }
 }
 
@@ -563,9 +562,10 @@ - (void) updateUIInfoLocked
         CGDirectDisplayID display = [[description objectForKey:@"NSScreenNumber"] unsignedIntValue];
         NSSize screenSize = [[[self window] screen] frame].size;
         CGSize screenPhysicalSize = CGDisplayScreenSize(display);
+        bool isFullscreen = ([[self window] styleMask] & NSWindowStyleMaskFullScreen) != 0;
         CVDisplayLinkRef displayLink;
 
-        frameSize = isFullscreen ? screenSize : [self frame].size;
+        frameSize = isFullscreen ? [self screenSafeAreaSize] : [self frame].size;
 
         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
             CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
@@ -612,31 +612,19 @@ - (void) updateUIInfo
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
 
@@ -646,51 +634,6 @@ - (void) switchSurface:(pixman_image_t *)image
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
@@ -804,7 +747,6 @@ - (bool) handleEventLocked:(NSEvent *)event
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     int buttons = 0;
     int keycode = 0;
-    NSPoint p = [self screenLocationOfEvent:event];
     NSUInteger modifiers = [event modifierFlags];
 
     /*
@@ -1000,48 +942,6 @@ - (bool) handleEventLocked:(NSEvent *)event
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
-            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
-        case NSEventTypeRightMouseDown:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
-        case NSEventTypeLeftMouseDragged:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
-        case NSEventTypeRightMouseDragged:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
-        case NSEventTypeOtherMouseDragged:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:true];
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
-            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:false];
-        case NSEventTypeRightMouseUp:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:false];
-        case NSEventTypeOtherMouseUp:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:false];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
@@ -1078,53 +978,117 @@ - (bool) handleEventLocked:(NSEvent *)event
     }
 }
 
-- (bool) handleMouseEvent:(NSEvent *)event
+- (void) handleMouseEvent:(NSEvent *)event
 {
     if (!isMouseGrabbed) {
-        return false;
+        return;
     }
 
-    if (isAbsoluteEnabled) {
-        NSPoint p = [self screenLocationOfEvent:event];
-        /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
-         * The check on screenContainsPoint is to avoid sending out of range values for
-         * clicks in the titlebar.
-         */
-        if ([self screenContainsPoint:p]) {
-            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
-            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
+    with_bql(^{
+        if (isAbsoluteEnabled) {
+            CGFloat d = (CGFloat)screen.height / [self frame].size.height;
+            NSPoint p = [event locationInWindow];
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
+- (void) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
+{
+    if (!isMouseGrabbed) {
+        return;
     }
 
-    qemu_input_event_sync();
+    with_bql(^{
+        qemu_input_queue_btn(dcl.con, button, down);
+    });
 
-    return true;
+    [self handleMouseEvent:event];
 }
 
-- (bool) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
+- (void) mouseExited:(NSEvent *)event
 {
-    if (!isMouseGrabbed && ![[self window] isKeyWindow]) {
-        return false;
+    if (isAbsoluteEnabled && isMouseGrabbed) {
+        [self ungrabMouse];
     }
+}
 
-    qemu_input_queue_btn(dcl.con, button, down);
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
+    }
+
+    [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:false];
+}
+
+- (void) rightMouseUp:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:false];
+}
 
-    return [self handleMouseEvent:event];
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
@@ -1134,15 +1098,14 @@ - (void) ungrabMouse
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
@@ -1153,8 +1116,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
 }
 - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
 - (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
-- (float) cdx {return cdx;}
-- (float) cdy {return cdy;}
 - (QEMUScreen) gscreen {return screen;}
 
 /*
@@ -1168,6 +1129,15 @@ - (void) raiseAllKeys
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
 
 
@@ -1182,7 +1152,6 @@ @interface QemuCocoaAppController : NSObject
 {
 }
 - (void)doToggleFullScreen:(id)sender;
-- (void)toggleFullScreen:(id)sender;
 - (void)showQEMUDoc:(id)sender;
 - (void)zoomToFit:(id) sender;
 - (void)displayConsole:(id)sender;
@@ -1224,7 +1193,8 @@ - (id) init
             exit(1);
         }
         [normalWindow setAcceptsMouseMovedEvents:YES];
-        [normalWindow setTitle:@"QEMU"];
+        [normalWindow setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
+        [normalWindow setTitle:qemu_name ? [NSString stringWithFormat:@"QEMU %s", qemu_name] : @"QEMU"];
         [normalWindow setContentView:cocoaView];
         [normalWindow makeKeyAndOrderFront:self];
         [normalWindow center];
@@ -1294,10 +1264,21 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
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
@@ -1313,6 +1294,23 @@ - (BOOL)windowShouldClose:(id)sender
     return NO;
 }
 
+- (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
+{
+    if (stretch_video) {
+        return [cocoaView fixZoomedFullScreenSize:proposedSize];
+    }
+
+    return NSMakeSize([cocoaView gscreen].width, [cocoaView gscreen].height);
+}
+
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
@@ -1332,14 +1330,7 @@ - (void) windowDidResignKey: (NSNotification *)aNotification
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
@@ -1390,6 +1381,7 @@ - (void)zoomToFit:(id) sender
     if (stretch_video == true) {
         [sender setState: NSControlStateValueOn];
     } else {
+        [cocoaView resizeWindow];
         [sender setState: NSControlStateValueOff];
     }
 }
@@ -2022,8 +2014,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     /* if fullscreen mode is to be used */
     if (opts->has_full_screen && opts->full_screen) {
-        [NSApp activateIgnoringOtherApps: YES];
-        [controller toggleFullScreen: nil];
+        [normalWindow toggleFullScreen: nil];
     }
     if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
         [controller setFullGrab: nil];

-- 
2.43.1


