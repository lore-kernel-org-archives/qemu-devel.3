Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81749C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqw-00036s-2c; Sun, 16 Feb 2025 18:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpk-0000jP-8X
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:58 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnph-0005QC-Dg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:55 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2211acda7f6so15106245ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747631; x=1740352431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E7vlO3RR3UYNWo8h4DXB5bjDyBPu8h+21e2YnVMnEwg=;
 b=xczGVevZJLW8WIACxSrpfRcx46+IhK0FC5WfSol5tlTEoOZzKJ1qfp4BQ7ciAkyn6K
 KCJD2InnYbWZ9Ze6AfoIItDu5KqsdKdq2vQn2/iJvV77zaILU4nb2WtO1+5I7K74LFoV
 Eyi0aG4uKBLJlKynYR6RxXOPV46r+L7wpsQvnhMGSZi93bVVaKDNhKw/CBSOvXBurGeN
 GueuOjLA+jbPdDyVIVyHTXdr+mP4zeEcCXCsDNr+ydGGQO4hyYqUToarYKE4OGzyY7G+
 DN+iRXysaBPbi6rT6/g+1IJWQ8GDMiYQP2SQBNbY/O85Sa2iC7rdQEfrh66OODoCoLD0
 HqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747631; x=1740352431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7vlO3RR3UYNWo8h4DXB5bjDyBPu8h+21e2YnVMnEwg=;
 b=gwjX+oiLDnH2AUFX1k4jX36BjKPoqCj5EBLpR+uEUP8qRZ/apGzc+W9KE34zG0+Py6
 BCEXgPSrfPw2PL6vLRcwwlR4+iOKoaew7Bu+R+F06JfRqrY5yu3YbqfipDqqTf5sW2On
 qSZr5JyTUe/6MGOMIvg/zU/cUK+J3MYeHYL142aWilB4ViEx/PA9VoQuvJAkPQYRCiYn
 wHYLAOwhWOexy6LtUjsIZpEGPSzD1IEI1v7+MMROWWGbY+dVh52pSvqj8GjhK8cSu8ow
 oDbda8CwllIwO+og8PTXdeLv9u8gUppMTRmWskPhw3gchrRYUF6IUJVCwm+ZuKU9DuMA
 xfwQ==
X-Gm-Message-State: AOJu0YwyuqaDdkojoZBAw/iwbowzOsqYiLjhUQx38NibVnKFZmIbXCpR
 L7Kpvu7V4vxPxF2HmM1KGPLpHSyb4vcRPZFRZDmI5WwRJMRQH6c37/VTFNMNjZjtKw0e9a8BNQE
 1
X-Gm-Gg: ASbGnctuyfBK15v9+8IWQbvJ65zKvvFTnkLs1aMGfgAmo2XW4rSsTh3KN6y7hnKVshU
 /LFWQY36Zei+wk90XLOc7rWyagN31gJl0FmEPXK3eeXi4BaE+4vqLjuHkg4D9ShNHm6wQcPUvPs
 4lFhvR3yjA0mYT6kvf13dgXqhueMUIl97M9ks3euUuqbW5RTwWVdWGPXL/QOndghksefuEsUEIv
 3/ka6nqisqSoHkkhhSgir+KQpG2b/4R6ksQw2HReGsBKLli0HabwCgMZaDZGPe4GQPbWgR0ip1F
 OBOq48fOZQ0KIYNPq8WTbXzvGxfx6+RgQUMKw48Ax9N0DhA=
X-Google-Smtp-Source: AGHT+IGxX+FVSD23PNEmdeO0hg9kJi4u36eMQVZ1csqaOCsxrlA7uaHK3xHzXB1FGcSvvDwB4eekXQ==
X-Received: by 2002:a17:902:e5d0:b0:216:3c2b:a5d0 with SMTP id
 d9443c01a7336-221040a4d45mr92941235ad.51.1739747630944; 
 Sun, 16 Feb 2025 15:13:50 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 048/162] tcg: Convert rem to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:17 -0800
Message-ID: <20250216231012.2808572-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

For TCI, we're losing type information in the interpreter.
Introduce a tci-specific opcode to handle the difference.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  6 ++++--
 tcg/tci.c                        |  4 ++--
 tcg/aarch64/tcg-target.c.inc     | 19 ++++++++++------
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        |  4 ++++
 tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++--------
 tcg/mips/tcg-target.c.inc        | 37 ++++++++++++++++++--------------
 tcg/ppc/tcg-target.c.inc         | 27 +++++++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 21 ++++++++++--------
 tcg/s390x/tcg-target.c.inc       |  4 ++++
 tcg/sparc64/tcg-target.c.inc     |  4 ++++
 tcg/tci/tcg-target-opc.h.inc     |  1 +
 tcg/tci/tcg-target.c.inc         | 17 ++++++++++++---
 13 files changed, 115 insertions(+), 57 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 560755bad8..5b75106943 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1040,6 +1040,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_rem_i32, TCGOutOpBinary, outop_rems),
