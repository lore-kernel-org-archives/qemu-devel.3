Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB191094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3zDd-0006Bp-DR; Sat, 21 Mar 2026 12:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDY-0006AN-I1
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDT-0002FD-Mj
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 33E6B596E00;
 Sat, 21 Mar 2026 17:30:20 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Ei06dmYZsxzs; Sat, 21 Mar 2026 17:30:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 35DAD596E02; Sat, 21 Mar 2026 17:30:18 +0100 (CET)
Message-ID: <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1774110169.git.balaton@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 7/8] ati-vga: Simplify pointer image handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 21 Mar 2026 17:30:18 +0100 (CET)
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

Rewrite reading of mouse pointer image. I am not sure this is entirely
correct but appears to work at least on little endian host with PPC
guests using little or big endian frame buffer (MorphOS and MacOS) but
still produces broken pointer image with Linux where I am not sure if
it is a guest driver bug or still missing something.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 53 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index fba73a9956..e1616dc3b3 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -142,27 +142,24 @@ static void ati_vga_switch_mode(ATIVGAState *s)
 /* Used by host side hardware cursor */
 static void ati_cursor_define(ATIVGAState *s)
 {
-    uint8_t data[1024];
+    uint64_t data[128];
     uint32_t srcoff;
-    int i, j, idx = 0;
 
     if ((s->regs.cur_offset & BIT(31)) || s->cursor_guest_mode) {
         return; /* Do not update cursor if locked or rendered by guest */
     }
     /* FIXME handle cur_hv_offs correctly */
-    srcoff = s->regs.cur_offset -
-        (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
-    for (i = 0; i < 64; i++) {
-        for (j = 0; j < 8; j++, idx++) {
-            data[idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j);
-            data[512 + idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j + 8);
-        }
+    srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+             (s->regs.cur_hv_offs & 0xffff) * 16;
+    for (int i = 0; i < 64; i++, srcoff += 16) {
+        data[i] = ldq_le_p(&s->vga.vram_ptr[srcoff]);
+        data[i + 64] = ldq_le_p(&s->vga.vram_ptr[srcoff + 8]);
     }
     if (!s->cursor) {
         s->cursor = cursor_alloc(64, 64);
     }
     cursor_set_mono(s->cursor, s->regs.cur_color1, s->regs.cur_color0,
-                    &data[512], 1, &data[0]);
+                    (uint8_t *)&data[64], 1, (uint8_t *)&data[0]);
     dpy_cursor_define(s->vga.con, s->cursor);
 }
 
@@ -197,9 +194,9 @@ static void ati_cursor_invalidate(VGACommonState *vga)
 static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
 {
     ATIVGAState *s = container_of(vga, ATIVGAState, vga);
-    uint32_t srcoff;
+    uint32_t h, srcoff, color;
+    uint64_t abits, xbits, mask;
     uint32_t *dp = (uint32_t *)d;
-    int i, j, h, idx = 0;
 
     if (!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN) ||
         scr_y < vga->hw_cursor_y || scr_y >= vga->hw_cursor_y + 64 ||
@@ -210,26 +207,24 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
     dp = &dp[vga->hw_cursor_x];
     h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
-    for (i = 0; i < 8; i++) {
-        uint32_t color;
-        uint8_t abits = vga_read_byte(vga, srcoff + i);
-        uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
-        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
-            if (vga->hw_cursor_x + idx >= h) {
-                return; /* end of screen, don't span to next line */
-            }
-            if (abits & BIT(7)) {
-                if (xbits & BIT(7)) {
-                    color = dp[idx] ^ 0xffffffff; /* complement */
-                } else {
-                    continue; /* transparent, no change */
-                }
+    abits = ldq_be_p(&vga->vram_ptr[srcoff]);
+    xbits = ldq_be_p(&vga->vram_ptr[srcoff + 8]);
+    mask = BIT(63);
+    for (int i = 0; i < 64; i++, mask >>= 1) {
+        if (vga->hw_cursor_x + i >= h) {
+            return; /* end of screen, don't span to next line */
+        }
+        if (abits & mask) {
+            if (xbits & mask) {
+                color = dp[i] ^ 0xffffffff; /* complement */
             } else {
-                color = (xbits & BIT(7) ? s->regs.cur_color1 :
-                                          s->regs.cur_color0) | 0xff000000;
+                continue; /* transparent, no change */
             }
-            dp[idx] = color;
+        } else {
+            color = (xbits & mask ? s->regs.cur_color1 :
+                                    s->regs.cur_color0) | 0xff000000;
         }
+        dp[i] = color;
     }
 }
 
-- 
2.41.3


