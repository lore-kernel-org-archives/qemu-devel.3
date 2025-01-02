Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AFCE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPf2-0000kv-Vo; Thu, 02 Jan 2025 13:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPen-0007XK-0R
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPej-0006HU-Dj
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166651f752so183474515ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841448; x=1736446248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F4dPAyqU7jW3EiHl1iFJF2MLGUYXViz/Z9qg6246/5A=;
 b=KvxGrI3PmeNOaMloB6YWpkcxxgKxlCK8SZIpum497dwDVPp/RZ+ZE0RIZDtIdk2UOl
 kUWwl6sBHKpMEHjiHm0E3FkksaV7BSSaKYyPZIMtogPiYRr81l7ntOzL5TBCFHXE5SQ9
 /ylmLd8q1ln0ZJJnx8GPnEg8z7DAgT+FhNHnpOjD2a6h72QaD/zzzXFQRqyMmUNPAU7O
 vUzn9LhlRILJjylHAiXu5QmD8LJ/yBrvjsGHyHRRIz7OLcVMNTmyyLvlD3fS+CpZLysq
 el6GFA5FGy6wCed4kPmRn8EpnDlYORDEyTls0LT+uhkANbd5qLsIYb3F7p1VBByImLxY
 7eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841448; x=1736446248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4dPAyqU7jW3EiHl1iFJF2MLGUYXViz/Z9qg6246/5A=;
 b=PUze/zCRQFXeNLD0Y0HbrYObuy+ohBELXeHv2JYQBarwyeDmpB0aUrSNIAerkrSoGJ
 H9oSaAP5Eixy+n/s8YJdD9S0/6gRCxbSdA2D1gN2WaIvIc2m9hmw1QWdeVfJ88k6IWBw
 rwu5wY39ToKDyKX2e2cFEkrAhxezPLXRjMAGjPwk8fonry+LO6ZtGEc3bwPIYZgo8/Nr
 wuz79Sc8FEUatZLenXFPK4pBFmudj2i22pyhzHHE5YH+1y/W9rf9xIckKp0386SUfHTu
 46fN0gqFcbWwLBK/O4n8p20VhMZZgFgsts6gnyia5wuMRtrxvI3lRnSlLRkZKXXMu64U
 dWJA==
X-Gm-Message-State: AOJu0YxhjoBzJhAt8+wjFLxJYbn+GnnDXeyyuEo65gJhHU7ApAKTtoLT
 tl5hVPWlm4shB4ZY5zs6U5FK3YVxFduLHv6NrM1Oodh1w4e4N+TMEtds9jwZ7NqISBUo0BXRQBA
 I
X-Gm-Gg: ASbGncupbCaxPs+DxrgAQPMrBgVEVwlRseOL4i/QO9lz0eR835Enl6vh2fYBzrXMUtd
 9DDxkkOPssMkDrPa7stgF2VGEJP0P/FwdclNpULTv1YPqz24hKdxtvTAZt12Pvs0sow71N4n+kA
 Qv0WwfPTzleYsqz3J3xxZHABI0PqRRh1yfumiPVjNgLUESE6krF4CIxeYG8b9rnNddi2/8gm5+y
 s8NkNWb9fupIU1fFkbpeVIkcmqxORMr5ZAAnA9KpSWjggW3rdrGgTmi6sJ9VA==
X-Google-Smtp-Source: AGHT+IGfKk8Vbp98QX3EhVzaSekF3tD6xZ3L33wpK7/KAksZMlxZju68wbrA/4LDWGq0RovANZVT1g==
X-Received: by 2002:a05:6a20:7f82:b0:1e0:d575:8d4f with SMTP id
 adf61e73a8af0-1e5e081c5acmr74790948637.37.1735841447917; 
 Thu, 02 Jan 2025 10:10:47 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 67/73] tcg: Merge extract, sextract operations
