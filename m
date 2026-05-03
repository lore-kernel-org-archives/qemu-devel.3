Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D3CD3427
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 05:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPrC-0001Ci-GY; Sun, 03 May 2026 01:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM67-0004un-Df
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:20 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM64-0000RT-Mw
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:19 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so3788988eec.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773494; x=1778378294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHLoSL7bJ7XP3E/wJcb8DLImZUQfEkLy4reFzKuMpYQ=;
 b=lO03dlPb8hwGC28aTGyGYc45CYxyYR9Uoo8RrVzDGqmAXjnRSOGfv9yyVs9/u/BOzS
 CX3bIbzLMMnlq+QOT0ghHIqYRBOyWTUXjTVCLfefvnyZcRTTc2/tf8dPQB37597n6yqX
 fiUoJgayXSxlFVtip3AUk/aoACqKqPf1qnh8qaCNpHAUMLDwX8LafNQHHGvsjatEonA/
 7gG8KQrvXdY92wFy+1EqyzHqbboBTs1vrCFcpgiXNZtpgdNGKIknuLtFvo2hiX7qcS/z
 D0KU8+43EvCHQ0SDTf1dHu0tXHMDEC+9Njc5Gzk+AS6M++lFFmxGnsRplZkbcfgAWee1
 T9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773494; x=1778378294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UHLoSL7bJ7XP3E/wJcb8DLImZUQfEkLy4reFzKuMpYQ=;
 b=ClLwyAJoJGuxzkg+rTAzFTeAnlYCyXaUZGbuMBcrLlECjsVIaQHcB9QqjtoZRggRPV
 7MCgd88SPSTjtN2Id60lZmuzVFdo3cWKXV1l6x754eGv7R5jd1fi0haFwrvDqkr/sdD8
 p2C3mETl288y/DuOZoh1t3ZlfmR4ta2mTe0R7iqMc1EJW9xLN74BcH9kwwrkUPXCJDvI
 hP3eE5Njj2n/X4KqyhzIfTY2qAs/wBBuxL1e6RXaKL897ESnpKhcJSgVdeF7+UBnKxoH
 +XgaHrzNfKGhxXFlL9mrPnEJ0+1AuSC377oSz9PuEpn5uj5PuMpoYy6Lf64UVjFNIP4p
 4TMw==
X-Gm-Message-State: AOJu0YzWJzZ4pE+RnuDBWoqQnoXYK0ofWweJas75bIZJBHHX9EQVkKi5
 vC67hpBmQMaPcMJvvRGOmnXwKt6YfaEvVkWYA03PyNF0ni00kjy2PCmkoZQQng==
X-Gm-Gg: AeBDievYKsz+6nBBsfjPhhcNVbRHyh+skdg9cVCPPMu7mhuXFYGcLC9683RHcuEqyOI
 WNaIlRW1VONVAmPPjwrA9bwNTjxmn08ZCW7uCkQLVuPdwLLLgdNVZAqFVfNb41Vd7NMnilLD2UA
 3HkbyfD+ey82LoTgFnbDYw/nLnh2yNHm8Osvq9OGMGrGGKcAeAB4cWRg6MvyxG452osUcl6Rf3z
 0eNGp8veqTlM1D+q/YTNB4uy/CP6/+iJRjyAaNInXDP6RZmeHMXHZXxI4kGqu3hfjdqntJn1bhY
 QI0QzC2JHhlanfm3f3wRbkj0qPBV/FOXGNotvC/VE2Uv+cUHUnVnFWfIwk2QuUOneD91DzL26rv
 qR8R/yv89kr7cFa/kePMfUdbamPNSrFV4GiKDWtjdOnbheMkkz6kHjT3TNFAd9/OrMM2QRjV6DX
 VR23E3JJ/kjrF9nGI7eayab9AyN5kLgbVVHKpLU+r0OMQLmgpPMg==
X-Received: by 2002:a05:693c:3001:b0:2da:2ec2:64e5 with SMTP id
 5a478bee46e88-2efbac9a7famr1949610eec.18.1777773493348; 
 Sat, 02 May 2026 18:58:13 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:12 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 1/7] target/m68k: Implement Physical Bus Error exception
 handling
