Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B0F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzczB-0004Li-CN; Mon, 09 Mar 2026 11:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyj-0003kx-Ld
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyh-0000oi-MJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso14240875e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071826; x=1773676626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qW66m+PTUn7D/glxz+scEcXDbtO4oFleggwjTiVmuRQ=;
 b=m/yk0JiSiFYlL5yXojpkbjOpIERsSzwIP0QTSXwDdCBPqyLufnCWNdKPwUyruFPbFF
 u4Kbhr0c0mcQaDEcDqA1eRvjaMoH+OS9JEULY2sIqOeswwW8HpAf0DK8PAN2gBxfCmEO
 C8pUP2zKgQrvSu+qRmkmCresZ0h0p0vVXFrtdgvN6pTJwwAsjeOCeolOeG1grJtEmKjJ
 cDrh9w0awuKwcrrf9A6CpUCIExkLKB6tQIUWHZLc9UDOynLFkdFGl9eryqIrh2G/4nfB
 WCeLu6EgHzjHIlKHyS3oN8KYvxkmJ3C5QgoAt5GHaTI3X5r05yvByboM5eIvmxRo5xGe
 cMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071826; x=1773676626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qW66m+PTUn7D/glxz+scEcXDbtO4oFleggwjTiVmuRQ=;
 b=utfKzHYLOaXGf+2gxVpF8pP9Iaox9CF7eAsKdpS2oHhfO6L8RZ0vjPzrGr/vMt9vye
 wZC2En9GXePW/1TqWXjH19ZLfabCvGbJefA2kQ0SaJVgpeHHjM1BDxwpxcmmNemVlGqN
 LgHbXfv3sQNHV9kfYWnTPDamb98DfSQse+HVnnzKiI3BMcgyQs6Is5eiw9/4zpOVSKBu
 rdBEZkBm0S7SOLohJvPL1qPpReL20klmFwDryLkbeQ197Z1EVIPBLGtEZI//MaqJkTU/
 OvxErvgb/znRQpsbDql99l9c5Rgztw4sGiowMFDOz5QbUm2rDR0mf73M5j4WPJfkwH31
 WGVQ==
X-Gm-Message-State: AOJu0YxzLinNlQ+Q78BdX1ZXVrYE1eDjKjSNeazH2uPJp/MCKb/M/DiD
 FdZD4WfZNINNq/NqWEOnypibeTqhwqRtRw9hf8UrnKiezTd8BOq/yMxrAzFSsxu97Udkq70IEHJ
 SqJbDMwI=
X-Gm-Gg: ATEYQzzK/JopzDviYK/spZtx3P2st8bJPA2qZQqKlpmlazDnOgl0BVGSWXwSXzZBfcU
 ZEyW1ZYqaOA9x/wYRrwBlTSYM9Ymdy6wHxxg2GUt2AionNnLMBUwyct6WxzaB3ksXG0OsFabXnC
 XvM9TwOBwKR1emVVavhY0Lvttgit45i6KjYIp9PG70eiWVtccsT1JsAJF2pxWA+VbzF0DOuD2Pv
 +6WomxGj/odFp0NhkzBZryFBYXISeCxF5M7jxQupahgBHWPEHdEbkfHhSW70qFZ/bEMghgEXdrw
 4NTBOs0FmPZ43J8w/qElfF+FNfgwBwv7Lq3SiVIetn5MQYRSRLMeu0f9zLmDRaepIi7f5Z8Ommd
 o+VJsRNDqcNCk4DOmC5Es/mdFhiz7oIDsUk0ZNqTY1IDM4zVCia7pRFJWikh44mTPEnd/IRrP4i
 GZqN2ZhyLRbVcj15QnTBj3zKlj7CrWuhC5RXlHMyg2AdOcePxCzbr4XMMfxrTYKvouSAB3Imah
X-Received: by 2002:a05:600c:8b83:b0:485:3bcb:8bec with SMTP id
 5b1f17b1804b1-48541a5c1e4mr1629205e9.14.1773071825604; 
 Mon, 09 Mar 2026 08:57:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9d8sm28717166f8f.21.2026.03.09.08.57.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/49] ati-vga: Implement scissor rectangle clipping for 2D
 operations
Date: Mon,  9 Mar 2026 16:52:12 +0100
Message-ID: <20260309155219.62400-43-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Message-ID: <4752dfbe240102c2ffa1f2cdab4c9442d4f0dcfb.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 87 ++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index be940d8ab6b..1cfd350769c 100644
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
2.53.0


