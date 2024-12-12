Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E0FE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkvJ-0005Uq-7b; Thu, 12 Dec 2024 10:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkuH-0003wi-38; Thu, 12 Dec 2024 10:15:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkuB-0003jP-A7; Thu, 12 Dec 2024 10:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DMGNUjzmKsMvZ/ENfaWJHv64f/zSYMmZ7qFj90kllSk=; b=Yis/fsxi1tHVNHdgW8AG3KYlHm
 OgBFvVXHATUk5V0M9lk9arwMvgSg1O9dRahYGkL7a9SYU1Nd2s5l4lxlTbRhLCSSRIC0pFeofVtRN
 4wDsEPilTuh0dzyX7cIaxkKMLfitnmb/+vc0HuGnHSV5QjM0yU8RXJ8BMnin4/R5o165TYKSujHtJ
 od5VX8PjVnvTi77nnkt286xtFLfdrlERsmtn2XJohk3N5zuIEcRjuqxX9zr7zvbQKibRNywa5N5/n
 9yyYpK03l2flVSAhzjg1SmPYH/QXM/KZ35FPlUvW/vrc82slfNh2RVfSvPfyob0KlIy6XkytZIh4W
 BY+X8lS5Y061jOP/szyQ7bGPEbiTiQ33R8KqZSIFfV13EL21jbP4D1CBaJ3V+NyBBj9sH+Dp2jH96
 Dhr3wfrRwxFOO0nziBLTpH9WROAqqQGRSbWkm3PaAHBu0UmjkGEkFgY45a5HYSdykodvzFzU8Yqrp
 KlSVWWB8K63E1YuNPEFLWFe27vXkk09hG2m2nWm2vZCgYODozp17nVQa7pQle3B/8eJrgWZgEa/PS
 Q1me+JEXOlDxXj6eXbL8+AKhlaAWSVjX9o9nb2U0mmCEI3rRYAvawtBPKXWdOgdq/B+/hAWA0lSmh
 vcBxLYLg0kLj9pZYkMuaTw4f5wqzF+o9uBYEER5ig=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktX-0008Ue-9r; Thu, 12 Dec 2024 15:14:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:10 +0000
Message-Id: <20241212151412.570454-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 09/11] target/ppc: implement address swizzle for
 gen_st_atomic()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The gen_st_atomic() function uses a number of TCG atomic primitives within its
implementation. Update gen_st_atomic() so that it implements the address swizzle
if required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 72 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b549525bb6..fc44e3293a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3208,28 +3208,84 @@ static void gen_st_atomic(DisasContext *ctx, MemOp memop)
     memop |= MO_ALIGN;
     switch (gpr_FC) {
     case 0: /* add and Store */
-        tcg_gen_atomic_add_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_add_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_add_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 1: /* xor and Store */
-        tcg_gen_atomic_xor_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_xor_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_xor_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 2: /* Or and Store */
-        tcg_gen_atomic_or_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_or_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_or_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 3: /* 'and' and Store */
-        tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_and_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 4:  /* Store max unsigned */
-        tcg_gen_atomic_umax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_umax_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_umax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 5:  /* Store max signed */
-        tcg_gen_atomic_smax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_smax_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_smax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 6:  /* Store min unsigned */
-        tcg_gen_atomic_umin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_umin_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_umin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 7:  /* Store min signed */
-        tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_smin_fetch_tl(discard, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 24: /* Store twin  */
         if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-- 
2.39.5


