Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A1C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIO8-0000Mn-W0; Tue, 04 Feb 2025 07:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINr-0008PA-4n
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:38 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINj-0002B3-UB
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:28 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38da72cc47bso499221f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673418; x=1739278218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMCLVG75imhon3JRh2v3hSuL1igLHDGnXzv1AZpRurg=;
 b=pbKyz2MaM1JoCWgVg7uUWJkY6VL02Ot6sO15AitCbL1cRROM+fYNui3BuP2FK4o1l/
 fQU/aFKtHuvNq2kL5Sb9c31d+sIAzRb3wZd7/vu/o0lkO7RdCFJPMheC+2KONcTux4wC
 hjVMSGLdeuzIUZabBeg3Oj4iAm1Tt7uHUFZ7W+d7DAcm6GBrXK+nL25jaPqWW4lrGadc
 bWIAM/icN2Za89Uugj1AkdKfja9AOY4PlgTY4CoJ1rx3/d1YOlJqP8UrIbxI9fN+Tvtc
 cWZfLXZI5STTbxEt6UIkKwhWUXSvaKCDtxfITYzD12PbwdCWcrka2kpl5+jNjVuoiq5l
 COuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673418; x=1739278218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMCLVG75imhon3JRh2v3hSuL1igLHDGnXzv1AZpRurg=;
 b=mCWxyCIO8BQyYo6hoBOGMI+Axa7uYKGJPiCvEEk+Saw6NfBLmMxg9zufIX1Y9TXSHs
 P57iQGXBJHJ5L1RzDKokDq/ODz7RZAAcw26qYKQyxjn6Lxijo/BOwkNOhdbOjq8fT8ud
 cpC5wmcLjvSi2iZcihC8fX8NCX/BVhQyW4mAU6q/rfmZS97O2/SvRO7IgJHHQv1bP5uz
 06g2IVRTxOGMzous2F8uMsyR3aadVueUKOKxdP3m0GvOdPWpvbA4xtLS/tFYhEAZTfVH
 dblzcIrQiL7quuf+4A8Fjxy7WGI6TY4egno91DisOuDtFP0AGhW+33vUXDw9zmYyzFbd
 8F9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVahtv6mWNDbiOa7hrwwupQtLJdHKrQ32hnc6pNIvM4oICWNh8M9ktn5VgqURuFS6lVspaxK+j8dEOi@nongnu.org
X-Gm-Message-State: AOJu0Yzc5Wr3BXUHe/6lVqDcamOCDjIJVYgFPoctW6+5egrkMOfR+JYs
 68k+JUZTAvV0M2k6x0zCC/zmO1xdOdRzLCqMq/7b2jH7+EOdZSdx9fq/rWcqGKU=
X-Gm-Gg: ASbGncux92dobZpsqRXFE+W6Lgwb5bpA63ZEVSk2h/SERRtTzMxNCe+jOVaTlSroHuF
 gwp0LLxh+4/E/QZMXjv7bws1fkajS61hgp04AmdCdUseVuyqoZDCDhQYOAXYE97Y/YTGxBEfpLX
 yG1RVjBUBA+gFtFuvnptrvWRAHt541gu6eJ9yMRlLkviE99RAOcoV8c4cXLAcjm7ISxYdQsTRMj
 B2LCC6gDyngSe+01WaKa+7wyC4GwPLwqlnUnyBFv1WqmK2Lwom88Ssx231a8u62z67kJn/Egx3m
 Xyp6egMyxh+7LO5K1zTHCQ==
X-Google-Smtp-Source: AGHT+IEP4iz2ZMMvy7N7WT7YPobyS75l1byrMXRCtZuqxLR0kt8EHFB2iJpRnHHigF9kRhw9AZqFqg==
X-Received: by 2002:adf:ee8b:0:b0:382:3c7b:9ae with SMTP id
 ffacd0b85a97d-38c51943ddemr18794462f8f.16.1738673417826; 
 Tue, 04 Feb 2025 04:50:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 6/9] target/arm: Implement SEL2 physical and virtual timers
Date: Tue,  4 Feb 2025 12:50:06 +0000
Message-Id: <20250204125009.2281315-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

