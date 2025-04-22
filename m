Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA08C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7El3-0006bt-VT; Tue, 22 Apr 2025 10:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7El0-0006b7-0a
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:37:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ekw-0002tD-5U
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:37:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so4787135b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745332669; x=1745937469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JdDIQnvmo0e1Jn2XVNIljcgd444Z5PONslazAv7tWg=;
 b=z25DonlHOIDxNeBquyFT7UYPUi0x9uuk2PHLuJ5rVT1PYkArb8imA6+ilym4fNoGkL
 Vb7GXEk8t4StGTTuMypvBYVeyOr6f4p4qsV3WvL77AguwwMRcS1utSN1MGwAgUjRcRZX
 aWKanROYaQJcrhsfILT6tIFG75VVB8bcGagaQuhnZafFKcRS3vEV8eTS3yeAhKh7VNN4
 IGS4kCEHY5qZr631F2APiekL1MAEvWoTjnXEawse8vq5ohveCl+CefaEC9dmyine6xWy
 LXNUCW5LvG0/lB6Kfgnmf63OLSJQK4R5ZztB2w1pw/A6FPrOCYMIy5IH5WCDl+i0xF0u
 MJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745332669; x=1745937469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JdDIQnvmo0e1Jn2XVNIljcgd444Z5PONslazAv7tWg=;
 b=r0D/sIyA22DP0AsYOhWAUfOOcZa5JchSiLVAqtUNKbULCjPYibtfAL7tf66SUa8zOo
 p6x19p1eD5XEQWLaJU0joZKoKHtvJRB1aoOk8PXJjKpdpWtjq7EBk+VF349agHhw1E0n
 v92SKwlsfmoM4uh3SNaAW1DXGw02GdJUFFa1ShlnHVl7nINPtf/JnVRoF+KLAHTsdZi0
 Hj6pHfELqWG0eMzBCDFx56gplt1+l9UMANf7B3G2StL/GZxXPqKRx6Lv6PwBbN1jGVdx
 oLjjfZffUoMuU1Kuiv32lm1OHX3JUhHMz2KLJ4Cx62oSbK60D5wgbD5k8FNZ9ZlRBISZ
 8IPg==
X-Gm-Message-State: AOJu0YwHGxssGOJyfCCTWSW4WbSd+zJNFHZwMe54t33iq+851rvLjj7l
 iav0MakX9yMZcMW3xWDK0bQQl7sZkDKz6zogtcU5nZUXhZDOq4I8AWKKKej8w4UKP37AoQXb3qU
 2
X-Gm-Gg: ASbGnct2BLE/TOTgprxOFU0quxu0ZNfpgHGVsj0e478The5uHzJ+WPFxk8mZn5pnVPu
 gtez458wfackJLZlyEB8JxrhG11k3+FmzMA7cb6RGQJz+0aWEjR6xKbs8CNy9G6iTe31PuYuwOr
 fUUBUSzSBfCR645h03qDA4AxyUU3xQ9ugztBtUVwPutOtM6O7qY8GQG5UB7kTomFvkPbNP6evMB
 BPzwdlvkcpwbuNwexg57MCWEv8rN6A06S3uuOcj9TbqjuLOq8Sjrf4MSNCwX1IZXtMLWd6lBjBH
 973AV+0XdTk4BQ/MPQB2f9Ogktvr2jVv+LrrBPkDRyvvNvbeHBYZ/n+fC1v+Sa2twDov49E/Ycc
 GeRopBQ9aZA==
X-Google-Smtp-Source: AGHT+IHiuq4pyjmQSQEq7v4h8xWijBuOVUB+ZESbDDT5P1EY9j9jRdId2q92tm9422Hwd0tOD2PsNg==
X-Received: by 2002:a05:6a20:9c99:b0:1f5:70d8:6a99 with SMTP id
 adf61e73a8af0-203cbc0a866mr21157961637.4.1745332668675; 
 Tue, 22 Apr 2025 07:37:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db157bb7dsm7375952a12.69.2025.04.22.07.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 07:37:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com
Subject: [PATCH 1/2] tcg/optimize: Introduce opt_insert_{before,after}
Date: Tue, 22 Apr 2025 07:37:45 -0700
Message-ID: <20250422143746.261776-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422143746.261776-1-richard.henderson@linaro.org>
References: <20250422143746.261776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Consolidate the places we call tcg_op_insert_{before,after}
within the optimization pass.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f922f86a1d..a4d4ad3005 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -344,6 +344,18 @@ static TCGArg arg_new_temp(OptContext *ctx)
     return temp_arg(ts);
 }
 
+static TCGOp *opt_insert_after(OptContext *ctx, TCGOp *op,
+                               TCGOpcode opc, unsigned narg)
+{
+    return tcg_op_insert_after(ctx->tcg, op, opc, narg);
+}
+
+static TCGOp *opt_insert_before(OptContext *ctx, TCGOp *op,
+                                TCGOpcode opc, unsigned narg)
+{
+    return tcg_op_insert_before(ctx->tcg, op, opc, narg);
+}
+
 static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 {
     TCGTemp *dst_ts = arg_temp(dst);
@@ -808,7 +820,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
     if (!TCG_TARGET_HAS_tst) {
         TCGOpcode and_opc = (ctx->type == TCG_TYPE_I32
                              ? INDEX_op_and_i32 : INDEX_op_and_i64);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        TCGOp *op2 = opt_insert_before(ctx, op, and_opc, 3);
         TCGArg tmp = arg_new_temp(ctx);
 
         op2->args[0] = tmp;
@@ -901,8 +913,8 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
-        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGOp *op1 = opt_insert_before(ctx, op, INDEX_op_and_i32, 3);
+        TCGOp *op2 = opt_insert_before(ctx, op, INDEX_op_and_i32, 3);
         TCGArg t1 = arg_new_temp(ctx);
         TCGArg t2 = arg_new_temp(ctx);
 
@@ -1263,7 +1275,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         rh = op->args[1];
 
         /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = tcg_op_insert_before(ctx->tcg, op, 0, 2);
+        op2 = opt_insert_before(ctx, op, 0, 2);
 
         tcg_opt_gen_movi(ctx, op, rl, al);
         tcg_opt_gen_movi(ctx, op2, rh, ah);
@@ -2096,7 +2108,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         rh = op->args[1];
 
         /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = tcg_op_insert_before(ctx->tcg, op, 0, 2);
+        op2 = opt_insert_before(ctx, op, 0, 2);
 
         tcg_opt_gen_movi(ctx, op, rl, l);
         tcg_opt_gen_movi(ctx, op2, rh, h);
@@ -2406,7 +2418,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op->args[3] = 1;
     } else {
         if (sh) {
-            op2 = tcg_op_insert_before(ctx->tcg, op, shr_opc, 3);
+            op2 = opt_insert_before(ctx, op, shr_opc, 3);
             op2->args[0] = ret;
             op2->args[1] = src1;
             op2->args[2] = arg_new_constant(ctx, sh);
@@ -2418,17 +2430,17 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     if (neg && inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
+        op2 = opt_insert_after(ctx, op, sub_opc, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
     } else if (inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
+        op2 = opt_insert_after(ctx, op, xor_opc, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
     } else if (neg) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, 2);
+        op2 = opt_insert_after(ctx, op, neg_opc, 2);
         op2->args[0] = ret;
         op2->args[1] = ret;
     }
-- 
2.43.0


