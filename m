Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F09F8D762
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDPyi-0006Ay-Kh; Thu, 16 Apr 2026 12:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyh-0006A7-30
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyf-0007ou-7Z
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ba840146so81567965e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776358443; x=1776963243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxoE2sQDfNJcl7sNbi2G1nRN3fSKrRDunzLrpBK4/AE=;
 b=Oirh1zMyfH4drx6HVEBfPNQWOrUMGP1xxYNGXtRQT39JBCQqGM5oZg9KoTQHDGkApY
 vIrxu8fxwPruZ9y0v6faOh+oVAAqdhI4J8gVXaQfzaKxKWdqXac/qNd5EAGAh4i+6t7n
 RHHd44Gd52Ns77ofBfBPykXrnavZdDmwPVjmDml7Rv2qTd0n9r4JS5RODHdvl26pSBQp
 ZISe1LLcgPdpdWuchE4uYsWM68qBRn6L9dafFg59uGt0lFeUdIwgzN68tYCk6frQIU42
 zfUTyHyrTsOBakRZcyKcDG7OTjokNcI7UlDOptIm3/XDWAMWUzWTDza8x/jrtBdXFwu1
 Iq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776358443; x=1776963243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CxoE2sQDfNJcl7sNbi2G1nRN3fSKrRDunzLrpBK4/AE=;
 b=SXJw5axpyfCdwMvdrwoFiU93WJAYekEQ/7Ia2E5Zr85CGeErT2PTCZuuF7NagjFd6u
 UO/THB+W7q9+/Bn9/hy+76EH96W8KliiZ6ipx9sCmh1vSNEz43DcveVMAhHLMhSArb04
 H9Vd5XYN5uPtLpylNcLaE4LU1fAffNH1ZLfnNHlR20pJ99/axOfMMeOoWVYujCh/7kvL
 dsApllBECtv6H9+yRSUpIWZ/R364Tqciag3Cg9DoxL6R0UulqYNk7w3H19uEQKNF4yiE
 MuF03POLaO0fVPGGkb6SqYmFWMkytM4iGTKeTADSxzG1HVUWxdlnkF6ZyG09emOqvxxb
 vLnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AwaKyZQ+dhAdWxT80nN9FMHlvEkAIp0nPjLN5njKTsMBFjrpXAEzF0h2zj7L2p1Ep/pwEv9qAEj74@nongnu.org
X-Gm-Message-State: AOJu0Yx3Yxp4W5YdpinIMY0CVn9+GpCFG/ZsNDfmB3DsSmDhGs0gkfWe
 l6CAWZpqqyGCxtXxGyFmsg39vioCQIlfW2wrNyCkz6NlXnFtoVuTo0hfQpG1IQfUXPc=
X-Gm-Gg: AeBDiesgpj4vfEy1cIW9hqUjXJwH+qO9T+KMgLpcbcn129XEM7K6rArqWL0TEDmh312
 biyX4t+Qi+adHHGqjfotqX8Y0FwORidd8pzXMcDWb5XJCeeN+7PgIzH/gQsAX84ECS/3PxfKG/U
 FxlNDlilRxm9rbT8hiP8Omxglyewh4sjlRoSbmf91p6oGL1ZIKdwfIJU0sa3QOpRCPiVm0fJX3S
 grFvnvvOO0V24BK/AyTCxEuLMrHWI5wVDaJZdGdDv8ORKKH7QrFDDjHxwRv6EH5WitDSeNGVoAz
 j9Xy5ZIaSxT76hTa9EtS8kpQQQNAMPmgZheNPByp2TbeyHNSmJ4/GssE2WQA2KehloijWlkr6nZ
 FqDF76+ZXJOVAv9AhxIf9EfE3GQNkdKHRXYklOZx7+FahHTYHObORupWqObt2rq9jEQ87/p6N9B
 3tquv38yCidkLOp259wzVcsnGYPrrLUVDWRQeYE/ej0S556UkZlYqseHACIkiR1aThCtMOh2jW1
 i5jboh9T7QJrua3FIlBjm8TlhdSiaEu1YZbKbPaVQ==
X-Received: by 2002:a05:600c:4fcb:b0:488:c120:480a with SMTP id
 5b1f17b1804b1-488d6891181mr380899715e9.31.1776358443389; 
 Thu, 16 Apr 2026 09:54:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fa79d476sm473035e9.1.2026.04.16.09.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:54:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 2/3] target/arm: Allow 'aarch64=off' to be set for TCG CPUs
Date: Thu, 16 Apr 2026 17:53:52 +0100
Message-ID: <20260416165353.589569-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416165353.589569-1-peter.maydell@linaro.org>
References: <20260416165353.589569-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Allow the 'aarch64=off' property, which is currently KVM-only, to
be set for TCG CPUs also.

Note that we don't permit it on the qemu-aarch64 user-mode binary:
this makes no sense as that executable can only handle AArch64
syscalls (and it would also assert at startup since it doesn't
compile in the A32-specific GDB xml files like arm-neon.xml).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Clément Chigot <chigot@adacore.com>
---
v1->v2: slight tweak to the docs wording
---
 docs/system/arm/cpu-features.rst | 10 +++++----
 target/arm/cpu-features.h        |  5 +++++
 target/arm/cpu.c                 | 36 ++++++++++++++++++++++++++++----
 tests/qtest/arm-cpu-features.c   |  8 ++-----
 4 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index ce19ae6a04..10b0eff27e 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -23,10 +23,12 @@ not implement ARMv8-A, will not have the ``aarch64`` CPU property.
 QEMU's support may be limited for some CPU features, only partially
 supporting the feature or only supporting the feature under certain
 configurations.  For example, the ``aarch64`` CPU feature, which, when
-disabled, enables the optional AArch32 CPU feature, is only supported
-when using the KVM accelerator and when running on a host CPU type that
-supports the feature.  While ``aarch64`` currently only works with KVM,
-it could work with TCG.  CPU features that are specific to KVM are
+disabled, enables the optional AArch32 CPU feature, can only be set to
+``off`` on the TCG and KVM accelerators, and it cannot be set to
+``off`` under KVM unless running on a host CPU type that supports
+running guests in AArch32.
+
+CPU features that are inherently specific to KVM are
 prefixed with "kvm-" and are described in "KVM VCPU Features".
 
 CPU Feature Probing
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b683c9551a..6e5212ff6c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1071,6 +1071,11 @@ static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
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
index 11d3437843..347616fa5a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1248,10 +1248,38 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
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
index bbdd89a81d..cb4d01fd46 100644
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


