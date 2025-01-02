Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A60AE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfe-0005jy-5I; Thu, 02 Jan 2025 13:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPen-0007Xu-9o
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPei-0006HB-CO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21661be2c2dso144729915ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841447; x=1736446247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qE41OY+UoaKdHmwHXR/XdocL/yHVQC/K8hnWzYaeUGU=;
 b=ljI2QPwI9MSR2mR1g0IPXg/iwgeOhyR51IqhqD4AOA4zeMUXizkwVAG9ZEK0GMEc/U
 quHHbVa+brKLLy0ystQ/BX67VN9JFS+Tkbe+/hA59vvV0w8XDM70jJPFeb20k2J77OZ9
 apOMKuKJPSdMoahiUfcXJ0OXWUnijlS+7rMMDVAQ6jpYSZHtZ+dVTpMjMaai4d6VzlDG
 bh93EVwYEdc0XfeDUkQdG82d3HTWrPcGiB9XsQkFD5xqj5aNpVF5xBMiP5HMpqIfXtyW
 Tzruk6Jhgx/Ga13QSpZnIT/DACIk4MpdEjlwD9AfbFFD7UrY66q5CXIBBWqb+iA6N3e5
 DAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841447; x=1736446247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qE41OY+UoaKdHmwHXR/XdocL/yHVQC/K8hnWzYaeUGU=;
 b=WBjRisEkhWVjuM9YLT9BtU+ceze+Bfa6g9b9m9w3rvXNH/Xqr7/2ACuYe9rnBZZntL
 S8W72vULdgJ3zwAqwbnyHc42vPmgIsCH6Reh0FZeYnlrf2k2WUIipHxzqXm5K2FSDvO0
 M1IRp+Gy0U4peuPwKNDaMv/eYSvJFo7hWrEKR39bs7MhsrePrtRhroIZx6wxj9VVF9sm
 8oqRBSSOx1zaqOr5jwSSxGG+9CM6Gon1kI3gnr7SDpyapzcyTP4O4q5vaBC8TMr3bVBQ
 26kAhcTn+COvHEsnPBmQkq1NIQ8/VIGflg8yj9ZIL468zLiO2SdXukaCWv6MxpK0EIjs
 95+w==
X-Gm-Message-State: AOJu0YzW9G5gZaj1MMClCyflN7QaHiUy31WnWzTuw/tfhbqV+UXR0dUm
 A73fJKttLJAnTsZ4KR3mL5VQmXofRDnG5JE9tAqJKAPngQE/Nl9phvWh4p8syGtbb7tSm6yMeor
 V
X-Gm-Gg: ASbGncvv+YiVuwS1ZGR9ucTcrkcehIRoiEE9rLMANgeZfpTlECbLiBmWvznf2y5zQst
 sT5rkJWJh20ONFb1cZ7L+l6E3FXmQl1OqUwR/AG34ZdZuSpQkbM6a2I1c7xUO/ddlWZ0sTetSoe
 sNJoDTD+Gjm+WccZCVAsoNJzLx4zZc58pdmoQs2sZLij+9ZFCCP1/jcFjlLHFQFQS1iLDiLPwKw
 1ehxHJemQfA797D+CaIuVJiR+3v7PCAcXawb4nVqVWhbr4diHZW0bQlFNqPUA==
X-Google-Smtp-Source: AGHT+IFZzmbKdZUxmYWzleYL6wqA7Rn/+HiW0y6PRHsHbn9XXu52IJNMlA6X0+xz3EMWtTnFNFzzYA==
X-Received: by 2002:a05:6a21:9989:b0:1e1:a8e1:b104 with SMTP id
 adf61e73a8af0-1e5e081d68amr71324981637.45.1735841446451; 
 Thu, 02 Jan 2025 10:10:46 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 65/73] tcg: Merge integer mul, div operations
Date: Thu,  2 Jan 2025 10:06:45 -0800
Message-ID: <20250102180654.1420056-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

For TCI, we're losing type information from the interpreter.
Limit the opcodes to the host register size; on 64-bit host
it's just as easy to reconstruct 64-bit operands for normal
multiply and divide.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  36 ++-----
 tcg/tci/tcg-target-has.h         |   6 +-
 tcg/optimize.c                   |  99 ++++++++++--------
 tcg/tcg-op.c                     |  68 ++++++------
 tcg/tcg.c                        |  80 +++++---------
 tcg/tci.c                        |  94 +++++++----------
 tcg/aarch64/tcg-target.c.inc     |  38 +++----
 tcg/arm/tcg-target.c.inc         |  20 ++--
 tcg/i386/tcg-target.c.inc        |  25 ++---
 tcg/loongarch64/tcg-target.c.inc |  98 ++++++++---------
 tcg/mips/tcg-target.c.inc        | 174 +++++++++++++------------------
 tcg/ppc/tcg-target.c.inc         | 102 +++++++++---------
 tcg/riscv/tcg-target.c.inc       |  82 +++++++--------
 tcg/s390x/tcg-target.c.inc       | 117 +++++++++------------
 tcg/sparc64/tcg-target.c.inc     |  61 +++++------
 tcg/tci/tcg-target.c.inc         |  35 +++----
 16 files changed, 504 insertions(+), 631 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 8d733462f6..964f919205 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -52,6 +52,17 @@ DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(add2, 2, 4, 0, TCG_OPF_INT)
 DEF(sub2, 2, 4, 0, TCG_OPF_INT)
+DEF(mul, 1, 2, 0, TCG_OPF_INT)
+DEF(mulu2, 2, 2, 0, TCG_OPF_INT)
+DEF(muls2, 2, 2, 0, TCG_OPF_INT)
+DEF(muluh, 1, 2, 0, TCG_OPF_INT)
+DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
+DEF(div, 1, 2, 0, TCG_OPF_INT)
+DEF(divu, 1, 2, 0, TCG_OPF_INT)
+DEF(rem, 1, 2, 0, TCG_OPF_INT)
+DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(div2, 2, 3, 0, TCG_OPF_INT)
+DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -59,14 +70,6 @@ DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld_i32, 1, 1, 2, 0)
 DEF(st_i32, 0, 2, 2, 0)
