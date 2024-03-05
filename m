Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B256C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdU-0008LZ-Fd; Tue, 05 Mar 2024 06:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdB-0007kI-A7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:45 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSd8-0002mq-6L
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:45 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso8319046a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636800; x=1710241600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeVy2+vY4lJTRcgog7P6iRUA3ib0rnR15yoPCfgtNoI=;
 b=WopqH3afYcbBjCiLq71Wf/tQ/cNW5PR4plpJCSK9x0aF4/2xHLVqS3WVzEF8xs32j6
 aaSrmqG1VBHzr8CKODbcx1oKwwXqwy78cEy3HuuD61ZTNMdmHnHtTlWTrgaXLkfEBRSq
 l+4BQSxw8BG2iyBPJlYUbzxPb4h7Aj+rIXhHjTmEvCox9rfbLUlsOh6aNRgM1i/G6iQU
 0KpxHB2k1FSDd2+Z0yydto9cUokNd0p5zWFVqruE+saqak/IBieLOYl68seWaHiM/QGD
 oNnGC15WdogtHmEQCMeyd/TbRjXCgIaI2ZtXlWCffuYtrjqRiNNiV8JlQ73xC56DDEtm
 ndOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636800; x=1710241600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeVy2+vY4lJTRcgog7P6iRUA3ib0rnR15yoPCfgtNoI=;
 b=W2fOuLrsplfOvx4NtJQvCl1SeUvj4HUFRrM/sTc4mtoDw7nzuV4ZXFxp+V0OV2L6Q6
 NirkWXjDJF0vKKyzEHFTmZkyELyEFpWlLmjlYCY17ZoT2bKAtLo0rzG/Kn8MOh1oquKT
 n6iRIbYaWnTpSFYJGvaVPpylLugHVVcCB+tg1EKOoJOxTtljKAUnnXniy8VLBI781JAH
 HF4S1uG8e0K4wsu6nTy9CJNtW1rYGNXpbD3oaCqaMhG9srpBf4X4Dok3PPhbpxxj6/YM
 3qoju8uCFM735UqWD/juPkjJHj2Nywdzto5hJADhQk2ncIblcrZj6sPJGrJ8Onx5mbEa
 juJA==
X-Gm-Message-State: AOJu0YztqKtp0FTLF7GKc9vzlU+d4txz5fprWXUJimPznnH5ijyKcGQv
 sLvRM9Qkkc4yQhze5X5DhgIzYpegWXi2d/Tri5qtPJew6yp7R41oUxMp35HGS302qu/tVFlrsPV
 C
X-Google-Smtp-Source: AGHT+IE65o+CNs29COjLnjxOQ2jdp+Ea75ZtojotESRO6ib3nKLC0eb2uFl0+bONdGtr71gfyWSOJw==
X-Received: by 2002:aa7:c742:0:b0:567:19df:28f with SMTP id
 c2-20020aa7c742000000b0056719df028fmr5204895eds.18.1709636800596; 
 Tue, 05 Mar 2024 03:06:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 bo19-20020a0564020b3300b005653f390f77sm5653437edb.10.2024.03.05.03.06.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/12] ui/cocoa: Release specific mouse buttons
Date: Tue,  5 Mar 2024 12:06:00 +0100
Message-ID: <20240305110608.21618-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

ui/cocoa used to release all mouse buttons when it sees
NSEventTypeLeftMouseUp, NSEventTypeRightMouseUp, or
NSEventTypeOtherMouseUp, but it can instead release specific one
according to the delivered event.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-3-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index ff6486093c..e156527082 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -103,7 +103,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
 };
-static int last_buttons;
 static int cursor_hide = 1;
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
@@ -1019,19 +1018,19 @@ - (bool) handleEventLocked:(NSEvent *)event
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
@@ -1043,11 +1042,11 @@ - (bool) handleEventLocked:(NSEvent *)event
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
@@ -1080,7 +1079,7 @@ - (bool) handleEventLocked:(NSEvent *)event
     }
 }
 
-- (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons
+- (bool) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
 {
     /* Don't send button events to the guest unless we've got a
      * mouse grab or window focus. If we have neither then this event
@@ -1089,17 +1088,12 @@ - (bool) handleMouseEvent:(NSEvent *)event buttons:(uint32_t)buttons
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
2.41.0


