Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3254C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrJ-00048m-Ru; Sun, 16 Feb 2025 18:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqA-00015V-VW
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpz-0005Sc-EB
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:16 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220c8f38febso67454625ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747643; x=1740352443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AYq+TETUgW9DkVlqb21sRi/RYuURVxlHMdH0bfUE7SU=;
 b=dm8xEgiwAp5t8YfSDfcNGwPQw6pJrA9wIBoyZGRIqKKI39XcLg5VaYfkQH+P9R5JVT
 eVUX9gvJYUp3FB5pPe46Hf3Nj8BO/t5Uzy8QSC0XYZ9b1a/84phiMh6ndKzhZ7P4MUBn
 dHMWXptdI7EoM8+BPAGXv+hklfP4cxZmjNEK1O/HVAlFTeOWP0EoU+J3AJoPMNJvAR0u
 rRJGFmX3O6nydArpK7BQWd33thZEz4ytJ9uPDuLD9fpfXhdU55UhlnbO7jUjLVn9yjDp
 ByM3c8c9IzPQjT9udnIKE5U9MpJ7zvDk+rmAaS7ykDGHZwTpIz/IAvyvQ+KG1ibWFMlZ
 WJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747643; x=1740352443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYq+TETUgW9DkVlqb21sRi/RYuURVxlHMdH0bfUE7SU=;
 b=a7R1vdOudShfK9Do6YHBLLNgvKTNajT9ri3C1Gze0Omg+5F6gYIXRe+5Ume5lQzxY6
 MYrOzSLj62uDm/y0JBQNjPqGBKIwOCwYl3RcfhpgII5H2kW1TrqZHRObeQb24/Mm2a+1
 xdLLujuLPKKAIcq7mFyC4+u9XbkBhbCeOXOFN/pmi98uVPImfoqYWAwslQsQxYOQv+V3
 M82+TBNmimRvLhnsIzdLLf9ya8I6V9h7qG44Czs3TwWLIIvtpuqArCeQXqFxCm48AbWE
 z1tVoNETCavlCnuvPjYvqrx9nLGHvYDo8O9uwSbIS/9jgMte0j4nbH9Jndh+WHaNQBzS
 iujg==
X-Gm-Message-State: AOJu0YxX9t5ubzzjAKBUOKpxXRqfn2oVM+vdchIAniGBhtC824o5xRKa
 XG1lhiErCEsSRo2s+34mzo9r4L/uW4DwI7LEYK9Rsv1MfKZcLPdC2RrEBOud0r0fkgLC1WrXHDT
 8
X-Gm-Gg: ASbGnctZZMfL/HfBAOuIbzxV/Q5bR842VWbzVr94NL5UxkOR98JGEtwAqgzmuoaw60i
 ZNXiMNJe4tnjqIo2uBMyivbPMyVS1cyiBcq3hwjR25d/q7ZkrBeEaFKDWteNmgoDzhb0uWFCFp7
 hutguancHFwoXgi+1fkYJ4xwu+EhGIAaaFMGZrYOLpYJY7pQT91CIAHHrfahKxmxWhH+LjhXWQh
 29+Q/wWWU/eDT551FOf6mN8GnR8x20+CI2RfoKZ6SlaHU6pbgZWymnV5916jkbBBfuorl2pHU/O
 e02QqU1bqUK+zuTkYwlSHbiDQnBCO/FMvxeAPGqbIZgV8tA=
X-Google-Smtp-Source: AGHT+IEjPHjO6bzCtModMpgmg/Esq847C+fJCVetg/M+5PujIFym2hYBZ4JvBSYNqvIhpKEyOsnu0g==
X-Received: by 2002:a17:902:ce89:b0:21f:71b1:70d8 with SMTP id
 d9443c01a7336-221040d6f8emr109590325ad.51.1739747642795; 
 Sun, 16 Feb 2025 15:14:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 064/162] tcg: Merge INDEX_op_ctz_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:33 -0800
Message-ID: <20250216231012.2808572-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 tcg/optimize.c           | 10 +++++-----
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  4 ++--
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index ad1d193ef4..4dfd8708a5 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
+DEF(ctz, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
@@ -96,7 +97,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
 DEF(setcond_i64, 1, 2, 1, 0)
@@ -130,7 +130,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
 
 DEF(add2_i64, 2, 4, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8c7a2f8b30..2dbc0e45b4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -497,10 +497,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return x ? clz64(x) : y;
 
-    case INDEX_op_ctz_i32:
-        return (uint32_t)x ? ctz32(x) : y;
-
-    case INDEX_op_ctz_i64:
+    case INDEX_op_ctz:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x ? ctz32(x) : y;
+        }
         return x ? ctz64(x) : y;
 
     case INDEX_op_ctpop_i32:
@@ -2887,7 +2887,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_bswap(&ctx, op);
             break;
         case INDEX_op_clz:
-        CASE_OP_32_64(ctz):
+        case INDEX_op_ctz:
             done = fold_count_zeros(&ctx, op);
             break;
         CASE_OP_32_64(ctpop):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b117a59f05..7bf7de1213 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -750,11 +750,11 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
 
-    if (tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_ctz_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_ctz, ret, arg1, arg2);
         return;
     }
-    if (tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -788,7 +788,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    if (!tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)
+    if (!tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
         && TCG_TARGET_HAS_ctpop_i32 && arg2 == 32) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -2366,8 +2366,8 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
 
-    if (tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
         return;
     }
     if (TCG_TARGET_HAS_ctpop_i64) {
@@ -2395,7 +2395,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32
         && arg2 <= 0xffffffffu
-        && tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)) {
+        && tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
         TCGv_i32 t32 = tcg_temp_ebb_new_i32();
         tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
         tcg_gen_addi_i32(t32, t32, 32);
@@ -2403,7 +2403,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         tcg_temp_free_i32(t32);
     } else if (arg2 == 64
-               && !tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)
+               && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
                && TCG_TARGET_HAS_ctpop_i64) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i64 t = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3b744d692d..e5a2bce79d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1027,8 +1027,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
-    OUTOP(INDEX_op_ctz_i32, TCGOutOpBinary, outop_ctz),
-    OUTOP(INDEX_op_ctz_i64, TCGOutOpBinary, outop_ctz),
+    OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -5394,8 +5393,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_ctz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
diff --git a/tcg/tci.c b/tcg/tci.c
index b505944b10..550f2014a8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -735,7 +735,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
             break;
-        case INDEX_op_ctz_i64:
+        case INDEX_op_ctz:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
@@ -1049,6 +1049,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
+    case INDEX_op_ctz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
@@ -1066,7 +1067,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_ctz_i64:
     case INDEX_op_tci_ctz32:
     case INDEX_op_tci_clz32:
     case INDEX_op_tci_divs32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 22f0432988..92344b8786 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -362,7 +362,7 @@ Logical
 
      - | *t0* = *t1* ? clz(*t1*) : *t2*
 
-   * - ctz_i32/i64 *t0*, *t1*, *t2*
+   * - ctz *t0*, *t1*, *t2*
 
      - | *t0* = *t1* ? ctz(*t1*) : *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 47bdec5f44..d8d45e2c4b 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -645,7 +645,7 @@ static void tgen_ctz(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_ctz32
-                     : INDEX_op_ctz_i64);
+                     : INDEX_op_ctz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


