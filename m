Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67138C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzG2-0007lU-6r; Tue, 11 Mar 2025 09:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzE1-00051Z-OM; Tue, 11 Mar 2025 09:00:51 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDw-00008I-CB; Tue, 11 Mar 2025 09:00:49 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so10439391a91.2; 
 Tue, 11 Mar 2025 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698042; x=1742302842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REbqXCfa8pgvPbVQj8PRaR6rcvUlPevWe8sa0CWfROg=;
 b=Rq4+J3WxtIk/Pxbh8GjHnUb0rotO7F5rQ/hRuDMRKfXDvwKgDid3bafvcx4EkuV37P
 rJUf58uNEYrmzWJrvSG0QPSxg9reSmuZH1n8BfHdvaGvYSDVx5iPOAMatnjFBG/H8ioK
 0vIiFjcqhq49+4Ia6J8APi26x/x6caqw44Zh4lM8ID8NPcbmFUB01h/FoeoZDiDecnlF
 PVpA1geBsIh1QYWd7LbJHmdBtfTgeiQweXJduIfj5oK7zzGstxTlurjnQRsEAfCbpMCz
 xIlRHrE1ZD7+Emf6wVOzZiVIWkm2MNd8NdmFdSq3H2oatFOouKrGEHt0TE2/9SxAdF7a
 v6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698042; x=1742302842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REbqXCfa8pgvPbVQj8PRaR6rcvUlPevWe8sa0CWfROg=;
 b=f+ioq74YE8d0SJ9tinrQ9Vj/iwuppYO5GnG16jv/hELYTCZL/7PXqUmvgemiI1L28L
 heDQjvcm7OqhxG+d1Lz2VGQafXTafL57wTy8pGsluCnPBMndMuP55ckYvqQnb5ACvIRr
 UgiiOYSOrmV/oy3gokTyzH+eXZrp//XPyA0RMGdkaxYrIMOqhMMx3ZzpHm77G44wZL6f
 9T3wF73V79KfaOg8u1gOV3annIs3bRr4xE8A21nufDMT752epf5e1OeC+Esd/90QhHWk
 dc1z35+aQuMdRzLK36WN5eYN1s4Z8UJzoKJz0iQP9QOLO6e1mkvDa9YZf/D2docTl41O
 IOrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS8jckMR1M4XwfDmMZkT1fbSUShQavkca5BO1aq6l5Xlsczr+VJXxPmD6YAbuI1DkzPQX8XBYutQ==@nongnu.org
X-Gm-Message-State: AOJu0YzZLcKbxgdKdJO1yFnALQiHadoiIFFCR8vsSYkDjl3riLa4JOPu
 1CB//EukC+cBqksXQMDaldK5NcqGZ4zVXm8qOlbG/goP6NEt0i8oHgKqPQ==
X-Gm-Gg: ASbGncuY0vpT1EUz1p1xO/ca9HGFXJ93F5iPr4nmFOWSWz5RBkvAyCb4ORsnQER7ZfH
 uFRVPKLkDLktYd6+MIsenrsUU8ZuTejUyxhMfAEPqIGSr0GFT1yJmSAHkazjJB4L5D0/urOwFhg
 Q2wOBTBvnk6KuXQR4XgViTXhO14neLWO5QCVFZMqGzZodrxdqBw6JP99vCWwYT1yaSIAnSxuOtf
 QFfhS2y5Rpw3EofPEvOTc0JJy75RGhV/hMtp0+j0sRjBKDQ2MW0Wwni2rv7EcpPf8eCPdESDlIj
 gjC8w7c0vruM4SC+dhy5jzcd+tBeOuFMzeIj+QXQecvta4jYR1g=
X-Google-Smtp-Source: AGHT+IFe4gxagE/tvsGdhOBDbnrU7b1D6VEvAbxeb6U5V91Du+JBsNh86syAphhju8NEfWrAsmwL2A==
X-Received: by 2002:a17:90b:3b52:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-2ff7ce451e3mr25660168a91.6.1741698041806; 
 Tue, 11 Mar 2025 06:00:41 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 44/72] target/ppc: Move TCG specific exception handlers to
 tcg-excp_helper.c
Date: Tue, 11 Mar 2025 22:57:38 +1000
Message-ID: <20250311125815.903177-45-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-5-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c     | 173 ------------------------------
 target/ppc/meson.build       |   1 +
 target/ppc/tcg-excp_helper.c | 202 +++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 173 deletions(-)
 create mode 100644 target/ppc/tcg-excp_helper.c

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7ed4bbec03..b05eb7f5ae 100644
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
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index db3b7a0c33..8eed1fa40c 100644
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
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
new file mode 100644
index 0000000000..3402dbe05e
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
-- 
2.47.1


