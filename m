Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8658BCA0EE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjuzS-0003AL-Qp; Fri, 30 Aug 2024 02:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuzQ-00030B-2o; Fri, 30 Aug 2024 02:20:08 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuzM-00054I-Sk; Fri, 30 Aug 2024 02:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724998800; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=IqM8CusqXwvZmeZD++cOJpYHdR6dLr5r0GPX8Vv3JOU=;
 b=IbbVqR0DhQa/Z2ysG+mIyS1iaw7DSgzt0/Fg8GMw8WH/69tRWr+QYlxfHrlgjyq0ZiXPJ9oocZQeYdamX96z24JN/QZeWK5mHth6JM7AV+mHQHYz6KDCWrtucHl8Utd4vvFwlehWTxrKQ3s6sjHaMrcDoc1Aq7VBmlTzJUI++nY=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDvaU5t_1724998796) by smtp.aliyun-inc.com;
 Fri, 30 Aug 2024 14:19:57 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 06/14] tcg/riscv: Implement vector mov/dup{m/i}
Date: Fri, 30 Aug 2024 14:15:59 +0800
Message-Id: <20240830061607.1940-7-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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
 tcg/riscv/tcg-target.c.inc | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 6f8814564a..b6b4bdc269 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -303,6 +303,12 @@ typedef enum {
     OPC_VS2R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(1),
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
+
+    OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
+    OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
+    OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
+
+    OPC_VMVNR_V = 0x9e000057 | V_OPIVI,
 } RISCVInsn;
 
 /*
@@ -544,6 +550,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 static void tcg_out_opc_reg_vec(TCGContext *s, RISCVInsn opc,
                                 TCGReg d, TCGReg s1, TCGReg s2, bool vm)
 {
+    tcg_debug_assert(d >= TCG_REG_V0 && d >= TCG_REG_V0);
     tcg_out32(s, encode_r(opc, d, s1, s2) | (vm << 25));
 }
 
@@ -656,6 +663,21 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_I64:
         tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
         break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        {
+            int nf = get_vec_type_bytes(type) / riscv_vlenb;
+
+            if (nf != 0) {
+                tcg_debug_assert(is_power_of_2(nf) && nf <= 8);
+                tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1, true);
+            } else {
+                riscv_set_vec_config_vl(s, type);
+                tcg_out_opc_vv(s, OPC_VMV_V_V, ret, TCG_REG_V0, arg, true);
+            }
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1042,6 +1064,33 @@ static void tcg_out_addsub2(TCGContext *s,
     }
 }
 
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                                   TCGReg dst, TCGReg src)
+{
+    riscv_set_vec_config_vl_vece(s, type, vece);
+    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, TCG_REG_V0, src, true);
+    return true;
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, TCGReg base, intptr_t offset)
+{
+    tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
+    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
+}
+
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, int64_t arg)
+{
+    if (arg < 16 && arg >= -16) {
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, TCG_REG_V0, arg, true);
+        return;
+    }
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
+    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
+}
+
 static const struct {
     RISCVInsn op;
     bool swap;
@@ -2170,6 +2219,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a2 = args[2];
 
     switch (opc) {
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
     case INDEX_op_ld_vec:
         tcg_out_ld(s, type, a0, a1, a2);
         break;
@@ -2341,6 +2393,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
+    case INDEX_op_dup_vec:
+    case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
     default:
-- 
2.43.0


