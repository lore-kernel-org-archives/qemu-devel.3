Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CA310F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsY-0000Yn-94; Wed, 08 Apr 2026 14:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wAXsW-0000Mq-CX
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wAHj2-0005ms-4h
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:29:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BED55969EC;
 Wed, 08 Apr 2026 03:28:55 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id H8IWqafsHX5F; Wed,  8 Apr 2026 03:28:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2A9F15969F6; Wed, 08 Apr 2026 03:28:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ati-vga: Fix check for overflowing vram
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260408012853.2A9F15969F6@zero.eik.bme.hu>
Date: Wed, 08 Apr 2026 03:28:53 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Take into account the bytes per pixels when checking for accessing
beyond end of vram area.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index f0f77cecc6..2450bb5e74 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -146,6 +146,7 @@ static uint32_t make_filler(int bpp, uint32_t color)
 static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     QemuRect vis_src, vis_dst;
+    unsigned int x, y, i, j, bypp = ctx->bpp / 8;
 
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -156,7 +157,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         return false;
     }
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
-        ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
+        ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x * bypp +
         (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
@@ -194,7 +195,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
         if (!ctx->host_data_active &&
             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
-            ctx->src_bits >= ctx->vram_end || ctx->src_bits + vis_src.x +
+            ctx->src_bits >= ctx->vram_end || ctx->src_bits + vis_src.x * bypp +
             (vis_src.y + vis_dst.height) * ctx->src_stride >= ctx->vram_end)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
@@ -240,7 +241,6 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = ctx->bpp / 8;
             for (y = 0; y < vis_dst.height; y++) {
                 i = vis_dst.x * bypp;
                 j = vis_src.x * bypp;
@@ -299,7 +299,6 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = ctx->bpp / 8;
             for (y = 0; y < vis_dst.height; y++) {
                 i = vis_dst.x * bypp + (vis_dst.y + y) * ctx->dst_stride;
                 for (x = 0; x < vis_dst.width; x++, i += bypp) {
-- 
2.41.3


