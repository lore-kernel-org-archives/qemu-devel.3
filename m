Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB704C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnn3-0006Gi-3v; Sun, 16 Feb 2025 18:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmf-0005dY-Ih
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmc-0005I1-CG
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:45 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso76902945ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747440; x=1740352240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4+awYRO+uqyYD2yTwS8VdoJEg1itW3qyoxaIzCaJ3eQ=;
 b=s81J5jpAl1CsAxUZmzzxwG/h6vujKe4JTb1lKb6ekTtbRt336Vc2IsGa2F/P6MXHjj
 4oEuU6e2Olz+TtZLBzTgwyS2KU1QoHnhG7HJx2C10xpMGQmdjllDsbr+wm81+m5pAlCc
 4anbi6kaFOX8fkqj63jTiWNmJwr37CT17hrWkfvu+iW/HjVcD/xW2TFWos/TWQMZeru8
 BDMd/BV7XMEDbSl3JrBxOFEkDNegkp5FoKR6vZgmoZnpbOriCWthk8JbDG99Z+43Mj1n
 /gDN+reUausGanPdAPGxzYIIPKBV7IL7JHkwnuEuZ0W2hfxRilONuzTa61QET3xr0f7U
 o7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747440; x=1740352240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+awYRO+uqyYD2yTwS8VdoJEg1itW3qyoxaIzCaJ3eQ=;
 b=SSEY7RvdkrxJMRLQi28NJ/+fCK+fC8yQ92839cpYIRaa6MTRa62fdqd9phabSVSngW
 NB9utL89omebNL8FewxKzaVWQnNzaEcRprs62YHdV0qpRJmwER8PX2DXIm0PPl8aOghs
 8DjHSBt1wQ1vrT5dmSOHtO+UXWb0lKSnNXljU7cyDZ4K12j1CNIKCTxAsinVXTdeZznL
 1T3sD0XBk6Nn9itaD+04vNJoFrWmNZci4tcmwoSUp+PxOLQo6u5iLy5umqRhg2ospAAq
 4CvxrpFNXKA0YujiGITtZymAHmYUm2PMJ4uar/2EsRHtzChVjX0yep4NvO142Ipd2Ye/
 Dk6A==
X-Gm-Message-State: AOJu0YwD6zGAnDP4ogQlnWnRO7mmu70vDwcoUpjgp+NRB7wYxN56HaT/
 Qr22QLmTMRlKg3lijjbK5wPfWlxBvraSXxy5v+ks5r0TmHlD1tlHcQev8SATjZKgfsyT0iB6pwf
 Y
X-Gm-Gg: ASbGncvVoOnMmhMXpCGY5E1B3BOYGFuxJV3us60loAgkoUJjitmnzX0x/6gqgqgEaH4
 QStyQT3O/P7qyj0bZr82hTvRHE4aGXoQaovfkab7heMDv8zgWkwM/pFDiAixY3nIY2DtAWBfx+o
 Wffkrlc9q0T2JNJmpFXv4kz+4R+sxO6UXFpV0Ulk0k2idLhXY+HT/H4h5cyxd1lzahiJKy1zT+N
 pRt1uEQVBRytYgvVB8IeJ+Mly/ek7D3KZ6SsulBDfZx0DNPT1frGlF1v75+sedoAZfFZj1yZuon
 xELYXkXENx5avskMfys8BV0rVPTf09K81qOJpbLqbXgfOf0=
X-Google-Smtp-Source: AGHT+IEJ60maeB1cmY1LkwOAi3Dbu2u75JN4W31lkUkq5ae73Nm8M9P/XtHqUH3aTQP6fnmK1GpPKA==
X-Received: by 2002:a17:902:d502:b0:21d:dfae:300b with SMTP id
 d9443c01a7336-22103ef5265mr136404865ad.10.1739747439621; 
 Sun, 16 Feb 2025 15:10:39 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 034/162] tcg: Convert mul to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:03 -0800
