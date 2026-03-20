Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9004210987A9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d3m-0005qA-Oi; Fri, 20 Mar 2026 12:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3a-0005pF-8E
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3X-0001Ps-R8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso527356f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025438; x=1774630238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmYiHLEMM3CrVk1bORwLOsj5HzlZX67DWgkYEyGciJg=;
 b=Ju6+uv7F10ilhtrjW6zlb0f6zEGTkMZBD2MoBec6fyVYqxPTtcV0DgxlS/ytoARgMr
 u3qYGqFlQH9b70FVc7oPRlbClLAMImB8U7uRkM4UL5runmb02VTuHe3Zz6XJ3IVPsxef
 oT18SBxxyIem2fGAkXoov3HvDbPTCu+LOBFMVp6kBaKKDVIOGPO5MgK3kn8/OCXY5jzz
 DCaAsH37sNMIfoj5ajH6J0+gqnG4k0qTzlm2rfZ2XZLk23A03uhXotoBWSz2lNMeOJkL
 0pvkGv12gKR39jTljrHVVFbEP4CySUHMYrl/ZlZbMahs6VVfEHwOINbwuk2FF7tUb9P1
 zokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025438; x=1774630238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmYiHLEMM3CrVk1bORwLOsj5HzlZX67DWgkYEyGciJg=;
 b=nrnnnrqvzvjQWFkoemSCctVKsDhfr1FfZLsUnZpE37xdGXnBxRe5E+k/fPKQefSqbO
 cZR0GM42Y+ohYWNhYLTxE0WG9tqRcBDv7wycZnTJzOXxEdfwSOFxlwVLppx3boxrDWE6
 G96AyaulcKFd9yuAztiUwD0Php2dc8SbVvcWEYjZKR5IiWbGlVesMiY1QeOMIKraNHDP
 ep6oAsDi+BsT3bPsVWv9ig/PDliLbV/z+q6TzJ7zX6uIAnoBQTfpitGFO7ElEqkQGUHH
 T2+SfuH7rGKdno8HwvoqJJVuV+khvckHOZ9U/SU53QV3Z8NPJb78VoHJhPychqUPO4v0
 Zqqg==
X-Gm-Message-State: AOJu0Yya3f8MCmQ36Zx860zVZrNFg6RN5n/SULrlQ/eJu9pvLzW2mJTb
 18MlyPgntVas/H6+lodK4Ob9iaarTsOe5bmW/LXPPm8tG/y7KzMxFKRlO1VuzsiGjGPNcBg8ogD
 KIumzNA8=
X-Gm-Gg: ATEYQzwErZxRjsMtbggbeApa8+Mg0xeSjQXwf3ORwQM1Jq1mXscDial9+CGBySpdxcr
 ea/KPKE04XAzjPcNpL9hSOyB4Y+j9j39n9ewUtW8MpPeURLQnlPCvRYZPzjTCin/f2T6rU9n1PU
 W/zIFIJYzxvWVr6Z/28VZYPqnBXJKuIJJPJ8pR8gVWmr7UQgTdh417iCKciugCWaRFHFVMyr3dk
 UUfrt0a5/TnXPT5PdBFisGSvkiT5wa4fky29zdljRCiK0TFBJg4cHdsTfU0xccjYai1kTUFIlg+
 XpRN5JsElhh0kLGMbUDJsFM+Ir45j5Br8djOfx+A4OhtTJ1Boq0NJLXrOAM6Zy7KNmB5br39nNq
 50aMpVG5Zh2TtwODlO9CQdERmtoUMDz54/UUZzxx4Tl29AtmwlzU/A3yAs8qQpERthdnRqy8W4B
 M3eq3llJv9MGm9aw+jMOviH1wRRIsYcKT02hEesRPqGfxeSXDBTSAOKzZ8DF5/HFc7BFx+ds9r
X-Received: by 2002:a05:6000:a8e:b0:43b:3cdc:9429 with SMTP id
 ffacd0b85a97d-43b64243307mr5583136f8f.1.1774025437686; 
 Fri, 20 Mar 2026 09:50:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470380asm7218075f8f.24.2026.03.20.09.50.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:50:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 2/7] target/ppc: Have 'info tlb' dump MMU
 information on monitor
