Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E4CFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTH6-0000Yn-QL; Wed, 07 Jan 2026 08:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTGw-0000Ot-Gp
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:22 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTGs-0008ME-QF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so13821955e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791297; x=1768396097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkuAkGIrYoWFyIDgqIBN9F37U9+A9epUfwbwl3z+CUI=;
 b=d4m1S82w0vYlJxDO9ApvnOYyvwHNCVKVE4NHaLY6AkaA82Q2w7L2S9/Y3KOyKBVKQt
 rQfGj79mxZXBD+QoD5wcLAgjz058S+WDrhpfE7EHp7d4NU4Fwz9VSiRemP9ZzLW2cUvA
 qgnqKCpd+GUWhqBDh9HQXeGG+oV6MxnuvWVa5q/dd1zdmYt9QyOkT4uCkQVv2iHDqx/X
 1gjrOIQj34xCq2G01/VkH85P0XUlB0DDuKnyTfcIkAbvlsdfAtaW7Z7HHc2QAgcXCoas
 hTMsx2NrZkvBufIFPjeyURG+DhWSc3x+biSwXvuEWs96WvH43bDBO1ssyNQThJ767+vo
 UPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791297; x=1768396097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mkuAkGIrYoWFyIDgqIBN9F37U9+A9epUfwbwl3z+CUI=;
 b=aqW7TNyeT4RiylpHR4hijp0bKgZdAMq+OFT0q92mEIQN3kj/G01L3G7lW+kUKz9mwl
 0Iv6N3YeVs0d75PH1lhB/QwikmhUIK92LhNP0XkEs9WwVXzPC/6Lu5/Wv/GN+c2xmG5A
 z2oBvJQjTxbEn5nieAcYNt0YFYpb6I65k5vxuOAoxoW0jXzQ9v/20bhz2iaRCYFJ6Syg
 RHjXIgKXH+tfKPAnl1ax6rlkXe/s2RXjwRrktgh8u2ht9RMHz8UqqjJFpM4aYGztUXbG
 BBHCfFlcoRLRy7d/7jT+jgQO+DwPkSZYyahJOYZyzyGhYjmL/+gipZJKh0xGKZQ2E5Ue
 JGDw==
X-Gm-Message-State: AOJu0YxcoGWTmYWjFePpIMRhOfnePk1/M2ro1/lvDpbMlVS0Z8gQlNhH
 RyahI0LjHxUcfNGgBJSrZ5r02XRGLhR8tHKi2mcFrIRoFeSbi+CzQSmkvr3cYGbB2/gKEudCjM2
 AGk+zox6GyQ==
X-Gm-Gg: AY/fxX6CiSmdJ88mdfmYkkYsBdIuYLGqz61/J9fiAzfYfM7gLrAyWfECu8AeKm1YJq5
 ew9qHEKYeIh7brLnSAJ+zvBMjeBLVJCmb/6EUvho8Zm2mcPIvyWhPSOvYK6R5XCB9Rh236a4cEj
 WAsFvldwlaZ7BH63x4qVWI54Y5yeFi7DJI25eEzFOwtfTZF8IJP99oIULe3fVCgnXKQ95naoSEQ
 nFigKX9OF4wA3nQntOmJlLtGWo6fYvgyy0lkY2a8Df7E3rpmZ8XWRsEmiszBGe/rdeQzIj91E3z
 Y1UPZhAgIjw3OvFwkY2h0Y+U6/pSf8YY507ffh4GyX2kT69oY9mP34Y8djtJsTLErWXLUSveI/1
 V6UHbYxa3mGGwcDqDKs+irGnvpRhHvzY4sAFDVMs8ecvLDgdYQmFbhWRDK5IMHjoO5GA9OwRF+J
 UjSZUM6o29MLDwJMWlFsbGpyJBFsMwWGItXybWtbveQO4mYoNQ3KDb4q8LoDnGHexIUo4ut+w=
X-Google-Smtp-Source: AGHT+IGIE3yR0kLLyXHjtztnslOGCnLgJbzMCSblwxgjTHE0NeqPrgnr1d+hENwFoZ7Drqzb7wV6xg==
X-Received: by 2002:a05:600c:1d0c:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-47d84b4093cmr26647095e9.25.1767791296772; 
 Wed, 07 Jan 2026 05:08:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f661a03sm105305525e9.13.2026.01.07.05.08.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 01/18] target/s390x: Restrict WatchPoint API to TCG
Date: Wed,  7 Jan 2026 14:07:49 +0100
Message-ID: <20260107130807.69870-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

