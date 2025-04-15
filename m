Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31B8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lv0-00009q-L5; Tue, 15 Apr 2025 15:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lun-000083-V4
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lue-00081e-PR
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso4700576b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745138; x=1745349938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lptjpN6O7YxuxlSMLYD8MyLJwzKBh7xN13ZXK3qervc=;
 b=ZofkO8XyuIJEjmp5PX0XZJQpGkYsXkHun9ps7Jo1Q7M9/Fo9Cgf3gTzpkhJ73Tpo06
 5rJdl4MKMVBbVkKURmUNAwZVAptXZTkwfKQh8RjhFoo1PQj80IWnuQaspRBep34ckUq1
 Gblg7OnNrFxQBJV4F7HVgvnYqwYuXyhRJI717nDDqPqC9cyFkIqjrnaIJcK0mTqQGTTc
 wSc8c4woXl/4rr/r/Pf8aTQknPeC/YQAKOQ+Iu353o2NbznEufy3EcGLFWiSGAVJqIQN
 T6iQL9gekvNOceef1WSouwrM6hocYI97MUcAiM5thob3a/tpRGXL3mftEzm2KPLVx98I
 lLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745138; x=1745349938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lptjpN6O7YxuxlSMLYD8MyLJwzKBh7xN13ZXK3qervc=;
 b=qtPhjG/0FqH+godt/uqzCwqTyb7vWPTBf36kxFwoqyg60fzdzESe3bmIoXsnxSPm8G
 xmZNicNxoBXrIXcWW9j8woaZW/DDnyYHDn1DunjU4nFowxD/IjXH3cHzKciv8QVyEppX
 OehewIbOU1Ki8qfF1flHJcWKgFNmyk/S9AWSdT1F1dfgrzbh6Fgc0CGL0y7gwymhVjJA
 W3IOE1fhXgkrUgjF2e3g5WP6RZ1AE29bkTaJKgkcUuVw1Cg9Iok6ZWN9lIAc3lAXKN+4
 v2cyqFHIiB2ADF+Y2C5DYla63UDPVi7Wlo5/r2Eiaxyx4PiXP8ms5gq0h1o2p+fJJoQy
 tUNw==
X-Gm-Message-State: AOJu0YzcCi0kqj4blQAaP9RPZ6k+hQG22mEUEKKbmBRLC1477/4jLkP3
 9AHHyIdUh41ou1MWKfrsapxbHUtfuYrnhNMVNxPUWTjkIMG8LLf963SE59UzKipyurXrGgBH3wF
 i
X-Gm-Gg: ASbGnctkxWXUbWFczgM5pgVEySrE9cGZAg3HlzIJOHdss2BIohORJ7KnHQkAMU5XlDE
 wL93bWkcB8QyRyzPtVz5U7vDZDN7cTLOM8zL4RG8ygbhnu75yZCgUN8oGNCr2V3MuPEItxSVB8C
 3ERm6HODv99eLeoEB0rFE+HaNiaC5Ok9lv8VjkadwPVYw+WlIcQ2v0G6+6TbFJ2WYrMTrVXL0FL
 fZyzJzLuABbvpoMfo56Yz6IMksEJAhd4UFKl1CEtIt92r2H2lbJV91XkmaE//G7rUTo+jgyOgZO
 xUkuva12njKuCIM8vB4pJuOEmmyJ+RYNL5SDsX8fA+7l30BEdmFFRVWdcCTWvftc2oktwWaHR9Q
 =
X-Google-Smtp-Source: AGHT+IFQOzIbrO5VYJhlT700XzLl+ChSV744h2EQtQ0wLIkS5P+X5JYhs09XZ68nOgkTgjkhcKL9dA==
X-Received: by 2002:a05:6a00:1897:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-73c1fb40a5fmr1055948b3a.12.1744745138181; 
 Tue, 15 Apr 2025 12:25:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 024/163] tcg: Merge INDEX_op_nand_{i32,i64}
Date: Tue, 15 Apr 2025 12:22:55 -0700
Message-ID: <20250415192515.232910-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 5 ++---
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c6869de244..1acdd7cfda 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
@@ -94,7 +95,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(nand_i32, 1, 2, 0, 0)
 DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
@@ -147,7 +147,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(nand_i64, 1, 2, 0, 0)
 DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4efd6a1b2c..b4dc34b9b1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -481,7 +481,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_eqv_vec:
         return ~(x ^ y);
 
-    CASE_OP_32_64_VEC(nand):
+    case INDEX_op_nand:
+    case INDEX_op_nand_vec:
         return ~(x & y);
 
     CASE_OP_32_64_VEC(nor):
@@ -2980,7 +2981,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(mulu2):
             done = fold_multiply2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(nand):
+        case INDEX_op_nand:
+        case INDEX_op_nand_vec:
             done = fold_nand(&ctx, op);
             break;
         CASE_OP_32_64(neg):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3921bac48d..57782864fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -690,8 +690,8 @@ void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_nand_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -2292,8 +2292,8 @@ void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nand_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nand_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_nand_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ee9da754de..9eac963269 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1008,8 +1008,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_nand_i32, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_nand_i64, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5431,8 +5430,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
+    case INDEX_op_nand:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 8be59a0193..9886ddf001 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -559,7 +559,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-        CASE_32_64(nand)
+        case INDEX_op_nand:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
@@ -1078,6 +1078,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
+    case INDEX_op_nand:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1085,8 +1086,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
     case INDEX_op_div_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fe149e012d..7703dfbc51 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -327,7 +327,7 @@ Logical
 
      - | *t0* = ~(*t1* ^ *t2*), or equivalently, *t0* = *t1* ^ ~\ *t2*
 
-   * - nand_i32/i64 *t0*, *t1*, *t2*
+   * - nand *t0*, *t1*, *t2*
 
      - | *t0* = ~(*t1* & *t2*)
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2a5c72705d..34a44a7674 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -672,7 +672,7 @@ static const TCGOutOpBinary outop_eqv = {
 static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_nand_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_nand, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nand = {
-- 
2.43.0


