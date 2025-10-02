Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B09DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 10:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4GNN-0001W5-0Y; Thu, 02 Oct 2025 06:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4GND-0001UC-0i
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:17:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4GMv-0003iD-4q
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:17:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so556339f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759400213; x=1760005013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBgpG96y2lKR3XM562KnP0FZkiyq1hYqwBo0lMKPO14=;
 b=cvLL+NT+6bkyIY6eQaRGQuxmId0wRE+7nuOghrs+VgkWaT6981Z2URkBUpMnjN7RV0
 q+8lJlTuY8pvlNgVU/pH2PPZrNUKFQ/7mbk2umzxNGwYzRAQufzwhSOxpdUmlG2Fo5yz
 /4BGH0oZ6LNMvjJ1yp8oIFH+wsNaOWQ1bDF5wtoJK/4U1XTG9RqsQsHNoEpHpxEyQ0UR
 VGnpJcoJwQsC8FM4oogwIatUVpFp5ZvJc0QIAZ3SREu6stZcBRGeALJvtr7yT9tg5Eyz
 itXw3Nh2JzcA8bIkhdV2ACk8RM5kNsE1l23Wc1ADAH2sU1j0cernazeOhm1b21x3mTOz
 cfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759400213; x=1760005013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CBgpG96y2lKR3XM562KnP0FZkiyq1hYqwBo0lMKPO14=;
 b=nsOpitpWYxlW2Iaied92jUWcikn4q+wfJtS9sVbYXbH56bYmDRjq1UriGU8fl7rpJ+
 PRJErGQHF+vnRwpIfsy5OVqRSKkzrjRK3giYSD6XDZNNbMDLytZlniq/7aB8SvCy4bFA
 Lbqwe/erGqSPSaB7de+pTRVAjSWJNoaG0dx6oDVgtKpbyEI6MuHrgAQ0hPCDN6BedY/D
 2F/i1NfFui90qVuXoi8ThSD6sNVUE8uFX7UpQE1r0EZZVmHs8kK3G2Wxj4QwV2WvIpOY
 0jqVwg/9u+r88c3Mhe5zZhzb2MmeYMq5bp7zfiNd/9/ACuQmStAzBy+mrlZp/IHq0XGp
 f2CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFsqzLmySntYCGEI+owKS3zt2VGh00Lv6x2on5gmD6miaZWtOOVGjX/cXZP+KcwaP9q5PTeWQAm2Eb@nongnu.org
X-Gm-Message-State: AOJu0YyJRUpLob6qdKU2rB3Yul93h7g3zTgFcy9Vm0JgM7+Hwokqt9Mt
 nbCB64aNKqr8Sry7efowGn+A6kPmjrtYNGN2PuAuigGa7B0TW05bDKmmi4s+0hEAZNw=
X-Gm-Gg: ASbGncvpyuCj6Byv8vtMcjjs1sQaOdjEI+dZKOLMvOqSWXXSEgM2JggxrAFcB9h21s7
 5OjF9ptg3KRyri2IToNK77Q0Ui5GT1KGT90epgJjchzQJ09/QhzdMzSmKag7vBf1ciB+ZCFsLS8
 pD3/GX6ysBeV5DEY8vMiR6iyZ/y0qoFgztUQlUDBto5vgKTgYKs+AoQzk8dYuVgDM/HKcoqA/QW
 ugrMot7s01OPHCVwKmibmRkaII4GNNDTwroA2x98nCPmjn+XfM5xyNPeGx8buHOfzvenQx5M0LT
 HciFmea/R4JkVBAYWnhPitIF9qqVFgRZez7zJ4cvb/UeKvCrQjr6dRPlUpmV5Nsw5IhBBaLpH9i
 K0WFLwsCMr9ExjWq+Sd9Dk8YmeCaTEKGmywX4GXbadp+WsuKHLKSqjmcKCfET9M1/pAQ=
