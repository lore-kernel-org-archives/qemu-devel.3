Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9943C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLd-0005WD-Fs; Thu, 01 May 2025 02:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0005ET-ST
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:22 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLB-0007Is-0D
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso874802b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080650; x=1746685450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIzywu3ug9p30W5eG0L2N1zxQEyM7lznNJHWjTnjaTM=;
 b=Rd9g0kj/4vfJxPQIwcs5enCn+eQwxyNumeNun7QeXg0FvAV/CmKIPu1/i0Ffzqgbu1
 ckyt7MozeqW/sDrO1GDuBK9xsK7VsIXGGkKYMfcf+HY6j3dgA8EAgopEayMsHKkLsOGt
 SxNntrGXMlvRBeqUQrGo06q62CTkeOqhshCdRYsho3qsjKJcJjg4N6fazHmWsrDxaJxz
 78HbylBfxt6NGenkwoJ86PhaW0MP/f0SSoWN4CPrdYm8MSsBdkSSMFrYGyx7gOkrU+1H
 cJKjKq2oo1X7O+FjJxO6xojWXehXuPO0i2BaI3cu7l9Hw4TttqIy0lBfs0NOPjHMH30X
 0jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080650; x=1746685450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIzywu3ug9p30W5eG0L2N1zxQEyM7lznNJHWjTnjaTM=;
 b=gaLhstXxb8b7yu2aQ5A7WjNMmZjwX1uolj8g/ZEzN/CzvA9rhJPFVy3k0VRRTQHElH
 5rtfhq2DZawrG6Axg0PeuYKY46cCDJygCMWuVOmEOqlOomJ8F0tBmdHVQtjidCdRKRdP
 7PaXoxaWLZiUqtmSJSfxMgPIcmytkn3aBsZWbTkImT1bqmndTCwfFpCNvMSrH6znpP6s
 W57YUHD0tQ9HiQZgk+FZHRh9Y8UZmU34NKneUgxgZryGXci2OoFGM4ksHOomGgCEr6Eh
 qWdwhwOkNYMPmn2mSloy6b1CPwRBQcvo9MHmTAeHLekWTlNmF9J02jVtugxp2wEYXap3
 /CTA==
X-Gm-Message-State: AOJu0YwMkIwxra5eYxptgTodVTvsb8qdWIsnVnMWHi0jrqB7ubQG6c2E
 REe12bwCGF6rXUZez4bvvvx3mmQjaerFRNjqPluv8sQViAyMuymOghbtM+R2azgaxhJhkr8uxWk
 n
X-Gm-Gg: ASbGncthP6IP6KG+9qtE6kFSwG2K++ukoM+T93oP6sY0MvKk8tALQrPFA1ZxDg2os9N
 u5oiqAIZLZHOtsXXEcdhhHZKAYRbXnKt0IMge2Rybww/Wtxo2mK6B2rIN3g1uM+kJtSLgUqEKXX
 t8n7x5jlUxwmT37734caIE46wATBBE+FV45feOnW++xmMUwRIRpCnYtqPREuqPOPM3Hl0co3lKv
 dT8PttpDOaT8ybGlKHINo9uGnzL6V5oQz12YIxV3s4GGyyPa4prxNrQVI4Y7bV+XtX5miET3gOs
 aeiMuzXkEMIDFM7pWVVJ0x7y6wSasgoGtBcDSE/D
X-Google-Smtp-Source: AGHT+IGQmTrN7AnDEHnrZ7Y8mTNrNLs1cJ9kxtU929N6mekWZpSbZF3PYXiv0EdYTWvD2uSXI9SPsg==
X-Received: by 2002:a05:6a00:3e1d:b0:730:97a6:f04 with SMTP id
 d2e1a72fcca58-7404777ec84mr2994181b3a.7.1746080650223; 
 Wed, 30 Apr 2025 23:24:10 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 21/33] target/arm/helper: expose aarch64 cpu registration
Date: Wed, 30 Apr 2025 23:23:32 -0700
Message-ID: <20250501062344.2526061-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

associated define_arm_cp_regs are guarded by
"cpu_isar_feature(aa64_*)", so it's safe to expose that code for arm
target (32 bit).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 595d9334977..1db40caec38 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6591,7 +6591,6 @@ static const ARMCPRegInfo zcr_reginfo[] = {
       .writefn = zcr_write, .raw_writefn = raw_write },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_tpidr2(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
 {
@@ -6825,7 +6824,6 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .writefn = aa64_allint_write, .readfn = aa64_allint_read,
       .resetfn = arm_cp_reset_ignore },
 };
-#endif /* TARGET_AARCH64 */
 
 static void define_pmu_regs(ARMCPU *cpu)
 {
@@ -7017,7 +7015,6 @@ static const ARMCPRegInfo lor_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -7510,8 +7507,6 @@ static const ARMCPRegInfo nv2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
 };
 
-#endif /* TARGET_AARCH64 */
-
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -8952,7 +8947,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &hcrx_el2_reginfo);
     }
 
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_sme, cpu)) {
         define_arm_cp_regs(cpu, sme_reginfo);
     }
@@ -9013,7 +9007,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_nmi, cpu)) {
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
-#endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
-- 
2.47.2


