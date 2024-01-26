Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA58C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHQ-0002dI-5K; Fri, 26 Jan 2024 09:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHM-0002S9-FU
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:00 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHK-0007zN-PP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-339237092dcso435659f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279637; x=1706884437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cravlyBFi7JJgiMIcZjmEYHU7D0lxD+xDQlAtlvWf2Y=;
 b=q1rMAIpkyzvxt0CJ+Yt6GxYNtfNHrwXKzgwrX+zMjwsQWVQ18Xrf1E5NJNX6qqGGR/
 DDRuJdLXN6h6tscri4vOoD331KnjJg0U+NPSimYGp6wtl6zxFZ2C+wZ6uqKSWlEjJD2j
 27agOc6NxhH9xWL2Lu6Hby7lRQEd9cOTsoZJgSxF8PsGyB+34P80Ju6ee5tXL5gbnx/B
 uZGA11YSMquyCV94WUrLoLeHkSFZ1JaFwLwAokuXOJleasetZV+sRyrdGj/bfV5BkXCD
 NUILACNSkMFuUy1+fVrK6tescVqaOafF1bJNlfjEca8fYlEE5UWAyvPIFkGBir+cRG5l
 lmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279637; x=1706884437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cravlyBFi7JJgiMIcZjmEYHU7D0lxD+xDQlAtlvWf2Y=;
 b=ppvHRSc2zpR7xDP5jFGa9wSu99M4q/CDF5b2AE0mGn1IOvXafswZVwA4uHpNIGfBfQ
 nCTzlddeqcVx7vBwfiC61Z/YIarZxOpXWevZgtXqiPvmSQP3ykxySdZDzI5OBiaH4/OQ
 P/hq0SiiqN3LKynD3ggpwY4Gqy6Ta57ozUm+NgRteIMx3S5GQLa5snpJFEadXPwth/uK
 y3mjbMmz+8kqNCSQqBSS2/FH5ACLC0PfT9ratZxgaQr7cahm4Y5XJRJFSuUHEsPjRyfP
 6wTCUT+2ARFpa/8nZ+sKtkdZoB7eoF111PezKB/4GcOfWc7wT3mBTLGTqO4cOZ32+U2r
 pDtA==
X-Gm-Message-State: AOJu0YyPDbdsmTWA3NEJE4E7x2sP+9a/42HqIb+Kg96V31JwkJNDPv9F
 Wi50go25PEqT6pyn8sbRaR2b316ClAFvVGl62UsZcQMk0mKSmOkKjL3wfxqUbsjBOYF1iPq4qC6
 G
X-Google-Smtp-Source: AGHT+IEILqfnbZGBXlWy+slEhy6m0yFFQg4ZhwKklIfg1knI3hjrnn8+o6vxiwuXsW6YxovER/bN8w==
X-Received: by 2002:a5d:564a:0:b0:33a:9919:853a with SMTP id
 j10-20020a5d564a000000b0033a9919853amr1022036wrw.96.1706279637483; 
 Fri, 26 Jan 2024 06:33:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/36] target/arm: Fix A64 scalar SQSHRN and SQRSHRN
Date: Fri, 26 Jan 2024 14:33:38 +0000
Message-Id: <20240126143341.2101237-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In commit 1b7bc9b5c8bf374dd we changed handle_vec_simd_sqshrn() so
that instead of starting with a 0 value and depositing in each new
element from the narrowing operation, it instead started with the raw
result of the narrowing operation of the first element.

This is fine in the vector case, because the deposit operations for
the second and subsequent elements will always overwrite any higher
bits that might have been in the first element's result value in
tcg_rd.  However in the scalar case we only go through this loop
once.  The effect is that for a signed narrowing operation, if the
result is negative then we will now return a value where the bits
above the first element are incorrectly 1 (because the narrowfn
returns a sign-extended result, not one that is truncated to the
element size).

Fix this by using an extract operation to get exactly the correct
bits of the output of the narrowfn for element 1, instead of a
plain move.

Cc: qemu-stable@nongnu.org
Fixes: 1b7bc9b5c8bf374dd3 ("target/arm: Avoid tcg_const_ptr in handle_vec_simd_sqshrn")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2089
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240123153416.877308-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 27335e85407..340265beb05 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8343,7 +8343,7 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
         narrowfn(tcg_rd_narrowed, tcg_env, tcg_rd);
         tcg_gen_extu_i32_i64(tcg_rd, tcg_rd_narrowed);
         if (i == 0) {
-            tcg_gen_mov_i64(tcg_final, tcg_rd);
+            tcg_gen_extract_i64(tcg_final, tcg_rd, 0, esize);
         } else {
             tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esize);
         }
-- 
2.34.1


