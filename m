Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD426C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 04:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv7cS-000410-So; Thu, 20 Mar 2025 00:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tv7cQ-00040d-Ji; Thu, 20 Mar 2025 00:34:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tv7cN-0003kC-8K; Thu, 20 Mar 2025 00:34:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225df540edcso30973165ad.0; 
 Wed, 19 Mar 2025 21:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742445292; x=1743050092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ovakpqaN+u7BWxAe5GnED8cWqK97yDbqhI6J/nIl3DM=;
 b=er0EmZQHTJS4JGZ4LGuy8oPXcrn50e8EHHgVSlSQHzi2t8vkHYX80JsL+eGqF6lw1f
 LyMlwcMlJxKZ5Jgp2U3Als4Q+j54NF9QOSUUZEXsS/mHdIWYoXpPc/hqNHdxaAtjZtBH
 +SPGbJzoOLCFP4dkExMn8lOla9iShGdP9VM+AceiTcyzwTlAvchYhU+wk6PWOy6/T2gp
 4Hkb8YDu0N4VrjJNNk23b3aZiX5+J9q0TN7G3AE5PqM1qM/p31fYQGZZWqIGwHLBdNXT
 zuOrP+mg7AcmiVG9Nvi5AYXdQcTdJ7Va4rIfAclPuNDNCWWU5MXROiWy+UYamGmyF18z
 r4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742445292; x=1743050092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovakpqaN+u7BWxAe5GnED8cWqK97yDbqhI6J/nIl3DM=;
 b=Xx18OO8+akFlJRvVn62P2QwYq79B7Jyj8vq8NN8UBxeKl49II4V/rfyg9R33wx/cg8
 Qa0iZT5Ut2kJi8W6SNsPH1DVG6bw2cge6gNGqlYfDsmcEfqXrrRX+MWH+G6bk4DBUzna
 m6/kat33dOQof/9uoM80MKAUNLCqyxwEAEACrW2fw/65gMr4kzH1uGYqhvez7HPTxMWN
 sj1+PzmeoKaVd72VaJ1li/nOko53mgqsOZzMfXw1sVCuqnGgR4bqhtwtQo7mGH8rdGr2
 zfuWmoDKGwlYjqLaswsb+dBytERM46FvDczErkwXyS2Un0eLWamAQuHmnBxsoZP0NLn2
 lSzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX45ERcRNjaj19xacmdUIPGURbFJeOLlSK9KwSuGc55xqxNR4pu/3VzAdYHyQacUS+RdoSrHSA15Q==@nongnu.org
X-Gm-Message-State: AOJu0YyM0Jb1z3ILfXC0KriiuipMj2g7c6FQynsGq5xYUXKYDA8ZO+jw
 OqcykT0CGaMnv1h//yYzskCNIhdSnvZmCbq5QKuH8zhfUQMLZB8/xkrXB/S/
X-Gm-Gg: ASbGncsU7HV+yUS7Jc1HJRr4ROAQFTyg2+jmgz3RGqi+T3rUW9DRTSUHBHNOOGDpJqO
 wUibzgFS6wE14V9sGPUYkXIZaaem08jn/MGRQ4yShAjPwXCRuOEs8Qbw+8vvcX4s1mtLPkQLVO2
 1KJQUYNEOiYub8m8+98AE+ItyVbKjrxLGNjFaDOEzRGhn9ucyvJSiOXJxMCGvL+6v9bmiqwew1K
 cVx4U6chMP3NhRZSmRDONb9LsG5gpijvq2WGNspIqkGbkS9UWG5dhG7SIsx2cowCXa/OzXQH1wG
 L1HU13kiTsucBJXtIvEMxprGbu9WIemwDZtPbZHSVPLA6/c=
X-Google-Smtp-Source: AGHT+IG795zuPboGvzOktFBr4PMO59r8WlauHPH2ekKD4eZzAOSXXQ4y5VLxfJq2DjpyrOIBcIXxtA==
X-Received: by 2002:a05:6a20:7288:b0:1f0:e2a9:fb2a with SMTP id
 adf61e73a8af0-1fd085563b1mr2587553637.4.1742445292505; 
 Wed, 19 Mar 2025 21:34:52 -0700 (PDT)
Received: from wheely.local0.net ([1.146.79.221])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cc961sm9972971a12.11.2025.03.19.21.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 21:34:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PATCH] ppc/spapr: Fix RTAS stopped state
Date: Thu, 20 Mar 2025 14:34:43 +1000
Message-ID: <20250320043443.88829-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

This change takes the CPUPPCState 'quiesced' field added for powernv
hardware CPU core controls (used to stop and start cores), and extends
it to spapr to model the "RTAS stopped" state. This prevents the
schedulers attempting to run stopped CPUs unexpectedly, which can cause
hangs and possibly other unexpected behaviour.

The detail of the problematic situation is this:

A KVM spapr guest boots with all secondary CPUs defined to be in the
"RTAS stopped" state. In this state, the CPU is only responsive to the
start-cpu RTAS call. This behaviour is modeled in QEMU with the
start_powered_off feature, which sets ->halted on secondary CPUs at
boot. ->halted=true looks like an idle / sleep / power-save state which
typically is responsive to asynchronous interrupts, but spapr clears
wake-on-interrupt bits in the LPCR SPR. This more-or-less works.

