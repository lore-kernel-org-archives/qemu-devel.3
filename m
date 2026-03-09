Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8DBEA852F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPjM-0005ov-Fc; Sun, 08 Mar 2026 21:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiw-0005lO-7J
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiq-0001HV-82
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:47:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7C4E25969EF;
 Mon, 09 Mar 2026 02:47:48 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id A3IAE80Q8XuP; Mon,  9 Mar 2026 02:47:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 657D55969EC; Mon, 09 Mar 2026 02:47:46 +0100 (CET)
Message-ID: <b6279657ab59821c2714af643df427ab6e84374f.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 3/9] ati-vga: Introduce ATI2DCtx struct for 2D blit context
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:46 +0100 (CET)
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

From: Chad Jablonski <chad@jablonski.xyz>

Previously all state derived from registers was moved to locals. Now we
can mechanically replace those locals with fields on the new ATI2DCtx
struct.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 226 +++++++++++++++++++++++++-------------------
 1 file changed, 131 insertions(+), 95 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index b9cd766130..9e0115c49d 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "ui/pixel_ops.h"
 #include "ui/console.h"
+#include "ui/rect.h"
 
 /*
  * NOTE:
@@ -43,21 +44,39 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
-static void ati_set_dirty(ATIVGAState *s,
-                          const uint8_t *dst_bits, unsigned dst_y)
+typedef struct {
+    int bpp;
+    uint32_t rop3;
+    bool left_to_right;
+    bool top_to_bottom;
+    uint32_t frgd_clr;
+    const uint8_t *palette;
+    const uint8_t *vram_end;
+
+    QemuRect dst;
+    int dst_stride;
+    uint8_t *dst_bits;
+    uint32_t dst_offset;
+
+    QemuRect src;
+    int src_stride;
+    const uint8_t *src_bits;
+} ATI2DCtx;
+
+static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
 {
-    VGACommonState *vga = &s->vga;
     DisplaySurface *ds = qemu_console_surface(vga->con);
 
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
             surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
-            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    if (dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
-        dst_bits < vga->vram_ptr + vga->vbe_start_addr +
+            ctx->rop3 >> 16);
+    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
+        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
         vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
         memory_region_set_dirty(&vga->vram, vga->vbe_start_addr +
-                                s->regs.dst_offset + dst_y * surface_stride(ds),
-                                s->regs.dst_height * surface_stride(ds));
+                                ctx->dst_offset + ctx->dst.y
+                                * surface_stride(ds),
+                                ctx->dst.height * surface_stride(ds));
     }
 }
 
@@ -65,100 +84,109 @@ void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    uint32_t rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
-    bool left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
-    bool top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
-    uint32_t frgd_clr = s->regs.dp_brush_frgd_clr;
-    uint8_t *palette = s->vga.palette;
-    unsigned dst_offset = s->regs.dst_offset;
-    unsigned dst_width = s->regs.dst_width;
-    unsigned dst_height = s->regs.dst_height;
-    unsigned dst_x = (left_to_right ?
-                     s->regs.dst_x : s->regs.dst_x + 1 - dst_width);
-    unsigned dst_y = (top_to_bottom ?
-                     s->regs.dst_y : s->regs.dst_y + 1 - dst_height);
-    int bpp = ati_bpp_from_datatype(s);
-    if (!bpp) {
+    ATI2DCtx ctx_;
+    ATI2DCtx *ctx = &ctx_;
+    ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
+    ctx->palette = s->vga.palette;
+    ctx->dst_offset = s->regs.dst_offset;
+    ctx->dst.width = s->regs.dst_width;
+    ctx->dst.height = s->regs.dst_height;
+    ctx->dst.x = (ctx->left_to_right ?
+                 s->regs.dst_x : s->regs.dst_x + 1 - ctx->dst.width);
+    ctx->dst.y = (ctx->top_to_bottom ?
+                 s->regs.dst_y : s->regs.dst_y + 1 - ctx->dst.height);
+    ctx->bpp = ati_bpp_from_datatype(s);
+    if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
     }
-    int dst_stride = s->regs.dst_pitch;
-    if (!dst_stride) {
+    ctx->dst_stride = s->regs.dst_pitch;
+    if (!ctx->dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + dst_offset;
+    ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-        dst_bits += s->regs.crtc_offset & 0x07ffffff;
-        dst_stride *= bpp;
+        ctx->dst_bits += s->regs.crtc_offset & 0x07ffffff;
+        ctx->dst_stride *= ctx->bpp;
     }
-    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x + (dst_y + dst_height) * dst_stride >= end) {
+    ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
+    if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
+        ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
+        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-            s->regs.src_offset, dst_offset, s->regs.default_offset,
-            s->regs.src_pitch, dst_stride, s->regs.default_pitch,
-            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            dst_width, dst_height,
-            (left_to_right ? '>' : '<'),
-            (top_to_bottom ? 'v' : '^'));
-    switch (rop3) {
+            s->regs.src_offset, ctx->dst_offset, s->regs.default_offset,
+            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
+            ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
+            ctx->dst.width, ctx->dst.height,
+            (ctx->left_to_right ? '>' : '<'),
+            (ctx->top_to_bottom ? 'v' : '^'));
+    switch (ctx->rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (left_to_right ?
-                         s->regs.src_x : s->regs.src_x + 1 - dst_width);
-        unsigned src_y = (top_to_bottom ?
-                         s->regs.src_y : s->regs.src_y + 1 - dst_height);
-        int src_stride = s->regs.src_pitch;
-        if (!src_stride) {
+        ctx->src.x = (ctx->left_to_right ?
+                     s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
+        ctx->src.y = (ctx->top_to_bottom ?
+                     s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
+        ctx->src_stride = s->regs.src_pitch;
+        if (!ctx->src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return;
         }
-        uint8_t *src_bits = s->vga.vram_ptr + s->regs.src_offset;
+        ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
 
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= bpp;
+            ctx->src_bits += s->regs.crtc_offset & 0x07ffffff;
+            ctx->src_stride *= ctx->bpp;
         }
-        if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
-            || src_bits + src_x
-             + (src_y + dst_height) * src_stride >= end) {
+        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff ||
+            ctx->src_bits >= ctx->vram_end ||
+            ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height) *
+            ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
 
         DPRINTF("pixman_blt(%p, %p, %ld, %ld, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride / sizeof(uint32_t),
-                dst_stride / sizeof(uint32_t), bpp, bpp, src_x, src_y, dst_x,
-                dst_y, dst_width, dst_height);
+                ctx->src_bits, ctx->dst_bits,
+                ctx->src_stride / sizeof(uint32_t),
+                ctx->dst_stride / sizeof(uint32_t),
+                ctx->bpp, ctx->bpp, ctx->src.x, ctx->src.y, ctx->dst.x,
+                ctx->dst.y, ctx->dst.width, ctx->dst.height);
 #ifdef CONFIG_PIXMAN
-        int src_stride_words = src_stride / sizeof(uint32_t);
-        int dst_stride_words = dst_stride / sizeof(uint32_t);
-        if ((s->use_pixman & BIT(1)) && left_to_right && top_to_bottom) {
-            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride_words, dst_stride_words, bpp, bpp,
-                                   src_x, src_y, dst_x, dst_y,
-                                   dst_width, dst_height);
+        int src_stride_words = ctx->src_stride / sizeof(uint32_t);
+        int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
+        if ((s->use_pixman & BIT(1)) &&
+            ctx->left_to_right && ctx->top_to_bottom) {
+            fallback = !pixman_blt((uint32_t *)ctx->src_bits,
+                                   (uint32_t *)ctx->dst_bits, src_stride_words,
+                                   dst_stride_words, ctx->bpp, ctx->bpp,
+                                   ctx->src.x, ctx->src.y, ctx->dst.x,
+                                   ctx->dst.y, ctx->dst.width, ctx->dst.height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = dst_width * (bpp / 8);
+            int llb = ctx->dst.width * (ctx->bpp / 8);
             int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
-                                     dst_height);
-            fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride_words, tmp_stride_words, bpp, bpp,
-                                   src_x, src_y, 0, 0,
-                                   dst_width, dst_height);
+                                     ctx->dst.height);
+            fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
+                                   src_stride_words, tmp_stride_words, ctx->bpp,
+                                   ctx->bpp, ctx->src.x, ctx->src.y, 0, 0,
+                                   ctx->dst.width, ctx->dst.height);
             if (!fallback) {
-                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
+                fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
                                        tmp_stride_words, dst_stride_words,
-                                       bpp, bpp, 0, 0, dst_x, dst_y,
-                                       dst_width, dst_height);
+                                       ctx->bpp, ctx->bpp, 0, 0,
+                                       ctx->dst.x, ctx->dst.y,
+                                       ctx->dst.width, ctx->dst.height);
             }
             g_free(tmp);
         } else
@@ -167,18 +195,21 @@ void ati_2d_blt(ATIVGAState *s)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = bpp / 8;
-            for (y = 0; y < dst_height; y++) {
-                i = dst_x * bypp;
-                j = src_x * bypp;
-                if (top_to_bottom) {
-                    i += (dst_y + y) * dst_stride;
-                    j += (src_y + y) * src_stride;
+            unsigned int y, i, j, bypp = ctx->bpp / 8;
+            for (y = 0; y < ctx->dst.height; y++) {
+                i = ctx->dst.x * bypp;
+                j = ctx->src.x * bypp;
+                if (ctx->top_to_bottom) {
+                    i += (ctx->dst.y + y) * ctx->dst_stride;
+                    j += (ctx->src.y + y) * ctx->src_stride;
                 } else {
-                    i += (dst_y + dst_height - 1 - y) * dst_stride;
-                    j += (src_y + dst_height - 1 - y) * src_stride;
+                    i += (ctx->dst.y + ctx->dst.height - 1 - y)
+                         * ctx->dst_stride;
+                    j += (ctx->src.y + ctx->dst.height - 1 - y)
+                         * ctx->src_stride;
                 }
-                memmove(&dst_bits[i], &src_bits[j], dst_width * bypp);
+                memmove(&ctx->dst_bits[i], &ctx->src_bits[j],
+                        ctx->dst.width * bypp);
             }
         }
         break;
@@ -189,35 +220,40 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint32_t filler = 0;
 
-        switch (rop3) {
+        switch (ctx->rop3) {
         case ROP3_PATCOPY:
-            filler = frgd_clr;
+            filler = ctx->frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0], palette[1],
-                                                   palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[0],
+                                                   ctx->palette[1],
+                                                   ctx->palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3], palette[4],
-                                                   palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[3],
+                                                   ctx->palette[4],
+                                                   ctx->palette[5]);
             break;
         }
 
         DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride / sizeof(uint32_t), bpp, dst_x, dst_y,
-                dst_width, dst_height, filler);
+                ctx->dst_bits, ctx->dst_stride / sizeof(uint32_t), ctx->bpp,
+                ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height,
+                filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride / sizeof(uint32_t),
-                         bpp, dst_x, dst_y, dst_width, dst_height, filler))
+            !pixman_fill((uint32_t *)ctx->dst_bits,
+                         ctx->dst_stride / sizeof(uint32_t), ctx->bpp,
+                         ctx->dst.x, ctx->dst.y,
+                         ctx->dst.width, ctx->dst.height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = bpp / 8;
-            for (y = 0; y < dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_stride;
-                for (x = 0; x < dst_width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+            unsigned int x, y, i, bypp = ctx->bpp / 8;
+            for (y = 0; y < ctx->dst.height; y++) {
+                i = ctx->dst.x * bypp + (ctx->dst.y + y) * ctx->dst_stride;
+                for (x = 0; x < ctx->dst.width; x++, i += bypp) {
+                    stn_he_p(&ctx->dst_bits[i], bypp, filler);
                 }
             }
         }
@@ -225,9 +261,9 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      rop3 >> 16);
+                      ctx->rop3 >> 16);
         return;
     }
 
-    ati_set_dirty(s, dst_bits, dst_y);
+    ati_set_dirty(&s->vga, ctx);
 }
-- 
2.41.3


