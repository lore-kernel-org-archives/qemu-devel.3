Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB9FC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKfX-0004wz-CL; Thu, 21 Mar 2024 11:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfW-0004wN-J9
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfQ-0001I7-4O
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-414701303f7so10795125e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036154; x=1711640954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPB7wPRU4EbQ/PHDSaLSRsBSA5jdN0249I6tKdnInr4=;
 b=NSChZN961vxgCuV3mTkiixFDOA1rj37FIovTLzqyRyd00VEr7/qwPh0879jruYTUGE
 YJeVdnolDOcu9zdydkK4teZwO9CkOZa2X7bx4m2WBhpkH0iPguOTEsQgm+Sd5xcE2ugF
 kFqoUztLIVhm1WXNvxSaprgTv35JQEOHmkXtj5Y46vywpVhivrim1iuyO3RlwjCIq5zk
 DrJ6X8SY55MlNKTxpiZqbWXSdn0qMdqn34o8CN7V0TpjWG9fUyMybxgMZ0WjxGKHs0/z
 pST3rVICGourwktefcE8pdF3+dVbTOWKTw2J/nTUrd7z0RuAX16N5qHPeitTGRoXhQYj
 JWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036154; x=1711640954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPB7wPRU4EbQ/PHDSaLSRsBSA5jdN0249I6tKdnInr4=;
 b=ug8ailcDliMbboFUxvS06IWW4ExY0r+WUem5OXdif8Y3IzhDmtNhff+lN6quy5PJre
 axrybCGgOGzxT3H/Us8tPuHiGzG1KpkKRleLzbMcJsUrOLbgxrHYMUhDX1IKnI3XSHKi
 qPhNzl/FRUVEbr9WioskpY+MFrbknCTFmhTIY579GOX+cQP6+nBF1BxJeHI9mcvbNgS4
 kZZLSXtPOhjdOWK7/YveDai9+69SRu30ghyDOKG/aFGXido15Ejrr1Z0IEypRBag4Tv6
 dvY5QtE4lOCw5764iAPS3rxCkHfbfUKW9UJr/RJ2Uh+DScfgFM2KruCjgo1L6EuhbRiN
 oqDA==
X-Gm-Message-State: AOJu0YzGlLA446nmbipX0mSFMIS3NmUfxVFDP/8RURkYY76TcCOXkbsc
 9RRSbNPtwTQdZD16mN9bRK/GGdB/c04R/YgOrSA5VopbIwlXYbaUSHLufUG2xnMXOSEHEKTGy8y
 vFDI=
X-Google-Smtp-Source: AGHT+IE9dq0aSOWu0+Go+xQwyO48QnvBZANp82mdCGdCe9QTAoKEvhJGXJ1ZX9SQy9dmf8KojLeQuQ==
X-Received: by 2002:a05:600c:19d2:b0:413:ee55:8bba with SMTP id
 u18-20020a05600c19d200b00413ee558bbamr2321713wmq.4.1711036153865; 
 Thu, 21 Mar 2024 08:49:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b004140a757256sm5997663wmo.31.2024.03.21.08.49.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:49:13 -0700 (PDT)
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
Subject: [PATCH-for-9.1 04/21] target/i386: Extract x86_dump_mmu() from
 hmp_info_tlb()
Date: Thu, 21 Mar 2024 16:48:20 +0100
Message-ID: <20240321154838.95771-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

hmp_info_tlb() is specific to tcg/system, move it to
target/i386/tcg/sysemu/hmp-cmds.c, along with the functions
it depend on (except addr_canonical() which is exposed in
"cpu.h").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h       |   7 ++
 target/i386/mmu.c       | 231 ++++++++++++++++++++++++++++++++++++++++
 target/i386/monitor.c   | 215 -------------------------------------
 target/i386/meson.build |   1 +
 4 files changed, 239 insertions(+), 215 deletions(-)
 create mode 100644 target/i386/mmu.c

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 952174bb6f..055c5b99de 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2342,6 +2342,13 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
     return mmu_index_base + mmu_index_32;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+void x86_dump_mmu(Monitor *mon, CPUX86State *env);
+
+/* Perform linear address sign extension */
+hwaddr addr_canonical(CPUArchState *env, hwaddr addr);
+#endif
+
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
 #define CC_SRC2 (env->cc_src2)