Date: Thu,  2 Jan 2025 10:06:47 -0800
Message-ID: <20250102180654.1420056-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 include/tcg/tcg-opc.h            |  7 +++--
 tcg/optimize.c                   | 12 ++++-----
 tcg/tcg-op.c                     | 20 +++++++--------
 tcg/tcg.c                        |  6 ++---
 tcg/tci.c                        | 25 +++++++-----------
 tcg/aarch64/tcg-target.c.inc     | 12 +++------
 tcg/arm/tcg-target.c.inc         |  8 +++---
 tcg/i386/tcg-target.c.inc        | 32 +++++++----------------
 tcg/loongarch64/tcg-target.c.inc | 25 +++++-------------
 tcg/mips/tcg-target.c.inc        | 29 +++++++--------------
 tcg/ppc/tcg-target.c.inc         | 38 ++++++++++-----------------
 tcg/riscv/tcg-target.c.inc       | 26 ++++++-------------
 tcg/s390x/tcg-target.c.inc       | 10 +++-----
 tcg/sparc64/tcg-target.c.inc     | 10 +++++---
 tcg/tci/tcg-target.c.inc         | 44 +++++++++++++-------------------
 15 files changed, 113 insertions(+), 191 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 1b133a63ea..643ebe05cc 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -64,6 +64,9 @@ DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(div2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 
+DEF(extract, 1, 1, 2, TCG_OPF_INT)
+DEF(sextract, 1, 1, 2, TCG_OPF_INT)
+
 DEF(brcond, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_INT)
 DEF(setcond, 1, 2, 1, TCG_OPF_INT)
 DEF(negsetcond, 1, 2, 1, TCG_OPF_INT)
@@ -79,8 +82,6 @@ DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, 0)
 DEF(rotr_i32, 1, 2, 0, 0)
 DEF(deposit_i32, 1, 2, 2, 0)
-DEF(extract_i32, 1, 1, 2, 0)
-DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
@@ -102,8 +103,6 @@ DEF(sar_i64, 1, 2, 0, 0)
 DEF(rotl_i64, 1, 2, 0, 0)
 DEF(rotr_i64, 1, 2, 0, 0)
 DEF(deposit_i64, 1, 2, 2, 0)
-DEF(extract_i64, 1, 1, 2, 0)
-DEF(sextract_i64, 1, 1, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3061459944..6077883bc4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2279,19 +2279,19 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     case TCG_TYPE_I32:
         shr_opc = INDEX_op_shr_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
-            uext_opc = INDEX_op_extract_i32;
+            uext_opc = INDEX_op_extract;
         }
         if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
-            sext_opc = INDEX_op_sextract_i32;
+            sext_opc = INDEX_op_sextract;
         }
         break;
     case TCG_TYPE_I64:
         shr_opc = INDEX_op_shr_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
-            uext_opc = INDEX_op_extract_i64;
+            uext_opc = INDEX_op_extract;
         }
         if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
-            sext_opc = INDEX_op_sextract_i64;
+            sext_opc = INDEX_op_sextract;
         }
         break;
     default:
@@ -2786,7 +2786,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_eqv_vec:
             done = fold_eqv(&ctx, op);
             break;
-        CASE_OP_32_64(extract):
+        case INDEX_op_extract:
             done = fold_extract(&ctx, op);
             break;
         CASE_OP_32_64(extract2):
@@ -2906,7 +2906,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_bitsel_vec:
             done = fold_bitsel_vec(&ctx, op);
             break;
-        CASE_OP_32_64(sextract):
+        case INDEX_op_sextract:
             done = fold_sextract(&ctx, op);
             break;
         case INDEX_op_sub:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7dbc7b1ad6..4d36da33c5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -990,7 +990,7 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
+        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
     if (ofs == 0) {
@@ -1000,7 +1000,7 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, 0, ofs + len);
         tcg_gen_shri_i32(ret, ret, ofs);
         return;
     }
@@ -1035,19 +1035,19 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, ofs, len);
         return;
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, 0, ofs + len);
         tcg_gen_sari_i32(ret, ret, ofs);
         return;
     }
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
         tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, ret, 0, len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, ret, 0, len);
         return;
     }
 
@@ -2690,7 +2690,7 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
+        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
     if (ofs == 0) {
@@ -2700,7 +2700,7 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, 0, ofs + len);
         tcg_gen_shri_i64(ret, ret, ofs);
         return;
     }
@@ -2767,19 +2767,19 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, ofs, len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
         return;
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, 0, ofs + len);
         tcg_gen_sari_i64(ret, ret, ofs);
         return;
     }
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
         tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, ret, 0, len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, ret, 0, len);
         return;
     }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f084b51a72..71171bb7dc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2192,12 +2192,14 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_brcond:
+    case INDEX_op_extract:
     case INDEX_op_mov:
     case INDEX_op_movcond:
     case INDEX_op_mul:
     case INDEX_op_neg:
     case INDEX_op_or:
     case INDEX_op_setcond:
