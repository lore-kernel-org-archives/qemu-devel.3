Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A63EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R18-0007bw-98; Fri, 25 Apr 2025 17:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R15-0007a6-2M
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R12-0000ah-PM
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so2335512b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618123; x=1746222923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L71wbVzPITjVbxLTuqE+a4PqABXthkJ7VNT8yULwBtw=;
 b=BT3dGqA/y4lSNUS+MCljrU7GvND93TfHl4CbRfUzI5TE45s0uGPj7n8NZwUz0fXYA9
 TwgVEgKTdcRBBhpVoqtBRyPL+yWpjO6I+bmaPP8j+njcUpYPFhVILVenSD3mU6s3aL+8
 XG2lgb1jGwehcPECJrlfupVw5I4iSbgyLZni3N62DfMG8zP3Vsf7SJGfOW8Z2E6B8kOu
 TcSQqU9YQBPcfH7Tx31irXMpEl9z1VbXJ/XH4BeJyS9TNpfPSKVdOuaG1chlxLQVGk0a
 xo+7x98ufsnMBhkb5qHcmGVX+v3CPsPF+ZQR3+6hkOpyX2jfe8UG1k+3c7AmlC1LWWaG
 Tfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618123; x=1746222923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L71wbVzPITjVbxLTuqE+a4PqABXthkJ7VNT8yULwBtw=;
 b=E1CHbllNT8TgZuRqYl67XKwpIu8gAcq2xYY3g0TbE3Z7Wrm0aMyApKEbyG/7f2thAK
 mht2j4iI9zN5ZcPYVtlIju3s+1m3sP9NgjN2ZClnbk+JOBY8rCLsMmDBk14cscBAmP6i
 C4IiHB9f64mwejRSI1jK5O43ZoCc2w7JF0aGOvcX6lA7Q0VohVr8vhyafcRVxuVuzRhV
 ysqcK2+LA0/RMeCY+nfst0Rc60aRK/d6sjXi9WpLX5H9EDXaOf+w+s9wvNPBXsDggQgK
 d+PlKzq3MfIPj2C6QW7Bt3tPI+sHkL+E9cZQ8PiM6Nxz71y1lr+MgxV6SCYoWUdRkcVR
 fbWQ==
X-Gm-Message-State: AOJu0YxJy33CkC5WNW6EB3YelilMIU+vxL41gUhd8H5dYrKheleGE/A5
 4xqCFEGwPmficquX28VLWGV3UFTC0Gla671lL5unKG9ix82WszSJz4H9Rs+Hg+Oe4SyDipN20oN
 a
X-Gm-Gg: ASbGncv/qmnQFCcVfmHoSYMAl4ptxMqjY2RJtJF0nmmcPPVfyNS9nsVusekZr+n7NR5
 dJ+PxGC+r0d53Of76lL8M0R6LIW5xWC/yT2i1ZQ35oruyxJOsgQgj6d4lb9I/6q3us8ymmQdCmx
 xd9JAA+TKAGabgUaP/NL35NjvFUfuLQfgI/EhIGfdHvYkym2W2RBnOg/7Ewx1jIbjCTugkwkluM
 3MNmAwzqg+qtoIpPG0luO/npCmlX+VcKBqAb0kMNYjwRx4grY12j8JmyDhsy35mffsVb5tPBF71
 Cyv2rNXWshpzWBqA8U1iemgwxo0DaPNgzzGohQczZdiH4H3T6fiMP8wIizU3Btc8qqUWyev1HbU
 =
X-Google-Smtp-Source: AGHT+IEbvFU6FhnQVIqOn9vIj6Dp0Vx9Kb8j9pZ2DEtq3ftBSzTiQiGyShZnWTIaA1Y+DCScPxUoQw==
X-Received: by 2002:a05:6a21:108f:b0:1f5:591b:4f7a with SMTP id
 adf61e73a8af0-2046a6f20afmr1087330637.38.1745618123256; 
 Fri, 25 Apr 2025 14:55:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 038/159] tcg: Merge INDEX_op_not_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:52 -0700
Message-ID: <20250425215454.886111-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 tcg/optimize.c           | 13 ++++++-------
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 11 +++++------
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 13b7650cec..d0fcdfd241 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -46,6 +46,7 @@ DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
+DEF(not, 1, 1, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(not_i32, 1, 1, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -144,7 +144,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(not_i64, 1, 1, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index b4a675ea37..315ee0a8bc 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -475,7 +475,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_rotl_i64:
         return rol64(x, y & 63);
 
-    CASE_OP_32_64_VEC(not):
+    case INDEX_op_not:
+    case INDEX_op_not_vec:
         return ~x;
 
     case INDEX_op_neg:
@@ -1103,12 +1104,9 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        not_op = INDEX_op_not_i32;
-        have_not = tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0);
-        break;
     case TCG_TYPE_I64:
-        not_op = INDEX_op_not_i64;
-        have_not = tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0);
+        not_op = INDEX_op_not;
+        have_not = tcg_op_supported(INDEX_op_not, ctx->type, 0);
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
@@ -2987,7 +2985,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_nor_vec:
             done = fold_nor(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(not):
+        case INDEX_op_not:
+        case INDEX_op_not_vec:
             done = fold_not(&ctx, op);
             break;
         case INDEX_op_or:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e0f8ab28b8..ddc1f465a4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -462,9 +462,9 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
+               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
         /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
+        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
     } else {
         tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
     }
@@ -472,8 +472,8 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
+    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
+        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
     } else {
         tcg_gen_xori_i32(ret, arg, -1);
     }
@@ -1764,9 +1764,9 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
+               tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
         /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
+        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
     } else {
         tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
     }
@@ -2254,8 +2254,8 @@ void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_not_i32(TCGV_LOW(ret), TCGV_LOW(arg));
         tcg_gen_not_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
-    } else if (tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg);
+    } else if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
+        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
     } else {
         tcg_gen_xori_i64(ret, arg, -1);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index acd666d30b..5e43a304c0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1024,8 +1024,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
-    OUTOP(INDEX_op_not_i32, TCGOutOpUnary, outop_not),
-    OUTOP(INDEX_op_not_i64, TCGOutOpUnary, outop_not),
+    OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -5474,8 +5473,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_neg:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 25ad37fcd5..96e3667ab2 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -571,6 +571,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = -regs[r1];
             break;
+        case INDEX_op_not:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ~regs[r1];
+            break;
 
             /* Arithmetic operations (32 bit). */
 
@@ -695,10 +699,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = bswap32(regs[r1]);
             break;
 #endif
-        CASE_32_64(not)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ~regs[r1];
-            break;
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
@@ -1053,6 +1053,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_mov:
     case INDEX_op_neg:
+    case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -1060,8 +1061,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         tci_args_rr(insn, &r0, &r1);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fb51691538..96dddc5fd3 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -315,7 +315,7 @@ Logical
 
      - | *t0* = *t1* ^ *t2*
 
-   * - not_i32/i64 *t0*, *t1*
+   * - not *t0*, *t1*
 
      - | *t0* = ~\ *t1*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d3da498098..a1f9a3a2f0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -739,7 +739,7 @@ static const TCGOutOpUnary outop_neg = {
 
 static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
-    tcg_out_op_rr(s, glue(INDEX_op_not_i,TCG_TARGET_REG_BITS), a0, a1);
+    tcg_out_op_rr(s, INDEX_op_not, a0, a1);
 }
 
 static const TCGOutOpUnary outop_not = {
-- 
2.43.0


