Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBE5CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwqt-0007NQ-C1; Fri, 15 May 2026 14:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqK-0007KC-6o
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqI-0001LD-7f
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=7hi7AA2XG2gxm40r8AsLerPje+OKDOjMMceoyaEuUL8=; b=GrmSbBK580Rr9Hd
 /5zHBxv9c/YF9fN1oosOnhxwyEPzRiB9IB82u6o/YVaY8ONwlPByHd4YcfDNHIYV/Y+PggwOxk4SF
 V4BsYeCzbD9rU0yjJ7lk7PQkX75Aq9j1St8O/y3cK9f/SibolorNkYHspRGW8ZF+hbL9EW+Kfo6Ou
 DI=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 11/27] target/riscv: Fix size of sw_check_code
Date: Fri, 15 May 2026 20:04:21 +0200
Message-ID: <20260515180437.23620-12-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The field only holds values of 2 and 3, fix its size to 8 bits and
update stores from TCG.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                            | 2 +-
 target/riscv/translate.c                      | 4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc       | 8 ++++----
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f4fcf65500..31eda139c6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -260,7 +260,7 @@ struct CPUArchState {
     /* env place holder for extra word 2 during unwind */
     uint64_t excp_uw2;
     /* sw check code for sw check exception */
-    target_ulong sw_check_code;
+    uint8_t sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9a0fd700d2..6a1ae92e5a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1400,8 +1400,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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
index ff450d46f8..fea05d02cc 100644
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
index 40e5a1b7df..cb9c5419fa 100644
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
     gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
-- 
2.52.0


