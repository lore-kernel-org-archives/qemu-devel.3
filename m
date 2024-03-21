Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE8C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKfp-0005jT-44; Thu, 21 Mar 2024 11:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfn-0005WT-5f
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfi-0001QX-QF
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41466e01965so7937905e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036176; x=1711640976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sC//v5zJC26L5oJBPuaKUrq0r2OoFOjOzcD/UQcspDw=;
 b=rLh1W1Od7zUegQVnLB1jrDqxPHf1d6D5npeVhFkEp4oLnUq7aY65Y9e34KL6Vba1NU
 ULgytPFa7qlfesSywN4X3umHx9JBRaYygYG9mB4zGnwA0pAfiFDcTqz26gl2o4Hphngi
 Kcu8+nTlKw7lvK3oKfS58nyNUzRExYdmr9UX2q0LmAC2xnmGtK15YqQZ2owCXHqu9tiL
 nbehf3VitkANQBlMH9dJHVkWYHHI0aH0iBIizLWJllL7XzMXDC7jaCgM4Lf65aQrN4Rm
 dNPFJIU/4A/+wRIrkvEkGmYJmD6WKperO/3qnJs4TU/vu64ZZNVqQaztmfzuVKvFQpe/
 bqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036176; x=1711640976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sC//v5zJC26L5oJBPuaKUrq0r2OoFOjOzcD/UQcspDw=;
 b=Jrx9GS0qbfbN32Vb564s4HnpAHwtnSNLXFxQ/bxo61mUgGlskZ2bb8bF3JVCxHxKGO
 5bqDkNy5p96jQp2NKbUpRWcTpT2X1ov3/xOgFa42+WV1KcybWfNDvhL1a0rJ1pG07nJh
 RAMQqOYxwVZfQSu3hseGWw5l0KL/6QH7ctbmbmYHUekzReV9xialY94GbFpV2JvdH7FB
 AYe/p/8RgZubbpKAzLmvrwRLCRg6zQsVNJoB9lHSf47v0HZAf6YEhAdRJE2ky76KXNX2
 PsTSBXEKCmSnjm2fBxLgwP8ppae+c8Nr3cYMq1B/TrNL2R4wAg8cmclmlcPdC8z17qzT
 nvhQ==
X-Gm-Message-State: AOJu0YyoJWU7CbA32iwvvA+YhRVnsTXtiyeMdsL+pkIpbSkzLJIEMtFq
 aw2C/Q1ie41roGM7hjK6PzY7dKN6ivbh/txPUNUQPs8ujBE0o6O9jwY1MmPcY4gE4GqMELqsVXU
 V+Eo=
X-Google-Smtp-Source: AGHT+IFw0k53MJIEDoEtj/96Ez8pi/LpbXoIDbS/169t1A8FKaf2xVKWSjv2p94mK18bkZO+A1abiA==
X-Received: by 2002:a05:600c:3b19:b0:414:f50:3587 with SMTP id
 m25-20020a05600c3b1900b004140f503587mr9936764wms.8.1711036176449; 
 Thu, 21 Mar 2024 08:49:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c4e4d00b004146750314csm6021722wmq.3.2024.03.21.08.49.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:49:35 -0700 (PDT)
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
Subject: [PATCH-for-9.1 07/21] target/m68k: Move MMU monitor commands from
 helper.c to monitor.c
Date: Thu, 21 Mar 2024 16:48:23 +0100
Message-ID: <20240321154838.95771-8-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Keep all HMP commands in monitor.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.h     |   3 +-
 target/m68k/helper.c  | 222 -----------------------------------------
 target/m68k/monitor.c | 223 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 223 insertions(+), 225 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 4e4307956d..0c2a9fa717 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -589,6 +589,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  unsigned size, MMUAccessType access_type,
                                  int mmu_idx, MemTxAttrs attrs,
                                  MemTxResult response, uintptr_t retaddr);
+void m68k_dump_mmu(Monitor *mon, CPUM68KState *env);
 #endif
 
 #include "exec/cpu-all.h"
@@ -620,6 +621,4 @@ static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
     }
 }
 
-void dump_mmu(Monitor *mon, CPUM68KState *env);
-
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index cf9d83e47e..bd833aed5d 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -25,7 +25,6 @@
 #include "exec/helper-proto.h"
 #include "gdbstub/helpers.h"
 #include "fpu/softfloat.h"
