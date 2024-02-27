Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04D4C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rez49-0003JT-1a; Tue, 27 Feb 2024 10:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez44-0003FQ-I7; Tue, 27 Feb 2024 10:08:16 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez3v-0007uk-Cm; Tue, 27 Feb 2024 10:08:16 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A59384E6013;
 Tue, 27 Feb 2024 16:08:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LIBqRBVlxg-k; Tue, 27 Feb 2024 16:08:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 967EC4E60D3; Tue, 27 Feb 2024 16:08:01 +0100 (CET)
Message-Id: <22b5dabb2dd51c393139350d095dc13a1845a017.1709045654.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1709045654.git.balaton@eik.bme.hu>
References: <cover.1709045654.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 01/10] target/ppc: Use env_cpu for cpu_abort in excp_helper
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Tue, 27 Feb 2024 16:08:01 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use the env_cpu function to get the CPUState for cpu_abort. These are
only needed in case of fatal errors so this allows to avoid casting
and storing CPUState in a local variable wnen not needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 55 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 98952de267..56a5fe7f3b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -445,7 +445,6 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -473,8 +472,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -523,7 +522,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
             env->spr[SPR_40x_ESR] = ESR_PTR;
             break;
         default:
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -550,11 +549,12 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         trace_ppc_excp_print("PIT");
         break;
     case POWERPC_EXCP_DEBUG:     /* Debug interrupt                          */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -569,7 +569,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -592,8 +591,8 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -653,7 +652,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -675,8 +674,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
-                      "exception %d with no HV support\n", excp);
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset exception "
+                      "%d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
@@ -703,11 +703,12 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
     case POWERPC_EXCP_MEXTBR:    /* Maskable external breakpoint             */
     case POWERPC_EXCP_NMEXTBR:   /* Non maskable external breakpoint         */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -730,7 +731,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -753,8 +753,8 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -812,7 +812,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -854,8 +854,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
-                      "exception %d with no HV support\n", excp);
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset exception "
+                      "%d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
@@ -875,11 +876,12 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -902,7 +904,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -925,8 +926,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -984,7 +985,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1026,7 +1027,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset "
                       "exception %d with no HV support\n", excp);
         }
         break;
@@ -1039,11 +1041,12 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1066,7 +1069,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -1103,8 +1105,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1135,6 +1137,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_EXTERNAL:  /* External input                           */
         if (env->mpic_proxy) {
+            CPUState *cs = env_cpu(env);
             /* IACK the IRQ on delivery */
             env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
         }
@@ -1173,7 +1176,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1214,7 +1217,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
             /* DBSR already modified by caller */
         } else {
-            cpu_abort(cs, "Debug exception triggered on unsupported model\n");
+            cpu_abort(env_cpu(env),
+                      "Debug exception triggered on unsupported model\n");
         }
         break;
     case POWERPC_EXCP_SPEU:   /* SPE/embedded floating-point unavailable/VPU  */
@@ -1228,17 +1232,19 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset "
                       "exception %d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_EFPDI:     /* Embedded floating-point data interrupt   */
     case POWERPC_EXCP_EFPRI:     /* Embedded floating-point round interrupt  */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1376,7 +1382,6 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1, lev = -1;
@@ -1415,8 +1420,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1512,7 +1517,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1578,7 +1583,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             new_msr |= (target_ulong)MSR_HVB;
         } else {
             if (FIELD_EX64(env->msr, MSR, POW)) {
-                cpu_abort(cs, "Trying to deliver power-saving system reset "
+                cpu_abort(env_cpu(env),
+                          "Trying to deliver power-saving system reset "
                           "exception %d with no HV support\n", excp);
             }
         }
@@ -1650,11 +1656,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1687,8 +1694,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     } else {
         /* Sanity check */
         if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
-            cpu_abort(cs, "Trying to deliver HV exception (HSRR) %d with "
-                      "no HV support\n", excp);
+            cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSRR) %d "
+                      "with no HV support\n", excp);
         }
 
         /* This can update new_msr and vector if AIL applies */
@@ -1706,11 +1713,11 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
     if (excp <= POWERPC_EXCP_NONE || excp >= POWERPC_EXCP_NB) {
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
     }
 
     qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
@@ -2244,7 +2251,6 @@ void ppc_maybe_interrupt(CPUPPCState *env)
 static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_MCK: /* Machine check exception */
@@ -2288,14 +2294,14 @@ static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
 static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_MCK: /* Machine check exception */
@@ -2359,7 +2365,8 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
@@ -2438,7 +2445,8 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 #endif
@@ -2446,7 +2454,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
 static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_RESET: /* External reset */
@@ -2543,7 +2550,8 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
-- 
2.30.9


