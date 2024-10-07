Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162CECFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 03:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxdyQ-0005SW-Jf; Sun, 06 Oct 2024 22:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxdyO-0005OB-Dy; Sun, 06 Oct 2024 22:59:48 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxdyM-0002pI-4l; Sun, 06 Oct 2024 22:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728269980; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=ZndB91MGLQgyq0rIK9ja/XPglxS/IFjbSPoYYWLY/Y0=;
 b=QbF3hA1t2xEY+yc2a389TriTsXyoGqXa7UOFZ7P348p+J989kJ5/mg8JFUdb64LTc6K5vbTVOmNkoonxXfXl3R8ipXyn1mlT45RswbuA3nI3j9hDKW8Y6SPDjnmxK4j1r85HGyh0i2731XZmUcGnVyu9oRnFSnvplTH87wsdIdU=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLM9kI_1728269979) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 10:59:39 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v5 05/12] tcg/riscv: Add support for basic vector opcodes
Date: Mon,  7 Oct 2024 10:56:53 +0800
Message-Id: <20241007025700.47259-6-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
References: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |  2 ++
 tcg/riscv/tcg-target.c.inc     | 52 ++++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h         |  2 +-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d73a62b0f2..4c4bc99355 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -23,3 +23,5 @@ C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
+C_O1_I1(v, v)
+C_O1_I2(v, v, v)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5187cdb6ac..35338f75d4 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -310,6 +310,13 @@ typedef enum {
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 
+    OPC_VADD_VV = 0x57 | V_OPIVV,
+    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
+    OPC_VAND_VV = 0x24000057 | V_OPIVV,
+    OPC_VOR_VV = 0x28000057 | V_OPIVV,
+    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
+    OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -568,6 +575,12 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * With RVV 1.0, vs2 is the first operand, while rs1/imm is the
  * second operand.
  */
+static void tcg_out_opc_vv(TCGContext *s, RISCVInsn opc, TCGReg vd,
+                           TCGReg vs2, TCGReg vs1, bool vm)
+{
+    tcg_out32(s, encode_v(opc, vd, vs1, vs2, vm));
+}
+
 static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc, TCGReg vd,
                            TCGReg vs2, TCGReg rs1, bool vm)
 {
@@ -2232,6 +2245,30 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
+    case INDEX_op_add_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VADD_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_sub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_and_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_or_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_xor_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_not_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2251,6 +2288,13 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_not_vec:
+        return 1;
     default:
         return 0;
     }
@@ -2401,6 +2445,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_not_vec:
+        return C_O1_I1(v, v);
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+        return C_O1_I2(v, v, v);
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 12a7a37aaa..acb8dfdf16 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -151,7 +151,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_vec         0
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
-- 
2.43.0