-/* arith */
-DEF(mul_i32, 1, 2, 0, 0)
-DEF(div_i32, 1, 2, 0, 0)
-DEF(divu_i32, 1, 2, 0, 0)
-DEF(rem_i32, 1, 2, 0, 0)
-DEF(remu_i32, 1, 2, 0, 0)
-DEF(div2_i32, 2, 3, 0, 0)
-DEF(divu2_i32, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -80,10 +83,6 @@ DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
-DEF(mulu2_i32, 2, 2, 0, 0)
-DEF(muls2_i32, 2, 2, 0, 0)
-DEF(muluh_i32, 1, 2, 0, 0)
-DEF(mulsh_i32, 1, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -99,14 +98,6 @@ DEF(movcond_i64, 1, 4, 1, 0)
 /* load/store */
 DEF(ld_i64, 1, 1, 2, 0)
 DEF(st_i64, 0, 2, 2, 0)
-/* arith */
-DEF(mul_i64, 1, 2, 0, 0)
-DEF(div_i64, 1, 2, 0, 0)
-DEF(divu_i64, 1, 2, 0, 0)
-DEF(rem_i64, 1, 2, 0, 0)
-DEF(remu_i64, 1, 2, 0, 0)
-DEF(div2_i64, 2, 3, 0, 0)
-DEF(divu2_i64, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
@@ -132,11 +123,6 @@ DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
 
-DEF(mulu2_i64, 2, 2, 0, 0)
-DEF(muls2_i64, 2, 2, 0, 0)
-DEF(muluh_i64, 1, 2, 0, 0)
-DEF(mulsh_i64, 1, 2, 0, 0)
-
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
 /* There are tcg_ctx->insn_start_words here, not just one. */
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 8534081daa..861fa42385 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -13,9 +13,9 @@
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         1
 #define TCG_TARGET_HAS_ctz(T)           1
-#define TCG_TARGET_HAS_div(T)           1
-#define TCG_TARGET_HAS_muls2(T)         1
-#define TCG_TARGET_HAS_mulu2(T)         1
+#define TCG_TARGET_HAS_div(T)           (T == TCG_TYPE_REG)
+#define TCG_TARGET_HAS_muls2(T)         (T == TCG_TYPE_REG)
+#define TCG_TARGET_HAS_mulu2(T)         (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_mulsh(T)         0
 #define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_negsetcond(T)    0
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9bd737e2b0..da3bec5d43 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -403,7 +403,7 @@ static bool tcg_opt_gen_movi(OptContext *ctx, TCGOp *op,
     return tcg_opt_gen_mov(ctx, op, dst, arg_new_constant(ctx, op->type, val));
 }
 
-static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
+static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type, uint64_t x, uint64_t y)
 {
     uint64_t l64, h64;
 
@@ -414,7 +414,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_sub:
         return x - y;
 
-    CASE_OP_32_64(mul):
+    case INDEX_op_mul:
         return x * y;
 
     case INDEX_op_and:
@@ -525,35 +525,40 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_extrh_i64_i32:
         return (uint64_t)x >> 32;
 
-    case INDEX_op_muluh_i32:
-        return ((uint64_t)(uint32_t)x * (uint32_t)y) >> 32;
-    case INDEX_op_mulsh_i32:
-        return ((int64_t)(int32_t)x * (int32_t)y) >> 32;
-
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
+        if (type == TCG_TYPE_I32) {
+            return ((uint64_t)(uint32_t)x * (uint32_t)y) >> 32;
+        }
         mulu64(&l64, &h64, x, y);
         return h64;
-    case INDEX_op_mulsh_i64:
+
+    case INDEX_op_mulsh:
+        if (type == TCG_TYPE_I32) {
+            return ((int64_t)(int32_t)x * (int32_t)y) >> 32;
+        }
         muls64(&l64, &h64, x, y);
         return h64;
 
-    case INDEX_op_div_i32:
+    case INDEX_op_div:
         /* Avoid crashing on divide by zero, otherwise undefined.  */
-        return (int32_t)x / ((int32_t)y ? : 1);
-    case INDEX_op_divu_i32:
-        return (uint32_t)x / ((uint32_t)y ? : 1);
-    case INDEX_op_div_i64:
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x / ((int32_t)y ? : 1);
+        }
         return (int64_t)x / ((int64_t)y ? : 1);
-    case INDEX_op_divu_i64:
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x / ((uint32_t)y ? : 1);
+        }
         return (uint64_t)x / ((uint64_t)y ? : 1);
-
-    case INDEX_op_rem_i32:
-        return (int32_t)x % ((int32_t)y ? : 1);
-    case INDEX_op_remu_i32:
-        return (uint32_t)x % ((uint32_t)y ? : 1);
-    case INDEX_op_rem_i64:
+    case INDEX_op_rem:
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x % ((int32_t)y ? : 1);
+        }
         return (int64_t)x % ((int64_t)y ? : 1);
-    case INDEX_op_remu_i64:
+    case INDEX_op_remu:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x % ((uint32_t)y ? : 1);
+        }
         return (uint64_t)x % ((uint64_t)y ? : 1);
 
     default:
@@ -564,7 +569,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
 static uint64_t do_constant_folding(TCGOpcode op, TCGType type,
                                     uint64_t x, uint64_t y)
 {
-    uint64_t res = do_constant_folding_2(op, x, y);
+    uint64_t res = do_constant_folding_2(op, type, x, y);
     if (type == TCG_TYPE_I32) {
         res = (int32_t)res;
     }
@@ -2020,21 +2025,23 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         TCGOp *op2;
 
         switch (op->opc) {
-        case INDEX_op_mulu2_i32:
-            l = (uint64_t)(uint32_t)a * (uint32_t)b;
-            h = (int32_t)(l >> 32);
-            l = (int32_t)l;
+        case INDEX_op_mulu2:
+            if (op->type == TCG_TYPE_I32) {
+                l = (uint64_t)(uint32_t)a * (uint32_t)b;
+                h = (int32_t)(l >> 32);
+                l = (int32_t)l;
+            } else {
+                mulu64(&l, &h, a, b);
+            }
             break;
-        case INDEX_op_muls2_i32:
-            l = (int64_t)(int32_t)a * (int32_t)b;
-            h = l >> 32;
-            l = (int32_t)l;
-            break;
-        case INDEX_op_mulu2_i64:
-            mulu64(&l, &h, a, b);
-            break;
-        case INDEX_op_muls2_i64:
-            muls64(&l, &h, a, b);
+        case INDEX_op_muls2:
+            if (op->type == TCG_TYPE_I32) {
+                l = (int64_t)(int32_t)a * (int32_t)b;
+                h = l >> 32;
+                l = (int32_t)l;
+            } else {
+                muls64(&l, &h, a, b);
+            }
             break;
         default:
             g_assert_not_reached();
@@ -2785,8 +2792,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(deposit):
             done = fold_deposit(&ctx, op);
             break;
-        CASE_OP_32_64(div):
-        CASE_OP_32_64(divu):
+        case INDEX_op_div:
+        case INDEX_op_divu:
             done = fold_divide(&ctx, op);
             break;
         case INDEX_op_dup_vec:
@@ -2833,15 +2840,15 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(movcond):
             done = fold_movcond(&ctx, op);
             break;
-        CASE_OP_32_64(mul):
+        case INDEX_op_mul:
             done = fold_mul(&ctx, op);
             break;
-        CASE_OP_32_64(mulsh):
-        CASE_OP_32_64(muluh):
+        case INDEX_op_mulsh:
+        case INDEX_op_muluh:
             done = fold_mul_highpart(&ctx, op);
             break;
-        CASE_OP_32_64(muls2):
-        CASE_OP_32_64(mulu2):
+        case INDEX_op_muls2:
+        case INDEX_op_mulu2:
             done = fold_multiply2(&ctx, op);
             break;
         case INDEX_op_nand:
@@ -2890,8 +2897,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_qemu_st_a64_i128:
             done = fold_qemu_st(&ctx, op);
             break;
-        CASE_OP_32_64(rem):
-        CASE_OP_32_64(remu):
+        case INDEX_op_rem:
+        case INDEX_op_remu:
             done = fold_remainder(&ctx, op);
             break;
         CASE_OP_32_64(rotl):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 81b18762fa..18839714f3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -578,7 +578,7 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
 
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_mul_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
 }
 
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -595,11 +595,11 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_div_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_div, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_div2_i32, ret, t0, arg1, t0, arg2);
+        tcg_gen_op5_i32(INDEX_op_div2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_div_i32(ret, arg1, arg2);
@@ -609,17 +609,17 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_rem, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_div_i32, t0, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_div, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
     } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_div2_i32, t0, ret, arg1, t0, arg2);
+        tcg_gen_op5_i32(INDEX_op_div2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_rem_i32(ret, arg1, arg2);
@@ -629,11 +629,11 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_divu_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, ret, t0, arg1, zero, arg2);
+        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_divu_i32(ret, arg1, arg2);
@@ -643,17 +643,17 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu_i32, t0, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
     } else if (TCG_TARGET_HAS_div2(TCG_TYPE_I32)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, t0, ret, arg1, zero, arg2);
