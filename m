Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8C1C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzIp-0002YC-P6; Tue, 11 Mar 2025 09:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzET-0005Uw-Bb; Tue, 11 Mar 2025 09:01:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEP-0000EK-1N; Tue, 11 Mar 2025 09:01:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2255003f4c6so49940685ad.0; 
 Tue, 11 Mar 2025 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698069; x=1742302869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOr0Iv0DC4pt8besb91uNgjRLEvbLePKXK2ZL6VXyUs=;
 b=SbeYQddCnmDPak1ipsZ9ONRB3vBMjdmuFbUPl10wxeIJjzx4n1b/2g5ivCybwi+cfK
 rnxt/GlutS9jvpWdi4p9mW6joDPbCz2cbAbsAyM3fKBkKQtb0PaOm6YJHNfXwFXMLanz
 DXYFslu/cnWZlcYi/2NOEhbgjJi6zwZ1ZcF43ZopN2kldINmXIRD62hFIm6aEqVEpPsX
 oUkYCTm0mfCyH1erSd1egetgszgmw5n+IqLHdcCVM4NEtZQNx1ZNa7lNTnsDW77fxDqk
 i+01oOpl34oD0/NtMMKpjhdfPFQxMcrBeVYrYxVTdVpeO7ZNPvJ/fpAGabXEUXbik03I
 8YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698069; x=1742302869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOr0Iv0DC4pt8besb91uNgjRLEvbLePKXK2ZL6VXyUs=;
 b=RD3z0IqU6Iz4Rxa9wjj20RRLNZBy4WoRSC/0lQK72oySr7V+DrE5/liGDJSdNUBpcd
 i5DLppGRf+b3JLEiYhPdT6A5IjQVe5IjEXcStgKkomWCwVoDjNTokhkHfR72qC3GJyKO
 YftoNmBiNur8buU03RVhXnKa4vkckKiUG5aRPgw8nxVDqZuwbdu1U7m5p4j+ovwpajku
 XqunGfT0TNEeltioiJnESpX4PgalCCDA/MnrGyLXnlmSL4c9uLsGX4M8s0vF2GcDihP4
 SiUppATm5NCon9Q8wDASuZU4kmaIDSuLmL73F6nNEcyGZi1UH94jI80S0N3CJYncEdd2
 70ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj97HoCXMK7Q2a9Q1t7FLcdKuLe17ZpiHjxuOgsoc09gazEX/OFI74lvoZVxE5jOpwYwN7QudjlQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxpc9cIRKasGIOccWWn9io6MmxYqOkYRxOhJ8ncIM43/nN9dkPn
 tfTOmGDIHaNlefYLb446R2Bow8Z3JfuxSUWYBoC7liuEDGnViOksh06VMA==
X-Gm-Gg: ASbGnctxFx90mMJTbuxhr4kHJDlYqJ/Ymyn47ijRlyWKtTf5rLOX2uUbyF2g1PEOBx4
 DM0mchPacXs63WDBmv1Z2vns7pq928X9gTrzBQ7nPOrJHRZl5SfhQHhuzX5lk39H1flccS/Y3O2
 8Hfxn+b3fyWZuCbDAFdGCMwVTVgPUYHKM28czGPJX4TW7FyfDY8CVokagjXe8hLpubH2CfLvaMW
 HYe5P1a0rTCGTb8mvZdE0FbZr7uFSlglGWlu47pHHAh2Zv96Nwe2/fc/CLV+kn1S4lcxGtHmPcD
 vWp2Jpkb6cA/wk1ggWJEHERKC73MDVuIfvTWyQi7SQ2l/vnWwws=
X-Google-Smtp-Source: AGHT+IExUlv0Jo62kwnGnHDajJY1AZaA8nuTSvQU84mIJwOieUTYENuxymwv7a/4IDwoozsO0bkrXw==
X-Received: by 2002:a17:90b:2e8f:b0:2fe:b907:3b05 with SMTP id
 98e67ed59e1d1-300ff3661a9mr4807699a91.29.1741698068472; 
 Tue, 11 Mar 2025 06:01:08 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 53/72] target/ppc: Restrict ATTN / SCV / PMINSN helpers to TCG
