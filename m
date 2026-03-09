Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33883EA8549
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPjK-0005oh-QX; Sun, 08 Mar 2026 21:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPj1-0005m1-Iq
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiy-0001If-Vk
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B1126596AE1;
 Mon, 09 Mar 2026 02:47:54 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 3uikUkAkAPF3; Mon,  9 Mar 2026 02:47:52 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A2C63596ABF; Mon, 09 Mar 2026 02:47:52 +0100 (CET)
Message-ID: <8d0d4b52a16f5564e37bbc88496d7ab8d41477ac.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 9/9] ati-vga: Implement HOST_DATA flush to VRAM
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:52 +0100 (CET)
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

Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
text rendering in X. Supports all datatypes (monochrome frgd/bkgd,
monochrome frgd, and color), however monochrome frgd support is
partial and does not properly handle transparency/leave-alone.

The flush is broken up into two steps. First, if necessary, expansion of the
monochrome bits to the destination color depth. Then the expanded pixels
are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
clips and performs the blit.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      |   6 +-
 hw/display/ati_2d.c   | 132 +++++++++++++++++++++++++++++++++++++++++-
 hw/display/ati_int.h  |   3 +
 hw/display/ati_regs.h |   4 ++
 4 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 16dbb743e1..bb9e0bba28 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1037,11 +1037,9 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         s->host_data.acc[s->host_data.next++] = data;
         if (addr == HOST_DATA_LAST) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA finish not yet implemented\n");
-            s->host_data.next = 0;
+            ati_host_data_finish(s);
         } else if (s->host_data.next >= 4) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