+    case INDEX_op_sextract:
     case INDEX_op_sub:
     case INDEX_op_xor:
         return has_type;
@@ -2207,8 +2209,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_sextract_i32:
     case INDEX_op_deposit_i32:
         return true;
 
@@ -2272,8 +2272,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i64:
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 7164072b1b..6b0f3ba3fd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -36,6 +36,9 @@
 # define tci_assert(cond) ((void)(cond))
 #endif
 
+#define extract_tr   glue(extract, TCG_TARGET_REG_BITS)
+#define sextract_tr  glue(sextract, TCG_TARGET_REG_BITS)
+
 __thread uintptr_t tci_tb_ptr;
 
 static void tci_write_reg64(tcg_target_ulong *regs, uint32_t high_index,
@@ -638,13 +641,13 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
             break;
-        case INDEX_op_extract_i32:
+        case INDEX_op_extract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = extract32(regs[r1], pos, len);
+            regs[r0] = extract_tr(regs[r1], pos, len);
             break;
-        case INDEX_op_sextract_i32:
+        case INDEX_op_sextract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract32(regs[r1], pos, len);
+            regs[r0] = sextract_tr(regs[r1], pos, len);
             break;
         case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
@@ -772,14 +775,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
-        case INDEX_op_extract_i64:
-            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = extract64(regs[r1], pos, len);
-            break;
-        case INDEX_op_sextract_i64:
-            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract64(regs[r1], pos, len);
-            break;
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
@@ -1097,10 +1092,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), str_r(r2), pos, len);
         break;
 
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
         tci_args_rrbb(insn, &r0, &r1, &pos, &len);
         info->fprintf_func(info->stream, "%-12s  %s,%s,%d,%d",
                            op_name, str_r(r0), str_r(r1), pos, len);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index afb7bce479..2050a0a6db 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2419,8 +2419,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_dep(s, ext, a0, REG0(2), args[3], args[4]);
         break;
 
-    case INDEX_op_extract_i64:
-    case INDEX_op_extract_i32:
+    case INDEX_op_extract:
         if (a2 == 0) {
             uint64_t mask = MAKE_64BIT_MASK(0, args[3]);
             tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, mask);
@@ -2429,8 +2428,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_sextract_i64:
-    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract:
         tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
         break;
 
@@ -2934,10 +2932,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
         return C_O1_I1(r, r);
 
     case INDEX_op_st_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index faebedcd75..09ab9d4051 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2127,10 +2127,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_deposit(s, COND_AL, args[0], args[2],
                         args[3], args[4], const_args[2]);
         break;