Date: Tue, 11 Mar 2025 22:57:47 +1000
Message-ID: <20250311125815.903177-54-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move helper_attn(), helper_scv() and helper_pminsn() to
tcg-excp_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-15-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h             |   3 -
 target/ppc/excp_helper.c     | 434 -----------------------------------
 target/ppc/tcg-excp_helper.c | 423 +++++++++++++++++++++++++++++++++-
 3 files changed, 421 insertions(+), 439 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 505b589714..8d43983fe1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2755,9 +2755,6 @@ static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
 }
 #endif
 
-G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
-G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
-                                    uint32_t error_code);
 G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
                                        uint32_t error_code, uintptr_t raddr);
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9ba5335698..44e19aacd8 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -30,11 +30,6 @@
 
 #include "trace.h"
 
-#ifdef CONFIG_TCG
-#include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
-#endif
-
 /*****************************************************************************/
 /* Exception processing */
 #ifndef CONFIG_USER_ONLY
@@ -399,21 +394,6 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
     env->reserve_addr = -1;
 }
 
-#ifdef CONFIG_TCG
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-void helper_attn(CPUPPCState *env)
-{
-    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
-    if ((*env->check_attn)(env)) {
-        powerpc_checkstop(env, "host executed attn");
-    } else {
-        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
-                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
-    }
-}
-#endif
-#endif /* CONFIG_TCG */
-
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     /* KVM guests always have MSR[ME] enabled */
@@ -2503,417 +2483,3 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 
 #endif /* !CONFIG_USER_ONLY */
