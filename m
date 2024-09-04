Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC424CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr20-0005Xs-57; Wed, 04 Sep 2024 10:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr1u-00058Z-O3; Wed, 04 Sep 2024 10:30:46 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1slr1s-0003ip-7A; Wed, 04 Sep 2024 10:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725460235; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=grNMnSmhhgECAmdk8+H95IzGzaBc/5MinvNZPJbGdiE=;
 b=duQ1hieODbi6dJ1sZiXufLxc8KVrZFgQ52c02cmA6pYrI3S2Mh4AXjCieVmS2XNSDZHnM6aG0xUMLQCabytG21Puo98Op5jh5ZV4ibIa0XjE//RR5vMnZkeLyiuQMVwazkIMvQ749PMLpZyYPwCrs8Z17UQcxUyPT5+Eusop/W4=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEIASGw_1725460233) by smtp.aliyun-inc.com;
 Wed, 04 Sep 2024 22:30:34 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v3 04/14] tcg/riscv: Add riscv vset{i}vli support
Date: Wed,  4 Sep 2024 22:27:29 +0800
Message-Id: <20240904142739.854-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
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
 include/tcg/tcg.h          |   3 +
 tcg/riscv/tcg-target.c.inc | 128 +++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..267e6ff95c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -566,6 +566,9 @@ struct TCGContext {
 
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
+
+    /* For host-specific values. */
+    int riscv_host_vtype;
 };
 
 static inline bool temp_readonly(TCGTemp *ts)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c3f018ff0c..df96d350a3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -165,6 +165,26 @@ static bool tcg_target_const_match(int64_t val, int ct,
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
@@ -260,6 +280,11 @@ typedef enum {
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
@@ -370,6 +395,26 @@ static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
            (s2 & 0x1f) << 20 | (vm << 25);
 }
 
+/* Vector Configuration */
+
+static uint32_t encode_vtype(bool vta, bool vma,
+                            MemOp vsew, RISCVVlmul vlmul)
+{
+    return vma << 7 | vta << 6 | vsew << 3 | vlmul;
+}
+
+static int32_t encode_vcfg(RISCVInsn opc, TCGReg rd,
+                           TCGArg rs1, uint32_t vtype)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (vtype & 0x7ff) << 20;
+}
+
+static int32_t encode_vcfgi(RISCVInsn opc, TCGReg rd,
+                            uint32_t uimm, uint32_t vtype)
+{
+    return opc | (rd & 0x1f) << 7 | (uimm & 0x1f) << 15 | (vtype & 0x3ff) << 20;
+}
+
 /*
  * RISC-V instruction emitters
  */
@@ -519,6 +564,88 @@ static void tcg_out_opc_ldst_vec(TCGContext *s, RISCVInsn opc, TCGReg data,
     tcg_out32(s, encode_v(opc, data, rs1, 0, vm));
 }
 
+static void tcg_out_opc_vec_config(TCGContext *s, RISCVInsn opc,
+                                  TCGReg rd, TCGReg rs1, int32_t vtype)
+{
+    tcg_out32(s, encode_vcfg(opc, rd, rs1, vtype));
+}
+
+static void tcg_out_opc_vec_configi(TCGContext *s, RISCVInsn opc,
+                                  TCGReg rd, uint32_t avl, int32_t vtype)
+{
+    tcg_out32(s, encode_vcfgi(opc, rd, avl, vtype));
+}
+
+static void tcg_out_vset(TCGContext *s, uint32_t avl, int vtype)
+{
+    if (avl < 32) {
+        vtype = sextreg(vtype, 0, 10);
+        tcg_out_opc_vec_configi(s, OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
+    } else {
+        vtype = sextreg(vtype, 0, 11);
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
+        tcg_out_opc_vec_config(s, OPC_VSETVLI, TCG_REG_ZERO,
+                               TCG_REG_TMP0, vtype);
+    }
+}
+
+/* LMUL_MAX = 8, vlmax = vlen / sew * LMUL_MAX. */
+static unsigned get_vlmax(MemOp vsew)
+{
+    return riscv_vlen / (8 << vsew) * 8;
+}
+
+static unsigned get_vec_type_bytes(TCGType type)
+{
+    tcg_debug_assert(type >= TCG_TYPE_V64);
+    return 8 << (type - TCG_TYPE_V64);
+}
+
+static RISCVVlmul calc_vlmul(MemOp vsew, unsigned oprsz)
+{
+    if (oprsz > riscv_vlenb) {
+        return ctzl(oprsz / riscv_vlenb);
+    } else {
+        if (vsew < MO_64) {
+            switch (riscv_vlenb / oprsz) {
+            case 2:
+                return VLMUL_MF2;
+            case 4:
+                return VLMUL_MF4;
+            case 8:
+                return VLMUL_MF8;
+            default:
+                break;
+            }
+        }
+    }
+    return VLMUL_M1;
+}
+
+static void tcg_target_set_vec_config(TCGContext *s, TCGType type,
+                                      MemOp vsew)
+{
+    unsigned oprsz, avl;
+    int vtype;
+    RISCVVlmul vlmul;
+
+    tcg_debug_assert(vsew <= MO_64);
+
+    oprsz = get_vec_type_bytes(type);
+    avl = oprsz / (1 << vsew);
+    vlmul = calc_vlmul(vsew, oprsz);
+
+    tcg_debug_assert(avl <= get_vlmax(vsew));
+    tcg_debug_assert(vlmul <= VLMUL_MF2);
+
+    vtype = encode_vtype(false, false, vsew, vlmul);
+
+    if (vtype != s->riscv_host_vtype) {
+        s->riscv_host_vtype = vtype;
+        tcg_out_vset(s, avl, vtype);
+    }
+}
+
 /*
  * TCG intrinsics
  */
@@ -2167,6 +2294,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    s->riscv_host_vtype = -1;
     /* nothing to do */
 }
 
-- 
2.43.0


