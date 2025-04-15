Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F343C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lzD-0007zH-RS; Tue, 15 Apr 2025 15:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyI-00051x-BU
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:26 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly9-0000uD-P6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:23 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af9a7717163so6191979a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745356; x=1745350156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=synVEIGLWtVlhIJKdpShXeJLPB1/9tWPJ7IsOSC3MpU=;
 b=yTk9TliZevCFCJbskSHU6C9ed2mFITkRyr5i+aiuNWcYznWWd0bhkh6HX2Go6qyjA0
 vLiCmWpL9SIMJRxetLVhyTxwAeK1zflynKB0Y9WDDLN6fN20Epx9Xq6XaVgDeGyj/pTw
 bxt3CDyWxwlPZ9fQOi4yxVp3cLs0kJsa+EOmrgAEtq1KgKV8x6JjgMWvLrnCa1D/dT6b
 bhHLVe5s7OH6A+VtDRn6iSsYiegjGImTQWkk3J6KTWJfBF/llFM8WBvytzb8xkyi1A9b
 DFgCpoXdon+j+9m8S+YMU64rGWyM8u0LMO5rZIY4/rYbVb0MOknep4w0P8gMuC7C1Ifk
 AK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745356; x=1745350156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=synVEIGLWtVlhIJKdpShXeJLPB1/9tWPJ7IsOSC3MpU=;
 b=fo77LeejUGkmcXTIKPQyCpmfxDSAwF9K+wf10JS8Wk31bfU+UOqIPJlmHVnjo07kyi
 SeY99NFCaRgVP+QsQJPvo5Mje54sz3iBPaEuUYbRvJrUMl4HtWYnWjsLZMr7xL0MlHe6
 Tyokn6gosmUnxn8viyuUbSJapimfbpVZKqYh7VUJnECClH721/GOjS3EsWmvRP7dSFEj
 ohQZ3Uqk/QSl4CvQCElaVml/3dTmmAS7o2i6iOjBv2zVaCSFQQjz91f1RPVb5Fd/f/sn
 +/c7IAEqANeIuKvmAOsOsVsxvMujGR4FKL69HcKjVemaCEvAyo9RuPrbZ6kvcG+e3XK/
 iu0A==
X-Gm-Message-State: AOJu0Yxt3nToP9mdd5uOA9lJxISG9cALN8bOAPGlW+ov+JLoz8OWgLT0
 yeUANvnpNzK1WnMxcEW64AMYjvHcJFR+Qsc+aJu8K6d8nO1y0VpsR7SjrSuTxoKeK4oJvgRXJfa
 v
X-Gm-Gg: ASbGncv91pSQB2NuPp4l8U7fFg5UMDbptqWxI+1L7pFzbw+L6liUZPKZSEw3ZVKQOvg
 JGJL9RJLMahGDmJwccvndwTElrWztsMpDZ9EY1beCof4RvJyS1EYVyv8oJUR1xS+UAR0ruCNvrE
 J2XCzHqwTFn3azEmoSpEGedcQFhC8CPr2r7xkXX6HAk6OZGjhi2gwF3bwU0xw4m+nsjL/zuBX0B
 zl5YPQADi7MJZuhVIv4DTmbQ6dQxG8hcmpr/zoT+2Wk0FKTZwRf36SN3d6Dv1nHHzB/tm0k9QFR
 1fAKPXu02pWUDptI2XbPVjiueovIU4ZfbMuoNVRr87lr3f6x4DfYnvOd8TRzlEzYJgXm9ssuq7g
 =
X-Google-Smtp-Source: AGHT+IEfhIxGkhPW3Cvjmavio/OvDOlYmQifGSMxSpwJ/we91LzOTcrzm8sIrimIjzio+AltztnZ9g==
X-Received: by 2002:a17:90a:d64f:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-3085eebb2camr560934a91.11.1744745355510; 
 Tue, 15 Apr 2025 12:29:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 069/163] tcg: Merge INDEX_op_muls2_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:40 -0700
Message-ID: <20250415192515.232910-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 tcg/optimize.c           | 17 +++++++++--------
 tcg/tcg-op.c             |  8 ++++----
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  6 ++----
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  3 +--
 7 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f4ccde074b..a45b22ca1a 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -51,6 +51,7 @@ DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
