Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099B3C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbN6-0004Tn-1s; Tue, 18 Jun 2024 12:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbN3-0004MM-T7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:45 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbN1-00081v-UQ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:45 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52bc274f438so6003000e87.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726862; x=1719331662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1CzEgsqs5Q5WzI+sZtnD/HRhJpPC0ikB+DYXS0unQ8=;
 b=uPbRMYM0U8RZ7tnUA1myn7e9KJzt8mn36dK6SePyQ9ap87NaySfyG9r9UHbv9bDnQk
 a+g3sdOtaHCev5uxhBf0FT91QgF2QqJQwa8KZtWRhRv10DG5FG+ERd4f0G8kZdg/Z9EY
 xEoSmu0sqIfDki2pG/r+icUkQXMTUtdXR78F61DVHuyCoooAIJg2cZwncFhoUKLcfUKU
 +fI9uX4hehZINTTeVxIb3YlX3JIjhXnDIHfaD7dCRk32ZBqJfqc87Jk03QXUk5zUNK/b
 kB6sR6UGXeROQ2pn284GJgB/lOPAvIyrJqZTvq9Ezc2dwH/f8N7jRfu3OHn1a9vIvfZ0
 f9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726862; x=1719331662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1CzEgsqs5Q5WzI+sZtnD/HRhJpPC0ikB+DYXS0unQ8=;
 b=vS9MvPueT5sByr10nXNe5nPrlTPz8l/aF8QHWu1VBndtOj8VhKNAEHvYDSzar/Be5b
 gxztAg6BC79ImeRYDmbiOurOqaqDiUqSlFNwuNDVMDRPLXfIbiLgGn2Ztj4tZQUarSeB
 NuA02YFB5iZxyNBBsTGpiEa09PPg0ERqSlY9tL6At3CfPjzurVDL6y3Ai2spV4ht6yl3
 scnxQwFSeDNN1ijypUIusNJrxWFllVoq+1LJSJ+xwx8GVMie7dzltx6J2jrvl5mOaz0k
 umT/LPJlQBELMfr/z8lnhptRs75MSdfJ4143DphIFujAz8E9cAWOdPtYuVaX0A1zLgn0
 QYnA==
X-Gm-Message-State: AOJu0Yw2VHU70I/Bc3HDnkxZWUBrW+cwbN6hpnDwajgc8E+/2BqbI2n4
 rzFTAzzVFYt5yGc8SpcJeEDOG1gY/6+XdlKTeHL8HJW0Vr0y+rHiN5oSQpPzOOJsZvZTKUTgYM5
 z
X-Google-Smtp-Source: AGHT+IH1GGbEnEWEPgAzM0J6HLVaClLpbTIyMgRjED95w8TtbGrWkNHZfoPApX8OiSbbqidwunTuDg==
X-Received: by 2002:a05:6512:b0d:b0:52c:a1ad:18bd with SMTP id
 2adb3069b0e04-52ccaa59580mr58703e87.6.1718726860905; 
 Tue, 18 Jun 2024 09:07:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104a8fsm14332891f8f.110.2024.06.18.09.07.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 73/76] ui/cocoa: Use qemu_add_mouse_change_notifier
Date: Tue, 18 Jun 2024 18:00:35 +0200
Message-ID: <20240618160039.36108-74-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

This eliminates the polling in cocoa_refresh and implements the
propagation of the mouse mode change from absolute to relative.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-ID: <20240322-mouse-v1-1-0b7d4d9bdfbf@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 62 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 981615a8b9..2935247cdd 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -296,6 +296,14 @@ @interface QemuCocoaView : NSView
 {
     QEMUScreen screen;
     pixman_image_t *pixman_image;
+    /* The state surrounding mouse grabbing is potentially confusing.
+     * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
+     *   pointing device an absolute-position one?"], but is only updated on
+     *   next refresh.
+     * isMouseGrabbed tracks whether GUI events are directed to the guest;
+     *   it controls whether special keys like Cmd get sent to the guest,
+     *   and whether we capture the mouse when in non-absolute mode.
+     */
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
@@ -307,17 +315,8 @@ - (void) setFullGrab:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (bool) handleEvent:(NSEvent *)event;
 - (bool) handleEventLocked:(NSEvent *)event;
-- (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
-/* The state surrounding mouse grabbing is potentially confusing.
- * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
- *   pointing device an absolute-position one?"], but is only updated on
- *   next refresh.
- * isMouseGrabbed tracks whether GUI events are directed to the guest;
- *   it controls whether special keys like Cmd get sent to the guest,
- *   and whether we capture the mouse when in non-absolute mode.
- */
+- (void) notifyMouseModeChange;
 - (BOOL) isMouseGrabbed;
-- (BOOL) isAbsoluteEnabled;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
 @end
@@ -404,6 +403,7 @@ - (void) selectConsoleLocked:(unsigned int)index
     qkbd_state_switch_console(kbd, con);
     dcl.con = con;
     register_displaychangelistener(&dcl);
+    [self notifyMouseModeChange];
     [self updateUIInfo];
 }
 
@@ -1109,14 +1109,26 @@ - (void) ungrabMouse
     [self raiseAllButtons];
 }
 
-- (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
+- (void) notifyMouseModeChange {
+    bool tIsAbsoluteEnabled = bool_with_bql(^{
+        return qemu_input_is_absolute(dcl.con);
+    });
+
+    if (tIsAbsoluteEnabled == isAbsoluteEnabled) {
+        return;
+    }
+
     isAbsoluteEnabled = tIsAbsoluteEnabled;
+
     if (isMouseGrabbed) {
-        CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
+        if (isAbsoluteEnabled) {
+            [self ungrabMouse];
+        } else {
+            CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
+        }
     }
 }
 - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
-- (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
 - (QEMUScreen) gscreen {return screen;}
 
 /*
@@ -1791,6 +1803,17 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
+static void cocoa_mouse_mode_change_notify(Notifier *notifier, void *data)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        [cocoaView notifyMouseModeChange];
+    });
+}
+
+static Notifier mouse_mode_change_notifier = {
+    .notify = cocoa_mouse_mode_change_notify
+};
+
 @interface QemuCocoaPasteboardTypeOwner : NSObject<NSPasteboardTypeOwner>
 @end
 
@@ -1975,17 +1998,6 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
     graphic_hw_update(dcl->con);
 
-    if (qemu_input_is_absolute(dcl->con)) {
-        dispatch_async(dispatch_get_main_queue(), ^{
-            if (![cocoaView isAbsoluteEnabled]) {
-                if ([cocoaView isMouseGrabbed]) {
-                    [cocoaView ungrabMouse];
-                }
-            }
-            [cocoaView setAbsoluteEnabled:YES];
-        });
-    }
-
     if (cbchangecount != [[NSPasteboard generalPasteboard] changeCount]) {
         qemu_clipboard_info_unref(cbinfo);
         cbinfo = qemu_clipboard_info_new(&cbpeer, QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
@@ -2062,6 +2074,8 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     // register vga output callbacks
     register_displaychangelistener(&dcl);
+    qemu_add_mouse_mode_change_notifier(&mouse_mode_change_notifier);
+    [cocoaView notifyMouseModeChange];
     [cocoaView updateUIInfo];
 
     qemu_event_init(&cbevent, false);
-- 
2.41.0


