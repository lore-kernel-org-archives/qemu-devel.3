Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F97CA0EE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjuyR-00072S-IQ; Fri, 30 Aug 2024 02:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuyP-0006vD-Oi; Fri, 30 Aug 2024 02:19:05 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuyN-0004sz-6G; Fri, 30 Aug 2024 02:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724998737; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=J48Krttc2o2DLwm9QXcAjAZXK7O6R59YUwptlmgtAbo=;
 b=F2SmCjgysYvRu3kYC2fwSAwG3MMmVJfge33vWGHb6F2AN/6a7BvBS3vAOaw6RRfh0LmxPWWdXtO+yH9dEWttEqQR8gKXH0XVn+TQISm9WiiG3fzAwWO5fjTOThvrCLdxRELVyVdqjhD2Cvn8T0qjYNcyiRO6dpeylHsaChcz/Sc=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDvaTjR_1724998733) by smtp.aliyun-inc.com;
 Fri, 30 Aug 2024 14:18:54 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 04/14] tcg/riscv: Add riscv vset{i}vli support
Date: Fri, 30 Aug 2024 14:15:57 +0800
Message-Id: <20240830061607.1940-5-zhiwei_liu@linux.alibaba.com>
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

In RISC-V, vector operations require initial configuration using
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
     or vector register group width changes.
  2. The vset instruction can be omitted when configuration
     remains unchanged.

This optimization is only effective within a single TB.
Each TB requires reconfiguration at its start, as the current
state cannot be obtained from hardware.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Signed-off-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target.c.inc | 104 +++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5ef1538aed..49d01b8775 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -119,6 +119,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define GET_VREG_SET(vlen) (vlen == 64 ? ALL_QVECTOR_REG_GROUPS : \
                              (vlen == 128 ? ALL_DVECTOR_REG_GROUPS : \
                               ALL_VECTOR_REGS))
+#define riscv_vlenb (riscv_vlen / 8)
 
 #define sextreg  sextract64
 
@@ -168,6 +169,18 @@ static bool tcg_target_const_match(int64_t val, int ct,
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
+#define V_SUMOP (0x0 << 20)
+#define V_LUMOP (0x0 << 20)
+
 typedef enum {
     OPC_ADD = 0x33,
     OPC_ADDI = 0x13,
@@ -263,6 +276,11 @@ typedef enum {
     /* Zicond: integer conditional operations */
     OPC_CZERO_EQZ = 0x0e005033,
     OPC_CZERO_NEZ = 0x0e007033,
+
+    /* V: Vector extension 1.0 */
+    OPC_VSETVLI  = 0x57 | V_OPCFG,
+    OPC_VSETIVLI = 0xc0000057 | V_OPCFG,
+    OPC_VSETVL   = 0x80000057 | V_OPCFG,
 } RISCVInsn;
 
 /*
@@ -355,6 +373,35 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
 
+typedef enum {
+    VTA_TU = 0,
+    VTA_TA,
+} RISCVVta;
+
+typedef enum {
+    VMA_MU = 0,
+    VMA_MA,
+} RISCVVma;
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
+#define LMUL_MAX 8
+
+static int32_t encode_vtypei(RISCVVta vta, RISCVVma vma,
+                            unsigned vsew, RISCVVlmul vlmul)
+{
+    return (vma & 0x1) << 7 | (vta & 0x1) << 6 | (vsew & 0x7) << 3 |
+           (vlmul & 0x7);
+}
+
 /*
  * RISC-V instruction emitters
  */
@@ -484,6 +531,12 @@ static void tcg_out_opc_reg_vec_i(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_r(opc, rd, (imm & 0x1f), vs2) | (vm << 25));
 }
 
+static void tcg_out_opc_vec_config(TCGContext *s, RISCVInsn opc,
+                                  TCGReg rd, uint32_t avl, int32_t vtypei)
+{
+    tcg_out32(s, encode_i(opc, rd, avl, vtypei));
+}
+
 /* vm=0 (vm = false) means vector masking ENABLED. */
 #define tcg_out_opc_vv(s, opc, vd, vs2, vs1, vm) \
     tcg_out_opc_reg_vec(s, opc, vd, vs1, vs2, vm);
@@ -498,12 +551,62 @@ static void tcg_out_opc_reg_vec_i(TCGContext *s, RISCVInsn opc,
 #define tcg_out_opc_vi(s, opc, vd, vs2, imm, vm) \
     tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, vm);
 
+#define tcg_out_opc_vconfig(s, opc, rd, avl, vtypei) \
+    tcg_out_opc_vec_config(s, opc, rd, avl, vtypei);
+
 /*
  * Only unit-stride addressing implemented; may extend in future.
  */
 #define tcg_out_opc_ldst_vec(s, opc, vs3_vd, rs1, vm) \
     tcg_out_opc_reg_vec(s, opc, vs3_vd, rs1, 0, vm);
 
+static void tcg_out_vsetvl(TCGContext *s, uint32_t avl, int vtypei)
+{
+    if (avl < 32) {
+        tcg_out_opc_vconfig(s, OPC_VSETIVLI, TCG_REG_ZERO, avl, vtypei);
+    } else {
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
+        tcg_out_opc_vconfig(s, OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtypei);
+    }
+}
+
+/*
+ * TODO: If the vtype value is not supported by the implementation,
+ * then the vill bit is set in vtype, the remaining bits in
+ * vtype are set to zero, and the vl register is also set to zero
+ */
+
+static __thread int prev_vtypei;
+
+#define get_vlmax(vsew) (riscv_vlen / (8 << vsew) * (LMUL_MAX))
+#define get_vec_type_bytes(type)    (type >= TCG_TYPE_V64 ? \
+                                    (8 << (type - TCG_TYPE_V64)) : 0)
+#define calc_vlmul(oprsz)    (ctzl(oprsz / riscv_vlenb))
+
+static void tcg_target_set_vec_config(TCGContext *s, TCGType type,
+                                      unsigned vece)
+{
+    unsigned vsew, oprsz, avl;
+    int vtypei;
+    RISCVVlmul vlmul;
+
+    vsew = vece;
+    oprsz = get_vec_type_bytes(type);
+    avl = oprsz / (1 << vece);
+    vlmul = oprsz > riscv_vlenb ?
+                      calc_vlmul(oprsz) : VLMUL_M1;
+    vtypei = encode_vtypei(VTA_TA, VMA_MA, vsew, vlmul);
+
+    tcg_debug_assert(avl <= get_vlmax(vsew));
+    tcg_debug_assert(vlmul <= VLMUL_RESERVED);
+    tcg_debug_assert(vsew <= MO_64);
+
+    if (vtypei != prev_vtypei) {
+        prev_vtypei = vtypei;
+        tcg_out_vsetvl(s, avl, vtypei);
+    }
+}
+
 /*
  * TCG intrinsics
  */
@@ -2152,6 +2255,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    prev_vtypei = -1;
     /* nothing to do */
 }
 
-- 
2.43.0