-
-#ifdef CONFIG_TCG
-
-#ifndef CONFIG_USER_ONLY
-void helper_store_msr(CPUPPCState *env, target_ulong val)
-{
-    uint32_t excp = hreg_store_msr(env, val, 0);
-
-    if (excp != 0) {
-        cpu_interrupt_exittb(env_cpu(env));
-        raise_exception(env, excp);
-    }
-}
-
-void helper_ppc_maybe_interrupt(CPUPPCState *env)
-{
-    ppc_maybe_interrupt(env);
-}
-
-#ifdef TARGET_PPC64
-void helper_scv(CPUPPCState *env, uint32_t lev)
-{
-    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
-        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
-    } else {
-        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
-    }
-}
-
-void helper_pminsn(CPUPPCState *env, uint32_t insn)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->halted = 1;
-
-    /* Condition for waking up at 0x100 */
-    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
-        (env->spr[SPR_PSSCR] & PSSCR_EC);
-
-    /* HDECR is not to wake from PM state, it may have already fired */
-    if (env->resume_as_sreset) {
-        PowerPCCPU *cpu = env_archcpu(env);
-        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
-    }
-
-    ppc_maybe_interrupt(env);
-}
-#endif /* TARGET_PPC64 */
-
-static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
-{
-    /* MSR:POW cannot be set by any form of rfi */
-    msr &= ~(1ULL << MSR_POW);
-
-    /* MSR:TGPR cannot be set by any form of rfi */
-    if (env->flags & POWERPC_FLAG_TGPR) {
-        msr &= ~(1ULL << MSR_TGPR);
-    }
-
-#ifdef TARGET_PPC64
-    /* Switching to 32-bit ? Crop the nip */
-    if (!msr_is_64bit(env, msr)) {
-        nip = (uint32_t)nip;
-    }
-#else
-    nip = (uint32_t)nip;
-#endif
-    /* XXX: beware: this is false if VLE is supported */
-    env->nip = nip & ~((target_ulong)0x00000003);
-    hreg_store_msr(env, msr, 1);
-    trace_ppc_excp_rfi(env->nip, env->msr);
-    /*
-     * No need to raise an exception here, as rfi is always the last
-     * insn of a TB
-     */
-    cpu_interrupt_exittb(env_cpu(env));
-    /* Reset the reservation */
-    env->reserve_addr = -1;
-
-    /* Context synchronizing: check if TCG TLB needs flush */
-    check_tlb_flush(env, false);
-}
-
-void helper_rfi(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
-}
-
-#ifdef TARGET_PPC64
-void helper_rfid(CPUPPCState *env)
-{
-    /*
-     * The architecture defines a number of rules for which bits can
-     * change but in practice, we handle this in hreg_store_msr()
-     * which will be called by do_rfi(), so there is no need to filter
-     * here
-     */
-    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
-}
-
-void helper_rfscv(CPUPPCState *env)
-{
-    do_rfi(env, env->lr, env->ctr);
-}
-
-void helper_hrfid(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
-}
-
-void helper_rfebb(CPUPPCState *env, target_ulong s)
-{
-    target_ulong msr = env->msr;
-
-    /*
-     * Handling of BESCR bits 32:33 according to PowerISA v3.1:
-     *
-     * "If BESCR 32:33 != 0b00 the instruction is treated as if
-     *  the instruction form were invalid."
-     */
-    if (env->spr[SPR_BESCR] & BESCR_INVALID) {
-        raise_exception_err(env, POWERPC_EXCP_PROGRAM,
-                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
-    }
-
-    env->nip = env->spr[SPR_EBBRR];
-
-    /* Switching to 32-bit ? Crop the nip */
-    if (!msr_is_64bit(env, msr)) {
-        env->nip = (uint32_t)env->spr[SPR_EBBRR];
-    }
-
-    if (s) {
-        env->spr[SPR_BESCR] |= BESCR_GE;
-    } else {
-        env->spr[SPR_BESCR] &= ~BESCR_GE;
-    }
-}
-
-/*
- * Triggers or queues an 'ebb_excp' EBB exception. All checks
- * but FSCR, HFSCR and msr_pr must be done beforehand.
- *
- * PowerISA v3.1 isn't clear about whether an EBB should be
- * postponed or cancelled if the EBB facility is unavailable.
- * Our assumption here is that the EBB is cancelled if both
- * FSCR and HFSCR EBB facilities aren't available.
- */
-static void do_ebb(CPUPPCState *env, int ebb_excp)
-{
-    PowerPCCPU *cpu = env_archcpu(env);
-
-    /*
-     * FSCR_EBB and FSCR_IC_EBB are the same bits used with
-     * HFSCR.
-     */
-    helper_fscr_facility_check(env, FSCR_EBB, 0, FSCR_IC_EBB);
-    helper_hfscr_facility_check(env, FSCR_EBB, "EBB", FSCR_IC_EBB);
-
-    if (ebb_excp == POWERPC_EXCP_PERFM_EBB) {
-        env->spr[SPR_BESCR] |= BESCR_PMEO;
-    } else if (ebb_excp == POWERPC_EXCP_EXTERNAL_EBB) {
-        env->spr[SPR_BESCR] |= BESCR_EEO;
-    }
-
-    if (FIELD_EX64(env->msr, MSR, PR)) {
-        powerpc_excp(cpu, ebb_excp);
-    } else {
-        ppc_set_irq(cpu, PPC_INTERRUPT_EBB, 1);
-    }
-}
-
-void raise_ebb_perfm_exception(CPUPPCState *env)
-{
-    bool perfm_ebb_enabled = env->spr[SPR_POWER_MMCR0] & MMCR0_EBE &&
-                             env->spr[SPR_BESCR] & BESCR_PME &&
-                             env->spr[SPR_BESCR] & BESCR_GE;
-
-    if (!perfm_ebb_enabled) {
-        return;
-    }
-
-    do_ebb(env, POWERPC_EXCP_PERFM_EBB);
-}
-#endif /* TARGET_PPC64 */
-
-/*****************************************************************************/
-/* Embedded PowerPC specific helpers */
-void helper_40x_rfci(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_40x_SRR2], env->spr[SPR_40x_SRR3]);
-}
-
-void helper_rfci(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1]);
-}
-
-void helper_rfdi(CPUPPCState *env)
-{
-    /* FIXME: choose CSRR1 or DSRR1 based on cpu type */
-    do_rfi(env, env->spr[SPR_BOOKE_DSRR0], env->spr[SPR_BOOKE_DSRR1]);
-}
-
-void helper_rfmci(CPUPPCState *env)
-{
-    /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
-    do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
-}
-
-/* Embedded.Processor Control */
-static int dbell2irq(target_ulong rb)
-{
-    int msg = rb & DBELL_TYPE_MASK;
-    int irq = -1;
-
-    switch (msg) {
-    case DBELL_TYPE_DBELL:
-        irq = PPC_INTERRUPT_DOORBELL;
-        break;
-    case DBELL_TYPE_DBELL_CRIT:
-        irq = PPC_INTERRUPT_CDOORBELL;
-        break;
-    case DBELL_TYPE_G_DBELL:
-    case DBELL_TYPE_G_DBELL_CRIT:
-    case DBELL_TYPE_G_DBELL_MC:
-        /* XXX implement */
-    default:
-        break;
-    }
-
-    return irq;
-}
-
-void helper_msgclr(CPUPPCState *env, target_ulong rb)
-{
-    int irq = dbell2irq(rb);
-
-    if (irq < 0) {
-        return;
-    }
-
-    ppc_set_irq(env_archcpu(env), irq, 0);
-}
-
-void helper_msgsnd(target_ulong rb)
-{
-    int irq = dbell2irq(rb);
-    int pir = rb & DBELL_PIRTAG_MASK;
-    CPUState *cs;
-
-    if (irq < 0) {
-        return;
-    }
-
-    bql_lock();
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *cenv = &cpu->env;
-
-        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
-            ppc_set_irq(cpu, irq, 1);
-        }
-    }
-    bql_unlock();
-}
-
-/* Server Processor Control */
-
-static bool dbell_type_server(target_ulong rb)
-{
-    /*
-     * A Directed Hypervisor Doorbell message is sent only if the
-     * message type is 5. All other types are reserved and the
-     * instruction is a no-op
-     */
-    return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
-}
-
-static inline bool dbell_bcast_core(target_ulong rb)
-{
-    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
-}
-
-static inline bool dbell_bcast_subproc(target_ulong rb)
-{
-    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
-}
-
-/*
- * Send an interrupt to a thread in the same core as env).
- */
-static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
-{
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-
-    if (ppc_cpu_lpar_single_threaded(cs)) {
-        if (target_tir == 0) {
-            ppc_set_irq(cpu, irq, 1);
-        }
-    } else {
-        CPUState *ccs;
-
-        /* Does iothread need to be locked for walking CPU list? */
-        bql_lock();
-        THREAD_SIBLING_FOREACH(cs, ccs) {
-            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
-            if (target_tir == ppc_cpu_tir(ccpu)) {
-                ppc_set_irq(ccpu, irq, 1);
-                break;
-            }
-        }
-        bql_unlock();
-    }
-}
-
-void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
-{
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
-}
-
-void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
-{
-    int pir = rb & DBELL_PROCIDTAG_MASK;
-    bool brdcast = false;
-    CPUState *cs, *ccs;
-    PowerPCCPU *cpu;
-
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
-    if (!(env->insns_flags2 & PPC2_ISA300)) {
-        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
-        return;
-    }
-
-    /* POWER9 and later msgsnd is a global (targets any thread) */
-    cpu = ppc_get_vcpu_by_pir(pir);
-    if (!cpu) {
-        return;
-    }
-    cs = CPU(cpu);
-
-    if (dbell_bcast_core(rb) || (dbell_bcast_subproc(rb) &&
-                                 (env->flags & POWERPC_FLAG_SMT_1LPAR))) {
-        brdcast = true;
-    }
-
-    if (ppc_cpu_core_single_threaded(cs) || !brdcast) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
-        return;
-    }
-
-    /*
-     * Why is bql needed for walking CPU list? Answer seems to be because ppc
-     * irq handling needs it, but ppc_set_irq takes the lock itself if needed,
-     * so could this be removed?
-     */
-    bql_lock();
-    THREAD_SIBLING_FOREACH(cs, ccs) {
-        ppc_set_irq(POWERPC_CPU(ccs), PPC_INTERRUPT_HDOORBELL, 1);
-    }
-    bql_unlock();
-}
-
-#ifdef TARGET_PPC64
-void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
-{
-    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSGP);
-
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_DOORBELL, 0);
-}
-
-/*
- * sends a message to another thread  on the same
- * multi-threaded processor
- */
-void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
-{
-    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
-
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
-}
-#endif /* TARGET_PPC64 */
-
-/* Single-step tracing */
-void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
-{
-    uint32_t error_code = 0;
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        /* Load/store reporting, SRR1[35, 36] and SDAR, are not implemented. */
-        env->spr[SPR_POWER_SIAR] = prev_ip;
-        error_code = PPC_BIT(33);
-    }
-    raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
-}
-
-#endif /* !CONFIG_USER_ONLY */
-#endif /* CONFIG_TCG */
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 2459d2d095..4b859a8ffa 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
@@ -55,13 +56,13 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
 
 #ifndef CONFIG_USER_ONLY
 
