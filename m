Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF0FD59D6A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFJ-0005D0-FK; Mon, 25 Nov 2024 14:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFE-000589-Rz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF7-0004pB-Im
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so9456385e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564772; x=1733169572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZxFPU/cHWqHSELYlJR67QZcEPKYi6vUTmv//JrZID4=;
 b=Z61uNxaBekoD6oSz6xG0+5RfnGFEFtjB/q0VT7ABSKHKl6uLMzI2jhSpvQShmKeaWR
 Fh56Z6pfzyjigWIcxchhDyu8ZGbwKsNhZhksYBf0vJt183pSJkAbg6KkP6LTlDQWlJl0
 +m5um7qbztjXaXnyA7P8TFqrQIp1Gc59cry1nlfK1Mp6jdgMw8+8y4/NRp0IYboMpVlo
 /TktK+dmzml4D4JF08RiwvhZL7GnKDsKNHsmWGptK3NX7z9db6915tfshD22C6PgIWd/
 mepkOgs48gpflmtNCUbXw0opJYxVay9oHs7fMGvbCfZNsU932Irpo0uNtHlkx4ynoRWu
 LYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564772; x=1733169572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZxFPU/cHWqHSELYlJR67QZcEPKYi6vUTmv//JrZID4=;
 b=dpy2I0ACx4Xd83EnE3FCHGxdlwGPhvE+5QX5OVUx8v9Go/u6BMEhFYgEIdX2cahyCl
 qCFDkDMRqDXzvbRi4pF7p/5tjczOIgnflufKRvLgj6EQPvUwAxPYaNr5N2cX1MdhgPCo
 wx0e5M6miaHvV8TjcZ8Hw7TRhvk+5q4UHtVF6U2iT4L78u0powXg62dB1cN4g+Zh96jY
 xcT7LluuRGZ0SXCSnp0ovfG73886SL7sC6aXXgrA+xOpFs9VUNsQaTm3OZtndI7uXPEG
 ktKALjhPb5kSuZnBYFkxHWjRa+gHZVH2ue6wS0oPCgZRfmmZoDqTglMZ688dlfaPmSSl
 2HRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnpu1Um4A5IGcfPY+XejUnbLO1i7extD/Tb5mdj87rHu3ByaIeI+gEqH7ND8/j5guP7sn5Mndspk8M@nongnu.org
X-Gm-Message-State: AOJu0Yz6DssmIPdgKYGcpJNgD1U35dxveD4geJ40yjCu7cyovdcROOuu
 WCxzaSjzgsIvm2ohzxAm5a94qkh9ybrYcEgUTenC7gNM1aWWJMnnsn/oy8QlRsU=
X-Gm-Gg: ASbGncvgo48FBnk4uOz8ijNfo+JT2FQnfYYJtOLl6m/JMKbKwuKGDAKRmm/rRGm3vYx
 zCO4Zhsn3JrXy84rnH8/aI0lxcmwsuWB2WWBaQBSz0afp31TgyEj3B3n77NgwSX4G2ku4Cc0FJ1
 Pe/BxfcsLYJEePkTObpdpdKpeYcJU7cj/7SvHeuhuy5oAEQHKofyt5DHKJvDSFbvdPTTwy/p10r
 wJlrGzqFLrx5lrFZDGyiV/4nyjyS+/cZnvnkPETrFFWKwMlbLAux5YDpti2b4mDwoir
X-Google-Smtp-Source: AGHT+IFVuKUMl8qVl+jZythLFRNH6SVTB2gdvNX8aguLJeAEaTVKDcV1J7mB6Tu6aoTmT/NUzj/bDQ==
X-Received: by 2002:a05:600c:4f86:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-433ce48eb82mr109983075e9.25.1732564772013; 
 Mon, 25 Nov 2024 11:59:32 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:31 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 13/26] target/arm/cpu: Set number of PMU counters in KVM
Date: Mon, 25 Nov 2024 19:56:12 +0000
Message-ID: <20241125195626.856992-15-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x334.google.com
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

Add a "num-pmu-counters" CPU parameter to configure the number of
counters that KVM presents to the guest. This is needed for Realm VMs,
whose parameters include the number of PMU counters and influence the
Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/cpu.h          |  3 +++
 target/arm/kvm_arm.h      |  1 +
 target/arm/arm-qmp-cmds.c |  2 +-
 target/arm/cpu64.c        | 41 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 34 +++++++++++++++++++++++++++++++-
 5 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5cef43a8d2..382dd4ded9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1113,6 +1113,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2393,6 +2394,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 28ebec8580..77680f238a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -17,6 +17,7 @@
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
 #define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
+#define KVM_REG_ARM_PMCR_EL0            ARM64_SYS_REG(3, 3, 9, 12, 0)
 
 /**
  * kvm_arm_register_device:
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 0f574bb1dd..985d4270b8 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -95,7 +95,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3",
-    "num-breakpoints", "num-watchpoints",
+    "num-breakpoints", "num-watchpoints", "num-pmu-counters",
     NULL
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1d4f4c134d..cf1d17fb90 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -643,12 +643,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
     cpu->num_bps = val;
 }
 
+static void arm_cpu_get_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        val = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+    } else {
+        val = cpu->num_pmu_ctrs;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_ctrs = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > max_ctrs) {
+        error_setg(errp, "invalid number of PMU counters");
+        return;
+    }
+
+    cpu->num_pmu_ctrs = val;
+}
+
 static void aarch64_add_kvm_writable_properties(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
                         arm_cpu_set_num_bps, NULL, NULL);
     object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
                         arm_cpu_set_num_wps, NULL, NULL);
+
+    cpu->num_pmu_ctrs = -1;
+    object_property_add(obj, "num-pmu-counters", "uint8",
+                        arm_cpu_get_num_pmu_ctrs, arm_cpu_set_num_pmu_ctrs,
+                        NULL, NULL);
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f6d45476b4..9784c47ff5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -438,7 +438,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         if (pmu_supported) {
             /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
             err |= read_sys_reg64(fdarray[2], &ahcf->isar.reset_pmcr_el0,
-                                  ARM64_SYS_REG(3, 3, 9, 12, 0));
+                                  KVM_REG_ARM_PMCR_EL0);
         }
 
         if (sve_supported) {
@@ -930,9 +930,41 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
     }
 }
 
+static void kvm_arm_configure_pmcr(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        return;
+    }
+
+    newval = FIELD_DP64(cpu->isar.reset_pmcr_el0, PMCR, N, cpu->num_pmu_ctrs);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded, since older versions of KVM ignore it.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_PMCR_EL0");
+    }
+}
+
 static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
 {
     kvm_arm_configure_aa64dfr0(cpu);
+    kvm_arm_configure_pmcr(cpu);
 }
 
 /**
-- 
2.47.0


