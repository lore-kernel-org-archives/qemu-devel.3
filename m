Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C59EE63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXX-0002Ws-R9; Sun, 15 Feb 2026 22:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXV-0002WS-QD
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:49 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXU-0002QG-63
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:49 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso975953a12.2
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213487; x=1771818287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g6TjkzWZADwtaXnuXxdFy8Vh9RUDwBaNaugNOdAFub8=;
 b=Rjh+Dpr827niZqEAfAAWOFOQoiE1m4wHnpnAqyoGsy8i6hauSawb5MUnN5QdEXAfOj
 uw6A7fZzmz+akPEVNgT77XyQ1jFWcm+YZ85HVjp36Stczl//qF5+GtusGyDvNSPQ0AsY
 c7XrcQ+rhKCLLvh4EhKOwTvgmZ0ML3AuelpYZtsFeLlaPtsk3mekoAMaSmjfoMwr32XC
 9bcHvUOtCHV8znPBKT3wNpydMjnpPcfohhJbOdpx5L8WDYzKLracddPhvwAV+1j5Mgyv
 pAtZ1GJINxbZ/3NhDjLAb2iZO5yOpSPeAueZKtrL8ANiWCUhEcaPt+XIYepiW0OYmXNo
 4VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213487; x=1771818287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g6TjkzWZADwtaXnuXxdFy8Vh9RUDwBaNaugNOdAFub8=;
 b=aDLpWSAyGPGHqgXj6BgT75LwMSv9Bvn21sJQNb+UOsxv3z0RU/5xhNOFbLXaWpL57W
 NsLLrGvDPS0bxjIw9XOfymG8AXVgewpx1olz5Ia9EQ2Jgi8PArn+K9RWI1EMOrxNLtCC
 dFuYyyf6wAvMqaj8UDJtt/RvqVaM/3WA0+sPAl7GYoy9gx2uV8xPMU0B9g7FsH9VSeDX
 nTIbzGO9mhIFQ+71L8nJsVlHutjhMJOoCAjeanzkhp89bZZy7pUOrp7pKmnUKdrjQi5s
 rVQTbD3bjNYVYlBbGZpnpvd0JO94oIJyTxaiqzcLGCipdSGIK3s+6vreb2YTj7IUXt+D
 +9yg==
X-Gm-Message-State: AOJu0YxuqnFwr9sdpmDcL0Tcy6307kVcDwroykwIkVZCKJJbIf2MOVFP
 O13ANzUk7x+oVARwMl3SBwAn+30ceCw5+0iWANrHddiH3n2xsSVmCIeCpG1hXmuD4UZM99q2LWQ
 QLtkCgu8=
X-Gm-Gg: AZuq6aJmy6BO11AyamC0HLlZYPDjSfsQJEv+8e3QlSvK+i95qXy5zn+DE/OUgo5ubOW
 XlTzQiUa4tOVUnV1jRx7WnNnEqLHck/2CEZY+bIZsa/c2PgRHDzAOlOsIyq/DGg7tWEK43k0jmk
 amJ+zRJ91oOSw9talzcXdVFvCraLg/5XDnoGcetalzAKmvId/GNCnxYocJdzC5PcI0g5grmV51A
 V1mQxaX3Sa+P/OtQLYePW2ucdJFOkLQQBYb+Y8s1mjPyBVSdqNM2cXP1/sDpZq/ZcwNndaIiCGf
 XN2CcXJDXH1q9Ajjq64lqbVpU4YfZb6Vm7BhQVNaYglS3m91gyKXjFWioRROlcg7A8iNhpul5qE
 TIdvJSJZR1ClZhdLHbq1iV75EXjmApSeUPXbVxxgbLbzMfRIpHSHOcPyNEAC/bTZUnJOtr/B0JK
 svmmRjKFq+WiU8c32mvcHUo8G1a9iqQas3
X-Received: by 2002:a05:6a21:114c:b0:350:b8e:f99b with SMTP id
 adf61e73a8af0-3946c87fdb4mr8336596637.45.1771213486610; 
 Sun, 15 Feb 2026 19:44:46 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 04/13] target/arm: Init sve_vq in
 kvm_arm_set_cpu_features_from_host
Date: Mon, 16 Feb 2026 13:44:23 +1000
Message-ID: <20260216034432.23912-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Probe for SVE vector sizes with the same scratch vm that
we use for probing other features.  Remove a separate
initialization path in arm_cpu_sve_finalize.
Unexport kvm_arm_sve_get_vls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h  | 10 ------
 target/arm/cpu64.c    | 20 +-----------
 target/arm/kvm-stub.c |  5 ---
 target/arm/kvm.c      | 73 ++++++++++++++++---------------------------
 4 files changed, 28 insertions(+), 80 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cc0b374254..97549766ea 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -124,16 +124,6 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
  */
 void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
 