Message-ID: <20250216231012.2808572-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/tcg.c                        |  6 ++-
 tcg/aarch64/tcg-target.c.inc     | 18 ++++---
 tcg/arm/tcg-target.c.inc         | 23 ++++----
 tcg/i386/tcg-target.c.inc        | 47 +++++++++-------
 tcg/loongarch64/tcg-target.c.inc | 24 +++++----
 tcg/mips/tcg-target.c.inc        | 43 +++++++++------
 tcg/ppc/tcg-target.c.inc         | 42 +++++++--------
 tcg/riscv/tcg-target.c.inc       | 21 ++++----
 tcg/s390x/tcg-target.c.inc       | 92 ++++++++++++++++++--------------
 tcg/sparc64/tcg-target.c.inc     | 28 +++++++---
 tcg/tci/tcg-target.c.inc         | 14 +++--
 11 files changed, 210 insertions(+), 148 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c7619b79a0..2f046b5028 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1021,6 +1021,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_mul_i32, TCGOutOpBinary, outop_mul),
+    OUTOP(INDEX_op_mul_i64, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
@@ -2247,7 +2249,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_mul_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -2313,7 +2314,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_mul_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -5430,6 +5430,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
     case INDEX_op_nand:
     case INDEX_op_nor:
     case INDEX_op_or:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 97b444bc17..4513140f58 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2168,6 +2168,17 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3509, MADD, type, a0, a1, a2, TCG_REG_XZR);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2322,11 +2333,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_mul_i64:
-    case INDEX_op_mul_i32:
-        tcg_out_insn(s, 3509, MADD, ext, a0, a1, a2, TCG_REG_XZR);
-        break;
-
     case INDEX_op_div_i64:
     case INDEX_op_div_i32:
         tcg_out_insn(s, 3508, SDIV, ext, a0, a1, a2);
@@ -3029,8 +3035,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 665bdd3c80..b6273d3997 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -927,13 +927,6 @@ static void tcg_out_dat_rIN(TCGContext *s, ARMCond cond, ARMInsn opc,
     }
 }
 
-static void tcg_out_mul32(TCGContext *s, ARMCond cond, TCGReg rd,
-                          TCGReg rn, TCGReg rm)
-{
-    /* mul */
-    tcg_out32(s, (cond << 28) | 0x90 | (rd << 16) | (rm << 8) | rn);
-}
-
 static void tcg_out_umull32(TCGContext *s, ARMCond cond, TCGReg rd0,
                             TCGReg rd1, TCGReg rn, TCGReg rm)
 {
@@ -1891,6 +1884,18 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    /* mul */
+    tcg_out32(s, (COND_AL << 28) | 0x90 | (a0 << 16) | (a1 << 8) | a2);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2066,9 +2071,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_mul_i32:
-        tcg_out_mul32(s, COND_AL, args[0], args[1], args[2]);
-        break;
     case INDEX_op_mulu2_i32:
         tcg_out_umull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
@@ -2264,7 +2266,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ctz_i32:
         return C_O1_I2(r, r, rIK);
 
-    case INDEX_op_mul_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
         return C_O1_I2(r, r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index db0d2fc237..4d23f13888 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2637,6 +2637,33 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_IMUL_GvEv + rexw, a0, a2);
+}
+
+static void tgen_muli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    if (a2 == (int8_t)a2) {
+        tcg_out_modrm(s, OPC_IMUL_GvEvIb + rexw, a0, a0);
+        tcg_out8(s, a2);
+    } else {
+        tcg_out_modrm(s, OPC_IMUL_GvEvIz + rexw, a0, a0);
+        tcg_out32(s, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_mul,
+    .out_rri = tgen_muli,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2804,22 +2831,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(mul):
-        if (const_a2) {
-            int32_t val;
-            val = a2;
-            if (val == (int8_t)val) {
-                tcg_out_modrm(s, OPC_IMUL_GvEvIb + rexw, a0, a0);
-                tcg_out8(s, val);
-            } else {
-                tcg_out_modrm(s, OPC_IMUL_GvEvIz + rexw, a0, a0);
-                tcg_out32(s, val);
-            }
-        } else {
-            tcg_out_modrm(s, OPC_IMUL_GvEv + rexw, a0, a2);
-        }
-        break;
-
     OP_32_64(div2):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IDIV, args[4]);
         break;
@@ -3707,10 +3718,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
-        return C_O1_I2(r, 0, re);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a93413d4a7..944107b668 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1320,6 +1320,21 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_mul_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_mul_d(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1614,13 +1629,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mul_i32:
-        tcg_out_opc_mul_w(s, a0, a1, a2);
-        break;
-    case INDEX_op_mul_i64:
-        tcg_out_opc_mul_d(s, a0, a1, a2);
-        break;
-
     case INDEX_op_mulsh_i32:
         tcg_out_opc_mulh_w(s, a0, a1, a2);
         break;
@@ -2327,8 +2335,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rJ);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
     case INDEX_op_mulsh_i32:
     case INDEX_op_mulsh_i64:
     case INDEX_op_muluh_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 4942855189..95c2645226 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1716,6 +1716,33 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn;
+
+    if (type == TCG_TYPE_I32) {
+        if (use_mips32_instructions) {
+            tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
+            return;
+        }
+        insn = OPC_MULT;
+    } else {
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DMUL, a0, a1, a2);
+            return;
+        }
+        insn = OPC_DMULT;
+    }
+    tcg_out_opc_reg(s, insn, 0, a1, a2);
+    tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1876,13 +1903,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_mul_i32:
-        if (use_mips32_instructions) {
-            tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_MULT, i2 = OPC_MFLO;
-        goto do_hilo1;
     case INDEX_op_mulsh_i32:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_MUH, a0, a1, a2);
