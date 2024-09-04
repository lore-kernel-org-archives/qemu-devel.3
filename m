Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E7CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr44-0006Sv-IW; Wed, 04 Sep 2024 10:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr3x-0005zs-D7; Wed, 04 Sep 2024 10:32:49 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr3u-00041m-J8; Wed, 04 Sep 2024 10:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725460362; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=p+m6c99pmYH6w/FLp/HP7mKwqCIgLFeR7e8cr84anM0=;
 b=WYyPAWox9GsWMrT1BDVc6R+X8T7QFCKdcaMuzjWTmQUlHdPzP4QUI4DfaRmbKMweBUqYP4D55z6BR+5U8rqIxn3PptvH++urWsFDMyyDt70QOt2xJ95Q5gikmN2RXve9i0N8fuPOZhzocHF622GbFD7J7DQNJ7xGCdAtL/fitAw=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEI1Cg5_1725460360) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 22:32:41 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 08/14] tcg/riscv: Implement vector cmp ops
Date: Wed,  4 Sep 2024 22:27:33 +0800
Message-Id: <20240904142739.854-9-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

1.Address immediate value constraints in RISC-V Vector Extension 1.0 for
comparison instructions.

2.Extend comparison results from mask registers to SEW-width elements,
  following recommendations in The RISC-V SPEC Volume I (Version 20240411).

This aligns with TCG's cmp_vec behavior by expanding compare results to
full element width: all 1s for true, all 0s for false.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target-con-set.h |   3 +
 tcg/riscv/tcg-target-con-str.h |   2 +
 tcg/riscv/tcg-target.c.inc     | 252 +++++++++++++++++++++++++++------
 tcg/riscv/tcg-target.h         |   2 +-
 tcg/tcg-internal.h             |   2 +
 tcg/tcg-op-vec.c               |   2 +-
 6 files changed, 214 insertions(+), 49 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d4504122a2..cc06102ccf 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -24,3 +24,6 @@ C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
+C_O1_I2(v, v, v)
+C_O1_I2(v, v, vL)
+C_O1_I4(v, v, vL, vK, vK)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index b2b3211bcb..089efe96ca 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -17,6 +17,8 @@ REGS('v', ALL_VECTOR_REGS)
  */
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_J12)
+CONST('K', TCG_CT_CONST_S5)
+CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c89d1a5dc9..37909e56fb 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -106,11 +106,13 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_A0 + slot;
 }
 
-#define TCG_CT_CONST_ZERO  0x100
-#define TCG_CT_CONST_S12   0x200
-#define TCG_CT_CONST_N12   0x400
-#define TCG_CT_CONST_M12   0x800
-#define TCG_CT_CONST_J12  0x1000
+#define TCG_CT_CONST_ZERO   0x100
+#define TCG_CT_CONST_S12    0x200
+#define TCG_CT_CONST_N12    0x400
+#define TCG_CT_CONST_M12    0x800
+#define TCG_CT_CONST_J12    0x1000
+#define TCG_CT_CONST_S5     0x2000
+#define TCG_CT_CONST_CMP_VI 0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -119,48 +121,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define sextreg  sextract64
 
-/* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, int ct,
-                                   TCGType type, TCGCond cond, int vece)
-{
-    if (ct & TCG_CT_CONST) {
-        return 1;
-    }
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
-    }
-    /*
-     * Sign extended from 12 bits: [-0x800, 0x7ff].
-     * Used for most arithmetic, as this is the isa field.
-     */
-    if ((ct & TCG_CT_CONST_S12) && val >= -0x800 && val <= 0x7ff) {
-        return 1;
-    }
-    /*
-     * Sign extended from 12 bits, negated: [-0x7ff, 0x800].
-     * Used for subtraction, where a constant must be handled by ADDI.
-     */
-    if ((ct & TCG_CT_CONST_N12) && val >= -0x7ff && val <= 0x800) {
-        return 1;
-    }
-    /*
-     * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
-     * Used by addsub2 and movcond, which may need the negative value,
-     * and requires the modified constant to be representable.
-     */
-    if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
-        return 1;
-    }
-    /*
-     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
-     * Used to map ANDN back to ANDI, etc.
-     */
-    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
-        return 1;
-    }
-    return 0;
-}
-
 /*
  * RISC-V Base ISA opcodes (IM)
  */
