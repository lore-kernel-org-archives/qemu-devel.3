Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EC6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDT-0006VK-63; Tue, 24 Dec 2024 15:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDI-0005zI-S9
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:09 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDH-0002ve-9I
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:08 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso57377605ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070945; x=1735675745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fe/KzvBli4+DT+q021rXbUAcleZsNqwpOUiAKLjvzrs=;
 b=nmiR9B01JES9/PXH1gp0bzCPqexq4Kqc1ov0Ga2iareRJm10owzOa7M01jDGTiIAUJ
 wdNuRMvzlBL86KwnXAh/cdXMWKJU+vNV+arGLORhIm3jgW0fSUE5TiqAMSptHwBcwqKz
 UVmZ9Mpq8seX6veRznmM+S5VAnvx84kTsPqg2GzRWbvCqR4mkFyHxjRR8CVkAuu7QhNc
 DvUfW39luu2Bp9oOC/Og66f8QpPxApfEyWuiRdSe0W8Hl/FGV1d+6kfSGlb3snYKU4Ui
 bwFOcimtr2tfnueKlA7kag7VFtcciocbG3nAfzgi7NVqWqLiep4MjB+d1EvJNjEhk535
 k6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070945; x=1735675745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fe/KzvBli4+DT+q021rXbUAcleZsNqwpOUiAKLjvzrs=;
 b=qTULClORO6zWn4Heo1fCopGCQu9fEQIh0L6tjCCgvVF6NxGOiuW64Sg+Fx+J1g1mvh
 M/qzdL9++r/2LPxBx76Qa6kZdlp9SiLwMrOgxqyseM4OCYgP5nEEufZoHsCnqPJf0cIv
 Yv1ee6BNHFD5PKnRX3AblhmqTti4YwQNLsQd1HGvmUCtQsA7TIA6ua3Mg32EYH5wN+QZ
 kBMcU9/nRhdfVvZdYPcRxXrCEBGYO18GQIFUfW+0c9P7z1OPGVTzGas94mOLinXn1l/B
 GZdQFVwLt1o8jXA7hsIuV2Ypn42a9w4oJi9niF1MQIdwxP9AL8t7/GHlwZOOBTHOl5fh
 4vmg==
X-Gm-Message-State: AOJu0YwqgNwYgRhRH4k0VYS5DcQICGGnmAcFE8S1J9a6GuF0ehJmLITa
 Mr+L31jBKxmRhyxQoo0jomdQhVoinoyXGXyIBT1PD304rHWvd6VIPrDA/+LCDGJsuBhl75AM9rY
 4yro=
X-Gm-Gg: ASbGnct+VSWrj3A47onc34eBenqX6QtAyX7c68m4nLsw38xnUIvGPHLvIRZo/+S+k9+
 SGCGXb1FAkJHSJNeLt4rZjeUms9mCHCwidrSXtkKOlb5TJJ1dD8S+y7YS1T7XGzcH0l3nNgaJss
 006bDujkkd9fHAPPHOU8lo8rVx1IoaJsTDpLSzB+HzCO99ugLkbYS7UT2Jv88RjTq6tzp6yAEs/
 zC6ORHZh1B+Vmdl1Hei6V9Z5e9pHyQQRY4IOD7Aj5Ky456ArMa9wf84KhM1RO7tT2kU+5wq1y3J
 Jgvhrgw+inBLcK+M6ITcCnzT4A==
X-Google-Smtp-Source: AGHT+IFo+FGuwZbYV9CpYwyRDmSqKwT1oc1uD+5B8CywUIUFEKz2H64Cd2xmeAI3TlFOLo2hlFMlgg==
X-Received: by 2002:a05:6a00:3910:b0:725:e37d:cd35 with SMTP id
 d2e1a72fcca58-72abe060d9fmr25548964b3a.18.1735070945450; 
 Tue, 24 Dec 2024 12:09:05 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 45/72] tcg/optimize: Use finish_folding in fold_sub,
 fold_sub_vec
Date: Tue, 24 Dec 2024 12:04:54 -0800
Message-ID: <20241224200521.310066-46-richard.henderson@linaro.org>
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

Duplicate fold_sub_vec into fold_sub instead of calling it,
now that fold_sub_vec always returns true.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 26790f7c27..cd052a2dbf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2620,12 +2620,15 @@ static bool fold_sub_vec(OptContext *ctx, TCGOp *op)
         fold_sub_to_neg(ctx, op)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub(OptContext *ctx, TCGOp *op)
 {
-    if (fold_const2(ctx, op) || fold_sub_vec(ctx, op)) {
+    if (fold_const2(ctx, op) ||
+        fold_xx_to_i(ctx, op, 0) ||
+        fold_xi_to_x(ctx, op, 0) ||
+        fold_sub_to_neg(ctx, op)) {
         return true;
     }
 
@@ -2637,7 +2640,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
                    ? INDEX_op_add_i32 : INDEX_op_add_i64);
         op->args[2] = arg_new_constant(ctx, -val);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


