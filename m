Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722B5E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDd-0007NF-DX; Tue, 24 Dec 2024 15:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDS-0006TT-BL
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDP-0002xX-Mv
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:17 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166f1e589cso67084455ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070954; x=1735675754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEYI0S30T/rgONrSP0b+foHB4bUKaiqwurHUBqbuKQI=;
 b=RXZkV9sRHT42gj/VRnKru6Qf02UPCljzVnTYOE6qos61gmbFiBQC7frxRhNygT+iYX
 rk8lrhDS6lgFI/v18NJT3KBZQDzUVI1TvaR3BzQG9TuHLQ7/bQOCQqAxJtAXZiYxPME9
 aD7+F+Fwoj+UEehTLCcSbpxJ8Dd29fXwCXRGMvzaTDxjB6SV1+MvVhLwO+Y6dJJfZRjA
 w7OiGXyYFKzD9vrFMZISn4G5xpVElU/eEKzN24y6DPdKn7Pc+FIYgYrPW2K0yEyz45mB
 YjYqrvmGrMedHj1/k8/qMoTfXJlbZjMiUazX6buri2qAKWqXxsErodmU48wM/nt6b51b
 cSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070954; x=1735675754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEYI0S30T/rgONrSP0b+foHB4bUKaiqwurHUBqbuKQI=;
 b=YAA/DJFMUv0+OtKghBMM0PsElJt1GtpjYgJymhfcN5L90lnL1LZK1/5FIA/VEiL8v1
 f+Wi9jstWjmciYerYBY4V6ZJICElfwbIo/GTaLNXd88ww9d7FbOzKdmiyrpBTrmZS8Ub
 2LZXbhfq6FlES6wIyx4fbRnpPoO9nd7lVBuG5VM6Tv2LqACAbJRhvjzX1HYv90KDpkuN
 bN+Jg1zZzHvfgw+hV8R9B9YEKAB/UaQ+NUPBH09rvF81YnwAPepnrWIQxySz/KVucMbC
 hTjnCoqbrxypgJHqRNRbbIEZZRvxVXkPMZelKM+/V8jEAmM6vEZVHpbaoWkqonoBKJOt
 ZgBA==
X-Gm-Message-State: AOJu0YxzKexQ7ZRm6Vnw1kyjISlgqotyqqMMtylPROvousfL/Ze8VBh+
 x85xbZZy3WUsbzurjHknBjOlvFCSE7yBkbHlq2WCLxSnZOt3IxX8uufWmXZN6RgdHM9d73elkB4
 djKA=
X-Gm-Gg: ASbGncvyjimFdDm3KF99j6ikXnuKwOQj5f8bnfyAwbwysyMxvTDL1gcKV2RYCUa5E9P
 Kz9BQEoqd7xK54F/yW7NcXQlKyTPQgPMKHZhxdTfvokLWqhtJq8U7aV4DvS6xz+ZUgCWu/HwvCR
 9r1zoxx9gRvEU7HMGnFORMURYmqPSTbR338VwK/oSjo3P1/X1ckk9hjht9jsUTPCwZlrm4aGQ4Z
 HACdkjD9TcQJzpD+nm6Yc0Md/jSpBW1Oq/va8R7E6LEP3k7/T5ihiX18JRSoGiNo9dL6xOIxqfW
 rP0NBZ7eTGUupnwFmzDkwdyAcw==
X-Google-Smtp-Source: AGHT+IFzIWlVkuDjWbDwthvcGSWvtRFMgtm4Z8h7UpHcq7nxEYUUICTXWYZn+vH5g1s8lUuFruys2Q==
X-Received: by 2002:a05:6a20:a108:b0:1e1:9bc1:6d6d with SMTP id
 adf61e73a8af0-1e5e07ee6e4mr35782718637.31.1735070954398; 
 Tue, 24 Dec 2024 12:09:14 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 54/72] tcg/optimize: Move fold_cmp_vec,
 fold_cmpsel_vec into alphabetic sort
Date: Tue, 24 Dec 2024 12:05:03 -0800
Message-ID: <20241224200521.310066-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1df61378ea..c23f0d1392 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1619,6 +1619,36 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
+{
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[3] = tcg_swap_cond(op->args[3]);
+    }
+    return finish_folding(ctx, op);
+}
+
+static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
+{
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[3], op->args[4])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
+    }
+
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[5] = tcg_swap_cond(op->args[5]);
+    }
+    /*
+     * Canonicalize the "false" input reg to match the destination,
+     * so that the tcg backend can implement "move if true".
+     */
+    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
+        op->args[5] = tcg_invert_cond(op->args[5]);
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask;
@@ -2519,36 +2549,6 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
 }
 
-static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
-{
-    /* Canonicalize the comparison to put immediate second. */
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[3] = tcg_swap_cond(op->args[3]);
-    }
-    return finish_folding(ctx, op);
-}
-
-static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
-{
-    /* If true and false values are the same, eliminate the cmp. */
-    if (args_are_copies(op->args[3], op->args[4])) {
-        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
-    }
-
-    /* Canonicalize the comparison to put immediate second. */
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[5] = tcg_swap_cond(op->args[5]);
-    }
-    /*
-     * Canonicalize the "false" input reg to match the destination,
-     * so that the tcg backend can implement "move if true".
-     */
-    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
-        op->args[5] = tcg_invert_cond(op->args[5]);
-    }
-    return finish_folding(ctx, op);
-}
-
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, s_mask_old;
-- 
2.43.0