@@ -310,6 +270,9 @@ typedef enum {
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 
+    OPC_VMERGE_VIM = 0x5c000057 | V_OPIVI,
+    OPC_VMERGE_VVM = 0x5c000057 | V_OPIVV,
+
     OPC_VADD_VV = 0x57 | V_OPIVV,
     OPC_VSUB_VV = 0x8000057 | V_OPIVV,
     OPC_VAND_VV = 0x24000057 | V_OPIVV,
@@ -317,6 +280,29 @@ typedef enum {
     OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
     OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
 
+    OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
+    OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
+    OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
+    OPC_VMSNE_VV = 0x64000057 | V_OPIVV,
+    OPC_VMSNE_VI = 0x64000057 | V_OPIVI,
+    OPC_VMSNE_VX = 0x64000057 | V_OPIVX,
+
+    OPC_VMSLTU_VV = 0x68000057 | V_OPIVV,
+    OPC_VMSLTU_VX = 0x68000057 | V_OPIVX,
+    OPC_VMSLT_VV = 0x6c000057 | V_OPIVV,
+    OPC_VMSLT_VX = 0x6c000057 | V_OPIVX,
+    OPC_VMSLEU_VV = 0x70000057 | V_OPIVV,
+    OPC_VMSLEU_VX = 0x70000057 | V_OPIVX,
+    OPC_VMSLE_VV = 0x74000057 | V_OPIVV,
+    OPC_VMSLE_VX = 0x74000057 | V_OPIVX,
+
+    OPC_VMSLEU_VI = 0x70000057 | V_OPIVI,
+    OPC_VMSLE_VI = 0x74000057 | V_OPIVI,
+    OPC_VMSGTU_VI = 0x78000057 | V_OPIVI,
+    OPC_VMSGTU_VX = 0x78000057 | V_OPIVX,
+    OPC_VMSGT_VI = 0x7c000057 | V_OPIVI,
+    OPC_VMSGT_VX = 0x7c000057 | V_OPIVX,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -324,6 +310,97 @@ typedef enum {
     OPC_VMVNR_V = 0x9e000057 | V_OPIVI,
 } RISCVInsn;
 
+static const struct {
+    RISCVInsn op;
+    bool swap;
+} tcg_cmpcond_to_rvv_vv[] = {
+    [TCG_COND_EQ] =  { OPC_VMSEQ_VV,  false },
+    [TCG_COND_NE] =  { OPC_VMSNE_VV,  false },
+    [TCG_COND_LT] =  { OPC_VMSLT_VV,  false },
+    [TCG_COND_GE] =  { OPC_VMSLE_VV,  true  },
+    [TCG_COND_GT] =  { OPC_VMSLT_VV,  true  },
+    [TCG_COND_LE] =  { OPC_VMSLE_VV,  false },
+    [TCG_COND_LTU] = { OPC_VMSLTU_VV, false },
+    [TCG_COND_GEU] = { OPC_VMSLEU_VV, true  },
+    [TCG_COND_GTU] = { OPC_VMSLTU_VV, true  },
+    [TCG_COND_LEU] = { OPC_VMSLEU_VV, false }
+};
+
+static const struct {
+    RISCVInsn op;
+    int min;
+    int max;
+    bool adjust;
+}  tcg_cmpcond_to_rvv_vi[] = {
+    [TCG_COND_EQ]  = { OPC_VMSEQ_VI,  -16, 15, false },
+    [TCG_COND_NE]  = { OPC_VMSNE_VI,  -16, 15, false },
+    [TCG_COND_GT]  = { OPC_VMSGT_VI,  -16, 15, false },
+    [TCG_COND_LE]  = { OPC_VMSLE_VI,  -16, 15, false },
+    [TCG_COND_LT]  = { OPC_VMSLE_VI,  -15, 16, true  },
+    [TCG_COND_GE]  = { OPC_VMSGT_VI,  -15, 16, true  },
+    [TCG_COND_LEU] = { OPC_VMSLEU_VI,   0, 15, false },
+    [TCG_COND_GTU] = { OPC_VMSGTU_VI,   0, 15, false },
+    [TCG_COND_LTU] = { OPC_VMSLEU_VI,   1, 16, true  },
+    [TCG_COND_GEU] = { OPC_VMSGTU_VI,   1, 16, true  },
+};
+
+/* test if a constant matches the constraint */
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
+{
+    if (ct & TCG_CT_CONST) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+        return 1;
+    }
+    /*
+     * Sign extended from 12 bits: [-0x800, 0x7ff].
+     * Used for most arithmetic, as this is the isa field.
+     */
+    if ((ct & TCG_CT_CONST_S12) && val >= -0x800 && val <= 0x7ff) {
+        return 1;
+    }
+    /*
+     * Sign extended from 12 bits, negated: [-0x7ff, 0x800].
+     * Used for subtraction, where a constant must be handled by ADDI.
+     */
+    if ((ct & TCG_CT_CONST_N12) && val >= -0x7ff && val <= 0x800) {
+        return 1;
+    }
+    /*
+     * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
+     * Used by addsub2 and movcond, which may need the negative value,
+     * and requires the modified constant to be representable.
+     */
+    if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
+        return 1;
+    }
+    /*
+     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
+     * Used to map ANDN back to ANDI, etc.
+     */
+    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
+        return 1;
+    }
+    /*
+     * Sign extended from 5 bits: [-0x10, 0x0f].
+     * Used for vector-immediate.
+     */
+    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
+        return 1;
+    }
+    /*
+     * Used for vector compare OPIVI instructions.
+     */
+    if ((ct & TCG_CT_CONST_CMP_VI) &&
+        val >= tcg_cmpcond_to_rvv_vi[cond].min &&
+        val <= tcg_cmpcond_to_rvv_vi[cond].max) {
+        return true;
+     }
+    return 0;
+}
+
 /*
  * RISC-V immediate and instruction encoders (excludes 16-bit RVC)
  */
