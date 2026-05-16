Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CEECD4F48
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIe7-000735-T7; Sat, 16 May 2026 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIe6-0006sP-0q
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIe3-0008UK-O8
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso7830705e9.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951866; x=1779556666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2B+NBXajc/QmvN9GPFw1CKwqetwZlIhbn6ldsGmgu/E=;
 b=HLawme6nRauGn3tSTRvLPCN1kRDq2is+lUy8quD7OP6M8hoUFtmw82AxbXVrEZtILo
 VGPcyJE/E8AzBwnR8chRLCpa5p392q/rvj8ieufFM2rY5g/j0Yis/HYv7Sjo5SKbwgdI
 A6ZMnY3beO+DKK52lN2MVXjKb2KFJkx8RK7LROtzXfVisZWJ7xt2WmWJCnp9YC4Eem6A
 DuoPqXByZM3fn0OcC1gEAlnQt/Dbf3Yai+VqgeQDCeonzH1t++++FBNiR06I8GgPdAhl
 K+cwm1U7mlrHQCtpeNqULc4a10ynq6a/0Go2Sp9xQz+LjiZE/tGaBqzzd7hhe/t8Ffma
 iLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951866; x=1779556666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2B+NBXajc/QmvN9GPFw1CKwqetwZlIhbn6ldsGmgu/E=;
 b=ig9ucg75iLf5eqJaj3fSWWcfANWuH9xBHNST9ivlyTVvP8KsyjB+Ktj8IHwYpxz4Dc
 lt84wEoA5L3T9C1QLyrMVW+IhcRd+s8mD6WNHJXXM8+G3qbKMT883/g3YjyInezwQ5hA
 PQ8lje10PJXjDgcSlEgRt7arJH/bQMhFSYrVYSdZ480FtZ4iSpODAsOLRxcNINq1nxYV
 SisglsMxiG+mHlqpsCMz3Pliy7YebSwOxQ+EV1wfmweJXPmdyqALAzv6EqWAqgNiYPYq
 e7UITBslSvKG8LoWsA0wRlwPkUwxOvrrtccDsPmSR5NHDnoHUMInCHFh65oa9rsNFMZ2
 nFzg==
X-Gm-Message-State: AOJu0YzKntbZVH2uESCSCGNGUM+9pFCmOKtYg3R9vYyphDbF3ggzU2EF
 xqxqpu3zm76nXUlXWno7swjGPsdIv6tskhfcZl178p/dekpH2U3U8ro0rp7YNY0FtVa3DYQJHfn
 g1fjSj/w=
X-Gm-Gg: Acq92OFd/Rpt4w3TzrOxnvS/fzbkSfMRFTa+Znwtpt9freLLSamzP9MwMXM8D72M4Tn
 7Xb2oR+3+d7FLPftzZRFf7CPms2U+Kl5KCuPbQsF5/hmn/ymy5Yb+p3ykkkBR4351XIRHqUJf87
 MCp1NB+FbVf4HPuJGf3MQ3xBzk/0zKn4LWwMGUvQxHvVMZpXphIoQrZrEa4OZx0u73K8Fx7s+MI
 xf/ybXHx5VZvC7dzeWfc+xRZER1a7vY8WhnH25/aqLxfpYMqMDRAOG/acW/atT5UgZqgw9nT37r
 87CzJd2JiFn0YLRgJGBx7Lc7fGBEeuw38uWENzDwo4qY/U8nYwUC5JjJCF2rs2q8vvm0YBSKDMX
 WznMccax27J35T+mkM5Niqp6wlFoYad7sI0iwQDI4hFhqVBvVELZN9IODH55yidUHqXQjEpcbM0
 /DY4DzfPkO26JIZbiBECg4BLxfaOL8W7L2bq6dDqZ5BDuFdhQ8coOpOQtEzmdp1OsxNsp2ZcL6W
 sACiKmNGJU=
X-Received: by 2002:a05:600c:3e1b:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48fe6515f20mr112814825e9.24.1778951866223; 
 Sat, 16 May 2026 10:17:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab2a23dsm41555855e9.5.2026.05.16.10.17.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:17:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v7 19/21] target/arm: Define 'max' CPU type in cpu-max.c
Date: Sat, 16 May 2026 19:15:21 +0200
Message-ID: <20260516171524.19184-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Rather than having the 32-bit 'max' CPU type defined in
cpu32.c and the 64-bit counter part in cpu64.c, unify the
code in a single place in cpu-max.c. Define stubs for
aarch64_host_initfn() and aarch64_max_tcg_initfn() in the
32-bit binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/internals.h   |  1 +
 target/arm/cpu-max.c     | 65 ++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c       | 21 +------------
 target/arm/tcg/cpu32.c   | 29 ------------------
 target/arm/tcg/stubs32.c | 10 +++++++
 5 files changed, 77 insertions(+), 49 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c95f3d63138..ccada1c9018 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1759,6 +1759,7 @@ void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
 void aarch64_aa32_a57_init(Object *obj, bool aa32_only);
