Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961BDD12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbH-0004UC-Pj; Tue, 05 Nov 2024 06:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbG-0004Td-62
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:54 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbA-00076M-A2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:53 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539fe76e802so6123715e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805585; x=1731410385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G3DkeEcruqixMHeVvkc/55DZL7+DSMMcCtNLajeMDec=;
 b=cn7tNfaB+GSUNWVy2JFVvlVp3JZRB4Rd/2UKoI4NaFD8yiQSaCwyg5fn6Kszk5kjDX
 fVuzG52F1qoAMyFwqyZjcsXE+m+3vZEit4gANqCyvjbNkW3y6xv+sEOm+ZeDBy6YbnkA
 5gPic+LwL3/0UK9NzeW37uAZRu2pIiEBbpya3Oh4RPLMYDnexpXMVxbw6h6U/qkVAGmA
 HC5uuAMTcinabL6VKtFMcxA3awXG0SBouZ9EY8MRo5Rw6HYpGP4NGYMEpeXwOtzBcVHN
 thFPEtEk52DY68Uj9PryIbFxA8ygDxYW9QiW6evZEtsWye6P4QrolEIXu2ayTqrf0YR8
 HK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805585; x=1731410385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3DkeEcruqixMHeVvkc/55DZL7+DSMMcCtNLajeMDec=;
 b=C7vdLfAKSzmlqeiSM4QsL9N4wwC41xGdRSSvRJp4TdS6Hu5msbvVJatU/sXtJUeAQs
 AAMajbxu5/m72bt7JgaIl+fNipmdYoNKqtfYj8gvPMky4NxnoOWQvEE//7Bl84eWgyf8
 UIjyCRxkV16omcauWw3fssrr1wd/PxfrJSGEZ/QdyApfEG90tHIbz6Yhvi+WnP7Fzyby
 WwJoARw7guaxO40ztxvlr6G/9z/Ezvq+HwUS5D+Ugcjw8u+N9JxEIyRGcDwt5qPiafoh
 zFg6y/ECbFI4kJmUMgw3w1qoNPDyx0fDollQbWQiI1c5qkdZ1sAUs3QYPvwv2cK1G41B
 0yJg==
X-Gm-Message-State: AOJu0YwccsjGqFud7MXenEhOZ9dhiq7BvVxit4Rm6eWxKw3u07Bafzva
 ahM+MoZaXZ6K20LJceQ0DIOCKMLn3/QkxYIui8xCODSRT5Z6xiqS8pDvCoo2JPTyuOArMZl1+7b
 l
X-Google-Smtp-Source: AGHT+IEMxBnt7b3NBxyUraRHoLqu0jbeA3FnOcPfcQj2w4ez5x2T3Fi/EIGa1sqHM9CH0RnnL1w0MA==
X-Received: by 2002:a05:6512:1150:b0:539:de0d:1e35 with SMTP id
 2adb3069b0e04-53d65dd0926mr7255780e87.1.1730805585337; 
 Tue, 05 Nov 2024 03:19:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/31] target/xtensa: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:18 +0000
Message-Id: <20241105111935.2747034-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

Set the NaN propagation rule explicitly in xtensa_use_first_nan().

(When we convert the softfloat pickNaNMulAdd routine to also
select a NaN propagation rule at runtime, we will be able to
remove the use_first_nan flag because the propagation rules
will handle everything.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-15-peter.maydell@linaro.org
---
 target/xtensa/fpu_helper.c     |  2 ++
 fpu/softfloat-specialize.c.inc | 12 +-----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 50a5efa65e2..f2d212d05df 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -60,6 +60,8 @@ static const struct {
 void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
 {
     set_use_first_nan(use_first, &env->fp_status);
+    set_float_2nan_prop_rule(use_first ? float_2nan_prop_ab : float_2nan_prop_ba,
+                             &env->fp_status);
 }
 
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8bc95187178..b050c5eb04a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -405,18 +405,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
-    || defined(TARGET_SPARC)
+    || defined(TARGET_SPARC) || defined(TARGET_XTENSA)
         g_assert_not_reached();
-#elif defined(TARGET_XTENSA)
-        /*
-         * Xtensa has two NaN propagation modes.
-         * Which one is active is controlled by float_status::use_first_nan.
-         */
-        if (status->use_first_nan) {
-            rule = float_2nan_prop_ab;
-        } else {
-            rule = float_2nan_prop_ba;
-        }
 #else
         rule = float_2nan_prop_x87;
 #endif
-- 
2.34.1


