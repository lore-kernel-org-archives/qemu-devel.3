Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189CCC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lyh-0006pN-Tb; Tue, 15 Apr 2025 15:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyI-00051e-BQ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:26 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly8-0000tD-9k
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:21 -0400
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-af5cdf4a2f8so4478950a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745354; x=1745350154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vIB8urvsZEi8i+iZt++qivt4i5X/EOsnZDYwFYlVPpM=;
 b=QJt5uBVB7eLrxGA/jzAurRdlPE3gmbqKozY/slIJejD69+InZ0MunReWB1wZqVYd5R
 Eht9FEIn5zfF7VLYHkMLYh6QDVyzRjiO4qOENjhfZZHX+1XO8kNxEGcphqSKazxMUZhv
 q2cpvnQBlPxd2oU6LS40vEaeNKlhApGPUBVLQwsDyq3KJOxvCWqHNARe0baEOxPwM/7q
 GOpbKL9tYkpXyQSje5tSlm6iSafJMVRXwEoTM5c2FiAVbdCpiz9FdH9TEHPtRXTDqYl2
 mQ9VyM8f/sZQyxjDhN6jlCPfgQeWxQ/18Z9yU4C0qo/H7+/5hMK/0Nr5VUBTGnt9sfz9
 2iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745354; x=1745350154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIB8urvsZEi8i+iZt++qivt4i5X/EOsnZDYwFYlVPpM=;
 b=fR6lCk6GuDAFCHqPilnpBlQ5TD8LQ6t7yHwq3iSNksZClQ+g3OccEkfcmPlB4qXfVt
 uh/Ahj5KHOoi7CJAUycr8FIKwcuunHduSXk/WLo0L1GgzQ7BsIhohjRfLuzabcbxtPwu
 3bQzWkfdh7d6/C6q3bC2TacbiD2H61wC7oSTyanX7NWRim2BRTSIqarH2u/4XALFurhK
 H5Ql+vzboanFtVYcvUQj7J62AttWKZXpgrHXEY/wC354XSW1yj1vI1ok3Z9ROYQ9KL/e
 GuJqEyUlSUT79aSDVCi6gBPeG3xXGEYGeNBj6PxQkmTNGUkREc4vI5K+8Mgl4VHm6E23
 XD0w==
X-Gm-Message-State: AOJu0YycSY9lhfpbxdSKFNyjRmlkAIPy0ejs3AxN23zfmJmbgygyx5ll
 FDZ/talpVeDoX7zxuWv0+xIliL97fHOofH0rQjewqCJ+5/4moCJrZWdNmMzMlHx/f1tBLTqYQ8y
 a
X-Gm-Gg: ASbGncvB6j7ay3kKDDY9vS7uObYOCmMi2FGffY9Pt1OOUSlYSZ5+MrJ8NIxqfQwSIub
 7J75eEUTFop6Fcj5/l2020bcfwSeucsYJof1X3gGmDKJjDSmIUABbQ/Gs9MhFT+LyFfcUWis5KX
 1hENHOu5Wo6LTL6iHZ5czpv6ffzWuV3BQot7IEJatQz2QK+tdpm2Mx5xcqcuMYSLknMrz6i3bvJ
 a7pmcvMgrXUafl451+lpkmnco/IIlsYft0Bng6BlfiMfj02CioTLQWLvLPKC6U7IF7ilABpZiMR
 la4S1AxjTCiZw3vHFSYNy/1io28nnEX/k52GtJlIwvKZhFQFXNjSGdO+T/CGFDyLYkAcV/MIM5A
 =
X-Google-Smtp-Source: AGHT+IFqLNy+uNRDqbwNOJ/1Yt+mlbwgqXWQjCoGfgZpFazTbHBTGhpC+XpKwUF4/9kznXIrECTZ4A==
X-Received: by 2002:a17:90b:5683:b0:2fe:8a84:e033 with SMTP id
 98e67ed59e1d1-3085ee95bc6mr648203a91.2.1744745353766; 
 Tue, 15 Apr 2025 12:29:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 067/163] tcg: Merge INDEX_op_ctpop_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:38 -0700
