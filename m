Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E50FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jC-0000dq-RO; Wed, 12 Aug 2026 09:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8iD-0007wa-Ue; Wed, 12 Aug 2026 09:09:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8iB-0005jE-Eo; Wed, 12 Aug 2026 09:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=luZQ4rmtLyYcn41v/+r/ciOu+8ruc4vspm4XoHQvoZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mSAYQ2ze5rk3bn+d4BANZ9taCgHYNTb7lXBFft/v6sJzcEkBIvHMZfMPRlMwiJl17
 76kQ5jErNNNi0g9OQ6QPUfdeCGH3ybkvWguQehasaO1CpCmvf+2Vz7zD04tPNsfi5h
 M5jcTx4hM3z6ZnYreda0to8Eda4wV45smCvHkTK/mZKCvYbVjOfPGS/4mVkMn4oRqJ
 dUu25iY3ZhqpISmz1g9uzMGVUtRormeKcP2x6Q5mFKxECoiJYLcgqDAKzPQGBaRfsd
 XeQmzhqs3FFs4Pi9Ped08SjZM5q534ecTcjCqJlLez9pa+SdnwCsMVMSVV4hmPX1Cd
 zDvaPVvVtY1Yw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 52C4C1CA4C4;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 89855409BA7;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 828B32F91E; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 069/102] hw/display/exynos4210_fimd: Pass width to
 draw_line functions
Date: Wed, 12 Aug 2026 16:01:44 +0300
Message-ID: <20260812130233.621965-69-mjt@tls.msk.ru>
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

The draw_line functions currently assume the width of the line they
need to draw is w->rightbot_x - w->lefttop_x + 1, i.e.  the full
width of the guest-programmed window.  We want to be able to clamp
this to the overall screen size, which we can calculate in the
calling function.

Refactor to do this calculation in the caller and pass the
width as an argument to the draw_line functions.

Stable CC because this is a prerequisite for an upcoming bugfix
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20260706173324.804340-3-peter.maydell@linaro.org
(cherry picked from commit 7dd1e2218835f2c0bd754c092588110883a380a5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 744e065c51a..bafbaf89cf0 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -282,7 +282,7 @@ struct Exynos4210fimdWindow {
 
     pixel_to_rgb_func *pixel_to_rgb;
     void (*draw_line)(Exynos4210fimdWindow *w, uint8_t *src, uint8_t *dst,
-            bool blend);
+                      uint32_t width, bool blend);
     uint32_t (*get_alpha)(Exynos4210fimdWindow *w, uint32_t pix_a);
     uint16_t lefttop_x, lefttop_y;   /* VIDOSD0 register */
     uint16_t rightbot_x, rightbot_y; /* VIDOSD1 register */
@@ -781,9 +781,9 @@ exynos4210_fimd_blend_pixel(Exynos4210fimdWindow *w, rgba p_bg, rgba *ret)
 /* Draw line with index in palette table in RAM frame buffer data */
 #define DEF_DRAW_LINE_PALETTE(N) \
 static void glue(draw_line_palette_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
-               uint8_t *dst, bool blend) \
+                                        uint8_t *dst, uint32_t width, \
+                                        bool blend)                   \
 { \
-    int width = w->rightbot_x - w->lefttop_x + 1; \
     uint8_t *ifb = dst; \
     uint8_t swap = (w->wincon & FIMD_WINCON_SWAP) >> FIMD_WINCON_SWAP_SHIFT; \
     uint64_t data; \
@@ -810,9 +810,8 @@ static void glue(draw_line_palette_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
 /* Draw line with direct color value in RAM frame buffer data */
 #define DEF_DRAW_LINE_NOPALETTE(N) \
 static void glue(draw_line_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
-                    uint8_t *dst, bool blend) \
+                                uint8_t *dst, uint32_t width, bool blend) \
 { \
-    int width = w->rightbot_x - w->lefttop_x + 1; \
     uint8_t *ifb = dst; \
     uint8_t swap = (w->wincon & FIMD_WINCON_SWAP) >> FIMD_WINCON_SWAP_SHIFT; \
     uint64_t data; \
@@ -845,11 +844,10 @@ DEF_DRAW_LINE_NOPALETTE(32)
 
 /* Special draw line routine for window color map case */
 static void draw_line_mapcolor(Exynos4210fimdWindow *w, uint8_t *src,
-                       uint8_t *dst, bool blend)
+                               uint8_t *dst, uint32_t width, bool blend)
 {
     rgba p, p_old;
     uint8_t *ifb = dst;
-    int width = w->rightbot_x - w->lefttop_x + 1;
     uint32_t map_color = w->winmap & FIMD_WINMAP_COLOR_MASK;
 
     do {
@@ -1294,6 +1292,7 @@ static void exynos4210_fimd_update(void *opaque)
     uint8_t *host_fb_addr;
     bool is_dirty = false;
     uint32_t global_width;
+    uint32_t window_width;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
@@ -1309,6 +1308,8 @@ static void exynos4210_fimd_update(void *opaque)
         if ((w->wincon & FIMD_WINCON_ENWIN) && w->host_fb_addr) {
             scrn_height = w->rightbot_y - w->lefttop_y + 1;
             scrn_width = w->virtpage_width;
+            /* Number of bytes to actually draw */
+            window_width = w->rightbot_x - w->lefttop_x + 1;
             /* Total width of virtual screen page in bytes */
             inc_size = scrn_width + w->virtpage_offsize;
             host_fb_addr = w->host_fb_addr;
@@ -1327,7 +1328,8 @@ static void exynos4210_fimd_update(void *opaque)
                     last_line = line;
                     w->draw_line(w, host_fb_addr, s->ifb +
                         w->lefttop_x * RGBA_SIZE + (w->lefttop_y + line) *
-                        global_width * RGBA_SIZE, blend);
+                                 global_width * RGBA_SIZE,
+                                 window_width, blend);
                 }
                 host_fb_addr += inc_size;
                 fb_line_addr += inc_size;
-- 
2.47.3


