Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3761EE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOI0-0004Z9-Ta; Wed, 11 Sep 2024 10:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOHX-0004Fu-8W; Wed, 11 Sep 2024 10:25:21 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOGz-00080P-J8; Wed, 11 Sep 2024 10:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726063152; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=rECffFvEXM35EN2I8Ye4kezYNYNMJMu+IsgiqClZmsQ=;
 b=plqFDm3/ckPRrn41fkZSwXE8iZ7/SnB5/9KZIP4wRtoh7KP50a72EF79IhkiDME6RxMxVIAjaLUJ5aOFa6n4MPO+fs+GX2QoQFDSkNcJWNu7XmXXX4XyUWrl+lbAnVxInQSaDNcO3FNqTrGtV3RDJ3yPypkPQ8r0LEKB1yKNBUU=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEo88KD_1726061345) by smtp.aliyun-inc.com;
 Wed, 11 Sep 2024 21:29:06 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v4 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
Date: Wed, 11 Sep 2024 21:26:21 +0800
Message-Id: <20240911132630.461-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

In RISC-V, vector operations require initial vtype and vl using
the vset{i}vl{i} instruction.

This instruction:
  1. Sets the vector length (vl) in bytes
  2. Configures the vtype register, which includes:
    SEW (Single Element Width)
    LMUL (vector register group multiplier)
    Other vector operation parameters

This configuration is crucial for defining subsequent vector
operation behavior. To optimize performance, the configuration
process is managed dynamically:
  1. Reconfiguration using vset{i}vl{i} is necessary when SEW
     or TCG_Type changes.
  2. The vset instruction can be omitted when configuration
     remains unchanged.

This optimization is only effective within a single TB.
Each TB requires reconfiguration at its start, as the current
state cannot be obtained from hardware.

We save the TCGType and SEW in TCGContext, so that it matches
the multi-threaded TCG.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Signed-off-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 include/tcg/tcg.h              |   7 +
 tcg/riscv/tcg-target-con-set.h |   2 +
 tcg/riscv/tcg-target.c.inc     | 269 ++++++++++++++++++++++++++++++++-
 3 files changed, 274 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..93aa9c30ee 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -544,6 +544,12 @@ struct TCGContext {
     struct qemu_plugin_insn *plugin_insn;
 #endif
 
+    /* For host-specific values. */
+#ifdef __riscv
+    MemOp riscv_cur_vsew;
+    TCGType riscv_cur_type;
+#endif
+
     GHashTable *const_table[TCG_TYPE_COUNT];
     TCGTempSet free_temps[TCG_TYPE_COUNT];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
@@ -566,6 +572,7 @@ struct TCGContext {
 
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
+
 };
 
 static inline bool temp_readonly(TCGTemp *ts)
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index aac5ceee2b..d73a62b0f2 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -21,3 +21,5 @@ C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
+C_O0_I2(v, r)
+C_O1_I1(v, r)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 966d1ad981..47f4e35237 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -165,6 +165,31 @@ static bool tcg_target_const_match(int64_t val, int ct,
  * RISC-V Base ISA opcodes (IM)
  */
 
+#define V_OPIVV (0x0 << 12)
+#define V_OPFVV (0x1 << 12)
+#define V_OPMVV (0x2 << 12)
+#define V_OPIVI (0x3 << 12)
+#define V_OPIVX (0x4 << 12)
+#define V_OPFVF (0x5 << 12)
+#define V_OPMVX (0x6 << 12)
+#define V_OPCFG (0x7 << 12)
+
+/* NF <= 7 && NF >= 0 */
+#define V_NF(x) (x << 29)
+#define V_UNIT_STRIDE (0x0 << 20)
+#define V_UNIT_STRIDE_WHOLE_REG (0x8 << 20)
+
+typedef enum {
+    VLMUL_M1 = 0, /* LMUL=1 */
+    VLMUL_M2,     /* LMUL=2 */
+    VLMUL_M4,     /* LMUL=4 */
+    VLMUL_M8,     /* LMUL=8 */
+    VLMUL_RESERVED,
+    VLMUL_MF8,    /* LMUL=1/8 */
+    VLMUL_MF4,    /* LMUL=1/4 */
+    VLMUL_MF2,    /* LMUL=1/2 */
+} RISCVVlmul;
+
 typedef enum {
     OPC_ADD = 0x33,
     OPC_ADDI = 0x13,
@@ -260,6 +285,30 @@ typedef enum {
     /* Zicond: integer conditional operations */
     OPC_CZERO_EQZ = 0x0e005033,
     OPC_CZERO_NEZ = 0x0e007033,
+
+    /* V: Vector extension 1.0 */
+    OPC_VSETVLI  = 0x57 | V_OPCFG,
+    OPC_VSETIVLI = 0xc0000057 | V_OPCFG,
+    OPC_VSETVL   = 0x80000057 | V_OPCFG,
+
+    OPC_VLE8_V  = 0x7 | V_UNIT_STRIDE,
+    OPC_VLE16_V = 0x5007 | V_UNIT_STRIDE,
+    OPC_VLE32_V = 0x6007 | V_UNIT_STRIDE,
+    OPC_VLE64_V = 0x7007 | V_UNIT_STRIDE,
+    OPC_VSE8_V  = 0x27 | V_UNIT_STRIDE,
+    OPC_VSE16_V = 0x5027 | V_UNIT_STRIDE,
+    OPC_VSE32_V = 0x6027 | V_UNIT_STRIDE,
+    OPC_VSE64_V = 0x7027 | V_UNIT_STRIDE,
+
+    OPC_VL1RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(0),
+    OPC_VL2RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(1),
+    OPC_VL4RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
+    OPC_VL8RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
+
+    OPC_VS1R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(0),
+    OPC_VS2R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(1),
+    OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
+    OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 } RISCVInsn;
 
 /*
@@ -352,6 +401,35 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
 
+/* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
+
+static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
+                        TCGReg s2, bool vm)
+{
+    return opc | (d & 0x1f) << 7 | (s1 & 0x1f) << 15 |
+           (s2 & 0x1f) << 20 | (vm << 25);
+}
+
+/* Vector vtype */
+
+static uint32_t encode_vtype(bool vta, bool vma,
+                            MemOp vsew, RISCVVlmul vlmul)
+{
+    return vma << 7 | vta << 6 | vsew << 3 | vlmul;
+}
+
+static int32_t encode_vset(RISCVInsn opc, TCGReg rd,
+                           TCGArg rs1, uint32_t vtype)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (vtype & 0x7ff) << 20;
+}
+
+static int32_t encode_vseti(RISCVInsn opc, TCGReg rd,
+                            uint32_t uimm, uint32_t vtype)
+{
+    return opc | (rd & 0x1f) << 7 | (uimm & 0x1f) << 15 | (vtype & 0x3ff) << 20;
+}
+
 /*
  * RISC-V instruction emitters
  */
@@ -464,6 +542,88 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     }
 }
 