-void raise_exception_err(CPUPPCState *env, uint32_t exception,
+static G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
                                            uint32_t error_code)
 {
     raise_exception_err_ra(env, exception, error_code, 0);
 }
 
-void raise_exception(CPUPPCState *env, uint32_t exception)
+static G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
@@ -426,4 +427,422 @@ uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
     return insn;
 }
 
+#if defined(TARGET_PPC64)
+void helper_attn(CPUPPCState *env)
+{
+    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
+    if ((*env->check_attn)(env)) {
+        powerpc_checkstop(env, "host executed attn");
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+}
+
+void helper_scv(CPUPPCState *env, uint32_t lev)
+{
+    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
+        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
+    }
+}
+
+void helper_pminsn(CPUPPCState *env, uint32_t insn)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->halted = 1;
+
+    /* Condition for waking up at 0x100 */
+    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
+        (env->spr[SPR_PSSCR] & PSSCR_EC);
+
+    /* HDECR is not to wake from PM state, it may have already fired */
+    if (env->resume_as_sreset) {
+        PowerPCCPU *cpu = env_archcpu(env);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+    }
+
+    ppc_maybe_interrupt(env);
+}
+
+#endif /* TARGET_PPC64 */
+void helper_store_msr(CPUPPCState *env, target_ulong val)
+{
+    uint32_t excp = hreg_store_msr(env, val, 0);
+
+    if (excp != 0) {
+        cpu_interrupt_exittb(env_cpu(env));
+        raise_exception(env, excp);
+    }
+}
+
+void helper_ppc_maybe_interrupt(CPUPPCState *env)
+{
+    ppc_maybe_interrupt(env);
+}
+
+static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
+{
+    /* MSR:POW cannot be set by any form of rfi */
+    msr &= ~(1ULL << MSR_POW);
+
+    /* MSR:TGPR cannot be set by any form of rfi */
+    if (env->flags & POWERPC_FLAG_TGPR) {
+        msr &= ~(1ULL << MSR_TGPR);
+    }
+
+#ifdef TARGET_PPC64
+    /* Switching to 32-bit ? Crop the nip */
+    if (!msr_is_64bit(env, msr)) {
+        nip = (uint32_t)nip;
+    }
+#else
+    nip = (uint32_t)nip;
+#endif
+    /* XXX: beware: this is false if VLE is supported */
+    env->nip = nip & ~((target_ulong)0x00000003);
+    hreg_store_msr(env, msr, 1);
+    trace_ppc_excp_rfi(env->nip, env->msr);
+    /*
+     * No need to raise an exception here, as rfi is always the last
+     * insn of a TB
+     */
+    cpu_interrupt_exittb(env_cpu(env));
+    /* Reset the reservation */
+    env->reserve_addr = -1;
+
+    /* Context synchronizing: check if TCG TLB needs flush */
+    check_tlb_flush(env, false);
+}
+
+void helper_rfi(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
+}
+
+#ifdef TARGET_PPC64
+void helper_rfid(CPUPPCState *env)
+{
+    /*
+     * The architecture defines a number of rules for which bits can
+     * change but in practice, we handle this in hreg_store_msr()
+     * which will be called by do_rfi(), so there is no need to filter
+     * here
+     */
+    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
+}
+
+void helper_rfscv(CPUPPCState *env)
+{
+    do_rfi(env, env->lr, env->ctr);
+}
+
+void helper_hrfid(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
+}
+
+void helper_rfebb(CPUPPCState *env, target_ulong s)
+{
+    target_ulong msr = env->msr;
+
+    /*
+     * Handling of BESCR bits 32:33 according to PowerISA v3.1:
+     *
+     * "If BESCR 32:33 != 0b00 the instruction is treated as if
+     *  the instruction form were invalid."
+     */
+    if (env->spr[SPR_BESCR] & BESCR_INVALID) {
+        raise_exception_err(env, POWERPC_EXCP_PROGRAM,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+
+    env->nip = env->spr[SPR_EBBRR];
+
+    /* Switching to 32-bit ? Crop the nip */
+    if (!msr_is_64bit(env, msr)) {
+        env->nip = (uint32_t)env->spr[SPR_EBBRR];
+    }
+
+    if (s) {
+        env->spr[SPR_BESCR] |= BESCR_GE;
+    } else {
+        env->spr[SPR_BESCR] &= ~BESCR_GE;
+    }
+}
+
+/*
+ * Triggers or queues an 'ebb_excp' EBB exception. All checks
+ * but FSCR, HFSCR and msr_pr must be done beforehand.
+ *
+ * PowerISA v3.1 isn't clear about whether an EBB should be
+ * postponed or cancelled if the EBB facility is unavailable.
+ * Our assumption here is that the EBB is cancelled if both
+ * FSCR and HFSCR EBB facilities aren't available.
+ */
+static void do_ebb(CPUPPCState *env, int ebb_excp)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+
+    /*
+     * FSCR_EBB and FSCR_IC_EBB are the same bits used with
+     * HFSCR.
+     */
+    helper_fscr_facility_check(env, FSCR_EBB, 0, FSCR_IC_EBB);
+    helper_hfscr_facility_check(env, FSCR_EBB, "EBB", FSCR_IC_EBB);
+
+    if (ebb_excp == POWERPC_EXCP_PERFM_EBB) {
+        env->spr[SPR_BESCR] |= BESCR_PMEO;
+    } else if (ebb_excp == POWERPC_EXCP_EXTERNAL_EBB) {
+        env->spr[SPR_BESCR] |= BESCR_EEO;
+    }
+
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        powerpc_excp(cpu, ebb_excp);
+    } else {
+        ppc_set_irq(cpu, PPC_INTERRUPT_EBB, 1);
+    }
+}
+
+void raise_ebb_perfm_exception(CPUPPCState *env)
+{
+    bool perfm_ebb_enabled = env->spr[SPR_POWER_MMCR0] & MMCR0_EBE &&
+                             env->spr[SPR_BESCR] & BESCR_PME &&
+                             env->spr[SPR_BESCR] & BESCR_GE;
+
+    if (!perfm_ebb_enabled) {
+        return;
+    }
+
+    do_ebb(env, POWERPC_EXCP_PERFM_EBB);
+}
+#endif /* TARGET_PPC64 */
+
+/*****************************************************************************/
+/* Embedded PowerPC specific helpers */
+void helper_40x_rfci(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_40x_SRR2], env->spr[SPR_40x_SRR3]);
+}
+
+void helper_rfci(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1]);
+}
+
+void helper_rfdi(CPUPPCState *env)
+{
+    /* FIXME: choose CSRR1 or DSRR1 based on cpu type */
+    do_rfi(env, env->spr[SPR_BOOKE_DSRR0], env->spr[SPR_BOOKE_DSRR1]);
+}
+
+void helper_rfmci(CPUPPCState *env)
+{
+    /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
+    do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
+}
+
+/* Embedded.Processor Control */
+static int dbell2irq(target_ulong rb)
+{
+    int msg = rb & DBELL_TYPE_MASK;
+    int irq = -1;
+
+    switch (msg) {
+    case DBELL_TYPE_DBELL:
+        irq = PPC_INTERRUPT_DOORBELL;
+        break;
+    case DBELL_TYPE_DBELL_CRIT:
+        irq = PPC_INTERRUPT_CDOORBELL;
+        break;
+    case DBELL_TYPE_G_DBELL:
+    case DBELL_TYPE_G_DBELL_CRIT:
+    case DBELL_TYPE_G_DBELL_MC:
+        /* XXX implement */
+    default:
+        break;
+    }
+
+    return irq;
+}
+
+void helper_msgclr(CPUPPCState *env, target_ulong rb)
+{
+    int irq = dbell2irq(rb);
+
+    if (irq < 0) {
+        return;
+    }
+
+    ppc_set_irq(env_archcpu(env), irq, 0);
+}
+
+void helper_msgsnd(target_ulong rb)
+{
+    int irq = dbell2irq(rb);
+    int pir = rb & DBELL_PIRTAG_MASK;
+    CPUState *cs;
+
+    if (irq < 0) {
+        return;
+    }
+
+    bql_lock();
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *cenv = &cpu->env;
+
+        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
+            ppc_set_irq(cpu, irq, 1);
+        }
+    }
+    bql_unlock();
+}
+
+/* Server Processor Control */
+
+static bool dbell_type_server(target_ulong rb)
+{
+    /*
+     * A Directed Hypervisor Doorbell message is sent only if the
+     * message type is 5. All other types are reserved and the
+     * instruction is a no-op
+     */
+    return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
+}
+
+static inline bool dbell_bcast_core(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
+}
+
+static inline bool dbell_bcast_subproc(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
+}
+
+/*
+ * Send an interrupt to a thread in the same core as env).
+ */
+static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+
+    if (ppc_cpu_lpar_single_threaded(cs)) {
+        if (target_tir == 0) {
+            ppc_set_irq(cpu, irq, 1);
+        }
+    } else {
+        CPUState *ccs;
+
+        /* Does iothread need to be locked for walking CPU list? */
+        bql_lock();
+        THREAD_SIBLING_FOREACH(cs, ccs) {
+            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+            if (target_tir == ppc_cpu_tir(ccpu)) {
+                ppc_set_irq(ccpu, irq, 1);
+                break;
+            }
+        }
+        bql_unlock();
+    }
+}
+
+void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
+{
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
+}
+
+void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
+{
+    int pir = rb & DBELL_PROCIDTAG_MASK;
+    bool brdcast = false;
+    CPUState *cs, *ccs;
+    PowerPCCPU *cpu;
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
+    if (!(env->insns_flags2 & PPC2_ISA300)) {
+        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
+        return;
+    }
+
+    /* POWER9 and later msgsnd is a global (targets any thread) */
+    cpu = ppc_get_vcpu_by_pir(pir);
+    if (!cpu) {
+        return;
+    }
+    cs = CPU(cpu);
+
+    if (dbell_bcast_core(rb) || (dbell_bcast_subproc(rb) &&
+                                 (env->flags & POWERPC_FLAG_SMT_1LPAR))) {
+        brdcast = true;
+    }
+
+    if (ppc_cpu_core_single_threaded(cs) || !brdcast) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
+        return;
+    }
+
+    /*
+     * Why is bql needed for walking CPU list? Answer seems to be because ppc
+     * irq handling needs it, but ppc_set_irq takes the lock itself if needed,
+     * so could this be removed?
+     */
+    bql_lock();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        ppc_set_irq(POWERPC_CPU(ccs), PPC_INTERRUPT_HDOORBELL, 1);
+    }
+    bql_unlock();
+}
+
+#ifdef TARGET_PPC64
+void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
+{
+    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSGP);
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_DOORBELL, 0);
+}
+
+/*
+ * sends a message to another thread  on the same
+ * multi-threaded processor
+ */
+void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
+{
+    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
+}
+#endif /* TARGET_PPC64 */
+
+/* Single-step tracing */
+void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
+{
+    uint32_t error_code = 0;
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        /* Load/store reporting, SRR1[35, 36] and SDAR, are not implemented. */
+        env->spr[SPR_POWER_SIAR] = prev_ip;
+        error_code = PPC_BIT(33);
+    }
+    raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
+}
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


