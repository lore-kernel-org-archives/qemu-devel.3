Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE4AC369C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lzd-00017j-Ow; Tue, 15 Apr 2025 15:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lz4-0007pD-Tc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:19 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lxw-0000jd-UF
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:14 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af50f56b862so4101177a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745336; x=1745350136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNZUeAYp03DjQgLcujdiXqgWJoyAlLQTZskoZNoeD+o=;
 b=dHYGuo+JqbTHO6mT8C1Yjt7nXTiXdKYnhIgVNzUxwAmnriPfmOEhuH1dm5ky5adSLH
 EGh0rp8VZ4kZ5zcDx+1EGU958Jrk1Ov46rAAy6Y5G4i5CuDDdVwoA/0q3RgUcocjRCKl
 8BdZ9W2yxmBWI1U6ZmnabicDTMgptW9EKxD+k/n+fkYXWR33H++qiFpqwaq6x3E06DCR
 AaKc5hEQPejQEE3QslgyDZ2BFu7jtRlwEbJZIofMtp+sh4CH2aE/8pC+eF4yCNN820QO
 zgGUY+W78ViczeyVH1ElKu22Lt7TWdu6e4Ws15I1ybSdU4uGgYVZJORkDuW1DUw7g95l
 1yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745336; x=1745350136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNZUeAYp03DjQgLcujdiXqgWJoyAlLQTZskoZNoeD+o=;
 b=llzQvcVW42rVXL2mh6MkWx8fDBoD/waUIHuavItNO2iJp3pYDuTeQZDClO6GyzUdS+
 WK7mQE9faC0vnIhRaHu5FfEMiy9X/nHTouaHdNUMcMyyB9FerbF6ASQ6wlbSknbXm9ZB
 kHkr8VSyHxzzsjqo+W2hHTWR4W74xC2cH1PYfB9wcGa/jzAjF6fG7nRrVqGdygBGKpqo
 oZMuWCoelFYUyP1zPol3ZoEPt6AHE/gduLuf7uRVZSFPPP20cd+XBWb7KiWeHMB9+fFe
 +Rch22pifAoYfomQc0vG/2UTj1lKNfAvRgWVoHzdUNcgWQXQAPX/4irGyXC1XLRJeALD
 1+KQ==
X-Gm-Message-State: AOJu0YznVdO09TAkkS/ejZRpwi239l0uh8eqob0l4fjt0V8G9zN2Bgbh
 j5AJF1hqeIBA/Rcfbg8lpZL7FJtjMzPrlI1AV6hSbpc7YSNv5nbdxrwvaaWczMS3qOPDE9wwgWw
 k
X-Gm-Gg: ASbGncvUGWYkcW5LV/GyMDC3+olr0dRlpxTJMm8GP0AvC71+kcYp8TXXoDubXIGRfow
 RAEJ4fsvyJ8qcGX/2nYEv7e0LJEMNNa/kJoaef6wpjch0Hyuu4FUSKhJGuaVPaNRhCi4DPtgkoy
 Mnbnb0gWwMKLRLduGZxgyM0fdS/LBo05ufctqV9rCnfK81DyeVcvUpEwxz4Lcr5Otl7QgXVV2AQ
 qB5o9YCGRjtRc3y3hwELMzoIeM5u5OA/97dEM/5roecWIvavZlNJCDMeqUVVv+tJ1gZ6hd6ElN4
 Dq6OnHXCMeQZqFnjmTwLWih69Ps33PAakjCh3gBb1eElSvdDxB4KttlQPBHFdUN9gdlVD5N2fCU
 =
X-Google-Smtp-Source: AGHT+IELbPvTmwQKgYa20WSNjPhagjYmH4kHQwumBc1MAoloOjzjdb0jvK2UWqOVOtKS0goLtNb6bA==
X-Received: by 2002:a17:90b:5212:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-3085ef96a39mr556730a91.29.1744745335575; 
 Tue, 15 Apr 2025 12:28:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:28:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 044/163] tcg: Merge INDEX_op_divu_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:15 -0700
Message-ID: <20250415192515.232910-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 tcg/optimize.c           |  9 +++++----
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 6d4edd0b16..243f002a61 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
+DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -69,7 +70,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(divu_i32, 1, 2, 0, 0)
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(divu_i64, 1, 2, 0, 0)
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 127d0f9390..77386eacb7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -551,9 +551,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (int64_t)x / ((int64_t)y ? : 1);
 
-    case INDEX_op_divu_i32:
-        return (uint32_t)x / ((uint32_t)y ? : 1);
-    case INDEX_op_divu_i64:
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x / ((uint32_t)y ? : 1);
+        }
         return (uint64_t)x / ((uint64_t)y ? : 1);
 
     case INDEX_op_rem_i32:
@@ -2896,7 +2897,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_deposit(&ctx, op);
             break;
         case INDEX_op_divs:
-        CASE_OP_32_64(divu):
+        case INDEX_op_divu:
             done = fold_divide(&ctx, op);
             break;
         case INDEX_op_dup_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 19be461214..f326c452a4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -635,8 +635,8 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
@@ -651,9 +651,9 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem_i32) {
         tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu_i32, t0, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
@@ -2003,8 +2003,8 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
@@ -2019,9 +2019,9 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rem_i64) {
         tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu_i64, t0, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c6eb3c1c2e..f77483188b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1021,8 +1021,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
-    OUTOP(INDEX_op_divu_i32, TCGOutOpBinary, outop_divu),
-    OUTOP(INDEX_op_divu_i64, TCGOutOpBinary, outop_divu),
+    OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5412,8 +5411,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_divs:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
+    case INDEX_op_divu:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_mulsh:
diff --git a/tcg/tci.c b/tcg/tci.c
index 0691824f97..bf97849bfe 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -724,7 +724,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
             break;
-        case INDEX_op_divu_i64:
+        case INDEX_op_divu:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
             break;
@@ -1072,6 +1072,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_divs:
+    case INDEX_op_divu:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_nand:
@@ -1082,8 +1083,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_xor:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index a833b3b7b2..41985be012 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -282,7 +282,7 @@ Arithmetic
      - | *t0* = *t1* / *t2* (signed)
        | Undefined behavior if division by zero or overflow.
 
-   * - divu_i32/i64 *t0*, *t1*, *t2*
+   * - divu *t0*, *t1*, *t2*
 
      - | *t0* = *t1* / *t2* (unsigned)
        | Undefined behavior if division by zero.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 18a10156a6..dfa8aecc7a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -663,7 +663,7 @@ static void tgen_divu(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_divu32
-                     : INDEX_op_divu_i64);
+                     : INDEX_op_divu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


