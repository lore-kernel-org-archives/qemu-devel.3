Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09617C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R1F-0007gA-BG; Fri, 25 Apr 2025 17:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R12-0007YQ-Bd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R10-0000Zv-0o
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2474839b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618120; x=1746222920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSCMcYrDJdLsJnSiafZFwfyvjgp8QL/GE9cjVvRxU3c=;
 b=yRqL1LhHDgwgtOkfkHBCFMUmbCxL6U3xH6v3W0sjF1UWuIqKjgtnGFXqOOeJ6Zle0e
 kjkkta++BtTJh3+Zxp1O84kTPZmWkes4n3P/kfuBNZ8AQ3dodvKcOPWad6BCJS5YbYnt
 RO8JgmPYU8MIyO19DwmXdQt0EvzTQ/o98OTpXVoakDFt1ECuwtBHVD3gYvuDH3he1cpu
 tPffdiDdjbFP6lfGaPSqNOcMazheGl75L5NK5FeWxqJQc/vrfoSv7t1dZlI6FPmCxtQS
 Z1NFgSchM76w33vEYGu0mnCj+xV94vTrsPO2VVbQTQ0qTFUaFNR1dAFweebzE1CMGXxo
 kqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618120; x=1746222920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSCMcYrDJdLsJnSiafZFwfyvjgp8QL/GE9cjVvRxU3c=;
 b=X9AL36dAWUmKI939mFgxpmYZgpGcnj6Xpc9nFQfG+xUrSsjr67PIFP7+bypAlJ+H8o
 dH/IkBeSZfgnfwSKMqSXzkLHhroAC8MrNq102AGqOfY7AR7jHfLA/mb85rR63wQiTYzl
 MYzMg4z3CkK1NLf6T0AD4BjHTjH1rWvOVpWTETI6HKaFazdaBszg4SKEe9Pxx2pgbglX
 1bp6gzBHGeKaHyo72/GWZ4XG09g2ZEzDf3NXsSfUKzM7I317fhSKr3PMpfQfWflpj/q/
 hIvSZ4fgE8Jn7mxkD4lUzplu1vJACIEdLdHMbiF0lY7t0ihZ+Yr4P7lef+B2RizG/VpW
 472w==
X-Gm-Message-State: AOJu0YxocBYYkBdJvP+Fs8I14C3Wqnyx907nlwCJ9qvFXEOJ2bmG1vHN
 mlwx7uieYDBk3axsRxzcEdmVg75HZ9PMrFMhiUHOaYigaiErG5uGUl2nTp5Vm93rfF/a2ePKlfG
 I
X-Gm-Gg: ASbGncutRcfKm5wy3ZiNcpGgd+MuVcFZNcfNdMj0/yOfYFaUd+Q6k7q7QkJ8Lrzj9ol
 U6g1+VCba06V0saUDhXeJ1VqNVUPMD1RdY9Zbnz/OMJfBQ/LI+li/fOD9t6/XHhXxxyxykVciR3
 JJF7dl+thW6tLP1ACOyM152SDba0Zsi1K5UfgweiFQsKtdDFGmVgEC7ej/0sklMR+YUDlSJol3X
 QBZ8/W4oeDvVFh/c/B4frc7vo0x71wX9rpbYkWoe8McEAJ4eBLkzuX9t5dviEsabth1b4CsyEWh
 ny0V4n8OoqnoDhbO9MwlpaNbS0SeVrXZcD3P8LAyihXHe5jyIdkKoD98sL1zt8s+YIWLF2NrY1E
 =
X-Google-Smtp-Source: AGHT+IFrtiE49BmhUC0tIf8WSlVcedOB87eA4HXdQrhla19clmqc+THLLxsoPfwZLCDnvLi+eKzs4g==
X-Received: by 2002:a05:6a20:cfa4:b0:204:4573:d853 with SMTP id
 adf61e73a8af0-2045b6984fdmr5332211637.4.1745618120463; 
 Fri, 25 Apr 2025 14:55:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 034/159] tcg: Merge INDEX_op_sub_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:48 -0700
Message-ID: <20250425215454.886111-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index e4c319fe45..718809ab8d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -427,7 +427,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_add:
         return x + y;
 
-    CASE_OP_32_64(sub):
+    case INDEX_op_sub:
         return x - y;
 
     CASE_OP_32_64(mul):
@@ -3066,7 +3066,7 @@ void tcg_optimize(TCGContext *s)
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
index d7a44ac1b1..b31e9798c5 100644
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
@@ -5457,8 +5454,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


