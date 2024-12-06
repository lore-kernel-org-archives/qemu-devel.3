Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E57E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJan8-0007iM-BZ; Fri, 06 Dec 2024 11:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJan2-0007fu-9R
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJamx-0006Uj-V1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so22086345e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500961; x=1734105761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSUUCyFArbxy+0GSSuSuEHiOsnV3phawKrAnzeeaAVQ=;
 b=SYIjXB8OZa//AgRVRBubs0gtK6U9W73UEFwJm0SCbEdou080SJ6c4HqO0a8B9mssql
 brz/Jg8PbJio6DlN0bDkyfOZH6gSxdfpk9yIecaSfwUGf4Ad1lZpzoiMIjAk7vJGQ5cE
 Ypc+Kwn9p1WhnVUkJRwIUMWQlGys7v0uGjt+HEddEDQL5Q2ppOxQ+OtCIK85ZY1rIxAc
 a0MAJJZQsFdbKWF2rCoy5wr1xWTRTvJYdoKswXMBSVSPElZJ0Pu/J3dTqWr2JLkggmrI
 cQZw+66GgVb2C6ulKpoOD79qMWrGFE1R01zYHnWssqh/h44LtEFg9OEBcpOwaRDwMsxK
 6Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500961; x=1734105761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSUUCyFArbxy+0GSSuSuEHiOsnV3phawKrAnzeeaAVQ=;
 b=AtPNEXgNaTRr+KBnIoQEOn7NlYDcTcGvpSlgCXSUeI1EpLJ4ESgsKUZBvUWsvc4ZCr
 AfzX6y1WVwpS8F9FagKvYyZFmex4LNfMlMYAwhgMZQeHdKy8kMt9zAEaoV3luPCe9mRw
 e3GfxrBohCPPdKfJrN3CZjO50FLS+0SFCKypF0gx/eNBu6OMGsIwJpnCkyJjOQ5e/lSH
 2SC4OUkbedfKcFH5AxRJvAvqaxhz3U2/UnMus2timo7RMVBvFKH2tblEKX/DQzZkANDA
 TaFhj4oT3Hi2Z+gG66946WlwIaQVrykUbeNAfNo+IyKrbVnyGzjZPoESeo3r7iotoHOJ
 hE0Q==
X-Gm-Message-State: AOJu0YxZpPtX02S+TH1PqnXQuBlpDaRK8jypm5orO+yN2ELcdqqUFKA/
 WlbGzURC4rusO8NfO2Rrjv0PdnHmaeKYypE/e1iIB/vQPTOmYRVaDACUXpUKX/I=
X-Gm-Gg: ASbGncuahLepbtyhyN6sWnUCkVJ/V2fPpv/1DbxWWbEESis2tLvQYVpD473OqCgkfi7
 iN7KKpHL8q5QV6BhrCm4FCrjc9be4g9IZ92ln1QBj6T/hyocY4Vvk1jPmIBepnFGp7TxTgdphvn
 oxNgndDtSeeMtDm0SU3jUdN1ndNlZtQt7v10duWAZk2rPxAHdOzJb9Cb0olNMYqaeASaUiKujjN
 LUjM89SMMTCYMobEa4Zu13AusHWEH4WPog3zO0hbf40UZTe
X-Google-Smtp-Source: AGHT+IFu1+0XA3JOMBRbQIpJxWtdJcJ0NwKyjD6Vh9Obf0jdsV7qG9uCVlXzXqKgjkjrDsTb79MgAQ==
X-Received: by 2002:a05:600c:1c8a:b0:434:a4a9:5d57 with SMTP id
 5b1f17b1804b1-434ddeb8cf6mr29723485e9.19.1733500961331; 
 Fri, 06 Dec 2024 08:02:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b14csm99454085e9.2.2024.12.06.08.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:02:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7D845F9FB;
 Fri,  6 Dec 2024 16:02:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, Andrei Homescu <ahomescu@google.com>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@google.com>,
 =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi.denis.courmont@huawei.com>
Subject: [PATCH 3/3] target/arm: implement SEL2 physical and virtual timers
Date: Fri,  6 Dec 2024 16:02:39 +0000
Message-Id: <20241206160239.3229094-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206160239.3229094-1-alex.bennee@linaro.org>
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

When FEAT_SEL2 was implemented the SEL2 timers where missed. This
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

---
v1
  - add better comments to GTIMER descriptions
  - also define new timers for sbsa-ref
  - don't conditionally gate qemu_timer creation on the feature
  - take cntvoff_el2 int account for SEC_VEL2 in gt_recalc/g_tval_[read|write]
---
 include/hw/arm/bsa.h |   2 +
 target/arm/cpu.h     |   2 +
 target/arm/gtimer.h  |   4 +-
 hw/arm/sbsa-ref.c    |   2 +
 hw/arm/virt.c        |   2 +
 target/arm/cpu.c     |   4 ++
 target/arm/helper.c  | 158 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
index 8eaab603c0..b4ecca1b1c 100644
--- a/include/hw/arm/bsa.h
+++ b/include/hw/arm/bsa.h
@@ -22,6 +22,8 @@
 #define QEMU_ARM_BSA_H
 
 /* These are architectural INTID values */
+#define ARCH_TIMER_S_VIRT_EL2_IRQ  19
+#define ARCH_TIMER_S_EL2_IRQ       20
 #define VIRTUAL_PMU_IRQ            23
 #define ARCH_GIC_MAINT_IRQ         25
 #define ARCH_TIMER_NS_EL2_IRQ      26
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280..10b5354d6f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1139,6 +1139,8 @@ void arm_gt_vtimer_cb(void *opaque);
 void arm_gt_htimer_cb(void *opaque);
 void arm_gt_stimer_cb(void *opaque);
 void arm_gt_hvtimer_cb(void *opaque);
