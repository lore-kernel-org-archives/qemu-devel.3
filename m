Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD24AC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqc-000228-OF; Sun, 16 Feb 2025 18:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnq5-00012h-6R
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:24 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpx-0005Ri-Kx
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d398bea9so52016245ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747637; x=1740352437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Du6dRevSzYwve6eY0t81TeUcucbU0ZiMPd1wa2vDxAw=;
 b=lz+che9iph/f9Wb2sOK2aNcqEqK7ZDKY14Mv6SKOom7o0PevIJABTfLJTDezRBrAI6
 ZbksT0n3thKNOSAmCetdNRvBr7vN+CTRuV3s7vN+VBSkufgvRAnAd/W1f3I5sCI1Dhie
 2onPqCTMtttYDaXlZ/zREmQot4GnQGDgk4j3hLpN7nIsdV9Kc1/W63MhQ116zdSiH0hG
 NMPKmoH9pVNDHhkHUGplh9M7vBw5dKxa22HwCLVPp3gZAltXLmNBDJ5B+u3f6cvijwU6
 4JljPBvs1mqj6C2FhCs/sJLWkHExfvy9u38W4OjJ6X9xwlOnXZt6PJ/4d/gHZowycWUI
 pdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747637; x=1740352437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Du6dRevSzYwve6eY0t81TeUcucbU0ZiMPd1wa2vDxAw=;
 b=DEIRxzPlTnK0YY+GS/ekC6yC80MA1wKHVppJesCDbOsUaKNzNCqNijkniUCOuH9f04
 WlVbTSy2t81x0DuLmpbNNSFDrtfAPTofeOe1UAbBYSTrKK02LSYtSHcabhYF687yVRYF
 tZFQRW2EUd25eIjqQTlUPV3c8O5IQtp756BwviveCJiXEhTE9LiDkto+Rq+Rs6NqHuWM
 xasK3ZBINhHoV8Y1LdSjAWIH/8QxpjiUQFFtIENtCyxmqtQ6gpa8qAkwqu/FOhcFxUIq
 nuLqok8R3fQsa08HWODOXkFgJtH0AH1tlFNuUWaZcj1do7DzmLWBGoSsumYjclcYe3hu
 Jz/g==
X-Gm-Message-State: AOJu0YzkJLHzTfgRniB7RLnD8JEi42Of18ERQRAXBCdBI1m5MkkXtB+I
 p8yPXi6FzSAB4b2t4D4NO5FVrXsiWM9Dh0ybj6Ymbzk/Qd4aB1IndDQjiVjHPN9/LlyrwUI0lDo
 Y
X-Gm-Gg: ASbGncvgcK64In6wNk8ughOymv/YlctRKxWRjMQYLk70goSlVzO632w5TtpK0AksqAo
 Ydvx/eLdQf8brPiP0887lzCoyJG8j/FezU+4fpYKY44zWU/KlvXrP6wB9zJTyEgvN3T/5jm67w0
 P/qiNxP7mhjuXHeC4mpBSzfkYsq2tWma7C2ZVneWGHyGannDQNX3UMrxkAEjMFNMRlY1vii8LcJ
 KqNeG/OBkADLaTUn3D8CJhKXlO/CQZIg8z06jQFnhMNjlevKlujjyF8fVFGsHguatY0j2Ic8Jp9
 3T7bh9bffJYbNsecC8QnKAN1SSWW2CCv9XItFhjiZuO7vV8=
X-Google-Smtp-Source: AGHT+IHS8HE1uhtXjMuPBE8i/BfjTVP032SfBp3WGkWiBNDg+d+vPHIWUqNatH+Wj7Bq9BtnAx10TQ==
X-Received: by 2002:a17:903:1c5:b0:220:f509:686a with SMTP id
 d9443c01a7336-2210407b939mr129115525ad.29.1739747636671; 
 Sun, 16 Feb 2025 15:13:56 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 055/162] tcg: Merge INDEX_op_shr_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:24 -0800
