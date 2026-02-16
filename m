Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48EAE63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXW-0002WT-10; Sun, 15 Feb 2026 22:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXT-0002WB-QJ
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:47 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXS-0002Q1-3I
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:47 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so19548055ad.2
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213485; x=1771818285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i0CkMEqHWZZBF7b/EDsRH9ZprXMms0dNpE5IJYi11qg=;
 b=rgPFn0YQE/4g1NAjK/s8UMKGOwQZ9o01TYXuhcv+CZ4OFEPE3DNzfP5gITVIl577Xs
 7zglWArlpHMTw3docllzI2o9sVob8i1UcCYxnhNVrjuq994tlCUZJmruwF2pIw/0TlT+
 j3f+A79lmJKbokItKew8L/tqQ6KHqwnsaNajd9CqEux4YYb8q3CQGmdq5+r4MNTl7509
 uwDSt7c0ybNdfAVDajkLCYg08M5VLWhbUIyCT3VyYURN46mDUKWyycYXLkK6czETPXzt
 ER4+wnvFCP4HC8qzC9hJ8J+UGoYPyIPDkZTD1EXZzvKtiPBf4kU/pF4wJ0rq7NiceAsB
 mBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213485; x=1771818285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i0CkMEqHWZZBF7b/EDsRH9ZprXMms0dNpE5IJYi11qg=;
 b=BijTVqMz11VxwXWCJ5V9+b+iR8xq3WKx8rD/fQdB2eg7TpWm9V2rDNd8pDFJZVFb2j
 65SmOWjOW/kzKj6lXVojNNu1vyPg+eqX5XF8YN1jZ5nNv7JBuYvMhY66eXNhcWPO/UII
 tQcfxu+e+lx5WBQCvmJZOznP0Et7uF/Ubq2CqG9NSUsjoBvKHLtfVoIbDajBx6NIZ0Kf
 tMc4wVS4v7JHSev133jAPtbxP0yaoxVMCeDb0m32dYSLgiyiB0L+M3BrNHXSTruQkZdW
 3o7jEvN4dcUcX7ekTTY+U8alnytZuC6ahPOyQKpupOl33LMLBvivhCSum4rPDruwnaWh
 hZsw==
X-Gm-Message-State: AOJu0YzlcjHCxrudRq4r438IX4j+EYUbsRyacBQ3W6O8QdyQF86j3+xb
 LIn7obC8c+8RE0xFfLvy0G+lURjtpI1lXo/67AkbGMiev8UUL/A1VfBnTveg5pXH9oRA38SR+5u
 kLKxQJ+Y=
X-Gm-Gg: AZuq6aImATcNd30SOWFM2PJ7kr9uY8f6RadZ9dFSbtAyBa+lrJxMiQBCdXOJylkCElI
 UnoZtmGy7hZItQ9Kk/12pFKgh21wEpJsiMhxWsj7TwN0KQMQPUx+Shv3B20H6BQMUnKVr+HEQZ6
 Uey2zkhWv1+tq4SqzkdX0G5HNVUYULRjMqm8ErHJdFa5aMkLTMR6s06TaLb9ZL2XjxCRm9gvxPo
 2LdZx6K51mCKfeqi/LLXZ5TgYdY6RSV++Xum4uOgp7pDMr6hC9iYEpKVgN1o/JnXXddZ7yzC72T
 MFe0ylmp9A9IRSTt8LEpWGe1+YRsfGD6H1KirkwgZOMuR2bovDvn0TgdSn8TBxqjLYRk3U/gycl
 uBVjdKt8eUf/tn9qQV8iCY0u9/z45nXxbDBxXf6jy5A/VAX3f2mJcndPjViXTQCiY1fDvGGEzQG
 351H4umW8xTTx//nZtkWuKmmGfh22qDIuT
X-Received: by 2002:a17:902:d48e:b0:2a9:2942:e15d with SMTP id
 d9443c01a7336-2ab4cf4f447mr115964305ad.5.1771213484686; 
 Sun, 15 Feb 2026 19:44:44 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 03/13] target/arm: Move kvm_arm_sve_get_vls within kvm.c
Date: Mon, 16 Feb 2026 13:44:22 +1000
Message-ID: <20260216034432.23912-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Prepare to adjust the invocation point and visibility.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm.c | 108 +++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ded582e0da..e0fd79b78c 100644
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
@@ -1886,60 +1940,6 @@ bool kvm_arm_mte_supported(void)
 
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


