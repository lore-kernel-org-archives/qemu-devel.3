Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3B0C48BF5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIik-0007Rh-Tq; Sat, 17 Feb 2024 06:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIij-0007RE-9A
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:01 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIih-0002fP-C7
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:01 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e38fbc0ee2so49747b3a.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708168738; x=1708773538;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9aPF/raZCUaNWr2M962mTjozvtYefD2y4h/liBQ3bA8=;
 b=mYA7sJr4YQ2i+c1PIk0O4Lcf2bpy20pdCkpK9WyZD+kSj/kKk9fTtXzg+6kQUbW0kZ
 FOJbUpcTiCSCJIIGFpw+DdJbSUGr1jCExx/13E6vV+CqdhyCj6ZIOnD63+0ZV4FQpldb
 BJ1hzm1wqpfxW7mdXhuFWfsJjl7+qonxQ59WuQ+7PwkaEEVuY6n0mhejuIuKlD3K1gA7
 EGFYkFXN6B6WixLY7sRA8uiPLNaqhcs4vkCVm0l3u5G8Cjs2JX8/7r2Yq882DVOMHklK
 tIsPG7q7fVtZfVMPSNV0OCg6xd5QrRaYgFTUEpvFHVBZz424sUp1Jm+Ct6TW2pkNwuIx
 guPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708168738; x=1708773538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aPF/raZCUaNWr2M962mTjozvtYefD2y4h/liBQ3bA8=;
 b=KvKDlsImAzklzV2kuefd8ua6tufu7HQC218cr7MV9zXywuHtHjfTxZoU2I/acQpHi7
 /BY6F6nZgOwWSOyIog+eHrvCLWXaoH3Tfx3g8A1Q2KN0qRZsWdwUoz0BPfudjddRiiqM
 gqbz50O/WAdFEFyoas7Pcyqz+B37uPOrcWJmeTLtomAPfy9zpdA+muDq0AenYmByinNz
 M4VyVyq+iXM/4MOzP4xUhhE7JfOf/aGyzbYWIAZCY8FnZ6dnp/zLCk7I/d4cRLAAaF1i
 z+C8U5gVNqYUUEIvUo4EoxU90CiLWpv8SJDIxcvMWSvau5c36/UG8TJWTHBL0OWECz/+
 uE/w==
X-Gm-Message-State: AOJu0YyUvftCkLH5UcV9uUX7JDTG5rvp6ZoDMLLLOXnijdGNp7b+mEY4
 acgZ13cWP1sQcrVqxbdEQj0uYK1TVcNhrzC6vr5UisEgv8pYWzwRQKMCokBZCDM=
X-Google-Smtp-Source: AGHT+IEFlqU5rS29zUHHPSf5rmHwiwOsdo6Vev7zEOegtvk0B/VRIMm8afF7bsm6oq8wtcc1q9v8ew==
X-Received: by 2002:a05:6a20:d808:b0:19e:cf1a:5369 with SMTP id
 iv8-20020a056a20d80800b0019ecf1a5369mr10956717pzb.24.1708168737950; 
 Sat, 17 Feb 2024 03:18:57 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 h15-20020a056a00000f00b006dd843734c8sm937820pfk.81.2024.02.17.03.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:18:57 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 17 Feb 2024 20:18:47 +0900
Subject: [PATCH v11 1/6] ui/cocoa: Release specific mouse buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-cocoa-v11-1-0a17a7e534d4@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ui/cocoa used to release all mouse buttons when it sees
NSEventTypeLeftMouseUp, NSEventTypeRightMouseUp, or
NSEventTypeOtherMouseUp, but it can instead release specific one
according to the delivered event.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 132 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 55 insertions(+), 77 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index eb99064beeb4..fe0eb74b0743 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -99,7 +99,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
 };
-static int last_buttons;
 static int cursor_hide = 1;
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
@@ -801,8 +800,6 @@ - (bool) handleEventLocked:(NSEvent *)event
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     int buttons = 0;
     int keycode = 0;
-    bool mouse_event = false;
-    // Location of event in virtual screen coordinates
     NSPoint p = [self screenLocationOfEvent:event];
     NSUInteger modifiers = [event modifierFlags];
 
@@ -883,25 +880,25 @@ - (bool) handleEventLocked:(NSEvent *)event
                     if (!!(modifiers & NSEventModifierFlagShift)) {
                         [self toggleKey:Q_KEY_CODE_SHIFT];
                     }
-                    break;
+                    return true;
 
                 case kVK_RightShift:
                     if (!!(modifiers & NSEventModifierFlagShift)) {
                         [self toggleKey:Q_KEY_CODE_SHIFT_R];
                     }
-                    break;
+                    return true;
 
                 case kVK_Control:
                     if (!!(modifiers & NSEventModifierFlagControl)) {
                         [self toggleKey:Q_KEY_CODE_CTRL];
                     }