+        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_remu_i32(ret, arg1, arg2);
@@ -1128,11 +1128,11 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I32)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
+        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
     } else if (TCG_TARGET_HAS_muluh(TCG_TYPE_I32)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul_i32, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh_i32, rh, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
     } else if (TCG_TARGET_REG_BITS == 64) {
@@ -1152,11 +1152,11 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_muls2(TCG_TYPE_I32)) {
-        tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
+        tcg_gen_op4_i32(INDEX_op_muls2, rl, rh, arg1, arg2);
     } else if (TCG_TARGET_HAS_mulsh(TCG_TYPE_I32)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul_i32, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_mulsh_i32, rh, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_mulsh, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
     } else if (TCG_TARGET_REG_BITS == 32) {
@@ -1633,7 +1633,7 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     TCGv_i32 t1;
 
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_mul_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
         return;
     }
 
@@ -1967,13 +1967,13 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
-            tcg_gen_op3_i64(INDEX_op_div_i64, ret, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_div, ret, arg1, arg2);
             return;
         }
         if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
             TCGv_i64 t0 = tcg_temp_ebb_new_i64();
             tcg_gen_sari_i64(t0, arg1, 63);
-            tcg_gen_op5_i64(INDEX_op_div2_i64, ret, t0, arg1, t0, arg2);
+            tcg_gen_op5_i64(INDEX_op_div2, ret, t0, arg1, t0, arg2);
             tcg_temp_free_i64(t0);
             return;
         }
@@ -1985,12 +1985,12 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_rem(TCG_TYPE_I64)) {
-            tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_rem, ret, arg1, arg2);
             return;
         }
         if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
             TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-            tcg_gen_op3_i64(INDEX_op_div_i64, t0, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_div, t0, arg1, arg2);
             tcg_gen_mul_i64(t0, t0, arg2);
             tcg_gen_sub_i64(ret, arg1, t0);
             tcg_temp_free_i64(t0);
@@ -1999,7 +1999,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
             TCGv_i64 t0 = tcg_temp_ebb_new_i64();
             tcg_gen_sari_i64(t0, arg1, 63);
-            tcg_gen_op5_i64(INDEX_op_div2_i64, t0, ret, arg1, t0, arg2);
+            tcg_gen_op5_i64(INDEX_op_div2, t0, ret, arg1, t0, arg2);
             tcg_temp_free_i64(t0);
             return;
         }
@@ -2011,13 +2011,13 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
-            tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
             return;
         }
         if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
             TCGv_i64 t0 = tcg_temp_ebb_new_i64();
             TCGv_i64 zero = tcg_constant_i64(0);
-            tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, zero, arg2);
+            tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
             tcg_temp_free_i64(t0);
             return;
         }
@@ -2029,12 +2029,12 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_rem(TCG_TYPE_I64)) {
-            tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
             return;
         }
         if (TCG_TARGET_HAS_div(TCG_TYPE_I64)) {
             TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-            tcg_gen_op3_i64(INDEX_op_divu_i64, t0, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
             tcg_gen_mul_i64(t0, t0, arg2);
             tcg_gen_sub_i64(ret, arg1, t0);
             tcg_temp_free_i64(t0);
@@ -2043,7 +2043,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         if (TCG_TARGET_HAS_div2(TCG_TYPE_I64)) {
             TCGv_i64 t0 = tcg_temp_ebb_new_i64();
             TCGv_i64 zero = tcg_constant_i64(0);
-            tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, zero, arg2);
+            tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
             tcg_temp_free_i64(t0);
             return;
         }
@@ -2881,13 +2881,13 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I64)) {
-            tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
+            tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
             return;
         }
         if (TCG_TARGET_HAS_muluh(TCG_TYPE_I64)) {
             t = tcg_temp_ebb_new_i64();
-            tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
-            tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
             tcg_gen_mov_i64(rl, t);
             tcg_temp_free_i64(t);
             return;
@@ -2906,13 +2906,13 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_muls2(TCG_TYPE_I64)) {
-            tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
+            tcg_gen_op4_i64(INDEX_op_muls2, rl, rh, arg1, arg2);
             return;
         }
         if (TCG_TARGET_HAS_mulsh(TCG_TYPE_I64)) {
             t = tcg_temp_ebb_new_i64();
-            tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
-            tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
             tcg_gen_mov_i64(rl, t);
             tcg_temp_free_i64(t);
             return;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6d19399c9b..03e5a93600 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2188,6 +2188,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_mov:
+    case INDEX_op_mul:
     case INDEX_op_neg:
     case INDEX_op_or:
     case INDEX_op_sub:
@@ -2199,7 +2200,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_movcond_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_mul_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -2212,8 +2212,22 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return has_type && TCG_TARGET_HAS_add2(type);
     case INDEX_op_andc:
         return has_type && TCG_TARGET_HAS_andc(type);
+    case INDEX_op_div:
+    case INDEX_op_divu:
+        return has_type && TCG_TARGET_HAS_div(type);
+    case INDEX_op_div2:
+    case INDEX_op_divu2:
+        return has_type && TCG_TARGET_HAS_div2(type);
     case INDEX_op_eqv:
         return has_type && TCG_TARGET_HAS_eqv(type);
+    case INDEX_op_muls2:
+        return has_type && TCG_TARGET_HAS_muls2(type);
+    case INDEX_op_mulsh:
+        return has_type && TCG_TARGET_HAS_mulsh(type);
+    case INDEX_op_mulu2:
+        return has_type && TCG_TARGET_HAS_mulu2(type);
+    case INDEX_op_muluh:
+        return has_type && TCG_TARGET_HAS_muluh(type);
     case INDEX_op_nand:
         return has_type && TCG_TARGET_HAS_nand(type);
     case INDEX_op_nor:
@@ -2222,33 +2236,19 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return has_type && TCG_TARGET_HAS_not(type);
     case INDEX_op_orc:
         return has_type && TCG_TARGET_HAS_orc(type);
+    case INDEX_op_rem:
+    case INDEX_op_remu:
+        return has_type && TCG_TARGET_HAS_rem(type);
     case INDEX_op_sub2:
         return has_type && TCG_TARGET_HAS_sub2(type);
 
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32);
-    case INDEX_op_div_i32:
-    case INDEX_op_divu_i32:
-        return TCG_TARGET_HAS_div(TCG_TYPE_I32);
-    case INDEX_op_rem_i32:
-    case INDEX_op_remu_i32:
-        return TCG_TARGET_HAS_rem(TCG_TYPE_I32);
-    case INDEX_op_div2_i32:
-    case INDEX_op_divu2_i32:
-        return TCG_TARGET_HAS_div2(TCG_TYPE_I32);
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2(TCG_TYPE_I32);
-    case INDEX_op_mulu2_i32:
-        return TCG_TARGET_HAS_mulu2(TCG_TYPE_I32);
-    case INDEX_op_muls2_i32:
-        return TCG_TARGET_HAS_muls2(TCG_TYPE_I32);
-    case INDEX_op_muluh_i32:
-        return TCG_TARGET_HAS_muluh(TCG_TYPE_I32);
-    case INDEX_op_mulsh_i32:
-        return TCG_TARGET_HAS_mulsh(TCG_TYPE_I32);
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap(TCG_TYPE_I32);
@@ -2268,7 +2268,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_movcond_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_mul_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -2283,15 +2282,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
 
     case INDEX_op_negsetcond_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64);
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_div(TCG_TYPE_I64);
-    case INDEX_op_rem_i64:
-    case INDEX_op_remu_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rem(TCG_TYPE_I64);
-    case INDEX_op_div2_i64:
-    case INDEX_op_divu2_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_div2(TCG_TYPE_I64);
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
@@ -2307,14 +2297,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctz(TCG_TYPE_I64);
     case INDEX_op_ctpop_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctpop(TCG_TYPE_I64);
