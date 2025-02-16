Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B918AC021A7
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnu7-0003t0-2b; Sun, 16 Feb 2025 18:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntA-00029x-FA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt7-00061J-Hn
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:28 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22114b800f7so14464785ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747843; x=1740352643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rV0rYk98rVZmUNIuHFolyPB+oKeu9IfrLLc8n1mR8z8=;
 b=SxTn6kui+4enpIy++efGg4O88s/YcdsexJ72A9VeKzWU9wjfgiwVfXnToNWAXhvQyr
 4sJVVkYCYJi5IqrvSbrZgI+xcg2GatFQxbqGNP45Z0VQDNGAgGMXg96+1Fotxn8utEOP
 OyWjiI7Oqhad7WAviyqdA/BQqVeZuiKbryJHSux2DvUkGEXTRLX4RxCyjMfrf0hbyInO
 3W8WiMYxFKsvO1NiU93rSoiJi4Xi/HLy0MeaTXzFRA7jMuLvUcvAzKV4FYu4woL6vdBI
 BVCTTUMdONNMpTSQSo4VKdIwyTJ0WYYcy9MlVRsdHWioHPNw2X1VNAFHqKlNZa+tcRuW
 UqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747843; x=1740352643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rV0rYk98rVZmUNIuHFolyPB+oKeu9IfrLLc8n1mR8z8=;
 b=MN1odMck+nuLd8p82YkPIlB0BAXB6cXdKHMqggN4MXO64LyUdf0q4qafjNCPP4H4bU
 wmk8daLCc+mDZHUTzR7EWnOOgbYDmdB/g2cfnQpbN8Lz22rhgqs5Ja6e9/ZXs+rJ9V2D
 /I3wzqR+fleQQrM8uxHxRsZgllawXglQv1TWnotXkNJSbOGkvDSeOBwwArL+Pms5vC5d
 rbijYlSh9uud2V8Q75CeaN/XMqouyovqTDUZKF/k1o1oSSBfjmN+XwaEQTwmC9CduBHk
 hw53ivbbSDdBWYbl/NKeUoGuE6LzTKnxW6vbEm77Y1X2wvDfbs0SJqfIeQMgUaFwXakN
 jUcA==
X-Gm-Message-State: AOJu0Yy0OS8YuRUvgUriBesN/CUlpYyKS/i93LU+J6CxMucWDNbfXSJE
 JOzWmdMdYl6OFsOPAnusXn+F8g4DIUmHflPxKJyDzSMNSlsj35xmSOnC6dX7QypyDJQMnN9YviZ
 K
X-Gm-Gg: ASbGncvwMD787GMrP2kqZdcchYNnp3ToDTXSSzRECAySiFOxIltqb/UpjtrZwC7u/lJ
 i12lFH3zPnzv50UoTdoP7NLrWyALVHJ8Byysff9pO2HV87wE9+oF83jiI4o8DcdJ5lZpzWVhggM
 51rmo9hBt88v3sWYVH9rB/fjksicrAAg0JPDh/jcPT144rCpfeUAzHC9ikjpLqy5j0Coq/5EAmt
 O7+YDlcFO1YWCa/yjjZpkGKYsx6/7LjrV0m0TtemIJPzClO1ikF57OD0ulmVAViLlcwLkssvmIb
 IY/TAaDR0z75cIXsDkNExVTdOjlWSWNBEKKDNqazOVGlfOY=
X-Google-Smtp-Source: AGHT+IEPo0GxprnqGJDQelXga9gxc6Y2ffx3HJUxcERC1OTFfheuKZYZzVA9yP4Ad9tSqkC6umtMBw==
X-Received: by 2002:a17:903:2341:b0:221:1cf:da1 with SMTP id
 d9443c01a7336-2210405c71emr122460925ad.24.1739747843048; 
 Sun, 16 Feb 2025 15:17:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 093/162] tcg: Merge INDEX_op_extract_{i32,i64}
Date: Sun, 16 Feb 2025 15:09:02 -0800
Message-ID: <20250216231012.2808572-94-richard.henderson@linaro.org>
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
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 14 ++++----------
 tcg/tcg-op.c             |  8 ++++----
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                | 12 ++++--------
 docs/devel/tcg-ops.rst   |  6 +++---
 tcg/tci/tcg-target.c.inc |  5 +----
 7 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 1d27b882fe..a8c304ca63 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -54,6 +54,7 @@ DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(extract, 1, 1, 2, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
@@ -89,7 +90,6 @@ DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
 DEF(deposit_i32, 1, 2, 2, 0)
-DEF(extract_i32, 1, 1, 2, 0)
 DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
@@ -112,7 +112,6 @@ DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
 DEF(deposit_i64, 1, 2, 2, 0)
-DEF(extract_i64, 1, 1, 2, 0)
 DEF(sextract_i64, 1, 1, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 87395f8ab5..6a9effab6b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2305,7 +2305,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode uext_opc = 0, sext_opc = 0;
+    TCGOpcode sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
     TCGOp *op2;
@@ -2326,17 +2326,11 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
-            uext_opc = INDEX_op_extract_i32;
-        }
         if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
             sext_opc = INDEX_op_sextract_i32;
         }
         break;
     case TCG_TYPE_I64:
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
-            uext_opc = INDEX_op_extract_i64;
-        }
         if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
             sext_opc = INDEX_op_sextract_i64;
         }
