Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE53C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7tB-0006IO-IX; Mon, 18 Mar 2024 03:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sf-00066S-0i
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:02 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sd-0000ml-Ac
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:00 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c38855957cso603616b6e.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748677; x=1711353477;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uHUi8VqTqgVwPhjWq614prpGtXiT8mHXsyIaQigbWrM=;
 b=ZgePFq21zbEmeCN3PGzoUsZOehgFOjeWXEQGQpjWBjT2kkgT2CeR9gHUr+ULASATsT
 TGjjtoJfm6OBCy1vE/65rAhqG/NCFyle6ahFbG9lO3uxdzC5zJDmyRacrjK01D03T6Ht
 a7B58U0ferwnTq5zyAFv/puazD61trTSMImhVSMlkv/udc40yQScMb/N0BKXm3o3t99R
 iDXVzK2pjd8oHKnWwyiu/7+owSfWS8cIPz6i7sJbtR02xVo/y8Vz+BAAO5Tndmw2ANE9
 tSsuDMOA33HtsL/xEjXcQajq8Z7SrCxUjlUOF4mYY0pK9V5qJGqa9F7S90/SDnlkGVV+
 fK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748677; x=1711353477;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHUi8VqTqgVwPhjWq614prpGtXiT8mHXsyIaQigbWrM=;
 b=KW6GoqsyofEKSuiRx/AcM1D3PKXk0Lksg0sd2RpkJ4ha5zzqnnl8BUL4ODt+Ah60Fm
 8bglbi3TtmbSe/DpobvINy1QoFxiQWtNKKRevgERdiJoRtiHQN2oj3Oz4Zk+EdEBkWFU
 1HPV87nD7zqy0/effkWWPdE64ONXYMt50yK88MQzqxttvbsdHmfuJrZrrghGJJxOS0ul
 J8JQsNVOzZimat3wObAykUtJBla1Mtwx3kQGD8hKCqmWJqAbWzOcxbxPUMlxewnHN4IN
 Ejzh7goFQm1lVpJKR9e96CxtPYCf9tlWU0yNRzhPOpb59rDQNfGSdifUz2cPt9kWacEc
 bQew==
X-Gm-Message-State: AOJu0YwjKclL7NEmCI8Y0oTDAZvlZ8jtO6HVE3s2jTxRSsyR+KYVoqGn
 BUQOf5Jo71YbiAou5RloHuJ8356Iu6t+CbQpSI1519O8FhdteS6sQtvk7HAmPNc=
X-Google-Smtp-Source: AGHT+IHv6VkosOe3kWs3HfNVldDGy6WkoHSWeeGJa9eSDqER0gBAqg2ws1JJCJRQIF05TspdaRC97A==
X-Received: by 2002:a05:6808:f93:b0:3c3:84cc:fd6c with SMTP id
 o19-20020a0568080f9300b003c384ccfd6cmr4040380oiw.3.1710748677009; 
 Mon, 18 Mar 2024 00:57:57 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 gx20-20020a056a001e1400b006e6bcbccda9sm7300248pfb.59.2024.03.18.00.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:57:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:57:44 +0900
Subject: [PATCH 3/4] ui/cocoa: Do not use console_select()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-console-v1-3-f4efbfa71253@daynix.com>
References: <20240318-console-v1-0-f4efbfa71253@daynix.com>
In-Reply-To: <20240318-console-v1-0-f4efbfa71253@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22f.google.com
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

ui/cocoa needs to update the UI info and reset the keyboard state
tracker when switching the console, or the new console will see the
stale UI info or keyboard state. Previously, updating the UI info was
done with cocoa_switch(), but it is meant to be called when the surface
is being replaced, and may be called even when not switching the
console. ui/cocoa never reset the keyboard state, which resulted in
stuck keys.

Add ui/cocoa's own implementation of console_select(), which updates the
UI info and resets the keyboard state tracker.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fa879d7dcd4b..47280c0a93be 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -102,6 +102,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
 };
