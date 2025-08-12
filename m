Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F62CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsql-0007gu-RX; Tue, 12 Aug 2025 13:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsqi-0007fx-NL
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:31:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsqf-0003vw-Js
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:31:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-459eb4ae596so52916125e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019902; x=1755624702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItlZL67yXVkL33ShD3YcHf/7JlewuU1bqR+ufSEzLKs=;
 b=tlS1Ic5+KGvS8f7AK8ondvzxiarRfu0PTAeDREBMIuKBAM2SsAA4ZztbsB28OI1l54
 XWdfw0uyU6L7i5eTib1H8MPPG8VF0KoWQj3O3VAxDWzsu/e5e7E+mb7jHKCCzV8r+2oA
 YbfnZDPnEVgbe5u1EZIugtrmrx/tlsH96XDY+4xZnjW3hsJF1KgQxn62qQKT9ib0x0jC
 9pJEf79Rv0qwtFuc7P4MGh77ojQr+KGNuQhZzj/RDnhKhwfZOCRev82pop0JE/Vw12Pu
 1jfVugR/qNE+1g9FftXumMHnWjoT/m7XpDuhMye2dPtmIuccWLHRoR1vTJY17UzVCiG6
 DbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019902; x=1755624702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItlZL67yXVkL33ShD3YcHf/7JlewuU1bqR+ufSEzLKs=;
 b=OiWTDBzwowbUKWPGuwDyJNqnGY1RvM/Pu2Uducdm8pK1ynIck+2vJf0vIa4rI1LGf9
 IJSg3obR5BvnnBGCpYn4R2afuFTL7NzlRBg2HmT9ZJqkiDUvA70nU9qWk20ycLkeIHOa
 6jBw5I806TsqY94Q5esAECWVjaBgdrn/opnR9IYkYezBNLhRJOGRoJCoEzRGUIWOK9D9
 M3Gqfly8ZguI0Fq/QuRHw5ZQkFu8km511m26tmbpJGuLL7Uf+phtmTCHkkRDOwe3Ihy+
 Oogc2GQY9QN6DMr3WJZVKNa3t+xP3sJVbnSWB9etXVxKsIRH6eFDYjTW3Bp0NZmHbDRL
 tWzA==
X-Gm-Message-State: AOJu0YyUvtqWXR9zD8Tsfhi7yqYyGyA9LLzvluArbuB1oe0sZOgyREi/
 /yIUA0ZbNGlyO//hDsG5eFGMhqQj/GBNEtfSkkP+p17+7BtLcM0NtJgNc2RsuxY3YYJGApaK0qF
 NfFSD
X-Gm-Gg: ASbGnct7TiesB1XGnfy3ZuCi4iKXrQyRcggRyaRZcOJZbjNDiyBKUzfBDZL/5gqYGnQ
 2g9UpyglrM4UfZdo9ZQPeBWOS3KnajFnxRvyl868ArjhAwCcL8T0h59Xh7ug5/yVkLJCDnvUhZ9
 gKXSuvvy+chUkcgLuaRDs7TQxfLPRD8zm6FaS5Rhh1yO5lagrb2SpdQ7mN9tcTxINbESU2DoB3S
 lSEZGiaOTn/O2kqhFIPhhM1NyUaDy1YJ07cKFZ+YdUdb9pyqnhymYVmHDskA8ZLbPWlkWWT322x
 EdfSVkbR6D0b3OiEDWSe08xgihsL4tC5A9oyTtasR5wJGweXRhWjfxmvusG1715LYhLwHdjT+Gv
 SJYYVs5EmGhRJsvUDwJVIgY2qtupjBYWKN8Jky8LRdBixsKG94j45Ragg+CskVlNkSxwFPYW9
X-Google-Smtp-Source: AGHT+IFzbket4AksstrlBz0r9ZXzdT5oXYjhvGXkYpRrgm5GJc/8f6Fzu3mmwL0yHFoI/yyxIiZ/Dw==
X-Received: by 2002:a05:600c:1c01:b0:458:bbed:a827 with SMTP id
 5b1f17b1804b1-45a165b7b15mr178235e9.1.1755019901964; 
 Tue, 12 Aug 2025 10:31:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e584302csm329645345e9.7.2025.08.12.10.31.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:31:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v2 06/10] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
Date: Tue, 12 Aug 2025 19:31:30 +0200
Message-ID: <20250812173131.86888-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812173131.86888-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173131.86888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Use the generic host_cpu_feature_supported() helper to
check for the PMU feature support. This will allow to
expand to non-KVM accelerators such HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm_arm.h  | 13 -------------
 target/arm/cpu.c      |  6 ++++--
 target/arm/kvm-stub.c |  5 -----
 target/arm/kvm.c      |  9 ++-------
 4 files changed, 6 insertions(+), 27 deletions(-)

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
index 1dc2a8330d8..ace8e73b532 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -24,6 +24,7 @@
 #include "qemu/log.h"
 #include "exec/page-vary.h"
 #include "target/arm/idau.h"
+#include "qemu/accel.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "cpu.h"
@@ -1564,8 +1565,9 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     ARMCPU *cpu = ARM_CPU(obj);
 
     if (value) {
-        if (kvm_enabled() && !kvm_arm_pmu_supported()) {
-            error_setg(errp, "'pmu' feature not supported by KVM on this host");
+        if (host_cpu_feature_supported(ARM_FEATURE_PMU)) {
+            error_setg(errp, "'pmu' feature not supported by %s on this host",
+                       current_accel_name());
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
index 93da9d67806..0aa2680a8e6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -288,7 +288,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_arm_pmu_supported()) {
+    if (host_cpu_feature_supported(ARM_FEATURE_PMU)) {
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
@@ -1783,7 +1778,7 @@ bool host_cpu_feature_supported(enum arm_features feature)
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


