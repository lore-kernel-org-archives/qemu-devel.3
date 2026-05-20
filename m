Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B59DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgNb-0004vp-C8; Wed, 20 May 2026 08:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgN5-0004ZN-GC; Wed, 20 May 2026 08:50:04 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgN2-0002cv-4a; Wed, 20 May 2026 08:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Dif4F/JSwsFoirBfR0Og1xVgR07gWDZRmkt3nSiTV88=; b=sZqr8tqokRxWxfk
 N80AVpEITHZ5nHgxkIaElOQPgSZGmejo3m+jUxE1EFY4nNj+oHARim+y7LtaVCFxXWAH74KKNrf/t
 lQHQh4kyLs9jDCGQh7s8frEGnXeBzzxVBO+grwXoAAk501izqjzoCMqaODtEFh5lDz3zgALIQDUFR
 gc=;
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v7 08/27] target/riscv: Fix size of retxh
Date: Wed, 20 May 2026 14:53:46 +0200
Message-ID: <20260520125406.28693-9-anjo@rev.ng>
In-Reply-To: <20260520125406.28693-1-anjo@rev.ng>
References: <20260520125406.28693-1-anjo@rev.ng>
MIME-Version: 1.0
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

128-bit helpers only make sense for MXL_RV128, TARGET_RISCV64,
and TCGv == TCGv_i64, therefore fix retxh to 64 bits.

For the sake of being pedandic, update 128-bit instructions to access
retxh via 64 bit TCG ops, even if they only make sense when TCGv ==
TCGv_i64.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                      |  2 +-
 target/riscv/insn_trans/trans_rvi.c.inc |  8 ++++++--
 target/riscv/insn_trans/trans_rvm.c.inc | 16 ++++++++++++----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index feacf19a5e..5ecae9b339 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -249,7 +249,7 @@ struct CPUArchState {
     uint32_t xl;            /* current xlen */
 
     /* 128-bit helpers upper part return value */
-    target_ulong retxh;
+    uint64_t retxh;
 
     uint64_t jvt;
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 2c82ae41a7..ff450d46f8 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -1030,10 +1030,12 @@ static bool do_csrr_i128(DisasContext *ctx, int rd, int rc)
     TCGv destl = dest_gpr(ctx, rd);
     TCGv desth = dest_gprh(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
+    TCGv_i64 wide_desth = tcg_temp_new_i64();
 
     translator_io_start(&ctx->base);
     gen_helper_csrr_i128(destl, tcg_env, csr);
-    tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(desth, wide_desth);
     gen_set_gpr128(ctx, rd, destl, desth);
     return do_csr_post(ctx);
 }
@@ -1053,10 +1055,12 @@ static bool do_csrrw_i128(DisasContext *ctx, int rd, int rc,
     TCGv destl = dest_gpr(ctx, rd);
     TCGv desth = dest_gprh(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
+    TCGv_i64 wide_desth = tcg_temp_new_i64();
 
     translator_io_start(&ctx->base);
     gen_helper_csrrw_i128(destl, tcg_env, csr, srcl, srch, maskl, maskh);
-    tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(desth, wide_desth);
     gen_set_gpr128(ctx, rd, destl, desth);
     return do_csr_post(ctx);
 }
diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/insn_trans/trans_rvm.c.inc
index 795f0ccf14..0e2da5bed2 100644
--- a/target/riscv/insn_trans/trans_rvm.c.inc
+++ b/target/riscv/insn_trans/trans_rvm.c.inc
@@ -169,8 +169,10 @@ static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
 static void gen_div_i128(TCGv rdl, TCGv rdh,
                          TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_divs_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_div(TCGv ret, TCGv source1, TCGv source2)
@@ -212,8 +214,10 @@ static bool trans_div(DisasContext *ctx, arg_div *a)
 static void gen_divu_i128(TCGv rdl, TCGv rdh,
                           TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_divu_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_divu(TCGv ret, TCGv source1, TCGv source2)
@@ -244,8 +248,10 @@ static bool trans_divu(DisasContext *ctx, arg_divu *a)
 static void gen_rem_i128(TCGv rdl, TCGv rdh,
                          TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_rems_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_rem(TCGv ret, TCGv source1, TCGv source2)
@@ -289,8 +295,10 @@ static bool trans_rem(DisasContext *ctx, arg_rem *a)
 static void gen_remu_i128(TCGv rdl, TCGv rdh,
                           TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_remu_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_remu(TCGv ret, TCGv source1, TCGv source2)
-- 
2.52.0