-    case INDEX_op_mulu2_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_mulu2(TCG_TYPE_I64);
-    case INDEX_op_muls2_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_muls2(TCG_TYPE_I64);
-    case INDEX_op_muluh_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_muluh(TCG_TYPE_I64);
-    case INDEX_op_mulsh_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_mulsh(TCG_TYPE_I64);
 
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
@@ -3974,25 +3956,15 @@ liveness_pass_1(TCGContext *s)
             }
             goto do_not_remove;
 
-        case INDEX_op_mulu2_i32:
-            opc_new = INDEX_op_mul_i32;
-            opc_new2 = INDEX_op_muluh_i32;
-            have_opc_new2 = TCG_TARGET_HAS_muluh(TCG_TYPE_I32);
+        case INDEX_op_mulu2:
+            opc_new = INDEX_op_mul;
+            opc_new2 = INDEX_op_muluh;
+            have_opc_new2 = TCG_TARGET_HAS_muluh(op->type);
             goto do_mul2;
-        case INDEX_op_muls2_i32:
-            opc_new = INDEX_op_mul_i32;
-            opc_new2 = INDEX_op_mulsh_i32;
-            have_opc_new2 = TCG_TARGET_HAS_mulsh(TCG_TYPE_I32);
-            goto do_mul2;
-        case INDEX_op_mulu2_i64:
-            opc_new = INDEX_op_mul_i64;
-            opc_new2 = INDEX_op_muluh_i64;
-            have_opc_new2 = TCG_TARGET_HAS_muluh(TCG_TYPE_I64);
-            goto do_mul2;
-        case INDEX_op_muls2_i64:
-            opc_new = INDEX_op_mul_i64;
-            opc_new2 = INDEX_op_mulsh_i64;
-            have_opc_new2 = TCG_TARGET_HAS_mulsh(TCG_TYPE_I64);
+        case INDEX_op_muls2:
+            opc_new = INDEX_op_mul;
+            opc_new2 = INDEX_op_mulsh;
+            have_opc_new2 = TCG_TARGET_HAS_mulsh(op->type);
             goto do_mul2;
         do_mul2:
             nb_iargs = 2;
diff --git a/tcg/tci.c b/tcg/tci.c
index b9c9bc27f7..6fcd3c9643 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -539,7 +539,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] - regs[r2];
             break;
-        CASE_32_64(mul)
+        case INDEX_op_mul:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] * regs[r2];
             break;
@@ -576,24 +576,27 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
 
+            /* Arithmetic operations */
+
+        case INDEX_op_div:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (tcg_target_long)regs[r1] / (tcg_target_long)regs[r2];
+            break;
+        case INDEX_op_divu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] / regs[r2];
+            break;
+        case INDEX_op_rem:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (tcg_target_long)regs[r1] % (tcg_target_long)regs[r2];
+            break;
+        case INDEX_op_remu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] % regs[r2];
+            break;
+
             /* Arithmetic operations (32 bit). */
 
-        case INDEX_op_div_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int32_t)regs[r1] / (int32_t)regs[r2];
-            break;
-        case INDEX_op_divu_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
-            break;
-        case INDEX_op_rem_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
-            break;
-        case INDEX_op_remu_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
-            break;
         case INDEX_op_clz_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             tmp32 = regs[r1];
@@ -675,15 +678,23 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 regs[r1] = T2;
             }
             break;
-        case INDEX_op_mulu2_i32:
+        case INDEX_op_mulu2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+#if TCG_TARGET_REG_BITS == 32
             tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
             tci_write_reg64(regs, r1, r0, tmp64);
+#else
+            mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
+#endif
             break;
-        case INDEX_op_muls2_i32:
+        case INDEX_op_muls2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+#if TCG_TARGET_REG_BITS == 32
             tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
             tci_write_reg64(regs, r1, r0, tmp64);
+#else
+            muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
+#endif
             break;
         CASE_32_64(bswap16)
             tci_args_rr(insn, &r0, &r1);
@@ -722,22 +733,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Arithmetic operations (64 bit). */
 
-        case INDEX_op_div_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
-            break;
-        case INDEX_op_divu_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
-            break;
-        case INDEX_op_rem_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
-            break;
-        case INDEX_op_remu_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
-            break;
         case INDEX_op_clz_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
@@ -750,14 +745,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop64(regs[r1]);
             break;
-        case INDEX_op_mulu2_i64:
-            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-            mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
-            break;
-        case INDEX_op_muls2_i64:
-            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-            muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
-            break;
 
             /* Shift/rotate operations (64 bit). */
 
@@ -1078,8 +1065,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_add:
     case INDEX_op_sub:
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
+    case INDEX_op_mul:
     case INDEX_op_and:
     case INDEX_op_or:
     case INDEX_op_xor:
@@ -1088,14 +1074,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_eqv:
     case INDEX_op_nand:
     case INDEX_op_nor:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
+    case INDEX_op_div:
+    case INDEX_op_rem:
+    case INDEX_op_divu:
+    case INDEX_op_remu:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
@@ -1140,10 +1122,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r3), str_r(r4), str_c(c));
         break;
 
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_mulu2_i64:
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
+    case INDEX_op_mulu2:
+    case INDEX_op_muls2:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1),
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index af3b9ad542..dfe8c13c24 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2267,27 +2267,22 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_mul_i64:
-    case INDEX_op_mul_i32:
+    case INDEX_op_mul:
         tcg_out_insn(s, 3509, MADD, ext, a0, a1, a2, TCG_REG_XZR);
         break;
 
-    case INDEX_op_div_i64:
-    case INDEX_op_div_i32:
+    case INDEX_op_div:
         tcg_out_insn(s, 3508, SDIV, ext, a0, a1, a2);
         break;
-    case INDEX_op_divu_i64:
-    case INDEX_op_divu_i32:
+    case INDEX_op_divu:
         tcg_out_insn(s, 3508, UDIV, ext, a0, a1, a2);
         break;
 
-    case INDEX_op_rem_i64:
-    case INDEX_op_rem_i32:
+    case INDEX_op_rem:
         tcg_out_insn(s, 3508, SDIV, ext, TCG_REG_TMP0, a1, a2);
         tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
         break;
-    case INDEX_op_remu_i64:
-    case INDEX_op_remu_i32:
+    case INDEX_op_remu:
         tcg_out_insn(s, 3508, UDIV, ext, TCG_REG_TMP0, a1, a2);
         tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
         break;
@@ -2467,10 +2462,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                         const_args[5], true);
         break;
 
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
         tcg_out_insn(s, 3508, UMULH, TCG_TYPE_I64, a0, a1, a2);
         break;
-    case INDEX_op_mulsh_i64:
+    case INDEX_op_mulsh:
         tcg_out_insn(s, 3508, SMULH, TCG_TYPE_I64, a0, a1, a2);
         break;
 
