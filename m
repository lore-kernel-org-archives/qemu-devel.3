Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D17EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAb-0003YZ-Kx; Tue, 24 Dec 2024 15:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAB-0002u2-KW
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:56 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAA-0002ck-00
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:55 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21680814d42so52214545ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070752; x=1735675552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gMoFC5QlvVuVHKNivgLi3juCNFsVMGqn8yIw/qWmEY=;
 b=u+nEM5zQyp0opjAYM8ZpROoLeYAc/0Z3y1x7BItmYEeBW/dpOBd2jmjz2p5GfdVF30
 7dkSFLMmFOndD6qzhOfvmiSddHd8Pt6umoQEPLj2LyI/wIUb0+dZbbQ+Q5AlsVVBiioL
 otTyToerjQcgB3ZmjBikYtJ23hNMDEp+3ybwTPS3lqKEUn5itXfQGwOp3g0zrowhkWwm
 dV+9pQ549U0qRZUTE7Yl/lZHXozxmIFTo0t1K8IjL3++ehqpRBoef66PI/MappFkAisI
 p9hGMIkaBtTvaoE66u4+2MqP/6qvuNkmQTWAMcOfSF1hyZRessa3redlVwDvtcbj0PJD
 XTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070752; x=1735675552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gMoFC5QlvVuVHKNivgLi3juCNFsVMGqn8yIw/qWmEY=;
 b=xU75hziDRj8LjCpjCZkM/V1bO0Xe+lHCklqffIi+LEAaC+0iFOvSCbbF281yV8KbQg
 0N1SfCvwXmUK/KtOxqpDFvJTF5C7r4O85W5V7wfUBuvuVy1RTWsVpvoev82VrlkU6uNM
 Dxu5LD8fNjVPjhbSqw9A06KwZEUE804EdIK37bEHHgfsOGbDb3sfArNbQLVce5iz7kpT
 KA02B1AU4WV0i6LbmqGGWKgIi+q4JZ926IgL/7bv4gRavWS77eJMw4JBFhgmUNnOwuJ1
 +OqcVOYynDZi+zC3F9zNdVbV41lO9jzcQk/dlMst1dla4YbiSfKTBrscNXEQmn8KO6YQ
 705A==
X-Gm-Message-State: AOJu0YxpyJrKdC9NkSq+TfEIUKEp34yRpmshq34Imhm7Dz4usURf8h/0
 Hefn+DH2wc/4dnAvPwlu2ncWNPN0ZadaspBBV8fmhD4eHstpc+Z4IC1MfIBNfVeNTRdQXLkUjh1
 HV10=
X-Gm-Gg: ASbGncukLmX8SjEzpMejrRPWC8R9zvVxMkPZ1bv755HzXPGepjJb0oAvq4dgv97AAWJ
 SP7DYykia/TYkYixSBcM0NzvB1hmLQzYrzhFaTHLHCCxW9O7DQURoW2+1ntLvT2DVZFZzgdSpXZ
 tpIbmU9SHgEi7QfkY128WX+tL6UsCasVKaRxWF3cB+WtHT7XoX1pLSqhG8l1jjMTrGG5RZFZFoC
 WWboYjJ1J7zauWXINrLVOhiUkaRBZYMfzkbjCy5Pp+R5PPIlws8faPlPE8ASPZwptDNIZMl2z/C
 TtuOyPRuNT6EjS0ZpiAWjslS6w==
X-Google-Smtp-Source: AGHT+IGw0QqIIjYouW1X4qwdatObDeb4KUQsYMFNgu8rCZ/FoHIbIKxzuJHwYlHk+Cvh4i2wcVt6uQ==
X-Received: by 2002:a05:6a00:ac2:b0:72a:ae66:3050 with SMTP id
 d2e1a72fcca58-72abde40466mr23461730b3a.1.1735070752542; 
 Tue, 24 Dec 2024 12:05:52 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 32/72] tcg/optimize: Use fold_masks_zs in fold_orc
Date: Tue, 24 Dec 2024 12:04:41 -0800
Message-ID: <20241224200521.310066-33-richard.henderson@linaro.org>
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e284d79fb1..81ed26a376 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2096,6 +2096,8 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -2103,9 +2105,9 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
-- 
2.43.0


