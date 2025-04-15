Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FB7C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m2r-0004Vm-AQ; Tue, 15 Apr 2025 15:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzB-0007vT-9N
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:21 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly3-0000ju-LX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso5242651a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745337; x=1745350137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2u/fQtfODmqKR51nOwe5ZrsA2fepjDkWFmnS0XPr9u0=;
 b=Lp+BEOKse7IB3h9JCt7VKm1MBAfyy8A7hW2WfD7fdSx/nclodENJR7hEHdbh4anQhV
 7Z7vhelFj3NP3IsUxW44Gp83qAfDpSo7VMwVThVXU1NEcfUZDz7wcWi/PMoIa5zlBbej
 RD5/3RSqfVL3c33ZO5InrcoYpbrNYYqJLPDcvMADYtQDVH0PeFg81M1AxOpnszpYWzOT
 NNYT0XOn+ab7T2LxHSkEgVf6QTvwxXr48ODl22F9K4lw9h2Hy208i4aGTZwFlIfH7N7D
 utgIrfDF98xoTcSABGKyJ0lGFeFHX7YUtpC8AkjUbN6NJK2YCeWeWa8TP7re4JaNwy8i
 xR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745337; x=1745350137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2u/fQtfODmqKR51nOwe5ZrsA2fepjDkWFmnS0XPr9u0=;
 b=dKEohqV/Wlb/fWyl2qwTtuBfwTX1oWGJbDrspF4SpCaDPOBUF6nEqaHLm0TEGiJ79B
 8p+vb3ZipWiC65UApJdO7LCYxhvAT9ftRmPQVOrYZDWMlx3CkZZxdaHMECs+R4vttwvi
 Udw9H9mwHbLMrviOIvndubDH9Yafk3ZjjBwL0DRojEPOoZ6/aENwnLVhRNmODJnIE9jg
 nvrctoqk5PwgqFhpxKd3kNJ4hioI9izZZyqhtJHcu8TURKUCzvLzms9j36kTwQKK6TpD
 SDnmPWb+cb1Ezw5tp29/mnYk/GGuRoxEiKWCPCqPGyaQ0LQSlVP1zoF4huoI+Z9X7Zig
 oBRg==
X-Gm-Message-State: AOJu0Yw/RAo0GOpMB4NGjbdwtpTXVXLmo2iUuIyg/ngGh0UlOHfbE/sQ
 /ZYynQWve3FmmTrgFCnOXn7Hbuh1s99J4/x7ES34gT50Y+bfC8BgOB0/0R/Q4jKjNhPPuzRTKZd
 1
X-Gm-Gg: ASbGncuetipGPkPnWFTzSeL72qtE6ZWm5Mr8XePH0tKyi5vYo5iENe40FLITy18c5Gu
 xBOlinbgeCJa6yfEYf2LkbU17BS4x0ahdrmarXmpSHhVmaSU8MdfWLfxoSnwzSolHEzanLbxs5f
 VmIzsub2BG+Jj/el1UGDF4jUbaVvdaAtKLhQCcch3DQNSnaBYTBct5N3whokrgNmM12V6ZtLQSa
 HAz+2UQ7Zblf1fNUqwXjP7xpCjCqTxRxR3LJdgZy4SLvRCMEznMJ793RdN+0c/0G3ND4CDdPel9
 3CEuXShoaVbItpuEB0/1wSboAyUbCMitcHeSc0ska2dOiunodNLMxpatXh0M4oH2CsFDCIYLsA7
 Yqx3NLIesBg==
X-Google-Smtp-Source: AGHT+IFWxAV9YEjz7NUKaHm9Mj2XyC8cRvFldOtAx6kBaSfWx2y9RjzOzMzHGLmJYcRPbsefakoDAA==
X-Received: by 2002:a17:90b:3a4c:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-3085dfad0d9mr1086367a91.11.1744745337147; 
 Tue, 15 Apr 2025 12:28:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.28.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:28:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 046/163] tcg: Merge INDEX_op_div2_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:17 -0700
Message-ID: <20250415192515.232910-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Rename to INDEX_op_divs2 to emphasize signed inputs,
and mirroring INDEX_op_divu2_*.  Document the opcode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h  |  3 +--
 tcg/tcg-op.c           | 16 ++++++++--------
 tcg/tcg.c              |  6 ++----
 docs/devel/tcg-ops.rst |  9 +++++++++
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 243f002a61..36dfbf80ad 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
+DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
@@ -72,7 +73,6 @@ DEF(st_i32, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
-DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
@@ -118,7 +118,6 @@ DEF(st_i64, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
-DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f326c452a4..f95beb8b5d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -603,10 +603,10 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_div2_i32, ret, t0, arg1, t0, arg2);
+        tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_div_i32(ret, arg1, arg2);
@@ -623,10 +623,10 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_div2_i32) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_div2_i32, t0, ret, arg1, t0, arg2);
+        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_rem_i32(ret, arg1, arg2);
@@ -1971,10 +1971,10 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_div2_i64) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_div2_i64, ret, t0, arg1, t0, arg2);
+        tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_div_i64(ret, arg1, arg2);
@@ -1991,10 +1991,10 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_div2_i64) {
+    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_div2_i64, t0, ret, arg1, t0, arg2);
+        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_rem_i64(ret, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 563a29e579..f6192142ba 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1028,8 +1028,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
-    OUTOP(INDEX_op_div2_i32, TCGOutOpDivRem, outop_divs2),
-    OUTOP(INDEX_op_div2_i64, TCGOutOpDivRem, outop_divs2),
+    OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5470,8 +5469,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
+    case INDEX_op_divs2:
         {
             const TCGOutOpDivRem *out =
                 container_of(all_outop[op->opc], TCGOutOpDivRem, base);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 41985be012..62af390854 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -297,6 +297,15 @@ Arithmetic
      - | *t0* = *t1* % *t2* (unsigned)
        | Undefined behavior if division by zero.
 
+   * - divs2 *q*, *r*, *nl*, *nh*, *d*
+
+     - | *q* = *nh:nl* / *d* (signed)
+       | *r* = *nh:nl* % *d*
+       | Undefined behaviour if division by zero, or the double-word
+         numerator divided by the single-word divisor does not fit
+         within the single-word quotient.  The code generator will
+         pass *nh* as a simple sign-extension of *nl*, so the only
+         overflow should be *INT_MIN* / -1.
 
 Logical
 -------
-- 
2.43.0


