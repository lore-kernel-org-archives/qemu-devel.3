Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0B0D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6IO-0004ka-0J; Mon, 02 Dec 2024 08:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6G0-0001p7-MG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Fs-0003Df-Hc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349fb56260so36520205e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145252; x=1733750052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8XgmjddIhM612jj3JENDu5XxtMOP1j+6PXpvtg3rDM=;
 b=uoX88bBcq9kEFizw5H8wDZ6CehpaAS3bTR+Lht6sps3Rt6IDxBkdL3l544fcK+hpKu
 e/k6UlhfNe1zlEHryRoweUclPn1CxVPezbi7QlCJUjEtml9VzkZtg0LSzKu7/CyBs16b
 52J6V0/XS8tMlnczkQWuHW4NiaDuSuYr4o3unpHMxh8FP8x8fmKRLVrJKA0aI0VKiEQg
 BxPJNsNXHtNkzPhhz9JrdpQXPQxd6COvTvn7CTEVB3D1AtduK4eZI9YgaTUfSoXj2Ifw
 w+MFrV3BVHaRdwyYPMWT94WZk8PIydcdQZI4Uq17ceAlORbFWgbwIk8uasknKFpiW/K+
 23jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145252; x=1733750052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8XgmjddIhM612jj3JENDu5XxtMOP1j+6PXpvtg3rDM=;
 b=ZCQSOGSnc7YGXLd7DW3OqNLiOeYI8Npn9rGqmlTLs/2ehTXpjLcj0qdoavjt26mIaa
 1BEyr4ERidzC8m0BHzCMnq5WJwqUem7lIQbyqZeIW7fIkVfa6G/NIvxT8l1UWTnVDNDY
 eChFWrX1mWpWe9/JpWj+XTwO6Q2oyFx5JXkhSXd0HjkpwCoG0CIXjj91f2uLNWR/3qYU
 wIEHKTCkXZywzWYx9GUWk9pP4xtxbL82Cdd0vQzTqhqlRVXe6wwFc7RlCN2GaOjTbGP6
 Pl9OShs6DETh03GHFZIcRi5qQJ6sdLF362b7FcZlBGi4YkbdQtR2zqbKqjIO1igLojKY
 S5QA==
X-Gm-Message-State: AOJu0Yyt5P8NgvkGS/x/6GBOdy2fFpNbzV8+xxfr8MTldicvkRwpK2BM
 WAJ28AGdnHxhQax6OeJINVaDnXHMEiHzQmftXs+rl6Z1JdQGDG2H56PqQjgmrXi4bPHelpQJq9q
 U
X-Gm-Gg: ASbGnctZBFD6hovNpLrGwLFJh45ctA7+CxpDqJLEw7kmwuS0viDAPfd7ANsOX12WFHK
 EiLxt0VPvCzBJ37QeIFnNk7YtUDz7CpnhQ3HkjOM1nh1ZDeZexdHnkMvKzh6nfYcCh9oKAk0iuR
 Q+neuU/Qf4gA2hLN990Aatt+3Gky+ZkhrawlDCUQixUb/fV+f44CX6RMHQxZGU2d8tnncDibLpB
 U5TPLmjAtq29rjcZFv2DcOla/BzlW6cuVCt1cy5uxbUorZZYOZN9Ps=
X-Google-Smtp-Source: AGHT+IFGAqP9oBoobvwRTVsxyHV68P3Uq4eNLluzGyHDJ84r6ieo+CCHSPp2emlfRlyYJlsQ5T8PFA==
X-Received: by 2002:a05:6000:1fac:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-385c6ebaecbmr21012001f8f.35.1733145252416; 
 Mon, 02 Dec 2024 05:14:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 13/54] target/hppa: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:06 +0000
Message-Id: <20241202131347.498124-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Set the FloatInfZeroNaNRule explicitly for the HPPA target,
so we can remove the ifdef from pickNaNMulAdd().

As this is the last target to be converted to explicitly setting
the rule, we can remove the fallback code in pickNaNMulAdd()
entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/fpu_helper.c       |  2 ++
 fpu/softfloat-specialize.c.inc | 13 +------------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 0e44074ba82..393cae33bf9 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -55,6 +55,8 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
      * HPPA does note implement a CPU reset method at all...
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /* For inf * 0 + NaN, return the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 05dec2fcb4c..3e4ec938b25 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,8 +475,6 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
-    FloatInfZeroNaNRule rule = status->float_infzeronan_rule;
-
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
@@ -485,21 +483,12 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      */
     assert(!status->default_nan_mode);
 
-    if (rule == float_infzeronan_none) {
-        /*
-         * Temporarily fall back to ifdef ladder
-         */
-#if defined(TARGET_HPPA)
-        rule = float_infzeronan_dnan_never;
-#endif
-    }
-
     if (infzero) {
         /*
          * Inf * 0 + NaN -- some implementations return the default NaN here,
          * and some return the input NaN.
          */
-        switch (rule) {
+        switch (status->float_infzeronan_rule) {
         case float_infzeronan_dnan_never:
             return 2;
         case float_infzeronan_dnan_always:
-- 
2.34.1


