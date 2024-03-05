Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4CAC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSde-0000GW-1V; Tue, 05 Mar 2024 06:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdb-00007J-7W
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:11 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdZ-0002rB-85
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:10 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51341a5aafbso2539902e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636825; x=1710241625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6bEtJuwfbnOuuvRh3OE+y+ZReFgvS5n0cBCvwV1aiQ=;
 b=Ez8TNzMn9+LJ8pBSXIsfZQKMvqyLKbD9jWduzNxc2IKvY+5m013LTnJchbGQvpex7E
 EUDBev3y71CZIDS7KvS8MpDWIzsm1opvWPfCT9EX2NAqoK2grCiuCknoc7kjuknnBbyY
 t3idbmJ9kyyFMAUpMxUAHnVbTWedoRsguflnG3kglcp/nlubPB41CgSU4roJ3OyepKGN
 X6odDpjMYBEYoW7xyhTADBbdxuRtzmV/g+Pjl4VYvR0xQJnDwXT4r2J3E0mJShB6Yqz8
 vIb8hYcNlKWSOG++ds2K7l/6+c4Any59BJ3+aXTmMSyWL1mCkVzGBYWKBAGS/ryeUCTR
 V+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636825; x=1710241625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6bEtJuwfbnOuuvRh3OE+y+ZReFgvS5n0cBCvwV1aiQ=;
 b=OCvok0wwUKgxpQHrPkts/BUfEUBXQ8SkMfMEZk7bgyHtWLRUZNJLphByHNlc4QkPNU
 zI0izWem7z2TZKp7a7YTUvGb8pL0TajX8CeWv5KDGzN/wfYHEwG1C2WR2vLa/VRaB1zp
 rfg1ITa34B+8fUyHQaUlazhxrFVSkVzTYJDAX/4wEIPhuPAb4vUQ/rTPqp8ZqazYSosd
 hNrTg9pD0xteSER8uH/GB5k8cUC4FQahCC3fYtJ/Cg4/nx28S+9DqjLM2a212mJ/b5Wv
 65Bv/n89Q+m2nnvDuBHuesk3RZg297CfsMbN1EnXupZaXJaCJwaexwBLmKsXYMoj6TLz
 uqIw==
X-Gm-Message-State: AOJu0YzUVk7lQLoLfvKgxJj2A1jQWZ3HvKrAqNYqqcq/MljOr6cCVx64
 er0fEQFJnQNfGBEozcIOt4phKpKnJeQEy7L9UPDzRPorBjoryZWbdO/bLjuB5bZ7iyXSJQtBCMI
 2
X-Google-Smtp-Source: AGHT+IHz/bsnGTA4cDxDfWscFabMYQqcmP7H+y2Lwyt5TM34xuStlJDOzAa8glbtkIq2a704e7ut7A==
X-Received: by 2002:a05:6512:551:b0:511:6a0b:1035 with SMTP id
 h17-20020a056512055100b005116a0b1035mr1018904lfl.17.1709636825185; 
 Tue, 05 Mar 2024 03:07:05 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a1709067d9700b00a42ee62b634sm5861402ejo.106.2024.03.05.03.07.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:07:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 09/12] ui/cocoa: Remove normalWindow
Date: Tue,  5 Mar 2024 12:06:04 +0100
Message-ID: <20240305110608.21618-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

QemuCocoaView used to have fullScreenWindow but now it's gone, so we
do no longer have to call the window specifically "normalWindow".
Instead, refer to it with [-QemuCocoaView window].

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-7-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 20d73098e2..a891e76345 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -93,7 +93,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 
 static void cocoa_refresh(DisplayChangeListener *dcl);
 
-static NSWindow *normalWindow;
 static const DisplayChangeListenerOps dcl_ops = {
     .dpy_name          = "cocoa",
     .dpy_gfx_update = cocoa_update,
@@ -1071,9 +1070,9 @@ - (void) grabMouse
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
 
     if (qemu_name)
-        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
+        [[self window] setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
     else
-        [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
+        [[self window] setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
     [self hideCursor];
     CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
     isMouseGrabbed = TRUE; // while isMouseGrabbed = TRUE, QemuCocoaApp sends all events to [cocoaView handleEvent:]
@@ -1084,9 +1083,9 @@ - (void) ungrabMouse
     COCOA_DEBUG("QemuCocoaView: ungrabMouse\n");
 
     if (qemu_name)
-        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
+        [[self window] setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
     else
-        [normalWindow setTitle:@"QEMU"];
+        [[self window] setTitle:@"QEMU"];
     [self unhideCursor];
     CGAssociateMouseAndMouseCursorPosition(TRUE);
     isMouseGrabbed = FALSE;
@@ -1157,6 +1156,8 @@ - (void)adjustSpeed:(id)sender;
 @implementation QemuCocoaAppController
 - (id) init
 {
+    NSWindow *window;
+
     COCOA_DEBUG("QemuCocoaAppController: init\n");
 
     self = [super init];
@@ -1170,20 +1171,20 @@ - (id) init
         }
 
         // create a window
-        normalWindow = [[NSWindow alloc] initWithContentRect:[cocoaView frame]
+        window = [[NSWindow alloc] initWithContentRect:[cocoaView frame]
             styleMask:NSWindowStyleMaskTitled|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskClosable
             backing:NSBackingStoreBuffered defer:NO];
-        if(!normalWindow) {
+        if(!window) {
             error_report("(cocoa) can't create window");
             exit(1);
         }
-        [normalWindow setAcceptsMouseMovedEvents:YES];
-        [normalWindow setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
-        [normalWindow setTitle:qemu_name ? [NSString stringWithFormat:@"QEMU %s", qemu_name] : @"QEMU"];
-        [normalWindow setContentView:cocoaView];
-        [normalWindow makeKeyAndOrderFront:self];
-        [normalWindow center];
-        [normalWindow setDelegate: self];
+        [window setAcceptsMouseMovedEvents:YES];
+        [window setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
+        [window setTitle:qemu_name ? [NSString stringWithFormat:@"QEMU %s", qemu_name] : @"QEMU"];
+        [window setContentView:cocoaView];
+        [window makeKeyAndOrderFront:self];
+        [window center];
+        [window setDelegate: self];
 
         /* Used for displaying pause on the screen */
         pauseLabel = [NSTextField new];
@@ -1306,7 +1307,7 @@ - (void) windowDidResignKey: (NSNotification *)aNotification
  */
 - (void) doToggleFullScreen:(id)sender
 {
-    [normalWindow toggleFullScreen:sender];
+    [[cocoaView window] toggleFullScreen:sender];
 }
 
 - (void) setFullGrab:(id)sender
@@ -2004,7 +2005,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     /* if fullscreen mode is to be used */
     if (opts->has_full_screen && opts->full_screen) {
-        [normalWindow toggleFullScreen: nil];
+        [[cocoaView window] toggleFullScreen: nil];
     }
     if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
         [controller setFullGrab: nil];
-- 
2.41.0