+void arm_gt_sel2timer_cb(void *opaque);
+void arm_gt_sel2vtimer_cb(void *opaque);
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
index de016e6da3..f8f7425a5f 100644
--- a/target/arm/gtimer.h
+++ b/target/arm/gtimer.h
@@ -15,7 +15,9 @@ enum {
     GTIMER_HYP      = 2, /* EL2 physical timer */
     GTIMER_SEC      = 3, /* EL3 physical timer */
     GTIMER_HYPVIRT  = 4, /* EL2 virtual timer */
-#define NUM_GTIMERS   5
+    GTIMER_SEC_PEL2 = 5, /* Secure EL2 physical timer */
+    GTIMER_SEC_VEL2 = 6, /* Secure EL2 virtual timer */
+#define NUM_GTIMERS   7
 };
 
 #endif
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..5dc36b3cee 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -484,6 +484,8 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_SEC_PEL2] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_SEC_VEL2] = ARCH_TIMER_S_VIRT_EL2_IRQ,
         };
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..451d154459 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -873,6 +873,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_SEC_PEL2] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_SEC_VEL2] = ARCH_TIMER_S_VIRT_EL2_IRQ,
         };
 
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b95..d15916c436 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2078,6 +2078,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                               arm_gt_stimer_cb, cpu);
         cpu->gt_timer[GTIMER_HYPVIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
                                                   arm_gt_hvtimer_cb, cpu);
+        cpu->gt_timer[GTIMER_SEC_PEL2] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                                   arm_gt_sel2timer_cb, cpu);
+        cpu->gt_timer[GTIMER_SEC_VEL2] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
+                                                   arm_gt_sel2vtimer_cb, cpu);
     }
 #endif
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd147b717a..f82503304e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2668,6 +2668,41 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
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
+    case 0:
+        return CP_ACCESS_TRAP;
+    case 1:
+        if (!arm_is_secure(env)) {
+            return CP_ACCESS_TRAP;
+        } else if (arm_hcr_el2_eff(env) & HCR_NV) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        return CP_ACCESS_TRAP;
+    case 2:
+        if (!arm_is_secure(env)) {
+            return CP_ACCESS_TRAP;
+        }
+        return CP_ACCESS_OK;
+    case 3:
+        if (env->cp15.scr_el3 & SCR_EEL2) {
+            return CP_ACCESS_OK;
+        } else {
+            return CP_ACCESS_TRAP;
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
 uint64_t gt_get_countervalue(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -2744,6 +2779,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         switch (timeridx) {
         case GTIMER_VIRT:
         case GTIMER_HYPVIRT:
+        case GTIMER_SEC_VEL2:
             offset = cpu->env.cp15.cntvoff_el2;
             break;
         default:
@@ -2858,6 +2894,7 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
     switch (timeridx) {
     case GTIMER_VIRT:
     case GTIMER_HYPVIRT:
+    case GTIMER_SEC_VEL2:
         offset = gt_virt_cnt_offset(env);
         break;
     case GTIMER_PHYS:
@@ -2878,6 +2915,7 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
     switch (timeridx) {
     case GTIMER_VIRT:
     case GTIMER_HYPVIRT:
+    case GTIMER_SEC_VEL2:
         offset = gt_virt_cnt_offset(env);
         break;
     case GTIMER_PHYS:
@@ -3186,6 +3224,62 @@ static void gt_sec_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_SEC, value);
 }
 
+static void gt_sec_pel2_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_SEC_PEL2);
+}
+
+static void gt_sec_pel2_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_SEC_PEL2, value);
+}
+
+static uint64_t gt_sec_pel2_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_SEC_PEL2);
+}
+
+static void gt_sec_pel2_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_SEC_PEL2, value);
+}
+
+static void gt_sec_pel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_SEC_PEL2, value);
+}
+
+static void gt_sec_vel2_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_SEC_VEL2);
+}
+
+static void gt_sec_vel2_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_SEC_VEL2, value);
+}
+
+static uint64_t gt_sec_vel2_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_SEC_VEL2);
+}
+
+static void gt_sec_vel2_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_SEC_VEL2, value);
+}
+
+static void gt_sec_vel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_SEC_VEL2, value);
+}
+
 static void gt_hv_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_HYPVIRT);
@@ -3242,6 +3336,20 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+void arm_gt_sel2timer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_SEC_PEL2);
+}
+
+void arm_gt_sel2vtimer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_SEC_VEL2);
+}
+
 void arm_gt_hvtimer_cb(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -6624,6 +6732,56 @@ static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
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
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_PEL2].ctl),
+      .resetvalue = 0,
+      .writefn = gt_sec_pel2_ctl_write, .raw_writefn = raw_write,
+    },
+    { .name = "CNTHPS_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 5, .opc2 = 2,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_PEL2].cval),
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
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_VEL2].ctl),
+      .resetvalue = 0,
+      .writefn = gt_sec_vel2_ctl_write, .raw_writefn = raw_write,
+    },
+    { .name = "CNTHVS_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 4, .opc2 = 2,
+      .type = ARM_CP_IO, .access = PL2_RW,
+      .accessfn = gt_sel2timer_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_VEL2].cval),
+      .writefn = gt_sec_vel2_cval_write, .raw_writefn = raw_write,
+    },
+#endif
 };
 
 static CPAccessResult nsacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.39.5