Date: Sat,  2 May 2026 18:57:50 -0700
Message-ID: <20260503015756.99176-2-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503015756.99176-1-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=54weasels@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:58:55 -0400
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

The M68020 natively maps hardware Bus Error (BERR) timeouts into a Long Bus Cycle Fault (Format 0xB). This commit adds the memory exception routing to natively synthesize these EXCP_ACCESS cycle faults. It also implements the double-fault / watchdog reset behavior required for Sun-3 hardware diagnostics, properly handles FSAVE/FRESTORE for 68881 FPU stubs, and properly constructs the 84-byte internal bus fault frame.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 target/m68k/cpu.c       |   5 +-
 target/m68k/cpu.h       |  18 +++-
 target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
 target/m68k/op_helper.c | 176 ++++++++++++++++++++++++++--------------
 target/m68k/translate.c |  31 +++++--
 5 files changed, 283 insertions(+), 77 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d849a4a90f..af375f0bce 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * QEMU Motorola 68k CPU
  *
@@ -51,8 +52,8 @@ static TCGTBCPUState m68k_get_tb_cpu_state(CPUState *cs)
     flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
     if (env->sr & SR_S) {
         flags |= TB_FLAGS_MSR_S;
-        flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
-        flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
+    flags |= (env->sfc << TB_FLAGS_SFC_S_BIT) & TB_FLAGS_SFC_S;
+    flags |= (env->dfc << TB_FLAGS_DFC_S_BIT) & TB_FLAGS_DFC_S;
     }
     if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
         flags |= TB_FLAGS_TRACE;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7911ab9de3..426ef6a6e1 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -149,10 +149,18 @@ typedef struct CPUArchState {
 
     int pending_vector;
     int pending_level;
+    bool nmi_pending;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
+    /* Custom MMU intercept logic, if any (e.g. for Sun-3) */
+    void *custom_mmu_opaque;
+    int (*custom_mmu_get_physical_address)(void *env, hwaddr *physical,
+                                           int *prot, vaddr address,
+                                           int access_type,
+                                           hwaddr *page_size);
+
     /* Fields from here on are preserved across CPU reset. */
     uint64_t features;
 } CPUM68KState;
@@ -601,12 +609,14 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_MSR_S_BIT      13
 #define TB_FLAGS_MSR_S          (1 << TB_FLAGS_MSR_S_BIT)
 #define TB_FLAGS_SFC_S_BIT      14
-#define TB_FLAGS_SFC_S          (1 << TB_FLAGS_SFC_S_BIT)
-#define TB_FLAGS_DFC_S_BIT      15
-#define TB_FLAGS_DFC_S          (1 << TB_FLAGS_DFC_S_BIT)
-#define TB_FLAGS_TRACE          16
+#define TB_FLAGS_SFC_S          (7 << TB_FLAGS_SFC_S_BIT) /* 3 Bits reserved */
+#define TB_FLAGS_DFC_S_BIT      17
+#define TB_FLAGS_DFC_S          (7 << TB_FLAGS_DFC_S_BIT) /* 3 Bits reserved */
+#define TB_FLAGS_TRACE          20
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
+#define MMU_MOVES_FC_BASE       2 /* mmu_idx 2-9 correspond to FC 0-7 */
+
 void dump_mmu(CPUM68KState *env);
 
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bab184389..997c2616f4 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -28,6 +28,7 @@
 #include "system/memory.h"
 #include "gdbstub/helpers.h"
 #include "fpu/softfloat.h"
+#include "qemu/log.h"
 #include "qemu/qemu-print.h"
 
 #define SIGNBIT (1u << 31)
@@ -280,8 +281,10 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
             return;
         }
         break;
-    /* Unimplemented Registers */
+    /* Dummy implementation for CAAR */
     case M68K_CR_CAAR:
+        return;
+    /* Unimplemented Registers */
     case M68K_CR_PCR:
     case M68K_CR_BUSCR:
         cpu_abort(env_cpu(env),
@@ -384,8 +387,10 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
             return env->mmu.ttr[M68K_DTTR1];
         }
         break;
-    /* Unimplemented Registers */
+    /* Dummy implementation for CAAR */
     case M68K_CR_CAAR:
