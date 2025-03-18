Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D29C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuVL6-0000r5-MJ; Tue, 18 Mar 2025 07:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuVL2-0000q4-KV
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:42:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuVL0-0001G4-Jv
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:42:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso3139913f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742298144; x=1742902944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ny5Q8iZtuoRdzdW7TydI30as0SJ5q+BAUtft5Hm6rtM=;
 b=eXdOiGI/8XELtjNn4e4j7ABElaryhzYXjIf7idukmH4cY7SJ4Q5lDx+wjL3uUY1jKU
 PIv1yrwl3u/Jy7r021W5IfVYFZhy24xZDwprXzWg0vdWxtJuRLJkXn5UsWS4vxosOShT
 1ZgHRT1+cL7QNAio1d2mlOMLlV+QNIfRhgvoeqtp4Ft19NKHP0AbqGSKMLZQnqyu6P1I
 LKK3xrWFYAVUqW4BRE6uElf/hV/r2X/zglE43sBfSglqyvNbpWLxqAGfciEzahH92cE7
 BhhDDP5SeHILlQ0idIAtJMSRWdeFBulz3n2PsmnyZSf7LmFzph5mpC1TQigTgWKABzqc
 YFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742298144; x=1742902944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ny5Q8iZtuoRdzdW7TydI30as0SJ5q+BAUtft5Hm6rtM=;
 b=l8ZOImrmSP2Zm3KKN1nC+gz0VaVl9i2ON9ukgN3okDIJeBpYQ/mgzn80HDyWvsyD0u
 Xi/KYZZmZEWZGqzNSjalxxUUBEYQj2Jh6vTiPh+E6rDd+S1y/w+ZIHC8AtMFovzcw8eN
 zA42UZwyhoUwXPQvItaAf/Y+C9Amfsxr1VkNGMIA74IMIHUI9EXeuHoRfOQugCxIj9Cs
 Z3Xm9tzICMr9o0uoC90A/qi6O87IkZmOjNSPUbKmt+lVlPl1rDcbxmsFv9hAYRM8MoAM
 jtBlSsyhhAkYn9aG74URHCuesvCVDu4S7Ts3UMs7E9NONagFkP0PTAZTBKak4Wph7KgM
 u51A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEcMykepcAJamGP6LIVaIu8aSxZw5s++lZ9zrQ+nWLi91F09dC/+ubUf78C3mt+Qo5pAa5IdbhKAPp@nongnu.org
X-Gm-Message-State: AOJu0YzHV2OcE1ZOB8qhUdJ+Hqaolnd/FaG/aVxzRRjnAGg1mwJB7VeL
 HyJu/rMY42PJyOK6+ocCxSf/tSIdaQypZ/4q3aPFcaqSwXRJAJmrKbdqA9CDGpw=
X-Gm-Gg: ASbGncuzEiWvK6y98wjf2dfNGDyV90N7G8Mjugjj9jNlOlCmccM4YOxv1bIRBN44ORR
 e6YDVwRDvd3yfJE9aF4xHT9azslZx5eSCDfMmsYhb5U4uctah2xKgSnyGkb10TK9rMXQqhAfoK+
 V8SYEFe3nJxZ1oKktrZ0kuYFOsw1OqX3YS6ZGRbpVQcV+n8KfzGVv8UM1iNnp+O6eDfothm7ouY
 jyrzDLmtb6MAO2FkvSbBRlztDAVPJXtjHtQ6UrTnTqJmc/xNo9RRkrYjH+qCMw82jQziel/T+oH
 LHT6UUuwrYYc5qwIYkKnyDGebjqpucG4GrkwJpTO4QFRJYnu96c=
X-Google-Smtp-Source: AGHT+IFW1ZlPDUM28YipJdnncd8jgiecZNBOxXVSkSFwOi/Vq3l5jtM7uy1ySbFJKWtEefW4MDPYWA==
X-Received: by 2002:a05:6000:400d:b0:394:d0c3:da5e with SMTP id
 ffacd0b85a97d-3971f5114b2mr15155734f8f.47.1742298144374; 
 Tue, 18 Mar 2025 04:42:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39965410600sm5895203f8f.50.2025.03.18.04.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 04:42:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-10.1] target/arm/kvm: Drop support for kernels without
 KVM_ARM_PREFERRED_TARGET
