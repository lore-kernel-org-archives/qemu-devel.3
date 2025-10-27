Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7894CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRmN-0004nL-HQ; Mon, 27 Oct 2025 14:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRm8-0004i7-Nj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRly-0003zg-1W
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=JTclVRBMtgGwr1WRYJzVLDg5Lk0+x88TQC1Cio9tuf4=; b=LS6/Mdzc7x7R5gq
 Q/mDocp/vUCR8ja/rK3iUL6RRceHg0ChTMHXTFesUNH7JRxQLHJ3xFfMHk0B/2mWTSayPRVO3ie12
 RoNTvrzSBpSx52t3yOhQZ4QQd9EelZBo8doy1EDzMV8UAvgnERUFOuNWRVGI/sO8DA1gYxJ7x6wB7
 F0=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 17/33] target/riscv: Fix size of ssp
Date: Mon, 27 Oct 2025 19:18:14 +0100
Message-ID: <20251027181831.27016-18-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
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

Note, the cpu/ssp VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                            |  2 +-
 target/riscv/machine.c                        |  6 +++---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 18 +++++++++++++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7c54a08eb4..1e4128128b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -256,7 +256,7 @@ struct CPUArchState {
     /* elp state for zicfilp extension */
     bool      elp;
     /* shadow stack register for zicfiss extension */
-    target_ulong ssp;
+    uint64_t ssp;
     /* env place holder for extra word 2 during unwind */
     target_ulong excp_uw2;
     /* sw check code for sw check exception */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1cf744c5f0..c55794c554 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -390,11 +390,11 @@ static bool ssp_needed(void *opaque)
 
 static const VMStateDescription vmstate_ssp = {
     .name = "cpu/ssp",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = ssp_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.ssp, RISCVCPU),
+        VMSTATE_UINT64(env.ssp, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 0b6ad57965..40e5a1b7df 100644
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
@@ -45,7 +47,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
     tcg_gen_addi_tl(addr, addr, tmp);
-    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ext_tl_i64(wide_addr, addr);
+    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
 
     return true;
 }
@@ -59,12 +62,15 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
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
@@ -76,7 +82,9 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
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


