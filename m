Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999EBC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmn-0005gQ-7m; Sun, 16 Feb 2025 18:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmY-0005aM-RH
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:38 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmW-0005Gx-QQ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:38 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso95082465ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747435; x=1740352235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvBwm2ARwIIYo+no03fcZ5ToGNWKAXpLeVi1uV5BIwE=;
 b=QZ5wG3yygjzAXBaga5FysofvXIV1gez84yboA53nHtiEt+54pd5UTjGhvktVNE1Xdg
 Q9YNRs/eDm0z/ZwvcYC6k0W4J8hikgUATcoOjss7P0X+KZj2AhmKRgZVkB6DOEL8I36g
 jpD8mTZifxuU9R5yqR1oGgqXbO7/E1HIhB4OLjF2pzkNkAiu/ThrLRPit5jqmfQpeXdW
 tyt7Sbhszl3LLqlKvpuHM4ASEWUvZzw2uQ3+qSCJmkWFwm+9N/KxF8YeH1o4BZ6ZRz9C
 bDDk17inJP5usIFubEz0bMK1pTjXVdhNEbZvEXm5hFRx04S1drkoaBWaz+8pPOIfmfZ0
 ee3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747435; x=1740352235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvBwm2ARwIIYo+no03fcZ5ToGNWKAXpLeVi1uV5BIwE=;
 b=tMvSwGE4ufmJtpfubXXo34lcHDa/ShApsSjI+1Xiqo4RTiEl2GZI3GO/3jHJ2+L6od
 SlQgy2uWcVenUjzIr2xXxVbF6Z75BRwUC4oLPMCtOI6kTzNJTeMrfSH0+ltqIE4ZLVLH
 rSaVbGrvQ5kvPWCSEq/MrVsNEHfLoFm1LtW4g2iMGvM14dFhcTRrUOB18iOYNbESSF08
 v6MNWyWF83x/sYKQvnsQhNA9vfFd7zXyJNIY14mhqcnHdh6w2liMi5QOucwqHQDreNFJ
 CHvxfWo7c0uXd4JT+d71uYwaBq5BOrmg1dyfCioPJB59kUl+m8z9W9FT7/podtDcpJSF
 Vd6A==
X-Gm-Message-State: AOJu0YznYcQDWyx0pJz6MTFYlxAmev+jrjtPyBUULVl06f1mA+2+OH1o
 mnzr/+IMd+1Vv4NQJGozuQLk0MGs1rBNROXX25d7Uni4rR7krDLDXtKQe+kQvAiWnoNuClm8fD9
 5
X-Gm-Gg: ASbGncuht4+YCGNRd9hgl2M5JxZFDUgqc+/qNcva4dmJa3WxDePehXa91Dh/SN6At4d
 Uj6acJUMDh0RsaUJADdK+DCIvTjnurIygaHTnItPsPOslrY2s8920fWlfkrK0FW1PaKx3N0raV4
 GOMKtONONglcmOAXAG3a4YwMajpCPLnx9DZIXrh4U1l9ZOkQgmMSlSUlz+R/xk055GnhC9TIHZn
 emODJVbRdHQC4kfahwuk7HSx2oj7Xc5x+rHg94qFwek0i9KsRLhwVFSRNKE2q1alVd4Ahm+cM+u
 UxphClt4h484Zar4NdsHFUF2OTtoptz77TGYoL4/1s2TK5c=
X-Google-Smtp-Source: AGHT+IEWZVyquuGV6qvj9+4+ykSmIoARGg8Q8rboJ46PBT2sp7cRXtPPT1Xnj5RByQ2d84nO4OSaEQ==
X-Received: by 2002:a17:902:e5d2:b0:20c:6399:d637 with SMTP id
 d9443c01a7336-221040a9b2dmr123454835ad.40.1739747435406; 
 Sun, 16 Feb 2025 15:10:35 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 029/162] tcg: Merge INDEX_op_sub_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:58 -0800
Message-ID: <20250216231012.2808572-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 tcg/optimize.c           |  4 ++--
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 10 +++-------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index aa9ed393c9..1be9b01caf 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -47,6 +47,7 @@ DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
+DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
@@ -62,7 +63,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
 DEF(div_i32, 1, 2, 0, 0)
 DEF(divu_i32, 1, 2, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(sub_i64, 1, 2, 0, 0)
 DEF(mul_i64, 1, 2, 0, 0)
 DEF(div_i64, 1, 2, 0, 0)
 DEF(divu_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1fe73f70ed..8927b1256c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -415,7 +415,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_add:
         return x + y;
 
-    CASE_OP_32_64(sub):
+    case INDEX_op_sub:
         return x - y;
 
     CASE_OP_32_64(mul):
@@ -3054,7 +3054,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-        CASE_OP_32_64(sub):
+        case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
         case INDEX_op_sub_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 228aa8f088..15faf4dc57 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -377,7 +377,7 @@ void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
 }
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -1565,7 +1565,7 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sub_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
     } else {
         tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                          TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ca91a80efc..ee2af15cf8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1020,8 +1020,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_sub_i32, TCGOutOpSubtract, outop_sub),
-    OUTOP(INDEX_op_sub_i64, TCGOutOpSubtract, outop_sub),
+    OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
 
@@ -4010,10 +4009,8 @@ liveness_pass_1(TCGContext *s)
             opc_new = INDEX_op_add;
             goto do_addsub2;
         case INDEX_op_sub2_i32:
-            opc_new = INDEX_op_sub_i32;
-            goto do_addsub2;
         case INDEX_op_sub2_i64:
-            opc_new = INDEX_op_sub_i64;
+            opc_new = INDEX_op_sub;
         do_addsub2:
             nb_iargs = 4;
             nb_oargs = 2;
@@ -5450,8 +5447,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
         {
             const TCGOutOpSubtract *out = &outop_sub;
 
diff --git a/tcg/tci.c b/tcg/tci.c
index ff129266c2..508d1405cd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -527,7 +527,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] + regs[r2];
             break;
-        CASE_32_64(sub)
+        case INDEX_op_sub:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] - regs[r2];
             break;
@@ -1080,9 +1080,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 26d464fa38..96b7f05919 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -265,7 +265,7 @@ Arithmetic
 
      - | *t0* = *t1* + *t2*
 
-   * - sub_i32/i64 *t0*, *t1*, *t2*
+   * - sub *t0*, *t1*, *t2*
 
      - | *t0* = *t1* - *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 353994e83f..67a46c6321 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -712,7 +712,7 @@ static const TCGOutOpBinary outop_orc = {
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_sub_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
 }
 
 static const TCGOutOpSubtract outop_sub = {
-- 
2.43.0


