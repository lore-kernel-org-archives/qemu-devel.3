Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82217C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 22:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLVnL-0005tS-T0; Sun, 23 Jun 2024 18:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLVnJ-0005su-R6; Sun, 23 Jun 2024 18:34:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLVnH-0002c8-Ft; Sun, 23 Jun 2024 18:34:45 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D81B4E6010;
 Mon, 24 Jun 2024 00:34:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id G64Mrsf7T7Cg; Mon, 24 Jun 2024 00:34:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 166F24E6001; Mon, 24 Jun 2024 00:34:38 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [not for merge PATCH v2] target/ppc/mem_helper.c: Remove a
 conditional from dcbz_common()
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240623223438.166F24E6001@zero.eik.bme.hu>
Date: Mon, 24 Jun 2024 00:34:38 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This is an updated version of this patch as suggested by Richard but
it runs slower and only gets 5.9 seconds instead of 5.83-5.81 with v1
so this is not for merge, only for reference in case it can be useful
for further optimisation or can be fixed in some way.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/helper.h     |  3 +--
 target/ppc/mem_helper.c | 16 +++-------------
 target/ppc/translate.c  | 18 ++++++++----------
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 76b8f25c77..220653c834 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -46,8 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(lsw, void, env, tl, i32, i32)
 DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
-DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
-DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
+DEF_HELPER_FLAGS_4(dcbz, TCG_CALL_NO_WG, void, env, tl, i32, i32)
 DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index f88155ad45..8f0c247df8 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -270,13 +270,13 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
     }
 }
 
-static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        uint32_t opcode, bool epid, uintptr_t retaddr)
+void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode,
+                 uint32_t mmu_idx)
 {
     target_ulong mask, dcbz_size = env->dcache_line_size;
     uint32_t i;
     void *haddr;
-    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, false);
+    uintptr_t retaddr = GETPC();
 
 #if defined(TARGET_PPC64)
     /* Check for dcbz vs dcbzl on 970 */
@@ -307,16 +307,6 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
-{
-    dcbz_common(env, addr, opcode, false, GETPC());
-}
-
-void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
-{
-    dcbz_common(env, addr, opcode, true, GETPC());
-}
-
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
     addr &= ~(env->dcache_line_size - 1);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0bc16d7251..ca172dd664 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4445,27 +4445,25 @@ static void gen_dcblc(DisasContext *ctx)
 /* dcbz */
 static void gen_dcbz(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbz(tcg_env, tcgv_addr, tcgv_op);
+    gen_helper_dcbz(tcg_env, tcgv_addr,
+                    tcg_constant_i32(ctx->opcode & 0x03FF000),
+                    tcg_constant_i32(ctx->mem_idx));
 }
 
 /* dcbzep */
 static void gen_dcbzep(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbzep(tcg_env, tcgv_addr, tcgv_op);
+    gen_helper_dcbz(tcg_env, tcgv_addr,
+                    tcg_constant_i32(ctx->opcode & 0x03FF000),
+                    tcg_constant_i32(PPC_TLB_EPID_STORE));
 }
 
 /* dst / dstt */
-- 
2.30.9


