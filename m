Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD2CECE577
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dX-0003U1-MW; Sat, 07 Sep 2024 22:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dV-0003LX-RP
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:45 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dU-000520-AD
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:45 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d873dc644dso2407582a91.3
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762403; x=1726367203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zeN6h7OSkzIznAtGXkS2TM05Vzv6xYEK4cYNsvDB5Y=;
 b=fgxrxszay9VRn5E174A3JWPdCzhUbe6SpMnwMRLmxtGBuiPjzmruzAZGYbwqig0TSK
 ELPqGje4TE3rIt+qJ33coqFSjCt3XVM+QXs8THuMV9TRE76N72XR0NEJpgfuaMJzXvPD
 GJWzvVFzsZYmYQCisNPZn6727WdMfQjGyur5Suk4rObtyENKT2I/ALQi4Z3/HpoUFQlf
 QlKE+nwnu2auCvG4S/qzP01WtdDGeLbNSjXgKyWmsIb+Fa9HN62ry5nyXbs8QBLBPKQQ
 v7O8WBWMIEF/TBZV0mLH8pYc03eMJO4nKtbSij6FCKb2FdU5rve+CRRLKDG/x4ypRzP0
 z7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762403; x=1726367203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zeN6h7OSkzIznAtGXkS2TM05Vzv6xYEK4cYNsvDB5Y=;
 b=a/+CrexhNjvmg5YMWeIb0JCdN+fPcp3P6q02iG+SWZxFco7wS9IqAQfDK8Of6bjeG0
 kCgqIBUHcHQJqKjdQbjorp8eJ/y9CxzbmJzSDwW16dGDDxnGqdTFuTimKvYn+nGGyaFb
 j8TWCFpurTBA8ojj9n+zCTt34QTlyRSlTjTK0d8q5u6g6CPMKs93fpMUO9rEjPt9CFYc
 gpZ5JlV/a9PNizKO0wWkcFSgHly3Pixfn9XCc3WTYEL8tjAvv8/k5VYyAdXZcc4py53z
 DXnp8KTea3H5XfbKlqPfZZHEnVAAZUsqNhlrLVo8akQmKw4BOFP3SJd0nnmmIZf++4yw
 Qrww==
X-Gm-Message-State: AOJu0Yzy3/D+aNM9JNJYL/zW1NxJCuto35vqMwksj+8PaTZ8ewIADnsb
 /cUnIAEsdg6mQab1LqTHxLKBUkga9msXL9MjGEOMNxqmeaQJhUFZiPukIhU3Utcs4qATNGUjnOY
 b
X-Google-Smtp-Source: AGHT+IHU4gZrp8G+R9jE7kfDXii3XHwlmfNyKPRaq86Q9mpD/aG7CPKQ1YUAfSU1k1Snp8PrcFRcbQ==
X-Received: by 2002:a17:90a:8c8c:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2dafd09713amr4639854a91.33.1725762402625; 
 Sat, 07 Sep 2024 19:26:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 08/12] tcg/optimize: Optimize bitsel_vec
Date: Sat,  7 Sep 2024 19:26:28 -0700
Message-ID: <20240908022632.459477-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Fold matching true/false operands.
Fold true/false operands with 0/-1 to simpler logicals.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f11f576fd4..e9ef16b3c6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2737,6 +2737,61 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
     return fold_masks(ctx, op);
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
+    return false;
+}
+
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
@@ -2964,6 +3019,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_cmpsel_vec:
             done = fold_cmpsel_vec(&ctx, op);
             break;
+        case INDEX_op_bitsel_vec:
+            done = fold_bitsel_vec(&ctx, op);
+            break;
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-- 
2.43.0


