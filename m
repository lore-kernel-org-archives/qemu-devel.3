Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB814C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdP-00080Q-13; Tue, 05 Mar 2024 06:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdB-0007kK-Ac
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:49 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSd5-0002mP-ND
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:45 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5656e5754ccso6960723a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636798; x=1710241598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Orv4djFB2EMOeVxvQYFyiboh//axFe5wKfX2XCTUXLY=;
 b=qso+0REDb2TDP52z5pu2LYECBb87e2BmiifViJlYlXR1HHvw3waFVHKHJxFothz++b
 3r1ePWQbVmXWhBY6wMH5xyt3O7XKBNZ7U7kjiEbE2vObPD0WguVAb/aMnehFeSKHAMLW
 Oqyq1O4qiD+ahZDGWIFW82oc3Ez2z75nkBTqumu0S8sIdD1MBlkQWcDPLuhUv4qrcBZ9
 Jq56Yu/gIIz9rE8bgxkzgWD4qa81Q+coXmo6zzsxSFg2Zg25qdKxORZf4JTfOniohxIj
 Tn7YurYtNS3fmL78Ku4rqZSKEKDEFXvhKWghXskupRjcquwRZAZIG0pav4w+wcFao0vJ
 f0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636798; x=1710241598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Orv4djFB2EMOeVxvQYFyiboh//axFe5wKfX2XCTUXLY=;
 b=mBeEx3zFiZlMdKo/QCHcGn1C+y4/Nx2DZpQBbvOyLQjCu6YTChgJl+6UgoiqAhrK9A
 cTIJ8Q7qQKbB/6A4cnEMu2QAG9QFZE2j2MPzll+qpBf7X7EVgqi9MUO1mWpDA69+kW9q
 kNTTSjPz4HK7x9rGnkxaO/W6lHquOJ2qsaXG3ta56Uy6+uDOhTvlIkqnazNAOOHzGlLC
 FNAtlYUFD/TcoK6YCcl7arp9vrf6lugKwevxaDU/vCAHhkQyBXl9IFnJQUNOccGNI03x
 /cVEfYq4/FmwZdwkXfKUuhfYgvBhrCESNmxIwQGuy/nH9cEPp94bYzSO4h0XujVQxBxN
 HY+w==
X-Gm-Message-State: AOJu0YySLw4KgqbhQekGILP/qQ2ynRku9f5mxGBZovhboY9a/LU4vUYn
 5WAsweKGahzNS4pbxLZHQuh1WSE7wADjVQoVj90TZ8CMYbTFG1ouEmrObUlMfRuLR43Oo5hsXYz
 3
X-Google-Smtp-Source: AGHT+IEUSyxc62dmlyAayb5hXqv1GAKHWtbW8eyfWXF3MKzehvfFlZPKDWaT8Yd5JckayIRLHL4GCQ==
X-Received: by 2002:a05:6512:110a:b0:513:33ad:2099 with SMTP id
 l10-20020a056512110a00b0051333ad2099mr1152533lfg.63.1709636776986; 
 Tue, 05 Mar 2024 03:06:16 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 um15-20020a170906cf8f00b00a443e6f9403sm5923651ejb.54.2024.03.05.03.06.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Carwyn Ellis <carwynellis@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/12] ui/cocoa: add zoom-interpolation display option
Date: Tue,  5 Mar 2024 12:05:56 +0100
Message-ID: <20240305110608.21618-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

From: Carwyn Ellis <carwynellis@gmail.com>

Provides a new display option, zoom-interpolation, that enables
interpolation of the scaled display when zoom-to-fit is enabled.

Also provides a corresponding view menu item to allow this to be toggled
as required.

Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20231110161729.36822-2-carwynellis@gmail.com>
[PMD: QAPI @zoom-interpolation since 9.0]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/ui.json |  6 +++++-
 ui/cocoa.m   | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index e3999b7c07..096a2ad26f 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1428,6 +1428,9 @@
 #     turned off the host window will be resized instead. Defaults to
 #     "off". (Since 8.2)
 #
+# @zoom-interpolation: Apply interpolation to smooth output when
+#     zoom-to-fit is enabled. Defaults to "off". (Since 9.0)
+#
 # Since: 7.0
 ##
 { 'struct': 'DisplayCocoa',
@@ -1435,7 +1438,8 @@
       '*left-command-key': 'bool',
       '*full-grab': 'bool',
       '*swap-opt-cmd': 'bool',
-      '*zoom-to-fit': 'bool'
+      '*zoom-to-fit': 'bool',
+      '*zoom-interpolation': 'bool'
   } }
 
 ##
diff --git a/ui/cocoa.m b/ui/cocoa.m
index eb99064bee..b7ca0ed94b 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -105,6 +105,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static bool swap_opt_cmd;
 
 static bool stretch_video;
+static CGInterpolationQuality zoom_interpolation = kCGInterpolationNone;
 static NSTextField *pauseLabel;
 
 static bool allow_events;
@@ -455,7 +456,7 @@ - (void) drawRect:(NSRect) rect
     // get CoreGraphic context
     CGContextRef viewContextRef = [[NSGraphicsContext currentContext] CGContext];
 
-    CGContextSetInterpolationQuality (viewContextRef, kCGInterpolationNone);
+    CGContextSetInterpolationQuality (viewContextRef, zoom_interpolation);
     CGContextSetShouldAntialias (viewContextRef, NO);
 
     // draw screen bitmap directly to Core Graphics context
@@ -1411,6 +1412,17 @@ - (void)zoomToFit:(id) sender
     }
 }
 
+- (void)toggleZoomInterpolation:(id) sender
+{
+    if (zoom_interpolation == kCGInterpolationNone) {
+        zoom_interpolation = kCGInterpolationLow;
+        [sender setState: NSControlStateValueOn];
+    } else {
+        zoom_interpolation = kCGInterpolationNone;
+        [sender setState: NSControlStateValueOff];
+    }
+}
+
 /* Displays the console on the screen */
 - (void)displayConsole:(id)sender
 {
@@ -1673,6 +1685,9 @@ static void create_initial_menus(void)
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
     [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
+    menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom Interpolation" action:@selector(toggleZoomInterpolation:) keyEquivalent:@""] autorelease];
+    [menuItem setState: zoom_interpolation == kCGInterpolationLow ? NSControlStateValueOn : NSControlStateValueOff];
+    [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
@@ -2070,6 +2085,10 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
         stretch_video = true;
     }
 
+    if (opts->u.cocoa.has_zoom_interpolation && opts->u.cocoa.zoom_interpolation) {
+        zoom_interpolation = kCGInterpolationLow;
+    }
+
     create_initial_menus();
     /*
      * Create the menu entries which depend on QEMU state (for consoles
-- 
2.41.0


