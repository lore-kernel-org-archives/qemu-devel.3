Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CBBC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 18:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnNA2-0007aj-FY; Thu, 21 Mar 2024 14:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnN9z-0007aH-DP
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:29:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnN9x-0003t1-I7
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:29:03 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso2413972a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711045740; x=1711650540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pCZe9c97mSPduNcttPxhwF3ZnoIb0Wd8cTRIAbH1CTg=;
 b=dPrfS9cdPoknkoInZTVL8P+IcgrWyF+4GRxWo+NCwRXs9fYaooMnz/Q53APBtHX3Bh
 q5NiwYGYVz3mOXJnMZe3/UdLFSGcB/+wexIqsF2pUG8KmbVP5HQt3dc41eTs6yD4jeC0
 EAwaH3S+2vQhCGwzt1PoEuRLp4owcymcYSCjrw8FyriT9V1X6Jil4a5VjTff2M0odqmN
 IKhzhZi615X/8jE9cbW77aRTZ3omsz+5rXvfJBTEdcwGuhkecwQQ8nQ5FobJSg6CrH/M
 m7HntkO26IL8z9m2AKJ/m6fY+A4mMOEWHtiVdNj9qv38RYqxGRcTs9b3q5fDMx0PmJLg
 SH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711045740; x=1711650540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pCZe9c97mSPduNcttPxhwF3ZnoIb0Wd8cTRIAbH1CTg=;
 b=ODRpOB+AlYfmxr32dvKwU5lhidEYwo2EQIuydHWyK9L6C9wZ6SoPGbh5ClEkWL02cB
 yRwL14LuzfPSwzV2rnO99LxKdUEbkO/JJz0BJp/Q15KHecAn1gYZ/4qaGjzoaD0I6q21
 abGOiebGqTV+vFknTd3IVj/T2M9CKyy9bf7WtruJT2WmdXjZBIHANEAvbEYAH34ExjWk
 M1TyrCWv4lMvb4WO4YmM6c/SXgSxgSVkqEjF5Vh55AOjlHHlu1orkgtWHXStMWO+8hr9
 Dj09ohyJFqj7macirw/YhkgxTRA0AFFrgcFfqYQv5fMC7+EgFp7NQE1aTrA0n2M19G81
 kVlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeA0m+Ox2ViCfrGKbL/HfdsUzNy+qrpYbvbpsoA6VYQighh9FuUNXr2ItxRuyLdCfKPxwOWdvmAgAeQIIW42JmiR2ZLwo=
X-Gm-Message-State: AOJu0Yyxvpmyi3R+dfXAqthm633J97GxshzLGE4Yy1TStNzF+4KRJzK0
 PZhogO8U+HWf+W3tUXJIiHDAgZ8yTZZE6OPvzVedu8gXabNd2veDo4012iAdi1fZjRN/TaMXv8e
 v9pqr/CkH4jCdjivuBpeeKWX20IIdRGSHbXtUOw==
X-Google-Smtp-Source: AGHT+IEc0QUfAhto+Ob5eSv9JXQk1wfN5nKjoy0owKd9IBUvLItEBwIQXue64VrKZlKR8H+MefSrdVFEtKrqA0k5Skw=
X-Received: by 2002:a50:d508:0:b0:56b:d1c6:66a5 with SMTP id
 u8-20020a50d508000000b0056bd1c666a5mr1397813edi.6.1711045739781; Thu, 21 Mar
 2024 11:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240321130812.2983113-1-ruanjinjie@huawei.com>
 <20240321130812.2983113-7-ruanjinjie@huawei.com>
 <CAFEAcA-SO3akirm+jgKGRvKH1bcsf1bLJE2uOCOoXi1h78WwFA@mail.gmail.com>
