Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBA4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lwi-0002v9-WE; Tue, 15 Apr 2025 15:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lv2-0000Bm-Av
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:26:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luo-00084h-Ao
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736c277331eso6417792b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745148; x=1745349948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqchgLmgEpuJ3EPygyVrz9CWcTgB8/eV0LO1JRh/V28=;
 b=XN1m8FFWHFBFbnNxwiksCZLvPz5kpWqmvZ7k0X4HtEffHcS6Rz8FrwHEEa1yYY90Uf
 O1maA4YWJ0QiwryXqTIkHHO4Kc2DzBAy7pfHuRnraKO1R10H7EAM7qI1KSACaeVdv8a6
 DXVp12ScFpOCY6OD7kEF5BTOnxTlT0Zohxw/IZehlv8iznjDEBgtol1ZCJmHjC7pYMdI
 nmBFIAY9jH/DtRCWNAJq2m4NCIkQDrNqBqzVameDA4DwN6WyrRiPhCKZCu6bxkMfZMvs
 iPjty2jwxTTFEy1JU8OWHJlrgi7GHDtxDrB58JlpbSdDteiY7eeOpRQQXMl131ncfEl3
 LS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745148; x=1745349948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqchgLmgEpuJ3EPygyVrz9CWcTgB8/eV0LO1JRh/V28=;
 b=UiCKsM9NjoPe+S7SbUCcDcTCh5nmmYrhOAUgqFBFozxTvGJ2KJ+Aq/fHTW6vTzQTHW
 Yv4aMf2uo9v2vt7wFb4VapR4gZS35kinqimAANP6amaOs0btazi/cJzdruDiRIicZnGs
 T76lEfOW49jk9JewytoewI+mEfNOKX4YtFvKJ+RmyDX0pNAQLj528KHLn5PGKas5I90Y
 xhK+JR1VfU718aQOIPxIMNM4xKknhLh8Mxi+zjOxsi5c4fmzaWoWMWlM+uiT7OEGqTms
 o9tthO5L3Px1c5KJ2xxCS3mCkLni5/kePPpke/zTa6rpFJ4N1hzM/7T3KJlpkrN2qGoK
 TVKg==
X-Gm-Message-State: AOJu0Yxl3f+DMbrzufpW/FWPK/Kiwm2jk1cll0vUInjmQziEdAZTPCG0
 scgFyoWeLda7TjUDxL7xweD6WChW7oMWd99CDd8W95zHBHCGS/Jj/9p22LY0inZtdVfV3d/umOi
 N
X-Gm-Gg: ASbGncumFj2GGqiYaeDrCYdCF7d23KlXSzw7hAQwJu3z6Dwc4zNDxUzIInJi4ycxWAA
 w/ytMPX82D8Q9ZCxj5A/vPike3hupEP+pXPaYxd/F7F/Ecg40+iHhDfpMdcATOzMF6wr1EpsW9s
 Ge4YL/RfKQ1CXqPDavWv9lnk6smLGBJj/grqBJkiVsUsjBSMQ3X+UxHCWOhJbkZk1l6R7EvJ3cD
 oPjQz5Ztql50PjIrDTyWwj6l+9vGeJxuPKz/0CD1WxRUxdcypWGzosExOsT/S0Ia1eFbW8GXIzS
 JysbF4nPf/EqRWOf9hO/DZYa4GPLmVb+MU9KPDttjMxiv70mde7L/Lzt4qkICQyIqY1bNHcBEZs
 =
X-Google-Smtp-Source: AGHT+IHhHyajJ5+7N61szSdkKBz7FItY78sWsKeP246yDBINLNhL9PvmD4iCo+YD7baEekap6q4w6w==
X-Received: by 2002:a05:6a00:2d02:b0:736:3ea8:4813 with SMTP id
 d2e1a72fcca58-73c1f8f5be3mr990801b3a.2.1744745147583; 
 Tue, 15 Apr 2025 12:25:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 035/163] tcg: Convert mul to TCGOutOpBinary
Date: Tue, 15 Apr 2025 12:23:06 -0700
Message-ID: <20250415192515.232910-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index bb831aefe6..6cd30133cf 100644
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
@@ -5433,6 +5433,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index 2477b1c4ab..93e5c70ae3 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -921,13 +921,6 @@ static void tcg_out_dat_rIN(TCGContext *s, ARMCond cond, ARMInsn opc,
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
@@ -1885,6 +1878,18 @@ static const TCGOutOpBinary outop_eqv = {
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
@@ -2060,9 +2065,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_mul_i32:
-        tcg_out_mul32(s, COND_AL, args[0], args[1], args[2]);
-        break;
     case INDEX_op_mulu2_i32:
         tcg_out_umull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
@@ -2258,7 +2260,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ctz_i32:
         return C_O1_I2(r, r, rIK);
 
-    case INDEX_op_mul_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
         return C_O1_I2(r, r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 24fef09c9e..4abe89d06e 100644
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