By inverting the 'tcg_enabled()' check in s390_cpu_set_psw()
we can let the compiler elide the s390_cpu_recompute_watchpoints()
call when TCG is not available. Move this function -- along with
s390x_cpu_debug_excp_handler() which was introduced in the same
commit 311918b979c ("target-s390x: PER storage-alteration event
support") -- to a TCG specific file to avoid compiling dead code
on KVM. This restricts the WatchPoint API calls to TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h  |  2 -
 target/s390x/tcg/tcg_s390x.h   |  5 ++
 target/s390x/cpu.c             | 30 ++++++------
 target/s390x/helper.c          | 38 ---------------
 target/s390x/tcg/debug.c       | 85 ++++++++++++++++++++++++++++++++++
 target/s390x/tcg/excp_helper.c | 32 -------------
 target/s390x/tcg/meson.build   |  3 ++
 7 files changed, 108 insertions(+), 87 deletions(-)
 create mode 100644 target/s390x/tcg/debug.c

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 9691366ec91..a4b54dc441c 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -259,7 +259,6 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 
 
 /* excp_helper.c */
-void s390x_cpu_debug_excp_handler(CPUState *cs);
 void s390_cpu_do_interrupt(CPUState *cpu);
 bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
@@ -317,7 +316,6 @@ void s390_cpu_gdb_init(CPUState *cs);
 void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void do_restart_interrupt(CPUS390XState *env);
 #ifndef CONFIG_USER_ONLY
-void s390_cpu_recompute_watchpoints(CPUState *cs);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 void s390_handle_wait(S390CPU *cpu);
diff --git a/target/s390x/tcg/tcg_s390x.h b/target/s390x/tcg/tcg_s390x.h
index 78558912f99..7c8aede80d2 100644
--- a/target/s390x/tcg/tcg_s390x.h
+++ b/target/s390x/tcg/tcg_s390x.h
@@ -21,4 +21,9 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
 G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
                                           uintptr_t ra);
 
+#ifndef CONFIG_USER_ONLY
+void s390_cpu_recompute_watchpoints(CPUState *cs);
+void s390x_cpu_debug_excp_handler(CPUState *cs);
+#endif
+
 #endif /* TCG_S390X_H */
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 6c4198eb1b1..f68b288e364 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -40,6 +40,7 @@
 #include "system/reset.h"
 #endif
 #include "hw/s390x/cpu-topology.h"
+#include "tcg/tcg_s390x.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -74,26 +75,25 @@ void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
     env->psw.mask = mask;
 
     /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
-    if (!tcg_enabled()) {
-        return;
-    }
-    env->cc_op = (mask >> 44) & 3;
+    if (tcg_enabled()) {
+        env->cc_op = (mask >> 44) & 3;
 
 #ifndef CONFIG_USER_ONLY
-    if (is_early_exception_psw(mask, addr)) {
-        env->int_pgm_ilen = 0;
-        trigger_pgm_exception(env, PGM_SPECIFICATION);
-        return;
-    }
+        if (is_early_exception_psw(mask, addr)) {
+            env->int_pgm_ilen = 0;
+            trigger_pgm_exception(env, PGM_SPECIFICATION);
+            return;
+        }
 
-    if ((old_mask ^ mask) & PSW_MASK_PER) {
-        s390_cpu_recompute_watchpoints(env_cpu(env));
-    }
+        if ((old_mask ^ mask) & PSW_MASK_PER) {
+            s390_cpu_recompute_watchpoints(env_cpu(env));
+        }
 
-    if (mask & PSW_MASK_WAIT) {
-        s390_handle_wait(env_archcpu(env));
-    }
+        if (mask & PSW_MASK_WAIT) {
+            s390_handle_wait(env_archcpu(env));
+        }
 #endif
+    }
 }
 
 uint64_t s390_cpu_get_psw_mask(CPUS390XState *env)
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 184428c6d9d..8d1e03f6768 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -143,41 +143,3 @@ void do_restart_interrupt(CPUS390XState *env)
 
     s390_cpu_set_psw(env, mask, addr);
 }
