Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDB6E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkui-0004Qc-J0; Thu, 12 Dec 2024 10:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktn-0003Uu-6b; Thu, 12 Dec 2024 10:14:44 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktb-0003g3-Ph; Thu, 12 Dec 2024 10:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=JiMImyXw6R9EQeL/l3lRffTHPCx4YGc8k16oAVbApi4=; b=USNz/DZXDv/MyeQx19vLFQaVtu
 Ey548ihuSiAiJul/YzkQWOp1x6hQ5p3LnGyi0BeAubfRNZYopbGa3h3iPVI1A34XuAx9UZWHA0bSk
 92ugjLE4XxIs//MmwMWUayGi4jQYE8g0ZH8s5ZDbtVJRXzliDfAsrzlOhMC1YMVihZt6yojNN1A4x
 F0OVhXKcKrQyVVRNuZSXbnIypu2JzFkANegUnwUt/zjbNNMithUUKUZw7i56OMizJFdv07v+JQ6Ff
 Bwifc0bPVTqgmQBN72yzBkbeSg8eew8mLEYKCJhK2OLrvVEPVbzij/9c2kOaKtVUligr7QUFFKwwX
 HSREGa21A+1jkIAe1cU+8hNEGd8SgcII9VC1PuLqDs0lmx/7GHwZhdYoaDiQ+OCEzsZ4tYeKILTG5
 wo8cdzFZ1+xz3d8qveNFFgZ0RTR7srRAS/fP+Hu1M8x5kCgNDKofz2jW88Ojwu7RYUF1jt0/RAltk
 ddXPmnIFbKS95F7ecr+tZxJZB9BZ7MljtPIjwC40NndEVFgeUnBj8rTiffqFcrb90SWrD97A6R5VJ
 rgOQPj2e4coUqZbT89uQJfS4yr0np+Oy95hG6yNWAZd5Wd7Wuk8iTPpm07Mn6qsL4KDwvn9hICKTK
 87+S78cctG5oxM+DGPIAxqiOAJ66Ci+Fgm6rTwWlM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkt0-0008Ue-4E; Thu, 12 Dec 2024 15:13:58 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:03 +0000
Message-Id: <20241212151412.570454-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 02/11] target/ppc: replace tcg_gen_qemu_ld_tl() with
 gen_ld_tl()
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

To ensure that all memory loads are performed by gen_ld_tl(), convert all
remaining users of tcg_gen_qemu_ld_tl() with gen_ld_tl().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c                     | 14 +++++++-------
 target/ppc/translate/fixedpoint-impl.c.inc |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5ddaf69599..5fb0aa36ce 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2675,7 +2675,7 @@ static void glue(gen_, name##epx)(DisasContext *ctx)                          \
     gen_set_access_type(ctx, ACCESS_INT);                                     \
     EA = tcg_temp_new();                                                      \
     gen_addr_reg_index(ctx, EA);                                              \
-    tcg_gen_qemu_ld_tl(cpu_gpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_LOAD, ldop);\
+    gen_ld_tl(ctx, cpu_gpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_LOAD, ldop);    \
 }
 
 GEN_LDEPX(lb, DEF_MEMOP(MO_UB), 0x1F, 0x02)
@@ -2942,7 +2942,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
 
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | MO_ALIGN);
+    gen_ld_tl(ctx, gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve, t0);
     tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
@@ -2966,9 +2966,9 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     TCGv t2 = tcg_temp_new();
     TCGv u = tcg_temp_new();
 
-    tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
+    gen_ld_tl(ctx, t, EA, ctx->mem_idx, memop);
     tcg_gen_addi_tl(t2, EA, memop_size(memop));
-    tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
+    gen_ld_tl(ctx, t2, t2, ctx->mem_idx, memop);
     tcg_gen_addi_tl(u, t, addend);
 
     /* E.g. for fetch and increment bounded... */
@@ -3031,7 +3031,7 @@ static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
 
-            tcg_gen_qemu_ld_tl(t0, EA, ctx->mem_idx, memop);
+            gen_ld_tl(ctx, t0, EA, ctx->mem_idx, memop);
             if ((memop & MO_SIZE) == MO_64 || TARGET_LONG_BITS == 32) {
                 tcg_gen_mov_tl(t1, src);
             } else {
@@ -3138,9 +3138,9 @@ static void gen_st_atomic(DisasContext *ctx, MemOp memop)
             TCGv s2 = tcg_temp_new();
             TCGv ea_plus_s = tcg_temp_new();
 
-            tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
+            gen_ld_tl(ctx, t, EA, ctx->mem_idx, memop);
             tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
-            tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
+            gen_ld_tl(ctx, t2, ea_plus_s, ctx->mem_idx, memop);
             tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
             tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
             tcg_gen_qemu_st_tl(s, EA, ctx->mem_idx, memop);
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index fa0191e866..717e3f122f 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -37,7 +37,7 @@ static bool do_ldst(DisasContext *ctx, int rt, int ra, TCGv displ, bool update,
     if (store) {
         tcg_gen_qemu_st_tl(cpu_gpr[rt], ea, ctx->mem_idx, mop);
     } else {
-        tcg_gen_qemu_ld_tl(cpu_gpr[rt], ea, ctx->mem_idx, mop);
+        gen_ld_tl(ctx, cpu_gpr[rt], ea, ctx->mem_idx, mop);
     }
     if (update) {
         tcg_gen_mov_tl(cpu_gpr[ra], ea);
-- 
2.39.5