When FEAT_SEL2 was implemented the SEL2 timers were missed. This
shows up when building the latest Hafnium with SPMC_AT_EL=2. The
actual implementation utilises the same logic as the rest of the
timers so all we need to do is:

  - define the timers and their access functions
  - conditionally add the correct system registers
  - create a new accessfn as the rules are subtly different to the
    existing secure timer

Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Cc: Andrei Homescu <ahomescu@google.com>
Cc: Arve Hjønnevåg <arve@google.com>
Cc: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
[PMM: CP_ACCESS_TRAP_UNCATEGORIZED -> CP_ACCESS_UNDEFINED;
 offset logic now in gt_{indirect,direct}_access_timer_offset() ]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bsa.h |   2 +
 target/arm/cpu.h     |   2 +
 target/arm/gtimer.h  |   4 +-
 target/arm/cpu.c     |   4 ++
 target/arm/helper.c  | 163 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
index 8eaab603c03..13ed2d2ac19 100644
--- a/include/hw/arm/bsa.h
+++ b/include/hw/arm/bsa.h
@@ -22,6 +22,8 @@
 #define QEMU_ARM_BSA_H
 
 /* These are architectural INTID values */
+#define ARCH_TIMER_S_EL2_VIRT_IRQ  19
+#define ARCH_TIMER_S_EL2_IRQ       20
 #define VIRTUAL_PMU_IRQ            23
 #define ARCH_GIC_MAINT_IRQ         25
 #define ARCH_TIMER_NS_EL2_IRQ      26
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ae1e8b1c779..3011595b3d0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1148,6 +1148,8 @@ void arm_gt_vtimer_cb(void *opaque);
 void arm_gt_htimer_cb(void *opaque);
 void arm_gt_stimer_cb(void *opaque);
 void arm_gt_hvtimer_cb(void *opaque);
+void arm_gt_sel2timer_cb(void *opaque);
+void arm_gt_sel2vtimer_cb(void *opaque);
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
index b992941bef1..0e89b8e58d0 100644
--- a/target/arm/gtimer.h
+++ b/target/arm/gtimer.h
@@ -15,7 +15,9 @@ enum {
     GTIMER_HYP      = 2,
     GTIMER_SEC      = 3,
     GTIMER_HYPVIRT  = 4,
-#define NUM_GTIMERS   5
+    GTIMER_S_EL2_PHYS = 5, /* CNTHPS_* ; only if FEAT_SEL2 */
+    GTIMER_S_EL2_VIRT = 6, /* CNTHVS_* ; only if FEAT_SEL2 */
+#define NUM_GTIMERS   7
 };
 
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a83b9ee34f..97acd230298 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2091,6 +2091,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                               arm_gt_stimer_cb, cpu);
         cpu->gt_timer[GTIMER_HYPVIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
                                                   arm_gt_hvtimer_cb, cpu);
+        cpu->gt_timer[GTIMER_S_EL2_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                                     arm_gt_sel2timer_cb, cpu);
+        cpu->gt_timer[GTIMER_S_EL2_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                                     arm_gt_sel2vtimer_cb, cpu);
     }
 #endif
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c021c237b9b..bc820b0de76 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2404,6 +2404,45 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     }
 }
 