+static QKbdState *kbd;
 static int cursor_hide = 1;
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
@@ -309,7 +310,6 @@ @interface QemuCocoaView : NSView
     NSTrackingArea *trackingArea;
     QEMUScreen screen;
     pixman_image_t *pixman_image;
-    QKbdState *kbd;
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
@@ -361,7 +361,6 @@ - (id)initWithFrame:(NSRect)frameRect
 
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
-        kbd = qkbd_state_init(dcl.con);
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
@@ -378,8 +377,6 @@ - (void) dealloc
         pixman_image_unref(pixman_image);
     }
 
-    qkbd_state_free(kbd);
-
     if (eventsTap) {
         CFRelease(eventsTap);
     }
@@ -429,6 +426,20 @@ - (void) viewWillMoveToWindow:(NSWindow *)newWindow
     [self removeTrackingRect];
 }
 
+- (void) selectConsoleLocked:(unsigned int)index
+{
+    QemuConsole *con = qemu_console_lookup_by_index(index);
+    if (!con) {
+        return;
+    }
+
+    unregister_displaychangelistener(&dcl);
+    qkbd_state_switch_console(kbd, con);
+    dcl.con = con;
+    register_displaychangelistener(&dcl);
+    [self updateUIInfo];
+}
+
 - (void) hideCursor
 {
     if (!cursor_hide) {
@@ -718,7 +729,8 @@ - (void) handleMonitorInput:(NSEvent *)event
     }
 
     if (keysym) {
-        qemu_text_console_put_keysym(NULL, keysym);
+        QemuTextConsole *con = QEMU_TEXT_CONSOLE(dcl.con);
+        qemu_text_console_put_keysym(con, keysym);
     }
 }
 
@@ -898,7 +910,7 @@ - (bool) handleEventLocked:(NSEvent *)event
 
                         // enable graphic console
                         case '1' ... '9':
-                            console_select(key - '0' - 1); /* ascii math */
+                            [self selectConsoleLocked:key - '0' - 1]; /* ascii math */
                             return true;
 
                         // release the mouse grab
@@ -909,7 +921,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                 }
             }
 
-            if (qemu_console_is_graphic(NULL)) {
+            if (qemu_console_is_graphic(dcl.con)) {
                 qkbd_state_key_event(kbd, keycode, true);
             } else {
                 [self handleMonitorInput: event];
@@ -924,7 +936,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                 return true;
             }
 
-            if (qemu_console_is_graphic(NULL)) {
+            if (qemu_console_is_graphic(dcl.con)) {
                 qkbd_state_key_event(kbd, keycode, false);
             }
             return true;
@@ -1374,7 +1386,7 @@ - (void)toggleZoomInterpolation:(id) sender
 - (void)displayConsole:(id)sender
 {
     with_bql(^{
-        console_select([sender tag]);
+        [cocoaView selectConsoleLocked:[sender tag]];
     });
 }
 
@@ -1945,7 +1957,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
     pixman_image_ref(image);
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        [cocoaView updateUIInfo];
         [cocoaView switchSurface:image];
     });
 }
@@ -1955,7 +1966,7 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
-    graphic_hw_update(NULL);
+    graphic_hw_update(dcl->con);
 
     if (qemu_input_is_absolute(dcl->con)) {
         dispatch_async(dispatch_get_main_queue(), ^{
@@ -2039,8 +2050,12 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     add_console_menu_entries();
     addRemovableDevicesMenuItems();
 
+    dcl.con = qemu_console_lookup_first_graphic_console();
+    kbd = qkbd_state_init(dcl.con);
+
     // register vga output callbacks
     register_displaychangelistener(&dcl);
+    [cocoaView updateUIInfo];
 
     qemu_event_init(&cbevent, false);
     cbowner = [[QemuCocoaPasteboardTypeOwner alloc] init];

-- 
2.44.0


