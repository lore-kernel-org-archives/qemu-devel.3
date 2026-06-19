Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36ADCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZpU-00021b-1N; Fri, 19 Jun 2026 10:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1waZpR-00020t-Le
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:04:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1waZpP-0000x7-Be
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:04:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB52A59694F;
 Fri, 19 Jun 2026 16:04:10 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id p0kbqH-Joi5e; Fri, 19 Jun 2026 16:04:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6CF98596948; Fri, 19 Jun 2026 16:04:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ati-vga: Include vga state in the blit context
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
Message-Id: <20260619140408.6CF98596948@zero.eik.bme.hu>
Date: Fri, 19 Jun 2026 16:04:08 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The vga state is needed by several functions using the blit context so
just include it in the context instead of passing it separately.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 48498677c7..ce62b470ab 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -45,6 +45,7 @@ static int ati_bpp_from_datatype(const ATIVGAState *s)
 }
 
 typedef struct {
+    VGACommonState *vga;
     int bpp;
     uint32_t rop3;
     bool host_data_active;
@@ -52,8 +53,6 @@ typedef struct {
     bool top_to_bottom;
     bool need_swap;
     uint32_t frgd_clr;
-    const uint8_t *palette;
-    const uint8_t *vram_end;
     QemuRect scissor;
 
     QemuRect dst;
@@ -66,8 +65,9 @@ typedef struct {
     const uint8_t *src_bits;
 } ATI2DCtx;
 
-static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
+static void ati_set_dirty(const ATI2DCtx *ctx)
 {
+    VGACommonState *vga = ctx->vga;
     DisplaySurface *ds = qemu_console_surface(vga->con);
     unsigned int bypp = ctx->bpp / 8;
     hwaddr dirty_start = ctx->dst_offset + ctx->dst.x * bypp +
@@ -94,8 +94,9 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
     }
 }
 
-static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
+static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
 {
+    ctx->vga = &s->vga;
     ctx->bpp = ati_bpp_from_datatype(s);
     ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
     ctx->host_data_active = s->host_data.active;
@@ -103,9 +104,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
     ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
-    ctx->palette = s->vga.palette;
     ctx->dst_offset = s->regs.dst_offset;
-    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
 
     ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
     ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
@@ -153,10 +152,11 @@ static uint32_t make_filler(int bpp, uint32_t color)
     return color;
 }
 
-static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
+static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
 {
     QemuRect vis_src, vis_dst;
     unsigned int x, y, i, j, bypp = ctx->bpp / 8;
+    const uint8_t *vram_end = ctx->vga->vram_ptr + ctx->vga->vram_size;
 
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -167,9 +167,8 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         return false;
     }
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
-        ctx->dst_bits >= ctx->vram_end - bypp ||
-        ctx->dst_bits + ctx->dst.x * bypp + (ctx->dst.y + ctx->dst.height) *
-        ctx->dst_stride >= ctx->vram_end - bypp) {
+        ctx->dst_bits >= vram_end - bypp || ctx->dst_bits + ctx->dst.x * bypp +
+        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= vram_end - bypp) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
     }
@@ -206,9 +205,9 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
         if (!ctx->host_data_active &&
             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
-            ctx->src_bits >= ctx->vram_end - bypp ||
+            ctx->src_bits >= vram_end - bypp ||
             ctx->src_bits + vis_src.x * bypp + (vis_src.y + vis_dst.height) *
-            ctx->src_stride >= ctx->vram_end - bypp)) {
+            ctx->src_stride >= vram_end - bypp)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
@@ -275,6 +274,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
     case ROP3_BLACKNESS:
     case ROP3_WHITENESS:
     {
+        const uint8_t *palette = ctx->vga->palette;
         uint32_t filler = 0;
 
         if (ctx->bpp == 24) {
@@ -286,14 +286,12 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             filler = make_filler(ctx->bpp, ctx->frgd_clr);
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[0],
-                                                   ctx->palette[1],
-                                                   ctx->palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0], palette[1],
+                                                   palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[3],
-                                                   ctx->palette[4],
-                                                   ctx->palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3], palette[4],
+                                                   palette[5]);
             break;
         }
         DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
@@ -347,7 +345,7 @@ void ati_2d_blt(ATIVGAState *s)
     }
     setup_2d_blt_ctx(s, &ctx);
     if (ati_2d_do_blt(&ctx, s->use_pixman)) {
-        ati_set_dirty(&s->vga, &ctx);
+        ati_set_dirty(&ctx);
     }
 }
 
@@ -441,7 +439,7 @@ bool ati_host_data_flush(ATIVGAState *s)
         DPRINTF("blt %dpx span @ row: %d, col: %d to dst (%d,%d)\n",
                 pix_in_scanline, row, col, chunk.dst.x, chunk.dst.y);
         if (ati_2d_do_blt(&chunk, s->use_pixman)) {
-            ati_set_dirty(&s->vga, &chunk);
+            ati_set_dirty(&chunk);
         }
         idx += pix_in_scanline;
         col += pix_in_scanline;
-- 
2.41.3