-    case INDEX_op_extract_i32:
+    case INDEX_op_extract:
         tcg_out_extract(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract:
         tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
     case INDEX_op_extract2_i32:
@@ -2186,8 +2186,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_sextract_i32:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
         return C_O1_I1(r, r);
 
     case INDEX_op_st_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index e49089450a..30bb5502f6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3042,8 +3042,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_extract_i64:
-        if (a2 + args[3] == 32) {
+    case INDEX_op_extract:
+        if (TCG_TARGET_REG_BITS == 64 && a2 + args[3] == 32) {
             if (a2 == 0) {
                 tcg_out_ext32u(s, a0, a1);
                 break;
@@ -3053,8 +3053,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_shifti(s, SHIFT_SHR, a0, a2);
             break;
         }
-        /* FALLTHRU */
-    case INDEX_op_extract_i32:
         if (a2 == 0 && args[3] == 8) {
             tcg_out_ext8u(s, a0, a1);
         } else if (a2 == 0 && args[3] == 16) {
@@ -3076,24 +3074,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_sextract_i64:
+    case INDEX_op_sextract:
         if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_I64, a0, a1);
+            tcg_out_ext8s(s, type, a0, a1);
         } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_I64, a0, a1);
-        } else if (a2 == 0 && args[3] == 32) {
+            tcg_out_ext16s(s, type, a0, a1);
+        } else if (type == TCG_TYPE_I64 && a2 == 0 && args[3] == 32) {
             tcg_out_ext32s(s, a0, a1);
-        } else {
-            g_assert_not_reached();
-        }
-        break;
-
-    case INDEX_op_sextract_i32:
-        if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_I32, a0, a1);
-        } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
-        } else if (a2 == 8 && args[3] == 8) {
+        } else if (type == TCG_TYPE_I32 && a2 == 8 && args[3] == 8) {
             if (a1 < 4 && a0 < 8) {
                 tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
             } else {
@@ -3737,10 +3725,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 4016a448a3..d91524e984 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1366,33 +1366,24 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_extract_i32:
+    case INDEX_op_extract:
         if (a2 == 0 && args[3] <= 12) {
             tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
-        } else {
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_bstrpick_w(s, a0, a1, a2, a2 + args[3] - 1);
-        }
-        break;
-    case INDEX_op_extract_i64:
-        if (a2 == 0 && args[3] <= 12) {
-            tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
         } else {
             tcg_out_opc_bstrpick_d(s, a0, a1, a2, a2 + args[3] - 1);
         }
         break;
 
-    case INDEX_op_sextract_i64:
-        if (a2 + args[3] == 32) {
+    case INDEX_op_sextract:
+        if (type == TCG_TYPE_I64 && a2 + args[3] == 32) {
             if (a2 == 0) {
                 tcg_out_ext32s(s, a0, a1);
             } else {
                 tcg_out_opc_srai_w(s, a0, a1, a2);
             }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
-        if (a2 == 0 && args[3] == 8) {
+        } else if (a2 == 0 && args[3] == 8) {
             tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
         } else if (a2 == 0 && args[3] == 16) {
             tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
@@ -2236,10 +2227,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_neg:
     case INDEX_op_not:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 85414bb96b..7e8f5e1379 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2025,33 +2025,24 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                          args[3] + args[4] - 1, args[3]);
         break;
 
-    case INDEX_op_extract_i32:
+    case INDEX_op_extract:
         if (a2 == 0 && args[3] <= 16) {
             tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
-        } else {
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_bf(s, OPC_EXT, a0, a1, args[3] - 1, a2);
-        }
-        break;
-    case INDEX_op_extract_i64:
-        if (a2 == 0 && args[3] <= 16) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, (1 << args[3]) - 1);
         } else {
             tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU,
                              a0, a1, args[3] - 1, a2);
         }
         break;
 
-    case INDEX_op_sextract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32s(s, a0, a1);
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract:
         if (a2 == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
+            tcg_out_ext8s(s, type, a0, a1);
         } else if (a2 == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
+            tcg_out_ext16s(s, type, a0, a1);
+        } else if (type == TCG_TYPE_I64 && a2 == 0 && args[3] == 32) {
+            tcg_out_ext32s(s, a0, a1);
         } else {
             g_assert_not_reached();
         }
@@ -2160,8 +2151,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_sextract_i32:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_ld_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
@@ -2170,8 +2161,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 421c0f89da..a2618e8573 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3379,37 +3379,29 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_extract_i32:
+    case INDEX_op_extract:
         if (args[2] == 0 && args[3] <= 16) {
             tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
-            break;
+        } else if (type == TCG_TYPE_I32) {
+            tcg_out_rlw(s, RLWINM, args[0], args[1],
+                        32 - args[2], 32 - args[3], 31);
+        } else {
+            tcg_out_rld(s, RLDICL, args[0], args[1],
+                        64 - args[2], 64 - args[3]);
         }
-        tcg_out_rlw(s, RLWINM, args[0], args[1],
-                    32 - args[2], 32 - args[3], 31);
-        break;
-    case INDEX_op_extract_i64:
-        if (args[2] == 0 && args[3] <= 16) {
-            tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
-            break;
-        }
-        tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 64 - args[3]);
         break;
 
