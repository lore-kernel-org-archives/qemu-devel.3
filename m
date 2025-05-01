Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815A4C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLp-0005pX-9S; Thu, 01 May 2025 02:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLN-0005Hw-4N
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0007Jz-O0
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736a72220edso790002b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080651; x=1746685451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpKaNGqfmwNtM4gHQeVcm0rmbF9SUIpTKwfANCDu8Fc=;
 b=eMX6I01dUHbHRG9btXbU6ozrIef4qlmcyPjdVk3fWPHwOixxTvPRRszTIFfSl0as3+
 LezM57cF6/MyIcp4U4W/GY3MvXzgrFd8AyHg59+svQwCpc5Q1Bb4pXSqGKTFfzVGZmPR
 smq/nBxDgy+hi/keyyjzruBME1TEEMtxGZxQ6/hdpxDuD3KozbuLvCs23F1TFmq6er+2
 CJr+RQgA08/IeV2gKzSdR8sqANlpzVnKyA74CCfeFmHZAHiGBx/T/mpylxrpCeh4FhF5
 W/t4cVD8fHGm7dFYiubmO/cvTMo3ybKRIf8cjtQtw3XVzYrJX6Mat3Ic4UJEnRk919l3
 AH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080651; x=1746685451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpKaNGqfmwNtM4gHQeVcm0rmbF9SUIpTKwfANCDu8Fc=;
 b=BTXVVJklw7hbH52TfIE9Q5oOVioim3lqHOiMEVprObMaDc1Ap2MrPAott42HmE23fd
 TLCg6gvF7Rtsldihan1xypTxFFQaW8xtUtyvFreZ3mWmgyItj/pWKtb/b+z9Aqv3VExj
 qpNcwTPB22qef4w1NZZ/kwFJDSsWom20AcWbOoMKivF+qQjjizE16pPU5XvnVrZjsU9C
 Wmr8R9bsn2vSfWFPTj8Csve2gG8i8chK23xjxnE3fk1Xocya/j69eJe2RFtT+mbPF03O
 Ew5r8mrd3gKvBjcMW1gPx5ZnC7lNxm9YdmakDIK7l9HeqqyPkgZa3Yp2KEvxeGUL01CK
 fgxw==
X-Gm-Message-State: AOJu0YzhAz8UM1hr32foZPLwyv13jSPkpGj9a3oJT7C29Wb65Sjc9BIU
 O1GOm5Ma4zV1xUj1FHunQph+K2sAhXZPd0xY4SV8D+rDrE3H7wjLwXq7NutICnBib00gE9aAQvi
 N
X-Gm-Gg: ASbGncvpyIoBWyQWu3ZoY+kcapsLMwzsynhhH8tkMC3OISMhEZX7G5GJ14jGI7hmFUV
 ox7pUagATrvbE2mqgZ2O4MKR0SBmWSym++jfxmShWJlWRYusYKSxmNJeNgLKnFdOPsffeIw7iaG
 kxJKR1G/kzelUFFGu7rziBIOacQYC+OsV2iiSm4hezOK6n3ZbtMEIHS5+U/zUYumwpo+3cHUI2D
 BDnLbJgU2bi81wca01pMkmTCdrm2AFw/QMqag1qqQmKC1CwDjH3y4+46/tu2PpAxKlA5NLUsNYY
 DjV2e0fVTWImooTRV12EgEOkqZsZ5MlLT+62PxjV
X-Google-Smtp-Source: AGHT+IHWmZFe0mwWyFeKYCiS49H1f5jxhNRdExacq+/xBeP9espa19f6AzO9WL3BuOcAYk+W5kolRA==
X-Received: by 2002:a05:6a00:84e:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-740477a3268mr2817241b3a.12.1746080651095; 
 Wed, 30 Apr 2025 23:24:11 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 22/33] target/arm/helper: remove remaining TARGET_AARCH64
Date: Wed, 30 Apr 2025 23:23:33 -0700
Message-ID: <20250501062344.2526061-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

They were hiding aarch64_sve_narrow_vq and aarch64_sve_change_el, which
we can expose safely.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1db40caec38..1dd9035f47e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,9 +6566,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
 
@@ -10645,9 +10643,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
-#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
-#endif
     }
 
     if (cur_el < new_el) {
@@ -11552,7 +11548,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
     *cs_base = flags.flags2;
 }
 
-#ifdef TARGET_AARCH64
 /*
  * The manual says that when SVE is enabled and VQ is widened the
  * implementation is allowed to zero the previously inaccessible
@@ -11664,12 +11659,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
-#endif
 
 #ifndef CONFIG_USER_ONLY
 ARMSecuritySpace arm_security_space(CPUARMState *env)
-- 
2.47.2


