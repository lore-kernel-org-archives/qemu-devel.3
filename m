Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E69E63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXf-0002Z6-71; Sun, 15 Feb 2026 22:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXd-0002Yi-PA
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:57 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXc-0002S0-9A
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:57 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a963f49234so10283115ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213495; x=1771818295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lAX9q0FAVjvqhmCaLqgZcT2Y1IPbyARjOjUjg0Oyqjc=;
 b=Aa1NimMHmrIuVZfoL/JWcwz5dpKQw1kkBoVUGEmmm+AV4SFfwe5Af82vgsw5MmY1l/
 CAEFQwQ4Ktlmk7UL4YyZXOd5GAykGf4GxVlPBjCmn48KfBBcBXc5CXL2cC1ml44gFReG
 S4/8y1yqulpSjkG1p1XIIejMgDlCtJHVmsUkvdt+E5jtJZrcSQaPaOpfE0tWh1w9PEc2
 W1x4iVtAqR94NPGKvQGXJUEifIdmK6A82M3FRo8t52Kyq1FxGDJnl7e6YsfLirVL/M4+
 UjC5YD9cOU79+mv9JypyAJEiwszFjuW+o1Dv5GpTB5R6EBpuO/fObZYHgjqeXkboh8Ey
 eTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213495; x=1771818295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lAX9q0FAVjvqhmCaLqgZcT2Y1IPbyARjOjUjg0Oyqjc=;
 b=fCBVgTkfjJx2OrMamSldFpdXSLxlOCrJBS0fa6QIXGtgFY7jUkxM8Uj6IWcvIM6SVM
 WBwn3tJfdGOdwLvFT/Wvq3Cji5g1NToWVRgcLf73RK4MhaX95SnDYN8E/BuXEWxjDB8B
 Ev2Db+mLjs8P4PSGQuZspAnapJikDYxEpSRPjt/QoeafWsow875cYPuZn3ilv9kqLfyb
 Rq27ndlx/fuULuUzywT+TnIxyCEba66RHb5ol4AJRZvI7I7LdZaoVexTT42mCD3mqtfy
 QZO7YXQQEVUXZhR+pOtV9Da6ijLpu4E6+2DDTI5ywJ+UzsxXQL9HgDLGgH/ZtnwaJi9X
 iBOg==
X-Gm-Message-State: AOJu0YxArdtgZWGezYmXkjyrwYgzxNUpFb5U2oDzXfoGg1M6KP/oQVe0
 dYKsRCSTC1FVmdkmG8IqWmHww2kjTejOm5cBUy4iqcYT4uwbVZb9/uMrNqJpNRXQaPBQ2g14WO0
 rclLmdCY=
X-Gm-Gg: AZuq6aIUJAE1jxCPIkKxGPiB3y1CevVymBCgKQRt8g41496ftErOjk+1tnquaTbcmuQ
 k+F/FLovMETem9ESEXmuOtvnqbal5c7L07vOG3WDZACiSYcQ8sgvuqf5iN7hBNiryDlimsHzXBs
 4Fjiv+W7JCQiafZmVlqDjP8J5xZqTuBPjMOLbZsMjd1JBCvXmgku6y4PS+JxQjJPce95F2Swley
 Z00mceD1RLQiYy3SwnoxWBYyOGfjZbHubVgk0X8KLWUbbfF1J76cdKzz2NcVtmhXgPRgOwRi/SZ
 clKTXchpjJpCOhUWsFgd5m9yK/HT33PicAodoYPYekUiqCSLMsngUeal/QEQiCZfueI24w+G7GY
 1NtUOL1mWMtWZeU1w9WBwWirDRO/tDnGluNBndEs/NDzSOrpEJvfNVEUVlehNFQ8VT0XMG0hQmD
 Wud1rBv7u+YPmxu/XfWqYapJ2NcP/Sk3ll
X-Received: by 2002:a17:902:ce89:b0:2aa:d289:2d95 with SMTP id
 d9443c01a7336-2ab50559e20mr95416455ad.17.1771213494749; 
 Sun, 15 Feb 2026 19:44:54 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/13] target/arm: Drop kvm_arm_pmu_supported
Date: Mon, 16 Feb 2026 13:44:27 +1000
Message-ID: <20260216034432.23912-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

This function has only one use, so inline it and drop the stubs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h  | 13 -------------
 target/arm/kvm-stub.c |  5 -----
 target/arm/kvm.c      |  7 +------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cee06b5f0b..82ac2aae46 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -168,14 +168,6 @@ void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
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
  * kvm_arm_mte_supported:
  *
@@ -196,11 +188,6 @@ static inline bool kvm_arm_aarch32_supported(void)
     return false;
 }
 
-static inline bool kvm_arm_pmu_supported(void)
-{
-    return false;
-}
-
 static inline bool kvm_arm_mte_supported(void)
 {
     return false;
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index f1d0ca09e6..169ef5f206 100644
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
 bool kvm_arm_mte_supported(void)
 {
     return false;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7724609b28..ccffa40900 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -319,7 +319,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_arm_pmu_supported()) {
+    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -542,11 +542,6 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
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
-- 
2.43.0


