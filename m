Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CEBCCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJR-0005lj-Jk; Wed, 01 Oct 2025 03:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJQ-0005kj-2V
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:44 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIw-0003WT-1Y
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=q6CUNnGP6tAmyFNexp048FSbVkBYomTwQB5GYSqdOAU=; b=Ln8KUvlLvhrdrrA
 7DDyzpcGOSALJ034yyeyAGiWyCpC8TZdWEK9PYe7OYCUypVstdnFWfoolX7oTrTtZQcoM8XVyLsEl
 wAT/auj12w1YGkc3YCAaoieCdXaCBxz/OoA2aM+wccUyWTy2nPmnn0TCGDcK8fSAPQ2vdIre4++fY
 eo=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 19/33] target/riscv: Fix size of sw_check_code
Date: Wed,  1 Oct 2025 09:32:52 +0200
Message-ID: <20251001073306.28573-20-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The field only holds values of 2 and 3, fix its size to 8 bits and
update stores from TCG.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h                            | 2 +-
 target/riscv/translate.c                      | 4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc       | 8 ++++----
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c98e8c833..586b8731b2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -259,7 +259,7 @@ struct CPUArchState {
     /* env place holder for extra word 2 during unwind */
     uint64_t excp_uw2;
     /* sw check code for sw check exception */
-    target_ulong sw_check_code;
+    uint8_t sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 10d39fd42a..5c42271c30 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1361,8 +1361,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (ctx->fcfi_lp_expected) {
         /* Emit after insn_start, i.e. before the op following insn_start. */
         tcg_ctx->emit_before_op = QTAILQ_NEXT(ctx->base.insn_start, link);
-        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                        tcg_env, offsetof(CPURISCVState, sw_check_code));
         gen_helper_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         tcg_ctx->emit_before_op = NULL;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 9c8c04b2dc..5efdd95f97 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -53,8 +53,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
         /*
          * misaligned, according to spec we should raise sw check exception
          */
-        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                        tcg_env, offsetof(CPURISCVState, sw_check_code));
         gen_helper_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         return true;
@@ -66,8 +66,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
         TCGv tmp = tcg_temp_new();
         tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
         tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
-        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
-                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                        tcg_env, offsetof(CPURISCVState, sw_check_code));
         gen_helper_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         gen_set_label(skip);
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 4333854979..0827c97e31 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -40,8 +40,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
                        mxl_memop(ctx) | MO_ALIGN);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
-    tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
-                  tcg_env, offsetof(CPURISCVState, sw_check_code));
+    tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
+                    tcg_env, offsetof(CPURISCVState, sw_check_code));
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.51.0


