Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE621CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3w-0008La-Fd; Tue, 13 Oct 2026 04:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3f-0007cw-EK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3c-0007ve-FW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so26435245e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880823; x=1792485623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gzfEd+fMuzIkl5MPbXsWVV3S6TkI1FXs7WFleXHIxOA=;
 b=lGCnE8plH62BTdjaKYZf+Uj2+2y9GUG25IoweJhfWi819KdsCxIpOk76/jgMV3DKLp
 MRoVrhxoKM4DKrI5Q9NhUxRyChiZphpx8Ux9OvFKm93kG6GBAcHdyP1NsBVn0UKbg9oW
 SDDhtHNpJvf31qJU5T1WuOHN1qD/XlWpwsq58kFzZe7Y8D+kpfCEyTMOLzibSWAeudKE
 n9paoYrdx0l2i5sZK88HoDcxHpHF+IElzAVtWb143G1w7A31/EXVB/Hl8uI4Ph+dfqcc
 S1EO00gSkKc21aIVujG3vP7j0oqaIEDZgrvPFjwrHK3YLxDGNw1x+EkZEk6jwdYJnynN
 pOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880823; x=1792485623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gzfEd+fMuzIkl5MPbXsWVV3S6TkI1FXs7WFleXHIxOA=;
 b=HiTOjifn9SCEG27AjvcEzGhUSU5LtiI/IosAlntDmZ0cDOumWljImze/Fv51GHvhHR
 AassM8sYwFOVfixGXj1MeCBvB3E+grJLUNZbHydNFNMz/0hbK4wvQW2Pbs2F+ZkH0Fuh
 rBsq2awT/tkj3x69oeBOgSWa19yncrcafimab50jgUcaGFBnhOUo8KSk3ueB1CthgYpt
 GGbpQTI3z7BVPBFUxoqhCoWx0Thn87YlUFrJY/8V9ali8f6VSsAk7qbSYHTS80CnX1vx
 0NBmfvl/QsEcCPSMNmYuJcOh59WDPM1/aR6i2PiuCMUvvApdljgoM+KQiJNmFhLAbm8r
 fCLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSdhrdMorcax3/96AOJ2H0l1bJYgJvDy1P+zHFUTIhzCUpmSoRl1GvJAKPUVFlTVTinxG5/RqJirgw@nongnu.org
X-Gm-Message-State: AFq9FYKh+LRfwOl+r7kLKqTmWZgJeWwKGKnFk8GqVSk6K+PRtoaQG4jT
 1aBwi6nHBlRuGuax22vpMFMZ2baLJ0ryu4BUS/sVMogu3cvZRJf41PgPqAwnvG+UWZvX0mIJEAQ
 jkEUr1bU=
X-Gm-Gg: AYBFou0VWsW2WSoLI3bOZl+tKncDYKfdYYF0hzwMWs5gG6E/mIyFWZ1iaAoe7cQT6AI
 TAbS18JP5QrYrjqzRzifj17p7KYraQqnDfAp2o+zt1X9zMDZ2x6a5OHdmw8cNk4C9S1zUP9FGxk
 QGTaZjYnE0Ov/SPHwFEVLRDaLxMXXZgGJoYveoDa04wkGsunKRajA16K35Kti7A7twuJIXYoCFy
 uNhcGRVHaGDc2R7cWqeGJCXITWnyic6Frw/YzKxaNwN9aOotq2uTdGMGOsQgqsPgZLmbWjG2RRf
 Y8MQ8LWsPmlFAbIrZruXOMcvCLJEQVIccUJUV9h5eHDGLEXQFaxpNMddic/qyEXsuJMYqsTv97e
 WKplTb8CRifGRK2jR/jQbYRzntC2dkIJPwLVWwtXVFgUbJqdYuf0pk5XCH7qhbnLwTdQrVSzAyD
 B25ilb1iJ0wNjG1A79jflJ8jAx6hJ2Nq6oyLOM84qaROn40Goqtn9WdtETl6ERv9Y5jQPXa+vee
 JjFfAGJx7nXJsCWJTT9F9KFziGwWaS9KAFx9EVEyUNFoplSxpTn6tRukvYQLO1z+fz1BE3SRC/B
 blYnPYUEm7o3QQ==
X-Received: by 2002:a05:600c:674a:b0:4a1:7cf8:5433 with SMTP id
 5b1f17b1804b1-4a18e443ee9mr218545885e9.3.1791880822894; 
 Tue, 13 Oct 2026 01:40:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 34/86] target/arm: GICv5 cpuif: Implement
 gicv5_update_virq_vfiq()
Date: Tue, 13 Oct 2026 09:38:41 +0100
Message-ID: <20261013083933.1024405-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Implement gicv5_update_virq_vfiq(), the virtual interrupt domain
equivalent of gicv5_update_irq_fiq().  Based on the current highest
priority pending interrupt for the virtual interrupt domain, we
signal either the VIRQ or VINMI lines.

