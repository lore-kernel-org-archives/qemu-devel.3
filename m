Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4814DF9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4i-0005z4-QF; Wed, 22 Apr 2026 08:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4h-0005yO-DO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4f-0005Tn-Oe
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891f625344so37527795e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862379; x=1777467179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oy8aVZbZZZe1U+CUvOIDDEpwm1FnWydA8CkWhWsEzmU=;
 b=bxpmWuA9P9L0E0FlG86LzWZ+Yv8bQpXfTIk9eTlX/gWh7jFoHc1neq4oX0UNMcHCrZ
 gnO3wQ6SA0xY3Grubp+KDkFlJK3My3bDcw/5Sldnw4fSXg999hvIfZbl6vST/R0Oop/v
 Y+bWrlAxeC+2vtrv2z9ZGvh+ufRBH28WhKRCmfzeQovxetteDAZLsSRdGUZFNDBBeF5U
 +qXAGw5mDNoWo4LiXyawlexnBdNBvDoojyayQ670hxy4GzI7ZHb1nDs1+BdUUMw5c+NH
 J0RauHj5X6o9hk55thO0ZRIx4FogQeew6JwpqLPMB93yJakx1Oo9DzOdLnt2d7D0a+Ph
 Q3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862379; x=1777467179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oy8aVZbZZZe1U+CUvOIDDEpwm1FnWydA8CkWhWsEzmU=;
 b=gTogedxzIzZOvzNXq3iqyU+pbRwHZK1KWUtClDCyp44+wL8YFCZE2abzwftALDmbBV
 gayLSWgRgAJxemnfUT0sGigJXxpsgsyba/4TiOWERGv7TwSOWhFiPtHIZJfkeOfWEhi6
 Fn0PLCNe+rNuuoFAOQR5PrF39EgetZSquG7wYMHZHcxFuGxkdlnMwHoY8ann2/Xae2SR
 0+xlVEaiNzfAcTIkKRmzwhq0w8Fe910qlD8s5wyPGrgsjEH9WgB8d2AhQ7aicSbMCQXc
 4+Y5CbC21KABM+7fNZ0Yeq/PzebevbFzk6bCfAxLZ3RHcDR2xHdWktDESGYAOG5jpscz
 L8XQ==
X-Gm-Message-State: AOJu0YxZK/aqjf4QN/qHkvhe5JbEixkwkkY6iZ1mEgqYHofI+XrD299W
 6zfLMwfhmNQ3et0eDbuyl8AdRCJBCeh0me5kHfLibuM26JsDwNs4SvdbiU4SZyI/6vQ=
X-Gm-Gg: AeBDiesYPDWYrCCQyq/3l8N2W0t2yCOuKHJxWOyx3pPWayBCVeKqzYKo7CPdKyiWuNA
 GiSQTG0DZEctfGyLbEZYU+J6VsnoOBAyTU6klWZp5H4lqyP0aQKzUSTcCfuNT8GLZ9Y+ZgIDtcf
 nAd7DMqoDFiVQegqMbvWvTEOUHsXD7/nCUUDd8MsH0dnPxxV5Q5DYR/j7DWHwf6l8ORZr48lYiW
 SAPxypp5GxElf6aQFYplTyYwvZQBbkzqaBUXPE+VWd9euE8BnaNPRlNBMZ8z1fDw5H0DD1pblPH
 nkq9kC3SdzJLBkmfIFYgZLFCSMbQtx4CEUfz+VnfSL1I94IPdeEN6EayCjOrtDiWaiz0bR3Vr9S
 CL31er6AnC76wnxHQ0+h+fIHuhjRDheX40ehyRGFDkOnWIvuY30nTMss86yKiIkgamjtNJwjVR4
 zjQBKUNVYNFku3YA8x8SGJvOZaMDMxP6t95w==
X-Received: by 2002:a05:600c:2288:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-488fb881ee2mr212647635e9.1.1776862379208; 
 Wed, 22 Apr 2026 05:52:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a071sm10434897f8f.21.2026.04.22.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E154060F2B;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 12/32] target/arm: migrate wfx syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:29 +0100
Message-ID: <20260422125250.1303100-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This will help later when we expand the fields we report.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 2ad6b97aea5..65d0de63a83 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -655,11 +655,25 @@ static inline uint32_t syn_breakpoint(int same_el)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a WF* instruction
+ */
+FIELD(WFX_ISS, TI, 0, 2)
+FIELD(WFX_ISS, RV, 2, 1)
+FIELD(WFX_ISS, RN, 5, 5)
+FIELD(WFX_ISS, COND, 20, 4)
+FIELD(WFX_ISS, CV, 24, 1)
+
 static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
-    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
-           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
-           (cv << 24) | (cond << 20) | ti;
+    uint32_t res = syn_set_ec(0, EC_WFX_TRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, WFX_ISS, CV, cv);
+    res = FIELD_DP32(res, WFX_ISS, COND, cond);
+    res = FIELD_DP32(res, WFX_ISS, TI, ti);
+
+    return res;
 }
 
 static inline uint32_t syn_illegalstate(void)
-- 
2.47.3


