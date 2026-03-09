Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A6AEA8549
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPjN-0005p2-1t; Sun, 08 Mar 2026 21:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPj2-0005mh-Ic
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiz-0001Ii-Nd
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 96CF0596A42;
 Mon, 09 Mar 2026 02:47:52 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id cDBxQwGLZ6hQ; Mon,  9 Mar 2026 02:47:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8E5D35969EE; Mon, 09 Mar 2026 02:47:50 +0100 (CET)
Message-ID: <4752dfbe240102c2ffa1f2cdab4c9442d4f0dcfb.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 7/9] ati-vga: Implement scissor rectangle clipping for 2D
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:50 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Chad Jablonski <chad@jablonski.xyz>

Use scissor registers to clip blit operations. This is required
for text rendering in X using the r128 driver. Without it overly-wide
glyphs are drawn and create all sorts of chaos.

The visible destination rectangle (vis_dst) is the intersection of the
scissor rectangle and the destination rectangle (dst).

The src also needs to be offset if clipped on the top and/or
left sides to ensure that src data is read correctly and appears
clipped when drawn rather than shifted.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 87 ++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 1dfad730ba..d62ad849f3 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -52,6 +52,7 @@ typedef struct {
     uint32_t frgd_clr;
     const uint8_t *palette;
     const uint8_t *vram_end;
+    QemuRect scissor;
 
     QemuRect dst;
     int dst_stride;
@@ -91,6 +92,11 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->dst_offset = s->regs.dst_offset;
     ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
 
+    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
+    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
+    ctx->scissor.x = s->regs.sc_left;
+    ctx->scissor.y = s->regs.sc_top;
+
     ctx->dst.width = s->regs.dst_width;
     ctx->dst.height = s->regs.dst_height;
     ctx->dst.x = (ctx->left_to_right ?
@@ -125,6 +131,8 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
 
 static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
+    QemuRect vis_src, vis_dst;
+
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return false;
@@ -139,6 +147,29 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
     }
+    qemu_rect_intersect(&ctx->dst, &ctx->scissor, &vis_dst);
+    if (!vis_dst.height || !vis_dst.width) {
+        /* Nothing is visible, completely clipped */
+        return false;
+    }
+    /*
+     * The src must be offset if clipping is applied to the dst.
+     * This is so that when the source is blit to a dst clipped
+     * on the top or left the src image is not shifted into the
+     * clipped region but actually clipped.
+     */
+    vis_src.x = ctx->src.x + (vis_dst.x - ctx->dst.x);
+    vis_src.y = ctx->src.y + (vis_dst.y - ctx->dst.y);
+    vis_src.width = vis_dst.width;
+    vis_src.height = vis_dst.height;
+
+    DPRINTF("dst: (%d,%d) %dx%d -> vis_dst: (%d,%d) %dx%d\n",
+            ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height,
+            vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height);
+    DPRINTF("src: (%d,%d) %dx%d -> vis_src: (%d,%d) %dx%d\n",
+            ctx->src.x, ctx->src.y, ctx->dst.width, ctx->dst.height,
+            vis_src.x, vis_src.y, vis_src.width, vis_src.height);
+
     switch (ctx->rop3) {
     case ROP3_SRCCOPY:
     {
@@ -147,10 +178,9 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return false;
         }
-        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff ||
-            ctx->src_bits >= ctx->vram_end ||
-            ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height) *
-            ctx->src_stride >= ctx->vram_end) {
+        if (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
+            ctx->src_bits >= ctx->vram_end || ctx->src_bits + vis_src.x +
+            (vis_src.y + vis_dst.height) * ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
@@ -159,8 +189,8 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
                 ctx->src_bits, ctx->dst_bits,
                 ctx->src_stride / sizeof(uint32_t),
                 ctx->dst_stride / sizeof(uint32_t),
-                ctx->bpp, ctx->bpp, ctx->src.x, ctx->src.y, ctx->dst.x,
-                ctx->dst.y, ctx->dst.width, ctx->dst.height);
+                ctx->bpp, ctx->bpp, vis_src.x, vis_src.y, vis_dst.x, vis_dst.y,
+                vis_dst.width, vis_dst.height);
 #ifdef CONFIG_PIXMAN
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
         int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
