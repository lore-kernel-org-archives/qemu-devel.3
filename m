Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FE1C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmS-0005Xm-MY; Sun, 16 Feb 2025 18:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmL-0005Up-37
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmG-0005CU-Cu
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:24 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22128b7d587so7725855ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747419; x=1740352219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5HhJ/ohARWwH30htvxxoFtKBuw007KzgTO6yl1HBSGk=;
 b=I4OVfjJNCrmAL32wGGPp3Xztv2kjQ2DTA1u6XPsQoJcbHUxxphn4jV4FYTnBDaCR5F
 uuHEP60EEM/Nv1gWTyrhGf4+1GeJmpPulRHkr5zsajoAQUOgRB71302pltzIpX3KwD9Q
 nHQ31zVele5JQNhGw6c94kn3W0ap5eByXbpQ+RYlNVh9hfmwK4iShvZTSUXvhwUSSLXK
 pcqbFxvZDrhDKqT2eqB5Ljyn+uVvbewEdw4UROqQnn7E6gpe/Ax/PbpVM2v/RwtWYJCf
 NjMb6HZJnGf/Ihd6xMKqh1yywhqQRk+O7FNm8PsM0L9hPqP/r+ewrf1S+yCnxR/+9Bkb
 VNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747419; x=1740352219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HhJ/ohARWwH30htvxxoFtKBuw007KzgTO6yl1HBSGk=;
 b=tUT3uicMleItF9vn1S9SLhrlPlw3kZPZb+N2yBTPqM/6BtZl/63nxtcjY+HLkK0QT3
 bSUO1OZi2DkP+Ejc14ORAjxg8tVRNj6H6YYaA7jpIZPng7Z+3DnW/oPktEINPlJ39IEm
 skx8fjZjDxIyXWrZfoa8cARoPnPK19+VJyOQ9Kp8LSPmsZWoc5TNiy5EE3xyP/Q0U5Yr
 DKIvfkQRiSv24cfa0ffs8jB8IClppobVHfdyvzSKmA97XqRyR2H/guROdPea6RCYEM/9
 bju0c1mQnl3QR47awj12RpF44Gvv3+q5r4BiDrHPPV50y2JYroSLevmMgwitfmCL9TQ4
 lmOQ==
X-Gm-Message-State: AOJu0YzeZwIHvcVmjrajOZBOdkDTafVlkGgtqcofjInjGZn9oEO6iAuK
 GoV3i0RH5HRcHrNJUDJ84b6MXxIItc/3NZz8rks6nevxz2txMP6BhMN2Vim5nzGpPUM7U5/SoC2
 4
X-Gm-Gg: ASbGncux7aOTQLRNpsN2f608srQb4vz3vCteI6cWDURsejFkW2tZYz3tE88rKEY5K8J
 Of3kQcPSEWCeHmxpUCXhgYRTw/9hizn0lA5qYCotsOyOYWo+JYu1EThRUc7HrawBCH8irRCjxWA
 qq+xcPGuRnXWKJ91Iu/oJjQC65RCsLJGvSaxdINMnnHUyP1P2xkRoCsz950jdvm/b/dxPJGueaN
 FyWg+zS3MKrpg8Vhb4PS/2nrf5jlro/kCtsR280K2/88PxQ+2XhmtSpedgIqBTqV4PNmNwNSEdD
 HI42let6MMP3jQRtYwCi9pgd8aE6HRrFszKfnRW1AunWCvY=
X-Google-Smtp-Source: AGHT+IHKWQ62cUTNBF9xtm1lDeNtsA+lZtR72OGLtG3DuzIH+yPJ1d6aHRRM8Mj0L0230eH34X8pmw==
X-Received: by 2002:a17:903:230c:b0:220:e9f5:4b7c with SMTP id
 d9443c01a7336-221040297b3mr102186035ad.17.1739747418578; 
 Sun, 16 Feb 2025 15:10:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 006/162] tcg: Convert and to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:07:35 -0800
