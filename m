Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDC01094480
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3zDe-0006Ca-An; Sat, 21 Mar 2026 12:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDR-00064s-Nl
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:25 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDN-0002DM-Ks
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 11AF3596A4B;
 Sat, 21 Mar 2026 17:30:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id yDXoSygmyMff; Sat, 21 Mar 2026 17:30:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D3615596A4A; Sat, 21 Mar 2026 17:30:11 +0100 (CET)
Message-ID: <759ed5e3b019cce94e9a4ef003f1fc2e0cea2ec1.1774110169.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1774110169.git.balaton@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 1/8] ati-vga: Fix colors when frame buffer endianness does
 not match host
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 21 Mar 2026 17:30:11 +0100 (CET)
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

When writing pixels we have to take into account if the frame buffer
endianness matches the host endianness or we need to swap to correct
endianness. This caused wrong colors e.g. with PPC Linux guest that
uses big endian frame buffer when running on little endian host.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 37fe6c17ee..0cbbdc33f4 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -50,6 +50,7 @@ typedef struct {
     bool host_data_active;
     bool left_to_right;
     bool top_to_bottom;
+    bool need_swap;
     uint32_t frgd_clr;
     const uint8_t *palette;
     const uint8_t *vram_end;
@@ -89,6 +90,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->host_data_active = s->host_data.active;
     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    ctx->need_swap = HOST_BIG_ENDIAN != s->vga.big_endian_fb ? true : false;
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
     ctx->palette = s->vga.palette;
     ctx->dst_offset = s->regs.dst_offset;
@@ -131,6 +133,17 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
+static uint32_t make_filler(int bpp, uint32_t color)
+{
+    if (bpp < 24) {
+        color |= color << 16;
+        if (bpp < 15) {
+            color |= color << 8;
+        }
+    }
+    return color;
+}
+
 static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     QemuRect vis_src, vis_dst;
@@ -255,7 +268,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 
         switch (ctx->rop3) {
         case ROP3_PATCOPY:
-            filler = ctx->frgd_clr;
+            filler = make_filler(ctx->bpp, ctx->frgd_clr);
             break;
         case ROP3_BLACKNESS:
             filler = 0xffUL << 24 | rgb_to_pixel32(ctx->palette[0],
@@ -268,10 +281,12 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
                                                    ctx->palette[5]);
             break;
         }
-
         DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
                 ctx->dst_bits, ctx->dst_stride / sizeof(uint32_t), ctx->bpp,
                 vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height, filler);
+        if (ctx->need_swap) {
+            bswap32s(&filler);
+        }
 #ifdef CONFIG_PIXMAN
         if (!(use_pixman & BIT(0)) ||
             !pixman_fill((uint32_t *)ctx->dst_bits,
@@ -325,11 +340,8 @@ void ati_2d_blt(ATIVGAState *s)
 bool ati_host_data_flush(ATIVGAState *s)
 {
     ATI2DCtx ctx, chunk;
-    uint32_t fg = s->regs.dp_src_frgd_clr;
-    uint32_t bg = s->regs.dp_src_bkgd_clr;
     unsigned bypp, pix_count, row, col, idx;
     uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
-    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
     uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
     uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
 
@@ -360,21 +372,27 @@ bool ati_host_data_flush(ATIVGAState *s)
     }
 
     bypp = ctx.bpp / 8;
-
+    pix_count = ATI_HOST_DATA_ACC_BITS;
     if (src_datatype == SRC_COLOR) {
-        pix_count = ATI_HOST_DATA_ACC_BITS / ctx.bpp;
-        memcpy(pix_buf, &s->host_data.acc[0], sizeof(s->host_data.acc));
+        pix_count /= ctx.bpp;
+        memcpy(pix_buf, s->host_data.acc, sizeof(s->host_data.acc));
     } else {
-        pix_count = ATI_HOST_DATA_ACC_BITS;
         /* Expand monochrome bits to color pixels */
+        uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+        uint32_t fg = make_filler(ctx.bpp, s->regs.dp_src_frgd_clr);
+        uint32_t bg = make_filler(ctx.bpp, s->regs.dp_src_bkgd_clr);
+
+        if (ctx.need_swap) {
+            bswap32s(&fg);
+            bswap32s(&bg);
+        }
         idx = 0;
         for (int word = 0; word < 4; word++) {
             for (int byte = 0; byte < 4; byte++) {
                 uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
                 for (int i = 0; i < 8; i++) {
                     bool is_fg = byte_val & BIT(byte_pix_order ? i : 7 - i);
-                    uint32_t color = is_fg ? fg : bg;
-                    stn_he_p(&pix_buf[idx], bypp, color);
+                    stn_he_p(&pix_buf[idx], bypp, is_fg ? fg : bg);
                     idx += bypp;
                 }
             }
-- 
2.41.3


