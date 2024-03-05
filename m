Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83C6C54E58
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdM-0007va-V6; Tue, 05 Mar 2024 06:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdB-0007kJ-AM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:46 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSd2-0002lv-KG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:45 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so8191737a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636794; x=1710241594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcMZ2wZGvgIXnfKqMdotL5RtUlqFDTHW5fA4eDcdqEc=;
 b=CjnwW2QLx3Djf0SsoP0rzi7iAFmrQb5TNCVC5zHA3jkvm++aXjmOfki/i10wA1bvbn
 SHJmvnEirX61CQ9q7KnyxvasTSp1RvhnqkSC+NhD406daZTcB9G2HzVmSPFbQe6fErfN
 e+JF0Kb1WArODkOrS8Pfayjb6/Qh0Q2eRDzJ1WKm2E2uZRvmRDa41PY4t8YzOblUl6ND
 6l8xx89/BA7HToTey8RFqgmpJ2kIzOHwKoCSSUHIGxRzy/+D4vEcYA/mwOjN39II375n
 sxQDZ5Ike23TVbswhPwQ74ykFNo0uDgFtCxNXBsgri1V7FDww0e7GqxAWkBahkJloymV
 Mwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636794; x=1710241594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcMZ2wZGvgIXnfKqMdotL5RtUlqFDTHW5fA4eDcdqEc=;
 b=cvqFnvrILZ8fOwe0QuWc/CsqPu5dhV/2OG3qpjbogNQic+isYFfFh5QD7rNbsI9Bvq
 is4VOrtICIdy8s61kKUmI00nVGByd0pfjumtbDDiwDCcr8EnznH55ETSCyaKygM8+TCa
 Chtt/f4aayEPwCgjygGqS6hCcK3mtFFgrOVTC13csG7ITGsfQze2XcmjrqqHPzRsvpua
 j0msDKeodd6JjNNy3Yo/4Y9/Xxu6RScW/rsDqNX9W985NYHOdZSQ7d+Kci5u8GaYHs/q
 df22hWEfVL/0ZdPxM8vhhMW8e3SgdzSjImsuNAgLwCO5AJ3vEmDyfjlJYOtqieRtl7/j
 XfHw==
X-Gm-Message-State: AOJu0Yw9euMNTEyGVyEpcvTxUZLn9AZ2V+tiUV8z6W8C+3IFOqU3FIxl
 JcoGPXkTFJpnjcm3dVxCU5V10SN3NIxoFs0lAITguvyVKGoDeRjmar27anDEcAF6SZP17zrpjVw
 /
X-Google-Smtp-Source: AGHT+IExgJj8yxppa+88n0ULWmKVtXCbO9WyjJqd1fH6z0QIIYKP2FTUSoBsvuSjC6OeQqLjnGWrmg==
X-Received: by 2002:a17:906:8301:b0:a43:dae8:d43c with SMTP id
 j1-20020a170906830100b00a43dae8d43cmr7634044ejx.32.1709636794677; 
 Tue, 05 Mar 2024 03:06:34 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 ag3-20020a1709069a8300b00a44790d06d3sm4990914ejc.71.2024.03.05.03.06.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Rene Engel <ReneEngel80@emailn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 04/12] ui/cocoa: Immediately call [-QemuCocoaView
 handleMouseEvent:buttons:]
Date: Tue,  5 Mar 2024 12:05:59 +0100
Message-ID: <20240305110608.21618-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Instead of using mouse_event variable to tell to handle a mouse event
later, immediately call [-QemuCocoaView handleMouseEvent:buttons:].

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Message-ID: <20240224-cocoa-v12-2-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 87 +++++++++++++++++++-----------------------------------
 1 file changed, 30 insertions(+), 57 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index aecd60df2a..ff6486093c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -807,9 +807,8 @@ - (bool) handleEventLocked:(NSEvent *)event
 {
     /* Return true if we handled the event, false if it should be given to OSX */
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
-    int buttons = 0;
+    InputButton button;
     int keycode = 0;
-    bool mouse_event = false;
     // Location of event in virtual screen coordinates
     NSPoint p = [self screenLocationOfEvent:event];
     NSUInteger modifiers = [event modifierFlags];
@@ -955,7 +954,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                     }
                     break;
             }
