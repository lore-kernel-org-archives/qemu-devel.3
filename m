Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA49F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcz3-000450-MM; Mon, 09 Mar 2026 11:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyc-0003fa-T4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyb-0000oV-8z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso8799015e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071819; x=1773676619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wXh203y0iWfmEpIZbgI0WGjeGbB3hah+KAK+PVl+7ew=;
 b=Y891bbPMirtCw03tTRtkNGYNUle24gB4Wf2F6LDFGDfR8Q7bt5+OrVz66IVT1Voyuf
 yd4acjDVSuejzfIPHbAESoOl4CDmUv+5o7E+btMNtUejmJnyA4BKt1wfkpNPYwHHM9cF
 gBF2Ytmft57ZBiR4hLG/sb31s2hG66TNj1Uh7kYHg4G6eo0BSBqGNJxddkgk7LqX7yi7
 mFtBtMlw802oC/RaYmFptplQ3igkl+93UQTjY3x/HYtd66miAm07BF0Z4u9V+u83x9DA
 VkF5KcTCNose1llrZr3vLkLvD1tCsux3ylTjCvto/aErY7OagQjwIDjnypwLvr6kkzBz
 dNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071819; x=1773676619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wXh203y0iWfmEpIZbgI0WGjeGbB3hah+KAK+PVl+7ew=;
 b=xNCk+7uY88qijOopEPP6SUerjgxCp+zV7xuqAirhlqecP19LQqwRWZ9YDy49cuNL1j
 hjt0NkOeocKyG86cggKR5YzWytbo6L6q6Iiy93BCERDUzxWAfWCxpbGaS71QE6KWL+We
 JZD77iuX8GJIUrC7vh2hBipDEs9kDXGjvA2322xM/Ier1XLig3CedOs7r6uEdbUKQzH/
 /VvhWB8lc1U/EqlFWG7X1YE3BC06U3b7yPnDDgG6V+GMeXCx6K03rqxHLelV0jCyYEKV
 4MQDFY8VshhOmR0ICDO5jj2jOHThiu+s/Xa+LwLwXT8BGZml0DaR5EOqF+ZhS4wfhTla
 t4dg==
X-Gm-Message-State: AOJu0YyVnu51oqkvtXxLAEqBUpVCMeHVBghgRG9AK9msteDbyhUGf1Kl
 6RQ5kEJEFJPo2AGASS+f47GWK7/VoN7hCYR21YxyMGsnhhjSwVu0YXQiaLOkAOPYbKyfer59nGq
 qtVjvbo4=
X-Gm-Gg: ATEYQzyoFId4xEBKYAXO+ybgxpCYrqMvy3sRzyJsGgzcJUyKH66QDAVx3tyCt8ZQzFr
 S3Osfo0xY1E9SPxAS08cNBBQQhD7/2lGnwJzqfUoYgbdZ51qTo4DAuF3UUhzvp8PWjhorHcFWyj
 GtCzZXU0MoPRsdibTYSHHlXmSGT3k+QAUatPI5D5XMAj8NwZ7wsWtU8O6gCAq8bSZw1AudjFi+9
 z5cn/QdUlNnMABQCqIhYefH1soodSgxYIcT8ChC1huq8Fvgxp53vy+DB3SlTL1kubzplIexZeBN
 Wyo422BsbDU9rg4DLKamjZ04HdRaNWIum+xPOk/rbFIq3D0D1Aw2pmNPrIC0KzGwkClUFyrMCls
 iorNwJo2UQwU8WZzZS+GF7UGp/xcfK30XW+Zh4SDpFBwQgd5GJ3m3zun/BFoMz1/Bzlo99uv5os
 bN4TMa7mlRNbqO6jeJcLDlNIyFqtKZEo+FUyJv32RZYp/GiMUCxKX0HCKp4fHo49sMiDnGlv+H
X-Received: by 2002:a05:600c:529a:b0:485:365f:b4e7 with SMTP id
 5b1f17b1804b1-485365fb814mr87433285e9.14.1773071818851; 
 Mon, 09 Mar 2026 08:56:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48533d6151esm51193065e9.10.2026.03.09.08.56.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/49] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
Date: Mon,  9 Mar 2026 16:52:11 +0100
Message-ID: <20260309155219.62400-42-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

This completes the decoupling from the ATIVGAState struct.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <6e3545dea9f4522e07e91f9db885a7d74dae781a.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index aa2e540a510..be940d8ab6b 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,7 +123,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-static bool ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
+static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -164,14 +164,14 @@ static bool ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
 #ifdef CONFIG_PIXMAN
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
         int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
-        if ((s->use_pixman & BIT(1)) &&
+        if ((use_pixman & BIT(1)) &&
             ctx->left_to_right && ctx->top_to_bottom) {
             fallback = !pixman_blt((uint32_t *)ctx->src_bits,
                                    (uint32_t *)ctx->dst_bits, src_stride_words,
                                    dst_stride_words, ctx->bpp, ctx->bpp,
                                    ctx->src.x, ctx->src.y, ctx->dst.x,
                                    ctx->dst.y, ctx->dst.width, ctx->dst.height);
-        } else if (s->use_pixman & BIT(1)) {
+        } else if (use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
             int llb = ctx->dst.width * (ctx->bpp / 8);
             int tmp_stride_words = DIV_ROUND_UP(llb, sizeof(uint32_t));
@@ -241,7 +241,7 @@ static bool ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
                 ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height,
                 filler);
 #ifdef CONFIG_PIXMAN
-        if (!(s->use_pixman & BIT(0)) ||
+        if (!(use_pixman & BIT(0)) ||
             !pixman_fill((uint32_t *)ctx->dst_bits,
                          ctx->dst_stride / sizeof(uint32_t), ctx->bpp,
                          ctx->dst.x, ctx->dst.y,
@@ -272,7 +272,7 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    if (ati_2d_do_blt(s, &ctx)) {
+    if (ati_2d_do_blt(&ctx, s->use_pixman)) {
         ati_set_dirty(&s->vga, &ctx);
     }
 }
-- 
2.53.0