Date: Fri, 20 Mar 2026 17:50:15 +0100
Message-ID: <20260320165021.39521-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
References: <20260320165021.39521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Currently 'info tlb' dumps the MMU information on stdout.
Propagate the @Monitor argument and replace qemu_printf() by
monitor_printf() -- or monitor_puts when no formatting -- to
dump information over the monitor (which is not always stdout).

Fixes: bebabbc7aa7 ("ppc: booke206: add "info tlb" support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h        |  2 +-
 target/ppc/mmu-hash64.h |  2 +-
 target/ppc/mmu-hash64.c | 10 +++----
 target/ppc/mmu_common.c | 66 ++++++++++++++++++++---------------------
 target/ppc/monitor.c    |  2 +-
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 296e7604077..ba17ea83fa2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3082,7 +3082,7 @@ static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 }
 #endif
 
-void dump_mmu(CPUPPCState *env);
+void dump_mmu(Monitor *mon, CPUPPCState *env);
 
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 void ppc_store_vscr(CPUPPCState *env, uint32_t vscr);
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ae8d4b37aed..9ce6939191a 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -4,7 +4,7 @@
 #ifndef CONFIG_USER_ONLY
 
 #ifdef TARGET_PPC64
-void dump_slb(PowerPCCPU *cpu);
+void dump_slb(Monitor *mon, PowerPCCPU *cpu);
 int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
                   target_ulong esid, target_ulong vsid);
 bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 2c33d98001d..356aee0c92c 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -23,7 +23,6 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "kvm_ppc.h"
@@ -34,6 +33,7 @@
 #include "mmu-book3s-v3.h"
 #include "mmu-books.h"
 #include "helper_regs.h"
+#include "monitor/monitor.h"
 
 #ifdef CONFIG_TCG
 #include "exec/helper-proto.h"
@@ -83,7 +83,7 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu, target_ulong eaddr)
     return NULL;
 }
 
-void dump_slb(PowerPCCPU *cpu)
+void dump_slb(Monitor *mon, PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
     int i;
@@ -91,15 +91,15 @@ void dump_slb(PowerPCCPU *cpu)
 
     cpu_synchronize_state(CPU(cpu));
 
-    qemu_printf("SLB\tESID\t\t\tVSID\n");
+    monitor_puts(mon, "SLB\tESID\t\t\tVSID\n");
     for (i = 0; i < cpu->hash64_opts->slb_size; i++) {
         slbe = env->slb[i].esid;
         slbv = env->slb[i].vsid;
         if (slbe == 0 && slbv == 0) {
             continue;
         }
-        qemu_printf("%d\t0x%016" PRIx64 "\t0x%016" PRIx64 "\n",
-                    i, slbe, slbv);
+        monitor_printf(mon, "%d\t0x%016" PRIx64 "\t0x%016" PRIx64 "\n",
+                       i, slbe, slbv);
     }
 }
 
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 52d48615ac2..5ea9b6d6773 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -29,11 +29,11 @@
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
 #include "internal.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
 #include "mmu-booke.h"
+#include "monitor/monitor.h"
 
 /* #define DUMP_PAGE_TABLES */
 
@@ -349,20 +349,20 @@ static const char *book3e_tsize_to_str[32] = {
     "1T", "2T"
 };
 
-static void mmubooke_dump_mmu(CPUPPCState *env)
+static void mmubooke_dump_mmu(Monitor *mon, CPUPPCState *env)
 {
     ppcemb_tlb_t *entry;
     int i;
 
 #ifdef CONFIG_KVM
     if (kvm_enabled() && !env->kvm_sw_tlb) {
-        qemu_printf("Cannot access KVM TLB\n");
+        monitor_puts(mon, "Cannot access KVM TLB\n");
         return;
     }
 #endif
 
-    qemu_printf("\nTLB:\n");
-    qemu_printf("Effective          Physical           Size PID   Prot     "
+    monitor_puts(mon, "\nTLB:\n");
+    monitor_puts(mon, "Effective          Physical           Size PID   Prot     "
                 "Attr\n");
 
     entry = &env->tlb.tlbe[0];
@@ -387,21 +387,21 @@ static void mmubooke_dump_mmu(CPUPPCState *env)
         } else {
             snprintf(size_buf, sizeof(size_buf), "%3" PRId64 "k", size / KiB);
         }
-        qemu_printf("0x%016" PRIx64 " 0x%016" PRIx64 " %s %-5u %08x %08x\n",
+        monitor_printf(mon, "0x%016" PRIx64 " 0x%016" PRIx64 " %s %-5u %08x %08x\n",
                     (uint64_t)ea, (uint64_t)pa, size_buf, (uint32_t)entry->PID,
                     entry->prot, entry->attr);
     }
 
 }
 