Message-ID: <20250415192515.232910-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.181;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-f181.google.com
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
 tcg/optimize.c           |  9 +++------
 tcg/tcg-op.c             | 21 ++++++++++-----------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  6 ++----
 docs/devel/tcg-ops.rst   |  6 +++---
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4dfd8708a5..f4ccde074b 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
+DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 DEF(ctz, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
@@ -97,7 +98,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(ctpop_i32, 1, 1, 0, 0)
 
 DEF(setcond_i64, 1, 2, 1, 0)
 DEF(negsetcond_i64, 1, 2, 1, 0)
@@ -130,7 +130,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(ctpop_i64, 1, 1, 0, 0)
 
 DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2dbc0e45b4..78979623c5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -503,11 +503,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return x ? ctz64(x) : y;
 
-    case INDEX_op_ctpop_i32:
-        return ctpop32(x);
-
-    case INDEX_op_ctpop_i64:
-        return ctpop64(x);
+    case INDEX_op_ctpop:
+        return type == TCG_TYPE_I32 ? ctpop32(x) : ctpop64(x);
 
     CASE_OP_32_64(bswap16):
         x = bswap16(x);
@@ -2890,7 +2887,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_ctz:
             done = fold_count_zeros(&ctx, op);
             break;
-        CASE_OP_32_64(ctpop):
+        case INDEX_op_ctpop:
             done = fold_ctpop(&ctx, op);
             break;
         CASE_OP_32_64(deposit):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index db0e79059b..0eeec47b83 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -765,8 +765,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_temp_free_i64(t2);
         return;
     }
-    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0) ||
-        tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
         t = tcg_temp_ebb_new_i32();
         tcg_gen_subi_i32(t, arg1, 1);
         tcg_gen_andc_i32(t, t, arg1);
@@ -791,7 +790,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
     if (arg2 == 32
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
-        && tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
+        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_subi_i32(t, arg1, 1);
@@ -819,9 +818,9 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 {
-    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop_i32, ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
+        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t, arg1);
         tcg_gen_ctpop_i64(t, t);
@@ -2372,7 +2371,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
         return;
     }
-    if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
         t = tcg_temp_ebb_new_i64();
         tcg_gen_subi_i64(t, arg1, 1);
         tcg_gen_andc_i64(t, t, arg1);
@@ -2406,7 +2405,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_temp_free_i32(t32);
     } else if (arg2 == 64
                && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-               && tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
+               && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_subi_i64(t, arg1, 1);
@@ -2435,12 +2434,12 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        if (tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
-            tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
+        if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+            tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
             return;
         }
     } else {
-        if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
             tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
             tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
             tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8344aee6c1..6095205307 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1027,8 +1027,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
-    OUTOP(INDEX_op_ctpop_i32, TCGOutOpUnary, outop_ctpop),
-    OUTOP(INDEX_op_ctpop_i64, TCGOutOpUnary, outop_ctpop),
+    OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
@@ -5444,8 +5443,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
+    case INDEX_op_ctpop:
     case INDEX_op_neg:
     case INDEX_op_not:
         {
diff --git a/tcg/tci.c b/tcg/tci.c
index 8bcf48b251..d58a94ff28 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -577,8 +577,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
             break;
-        case INDEX_op_ctpop_i32:
-        case INDEX_op_ctpop_i64:
+        case INDEX_op_ctpop:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop_tr(regs[r1]);
             break;
@@ -1023,6 +1022,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), s2);
         break;
 
+    case INDEX_op_ctpop:
     case INDEX_op_mov:
     case INDEX_op_neg:
     case INDEX_op_not:
@@ -1033,8 +1033,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
         tci_args_rr(insn, &r0, &r1);
         info->fprintf_func(info->stream, "%-12s  %s, %s",
                            op_name, str_r(r0), str_r(r1));
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 92344b8786..fb7764e3c0 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -366,12 +366,12 @@ Logical
 
      - | *t0* = *t1* ? ctz(*t1*) : *t2*
 
-   * - ctpop_i32/i64 *t0*, *t1*
+   * - ctpop *t0*, *t1*
 
      - | *t0* = number of bits set in *t1*
        |
-       | With *ctpop* short for "count population", matching
-       | the function name used in ``include/qemu/host-utils.h``.
+       | The name *ctpop* is short for "count population", and matches
+         the function name used in ``include/qemu/host-utils.h``.
 
 
 Shifts/Rotates
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index a931369a80..1d696a087e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -883,7 +883,7 @@ static const TCGOutOpBinary outop_xor = {
 
 static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
-    tcg_out_op_rr(s, glue(INDEX_op_ctpop_i,TCG_TARGET_REG_BITS), a0, a1);
+    tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
 }
 
 static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
-- 
2.43.0


