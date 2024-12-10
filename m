Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D476AE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL29k-0007Je-F3; Tue, 10 Dec 2024 10:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29f-0006V2-4h
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:07 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29c-0000K9-JO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:06 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71de334f141so734479a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844483; x=1734449283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kk1vW6jFHzIeel5bbAGFsFlrjy89Dvl21DC4rV/7wrE=;
 b=O2TTLg33l3CZia6oKueByDTLbwShjORKW/YGyNTkTooKLM8es5hmcCnfiUkvK+5Uqm
 tV7e5Dpic1A6rgq/B39X5O+rPdPR5c+NYTWdcJ0kfmLsgayzW2aYp8oqi8zdOxp5WQeh
 zAO+cyamMYb5Rm7dp5NSDYKx0xMTo4eSH97xr7HS5bRj33SebSrr/fJBu8gymxz+jr+J
 9zCcdRPmPC4LOQs7HYwYpJVUj4xT0PNlEt01/danOkxTKVIYtJJWwikQOpoE21WP1i9l
 hhVL0xKLbPwxGTczhgXfLD2MLQJXblxkmdPfqI+oaiuvBLtG5q0ikDZRHMDWJS2iLnnc
 8CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844483; x=1734449283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kk1vW6jFHzIeel5bbAGFsFlrjy89Dvl21DC4rV/7wrE=;
 b=n3vLs2MWA1gVzz09Fc2xWFf1qaXxgw861+Bli4i1GiNsbaJT96HP5oCBLoxC8UWZzH
 2UfuQLkp06hksFpq2pN2E16ZfHr2wvl/KGcq/ZUXSMW7cLZOgcVb0Crv23vWkFV/KRmC
 KWKGoNBq6m1OSoFk8BugXR5yeEZnxmXpLy2P0pat8+uTdZMy1JW0vYMNEq0Um0VyDTeg
 nrWl3NwaGlBcXjQnh8OrGA0SeS7I2QE0wLpa6zFTnxI7LGAeNdaqS0vGKP9pbv82xLVj
 cYYfTX0IoxRunyx8AcWyHoyDPnDEHWHxTLsuwz8b5LhOZIPkHbx5Z5XB8CzOglrkjD0B
 6BIA==
X-Gm-Message-State: AOJu0YwUviPm0mbhFlZtaE7IlyFixhchjmPDCrpbOX9/kTKO9uVFJCc3
 aRgmUcFePOqUb21Ilwsp1dYDbEEFsINWcexwHihyxIdOjjan5qC7X3PvsFmGwpL7kykeazoHi24
 KL2DNhyzC
X-Gm-Gg: ASbGncsJgoA5+RzFXlyjSLzbh78xPaOVP+WT9f8LEUSDY9enVishAvYjb+fHyGpAwIb
 mGkS9ObVVOcNO5SZay642pfkcLAr6ZrvVzYg5f6VvjZnBu3RRSWsSjdQa4fFGxJ2W/oUBMUeoOM
 ZeoIUSYoY7AdfZeWXhArbQUWL2wmcaE80chTCwe1a+HdoknbWJBTj/sh0F0QZdq5POV+pNTuLs+
 r/Q82397wkCc+Cq1ETf0jqkYTUdOXZizajeeBdvK3iorFnS3iKvGnooADbCyA==
X-Google-Smtp-Source: AGHT+IG2x8ffnGKfRMw8yvwTviJAAdFIa7OQv9xtk4G0/JfOS3qxmbwwoKQ7xNTa/ZylQwbeZopWEQ==
X-Received: by 2002:a05:6830:927:b0:718:1863:a3fa with SMTP id
 46e09a7af769-71e021ac7e8mr2409944a34.10.1733844482995; 
 Tue, 10 Dec 2024 07:28:02 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2785955a34.52.2024.12.10.07.28.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:28:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 45/46] tcg/optimize: Move fold_bitsel_vec into alphabetic sort
Date: Tue, 10 Dec 2024 09:24:00 -0600
Message-ID: <20241210152401.1823648-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 114 +++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index eb6e93809e..54082042aa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1191,6 +1191,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
  *   3) those that produce information about the result value.
  */
 
+static bool fold_or(OptContext *ctx, TCGOp *op);
+static bool fold_orc(OptContext *ctx, TCGOp *op);
+static bool fold_xor(OptContext *ctx, TCGOp *op);
+
 static bool fold_add(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -1347,6 +1351,61 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
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
@@ -2758,61 +2817,6 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
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


