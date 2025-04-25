Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF16C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0j-0007Fc-GZ; Fri, 25 Apr 2025 17:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0f-0007Cp-F8
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0c-0000IH-Jb
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:01 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so2462719b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618097; x=1746222897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yL5Df6MlqpnjsRM4lJY2fvGRb96qZEkbw6f23uPi2c=;
 b=qh5tVCPq7+bjA7TDK8in3YPFRZfG+MOe+M+13AUxcO+272ehUFyff52zxK4fydK3pI
 nQGRUmY/GZL3SuasgVkm2sw9HbFjuOdzb68QaWRo3PBTRcqnxsT1rSBldr3wNaasggAt
 PhmZJ6gwFGI/3zS0GdF36l90ZQYP7F1RkDFPpi7cmDq9l9btVX5w9sqqKYI7BdgBGmKQ
 iBDLigC9sIJ4b4aG1602fdEYjiBBBLtk++PWLYuC+Q/j38MVZvqNatjE4aqoDsTw4pjZ
 qNWt31NIh9qbUYx+hyGVinVFg6u8QQ4hkbOdxHaIWWpxwKkzwEA96l9PrsreamsoBt0t
 ASwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618097; x=1746222897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yL5Df6MlqpnjsRM4lJY2fvGRb96qZEkbw6f23uPi2c=;
 b=oxsdvnbmf77I5Zq1J+tLvq+wom8se0HJ0TTGbqMbQUx7yiXrar0FRnSWHDYOd+/ZSu
 XqhvOtGy0MRmfAexpEuxQbxA9Bh/vh/TEvZiVy+5A5aLS5iwkXXBh9WZXpXk+dTSXATO
 WGXE6Et9w+26YlJLFcAs2LbsBGiShLhzLZVzT9GdA2DxEAO9qZeUUhVbkS7AdgJiM8o1
 GBw1Xz99LFIJOR5SHnGSbV3GQwygUqGAUxI/b5GD514ZyYaMDkD63+4/X5eOO33LskTH
 lNrO9WFo6EY9O5yuBkwtGGae54nLANCQuwiwkN+aqAUC0z2wDo1/P6bmfk6EecY3BDZb
 6SGA==
X-Gm-Message-State: AOJu0YzK16qWVai9Dju3x0bQ0NbyDZQLsTiv6JVZ+XOJSUXwgVihI2MR
 sMaUT9QwkYgrqvJVa5yCiawz2/iPKWJGU3eXBn3RGzOInBfmRti33F2kgupVEyDCZN/EvMKS0FV
 +
X-Gm-Gg: ASbGncsJajNk5Pd/4qx1pUkdOJH4U7SP3DMdRbp2Yzej/dFXqACbNfsC7W9heQF6H7V
 cDVX8ujMRD2FN+PmN/1iSQUwF1K7BdiJ+tpKsceWdT5BSablAKLsoorOw2kWJCiAh9/2kK/F5k/
 lP3mrlcafhz80pzuIiwgyV9kFwo6rBnI4OsEMoGNmjCAJR8B/1pjdA5jmAQB5+AA1HgLK3iXtwL
 /YAHsvCdn7pQiZEsOyNfP5xc8FLV1+fq1Mf7TVj+SwdF4BfMT8Th9FpIvr6ehA6gzMJW90MP43r
 izJj40k+qz/aaqA4WMRsHRpIQ0igsgqP+2va7Hy20E3qmOVePcE+ghEZMR2ACEYwtHNhlY2D3gM
 =
X-Google-Smtp-Source: AGHT+IEnwK8UPFjOQkoKJr67f5m+2NhQcVBefeT3ddVBTkeXVUFLSzgEbkgq1G83y8v71ysNzyfRvQ==
X-Received: by 2002:a05:6a21:1f81:b0:1f5:75a9:526c with SMTP id
 adf61e73a8af0-2045b6f5201mr5903141637.13.1745618097218; 
 Fri, 25 Apr 2025 14:54:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:54:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 003/159] tcg/optimize: Introduce opt_insert_{before,after}
Date: Fri, 25 Apr 2025 14:52:17 -0700
Message-ID: <20250425215454.886111-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