-            s->host_data.next = 0;
+            ati_host_data_flush(s);
         }
         break;
     default:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index d62ad849f3..26ae2f1825 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -47,6 +47,7 @@ static int ati_bpp_from_datatype(const ATIVGAState *s)
 typedef struct {
     int bpp;
     uint32_t rop3;
+    bool host_data_active;
     bool left_to_right;
     bool top_to_bottom;
     uint32_t frgd_clr;
@@ -85,6 +86,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
 {
     ctx->bpp = ati_bpp_from_datatype(s);
     ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    ctx->host_data_active = s->host_data.active;
     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
@@ -178,9 +180,10 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return false;
         }
-        if (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
+        if (!ctx->host_data_active &&
+            (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
             ctx->src_bits >= ctx->vram_end || ctx->src_bits + vis_src.x +
-            (vis_src.y + vis_dst.height) * ctx->src_stride >= ctx->vram_end) {
+            (vis_src.y + vis_dst.height) * ctx->src_stride >= ctx->vram_end)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
@@ -300,8 +303,133 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+
+    /* Finish any active HOST_DATA blits before starting a new blit */
+    ati_host_data_finish(s);
+
+    if (src_source == DP_SRC_HOST || src_source == DP_SRC_HOST_BYTEALIGN) {
+        /* Begin a HOST_DATA blit */
+        s->host_data.active = true;
+        s->host_data.next = 0;
+        s->host_data.col = 0;
+        s->host_data.row = 0;
+        return;
+    }
     setup_2d_blt_ctx(s, &ctx);
     if (ati_2d_do_blt(&ctx, s->use_pixman)) {
         ati_set_dirty(&s->vga, &ctx);
     }
 }
+
+bool ati_host_data_flush(ATIVGAState *s)
+{
+    ATI2DCtx ctx, chunk;
+    uint32_t fg = s->regs.dp_src_frgd_clr;
+    uint32_t bg = s->regs.dp_src_bkgd_clr;
+    unsigned bypp, pix_count, row, col, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
+    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+    uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
+
+    if (!s->host_data.active) {
+        return false;
+    }
+    if (src_source != DP_SRC_HOST) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: unsupported src_source %x\n", src_source);
+        return false;
+    }
+    if (src_datatype != SRC_MONO_FRGD_BKGD && src_datatype != SRC_MONO_FRGD &&
+        src_datatype != SRC_COLOR) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: undefined src_datatype %x\n",
+                      src_datatype);
+        return false;
+    }
+
+    setup_2d_blt_ctx(s, &ctx);
+
+    if (!ctx.left_to_right || !ctx.top_to_bottom) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: unsupported blit direction %c%c\n",
+                      ctx.left_to_right ? '>' : '<',
+                      ctx.top_to_bottom ? 'v' : '^');
+        return false;
+    }
+
+    bypp = ctx.bpp / 8;
+
+    if (src_datatype == SRC_COLOR) {
+        pix_count = ATI_HOST_DATA_ACC_BITS / ctx.bpp;
+        memcpy(pix_buf, &s->host_data.acc[0], sizeof(s->host_data.acc));
+    } else {
+        pix_count = ATI_HOST_DATA_ACC_BITS;
+        /* Expand monochrome bits to color pixels */
+        idx = 0;
+        for (int word = 0; word < 4; word++) {
+            for (int byte = 0; byte < 4; byte++) {
+                uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
+                for (int i = 0; i < 8; i++) {
+                    bool is_fg = byte_val & BIT(byte_pix_order ? i : 7 - i);
+                    uint32_t color = is_fg ? fg : bg;
+                    stn_he_p(&pix_buf[idx], bypp, color);
+                    idx += bypp;
+                }
+            }
+        }
+    }
+
+    /* Copy and then modify blit ctx for use in a chunked blit */
+    chunk = ctx;
+    chunk.src_bits = pix_buf;
+    chunk.src.y = 0;
+    chunk.src_stride = ATI_HOST_DATA_ACC_BITS * bypp;
+
+    /* Blit one scanline chunk at a time */
+    row = s->host_data.row;
+    col = s->host_data.col;
+    idx = 0;
+    DPRINTF("blt %dpx @ row: %d, col: %d\n", pix_count, row, col);
+    while (idx < pix_count && row < ctx.dst.height) {
+        unsigned pix_in_scanline = MIN(pix_count - idx,
+                                       ctx.dst.width - col);
+        chunk.src.x = idx;
+        /* Build a rect for this scanline chunk */
+        chunk.dst.x = ctx.dst.x + col;
+        chunk.dst.y = ctx.dst.y + row;
+        chunk.dst.width = pix_in_scanline;
+        chunk.dst.height = 1;
+        DPRINTF("blt %dpx span @ row: %d, col: %d to dst (%d,%d)\n",
+                pix_in_scanline, row, col, chunk.dst.x, chunk.dst.y);
+        if (ati_2d_do_blt(&chunk, s->use_pixman)) {
+            ati_set_dirty(&s->vga, &chunk);
+        }
+        idx += pix_in_scanline;
+        col += pix_in_scanline;
+        if (col >= ctx.dst.width) {
+            col = 0;
+            row += 1;
+        }
+    }
+
+    /* Track state of the overall blit for use by the next flush */
+    s->host_data.next = 0;
+    s->host_data.row = row;
+    s->host_data.col = col;
+    if (s->host_data.row >= ctx.dst.height) {
+        s->host_data.active = false;
+    }
+
+    return s->host_data.active;
+}
+
+void ati_host_data_finish(ATIVGAState *s)
+{
+    if (ati_host_data_flush(s)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "HOST_DATA blit ended before all data was written\n");
+    }
+    s->host_data.active = false;
+}
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 063efc7bba..21b74511e0 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -33,6 +33,7 @@
 
 #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
 #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
+#define ATI_HOST_DATA_ACC_BITS 128
 
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
@@ -128,5 +129,7 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+bool ati_host_data_flush(ATIVGAState *s);
+void ati_host_data_finish(ATIVGAState *s);
 
 #endif /* ATI_INT_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 48f15e9b1d..b813fa119e 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -397,7 +397,11 @@
 #define DST_32BPP                               0x00000006
 #define DP_DST_DATATYPE                         0x0000000f
 #define DP_BRUSH_DATATYPE                       0x00000f00
+#define SRC_MONO_FRGD_BKGD                      0x00000000
+#define SRC_MONO_FRGD                           0x00010000
+#define SRC_COLOR                               0x00030000
 #define DP_SRC_DATATYPE                         0x00030000
+#define DP_BYTE_PIX_ORDER                       0x40000000
 
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
-- 
2.41.3