+DEF(muls2, 2, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
 DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
@@ -92,7 +93,6 @@ DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
 DEF(mulu2_i32, 2, 2, 0, 0)
-DEF(muls2_i32, 2, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -134,7 +134,6 @@ DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
 DEF(mulu2_i64, 2, 2, 0, 0)
-DEF(muls2_i64, 2, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 78979623c5..2b0ae4c12d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2062,16 +2062,17 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
             h = (int32_t)(l >> 32);
             l = (int32_t)l;
             break;
-        case INDEX_op_muls2_i32:
-            l = (int64_t)(int32_t)a * (int32_t)b;
-            h = l >> 32;
-            l = (int32_t)l;
-            break;
         case INDEX_op_mulu2_i64:
             mulu64(&l, &h, a, b);
             break;
-        case INDEX_op_muls2_i64:
-            muls64(&l, &h, a, b);
+        case INDEX_op_muls2:
+            if (ctx->type == TCG_TYPE_I32) {
+                l = (int64_t)(int32_t)a * (int32_t)b;
+                h = l >> 32;
+                l = (int32_t)l;
+            } else {
+                muls64(&l, &h, a, b);
+            }
             break;
         default:
             g_assert_not_reached();
@@ -2961,7 +2962,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_muluh:
             done = fold_mul_highpart(&ctx, op);
             break;
-        CASE_OP_32_64(muls2):
+        case INDEX_op_muls2:
         CASE_OP_32_64(mulu2):
             done = fold_multiply2(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8a0846a8d2..0f48484dfe 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1162,8 +1162,8 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_muls2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
+        tcg_gen_op4_i32(INDEX_op_muls2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
@@ -2880,8 +2880,8 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_muls2_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
+        tcg_gen_op4_i64(INDEX_op_muls2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e4b38d9bda..8e6f8c1194 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1041,8 +1041,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
-    OUTOP(INDEX_op_muls2_i32, TCGOutOpMul2, outop_muls2),
-    OUTOP(INDEX_op_muls2_i64, TCGOutOpMul2, outop_muls2),
+    OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
@@ -4008,8 +4007,7 @@ liveness_pass_1(TCGContext *s)
             }
             goto do_not_remove;
 
-        case INDEX_op_muls2_i32:
-        case INDEX_op_muls2_i64:
+        case INDEX_op_muls2:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh;
             goto do_mul2;
@@ -5474,8 +5472,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
+    case INDEX_op_muls2:
         {
             const TCGOutOpMul2 *out =
                 container_of(all_outop[op->opc], TCGOutOpMul2, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 51cbb5760a..708ded34c7 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -581,8 +581,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop_tr(regs[r1]);
             break;
-        case INDEX_op_muls2_i32:
-        case INDEX_op_muls2_i64:
+        case INDEX_op_muls2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
 #if TCG_TARGET_REG_BITS == 32
             tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
@@ -1095,10 +1094,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r3), str_r(r4), str_c(c));
         break;
 
+    case INDEX_op_muls2:
     case INDEX_op_mulu2_i32:
     case INDEX_op_mulu2_i64:
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1),
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fb7764e3c0..0394767291 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -604,7 +604,7 @@ Multiword arithmetic support
      - | Similar to mul, except two unsigned inputs *t1* and *t2* yielding the full
          double-word product *t0*. The latter is returned in two single-word outputs.
 
-   * - muls2_i32/i64 *t0_low*, *t0_high*, *t1*, *t2*
+   * - muls2 *t0_low*, *t0_high*, *t1*, *t2*
 
      - | Similar to mulu2, except the two inputs *t1* and *t2* are signed.
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index f568d4edb9..aa3ce929b4 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -716,8 +716,7 @@ static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
 static void tgen_muls2(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
 {
-    tcg_out_op_rrrr(s, glue(INDEX_op_muls2_i,TCG_TARGET_REG_BITS),
-                    a0, a1, a2, a3);
+    tcg_out_op_rrrr(s, INDEX_op_muls2, a0, a1, a2, a3);
 }
 
 static const TCGOutOpMul2 outop_muls2 = {
-- 
2.43.0