@@ -2971,18 +2966,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
-    case INDEX_op_muluh_i64:
-    case INDEX_op_mulsh_i64:
+    case INDEX_op_mul:
+    case INDEX_op_div:
+    case INDEX_op_divu:
+    case INDEX_op_rem:
+    case INDEX_op_remu:
+    case INDEX_op_muluh:
+    case INDEX_op_mulsh:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_and:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index d2014008a2..d506880e52 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1989,13 +1989,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dat_reg(s, COND_AL,
                         ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
         break;
-    case INDEX_op_mul_i32:
+    case INDEX_op_mul:
         tcg_out_mul32(s, COND_AL, args[0], args[1], args[2]);
         break;
-    case INDEX_op_mulu2_i32:
+    case INDEX_op_mulu2:
         tcg_out_umull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    case INDEX_op_muls2_i32:
+    case INDEX_op_muls2:
         tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
     /* XXX: Perhaps args[2] & 0x1f is wrong */
@@ -2155,10 +2155,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_div_i32:
+    case INDEX_op_div:
         tcg_out_sdiv(s, COND_AL, args[0], args[1], args[2]);
         break;
-    case INDEX_op_divu_i32:
+    case INDEX_op_divu:
         tcg_out_udiv(s, COND_AL, args[0], args[1], args[2]);
         break;
 
@@ -2205,13 +2205,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctz_i32:
         return C_O1_I2(r, r, rIK);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_div_i32:
-    case INDEX_op_divu_i32:
+    case INDEX_op_mul:
+    case INDEX_op_div:
+    case INDEX_op_divu:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_muls2_i32:
+    case INDEX_op_mulu2:
+    case INDEX_op_muls2:
         return C_O2_I2(r, r, r, r);
 
     case INDEX_op_or:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 456e93ad4f..fa8590a3b3 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2780,7 +2780,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(mul):
+    case INDEX_op_mul:
         if (const_a2) {
             int32_t val;
             val = a2;
@@ -2796,10 +2796,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(div2):
+    case INDEX_op_div2:
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IDIV, args[4]);
         break;
-    OP_32_64(divu2):
+    case INDEX_op_divu2:
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_DIV, args[4]);
         break;
 
@@ -2963,10 +2963,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
         break;
 
-    OP_32_64(mulu2):
+    case INDEX_op_mulu2:
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, args[3]);
         break;
-    OP_32_64(muls2):
+    case INDEX_op_muls2:
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IMUL, args[3]);
         break;
     case INDEX_op_add2:
@@ -3696,8 +3696,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O1_I2(r, r, re);
 
     case INDEX_op_sub:
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
+    case INDEX_op_mul:
     case INDEX_op_or:
     case INDEX_op_xor:
         return C_O1_I2(r, 0, re);
@@ -3765,16 +3764,12 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, reT, r, 0);
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
-    case INDEX_op_divu2_i32:
-    case INDEX_op_divu2_i64:
+    case INDEX_op_div2:
+    case INDEX_op_divu2:
         return C_O2_I3(a, d, 0, 1, r);
 
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_mulu2_i64:
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
+    case INDEX_op_mulu2:
+    case INDEX_op_muls2:
         return C_O2_I2(a, d, a, r);
 
     case INDEX_op_add2:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2d23fae5dc..c0e1ce8090 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1557,53 +1557,60 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mul_i32:
-        tcg_out_opc_mul_w(s, a0, a1, a2);
-        break;
-    case INDEX_op_mul_i64:
-        tcg_out_opc_mul_d(s, a0, a1, a2);
+    case INDEX_op_mul:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_mul_w(s, a0, a1, a2);
+        } else {
+            tcg_out_opc_mul_d(s, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_mulsh_i32:
-        tcg_out_opc_mulh_w(s, a0, a1, a2);
-        break;
-    case INDEX_op_mulsh_i64:
-        tcg_out_opc_mulh_d(s, a0, a1, a2);
+    case INDEX_op_mulsh:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_mulh_w(s, a0, a1, a2);
+        } else {
+            tcg_out_opc_mulh_d(s, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_muluh_i32:
-        tcg_out_opc_mulh_wu(s, a0, a1, a2);
-        break;
-    case INDEX_op_muluh_i64:
-        tcg_out_opc_mulh_du(s, a0, a1, a2);
+    case INDEX_op_muluh:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_mulh_wu(s, a0, a1, a2);
+        } else {
+            tcg_out_opc_mulh_du(s, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_div_i32:
-        tcg_out_opc_div_w(s, a0, a1, a2);
-        break;
-    case INDEX_op_div_i64:
-        tcg_out_opc_div_d(s, a0, a1, a2);
+    case INDEX_op_div:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_div_w(s, a0, a1, a2);
+        } else {
+            tcg_out_opc_div_d(s, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_divu_i32:
-        tcg_out_opc_div_wu(s, a0, a1, a2);
-        break;
-    case INDEX_op_divu_i64:
-        tcg_out_opc_div_du(s, a0, a1, a2);
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_div_wu(s, a0, a1, a2);
+        } else {
+            tcg_out_opc_div_du(s, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_rem_i32:
-        tcg_out_opc_mod_w(s, a0, a1, a2);
-        break;
-    case INDEX_op_rem_i64:
-        tcg_out_opc_mod_d(s, a0, a1, a2);
+    case INDEX_op_rem:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_mod_w(s, a0, a1, a2);
+        } else {
+            tcg_out_opc_mod_d(s, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_remu_i32:
-        tcg_out_opc_mod_wu(s, a0, a1, a2);
-        break;
-    case INDEX_op_remu_i64:
-        tcg_out_opc_mod_du(s, a0, a1, a2);
+    case INDEX_op_remu:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_mod_wu(s, a0, a1, a2);
+        } else {
+            tcg_out_opc_mod_du(s, a0, a1, a2);
+        }
         break;
 
     case INDEX_op_setcond_i32:
@@ -2303,20 +2310,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rZ, rJ);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i32:
-    case INDEX_op_muluh_i64:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
+    case INDEX_op_mul:
+    case INDEX_op_mulsh:
+    case INDEX_op_muluh:
+    case INDEX_op_div:
+    case INDEX_op_divu:
+    case INDEX_op_rem:
+    case INDEX_op_remu:
         return C_O1_I2(r, rZ, rZ);
 
     case INDEX_op_movcond_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ad60304098..ac70a793f7 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1815,119 +1815,104 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         i1 = OPC_NOR;
         goto do_binaryv;
 
-    case INDEX_op_mul_i32:
-        if (use_mips32_instructions) {
-            tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
-            break;
+    case INDEX_op_mul:
+        if (type == TCG_TYPE_I32) {
+            if (use_mips32_instructions) {
+                tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
+                break;
+            }
+            i1 = OPC_MULT;
+        } else {
+            if (use_mips32r6_instructions) {
+                tcg_out_opc_reg(s, OPC_DMUL, a0, a1, a2);
+                break;
+            }
+            i1 = OPC_DMULT;
         }
-        i1 = OPC_MULT, i2 = OPC_MFLO;
+        i2 = OPC_MFLO;
         goto do_hilo1;
-    case INDEX_op_mulsh_i32:
+    case INDEX_op_mulsh:
         if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MUH, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_reg(s, OPC_MUH, a0, a1, a2);
+            } else {
+                tcg_out_opc_reg(s, OPC_DMUH, a0, a1, a2);
+            }
             break;
         }
-        i1 = OPC_MULT, i2 = OPC_MFHI;
+        i1 = type == TCG_TYPE_I32 ? OPC_MULT : OPC_DMULT;
+        i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_muluh_i32:
+    case INDEX_op_muluh:
         if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MUHU, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_reg(s, OPC_MUHU, a0, a1, a2);
+            } else {
+                tcg_out_opc_reg(s, OPC_DMUHU, a0, a1, a2);
+            }
             break;
         }
-        i1 = OPC_MULTU, i2 = OPC_MFHI;
+        i1 = type == TCG_TYPE_I32 ? OPC_MULTU : OPC_DMULTU;
+        i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_div_i32:
+    case INDEX_op_div:
         if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DIV_R6, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_reg(s, OPC_DIV_R6, a0, a1, a2);
+            } else {
+                tcg_out_opc_reg(s, OPC_DDIV_R6, a0, a1, a2);
+            }
             break;
         }