-#include "monitor/monitor.h"
 
 #define SIGNBIT (1u << 31)
 
@@ -455,227 +454,6 @@ void m68k_switch_sp(CPUM68KState *env)
 #if !defined(CONFIG_USER_ONLY)
 /* MMU: 68040 only */
 
-static void print_address_zone(Monitor *mon,
-                               uint32_t logical, uint32_t physical,
-                               uint32_t size, int attr)
-{
-    monitor_printf(mon, "%08x - %08x -> %08x - %08x %c ",
-                   logical, logical + size - 1,
-                   physical, physical + size - 1,
-                   attr & 4 ? 'W' : '-');
-    size >>= 10;
-    if (size < 1024) {
-        monitor_printf(mon, "(%d KiB)\n", size);
-    } else {
-        size >>= 10;
-        if (size < 1024) {
-            monitor_printf(mon, "(%d MiB)\n", size);
-        } else {
-            size >>= 10;
-            monitor_printf(mon, "(%d GiB)\n", size);
-        }
-    }
-}
-
-static void dump_address_map(Monitor *mon, CPUM68KState *env,
-                             uint32_t root_pointer)
-{
-    int i, j, k;
-    int tic_size, tic_shift;
-    uint32_t tib_mask;
-    uint32_t tia, tib, tic;
-    uint32_t logical = 0xffffffff, physical = 0xffffffff;
-    uint32_t first_logical = 0xffffffff, first_physical = 0xffffffff;
-    uint32_t last_logical, last_physical;
-    int32_t size;
-    int last_attr = -1, attr = -1;
-    CPUState *cs = env_cpu(env);
-    MemTxResult txres;
-
-    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
-        /* 8k page */
-        tic_size = 32;
-        tic_shift = 13;
-        tib_mask = M68K_8K_PAGE_MASK;
-    } else {
-        /* 4k page */
-        tic_size = 64;
-        tic_shift = 12;
-        tib_mask = M68K_4K_PAGE_MASK;
-    }
-    for (i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
-        tia = address_space_ldl(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4,
-                                MEMTXATTRS_UNSPECIFIED, &txres);
-        if (txres != MEMTX_OK || !M68K_UDT_VALID(tia)) {
-            continue;
-        }
-        for (j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
-            tib = address_space_ldl(cs->as, M68K_POINTER_BASE(tia) + j * 4,
-                                    MEMTXATTRS_UNSPECIFIED, &txres);
-            if (txres != MEMTX_OK || !M68K_UDT_VALID(tib)) {
-                continue;
-            }
-            for (k = 0; k < tic_size; k++) {
-                tic = address_space_ldl(cs->as, (tib & tib_mask) + k * 4,
-                                        MEMTXATTRS_UNSPECIFIED, &txres);
-                if (txres != MEMTX_OK || !M68K_PDT_VALID(tic)) {
-                    continue;
-                }
-                if (M68K_PDT_INDIRECT(tic)) {
-                    tic = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(tic),
-                                            MEMTXATTRS_UNSPECIFIED, &txres);
-                    if (txres != MEMTX_OK) {
-                        continue;
-                    }
-                }
-
-                last_logical = logical;
-                logical = (i << M68K_TTS_ROOT_SHIFT) |
-                          (j << M68K_TTS_POINTER_SHIFT) |
-                          (k << tic_shift);
-
-                last_physical = physical;
-                physical = tic & ~((1 << tic_shift) - 1);
-
-                last_attr = attr;
-                attr = tic & ((1 << tic_shift) - 1);
-
-                if ((logical != (last_logical + (1 << tic_shift))) ||
-                    (physical != (last_physical + (1 << tic_shift))) ||
-                    (attr & 4) != (last_attr & 4)) {
-
-                    if (first_logical != 0xffffffff) {
-                        size = last_logical + (1 << tic_shift) -
-                               first_logical;
-                        print_address_zone(mon, first_logical,
-                                           first_physical, size, last_attr);
-                    }
-                    first_logical = logical;
-                    first_physical = physical;
-                }
-            }
-        }
-    }
-    if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
-        size = logical + (1 << tic_shift) - first_logical;
-        print_address_zone(mon, first_logical, first_physical, size, last_attr);
-    }
-}
-
-#define DUMP_CACHEFLAGS(a) \
-    switch (a & M68K_DESC_CACHEMODE) { \
-    case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
-        monitor_puts(mon, "T"); \
-        break; \
-    case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
-        monitor_puts(mon, "C"); \
-        break; \
-    case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
-        monitor_puts(mon, "S"); \
-        break; \
-    case M68K_DESC_CM_NCACHE: /* noncachable */ \
-        monitor_puts(mon, "N"); \
-        break; \
-    }
-
-static void dump_ttr(Monitor *mon, const char *desc, uint32_t ttr)
-{
-    monitor_printf(mon, "%s: ", desc);
-    if ((ttr & M68K_TTR_ENABLED) == 0) {
-        monitor_puts(mon, "disabled\n");
-        return;
-    }
-    monitor_printf(mon, "Base: 0x%08x Mask: 0x%08x Control: ",
-                   ttr & M68K_TTR_ADDR_BASE,
-                   (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
-    switch (ttr & M68K_TTR_SFIELD) {
-    case M68K_TTR_SFIELD_USER:
-        monitor_puts(mon, "U");
-        break;
-    case M68K_TTR_SFIELD_SUPER:
-        monitor_puts(mon, "S");
-        break;
-    default:
-        monitor_puts(mon, "*");
-        break;
-    }
-    DUMP_CACHEFLAGS(ttr);
-    if (ttr & M68K_DESC_WRITEPROT) {
-        monitor_puts(mon, "R");
-    } else {
-        monitor_puts(mon, "W");
-    }
-    monitor_printf(mon, " U: %d\n", (ttr & M68K_DESC_USERATTR) >>
-                               M68K_DESC_USERATTR_SHIFT);
-}
-
-void dump_mmu(Monitor *mon, CPUM68KState *env)
-{
-    if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
-        monitor_puts(mon, "Translation disabled\n");
-        return;
-    }
-    monitor_puts(mon, "Page Size: ");
-    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
-        monitor_puts(mon, "8kB\n");
-    } else {
-        monitor_puts(mon, "4kB\n");
-    }
-
-    monitor_puts(mon, "MMUSR: ");
-    if (env->mmu.mmusr & M68K_MMU_B_040) {
-        monitor_puts(mon, "BUS ERROR\n");
-    } else {
-        monitor_printf(mon, "Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
-        /* flags found on the page descriptor */
-        if (env->mmu.mmusr & M68K_MMU_G_040) {
-            monitor_puts(mon, "G"); /* Global */
-        } else {
-            monitor_puts(mon, ".");
-        }
-        if (env->mmu.mmusr & M68K_MMU_S_040) {
-            monitor_puts(mon, "S"); /* Supervisor */
-        } else {
-            monitor_puts(mon, ".");
-        }
-        if (env->mmu.mmusr & M68K_MMU_M_040) {
-            monitor_puts(mon, "M"); /* Modified */
-        } else {
-            monitor_puts(mon, ".");
-        }
-        if (env->mmu.mmusr & M68K_MMU_WP_040) {
-            monitor_puts(mon, "W"); /* Write protect */
-        } else {
-            monitor_puts(mon, ".");
-        }
-        if (env->mmu.mmusr & M68K_MMU_T_040) {
-            monitor_puts(mon, "T"); /* Transparent */
-        } else {
-            monitor_puts(mon, ".");
-        }
-        if (env->mmu.mmusr & M68K_MMU_R_040) {
-            monitor_puts(mon, "R"); /* Resident */
-        } else {
-            monitor_puts(mon, ".");
-        }
-        monitor_puts(mon, " Cache: ");
-        DUMP_CACHEFLAGS(env->mmu.mmusr);
-        monitor_printf(mon, " U: %d\n", (env->mmu.mmusr >> 8) & 3);
-        monitor_puts(mon, "\n");
-    }
-
-    dump_ttr(mon, "ITTR0", env->mmu.ttr[M68K_ITTR0]);
-    dump_ttr(mon, "ITTR1", env->mmu.ttr[M68K_ITTR1]);
-    dump_ttr(mon, "DTTR0", env->mmu.ttr[M68K_DTTR0]);
-    dump_ttr(mon, "DTTR1", env->mmu.ttr[M68K_DTTR1]);
-
-    monitor_printf(mon, "SRP: 0x%08x\n", env->mmu.srp);
-    dump_address_map(mon, env, env->mmu.srp);
-
-    monitor_printf(mon, "URP: 0x%08x\n", env->mmu.urp);
-    dump_address_map(mon, env, env->mmu.urp);
-}
-
 static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
                      int access_type)
 {
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 623c6ab635..c225846540 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -10,6 +10,227 @@
 #include "monitor/hmp-target.h"
 #include "monitor/monitor.h"
 
+static void print_address_zone(Monitor *mon,
+                               uint32_t logical, uint32_t physical,
+                               uint32_t size, int attr)
+{
+    monitor_printf(mon, "%08x - %08x -> %08x - %08x %c ",
+                   logical, logical + size - 1,
+                   physical, physical + size - 1,
+                   attr & 4 ? 'W' : '-');
+    size >>= 10;
+    if (size < 1024) {
+        monitor_printf(mon, "(%d KiB)\n", size);
+    } else {
+        size >>= 10;
+        if (size < 1024) {
+            monitor_printf(mon, "(%d MiB)\n", size);
+        } else {
+            size >>= 10;
+            monitor_printf(mon, "(%d GiB)\n", size);
+        }
+    }
+}
+
+static void dump_address_map(Monitor *mon, CPUM68KState *env,
+                             uint32_t root_pointer)
+{
+    int i, j, k;
+    int tic_size, tic_shift;
+    uint32_t tib_mask;
+    uint32_t tia, tib, tic;
+    uint32_t logical = 0xffffffff, physical = 0xffffffff;
+    uint32_t first_logical = 0xffffffff, first_physical = 0xffffffff;
+    uint32_t last_logical, last_physical;
+    int32_t size;
+    int last_attr = -1, attr = -1;
+    CPUState *cs = env_cpu(env);
+    MemTxResult txres;
+
+    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
+        /* 8k page */
+        tic_size = 32;
+        tic_shift = 13;
+        tib_mask = M68K_8K_PAGE_MASK;
+    } else {
+        /* 4k page */
+        tic_size = 64;
+        tic_shift = 12;
+        tib_mask = M68K_4K_PAGE_MASK;
+    }
+    for (i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
+        tia = address_space_ldl(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4,
+                                MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK || !M68K_UDT_VALID(tia)) {
+            continue;
+        }
+        for (j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
+            tib = address_space_ldl(cs->as, M68K_POINTER_BASE(tia) + j * 4,
+                                    MEMTXATTRS_UNSPECIFIED, &txres);
+            if (txres != MEMTX_OK || !M68K_UDT_VALID(tib)) {
+                continue;
+            }
+            for (k = 0; k < tic_size; k++) {
+                tic = address_space_ldl(cs->as, (tib & tib_mask) + k * 4,
+                                        MEMTXATTRS_UNSPECIFIED, &txres);
+                if (txres != MEMTX_OK || !M68K_PDT_VALID(tic)) {
+                    continue;
+                }
+                if (M68K_PDT_INDIRECT(tic)) {
+                    tic = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(tic),
+                                            MEMTXATTRS_UNSPECIFIED, &txres);
+                    if (txres != MEMTX_OK) {
+                        continue;
+                    }
+                }
+
+                last_logical = logical;
+                logical = (i << M68K_TTS_ROOT_SHIFT) |
+                          (j << M68K_TTS_POINTER_SHIFT) |
+                          (k << tic_shift);
+
+                last_physical = physical;
+                physical = tic & ~((1 << tic_shift) - 1);
+
+                last_attr = attr;
+                attr = tic & ((1 << tic_shift) - 1);
+
+                if ((logical != (last_logical + (1 << tic_shift))) ||
+                    (physical != (last_physical + (1 << tic_shift))) ||
+                    (attr & 4) != (last_attr & 4)) {
+
+                    if (first_logical != 0xffffffff) {
+                        size = last_logical + (1 << tic_shift) -
+                               first_logical;
+                        print_address_zone(mon, first_logical,
+                                           first_physical, size, last_attr);
+                    }
+                    first_logical = logical;
+                    first_physical = physical;
+                }
+            }
+        }
+    }
+    if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
+        size = logical + (1 << tic_shift) - first_logical;
+        print_address_zone(mon, first_logical, first_physical, size, last_attr);
+    }
+}
+
+#define DUMP_CACHEFLAGS(a) \
+    switch (a & M68K_DESC_CACHEMODE) { \
+    case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
+        monitor_puts(mon, "T"); \
+        break; \
+    case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
+        monitor_puts(mon, "C"); \
+        break; \
+    case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
+        monitor_puts(mon, "S"); \
+        break; \
+    case M68K_DESC_CM_NCACHE: /* noncachable */ \
+        monitor_puts(mon, "N"); \
+        break; \
+    }
+
+static void dump_ttr(Monitor *mon, const char *desc, uint32_t ttr)
+{
+    monitor_printf(mon, "%s: ", desc);
+    if ((ttr & M68K_TTR_ENABLED) == 0) {
+        monitor_puts(mon, "disabled\n");
+        return;
+    }
+    monitor_printf(mon, "Base: 0x%08x Mask: 0x%08x Control: ",
+                   ttr & M68K_TTR_ADDR_BASE,
+                   (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
+    switch (ttr & M68K_TTR_SFIELD) {
+    case M68K_TTR_SFIELD_USER:
+        monitor_puts(mon, "U");
+        break;
+    case M68K_TTR_SFIELD_SUPER:
+        monitor_puts(mon, "S");
+        break;
+    default:
+        monitor_puts(mon, "*");
+        break;
+    }
+    DUMP_CACHEFLAGS(ttr);
+    if (ttr & M68K_DESC_WRITEPROT) {
+        monitor_puts(mon, "R");
+    } else {
+        monitor_puts(mon, "W");
+    }
+    monitor_printf(mon, " U: %d\n", (ttr & M68K_DESC_USERATTR) >>
+                               M68K_DESC_USERATTR_SHIFT);
+}
+
+void m68k_dump_mmu(Monitor *mon, CPUM68KState *env)
+{
+    if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
+        monitor_puts(mon, "Translation disabled\n");
+        return;
+    }
+    monitor_puts(mon, "Page Size: ");
+    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
+        monitor_puts(mon, "8kB\n");
+    } else {
+        monitor_puts(mon, "4kB\n");
+    }
+
+    monitor_puts(mon, "MMUSR: ");
+    if (env->mmu.mmusr & M68K_MMU_B_040) {
+        monitor_puts(mon, "BUS ERROR\n");
+    } else {
+        monitor_printf(mon, "Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
+        /* flags found on the page descriptor */
+        if (env->mmu.mmusr & M68K_MMU_G_040) {
+            monitor_puts(mon, "G"); /* Global */
+        } else {
+            monitor_puts(mon, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_S_040) {
+            monitor_puts(mon, "S"); /* Supervisor */
+        } else {
+            monitor_puts(mon, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_M_040) {
+            monitor_puts(mon, "M"); /* Modified */
+        } else {
+            monitor_puts(mon, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_WP_040) {
+            monitor_puts(mon, "W"); /* Write protect */
+        } else {
+            monitor_puts(mon, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_T_040) {
+            monitor_puts(mon, "T"); /* Transparent */
+        } else {
+            monitor_puts(mon, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_R_040) {
+            monitor_puts(mon, "R"); /* Resident */
+        } else {
+            monitor_puts(mon, ".");
+        }
+        monitor_puts(mon, " Cache: ");
+        DUMP_CACHEFLAGS(env->mmu.mmusr);
+        monitor_printf(mon, " U: %d\n", (env->mmu.mmusr >> 8) & 3);
+        monitor_puts(mon, "\n");
+    }
+
+    dump_ttr(mon, "ITTR0", env->mmu.ttr[M68K_ITTR0]);
+    dump_ttr(mon, "ITTR1", env->mmu.ttr[M68K_ITTR1]);
+    dump_ttr(mon, "DTTR0", env->mmu.ttr[M68K_DTTR0]);
+    dump_ttr(mon, "DTTR1", env->mmu.ttr[M68K_DTTR1]);
+
+    monitor_printf(mon, "SRP: 0x%08x\n", env->mmu.srp);
+    dump_address_map(mon, env, env->mmu.srp);
+
+    monitor_printf(mon, "URP: 0x%08x\n", env->mmu.urp);
+    dump_address_map(mon, env, env->mmu.urp);
+}
+
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
@@ -19,7 +240,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    dump_mmu(mon, env1);
+    m68k_dump_mmu(mon, env1);
 }
 
 static const MonitorDef monitor_defs[] = {
-- 
2.41.0