diff --git a/target/i386/mmu.c b/target/i386/mmu.c
new file mode 100644
index 0000000000..da9b2263b4
--- /dev/null
+++ b/target/i386/mmu.c
@@ -0,0 +1,231 @@
+/*
+ * QEMU x86 MMU monitor commands
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "cpu.h"
+
+hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
+{
+#ifdef TARGET_X86_64
+    if (env->cr[4] & CR4_LA57_MASK) {
+        if (addr & (1ULL << 56)) {
+            addr |= (hwaddr)-(1LL << 57);
+        }
+    } else {
+        if (addr & (1ULL << 47)) {
+            addr |= (hwaddr)-(1LL << 48);
+        }
+    }
+#endif
+    return addr;
+}
+
+static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+                      hwaddr pte, hwaddr mask)
+{
+    addr = addr_canonical(env, addr);
+
+    monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
+                   " %c%c%c%c%c%c%c%c%c\n",
+                   addr,
+                   pte & mask,
+                   pte & PG_NX_MASK ? 'X' : '-',
+                   pte & PG_GLOBAL_MASK ? 'G' : '-',
+                   pte & PG_PSE_MASK ? 'P' : '-',
+                   pte & PG_DIRTY_MASK ? 'D' : '-',
+                   pte & PG_ACCESSED_MASK ? 'A' : '-',
+                   pte & PG_PCD_MASK ? 'C' : '-',
+                   pte & PG_PWT_MASK ? 'T' : '-',
+                   pte & PG_USER_MASK ? 'U' : '-',
+                   pte & PG_RW_MASK ? 'W' : '-');
+}
+
+static void tlb_info_32(Monitor *mon, CPUArchState *env)
+{
+    unsigned int l1, l2;
+    uint32_t pgd, pde, pte;
+
+    pgd = env->cr[3] & ~0xfff;
+    for(l1 = 0; l1 < 1024; l1++) {
+        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
+        pde = le32_to_cpu(pde);
+        if (pde & PG_PRESENT_MASK) {
+            if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
+                /* 4M pages */
+                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
+            } else {
+                for(l2 = 0; l2 < 1024; l2++) {
+                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
+                    pte = le32_to_cpu(pte);
+                    if (pte & PG_PRESENT_MASK) {
+                        print_pte(mon, env, (l1 << 22) + (l2 << 12),
+                                  pte & ~PG_PSE_MASK,
+                                  ~0xfff);
+                    }
+                }
+            }
+        }
+    }
+}
+
+static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
+{
+    unsigned int l1, l2, l3;
+    uint64_t pdpe, pde, pte;
+    uint64_t pdp_addr, pd_addr, pt_addr;
+
+    pdp_addr = env->cr[3] & ~0x1f;
+    for (l1 = 0; l1 < 4; l1++) {
+        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
+        pdpe = le64_to_cpu(pdpe);
+        if (pdpe & PG_PRESENT_MASK) {
+            pd_addr = pdpe & 0x3fffffffff000ULL;
+            for (l2 = 0; l2 < 512; l2++) {
+                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
+                pde = le64_to_cpu(pde);
+                if (pde & PG_PRESENT_MASK) {
+                    if (pde & PG_PSE_MASK) {
+                        /* 2M pages with PAE, CR4.PSE is ignored */
+                        print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
+                                  ~((hwaddr)(1 << 20) - 1));
+                    } else {
+                        pt_addr = pde & 0x3fffffffff000ULL;
+                        for (l3 = 0; l3 < 512; l3++) {
+                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
+                            pte = le64_to_cpu(pte);
+                            if (pte & PG_PRESENT_MASK) {
+                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
+                                          + (l3 << 12),
+                                          pte & ~PG_PSE_MASK,
+                                          ~(hwaddr)0xfff);
+                            }
+                        }
+                    }
+                }
+            }
+        }
+    }
+}
+
+#ifdef TARGET_X86_64
+static void tlb_info_la48(Monitor *mon, CPUArchState *env,
+        uint64_t l0, uint64_t pml4_addr)
+{
+    uint64_t l1, l2, l3, l4;
+    uint64_t pml4e, pdpe, pde, pte;
+    uint64_t pdp_addr, pd_addr, pt_addr;
+
+    for (l1 = 0; l1 < 512; l1++) {
+        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+        pml4e = le64_to_cpu(pml4e);
+        if (!(pml4e & PG_PRESENT_MASK)) {
+            continue;
+        }
+
+        pdp_addr = pml4e & 0x3fffffffff000ULL;
+        for (l2 = 0; l2 < 512; l2++) {
+            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+            pdpe = le64_to_cpu(pdpe);
+            if (!(pdpe & PG_PRESENT_MASK)) {
+                continue;
+            }
+
+            if (pdpe & PG_PSE_MASK) {
+                /* 1G pages, CR4.PSE is ignored */
+                print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
+                        pdpe, 0x3ffffc0000000ULL);
+                continue;
+            }
+
+            pd_addr = pdpe & 0x3fffffffff000ULL;
+            for (l3 = 0; l3 < 512; l3++) {
+                cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                pde = le64_to_cpu(pde);
+                if (!(pde & PG_PRESENT_MASK)) {
+                    continue;
+                }
+
+                if (pde & PG_PSE_MASK) {
+                    /* 2M pages, CR4.PSE is ignored */
+                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
+                            (l3 << 21), pde, 0x3ffffffe00000ULL);
+                    continue;
+                }
+
+                pt_addr = pde & 0x3fffffffff000ULL;
+                for (l4 = 0; l4 < 512; l4++) {
+                    cpu_physical_memory_read(pt_addr
+                            + l4 * 8,
+                            &pte, 8);
+                    pte = le64_to_cpu(pte);
+                    if (pte & PG_PRESENT_MASK) {
+                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
+                                (l2 << 30) + (l3 << 21) + (l4 << 12),
+                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
+                    }
+                }
+            }
+        }
+    }
+}
+
+static void tlb_info_la57(Monitor *mon, CPUArchState *env)
+{
+    uint64_t l0;
+    uint64_t pml5e;
+    uint64_t pml5_addr;
+
+    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
+    for (l0 = 0; l0 < 512; l0++) {
+        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
+        pml5e = le64_to_cpu(pml5e);
+        if (pml5e & PG_PRESENT_MASK) {
+            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
+        }
+    }
+}
+#endif /* TARGET_X86_64 */
+
+void x86_dump_mmu(Monitor *mon, CPUX86State *env)
+{
+    if (!(env->cr[0] & CR0_PG_MASK)) {
+        monitor_printf(mon, "PG disabled\n");
+        return;
+    }
+    if (env->cr[4] & CR4_PAE_MASK) {
+#ifdef TARGET_X86_64
+        if (env->hflags & HF_LMA_MASK) {
+            if (env->cr[4] & CR4_LA57_MASK) {
+                tlb_info_la57(mon, env);
+            } else {
+                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
+            }
+        } else
+#endif
+        {
+            tlb_info_pae32(mon, env);
+        }
+    } else {
+        tlb_info_32(mon, env);
+    }
+}
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env;
+
+    env = mon_get_cpu_env(mon);
+    if (!env) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+
+    x86_dump_mmu(mon, env);
+}
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 2d766b2637..fa155ac3c9 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -32,221 +32,6 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
 
