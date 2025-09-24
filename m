Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A224CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JnQ-0005e5-FI; Wed, 24 Sep 2025 03:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1JnN-0005bP-NA
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:09 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1JnJ-0003RG-NO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=OZO8hLRD1il0/T6biuW8RyclBm1fgAOzTgPsI/lBN/U=; b=iytIu81qpqAQpS/
 SLRkl//jyRedQlHsNIgLabNM3SJ91IBHZ5/LG+xBHNt0NdNprjN/3cRi/AwjSNIZhoTeFD1RODlko
 9eGmsXMnOtQexs+/LLF0+1S36lgYWBRT4diZoQ4QpcaxzcO01aUcrlfMt4taxgHiXj4XCukSLA3Gg
 Bk=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 18/34] target/riscv: Fix size of ssp
Date: Wed, 24 Sep 2025 09:21:08 +0200
Message-ID: <20250924072124.6493-19-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As ssp holds a pointer, fix to 64 bits in size and make sure stores from
TCG use the correct size to avoid problems on big endian hosts.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h                            |  2 +-
 target/riscv/machine.c                        |  2 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 18 +++++++++++++-----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ffc2c1b424..1c544bc260 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -255,7 +255,7 @@ struct CPUArchState {
     /* elp state for zicfilp extension */
     bool      elp;
     /* shadow stack register for zicfiss extension */
-    target_ulong ssp;
+    uint64_t ssp;
     /* env place holder for extra word 2 during unwind */
     target_ulong excp_uw2;
     /* sw check code for sw check exception */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 9a2fd3267d..b95d432e0e 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -393,7 +393,7 @@ static const VMStateDescription vmstate_ssp = {
     .minimum_version_id = 1,
     .needed = ssp_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.ssp, RISCVCPU),
+        VMSTATE_UINT64(env.ssp, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index b0096adcd0..4333854979 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -32,7 +32,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
-    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(addr, wide_addr);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
@@ -44,7 +46,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
     tcg_gen_addi_tl(addr, addr, tmp);
-    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ext_tl_i64(wide_addr, addr);
+    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
 
     return true;
 }
@@ -58,12 +61,15 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
     TCGv addr = tcg_temp_new();
     int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(addr, wide_addr);
     tcg_gen_addi_tl(addr, addr, tmp);
     tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
-    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ext_tl_i64(wide_addr, addr);
+    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
 
     return true;
 }
@@ -75,7 +81,9 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
-    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(dest, wide_addr);
     gen_set_gpr(ctx, a->rd, dest);
 
     return true;
-- 
2.51.0