Message-ID: <20250216231012.2808572-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 17 +++++++----------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 11 +++--------
 docs/devel/tcg-ops.rst   |  4 ++--
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c2ac25d1b6..35e0be8f80 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -59,6 +59,7 @@ DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
+DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
@@ -75,7 +76,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(shr_i32, 1, 2, 0, 0)
 DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, 0)
 DEF(rotr_i32, 1, 2, 0, 0)
@@ -115,7 +115,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(shr_i64, 1, 2, 0, 0)
 DEF(sar_i64, 1, 2, 0, 0)
 DEF(rotl_i64, 1, 2, 0, 0)
 DEF(rotr_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index bc882dbe31..a10fb67da8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -440,10 +440,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x << (y & 63);
 
-    case INDEX_op_shr_i32:
-        return (uint32_t)x >> (y & 31);
-
-    case INDEX_op_shr_i64:
+    case INDEX_op_shr:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x >> (y & 31);
+        }
         return (uint64_t)x >> (y & 63);
 
     case INDEX_op_sar_i32:
@@ -2330,7 +2330,6 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2352,7 +2351,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        shr_opc = INDEX_op_shr_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
             uext_opc = INDEX_op_extract_i32;
         }
@@ -2361,7 +2359,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        shr_opc = INDEX_op_shr_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
             uext_opc = INDEX_op_extract_i64;
         }
@@ -2390,7 +2387,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op->args[3] = 1;
     } else {
         if (sh) {
-            op2 = tcg_op_insert_before(ctx->tcg, op, shr_opc, 3);
+            op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_shr, 3);
             op2->args[0] = ret;
             op2->args[1] = src1;
             op2->args[2] = arg_new_constant(ctx, sh);
@@ -2597,7 +2594,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * input sign repetitions.
          */
         return fold_masks_s(ctx, op, s_mask);
-    CASE_OP_32_64(shr):
+    case INDEX_op_shr:
         /*
          * If the sign bit is known zero, then logical right shift
          * will not reduce the number of input sign repetitions.
@@ -3020,7 +3017,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(rotr):
         CASE_OP_32_64(sar):
         case INDEX_op_shl:
-        CASE_OP_32_64(shr):
+        case INDEX_op_shr:
             done = fold_shift(&ctx, op);
             break;
         CASE_OP_32_64(setcond):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c85c056726..ef8cf5a1ac 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -496,7 +496,7 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_shr_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
 }
 
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1615,7 +1615,7 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_shr_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
     } else {
         gen_helper_shr_i64(ret, arg1, arg2);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a22e642522..5b60ffcaab 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1043,8 +1043,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
-    OUTOP(INDEX_op_shr_i32, TCGOutOpBinary, outop_shr),
-    OUTOP(INDEX_op_shr_i64, TCGOutOpBinary, outop_shr),
+    OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -5417,8 +5416,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_rems:
     case INDEX_op_remu:
     case INDEX_op_shl:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
+    case INDEX_op_shr:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index 22401ce1f6..376b1b1ece 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -621,9 +621,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] << (regs[r2] % TCG_TARGET_REG_BITS);
             break;
-        case INDEX_op_shr_i32:
+        case INDEX_op_shr:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint32_t)regs[r1] >> (regs[r2] & 31);
+            regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
             break;
         case INDEX_op_sar_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -787,10 +787,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_shr_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = regs[r1] >> (regs[r2] & 63);
-            break;
         case INDEX_op_sar_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
@@ -1078,10 +1074,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_rems:
     case INDEX_op_remu:
     case INDEX_op_shl:
+    case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f64c881530..f9fd4b0087 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -384,10 +384,10 @@ Shifts/Rotates
      - | *t0* = *t1* << *t2*
        | Unspecified behavior for negative or out-of-range shifts.
 
-   * - shr_i32/i64 *t0*, *t1*, *t2*
+   * - shr *t0*, *t1*, *t2*
 
      - | *t0* = *t1* >> *t2* (unsigned)
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
    * - sar_i32/i64 *t0*, *t1*, *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 5651833ac9..c0dbe873f1 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -792,7 +792,7 @@ static void tgen_shr(TCGContext *s, TCGType type,
         tcg_out_ext32u(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
-    tcg_out_op_rrr(s, glue(INDEX_op_shr_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_shr = {
-- 
2.43.0


