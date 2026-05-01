Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89E7CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuI-00042d-Ud; Fri, 01 May 2026 06:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuA-000403-9b
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku8-0000AB-Dh
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so26211545e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630526; x=1778235326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2YjxkgDmODhzB8F97AzDnOR+tGT6XYFOQgHnOUXmosQ=;
 b=oRXoGm9gk7R71IyQxNkHRQyGzFLOiB2vp5S6Ba3YLdZIh4Pe9X9T8jTjrkOWvj5vmS
 ps9FAYw5mONzDIsGcWE8nr2YqpT+ubJIFc3aG2jgGdGi5H4LOnvTXwKX1d9Oh1h5ICzx
 WpFuzt6rC0AT6/E6lepCyWnffvQYinCcYbrPA69CordLQ4GZ1jQvaIKGe7flDDGORRQl
 klTDx+9/pKlHkR7KwlASUiOKk5wP8/fVEVFbYpmxO1iFJLOOnTQo9sDKpr2T2BCBPx60
 3Jzy1ldJYHhLV79KPf2t/6qgnBHUHQE1A9hNrRypCtmaDJegTqeXZNv1U9kNGGYX8qjQ
 5avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630526; x=1778235326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2YjxkgDmODhzB8F97AzDnOR+tGT6XYFOQgHnOUXmosQ=;
 b=aDv1rorr6OiB5jocuHs2KgYtWdWFHz1xYSY9ydhbsCIAs1lR2w2b/SkeVQXnCVBsuF
 3ZyxO5s/1u/PHcp492LdZYbWhL0TMv1XuVt6HxXOsya4pcEqvsF0PEQ590fCOhFM4PwT
 Qw4QZreoV5yvg8guB49rHLtknp/uuUU+lWtghwfBceqa2O+bNdibA4ZcJRWQ1K3PrjUJ
 KkZEibH75VL7wTYmwV/R3lwDTp9UVhOzwuupaG53zdrCrHfuzTIRQEqRrTFu4YJqcuHr
 nty5GTJ5FkZcuex89Kr37tAd5VetDdxLSCstxbBpFD+tizEZB2Yk31R+JF0zcOXvo/9e
 vadg==
X-Gm-Message-State: AOJu0YwgPJ0enM35tDP8Ni4AtoAYhzJb+J6k8sBlekrubA/ddMGlJV31
 a67CuG6VMlg1VsNb2ECC7XixZwZ8Kg1wXsOmwVxdjjqwrPJI49VK85EcMY/MdLW02jBtZv60EMT
 mn3oi
X-Gm-Gg: AeBDieuJSAUvPA5HFCUNUpjhyPuuEIZo77GjAHyOxU9AaeOHrTj0IE1wcG0CdK7IDi6
 I7pGYMoKEnRZU8uQWYrczUDT4z4W0vCh5zRedEmHtvs8VLaE9JMRuqE/aCb199KtlbAQAbUFU31
 L+cg2Z4Dv2L9+KMSpcKa2XXB03B9PKIYMIUouNPT3Z9HuD8O9X59u1Rrwbreu86Pe9C4mMldqIa
 Z5f8PCg1thEIUAiOjmRBDZY+YhgljmLCvLDsZtOPuN8+jtptrvaIvwde+R10Pr6rtjmnjkN1DFm
 BNqGHdU9cZGNpOSbh/BC9PPv72RL7U0HN4+nxZynMvPqijPNg4r58yC70KJIyraFqmPR7ssMchR
 lAvkd0GVu1jTSjNmbgzvhdtGnEoUAOCIEJYq1quxdSzC29XgQuuGnhGO/LUzqMdic9MetjwOBCp
 uecWzCjL6dULIcbh+dR+PGJULSaNLWR7WBhPxWUrGIAVfi17KcZMUCaxr26RzwRf9FOm0891Jdy
 UE9SRYC5TruEBpHUFxgficQEYR7yXz9YfrjScpCe2uUlhqxruFg
X-Received: by 2002:a05:600c:1d1a:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48a84458d16mr114107105e9.21.1777630526469; 
 Fri, 01 May 2026 03:15:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/28] target/arm/kvm: Cache host CPU probe failure
Date: Fri,  1 May 2026 11:14:50 +0100
Message-ID: <20260501101505.3485916-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

kvm_arm_set_cpu_features_from_host() does not properly handle host CPU
probe failure with caching. The current algorithm can be summarized as
follows:

    If dtb_compatible is not cached:
        If kvm_arm_create_scratch_host_vcpu() fails:
            Report failure

        Cache dtb_compatible

        If getting register values fails:
            Report failure

    Report success

This algorithm has the following problems:

- If kvm_arm_create_scratch_host_vcpu() fails, probing may be repeated.
- If getting register values fails, later invocations incorrectly report
  success.

Make two changes to fix them:

- Cache dtb_compatible whenever a probe is attempted.
- Record probe failure by assigning QEMU_KVM_ARM_TARGET_NONE to
  arm_host_cpu_features.target.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b8..7d194ea112 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -273,7 +273,7 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
 }
 
-static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
      * fill out the ARMHostCPUClass fields accordingly. To do this
@@ -287,6 +287,13 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     uint64_t features = 0;
     int err;
 
+    ahcf->target = QEMU_KVM_ARM_TARGET_NONE;
+    ahcf->dtb_compatible = "arm,armv8";
+
+    if (!kvm_enabled()) {
+        return;
+    }
+
     /*
      * target = -1 informs kvm_arm_create_scratch_host_vcpu()
      * to use the preferred target
@@ -326,11 +333,9 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     }
 
     if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
-        return false;
+        return;
     }
 
-    ahcf->target = init.target;
-    ahcf->dtb_compatible = "arm,armv8";
     int fd = fdarray[2];
 
     err = get_host_cpu_reg(fd, ahcf, ID_AA64PFR0_EL1_IDX);
@@ -454,7 +459,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
     if (err < 0) {
-        return false;
+        return;
     }
 
     /*
@@ -471,9 +476,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         features |= 1ULL << ARM_FEATURE_EL2;
     }
 
+    ahcf->target = init.target;
     ahcf->features = features;
-
-    return true;
 }
 
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
@@ -481,18 +485,20 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
 
     if (!arm_host_cpu_features.dtb_compatible) {
-        if (!kvm_enabled() ||
-            !kvm_arm_get_host_cpu_features(&arm_host_cpu_features)) {
-            /* We can't report this error yet, so flag that we need to
-             * in arm_cpu_realizefn().
-             */
-            cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
-            cpu->host_cpu_probe_failed = true;
-            return;
-        }
+        kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
     }
 
     cpu->kvm_target = arm_host_cpu_features.target;
+
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
+        /*
+         * We can't report this error yet, so flag that we need to
+         * in arm_cpu_realizefn().
+         */
+        cpu->host_cpu_probe_failed = true;
+        return;
+    }
+
     cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
     cpu->isar = arm_host_cpu_features.isar;
     cpu->sve_vq.supported = arm_host_cpu_features.sve_vq_supported;
-- 
2.43.0