-
-void s390_cpu_recompute_watchpoints(CPUState *cs)
-{
-    const int wp_flags = BP_CPU | BP_MEM_WRITE | BP_STOP_BEFORE_ACCESS;
-    CPUS390XState *env = cpu_env(cs);
-
-    /* We are called when the watchpoints have changed. First
-       remove them all.  */
-    cpu_watchpoint_remove_all(cs, BP_CPU);
-
-    /* Return if PER is not enabled */
-    if (!(env->psw.mask & PSW_MASK_PER)) {
-        return;
-    }
-
-    /* Return if storage-alteration event is not enabled.  */
-    if (!(env->cregs[9] & PER_CR9_EVENT_STORE)) {
-        return;
-    }
-
-    if (env->cregs[10] == 0 && env->cregs[11] == -1LL) {
-        /* We can't create a watchoint spanning the whole memory range, so
-           split it in two parts.   */
-        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, NULL);
-        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, NULL);
-    } else if (env->cregs[10] > env->cregs[11]) {
-        /* The address range loops, create two watchpoints.  */
-        cpu_watchpoint_insert(cs, env->cregs[10], -env->cregs[10],
-                              wp_flags, NULL);
-        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, NULL);
-
-    } else {
-        /* Default case, create a single watchpoint.  */
-        cpu_watchpoint_insert(cs, env->cregs[10],
-                              env->cregs[11] - env->cregs[10] + 1,
-                              wp_flags, NULL);
-    }
-}
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
new file mode 100644
index 00000000000..01fd4b67442
--- /dev/null
+++ b/target/s390x/tcg/debug.c
@@ -0,0 +1,85 @@
+/*
+ * QEMU S/390 debug routines
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/breakpoint.h"
+#include "exec/watchpoint.h"
+#include "target/s390x/cpu.h"
+#include "target/s390x/s390x-internal.h"
+#include "tcg_s390x.h"
+
+void s390_cpu_recompute_watchpoints(CPUState *cs)
+{
+    const int wp_flags = BP_CPU | BP_MEM_WRITE | BP_STOP_BEFORE_ACCESS;
+    CPUS390XState *env = cpu_env(cs);
+
+    /* We are called when the watchpoints have changed. First
+       remove them all.  */
+    cpu_watchpoint_remove_all(cs, BP_CPU);
+
+    /* Return if PER is not enabled */
+    if (!(env->psw.mask & PSW_MASK_PER)) {
+        return;
+    }
+
+    /* Return if storage-alteration event is not enabled.  */
+    if (!(env->cregs[9] & PER_CR9_EVENT_STORE)) {
+        return;
+    }
+
+    if (env->cregs[10] == 0 && env->cregs[11] == -1LL) {
+        /* We can't create a watchoint spanning the whole memory range, so
+           split it in two parts.   */
+        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, NULL);
+        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, NULL);
+    } else if (env->cregs[10] > env->cregs[11]) {
+        /* The address range loops, create two watchpoints.  */
+        cpu_watchpoint_insert(cs, env->cregs[10], -env->cregs[10],
+                              wp_flags, NULL);
+        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, NULL);
+
+    } else {
+        /* Default case, create a single watchpoint.  */
+        cpu_watchpoint_insert(cs, env->cregs[10],
+                              env->cregs[11] - env->cregs[10] + 1,
+                              wp_flags, NULL);
+    }
+}
+
+void s390x_cpu_debug_excp_handler(CPUState *cs)
+{
+    CPUS390XState *env = cpu_env(cs);
+    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
+
+    if (wp_hit && wp_hit->flags & BP_CPU) {
+        /*
+         * FIXME: When the storage-alteration-space control bit is set,
+         * the exception should only be triggered if the memory access
+         * is done using an address space with the storage-alteration-event
+         * bit set.  We have no way to detect that with the current
+         * watchpoint code.
+         */
+        cs->watchpoint_hit = NULL;
+
+        env->per_address = env->psw.addr;
+        env->per_perc_atmid |= PER_CODE_EVENT_STORE | get_per_atmid(env);
+        /*
+         * FIXME: We currently no way to detect the address space used
+         * to trigger the watchpoint.  For now just consider it is the
+         * current default ASC. This turn to be true except when MVCP
+         * and MVCS instrutions are not used.
+         */
+        env->per_perc_atmid |= env->psw.mask & (PSW_MASK_ASC) >> 46;
+
+        /*
+         * Remove all watchpoints to re-execute the code.  A PER exception
+         * will be triggered, it will call s390_cpu_set_psw which will
+         * recompute the watchpoints.
+         */
+        cpu_watchpoint_remove_all(cs, BP_CPU);
+        cpu_loop_exit_noexc(cs);
+    }
+}
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index d4a096f5998..019eb4fba1f 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,7 +24,6 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
-#include "exec/watchpoint.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
@@ -607,37 +606,6 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-void s390x_cpu_debug_excp_handler(CPUState *cs)
-{
-    CPUS390XState *env = cpu_env(cs);
-    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
-
-    if (wp_hit && wp_hit->flags & BP_CPU) {
-        /* FIXME: When the storage-alteration-space control bit is set,
-           the exception should only be triggered if the memory access
-           is done using an address space with the storage-alteration-event
-           bit set.  We have no way to detect that with the current
-           watchpoint code.  */
-        cs->watchpoint_hit = NULL;
-
-        env->per_address = env->psw.addr;
-        env->per_perc_atmid |= PER_CODE_EVENT_STORE | get_per_atmid(env);
-        /* FIXME: We currently no way to detect the address space used
-           to trigger the watchpoint.  For now just consider it is the
-           current default ASC. This turn to be true except when MVCP
-           and MVCS instrutions are not used.  */
-        env->per_perc_atmid |= env->psw.mask & (PSW_MASK_ASC) >> 46;
-
-        /*
-         * Remove all watchpoints to re-execute the code.  A PER exception
-         * will be triggered, it will call s390_cpu_set_psw which will
-         * recompute the watchpoints.
-         */
-        cpu_watchpoint_remove_all(cs, BP_CPU);
-        cpu_loop_exit_noexc(cs);
-    }
-}
-
 void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr)
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index ee4e8fec77c..515cb8b473d 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -12,3 +12,6 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
+s390x_system_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'debug.c',
+))
-- 
2.52.0