@@ -1925,13 +1945,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DIVU, i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_mul_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMUL, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DMULT, i2 = OPC_MFLO;
-        goto do_hilo1;
     case INDEX_op_mulsh_i64:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_DMUH, a0, a1, a2);
@@ -2232,7 +2245,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_div_i32:
@@ -2240,7 +2252,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
     case INDEX_op_setcond_i32:
-    case INDEX_op_mul_i64:
     case INDEX_op_mulsh_i64:
     case INDEX_op_muluh_i64:
     case INDEX_op_div_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 38cbe5223b..a7cc9d0bc7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2965,6 +2965,25 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? MULLW : MULLD;
+    tcg_out32(s, insn | TAB(a0, a1, a2));
+}
+
+static void tgen_muli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out32(s, MULLI | TAI(a0, a1, a2));
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_mul,
+    .out_rri = tgen_muli,
+};
+
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3077,7 +3096,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2;
+    TCGArg a0, a1;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -3166,15 +3185,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_mul_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out32(s, MULLI | TAI(a0, a1, a2));
-        } else {
-            tcg_out32(s, MULLW | TAB(a0, a1, a2));
-        }
-        break;
-
     case INDEX_op_div_i32:
         tcg_out32(s, DIVW | TAB(args[0], args[1], args[2]));
         break;
@@ -3283,14 +3293,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mul_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out32(s, MULLI | TAI(a0, a1, a2));
-        } else {
-            tcg_out32(s, MULLD | TAB(a0, a1, a2));
-        }
-        break;
     case INDEX_op_div_i64:
         tcg_out32(s, DIVD | TAB(args[0], args[1], args[2]));
         break;
@@ -4171,10 +4173,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
-        return C_O1_I2(r, r, rI);
-
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5e9e14815d..ff685037d7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2009,6 +2009,18 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_MULW : OPC_MUL;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2160,13 +2172,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_mul_i32:
-        tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
-        break;
-    case INDEX_op_mul_i64:
-        tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
-        break;
-
     case INDEX_op_div_i32:
         tcg_out_opc_reg(s, OPC_DIVW, a0, a1, a2);
         break;
