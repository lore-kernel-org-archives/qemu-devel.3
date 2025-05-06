Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE08C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXO-00036J-06; Tue, 06 May 2025 10:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVQ-00025b-BG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVO-0002AI-5W
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso5315785e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542564; x=1747147364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aj1LInBRLZfeL0vVJ4DPx0VjONBgyKGAHZpqEc/4nFI=;
 b=xaGyxGgsSYh6BeXkp1Lv3toHDNVbgcc0oZ5XD7crkASP0Btf9QVaOEnUQHK4zs+wEg
 EPU+yECvD2hfuTMDiOLj3QOmQuZGt7OikSMeW6AluNMlF3fLkK7VOOCDZgD6X1s7Dvb0
 USx4YbTByKQbzCSUTH2OXW+tdq0X7fEoMHvkgSvzcwUcrHa4g1eMHC0E/ASPQr/JB/+i
 on2pjfxTc9JsgpDXp+VsQOxLmkZ7SojLgflui9oQJowgFj01TWPrY+9xnR6deztxiv5k
 qh+QEzqL0+uy1JwMpJznCcUYckcdZ/l3DoHuBOrVTeuxN3Sychsro3Q09iJBxMkWR0JP
 3O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542564; x=1747147364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aj1LInBRLZfeL0vVJ4DPx0VjONBgyKGAHZpqEc/4nFI=;
 b=JAgI/0TQw6Isu7JT3ezLerkwqy/3MhSt/VhRq2GUR3r9fV6xfM9bZdHpICKz2VFrSn
 Om7k+lzie30/2j/+bKAE5172FlL/Y3hRObRVMR7mtqVIg9nAAoXE+krx39KTmbfzLf57
 D1iDgYTA6jEuXZc/e+Yg49FHfqZdAwb2vDuALHW08so5vwKwz3XojDjljqHd7IEq8lwt
 iEEDs7HYuP/h31uO8Edh1TL5Q/LsKPhHw7qjkEn5ULaY49UVpZSbMmiUinx8os5xoYSN
 QDywNI8eZXXDloMEBzxZwAy4/jd5OvAxCUYqKGlP/w/vznNF6zpBJBdyRXWGdCV/+Pb2
 StyA==
X-Gm-Message-State: AOJu0YylG0aUzkMuYsqMEFXVOVv7cwg8YebYXQqtHaLEAdZoWidydlit
 CCycTSjs3RQJ9c0No0zuCO5sHyP7Qd1AxQZDzdb+3RQP7BIzidNXLy3PzHwu22ePiXwitTlwYP3
 s
X-Gm-Gg: ASbGncuSuR8+hX1ZwEXMG7egIjNteBvjQAINOU7PEB19HH2wfSQOnlbhVRu9/v+AqTZ
 ASQDQIzDUlA7CLdg1gxafeZLKSnn8TXDp530gZBn7NUuaukbr5rvVm9lqzW+H5sPG9fVlsgZg0O
 V80VUlA1mUQYeCAbCIr5CsrmoHOS4vsjmqsv3Db8z23P1x08CVyTVGHwdOXGJ0LAKTKECgTGsGv
 O1Ihk2lPX7zrVfi1SgLOXs+Iml7okf1t0lOGasxl04WLCxwy2UmtwG5EJXA+2mZfbj71okwFXUB
 z6hqImpAQG5PxZkT8i6tU5P42cCkB/XNH5qNwCekIenx/6Y=
X-Google-Smtp-Source: AGHT+IHUZk3kZTe0pQbAnoxc9PJ6nNfKBAwRvV/tqcspTe+M/X7XgiYgpFGMTgszz96ZL2XsDACoNw==
X-Received: by 2002:a05:600c:528c:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-441c49473e7mr96300925e9.31.1746542564469; 
 Tue, 06 May 2025 07:42:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] target/arm/kvm: Drop support for kernels without
 KVM_ARM_PREFERRED_TARGET
Date: Tue,  6 May 2025 15:42:07 +0100
Message-ID: <20250506144214.1221450-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250318114222.1018200-1-peter.maydell@linaro.org
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
index 97de8c7e939..9c62d12b233 100644
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


