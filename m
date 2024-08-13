Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6376BC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpsx-0005lZ-98; Tue, 13 Aug 2024 07:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpsb-00050O-0J; Tue, 13 Aug 2024 07:39:58 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpsX-0002sq-QQ; Tue, 13 Aug 2024 07:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723549187; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=02wqUiyefw7v9nlh8NyilSaQ5kFPiJpt3dBm6HMn1og=;
 b=oxt5IF47jKQFvzwEjEj02qinMsu3SizQU3EV2pbOambEd4JXLJt8z5l7PNg0SZgN0ucsoG7A7Zur/NIBvIrL/exNA4KNNoFMv6yE5tCXxjfPRNtfn1EX5SwYiY80/T8U7DBQUhWBe6lqzRCOip3+FcSArpryO3TWRknA8bnq/IM=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCow15V_1723549185) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:39:46 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 09/15] tcg/riscv: Implement vector cmp ops
Date: Tue, 13 Aug 2024 19:34:30 +0800
Message-Id: <20240813113436.831-10-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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
 tcg/riscv/tcg-target-con-set.h |   2 +
 tcg/riscv/tcg-target-con-str.h |   1 +
 tcg/riscv/tcg-target.c.inc     | 188 +++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.opc.h     |   3 +
 4 files changed, 194 insertions(+)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 8a0de18257..23b391dd07 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -22,5 +22,7 @@ C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
+C_O0_I2(v, vK)
 C_O1_I1(v, r)
 C_O1_I2(v, v, v)
+C_O1_I2(v, v, vK)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index b2b3211bcb..0aaad7b753 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -17,6 +17,7 @@ REGS('v', ALL_VECTOR_REGS)
  */
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_J12)
+CONST('K', TCG_CT_CONST_S5)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 650b5eff1a..3f1e215e90 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -113,6 +113,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_N12   0x400
 #define TCG_CT_CONST_M12   0x800
 #define TCG_CT_CONST_J12  0x1000
+#define TCG_CT_CONST_S5   0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(33, 31)
@@ -160,6 +161,13 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
         return 1;
     }
+    /*
+     * Sign extended from 5 bits: [-0x10, 0x0f].
+     * Used for vector-immediate.
+     */
+    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
+        return 1;
+    }
     return 0;
 }
 
@@ -289,12 +297,39 @@ typedef enum {
     OPC_VSE32_V = 0x6027 | V_SUMOP,
     OPC_VSE64_V = 0x7027 | V_SUMOP,
 
+    OPC_VMERGE_VIM = 0x5c000057 | V_OPIVI,
+    OPC_VMERGE_VVM = 0x5c000057 | V_OPIVV,
+    OPC_VMNAND_MM = 0x74000057 | V_OPMVV,
+
     OPC_VADD_VV = 0x57 | V_OPIVV,
     OPC_VSUB_VV = 0x8000057 | V_OPIVV,
     OPC_VAND_VV = 0x24000057 | V_OPIVV,
     OPC_VOR_VV = 0x28000057 | V_OPIVV,
     OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
 
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
@@ -575,6 +610,15 @@ static void tcg_out_opc_vec_config(TCGContext *s, RISCVInsn opc,
 #define tcg_out_opc_vi(s, opc, vd, vs2, imm, vm) \
     tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, vm);
 
+#define tcg_out_opc_vim_mask(s, opc, vd, vs2, imm) \
+    tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, false);
+
+#define tcg_out_opc_vvm_mask(s, opc, vd, vs2, vs1) \
+    tcg_out_opc_reg_vec(s, opc, vd, vs1, vs2, false);
+
+#define tcg_out_opc_mvv(s, opc, vd, vs2, vs1, vm) \
+    tcg_out_opc_reg_vec(s, opc, vd, vs1, vs2, vm);
+
 #define tcg_out_opc_vconfig(s, opc, rd, avl, vtypei) \
     tcg_out_opc_vec_config(s, opc, rd, avl, vtypei);
 
@@ -1037,6 +1081,22 @@ static const struct {
     [TCG_COND_GTU] = { OPC_BLTU, true  }
 };
 
+static const struct {
+    RISCVInsn opc;
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
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
@@ -1054,6 +1114,79 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_opc_branch(s, op, arg1, arg2, 0);
 }
 
