Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31835C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfS-00036Y-PQ; Tue, 30 Apr 2024 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf4-0002Oq-8P
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qex-0005d0-Ud
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41adf3580dbso66565e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495730; x=1715100530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZRx6TDLUMLghtjN21VBOwZjWZpZDFLSrLQHG0HuKw1o=;
 b=WaRW0/qsoqRU+l9ezCvwf9f+B1+EaFdQqbCOg+Z/JCkke0uClH/tGHpQvGWwZY5IR/
 MZ77WWy/vP48VBomdwnHmZoETkHygPDsn50g/7UeQIjHqtxPKPkVo3OW53fHuZSMVE9S
 +jbx6DnvB2a+6bve2n5EjN5JYC0I1CP8Z6NajbyCxYaFYtV0KuCZEI8UjN0SAaetDQdZ
 1zznnNO43E6/I0BFyj7Mz+vkZct05LHvRLFbKMkv9fx7zX3PilmHIQaDAiWqsG95Ot/L
 aRp/MTEIHvYs2cooxoEvmb0zP3qmj9jAzWH8GnKEs+VzkZw2d4gNNS19vAfjERCCc7JM
 njTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495730; x=1715100530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRx6TDLUMLghtjN21VBOwZjWZpZDFLSrLQHG0HuKw1o=;
 b=PaCpp0oIaoQzxkNYBZZZkcCA3K9RKkIjgK0CLhCofL1YUlkxna81JPtj97VXnPmltv
 cUkxx+EL3NHro5j7ftJ9OF+ZzTF7YAT2ELwjPr8oLbyG6h3DQRGuHYr9wSHp807aITK2
 nOalIIEgWuueqj6tX3M+NyT1uj4bq/4JcNWw5uBNvkTr/YSaFZaImbnBuu6HTKMLNtAc
 j/xUa4VWbPxrkrN64INdcqDomde1Y12GM3zBxmf3Q0Zs9rmIu/yJkGpdMvANK8x64dkU
 M+IXf6EjiCgZnShdFaxi1XixeZoB15O+d2s3OCSwAehhUWwbopCEOPfzHDU9WY7oT9cX
 vxZw==
X-Gm-Message-State: AOJu0Yw7Ln5mXSgMs6qZZtU91xENWaJB33V73C6itLbV6LkbMAlR2y6S
 A04cCEvcj6+A8gjR8DYBuUcVTI+wPEkdCzSiKvAU2sauKcgucgdIVCnq+z7EaBBRFTZ6JFFKGE6
 r
X-Google-Smtp-Source: AGHT+IE0AZm7jC8A7STH8G7ofCbG2xaHMVRNGb1jlxIh9EvyByTuHjYRycv39SZsqzAXDDrGvODqVQ==
X-Received: by 2002:a05:600c:1c88:b0:419:e3b9:b384 with SMTP id
 k8-20020a05600c1c8800b00419e3b9b384mr3166499wms.11.1714495730598; 
 Tue, 30 Apr 2024 09:48:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/21] target/arm: Default to 1GHz cntfrq for 'max' and new CPUs
Date: Tue, 30 Apr 2024 17:48:34 +0100
Message-Id: <20240430164842.4074734-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In previous versions of the Arm architecture, the frequency of the
generic timers as reported in CNTFRQ_EL0 could be any IMPDEF value,
and for QEMU we picked 62.5MHz, giving a timer tick period of 16ns.
In Armv8.6, the architecture standardized this frequency to 1GHz.

Because there is no ID register feature field that indicates whether
a CPU is v8.6 or that it ought to have this counter frequency, we
implement this by changing our default CNTFRQ value for all CPUs,
with exceptions for backwards compatibility:

 * CPU types which we already implement will retain the old
   default value. None of these are v8.6 CPUs, so this is
   architecturally OK.
 * CPUs used in versioned machine types with a version of 9.0
   or earlier will retain the old default value.

The upshot is that the only CPU type that changes is 'max'; but any
new type we add in future (whether v8.6 or not) will also get the new
1GHz default.

