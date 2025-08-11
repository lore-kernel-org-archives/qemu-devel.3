Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE76CA0EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVzM-0004yD-PC; Mon, 11 Aug 2025 13:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzB-0004vm-R1
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVz5-0001qM-VR
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459e210bd2dso16542745e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754932012; x=1755536812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy66U/Y+GsoS7WvoAHDCbL+/HfooWzRIS+dCFcyd4Uo=;
 b=AI94lzQNdEppdkJ/fqjRpRDYdE7rrP3xT+FLCtZu99BYl94DH9/fLGoGD2OHi9ZNMI
 cF8l9xgShIwNhbeGFWdxV6E0tpKpGadIbvgNdPt1dXxpY0Jts6b7Zz7IS9wGoTrPj7rA
 cJPlJqBje2DvekR5jGjQbpHfxsCSry2oWGQmMyqGD2s6wTXrLwq3BuwE34EFA0AaHWfv
 cXWKq3XnH1C/xccR3l/gcGb3Ihusj1JgecksBc6RKWOK5X95RXzLy84i4gmSFyvzI5Jx
 1jJgh33jTX+LJJR5QO0z0AcM5HfTYLkO/QmKQnCcL7OL3brsMmQp4qcIEqdrH/NFriHt
 kWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754932012; x=1755536812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xy66U/Y+GsoS7WvoAHDCbL+/HfooWzRIS+dCFcyd4Uo=;
 b=EYB9guEvyETdUUwyak1Ug4WQXp7Fhnf1pCLmX68sHEf0vytPKWFSDLM6KEtZqFotMs
 m22xkGPNHi0YWXQmd7wEBgZ9+uKsjP+7+jygVaHp2a5Nz8NtKBogdAB6BLETRU/l/dpe
 wz7aLbKo1o6xSc9XL0zUhfwNFPjTzctfSrV1OgLHLfRZFNqrLeBzNIBbceuC+KKkEfTC
 i0QJutkhxSYiwHW/6LBXAinh0RpyXmJYBfhDdroZsy/f0qpWHEQVBaPT3ig0gsoiA+jd
 XQXctMSOu+VMgLmAEC+L0QTDE8M/o2sJaLuvfbVPrn0Fw+l7Imdq/+6IDqrP0j9r3Yoh
 ch1A==
X-Gm-Message-State: AOJu0YwiPfjnZUwuXrgsJnsaVwpqjO1zeESsp9pZnMB4zf5DVk25WrNP
 nB0DlTnEqodZy10HrVaJWGM9E7NsCMr6pGyz96cHuARhrOwMEA/8xhXgvYsJNg05E3Nswm07l6Y
 x6v7J
X-Gm-Gg: ASbGncvz8kBZD6tA/nlPoYhpldhIfChNlC+RvlRAxLU2Pc7kW2TkRoyMuyZ8PqmGzqU
 Yc6Iq+U/f6/XPorM4+MRUWC5ZBivfsaR4x1BKBIAuFp60ZTbdL/XeYK4ds4j8zOzSbf6MNyp6sJ
 zMN/LgKlfnCNsesss+XtqzRqV4/KsOCcK51a13mElutZSP7ZCAX768uMKlCmp7E62rOKJ2crZ9X
 RCJB/1VTSBPYmcUjNrzxHIBiDDGzbg47a81J7EWBOBffydioltP5EXFpyuxItHswZVz6cgRp9cd
 bSmIqpgn2SmNawF0M4xuYJCpCXIJBiDvzKuYzmQG6Rs6HrfybgB20FDc/I0ul3Y3N7Xq8/dZqBr
 6j7BUgbcNqnCFLuPymhgwmc63Vqi/XSQtrTQKpIcreiIE8q1kaaDh3awEgJfL1skkfaV4avz9
X-Google-Smtp-Source: AGHT+IGmfphj2mVyIXTj/0jyub2rh0Wyucghu5fqob5NYPlURmtsCqqH6Zi92+hXGXffCLSOUjqF9w==
X-Received: by 2002:a05:600c:1c27:b0:458:bd08:72a8 with SMTP id
 5b1f17b1804b1-45a10dac800mr3454185e9.13.1754932011892; 
 Mon, 11 Aug 2025 10:06:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453aeasm42842421f8f.40.2025.08.11.10.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:06:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 07/11] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
Date: Mon, 11 Aug 2025 19:06:07 +0200
Message-ID: <20250811170611.37482-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use the generic host_cpu_feature_supported() helper to
check for the PMU feature support. This will allow to
expand to non-KVM accelerators such HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm_arm.h  | 13 -------------
 target/arm/cpu.c      |  4 ++--
 target/arm/kvm-stub.c |  5 -----
 target/arm/kvm.c      |  9 ++-------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6a9b6374a6d..364578c50d6 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -177,14 +177,6 @@ void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
  */
 bool kvm_arm_aarch32_supported(void);
 
-/**
- * kvm_arm_pmu_supported:
- *
- * Returns: true if KVM can enable the PMU
- * and false otherwise.
- */
-bool kvm_arm_pmu_supported(void);
-
 /**
  * kvm_arm_sve_supported:
  *
@@ -212,11 +204,6 @@ static inline bool kvm_arm_aarch32_supported(void)
     return false;
 }
 
-static inline bool kvm_arm_pmu_supported(void)
-{
-    return false;
-}
-
 static inline bool kvm_arm_sve_supported(void)
 {
     return false;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1dc2a8330d8..c78a3c9cda8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1564,8 +1564,8 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     ARMCPU *cpu = ARM_CPU(obj);
 
     if (value) {
-        if (kvm_enabled() && !kvm_arm_pmu_supported()) {
-            error_setg(errp, "'pmu' feature not supported by KVM on this host");
+        if (host_cpu_feature_supported(ARM_FEATURE_PMU, false)) {
+            error_setg(errp, "'pmu' feature not supported by this host accelerator");
             return;
         }
         set_feature(&cpu->env, ARM_FEATURE_PMU);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index c93462c5b9b..3beb336416d 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -32,11 +32,6 @@ bool kvm_arm_aarch32_supported(void)
     return false;
 }
 
-bool kvm_arm_pmu_supported(void)
-{
-    return false;
-}
-
 bool kvm_arm_sve_supported(void)
 {
     return false;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 82853e68d8d..0fe0f89f931 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -288,7 +288,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_arm_pmu_supported()) {
+    if (host_cpu_feature_supported(ARM_FEATURE_PMU, false)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -506,11 +506,6 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                                     "Set off to disable KVM steal time.");
 }
 
-bool kvm_arm_pmu_supported(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
-}
-
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
@@ -1783,7 +1778,7 @@ bool arm_hw_accel_cpu_feature_supported(enum arm_features feat, bool can_emulate
     case ARM_FEATURE_GENERIC_TIMER:
         return true;
     case ARM_FEATURE_PMU:
-        return kvm_arm_pmu_supported();
+        return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
     case ARM_FEATURE_EL2:
         return kvm_arm_el2_supported();
     case ARM_FEATURE_EL3:
-- 
2.49.0