+static const struct {
+    RISCVInsn op;
+    bool expand;
+}  tcg_cmpcond_to_rvv_vx[] = {
+    [TCG_COND_EQ]  = { OPC_VMSEQ_VX,  false },
+    [TCG_COND_NE]  = { OPC_VMSNE_VX,  false },
+    [TCG_COND_GT]  = { OPC_VMSGT_VX,  false },
+    [TCG_COND_LE]  = { OPC_VMSLE_VX,  false },
+    [TCG_COND_LT]  = { OPC_VMSLT_VX,  false },
+    [TCG_COND_LTU] = { OPC_VMSLTU_VX, false },
+    [TCG_COND_GTU] = { OPC_VMSGTU_VX, false },
+    [TCG_COND_LEU] = { OPC_VMSLEU_VX, false },
+    [TCG_COND_GE]  = { OPC_VMSLT_VX,  true  },
+    [TCG_COND_GEU] = { OPC_VMSLTU_VX, true  },
+};
+
+static void tcg_out_cmp_vec_vx(TCGContext *s, TCGCond cond, TCGReg arg1,
+                               tcg_target_long arg2)
+{
+    RISCVInsn op;
+
+    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_cmpcond_to_rvv_vx));
+    op = tcg_cmpcond_to_rvv_vx[cond].op;
+    tcg_debug_assert(op != 0);
+
+    tcg_out_opc_vx(s, op, TCG_REG_V0, arg1, arg2, true);
+    if (tcg_cmpcond_to_rvv_vx[cond].expand) {
+        tcg_out_opc_mvv(s, OPC_VMNAND_MM, TCG_REG_V0, TCG_REG_V0,
+                        TCG_REG_V0, false);
+    }
+}
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
+static void tcg_out_cmp_vec_vi(TCGContext *s, TCGCond cond, TCGReg arg1,
+                               tcg_target_long arg2)
+{
+    RISCVInsn op;
+    signed imm_min, imm_max;
+
+    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_cmpcond_to_rvv_vi));
+    op = tcg_cmpcond_to_rvv_vi[cond].op;
+    tcg_debug_assert(op != 0);
+    imm_min = tcg_cmpcond_to_rvv_vi[cond].min;
+    imm_max = tcg_cmpcond_to_rvv_vi[cond].max;
+
+    if (arg2 >= imm_min && arg2 <= imm_max) {
+        if (tcg_cmpcond_to_rvv_vi[cond].adjust) {
+            arg2 -= 1;
+        }
+        tcg_out_opc_vi(s, op, TCG_REG_V0, arg1, arg2, true);
+    } else {
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, arg2);
+        tcg_out_cmp_vec_vx(s, cond, arg1, TCG_REG_TMP0);
+    }
+}
+
 #define SETCOND_INV    TCG_TARGET_NB_REGS
 #define SETCOND_NEZ    (SETCOND_INV << 1)
 #define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
@@ -2179,6 +2312,33 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_xor_vec:
         tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
         break;
+    case INDEX_op_rvv_cmpcond_vec:
+        {
+            RISCVInsn op;
+            if (const_args[1]) {
+                tcg_out_cmp_vec_vi(s, a2, a0, a1);
+            } else {
+                op = tcg_cmpcond_to_rvv_vv[a2].opc;
+                tcg_debug_assert(op != 0);
+
+                if (tcg_cmpcond_to_rvv_vv[a2].swap) {
+                    TCGReg t = a0;
+                    a0 = a1;
+                    a1 = t;
+                }
+                tcg_out_opc_vv(s, op, TCG_REG_V0, a0, a1, true);
+            }
+        }
+        break;
+    case INDEX_op_rvv_merge_vec:
+        if (const_args[2]) {
+            /* vd[i] = v0.mask[i] ? imm : vs2[i] */
+            tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, a0, a1, a2);
+        } else {
+            /* vd[i] = v0.mask[i] ? vs1[i] : vs2[i] */
+            tcg_out_opc_vvm_mask(s, OPC_VMERGE_VVM, a0, a1, a2);
+        }
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2189,10 +2349,31 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
+        {
+            a3 = va_arg(va, TCGArg);
+            vec_gen_3(INDEX_op_rvv_cmpcond_vec, type, vece,
+                      tcgv_vec_arg(v1), a2, a3);
+            tcg_gen_mov_vec(v0, tcg_constant_vec_matching(v0, vece, 0));
+            vec_gen_3(INDEX_op_rvv_merge_vec, type, vece,
+                      tcgv_vec_arg(v0), tcgv_vec_arg(v0),
+                      tcgv_i64_arg(tcg_constant_i64(-1)));
+        }
+        break;
     default:
         g_assert_not_reached();
     }
+    va_end(va);
 }
 
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
@@ -2204,6 +2385,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
         return 1;
+    case INDEX_op_cmp_vec:
+        return -1;
     default:
         return 0;
     }
@@ -2360,6 +2543,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
         return C_O1_I2(v, v, v);
+    case INDEX_op_cmp_vec:
+    case INDEX_op_rvv_merge_vec:
+        return C_O1_I2(v, v, vK);
+    case INDEX_op_rvv_cmpcond_vec:
+        return C_O0_I2(v, vK);
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target.opc.h
index b80b39e1e5..2f23453c35 100644
--- a/tcg/riscv/tcg-target.opc.h
+++ b/tcg/riscv/tcg-target.opc.h
@@ -10,3 +10,6 @@
  * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
  * consider these to be UNSPEC with names.
  */
+
+DEF(rvv_cmpcond_vec, 0, 2, 1, IMPLVEC)
+DEF(rvv_merge_vec, 1, 2, 0, IMPLVEC)
-- 
2.43.0