@@ -169,24 +199,24 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             fallback = !pixman_blt((uint32_t *)ctx->src_bits,
                                    (uint32_t *)ctx->dst_bits, src_stride_words,
                                    dst_stride_words, ctx->bpp, ctx->bpp,
-                                   ctx->src.x, ctx->src.y, ctx->dst.x,
-                                   ctx->dst.y, ctx->dst.width, ctx->dst.height);
+                                   vis_src.x, vis_src.y, vis_dst.x, vis_dst.y,
+                                   vis_dst.width, vis_dst.height);
         } else if (use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = ctx->dst.width * (ctx->bpp / 8);
+            int llb = vis_dst.width * (ctx->bpp / 8);
             int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
-                                     ctx->dst.height);
+                                     vis_dst.height);
             fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
                                    src_stride_words, tmp_stride_words, ctx->bpp,
-                                   ctx->bpp, ctx->src.x, ctx->src.y, 0, 0,
-                                   ctx->dst.width, ctx->dst.height);
+                                   ctx->bpp, vis_src.x, vis_src.y, 0, 0,
+                                   vis_dst.width, vis_dst.height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
                                        tmp_stride_words, dst_stride_words,
                                        ctx->bpp, ctx->bpp, 0, 0,
-                                       ctx->dst.x, ctx->dst.y,
-                                       ctx->dst.width, ctx->dst.height);
+                                       vis_dst.x, vis_dst.y,
+                                       vis_dst.width, vis_dst.height);
             }
             g_free(tmp);
         } else
@@ -196,20 +226,20 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = ctx->bpp / 8;
-            for (y = 0; y < ctx->dst.height; y++) {
-                i = ctx->dst.x * bypp;
-                j = ctx->src.x * bypp;
+            for (y = 0; y < vis_dst.height; y++) {
+                i = vis_dst.x * bypp;
+                j = vis_src.x * bypp;
                 if (ctx->top_to_bottom) {
-                    i += (ctx->dst.y + y) * ctx->dst_stride;
-                    j += (ctx->src.y + y) * ctx->src_stride;
+                    i += (vis_dst.y + y) * ctx->dst_stride;
+                    j += (vis_src.y + y) * ctx->src_stride;
                 } else {
-                    i += (ctx->dst.y + ctx->dst.height - 1 - y)
+                    i += (vis_dst.y + vis_dst.height - 1 - y)
                          * ctx->dst_stride;
-                    j += (ctx->src.y + ctx->dst.height - 1 - y)
+                    j += (vis_src.y + vis_dst.height - 1 - y)
                          * ctx->src_stride;
                 }
                 memmove(&ctx->dst_bits[i], &ctx->src_bits[j],
-                        ctx->dst.width * bypp);
+                        vis_dst.width * bypp);
             }
         }
         break;
@@ -238,21 +268,20 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 
         DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
                 ctx->dst_bits, ctx->dst_stride / sizeof(uint32_t), ctx->bpp,
-                ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height,
-                filler);
+                vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(use_pixman & BIT(0)) ||
             !pixman_fill((uint32_t *)ctx->dst_bits,
                          ctx->dst_stride / sizeof(uint32_t), ctx->bpp,
-                         ctx->dst.x, ctx->dst.y,
-                         ctx->dst.width, ctx->dst.height, filler))
+                         vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height,
+                         filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = ctx->bpp / 8;
-            for (y = 0; y < ctx->dst.height; y++) {
-                i = ctx->dst.x * bypp + (ctx->dst.y + y) * ctx->dst_stride;
-                for (x = 0; x < ctx->dst.width; x++, i += bypp) {
+            for (y = 0; y < vis_dst.height; y++) {
+                i = vis_dst.x * bypp + (vis_dst.y + y) * ctx->dst_stride;
+                for (x = 0; x < vis_dst.width; x++, i += bypp) {
                     stn_he_p(&ctx->dst_bits[i], bypp, filler);
                 }
             }
-- 
2.41.3


