Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6214CA0EE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjv0T-00081v-0e; Fri, 30 Aug 2024 02:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjv0Q-0007o1-Lh; Fri, 30 Aug 2024 02:21:10 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjv0N-0005Rl-Ud; Fri, 30 Aug 2024 02:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724998860; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=78Pz9tXIJ/2kEWrTT1Okx0l929TEY1b6j1mHwJazfhs=;
 b=aX6CBy82DY+xWM099ymZt2gd9Mn/+ahFNkvh7l0+fyaNlmgSzEEFcWsHt5nxfjUOntCRJEq8qIGx6lM9kS+9nhIscMHzDACdqVH/nWe5kyP58lbChATJtrbPnQyAqe6HiiCqrqjccsv7zdyI1FX/OxgWLXYQgGdq6p/APswh81Y=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDvasa._1724998858) by smtp.aliyun-inc.com;
 Fri, 30 Aug 2024 14:20:59 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 08/14] tcg/riscv: Implement vector cmp ops
Date: Fri, 30 Aug 2024 14:16:01 +0800
Message-Id: <20240830061607.1940-9-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
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
 tcg/riscv/tcg-target-con-set.h |   6 +-
 tcg/riscv/tcg-target.c.inc     | 240 +++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.opc.h     |   5 +
 3 files changed, 250 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 7277cb9af8..6c9ad5188b 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -21,7 +21,11 @@ C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
+C_O0_I1(v)
+C_O0_I2(v, v)
 C_O0_I2(v, r)
-C_O0_I2(v, vK)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
+C_O1_I2(v, v, v)
+C_O1_I2(v, v, vi)
+C_O1_I2(v, v, vK)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index fde4e71260..1e8c0fb031 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -312,6 +312,9 @@ typedef enum {
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 
+    OPC_VMERGE_VIM = 0x5c000057 | V_OPIVI,
+    OPC_VMERGE_VVM = 0x5c000057 | V_OPIVV,
+
     OPC_VADD_VV = 0x57 | V_OPIVV,
     OPC_VSUB_VV = 0x8000057 | V_OPIVV,
     OPC_VAND_VV = 0x24000057 | V_OPIVV,
@@ -319,6 +322,29 @@ typedef enum {
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
@@ -595,6 +621,12 @@ static void tcg_out_opc_vec_config(TCGContext *s, RISCVInsn opc,
 #define tcg_out_opc_vi(s, opc, vd, vs2, imm, vm) \
     tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, vm);
 
+#define tcg_out_opc_vim_mask(s, opc, vd, vs2, imm) \
+    tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, false);
+
+#define tcg_out_opc_vvm_mask(s, opc, vd, vs2, vs1) \
+    tcg_out_opc_reg_vec(s, opc, vd, vs1, vs2, false);
+
 #define tcg_out_opc_vconfig(s, opc, rd, avl, vtypei) \
     tcg_out_opc_vec_config(s, opc, rd, avl, vtypei);
 
@@ -1139,6 +1171,101 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_opc_branch(s, op, arg1, arg2, 0);
 }
 
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
+    bool invert;
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
+static void tcg_out_cmp_vec_vv(TCGContext *s, TCGCond cond,
+                                      TCGReg arg1, TCGReg arg2)
+{
+    RISCVInsn op;
+
+    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_cmpcond_to_rvv_vv));
+    op = tcg_cmpcond_to_rvv_vv[cond].op;
+    tcg_debug_assert(op != 0);
+
+    tcg_out_opc_vv(s, op, TCG_REG_V0, arg1, arg2, true);
+}
+
+static void tcg_out_cmp_vec_vx(TCGContext *s, TCGCond cond,
+                                      TCGReg arg1, TCGReg arg2)
+{
+    RISCVInsn op;
+
+    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_cmpcond_to_rvv_vx));
+    op = tcg_cmpcond_to_rvv_vx[cond].op;
+    tcg_debug_assert(op != 0);
+
+    tcg_out_opc_vx(s, op, TCG_REG_V0, arg1, arg2, true);
+}
+
+static bool tcg_vec_cmp_can_do_vi(TCGCond cond, int64_t arg)
+{
+    signed imm_min, imm_max;
+
+    imm_min = tcg_cmpcond_to_rvv_vi[cond].min;
+    imm_max = tcg_cmpcond_to_rvv_vi[cond].max;
+    return (arg >= imm_min && arg <= imm_max);
+}
+
+static void tcg_out_cmp_vec_vi(TCGContext *s, TCGCond cond, TCGReg arg1,
+                               tcg_target_long arg2)
+{
+    RISCVInsn op;
+
+    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_cmpcond_to_rvv_vi));
+    op = tcg_cmpcond_to_rvv_vi[cond].op;
+    tcg_debug_assert(op != 0);
+
+    tcg_out_opc_vi(s, op, TCG_REG_V0, arg1, arg2, true);
+}
+
 #define SETCOND_INV    TCG_TARGET_NB_REGS
 #define SETCOND_NEZ    (SETCOND_INV << 1)
 #define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
@@ -2267,6 +2394,28 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         riscv_set_vec_config_vl(s, type);
         tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
         break;
