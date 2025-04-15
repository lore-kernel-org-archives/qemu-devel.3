Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D587AC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lwQ-0001nL-04; Tue, 15 Apr 2025 15:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lv2-0000Bp-Jz
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:26:09 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lur-00085i-Pl
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:26:01 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso55607975ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745150; x=1745349950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBKXHqai4IetfMGKIq+L4gww31+chqVJ2qJeC7b/WdE=;
 b=NCqubyDEBpTe8YLuWq9UzTYKuNnqlfMpz5NP5FCwUoIKdm3MEDLRqe8yfFitb3IDO5
 aflX6TrtmsXfry3dgbXZPCF2VWv+RyOH6zEVAP7V2fxDuXStgHk93FIaaTc2w0HsHsuj
 HWlCwGbeALSmiqNPgmPboyVlwmC39ltrbeLh0Qq1Q4nbD2RYWWY0nnaZNVvMTY8sIszz
 /YbC1NHxr95E+aB33WX5PaY9bkcBiJ34HUr0boVeyp74GqSZDpd9n/tuDE30eEIDEqi7
 rnV+Y8tZXAKb4PktuYCLbjXU2zwiosXI5Um0hdM57o1pp8N9+rJ/uTm4/q+OvrXPfC1l
 yCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745150; x=1745349950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBKXHqai4IetfMGKIq+L4gww31+chqVJ2qJeC7b/WdE=;
 b=fSMO3A1UgkeWv286qgegf8nHGoTgq101GI/FuXY5tIZAt7jgIoQGBdfD0O33jFN4ps
 VadMsQfv5dW2qNUbiDAYZsHByBunfNyKGhS5scQOg7dUveRaqJfKvYn61wmoPsLj1Ni3
 3WJfMh7fZRj43lEWnT/DVI6iWZMUgKs5aWwIIn7zMiLvOpUSmwe/S3GpZr49bCW+yKNg
 tEQZPFYA3++z29m9YMUhi5Pmp/JDQY/NFEhqgwQde2YFW1K/3mtvqYeUL1IbEgG+HI7F
 be9Q/WufBFDatBEnDekCEMFbqMU2FDS+rfU0lJ7kdRP3tcvbN6VEqCUcgbP9pFmwd9Qc
 TwjA==
X-Gm-Message-State: AOJu0Yz7rFXAjXna9KjWeYmTh6ed3BtZhxe7N08RqOmj81sMeZl9O7+f
 UXhmF4lViAc9PeF4LLoiEc9jyRlU5/Vhi0KMERq9evAThjKS26umgbNTLgqYYuuzsKBVyDLJppe
 j
X-Gm-Gg: ASbGncs2XO/FBUHijj0QkaqVHkjVet5udEhGY7mgdIotw03s2X1xtSyE5MIMtfv81D4
 oCVmve1WwlKBOp3VCcBKUek1OUhK4l27JOo3nOVsIbEzrBzSoafvuTBG1GJzzhCHByAzsRr5WIB
 9XrPhCt89cWVC2cjmjnGTkKyRAFyKDKb/LwSGhklNM5S1bHcgchHILKZOcYERO3X+hojqfO6p26
 bk0sBri8hfxlOf52O/b65VKlYcXQQf26uGeS++tzuoofbYPXCRB0EREHVZI+eGdYE2pXnELGgHo
 IkVYmpZAcn/qCX33MqqVpeWMnkOP3Pl5qDIwxOyLnkmB2BgBUN6A0NJLkG8eMGpGzyyJr+XvWR2
 8KhpJdvqcOg==
X-Google-Smtp-Source: AGHT+IFIztd+TIngCd7zZrgpuB20qqv5+mtC6xE8IzluCvFFHhsTlNFC6hr/zZKSi4xeMaERxY7isg==
X-Received: by 2002:a17:902:d54f:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-22c249cfe9bmr72549905ad.12.1744745150365; 
 Tue, 15 Apr 2025 12:25:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 038/163] tcg: Merge INDEX_op_muluh_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:09 -0700
Message-ID: <20250415192515.232910-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 include/tcg/tcg-opc.h  |  3 +--
 tcg/optimize.c         | 19 +++++++++++--------
 tcg/tcg-op.c           | 10 +++++-----
 tcg/tcg.c              | 13 ++++---------
 docs/devel/tcg-ops.rst |  2 +-
 5 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4ecba62fda..28a5128537 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
+DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
@@ -89,7 +90,6 @@ DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
 DEF(mulu2_i32, 2, 2, 0, 0)
 DEF(muls2_i32, 2, 2, 0, 0)