X-Google-Smtp-Source: AGHT+IEdfyV10SxaVF2JzlGoG0ODRu/WHoFKdhHC/kWiGy39gP7L3l9HKnavGfoB5g/iw4Jth+0/+g==
X-Received: by 2002:a05:6000:2002:b0:3ec:75c0:9cf5 with SMTP id
 ffacd0b85a97d-42557a1599bmr4680127f8f.47.1759400212655; 
 Thu, 02 Oct 2025 03:16:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9780sm2978809f8f.29.2025.10.02.03.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 03:16:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [RFC PATCH 2/2] target/arm: Allow 'aarch64=off' to be set for TCG CPUs
Date: Thu,  2 Oct 2025 11:16:48 +0100
Message-ID: <20251002101648.2455374-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002101648.2455374-1-peter.maydell@linaro.org>
References: <20251002101648.2455374-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Allow the 'aarch64=off' property, which is currently KVM-only, to
be set for TCG CPUs also.

Note that we don't permit it on the qemu-aarch64 user-mode binary:
this makes no sense as that executable can only handle AArch64
syscalls (and it would also assert at startup since it doesn't
compile in the A32-specific GDB xml files like arm-neon.xml).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst |  7 ++++---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/cpu.c                 | 36 ++++++++++++++++++++++++++++----
 tests/qtest/arm-cpu-features.c   |  8 ++-----
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 37d5dfd15b3..7c339f1fb71 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -24,9 +24,10 @@ QEMU's support may be limited for some CPU features, only partially
 supporting the feature or only supporting the feature under certain
 configurations.  For example, the ``aarch64`` CPU feature, which, when
 disabled, enables the optional AArch32 CPU feature, is only supported
-when using the KVM accelerator and when running on a host CPU type that
-supports the feature.  While ``aarch64`` currently only works with KVM,
-it could work with TCG.  CPU features that are specific to KVM are
+on the TCG accelerator and when the KVM accelerator is running on a
+host CPU type that supports the feature.
+
+CPU features that are inherently specific to KVM are
 prefixed with "kvm-" and are described in "KVM VCPU Features".
 
 CPU Feature Probing
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 602f6a88e53..201fb93ac7e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1066,6 +1066,11 @@ static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL2) >= 2;
 }
 
+static inline bool isar_feature_aa64_aa32_el3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL3) >= 2;
+}
+
 static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RAS) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e0376b02119..79d71b2e8d2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1220,10 +1220,38 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
      * uniform execution state like do_interrupt.
      */
     if (value == false) {
-        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
-            error_setg(errp, "'aarch64' feature cannot be disabled "
-                             "unless KVM is enabled and 32-bit EL1 "
-                             "is supported");
+        if (kvm_enabled()) {
+            if (!kvm_arm_aarch32_supported()) {
+                error_setg(errp, "'aarch64' feature cannot be disabled for KVM "
+                           "because this host does not support 32-bit EL1");
+                return;
+            }
+        } else if (tcg_enabled()) {
+#ifdef CONFIG_USER_ONLY
+            error_setg(errp, "'aarch64' feature cannot be disabled for "
+                       "usermode emulator qemu-aarch64; use qemu-arm instead");
+            return;
+#else
+            bool aa32_at_highest_el;
+            if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
+                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el3, cpu);
+            } else if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
+                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el2, cpu);
+            } else {
+                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el1, cpu);
+            }
+
+            if (!aa32_at_highest_el) {
+                error_setg(errp, "'aarch64' feature cannot be disabled for "
+                           "this TCG CPU because it does not support 32-bit "
+                           "execution at its highest implemented exception "
+                           "level");
+                return;
+            }
+#endif
+        } else {
+            error_setg(errp, "'aarch64' feature cannot be disabled for "
+                       "this accelerator");
             return;
         }
         unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index eb8ddebffbf..66009c3900a 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -493,12 +493,8 @@ static void test_query_cpu_model_expansion(const void *data)
         sve_tests_default(qts, "max");
         pauth_tests_default(qts, "max");
 
-        /* Test that features that depend on KVM generate errors without. */
-        assert_error(qts, "max",
-                     "'aarch64' feature cannot be disabled "
-                     "unless KVM is enabled and 32-bit EL1 "
-                     "is supported",
-                     "{ 'aarch64': false }");
+        /* TCG allows us to turn off AArch64 on the 'max' CPU type */
+        assert_set_feature(qts, "max", "aarch64", false);
     }
 
     qtest_quit(qts);
-- 
2.43.0


