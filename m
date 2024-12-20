Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78360E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQv-0003TD-BI; Thu, 19 Dec 2024 23:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPW-0001YW-Pj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:50 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPU-0006rQ-Vi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:46 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725abf74334so1298126b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668083; x=1735272883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAulOf64Aq+MQyz7Gm3afpYDj7PG4HhSWEO5QGhMKrY=;
 b=Gl2dV9IP0oXdOC0s8bsj0MfbbJbthae2MNj2nYhJXXnKFQsTi5WaajgQsmdlXZc/is
 gilPTa5oIUItv5AXMe9JoykD9e2i8PZNpc7HIuFswCmTXtlHs6wvd12Tb9iwN/m9bCpJ
 iNE0RJVYkDJJBAsBKSSyyGD8sTeVSYf9+yAtAcycXxZQhAWfxLlKi7B7y66e85XVUs4N
 o4X6Sd6SLeggzy32IOGAPUcLq1vMv+PLESgW4GzjcWaPoR+b3WZRKW01d12iWrNTflTJ
 DiPyIXxlqju8PhTIRY4Zr12zJLMzUCXeSwTEoU/9DfLNlBj6ndu321s23NV4JT3Jn3np
 Hf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668083; x=1735272883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAulOf64Aq+MQyz7Gm3afpYDj7PG4HhSWEO5QGhMKrY=;
 b=QuG8dzmAKn+TekqY5eB0DuCYr5dYNeblFHp/YsZWO7xi2BBNjiUOAJqfu73znhXuMX
 3zXmwhfRHP/qpif8eIJzP0StG50YK2a2Hr3R17FajYogOwwd+Wl2vCCaQAAfqSDOaGFK
 qH/s1/7RgSZkHIY2J0IVolCZyNh1iqfpe65c8v7jSCD7DVwcSrJuWKeLyORXgCHrjymu
 ESrl4dmrnNp57iNeRKev8C6vopf8M+NVDTMXgkQSO6zQ8eKMBz8eB171bBj9QY1Md0bS
 MJ86KbrXOoocKvwH5C6RHbcZj0hYepienURpl7rrwc+KPEfT24tNObwMu1GeVX/nDp+X
 l5vg==
X-Gm-Message-State: AOJu0YwVyjnatjpNNVvTyulhmjleCYKpio3oD6PWuKsT5kDEydGUk19R
 Z2kQUgyGPJWf1uyZiBlUq8paCksCbTtOzJLOwp2OJappo4uG41jtyW25NdN/EENIEAkR8L2YK+E
 G
X-Gm-Gg: ASbGnculgmr35MLufq32TAS/VpATL/Y+jZrIPmZSTwWkXGD/ACJ2F1pvBJTi+I7yxfR
 7FPWAsdlCj882m/Cbtc4nuyV2B4lY+tqqjV5KlZHihDsw/EZn6KPyttZuYH/0feb9Ck/tWxTC6P
 8KWDznsqaoe8ZO9PmgkezAvO/6QR74GFh3rx2MgbyVMq3luGZl1dTZPpkAuaNXUN8/zdnU3B1H1
 cMuas97NeZuDDlCIWnFkGR6wpBt50To7p+Ke8c/K/eMYZkUWoSmwwkYlmTt5rA=
X-Google-Smtp-Source: AGHT+IGQaSJ7E4TnSwOgdRbci61uPvpkftB5qjHIPmw976SITYpdEhd4wHHKJUU9T77b4pLBbO7aXw==
X-Received: by 2002:a05:6a20:158c:b0:1e1:afd3:bbfc with SMTP id
 adf61e73a8af0-1e5e0446374mr2820327637.3.1734668083253; 
 Thu, 19 Dec 2024 20:14:43 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 50/51] tcg/optimize: Move fold_bitsel_vec into alphabetic
 sort
