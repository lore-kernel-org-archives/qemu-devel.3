Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C970AEA8549
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPjN-0005p3-48; Sun, 08 Mar 2026 21:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiw-0005lL-6U
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiq-0001HM-9g
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:47:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 801E15969ED;
 Mon, 09 Mar 2026 02:47:46 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 7_kKrN1MRwWp; Mon,  9 Mar 2026 02:47:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4A7135969E8; Mon, 09 Mar 2026 02:47:44 +0100 (CET)
Message-ID: <7ab2227b96b73a63cb4fc61d0e6921e01900a4ee.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 1/9] ati-vga: Remove src and dst stride mutation in
 ati_2d_blt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:44 +0100 (CET)
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

Pixman requires stride in words. So over the course of the ati_2d_blt
function both src and dst stride were mutated before being passed to
pixman and then back afterwards.

This creates local variables holding src and dst stride in words
avoiding the potentially confusing mutation.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 48 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 980cdd6ac0..8a7dcdf6e9 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -125,34 +125,34 @@ void ati_2d_blt(ATIVGAState *s)
             return;
         }
 
-        src_stride /= sizeof(uint32_t);
-        dst_stride /= sizeof(uint32_t);
-        DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
-                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
-                src_x, src_y, dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height);
+        DPRINTF("pixman_blt(%p, %p, %ld, %ld, %d, %d, %d, %d, %d, %d, %d, %d)\n",
+                src_bits, dst_bits, src_stride / sizeof(uint32_t),
+                dst_stride / sizeof(uint32_t), bpp, bpp, src_x, src_y, dst_x,
+                dst_y, s->regs.dst_width, s->regs.dst_height);
 #ifdef CONFIG_PIXMAN
+        int src_stride_words = src_stride / sizeof(uint32_t);
+        int dst_stride_words = dst_stride / sizeof(uint32_t);
         if ((s->use_pixman & BIT(1)) &&
             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                                   src_stride, dst_stride, bpp, bpp,
+                                   src_stride_words, dst_stride_words, bpp, bpp,
                                    src_x, src_y, dst_x, dst_y,
                                    s->regs.dst_width, s->regs.dst_height);
         } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
             int llb = s->regs.dst_width * (bpp / 8);
-            int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
-            uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
+            int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
+            uint32_t *tmp = g_malloc(tmp_stride_words * sizeof(uint32_t) *
                                      s->regs.dst_height);
             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
-                                   src_stride, tmp_stride, bpp, bpp,
+                                   src_stride_words, tmp_stride_words, bpp, bpp,
                                    src_x, src_y, 0, 0,
                                    s->regs.dst_width, s->regs.dst_height);
             if (!fallback) {
                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
-                                       tmp_stride, dst_stride, bpp, bpp,
-                                       0, 0, dst_x, dst_y,
+                                       tmp_stride_words, dst_stride_words,
+                                       bpp, bpp, 0, 0, dst_x, dst_y,
                                        s->regs.dst_width, s->regs.dst_height);
             }
             g_free(tmp);
@@ -163,18 +163,15 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (fallback) {
             unsigned int y, i, j, bypp = bpp / 8;
-            unsigned int src_pitch = src_stride * sizeof(uint32_t);
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
-
             for (y = 0; y < s->regs.dst_height; y++) {
                 i = dst_x * bypp;
                 j = src_x * bypp;
                 if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-                    i += (dst_y + y) * dst_pitch;
-                    j += (src_y + y) * src_pitch;
+                    i += (dst_y + y) * dst_stride;
+                    j += (src_y + y) * src_stride;
                 } else {
-                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
-                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
+                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_stride;
+                    j += (src_y + s->regs.dst_height - 1 - y) * src_stride;
                 }
                 memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
             }
@@ -201,21 +198,20 @@ void ati_2d_blt(ATIVGAState *s)
             break;
         }
 
-        dst_stride /= sizeof(uint32_t);
-        DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp, dst_x, dst_y,
+        DPRINTF("pixman_fill(%p, %ld, %d, %d, %d, %d, %d, %x)\n",
+                dst_bits, dst_stride / sizeof(uint32_t), bpp, dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height, filler);
 #ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) ||
-            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height, filler))
+            !pixman_fill((uint32_t *)dst_bits, dst_stride / sizeof(uint32_t),
+                         bpp, dst_x, dst_y, s->regs.dst_width,
+                         s->regs.dst_height, filler))
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = bpp / 8;
-            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
             for (y = 0; y < s->regs.dst_height; y++) {
-                i = dst_x * bypp + (dst_y + y) * dst_pitch;
+                i = dst_x * bypp + (dst_y + y) * dst_stride;
                 for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
                     stn_he_p(&dst_bits[i], bypp, filler);
                 }
-- 
2.41.3