+static CPAccessResult gt_sel2timer_access(CPUARMState *env,
+                                          const ARMCPRegInfo *ri,
+                                          bool isread)
+{
+    /*
+     * The AArch64 register view of the secure EL2 timers are mostly
+     * accessible from EL3 and EL2 although can also be trapped to EL2
+     * from EL1 depending on nested virt config.
+     */
+    switch (arm_current_el(env)) {
+    case 0: /* UNDEFINED */
+        return CP_ACCESS_UNDEFINED;
+    case 1:
+        if (!arm_is_secure(env)) {
+            /* UNDEFINED */
+            return CP_ACCESS_UNDEFINED;
+        } else if (arm_hcr_el2_eff(env) & HCR_NV) {
+            /* Aarch64.SystemAccessTrap(EL2, 0x18) */
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* UNDEFINED */
+        return CP_ACCESS_UNDEFINED;
+    case 2:
+        if (!arm_is_secure(env)) {
+            /* UNDEFINED */
+            return CP_ACCESS_UNDEFINED;
+        }
+        return CP_ACCESS_OK;
+    case 3:
+        if (env->cp15.scr_el3 & SCR_EEL2) {
+            return CP_ACCESS_OK;
+        } else {
+            return CP_ACCESS_UNDEFINED;
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
 uint64_t gt_get_countervalue(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -2475,6 +2514,8 @@ static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
     case GTIMER_HYP:
     case GTIMER_SEC:
     case GTIMER_HYPVIRT:
+    case GTIMER_S_EL2_PHYS:
+    case GTIMER_S_EL2_VIRT:
         return 0;
     default:
         g_assert_not_reached();
@@ -2521,6 +2562,8 @@ uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx)
     case GTIMER_HYP:
     case GTIMER_SEC:
     case GTIMER_HYPVIRT:
+    case GTIMER_S_EL2_PHYS:
+    case GTIMER_S_EL2_VIRT:
         return 0;
     default:
         g_assert_not_reached();
@@ -2953,6 +2996,62 @@ static void gt_sec_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_SEC, value);
 }
 
+static void gt_sec_pel2_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_S_EL2_PHYS);
+}
+
+static void gt_sec_pel2_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_S_EL2_PHYS, value);
+}
+
+static uint64_t gt_sec_pel2_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_S_EL2_PHYS);
+}
+
+static void gt_sec_pel2_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_S_EL2_PHYS, value);
+}
+
+static void gt_sec_pel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_S_EL2_PHYS, value);
+}
+
+static void gt_sec_vel2_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_S_EL2_VIRT);
+}
+
+static void gt_sec_vel2_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_S_EL2_VIRT, value);
+}
+
+static uint64_t gt_sec_vel2_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_S_EL2_VIRT);
+}
+
+static void gt_sec_vel2_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_S_EL2_VIRT, value);
+}
+
+static void gt_sec_vel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_S_EL2_VIRT, value);
+}
+
 static void gt_hv_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_HYPVIRT);
@@ -3009,6 +3108,20 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+void arm_gt_sel2timer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_S_EL2_PHYS);
+}
+
+void arm_gt_sel2vtimer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_S_EL2_VIRT);
+}
+
 void arm_gt_hvtimer_cb(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -5733,6 +5846,56 @@ static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
       .access = PL2_RW, .accessfn = sel2_access,
       .nv2_redirect_offset = 0x48,
       .fieldoffset = offsetof(CPUARMState, cp15.vstcr_el2) },
+#ifndef CONFIG_USER_ONLY
+    /* Secure EL2 Physical Timer */
+    { .name = "CNTHPS_TVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 5, .opc2 = 0,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .readfn = gt_sec_pel2_tval_read,
+      .writefn = gt_sec_pel2_tval_write,
+      .resetfn = gt_sec_pel2_timer_reset,
+    },
+    { .name = "CNTHPS_CTL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 5, .opc2 = 1,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_S_EL2_PHYS].ctl),
+      .resetvalue = 0,
+      .writefn = gt_sec_pel2_ctl_write, .raw_writefn = raw_write,
+    },
+    { .name = "CNTHPS_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 5, .opc2 = 2,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_S_EL2_PHYS].cval),
+      .writefn = gt_sec_pel2_cval_write, .raw_writefn = raw_write,
+    },
+    /* Secure EL2 Virtual Timer */
+    { .name = "CNTHVS_TVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 4, .opc2 = 0,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .readfn = gt_sec_vel2_tval_read,
+      .writefn = gt_sec_vel2_tval_write,
+      .resetfn = gt_sec_vel2_timer_reset,
+    },
+    { .name = "CNTHVS_CTL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 4, .opc2 = 1,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_S_EL2_VIRT].ctl),
+      .resetvalue = 0,
+      .writefn = gt_sec_vel2_ctl_write, .raw_writefn = raw_write,
+    },
+    { .name = "CNTHVS_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 4, .opc2 = 2,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_S_EL2_VIRT].cval),
+      .writefn = gt_sec_vel2_cval_write, .raw_writefn = raw_write,
+    },
+#endif
 };
 
 static CPAccessResult nsacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.34.1


