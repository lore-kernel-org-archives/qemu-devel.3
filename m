Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05179C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUO-0007gC-B3; Fri, 08 Mar 2024 10:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUK-0007LF-AL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:24 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUH-0004Rs-8l
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e4f15710aso587118f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913020; x=1710517820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8cudjxseJfBqRgnwTHuE2v1lkoipHqT1HiImqg+oJ0=;
 b=xR1b0QanZpfVGeyGbGyG+Gs8S5bNh72jhI064sF474vLGKAM88/VDH4xhhvJd5hyL0
 OKqRotUqN06uUadlN7KQ8yMAKz1TdFJKqDZpIhqDx4ziUJ5xpraT3C3YHN9zby++/odM
 wYhRgzmArHxgTpviIa/A9LmR9YR7ILIWsWkMddvDA8dNEIdTpK59ywZxLeW5+TzsJ3bY
 BLKrUbPix77Z12Ksg6P+ydPm23HRrYKUOr3PEa+5HtZ44/7/j3vgAo/Qz82xWdiOV99p
 R7qmk5FSfdrJs6mSCjpiRBlU916qUbSWjTJ1tLs/JELZFVT2tS05Bp8qkMTJprqbHOkd
 lf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913020; x=1710517820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8cudjxseJfBqRgnwTHuE2v1lkoipHqT1HiImqg+oJ0=;
 b=dayV3qBJuGaCIeINT6dx+ebaDY9er81kJdjtRqMOZiq8xJdHOIbcBstLiKLLFBrQFd
 nL7Y3v08WdQto40x9gM3vwBIinPfcS23JFH9dDiA3TAhJzesjFaNnFeL1bCd4mo+flkR
 ZYnOwOBH5Me4L+r2iPvE6lbJelDI1BJlPy7mfk03V6dw8tZPnuGxUmQPRj9m3S9y8i0u
 T/Fctle3CUb0Z8NVeJWftfarMEmMg38KWKfDXymRHqS5MuzsGix58F+wOY1IZHDCf4gJ
 G/MKJIvqF3km7nMTZDy9uSX0Ka4jZ+ngHXC/7rFj9bA8VQaD5W8wPGimD3g6lLBA/e9n
 FKeA==
X-Gm-Message-State: AOJu0YyFPqbEZtnGFwdOqxWr5wO7uwx1JBd8ivNtD+q5KOTjrZdFKedi
 G6sEo9TOH8VAQY1ZT7RIXlVYzVfkQ50IW7tSf3yKkrOIsjH+bjpy6i8LNItU5/OTHWkXZ/519TG
 U
X-Google-Smtp-Source: AGHT+IFmPBbxhD21/Q6MfSlQCEE7+KQ63WrDoK6NR48ydWxdI2Zzg2mUKwYugMVEsLx0ltdCEUNBtQ==
X-Received: by 2002:a5d:63d2:0:b0:33e:6a80:353b with SMTP id
 c18-20020a5d63d2000000b0033e6a80353bmr2834705wrw.42.1709913019765; 
 Fri, 08 Mar 2024 07:50:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling
Date: Fri,  8 Mar 2024 15:50:08 +0000
Message-Id: <20240308155015.3637663-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When ID_AA64MMFR0_EL1.ECV is 0b0010, a new register CNTPOFF_EL2 is
implemented.  This is similar to the existing CNTVOFF_EL2, except
that it controls a hypervisor-adjustable offset made to the physical
counter and timer.

Implement the handling for this register, which includes control/trap
bits in SCR_EL3 and CNTHCTL_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301183219.2424889-8-peter.maydell@linaro.org
---
 target/arm/cpu-features.h |  5 +++
 target/arm/cpu.h          |  1 +
 target/arm/helper.c       | 68 +++++++++++++++++++++++++++++++++++++--
 target/arm/trace-events   |  1 +
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b447ec5c0e6..e5758d9fbc8 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -746,6 +746,11 @@ static inline bool isar_feature_aa64_ecv_traps(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 0;
 }
 
