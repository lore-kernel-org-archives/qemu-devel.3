Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B480C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Bm-0004uk-Sy; Thu, 23 Jan 2025 16:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bl-0004tQ-2c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bi-0002l1-MQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:36 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436202dd730so10299285e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669393; x=1738274193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTJwfGzF9H+nXAFh4oKJlHlsOewOwWpsY8vG45m99Ks=;
 b=Q6AeO++BTcaWnHF3acIqD/DxewMLrR+16WkIy1ptAf5acpuxXKW+B9eBU615aolhii
 gIQncUtCxXCuAOYLUY2Q7UmYrQhDIBsYKAcC+40kJYRN7SM9YQwCheCcv8TO9pYWa//P
 o/JdSInBMn7E4txNAi/5tGmDtXiLDqaY5UUO+V1jlYulYkSq4fL5dR2YyjqeL7t5NLYB
 U6gDhM89QejvDl56Yp8Up2V7RQLPARp3lN8vyfnEx+pIuEwKLs4MnrV8Pv1GgSQLc5ZV
 OJRD3BumVezxf5GcG3Ub21S+W3WkRVEkJZc54D+9O5Gn2/k8CIRBWYdnWqlanqG6TOuC
 yDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669393; x=1738274193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTJwfGzF9H+nXAFh4oKJlHlsOewOwWpsY8vG45m99Ks=;
 b=g3Yn3jY+0DMpZe5Y6WlVWkaSHK8C/FKG2UJur7Oyl9BClu4zL5/tR5q1/Zgox3833Z
 4ETwCpngT9DkaOSo3Y4FjY3vva1YsNVQxM0KloJiwMZZblXTP9tV6NfYn7uKqB96RF07
 wIPsWzriPv55F6wWZLaHCyz1m7LcRXrN4kZebs10aBQ7J8xphjirVgAdlRAZ/U+ODbyP
 j1Zil4bUpLhRcEUKMAEQCr1CiDkkq9OOfk8FJk8ZFTXFr0vjB8EIDXq/YrG8iwzdxTAg
 v2r8dKOrj2Vj3HgRhAtPm6QQXuQlMhIeUve6jnOPy9qnVE0efJfABm59dA9p1YKBATw2
 6tTA==
X-Gm-Message-State: AOJu0YwoYgokfOledqSFAyjVlQJP7L6WtCzcUT09qbYfljNDYqw7C570
 6nC2FrwrOH+T8c/CrJDEBlGALVmkFqNbLAe6nwk88iwZZBQLrATtA5WWVXhBBvN9xMP0rZJBm/r
 54xc=
X-Gm-Gg: ASbGncs1Z6RMsCkzw4ZzE90tCaJc2bZeZ1oYrhlGf+lyM0HZ0N6WoAA5gyKEUEV3EwG
 Hala9EegnA/u/SJbzCFtVoZx3jk+8c42T4sA7z2jbfdllWBmvgp2+sAAiaDq6keHosdr7CfqSgP
 pj1Prj5KLiB3RozpbJMwu74WLh5jEr3efSZSiIGDoinAZI97eFs98aq32y6pU1ekNiIqBi5LjTE
 TTnVYlCYicDoH/JGar5pJIUsAAgljq9W/6R7Xw4IE9gx7PeNPUw1jUdYcp4KNfkALOiWxzWSZLA
 tR3lRofVIri50sqy3Ck47Eiwj11c7FbTIrg5ZpLLApRO3HLNiHe8Xfw=
X-Google-Smtp-Source: AGHT+IHRk1ci3cphUxm5subnkR+MHr58uObFbzHgejoDzBCmzrCFgf09BfR3NxEzaRaop6hTCxpmWA==
X-Received: by 2002:a05:600c:3d96:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-43891439dfdmr252175745e9.23.1737669392560; 
 Thu, 23 Jan 2025 13:56:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f25csm5050725e9.1.2025.01.23.13.56.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/15] target/ppc: Move TCG specific exception handlers to
 tcg-excp_helper.c
Date: Thu, 23 Jan 2025 22:55:58 +0100
Message-ID: <20250123215609.30432-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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