@@ -592,6 +669,18 @@ static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc, TCGReg vd,
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, vm));
 }
 
+static void tcg_out_opc_vim_mask(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                           TCGReg vs2, int32_t imm)
+{
+    tcg_out32(s, encode_vi(opc, vd, imm, vs2, false));
+}
+
+static void tcg_out_opc_vvm_mask(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                           TCGReg vs2, TCGReg vs1)
+{
+    tcg_out32(s, encode_v(opc, vd, vs1, vs2, false));
+}
+
 /*
  * Only unit-stride addressing implemented; may extend in future.
  */
@@ -2322,6 +2411,51 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         riscv_set_vec_config_vl(s, type);
         tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
         break;
+    case INDEX_op_cmpsel_vec:
+        TCGArg a3, a4;
+        int c3, c4;
+        TCGCond cond;
+
+        a3 = args[3];
+        a4 = args[4];
+        c3 = const_args[3];
+        c4 = const_args[4];
+        cond = args[5];
+        riscv_set_vec_config_vl_vece(s, type, vece);
+
+        /* Use only vmerge_vim if possible, by inverting the test. */
+        if (c4 && !c3) {
+            cond = tcg_invert_cond(cond);
+            a3 = a4;
+            a4 = args[3];
+            c3 = true;
+            c4 = false;
+        }
+
+        /* Perform the comparison into V0 mask. */
+        if (const_args[2]) {
+            tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op,
+                            TCG_REG_V0, a1,
+                            a2 - tcg_cmpcond_to_rvv_vi[cond].adjust, true);
+        } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
+            tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
+                            TCG_REG_V0, a2, a1, true);
+        } else {
+            tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
+                            TCG_REG_V0, a1, a2, true);
+        }
+        if (c3) {
+            if (c4) {
+                tcg_out_opc_vi(s, OPC_VMV_V_I, a0, TCG_REG_V0, a4, true);
+                a4 = a0;
+            }
+            /* vd[i] == v0.mask[i] ? imm : vs2[i] */
+            tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, a0, a4, a3);
+        } else {
+            /* vd[i] == v0.mask[i] ? vs1[i] : vs2[i] */
+            tcg_out_opc_vvm_mask(s, OPC_VMERGE_VVM, a0, a4, a3);
+        }
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2332,10 +2466,27 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
+    va_list va;
+    TCGv_vec v0, v1;
+    TCGArg a2, a3;
+
+    va_start(va, a0);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a2 = va_arg(va, TCGArg);
+
     switch (opc) {
+    case INDEX_op_cmp_vec:
+        a3 = va_arg(va, TCGArg);
+        vec_gen_6(INDEX_op_cmpsel_vec, type, vece, tcgv_vec_arg(v0),
+                    tcgv_vec_arg(v1), a2,
+                    tcgv_i64_arg(tcg_constant_i64(-1)),
+                    tcgv_i64_arg(tcg_constant_i64(0)), a3);
+        break;
     default:
         g_assert_not_reached();
     }
+    va_end(va);
 }
 
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
@@ -2347,7 +2498,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_cmpsel_vec:
         return 1;
+    case INDEX_op_cmp_vec:
+        return -1;
     default:
         return 0;
     }
@@ -2506,6 +2660,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
         return C_O1_I2(v, v, v);
+    case INDEX_op_cmp_vec:
+        return C_O1_I2(v, v, vL);
+    case INDEX_op_cmpsel_vec:
+        return C_O1_I4(v, v, vL, vK, vK);
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index acb8dfdf16..94034504b2 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -164,7 +164,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sat_vec          0
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 
 #define TCG_TARGET_HAS_tst_vec          0
 
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 9b0d982f65..512128e8a7 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -102,5 +102,7 @@ void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
 void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+                    TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 84af210bc0..851322878c 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -172,7 +172,7 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
     op->args[3] = c;
 }
 
-static void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                       TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
-- 
2.43.0


