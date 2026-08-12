Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0818DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jF-0000pv-04; Wed, 12 Aug 2026 09:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8iD-0007wZ-7U; Wed, 12 Aug 2026 09:09:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8i7-0005ik-NA; Wed, 12 Aug 2026 09:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=7vQp8z0NgszPqiHyi/KNUnYAv2yjwf9q1jNnp1FUfCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l1aUg8Gfagb1Bd5DyO6C6NR5UD541d5Xwzcjz6FMBZ13kPeifV8WatzjVFYD93JWC
 Cx8gKs/BMi3ky+c1YyDVDGgfnCxs2zgP5YD8/QX1U3rvMmaIL4AtFueyXMoza5x8Uf
 jwBbUYFM5sG6nXHcvX1xaDiMptUHP0FywhwG9dcZA22Bq0Pmm//o6spTjM+tli2gSf
 Fi+a7+GGgM+ERSdyT49Io8uob13GO7oXusA+bUi8MaUnV1+QK1XxIeG5bR1ve3tjC8
 YM2er1qwifl4FeF4j7EOx1UOyzO48/NxBqhpjMmfEBVMlfxlZKiyRqMGfUOffPpppa
 tGjEQwig95aog==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4FE4A1CA4C3;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 854A5409BA6;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7FAA22F91C; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 068/102] hw/display/exynos4210_fimd: Factor out
 finding screen width/height
Date: Wed, 12 Aug 2026 16:01:43 +0300
Message-ID: <20260812130233.621965-68-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
index b3442d3b444..744e065c51a 100644
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


