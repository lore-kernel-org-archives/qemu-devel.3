Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E917910ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CH-00076A-NY; Fri, 27 Mar 2026 07:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CD-00071u-Hg
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CB-0008Go-8C
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439fe4985efso1507656f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610261; x=1775215061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWiLavvxAVAygJhnwAz/WH2EaKWfbUPcvwYUiTpOfXM=;
 b=I/osg9DrYRxUlvEU6AiUfqXt2+fEeJQpOdGrBGAHq0EJhmFodvGJtVs1pXuxV56X/m
 1gK8ToLM1VD2HqEmFzaQXyEKeHOIvYpKAUfIHBBnExPnj0l0P2jj2ye506qz55ni3Wkw
 +d26yx9sn39SZ4QQ9U7H5oy40DcDQ7twwhRSYxUZADl3zoliSzAToMTNkT7jBEB7uvVF
 IMnJGW6yHJUOpkd2NdQ5Bw14A+sakR7jaJE2NV97j0vfG/uzt3r8RkhhC1JoIjf1DjLk
 o1H5bttPDWt6xZVxbiSVoU5uUftSRXu1YQmjg/B0E1eGhfGJ4HXy593dWg+9uzmRS2Ff
 T1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610261; x=1775215061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rWiLavvxAVAygJhnwAz/WH2EaKWfbUPcvwYUiTpOfXM=;
 b=iE337hF7Vks1j6P9CGoPoRFDH6tWn9rR0J8H8AOhiIGlocbn9o26XJnXcpl7YXYQrf
 S2iy0Q1s4WfF1Va4VYjNn7FREV5AdSjiwB6LPklbcbpBqUYc/tyl28PDEdlJ4X2NBQPs
 3/UsEjo7ZKQWcYW29EERsb15u1ZgFNc7iiqRrJDyDFRs4e3GwkwVgGym3eMfweorvrwk
 BLabluqe1hL5iBKNc17fWZisoWRFqb8zktF/rlV3m1oZL44Hniq/aLlPbkqFG9e2FsUt
 bzVDTEnR6N4xWLXQLmTYAlXXXaePc8qEBVuGUofXN2laSl+HadcmpnyHv+9mLajwGg2m
 OVFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKr1xJx77ZFVd9t1s1EUmuOwKwjnrZpaSFiyhsH5u0YbAn9K0tshLimz0Zg+JkMq6+lQqfXDwBzJdk@nongnu.org
X-Gm-Message-State: AOJu0YxxP5KHQkmRlfzQ2Pwp4ze6D/V+BJQG/BDp5v/yQEQqEIxMCcSM
 H9UscV1FxVifeiMFnesfVqIRfbfowBXhGeo4Ru1hx9z3qwmEP1KM4/glw6aP9QA9ycU6J6hVz5E
 tBC1JwyM=
X-Gm-Gg: ATEYQzzPsjBE1vq09EtcuAR17n7V4ZSiym3ZnhkCqSm0rgilmjD4uMuTxDxaLYGsXUh
 FVBB4XHcw5tt8ZhuAXDkdo6cdHiUiFJjx02/XI7hahlii95dX42MZwQlZMzVfR8CR+zjLge5ypp
 tKPdT772tdSD53rBUv1rfpFFB77DHbn5rCqJhVEozSBOsJwrBieTbLaFkFFAPFHo2N/Wr+vIhOP
 WG3ulVCXp6EQMKKCrMy6OxX7PmmLYvO7tQ/fZkvtyi4lrUGzTnYB1loGwdHf5mXS4KL4+uGGvO9
 n321/6x0jjSuf5pt6tVw1Ntb+TibD90bwNcHRd4FUPvImC2FJ0/7Tktwm83sVA+RA7+xP5wCdl3
 G3YieJ+Xatd/3nM+lXKvHKNTkGe/gf+BdQ2/j115XjCJUX63VlwLnyAkdhCABPTreR5L+/GpvHu
 EWG1WWlzm4eQ2xG9spv3pZ0U/8QAdcwbUsydobWTjSeEeqeSuTq2KuAKRcOdyHuHng8UIcqcyjW
 z3HUaEqnsbMsUjCTncA078XBkAlKrM=
