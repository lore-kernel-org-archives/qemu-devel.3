Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76E6C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrNl-00025z-GU; Sat, 24 Feb 2024 07:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNj-00025p-Nz
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:55 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNi-0006q4-73
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:55 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so11253785ad.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778633; x=1709383433;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KT8BcIb11mqz+9fAbvto/wj31bQu+F9olqAkWWMLAX4=;
 b=W05cjieE5E1/T80SA0KWISasWLQsProlbp8FQjL/uxPVLmM0I4r5j1uuEUlBbrdoXk
 Bu5eLomaePY+vJHIqoCdutZnjNvXebLv6K34GolcEnLTV+tmDMxxP+YgWnE9g3ee2yna
 G9Fb6dujDNESPxadNA5adJ8dWg5A1GHLLcXLaT2aNck4Bv6Z58lSPIHoCalkH6y1kD05
 jmQGM8U0dhrzuIhK3nHQDs6QoRgM/mkVlfcFY9wrdc7VgLfnNKse5V3/uoyg7suQEv+a
 9yqJqPFLTEsN4lDBNy0F6lZvJsHs1j2w4c1oDOn82SE87HtWkFR2R4chevVYmR33qW4k
 NG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778633; x=1709383433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KT8BcIb11mqz+9fAbvto/wj31bQu+F9olqAkWWMLAX4=;
 b=oZs3DPB1UcxH/h3Ng1VmxBI3bMehcvjooYsF9bUGfCPVESzNyFKtnFq4kSSwNn2ipn
 REE0HybHxjo30jYzkTMg8ns6H8WSyFfBdioh5TTeHFFQZV2LnA5qjBE3Uw5zynlIIkQ5
 QaSuHfZDRUDA3lpN+AsDJ/+aw8TGDCpX3XlOJ0Rtl2QbVL5EzXSkwKd4SNwZkNXSt1qG
 olwo02lC6fKAHxn1/sU8qAOqbt07mUk918evGY1m3tYD0cBLIUseZijCUnZ/NTDNRZ2W
 5p4zZDl29f2qTtU08udMdnqMPMt6VbENxPAALKL5rZVBoWnrrxHLH5oHCdthpz4Zqktp
 mabg==
X-Gm-Message-State: AOJu0Ywq2I4OyC6VSLyGikGtZuWy/BJglDVX24+skmbrMzXNdmU/x1jr
 TIbBth5wuXwHb8jQ53HwWx4mUd4hb7L+DiNZ0sy+QBk8lIZynKNDYVw96bIUCc0=
X-Google-Smtp-Source: AGHT+IE6eUdD5Y4L+f5k2vx8a8DMok24SACD8W3Dyq2GP4wCyxnoidNicpPK2Y5NI9iT53+69d+K+A==
X-Received: by 2002:a17:902:6806:b0:1db:3a0d:1cf9 with SMTP id
 h6-20020a170902680600b001db3a0d1cf9mr2328358plk.48.1708778632952; 
 Sat, 24 Feb 2024 04:43:52 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 j6-20020a170902758600b001dc8923a2c4sm596219pll.294.2024.02.24.04.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:43:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:35 +0900
Subject: [PATCH v12 04/10] ui/cocoa: Scale with NSView instead of Core Graphics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-4-e89f70bdda71@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

Core Graphics is not accelerated and slow.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index c73ef8884454..644fd32eaa4d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -496,10 +496,8 @@ - (void) drawRect:(NSRect) rect
 
         [self getRectsBeingDrawn:&rectList count:&rectCount];
         for (i = 0; i < rectCount; i++) {
-            clipRect.origin.x = rectList[i].origin.x / cdx;
-            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) / cdy;
-            clipRect.size.width = rectList[i].size.width / cdx;
-            clipRect.size.height = rectList[i].size.height / cdy;
+            clipRect = rectList[i];
+            clipRect.origin.y = (float)h - (clipRect.origin.y + clipRect.size.height);
             clipImageRef = CGImageCreateWithImageInRect(
                                                         imageRef,
                                                         clipRect
@@ -545,6 +543,11 @@ - (void) setContentDimensions
     }
 }
 
+- (void) updateBounds
+{
+    [self setBoundsSize:NSMakeSize(screen.width, screen.height)];
+}
+
 - (void) updateUIInfoLocked
 {
     /* Must be called with the BQL, i.e. via updateUIInfo */
@@ -634,6 +637,7 @@ - (void) switchSurface:(pixman_image_t *)image
         screen.height = h;
         [self setContentDimensions];
         [self setFrame:NSMakeRect(cx, cy, cw, ch)];
+        [self updateBounds];
     }
 
     // update screenBuffer
@@ -1297,6 +1301,7 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
 
 - (void)windowDidResize:(NSNotification *)notification
 {
+    [cocoaView updateBounds];
     [cocoaView updateUIInfo];
 }
 
@@ -1945,16 +1950,7 @@ static void cocoa_update(DisplayChangeListener *dcl,
     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        NSRect rect;
-        if ([cocoaView cdx] == 1.0) {
-            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
-        } else {
-            rect = NSMakeRect(
-                x * [cocoaView cdx],
-                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
-                w * [cocoaView cdx],
-                h * [cocoaView cdy]);
-        }
+        NSRect rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
         [cocoaView setNeedsDisplayInRect:rect];
     });
 }

-- 
2.43.2