+    case INDEX_op_rvv_cmp_vx:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_cmp_vec_vx(s, a2, a0, a1);
+        break;
+    case INDEX_op_rvv_cmp_vi:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_debug_assert(tcg_vec_cmp_can_do_vi(a2, a1));
+        tcg_out_cmp_vec_vi(s, a2, a0, a1);
+        break;
+    case INDEX_op_rvv_cmp_vv:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_cmp_vec_vv(s, a2, a0, a1);
+        break;
+    case INDEX_op_rvv_merge_vec:
+        if (const_args[2]) {
+            /* vd[i] == v0.mask[i] ? imm : vs2[i] */
+            tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, a0, a1, a2);
+        } else {
+            /* vd[i] == v0.mask[i] ? vs1[i] : vs2[i] */
+            tcg_out_opc_vvm_mask(s, OPC_VMERGE_VVM, a0, a1, a2);
+        }
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2274,13 +2423,92 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+static void expand_vec_cmp_vv(TCGType type, unsigned vece,
+                              TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+{
+    if (tcg_cmpcond_to_rvv_vv[cond].swap) {
+        vec_gen_3(INDEX_op_rvv_cmp_vv, type, vece,
+                  tcgv_vec_arg(v2), tcgv_vec_arg(v1), cond);
+    } else {
+        vec_gen_3(INDEX_op_rvv_cmp_vv, type, vece,
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
+    }
+}
+
+static bool expand_vec_cmp_vi(TCGType type, unsigned vece,
+                              TCGv_vec v1, TCGArg a2, TCGCond cond)
+{
+    int64_t arg2 = arg_temp(a2)->val;
+    bool invert = false;
+
+    if (!tcg_vec_cmp_can_do_vi(cond, arg2)) {
+        /* for cmp_vec_vx */
+        vec_gen_3(INDEX_op_rvv_cmp_vx, type, vece,
+                  tcgv_vec_arg(v1), tcgv_i64_arg(tcg_constant_i64(arg2)),
+                  cond);
+
+        tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_cmpcond_to_rvv_vx));
+        invert = tcg_cmpcond_to_rvv_vx[cond].invert;
+    } else {
+        if (tcg_cmpcond_to_rvv_vi[cond].adjust) {
+            arg2 -= 1;
+        }
+        vec_gen_3(INDEX_op_rvv_cmp_vi, type, vece,
+                    tcgv_vec_arg(v1), arg2, cond);
+    }
+    return invert;
+}
+
+static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v1,
+                          TCGArg a2, TCGCond cond)
+{
+    bool invert = false;
+    TCGTemp *t1 = arg_temp(a2);
+
+    if (t1->kind == TEMP_CONST) {
+        invert = expand_vec_cmp_vi(type, vece, v1, a2, cond);
+    } else {
+        expand_vec_cmp_vv(type, vece, v1, temp_tcgv_vec(t1), cond);
+    }
+    return invert;
+}
+
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
+
+            /*
+             * Mask values should be widened into SEW-width elements.
+             * For e.g. when SEW = 8bit, do 0b1 -> 0xff, 0b0 -> 0x00.
+             */
+            if (expand_vec_cmp_noinv(type, vece, v1, a2, a3)) {
+                vec_gen_3(INDEX_op_rvv_merge_vec, type, vece, tcgv_vec_arg(v0),
+                          tcgv_vec_arg(tcg_constant_vec(type, vece, -1)),
+                          tcgv_i64_arg(tcg_constant_i64(0)));
+            } else {
+                vec_gen_3(INDEX_op_rvv_merge_vec, type, vece, tcgv_vec_arg(v0),
+                          tcgv_vec_arg(tcg_constant_vec(type, vece, 0)),
+                          tcgv_i64_arg(tcg_constant_i64(-1)));
+            }
+        }
+        break;
     default:
         g_assert_not_reached();
     }
+    va_end(va);
 }
 
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
@@ -2293,6 +2521,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
         return 1;
+    case INDEX_op_cmp_vec:
+        return -1;
     default:
         return 0;
     }
@@ -2451,6 +2681,16 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
         return C_O1_I2(v, v, v);
+    case INDEX_op_rvv_merge_vec:
+        return C_O1_I2(v, v, vK);
+    case INDEX_op_rvv_cmp_vi:
+        return C_O0_I1(v);
+    case INDEX_op_rvv_cmp_vx:
+        return C_O0_I2(v, r);
+    case INDEX_op_rvv_cmp_vv:
+        return C_O0_I2(v, v);
+    case INDEX_op_cmp_vec:
+        return C_O1_I2(v, v, vi);
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target.opc.h
index b80b39e1e5..8eb0daf0a7 100644
--- a/tcg/riscv/tcg-target.opc.h
+++ b/tcg/riscv/tcg-target.opc.h
@@ -10,3 +10,8 @@
  * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
  * consider these to be UNSPEC with names.
  */
+
+DEF(rvv_cmp_vi, 0, 1, 2, IMPLVEC)
+DEF(rvv_cmp_vx, 0, 2, 1, IMPLVEC)
+DEF(rvv_cmp_vv, 0, 2, 1, IMPLVEC)
+DEF(rvv_merge_vec, 1, 2, 0, IMPLVEC)
-- 
2.43.0