-                    break;
+                    return true;
 
                 case kVK_RightControl:
                     if (!!(modifiers & NSEventModifierFlagControl)) {
                         [self toggleKey:Q_KEY_CODE_CTRL_R];
                     }
-                    break;
+                    return true;
 
                 case kVK_Option:
                     if (!!(modifiers & NSEventModifierFlagOption)) {
@@ -911,7 +908,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_ALT];
                         }
                     }
-                    break;
+                    return true;
 
                 case kVK_RightOption:
                     if (!!(modifiers & NSEventModifierFlagOption)) {
@@ -921,7 +918,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_ALT_R];
                         }
                     }
-                    break;
+                    return true;
 
                 /* Don't pass command key changes to guest unless mouse is grabbed */
                 case kVK_Command:
@@ -934,7 +931,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_META_L];
                         }
                     }
-                    break;
+                    return true;
 
                 case kVK_RightCommand:
                     if (isMouseGrabbed &&
@@ -945,9 +942,11 @@ - (bool) handleEventLocked:(NSEvent *)event
                             [self toggleKey:Q_KEY_CODE_META_R];
                         }
                     }
-                    break;
+                    return true;
+
+                default:
+                    return true;
             }
-            break;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
@@ -983,7 +982,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             } else {
                 [self handleMonitorInput: event];
             }
-            break;
+            return true;
         case NSEventTypeKeyUp:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
@@ -996,7 +995,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             if (qemu_console_is_graphic(NULL)) {
                 qkbd_state_key_event(kbd, keycode, false);
             }
-            break;
+            return true;
         case NSEventTypeMouseMoved:
             if (isAbsoluteEnabled) {
                 // Cursor re-entered into a window might generate events bound to screen coordinates
@@ -1012,34 +1011,18 @@ - (bool) handleEventLocked:(NSEvent *)event
                     }
                 }
             }
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event];
         case NSEventTypeLeftMouseDown:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
         case NSEventTypeRightMouseDown:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
-        case NSEventTypeOtherMouseDown:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
         case NSEventTypeLeftMouseDragged:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
         case NSEventTypeRightMouseDragged:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
         case NSEventTypeOtherMouseDragged:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:true];
         case NSEventTypeLeftMouseUp:
-            mouse_event = true;
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
                 /*
                  * In fullscreen mode, the window of cocoaView may not be the
@@ -1050,13 +1033,11 @@ - (bool) handleEventLocked:(NSEvent *)event
                     [self grabMouse];
                 }
             }
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:false];
         case NSEventTypeRightMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:false];
         case NSEventTypeOtherMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:false];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
@@ -1087,52 +1068,49 @@ - (bool) handleEventLocked:(NSEvent *)event
              * Since deltaX/deltaY also report scroll wheel events we prevent mouse
              * movement code from executing.
              */
-            mouse_event = false;
-            break;
+            return true;
         default:
             return false;
     }
+}
+
+- (bool) handleMouseEvent:(NSEvent *)event
+{
+    if (!isMouseGrabbed) {
+        return false;
+    }
 
-    if (mouse_event) {
-        /* Don't send button events to the guest unless we've got a
-         * mouse grab or window focus. If we have neither then this event
-         * is the user clicking on the background window to activate and
-         * bring us to the front, which will be done by the sendEvent
-         * call below. We definitely don't want to pass that click through
-         * to the guest.
+    if (isAbsoluteEnabled) {
+        NSPoint p = [self screenLocationOfEvent:event];
+        /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
+         * The check on screenContainsPoint is to avoid sending out of range values for
+         * clicks in the titlebar.
          */
-        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
-            (last_buttons != buttons)) {
-            static uint32_t bmap[INPUT_BUTTON__MAX] = {
-                [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
-                [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
-                [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
-            };
-            qemu_input_update_buttons(dcl.con, bmap, last_buttons, buttons);
-            last_buttons = buttons;
-        }
-        if (isMouseGrabbed) {
-            if (isAbsoluteEnabled) {
-                /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
-                 * The check on screenContainsPoint is to avoid sending out of range values for
-                 * clicks in the titlebar.
-                 */
-                if ([self screenContainsPoint:p]) {
-                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
-                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
-                }
-            } else {
-                qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
-                qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
-            }
-        } else {
-            return false;
+        if ([self screenContainsPoint:p]) {
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
         }
-        qemu_input_event_sync();
+    } else {
+        qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
+        qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
     }
+
+    qemu_input_event_sync();
+
     return true;
 }
 
+- (bool) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
+{
+    if (!isMouseGrabbed && ![[self window] isKeyWindow]) {
+        return false;
+    }
+
+    qemu_input_queue_btn(dcl.con, button, down);
+
+    return [self handleMouseEvent:event];
+}
+
 - (void) grabMouse
 {
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");

-- 
2.43.1


