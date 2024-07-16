Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A283C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTme5-0004sc-28; Tue, 16 Jul 2024 14:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdQ-0001hF-47
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdN-0001JG-45
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso41300645e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153439; x=1721758239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0D9AUY7gUeEKLy7Uo83BX14QqkvgyIU5b+p9IGxUa0=;
 b=xMZRMUsUoZL4CDu/F41+r6OT67G0ebFBV5WgA+EOisZeQpaMHPg8ZZ4fqM7V3+XyA4
 OcZ2HfmtvMibu7mrY+6Sj5E2qXjjjjDEDzfO3xI0p/wQY5Du+7sxp2kFuO7VxKWYeho0
 jsHMfFpTlBcZSsvECthJ7HRt6iY5sWWRBfmiWk5omw/J8xOcR9Ly4EVRrfmy+PZrRlxx
 jo9BzOzqliBUKlCiF2qMb7X8ej1Y7YZhaFC6rC+Zss0PI3NC9LZvzFBshtbNZs6otl1w
 W1J6ECkoYYxEFunBLNydHaG7ZC3t+NAfwui3PsHnB9HxsyYPW6nThcV3PTewN/Ky0t3C
 7dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153439; x=1721758239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0D9AUY7gUeEKLy7Uo83BX14QqkvgyIU5b+p9IGxUa0=;
 b=fwcKPm5MU1Nb8DKMXSeKJ39WAJWjJ6+XszYYMZx65EAY0Hjh3WvzxVJUm2iTdprj5N
 Hh6NuFSS0E7WJGTjjmiK0jVtFH30IjnJ9dwM9ikCQlQcHmzhF2JvOsVHmQ7Y5Um/S0Om
 GiWIeg9kVy9xxJbpS/GnmSaWPCTW+MTTcJ1YFlgr7YNObyw0dJtyWFMl2VPvMUXyvWXi
 9Tgbh6yX4fSHbLLaaBRagi9Z+iGYriM3ldu1UwNOWG0EzbOUF8H0ypm/w+ZaepCq2AEm
 tgbAZk1jhj8wPF/7pFfAFSYur67IeGaRhou+3B62YwfC4IBvR0KO/r1H9+P1ZK3ng/0L
 xG2A==
X-Gm-Message-State: AOJu0YwK2VFVbQMiJ37cC2bCExTpInyqiQfg+OUHGO2Lkgns/3gEFwEg
 YBt6CNBdV4db/u5HbPK+v48RHvPAfhUecWbP2my/Gmokk15UacgQ+VHhoh7NamisHXF0wTLusp1
 iI9l96w==
X-Google-Smtp-Source: AGHT+IFs48Yrh5pWhGCoVY2TzBsGBiXvpyzRIb8s0Q1MFoW0uiaVODFeTB8Ez21Vd1xGowT1gSZ6pw==
X-Received: by 2002:a05:600c:3b0f:b0:426:6fd3:1547 with SMTP id
 5b1f17b1804b1-427ba654e7amr19745035e9.2.1721153438966; 
 Tue, 16 Jul 2024 11:10:38 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e8266asm137898735e9.13.2024.07.16.11.10.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/13] ui/cocoa: Add cursor composition
Date: Tue, 16 Jul 2024 20:09:37 +0200
Message-ID: <20240716180941.40211-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add accelerated cursor composition to ui/cocoa. This does not only
improve performance for display devices that exposes the capability to
the guest according to dpy_cursor_define_supported(), but fixes the
cursor display for devices that unconditionally expects the availability
of the capability (e.g., virtio-gpu).

The common pattern to implement accelerated cursor composition is to
replace the cursor and warp it so that the replaced cursor is shown at
the correct position on the guest display for relative pointer devices.
Unfortunately, ui/cocoa cannot do the same because warping the cursor
position interfers with the mouse input so it uses CALayer instead;
although it is not specialized for cursor composition, it still can
compose images with hardware acceleration.

Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240715-cursor-v3-3-afa5b9492dbf@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build |  3 +-
 ui/cocoa.m  | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6a93da48e1..a1e51277b0 100644
--- a/meson.build
+++ b/meson.build
@@ -1070,7 +1070,8 @@ if get_option('attr').allowed()
   endif
 endif
 