+static inline bool isar_feature_aa64_ecv(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 1;
+}
+
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c827daa33fa..bc0c84873ff 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -452,6 +452,7 @@ typedef struct CPUArchState {
         uint64_t c14_cntkctl; /* Timer Control register */
         uint64_t cnthctl_el2; /* Counter/Timer Hyp Control register */
         uint64_t cntvoff_el2; /* Counter Virtual Offset register */
+        uint64_t cntpoff_el2; /* Counter Physical Offset register */
         ARMGenericTimer c14_timer[NUM_GTIMERS];
         uint32_t c15_cpar; /* XScale Coprocessor Access Register */
         uint32_t c15_ticonfig; /* TI925T configuration byte.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 68b5d6a4cb0..3f3a5b55d4a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1923,6 +1923,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_rme, cpu)) {
             valid_mask |= SCR_NSE | SCR_GPF;
         }
+        if (cpu_isar_feature(aa64_ecv, cpu)) {
+            valid_mask |= SCR_ECVEN;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -2682,6 +2685,25 @@ void gt_rme_post_el_change(ARMCPU *cpu, void *ignored)
     gt_update_irq(cpu, GTIMER_PHYS);
 }
 
+static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
+{
+    if ((env->cp15.scr_el3 & SCR_ECVEN) &&
+        FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV) &&
+        arm_is_el2_enabled(env) &&
+        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        return env->cp15.cntpoff_el2;
+    }
+    return 0;
+}
+
+static uint64_t gt_phys_cnt_offset(CPUARMState *env)
+{
+    if (arm_current_el(env) >= 2) {
+        return 0;
+    }
+    return gt_phys_raw_cnt_offset(env);
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2692,7 +2714,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * reset timer to when ISTATUS next has to change
          */
         uint64_t offset = timeridx == GTIMER_VIRT ?
-                                      cpu->env.cp15.cntvoff_el2 : 0;
+            cpu->env.cp15.cntvoff_el2 : gt_phys_raw_cnt_offset(&cpu->env);
         uint64_t count = gt_get_countervalue(&cpu->env);
         /* Note that this must be unsigned 64 bit arithmetic: */
         int istatus = count - offset >= gt->cval;
@@ -2755,7 +2777,7 @@ static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env);
+    return gt_get_countervalue(env) - gt_phys_cnt_offset(env);
 }
 
 static uint64_t gt_virt_cnt_offset(CPUARMState *env)
@@ -2804,6 +2826,9 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
     case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
+    case GTIMER_PHYS:
+        offset = gt_phys_cnt_offset(env);
+        break;
     }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
@@ -2821,6 +2846,9 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
     case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
+    case GTIMER_PHYS:
+        offset = gt_phys_cnt_offset(env);
+        break;
     }
 
     trace_arm_gt_tval_write(timeridx, value);
@@ -3000,6 +3028,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1NVVCT_MASK |
             R_CNTHCTL_EVNTIS_MASK;
     }
+    if (cpu_isar_feature(aa64_ecv, cpu)) {
+        valid_mask |= R_CNTHCTL_ECV_MASK;
+    }
 
     /* Clear RES0 bits */
     value &= valid_mask;
@@ -3417,6 +3448,34 @@ static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
     },
 };
 
+static CPAccessResult gt_cntpoff_access(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    if (arm_current_el(env) == 2 && !(env->cp15.scr_el3 & SCR_ECVEN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static void gt_cntpoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    trace_arm_gt_cntpoff_write(value);
+    raw_write(env, ri, value);
+    gt_recalc_timer(cpu, GTIMER_PHYS);
+}
+
+static const ARMCPRegInfo gen_timer_cntpoff_reginfo = {
+    .name = "CNTPOFF_EL2", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 0, .opc2 = 6,
+    .access = PL2_RW, .type = ARM_CP_IO, .resetvalue = 0,
+    .accessfn = gt_cntpoff_access, .writefn = gt_cntpoff_write,
+    .nv2_redirect_offset = 0x1a8,
+    .fieldoffset = offsetof(CPUARMState, cp15.cntpoff_el2),
+};
 #else
 
 /*
@@ -9301,6 +9360,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_ecv_traps, cpu)) {
         define_arm_cp_regs(cpu, gen_timer_ecv_cp_reginfo);
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu_isar_feature(aa64_ecv, cpu)) {
+        define_one_arm_cp_reg(cpu, &gen_timer_cntpoff_reginfo);
+    }
+#endif
     if (arm_feature(env, ARM_FEATURE_VAPA)) {
         ARMCPRegInfo vapa_cp_reginfo[] = {
             { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 48cc0512dbe..4438dce7bec 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -8,6 +8,7 @@ arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value 0x%"
 arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value 0x%" PRIx64
 arm_gt_imask_toggle(int timer) "gt_ctl_write: timer %d IMASK toggle"
 arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value 0x%" PRIx64
+arm_gt_cntpoff_write(uint64_t value) "gt_cntpoff_write: value 0x%" PRIx64
 arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
-- 
2.34.1


