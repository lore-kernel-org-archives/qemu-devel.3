Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B552C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKgd-0007wp-E0; Thu, 21 Mar 2024 11:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgb-0007ic-Dr
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:33 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgX-0001sl-KM
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:33 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56bc753f58eso1159807a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036222; x=1711641022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3sd7YoSjS7p83F+7iO1jGEskdO0c4OapH9Z6R07/q8=;
 b=eCsgufLgZmATej3m07R3dQOAj47nga20ZLUqwl0uUR32UmuLZxwwa3Aoji3Z9V9rG6
 UCyGXFhxAUD9lqCgVhJtZfkTg7RgWw4nz5I7gj5QngL+GNl7PigX188qLQFHovSdBKyj
 11Uiu8/dCTQfZ8ALaZZxl0yO5kzkLgy0x9ZeQpmbb9I+QJPvVNqyTXOqoLSmgpclpLs6
 6gRVyJLktejXcyJnSMsmkI7AV9bzv2kJr1C6QbhXLI/aMT8TssilK7HTsBMk1y4+T4fU
 Zk6xz7Fho1T7fCk/96GPBSmX6AF5lHTy/0RPoVgIGWhY6WkIN2DbXEcP8/ZTg9F+mdpl
 krYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036222; x=1711641022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3sd7YoSjS7p83F+7iO1jGEskdO0c4OapH9Z6R07/q8=;
 b=LjQploP2PHwPSA1hj5F0GJRVqpfNl2lz017L+5fg8uNiLb/o+47XRkuVaoha87TbSz
 vKSMcTjg+MtzbG1rlGz1ojdeuNsT+5Oq3pr1G1Ij44mtr4ioo5rggAtH1G92ouuNIZRg
 J068yt6PwKMw8KG/v4YK55lLbXPKbFdTgD3JX4Vrmlo325X59jnxhERoQ9YWPMK9vXhw
 9AJMrkdfr7xcKvqYLQPtZz45PFnKx58x6zf2PPNqo+RMxmEWd1I7rjfc7DGHqUDwc1Y8
 fvvC01eyVPZCmQ1T1vaI0gbCMpQVqcU2GdCRVbQ5HB5pza7Vqs5tTSm7Yf83Jqpiu/sc
 9CTg==
X-Gm-Message-State: AOJu0Yz4iuJc9D7wXy7lxOGFDPbc/PJYl90dl1Iy5XcEZFq/bMCNhcI2
 JdDjwozMp8reDKJUuR8J3f3zS40AgaG2SWSY3kd2icoSedpKnGxIbmyvfqYOlAvIuBsW73FegCs
 HVZ4=
X-Google-Smtp-Source: AGHT+IEu+Xf3tX08u4bnOa0GpwQBGkGiFM8CfhrUIJD16i3Ya68B9pVMVVLfdtyhWqR3h9YHbWXPyg==
X-Received: by 2002:a05:6402:e83:b0:568:b46c:c4ba with SMTP id
 h3-20020a0564020e8300b00568b46cc4bamr4264429eda.30.1711036222254; 
 Thu, 21 Mar 2024 08:50:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 ew3-20020a056402538300b0056b2c5c58d2sm16219edb.21.2024.03.21.08.50.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 13/21] target/ppc: Replace qemu_printf() by
 monitor_printf() in monitor
Date: Thu, 21 Mar 2024 16:48:29 +0100
Message-ID: <20240321154838.95771-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Replace qemu_printf() by monitor_printf() / monitor_puts() in monitor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h          |   2 +-
 target/ppc/mmu_common.c   | 147 +++++++++++++++++++-------------------
 target/ppc/ppc-qmp-cmds.c |   2 +-
 3 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 67e6b2effd..52ac667470 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2982,7 +2982,7 @@ static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 }
 #endif
 
-void dump_mmu(CPUPPCState *env);
+void ppc_dump_mmu(Monitor *mon, CPUPPCState *env);
 
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 void ppc_store_vscr(CPUPPCState *env, uint32_t vscr);
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 751403f1c8..ba8e91b949 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -32,6 +32,7 @@
 #include "internal.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
+#include "monitor/monitor.h"
 
 /* #define DUMP_PAGE_TABLES */
 
@@ -924,21 +925,21 @@ static const char *book3e_tsize_to_str[32] = {
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
-                "Attr\n");
+    monitor_puts(mon, "\nTLB:\n");
+    monitor_puts(mon, "Effective          Physical           Size PID   Prot     "
+                 "Attr\n");
 
     entry = &env->tlb.tlbe[0];
     for (i = 0; i < env->nb_tlb; i++, entry++) {
@@ -962,22 +963,22 @@ static void mmubooke_dump_mmu(CPUPPCState *env)
         } else {
             snprintf(size_buf, sizeof(size_buf), "%3" PRId64 "k", size / KiB);
         }