+/*
+ * RISC-V vector instruction emitters
+ */
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
+static bool lmul_check(int lmul, MemOp vsew)
+{
+    /*
+     * For a given supported fractional LMUL setting, implementations must
+     * support SEW settings between SEW_MIN and LMUL * ELEN, inclusive.
+     * So if ELEN = 64, LMUL = 1/2, then SEW will support e8, e16, e32,
+     * but e64 may not be supported.
+     */
+    if (lmul < 0) {
+        return (8 << vsew) <= (64 / (1 << (-lmul)));
+    } else {
+        return true;
+    }
+}
+
+static void set_vtype(TCGContext *s, TCGType type, MemOp vsew)
+{
+    unsigned vtype, insn, avl;
+    int lmul;
+    RISCVVlmul vlmul;
+    bool lmul_eq_avl;
+
+    s->riscv_cur_type = type;
+    s->riscv_cur_vsew = vsew;
+
+    /* Match riscv_lg2_vlenb to TCG_TYPE_V64. */
+    QEMU_BUILD_BUG_ON(TCG_TYPE_V64 != 3);
+
+    lmul = type - riscv_lg2_vlenb;
+    if (lmul < -3) {
+        /* Host VLEN >= 1024 bits. */
+        vlmul = VLMUL_M1;
+        lmul_eq_avl = false;
+    } else if (lmul < 3) {
+        /* 1/8, 1/4, 1/2, 1, 2, 4 */
+        if (lmul_check(lmul, vsew)) {
+            vlmul = lmul & 7;
+        } else {
+            vlmul = VLMUL_M1;
+        }
+        lmul_eq_avl = true;
+    } else {
+        /* Guaranteed by Zve64x. */
+        g_assert_not_reached();
+    }
+
+    avl = tcg_type_size(type) >> vsew;
+    vtype = encode_vtype(true, true, vsew, vlmul);
+
+    if (avl < 32) {
+        insn = encode_vseti(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
+    } else if (lmul_eq_avl) {
+        /* rd != 0 and rs1 == 0 uses vlmax */
+        insn = encode_vset(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, vtype);
+    } else {
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
+        insn = encode_vset(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtype);
+    }
+    tcg_out32(s, insn);
+}
+
+static MemOp set_vtype_len(TCGContext *s, TCGType type)
+{
+    if (type != s->riscv_cur_type) {
+        set_vtype(s, type, MO_64);
+    }
+    return s->riscv_cur_vsew;
+}
+
 /*
  * TCG intrinsics
  */
@@ -670,18 +830,101 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     }
 }
 