Message-ID: <20250216231012.2808572-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  4 +++
 tcg/aarch64/tcg-target.c.inc     | 31 ++++++++++--------
 tcg/arm/tcg-target.c.inc         | 41 +++++++++++++++++-------
 tcg/i386/tcg-target.c.inc        | 27 ++++++++++++----
 tcg/loongarch64/tcg-target.c.inc | 29 ++++++++++-------
 tcg/mips/tcg-target.c.inc        | 55 +++++++++++++++++++-------------
 tcg/ppc/tcg-target.c.inc         | 40 ++++++++++++-----------
 tcg/riscv/tcg-target.c.inc       | 29 ++++++++++-------
 tcg/s390x/tcg-target.c.inc       | 48 +++++++++++++++-------------
 tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++---
 tcg/tci/tcg-target.c.inc         | 14 ++++++--
 11 files changed, 216 insertions(+), 125 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index cab4844684..68afee4423 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1005,6 +1005,8 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_and_i32, TCGOutOpBinary, outop_and),
+    OUTOP(INDEX_op_and_i64, TCGOutOpBinary, outop_and),
 };
 
 #undef OUTOP
@@ -5436,6 +5438,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_add:
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a181b7e65a..b7d11887e3 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2128,6 +2128,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, AND, type, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_logicali(s, I3404_ANDI, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rL),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2209,17 +2227,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_and_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_and_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3510, AND, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_andc_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3009,8 +3016,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 4b7358a4e8..d4bd158080 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -880,17 +880,23 @@ static void tcg_out_dat_rI(TCGContext *s, ARMCond cond, ARMInsn opc,
  * Emit either the reg,imm or reg,reg form of a data-processing insn.
  * rhs must satisfy the "rIK" constraint.
  */
+static void tcg_out_dat_IK(TCGContext *s, ARMCond cond, ARMInsn opc,
+                            ARMInsn opinv, TCGReg dst, TCGReg lhs, TCGArg rhs)
+{
+    int imm12 = encode_imm(rhs);
+    if (imm12 < 0) {
+        imm12 = encode_imm_nofail(~rhs);
+        opc = opinv;
+    }
+    tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+}
+
 static void tcg_out_dat_rIK(TCGContext *s, ARMCond cond, ARMInsn opc,
                             ARMInsn opinv, TCGReg dst, TCGReg lhs, TCGArg rhs,
                             bool rhs_is_const)
 {
     if (rhs_is_const) {
-        int imm12 = encode_imm(rhs);
-        if (imm12 < 0) {
-            imm12 = encode_imm_nofail(~rhs);
-            opc = opinv;
-        }
-        tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+        tcg_out_dat_IK(s, cond, opc, opinv, dst, lhs, rhs);
     } else {
         tcg_out_dat_reg(s, cond, opc, dst, lhs, rhs, SHIFT_IMM_LSL(0));
     }
@@ -1852,6 +1858,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_AND, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IK(s, COND_AL, ARITH_AND, ARITH_BIC, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rIK),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1914,10 +1938,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_and_i32:
-        tcg_out_dat_rIK(s, COND_AL, ARITH_AND, ARITH_BIC,
-                        args[0], args[1], args[2], const_args[2]);
-        break;
     case INDEX_op_andc_i32:
         tcg_out_dat_rIK(s, COND_AL, ARITH_BIC, ARITH_AND,
                         args[0], args[1], args[2], const_args[2]);
@@ -2175,7 +2195,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
-    case INDEX_op_and_i32:
     case INDEX_op_andc_i32:
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 1115d1e38d..01010dfdc0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2595,6 +2595,26 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_AND + rexw, a0, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_AND + rexw, a0, a2, 0);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, 0, reZ),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2679,9 +2699,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(and):
-        c = ARITH_AND;
-        goto gen_arith;
     OP_32_64(or):
         c = ARITH_OR;
         goto gen_arith;