-        qemu_printf("0x%016" PRIx64 " 0x%016" PRIx64 " %s %-5u %08x %08x\n",
-                    (uint64_t)ea, (uint64_t)pa, size_buf, (uint32_t)entry->PID,
-                    entry->prot, entry->attr);
+        monitor_printf(mon, "0x%016" PRIx64 " 0x%016" PRIx64 " %s %-5u %08x %08x\n",
+                       (uint64_t)ea, (uint64_t)pa, size_buf, (uint32_t)entry->PID,
+                       entry->prot, entry->attr);
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
-                " URWX WIMGE U0123\n");
+    monitor_printf(mon, "\nTLB%d:\n", tlbn);
+    monitor_puts(mon, "Effective          Physical           Size TID   TS SRWX"
+                 " URWX WIMGE U0123\n");
 
     entry = &env->tlb.tlbm[offset];
     for (i = 0; i < tlbsize; i++, entry++) {
@@ -993,38 +994,38 @@ static void mmubooke206_dump_one_tlb(CPUPPCState *env, int tlbn, int offset,
         ea = entry->mas2 & ~(size - 1);
         pa = entry->mas7_3 & ~(size - 1);
 
-        qemu_printf("0x%016" PRIx64 " 0x%016" PRIx64 " %4s %-5u %1u  S%c%c%c"
-                    " U%c%c%c %c%c%c%c%c U%c%c%c%c\n",
-                    (uint64_t)ea, (uint64_t)pa,
-                    book3e_tsize_to_str[tsize],
-                    (entry->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT,
-                    (entry->mas1 & MAS1_TS) >> MAS1_TS_SHIFT,
-                    entry->mas7_3 & MAS3_SR ? 'R' : '-',
-                    entry->mas7_3 & MAS3_SW ? 'W' : '-',
-                    entry->mas7_3 & MAS3_SX ? 'X' : '-',
-                    entry->mas7_3 & MAS3_UR ? 'R' : '-',
-                    entry->mas7_3 & MAS3_UW ? 'W' : '-',
-                    entry->mas7_3 & MAS3_UX ? 'X' : '-',
-                    entry->mas2 & MAS2_W ? 'W' : '-',
-                    entry->mas2 & MAS2_I ? 'I' : '-',
-                    entry->mas2 & MAS2_M ? 'M' : '-',
-                    entry->mas2 & MAS2_G ? 'G' : '-',
-                    entry->mas2 & MAS2_E ? 'E' : '-',
-                    entry->mas7_3 & MAS3_U0 ? '0' : '-',
-                    entry->mas7_3 & MAS3_U1 ? '1' : '-',
-                    entry->mas7_3 & MAS3_U2 ? '2' : '-',
-                    entry->mas7_3 & MAS3_U3 ? '3' : '-');
+        monitor_printf(mon, "0x%016" PRIx64 " 0x%016" PRIx64 " %4s %-5u %1u  S%c%c%c"
+                       " U%c%c%c %c%c%c%c%c U%c%c%c%c\n",
+                       (uint64_t)ea, (uint64_t)pa,
+                       book3e_tsize_to_str[tsize],
+                       (entry->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT,
+                       (entry->mas1 & MAS1_TS) >> MAS1_TS_SHIFT,
+                       entry->mas7_3 & MAS3_SR ? 'R' : '-',
+                       entry->mas7_3 & MAS3_SW ? 'W' : '-',
+                       entry->mas7_3 & MAS3_SX ? 'X' : '-',
+                       entry->mas7_3 & MAS3_UR ? 'R' : '-',
+                       entry->mas7_3 & MAS3_UW ? 'W' : '-',
+                       entry->mas7_3 & MAS3_UX ? 'X' : '-',
+                       entry->mas2 & MAS2_W ? 'W' : '-',
+                       entry->mas2 & MAS2_I ? 'I' : '-',
+                       entry->mas2 & MAS2_M ? 'M' : '-',
+                       entry->mas2 & MAS2_G ? 'G' : '-',
+                       entry->mas2 & MAS2_E ? 'E' : '-',
+                       entry->mas7_3 & MAS3_U0 ? '0' : '-',
+                       entry->mas7_3 & MAS3_U1 ? '1' : '-',
+                       entry->mas7_3 & MAS3_U2 ? '2' : '-',
+                       entry->mas7_3 & MAS3_U3 ? '3' : '-');
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
@@ -1036,12 +1037,12 @@ static void mmubooke206_dump_mmu(CPUPPCState *env)
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
@@ -1064,51 +1065,53 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
         BEPIu = *BATu & 0xF0000000;
         BEPIl = *BATu & 0x0FFE0000;
         bl = (*BATu & 0x00001FFC) << 15;
-        qemu_printf("%s BAT%d BATu " TARGET_FMT_lx
-                    " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
-                    TARGET_FMT_lx " " TARGET_FMT_lx "\n",
-                    type == ACCESS_CODE ? "code" : "data", i,
-                    *BATu, *BATl, BEPIu, BEPIl, bl);
+        monitor_printf(mon, "%s BAT%d BATu " TARGET_FMT_lx
+                       " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
+                       TARGET_FMT_lx " " TARGET_FMT_lx "\n",
+                       type == ACCESS_CODE ? "code" : "data", i,
+                       *BATu, *BATl, BEPIu, BEPIl, bl);
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
+    monitor_printf(mon, "HTAB base = 0x%"HWADDR_PRIx"\n",
+                   ppc_hash32_hpt_base(cpu));
+    monitor_printf(mon, "HTAB mask = 0x%"HWADDR_PRIx"\n",
+                   ppc_hash32_hpt_mask(cpu));
 
-    qemu_printf("\nSegment registers:\n");
+    monitor_puts(mon, "\nSegment registers:\n");
     for (i = 0; i < 32; i++) {
         sr = env->sr[i];
         if (sr & 0x80000000) {
-            qemu_printf("%02d T=%d Ks=%d Kp=%d BUID=0x%03x "
-                        "CNTLR_SPEC=0x%05x\n", i,
-                        sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
-                        sr & 0x20000000 ? 1 : 0, (uint32_t)((sr >> 20) & 0x1FF),
-                        (uint32_t)(sr & 0xFFFFF));
+            monitor_printf(mon, "%02d T=%d Ks=%d Kp=%d BUID=0x%03x "
+                           "CNTLR_SPEC=0x%05x\n", i,
+                           sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
+                           sr & 0x20000000 ? 1 : 0, (uint32_t)((sr >> 20) & 0x1FF),
+                           (uint32_t)(sr & 0xFFFFF));
         } else {
-            qemu_printf("%02d T=%d Ks=%d Kp=%d N=%d VSID=0x%06x\n", i,
-                        sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
-                        sr & 0x20000000 ? 1 : 0, sr & 0x10000000 ? 1 : 0,
-                        (uint32_t)(sr & 0x00FFFFFF));
+            monitor_printf(mon, "%02d T=%d Ks=%d Kp=%d N=%d VSID=0x%06x\n", i,
+                           sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
+                           sr & 0x20000000 ? 1 : 0, sr & 0x10000000 ? 1 : 0,
+                           (uint32_t)(sr & 0x00FFFFFF));
         }
     }
 
-    qemu_printf("\nBATs:\n");
-    mmu6xx_dump_BATs(env, ACCESS_INT);
-    mmu6xx_dump_BATs(env, ACCESS_CODE);
+    monitor_puts(mon, "\nBATs:\n");
+    mmu6xx_dump_BATs(mon, env, ACCESS_INT);
+    mmu6xx_dump_BATs(mon, env, ACCESS_CODE);
 
     if (env->id_tlbs != 1) {
-        qemu_printf("ERROR: 6xx MMU should have separated TLB"
-                    " for code and data\n");
+        monitor_puts(mon, "ERROR: 6xx MMU should have separated TLB"
+                     " for code and data\n");
     }
 
-    qemu_printf("\nTLBs                       [EPN    EPN + SIZE]\n");
+    monitor_puts(mon, "\nTLBs                       [EPN    EPN + SIZE]\n");
 
     for (type = 0; type < 2; type++) {
         for (way = 0; way < env->nb_ways; way++) {
@@ -1117,28 +1120,28 @@ static void mmu6xx_dump_mmu(CPUPPCState *env)
                  entry++) {
 
                 tlb = &env->tlb.tlb6[entry];
-                qemu_printf("%s TLB %02d/%02d way:%d %s ["
-                            TARGET_FMT_lx " " TARGET_FMT_lx "]\n",
-                            type ? "code" : "data", entry % env->nb_tlb,
-                            env->nb_tlb, way,
-                            pte_is_valid(tlb->pte0) ? "valid" : "inval",
-                            tlb->EPN, tlb->EPN + TARGET_PAGE_SIZE);
+                monitor_printf(mon, "%s TLB %02d/%02d way:%d %s ["
+                               TARGET_FMT_lx " " TARGET_FMT_lx "]\n",
+                               type ? "code" : "data", entry % env->nb_tlb,
+                               env->nb_tlb, way,
+                               pte_is_valid(tlb->pte0) ? "valid" : "inval",
+                               tlb->EPN, tlb->EPN + TARGET_PAGE_SIZE);
             }
         }
     }
 }
 
-void dump_mmu(CPUPPCState *env)
+void ppc_dump_mmu(Monitor *mon, CPUPPCState *env)
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
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index a25d86a8d1..e798c30f91 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -88,7 +88,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(env1);
+    ppc_dump_mmu(mon, env1);
 }
 
 const MonitorDef monitor_defs[] = {
-- 
2.41.0