+static void tcg_out_vec_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
+                              TCGReg addr, intptr_t offset)
+{
+    tcg_debug_assert(data >= TCG_REG_V0);
+    tcg_debug_assert(addr < TCG_REG_V0);
+
+    if (offset) {
+        tcg_debug_assert(addr != TCG_REG_ZERO);
+        if (offset == sextreg(offset, 0, 12)) {
+            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, addr);
+        }
+        addr = TCG_REG_TMP0;
+    }
+    tcg_out_opc_ldst_vec(s, opc, data, addr, true);
+}
+
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
-    tcg_out_ldst(s, insn, arg, arg1, arg2);
+    RISCVInsn insn;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_out_ldst(s, OPC_LW, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_I64:
+        tcg_out_ldst(s, OPC_LD, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        if (type >= riscv_lg2_vlenb) {
+            static const RISCVInsn whole_reg_ld[] = {
+                OPC_VL1RE64_V, OPC_VL2RE64_V, OPC_VL4RE64_V, OPC_VL8RE64_V
+            };
+            unsigned idx = type - riscv_lg2_vlenb;
+
+            tcg_debug_assert(idx < sizeof(whole_reg_ld));
+            insn = whole_reg_ld[idx];
+        } else {
+            static const RISCVInsn unit_stride_ld[] = {
+                OPC_VLE8_V, OPC_VLE16_V, OPC_VLE32_V, OPC_VLE64_V
+            };
+            MemOp prev_vsew = set_vtype_len(s, type);
+
+            tcg_debug_assert(prev_vsew < sizeof(unit_stride_ld));
+            insn = unit_stride_ld[prev_vsew];
+        }
+        tcg_out_vec_ldst(s, insn, arg, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SW : OPC_SD;
-    tcg_out_ldst(s, insn, arg, arg1, arg2);
+    RISCVInsn insn;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_out_ldst(s, OPC_SW, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_I64:
+        tcg_out_ldst(s, OPC_SD, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        if (type >= riscv_lg2_vlenb) {
+            static const RISCVInsn whole_reg_st[] = {
+                OPC_VS1R_V, OPC_VS2R_V, OPC_VS4R_V, OPC_VS8R_V
+            };
+            unsigned idx = type - riscv_lg2_vlenb;
+
+            tcg_debug_assert(idx < sizeof(whole_reg_st));
+            insn = whole_reg_st[idx];
+        } else {
+            static const RISCVInsn unit_stride_st[] = {
+                OPC_VSE8_V, OPC_VSE16_V, OPC_VSE32_V, OPC_VSE64_V
+            };
+            MemOp prev_vsew = set_vtype_len(s, type);
+
+            tcg_debug_assert(prev_vsew < sizeof(unit_stride_st));
+            insn = unit_stride_st[prev_vsew];
+        }
+        tcg_out_vec_ldst(s, insn, arg, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -1892,7 +2135,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const TCGArg args[TCG_MAX_OP_ARGS],
                            const int const_args[TCG_MAX_OP_ARGS])
 {
+    TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg a0, a1, a2;
+
+    a0 = args[0];
+    a1 = args[1];
+    a2 = args[2];
+
     switch (opc) {
+    case INDEX_op_ld_vec:
+        tcg_out_ld(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_st_vec:
+        tcg_out_st(s, type, a0, a1, a2);
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2056,6 +2312,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
 
+    case INDEX_op_st_vec:
+        return C_O0_I2(v, r);
+    case INDEX_op_ld_vec:
+        return C_O1_I1(v, r);
     default:
         g_assert_not_reached();
     }
@@ -2129,6 +2389,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    s->riscv_cur_type = TCG_TYPE_COUNT;
     /* nothing to do */
 }
 
-- 
2.43.0


