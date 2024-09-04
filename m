Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46010CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr1h-00047P-Bo; Wed, 04 Sep 2024 10:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr1S-00037J-GD; Wed, 04 Sep 2024 10:30:22 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr1N-0003eG-2R; Wed, 04 Sep 2024 10:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725460204; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=DS4/p3J9h6+SjdeoOeViXEJtRaT5lpL5R7/IwKiAdc8=;
 b=AXKYztScJNf6fDB7cKOvFgmmiotjuyhbBLkxN19OJnritS6cpqXSFSYpuLO3euNSC7wDKTwNM59vfDyIlzwAUk+p3h4Atg7UnYluRi17gFfGvIYqYB/N8MR4Oag9i/QqEIx3zr8huyUcvERCz+BOz8CVe/yro7Vok6rqsjr2/EE=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEI2Jha_1725460202) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 22:30:03 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 Swung0x48 <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 03/14] tcg/riscv: Add basic support for vector
Date: Wed,  4 Sep 2024 22:27:28 +0800
Message-Id: <20240904142739.854-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

From: Swung0x48 <swung0x48@outlook.com>

The RISC-V vector instruction set utilizes the LMUL field to group
multiple registers, enabling variable-length vector registers. This
implementation uses only the first register number of each group while
reserving the other register numbers within the group.

In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
host runtime needs to adjust LMUL based on the type to use different
register groups.

This presents challenges for TCG's register allocation. Currently, we
avoid modifying the register allocation part of TCG and only expose the
minimum number of vector registers.

For example, when the host vlen is 64 bits and type is TCG_TYPE_V256, with
LMUL equal to 4, we use 4 vector registers as one register group. We can
use a maximum of 8 register groups, but the V0 register number is reserved
as a mask register, so we can effectively use at most 7 register groups.
Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers are
forced to be used. This is because TCG cannot yet dynamically constrain
registers with type; likewise, when the host vlen is 128 bits and
TCG_TYPE_V256, we can use at most 15 registers.

There is not much pressure on vector register allocation in TCG now, so
using 7 registers is feasible and will not have a major impact on code
generation.

This patch:
1. Reserves vector register 0 for use as a mask register.
2. When using register groups, reserves the additional registers within
   each group.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Co-authored-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target-con-str.h |   1 +
 tcg/riscv/tcg-target.c.inc     | 166 ++++++++++++++++++++++++++-------
 tcg/riscv/tcg-target.h         |  78 +++++++++-------
 tcg/riscv/tcg-target.opc.h     |  12 +++
 4 files changed, 191 insertions(+), 66 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index d5c419dff1..b2b3211bcb 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -9,6 +9,7 @@
  * REGS(letter, register_mask)
  */
 REGS('r', ALL_GENERAL_REGS)
+REGS('v', ALL_VECTOR_REGS)
 
 /*
  * Define constraint letters for constants:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d334857226..c3f018ff0c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -32,38 +32,14 @@
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "zero",
-    "ra",
-    "sp",
-    "gp",
-    "tp",
-    "t0",
-    "t1",
-    "t2",
-    "s0",
-    "s1",
-    "a0",
-    "a1",
-    "a2",
-    "a3",
-    "a4",
-    "a5",
-    "a6",
-    "a7",
-    "s2",
-    "s3",
-    "s4",
-    "s5",
-    "s6",
-    "s7",
-    "s8",
-    "s9",
-    "s10",
-    "s11",
-    "t3",
-    "t4",
-    "t5",
-    "t6"
+    "zero", "ra",  "sp",  "gp",  "tp",  "t0",  "t1",  "t2",
+    "s0",   "s1",  "a0",  "a1",  "a2",  "a3",  "a4",  "a5",
+    "a6",   "a7",  "s2",  "s3",  "s4",  "s5",  "s6",  "s7",
+    "s8",   "s9",  "s10", "s11", "t3",  "t4",  "t5",  "t6",
+    "v0",   "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
+    "v8",   "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16",  "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24",  "v25", "v26", "v27", "v28", "v29", "v30", "v31",
 };
 #endif
 
@@ -100,6 +76,16 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_A5,
     TCG_REG_A6,
     TCG_REG_A7,
+
+    /* Vector registers and TCG_REG_V0 reserved for mask. */
+    TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,  TCG_REG_V4,
+    TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,  TCG_REG_V8,
+    TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11, TCG_REG_V12,
+    TCG_REG_V13, TCG_REG_V14, TCG_REG_V15, TCG_REG_V16,
+    TCG_REG_V17, TCG_REG_V18, TCG_REG_V19, TCG_REG_V20,
+    TCG_REG_V21, TCG_REG_V22, TCG_REG_V23, TCG_REG_V24,
+    TCG_REG_V25, TCG_REG_V26, TCG_REG_V27, TCG_REG_V28,
+    TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -127,6 +113,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_J12  0x1000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
+#define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
+#define ALL_DVECTOR_REG_GROUPS 0x5555555500000000
+#define ALL_QVECTOR_REG_GROUPS 0x1111111100000000
 
 #define sextreg  sextract64
 
@@ -363,6 +352,24 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
 
+/* Type-OPIVI */
+
+static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
+                         TCGReg vs2, bool vm)
+{
+    return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
+           (vs2 & 0x1f) << 20 | (vm << 25);
+}
+
+/* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
+
+static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
+                        TCGReg s2, bool vm)
+{
+    return opc | (d & 0x1f) << 7 | (s1 & 0x1f) << 15 |
+           (s2 & 0x1f) << 20 | (vm << 25);
+}
+
 /*
  * RISC-V instruction emitters
  */
@@ -475,6 +482,43 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     }
 }
 
