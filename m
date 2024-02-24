Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739C5C54E4A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrNx-00028G-0A; Sat, 24 Feb 2024 07:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNw-000286-1K
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:08 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNu-0006u1-EG
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc418fa351so7465235ad.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778644; x=1709383444;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nt57ujv4NnZB25s+B3l5Rc+AeEqYc9k3QAlhH6Vn4XQ=;
 b=gi68XU313FwCz0IQ6zF4ENuuIBUGdm6DLqWTsbP64N8hjsbQH7gM541W1D+8JiPgUi
 A+ZH90Vm+JHISNVuJNZCSGeJUhRvhCp7rgiOk+CN1NcpLwGrcyuaNCcIrxIfxEDqEr5Z
 a+nIScuAnpgwl1H2VgRYIgeGGh1hLKiqVfl9ujKoibiKPYcSYuVbO/5F0X1dvKH92f5y
 B7ibEqDUwWVQ7Br+ORAUz19y3eGI6KA4MlmK5AGtR5YLLIyRSJayzorDXRJYvuCjQQRc
 Ed5C9EUWCe7PTdv9yj9HY97S2QRzpzm6k++DTZW1o8Y1qF9SUg+Kx5wllKFvNqqVE+S1
 Rdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778644; x=1709383444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nt57ujv4NnZB25s+B3l5Rc+AeEqYc9k3QAlhH6Vn4XQ=;
 b=oIb4ry3tgVDX6EUPndgVtM52f3KOLhhKcmSX58ydIE8qew/+p3zIQlRFF5T+MWXwy8
 qV8zK9Y38bPXdRTy13mUzkkBtlSSbzA9rP9zhn8CfXeIYD9GRUeMCYKTlKwgbw4573W7
 jDSp5uau7NimHAQ1zznIwEth4aQIHDLbEwIRrMipG4SKakpDsAZ2DVox1BKIU7jfdw+U
 UTHk2ph1rFBORbvwdrUqBm2bfML05p1zvYt/256tFELj1ehMEaUTq6WIwBKp+auujGXm
 a1EBs3oHqy0KlfRSnS1lXbugBie+uPEj5CEiJN5NTVEQ548WGw/aJdOdlVhtYBIwgyrp
 5GgA==
X-Gm-Message-State: AOJu0YykEWnDiHgcgB/uq2p2iCJytjSUa3xgZfirYH5qavdH35ouGTDn
 4w2xZC674oXX9W4z4pZkVQrfKb1gw7yL22e6TkroImW2fSShor1brGyXbbIilx0=
X-Google-Smtp-Source: AGHT+IHNcZDxhg1DJ9UepZI/UUGve8G0YCSJHWvOyeyoIGJ4tm56PiY1WHTrYPwbsKxo14WlXHNrvA==
X-Received: by 2002:a17:902:ea0b:b0:1dc:7101:58c0 with SMTP id
 s11-20020a170902ea0b00b001dc710158c0mr3326114plg.22.1708778644181; 
 Sat, 24 Feb 2024 04:44:04 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 w19-20020a170902c79300b001db6a228c3esm961057pla.307.2024.02.24.04.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:44:03 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:38 +0900
Subject: [PATCH v12 07/10] ui/cocoa: Remove normalWindow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-7-e89f70bdda71@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

QemuCocoaView used to have fullScreenWindow but now it's gone, so we
do no longer have to call the window specifically "normalWindow".
Instead, refer to it with [-QemuCocoaView window].

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 88684af6f38b..05c91e4eed53 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -89,7 +89,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 
 static void cocoa_refresh(DisplayChangeListener *dcl);
 
-static NSWindow *normalWindow;
 static const DisplayChangeListenerOps dcl_ops = {
     .dpy_name          = "cocoa",
     .dpy_gfx_update = cocoa_update,
@@ -1063,9 +1062,9 @@ - (void) grabMouse
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
@@ -1076,9 +1075,9 @@ - (void) ungrabMouse
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
@@ -1149,6 +1148,8 @@ - (void)adjustSpeed:(id)sender;
 @implementation QemuCocoaAppController
 - (id) init
 {
+    NSWindow *window;
+
     COCOA_DEBUG("QemuCocoaAppController: init\n");
 
     self = [super init];
@@ -1162,20 +1163,20 @@ - (id) init
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
@@ -1298,7 +1299,7 @@ - (void) windowDidResignKey: (NSNotification *)aNotification
  */
 - (void) doToggleFullScreen:(id)sender
 {
-    [normalWindow toggleFullScreen:sender];
+    [[cocoaView window] toggleFullScreen:sender];
 }
 
 - (void) setFullGrab:(id)sender
@@ -1982,7 +1983,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     /* if fullscreen mode is to be used */
     if (opts->has_full_screen && opts->full_screen) {
-        [normalWindow toggleFullScreen: nil];
+        [[cocoaView window] toggleFullScreen: nil];
     }
     if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
         [controller setFullGrab: nil];

-- 
2.43.2