+        return 0;
+    /* Unimplemented Registers */
     case M68K_CR_PCR:
     case M68K_CR_BUSCR:
         cpu_abort(env_cpu(env), "Unimplemented control register read 0x%x\n",
@@ -915,6 +920,21 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int access_type;
     target_ulong page_size;
 
+    access_type = ACCESS_DATA | ACCESS_DEBUG;
+    if (env->sr & SR_S) {
+        access_type |= ACCESS_SUPER;
+    }
+
+    if (env->custom_mmu_get_physical_address) {
+        hwaddr custom_page_size;
+        if (env->custom_mmu_get_physical_address(env, &phys_addr, &prot, addr,
+                                                 access_type,
+                                                 &custom_page_size) == 0) {
+            return phys_addr;
+        }
+        return -1;
+    }
+
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
         return addr;
@@ -944,6 +964,12 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
     CPUState *cs = CPU(cpu);
     CPUM68KState *env = &cpu->env;
 
+    if (level == 7 && env->pending_level != 7) {
+        env->nmi_pending = true;
+    } else if (level != 7) {
+        env->nmi_pending = false;
+    }
+
     env->pending_level = level;
     env->pending_vector = vector;
     if (level) {
@@ -964,6 +990,106 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int ret;
     target_ulong page_size;
 
+    if (qemu_access_type == MMU_INST_FETCH) {
+        access_type = ACCESS_CODE;
+    } else {
+        access_type = ACCESS_DATA;
+        if (qemu_access_type == MMU_DATA_STORE) {
+            access_type |= ACCESS_STORE;
+        }
+    }
+
+    /* Decode explicit Function Codes from moves instructions */
+    if (mmu_idx >= MMU_MOVES_FC_BASE) {
+        uint8_t fc = mmu_idx - MMU_MOVES_FC_BASE;
+        access_type |= (fc << 8); /* Pack explicit FC into access type */
+        if (fc != 1 && fc != 2) {
+            access_type |= ACCESS_SUPER;
+        }
+    } else {
+        /* Standard memory accesses map logically to normal M68K FCs */
+        if (mmu_idx == MMU_KERNEL_IDX) {
+            access_type |= ACCESS_SUPER;
+            access_type |= ((qemu_access_type == MMU_INST_FETCH ? 6 : 5) << 8);
+        } else {
+            access_type |= ((qemu_access_type == MMU_INST_FETCH ? 2 : 1) << 8);
+        }
+    }
+
+    if (env->custom_mmu_get_physical_address) {
+        hwaddr custom_page_size;
+
+        /* Delegate translation to external board-specific MMU if registered */
+        ret = env->custom_mmu_get_physical_address(env, &physical, &prot,
+                                                   address, access_type,
+                                                   &custom_page_size);
+
+        if (likely(ret == 0)) {
+            tlb_set_page(cs, address & TARGET_PAGE_MASK,
+                         physical & TARGET_PAGE_MASK, prot,
+                         mmu_idx, custom_page_size);
+            return true;
+        }
+
+        if (probe) {
+            return false;
+        }
+
+        /* page fault */
+        cs->exception_index = EXCP_ACCESS;
+        env->mmu.ar = address;
+
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ssw = M68K_ATC_040;
+            switch (size) {
+            case 1:
+                env->mmu.ssw |= M68K_BA_SIZE_BYTE;
+                break;
+            case 2:
+                env->mmu.ssw |= M68K_BA_SIZE_WORD;
+                break;
+            case 4:
+                env->mmu.ssw |= M68K_BA_SIZE_LONG;
+                break;
+            }
+            env->mmu.ssw |= M68K_TM_040_DATA;
+        } else {
+            /* M68020/030 Special Status Word (SSW) */
+            uint16_t ssw = 0x0100; /* DF - Data Fault */
+            switch (size) {
+            case 1:
+                ssw |= 0x0010;
+                break;
+            case 2:
+                ssw |= 0x0020;
+                break;
+            case 3:
+                ssw |= 0x0030;
+                break;
+            case 4:
+                ssw |= 0x0000;
+                break;
+            }
+            if (qemu_access_type != MMU_DATA_STORE) {
+                ssw |= 0x0040; /* RW - Read */
+            }
+            /* Function Code */
+            uint8_t fc;
+            if (mmu_idx >= MMU_MOVES_FC_BASE) {
+                fc = mmu_idx - MMU_MOVES_FC_BASE;
+            } else {
+                if (mmu_idx == MMU_KERNEL_IDX) {
+                    fc = (qemu_access_type == MMU_INST_FETCH) ? 6 : 5;
+                } else {
+                    fc = (qemu_access_type == MMU_INST_FETCH) ? 2 : 1;
+                }
+            }
+            ssw |= (fc & 7);
+            env->mmu.ssw = ssw;
+        }
+        cpu_loop_exit_restore(cs, retaddr);
+    }
+
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8148a8852e..84d5270767 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  M68K helper routines
  *
@@ -25,6 +26,7 @@
 #include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
+#include "system/runstate.h"
 
 static void cf_rte(CPUM68KState *env)
 {
@@ -73,6 +75,12 @@ throwaway:
         case 7:
             sp += 52;
             break;
+        case 0xa: /* Short Bus Cycle Fault (Format 0xA) */
+            sp += 32 - 8; /* 32 bytes total - 8 bytes header = 24 bytes */
+            break;
+        case 0xb: /* Long Bus Cycle Fault (Format 0xB) */
+            sp += 92 - 8; /* 92 bytes total - 8 bytes header = 84 bytes */
+            break;
         }
     }
     env->aregs[7] = sp;