-cocoa = dependency('appleframeworks', modules: ['Cocoa', 'CoreVideo'],
+cocoa = dependency('appleframeworks',
+                   modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
                    required: get_option('cocoa'))
 
 vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 79a054b128..4c2dd33532 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #import <Cocoa/Cocoa.h>
+#import <QuartzCore/QuartzCore.h>
 #include <crt_externs.h>
 
 #include "qemu/help-texts.h"
@@ -79,12 +80,16 @@ static void cocoa_switch(DisplayChangeListener *dcl,
                          DisplaySurface *surface);
 
 static void cocoa_refresh(DisplayChangeListener *dcl);
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, bool on);
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor);
 
 static const DisplayChangeListenerOps dcl_ops = {
     .dpy_name          = "cocoa",
     .dpy_gfx_update = cocoa_update,
     .dpy_gfx_switch = cocoa_switch,
     .dpy_refresh = cocoa_refresh,
+    .dpy_mouse_set = cocoa_mouse_set,
+    .dpy_cursor_define = cocoa_cursor_define,
 };
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
@@ -308,6 +313,11 @@ @interface QemuCocoaView : NSView
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
     CGColorSpaceRef colorspace;
+    CALayer *cursorLayer;
+    QEMUCursor *cursor;
+    int mouseX;
+    int mouseY;
+    bool mouseOn;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
@@ -364,6 +374,12 @@ - (id)initWithFrame:(NSRect)frameRect
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
+        [self setWantsLayer:YES];
+        cursorLayer = [[CALayer alloc] init];
+        [cursorLayer setAnchorPoint:CGPointMake(0, 1)];
+        [cursorLayer setAutoresizingMask:kCALayerMaxXMargin |
+                                         kCALayerMinYMargin];
+        [[self layer] addSublayer:cursorLayer];
 
     }
     return self;
@@ -382,6 +398,8 @@ - (void) dealloc
     }
 
     CGColorSpaceRelease(colorspace);
+    [cursorLayer release];
+    cursor_unref(cursor);
     [super dealloc];
 }
 
@@ -426,6 +444,72 @@ - (void) unhideCursor
     [NSCursor unhide];
 }
 
+- (void)setMouseX:(int)x y:(int)y on:(bool)on
+{
+    CGPoint position;
+
+    mouseX = x;
+    mouseY = y;
+    mouseOn = on;
+
+    position.x = mouseX;
+    position.y = screen.height - mouseY;
+
+    [CATransaction begin];
+    [CATransaction setDisableActions:YES];
+    [cursorLayer setPosition:position];
+    [cursorLayer setHidden:!mouseOn];
+    [CATransaction commit];
+}
+
+- (void)setCursor:(QEMUCursor *)given_cursor
+{
+    CGDataProviderRef provider;
+    CGImageRef image;
+    CGRect bounds = CGRectZero;
+
+    cursor_unref(cursor);
+    cursor = given_cursor;
+
+    if (!cursor) {
+        return;
+    }
+
+    cursor_ref(cursor);
+
+    bounds.size.width = cursor->width;
+    bounds.size.height = cursor->height;
+
+    provider = CGDataProviderCreateWithData(
+        NULL,
+        cursor->data,
+        cursor->width * cursor->height * 4,
+        NULL
+    );
+
+    image = CGImageCreate(
+        cursor->width, //width
+        cursor->height, //height
+        8, //bitsPerComponent
+        32, //bitsPerPixel
+        cursor->width * 4, //bytesPerRow
+        colorspace, //colorspace
+        kCGBitmapByteOrder32Little | kCGImageAlphaFirst, //bitmapInfo
+        provider, //provider
+        NULL, //decode
+        0, //interpolate
+        kCGRenderingIntentDefault //intent
+    );
+
+    CGDataProviderRelease(provider);
+    [CATransaction begin];
+    [CATransaction setDisableActions:YES];
+    [cursorLayer setBounds:bounds];
+    [cursorLayer setContents:(id)image];
+    [CATransaction commit];
+    CGImageRelease(image);
+}
+
 - (void) drawRect:(NSRect) rect
 {
     COCOA_DEBUG("QemuCocoaView: drawRect\n");
@@ -2015,6 +2099,21 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     [pool release];
 }
 
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, bool on)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        [cocoaView setMouseX:x y:y on:on];
+    });
+}
+
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        BQL_LOCK_GUARD();
+        [cocoaView setCursor:qemu_console_get_cursor(dcl->con)];
+    });
+}
+
 static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
-- 
2.41.0


