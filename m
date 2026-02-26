Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06451FD8FCF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiX-0005PR-8n; Thu, 26 Feb 2026 10:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiS-0005OA-Qr
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiR-0003lg-2w
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439857ec679so900176f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121349; x=1772726149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+W4n7F0RdzIOjtiRGCeQo/5csBStB2/lMq2PpMdFY+o=;
 b=v9dbha9ZYbiD0/GerfdKbdNhhaXBIKL6iPYP09Nezm9nRD9LTMuWpi8uvUaH52yc+9
 RFRb+a89WIjUO+MpZOIebquuFaG2dUdjiVTvIAXW8bqJpk41GJBJaRGrOwwxlddYL+3l
 duciEoqZu57ZDlhVkfbTEnwVP/vReg6nKTl5sxODM/0WzNOGti7uJEceMy2SWAXmsn7K
 6t8VYMSKC7msNPlS25WCswyUjRfxEv2pyestipia/f6svxMV5KgRj7wKXqS6GHdqLw34
 m1aym04yfyTtmgQW84FHEYpZk0QKj/rzr53oTH+iYOs2++7zT9yvhWaOrq7brLFRBi9C
 N8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121349; x=1772726149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+W4n7F0RdzIOjtiRGCeQo/5csBStB2/lMq2PpMdFY+o=;
 b=f/GR7p7WdMTgCKPS0stORyiUPRWFuGbM4v27Bl2VhBmPOo9/3zlDqYsa8x93wRSQT2
 0Fa5YRr+oDuW0fYo7lVvBinagV0/l8mv98kFF9g+YQkQq4TtEhZSHXjlOgM66MUoMnKw
 c8TWdo17an+7CHCxAjRPerBilZ365JHgNXt8TFeZxW9ZgesyWGyExhKQwRnZqujhXKJv
 pPQX4YIp8HFrDsvm8/0/ifU7SftN4avXz5oK5iZ6w6oNcf3kCiMT+2OWrFU5Jutih5n2
 mG8kFyDaC7mVYNSw+OdM172PoPI1YhDzikJ5SPB5IlefJ3WflJsoGzaffiiyX2v202n/
 qMnA==
X-Gm-Message-State: AOJu0YxNIfEWVn4iB8lc2Rzps6EknnIEqGKOqQuqWHYyScYUMVbJgISj
 libpsS/bTRPKH4kec7vUe1F+5ppwzdCSyOaSQ7TjeCf74AxVFZ+iNrD2j83Ju8PG1auyjq2Q4RB
 GQcz3
X-Gm-Gg: ATEYQzyXjKxev7fBrZn50LgcLVrvB+6XMqIy2pIhGSc4vovCCShIyLomWGhOCAHnUyL
 1a8am0O9b07ZO8BTewnuWA+TJpCVYmyl8fnnXAFbYMn6MgDMdVb3S9MKbJgjya2HH6+TiC94AgJ
 j/teWbxHk9UJePwLx//33HRWyTPX0c5U/DtypjZ1qlSR0jYIZ4J5lvD+4FPquZLLuhvFAFPdtSS
 V/rPjBtrxSb6jxkD+6ykIpA9WT3/roR7oLpJvE90OaAb4KQMt7mqTfuchDYYfaOuFhetBHkTyCc
 +uspYozI4V9dqaWbHNHTctigpKCcGLVCqZWOSDpwz64z3wXHm0LPkDeXe/4S2K3oPSvTypjK5Nc
 ssDsEdg5PlZEcf83HavgnNDANg5Joym1aJrs0vEFTQ3FUZIcU0tSvHht0h76oFSkPReHOIR1bWe
 EplLu5s5e7qtL0CdM4tASBs/kpOeFyU5VWbn4XM4h838NCYBHSKzjKcZ1R/OJEGmTshMtu83A0Y
 wlv0OVDi+k8DRZ0sHRgrkWTzYQTqOs=
X-Received: by 2002:a5d:5d85:0:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-439942aa2bcmr8986689f8f.14.1772121348540; 
 Thu, 26 Feb 2026 07:55:48 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] target/arm: Move kvm_arm_sve_get_vls within kvm.c
Date: Thu, 26 Feb 2026 15:55:26 +0000
Message-ID: <20260226155535.1171290-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Prepare to adjust the invocation point and visibility.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 108 +++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c46ee9620b..2b74901d54 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -243,6 +243,60 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
+uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
+{
+    /* Only call this function if kvm_arm_sve_supported() returns true. */
+    static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
+    static bool probed;
+    uint32_t vq = 0;
+    int i;
+
+    /*
+     * KVM ensures all host CPUs support the same set of vector lengths.
+     * So we only need to create the scratch VCPUs once and then cache
+     * the results.
+     */
+    if (!probed) {
+        struct kvm_vcpu_init init = {
+            .target = -1,
+            .features[0] = (1 << KVM_ARM_VCPU_SVE),
+        };
+        struct kvm_one_reg reg = {
+            .id = KVM_REG_ARM64_SVE_VLS,
+            .addr = (uint64_t)&vls[0],
+        };
+        int fdarray[3], ret;
+
+        probed = true;
+
+        if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
+            error_report("failed to create scratch VCPU with SVE enabled");
+            abort();
+        }
+        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
+        kvm_arm_destroy_scratch_host_vcpu(fdarray);
+        if (ret) {
+            error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
+                         strerror(errno));
+            abort();
+        }
+
+        for (i = KVM_ARM64_SVE_VLS_WORDS - 1; i >= 0; --i) {
+            if (vls[i]) {
+                vq = 64 - clz64(vls[i]) + i * 64;
+                break;
+            }
+        }
+        if (vq > ARM_MAX_VQ) {
+            warn_report("KVM supports vector lengths larger than "
+                        "QEMU can enable");
+            vls[0] &= MAKE_64BIT_MASK(0, ARM_MAX_VQ);
+        }
+    }
+
+    return vls[0];
+}
+
 static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
@@ -1914,60 +1968,6 @@ bool kvm_arm_mte_supported(void)
 
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
-uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
-{
-    /* Only call this function if kvm_arm_sve_supported() returns true. */
-    static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
-    static bool probed;
-    uint32_t vq = 0;
-    int i;
-
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
-    }
-
-    return vls[0];
-}
-
 static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 {
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS] = { cpu->sve_vq.map };
-- 
2.43.0


