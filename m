Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD80F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcyi-0003ff-Rh; Mon, 09 Mar 2026 11:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcy6-0002oJ-5e
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcy2-0000kt-Ij
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48374014a77so140993645e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071784; x=1773676584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JtkKw13Vk9HzOzHG7UMYz97Jnsnp+coU48cy74dU8ts=;
 b=VRAK83Wwsmf2Ct3ZS4hkBREzAMZcPYZCuBg7yFqRRNhjrz6XLsrha1rA9AB39xf4hc
 NlS28kjflmYu0ZzEdXQVlrCcW5Dw+Udj/HTmqeFVH45Jo68QQsl/JskEtmfHOoe4GiWe
 kX8VxCoK9G2LExjxhJT5TH1eU55u6R6SsDiXrGiDaT7siCl6z6cHbVsQuKj33CEA9WV+
 RaQniknVIMNztIPSk0x7rjlirOMg+Xx50FZx1TelMGqzsUizyCZfoujDBD5eMyo5Srrx
 IJc+BN2y+AmtlyIn8/BPMSd7xPkr5Pi+sLmL5zpiqC+SGsBlpipDMWAvgFaX76gYsKL1
 6p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071784; x=1773676584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JtkKw13Vk9HzOzHG7UMYz97Jnsnp+coU48cy74dU8ts=;
 b=trEj3QUNylgYDxdkbqFlrjzI8aS+t46e95Izfe97TyfvXvbAd1jkIKNFc3CZy8sP/w
 7SxEtwjbxdikojs3hlRqDMd9gRaAi+XShdf8lznARjqnatUP9Me0w0pAFaBxn1j5TIjK
 750CMxUNYhu/JyhoGZryiWGIPYQeoBQRKZbydLr0K7yVZj9N7srsuzE2NuudmQwwbXUu
 vxM+mEgqr4SV233Qxvar5sTSkUXFxgHqDLjRdGUmtBWLyHbmyJ62AR5DpMnXmggeJZvc
 gANBzXMfUhFg4Ews6FC+96/S3fWeELngHFo54C08Rv+aY+kXoAKttWEt5ENPxIKCx2H5
 eKyw==
X-Gm-Message-State: AOJu0YyqztEc8q066RLdXEvmkYjMdLGROUKS6/lwBooVcCdQQJ+nXwFm
 5YbrUCCg05xc8n+WwDSZEmoJCCtjMvcGzPWsOi6VAUCN7E1Y8dBFcSUsmw51paVvGNZQYib+fEC
 BQ58fMDA=
X-Gm-Gg: ATEYQzwTXOsknCMa0QbssC9iA9Jbi6WCkr63bT6pAwwpcrgu5RNKb6mjULDPmFCoKTW
 QRM2dB3qtA8XQLrVhDdiJVxS7JMbmxoS1cRmUVrwWT5lUQhX/6OXgNDCtQGZAoMFzaOWWeH0yly
 NY2QhkHZarpzBnUWON75WPQ8W3VziQTqECB5YNIeYcla3tf6pyyTZKUzrWSleKv9KjZxZh3NTZk
 gRCUksTBoTg8XhR1ewJYsqw94LBprLdpxvbCeHWfVGZYsEc7R8/57vX46k+7L2Ioca8ZVt2pqYH
 3JNo7q3CVkePW/MMSqfzvUAfb3MF17QFLwDMPS2FgTDZaczPETZP7K+B2QlFINot87Cn41wIP7Y
 iL5cT9aOQUnzykrpAbqSDeRiv/sTNYAa3kliXzgxsuZA0fpA/oUSlT5r31VEHhS5BoKm2sXEtP2
 T3t5yyCdvEbIdSX1Xdeod/6dOYRAML6kCIosw0LBXmSHnNDNcbMAWmnMu65GA7tY7acvjeoipz
X-Received: by 2002:a05:600c:8b88:b0:485:30d4:6b98 with SMTP id
 5b1f17b1804b1-48530d46ef4mr129177685e9.15.1773071784322; 
 Mon, 09 Mar 2026 08:56:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541acea11sm657235e9.7.2026.03.09.08.56.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/49] ati-vga: Remove src and dst stride mutation in ati_2d_blt
Date: Mon,  9 Mar 2026 16:52:06 +0100
Message-ID: <20260309155219.62400-37-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Pixman requires stride in words. So over the course of the ati_2d_blt
function both src and dst stride were mutated before being passed to
pixman and then back afterwards.

This creates local variables holding src and dst stride in words
avoiding the potentially confusing mutation.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <7ab2227b96b73a63cb4fc61d0e6921e01900a4ee.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 48 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 8e192802d3a..a5b475ee18d 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -126,34 +126,34 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -164,18 +164,15 @@ void ati_2d_blt(ATIVGAState *s)
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
@@ -202,21 +199,20 @@ void ati_2d_blt(ATIVGAState *s)
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
2.53.0