For VIRQ and VINMI it is important that we call arm_cpu_set_irq()
rather than calling cpu_interrupt() and cpu_reset_interrupt()
directly, because arm_cpu_set_irq() handles the logical OR of the
state from the cpuif and the value of HCR_EL2.{VI,VINMI} to produce
the VIRQ/VINMI signals seen by the rest of the CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 43 +++++++++++++++++++++++++++++++++++-
 target/arm/tcg/trace-events  |  1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index d2454011b40..a938428b20a 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -310,6 +310,35 @@ static void gicv5_update_irq_fiq(CPUARMState *env)
     arm_cpu_set_irq(env_archcpu(env), ARM_CPU_NMI, superpriority);
 }
 
+static void gicv5_update_virq_vfiq(CPUARMState *env)
+{
+    /*
+     * Update whether we are signalling VIRQ or VFIQ based on the
+     * current state of the CPU interface.
+     */
+    GICv5PendingIrq current_hppi;
+    bool virq, superpriority;
+
+    /*
+     * Only the legacy vCPU interface signals VFIQ, and we don't
+     * implement that yet. So we leave ARM_CPU_VFIQ and ARM_CPU_VFNMI
+     * at their default unasserted levels.
+     */
+
+    /*
+     * We signal VIRQ if there is a HPPI of sufficient priority for
+     * the virtual interrupt domain. It has Superpriority if its
+     * priority is 0 (in which case it is CPU_INTERRUPT_VINMI).
+     */
+    current_hppi = gic_virt_hppi(env);
+    superpriority = current_hppi.prio == 0;
+    virq = current_hppi.prio != PRIO_IDLE && !superpriority;
+
+    trace_gicv5_update_virq_vfiq(virq, superpriority);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_VIRQ, virq);
+    arm_cpu_set_irq(env_archcpu(env), ARM_CPU_VINMI, superpriority);
+}
+
 static void gic_recalc_ppi_hppi(CPUARMState *env)
 {
     /*
@@ -398,6 +427,8 @@ static void gic_recalc_virt_ppi_hppi(CPUARMState *env)
 
     trace_gicv5_recalc_virt_ppi_hppi(env->gicv5_cpuif.virt_ppi_hppi.intid,
                                      env->gicv5_cpuif.virt_ppi_hppi.prio);
+
+    gicv5_update_virq_vfiq(env);
 }
 
 void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain, bool virtual)
@@ -408,7 +439,12 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain, bool virtual)
      * If this is a virtual interrupt, do similarly for VIRQ/VFIQ.
      */
     if (virtual) {
-        /* Here we will eventually update the VIRQ/VFIQ state */
+        /*
+         * We don't need to check here for a mismatch between domain
+         * and the domain of the resident VPE, because that will
+         * be checked when gic_virt_hppi() calls back into the IRS.
+         */
+        gicv5_update_virq_vfiq(&cpu->env);
     } else {
         gicv5_update_irq_fiq(&cpu->env);
     }
@@ -775,12 +811,14 @@ static void gic_ich_vctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
     raw_write(env, ri, value);
+    gicv5_update_virq_vfiq(env);
 }
 
 static void gic_ich_vmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
     raw_write(env, ri, value);
+    gicv5_update_virq_vfiq(env);
 }
 
 /*
@@ -798,6 +836,7 @@ static void gic_icc_apr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     if (gicv5_icv_access(env)) {
         env->gicv5_cpuif.ich_apr_el2 = value;
+        gicv5_update_virq_vfiq(env);
     } else {
         GICv5Domain domain = gicv5_logical_domain(env);
         env->gicv5_cpuif.icc_apr[domain] = value;
@@ -844,6 +883,7 @@ static void gic_icc_cr0_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
         vmcr = FIELD_DP64(vmcr, ICH_VMCR_EL2, EN,
                           FIELD_EX64(value, ICC_CR0, EN));
         env->gicv5_cpuif.ich_vmcr_el2 = vmcr;
+        gicv5_update_virq_vfiq(env);
     } else {
         /*
          * For our implementation the link to the IRI is always connected,
@@ -889,6 +929,7 @@ static void gic_icc_pcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
         vmcr = FIELD_DP64(vmcr, ICH_VMCR_EL2, VMPR,
                           FIELD_EX64(value, ICC_PCR, PRIORITY));
         env->gicv5_cpuif.ich_vmcr_el2 = vmcr;
+        gicv5_update_virq_vfiq(env);
     } else {
         GICv5Domain domain = gicv5_logical_domain(env);
 
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index da25ec994cc..71f1369fcda 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -9,4 +9,5 @@ gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrup
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
 gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x%x"
 gicv5_update_irq_fiq(bool irq, bool fiq, bool nmi) "now IRQ %d FIQ %d NMI %d"
+gicv5_update_virq_vfiq(bool virq, bool vinmi) "now VIRQ %d VINMI %d"
 gicv5_update_ppi_state(int ppi, bool level) "PPI %d source level now %d"
-- 
2.43.0