X-Received: by 2002:a05:6000:2003:b0:43b:495a:a760 with SMTP id
 ffacd0b85a97d-43b9e9d8c74mr3211827f8f.5.1774610261126; 
 Fri, 27 Mar 2026 04:17:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 41/65] target/arm: GICv5 cpuif: Implement ICC_APR_EL1 and
 ICC_HAPR_EL1
Date: Fri, 27 Mar 2026 11:16:36 +0000
Message-ID: <20260327111700.795099-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The ICC_APR_EL1 GICv5 cpuif register records the physical active
priorities.  Since the GICv5 always uses 5 bits of priority, this
register always has 32 non-RES0 bits, and we don't need the
complicated GICv3 setup where there might be 1, 2 or 4 APR registers.

ICC_HAPR_EL1 is a read-only register which reports the current
running priority.  This is defined to be the lowest set bit (i.e.
the highest priority) in the APR, or the Idle priority 0xff if there
are no active interrupts, so it is effectively a convenience
re-presentation of the APR register data.

The APR register is banked per interrupt domain; ICC_APR_EL1 accesses
the version of the register corresponding to the current logical
interrupt domain.  The APR data for the final domain (EL3) is
accessed via ICC_APR_EL3.  Although we are starting with an EL1-only
implementation, we define the CPU state as banked here so we don't
have to change our representation of it later when we add EL3 and RME
support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 include/hw/intc/arm_gicv5_types.h |  2 ++
 target/arm/cpu.h                  |  2 ++
 target/arm/tcg/gicv5-cpuif.c      | 60 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index f6f8709a6a..5966ebde05 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -84,4 +84,6 @@ typedef enum GICv5TriggerMode {
     GICV5_TRIGGER_LEVEL = 1,
 } GICv5TriggerMode;
 
+#define PRIO_IDLE 0xff
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b97f659352..6841b6748f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -35,6 +35,7 @@
 #include "target/arm/gtimer.h"
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
+#include "hw/intc/arm_gicv5_types.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
@@ -603,6 +604,7 @@ typedef struct CPUArchState {
     struct {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
+        uint64_t icc_apr[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 74132ca097..33e4762ef4 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -95,6 +95,16 @@ static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
     return gicv5_logical_domain(env);
 }
 
+static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
+{
+    /*
+     * Return the current running priority; this is the lowest set bit in
+     * the Active Priority Register, or the idle priority if none (D_XMBQZ)
+     */
+    uint64_t hap = ctz64(env->gicv5_cpuif.icc_apr[domain]);
+    return hap < 32 ? hap : PRIO_IDLE;
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -231,6 +241,44 @@ static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+/*
+ * ICC_APR_EL1 is banked and reads/writes as the version for the
+ * current logical interrupt domain.
+ */
+static void gic_icc_apr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * With an architectural 5 bits of priority, this register has 32
+     * non-RES0 bits
+     */
+    GICv5Domain domain = gicv5_logical_domain(env);
+    value &= 0xffffffff;
+    env->gicv5_cpuif.icc_apr[domain] = value;
+}
+
+static uint64_t gic_icc_apr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    return env->gicv5_cpuif.icc_apr[domain];
+}
+
+static void gic_icc_apr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.icc_apr); i++) {
+        env->gicv5_cpuif.icc_apr[i] = 0;
+    }
+}
+
+static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * ICC_HAPR_EL1 reports the current running priority, which can be
+     * calculated from the APR register.
+     */
+    return gic_running_prio(env, gicv5_current_phys_domain(env));
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -382,6 +430,18 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
         .writefn = gic_ppi_spend_write,
     },
+    {   .name = "ICC_APR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 0,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_apr_el1_read,
+        .writefn = gic_icc_apr_el1_write,
+        .resetfn = gic_icc_apr_el1_reset,
+    },
+    {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_hapr_el1_read, .raw_writefn = arm_cp_write_ignore,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