-        i1 = OPC_DIV, i2 = OPC_MFLO;
+        i1 = type == TCG_TYPE_I32 ? OPC_DIV : OPC_DDIV;
+        i2 = OPC_MFLO;
         goto do_hilo1;
-    case INDEX_op_divu_i32:
+    case INDEX_op_divu:
         if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DIVU_R6, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_reg(s, OPC_DIVU_R6, a0, a1, a2);
+            } else {
+                tcg_out_opc_reg(s, OPC_DDIVU_R6, a0, a1, a2);
+            }
             break;
         }
-        i1 = OPC_DIVU, i2 = OPC_MFLO;
+        i1 = type == TCG_TYPE_I32 ? OPC_DIVU : OPC_DDIVU;
+        i2 = OPC_MFLO;
         goto do_hilo1;
-    case INDEX_op_rem_i32:
+    case INDEX_op_rem:
         if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MOD, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_reg(s, OPC_MOD, a0, a1, a2);
+            } else {
+                tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
+            }
             break;
         }
-        i1 = OPC_DIV, i2 = OPC_MFHI;
+        i1 = type == TCG_TYPE_I32 ? OPC_DIV : OPC_DDIV;
+        i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_remu_i32:
+    case INDEX_op_remu:
         if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MODU, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_reg(s, OPC_MODU, a0, a1, a2);
+            } else {
+                tcg_out_opc_reg(s, OPC_DMODU, a0, a1, a2);
+            }
             break;
         }
-        i1 = OPC_DIVU, i2 = OPC_MFHI;
+        i1 = type == TCG_TYPE_I32 ? OPC_DIVU : OPC_DDIVU;
+        i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_mul_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMUL, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DMULT, i2 = OPC_MFLO;
-        goto do_hilo1;
-    case INDEX_op_mulsh_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMUH, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DMULT, i2 = OPC_MFHI;
-        goto do_hilo1;
-    case INDEX_op_muluh_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMUHU, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DMULTU, i2 = OPC_MFHI;
-        goto do_hilo1;
-    case INDEX_op_div_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DDIV_R6, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DDIV, i2 = OPC_MFLO;
-        goto do_hilo1;
-    case INDEX_op_divu_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DDIVU_R6, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DDIVU, i2 = OPC_MFLO;
-        goto do_hilo1;
-    case INDEX_op_rem_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DDIV, i2 = OPC_MFHI;
-        goto do_hilo1;
-    case INDEX_op_remu_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMODU, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DDIVU, i2 = OPC_MFHI;
     do_hilo1:
         tcg_out_opc_reg(s, i1, 0, a1, a2);
         tcg_out_opc_reg(s, i2, a0, 0, 0);
         break;
 
-    case INDEX_op_muls2_i32:
-        i1 = OPC_MULT;
+    case INDEX_op_muls2:
+        i1 = type == TCG_TYPE_I32 ? OPC_MULT : OPC_DMULT;
         goto do_hilo2;
-    case INDEX_op_mulu2_i32:
-        i1 = OPC_MULTU;
-        goto do_hilo2;
-    case INDEX_op_muls2_i64:
-        i1 = OPC_DMULT;
-        goto do_hilo2;
-    case INDEX_op_mulu2_i64:
-        i1 = OPC_DMULTU;
+    case INDEX_op_mulu2:
+        i1 = type == TCG_TYPE_I32 ? OPC_MULTU : OPC_DMULTU;
     do_hilo2:
         tcg_out_opc_reg(s, i1, 0, a2, args[3]);
         tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
@@ -2200,28 +2185,19 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O1_I2(r, r, rJ);
     case INDEX_op_sub:
         return C_O1_I2(r, rZ, rN);
-    case INDEX_op_mul_i32:
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_muluh_i32:
-    case INDEX_op_div_i32:
-    case INDEX_op_divu_i32:
-    case INDEX_op_rem_i32:
-    case INDEX_op_remu_i32:
+    case INDEX_op_mul:
+    case INDEX_op_mulsh:
+    case INDEX_op_muluh:
+    case INDEX_op_div:
+    case INDEX_op_divu:
+    case INDEX_op_rem:
+    case INDEX_op_remu:
     case INDEX_op_nor:
     case INDEX_op_setcond_i32:
-    case INDEX_op_mul_i64:
-    case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i64:
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i64:
-    case INDEX_op_rem_i64:
-    case INDEX_op_remu_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rZ, rZ);
-    case INDEX_op_muls2_i32:
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_muls2_i64:
-    case INDEX_op_mulu2_i64:
+    case INDEX_op_muls2:
+    case INDEX_op_mulu2:
         return C_O2_I2(r, r, r, r);
     case INDEX_op_and:
         return C_O1_I2(r, r, rIK);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b74802dd01..68f84342d8 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3124,29 +3124,47 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_mul_i32:
+    case INDEX_op_mul:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
             tcg_out32(s, MULLI | TAI(a0, a1, a2));
-        } else {
+        } else if (type == TCG_TYPE_I32) {
             tcg_out32(s, MULLW | TAB(a0, a1, a2));
+        } else {
+            tcg_out32(s, MULLD | TAB(a0, a1, a2));
         }
         break;
 
-    case INDEX_op_div_i32:
-        tcg_out32(s, DIVW | TAB(args[0], args[1], args[2]));
+    case INDEX_op_div:
+        if (type == TCG_TYPE_I32) {
+            tcg_out32(s, DIVW | TAB(args[0], args[1], args[2]));
+        } else {
+            tcg_out32(s, DIVD | TAB(args[0], args[1], args[2]));
+        }
         break;
 
-    case INDEX_op_divu_i32:
-        tcg_out32(s, DIVWU | TAB(args[0], args[1], args[2]));
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            tcg_out32(s, DIVWU | TAB(args[0], args[1], args[2]));
+        } else {
+            tcg_out32(s, DIVDU | TAB(args[0], args[1], args[2]));
+        }
         break;
 
-    case INDEX_op_rem_i32:
-        tcg_out32(s, MODSW | TAB(args[0], args[1], args[2]));
+    case INDEX_op_rem:
+        if (type == TCG_TYPE_I32) {
+            tcg_out32(s, MODSW | TAB(args[0], args[1], args[2]));
+        } else {
+            tcg_out32(s, MODSD | TAB(args[0], args[1], args[2]));
+        }
         break;
 
-    case INDEX_op_remu_i32:
-        tcg_out32(s, MODUW | TAB(args[0], args[1], args[2]));
+    case INDEX_op_remu:
+        if (type == TCG_TYPE_I32) {
+            tcg_out32(s, MODUW | TAB(args[0], args[1], args[2]));
+        } else {
+            tcg_out32(s, MODUD | TAB(args[0], args[1], args[2]));
+        }
         break;
 
     case INDEX_op_shl_i32:
@@ -3252,27 +3270,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_sari64(s, args[0], args[1], 32);
         break;
 