@@ -2355,8 +2349,8 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op->args[2] = sh;
         op->args[3] = 1;
         return;
-    } else if (sh && uext_opc) {
-        op->opc = uext_opc;
+    } else if (sh && TCG_TARGET_extract_valid(ctx->type, sh, 1)) {
+        op->opc = INDEX_op_extract;
         op->args[1] = src1;
         op->args[2] = sh;
         op->args[3] = 1;
@@ -2885,7 +2879,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_eqv_vec:
             done = fold_eqv(&ctx, op);
             break;
-        CASE_OP_32_64(extract):
+        case INDEX_op_extract:
             done = fold_extract(&ctx, op);
             break;
         CASE_OP_32_64(extract2):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ba062191ac..ddade73b7b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -998,7 +998,7 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
+        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
     if (ofs == 0) {
@@ -1008,7 +1008,7 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, 0, ofs + len);
         tcg_gen_shri_i32(ret, ret, ofs);
         return;
     }
@@ -2670,7 +2670,7 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
+        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
     if (ofs == 0) {
@@ -2680,7 +2680,7 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, 0, ofs + len);
         tcg_gen_shri_i64(ret, ret, ofs);
         return;
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a6e47664bb..80a78edb98 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1091,8 +1091,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_extract_i32, TCGOutOpExtract, outop_extract),
-    OUTOP(INDEX_op_extract_i64, TCGOutOpExtract, outop_extract),
+    OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -2326,6 +2325,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_brcond:
+    case INDEX_op_extract:
     case INDEX_op_mov:
     case INDEX_op_movcond:
     case INDEX_op_negsetcond:
@@ -2342,7 +2342,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_deposit_i32:
         return true;
@@ -2371,7 +2370,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
@@ -5507,8 +5505,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
+    case INDEX_op_extract:
         {
             const TCGOutOpExtract *out =
                 container_of(all_outop[op->opc], TCGOutOpExtract, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 30928c3412..6345029802 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -27,6 +27,7 @@
 
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
+#define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
 
 /*
  * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
@@ -656,9 +657,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
             break;
-        case INDEX_op_extract_i32:
+        case INDEX_op_extract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = extract32(regs[r1], pos, len);
+            regs[r0] = extract_tr(regs[r1], pos, len);
             break;
         case INDEX_op_sextract_i32:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
@@ -772,10 +773,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
-        case INDEX_op_extract_i64:
-            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = extract64(regs[r1], pos, len);
-            break;
         case INDEX_op_sextract_i64:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = sextract64(regs[r1], pos, len);
@@ -1057,8 +1054,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), str_r(r2), pos, len);
         break;
 
-    case INDEX_op_extract_i32:
-    case INDEX_op_extract_i64:
+    case INDEX_op_extract:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
         tci_args_rrbb(insn, &r0, &r1, &pos, &len);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 72a23d6ea2..2843f88772 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -456,7 +456,7 @@ Misc
        |
        |     *dest* = (*t1* & ~0x0f00) | ((*t2* << 8) & 0x0f00)
 
-   * - extract_i32/i64 *dest*, *t1*, *pos*, *len*
+   * - extract *dest*, *t1*, *pos*, *len*
 
        sextract_i32/i64 *dest*, *t1*, *pos*, *len*
 
@@ -467,12 +467,12 @@ Misc
          to the left with zeros; for sextract_*, the result will be extended
          to the left with copies of the bitfield sign bit at *pos* + *len* - 1.
        |
-       | For example, "sextract_i32 dest, t1, 8, 4" indicates a 4-bit field
+       | For example, "sextract dest, t1, 8, 4" indicates a 4-bit field
          at bit 8. This operation would be equivalent to
        |
        |    *dest* = (*t1* << 20) >> 28
        |
-       | (using an arithmetic right shift).
+       | (using an arithmetic right shift) on TCG_TYPE_I32.
 
    * - extract2_i32/i64 *dest*, *t1*, *t2*, *pos*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d8cf5d237b..ede11d9e70 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -436,10 +436,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
                             TCGReg rs, unsigned pos, unsigned len)
 {
-    TCGOpcode opc = type == TCG_TYPE_I32 ?
-                    INDEX_op_extract_i32 :
-                    INDEX_op_extract_i64;
-    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, pos, len);
 }
 
 static const TCGOutOpExtract outop_extract = {
-- 
2.43.0