-DEF(muluh_i32, 1, 2, 0, 0)
 DEF(mulsh_i32, 1, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
@@ -151,7 +151,6 @@ DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
 DEF(mulu2_i64, 2, 2, 0, 0)
 DEF(muls2_i64, 2, 2, 0, 0)
-DEF(muluh_i64, 1, 2, 0, 0)
 DEF(mulsh_i64, 1, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 547a338486..cd37a540ca 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -407,7 +407,8 @@ static bool tcg_opt_gen_movi(OptContext *ctx, TCGOp *op,
     return tcg_opt_gen_mov(ctx, op, dst, arg_new_constant(ctx, val));
 }
 
-static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
+static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
+                                      uint64_t x, uint64_t y)
 {
     uint64_t l64, h64;
 
@@ -529,14 +530,16 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_extrh_i64_i32:
         return (uint64_t)x >> 32;
 
-    case INDEX_op_muluh_i32:
-        return ((uint64_t)(uint32_t)x * (uint32_t)y) >> 32;
+    case INDEX_op_muluh:
+        if (type == TCG_TYPE_I32) {
+            return ((uint64_t)(uint32_t)x * (uint32_t)y) >> 32;
+        }
+        mulu64(&l64, &h64, x, y);
+        return h64;
+
     case INDEX_op_mulsh_i32:
         return ((int64_t)(int32_t)x * (int32_t)y) >> 32;
 
-    case INDEX_op_muluh_i64:
-        mulu64(&l64, &h64, x, y);
-        return h64;
     case INDEX_op_mulsh_i64:
         muls64(&l64, &h64, x, y);
         return h64;
@@ -568,7 +571,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
 static uint64_t do_constant_folding(TCGOpcode op, TCGType type,
                                     uint64_t x, uint64_t y)
 {
-    uint64_t res = do_constant_folding_2(op, x, y);
+    uint64_t res = do_constant_folding_2(op, type, x, y);
     if (type == TCG_TYPE_I32) {
         res = (int32_t)res;
     }
@@ -2955,7 +2958,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_mul(&ctx, op);
             break;
         CASE_OP_32_64(mulsh):
-        CASE_OP_32_64(muluh):
+        case INDEX_op_muluh:
             done = fold_mul_highpart(&ctx, op);
             break;
         CASE_OP_32_64(muls2):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 39581465f2..7a37b21c56 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1132,10 +1132,10 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_mulu2_i32) {
         tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh_i32, rh, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
     } else if (TCG_TARGET_REG_BITS == 64) {
@@ -2842,10 +2842,10 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_mulu2_i64) {
         tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
     } else {
@@ -2868,7 +2868,7 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
     } else if (TCG_TARGET_HAS_mulu2_i64 ||
-               tcg_op_supported(INDEX_op_muluh_i64, TCG_TYPE_I64, 0)) {
+               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ea0d06e6ef..a1ddae0af1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1022,8 +1022,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
-    OUTOP(INDEX_op_muluh_i32, TCGOutOpBinary, outop_muluh),
-    OUTOP(INDEX_op_muluh_i64, TCGOutOpBinary, outop_muluh),
+    OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
@@ -4030,17 +4029,14 @@ liveness_pass_1(TCGContext *s)
             }
             goto do_not_remove;
 
-        case INDEX_op_mulu2_i32:
-            opc_new = INDEX_op_mul;
-            opc_new2 = INDEX_op_muluh_i32;
-            goto do_mul2;
         case INDEX_op_muls2_i32:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh_i32;
             goto do_mul2;
+        case INDEX_op_mulu2_i32:
         case INDEX_op_mulu2_i64:
             opc_new = INDEX_op_mul;
-            opc_new2 = INDEX_op_muluh_i64;
+            opc_new2 = INDEX_op_muluh;
             goto do_mul2;
         case INDEX_op_muls2_i64:
             opc_new = INDEX_op_mul;
@@ -5427,8 +5423,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_mul:
-    case INDEX_op_muluh_i32:
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
     case INDEX_op_nand:
     case INDEX_op_nor:
     case INDEX_op_or:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6c36e72242..4fed5a77c6 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -591,7 +591,7 @@ Multiword arithmetic support
 
    * - mulsh_i32/i64 *t0*, *t1*, *t2*
 
-       muluh_i32/i64 *t0*, *t1*, *t2*
+       muluh *t0*, *t1*, *t2*
 
      - | Provide the high part of a signed or unsigned multiply, respectively.
        |
-- 
2.43.0