-    case INDEX_op_mul_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out32(s, MULLI | TAI(a0, a1, a2));
-        } else {
-            tcg_out32(s, MULLD | TAB(a0, a1, a2));
-        }
-        break;
-    case INDEX_op_div_i64:
-        tcg_out32(s, DIVD | TAB(args[0], args[1], args[2]));
-        break;
-    case INDEX_op_divu_i64:
-        tcg_out32(s, DIVDU | TAB(args[0], args[1], args[2]));
-        break;
-    case INDEX_op_rem_i64:
-        tcg_out32(s, MODSD | TAB(args[0], args[1], args[2]));
-        break;
-    case INDEX_op_remu_i64:
-        tcg_out32(s, MODUD | TAB(args[0], args[1], args[2]));
-        break;
-
     case INDEX_op_qemu_ld_a64_i32:
         if (TCG_TARGET_REG_BITS == 32) {
             tcg_out_qemu_ld(s, args[0], -1, args[1], args[2],
@@ -3484,17 +3481,19 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_muluh_i32:
-        tcg_out32(s, MULHWU | TAB(args[0], args[1], args[2]));
+    case INDEX_op_muluh:
+        if (type == TCG_TYPE_I32) {
+            tcg_out32(s, MULHWU | TAB(args[0], args[1], args[2]));
+        } else {
+            tcg_out32(s, MULHDU | TAB(args[0], args[1], args[2]));
+        }
         break;
-    case INDEX_op_mulsh_i32:
-        tcg_out32(s, MULHW | TAB(args[0], args[1], args[2]));
-        break;
-    case INDEX_op_muluh_i64:
-        tcg_out32(s, MULHDU | TAB(args[0], args[1], args[2]));
-        break;
-    case INDEX_op_mulsh_i64:
-        tcg_out32(s, MULHD | TAB(args[0], args[1], args[2]));
+    case INDEX_op_mulsh:
+        if (type == TCG_TYPE_I32) {
+            tcg_out32(s, MULHW | TAB(args[0], args[1], args[2]));
+        } else {
+            tcg_out32(s, MULHD | TAB(args[0], args[1], args[2]));
+        }
         break;
 
     case INDEX_op_mb:
@@ -4178,24 +4177,17 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
+    case INDEX_op_mul:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_div_i32:
-    case INDEX_op_divu_i32:
-    case INDEX_op_rem_i32:
-    case INDEX_op_remu_i32:
+    case INDEX_op_div:
+    case INDEX_op_divu:
+    case INDEX_op_rem:
+    case INDEX_op_remu:
     case INDEX_op_nand:
     case INDEX_op_nor:
-    case INDEX_op_muluh_i32:
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i64:
-    case INDEX_op_rem_i64:
-    case INDEX_op_remu_i64:
-    case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
+    case INDEX_op_mulsh:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_clz_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f87cb3e880..4cbe1a1736 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2107,39 +2107,44 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, insn, a0, TCG_REG_ZERO, a1);
         break;
 
-    case INDEX_op_mul_i32:
-        tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
-        break;
-    case INDEX_op_mul_i64:
-        tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
+    case INDEX_op_mul:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_div_i32:
-        tcg_out_opc_reg(s, OPC_DIVW, a0, a1, a2);
-        break;
-    case INDEX_op_div_i64:
-        tcg_out_opc_reg(s, OPC_DIV, a0, a1, a2);
+    case INDEX_op_div:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_DIVW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_DIV, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_divu_i32:
-        tcg_out_opc_reg(s, OPC_DIVUW, a0, a1, a2);
-        break;
-    case INDEX_op_divu_i64:
-        tcg_out_opc_reg(s, OPC_DIVU, a0, a1, a2);
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_DIVUW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_DIVU, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_rem_i32:
-        tcg_out_opc_reg(s, OPC_REMW, a0, a1, a2);
-        break;
-    case INDEX_op_rem_i64:
-        tcg_out_opc_reg(s, OPC_REM, a0, a1, a2);
+    case INDEX_op_rem:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_REMW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_REM, a0, a1, a2);
+        }
         break;
 
-    case INDEX_op_remu_i32:
-        tcg_out_opc_reg(s, OPC_REMUW, a0, a1, a2);
-        break;
-    case INDEX_op_remu_i64:
-        tcg_out_opc_reg(s, OPC_REMU, a0, a1, a2);
+    case INDEX_op_remu:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_REMUW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_REMU, a0, a1, a2);
+        }
         break;
 
     case INDEX_op_shl_i32:
@@ -2314,13 +2319,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
         break;
 
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_mulsh_i64:
+    case INDEX_op_mulsh:
         tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
         break;
 
-    case INDEX_op_muluh_i32:
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
         tcg_out_opc_reg(s, OPC_MULHU, a0, a1, a2);
         break;
 
@@ -2644,20 +2647,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sub:
         return C_O1_I2(r, rZ, rN);
 
-    case INDEX_op_mul_i32:
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_muluh_i32:
-    case INDEX_op_div_i32:
-    case INDEX_op_divu_i32:
-    case INDEX_op_rem_i32:
-    case INDEX_op_remu_i32:
-    case INDEX_op_mul_i64:
-    case INDEX_op_mulsh_i64:
-    case INDEX_op_muluh_i64:
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i64:
-    case INDEX_op_rem_i64:
-    case INDEX_op_remu_i64:
+    case INDEX_op_mul:
+    case INDEX_op_mulsh:
+    case INDEX_op_muluh:
+    case INDEX_op_div:
+    case INDEX_op_divu:
+    case INDEX_op_rem:
+    case INDEX_op_remu:
         return C_O1_I2(r, rZ, rZ);
 
     case INDEX_op_shl_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index dce96b5ba6..519d7c082c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2387,35 +2387,58 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mul_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            if (a2 == (int16_t)a2) {
-                tcg_out_insn(s, RI, MHI, a0, a2);
+    case INDEX_op_mul:
+        a0 = args[0], a1 = args[1], a2 = args[2];
+        if (type == TCG_TYPE_I32) {
+            if (const_args[2]) {
+                tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
+                if (a2 == (int16_t)a2) {
+                    tcg_out_insn(s, RI, MHI, a0, a2);
+                } else {
+                    tcg_out_insn(s, RIL, MSFI, a0, a2);
+                }
+            } else if (a0 == a1) {
+                tcg_out_insn(s, RRE, MSR, a0, a2);
             } else {
-                tcg_out_insn(s, RIL, MSFI, a0, a2);
+                tcg_out_insn(s, RRFa, MSRKC, a0, a1, a2);
             }
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RRE, MSR, a0, a2);
         } else {
-            tcg_out_insn(s, RRFa, MSRKC, a0, a1, a2);
+            if (const_args[2]) {
+                tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
+                if (a2 == (int16_t)a2) {
+                    tcg_out_insn(s, RI, MGHI, a0, a2);
+                } else {
+                    tcg_out_insn(s, RIL, MSGFI, a0, a2);
+                }
+            } else if (a0 == a1) {
+                tcg_out_insn(s, RRE, MSGR, a0, a2);
+            } else {
+                tcg_out_insn(s, RRFa, MSGRKC, a0, a1, a2);
+            }
         }
         break;
 
-    case INDEX_op_div2_i32:
+    case INDEX_op_div2:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert(args[1] == args[3]);
         tcg_debug_assert((args[1] & 1) == 0);
         tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RR, DR, args[1], args[4]);
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RR, DR, args[1], args[4]);
+        } else {
+            tcg_out_insn(s, RRE, DSGR, args[1], args[4]);
+        }
         break;
-    case INDEX_op_divu2_i32:
+    case INDEX_op_divu2:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert(args[1] == args[3]);
         tcg_debug_assert((args[1] & 1) == 0);
         tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRE, DLR, args[1], args[4]);
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RRE, DLR, args[1], args[4]);
+        } else {
+            tcg_out_insn(s, RRE, DLGR, args[1], args[4]);
+        }
         break;
 
     case INDEX_op_shl_i32:
