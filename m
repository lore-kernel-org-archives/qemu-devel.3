Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE30DEA854A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPjL-0005or-4Q; Sun, 08 Mar 2026 21:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiw-0005lN-7C
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiq-0001HO-8A
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:47:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 66D5D5969E8;
 Mon, 09 Mar 2026 02:47:47 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id RWK0C-Lt52wF; Mon,  9 Mar 2026 02:47:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5AF0E5969EB; Mon, 09 Mar 2026 02:47:45 +0100 (CET)
Message-ID: <2c7f8fdc527e8c5bad237933a1c8a7a8e5068a3d.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 2/9] ati-vga: Use local variables for register values in
 ati_2d_blt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:45 +0100 (CET)
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

ati_2d_blt uses a mixture of locals and direct register access of needed
state. This assigns all values derived from register state to local
variables. It prepares the function for a larger refactor that removes
the dependency on the full device and direct register access entirely.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 92 +++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 8a7dcdf6e9..b9cd766130 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -65,10 +65,18 @@ void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+    uint32_t rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    bool left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
+    bool top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
+    uint32_t frgd_clr = s->regs.dp_brush_frgd_clr;
+    uint8_t *palette = s->vga.palette;
+    unsigned dst_offset = s->regs.dst_offset;
+    unsigned dst_width = s->regs.dst_width;
+    unsigned dst_height = s->regs.dst_height;
+    unsigned dst_x = (left_to_right ?
+                     s->regs.dst_x : s->regs.dst_x + 1 - dst_width);
+    unsigned dst_y = (top_to_bottom ?
+                     s->regs.dst_y : s->regs.dst_y + 1 - dst_height);
     int bpp = ati_bpp_from_datatype(s);
     if (!bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -79,7 +87,7 @@ void ati_2d_blt(ATIVGAState *s)
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
+    uint8_t *dst_bits = s->vga.vram_ptr + dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
@@ -87,26 +95,25 @@ void ati_2d_blt(ATIVGAState *s)
     }
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
-        || dst_bits + dst_x
-         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
+        || dst_bits + dst_x + (dst_y + dst_height) * dst_stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-            s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
-            s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
+            s->regs.src_offset, dst_offset, s->regs.default_offset,
+            s->regs.src_pitch, dst_stride, s->regs.default_pitch,
             s->regs.src_x, s->regs.src_y, dst_x, dst_y,
-            s->regs.dst_width, s->regs.dst_height,
-            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
-            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
-    switch (s->regs.dp_mix & GMC_ROP3_MASK) {
+            dst_width, dst_height,
+            (left_to_right ? '>' : '<'),
+            (top_to_bottom ? 'v' : '^'));
+    switch (rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
-        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
-        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
+        unsigned src_x = (left_to_right ?
+                         s->regs.src_x : s->regs.src_x + 1 - dst_width);
+        unsigned src_y = (top_to_bottom ?
+                         s->regs.src_y : s->regs.src_y + 1 - dst_height);
         int src_stride = s->regs.src_pitch;
         if (!src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
@@ -120,7 +127,7 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + s->regs.dst_height) * src_stride >= end) {
+             + (src_y + dst_height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -128,32 +135,30 @@ void ati_2d_blt(ATIVGAState *s)
         DPRINTF("pixman_blt(%p, %p, %ld, %ld, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src_bits, dst_bits, src_stride / sizeof(uint32_t),
                 dst_stride / sizeof(uint32_t), bpp, bpp, src_x, src_y, dst_x,
-                dst_y, s->regs.dst_width, s->regs.dst_height);
+                dst_y, dst_width, dst_height);
 #ifdef CONFIG_PIXMAN
         int src_stride_words = src_stride / sizeof(uint32_t);
         int dst_stride_words = dst_stride / sizeof(uint32_t);
-        if ((s->use_pixman & BIT(1)) &&
-            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
-            s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
+        if ((s->use_pixman & BIT(1)) && left_to_right && top_to_bottom) {
             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
                                    src_stride_words, dst_stride_words, bpp, bpp,
                                    src_x, src_y, dst_x, dst_y,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   dst_width, dst_height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
-            int llb = s->regs.dst_width * (bpp / 8);
+            int llb = dst_width * (bpp / 8);
             int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
-                                     s->regs.dst_height);
+                                     dst_height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
                                    src_stride_words, tmp_stride_words, bpp, bpp,
                                    src_x, src_y, 0, 0,
-                                   s->regs.dst_width, s->regs.dst_height);
+                                   dst_width, dst_height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
                                        tmp_stride_words, dst_stride_words,
                                        bpp, bpp, 0, 0, dst_x, dst_y,
-                                       s->regs.dst_width, s->regs.dst_height);
+                                       dst_width, dst_height);
             }
             g_free(tmp);
         } else
@@ -163,17 +168,17 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = bpp / 8;
-            for (y = 0; y < s->regs.dst_height; y++) {
+            for (y = 0; y < dst_height; y++) {
                 i = dst_x * bypp;
                 j = src_x * bypp;
-                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
+                if (top_to_bottom) {
                     i += (dst_y + y) * dst_stride;
                     j += (src_y + y) * src_stride;
                 } else {
-                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_stride;
-                    j += (src_y + s->regs.dst_height - 1 - y) * src_stride;
+                    i += (dst_y + dst_height - 1 - y) * dst_stride;
+                    j += (src_y + dst_height - 1 - y) * src_stride;
                 }
-                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
+                memmove(&dst_bits[i], &src_bits[j], dst_width * bypp);
             }
         }
         break;
@@ -184,35 +189,34 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint32_t filler = 0;
 
-        switch (s->regs.dp_mix & GMC_ROP3_MASK) {
+        switch (rop3) {
         case ROP3_PATCOPY:
-            filler = s->regs.dp_brush_frgd_clr;
+            filler = frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[0],
-                     s->vga.palette[1], s->vga.palette[2]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[0], palette[1],
+                                                   palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[3],
-                     s->vga.palette[4], s->vga.palette[5]);
+            filler = 0xffUL << 24 | rgb_to_pixel32(palette[3], palette[4],
+                                                   palette[5]);
             break;
         }
 
         DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
                 dst_bits, dst_stride / sizeof(uint32_t), bpp, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height, filler);
+                dst_width, dst_height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
             !pixman_fill((uint32_t *)dst_bits, dst_stride / sizeof(uint32_t),
-                         bpp, dst_x, dst_y, s->regs.dst_width,
-                         s->regs.dst_height, filler))
+                         bpp, dst_x, dst_y, dst_width, dst_height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = bpp / 8;
-            for (y = 0; y < s->regs.dst_height; y++) {
+            for (y = 0; y < dst_height; y++) {
                 i = dst_x * bypp + (dst_y + y) * dst_stride;
-                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
+                for (x = 0; x < dst_width; x++, i += bypp) {
                     stn_he_p(&dst_bits[i], bypp, filler);
                 }
             }
@@ -221,7 +225,7 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+                      rop3 >> 16);
         return;
     }
 
-- 
2.41.3