@@ -342,56 +350,80 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     switch (cs->exception_index) {
     case EXCP_ACCESS:
         if (env->mmu.fault) {
-            cpu_abort(cs, "DOUBLE MMU FAULT\n");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M68K: Double MMU Fault. Halting CPU and requesting reset.\n");
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            cs->halted = 1;
+            cs->exception_index = EXCP_HLT;
+            cpu_loop_exit(cs);
         }
         env->mmu.fault = true;
-        /* push data 3 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* push data 2 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* push data 1 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 1 / push data 0 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 1 address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 2 data */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 2 address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 3 data */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 3 address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
-        /* fault address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
-        /* write back 1 status */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 2 status */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 3 status */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* special status word */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
-        /* effective address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
-
-        do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
+
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            /* push data 3 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* push data 2 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* push data 1 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 1 / push data 0 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 1 address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 2 data */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 2 address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 3 data */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 3 address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+            /* fault address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+            /* write back 1 status */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 2 status */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 3 status */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* special status word */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
+            /* effective address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+
+            do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
+        } else {
+            /* M68020 Long Bus Cycle Fault (Format 0xB) */
+            /*
+             * 84 bytes of internal state are pushed before the generic
+             * 8-byte header
+             */
+            sp -= 84;
+            for (int i = 0; i < 84; i += 4) {
+                cpu_stl_be_mmuidx_ra(env, sp + i, 0, MMU_KERNEL_IDX, 0);
+            }
+            /* Offset 0x02 from internal frame: SSW */
+            cpu_stw_be_mmuidx_ra(env, sp + 2, env->mmu.ssw, MMU_KERNEL_IDX, 0);
+            /* Offset 0x08 from internal frame: Fault Address */
+            cpu_stl_be_mmuidx_ra(env, sp + 8, env->mmu.ar, MMU_KERNEL_IDX, 0);
+
+            do_stack_frame(env, &sp, 0xb, oldsr, 0, env->pc);
+        }
         env->mmu.fault = false;
         if (qemu_loglevel_mask(CPU_LOG_INT)) {
             qemu_log("            "
@@ -437,7 +469,9 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 
     env->aregs[7] = sp;
     /* Jump to vector.  */
+    env->mmu.fault = true;
     env->pc = cpu_ldl_be_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+    env->mmu.fault = false;
 
     do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
@@ -509,26 +543,46 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
         if (access_type != MMU_DATA_STORE) {
             env->mmu.ssw |= M68K_RW_040;
         }
-
-        env->mmu.ar = addr;
-
-        cs->exception_index = EXCP_ACCESS;
-        cpu_loop_exit(cs);
+    } else if (m68k_feature(env, M68K_FEATURE_M68020)) {
+        /*
+         * M68020 Long Bus Cycle Fault (Format 0xB).
+         * The Motorola 68020 hardware intrinsically generates a physical
+         * Bus Error exception whenever the system bus flags a transaction
+         * timeout or failure (e.g., attempting to read an unpopulated bus
+         * address). This natively injects the EXCP_ACCESS cycle to build
+         * the generic 84-byte exception stack frame.
+         */
+        env->mmu.ssw = 0;
+        if (access_type == MMU_INST_FETCH) {
+            env->mmu.ssw |= 0x1000;
+        } else if (access_type == MMU_DATA_STORE) {
+            env->mmu.ssw |= 0x0040;
+        } else {
+            env->mmu.ssw |= 0x0080;
+        }
+    } else {
+        /*
+         * Older architectures (e.g. 68000) do not currently support
+         * hardware-injected transaction failures in QEMU.
+         */
+        return;
     }
+
+    env->mmu.ar = addr;
+    cs->exception_index = EXCP_ACCESS;
+    cpu_loop_exit(cs);
 }
 
 bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUM68KState *env = cpu_env(cs);
 