@@ -2590,49 +2613,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
-    case INDEX_op_div2_i64:
-        /*
-         * ??? We get an unnecessary sign-extension of the dividend
-         * into op0 with this definition, but as we do in fact always
-         * produce both quotient and remainder using INDEX_op_div_i64
-         * instead requires jumping through even more hoops.
-         */
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRE, DSGR, args[1], args[4]);
-        break;
-    case INDEX_op_divu2_i64:
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRE, DLGR, args[1], args[4]);
-        break;
-    case INDEX_op_mulu2_i64:
+    case INDEX_op_mulu2:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert((args[1] & 1) == 0);
         tcg_debug_assert(args[0] == args[1] + 1);
         tcg_out_insn(s, RRE, MLGR, args[1], args[3]);
         break;
-    case INDEX_op_muls2_i64:
+    case INDEX_op_muls2:
         tcg_debug_assert((args[1] & 1) == 0);
         tcg_debug_assert(args[0] == args[1] + 1);
         tcg_out_insn(s, RRFa, MGRK, args[1], args[2], args[3]);
@@ -3242,14 +3229,14 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_nor:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_mul_i32:
-        return (HAVE_FACILITY(MISC_INSN_EXT2)
-                ? C_O1_I2(r, r, ri)
-                : C_O1_I2(r, 0, ri));
-    case INDEX_op_mul_i64:
-        return (HAVE_FACILITY(MISC_INSN_EXT2)
-                ? C_O1_I2(r, r, rJ)
-                : C_O1_I2(r, 0, rJ));
+    case INDEX_op_mul:
+        return (op->type == TCG_TYPE_I32
+                ? (HAVE_FACILITY(MISC_INSN_EXT2)
+                   ? C_O1_I2(r, r, ri)
+                   : C_O1_I2(r, 0, ri))
+                : (HAVE_FACILITY(MISC_INSN_EXT2)
+                   ? C_O1_I2(r, r, rJ)
+                   : C_O1_I2(r, 0, rJ)));
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -3306,15 +3293,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rI, r);
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
-    case INDEX_op_divu2_i32:
-    case INDEX_op_divu2_i64:
+    case INDEX_op_div2:
+    case INDEX_op_divu2:
         return C_O2_I3(o, m, 0, 1, r);
 
-    case INDEX_op_mulu2_i64:
+    case INDEX_op_mulu2:
         return C_O2_I2(o, m, 0, r);
-    case INDEX_op_muls2_i64:
+    case INDEX_op_muls2:
         return C_O2_I2(o, m, r, r);
 
     case INDEX_op_add2:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index fffd203c03..0ee5fc3235 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1395,8 +1395,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i32:
         c = SHIFT_SRA;
         goto do_shift32;
-    case INDEX_op_mul_i32:
-        c = ARITH_UMUL;
+    case INDEX_op_mul:
+        c = type == TCG_TYPE_I32 ? ARITH_UMUL : ARITH_MULX;
         goto gen_arith;
 
     case INDEX_op_neg:
@@ -1406,12 +1406,20 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 	c = ARITH_ORN;
 	goto gen_arith1;
 
-    case INDEX_op_div_i32:
-        tcg_out_div32(s, a0, a1, a2, c2, 0);
-        break;
-    case INDEX_op_divu_i32:
-        tcg_out_div32(s, a0, a1, a2, c2, 1);
-        break;
+    case INDEX_op_div:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_div32(s, a0, a1, a2, c2, 0);
+            break;
+        }
+        c = ARITH_SDIVX;
+        goto gen_arith;
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_div32(s, a0, a1, a2, c2, 1);
+            break;
+        }
+        c = ARITH_UDIVX;
+        goto gen_arith;
 
     case INDEX_op_brcond_i32:
         tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
@@ -1446,13 +1454,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                                 const_args[4], args[5], const_args[5], true);
         }
         break;
-    case INDEX_op_mulu2_i32:
+    case INDEX_op_mulu2:
         c = ARITH_UMUL;
         goto do_mul2;
-    case INDEX_op_muls2_i32:
+    case INDEX_op_muls2:
         c = ARITH_SMUL;
     do_mul2:
-        /* The 32-bit multiply insns produce a full 64-bit result. */
+        /*
+         * The 32-bit multiply insns produce a full 64-bit result.
+         * Providing these avoids the need for truncating the inputs
+         * to use a 64-bit multiply.
+         */
+        tcg_debug_assert(type == TCG_TYPE_I32);
         tcg_out_arithc(s, a0, a2, args[3], const_args[3], c);
         tcg_out_arithi(s, a1, a0, 32, SHIFT_SRLX);
         break;
@@ -1486,15 +1499,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i64:
         c = SHIFT_SRAX;
         goto do_shift64;
-    case INDEX_op_mul_i64:
-        c = ARITH_MULX;
-        goto gen_arith;
-    case INDEX_op_div_i64:
-        c = ARITH_SDIVX;
-        goto gen_arith;
-    case INDEX_op_divu_i64:
-        c = ARITH_UDIVX;
-        goto gen_arith;
 
     case INDEX_op_brcond_i64:
         tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
@@ -1508,7 +1512,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_movcond_i64:
         tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
         break;
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
         tcg_out_arith(s, args[0], args[1], args[2], ARITH_UMULXHI);
         break;
 
@@ -1579,12 +1583,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I2(rZ, r);
 
     case INDEX_op_add:
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
+    case INDEX_op_mul:
+    case INDEX_op_div:
+    case INDEX_op_divu:
     case INDEX_op_sub:
     case INDEX_op_and:
     case INDEX_op_andc:
@@ -1612,10 +1613,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_add2:
     case INDEX_op_sub2:
         return C_O2_I4(r, r, rZ, rZ, rJ, rJ);
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_muls2_i32:
+    case INDEX_op_mulu2:
+    case INDEX_op_muls2:
         return C_O2_I2(r, r, rZ, rJ);
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
         return C_O1_I2(r, r, r);
 
     default:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 04f35cecfa..ea12768a8f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -67,18 +67,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
+    case INDEX_op_div:
+    case INDEX_op_divu:
+    case INDEX_op_rem:
+    case INDEX_op_remu:
     case INDEX_op_add:
     case INDEX_op_sub:
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
+    case INDEX_op_mul:
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
@@ -120,10 +115,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I4(r, r, r, r);
 #endif
 
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_mulu2_i64:
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
+    case INDEX_op_mulu2:
+    case INDEX_op_muls2:
         return C_O2_I2(r, r, r, r);
 
     case INDEX_op_movcond_i32:
@@ -711,7 +704,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_add:
     case INDEX_op_sub:
-    CASE_32_64(mul)
+    case INDEX_op_mul:
     case INDEX_op_and:
     case INDEX_op_or:
     case INDEX_op_xor:
@@ -725,10 +718,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
-    CASE_32_64(div)      /* Optional (TCG_TARGET_HAS_div_*). */
-    CASE_32_64(divu)     /* Optional (TCG_TARGET_HAS_div_*). */
-    CASE_32_64(rem)      /* Optional (TCG_TARGET_HAS_div_*). */
-    CASE_32_64(remu)     /* Optional (TCG_TARGET_HAS_div_*). */
+    case INDEX_op_div:
+    case INDEX_op_divu:
+    case INDEX_op_rem:
+    case INDEX_op_remu:
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
     CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
         tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
@@ -791,8 +784,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 #endif
 
-    CASE_32_64(mulu2)
-    CASE_32_64(muls2)
+    case INDEX_op_mulu2:
+    case INDEX_op_muls2:
         tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
-- 
2.43.0


