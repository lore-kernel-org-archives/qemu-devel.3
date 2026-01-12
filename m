Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC1DC9EC86
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHmn-00022W-PE; Mon, 12 Jan 2026 08:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlW-0001Xp-H5
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlU-0002YF-Eb
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+Moj1HKTWbYuxZ++iDn1wHHhWRGuDIZAFTVME3YgBU=;
 b=QwUCLlKU4Gck0kEnT+A6YOOxJ+IYDDhWaJjsfjEXHBnW4ww+9tfPpd5Jth/5qmuubvLwzI
 xw6Q/RBCauWNoywbveXMY1wi7u7D9QgGL8CapxGkyLZ/7cG6FKcQXaL6rdZnYGvwvWaazd
 E3zVaZQuL7AHfBOo+WLam+3MJMGEHoI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-eop_FrtpN4WKxE2_R66PsA-1; Mon,
 12 Jan 2026 08:15:22 -0500
X-MC-Unique: eop_FrtpN4WKxE2_R66PsA-1
X-Mimecast-MFC-AGG-ID: eop_FrtpN4WKxE2_R66PsA_1768223720
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68FD818005B2; Mon, 12 Jan 2026 13:15:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73CF130001A7; Mon, 12 Jan 2026 13:15:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/15] target/s390x: Restrict WatchPoint API to TCG
Date: Mon, 12 Jan 2026 14:14:50 +0100
Message-ID: <20260112131457.67128-9-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

By inverting the 'tcg_enabled()' check in s390_cpu_set_psw()
we can let the compiler elide the s390_cpu_recompute_watchpoints()
call when TCG is not available. Move this function -- along with
s390x_cpu_debug_excp_handler() which was introduced in the same
commit 311918b979c ("target-s390x: PER storage-alteration event
support") -- to a TCG specific file to avoid compiling dead code
on KVM. This restricts the WatchPoint API calls to TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260107130807.69870-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
index 6af7446fd9f..cd472d38be7 100644
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
index 00000000000..50d2853d443
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
+         * and MVCS instructions are not used.
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


