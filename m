Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B13C3ABD2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WO-0006no-FU; Sun, 11 May 2025 09:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WG-0006UC-LN
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:04 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WE-0006qb-0N
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:04 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id BA35518006C
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:50 +0200 (CEST)
Received: (qmail 26112 invoked by uid 990); 11 May 2025 13:14:50 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:50 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH v4 15/23] target/ppc: call plugin trap callbacks
Date: Sun, 11 May 2025 15:14:07 +0200
Message-ID: <4daa0f2dc7ebb59ed0cce0c85b6b8b40720728f5.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.987861) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.587861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=+MotbJIQe9rsBhnC1Fo8zZ/hxx6wRlQ/dXH41OFrpnU=;
 b=AwR3tBAe5In+f4jpyClpXan++T8wjUzFBRCWPNhZuUrV8QlheEakPa+FAQXGc+hAq739j2VO+Y
 G68ZM7PlQjPYQ0gbtED1j6tW3XFfxv4kilvAVFg6QUJFYBiWPIlCsgHLmZjMtvZtNXmlxcNowrDW
 Nl6x6mFIQzHLOkEXSV43HDNFRx5N+QkBed88re3bUwB3/BYsGBbOvDz2Ef2M/0f1l1Z6nvALS0lo
 /9d6Vp67Pfmy7lHmSvc+9xwymxj/KAoB6M/0UFE8L+fJRpI805Cd+hWRfZyRsZ/JFLU7zoFhRoHh
 LfoPNC585Fgibi1bbClEybmG/WMkP5ia+vuTPhoXNYrxeBMNwDO+2RYje3KO9RpeYeW6kQVQgai+
 iQBgNBEbL+3Ie+BmTm6dPh4erLZReqO9sa/5VVNwOYFkk96CG8PMogTf8O+COCOrhPGcQXiv7XW3
 2Q10nHuYkfqd0uEB+Sv30tmHMwPoUPpQAqNt3BfKlPIPUU119GJa2SfrSOFCBDfaVolFIutXFOsz
 osZShDjMBI9/qV+VPFZDPJBjPiDTHCUxqdGL4J2neaFWIrLVwiEkXvMWXdXizZwmNkcboUKKpRQw
 qbqqyBBPX1UW/25bMPSmgV8VxV/4JZBp+MqdqMaduUTImBXDXF/jVIFc5lm4OlYe6/JL9DroBigY
 A=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Power PC targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/ppc/excp_helper.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1efdc4066e..24740a000b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -27,6 +27,7 @@
 #include "internal.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
+#include "qemu/plugin.h"
 
 #include "trace.h"
 
@@ -404,11 +405,32 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
     powerpc_checkstop(env, "machine check with MSR[ME]=0");
 }
 
+static void powerpc_do_plugin_vcpu_interrupt_cb(CPUState *cs, int excp,
+                                                uint64_t from)
+{
+    switch (excp) {
+    case POWERPC_EXCP_NONE:
+        break;
+    case POWERPC_EXCP_FIT:
+    case POWERPC_EXCP_WDT:
+    case POWERPC_EXCP_DEBUG:
+    case POWERPC_EXCP_PIT:
+    case POWERPC_EXCP_SMI:
+    case POWERPC_EXCP_PERFM:
+    case POWERPC_EXCP_THERM:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+    }
+}
+
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -456,6 +478,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             env->spr[SPR_40x_ESR] = ESR_FP;
@@ -510,12 +533,14 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
     env->spr[srr0] = env->nip;
     env->spr[srr1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -567,6 +592,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -653,12 +679,14 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -708,6 +736,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -758,6 +787,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         if (lev == 1 && cpu->vhyp) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
 
@@ -803,12 +833,14 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -858,6 +890,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -908,6 +941,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         if (lev == 1 && cpu->vhyp) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
 
@@ -947,6 +981,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     env->spr[SPR_SRR0] = env->nip;
     env->spr[SPR_SRR1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
@@ -954,6 +989,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1;
+    uint64_t last_pc = env->nip;
 
     /*
      * Book E does not play games with certain bits of xSRR1 being MSR save
@@ -1025,6 +1061,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -1133,6 +1170,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     env->spr[srr0] = env->nip;
     env->spr[srr1] = msr;
     powerpc_set_excp_state(cpu, vector, new_msr);
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 
 /*
@@ -1254,6 +1292,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0 = SPR_SRR0, srr1 = SPR_SRR1, lev = -1;
+    uint64_t last_pc = env->nip;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -1353,6 +1392,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
+                qemu_plugin_vcpu_exception_cb(env_cpu(env), last_pc);
                 return;
             }
             /*
@@ -1397,6 +1437,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
             cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
+            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
             return;
         }
         if (env->insns_flags2 & PPC2_ISA310) {
@@ -1543,6 +1584,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         ppc_excp_apply_ail(cpu, excp, msr, &new_msr, &vector);
         powerpc_set_excp_state(cpu, vector, new_msr);
     }
+    powerpc_do_plugin_vcpu_interrupt_cb(env_cpu(env), excp, last_pc);
 }
 #else
 static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
-- 
2.49.0