Date: Tue, 18 Mar 2025 11:42:22 +0000
Message-ID: <20250318114222.1018200-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Our KVM code includes backwards compatibility support for ancient
kernels which don't support the KVM_ARM_PREFERRED_TARGET ioctl.  This
ioctl was introduced in kernel commit 42c4e0c77ac91 in September
2013 and is in v3.12, so it's reasonable to assume it's present.

(We already dropped support for kernels without KVM_CAP_DEVICE_CTRL,
a feature added to the kernel in April 2013, in our commit
84f298ea3e; so there are only about six months' worth of kernels,
from v3.9 to v3.11, that we don't already fail to run on and that
this commit is dropping handling for.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h      |  7 +----
 target/arm/arm-qmp-cmds.c |  2 +-
 target/arm/kvm.c          | 55 ++++++---------------------------------
 3 files changed, 10 insertions(+), 54 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 05c3de8cd46..5f17fc2f3d5 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -97,10 +97,6 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu);
 #ifdef CONFIG_KVM
 /**
  * kvm_arm_create_scratch_host_vcpu:
- * @cpus_to_try: array of QEMU_KVM_ARM_TARGET_* values (terminated with
- * QEMU_KVM_ARM_TARGET_NONE) to try as fallback if the kernel does not
- * know the PREFERRED_TARGET ioctl. Passing NULL is the same as passing
- * an empty array.
  * @fdarray: filled in with kvmfd, vmfd, cpufd file descriptors in that order
  * @init: filled in with the necessary values for creating a host
  * vcpu. If NULL is provided, will not init the vCPU (though the cpufd
@@ -113,8 +109,7 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu);
  * Returns: true on success (and fdarray and init are filled in),
  * false on failure (and fdarray and init are not valid).
  */
-bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
-                                      int *fdarray,
+bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init);
 
 /**
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 883c0a0e8cc..a1a944adb43 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -46,7 +46,7 @@ static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 #ifdef CONFIG_KVM
     int fdarray[3];
 
-    if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
         return;
     }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb234..568561c6d54 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -100,8 +100,7 @@ static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
     return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_FINALIZE, &feature);
 }
 
-bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
-                                      int *fdarray,
+bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
@@ -150,40 +149,13 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
         struct kvm_vcpu_init preferred;
 
         ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
-        if (!ret) {
-            init->target = preferred.target;
+        if (ret < 0) {
+            goto err;
         }
+        init->target = preferred.target;
     }
-    if (ret >= 0) {
-        ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
-        if (ret < 0) {
-            goto err;
-        }
-    } else if (cpus_to_try) {
-        /* Old kernel which doesn't know about the
-         * PREFERRED_TARGET ioctl: we know it will only support
-         * creating one kind of guest CPU which is its preferred
-         * CPU type.
-         */
-        struct kvm_vcpu_init try;
-
-        while (*cpus_to_try != QEMU_KVM_ARM_TARGET_NONE) {
-            try.target = *cpus_to_try++;
-            memcpy(try.features, init->features, sizeof(init->features));
-            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, &try);
-            if (ret >= 0) {
-                break;
-            }
-        }
-        if (ret < 0) {
-            goto err;
-        }
-        init->target = try.target;
-    } else {
-        /* Treat a NULL cpus_to_try argument the same as an empty
-         * list, which means we will fail the call since this must
-         * be an old kernel which doesn't support PREFERRED_TARGET.
-         */
+    ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
+    if (ret < 0) {
         goto err;
     }
 
@@ -259,17 +231,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     uint64_t features = 0;
     int err;
 
-    /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
-     * we know these will only support creating one kind of guest CPU,
-     * which is its preferred CPU type. Fortunately these old kernels
-     * support only a very limited number of CPUs.
-     */
-    static const uint32_t cpus_to_try[] = {
-        KVM_ARM_TARGET_AEM_V8,
-        KVM_ARM_TARGET_FOUNDATION_V8,
-        KVM_ARM_TARGET_CORTEX_A57,
-        QEMU_KVM_ARM_TARGET_NONE
-    };
     /*
      * target = -1 informs kvm_arm_create_scratch_host_vcpu()
      * to use the preferred target
@@ -300,7 +261,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         features |= 1ULL << ARM_FEATURE_PMU;
     }
 
-    if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
         return false;
     }
 
@@ -1835,7 +1796,7 @@ uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
 
         probed = true;
 
-        if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, &init)) {
+        if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
             error_report("failed to create scratch VCPU with SVE enabled");
             abort();
         }
-- 
2.43.0


