Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD07E63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXi-0002ZZ-Lj; Sun, 15 Feb 2026 22:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXg-0002Z7-8H
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:00 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXe-0002SA-9a
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:59 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-824a3ba5222so1458308b3a.2
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213497; x=1771818297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nr30QrVHuiZUYlgVuaIXnVQfwgC+Xsfy6MjmOV0NUmo=;
 b=rK7foNSmxhZ/btc9aSsGQecveeEJpag92txQ8F4jYGwUZfuxHTsVmXg/7zavIwcMog
 LIxxa3YM9XwnTXG9f8bLntldSLxBVrjRgb+w1b55HdylLyYnpjElICobzQvOY/vtqyXE
 SqBECBuunnn6/yQwed3q82zjbFkt+LrVej7NUSe7yjflHG12DPOUxMilQJmpwfrb32HE
 bOB61ZcphQfoM94hlKmpnfcRLTx8nk1xPOYb6MkWcr7hGm2j2eThPVv6OnoI+8R8L/P+
 Z+iBTorQKdYlePprk0zhIgY3MzPux9WzWQd52N2Lj6a7AKZyecyr8ij85Ns+R7qMOEd0
 dD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213497; x=1771818297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nr30QrVHuiZUYlgVuaIXnVQfwgC+Xsfy6MjmOV0NUmo=;
 b=Pel835DFBztMYqJBBCVIdXjYwD8HxaeAHR6uimRJKthVRlJ48PcTk8ELLDp+jF5yVG
 Y6W9S2evScS9Zx+Eon1hOjf875vg4X2zAfXInYB2Mo0q63aSFVWuOFTgehsUG64tiOWR
 /x6FVsrlJEnptwjAGEWIwIWezLcAFzAzv+212lLDfHMvR0gAysK8BT7mRtFecfWTHgKo
 kmbD3FYp2r/OK82ro4fztJ0eBAEoRKGCBshwyJPSgZCUtxxh7R8ynPZiGtNy5WB7qnsi
 AxgeDSNMhw2ih2x2vCPFXUoAuOPcfBCmiiBneuogxbB2dJPagnPzA+n0BsckqCHiMpcE
 DxlA==
X-Gm-Message-State: AOJu0YxVW15muELUGbf1kw6WQ9O9mU04BumvanbZwlUanDKUBGPZP2Vw
 16PDevxOCqAaY8LD1VfW904eynpbQ1TPSubEaW451oZRmJTcpL2g+UDtzTuSAoMubQvP/1Q7jyZ
 LeYHPbJ4=
X-Gm-Gg: AZuq6aLm5GYW3oJZt7FHeEjc/+GQ4c+Z+AuXD5dxQ9Ixg1CSu3SLmil1Tw0NDPdKOjY
 RcB2Rw3rjcN8JTdtXVN2s1M+vpW5REt/lQD0/vVleUiqmd6nZSOS0ZmorJYiTUIfWm1gM7F98r3
 mQk3CO/bdash1AJjpQ32npIewW9EAPZWkCQvjqG4qSXZnconvwZ2/ZagbMeh5q0EK4ZToYad9ep
 J3GLPX03X2I2/mQlm9wZout+RPxB06CrdjM52V9OqLRPOMMYUK+Ps00YTuU4Evn0Uni2J4nIt5z
 53RDBp4q0EmGgf86hS0bipmfIlukBvEsdsAQr4ci6+TU2rB3LcXSw6NaUXnXXN9wa97iDzQD6HA
 Iktaw6qXyaigMPPr1/tB+UbKhavr6OSEk/CZ3WwEx2HltlHE1iJX/m8eW3BR9kB4K8x7VTfRrvb
 HvpO/lGEMnPpeq5a9YXeWFQMhs4ipMUrgo
X-Received: by 2002:a05:6a21:4d8d:b0:35d:7f7:4aac with SMTP id
 adf61e73a8af0-3948398f0b5mr5536808637.47.1771213496754; 
 Sun, 15 Feb 2026 19:44:56 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 09/13] target/arm: Detect SME in
 kvm_arm_get_host_cpu_features
Date: Mon, 16 Feb 2026 13:44:28 +1000
Message-ID: <20260216034432.23912-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ccffa40900..979265a810 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -61,6 +61,7 @@ typedef struct ARMHostCPUFeatures {
     uint64_t features;
     uint32_t target;
     uint32_t sve_vq_supported;
+    uint32_t sme_vq_supported;
     const char *dtb_compatible;
 } ARMHostCPUFeatures;
 
@@ -273,6 +274,36 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
 }
 
+static uint32_t kvm_arm_sme_get_vls(int fd)
+{
+    uint64_t vls[KVM_ARM64_SME_VLS_WORDS];
+    struct kvm_one_reg reg = {
+        .id = KVM_REG_ARM64_SME_VLS,
+        .addr = (uint64_t)&vls[0],
+    };
+    uint32_t vq = 0;
+    int ret;
+
+    ret = ioctl(fd, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        error_report("failed to get KVM_REG_ARM64_SME_VLS: %s",
+                     strerror(errno));
+        abort();
+    }
+
+    for (int i = KVM_ARM64_SME_VLS_WORDS - 1; i >= 0; --i) {
+        if (vls[i]) {
+            vq = 64 - clz64(vls[i]) + i * 64;
+            break;
+        }
+    }
+    if (vq > ARM_MAX_VQ) {
+        warn_report("KVM supports vector lengths larger than QEMU can enable");
+    }
+    return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
+}
+
+
 static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
@@ -282,6 +313,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     int fdarray[3];
     bool sve_supported;
+    bool sme_supported;
     bool el2_supported;
     bool pmu_supported = false;
     uint64_t features = 0;
@@ -302,9 +334,13 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
     }
 
-    /*
-     * Ask for EL2 if supported.
-     */
+    /* Similarly for SME... */
+    sme_supported = kvm_check_extension(kvm_state, KVM_CAP_ARM_SME);
+    if (sme_supported) {
+        init.features[0] |= 1 << KVM_ARM_VCPU_SME;
+    }
+
+    /* ... and EL2. */
     el2_supported = kvm_arm_el2_supported();
     if (el2_supported) {
         init.features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
@@ -449,6 +485,17 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             /* Read the set of supported vector lengths. */
             arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
         }
+
+	if (sme_supported) {
+            /*
+	     * While ID_AA64SMFR0_EL1 is always accessible, if RAZ,
+	     * it's unused if !sme_supported.
+	     */
+            err |= get_host_cpu_reg(fd, ahcf, ID_AA64SMFR0_EL1_IDX);
+
+            /* Read the set of supported vector lengths. */
+            arm_host_cpu_features.sme_vq_supported = kvm_arm_sme_get_vls(fd);
+        }
     }
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
@@ -496,6 +543,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
     cpu->isar = arm_host_cpu_features.isar;
     cpu->sve_vq.supported = arm_host_cpu_features.sve_vq_supported;
+    cpu->sme_vq.supported = arm_host_cpu_features.sme_vq_supported;
     env->features = arm_host_cpu_features.features;
 }
 
-- 
2.43.0