It remains the case that the machine model can override the default
value via the 'cntfrq' QOM property (regardless of the CPU type).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240426122913.3427983-5-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 11 +++++++++++
 target/arm/internals.h | 12 ++++++++++--
 hw/core/machine.c      |  4 +++-
 target/arm/cpu.c       | 23 +++++++++++++++++------
 target/arm/cpu64.c     |  2 ++
 target/arm/tcg/cpu32.c |  4 ++++
 target/arm/tcg/cpu64.c | 18 ++++++++++++++++++
 7 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1f90590f937..a550bcd25fe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -956,6 +956,9 @@ struct ArchCPU {
      */
     bool host_cpu_probe_failed;
 
+    /* QOM property to indicate we should use the back-compat CNTFRQ default */
+    bool backcompat_cntfrq;
+
     /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
      * register.
      */
@@ -2373,6 +2376,14 @@ enum arm_features {
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
     ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
+    /*
+     * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
+     * if the board doesn't set a value, instead of 1GHz. It is for backwards
+     * compatibility and used only with CPU definitions that were already
+     * in QEMU before we changed the default. It should not be set on any
+     * CPU types added in future.
+     */
+    ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index b6c78db0243..ee3ebd383e1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -62,9 +62,17 @@ static inline bool excp_is_internal(int excp)
 
 /*
  * Default frequency for the generic timer, in Hz.
- * This is 62.5MHz, which gives a 16 ns tick period.
+ * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
+ * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
+ * which gives a 16ns tick period.
+ *
+ * We will use the back-compat value:
+ *  - for QEMU CPU types added before we standardized on 1GHz
+ *  - for versioned machine types with a version of 9.0 or earlier
+ * In any case, the machine model may override via the cntfrq property.
  */
-#define GTIMER_DEFAULT_HZ 62500000
+#define GTIMER_DEFAULT_HZ 1000000000
+#define GTIMER_BACKCOMPAT_HZ 62500000
 
 /* Bit definitions for the v7M CONTROL register */
 FIELD(V7M_CONTROL, NPRIV, 0, 1)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0dec48e8021..4ff60911e74 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -33,7 +33,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_0[] = {};
+GlobalProperty hw_compat_9_0[] = {
+    {"arm-cpu", "backcompat-cntfrq", "true" },
+};
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
 GlobalProperty hw_compat_8_2[] = {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9f2ca6633a1..fdc3eda318a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1959,13 +1959,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     if (!cpu->gt_cntfrq_hz) {
         /*
-         * 0 means "the board didn't set a value, use the default".
-         * The default value of the generic timer frequency (as seen in
-         * CNTFRQ_EL0) is 62.5MHz, which corresponds to a period of 16ns.
-         * This is what you get (a) for a CONFIG_USER_ONLY CPU (b) if the
-         * board doesn't set it.
+         * 0 means "the board didn't set a value, use the default". (We also
+         * get here for the CONFIG_USER_ONLY case.)
+         * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
+         * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
+         * which gives a 16ns tick period.
+         *
+         * We will use the back-compat value:
+         *  - for QEMU CPU types added before we standardized on 1GHz
+         *  - for versioned machine types with a version of 9.0 or earlier
          */
-        cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+        if (arm_feature(env, ARM_FEATURE_BACKCOMPAT_CNTFRQ) ||
+            cpu->backcompat_cntfrq) {
+            cpu->gt_cntfrq_hz = GTIMER_BACKCOMPAT_HZ;
+        } else {
+            cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+        }
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -2574,6 +2583,8 @@ static Property arm_cpu_properties[] = {
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
+    /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
+    DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 985b1efe160..c15d086049f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -599,6 +599,7 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -656,6 +657,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index b5a60682fa6..bdd82d912a2 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -457,6 +457,7 @@ static void cortex_a7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -505,6 +506,7 @@ static void cortex_a15_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -696,6 +698,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     cpu->midr = 0x411fd133; /* r1p3 */
@@ -924,6 +927,7 @@ static void arm_max_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 443cffe3a85..da41a44f75b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -63,6 +63,7 @@ static void aarch64_a35_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -231,6 +232,7 @@ static void aarch64_a55_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -299,6 +301,7 @@ static void aarch64_a72_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -354,6 +357,7 @@ static void aarch64_a76_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -423,6 +427,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -592,6 +597,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -663,6 +669,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -885,6 +892,7 @@ static void aarch64_a710_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -982,6 +990,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
@@ -1077,6 +1086,15 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    /*
+     * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
+     * to because we started with aarch64_a57_initfn(). A 'max' CPU might
+     * be a v8.6-or-later one, in which case the cntfrq must be 1GHz; and
+     * because it is our "may change" CPU type we are OK with it not being
+     * backwards-compatible with how it worked in old QEMU.
+     */
+    unset_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
+
     /*
      * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
      * one and try to apply errata workarounds or use impdef features we
-- 
2.34.1