@@ -3625,10 +3642,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        return C_O1_I2(r, 0, reZ);
-
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
         return C_O1_I2(r, r, rI);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 08106b6e4c..b7b94ca6cd 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1291,6 +1291,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tcg_out_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_and(s, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_andi(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1361,15 +1379,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        if (c2) {
-            tcg_out_opc_andi(s, a0, a1, a2);
-        } else {
-            tcg_out_opc_and(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
         if (c2) {
@@ -2284,8 +2293,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
     case INDEX_op_or_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 263e7e66c9..460f73d06a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1676,6 +1676,38 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int msb;
+
+    if (a2 == (uint16_t)a2) {
+        tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
+        return;
+    }
+
+    tcg_debug_assert(use_mips32r2_instructions);
+    tcg_debug_assert(is_p2m1(a2));
+    msb = ctz64(~a2) - 1;
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_bf(s, OPC_EXT, a0, a1, msb, 0);
+    } else {
+        tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1, msb, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rIK),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1776,26 +1808,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             break;
         }
         goto do_binaryv;
-    case INDEX_op_and_i32:
-        if (c2 && a2 != (uint16_t)a2) {
-            int msb = ctz32(~a2) - 1;
-            tcg_debug_assert(use_mips32r2_instructions);
-            tcg_debug_assert(is_p2m1(a2));
-            tcg_out_opc_bf(s, OPC_EXT, a0, a1, msb, 0);
-            break;
-        }
-        i1 = OPC_AND, i2 = OPC_ANDI;
-        goto do_binary;
-    case INDEX_op_and_i64:
-        if (c2 && a2 != (uint16_t)a2) {
-            int msb = ctz64(~a2) - 1;
-            tcg_debug_assert(use_mips32r2_instructions);
-            tcg_debug_assert(is_p2m1(a2));
-            tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1, msb, 0);
-            break;
-        }
-        i1 = OPC_AND, i2 = OPC_ANDI;
-        goto do_binary;
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
         i1 = OPC_NOR;
@@ -2202,9 +2214,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        return C_O1_I2(r, r, rIK);
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_or_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6b27238499..3d34edfa79 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2921,6 +2921,28 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, AND | SAB(a1, a0, a2));
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_andi32(s, a0, a1, a2);
+    } else {
+        tcg_out_andi64(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3006,22 +3028,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
-        }
-        break;
-    case INDEX_op_and_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi64(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_or_i64:
     case INDEX_op_or_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -4129,7 +4135,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_andc_i32:
@@ -4140,7 +4145,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 135137ff53..7f585bc4f9 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1978,6 +1978,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2056,15 +2074,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
         if (c2) {
@@ -2664,10 +2673,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index f5441d2033..d60bdaba25 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2196,6 +2196,31 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, NR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
+    }
+}
+
+static void tgen_andi_3(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_andi(s, type, a0, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rNKR),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi_3,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2264,17 +2289,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_andi(s, TCG_TYPE_I32, a0, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, NR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_or_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2535,15 +2549,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_andi(s, TCG_TYPE_I64, args[0], args[2]);
-        } else {
-            tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_or_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3274,12 +3279,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_and_i64:
-        return C_O1_I2(r, r, rNKR);
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index f43d95b025..b3fbe127c0 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1304,6 +1304,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_AND);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_AND);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1361,9 +1379,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(and):
-        c = ARITH_AND;
-        goto gen_arith;
     OP_32_64(andc):
         c = ARITH_ANDN;
         goto gen_arith;
@@ -1589,8 +1604,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
     case INDEX_op_or_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 726b645da8..fd38ecad39 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -95,8 +95,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
     case INDEX_op_eqv_i32:
@@ -650,6 +648,17 @@ static const TCGOutOpBinary outop_add = {
     .out_rrr = tgen_add,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_and_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_and,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -694,7 +703,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(and)
     CASE_32_64(or)
     CASE_32_64(xor)
     CASE_32_64(andc)     /* Optional (TCG_TARGET_HAS_andc_*). */
-- 
2.43.0


