Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86106E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9w-0002mk-Tn; Tue, 24 Dec 2024 15:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9m-0002je-JQ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9l-0002XI-4g
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:30 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216401de828so54800755ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070728; x=1735675528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6O0RsWWKqdEinIh2H96IW4WRMj9sIUVKDwhRVVNpMf0=;
 b=R0LncO7iqnfvdWdHnmBW90w4sao/4HqmR/WnRXAW4PGPLyQ1dr+W1Xnt5zF0/Nf0xX
 T0tOXsDl64IOo8Y8fyVrLpkHcjE9UjK8J29xgu0HMCsMxqYv3nrXDGkZ16U0Ef1Le//3
 lL/ArsTBsG+s4ysdLWO7tet4ZzRtre+2Z69zkYUCjgtnSp29iWF3quriHY8B/XpZhefT
 Z7MicNU2x4sHBFRfjl1YZ2y/qxZVMvgJ3Var9E5oXld+uqO+a+SSNU7y284pc04HWKrY
 MGhf3b4sPwXr/MVj7uMwRRX3h7G80dagX4n0jfIu2AQbSY1AyFDmepVJOL0mL70LfYvC
 7fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070728; x=1735675528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6O0RsWWKqdEinIh2H96IW4WRMj9sIUVKDwhRVVNpMf0=;
 b=gzbhG9apv8e/vk13WYpw/7NfuXwKsPNEVCLbgju14sS0BTSTe1Vc0iOKHk0aAOMMBZ
 uFqr3hEOaJtpMkHHKz6i55aNcOhVz/1qjsohwJQo7tIoMXPzoAOQdAe4kxzOx+lX1sSt
 nDGj0NM0yUjXd8b2z4io8LCIfI1hq9t3XaypDsk487+YqGmERktP04AbjoEuIpg13wv0
 B6qoLiPWvjMfN6K9qlgs55NoC5vqTQzz3n3TYWtdRH+7jXHzVsRPbB4APBaPw5zupCrM
 1l3ndRG4ezUBvvax2jSpF7f5eTYGj0WRuDC9wSBCQgGI0qqCu2k91yM2jAvKtqEyn72Y
 MugQ==
X-Gm-Message-State: AOJu0YwNob8apu0bZuJdiKukUoHLngCF3YgOMLUQxXtJW+ddpuVKYZpT
 vC8wsGczQfdgbwap09L95M2rPjTivQEEHTSNg/B36lYOUIwuAW02mmoKOSZdHiPcn3kRr78G0rJ
 mMsA=
X-Gm-Gg: ASbGncvBBrqqrNEGOw9cML0fR8LhyOC3td7d6YERT3MuNomY6zD4iNko29apWCzv2/X
 NZSj7QCI0J0+1jMlSWL+TYdasfURNnVD5GGATKjnsi/mnnITCxZL0xd/amo7CL2TmSPAmqhdaoa
 y4RL9qf9uGV+07ivGqThpx/LH5Os4bJM5c12CUr4yXVWNt0dO2X3Une4Batp4FVMW8W6Zm1uUcU
 C6X/u+FqEo2etk6o7xBWSf9HOgglwT3KUfRCgIKdTA84bDs1phhxYiLZI2CtWWYYFy4otsnkV+u
 SgAAoQ3tMMOBbgrsPbXkOxDOKw==
X-Google-Smtp-Source: AGHT+IGjqRyBI3PNaSVIgxXcJVAjXo4Bl73aj9e63UokeBhRzupOOOyhMy4X/kFHj62fXuIxXpQV+g==
X-Received: by 2002:a05:6a00:44c4:b0:725:e405:6df7 with SMTP id
 d2e1a72fcca58-72abdd7f683mr26519750b3a.10.1735070727737; 
 Tue, 24 Dec 2024 12:05:27 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/72] tcg/optimize: Split out fold_masks_zs
Date: Tue, 24 Dec 2024 12:04:15 -0800
Message-ID: <20241224200521.310066-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Add a routine to which masks can be passed directly, rather than
storing them into OptContext.  To be used in upcoming patches.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2aa57afd64..d70127b88d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1044,10 +1044,14 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
     return fold_const2(ctx, op);
 }
 
-static bool fold_masks(OptContext *ctx, TCGOp *op)
+/*
+ * Record "zero" and "sign" masks for the single output of @op.
+ * See TempOptInfo definition of z_mask and s_mask.
+ * If z_mask allows, fold the output to constant zero.
+ */
+static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
+                          uint64_t z_mask, uint64_t s_mask)
 {
-    uint64_t z_mask = ctx->z_mask;
-    uint64_t s_mask = ctx->s_mask;
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
     TempOptInfo *ti;
@@ -1080,6 +1084,11 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_masks(OptContext *ctx, TCGOp *op)
+{
+    return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
+}
+
 /*
  * An "affected" mask bit is 0 if and only if the result is identical
  * to the first input.  Thus if the entire mask is 0, the operation
-- 
2.43.0


