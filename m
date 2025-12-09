Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D97D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 06:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSr0j-00012T-2i; Tue, 09 Dec 2025 01:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1vSr0g-000119-Dt; Tue, 09 Dec 2025 01:15:42 -0500
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1vSr0e-0005hw-8J; Tue, 09 Dec 2025 01:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
 References; bh=E2bBR21+PBVD619vdFeH9bjzc7LgQKoClRNzt1xkNQY=; b=LqPKx7A3vB54uM
 aEYBjxpzktESl09slW2h+GhKpbzTEsUPQW2Tw18FSoCxXeWrCa1vIp8CECawJ5NbaiM2Y/LcwcsfU
 1cla83fwsPIsA7dK+hZJuqLj31g6UM+4hlrxcEIbXzrPd61NZzF6FSdBXbHixKqXzc7OHet7iR0YS
 smoWrfhRZqQurlmzJ2+aL8iT9edQE6l7njxJZ9NlrpjreiKNeC/njw6vSza/f1bG2Eq5GRr65kTSu
 gaGBWeJztT8oSN5HcnI84L0kWjkdjaqnrzKJ34V7ZQKCmtNxtaozPGNnsZMk0BPDlAqui9CF2JXFG
 Vrnj8UU1ZOPbx3LW8/7w==;
Received: from fs98a57d9c.tkyc007.ap.nuro.jp ([152.165.125.156]
 helo=codethink..)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1vSr0V-008v7E-2v; Tue, 09 Dec 2025 06:15:32 +0000
From: Roan Richmond <roan.richmond@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, alistair23@gmail.com, richard.henderson@linaro.org,
 Roan Richmond <roan.richmond@codethink.co.uk>
Subject: [PATCH v3] Add RISCV Zilsd extension
Date: Tue,  9 Dec 2025 06:14:45 +0000
Message-ID: <20251209061510.75080-1-roan.richmond@codethink.co.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=roan.richmond@codethink.co.uk; helo=imap5.colo.codethink.co.uk
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is based on v1.0 of the Zilsd extension [1].
The specification is listed as in the Ratified state [2],
 since Jan 30, 2025.

[1]: https://github.com/riscv/riscv-zilsd
[2]: https://riscv.atlassian.net/wiki/spaces/HOME/pages/16154861/RISC-V+Specs+Under+Development

Reviewed-by: Daniel Henrique barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson  <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
---

v3:
  - Rebased on newest version of master
  - Reworked `gen_store_zilsd`, now using one 64bit store instead of two 32bit
    stores, as per Richard Henderson's suggestions.

 target/riscv/cpu.c                      |  2 +
 target/riscv/cpu_cfg_fields.h.inc       |  1 +
 target/riscv/insn_trans/trans_rvi.c.inc | 62 ++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..6e0d37fb96 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_13_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1247,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
     MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
     MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..8d8e35e4cf 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -41,6 +41,7 @@ BOOL_FIELD(ext_zicond)
 BOOL_FIELD(ext_zihintntl)
 BOOL_FIELD(ext_zihintpause)
 BOOL_FIELD(ext_zihpm)
+BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 54b9b4f241..3a055f4e0d 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -370,6 +370,27 @@ static bool gen_load_tl(DisasContext *ctx, arg_lb *a, MemOp memop)
     return true;
 }
 
+/* Zilsd extension adds load/store double for 32bit arch */
+static bool gen_load_zilsd(DisasContext *ctx, arg_lb *a)
+{
+    TCGv dest_1 = tcg_temp_new();
+    TCGv dest_2 = tcg_temp_new();
+    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
+    TCGv addr_2 = get_address(ctx, a->rs1, a->imm + 4);
+
+    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
+    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);
+
+    /* If destination is x0 then result of the load is discarded */
+    if (a->rd == 0) {
+        return true;
+    }
+
+    gen_set_gpr(ctx, a->rd, dest_1);
+    gen_set_gpr(ctx, a->rd + 1, dest_2);
+    return true;
+}
+
 /* Compute only 64-bit addresses to use the address translation mechanism */
 static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
@@ -409,6 +430,8 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
+    } else if (memop == MO_SQ && get_xl(ctx) == MXL_RV32) {
+        out = gen_load_zilsd(ctx, a);
     } else {
         out = gen_load_tl(ctx, a, memop);
     }
@@ -437,7 +460,10 @@ static bool trans_lw(DisasContext *ctx, arg_lw *a)
 
 static bool trans_ld(DisasContext *ctx, arg_ld *a)
 {
-    REQUIRE_64_OR_128BIT(ctx);
+    /* Check for Zilsd extension if 32bit */
+    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
+        return false;
+    }
     return gen_load(ctx, a, MO_SQ);
 }
 
@@ -482,6 +508,33 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
     return true;
 }
 
+/* Zilsd extension adds load/store double for 32bit arch */
+static bool gen_store_zilsd(DisasContext *ctx, arg_sb *a)
+{
+    TCGv_i64 data = tcg_constant_i64(0);
+    TCGv addr = get_address(ctx, a->rs1, a->imm);
+
+    if (a->rs2 != 0) {
+        TCGv data_1 = get_gpr(ctx, a->rs2, EXT_NONE);
+        TCGv data_2 = get_gpr(ctx, a->rs2 + 1, EXT_NONE);
+        data = tcg_temp_new_i64();
+        /* little-endian memory access assumed for now */
+        tcg_gen_concat_tl_i64(data, data_1, data_2);
+    }
+
+    if (ctx->ztso) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+
+    /*
+     * The spec allows for this op to be non-atomic and made of two 32bit
+     * stores. However, the two stores have been combined into one 64bit store,
+     * thus avoiding the case where only one of these stores succeeds.
+     */
+    tcg_gen_qemu_st_i64(data, addr, ctx->mem_idx, MO_UQ);
+    return true;
+}
+
 static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
     TCGv src1l = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -511,6 +564,8 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
+    } else if (memop == MO_UQ && get_xl(ctx) == MXL_RV32) {
+        return gen_store_zilsd(ctx, a);
     } else {
         return gen_store_tl(ctx, a, memop);
     }
@@ -533,7 +588,10 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
 
 static bool trans_sd(DisasContext *ctx, arg_sd *a)
 {
-    REQUIRE_64_OR_128BIT(ctx);
+    /* Check for Zilsd extension if 32bit */
+    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
+        return false;
+    }
     return gen_store(ctx, a, MO_UQ);
 }
 
-- 
2.43.0


