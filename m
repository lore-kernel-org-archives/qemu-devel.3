Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3273AC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKV-0001kF-10; Mon, 27 Jan 2025 05:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKM-0001gG-Au
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:46 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKJ-0001xE-Rk
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so2088525f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973601; x=1738578401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTJwfGzF9H+nXAFh4oKJlHlsOewOwWpsY8vG45m99Ks=;
 b=nAx6b6nVW+mtioKXixC07NT/QxFyuoBnxrOukFt0h73UI2ev4RZRvqdAtMa+D8Akcq
 SOOb+Sr3m7vSCvZCZJE8q9AsUfRhh3r+pqGO1sk5WEw2lX1a87KlvGNJHqbDXb/Q2WS0
 a8KVBUu5uNUTL/wqukr2oLhtUX9CgZXK/FTzK/bsMSxR+O6kMR1wCcfUFrkxEshssqEq
 hM8wb3uo+7Q2hN1lxASGENXmgIEEYlfrlUiRcNCuz7+H17AnhoM8HVnGlOZi0zPAMUlC
 a3R6sckRPqo6DFgSmffiQK4lWf2tzXJOcCMtIp4D6XVYExgCV+bQWbnXU9DhHYxmTg4w
 D15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973601; x=1738578401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTJwfGzF9H+nXAFh4oKJlHlsOewOwWpsY8vG45m99Ks=;
 b=FJ00dDqMlmIQHz7x2A2/QijOek5NtyJAfCu/4eSyG3+30FnN+2HT6ZtuWouN73esGy
 0u8npyrhmVlqY/caZP6nGfCqCPaFuLp/2feOvpBPXZYhRr1o2RDPdqsi+QifcjESIsyy
 mxJ8rN6N9EdOn3K10y2oWuJ6pgadIcsugQ0efY7bcu13XHRgCpK2XFQiYo1a8nS+3ZGH
 9UNT6RBSGywnaCElprqEFkH1LSGYcWOSFJLPAv6IYkSZNuzgv3nO4A1ftcp8cuMEQdeU
 PMycSNzGfnyIkYZUrpkpduM9vg8I3WztCfXmuWW7YMa86TTsnK/Z0R8NXqeUVVT9JhCT
 S4YQ==
X-Gm-Message-State: AOJu0Ywsl3l9l9tl2RzN0M61REG/79G6C52f5fvRCCUpf8GTB3Xf0TI9
 VKWKN+8lC0NBTO6sgIBpsaz3ngwRcevgb1phJHPaigqkbIM6OjbfcAJ7YrTz0MH/IONcOoRfOMO
 id68=
X-Gm-Gg: ASbGncuJGiTKnuj722xebdsHTygjkUtGC1HBjS3vjfDBbgnM3dio4uMyHqlH/mCEWQR
 X99YiRVwTIAc+pbOAfF7pB80ENfXP1GcEk21kwZPLCopsM4x+EiFYTPPcAW8DWVgVSyVWdX6T7g
 bjcN9cmBYg2yVCx7/Ves+YJfXcKe01IHlaP/g7GQN50fAg6Kq2y+K948Mcjr6DRXkW2Lg92wyNe
 YeaSIjPGolvZ1wFNpaBZjDlgnDzpT6lT5akFL6eQp4T/6pV18VbZ+60wFiV1cBujji137fuc81l
 48+Pa2FnCmZTQn2vDF2HjFn3CRIVw3XU78G7pPxrrZRbdm32HbpgWeU=
X-Google-Smtp-Source: AGHT+IEkEdHw2WiX0AIWwABqon6HT9kV+m2SWV6R8k0T0BGDgM5OOsS8u+Xl2dRwjFNLRwaOA7hMJg==
X-Received: by 2002:a05:6000:104d:b0:386:3803:bbd5 with SMTP id
 ffacd0b85a97d-38bf57c901bmr29440191f8f.45.1737973600728; 
 Mon, 27 Jan 2025 02:26:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764d3sm10793277f8f.19.2025.01.27.02.26.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/15] target/ppc: Move TCG specific exception handlers to
 tcg-excp_helper.c