+/*
+ * RISC-V vector instruction emitters
+ */
+
+/*
+ * Vector registers uses the same 5 lower bits as GPR registers,
+ * and vm=0 (vm = false) means vector masking ENABLED.
+ * With RVV 1.0, vs2 is the first operand, while rs1/imm is the
+ * second operand.
+ */
+static void tcg_out_opc_vv(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                           TCGReg vs2, TCGReg vs1, bool vm)
+{
+    tcg_out32(s, encode_v(opc, vd, vs1, vs2, vm));
+}
+
+static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                           TCGReg vs2, TCGReg rs1, bool vm)
+{
+    tcg_out32(s, encode_v(opc, vd, rs1, vs2, vm));
+}
+
+static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                           TCGReg vs2, int32_t imm, bool vm)
+{
+    tcg_out32(s, encode_vi(opc, vd, imm, vs2, vm));
+}
+
+/*
+ * Only unit-stride addressing implemented; may extend in future.
+ */
+static void tcg_out_opc_ldst_vec(TCGContext *s, RISCVInsn opc, TCGReg data,
+                                 TCGReg rs1, bool vm)
+{
+    tcg_out32(s, encode_v(opc, data, rs1, 0, vm));
+}
+
 /*
  * TCG intrinsics
  */
@@ -1881,6 +1925,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg args[TCG_MAX_OP_ARGS],
+                           const int const_args[TCG_MAX_OP_ARGS])
+{
+    switch (opc) {
+    case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    switch (opc) {
+    default:
+        g_assert_not_reached();
+    }
+}
+
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    default:
+        return 0;
+    }
+}
+
 static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 {
     switch (op) {
@@ -2100,6 +2174,32 @@ static void tcg_target_init(TCGContext *s)
 {
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    s->reserved_regs = 0;
+
+    if (cpuinfo & CPUINFO_ZVE64X) {
+        switch (riscv_vlen) {
+        case 64:
+            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V128] = ALL_DVECTOR_REG_GROUPS;
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_QVECTOR_REG_GROUPS;
+            s->reserved_regs |= (~ALL_QVECTOR_REG_GROUPS & 0xffffffff00000000);
+            break;
+        case 128:
+            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_DVECTOR_REG_GROUPS;
+            s->reserved_regs |= (~ALL_DVECTOR_REG_GROUPS & 0xffffffff00000000);
+            break;
+        case 256:
+            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
+            break;
+        default:
+            g_assert_not_reached();
+            break;
+        }
+    }
 
     tcg_target_call_clobber_regs = -1u;
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S0);
@@ -2115,7 +2215,6 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S10);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S11);
 
-    s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_ZERO);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
@@ -2123,6 +2222,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_V0);
 }
 
 typedef struct {
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 1a347eaf6e..12a7a37aaa 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -28,42 +28,28 @@
 #include "host/cpuinfo.h"
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 typedef enum {
-    TCG_REG_ZERO,
-    TCG_REG_RA,
-    TCG_REG_SP,
-    TCG_REG_GP,
-    TCG_REG_TP,
-    TCG_REG_T0,
-    TCG_REG_T1,
-    TCG_REG_T2,
-    TCG_REG_S0,
-    TCG_REG_S1,
-    TCG_REG_A0,
-    TCG_REG_A1,
-    TCG_REG_A2,
-    TCG_REG_A3,
-    TCG_REG_A4,
-    TCG_REG_A5,
-    TCG_REG_A6,
-    TCG_REG_A7,
-    TCG_REG_S2,
-    TCG_REG_S3,
-    TCG_REG_S4,
-    TCG_REG_S5,
-    TCG_REG_S6,
-    TCG_REG_S7,
-    TCG_REG_S8,
-    TCG_REG_S9,
-    TCG_REG_S10,
-    TCG_REG_S11,
-    TCG_REG_T3,
-    TCG_REG_T4,
-    TCG_REG_T5,
-    TCG_REG_T6,
+    TCG_REG_ZERO, TCG_REG_RA,  TCG_REG_SP,  TCG_REG_GP,
+    TCG_REG_TP,   TCG_REG_T0,  TCG_REG_T1,  TCG_REG_T2,
+    TCG_REG_S0,   TCG_REG_S1,  TCG_REG_A0,  TCG_REG_A1,
+    TCG_REG_A2,   TCG_REG_A3,  TCG_REG_A4,  TCG_REG_A5,
+    TCG_REG_A6,   TCG_REG_A7,  TCG_REG_S2,  TCG_REG_S3,
+    TCG_REG_S4,   TCG_REG_S5,  TCG_REG_S6,  TCG_REG_S7,
+    TCG_REG_S8,   TCG_REG_S9,  TCG_REG_S10, TCG_REG_S11,
+    TCG_REG_T3,   TCG_REG_T4,  TCG_REG_T5,  TCG_REG_T6,
+
+    /* RISC-V V Extension registers */
+    TCG_REG_V0,   TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
+    TCG_REG_V4,   TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
+    TCG_REG_V8,   TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12,  TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16,  TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20,  TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24,  TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28,  TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
 
     /* aliases */
     TCG_AREG0          = TCG_REG_S0,
@@ -156,6 +142,32 @@ typedef enum {
 
 #define TCG_TARGET_HAS_tst              0
 
+/* vector instructions */
+#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v128             0
+#define TCG_TARGET_HAS_v256             0
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+
+#define TCG_TARGET_HAS_tst_vec          0
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target.opc.h
new file mode 100644
index 0000000000..b80b39e1e5
--- /dev/null
+++ b/tcg/riscv/tcg-target.opc.h
@@ -0,0 +1,12 @@
+/*
+ * Copyright (c) C-SKY Microsystems Co., Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
-- 
2.43.0


