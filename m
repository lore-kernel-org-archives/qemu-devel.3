Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A58E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDa-00073O-6Y; Tue, 24 Dec 2024 15:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDM-00063Q-1J
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:12 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDK-0002wA-BY
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:11 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216281bc30fso65762265ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070948; x=1735675748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o97JXDzIrwrMdvgcbM1yV2U/pc+QtaOODWU42ZGI8Z4=;
 b=X1pJnsc9MweBqFLdkApwORk3nA64ycsiEmkDIbBjiLN8gsD9uQHta5UhVazs2iZhc3
 DHmo3haQqmEdT9e1WKSCn/cuiDmG+r27owRSp/8ZoHRRYpv9+/V4aOT2EtFP9E9kZqk4
 QArJJMR/kgoz78lteyXTyiepdDsZY4uYwkG3aOllO5wZQvr33kmAIKpjqXKnZcx37TQm
 fkuYsybDJVkYturOqRpQMkTqzCEaj6zzjBU+ugWp9j0SWnc5JIqZZbqSFT8Vq6Cdf5yO
 YhTZJd3IRNXv7WuBrITo8u/KlwX5z83PS5VjsatC0i09Bj2AaZLRaH3AxOMX164q2AT1
 m1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070948; x=1735675748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o97JXDzIrwrMdvgcbM1yV2U/pc+QtaOODWU42ZGI8Z4=;
 b=avdvZI6ND1LBpW0N9F0CCAf2zX9Rt/E+80zfcYUIVCa8IVjAFtDanB4iGC5SVDm66R
 UoJ4FxZl6+dZo02bNDMWNlsaxpfNeq3hKKyS045ZxNGYJ92UNWWo3Gyzec8QMPJRlca0
 dShqEIEheAz2y8UHNLcBiFcBIwA41jDu1f3z5kZthZAaUSuE03FvBAnV41UsPC0S84G0
 YnKQC8o8aSODqWCIWvCGh/I8BhhcJdCMA/5XcBD8c/BZUExe8sjxvSiRgvWBL92/3CJq
 bYes/bH+1ht9+Va4ZYi1YU3EQUCGwQ7dHc5bmwBQk81685bzJgJLd8xFjM4sPvpYE2f4
 L82Q==
X-Gm-Message-State: AOJu0YxWCt7CoUl/66Dk+9iXgWrGOwvNHY9qokNQnAJhCC+Eicks79uw
 7aYaXWQchanmJ5Xir5w0Y3eZLyTSelgi0H9wF1xonsVUWYFRwnkRivZT4SV77D3Iq2kiaUhXK/B
 Hv2E=
X-Gm-Gg: ASbGncvEhSJ3VOv/fMTB/Aoti+2ti46674SauEGWAuPOV6GTKH9rpbhUV2UQVVAIccf
 dqBcfIOwBS5xqfRXGSpyP3WpWPSvrIBD59ZSnlaq3hII930D1cTd/Cv391RZina0NJgtznfg7EA
 NSV58k2EzF2Vl3wKgWS7Vj/gDwLucyvZ7rHY7es4kr61dwkKmy0RN0yjecz3eB5JV0xiQnCMpb6
 0cZs3TJZW4EjfrzRlXXnoxPbn11eCVnmB4yGRmkz9L1H9+TvAVsLnVGxKkha0BfqeTM9zj1zA+4
 YH6KRXvgXBkhlEh08TSsWp8fxQ==
X-Google-Smtp-Source: AGHT+IGgDFMjTqHTRGd1f7T9w9Lf7XJr0owOzZitubGmOivmttyb4YuzdB+QrrhNaU+xifIgbKYpXQ==
X-Received: by 2002:a05:6a20:1596:b0:1db:e0d7:675c with SMTP id
 adf61e73a8af0-1e5e045a0b9mr30625360637.13.1735070948607; 
 Tue, 24 Dec 2024 12:09:08 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 48/72] tcg/optimize: Use fold_masks_zs in fold_xor
Date: Tue, 24 Dec 2024 12:04:57 -0800
Message-ID: <20241224200521.310066-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index 047cb5a1ee..d543266b8d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1077,11 +1077,6 @@ static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
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
@@ -2769,6 +2764,9 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
         fold_xi_to_x(ctx, op, 0) ||
@@ -2776,11 +2774,11 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
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


