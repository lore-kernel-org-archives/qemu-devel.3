Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FB9C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAPp-0007as-Pg; Wed, 12 Aug 2026 10:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPY-0006i6-AO; Wed, 12 Aug 2026 10:58:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPW-0001Fh-0d; Wed, 12 Aug 2026 10:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=l0D09KU06IlF6XhbCg+2gCjeUISqqmYt3jBoagWhqM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y5aUMaqgqhl2GDgYLSl/FyBrI5WW7rPv1+dzTOu9NKsnVdYM7AL+1SplA3fIhwSWM
 ZZqGIRipy79q5HRuoxk3W43aUcQyrUgvZ29N+LUXrSuLM/TD0i7B9nKXlvDisyUybL
 P/xgmk7j27+dsmpK8ieKhsN01OGiE2jB2QfhfJdBIUnn0uCPlDP8Gyvip9oWlw0pY3
 78yjTkDK0loLUH/gw2VbD8KE1TnOIRKvR+E+wtli9s8Sjv4VWb5xqP1CF5znqBH9LT
 LoM9xunZWp/klif+A+QPPV0uLgGn1c1JPUjbCl+NEvKQ8CXcOANyWGffkNh/9XkXuv
 LtGyDRVLFNJAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF4621CA653;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5632C409D95;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B3A462FA01; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 079/120] hw/display/exynos4210_fimd: Factor out
 finding screen width/height
Date: Wed, 12 Aug 2026 17:49:02 +0300
Message-ID: <20260812144955.649205-79-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Currently we hard-code the expressions for getting the global screen
width and height out of the VIDTCON2 register where we need them.
Use functions instead.  Make the global_width variable in
exynos4210_fimd_update() uint32_t for consistency.  (The values are
clamped to well below INT_MAX, so there is no overflow risk here.)

Stable CC because this is a prerequisite for an upcoming bugfix
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20260706173324.804340-2-peter.maydell@linaro.org
(cherry picked from commit 4f635bddf50c8c7783dbab7a584ebce4a07feee2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 2d8fa7ee944..ff3a45339f3 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1249,15 +1249,25 @@ static void exynos4210_fimd_update_irq(Exynos4210fimdState *s)
     }
 }
 
+static uint32_t exynos4210_fimd_global_width(Exynos4210fimdState *s)
+{
+    return ((s->vidtcon[2] >> FIMD_VIDTCON2_HOR_SHIFT) &
+            FIMD_VIDTCON2_SIZE_MASK) + 1;
+}
+
+static uint32_t exynos4210_fimd_global_height(Exynos4210fimdState *s)
+{
+    return ((s->vidtcon[2] >> FIMD_VIDTCON2_VER_SHIFT) &
+            FIMD_VIDTCON2_SIZE_MASK) + 1;
+}
+
 static void exynos4210_update_resolution(Exynos4210fimdState *s)
 {
     DisplaySurface *surface = qemu_console_surface(s->console);
 
     /* LCD resolution is stored in VIDEO TIME CONTROL REGISTER 2 */
-    uint32_t width = ((s->vidtcon[2] >> FIMD_VIDTCON2_HOR_SHIFT) &
-            FIMD_VIDTCON2_SIZE_MASK) + 1;
-    uint32_t height = ((s->vidtcon[2] >> FIMD_VIDTCON2_VER_SHIFT) &
-            FIMD_VIDTCON2_SIZE_MASK) + 1;
+    uint32_t width = exynos4210_fimd_global_width(s);
+    uint32_t height = exynos4210_fimd_global_height(s);
 
     if (s->ifb == NULL || surface_width(surface) != width ||
             surface_height(surface) != height) {
@@ -1283,14 +1293,14 @@ static void exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    int global_width;
+    uint32_t global_width;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
         return;
     }
 
-    global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
+    global_width = exynos4210_fimd_global_width(s);
     exynos4210_update_resolution(s);
     surface = qemu_console_surface(s->console);
 
-- 
2.47.3