@@ -2706,14 +2711,12 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_mul_i64:
     case INDEX_op_mulsh_i64:
     case INDEX_op_muluh_i64:
     case INDEX_op_div_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 98bf3ee19e..1ba9741fdd 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2258,6 +2258,57 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        if (a0 == a1) {
+            tcg_out_insn(s, RRE, MSR, a0, a2);
+        } else {
+            tcg_out_insn(s, RRFa, MSRKC, a0, a1, a2);
+        }
+    } else {
+        if (a0 == a1) {
+            tcg_out_insn(s, RRE, MSGR, a0, a2);
+        } else {
+            tcg_out_insn(s, RRFa, MSGRKC, a0, a1, a2);
+        }
+    }
+}
+
+static void tgen_muli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    if (type == TCG_TYPE_I32) {
+        if (a2 == (int16_t)a2) {
+            tcg_out_insn(s, RI, MHI, a0, a2);
+        } else {
+            tcg_out_insn(s, RIL, MSFI, a0, a2);
+        }
+    } else {
+        if (a2 == (int16_t)a2) {
+            tcg_out_insn(s, RI, MGHI, a0, a2);
+        } else {
+            tcg_out_insn(s, RIL, MSGFI, a0, a2);
+        }
+    }
+}
+
+static TCGConstraintSetIndex cset_mul(TCGType type, unsigned flags)
+{
+    return (HAVE_FACILITY(MISC_INSN_EXT2)
+            ? C_O1_I2(r, r, rJ)
+            : C_O1_I2(r, 0, rJ));
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mul,
+    .out_rrr = tgen_mul,
+    .out_rri = tgen_muli,
+};
+
 static void tgen_nand(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2460,22 +2511,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_mul_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            if (a2 == (int16_t)a2) {
-                tcg_out_insn(s, RI, MHI, a0, a2);
-            } else {
-                tcg_out_insn(s, RIL, MSFI, a0, a2);
-            }
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RRE, MSR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, MSRKC, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_div2_i32:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert(args[1] == args[3]);
@@ -2651,22 +2686,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
 
-    case INDEX_op_mul_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            if (a2 == (int16_t)a2) {
-                tcg_out_insn(s, RI, MGHI, a0, a2);
-            } else {
-                tcg_out_insn(s, RIL, MSGFI, a0, a2);
-            }
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RRE, MSGR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, MSGRKC, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_div2_i64:
         /*
          * ??? We get an unnecessary sign-extension of the dividend
@@ -3316,15 +3335,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_mul_i32:
-        return (HAVE_FACILITY(MISC_INSN_EXT2)
-                ? C_O1_I2(r, r, ri)
-                : C_O1_I2(r, 0, ri));
-    case INDEX_op_mul_i64:
-        return (HAVE_FACILITY(MISC_INSN_EXT2)
-                ? C_O1_I2(r, r, rJ)
-                : C_O1_I2(r, 0, rJ));
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 5819dc44fe..0a13a91166 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1337,6 +1337,26 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? ARITH_UMUL : ARITH_MULX;
+    tcg_out_arith(s, a0, a1, a2, insn);
+}
+
+static void tgen_muli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? ARITH_UMUL : ARITH_MULX;
+    tcg_out_arithi(s, a0, a1, a2, insn);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_mul,
+    .out_rri = tgen_muli,
+};
+
 static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1489,9 +1509,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i32:
         c = SHIFT_SRA;
         goto do_shift32;
-    case INDEX_op_mul_i32:
-        c = ARITH_UMUL;
-        goto gen_arith;
 
     case INDEX_op_div_i32:
         tcg_out_div32(s, a0, a1, a2, c2, 0);
@@ -1568,9 +1585,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i64:
         c = SHIFT_SRAX;
         goto do_shift64;
-    case INDEX_op_mul_i64:
-        c = ARITH_MULX;
-        goto gen_arith;
     case INDEX_op_div_i64:
         c = ARITH_SDIVX;
         goto gen_arith;
@@ -1667,8 +1681,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index a1f9a3a2f0..ce17079ffc 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -87,8 +87,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
@@ -661,6 +659,17 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_mul_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -789,7 +798,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(mul)
     CASE_32_64(shl)
     CASE_32_64(shr)
     CASE_32_64(sar)
-- 
2.43.0