Date: Thu, 19 Dec 2024 20:11:02 -0800
Message-ID: <20241220041104.53105-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The big comment just above says functions should be sorted.
Add forward declarations as needed.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 114 +++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2b64b8a0ec..4ec70130a9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1211,6 +1211,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
  *   3) those that produce information about the result value.
  */
 
+static bool fold_or(OptContext *ctx, TCGOp *op);
+static bool fold_orc(OptContext *ctx, TCGOp *op);
+static bool fold_xor(OptContext *ctx, TCGOp *op);
+
 static bool fold_add(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -1373,6 +1377,61 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
+static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
+{
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[2], op->args[3])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
+    }
+
+    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
+        uint64_t tv = arg_info(op->args[2])->val;
+        uint64_t fv = arg_info(op->args[3])->val;
+
+        if (tv == -1 && fv == 0) {
+            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+        }
+        if (tv == 0 && fv == -1) {
+            if (TCG_TARGET_HAS_not_vec) {
+                op->opc = INDEX_op_not_vec;
+                return fold_not(ctx, op);
+            } else {
+                op->opc = INDEX_op_xor_vec;
+                op->args[2] = arg_new_constant(ctx, -1);
+                return fold_xor(ctx, op);
+            }
+        }
+    }
+    if (arg_is_const(op->args[2])) {
+        uint64_t tv = arg_info(op->args[2])->val;
+        if (tv == -1) {
+            op->opc = INDEX_op_or_vec;
+            op->args[2] = op->args[3];
+            return fold_or(ctx, op);
+        }
+        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
+            op->opc = INDEX_op_andc_vec;
+            op->args[2] = op->args[1];
+            op->args[1] = op->args[3];
+            return fold_andc(ctx, op);
+        }
+    }
+    if (arg_is_const(op->args[3])) {
+        uint64_t fv = arg_info(op->args[3])->val;
+        if (fv == 0) {
+            op->opc = INDEX_op_and_vec;
+            return fold_and(ctx, op);
+        }
+        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
+            op->opc = INDEX_op_orc_vec;
+            op->args[2] = op->args[1];
+            op->args[1] = op->args[3];
+            return fold_orc(ctx, op);
+        }
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
 {
     int i = do_constant_folding_cond1(ctx, op, NO_DEST, &op->args[0],
@@ -2799,61 +2858,6 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
     return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
-static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-{
-    /* If true and false values are the same, eliminate the cmp. */
-    if (args_are_copies(op->args[2], op->args[3])) {
-        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
-    }
-
-    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
-        uint64_t tv = arg_info(op->args[2])->val;
-        uint64_t fv = arg_info(op->args[3])->val;
-
-        if (tv == -1 && fv == 0) {
-            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
-        }
-        if (tv == 0 && fv == -1) {
-            if (TCG_TARGET_HAS_not_vec) {
-                op->opc = INDEX_op_not_vec;
-                return fold_not(ctx, op);
-            } else {
-                op->opc = INDEX_op_xor_vec;
-                op->args[2] = arg_new_constant(ctx, -1);
-                return fold_xor(ctx, op);
-            }
-        }
-    }
-    if (arg_is_const(op->args[2])) {
-        uint64_t tv = arg_info(op->args[2])->val;
-        if (tv == -1) {
-            op->opc = INDEX_op_or_vec;
-            op->args[2] = op->args[3];
-            return fold_or(ctx, op);
-        }
-        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
-            op->opc = INDEX_op_andc_vec;
-            op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
-            return fold_andc(ctx, op);
-        }
-    }
-    if (arg_is_const(op->args[3])) {
-        uint64_t fv = arg_info(op->args[3])->val;
-        if (fv == 0) {
-            op->opc = INDEX_op_and_vec;
-            return fold_and(ctx, op);
-        }
-        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
-            op->opc = INDEX_op_orc_vec;
-            op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
-            return fold_orc(ctx, op);
-        }
-    }
-    return finish_folding(ctx, op);
-}
-
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
-- 
2.43.0