In-Reply-To: <CAFEAcA-SO3akirm+jgKGRvKH1bcsf1bLJE2uOCOoXi1h78WwFA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 18:28:48 +0000
Message-ID: <CAFEAcA8+9Xd-GDNzBqGfDxoc7Bg-+wK59vcsyyNmrXrvAitAuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 21 Mar 2024 at 15:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> Something somewhere needs to implement "if SCTLR_ELx.NMI is 0 then
> we don't take EXCP_VINMI etc but instead (maybe) EXCP_VIRQ etc".
> At the moment nothing does that:
>  * arm_cpu_update_vinmi() doesn't look at the NMI bit before
>    deciding whether to set CPU_INTERRUPT_VINMI
>  * in arm_excp_unmasked() if NMI is 0 then allIntMask takes its
>    default value of false and so arm_excp_unmasked() returns true,
>    so VINMI is not masked
>  * arm_cpu_exec_interrupt() doesn't look at the NMI bit before
>    deciding whether to check the CPU_INTERRUPT_VINMI bit in interrupt_request
>
> So even if SCTLR_ELx.NMI is 0 we'll still try to take a VINMI
> if it's set up in the HCR_EL2 bits.
>
> However we do this the required behaviour is that if NMI is 0
> then it is as if the interrupt doesn't have superpriority and
> it falls back to being handled as an ordinary IRQ, VIRQ, VFIQ etc.
> I think the best place to do this is probably here in
> arm_cpu_exec_interrupt() -- if SCTLR_ELx.NMI isn't set then
> treat the VFNMI bit like VFIQ, the VINMI bit like VIRQ, and
> the NMI bit like IRQ.

Folding in something like this I think will work:

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 91c2896de0f..797ae3eb805 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -837,7 +837,8 @@ static bool arm_cpu_exec_interrupt(CPUState *cs,
int interrupt_request)

     /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */

-    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
+        (arm_sctlr(env, cur_el) & SCTLR_NMI)) {
         if (interrupt_request & CPU_INTERRUPT_NMI) {
             excp_idx = EXCP_NMI;
             target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
@@ -862,7 +863,22 @@ static bool arm_cpu_exec_interrupt(CPUState *cs,
int interrupt_request)
                 goto found;
             }
         }
+    } else {
+        /*
+         * NMI disabled: interrupts with superpriority are handled
+         * as if they didn't have it
+         */
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
+            interrupt_request |= CPU_INTERRUPT_HARD;
+        }
+        if (interrupt_request & CPU_INTERRUPT_VINMI) {
+            interrupt_request |= CPU_INTERRUPT_VIRQ;
+        }
+        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
+            interrupt_request |= CPU_INTERRUPT_VFIQ;
+        }
     }
+
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx = EXCP_FIQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);


> What semantics do we intend for the VINMI/VFNMI bits in interrupt_request
> and for the incoming IRQ, FIQ, NMI lines? The GIC spec suggests
> (but doesn't mandate) that NMI could be signalled by asserting
> both NMI and IRQ, and plain IRQ by asserting just IRQ (table 4-6
> in the GIC spec). I think the GIC changes in this patchset assert
> only the NMI line for an IRQNMI, and not both NMI and IRQ. That's OK
> and I think makes more sense for QEMU than signalling both lines,
> but it's not the same as what we wind up doing with the handling
> of the HCR_EL2 bits in these functions, because you don't change
> the existing arm_cpu_update_virq() so that it only sets the
> CPU_INTERRUPT_VIRQ bit if this is a VIRQ and not a VIRQNMI.
> So if the guest sets HCR_EL2.VI and HCRX_EL2.VINMI then
> arm_cpu_update_virq() will say "this is a VIRQ" and also
> arm_cpu_update_vinmi() will say "This is a VINMI" and so both bits
> get set in the interrupt_request field.
>
> I think the fix for this is probably to have arm_cpu_update_virq()
> and arm_cpu_update_vfiq() check that this is not a VINMI/VFNMI,
> so we only set 1 bit in interrupt_request, not 2.

And for this a change like:

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 03a48a41366..91c2896de0f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -926,7 +926,8 @@ void arm_cpu_update_virq(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);

-    bool new_state = (env->cp15.hcr_el2 & HCR_VI) ||
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
+                      !(arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VIRQ);

     if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
@@ -947,7 +948,8 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);

-    bool new_state = (env->cp15.hcr_el2 & HCR_VF) ||
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VF) &&
+                      !(arm_hcrx_el2_eff(env) & HCRX_VFNMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VFIQ);

     if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {


thanks
-- PMM

