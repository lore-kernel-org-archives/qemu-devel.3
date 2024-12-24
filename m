Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7886CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAy-0004Hp-MU; Tue, 24 Dec 2024 15:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA4-0002pB-BB
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:48 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA2-0002aJ-Q2
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:48 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216401de828so54802625ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070744; x=1735675544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K74UPQ6ATO0nDrlE7cqFEozEZk33xGq1bz1J9EIx6SI=;
 b=pBZJ9KiB9yKcGMNwZqXl4IEVdV8klzUCp7NRGl4Q+ee6uEFp3l617IL+KSJbzLX35T
 X3f8uei0ALu6yNTeztUMxIG3JPjdre4LuNEY9P9NBxaHOOMdXqGIHDx7OnWwpasfzAfQ
 5kKQ2m0gGDSf90wT5hwpi0e8mNq4mmUfweFe1yzNYfCkVlK7Yf7Uucp6n99CFkTHr48o
 4svWZD4K180ZyqOYhvgCo5BVaeM0woMTo95DB8iVNeC1uVTdOm6FPvTsk0z6qmClpexd
 uwOwCVKdmGdXMAClbyomq/FMzWJBoyAbT6SVKKgKXdDU1wqBntLTP249Pb+TDGySy0vd
 MLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070744; x=1735675544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K74UPQ6ATO0nDrlE7cqFEozEZk33xGq1bz1J9EIx6SI=;
 b=qzY3mchwZnsY0Bsp7cnrnKe2cfOiFhCt3dilznvmErlZ+eTTJFjxGQ483FhvrjI/F+
 gFPjzTpUS9EcryRDMSq7H/754YirjmUqyBmi1YDFAQ6ixaFOLsdvwI4K0vksAMbRJes4
 lferGBBYLk7RZlAQjL1cKX0fwJu+qFI9Zibyb240FsMbDe4CHBwggPzYNYXmrf+7cfNF
 fiz1mkkwN7EHYomvZYIKVBmoykbUTqtg68ysWTEYLb3Ni4MA0iLX9wA3ICW5n9+rmyeP
 Vugg69WT8lq2aWKaqN7L6yhY9dPHL4uEOfK27GZI+HEtBZFNTNRlm0eO0Zoxsb5iYsXZ
 mvSA==
X-Gm-Message-State: AOJu0Yy3FEbtNNw6imzfE3yV6cvaorxp+QKGq+KmpJxw4VTM2l1zSzg1
 mu1mrVs4XjUOJTr2Esj+bVOT5UWHDpMFgio4z77iDELDo2SK/8taS7NdknAzhx8MHbmvo0aguC7
 RlgI=
X-Gm-Gg: ASbGncvQZ7mVBglBtAmb8C/WyJ68zCAbVrDj4LaxeRe01lXXWfv7mjabTeAsVkr97xI
 fqWHHFdYR3T52HZi8msz58fQVIL7SDBOtuRU+RMY0Q9HtMmSezAer1jZppLfIclH2l+QBcyxQcy
 +K1zUkKCeNpG+Rghf7VqHrEI0ZKqfcBrPnzYF++AJJ0XDs8N0oi5YM50GdyslNeR/4XUgqtjXSh
 pWCCS2vh3VzEGo5f3bL7ECf9t5++HiSbwKd0i18JOlAhC7heKzsxKW20I9vwo+FdsTAWMqq9tJx
 q3SdBY00ekn9ZtYHzIMbvAMw5w==
X-Google-Smtp-Source: AGHT+IHovg5eGdtTp4h4tD5mpyB8hf0d7yLpFQmYey+YNWla3BlzxP2UyV09RoLHJbPNngCU5aSDig==
X-Received: by 2002:a05:6a00:414a:b0:725:96b1:d217 with SMTP id
 d2e1a72fcca58-72abdd7e0e5mr21657386b3a.9.1735070744223; 
 Tue, 24 Dec 2024 12:05:44 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 23/72] tcg/optimize: Use fold_masks_zs in fold_exts
Date: Tue, 24 Dec 2024 12:04:32 -0800
Message-ID: <20241224200521.310066-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.
Explicitly sign-extend z_mask instead of doing that manually.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 04ec6fdcef..3aafe039ed 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1778,49 +1778,44 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask_old, s_mask, z_mask, sign;
+    uint64_t s_mask_old, s_mask, z_mask;
     bool type_change = false;
+    TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-    s_mask = arg_info(op->args[1])->s_mask;
+    t1 = arg_info(op->args[1]);
+    z_mask = t1->z_mask;
+    s_mask = t1->s_mask;
     s_mask_old = s_mask;
 
     switch (op->opc) {
     CASE_OP_32_64(ext8s):
-        sign = INT8_MIN;
-        z_mask = (uint8_t)z_mask;
+        s_mask |= INT8_MIN;
+        z_mask = (int8_t)z_mask;
         break;
     CASE_OP_32_64(ext16s):
-        sign = INT16_MIN;
-        z_mask = (uint16_t)z_mask;
+        s_mask |= INT16_MIN;
+        z_mask = (int16_t)z_mask;
         break;
     case INDEX_op_ext_i32_i64:
         type_change = true;
         QEMU_FALLTHROUGH;
     case INDEX_op_ext32s_i64:
-        sign = INT32_MIN;
-        z_mask = (uint32_t)z_mask;
+        s_mask |= INT32_MIN;
+        z_mask = (int32_t)z_mask;
         break;
     default:
         g_assert_not_reached();
     }
 
-    if (z_mask & sign) {
-        z_mask |= sign;
-    }
-    s_mask |= sign << 1;
-
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
     if (0 && !type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
-- 
2.43.0