-static void mmubooke206_dump_one_tlb(CPUPPCState *env, int tlbn, int offset,
-                                     int tlbsize)
+static void mmubooke206_dump_one_tlb(Monitor *mon, CPUPPCState *env,
+                                     int tlbn, int offset, int tlbsize)
 {
     ppcmas_tlb_t *entry;
     int i;
 
-    qemu_printf("\nTLB%d:\n", tlbn);
-    qemu_printf("Effective          Physical           Size TID   TS SRWX"
+    monitor_printf(mon, "\nTLB%d:\n", tlbn);
+    monitor_puts(mon, "Effective          Physical           Size TID   TS SRWX"
                 " URWX WIMGE U0123\n");
 
     entry = &env->tlb.tlbm[offset];
@@ -418,7 +418,7 @@ static void mmubooke206_dump_one_tlb(CPUPPCState *env, int tlbn, int offset,
         ea = entry->mas2 & ~(size - 1);
         pa = entry->mas7_3 & ~(size - 1);
 
-        qemu_printf("0x%016" PRIx64 " 0x%016" PRIx64 " %4s %-5u %1u  S%c%c%c"
+        monitor_printf(mon, "0x%016" PRIx64 " 0x%016" PRIx64 " %4s %-5u %1u  S%c%c%c"
                     " U%c%c%c %c%c%c%c%c U%c%c%c%c\n",
                     (uint64_t)ea, (uint64_t)pa,
                     book3e_tsize_to_str[tsize],
@@ -442,14 +442,14 @@ static void mmubooke206_dump_one_tlb(CPUPPCState *env, int tlbn, int offset,
     }
 }
 
-static void mmubooke206_dump_mmu(CPUPPCState *env)
+static void mmubooke206_dump_mmu(Monitor *mon, CPUPPCState *env)
 {
     int offset = 0;
     int i;
 
 #ifdef CONFIG_KVM
     if (kvm_enabled() && !env->kvm_sw_tlb) {
-        qemu_printf("Cannot access KVM TLB\n");
+        monitor_puts(mon, "Cannot access KVM TLB\n");
         return;
     }
 #endif
@@ -461,12 +461,12 @@ static void mmubooke206_dump_mmu(CPUPPCState *env)
             continue;
         }
 
-        mmubooke206_dump_one_tlb(env, i, offset, size);
+        mmubooke206_dump_one_tlb(mon, env, i, offset, size);
         offset += size;
     }
 }
 
-static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
+static void mmu6xx_dump_BATs(Monitor *mon, CPUPPCState *env, int type)
 {
     target_ulong *BATlt, *BATut, *BATu, *BATl;
     target_ulong BEPIl, BEPIu, bl;
@@ -489,7 +489,7 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
         BEPIu = *BATu & BATU32_BEPIU;
         BEPIl = *BATu & BATU32_BEPIL;
         bl = (*BATu & BATU32_BL) << 15;
-        qemu_printf("%s BAT%d BATu " TARGET_FMT_lx
+        monitor_printf(mon, "%s BAT%d BATu " TARGET_FMT_lx
                     " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
                     TARGET_FMT_lx " " TARGET_FMT_lx "\n",
                     type == ACCESS_CODE ? "code" : "data", i,
@@ -497,38 +497,38 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
     }
 }
 
-static void mmu6xx_dump_mmu(CPUPPCState *env)
+static void mmu6xx_dump_mmu(Monitor *mon, CPUPPCState *env)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     ppc6xx_tlb_t *tlb;
     target_ulong sr;
     int type, way, entry, i;
 
-    qemu_printf("HTAB base = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(cpu));
-    qemu_printf("HTAB mask = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(cpu));
+    monitor_printf(mon, "HTAB base = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(cpu));
+    monitor_printf(mon, "HTAB mask = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(cpu));
 
-    qemu_printf("\nSegment registers:\n");
+    monitor_puts(mon, "\nSegment registers:\n");
     for (i = 0; i < 32; i++) {
         sr = env->sr[i];
         if (sr & 0x80000000) {
-            qemu_printf("%02d T=%d Ks=%d Kp=%d BUID=0x%03x "
+            monitor_printf(mon, "%02d T=%d Ks=%d Kp=%d BUID=0x%03x "
                         "CNTLR_SPEC=0x%05x\n", i,
                         sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
                         sr & 0x20000000 ? 1 : 0, (uint32_t)((sr >> 20) & 0x1FF),
                         (uint32_t)(sr & 0xFFFFF));
         } else {
-            qemu_printf("%02d T=%d Ks=%d Kp=%d N=%d VSID=0x%06x\n", i,
+            monitor_printf(mon, "%02d T=%d Ks=%d Kp=%d N=%d VSID=0x%06x\n", i,
                         sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
                         sr & 0x20000000 ? 1 : 0, sr & 0x10000000 ? 1 : 0,
                         (uint32_t)(sr & 0x00FFFFFF));
         }
     }
 
-    qemu_printf("\nBATs:\n");
-    mmu6xx_dump_BATs(env, ACCESS_INT);
-    mmu6xx_dump_BATs(env, ACCESS_CODE);
+    monitor_puts(mon, "\nBATs:\n");
+    mmu6xx_dump_BATs(mon, env, ACCESS_INT);
+    mmu6xx_dump_BATs(mon, env, ACCESS_CODE);
 
-    qemu_printf("\nTLBs                       [EPN    EPN + SIZE]\n");
+    monitor_puts(mon, "\nTLBs                       [EPN    EPN + SIZE]\n");
     for (type = 0; type < 2; type++) {
         for (way = 0; way < env->nb_ways; way++) {
             for (entry = env->nb_tlb * type + env->tlb_per_way * way;
@@ -536,7 +536,7 @@ static void mmu6xx_dump_mmu(CPUPPCState *env)
                  entry++) {
 
                 tlb = &env->tlb.tlb6[entry];
-                qemu_printf("%s TLB %02d/%02d way:%d %s ["
+                monitor_printf(mon, "%s TLB %02d/%02d way:%d %s ["
                             TARGET_FMT_lx " " TARGET_FMT_lx "]\n",
                             type ? "code" : "data", entry % env->nb_tlb,
                             env->nb_tlb, way,
@@ -547,31 +547,31 @@ static void mmu6xx_dump_mmu(CPUPPCState *env)
     }
 }
 
-void dump_mmu(CPUPPCState *env)
+void dump_mmu(Monitor *mon, CPUPPCState *env)
 {
     switch (env->mmu_model) {
     case POWERPC_MMU_BOOKE:
-        mmubooke_dump_mmu(env);
+        mmubooke_dump_mmu(mon, env);
         break;
     case POWERPC_MMU_BOOKE206:
-        mmubooke206_dump_mmu(env);
+        mmubooke206_dump_mmu(mon, env);
         break;
     case POWERPC_MMU_SOFT_6xx:
-        mmu6xx_dump_mmu(env);
+        mmu6xx_dump_mmu(mon, env);
         break;
 #if defined(TARGET_PPC64)
     case POWERPC_MMU_64B:
     case POWERPC_MMU_2_03:
     case POWERPC_MMU_2_06:
     case POWERPC_MMU_2_07:
-        dump_slb(env_archcpu(env));
+        dump_slb(mon, env_archcpu(env));
         break;
     case POWERPC_MMU_3_00:
         if (ppc64_v3_radix(env_archcpu(env))) {
             qemu_log_mask(LOG_UNIMP, "%s: the PPC64 MMU is unsupported\n",
                           __func__);
         } else {
-            dump_slb(env_archcpu(env));
+            dump_slb(mon, env_archcpu(env));
         }
         break;
 #endif
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 7c88e0e2bda..41337d77a89 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -19,5 +19,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(env1);
+    dump_mmu(mon, env1);
 }
-- 
2.53.0


