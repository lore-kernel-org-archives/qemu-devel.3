Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A084ACA0EE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjuyt-0000hT-3A; Fri, 30 Aug 2024 02:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuyr-0000UO-9x; Fri, 30 Aug 2024 02:19:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuyp-0004y2-2C; Fri, 30 Aug 2024 02:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724998767; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=c4HO13LDwm2CxmhfL6yZRYdgk7zLX2asTNksynkRnzk=;
 b=M0/m7z7R20kFWDM5fpX9BdBHjqnw4xqJk+BPDkD0s9Q2MFbPZe7Mdwsp1nyI/ZY895OmDHyp398rV6Ic5pa0spauz/y9tQOsIBiN/msBoiAtdqGCW2uPGcKOFRImym8HH5To5k4W6/55XVMQFVXFbDzSvo+oKn5r3XdhHc9tMf8=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDvarzk_1724998765) by smtp.aliyun-inc.com;
 Fri, 30 Aug 2024 14:19:26 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 05/14] tcg/riscv: Implement vector load/store
Date: Fri, 30 Aug 2024 14:15:58 +0800
Message-Id: <20240830061607.1940-6-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target-con-set.h |   2 +
 tcg/riscv/tcg-target.c.inc     | 169 ++++++++++++++++++++++++++++++++-
 2 files changed, 167 insertions(+), 4 deletions(-)

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
index 49d01b8775..6f8814564a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -178,8 +178,11 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define V_OPMVX (0x6 << 12)
 #define V_OPCFG (0x7 << 12)
 
-#define V_SUMOP (0x0 << 20)
-#define V_LUMOP (0x0 << 20)
+#define V_UNIT_STRIDE (0x0 << 20)
+#define V_UNIT_STRIDE_WHOLE_REG (0x8 << 20)
+
+/* NF <= 7 && BNF >= 0 */
+#define V_NF(x) (x << 29)
 
 typedef enum {
     OPC_ADD = 0x33,
@@ -281,6 +284,25 @@ typedef enum {
     OPC_VSETVLI  = 0x57 | V_OPCFG,
     OPC_VSETIVLI = 0xc0000057 | V_OPCFG,
     OPC_VSETVL   = 0x80000057 | V_OPCFG,
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
@@ -607,6 +629,19 @@ static void tcg_target_set_vec_config(TCGContext *s, TCGType type,
     }
 }
 
+static int riscv_set_vec_config_vl(TCGContext *s, TCGType type)
+{
+    int prev_vsew = prev_vtypei < 0 ? MO_8 : ((prev_vtypei >> 3) & 0x7);
+    tcg_target_set_vec_config(s, type, prev_vsew);
+    return prev_vsew;
+}
+
+static void riscv_set_vec_config_vl_vece(TCGContext *s, TCGType type,
+                                         unsigned vece)
+{
+    tcg_target_set_vec_config(s, type, vece);
+}
+
 /*
  * TCG intrinsics
  */
@@ -799,6 +834,17 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_SD:
         tcg_out_opc_store(s, opc, addr, data, imm12);
         break;
+    case OPC_VSE8_V:
+    case OPC_VSE16_V:
+    case OPC_VSE32_V:
+    case OPC_VSE64_V:
+    case OPC_VS1R_V:
+    case OPC_VS2R_V:
+    case OPC_VS4R_V:
+    case OPC_VS8R_V:
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, imm12);
+        tcg_out_opc_ldst_vec(s, opc, data, TCG_REG_TMP0, true);
+        break;
     case OPC_LB:
     case OPC_LBU:
     case OPC_LH:
@@ -808,6 +854,17 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_LD:
         tcg_out_opc_imm(s, opc, data, addr, imm12);
         break;
+    case OPC_VLE8_V:
+    case OPC_VLE16_V:
+    case OPC_VLE32_V:
+    case OPC_VLE64_V:
+    case OPC_VL1RE64_V:
+    case OPC_VL2RE64_V:
+    case OPC_VL4RE64_V:
+    case OPC_VL8RE64_V:
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, imm12);
+        tcg_out_opc_ldst_vec(s, opc, data, TCG_REG_TMP0, true);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -816,14 +873,101 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
+    RISCVInsn insn;
+
+    if (type < TCG_TYPE_V64) {
+        insn = (type == TCG_TYPE_I32) ? OPC_LW : OPC_LD;
+    } else {
+        int nf = get_vec_type_bytes(type) / riscv_vlenb;
+
+        switch (nf) {
+        case 1:
+            insn = OPC_VL1RE64_V;
+            break;
+        case 2:
+            insn = OPC_VL2RE64_V;
+            break;
+        case 4:
+            insn = OPC_VL4RE64_V;
+            break;
+        case 8:
+            insn = OPC_VL8RE64_V;
+            break;
+        default:
+            {
+                int prev_vsew = riscv_set_vec_config_vl(s, type);
+
+                switch (prev_vsew) {
+                case MO_8:
+                    insn = OPC_VLE8_V;
+                    break;
+                case MO_16:
+                    insn = OPC_VLE16_V;
+                    break;
+                case MO_32:
+                    insn = OPC_VLE32_V;
+                    break;
+                case MO_64:
+                    insn = OPC_VLE64_V;
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+            break;
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
+        insn = (type == TCG_TYPE_I32) ? OPC_SW : OPC_SD;
+        tcg_out_ldst(s, insn, arg, arg1, arg2);
+    } else {
+        int nf = get_vec_type_bytes(type) / riscv_vlenb;
+
+        switch (nf) {
+        case 1:
+            insn = OPC_VS1R_V;
+            break;
+        case 2:
+            insn = OPC_VS2R_V;
+            break;
+        case 4:
+            insn = OPC_VS4R_V;
+            break;
+        case 8:
+            insn = OPC_VS8R_V;
+            break;
+        default:
+            {
+                int prev_vsew = riscv_set_vec_config_vl(s, type);
+
+                switch (prev_vsew) {
+                case MO_8:
+                    insn = OPC_VSE8_V;
+                    break;
+                case MO_16:
+                    insn = OPC_VSE16_V;
+                    break;
+                case MO_32:
+                    insn = OPC_VSE32_V;
+                    break;
+                case MO_64:
+                    insn = OPC_VSE64_V;
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+            break;
+        }
+    }
     tcg_out_ldst(s, insn, arg, arg1, arg2);
 }
 
@@ -2018,7 +2162,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -2182,6 +2339,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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


