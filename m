Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8607ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4y-0002Rq-TU; Thu, 25 Sep 2025 20:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w4T-0002Od-Li
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:22 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w40-0005FO-F4
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-27edcbcd158so12006715ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845503; x=1759450303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIoPPX89KhI5MTUQ/bZHHvReGWobnIF7iuMGQp+/YZo=;
 b=jYgZhdoh1trjpZPBpgHfIj19eGNnEzRywGiWAdqJ86hgXeLGecNmze3GKeZV5x9WJw
 kAR7AxR+ZlWp3oOs9Jr/hKTRN+M9z68yv9eEH9UHMhRDoHJ8HBJ/bQ//Jegk2ip/FQY2
 2RTmwvJhXqaqM1o37R25CLI/FDXRuQW2JEQfKbf0u53LsQwly72DqsWbZJUWzsmXR1Wk
 uc+gJhSBOe/iSf1ToLN7M/8isTPTRQhKzZ2k9r93MT2F1Etn0ETOZac19L4/njri94MK
 tr/8s52lexM/nkaMctsI0ASWDnnXkC1WUhNXRUnUw7E91EF3DWJVFAGtPAV4gcjgWc+a
 PxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845503; x=1759450303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIoPPX89KhI5MTUQ/bZHHvReGWobnIF7iuMGQp+/YZo=;
 b=SCs+qFoZtCWYpRFobW/F0TMg0yB3Bn9HDLtEqe9BNTU/3/M+7tPoZR1yEbEmRh6cRR
 WpHQfm1PlmxO8gYSGD1yr0jFtEXt34o00hKWMqyCvxkOWaHSJHX7oOU85TvIswiicAlG
 o47X0s72J85HbUpwFZ2hVKjRHdO7mTmMB+Jf9HUx9wTFc28KzFwA4vjcx9cosLUDSOIV
 Db80pKHTVO4/FvCaNDWLaYXP0l+I1ND9bQE9bQxZJNucJs2/JWp7sUd24Ctt4s+lWegA
 AtS9dA/QD1cQxQ9dTJbpeiJQD6SruzJWYuwyNT0tEWUhWwDM+vWQAx+EDfjA+16tZLHF
 AqJg==
X-Gm-Message-State: AOJu0YyWXRDdH0MMlLNUN5Rjt0a7xj7SaRZ+g+nZK8vrW+lHEqmY+XKn
 NFla47PGtD7J7WckLeA7B0dvfAncRBa0uBe1jZ+DziMia1tWhHoI8fCb1YPUvw8Xs0WSG5FQ58k
 vkebO
X-Gm-Gg: ASbGncvmj1s6kLSPiyiq9ZzI8yqdA4bvs9sfbtFEXSxMm1TkhOgMmMWx1UNFb/MwAB/
 apdmN9TIf5p8+bijKgdn4iwDHaRJExIb57FN4vHAZWf1oP3Ng2Tq+KEnklqcPBoNhDm1VgZl2OC
 i0BAFZy+AMq7uw/2lwTsNbzguZ53iPeBOcQLzUJR7w9gV/N91utEu78LYcpaEKrxVoG/qLr7/+w
 MFKdKmlrfxmSJ5dwyviSCLge9MGgbXw1Gz00dj5U0sIBPX+NmUbDppZsbAFZWFl4Yh/j9/SDIcP
 YzFtT7lv77+uLQdxs6I7sFj+I60gN06lgY6o4FwRthpJ9zjIhey9c3U8vOdoY9A9hHC3+tDcpXg
 PgTKEWai3BFbu+xCO7hVRSRPb8ekI
X-Google-Smtp-Source: AGHT+IH08nJKJAA+PzaV4LTit7qsxIulDG8/iBmjavtCZT2KB5gtVeb3Bgo3a/IpGmRz4ExyU5PXKw==
X-Received: by 2002:a17:902:dacd:b0:272:f27d:33c7 with SMTP id
 d9443c01a7336-27ed45e7b1cmr57703865ad.0.1758845503175; 
 Thu, 25 Sep 2025 17:11:43 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/10] target/arm: Enable FEAT_RME_GPC2 for -cpu max with x-rme
Date: Thu, 25 Sep 2025 17:11:34 -0700
Message-ID: <20250926001134.295547-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
References: <20250926001134.295547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 3 ++-
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index abef6a246e..3e30d693b5 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -159,7 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value);
+    /* Enable FEAT_RME_GPC2 */
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
 }
 
 static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 6b04c96c8c..1aa0a6e4c3 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -120,6 +120,7 @@ the following architecture extensions:
 - FEAT_RASv1p1 (RAS Extension v1.1)
 - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
+- FEAT_RME_GPC2 (RME Granule Protection Check 2 Extension)
 - FEAT_RNG (Random number generator)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
-- 
2.43.0