+    OUTOP(INDEX_op_rem_i64, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -2270,7 +2272,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond_i32;
-    case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
         return TCG_TARGET_HAS_rem_i32;
     case INDEX_op_rotl_i32:
@@ -2327,7 +2328,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i64:
         return TCG_TARGET_HAS_negsetcond_i64;
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return TCG_TARGET_HAS_rem_i64;
     case INDEX_op_rotl_i64:
@@ -5419,6 +5419,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_rem_i32:
+    case INDEX_op_rem_i64:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index bf97849bfe..65f493c3d4 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -586,7 +586,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
             break;
-        case INDEX_op_rem_i32:
+        case INDEX_op_tci_rems32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
             break;
@@ -1081,7 +1081,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
@@ -1101,6 +1100,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_ctz_i64:
     case INDEX_op_tci_divs32:
     case INDEX_op_tci_divu32:
+    case INDEX_op_tci_rems32:
         tci_args_rrr(insn, &r0, &r1, &r2);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2));
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 456159cdc6..6e80e18a6a 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2275,6 +2275,18 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, SDIV, type, TCG_REG_TMP0, a1, a2);
+    tcg_out_insn(s, 3509, MSUB, type, a0, TCG_REG_TMP0, a2, a1);
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2392,11 +2404,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_rem_i64:
-    case INDEX_op_rem_i32:
-        tcg_out_insn(s, 3508, SDIV, ext, TCG_REG_TMP0, a1, a2);
-        tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
-        break;
     case INDEX_op_remu_i64:
     case INDEX_op_remu_i32:
         tcg_out_insn(s, 3508, UDIV, ext, TCG_REG_TMP0, a1, a2);
@@ -3078,8 +3085,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
         return C_O1_I2(r, r, r);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index a20ee0ce0f..318a4c3dd8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1961,6 +1961,10 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2d4c5bc46c..b127a4034d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2736,6 +2736,10 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2f9b0969ee..1049563f80 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1447,6 +1447,21 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_mod_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_mod_d(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1697,13 +1712,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_rem_i32:
-        tcg_out_opc_mod_w(s, a0, a1, a2);
-        break;
-    case INDEX_op_rem_i64:
-        tcg_out_opc_mod_d(s, a0, a1, a2);
-        break;
-
     case INDEX_op_remu_i32:
         tcg_out_opc_mod_wu(s, a0, a1, a2);
         break;
@@ -2375,8 +2383,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rJ);
 
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
         return C_O1_I2(r, rz, rz);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f4eb098135..079bc00d96 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1872,6 +1872,27 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (use_mips32r6_instructions) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_MOD, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
+        }
+    } else {
+        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_DIV : OPC_DDIV;
+        tcg_out_opc_reg(s, insn, 0, a1, a2);
+        tcg_out_opc_reg(s, OPC_MFHI, a0, 0, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1995,13 +2016,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_rem_i32:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MOD, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DIV, i2 = OPC_MFHI;
-        goto do_hilo1;
     case INDEX_op_remu_i32:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_MODU, a0, a1, a2);
@@ -2009,13 +2023,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DIVU, i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_rem_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DDIV, i2 = OPC_MFHI;
-        goto do_hilo1;
     case INDEX_op_remu_i64:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_DMODU, a0, a1, a2);
@@ -2281,10 +2288,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
     case INDEX_op_setcond_i32:
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rz);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 8b14d57d1c..c331f0d672 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3091,6 +3091,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static TCGConstraintSetIndex cset_mod(TCGType type, unsigned flags)
+{
+    return have_isa_3_00 ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? MODSW : MODSD;
+    tcg_out32(s, insn | TAB(a0, a1, a2));
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mod,
+    .out_rrr = tgen_rems,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3241,10 +3259,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_rem_i32:
-        tcg_out32(s, MODSW | TAB(args[0], args[1], args[2]));
-        break;
-
     case INDEX_op_remu_i32:
         tcg_out32(s, MODUW | TAB(args[0], args[1], args[2]));
         break;
@@ -3341,9 +3355,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_rem_i64:
-        tcg_out32(s, MODSD | TAB(args[0], args[1], args[2]));
-        break;
     case INDEX_op_remu_i64:
         tcg_out32(s, MODUD | TAB(args[0], args[1], args[2]));
         break;
@@ -4202,9 +4213,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return C_O1_I2(r, r, r);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 72910b0f25..b0a98273f1 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2120,6 +2120,18 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_REMW : OPC_REM;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2233,13 +2245,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_rem_i32:
-        tcg_out_opc_reg(s, OPC_REMW, a0, a1, a2);
-        break;
-    case INDEX_op_rem_i64:
-        tcg_out_opc_reg(s, OPC_REM, a0, a1, a2);
-        break;
-
     case INDEX_op_remu_i32:
         tcg_out_opc_reg(s, OPC_REMUW, a0, a1, a2);
         break;
@@ -2748,9 +2753,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return C_O1_I2(r, rz, rz);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 9af626eec2..320268669a 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2437,6 +2437,10 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index a4659653b3..23cca5c664 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1476,6 +1476,10 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 43c07a269f..2822fbffc8 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -4,3 +4,4 @@ DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 27271c178c..4d9c142a00 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
@@ -754,6 +752,20 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rems32
+                     : INDEX_op_rem_i64);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -843,7 +855,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
-    CASE_32_64(rem)      /* Optional (TCG_TARGET_HAS_div_*). */
     CASE_32_64(remu)     /* Optional (TCG_TARGET_HAS_div_*). */
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
     CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
-- 
2.43.0


