Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5DDC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mJQ-0007h9-0Q; Tue, 15 Apr 2025 15:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAS-0006IW-BU
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:16 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8f-0006VV-FN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:41:13 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c55500d08cso527816785a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746008; x=1745350808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+G8vJ2kGAYn6U5kRrUXQgJCAADvklAjAdFTsG7kgyJg=;
 b=Xc4BRwD1OTvax+opa2fFEVZpwyOnoCGTsIT9g/uAF/H/r5aJp9ne9eMW1kim5uR2r6
 dMQ3obtoCVvbilr8zqIQsPXmYaEWIfBNF4UE0M4AT5ti71/ljsxLo0Bg7rAYKzWMTiEk
 in2U8jM1q815BqTTOXiTBEQbQ97qxk9xCFW1lWKsp01VgrMJx/o0YlOhDnALfqtBmPaI
 IWLjfxAhHdPAL6xCGvaSMU6pwfL8wjNyupN+b2hqwrntPxvg/G53iC+CipVAzFI8HifE
 o+kBK08LS3bek+nO8D8wC8rz5zXklEaKTqSP2n6oYjBL/3QIA4L2LkLkZDMIluiZh7JH
 PXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746008; x=1745350808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+G8vJ2kGAYn6U5kRrUXQgJCAADvklAjAdFTsG7kgyJg=;
 b=jUjnUyRRZp8LJteZaAh9qSNIRR71B5dCMpnLJisPPwAdCakeEUjbJUoLVb3VrURo0K
 WWXYMxjxZfRNs7ydIzXGuQTLNdqfcrczkAD3S6ZyMyHYa334prAWSBmPV3LichR4/JRV
 c9f/8TpvtFzS+G6dVgwyVkPy2LVpdsSzu4pn6lloZtrBbJ6xq84Zlkpgd++xhHHzsEc9
 UzLz4erSOVzaGrCiV5/l56Ihur2buv+O5LjgT0osJxXUn+KOxd3ouOntAwTH9l+Cf2Ly
 nObIQ5v/ZI7irijI//8/fVPvS75Rj/vU0PhEVyuJQj7PKlCFE2Gn40HqrG7TrZtyBvdc
 U+cA==
X-Gm-Message-State: AOJu0YwhkcyQ4uBNYEm36qntGpE7LyXWdeMTGxSt5cpN4LBwi8fH0Qgz
 b0Q7l9NUqovxOtqhOSd596UMjg8Y+2JhM45Xx5B270hhS0ejOYz1i/21GlDF4E3jQmfTgouICWp
 7
X-Gm-Gg: ASbGncu1LaexpiX0982CX8LDGOeiTFfUgmRzeeb7yBA3KnVJM7X1hiMXGHeu/xkDNic
 5tXrVWkriSobnkxvMs2+nCpsQrzp6QnTHOhZJRbjXV0EvtjKAeeOOop+zUvaIkKYBJlE0BjN9dq
 gaJRzA8ZE9S++ynHYxGspfhK7+DJzUcuKmC4HGS1Hz1SON3sgC8uuSH/7RaTUUplMJ3hM9F10vh
 8hPs/IzvB+u3Xp3wGG9WsoiZdHNYCp9eVoCjl/IBDNbucDtQiW0t2XFXqTKuC5VAZhyKuK8szIX
 cubZNg+VTJqZ3utSxSQSAJf/2EtWOCwrKfk2T72u/PBd7peDw+Rm0r9qLg23E4uLkYQsRx24OGi
 owj1XN8lc2Q==
X-Google-Smtp-Source: AGHT+IFTBow9TpwMIE3wKqCZCFG4WDaOCJQtHnhMkYdd9Q7IvAKx7LDAb85r8SEBDV0+7XHq8Q0xFA==
X-Received: by 2002:a17:902:ce07:b0:223:62f5:fd44 with SMTP id
 d9443c01a7336-22c31a7cbc4mr5591875ad.40.1744745556261; 
 Tue, 15 Apr 2025 12:32:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 094/163] tcg: Merge INDEX_op_extract_{i32,i64}
Date: Tue, 15 Apr 2025 12:24:05 -0700
Message-ID: <20250415192515.232910-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
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
index 3f81dce074..5f5b323c66 100644
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
@@ -5516,8 +5514,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