-/**
- * kvm_arm_sve_get_vls:
- * @cpu: ARMCPU
- *
- * Get all the SVE vector lengths supported by the KVM host, setting
- * the bits corresponding to their length in quadwords minus one
- * (vq - 1) up to ARM_MAX_VQ.  Return the resulting map.
- */
-uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu);
-
 /**
  * kvm_arm_set_cpu_features_from_host:
  * @cpu: ARMCPU to set the features for
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 10c6796548..0116b6cc88 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -79,28 +79,10 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
      */
     uint32_t vq_map = cpu->sve_vq.map;
     uint32_t vq_init = cpu->sve_vq.init;
-    uint32_t vq_supported;
+    uint32_t vq_supported = cpu->sve_vq.supported;
     uint32_t vq_mask = 0;
     uint32_t tmp, vq, max_vq = 0;
 
-    /*
-     * CPU models specify a set of supported vector lengths which are
-     * enabled by default.  Attempting to enable any vector length not set
-     * in the supported bitmap results in an error.  When KVM is enabled we
-     * fetch the supported bitmap from the host.
-     */
-    if (kvm_enabled()) {
-        if (kvm_arm_sve_supported()) {
-            cpu->sve_vq.supported = kvm_arm_sve_get_vls(cpu);
-            vq_supported = cpu->sve_vq.supported;
-        } else {
-            assert(!cpu_isar_feature(aa64_sve, cpu));
-            vq_supported = 0;
-        }
-    } else {
-        vq_supported = cpu->sve_vq.supported;
-    }
-
     /*
      * Process explicit sve<N> properties.
      * From the properties, sve_vq_map<N> implies sve_vq_init<N>.
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index ea67deea52..f2de36aef3 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -95,11 +95,6 @@ void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
     g_assert_not_reached();
 }
 
-uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
 {
     g_assert_not_reached();
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e0fd79b78c..464356989b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -60,6 +60,7 @@ typedef struct ARMHostCPUFeatures {
     ARMISARegisters isar;
     uint64_t features;
     uint32_t target;
+    uint32_t sve_vq_supported;
     const char *dtb_compatible;
 } ARMHostCPUFeatures;
 
@@ -243,58 +244,34 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
-uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
+static uint32_t kvm_arm_sve_get_vls(int fd)
 {
     /* Only call this function if kvm_arm_sve_supported() returns true. */
-    static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
-    static bool probed;
+    uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
+    struct kvm_one_reg reg = {
+        .id = KVM_REG_ARM64_SVE_VLS,
+        .addr = (uint64_t)&vls[0],
+    };
     uint32_t vq = 0;
-    int i;
+    int ret;
 
-    /*
-     * KVM ensures all host CPUs support the same set of vector lengths.
-     * So we only need to create the scratch VCPUs once and then cache
-     * the results.
-     */
-    if (!probed) {
-        struct kvm_vcpu_init init = {
-            .target = -1,
-            .features[0] = (1 << KVM_ARM_VCPU_SVE),
-        };
-        struct kvm_one_reg reg = {
-            .id = KVM_REG_ARM64_SVE_VLS,
-            .addr = (uint64_t)&vls[0],
-        };
-        int fdarray[3], ret;
-
-        probed = true;
-
-        if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
-            error_report("failed to create scratch VCPU with SVE enabled");
-            abort();
-        }
-        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
-        kvm_arm_destroy_scratch_host_vcpu(fdarray);
-        if (ret) {
-            error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
-                         strerror(errno));
-            abort();
-        }
-
-        for (i = KVM_ARM64_SVE_VLS_WORDS - 1; i >= 0; --i) {
-            if (vls[i]) {
-                vq = 64 - clz64(vls[i]) + i * 64;
-                break;
-            }
-        }
-        if (vq > ARM_MAX_VQ) {
-            warn_report("KVM supports vector lengths larger than "
-                        "QEMU can enable");
-            vls[0] &= MAKE_64BIT_MASK(0, ARM_MAX_VQ);
-        }
+    ret = ioctl(fd, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
+                     strerror(errno));
+        abort();
     }
 
-    return vls[0];
+    for (int i = KVM_ARM64_SVE_VLS_WORDS - 1; i >= 0; --i) {
+        if (vls[i]) {
+            vq = 64 - clz64(vls[i]) + i * 64;
+            break;
+        }
+    }
+    if (vq > ARM_MAX_VQ) {
+        warn_report("KVM supports vector lengths larger than QEMU can enable");
+    }
+    return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
 }
 
 static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
@@ -469,6 +446,9 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
              * So only read the register if we set KVM_ARM_VCPU_SVE above.
              */
             err |= get_host_cpu_reg(fd, ahcf, ID_AA64ZFR0_EL1_IDX);
+
+            /* Read the set of supported vector lengths. */
+            arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
         }
     }
 
@@ -516,6 +496,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->kvm_target = arm_host_cpu_features.target;
     cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
     cpu->isar = arm_host_cpu_features.isar;
+    cpu->sve_vq.supported = arm_host_cpu_features.sve_vq_supported;
     env->features = arm_host_cpu_features.features;
 }
 
-- 
2.43.0


