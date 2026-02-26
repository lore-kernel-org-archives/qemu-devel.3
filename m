Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75682FD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiZ-0005Pd-5w; Thu, 26 Feb 2026 10:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiT-0005OC-1Q
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiR-0003m1-3U
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4398913af88so940980f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121350; x=1772726150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OV2bwWbH/FypjV7kt9sYi2EC7GB2lhasvy/QfiSyHxs=;
 b=EnQWec010UGpd98SS75PJjHBDpRNkZOt/WTssm03y3a3CsLY7YFDSZXicmnnxEa0CV
 cW/ByKMHfI8jK+tLLo6c62fEmorAdimpu3wJItHfry1roqFK5YSaIHTelTlU52dQjz2f
 7djq65PVLmWd38XtWYd9xqfBk/pT6tl4aP2XGoxWEraNu+XoBB/hDiFoqQCAs0RIehNm
 tGvNMALn6z5+Rg3RDg+8myX6ZSONsYNNJ4F0ftono7q7pfM/P+4E7fVBvHXCbYwTcQGY
 K5eHL0gtdhP8tFOj/JFz28RHU+QbTwL2WhtjYSNHq7aHo/hAfxCrOtEj6odne1tnZ3nD
 zLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121350; x=1772726150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OV2bwWbH/FypjV7kt9sYi2EC7GB2lhasvy/QfiSyHxs=;
 b=CAeUHBYGQ4tmWOKa7AAU2Mr0R2FmDHu/JOb9s8rxugHnRaIPpmHeWpMSakI6ebz8ml
 J1A5vd2uhoB299E7Ay33ZaDc1TzQsUyFyrt+UNLaRHpUKAaWE0evj7/5AXUIKEEdrNTT
 yWRjrt2Ihj2s/Yf2GFmC7XKSOFJTZCf6Tw5oq9YWHEgVc6AH0TIHeaJiYmhrOo+MM2eW
 YsgIOfzIatpVcp1WqHdPoyBLZAQRazQukwvgogJC4saQ7d0scNUEE44I4+nv+eQVFGac
 SNuX/dBCw3r5Pwz4bSt27uH8FqTWLn5tZgKsqv0pJoccJ4Mr9LPsupUPafRiLhPJlvOq
 vM7w==
X-Gm-Message-State: AOJu0YwYTs7olNhiUhu1Q51n362zTQDLhLXhjARJ8cE2dvuGOK2DlE44
 f/9SzdOQaFQ883Tw0UZoYlz68yOIp/e5rZr+rXwRy2Nb64oY3Q9ipF7z1Ai7bXp7SNrrRfCB7Qn
 EM5ED
X-Gm-Gg: ATEYQzyg5C0V74E+pDtDx84nVclHytHkcEVgWzDXABCNv5NX6Zi+uKYBJbHn7Psktzn
 Pnw0/YYQuqNXwfigkGpBDlUBb084y2/alvk4Cx46pBfSwYdcMXH50FnmqKsHgCNy49NO33wA2FP
 cL2z1JOCrar8I8RNOa0EyLrZmudelHPXIZwukhCSemI8jiWTgtMxYRVOkVOhkTaJUDMVQ96aVzQ
 0nE2S2umDJw0gNYMJbCk1lim+yAg7nXmVftFo86OY14hhMNfOlQS2dHgJV/Tj7nfVnpNTVzlcwy
 cEDg4fxtEtviXmfCrlosLYwqqgbyNzOMuACodmrgpUwQH7hUdu9amFMfr3fOpGtdVt93bET7oHK
 5uIFK+BuK4hNRNVk4VGKAGdxlKzj34C5wVlhbjeT5woSUPPsRZUhJPRibqO+axL90TaME/zZHiF
 X89FqvO99MpWWDLgGC70xdJnNwwmXqp2lh4RvbxsE3TFWDKb7p04vUZPFgkSEXUGB61vIYinO71
 ZsuNqLibVrj48SX3Wchlu9k39fzMwI=
X-Received: by 2002:a05:6000:2f88:b0:437:6c1f:de27 with SMTP id
 ffacd0b85a97d-439942ed02emr9415290f8f.37.1772121349432; 
 Thu, 26 Feb 2026 07:55:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] target/arm: Init sve_vq in
 kvm_arm_set_cpu_features_from_host
Date: Thu, 26 Feb 2026 15:55:27 +0000
Message-ID: <20260226155535.1171290-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Probe for SVE vector sizes with the same scratch vm that
we use for probing other features.  Remove a separate
initialization path in arm_cpu_sve_finalize.
Unexport kvm_arm_sve_get_vls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c    | 20 +-----------
 target/arm/kvm-stub.c |  5 ---
 target/arm/kvm.c      | 73 ++++++++++++++++---------------------------
 target/arm/kvm_arm.h  | 10 ------
 4 files changed, 28 insertions(+), 80 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 87b8c586c4..209ab5c344 100644
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
index 2b74901d54..b00172a289 100644
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
-- 
2.43.0


