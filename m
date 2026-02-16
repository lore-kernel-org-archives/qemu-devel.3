Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67956E63F2D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXa-0002Xs-Qz; Sun, 15 Feb 2026 22:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXZ-0002XO-DQ
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:53 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXY-0002Qg-0Q
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:53 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a79ded11a2so17386605ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213491; x=1771818291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wbaWufcL2e5tEtCZHFxuRaX3s02e+nS0+Goels1wiTo=;
 b=xzsnB34SneBwnNatga5TfxJzvv9HcssmGhM/t48DCqCT26sCc1JGagjkam/UNf/tpz
 AF/hcrAqS3KiqL+WTIaz8bFivpQFb/bx0vvYwoRrLMNF0wNpY4wE7y/8JTv6fyqCclw+
 M9MhowaezAUsGkb4o02nzBxLYSlubXkIvHs6zNWw9qU7x0xEge3zDnOBtDFGsVegKjPz
 wxMbqgQ2GhUYVVE5JtUfCLmD2KrchBKIZseZx/sC2XDALYdMBE+Y34ZrldXSixXSaiU7
 6wStlnJef3wbLUYJm6g7VJ/jiy6QGlI9LUOn5X6CKMzY4+EVBsGqj0p2xfNtc8C0CCN5
 ZWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213491; x=1771818291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wbaWufcL2e5tEtCZHFxuRaX3s02e+nS0+Goels1wiTo=;
 b=q6vW3fpicMBixTSAQqeknx26h+hkN1hWCY9Pj52JyjjH21B8wZVhd85g41rMOPrFRx
 N/4DZnHRWmU7vEmJTrbFhk9hI7Nx3wKbw5EXMNIItBsDSwLg5MqH9Bwr6xoL9JdRCzUw
 /UOARK/Udid9f7bMLih1p4n5lAZeFZEv9tYiAQXwVJsleYpWaGESURNpVTIM1Jzql0O5
 ShoDGmvF3tcam1Y5GJF/8fGuALhYqvolIT59qAPPtd59BcauLYq+3SSjkRhWgkfGUwTa
 KGT2beGR2OyVjXIG9mGdANAOhEjsjsth7VAFepXM5w2j04AB3feIdE1II7S8PTTKsu11
 UThw==
X-Gm-Message-State: AOJu0YyodHmUKlnaPXuUyr9y2vyQDsGp1Sb3xKoe9XosQv8IgMeW10bf
 VqHN9yB2XMFXNXE/SHIZl17ZKGkaQIfJq26PV7T0RkwmI5u77DCjV/mGvHIMR7V+JJtXmzMxW4g
 /gpEgBNc=
X-Gm-Gg: AZuq6aK3eBnk8K6Tuqa4vreV2VYBMCbNwIbAUX/vk8SnGYChyK3wErQSwyQOxBcVOSK
 2txukbyCqz46R1bS2tJcBnyXiuo0HxwFVXenK09+DcQf+YFvyhg7As/NUanIktVs2Nj8qVBQB7y
 ec5NXk5e/EBS6SMttaynTfaCJShmdqVbUhP6J867z/5Y/QDecwmPSa9ykHa8TLImmGn3KV5qlDL
 oBd2WTW+lz315GN4PQuZaUcAfmK67UgWvMR8BmWPk74J+b9SOFLP8XizdHFtffPFavSiq3rQlMs
 K7bPsesu/xQnMX07OTV2GgjxLEkEY657OTclurhaepW3BkrcYg8N+d0mrVBOAJZw0qEqmMkVjA5
 TlChqFSR5ZiCjdAXUekQ1Gsdn91TDYodbX8RvEBUcVq368NWfdUCzFCqoY86fmDclosS9OGQjHw
 C4rRkFsLcKDLl7UawTQryic7CQcHrtQM5b
X-Received: by 2002:a17:903:22d2:b0:2aa:e6c1:cea1 with SMTP id
 d9443c01a7336-2ab50506bbdmr88481665ad.17.1771213490551; 
 Sun, 15 Feb 2026 19:44:50 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 06/13] target/arm: Drop kvm_arm_sve_supported
Date: Mon, 16 Feb 2026 13:44:25 +1000
Message-ID: <20260216034432.23912-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
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

This function has only one real use, so inline it and
drop the stubs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h  | 12 ------------
 target/arm/kvm-stub.c |  5 -----
 target/arm/kvm.c      |  9 +--------
 3 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 97549766ea..cee06b5f0b 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -176,13 +176,6 @@ bool kvm_arm_aarch32_supported(void);
  */
 bool kvm_arm_pmu_supported(void);
 
-/**
- * kvm_arm_sve_supported:
- *
- * Returns true if KVM can enable SVE and false otherwise.
- */
-bool kvm_arm_sve_supported(void);
-
 /**
  * kvm_arm_mte_supported:
  *
@@ -208,11 +201,6 @@ static inline bool kvm_arm_pmu_supported(void)
     return false;
 }
 
-static inline bool kvm_arm_sve_supported(void)
-{
-    return false;
-}
-
 static inline bool kvm_arm_mte_supported(void)
 {
     return false;
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index f2de36aef3..f1d0ca09e6 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -37,11 +37,6 @@ bool kvm_arm_pmu_supported(void)
     return false;
 }
 
-bool kvm_arm_sve_supported(void)
-{
-    return false;
-}
-
 bool kvm_arm_mte_supported(void)
 {
     return false;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 464356989b..7724609b28 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -246,7 +246,6 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
 
 static uint32_t kvm_arm_sve_get_vls(int fd)
 {
-    /* Only call this function if kvm_arm_sve_supported() returns true. */
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
     struct kvm_one_reg reg = {
         .id = KVM_REG_ARM64_SVE_VLS,
@@ -298,7 +297,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * Ask for SVE if supported, so that we can query ID_AA64ZFR0,
      * which is otherwise RAZ.
      */
-    sve_supported = kvm_arm_sve_supported();
+    sve_supported = kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
     if (sve_supported) {
         init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
     }
@@ -1909,11 +1908,6 @@ bool kvm_arm_el2_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
 }
 
-bool kvm_arm_sve_supported(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
-}
-
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
@@ -1968,7 +1962,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        assert(kvm_arm_sve_supported());
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
     }
     if (cpu_isar_feature(aa64_pauth, cpu)) {
-- 
2.43.0


