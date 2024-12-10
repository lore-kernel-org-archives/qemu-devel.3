Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647E7E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL260-0004EV-PV; Tue, 10 Dec 2024 10:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25y-0004Dt-Mk
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:18 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25x-0008JO-5O
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:18 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb7934a948so173422b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844256; x=1734449056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lgQ/ULVZFjj6+VNKWnPAdQtqhmA1FRoKCyM4IRm+CCM=;
 b=Qhg6f8irf4BE345L/4Ib7wgA4bYiBrwrfuhKsMrmOUs3JC7gyWeki7w1Ns+v3wxz5L
 b3MNiMgVO10LzDEM+vk90N/4eOtG/GOZCGeeamn5bf9uWRW61lHE/6YRIPdVC8XKe6EW
 2MCtLujLWrp+bjtQwsRaj5LgNo+Z9NZ/waq3gzFeh/W+ECSKlPpxuuaHz0Ir2rU/FHMS
 N7fWXx+MgwMOUF62NOWu88gZrGPHWAPj6IvEg47wQox41LbrHnuVX+jLeCpq81aTt7Ax
 C7T5XvwuTlx6uLgKNC8MwzchZsUIeNXoxkjtyEoY2ABy1MJaSUmdfhovuJdCZyoHclq5
 nzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844256; x=1734449056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgQ/ULVZFjj6+VNKWnPAdQtqhmA1FRoKCyM4IRm+CCM=;
 b=NbQ4dI19uvFGu1wW/QkGX0Z0FI0u3WW219coEyg+ZfkeK6PHwOuoVShCHR7VG2ciAo
 v1lfspKgtNDOevAUZ7Zxtd7ZGgQy6ucHAntekMildQewn+hlm91N+67pEeUSFNR9QLfm
 uO0LlNFAS1oNLSoW879Yy+PnfZVZ/kuF1cUoM95O+1voIUnc8b6dEACiFiRI0b8Z10FQ
 MZr+T1CeY4UmYPI6eE6MKAQUq9Sx4gK8kn/VpNSMJdcpMNBFifdBeupLweAg9ZYz7HD1
 5wcjgIT50Fvo7fEAw1MLBLZ2vatPssP0PF9Eeq4m/Puk3CqsQz9DccFJw/g2XTfoJYvL
 w2wQ==
X-Gm-Message-State: AOJu0YzEkpUAJKi37gwrN9kjGZ+PFol71MTnX4iOJ0JychLxTLwUewOK
 zzc7rRuOjdpFSOHK+K+OD0Vf2qkWi0Oj3FYOO7OrThP6lFiD/LGShebKpv8jzwbyTLSKxCB8TI9
 kKH3dnHdt
X-Gm-Gg: ASbGncs4hKukS2Jk3RktkIsB8Z+JjU6NwSY/0wXr8Nq4a0CMOI0bx8/ziL6r3xnXqCB
 IzOralO/FXztnPwkdv0nZN74IAXKefYZqUfmmc6Copfr2TWKXHj13942Ay6eiz7tQ4lDET4AW3I
 JPvcvbl9AxaL7O4Lny5mFzmY0s9LrD01IihiZHbncQ1+RRuwApXxdMHfglCcqdxZ55UfFAALowJ
 c8yFS8Zuws7u1D+k98Ccm1FaizdLwv9R3djy45NF3Tvl498fd1aGAodXpTHyA==
X-Google-Smtp-Source: AGHT+IGkTm+iUqR5v/Pwy6Xt+XyZeypJ5h860PPi7zvm3YPWbjAIQA5SoUKs/ErZfHouyjwLwYMGGw==
X-Received: by 2002:a05:6808:10d0:b0:3eb:6af4:e644 with SMTP id
 5614622812f47-3eb6af56c9fmr2522077b6e.16.1733844256092; 
 Tue, 10 Dec 2024 07:24:16 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/46] tcg/optimize: Use fold_masks_zsa in fold_and
Date: Tue, 10 Dec 2024 09:23:21 -0600
Message-ID: <20241210152401.1823648-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

Avoid the use of the OptContext slots.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 135b14974f..000ac0f810 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1306,7 +1306,7 @@ static bool fold_add2(OptContext *ctx, TCGOp *op)
 
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1, z2;
+    uint64_t z1, z2, z_mask, s_mask, a_mask = -1;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_i(ctx, op, 0) ||
@@ -1317,24 +1317,24 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
     z1 = arg_info(op->args[1])->z_mask;
     z2 = arg_info(op->args[2])->z_mask;
-    ctx->z_mask = z1 & z2;
+    z_mask = z1 & z2;
 
     /*
      * Sign repetitions are perforce all identical, whether they are 1 or 0.
      * Bitwise operations preserve the relative quantity of the repetitions.
      */
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
 
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer affected bits from it.
      */
     if (arg_is_const(op->args[2])) {
-        ctx->a_mask = z1 & ~z2;
+        a_mask = z1 & ~z2;
     }
 
-    return fold_masks(ctx, op);
+    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