-/* Perform linear address sign extension */
-static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
-{
-#ifdef TARGET_X86_64
-    if (env->cr[4] & CR4_LA57_MASK) {
-        if (addr & (1ULL << 56)) {
-            addr |= (hwaddr)-(1LL << 57);
-        }
-    } else {
-        if (addr & (1ULL << 47)) {
-            addr |= (hwaddr)-(1LL << 48);
-        }
-    }
-#endif
-    return addr;
-}
-
-static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
-{
-    addr = addr_canonical(env, addr);
-
-    monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
-                   " %c%c%c%c%c%c%c%c%c\n",
-                   addr,
-                   pte & mask,
-                   pte & PG_NX_MASK ? 'X' : '-',
-                   pte & PG_GLOBAL_MASK ? 'G' : '-',
-                   pte & PG_PSE_MASK ? 'P' : '-',
-                   pte & PG_DIRTY_MASK ? 'D' : '-',
-                   pte & PG_ACCESSED_MASK ? 'A' : '-',
-                   pte & PG_PCD_MASK ? 'C' : '-',
-                   pte & PG_PWT_MASK ? 'T' : '-',
-                   pte & PG_USER_MASK ? 'U' : '-',
-                   pte & PG_RW_MASK ? 'W' : '-');
-}
-
-static void tlb_info_32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2;
-    uint32_t pgd, pde, pte;
-
-    pgd = env->cr[3] & ~0xfff;
-    for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
-        pde = le32_to_cpu(pde);
-        if (pde & PG_PRESENT_MASK) {
-            if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
-                /* 4M pages */
-                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
-            } else {
-                for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
-                    pte = le32_to_cpu(pte);
-                    if (pte & PG_PRESENT_MASK) {
-                        print_pte(mon, env, (l1 << 22) + (l2 << 12),
-                                  pte & ~PG_PSE_MASK,
-                                  ~0xfff);
-                    }
-                }
-            }
-        }
-    }
-}
-
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2, l3;
-    uint64_t pdpe, pde, pte;
-    uint64_t pdp_addr, pd_addr, pt_addr;
-
-    pdp_addr = env->cr[3] & ~0x1f;
-    for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
-        pdpe = le64_to_cpu(pdpe);
-        if (pdpe & PG_PRESENT_MASK) {
-            pd_addr = pdpe & 0x3fffffffff000ULL;
-            for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
-                if (pde & PG_PRESENT_MASK) {
-                    if (pde & PG_PSE_MASK) {
-                        /* 2M pages with PAE, CR4.PSE is ignored */
-                        print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
-                                  ~((hwaddr)(1 << 20) - 1));
-                    } else {
-                        pt_addr = pde & 0x3fffffffff000ULL;
-                        for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
-                            pte = le64_to_cpu(pte);
-                            if (pte & PG_PRESENT_MASK) {
-                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
-                                          + (l3 << 12),
-                                          pte & ~PG_PSE_MASK,
-                                          ~(hwaddr)0xfff);
-                            }
-                        }
-                    }
-                }
-            }
-        }
-    }
-}
-
-#ifdef TARGET_X86_64
-static void tlb_info_la48(Monitor *mon, CPUArchState *env,
-        uint64_t l0, uint64_t pml4_addr)
-{
-    uint64_t l1, l2, l3, l4;
-    uint64_t pml4e, pdpe, pde, pte;
-    uint64_t pdp_addr, pd_addr, pt_addr;
-
-    for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
-        pml4e = le64_to_cpu(pml4e);
-        if (!(pml4e & PG_PRESENT_MASK)) {
-            continue;
-        }
-
-        pdp_addr = pml4e & 0x3fffffffff000ULL;
-        for (l2 = 0; l2 < 512; l2++) {
-            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
-            pdpe = le64_to_cpu(pdpe);
-            if (!(pdpe & PG_PRESENT_MASK)) {
-                continue;
-            }
-
-            if (pdpe & PG_PSE_MASK) {
-                /* 1G pages, CR4.PSE is ignored */
-                print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
-                        pdpe, 0x3ffffc0000000ULL);
-                continue;
-            }
-
-            pd_addr = pdpe & 0x3fffffffff000ULL;
-            for (l3 = 0; l3 < 512; l3++) {
-                cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
-                if (!(pde & PG_PRESENT_MASK)) {
-                    continue;
-                }
-
-                if (pde & PG_PSE_MASK) {
-                    /* 2M pages, CR4.PSE is ignored */
-                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21), pde, 0x3ffffffe00000ULL);
-                    continue;
-                }
-
-                pt_addr = pde & 0x3fffffffff000ULL;
-                for (l4 = 0; l4 < 512; l4++) {
-                    cpu_physical_memory_read(pt_addr
-                            + l4 * 8,
-                            &pte, 8);
-                    pte = le64_to_cpu(pte);
-                    if (pte & PG_PRESENT_MASK) {
-                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
-                                (l2 << 30) + (l3 << 21) + (l4 << 12),
-                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
-                    }
-                }
-            }
-        }
-    }
-}
-
-static void tlb_info_la57(Monitor *mon, CPUArchState *env)
-{
-    uint64_t l0;
-    uint64_t pml5e;
-    uint64_t pml5_addr;
-
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
-    for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
-        pml5e = le64_to_cpu(pml5e);
-        if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
-        }
-    }
-}
-#endif /* TARGET_X86_64 */
-
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-{
-    CPUArchState *env;
-
-    env = mon_get_cpu_env(mon);
-    if (!env) {
-        monitor_printf(mon, "No CPU available\n");
-        return;
-    }
-
-    if (!(env->cr[0] & CR0_PG_MASK)) {
-        monitor_printf(mon, "PG disabled\n");
-        return;
-    }
-    if (env->cr[4] & CR4_PAE_MASK) {
-#ifdef TARGET_X86_64
-        if (env->hflags & HF_LMA_MASK) {
-            if (env->cr[4] & CR4_LA57_MASK) {
-                tlb_info_la57(mon, env);
-            } else {
-                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
-            }
-        } else
-#endif
-        {
-            tlb_info_pae32(mon, env);
-        }
-    } else {
-        tlb_info_32(mon, env);
-    }
-}
-
 static void mem_print(Monitor *mon, CPUArchState *env,
                       hwaddr *pstart, int *plast_prot,
                       hwaddr end, int prot)
diff --git a/target/i386/meson.build b/target/i386/meson.build
index ba8dc68a34..6c6f383e2e 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -18,6 +18,7 @@ i386_system_ss.add(files(
   'arch_memory_mapping.c',
   'machine.c',
   'monitor.c',
+  'mmu.c',
   'cpu-apic.c',
   'cpu-sysemu.c',
 ))
-- 
2.41.0


