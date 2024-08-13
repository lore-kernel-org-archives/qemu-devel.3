Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B68C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdprD-00079E-9l; Tue, 13 Aug 2024 07:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpr7-0006wO-IV; Tue, 13 Aug 2024 07:38:27 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpr2-0002mO-Qh; Tue, 13 Aug 2024 07:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723549093; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=4caXpcnBVCZB2n4y1+rDuHT9XRwbTsjdRnqhWeySDsU=;
 b=oTlYcbzDCP287wd7SF+jMqh7QyJZDEyPYp1zcVixNcLp2erqi1MlXJF7AhdHUrnsEfetfC3XZRLlu0JGoiX4nm08QvglbSwdzhAEgagT1kGlRuGzoSHRb0kEUAVdm/k06wMNZOpft6ScpK8aDSgHH3sBHti5koowQ6Sc7tN4RrI=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCp.96L_1723549092) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:38:12 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 06/15] tcg/riscv: Implement vector load/store
Date: Tue, 13 Aug 2024 19:34:27 +0800
Message-Id: <20240813113436.831-7-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target-con-set.h |  2 +
 tcg/riscv/tcg-target.c.inc     | 92 ++++++++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 3 deletions(-)

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
index d17f523187..f17d679d71 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -279,6 +279,15 @@ typedef enum {
     OPC_VSETVLI  = 0x57 | V_OPCFG,
     OPC_VSETIVLI = 0xc0000057 | V_OPCFG,
     OPC_VSETVL   = 0x80000057 | V_OPCFG,
+
+    OPC_VLE8_V  = 0x7 | V_LUMOP,
+    OPC_VLE16_V = 0x5007 | V_LUMOP,
+    OPC_VLE32_V = 0x6007 | V_LUMOP,
+    OPC_VLE64_V = 0x7007 | V_LUMOP,
+    OPC_VSE8_V  = 0x27 | V_SUMOP,
+    OPC_VSE16_V = 0x5027 | V_SUMOP,
+    OPC_VSE32_V = 0x6027 | V_SUMOP,
+    OPC_VSE64_V = 0x7027 | V_SUMOP,
 } RISCVInsn;
 
 /*
@@ -810,6 +819,13 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_SD:
         tcg_out_opc_store(s, opc, addr, data, imm12);
         break;
+    case OPC_VSE8_V:
+    case OPC_VSE16_V:
+    case OPC_VSE32_V:
+    case OPC_VSE64_V:
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, imm12);
+        tcg_out_opc_ldst_vec(s, opc, data, TCG_REG_TMP0, true);
+        break;
     case OPC_LB:
     case OPC_LBU:
     case OPC_LH:
@@ -819,6 +835,13 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_LD:
         tcg_out_opc_imm(s, opc, data, addr, imm12);
         break;
+    case OPC_VLE8_V:
+    case OPC_VLE16_V:
+    case OPC_VLE32_V:
+    case OPC_VLE64_V:
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, imm12);
+        tcg_out_opc_ldst_vec(s, opc, data, TCG_REG_TMP0, true);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -827,14 +850,59 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
+    RISCVInsn insn;
+
+    if (type < TCG_TYPE_V64) {
+        insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
+    } else {
+        tcg_debug_assert(arg >= TCG_REG_V1);
+        switch (prev_vece) {
+        case MO_8:
+            insn = OPC_VLE8_V;
+            break;
+        case MO_16:
+            insn = OPC_VLE16_V;
+            break;
+        case MO_32:
+            insn = OPC_VLE32_V;
+            break;
+        case MO_64:
+            insn = OPC_VLE64_V;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
     tcg_out_ldst(s, insn, arg, arg1, arg2);
 }
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SW : OPC_SD;
+    RISCVInsn insn;
+
+    if (type < TCG_TYPE_V64) {
+        insn = type == TCG_TYPE_I32 ? OPC_SW : OPC_SD;
+        tcg_out_ldst(s, insn, arg, arg1, arg2);
+    } else {
+        tcg_debug_assert(arg >= TCG_REG_V1);
+        switch (prev_vece) {
+        case MO_8:
+            insn = OPC_VSE8_V;
+            break;
+        case MO_16:
+            insn = OPC_VSE16_V;
+            break;
+        case MO_32:
+            insn = OPC_VSE32_V;
+            break;
+        case MO_64:
+            insn = OPC_VSE64_V;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
     tcg_out_ldst(s, insn, arg, arg1, arg2);
 }
 
@@ -2030,11 +2098,25 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg a0, a1, a2;
+
+    a0 = args[0];
+    a1 = args[1];
+    a2 = args[2];
 
-    if (vec_vtpye_init) {
+    if (!vec_vtpye_init &&
+        (opc == INDEX_op_ld_vec || opc == INDEX_op_st_vec)) {
+        tcg_target_set_vec_config(s, type, prev_vece);
+    } else {
         tcg_target_set_vec_config(s, type, vece);
     }
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
@@ -2198,6 +2280,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
 
+    case INDEX_op_st_vec:
+        return C_O0_I2(v, r);
+    case INDEX_op_ld_vec:
+        return C_O1_I1(v, r);
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