+void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
 static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 6fc54ebe74e..8cf8edc6535 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -8,7 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "system/hw_accel.h"
 #include "system/kvm.h"
+#include "system/qtest.h"
+#include "system/tcg.h"
 #include "target/arm/internals.h"
 #include "target/arm/cpregs.h"
 
@@ -178,3 +181,65 @@ void aa32_max_features(ARMCPU *cpu)
 
     FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
 }
+
+/*
+ * -cpu max: a CPU with as many features enabled as our emulation supports.
+ * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu64.c;
+ * this only needs to handle 32 bits, and need not care about KVM.
+ */
+static void cpu_max_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+#ifdef TARGET_AARCH64
+    const bool aarch64_enabled = true;
+#else
+    const bool aarch64_enabled = false;
+#endif /* !TARGET_AARCH64 */
+
+    if (hwaccel_enabled()) {
+        assert(aarch64_enabled);
+        /*
+         * When hardware acceleration enabled, '-cpu max' is
+         * identical to '-cpu host'
+         */
+        aarch64_host_initfn(obj);
+        return;
+    }
+
+    if (tcg_enabled() || qtest_enabled()) {
+        aarch64_aa32_a57_init(obj, !aarch64_enabled);
+    }
+
+    if (!aarch64_enabled) {
+        aa32_max_features(cpu);
+#ifdef CONFIG_USER_ONLY
+        /*
+         * Break with true ARMv8 and add back old-style VFP short-vector
+         * support. Only do this for user-mode, where -cpu max is the default,
+         * so that older v6 and v7 programs are more likely to work without
+         * adjustment.
+         */
+        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+#endif
+    } else if (tcg_enabled()) {
+        assert(aarch64_enabled);
+        /*
+         * '-cpu max' for TCG: we currently do this as
+         * "A57 with extra things"
+         */
+        aarch64_max_tcg_initfn(obj);
+    }
+}
+
+static const ARMCPUInfo arm_max_cpu = {
+    .name = "max",
+    .initfn = cpu_max_initfn,
+};
+
+static void arm_max_cpu_register_types(void)
+{
+    arm_cpu_register(&arm_max_cpu);
+}
+
+type_init(arm_max_cpu_register_types)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 499d154dace..28167355773 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -791,7 +791,7 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
 }
 #endif
 
-static void aarch64_host_initfn(Object *obj)
+void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
@@ -818,28 +818,9 @@ static void aarch64_host_initfn(Object *obj)
     }
 }
 
-static void aarch64_max_initfn(Object *obj)
-{
-    if (hwaccel_enabled()) {
-        /* When hardware acceleration enabled, '-cpu max' is identical to '-cpu host' */
-        aarch64_host_initfn(obj);
-        return;
-    }
-
-    if (tcg_enabled() || qtest_enabled()) {
-        aarch64_aa32_a57_init(obj, false);
-    }
-
-    /* '-cpu max' for TCG: we currently do this as "A57 with extra things" */
-    if (tcg_enabled()) {
-        aarch64_max_tcg_initfn(obj);
-    }
-}
-
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-    { .name = "max",                .initfn = aarch64_max_initfn },
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index a2f730451fb..8220d785f5b 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -711,32 +711,6 @@ static void sa1110_initfn(Object *obj)
     cpu->reset_sctlr = 0x00000070;
 }
 
-#ifndef TARGET_AARCH64
-/*
- * -cpu max: a CPU with as many features enabled as our emulation supports.
- * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu64.c;
- * this only needs to handle 32 bits, and need not care about KVM.
- */
-static void arm_max_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    /* Cortex-A57 advertising none of the aarch64 features */
-    aarch64_aa32_a57_init(obj, true);
-
-    aa32_max_features(cpu);
-
-#ifdef CONFIG_USER_ONLY
-    /*
-     * Break with true ARMv8 and add back old-style VFP short-vector support.
-     * Only do this for user-mode, where -cpu max is the default, so that
-     * older v6 and v7 programs are more likely to work without adjustment.
-     */
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-#endif
-}
-#endif /* !TARGET_AARCH64 */
-
 static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "arm926",      .initfn = arm926_initfn },
     { .name = "arm946",      .initfn = arm946_initfn },
@@ -760,9 +734,6 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "ti925t",      .initfn = ti925t_initfn },
     { .name = "sa1100",      .initfn = sa1100_initfn },
     { .name = "sa1110",      .initfn = sa1110_initfn },
-#ifndef TARGET_AARCH64
-    { .name = "max",         .initfn = arm_max_initfn },
-#endif
 };
 
 static void arm_tcg_cpu_register_types(void)
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index 3945dc49e5e..78f819ef6ff 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -22,3 +22,13 @@ void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     g_assert_not_reached();
 }
+
+void aarch64_host_initfn(Object *obj)
+{
+    g_assert_not_reached();
+}
+
+void aarch64_max_tcg_initfn(Object *obj)
+{
+    g_assert_not_reached();
+}
-- 
2.53.0


