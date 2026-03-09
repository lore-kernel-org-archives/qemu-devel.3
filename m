Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42C2EA852F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPjQ-0005qq-En; Sun, 08 Mar 2026 21:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPj1-0005lz-26
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPiv-0001ID-Vb
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:48:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 83BBE5969EC;
 Mon, 09 Mar 2026 02:47:51 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id OWr6xUq3Kmx9; Mon,  9 Mar 2026 02:47:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 845CF5969EB; Mon, 09 Mar 2026 02:47:49 +0100 (CET)
Message-ID: <6e3545dea9f4522e07e91f9db885a7d74dae781a.1773020351.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773020351.git.balaton@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v12 6/9] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 09 Mar 2026 02:47:49 +0100 (CET)
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

This completes the decoupling from the ATIVGAState struct.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati_2d.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 0475fcb585..1dfad730ba 100644
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
2.41.3


