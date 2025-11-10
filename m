Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC4FCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 09:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vINqJ-0000OX-Nb; Mon, 10 Nov 2025 04:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1vINqH-0000LB-35; Mon, 10 Nov 2025 04:05:41 -0500
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1vINqA-0006zk-2C; Mon, 10 Nov 2025 04:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
 References; bh=dg7dAq86B9KtIhI/5FjeoxqaHzeoL+nlQc+9rDlB7vQ=; b=sIHW62MXvxuYC6
 Z6AJj7as+8bs/3LvFpjhAZOdJMyvCwrxpKiA3gAIGzZmxyLhLJnirk1jeO2RInWFD7N94IVpSdK0h
 U5pzQLQY9BFfQhy4OBEGGyAAhnvK3B40II7OOyrUiTySe1PtJbqwleoWxHFdPUAx+ZQ3cAgespKZI
 nUgzw6bF6yRTs896JjcZHiB1r7WNlU03rGNNVp7lQB9EFXZaKd8GA8GYJVtodCvurm0PyRRbdfINv
 jd1n56RHQyr67tI5L/kumxsSF6nTcehO7k6FNp5Ue8CkaoJY2GfoXTOef71AuUYI19/Mtd7vEB/vI
 y2+4sMhCHkrDhpsH7Pyw==;
Received: from [167.98.27.226] (helo=codethink.office.codethink.co.uk)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1vINq1-0017m1-QA; Mon, 10 Nov 2025 09:05:25 +0000
From: Roan Richmond <roan.richmond@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, alistair23@gmail.com, richard.henderson@linaro.org,
 Roan Richmond <roan.richmond@codethink.co.uk>
Subject: [PATCH v2] Add RISCV Zilsd extension
Date: Mon, 10 Nov 2025 09:05:07 +0000
Message-ID: <20251110090510.84103-1-roan.richmond@codethink.co.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=roan.richmond@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
---
v2:
  - In `gen_load_zilsd` swapped `dest_gpr` with `tcg_temp_new`, this prevents
    writing to `r1/r0` in the case where `r0` is the set as `rd`.
  - Removed unneeded brackets around `a->rd` + c expressions

 target/riscv/cpu.c                      |  2 +
 target/riscv/cpu_cfg_fields.h.inc       |  1 +
 target/riscv/insn_trans/trans_rvi.c.inc | 57 ++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 2 deletions(-)

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
index 54b9b4f241..20058bf483 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -18,6 +18,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "migration/multifd.h"
 static bool trans_illegal(DisasContext *ctx, arg_empty *a)
 {
     gen_exception_illegal(ctx);
@@ -370,6 +371,27 @@ static bool gen_load_tl(DisasContext *ctx, arg_lb *a, MemOp memop)
     return true;
 }
 
+/* Zilsd extension adds load/store double for 32bit arch */
+static bool gen_load_zilsd(DisasContext *ctx, arg_lb *a)
+{
+    TCGv dest_1 = tcg_temp_new();
+    TCGv dest_2 = tcg_temp_new();
+    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
+    TCGv addr_2 = get_address(ctx, a->rs1, a->imm+4);
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
+    gen_set_gpr(ctx, a->rd+1, dest_2);
+    return true;
+}
+
 /* Compute only 64-bit addresses to use the address translation mechanism */
 static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
@@ -409,6 +431,8 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
+    } else if (memop == MO_SQ && get_xl(ctx) == MXL_RV32) {
+        out = gen_load_zilsd(ctx, a);
     } else {
         out = gen_load_tl(ctx, a, memop);
     }
@@ -437,7 +461,10 @@ static bool trans_lw(DisasContext *ctx, arg_lw *a)
 
 static bool trans_ld(DisasContext *ctx, arg_ld *a)
 {
-    REQUIRE_64_OR_128BIT(ctx);
+    /* Check for Zilsd extension if 32bit */
+    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
+        return false;
+    }
     return gen_load(ctx, a, MO_SQ);
 }
 
@@ -482,6 +509,27 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
     return true;
 }
 
+/* Zilsd extension adds load/store double for 32bit arch */
+static bool gen_store_zilsd(DisasContext *ctx, arg_sb *a)
+{
+    TCGv data_1 = tcg_temp_new();
+    TCGv data_2 = tcg_temp_new();
+    if (a->rs2 != 0) {
+        data_1 = get_gpr(ctx, a->rs2, EXT_NONE);
+        data_2 = get_gpr(ctx, a->rs2+1, EXT_NONE);
+    }
+    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
+    TCGv addr_2 = get_address(ctx, a->rs1, a->imm+4);
+
+    if (ctx->ztso) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+
+    tcg_gen_qemu_st_tl(data_1, addr_1, ctx->mem_idx, MO_SL);
+    tcg_gen_qemu_st_tl(data_2, addr_2, ctx->mem_idx, MO_SL);
+    return true;
+}
+
 static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
     TCGv src1l = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -511,6 +559,8 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
+    } else if (memop == MO_UQ && get_xl(ctx) == MXL_RV32) {
+        return gen_store_zilsd(ctx, a);
     } else {
         return gen_store_tl(ctx, a, memop);
     }
@@ -533,7 +583,10 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
 
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


