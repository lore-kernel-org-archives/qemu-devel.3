Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEAECD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2Y3-0001WF-D9; Thu, 21 May 2026 08:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ2Wi-0000y8-4x
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:29:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ2Wg-0001dK-Ew
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:29:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4903d5c67bfso1419905e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779366561; x=1779971361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pryi5TKCDpB8CFidgAdyXB10hiTus4CQlxwL4fbFbdo=;
 b=wNBbZy6UK44dmLcQnDZxIHTNJ4Q+eyhVdOLwGiatWNjmijH5MnylNFcJc8g1oa9eR2
 4+30eg+od6xtCcfY1kMRk0+4AMguvLNM2dV5gg+K9+vTRajCxHa43qoSSa2u7HSaWog/
 Jia1YoXOF7xT8+kCo2dQREI4Cyktg46nscfY519MDuUdXdXErHMGd1f/ZdTVxHzeja9+
 iqbnxgzk3bKCkWZDzAwL1RjI9GZE5FvkEVYzKAsGMT/xL9ZYBbwZpRfRgnSFT7XsTPaV
 ZhJQj7u9HIkSt0CYHZXw+7iN86JpxzLKjEYOafCn4umT2IL5QOAScd4RnzCGmreB4Ihj
 2oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779366561; x=1779971361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pryi5TKCDpB8CFidgAdyXB10hiTus4CQlxwL4fbFbdo=;
 b=acM7Jr1bGQMcjnPrF9r0D5NTK5wANX5YK8kZt1Ftc+pgv5aDzNrwC5ZyerJdT33YF+
 flBlvIg4wc0UoTPoODQenuz/QBzHFuQ8cZpt8nPapzRysulbSREf4cX052wSJRLqIAjD
 Q6q9dIMReueZAbavTtk+Ji7zHiuz95gAw/k24A/Q/VepJ6BY8VpQlYxAnzpihi0vUnpv
 dpl9Q7MdWmRUcWyHGLVItcLz6+ECrzq6vpYSa6sqsH76PHW/JIKANvnGh7QZPgd6i+81
 hfG/tX31ciCiXxMv1opYKdkZdIDpGptqNE/qJnZiaTFvOfYaRojCtiYS4apDq7+SG1Cq
 Yv/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RIYNkW7iGSfHgnYPAKqBvhS+sB2YIeOvKGI5TXylUt1sbQJAKEujmtV85bpJ9LTaMkRU7ASs8Xwom@nongnu.org
X-Gm-Message-State: AOJu0YynzDEGQxv/0RrCBZDsYJAGkqBnJ6b/x5hnxz2IemlOKMky4A85
 L8YOgNH7ciXPr09rklj2vIVZbuGTNYBbxYnfQr5gBgBtX/8WVqArqYM3NR8T40s2YP8=
X-Gm-Gg: Acq92OGS4oBRoLkcZeWGGijkmHS5X0TQhj0eGyI9X5pebaZMWAiM7Uh94OFVKhUconG
 V+VUIL6lKGeRQsLTB8uuiyOH61xz5LnE1mnP5tue13dqTTeo8ujuVI+bMbya6EqQ1k9xGNABQGK
 J4zu6f1wcHbNQLt0haPEC3xZ0cT5B3llR6kZm9l7Rqgde7/srkRgaqqsf2Snb0xnWLT4KXNiXub
 9iJG/GEhlegzR9mUWRuH999ZRMlOY1EqZTRKNpCCMzdE4sTduxG7Pk9zbrfN2rEYoG+lEwkMX8y
 UDYyYEjYNK7EjeY2Sv4JLZpZVc3pmuAnzVE300MriTHdYi6mOunC2cr/HVMMRVV3OyLHFjtSnJL
 CpTlBF3djr4HnYbUUiuXpAihefad90VWKfj4niPtWFFiZg06Ap4WNk5JaWVDZp+FYKCscJsG4uU
 J6XMG54cWIg8uhnFDKg59pVTRuuJpbJuYvo/VJ6pHYAxBeN27nkbYi4656Jfawa1FGDi7cdsJcI
 fFv5FnekozJewMDH4yQAXgb9pbmNvR+hFxQyvzUDQ==
X-Received: by 2002:a05:600c:1f89:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-49036080e18mr36554365e9.12.1779366560954; 
 Thu, 21 May 2026 05:29:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c72c78sm22054245e9.3.2026.05.21.05.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:29:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 3/3] target/arm: Set correct fp flags for FLOGB when FPCR.AH =
 1
Date: Thu, 21 May 2026 13:29:13 +0100
Message-ID: <20260521122913.1565011-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521122913.1565011-1-peter.maydell@linaro.org>
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Our implementation of the FLOGB insn does the operations entirely
in the helper function, without needing to use fpu functions.
This means it needs to handle all the fp status flags itself.
We aren't setting float_flag_input_denormal_used when we
use (i.e. do not flush to zero) an input denormal, which means
that FPCR.IDC isn't set when it should be for FPCR.AH=1.
We missed this when we added float_flag_input_denormal_used
and made the fpu/ code set it.

Add the missing float_raise().

Cc: qemu-stable@nongnu.org
Fixes: d38a57a3f ("target/arm: Enable FEAT_AFP for '-cpu max'")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 179cbd74fb..d884ba474f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5036,6 +5036,7 @@ static int16_t do_float16_logb_as_int(float16 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -15 - clz32(frac);
             }
             /* flush to zero */
@@ -5064,6 +5065,7 @@ static int32_t do_float32_logb_as_int(float32 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -127 - clz32(frac);
             }
             /* flush to zero */
@@ -5092,6 +5094,7 @@ static int64_t do_float64_logb_as_int(float64 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -1023 - clz64(frac);
             }
             /* flush to zero */
-- 
2.43.0