Commit e8291ec16da8 ("target/ppc: fix timebase register reset state")
recently caused the decrementer to expire sooner at boot, causing a
decrementer exception on secondary CPUs in RTAS stopped state. This
was not a problem on TCG, but KVM limits how a guest can modify LPCR, in
particular it prevents the clearing of wake-on-interrupt bits, and so in
the course of CPU register synchronisation, the LPCR as set by spapr to
model the RTAS stopped state is overwritten with KVM's LPCR value, and
that then causes QEMU's interrupt code to notice the expired decrementer
exception, turn that into an interrupt, and set CPU_INTERRUPT_HARD.

That causes the CPU to be kicked, and the KVM vCPU thread to loop
calling kvm_cpu_exec(). kvm_cpu_exec() calls
kvm_arch_process_async_events(), which on ppc just returns ->halted.
This is still true, so it returns immediately with EXCP_HLT, and the
vCPU never goes to sleep because qemu_wait_io_event() sees
CPU_INTERRUPT_HARD is set. All this while the vCPU holds the bql.  This
causes the boot CPU to eventually lock up when it needs the bql.

So make 'quiesced' represent the "RTAS stopped" state, and have it
explicitly not respond to exceptions (interrupt conditions) rather than
rely on machine register state to model that state. This matches the
powernv quiesced state very well because it essentially turns off the
CPU core via a side-band control unit.

There are still issues with QEMU and KVM idea of LPCR diverging and that
is quite ugly and fragile that should be fixed. spapr should synchronize
its LPCR properly with KVM, and not try to use values that KVM does not
support.

Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         | 11 +++++++++++
 hw/ppc/pnv_core.c        |  6 +++++-
 hw/ppc/spapr_cpu_core.c  |  6 ++++++
 hw/ppc/spapr_rtas.c      |  5 ++++-
 target/ppc/excp_helper.c |  4 ++++
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index efab54a0683..3ee83517dcd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1356,6 +1356,17 @@ struct CPUArchState {
      * special way (such as routing some resume causes to 0x100, i.e. sreset).
      */
     bool resume_as_sreset;
+
+    /*
+     * On powernv, quiesced means the CPU has been stopped using PC direct
+     * control xscom registers.
+     *
+     * On spapr, quiesced means it is in the "RTAS stopped" state.
+     *
+     * The core halted/stopped variables aren't sufficient for this, because
+     * they can be changed with various side-band operations like qmp cont,
+     * powersave interrupts, etc.
+     */
     bool quiesced;
 #endif
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 99d9644ee38..a33977da188 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -248,21 +248,25 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
 
             if (val & PPC_BIT(7 + 8 * i)) { /* stop */
                 val &= ~PPC_BIT(7 + 8 * i);
-                cpu_pause(cs);
                 env->quiesced = true;
+                ppc_maybe_interrupt(env);
+                cpu_pause(cs);
             }
             if (val & PPC_BIT(6 + 8 * i)) { /* start */
                 val &= ~PPC_BIT(6 + 8 * i);
                 env->quiesced = false;
+                ppc_maybe_interrupt(env);
                 cpu_resume(cs);
             }
             if (val & PPC_BIT(4 + 8 * i)) { /* sreset */
                 val &= ~PPC_BIT(4 + 8 * i);
                 env->quiesced = false;
+                ppc_maybe_interrupt(env);
                 pnv_cpu_do_nmi_resume(cs);
             }
             if (val & PPC_BIT(3 + 8 * i)) { /* clear maint */
                 env->quiesced = false;
+                ppc_maybe_interrupt(env);
                 /*
                  * Hardware has very particular cases for where clear maint
                  * must be used and where start must be used to resume a
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 0671d9e44b4..faf9170ba6b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -37,6 +37,9 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     cpu_reset(cs);
 
+    env->quiesced = true; /* set "RTAS stopped" state. */
+    ppc_maybe_interrupt(env);
+
     /*
      * "PowerPC Processor binding to IEEE 1275" defines the initial MSR state
      * as 32bit (MSR_SF=0) with MSR_ME=1 and MSR_FP=1 in "8.2.1. Initial
@@ -98,6 +101,9 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
     CPU(cpu)->halted = 0;
     /* Enable Power-saving mode Exit Cause exceptions */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
+
+    env->quiesced = false; /* clear "RTAS stopped" state. */
+    ppc_maybe_interrupt(env);
 }
 
 /*
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 503d441b48e..78309dbb09d 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -110,7 +110,8 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *cpu_,
     id = rtas_ld(args, 0);
     cpu = spapr_find_cpu(id);
     if (cpu != NULL) {
-        if (CPU(cpu)->halted) {
+        CPUPPCState *env = &cpu->env;
+        if (env->quiesced) {
             rtas_st(rets, 1, 0);
         } else {
             rtas_st(rets, 1, 2);
@@ -215,6 +216,8 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
      * For the same reason, set PSSCR_EC.
      */
     env->spr[SPR_PSSCR] |= PSSCR_EC;
+    env->quiesced = true; /* set "RTAS stopped" state. */
+    ppc_maybe_interrupt(env);
     cs->halted = 1;
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     kvmppc_set_reg_ppc_online(cpu, 0);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 44e19aacd8d..c941c89806e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1951,6 +1951,10 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     target_ulong lpcr = env->spr[SPR_LPCR];
     bool async_deliver;
 
+    if (unlikely(env->quiesced)) {
+        return 0;
+    }
+
 #ifdef TARGET_PPC64
     switch (env->excp_model) {
     case POWERPC_EXCP_POWER7:
-- 
2.47.1


