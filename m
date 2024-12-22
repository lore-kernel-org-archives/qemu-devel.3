Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE558E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOpd-0005YX-AS; Sun, 22 Dec 2024 11:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOod-00051q-0s
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:29 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoa-0003kH-7V
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:26 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-801c8164ef9so2478836a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884903; x=1735489703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctuXEQAvjhmDIIWoKLKBiMc6mMChQIOixW2dzl2+Gwk=;
 b=QCmWUtg0tyudFV35HYJc6rG9HTN7pJib/L4uu1iCDt74hvwEynPEzEyfQioUhmRUdm
 lMoFDxDcog3Lt+vBI6QiA58RJyM6p9CfOWVtwyP5Vz5TPJIzqZPsWcjgUjKFCQx5xNIN
 Xiv7bPlQ1txBJeRebmgIbiZKubLey/n9A1ET+4vYD8hmMfnEoa/nAJNSkpVXCw4ZG39J
 RNL+IlaDInfXRH9uQxCtbK8sM5acp7irYemp0lr/3cH1xI3WgXhOtq7L66kRj5XlVRwS
 K8vfc/1dsOAEb1aQr5xgNMTJFl7x4u47T0TtZmeFWTZgUCumZjMaj831qz8sNUqw+sEe
 WaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884903; x=1735489703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctuXEQAvjhmDIIWoKLKBiMc6mMChQIOixW2dzl2+Gwk=;
 b=csxbfs+9qhu7Gv1j5SxDK656edjSo3PxMiQ/PoWkbPY+J/EFp1wnnb+71PVaTt3+zF
 CthWmUL0+r/ltWeSyit8JaRVFFQApGMj1s1iUkwawK+X/hUxH4eApl8w3Ti1XoZmzTae
 QA4Vk8kClqFHeKJCIxdDiY8AwkywwP204kX55Dj3VLns07vkF9R15R2SelTxlxxW2wt7
 UIxpWhA6fInizwnIwxWu27QNjcAgnlsIBYWBw5mSluwDlWIYWoI6LTQKHHmp2+8JqJzl
 w78aKZDNVPJ1notR4ztWrZAPqy2FqGK6WdzVubufeb2MKSklkTLZqh8CQe717l+Or94e
 4j/Q==
X-Gm-Message-State: AOJu0YwQ/+vlNRkqd1xG0DgRcuLNmVf4EIHAqWIUTHH4QJNNVUXj5jT9
 d97SemnhY+7O5SXcbOcJhmqiITECTGWdE12nbDVFbKAy3nzqv5ngQgVHvgfd4N6LN7CXkUUW4nU
 j7Gk=
X-Gm-Gg: ASbGncvfDBgnv/OCsEkxtM1Z13rSpvz7DJPMatQtGEHP/dye6WH6Phkcajpccb/SQiB
 kAft3v/y+++dxUrun+DAuPholAYvG4lcWwl/E1XuhPVm23VYx5olBBdoCjkogX4Ic0uYZrr0UQ8
 GoCPLs9ri5lMcC91W/8L5bMw0s68DLwbv09DUV4hzSP91NV4zribp1aRuFaDQ/UwK5TOFNbrmr5
 m+UVi729Hr8zOpNFzoRbo+e+lY6VTCL9QrN8wrW/CG976aOlCMRtlb5N2ad0jI=
X-Google-Smtp-Source: AGHT+IFEXzWxupMqZrC8D49eLIKc0s3byQA23O0t2RoOQ3MiFNVlFDo6rfZO65TfEDLh2zBebMDqpQ==
X-Received: by 2002:a17:902:ebc8:b0:216:4b6f:dde5 with SMTP id
 d9443c01a7336-219da5e3ba5mr223023945ad.13.1734884902872; 
 Sun, 22 Dec 2024 08:28:22 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 50/51] tcg/optimize: Move fold_bitsel_vec into alphabetic
 sort
Date: Sun, 22 Dec 2024 08:24:45 -0800
Message-ID: <20241222162446.2415717-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
index 607697e19c..312cbac690 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1179,6 +1179,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
  *   3) those that produce information about the result value.
  */
 
+static bool fold_or(OptContext *ctx, TCGOp *op);
+static bool fold_orc(OptContext *ctx, TCGOp *op);
+static bool fold_xor(OptContext *ctx, TCGOp *op);
+
 static bool fold_add(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -1341,6 +1345,61 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
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
@@ -2755,61 +2814,6 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
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


