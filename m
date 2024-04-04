Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536E9CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 21:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsUD5-0000yA-Qj; Thu, 04 Apr 2024 17:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsUCn-0000mw-BY
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 17:01:06 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsUCT-0007Qq-Jz
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 17:01:00 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so1100788a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712264443; x=1712869243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0/ekaTyyBHEzg2gMKpvUq/mv6Nl9iOhi1rhUNF8qDbI=;
 b=untSB3DJz/zDZECL01+9KnzLhCyslTesEZkRzjuig2UlkzslfJ2UCFeEGUbQDGCL6B
 kN83m38dHT6P+CqQ5ywB+n9J1svjttXBlpg2oYODSdKmvGrAvF4pP+jnXGowjgssL4AO
 tjswg5DogZCwrBTE5yfNnRYpLuzI7bLy7LbuLcbb/7iavtioredGJePlWSFuQ7qIkKqB
 Nobrl81PLnjwmbK3NDduV1gFUJp1/s9f0+ueZ5HchmThJK3uOSzwlHl5DWbRjRzeNVD3
 gAbc3bkQJ38YyVkq6ooQURjTrKguHFQLdojXvBr9Wtl7joyPkWk16Gn/piajeap445GW
 CDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712264443; x=1712869243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0/ekaTyyBHEzg2gMKpvUq/mv6Nl9iOhi1rhUNF8qDbI=;
 b=e6dwpYoptxB/78GOFfvmqCHoRoPhAkBQ2b+NVyaBSs3IKkQ4+Qckmjn1WXe85boSEJ
 yNOmKbTScExN8VcHtCx0mV7CmSICOS1GNUIQH7viIf1C/D1YZo+t2G8Qs5V+0xXzhxai
 ULUZcLxvutXPA7A+PyhdJiIRLtypsosWpR7ibE9l2188pt18osersk5RAwE/aBsfI4Pg
 v9smU9a84DoWjCDx5UK7/aUkFVrHv+a8EDECfhSycLs2GGDSBI13IJlAeOXsWot0+qhj
 cac9qHBckBkcgtYMUlgTKpdoGt3k4YFLcGwYYnym+uXaqC6sIyBz+ue1k2A7EwNXy7mK
 vOmA==
X-Gm-Message-State: AOJu0YyeWjycjaBiErCUnV7q6qzOeXKzJQ39bp5A3fA0CVNPWWWllC4e
 i3HuSeia1/TfkfhnkCVoT6ggyTPhoosZ+KlxdqGoXKdQpCzMshkvgJnEnhzz1vMCrQxqFCwIFbC
 /
X-Google-Smtp-Source: AGHT+IH9Na5/3d+Tnc8jhhTltzkBnJ8Wcq4AwtwWwhMloY50uV24QTTHUpnkyFJxU6dy6OMohmLaMQ==
X-Received: by 2002:a17:90a:ce:b0:2a2:a88a:4324 with SMTP id
 v14-20020a17090a00ce00b002a2a88a4324mr3390254pjd.13.1712264443175; 
 Thu, 04 Apr 2024 14:00:43 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 fz7-20020a17090b024700b0029facfb3f25sm140418pjb.45.2024.04.04.14.00.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 14:00:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.0] tcg/optimize: Do not attempt to constant fold neg_vec
Date: Thu,  4 Apr 2024 11:00:40 -1000
Message-Id: <20240404210040.5150-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Split out the tail of fold_neg to fold_neg_no_const so that we
can avoid attempting to constant fold vector negate.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2150
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c                    | 17 ++++++++---------
 tests/tcg/aarch64/test-2150.c     | 12 ++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2150.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 275db77b42..2e9e5725a9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1990,16 +1990,10 @@ static bool fold_nand(OptContext *ctx, TCGOp *op)
     return false;
 }
 
-static bool fold_neg(OptContext *ctx, TCGOp *op)
+static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
-
-    if (fold_const1(ctx, op)) {
-        return true;
-    }
-
     /* Set to 1 all bits to the left of the rightmost.  */
-    z_mask = arg_info(op->args[1])->z_mask;
+    uint64_t z_mask = arg_info(op->args[1])->z_mask;
     ctx->z_mask = -(z_mask & -z_mask);
 
     /*
@@ -2010,6 +2004,11 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_neg(OptContext *ctx, TCGOp *op)
+{
+    return fold_const1(ctx, op) || fold_neg_no_const(ctx, op);
+}
+
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -2418,7 +2417,7 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     if (have_neg) {
         op->opc = neg_op;
         op->args[1] = op->args[2];
-        return fold_neg(ctx, op);
+        return fold_neg_no_const(ctx, op);
     }
     return false;
 }
diff --git a/tests/tcg/aarch64/test-2150.c b/tests/tcg/aarch64/test-2150.c
new file mode 100644
index 0000000000..fb86c11958
--- /dev/null
+++ b/tests/tcg/aarch64/test-2150.c
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2150 */
+
+int main()
+{
+    asm volatile(
+        "movi     v6.4s, #1\n"
+        "movi     v7.4s, #0\n"
+        "sub      v6.2d, v7.2d, v6.2d\n"
+        : : : "v6", "v7");
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0efd565f05..70d728ae9a 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -10,7 +10,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
 AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
-AARCH64_TESTS += test-2248
+AARCH64_TESTS += test-2248 test-2150
 
 fcvt: LDFLAGS+=-lm
 
-- 
2.34.1


