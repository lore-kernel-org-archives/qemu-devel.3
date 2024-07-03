Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DDC3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpEC-0003x9-84; Tue, 02 Jul 2024 21:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOpE9-0003vJ-Bn; Tue, 02 Jul 2024 21:56:09 -0400
Received: from out199-10.us.a.mail.aliyun.com ([47.90.199.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOpE6-0000tY-Is; Tue, 02 Jul 2024 21:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719971758; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=QpVBEF/RlwEkyRpCjGh9CFCA9iT8qsWD+3YJiYVH160=;
 b=jnXkk6T0UL1hTqQGcGLIbyaZIRk8N77P+G7rk3wBfmsCEYVxGGTofuhxgtuQL3ac8gpfsVrPylGr6Qe+5Xo++J5npBpXd2oN0NxEHUIv5hB4RAHmDuNGE04WB0v/ootEU8tuVz47Dy+3450WqDrvOjfZ3mvwYXLAX+7ktviH6+4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W9kB2Eq_1719971438; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9kB2Eq_1719971438) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 09:50:39 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3 05/11] target/riscv: Support Zama16b extension
Date: Wed,  3 Jul 2024 09:46:29 +0800
Message-Id: <20240703014635.1020-6-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
References: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=47.90.199.10;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out199-10.us.a.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Zama16b is the property that misaligned load/stores/atomics within
a naturally aligned 16-byte region are atomic.

According to the specification, Zama16b applies only to AMOs, loads
and stores defined in the base ISAs, and loads and stores of no more
than XLEN bits defined in the F, D, and Q extensions. Thus it should
not apply to zacas or RVC instructions.

For an instruction in that set, if all accessed bytes lie within 16B granule,
the instruction will not raise an exception for reasons of address alignment,
and the instruction will give rise to only one memory operation for the
purposes of RVWMO—i.e., it will execute atomically.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                      |  2 ++
 target/riscv/cpu_cfg.h                  |  1 +
 target/riscv/insn_trans/trans_rva.c.inc | 42 ++++++++++++++-----------
 target/riscv/insn_trans/trans_rvd.c.inc | 14 +++++++--
 target/riscv/insn_trans/trans_rvf.c.inc | 14 +++++++--
 target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++
 6 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1d1402775a..5219b44176 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -118,6 +118,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
+    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
@@ -1476,6 +1477,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
     MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
+    MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
     MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index d85e54b475..ddbfae37e5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -83,6 +83,7 @@ struct RISCVCPUConfig {
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
+    bool ext_zama16b;
     bool ext_zalrsc;
     bool ext_zawrs;
     bool ext_zfa;
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 4a9e4591d1..eb080baddd 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -103,6 +103,12 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
+    if (ctx->cfg_ptr->ext_zama16b) {
+        mop |= MO_ATOM_WITHIN16;
+    } else {
+        mop |= MO_ALIGN;
+    }
+
     decode_save_opc(ctx);
     src1 = get_address(ctx, a->rs1, 0);
     func(dest, src1, src2, ctx->mem_idx, mop);
@@ -126,55 +132,55 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESL);
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESL);
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESL);
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESL);
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESL);
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESL);
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESL);
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESL);
 }
 
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
@@ -195,61 +201,61 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TEUQ);
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TEUQ);
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TEUQ);
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TEUQ);
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TEUQ);
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TEUQ);
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TEUQ);
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TEUQ);
 }
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index d9ce9e407f..1f5fac65a2 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -42,13 +42,18 @@
 static bool trans_fld(DisasContext *ctx, arg_fld *a)
 {
     TCGv addr;
+    MemOp memop = MO_TEUQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
+    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+        memop |= MO_ATOM_WITHIN16;
+    }
+
     decode_save_opc(ctx);
     addr = get_address(ctx, a->rs1, a->imm);
-    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, memop);
 
     mark_fs_dirty(ctx);
     return true;
@@ -57,13 +62,18 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
 static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 {
     TCGv addr;
+    MemOp memop = MO_TEUQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
+    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+        memop |= MO_ATOM_WITHIN16;
+    }
+
     decode_save_opc(ctx);
     addr = get_address(ctx, a->rs1, a->imm);
-    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 97a368970b..f771aa1939 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -43,14 +43,19 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv_i64 dest;
     TCGv addr;
+    MemOp memop = MO_TEUL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+        memop |= MO_ATOM_WITHIN16;
+    }
+
     decode_save_opc(ctx);
     addr = get_address(ctx, a->rs1, a->imm);
     dest = cpu_fpr[a->rd];
-    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUL);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, memop);
     gen_nanbox_s(dest, dest);
 
     mark_fs_dirty(ctx);
@@ -60,13 +65,18 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 {
     TCGv addr;
+    MemOp memop = MO_TEUL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+        memop |= MO_ATOM_WITHIN16;
+    }
+
     decode_save_opc(ctx);
     addr = get_address(ctx, a->rs1, a->imm);
-    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, MO_TEUL);
+    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index ad40d3e87f..98e3806d5e 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -268,6 +268,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
+    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+        memop |= MO_ATOM_WITHIN16;
+    }
     decode_save_opc(ctx);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
@@ -366,6 +369,9 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
+    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+        memop |= MO_ATOM_WITHIN16;
+    }
     decode_save_opc(ctx);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
-- 
2.25.1