-            break;
+            return true;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
@@ -991,7 +990,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             } else {
                 [self handleMonitorInput: event];
             }
-            break;
+            return true;
         case NSEventTypeKeyUp:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
@@ -1004,7 +1003,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             if (qemu_console_is_graphic(NULL)) {
                 qkbd_state_key_event(kbd, keycode, false);
             }
-            break;
+            return true;
         case NSEventTypeMouseMoved:
             if (isAbsoluteEnabled) {
                 // Cursor re-entered into a window might generate events bound to screen coordinates
@@ -1020,34 +1019,20 @@ - (bool) handleEventLocked:(NSEvent *)event
                     }
                 }
             }
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeLeftMouseDown:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_LBUTTON];
         case NSEventTypeRightMouseDown:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_RBUTTON];
         case NSEventTypeOtherMouseDown:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_MBUTTON];
         case NSEventTypeLeftMouseDragged:
-            buttons |= MOUSE_EVENT_LBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_LBUTTON];
         case NSEventTypeRightMouseDragged:
-            buttons |= MOUSE_EVENT_RBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_RBUTTON];
         case NSEventTypeOtherMouseDragged:
-            buttons |= MOUSE_EVENT_MBUTTON;
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:MOUSE_EVENT_MBUTTON];
         case NSEventTypeLeftMouseUp:
-            mouse_event = true;
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
                 /*
                  * In fullscreen mode, the window of cocoaView may not be the
@@ -1058,53 +1043,41 @@ - (bool) handleEventLocked:(NSEvent *)event
                     [self grabMouse];
                 }
             }
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeRightMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeOtherMouseUp:
-            mouse_event = true;
-            break;
+            return [self handleMouseEvent:event buttons:0];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
              * This is in-line with standard Mac OS X UI behaviour.
              */
 
-            /*
-             * We shouldn't have got a scroll event when deltaY and delta Y
-             * are zero, hence no harm in dropping the event
-             */
-            if ([event deltaY] != 0 || [event deltaX] != 0) {
             /* Determine if this is a scroll up or scroll down event */
-                if ([event deltaY] != 0) {
-                  buttons = ([event deltaY] > 0) ?
+            if ([event deltaY] != 0) {
+                button = ([event deltaY] > 0) ?
                     INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
-                } else if ([event deltaX] != 0) {
-                  buttons = ([event deltaX] > 0) ?
+            } else if ([event deltaX] != 0) {
+                button = ([event deltaX] > 0) ?
                     INPUT_BUTTON_WHEEL_LEFT : INPUT_BUTTON_WHEEL_RIGHT;
-                }
-
-                qemu_input_queue_btn(dcl.con, buttons, true);
-                qemu_input_event_sync();
-                qemu_input_queue_btn(dcl.con, buttons, false);
-                qemu_input_event_sync();
+            } else {
+                /*
+                 * We shouldn't have got a scroll event when deltaY and delta Y
+                 * are zero, hence no harm in dropping the event
+                 */
+                return true;
             }
 
-            /*
-             * Since deltaX/deltaY also report scroll wheel events we prevent mouse
-             * movement code from executing.
-             */
-            mouse_event = false;
-            break;
+            qemu_input_queue_btn(dcl.con, button, true);
+            qemu_input_event_sync();
+            qemu_input_queue_btn(dcl.con, button, false);
+            qemu_input_event_sync();
+
+            return true;
         default:
             return false;
     }
-
-    if (mouse_event) {
-        return [self handleMouseEvent:event buttons:buttons];
-    }
-    return true;
 }
 
 - (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons
-- 
2.41.0


