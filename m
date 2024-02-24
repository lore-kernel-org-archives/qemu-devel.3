Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1483C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrNh-00025M-1o; Sat, 24 Feb 2024 07:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNf-000256-Vi
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:51 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNe-0006p9-C1
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:51 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso1142266a12.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778628; x=1709383428;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YNMnx4rRlrCUWfLy2rfWV5EZBoiMlt/rt6jmjb8kkJk=;
 b=e9+ndoXjxhmmnU3HuISC8/FREqvNBAe2L2RFcN/es8/pXVxWTHkgrBK/nYyCzIp8uq
 vIfHiu44xHRYHInQev39hdjiar0Dux2kPuz3KKXxG6BcyT4M12QGl3SQLgSu2+MSPpeX
 esLjGE0sd6SlIAK6DzxmlMMpuQXAZy/G7j+52TUBhFikBMYFapaiZfBQcLsyi7TztiEm
 XCOId59zstUZhm5BXF56bukd+sO+TkVhx6+vmcjJYgNNIycITNUn+6gFKeuLLYRWb1vG
 sIUTP7107QiExRaGpbr55c7DKrwW6bbxVAHiQuhY1yIqsqSA7Rm9f1+NHzzmVDOlbjTV
 RINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778628; x=1709383428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNMnx4rRlrCUWfLy2rfWV5EZBoiMlt/rt6jmjb8kkJk=;
 b=CRbtADjub4fcCrBymzLMPvhvl4KOEuYpgcZgTG4w9Pxn+6YGbNwpuTfKpswahZSzu7
 Vj9ybRIkbfWC1cFKyRR9yv00mxAvxx2BiJjpOa05O4uZtIoOzQpOdkkRYyuZaCmkFDov
 bIlNI6GmqVe+Ce6GCucMq5JdESyXx9f+MJd+fWkEGiTPhScD3sz4MZ0T//XErqcBmccm
 VfN6Qild3bmiRYIvnUa9T2P9sKO7ZvFfToGb4Wq5zrT1ZnOfe4Goqox4N8fjFjYYb0Ja
 O9OZ96LDscUMLcte4V9qTAr8BDJ89rr/kE/f0iDHyeX3ouH979QN3FTBlSRb3vwW/hw9
 yBcQ==
X-Gm-Message-State: AOJu0YwtfltTsMkb1xOAd7wZNgLtgTJJedLeOYMPxrecvHll6LWFqaOA
 Dqv3rqxfvvKi1RKQzUVfG7BXFhwLfH6tDTs+UoeiaUTwHJYxwMPq6TbxIapFHNw=
X-Google-Smtp-Source: AGHT+IHhV3BHS2nx2ED1B4PgCgtJojj4qGc3VsyOY37RmH5kbcBMscZ+HgcOfQC2ndgQT+eUOl0Sxw==
X-Received: by 2002:a17:902:9a43:b0:1dc:66ac:c34b with SMTP id
 x3-20020a1709029a4300b001dc66acc34bmr2453646plv.68.1708778628690; 
 Sat, 24 Feb 2024 04:43:48 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 b10-20020a170902ed0a00b001d91d515dffsm960016pld.156.2024.02.24.04.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:43:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:34 +0900
Subject: [PATCH v12 03/10] ui/cocoa: Release specific mouse buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-3-e89f70bdda71@daynix.com>
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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
 ui/cocoa.m | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 06bd5737636b..c73ef8884454 100644
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
@@ -1011,19 +1010,19 @@ - (bool) handleEventLocked:(NSEvent *)event
                     }
                 }
             }
-            return [self handleMouseEvent:event buttons:0];
+            return [self handleMouseEvent:event];
         case NSEventTypeLeftMouseDown:
-            return [self handleMouseEvent:event buttons:MOUSE_EVENT_LBUTTON];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:true];
         case NSEventTypeRightMouseDown:
-            return [self handleMouseEvent:event buttons:MOUSE_EVENT_RBUTTON];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:true];
         case NSEventTypeOtherMouseDown:
-            return [self handleMouseEvent:event buttons:MOUSE_EVENT_MBUTTON];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:true];
         case NSEventTypeLeftMouseDragged:
-            return [self handleMouseEvent:event buttons:MOUSE_EVENT_LBUTTON];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:true];
         case NSEventTypeRightMouseDragged:
-            return [self handleMouseEvent:event buttons:MOUSE_EVENT_RBUTTON];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:true];
         case NSEventTypeOtherMouseDragged:
-            return [self handleMouseEvent:event buttons:MOUSE_EVENT_MBUTTON];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:true];
         case NSEventTypeLeftMouseUp:
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
                 /*
@@ -1035,11 +1034,11 @@ - (bool) handleEventLocked:(NSEvent *)event
                     [self grabMouse];
                 }
             }
-            return [self handleMouseEvent:event buttons:0];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:false];
         case NSEventTypeRightMouseUp:
-            return [self handleMouseEvent:event buttons:0];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:false];
         case NSEventTypeOtherMouseUp:
-            return [self handleMouseEvent:event buttons:0];
+            return [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:false];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
@@ -1072,7 +1071,7 @@ - (bool) handleEventLocked:(NSEvent *)event
     }
 }
 
-- (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons
+- (bool) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
 {
     /* Don't send button events to the guest unless we've got a
      * mouse grab or window focus. If we have neither then this event
@@ -1081,17 +1080,12 @@ - (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons
      * call below. We definitely don't want to pass that click through
      * to the guest.
      */
-    if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
-        (last_buttons != buttons)) {
-        static uint32_t bmap[INPUT_BUTTON__MAX] = {
-            [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
-            [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
-            [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
-        };
-        qemu_input_update_buttons(dcl.con, bmap, last_buttons, buttons);
-        last_buttons = buttons;
+    if (!isMouseGrabbed && ![[self window] isKeyWindow]) {
+        return false;
     }
 
+    qemu_input_queue_btn(dcl.con, button, down);
+
     return [self handleMouseEvent:event];
 }
 

-- 
2.43.2