Date: Mon, 27 Jan 2025 11:26:08 +0100
Message-ID: <20250127102620.39159-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Move the TCGCPUOps handlers to a new unit: tcg-excp_helper.c,
only built when TCG is selected.

See in target/ppc/cpu_init.c:

    #ifdef CONFIG_TCG
    static const TCGCPUOps ppc_tcg_ops = {
      ...
      .do_unaligned_access = ppc_cpu_do_unaligned_access,
      .do_transaction_failed = ppc_cpu_do_transaction_failed,
      .debug_excp_handler = ppc_cpu_debug_excp_handler,
      .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
      .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
    };
    #endif /* CONFIG_TCG */

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c     | 173 ------------------------------
 target/ppc/tcg-excp_helper.c | 202 +++++++++++++++++++++++++++++++++++
 target/ppc/meson.build       |   1 +
 3 files changed, 203 insertions(+), 173 deletions(-)
 create mode 100644 target/ppc/tcg-excp_helper.c

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7ed4bbec035..b05eb7f5aec 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3144,178 +3144,5 @@ void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
     raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
 }
 
-void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
-                                 MMUAccessType access_type,
-                                 int mmu_idx, uintptr_t retaddr)
-{
-    CPUPPCState *env = cpu_env(cs);
-    uint32_t insn;
-
-    /* Restore state and reload the insn we executed, for filling in DSISR.  */
-    cpu_restore_state(cs, retaddr);
-    insn = ppc_ldl_code(env, env->nip);
-
-    switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_4xx:
-        env->spr[SPR_40x_DEAR] = vaddr;
-        break;
-    case POWERPC_MMU_BOOKE:
-    case POWERPC_MMU_BOOKE206:
-        env->spr[SPR_BOOKE_DEAR] = vaddr;
-        break;
-    default:
-        env->spr[SPR_DAR] = vaddr;
-        break;
-    }
-
-    cs->exception_index = POWERPC_EXCP_ALIGN;
-    env->error_code = insn & 0x03FF0000;
-    cpu_loop_exit(cs);
-}
-
-void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-                                   vaddr vaddr, unsigned size,
-                                   MMUAccessType access_type,
-                                   int mmu_idx, MemTxAttrs attrs,
-                                   MemTxResult response, uintptr_t retaddr)
-{
-    CPUPPCState *env = cpu_env(cs);
-
-    switch (env->excp_model) {
-#if defined(TARGET_PPC64)
-    case POWERPC_EXCP_POWER8:
-    case POWERPC_EXCP_POWER9:
-    case POWERPC_EXCP_POWER10:
-    case POWERPC_EXCP_POWER11:
-        /*
-         * Machine check codes can be found in processor User Manual or
-         * Linux or skiboot source.
-         */
-        if (access_type == MMU_DATA_LOAD) {
-            env->spr[SPR_DAR] = vaddr;
-            env->spr[SPR_DSISR] = PPC_BIT(57);
-            env->error_code = PPC_BIT(42);
-
-        } else if (access_type == MMU_DATA_STORE) {
-            /*
-             * MCE for stores in POWER is asynchronous so hardware does
-             * not set DAR, but QEMU can do better.
-             */
-            env->spr[SPR_DAR] = vaddr;
-            env->error_code = PPC_BIT(36) | PPC_BIT(43) | PPC_BIT(45);
-            env->error_code |= PPC_BIT(42);
-
-        } else { /* Fetch */
-            /*
-             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
-             * the instruction, so that must always be clear for fetches.
-             */
-            env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
-        }
-        break;
-#endif
-    default:
-        /*
-         * TODO: Check behaviour for other CPUs, for now do nothing.
-         * Could add a basic MCE even if real hardware ignores.
-         */
-        return;
-    }
-
-    cs->exception_index = POWERPC_EXCP_MCHECK;
-    cpu_loop_exit_restore(cs, retaddr);
-}
-
-void ppc_cpu_debug_excp_handler(CPUState *cs)
-{
-#if defined(TARGET_PPC64)
-    CPUPPCState *env = cpu_env(cs);
-
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        if (cs->watchpoint_hit) {
-            if (cs->watchpoint_hit->flags & BP_CPU) {
-                env->spr[SPR_DAR] = cs->watchpoint_hit->hitaddr;
-                env->spr[SPR_DSISR] = PPC_BIT(41);
-                cs->watchpoint_hit = NULL;
-                raise_exception(env, POWERPC_EXCP_DSI);
-            }
-            cs->watchpoint_hit = NULL;
-        } else if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
-            raise_exception_err(env, POWERPC_EXCP_TRACE,
-                                PPC_BIT(33) | PPC_BIT(43));
-        }
-    }
-#endif
-}
-
-bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
-{
-#if defined(TARGET_PPC64)
-    CPUPPCState *env = cpu_env(cs);
-
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        target_ulong priv;
-
-        priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
-        switch (priv) {
-        case 0x1: /* problem */
-            return env->msr & ((target_ulong)1 << MSR_PR);
-        case 0x2: /* supervisor */
-            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
-                    !(env->msr & ((target_ulong)1 << MSR_HV)));
-        case 0x3: /* hypervisor */
-            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
-                     (env->msr & ((target_ulong)1 << MSR_HV)));
-        default:
-            g_assert_not_reached();
-        }
-    }
-#endif
-
-    return false;
-}
-
-bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
-{
-#if defined(TARGET_PPC64)
-    CPUPPCState *env = cpu_env(cs);
-
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        if (wp == env->dawr0_watchpoint) {
-            uint32_t dawrx = env->spr[SPR_DAWRX0];
-            bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
-            bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
-            bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
-            bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
-            bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
-
-            if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
-                return false;
-            } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
-                return false;
-            } else if (!sv) {
-                return false;
-            }
-
-            if (!wti) {
-                if (env->msr & ((target_ulong)1 << MSR_DR)) {
-                    if (!wt) {
-                        return false;
-                    }
-                } else {
-                    if (wt) {
-                        return false;
-                    }
-                }
-            }
-
-            return true;
-        }
-    }
-#endif
-
-    return false;
-}
-
 #endif /* !CONFIG_USER_ONLY */
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
new file mode 100644
index 00000000000..3402dbe05ee
--- /dev/null
+++ b/target/ppc/tcg-excp_helper.c
@@ -0,0 +1,202 @@
+/*
+ *  PowerPC exception emulation helpers for QEMU (TCG specific)
+ *
+ *  Copyright (c) 2003-2007 Jocelyn Mayer
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "exec/cpu_ldst.h"
+
+#include "hw/ppc/ppc.h"
+#include "internal.h"
+#include "cpu.h"
+#include "trace.h"
+
+#ifndef CONFIG_USER_ONLY
+
+void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+    CPUPPCState *env = cpu_env(cs);
+    uint32_t insn;
+
+    /* Restore state and reload the insn we executed, for filling in DSISR.  */
+    cpu_restore_state(cs, retaddr);
+    insn = ppc_ldl_code(env, env->nip);
+
+    switch (env->mmu_model) {
+    case POWERPC_MMU_SOFT_4xx:
+        env->spr[SPR_40x_DEAR] = vaddr;
+        break;
+    case POWERPC_MMU_BOOKE:
+    case POWERPC_MMU_BOOKE206:
+        env->spr[SPR_BOOKE_DEAR] = vaddr;
+        break;
+    default:
+        env->spr[SPR_DAR] = vaddr;
+        break;
+    }
+
+    cs->exception_index = POWERPC_EXCP_ALIGN;
+    env->error_code = insn & 0x03FF0000;
+    cpu_loop_exit(cs);
+}
+
+void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                   vaddr vaddr, unsigned size,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, MemTxAttrs attrs,
+                                   MemTxResult response, uintptr_t retaddr)
+{
+    CPUPPCState *env = cpu_env(cs);
+
+    switch (env->excp_model) {
+#if defined(TARGET_PPC64)
+    case POWERPC_EXCP_POWER8:
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
+        /*
+         * Machine check codes can be found in processor User Manual or
+         * Linux or skiboot source.
+         */
+        if (access_type == MMU_DATA_LOAD) {
+            env->spr[SPR_DAR] = vaddr;
+            env->spr[SPR_DSISR] = PPC_BIT(57);
+            env->error_code = PPC_BIT(42);
+
+        } else if (access_type == MMU_DATA_STORE) {
+            /*
+             * MCE for stores in POWER is asynchronous so hardware does
+             * not set DAR, but QEMU can do better.
+             */
+            env->spr[SPR_DAR] = vaddr;
+            env->error_code = PPC_BIT(36) | PPC_BIT(43) | PPC_BIT(45);
+            env->error_code |= PPC_BIT(42);
+
+        } else { /* Fetch */
+            /*
+             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
+             * the instruction, so that must always be clear for fetches.
+             */
+            env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
+        }
+        break;
+#endif
+    default:
+        /*
+         * TODO: Check behaviour for other CPUs, for now do nothing.
+         * Could add a basic MCE even if real hardware ignores.
+         */
+        return;
+    }
+
+    cs->exception_index = POWERPC_EXCP_MCHECK;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+void ppc_cpu_debug_excp_handler(CPUState *cs)
+{
+#if defined(TARGET_PPC64)
+    CPUPPCState *env = cpu_env(cs);
+
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        if (cs->watchpoint_hit) {
+            if (cs->watchpoint_hit->flags & BP_CPU) {
+                env->spr[SPR_DAR] = cs->watchpoint_hit->hitaddr;
+                env->spr[SPR_DSISR] = PPC_BIT(41);
+                cs->watchpoint_hit = NULL;
+                raise_exception(env, POWERPC_EXCP_DSI);
+            }
+            cs->watchpoint_hit = NULL;
+        } else if (cpu_breakpoint_test(cs, env->nip, BP_CPU)) {
+            raise_exception_err(env, POWERPC_EXCP_TRACE,
+                                PPC_BIT(33) | PPC_BIT(43));
+        }
+    }
+#endif
+}
+
+bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
+{
+#if defined(TARGET_PPC64)
+    CPUPPCState *env = cpu_env(cs);
+
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        target_ulong priv;
+
+        priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
+        switch (priv) {
+        case 0x1: /* problem */
+            return env->msr & ((target_ulong)1 << MSR_PR);
+        case 0x2: /* supervisor */
+            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
+                    !(env->msr & ((target_ulong)1 << MSR_HV)));
+        case 0x3: /* hypervisor */
+            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
+                     (env->msr & ((target_ulong)1 << MSR_HV)));
+        default:
+            g_assert_not_reached();
+        }
+    }
+#endif
+
+    return false;
+}
+
+bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+{
+#if defined(TARGET_PPC64)
+    CPUPPCState *env = cpu_env(cs);
+
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        if (wp == env->dawr0_watchpoint) {
+            uint32_t dawrx = env->spr[SPR_DAWRX0];
+            bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
+            bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
+            bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+            bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+            bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
+
+            if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
+                return false;
+            } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
+                return false;
+            } else if (!sv) {
+                return false;
+            }
+
+            if (!wti) {
+                if (env->msr & ((target_ulong)1 << MSR_DR)) {
+                    if (!wt) {
+                        return false;
+                    }
+                } else {
+                    if (wt) {
+                        return false;
+                    }
+                }
+            }
+
+            return true;
+        }
+    }
+#endif
+
+    return false;
+}
+
+#endif /* !CONFIG_USER_ONLY */
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index db3b7a0c33b..8eed1fa40ca 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -14,6 +14,7 @@ ppc_ss.add(when: 'CONFIG_TCG', if_true: files(
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
+  'tcg-excp_helper.c',
   'timebase_helper.c',
   'translate.c',
   'power8-pmu.c',
-- 
2.47.1


