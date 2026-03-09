Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DBDF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcyR-0003PY-7n; Mon, 09 Mar 2026 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyB-0002vI-NG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcy9-0000lm-41
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so21332095e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071791; x=1773676591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=23TZl0n+F48uCiWVu1Gf9PEGdFnR308e5jPHPWmn/as=;
 b=YgZ0uo/YTetUxRByRcrB07eY7PM9sahQtAXUsru/mCH1Xo16qJic0ltpOH2kvt5k0Z
 krx42XCzj5OGbM8dUGRNfrxJV9b444eA/Mhz9QaL1ea0NYYeD5sh+oBeUcmC/+ABhysT
 IKNBd8rTsay712gZO9nhnaaOblYQHNMczEgeJOS5ZPiqIZeMLttxDPAgdg1djzCheMST
 62Ihzy0aeMhlUgSOFyHvI0l2c/Cr+yGELYWj/Cqsaxz5Pgq3N2Dr8wxDrZuECzgaS/UF
 Ga79lIkDZ407Z2Ya28M+/8iC3Dg6/5y0roQapzvMBpfHutrwck7ejPnZdaFcA6d6lIMs
 jCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071791; x=1773676591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=23TZl0n+F48uCiWVu1Gf9PEGdFnR308e5jPHPWmn/as=;
 b=ExOVr62FGPiXXbH0WzskvmrUInmoEoafdhAWOp9044ecw2D1AefYYhnQrkxsn7wEjg
 9DL3861QGbp0lnz2FzF46kzXLTmWmpdKdAfDx4ythbmY+MlTBxBj4hGT+UWJV0MvnL4x
 mopqJrzmtbtcV/g6kf+wghPvZniQ6XfQ39XqO6Oyv1AgbWlrjLvzdd6u4V3HERY1rCbe
 NrnqqXPLvJdX97ry8RwWLqd+SLpfximtUqNXNiTpJzaHvxljnJjNN8qBbeaKW4GVXlTF
 HSJQTCRnkITmcXsBI95lwSqqGxjmiYQFu+Et97mkOcikoSKItuXQ5AmwSZJZb1wqtjUW
 VtGg==
X-Gm-Message-State: AOJu0YzDItdiFtwvaZMlY5tZaoPBVH9xmLhI5vM5GXWUFSaFdS9lRYWe
 ZV/BBY6J1fQ0+TzupDJrfg0k8Z6j2/L60xJEFSsacPtWdfTowD+e0gZqU8NfBs7vw50qQ3Av6I/
 jUtm4HXU=
X-Gm-Gg: ATEYQzzZkJ5KkODCaL0/wu36FCVuWqSn7FtG7z+M0PJtpV9WVlG2VTyIe/BLf/fvOA7
 9DPt2w4fY9yAcBNnlmD2zAQXNQAPmZ056oOO02QbwnnT9MuN116xnXuRRM+IQl1Et/ibLCdYcy5
 5DSwV4KeIRS6+jxpqAAJahwAg0vMGHflbHp/Qw4BcQE90n1sIpjBY/IAe5ehy9P2vd7f/A80OUc
 /JtEFsbRORmwlrDcdSC5EI33zz6YW4nat49EgzIIE0AwesqtFKKtZemwOgf/pdoYqYhSWxf90ch
 NKNC7CfFvfnH//qtO46SNES3Go/5EAwQbTvTITxL3SofXI4hEReQlpBndsGYXq4HQdlXkQklgDc
 cEuwn2r7gwFMmJ/ECpKYfgQGYLJ7WkEk1GJfW0VG8mjOrioeNOwR4J/HSqXIG5yUT3CMmYev9YM
 b5SU2zQ+A1fGnXFcxcqLdwUMK2I6KqQ3Ociw5EpBjix4+MtkP4XmG7mDe0Og07KNg9yFTze6iF7
 9cmEj2RjT0=
X-Received: by 2002:a05:600c:3492:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4853e19a14cmr43253335e9.28.1773071791116; 
 Mon, 09 Mar 2026 08:56:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485419b8526sm2161625e9.0.2026.03.09.08.56.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/49] ati-vga: Use local variables for register values in
 ati_2d_blt
Date: Mon,  9 Mar 2026 16:52:07 +0100
Message-ID: <20260309155219.62400-38-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

ati_2d_blt uses a mixture of locals and direct register access of needed
state. This assigns all values derived from register state to local
variables. It prepares the function for a larger refactor that removes
the dependency on the full device and direct register access entirely.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <2c7f8fdc527e8c5bad237933a1c8a7a8e5068a3d.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 92 +++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a5b475ee18d..cdca7518638 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -66,10 +66,18 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -80,7 +88,7 @@ void ati_2d_blt(ATIVGAState *s)
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return;
     }
-    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
+    uint8_t *dst_bits = s->vga.vram_ptr + dst_offset;
 
     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
         dst_bits += s->regs.crtc_offset & 0x07ffffff;
@@ -88,26 +96,25 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -121,7 +128,7 @@ void ati_2d_blt(ATIVGAState *s)
         }
         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
             || src_bits + src_x
-             + (src_y + s->regs.dst_height) * src_stride >= end) {
+             + (src_y + dst_height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -129,32 +136,30 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -164,17 +169,17 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -185,35 +190,34 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -222,7 +226,7 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+                      rop3 >> 16);
         return;
     }
 
-- 
2.53.0