-    case INDEX_op_sextract_i64:
-        if (args[2] + args[3] == 32) {
+    case INDEX_op_sextract:
+        if (type == TCG_TYPE_I64 && args[2] + args[3] == 32) {
             if (args[2] == 0) {
                 tcg_out_ext32s(s, args[0], args[1]);
             } else {
                 tcg_out_sari32(s, args[0], args[1], args[2]);
             }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
-        if (args[2] == 0 && args[3] == 8) {
-            tcg_out_ext8s(s, TCG_TYPE_I32, args[0], args[1]);
+        } else if (args[2] == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, type, args[0], args[1]);
         } else if (args[2] == 0 && args[3] == 16) {
-            tcg_out_ext16s(s, TCG_TYPE_I32, args[0], args[1]);
+            tcg_out_ext16s(s, type, args[0], args[1]);
         } else {
             g_assert_not_reached();
         }
@@ -4111,8 +4103,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_sextract_i32:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
     case INDEX_op_ext_i32_i64:
@@ -4122,8 +4114,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index e9a874e424..966cffb525 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2327,36 +2327,28 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_extract_i64:
-        if (a2 + args[3] == 32) {
+    case INDEX_op_extract:
+        if (type == TCG_TYPE_I64 && a2 + args[3] == 32) {
             if (a2 == 0) {
                 tcg_out_ext32u(s, a0, a1);
             } else {
                 tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
             }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_extract_i32:
-        if (a2 == 0 && args[3] == 16) {
+        } else if (a2 == 0 && args[3] == 16) {
             tcg_out_ext16u(s, a0, a1);
         } else {
             g_assert_not_reached();
         }
         break;
 
-    case INDEX_op_sextract_i64:
-        if (a2 + args[3] == 32) {
+    case INDEX_op_sextract:
+        if (type == TCG_TYPE_I64 && a2 + args[3] == 32) {
             if (a2 == 0) {
                 tcg_out_ext32s(s, a0, a1);
             } else {
                 tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2);
             }
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_sextract_i32:
-        if (a2 == 0 && args[3] == 8) {
+        } else if (a2 == 0 && args[3] == 8) {
             tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
         } else if (a2 == 0 && args[3] == 16) {
             tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
@@ -2608,10 +2600,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap16_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 054e036168..1c83e5d648 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2682,10 +2682,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(extract):
+    case INDEX_op_extract:
         tgen_extract(s, args[0], args[1], args[2], args[3]);
         break;
-    OP_32_64(sextract):
+    case INDEX_op_sextract:
         tgen_sextract(s, args[0], args[1], args[2], args[3]);
         break;
 
@@ -3240,10 +3240,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 2e322eed87..449433c6b3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1532,11 +1532,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_extract_i64:
+    case INDEX_op_extract:
+        tcg_debug_assert(type == TCG_TYPE_I64);
         tcg_debug_assert(a2 + args[3] == 32);
         tcg_out_arithi(s, a0, a1, a2, SHIFT_SRL);
         break;
-    case INDEX_op_sextract_i64:
+    case INDEX_op_sextract:
+        tcg_debug_assert(type == TCG_TYPE_I64);
         tcg_debug_assert(a2 + args[3] == 32);
         tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
         break;
@@ -1570,8 +1572,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e85cbba0bb..55008e3815 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,10 +55,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
@@ -496,54 +494,48 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 }
 
-static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
-                            TCGReg rs, unsigned pos, unsigned len)
+static void tcg_out_extract(TCGContext *s, TCGReg rd, TCGReg rs,
+                            unsigned pos, unsigned len)
 {
-    TCGOpcode opc = type == TCG_TYPE_I32 ?
-                    INDEX_op_extract_i32 :
-                    INDEX_op_extract_i64;
-    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, pos, len);
 }
 
-static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
-                             TCGReg rs, unsigned pos, unsigned len)
+static void tcg_out_sextract(TCGContext *s, TCGReg rd, TCGReg rs,
+                             unsigned pos, unsigned len)
 {
-    TCGOpcode opc = type == TCG_TYPE_I32 ?
-                    INDEX_op_sextract_i32 :
-                    INDEX_op_sextract_i64;
-    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_out_sextract(s, type, rd, rs, 0, 8);
+    tcg_out_sextract(s, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
+    tcg_out_extract(s, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_out_sextract(s, type, rd, rs, 0, 16);
+    tcg_out_sextract(s, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
+    tcg_out_extract(s, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_out_sextract(s, rd, rs, 0, 32);
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_out_extract(s, rd, rs, 0, 32);
 }
 
 static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
@@ -751,12 +743,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
-    CASE_32_64(extract)  /* Optional (TCG_TARGET_HAS_extract_*). */
-    CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
         tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
     case INDEX_op_extrh_i64_i32:
-        tcg_out_op_rrbb(s, INDEX_op_extract_i64, args[0], args[1], 32, 32);
+        tcg_out_extract(s, args[0], args[1], 32, 32);
         break;
 
     case INDEX_op_neg:
@@ -779,7 +771,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         /* The base tci bswaps zero-extend, and ignore high bits. */
         tcg_out_op_rr(s, opc, args[0], args[1]);
         if (args[2] & TCG_BSWAP_OS) {
-            tcg_out_sextract(s, TCG_TYPE_REG, args[0], args[0], 0, width);
+            tcg_out_sextract(s, args[0], args[0], 0, width);
         }
         break;
 
-- 
2.43.0


