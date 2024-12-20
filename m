Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A611E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMS-0008UC-LD; Thu, 19 Dec 2024 23:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMG-0008Q4-Hs
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:26 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUME-0006LX-S7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:24 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7feb6871730so964103a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667881; x=1735272681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+Y+Gl05V5R9wO/k+rBUGjrtuN3gf4BK1vVOJZqpHsQ=;
 b=qJbAnaNYEx7xkAyd8YS5D8HzA99DH5FPjCz8+5qBMNIZsSVyZi2Hq1KmyNkHj6VljX
 3fmmSRMBlYrcd3WSWAry4XZDRHGDu2BOnW73lCTeIqqTy/Yjb7WCMVgkc0G3RY8cr9uH
 vwA6BMkTwSc8oljBVZeCFyf2yJxV+wDNmRRVvXQJC/cB2b4YmZ/UIHZ0wJBuGK/TBwfE
 fF76to/k63N8qpgN/SrZQRWmZZ2mMYVEsxPN6T8GUQL5mL8NmH0eFNtwlBNcgGdH/9ZN
 5nF8mYWJX0JhnS29O+l7al+qg1uJzCh83iJ36QVljyVqf/UdAYljeByJ3FGE9w0GST5G
 rLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667881; x=1735272681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+Y+Gl05V5R9wO/k+rBUGjrtuN3gf4BK1vVOJZqpHsQ=;
 b=Q66kyOoBbDB8ijKHwHVEqOdA/90BD3r9bcKdtpUCb7xP8AmS5VrjpgUnJ/4PZ2PY7m
 5mluDWiwtpHud6OoyXw6v8Cp9wwANl1YJJcvKBQnFr9m3ttwBouAP5wm7BX6xz09UM4S
 KyTunFV42cyGTHSLiBCrF73pdvs9KqFWYeVA8NUWJQtaCJAM3vmf52CaU4IxRJVmAooC
 yuJ0ZDFSQIBM/WqCl+7k2+iHtiFOfB/g6J5oyL2NlLHwXCWBoJLNgJIbbwJTmBafXY53
 +bYB4Y3bnHc/deBRr3alJSY0CcfOKN1JJExj37IXGt7fnK6iLEtu4XWQgEKwoHgFIBli
 eFag==
X-Gm-Message-State: AOJu0YyvsSaZWNogo/i6ZEMAsPA2aDRKDZRG8Z3qMnHWTFh1oMCV2mTC
 O9ai4GxIq3Y6njisoWu1gMaSIm+1OV/EQ1khya7c8kLef4lYQfyD8WSeEvH+y62ypnFNCowdkju
 y
X-Gm-Gg: ASbGncsquK6KQda9p4/nqhZxYmzUXrhtJWd/Jf6R1eWVvrcKZ0YmoHPaNu032Dr5L/m
 fkDWMcGZKtrGagHAi849x+EmS+krtLDN2fNUz6P/Q28q/W8lLSMRjaOnVS0Az/jKKwSWhtekd6j
 Vs5Crh9S9Fay1GWIiV28AEWLFmtQk+hF3mz5yAysqYC4zQG5CF0UqNXle4nKkhqJCcHyGph0X2b
 V0lRmz8B3VzzdFNHPpde9H0p7ztFV5iJfS7nr2Q/3+3jOn70xvKNIIHaUX6gNM=
X-Google-Smtp-Source: AGHT+IFvQFTrhIllXQxSHElY+PhL6g9fQdjsArZSQW7pvCxFZIgsX7XP2t0tFIqjDcaNFxD/5rJdpQ==
X-Received: by 2002:a17:90b:54c6:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2f452e22c43mr2788986a91.12.1734667881629; 
 Thu, 19 Dec 2024 20:11:21 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 23/51] tcg/optimize: Use fold_masks_s in fold_nand
Date: Thu, 19 Dec 2024 20:10:35 -0800
Message-ID: <20241220041104.53105-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5b71a98cc7..c206c0f40d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2045,14 +2045,16 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, -1)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
-- 
2.43.0


