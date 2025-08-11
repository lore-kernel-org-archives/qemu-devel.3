Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F37CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVz5-0004tV-C9; Mon, 11 Aug 2025 13:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVz2-0004sj-OL
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyx-0001o2-1l
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so28089005e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754932001; x=1755536801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87BQk4WDEzqTJD4OBgNMj09kaieo6h7xgFKV69c1SWc=;
 b=QJxxL7eir4zdIy1w280OZ+mobj1czlYrRolLcSdbDYRFPdBTfJnIaEIESbZUPvQudl
 2hoRL/cuvvGJobGmF+rlSht4zubO3ZJ3k/si+VnZYvJZPv3ei70HFgoAmP8hbfUNAEWm
 2HJpeQmrQGV6P33g7eI8eTZBsOJKqUZql2Pq121/O2aWEyIOga5Lv9mDr1/Jm3OqRenh
 GKMrCMfsWyAZgHyu4rvgBYFakRxlA8FezMfGnaIVKVeUHti2ZKp1aQVClhZ0PQLrjDBf
 ijhpTnq2xi3+BvvDvsv97Q832Zge3OKnn7gDVhPMfMrCwMRCNrW4GkgeLaQiz09jrhuA
 wg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754932001; x=1755536801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87BQk4WDEzqTJD4OBgNMj09kaieo6h7xgFKV69c1SWc=;
 b=EQlHzWE7ZissrIgzgQI7Aqk7bcuUCk4B0k0/KMu1e8sIQg+IZ0jH1cZih/7IQmlQAk
 3RZ7in+yV6lXCR9faM4H1N7wSDNq+WMiHkONQfT/M4nQLE9MabDbR/L+lIxyqq5UyNiw
 W9XBx1biEAY3AdYsYS8KdcbMSk8O0ZGe6Id910toDjZXNsgxAptNmHM4wtsRIT7LOVT0
 jIJRcK9e5DkVMuSNMxFdafUAciLapP0hpvviqMofpto98QZyDjlXcdoefZux0hxXIP8w
 cNo6qPix1wuFqu0tBP7R6ibIbxzyrtj2s1Xqwn8SmaNL33B7jCciR1AwAWwDRj/s8DQc
 eS7A==
X-Gm-Message-State: AOJu0Yyc2kIf9bOfWX6q6JxD2pmhsMeqDc8/rWYEdhjQsqdZeDgDultr
 7IdkERmliDDSyI+VkgzApfgddrJ8MIuIYx+g2GuIVzKH0Ft9/TOv/67aBjWMBNC/FVNnECM3ufV
 oxLCl
X-Gm-Gg: ASbGncvkaet7ldUtMFRWtRhh7KEijn2LWmMI3FZ04d5jEeaMKLor+ehPwPEur0DXrIc
 Qd/kYcTScn6tUgzzbMFJMXZasPOyehOVMv3lB5yq+6P6gp1Pvm6oIURE8FD9vSekKEMkW0cHncj
 LeDZlbXvIuaZgzlS5Rh6X/jRMZreoGNFK7TlWde/9eksSFOTO7Df6pp6u0r3Y/2AZxtlEqyva+K
 pMWrEb9vM6Dm/job7vfK14Lav/LbMQ9ey4QCfYgbjdE0hOvU4GJjV3ItfMwettbEKqGgeK4l3Fq
 uNuAeyM28citO3bPxhKL0btDbD0o8+1vf6sNRP9WG3DAI0RNQO/6mT7ltA0vts7sZnHVCwLKLtZ
 6pdubQCIHnklZcsSjWiFoZRThjCDygPNLGct8EE5+hBiG80W3tQtwaNuEsnLWsjYCS/abdXcd+M
 vHhVA6FVw=
X-Google-Smtp-Source: AGHT+IHaTwICaPRcKARdQT0mw9k+cJoRSQtgKTQLc8LGODj1lp8+nI2sBInpFOyWKeNcBONwY9kYnw==
X-Received: by 2002:a05:600c:45c7:b0:459:e398:ed80 with SMTP id
 5b1f17b1804b1-459f4f3b70dmr100697845e9.32.1754932001105; 
 Mon, 11 Aug 2025 10:06:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dcb86d6asm311879855e9.5.2025.08.11.10.06.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:06:40 -0700 (PDT)
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
Subject: [RFC PATCH 05/11] target/arm: Introduce
 arm_hw_accel_cpu_feature_supported()
Date: Mon, 11 Aug 2025 19:06:05 +0200
Message-ID: <20250811170611.37482-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Introduce arm_hw_accel_cpu_feature_supported() helper,
an accelerator implementation to return whether a ARM
feature is supported by host hardware. Allow optional
fallback on emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h     | 12 ++++++++++++
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 target/arm/kvm.c     | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dc9b6dce4c9..5136c4caabf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2507,6 +2507,18 @@ static inline ARMSecuritySpace arm_secure_to_space(bool secure)
 }
 
 #if !defined(CONFIG_USER_ONLY)
+
+/**
+ * arm_hw_accel_cpu_feature_supported:
+ * @feat: Feature to test for support
+ * @can_emulate: Whether Allow to fall back to emulation if @feat is not
+ *               supported by hardware accelerator
+ *
+ * Hardware accelerator implementation of cpu_feature_supported().
+ */
+bool arm_hw_accel_cpu_feature_supported(enum arm_features feat,
+                                        bool can_emulate);
+
 /**
  * arm_security_space_below_el3:
  * @env: cpu context
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 81dc4df686d..5174973991f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -964,6 +964,26 @@ uint32_t hvf_arm_get_max_ipa_bit_size(void)
     return round_down_to_parange_bit_size(max_ipa_size);
 }
 
+bool arm_hw_accel_cpu_feature_supported(enum arm_features feat, bool can_emulate)
+{
+    if (!hvf_enabled()) {
+        return false;
+    }
+    switch (feat) {
+    case ARM_FEATURE_V8:
+    case ARM_FEATURE_NEON:
+    case ARM_FEATURE_AARCH64:
+    case ARM_FEATURE_PMU:
+    case ARM_FEATURE_GENERIC_TIMER:
+        return true;
+    case ARM_FEATURE_EL2:
+    case ARM_FEATURE_EL3:
+        return false;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
     if (!arm_host_cpu_features.dtb_compatible) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 66723448554..82853e68d8d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1771,6 +1771,28 @@ void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
     }
 }
 
+bool arm_hw_accel_cpu_feature_supported(enum arm_features feat, bool can_emulate)
+{
+    if (!kvm_enabled()) {
+        return false;
+    }
+    switch (feat) {
+    case ARM_FEATURE_V8:
+    case ARM_FEATURE_NEON:
+    case ARM_FEATURE_AARCH64:
+    case ARM_FEATURE_GENERIC_TIMER:
+        return true;
+    case ARM_FEATURE_PMU:
+        return kvm_arm_pmu_supported();
+    case ARM_FEATURE_EL2:
+        return kvm_arm_el2_supported();
+    case ARM_FEATURE_EL3:
+        return false;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 bool kvm_arm_aarch32_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);
-- 
2.49.0


