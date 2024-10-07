Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A51CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 02:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxdxz-0004nl-Mr; Sun, 06 Oct 2024 22:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxdxt-0004kA-PP; Sun, 06 Oct 2024 22:59:17 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sxdxr-0002oc-AH; Sun, 06 Oct 2024 22:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1728269950; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=w8Lx1g9UTqUJw4++FBNmopFsdQHo5Omd6l7285PLmsQ=;
 b=BlvB5yNCkohe+t0JeWDEKDpVx6HfndAQemsvsHBoLVZgtanJx6vZ+eDqPe24+wkM1zm5LFlHRdQ5bW8K9yc8nERKj+KMexeMWBnx2h82IHYEi9CzNCkB1ZGlC8u7FQFaxWP+Ol50sOhB/4FdJGRDCF8x4f/STXOC2aIMtoEuYYw=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WGLJYLg_1728269947) by smtp.aliyun-inc.com;
 Mon, 07 Oct 2024 10:59:08 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v5 04/12] tcg/riscv: Implement vector mov/dup{m/i}
Date: Mon,  7 Oct 2024 10:56:52 +0800
Message-Id: <20241007025700.47259-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
References: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
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
 tcg/riscv/tcg-target.c.inc | 73 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index aacb1ae28e..5187cdb6ac 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -309,6 +309,12 @@ typedef enum {
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
@@ -401,6 +407,16 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
 
+
+/* Type-OPIVI */
+
+static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
+                         TCGReg vs2, bool vm)
+{
+    return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
+           (vs2 & 0x1f) << 20 | (vm << 25);
+}
+
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
 
 static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
@@ -546,6 +562,24 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * RISC-V vector instruction emitters
  */
 
+/*
+ * Vector registers uses the same 5 lower bits as GPR registers,
+ * and vm=0 (vm = false) means vector masking ENABLED.
+ * With RVV 1.0, vs2 is the first operand, while rs1/imm is the
+ * second operand.
+ */
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
 /*
  * Only unit-stride addressing implemented; may extend in future.
  */
@@ -628,6 +662,13 @@ static MemOp set_vtype_len(TCGContext *s, TCGType type)
     return s->riscv_cur_vsew;
 }
 
+static void set_vtype_len_sew(TCGContext *s, TCGType type, MemOp vsew)
+{
+    if (type != s->riscv_cur_type || vsew != s->riscv_cur_vsew) {
+        set_vtype(s, type, vsew);
+    }
+}
+
 /*
  * TCG intrinsics
  */
@@ -642,6 +683,15 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_I64:
         tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
         break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        {
+            int lmul = type - riscv_lg2_vlenb;
+            int nf = 1 << MAX(lmul, 0);
+            tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1, true);
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1005,18 +1055,32 @@ static void tcg_out_addsub2(TCGContext *s,
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                                    TCGReg dst, TCGReg src)
 {
-    return false;
+    set_vtype_len_sew(s, type, vece);
+    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, TCG_REG_V0, src, true);
+    return true;
 }
 
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                                     TCGReg dst, TCGReg base, intptr_t offset)
 {
-    return false;
+    tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
+    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
                                     TCGReg dst, int64_t arg)
 {
+    if (arg >= -16 && arg < 16) {
+        if (arg == 0 || arg == -1) {
+            set_vtype_len(s, type);
+        } else {
+            set_vtype_len_sew(s, type, vece);
+        }
+        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, TCG_REG_V0, arg, true);
+        return;
+    }
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
+    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static const struct {
@@ -2159,6 +2223,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a2 = args[2];
 
     switch (opc) {
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
     case INDEX_op_ld_vec:
         tcg_out_ld(s, type, a0, a1, a2);
         break;
@@ -2330,6 +2397,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
+    case INDEX_op_dup_vec:
+    case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
     default:
-- 
2.43.0


