Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256B7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQv-0003aZ-UP; Thu, 19 Dec 2024 23:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPT-0001Ln-UA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:49 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPR-0006qn-Qb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:43 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso1345755b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668080; x=1735272880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRQkBQzTRu7scLpRrqJFno9GLIyKwfRFAwGQsXfZPj8=;
 b=zwx2Nj1JD6vqgeeZ/xhwzu2iSPPUk0FAJqcl46ISHfcFZuv/K/4FG5dMkKm0BkZoS7
 eWz4Z5uqUamRleRduBx84+8/Iz303qmLB0jZTojlRwQ44Beg4enXP37XZJNWMAINmJlP
 f05U2ewSBsymEKCPfEyztT30kZw3otXx02KUG4nG+UsV+eD1SaSp78173ALAQdQ5NGpU
 76BW0qW5/a/gtZlofk0QSRyS2cRMcUoYEppJLTh/NbhzPMz2dfQwXkkvQhtL6EbI2FEy
 NNQZQtTPyQbp4/+l/YfDd45zE98NAVOEkkeRtvsUEHcDxyLwmmJk879E1J9LCjFYnb2M
 yrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668080; x=1735272880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRQkBQzTRu7scLpRrqJFno9GLIyKwfRFAwGQsXfZPj8=;
 b=qn++3VmWYNJnqslpelQZexkPlEBj7yNBhY5zlXW1tSPsXDFa/WGj5xcx5+4+8QSWnN
 IY0/3nQGijuQdEQWSEYZXd0M7pkrZ8bmVhGINJNrkDUkxtmoO/5ch+xYUHqCkd+lZP9q
 MH2fMz+JvluLINjubymVthPwepely1OjZqcDe1SxjCu7sf7DcoGOP5Lcst99UeklQFIH
 F20yaV+/G3GOvJoXJMsNU58d53yXNIQJeSklWcA3OXe1afrUeYImhzYTzd9M8mpMvdBb
 OD78VxtNd3DdmtSwwxX5Cn3V4txaYzAPScgF5Lz13t1yss4/j+mKkm+l+CHJhg0LV7v5
 zEqQ==
X-Gm-Message-State: AOJu0YzzhTJIk8PD7BRb125xyrckUK16l+gr2qpMC9ZKDYsKz/h9KjwW
 nf/4KrnDLhaN4xFMFZOIscLSIq/z5fsb29gdVdg1a5v5PnPjNtP2HybSC8pLH0NWziMotk2/Stt
 s
X-Gm-Gg: ASbGncsQhRmrNyYFq3jyWHYvVbyWR3ciiw+mr8MFst2c/hLZWgQxTTPf4FUg3Id5eyn
 nWdFJFhssD3axGrnxkRx6PgkAq4eLshwBy64igKhAgoOiIRvwMO/HKa7Imy2ajyNUvqwfj5Lh33
 /jVLgsze2HoWh7UXl7vUlft7q1lwPR6uqQ3gnpatYyEI6ksHSdgeRwVQzfoxq7wuPGoebW4Qhcf
 pQTPNTsdIKaufgzCsHdRgirvvqG6Jjfi6fGPBOsnZVQUWP1qyOjZWNQbMlI5p4=
X-Google-Smtp-Source: AGHT+IEnGTU2K0VvmCJC9q8FhopKdmQClxxfXc3e7Uj6JFrB1EuLsitemCd+Zmj1S5ruSVokAnZ9hg==
X-Received: by 2002:a05:6a00:3286:b0:725:b201:2353 with SMTP id
 d2e1a72fcca58-72abdec8856mr1967427b3a.13.1734668080241; 
 Thu, 19 Dec 2024 20:14:40 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 46/51] tcg/optimize: Use fold_masks_zs in fold_xor
Date: Thu, 19 Dec 2024 20:10:58 -0800
Message-ID: <20241220041104.53105-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
Remove fold_masks as the function becomes unused.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0a84959f4c..6f81d2e831 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1096,11 +1096,6 @@ static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
     return fold_masks_zs(ctx, op, -1, s_mask);
 }
 
-static bool fold_masks(OptContext *ctx, TCGOp *op)
-{
-    return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
-}
-
 /*
  * An "affected" mask bit is 0 if and only if the result is identical
  * to the first input.  Thus if the entire mask is 0, the operation
@@ -2797,6 +2792,9 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
         fold_xi_to_x(ctx, op, 0) ||
@@ -2804,11 +2802,11 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    ctx->z_mask = arg_info(op->args[1])->z_mask
-                | arg_info(op->args[2])->z_mask;
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z_mask = t1->z_mask | t2->z_mask;
+    s_mask = t1->s_mask & t2->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


