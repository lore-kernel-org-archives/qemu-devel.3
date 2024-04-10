Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47230CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSIp-0007aU-OK; Wed, 10 Apr 2024 03:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIl-0007Xs-Cu; Wed, 10 Apr 2024 03:23:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIj-0003tq-Ft; Wed, 10 Apr 2024 03:23:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BE72A5D675;
 Wed, 10 Apr 2024 10:25:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 621F2B02B6;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191662 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Parsons <dave@daveparsons.net>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 06/87] ui/cocoa: Fix window clipping on macOS 14
Date: Wed, 10 Apr 2024 10:21:39 +0300
Message-Id: <20240410072303.4191455-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Parsons <dave@daveparsons.net>

macOS Sonoma changes the NSView.clipsToBounds to false by default
where it was true in earlier version of macOS. This causes the window
contents to be occluded by the frame at the top of the window. This
fixes the issue by conditionally compiling the clipping on Sonoma to
true. NSView only exposes the clipToBounds in macOS 14 and so has
to be fixed via conditional compilation.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
Signed-off-by: David Parsons <dave@daveparsons.net>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240224140620.39200-1-dave@daveparsons.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit f5af80271aad356233b2bea2369b3b2211fa395d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/cocoa.m b/ui/cocoa.m
index cd069da696..d39c9e2a3b 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -54,6 +54,10 @@
 #define MAC_OS_X_VERSION_10_13 101300
 #endif
 
+#ifndef MAC_OS_VERSION_14_0
+#define MAC_OS_VERSION_14_0 140000
+#endif
+
 /* 10.14 deprecates NSOnState and NSOffState in favor of
  * NSControlStateValueOn/Off, which were introduced in 10.13.
  * Define for older versions
@@ -365,6 +369,9 @@ - (id)initWithFrame:(NSRect)frameRect
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
         kbd = qkbd_state_init(dcl.con);
+#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
+        [self setClipsToBounds:YES];
+#endif
 
     }
     return self;
-- 
2.39.2