-    if (interrupt_request & CPU_INTERRUPT_HARD
-        && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
-        /*
-         * Real hardware gets the interrupt vector via an IACK cycle
-         * at this point.  Current emulated hardware doesn't rely on
-         * this, so we provide/save the vector when the interrupt is
-         * first signalled.
-         */
+    if (env->nmi_pending) {
+        env->nmi_pending = false;
+        cs->exception_index = env->pending_vector;
+        do_interrupt_m68k_hardirq(env);
+        return true;
+    } else if (((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
         cs->exception_index = env->pending_vector;
         do_interrupt_m68k_hardirq(env);
         return true;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index abc1c79f3c..d6fcd6c4d9 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  m68k translation
  *
@@ -163,10 +164,12 @@ static void do_writebacks(DisasContext *s)
 #define IS_USER(s) 1
 #else
 #define IS_USER(s)   (!(s->base.tb->flags & TB_FLAGS_MSR_S))
-#define SFC_INDEX(s) ((s->base.tb->flags & TB_FLAGS_SFC_S) ? \
-                      MMU_KERNEL_IDX : MMU_USER_IDX)
-#define DFC_INDEX(s) ((s->base.tb->flags & TB_FLAGS_DFC_S) ? \
-                      MMU_KERNEL_IDX : MMU_USER_IDX)
+#define SFC_INDEX(s) (MMU_MOVES_FC_BASE + \
+                     (((s)->base.tb->flags & TB_FLAGS_SFC_S) >> \
+                      TB_FLAGS_SFC_S_BIT))
+#define DFC_INDEX(s) (MMU_MOVES_FC_BASE + \
+                     (((s)->base.tb->flags & TB_FLAGS_DFC_S) >> \
+                      TB_FLAGS_DFC_S_BIT))
 #endif
 
 typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t insn);
@@ -5364,11 +5367,19 @@ DISAS_INSN(frestore)
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
-    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+    if (m68k_feature(s->env, M68K_FEATURE_M68040) ||
+        m68k_feature(s->env, M68K_FEATURE_FPU)) {
         SRC_EA(env, addr, OS_LONG, 0, NULL);
-        /* FIXME: check the state frame */
+        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+            /* FIXME: check the state frame */
+        } else {
+            /*
+             * 68881/68882 FRESTORE: read the state frame
+             * (NULL frame is 4 bytes)
+             */
+        }
     } else {
-        disas_undef(env, s, insn);
+        disas_undef_fpu(env, s, insn);
     }
 }
 
@@ -5383,8 +5394,12 @@ DISAS_INSN(fsave)
         /* always write IDLE */
         TCGv idle = tcg_constant_i32(0x41000000);
         DEST_EA(env, insn, OS_LONG, idle, NULL);
+    } else if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
+        /* 68881/68882 FSAVE: always write NULL frame */
+        TCGv null_frame = tcg_constant_i32(0x00000000);
+        DEST_EA(env, insn, OS_LONG, null_frame, NULL);
     } else {
-        disas_undef(env, s, insn);
+        disas_undef_fpu(env, s, insn);
     }
 }
 #endif
-- 
2.50.1 (Apple Git-155)


