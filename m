Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7B3C44502
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdO-0006we-7k; Sun, 05 Jul 2026 00:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcH-00053x-UQ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc0-0004G7-4Y
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cc80b585bfso2697525ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226266; x=1783831066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdKkkE70/EE7jPqdOPX8dqbb6Lk47OmxicsC019xmGU=;
 b=YIzea8O7PLPWcE7rz+AUn2pwzGc4UFKOD7USfzv7T/pKhMdYpVuzxM8UIPRCAO9fJ6
 xTteJQ/qLF8lL2Eo9qvHEmpCT/16j5vI2Jlu9wyZqnnfR3lUX3Yh5YteBqfE0PKQK1F9
 9MwOu9CSe9zi15hnC5gTeAOCO4tVeVKZ9wjr+dXrowdn5aOOB8XgC6fRCKptMtILDKHp
 hbelM+syY9kflzL7DWJIE/e208Zsd3JkzTc7ZAVEr1WActsQg9e2ZEiILBHpOKcq4rwI
 q5fM8Tmnh5DkwHHg0mizCHbVGdNwRLvJUv3cm5kxPIho84cWAK2+PouizuMypVfzkV6i
 OQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226266; x=1783831066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CdKkkE70/EE7jPqdOPX8dqbb6Lk47OmxicsC019xmGU=;
 b=E7niy2nJSFMa6WUHE/BRZP08drgmTOaL8Zo92PHbhyflEjykckRdIMcRAMV8flTMW/
 8SZjQ16DLYilrjFEd6nkXkAZ/O7GOhYpbQsHCmR0imJecNUQYkTDc80UeuPljjLQM6qt
 o2WaOE0QsrKdmpECEbNcVmTj45M8KlrYUReLwynVKejvprsQbLvG0f9ib7xcGc5fi3Ny
 GjYHn+kwR3ItPkH9N6ZmaWkCpW4uX+XnKKFWuvkHkqiEui9rAmoksvXqCvfxXWL4oLkM
 oSs4NSVPm4DpbiBrPKE8BDsqdBUavhckvQs2CjVHoWcKNaTskd6vjOxnvDVrVTNuAllw
 XuZA==
X-Gm-Message-State: AOJu0Yw0fqCFkwd7HNnXKxf6LYdq2sM7BqNc9TwpoiruYUHxfI4Wlh+g
 7l7o82Im/v7vrNUrpOGsU8eaBZWL8rcVhHbjZk8Hp7E+Dc9itQN3u9Y6rDIZB3D497r9SWCaD7K
 e2lpX
X-Gm-Gg: AfdE7clw2tYnk/2xaiiIrpsH1ZINq18HT1e+mMbyMxzsmQm023igeOoYXoGQPbY+QYf
 FSIUCgLO7OYrz+TGzxLaNJDYnJ6kGj+XnL8AQeHOrGQUwpiIsTMA2t2DfPZv2d4SYBxvUSjybOm
 3+fisPSLLLj0TjXec8VyD1KW3/PpxTCUBbu2eC7f93B8vPqaePylKivL5w4Mvfii2sE5wtcskoo
 H8PvApokc0w+gSylG/eRkR3nLbGmt+RcOsbsV1cDMnvVivT0uz4R5jdO/QhQ/Aw6qSnuHK4PqI8
 u6uEflytUW/8V+t3GxGYNXCsP5w/6EgTITnsTVlajcC2lgK0olwcqueOT+FI2lLRpB5rWDFgWSG
 bwNTJS2WftMjS9Krzqwm/rxmQ06b1283xo766fJf/W0S+KVj6/JFS4rI4d9RCIyHu+bvsIuf2G5
 s9bl/nxI/dLtI1LDomflg8zUjN3YqIOajCpygcyhrelgjhqVw=
X-Received: by 2002:a17:903:3c4b:b0:2ca:9d5a:8b6c with SMTP id
 d9443c01a7336-2cbb8367871mr53309605ad.5.1783226266188; 
 Sat, 04 Jul 2026 21:37:46 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 22/46] cpu: Use interval-tree for CPUWatchpoint
Date: Sat,  4 Jul 2026 21:37:01 -0700
Message-ID: <20260705043725.1373137-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Use a balanced binary tree rather than a simple list for watchpoints.
Using an interval tree makes it easy to probe for any overlapping address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h |   7 +-
 include/hw/core/cpu.h     |   3 +-
 accel/tcg/cpu-exec.c      |   8 +-
 accel/tcg/watchpoint.c    | 155 +++++++++++++++++++++-----------------
 hw/core/cpu-common.c      |   1 -
 system/watchpoint.c       |  43 ++++++-----
 target/arm/hyp_gdbstub.c  |   3 +-
 7 files changed, 119 insertions(+), 101 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 5f0025a3c9..3ea6e26fa4 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -9,7 +9,6 @@
 #define EXEC_BREAKPOINT_H
 
 #include "qemu/interval-tree.h"
-#include "qemu/queue.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
@@ -35,13 +34,11 @@ struct CPUBreakpoint {
 };
 
 struct CPUWatchpoint {
-    vaddr vaddr;
-    vaddr len;
+    IntervalTreeNode itree;
     vaddr hitaddr;
     MemTxAttrs hitattrs;
-    int flags; /* BP_* */
+    BreakpointFlags flags;
     unsigned id;
-    QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b6368c2c2f..ccfcab6a8a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -525,8 +525,7 @@ struct CPUState {
 
     /* ice debug support */
     IntervalTreeRoot breakpoints;
-
-    QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
+    IntervalTreeRoot watchpoints;
     CPUWatchpoint *watchpoint_hit;
 
     void *opaque;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5812cb57aa..24b72c358d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -682,10 +682,12 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    CPUWatchpoint *wp;
+    IntervalTreeNode *n;
 
-    if (!cpu->watchpoint_hit) {
-        QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+    for (n = interval_tree_iter_first(&cpu->watchpoints, 0, -1); n;
+         n = interval_tree_iter_next(n, 0, -1)) {
+        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+        if (wp != cpu->watchpoint_hit) {
             wp->flags &= ~BP_WATCHPOINT_HIT;
         }
     }
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 5ea66e9763..a7ce5fa9dd 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -30,38 +30,18 @@
 #include "hw/core/cpu.h"
 #include "internal-common.h"
 
-/*
- * Return true if this watchpoint address matches the specified
- * access (ie the address range covered by the watchpoint overlaps
- * partially or completely with the address range covered by the
- * access).
- */
-static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
-                                              vaddr addr, vaddr len)
-{
-    /*
-     * We know the lengths are non-zero, but a little caution is
-     * required to avoid errors in the case where the range ends
-     * exactly at the top of the address space and so addr + len
-     * wraps round to zero.
-     */
-    vaddr wpend = wp->vaddr + wp->len - 1;
-    vaddr addrend = addr + len - 1;
-
-    return !(addr > wpend || wp->vaddr > addrend);
-}
-
 /* Return flags for watchpoints that match addr + prot.  */
 BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
                                                vaddr addr, vaddr len)
 {
-    CPUWatchpoint *wp;
+    vaddr last = addr + len - 1;
     BreakpointFlags ret = 0;
+    IntervalTreeNode *n;
 
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (watchpoint_address_matches(wp, addr, len)) {
-            ret |= wp->flags;
-        }
+    for (n = interval_tree_iter_first(&cpu->watchpoints, addr, last); n;
+         n = interval_tree_iter_next(n, addr, last)) {
+        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+        ret |= wp->flags;
     }
     return ret;
 }
@@ -70,7 +50,10 @@ BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, BreakpointFlags flags, uintptr_t ra)
 {
-    CPUWatchpoint *wp;
+    vaddr last = addr + len - 1;
+    IntervalTreeNode *n;
+    CPUWatchpoint *found_wp = NULL;
+    bool have_cpu_wp = false;
 
     assert(tcg_enabled());
     if (cpu->watchpoint_hit) {
@@ -88,56 +71,90 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
     if (cpu->cc->tcg_ops->adjust_watchpoint_address) {
         /* this is currently used only by ARM BE32 */
         addr = cpu->cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
+        last = addr + len - 1;
     }
 
     assert((flags & ~BP_MEM_ACCESS) == 0);
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        BreakpointFlags hit_flags = wp->flags & flags;
 
-        if (hit_flags && watchpoint_address_matches(wp, addr, len)) {
-            if (replay_running_debug()) {
-                /*
-                 * replay_breakpoint reads icount.
-                 * Force recompile to succeed, because icount may
-                 * be read only at the end of the block.
-                 */
-                if (!cpu->neg.can_do_io) {
-                    /* Force execution of one insn next time.  */
-                    cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                    cpu_loop_exit_restore(cpu, ra);
-                }
-                /*
-                 * Don't process the watchpoints when we are
-                 * in a reverse debugging operation.
-                 */
-                replay_breakpoint();
-                return;
-            }
+    for (n = interval_tree_iter_first(&cpu->watchpoints, addr, last); n;
+         n = interval_tree_iter_next(n, addr, last)) {
+        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
 
-            wp->flags |= hit_flags << BP_HIT_SHIFT;
-            wp->hitaddr = MAX(addr, wp->vaddr);
-            wp->hitattrs = attrs;
-
-            if (wp->flags & BP_CPU
-                && cpu->cc->tcg_ops->debug_check_watchpoint
-                && !cpu->cc->tcg_ops->debug_check_watchpoint(cpu, wp)) {
+        if (wp->flags & flags) {
+            /*
+             * Prefer GDB over CPU watchpoint, so we can take the first
+             * GDB watchpoint that we see.
+             */
+            if (wp->flags & BP_GDB) {
                 wp->flags &= ~BP_WATCHPOINT_HIT;
-                continue;
-            }
-            cpu->watchpoint_hit = wp;
+                wp->flags |= flags << BP_HIT_SHIFT;
+                wp->hitaddr = MAX(addr, wp->itree.start);
+                wp->hitattrs = attrs;
 
-            /* This call also restores vCPU state */
-            tb_check_watchpoint(cpu, ra);
-            if (wp->flags & BP_STOP_BEFORE_ACCESS) {
-                cpu->exception_index = EXCP_DEBUG;
-                cpu_loop_exit(cpu);
-            } else {
-                /* Force execution of one insn next time.  */
-                cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                cpu_loop_exit_noexc(cpu);
+                found_wp = wp;
+                goto found;
             }
-        } else {
-            wp->flags &= ~BP_WATCHPOINT_HIT;
+            have_cpu_wp = true;
         }
     }
+
+    if (have_cpu_wp) {
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+        for (n = interval_tree_iter_first(&cpu->watchpoints, addr, last); n;
+             n = interval_tree_iter_next(n, addr, last)) {
+            CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+
+            if ((wp->flags & BP_CPU) && (wp->flags & flags)) {
+                wp->flags &= ~BP_WATCHPOINT_HIT;
+                wp->flags |= flags << BP_HIT_SHIFT;
+                wp->hitaddr = MAX(addr, wp->itree.start);
+                wp->hitattrs = attrs;
+
+                if (tcg_ops->debug_check_watchpoint
+                    && !tcg_ops->debug_check_watchpoint(cpu, wp)) {
+                    wp->flags &= ~BP_WATCHPOINT_HIT;
+                    continue;
+                }
+
+                found_wp = wp;
+                goto found;
+            }
+        }
+    }
+    return;
+
+ found:
+    if (replay_running_debug()) {
+        /*
+         * replay_breakpoint reads icount.
+         * Force recompile to succeed, because icount may
+         * be read only at the end of the block.
+         */
+        if (!cpu->neg.can_do_io) {
+            /* Force execution of one insn next time.  */
+            cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+            cpu_loop_exit_restore(cpu, ra);
+        }
+        /*
+         * Don't process the watchpoints when we are
+         * in a reverse debugging operation.
+         */
+        replay_breakpoint();
+        return;
+    }
+
+    cpu->watchpoint_hit = found_wp;
+
+    /* This call also restores vCPU state */
+    tb_check_watchpoint(cpu, ra);
+    if (found_wp->flags & BP_STOP_BEFORE_ACCESS) {
+        cpu->exception_index = EXCP_DEBUG;
+        cpu_loop_exit(cpu);
+    } else {
+        /* Force execution of one insn next time.  */
+        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+        cpu_loop_exit_noexc(cpu);
+    }
+    qemu_build_not_reached();
 }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 5c2d7ed42c..868c7c4d46 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -322,7 +322,6 @@ static void cpu_common_initfn(Object *obj)
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
     QSIMPLEQ_INIT(&cpu->work_list);
-    QTAILQ_INIT(&cpu->watchpoints);
 
     cpu_exec_initfn(cpu);
 
diff --git a/system/watchpoint.c b/system/watchpoint.c
index a618bb5acd..ed505da403 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -30,26 +30,23 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           CPUWatchpoint **watchpoint)
 {
     CPUWatchpoint *wp;
+    vaddr last = addr + len - 1;
     vaddr in_page;
 
     /* forbid ranges which are empty or run off the end of the address space */
-    if (len == 0 || (addr + len - 1) < addr) {
+    if (len == 0 || last < addr) {
         error_report("tried to set invalid watchpoint at %"
                      VADDR_PRIx ", len=%" VADDR_PRIu, addr, len);
         return -EINVAL;
     }
-    wp = g_malloc(sizeof(*wp));
 
-    wp->vaddr = addr;
-    wp->len = len;
+    wp = g_new0(CPUWatchpoint, 1);
+
+    wp->itree.start = addr;
+    wp->itree.last = last;
     wp->flags = flags;
 
-    /* keep all GDB-injected watchpoints in front */
-    if (flags & BP_GDB) {
-        QTAILQ_INSERT_HEAD(&cpu->watchpoints, wp, entry);
-    } else {
-        QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
-    }
+    interval_tree_insert(&wp->itree, &cpu->watchpoints);
 
     in_page = -(addr | TARGET_PAGE_MASK);
     if (len <= in_page) {
@@ -68,11 +65,16 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
                           BreakpointFlags flags)
 {
-    CPUWatchpoint *wp;
+    vaddr last = addr + len - 1;
+    IntervalTreeNode *n;
 
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (addr == wp->vaddr && len == wp->len
-                && flags == (wp->flags & ~BP_WATCHPOINT_HIT)) {
+    for (n = interval_tree_iter_first(&cpu->watchpoints, addr, addr); n;
+         n = interval_tree_iter_next(n, addr, addr)) {
+        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+
+        if (addr == wp->itree.start &&
+            last == wp->itree.last &&
+            flags == (wp->flags & ~BP_WATCHPOINT_HIT)) {
             cpu_watchpoint_remove_by_ref(cpu, wp);
             return 0;
         }
@@ -83,19 +85,20 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
 /* Remove a specific watchpoint by reference.  */
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
 {
-    QTAILQ_REMOVE(&cpu->watchpoints, watchpoint, entry);
-
-    tlb_flush_page(cpu, watchpoint->vaddr);
-
+    interval_tree_remove(&watchpoint->itree, &cpu->watchpoints);
+    tlb_flush_page(cpu, watchpoint->itree.start);
     g_free(watchpoint);
 }
 
 /* Remove all matching watchpoints.  */
 void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask)
 {
-    CPUWatchpoint *wp, *next;
+    IntervalTreeNode *n = interval_tree_iter_first(&cpu->watchpoints, 0, -1);
 
-    QTAILQ_FOREACH_SAFE(wp, &cpu->watchpoints, entry, next) {
+    while (n) {
+        CPUWatchpoint *wp = container_of(n, CPUWatchpoint, itree);
+
+        n = interval_tree_iter_next(n, 0, -1);
         if (wp->flags & mask) {
             cpu_watchpoint_remove_by_ref(cpu, wp);
         }
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 456a09e766..5ecc0939e9 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -130,7 +130,8 @@ int insert_hw_watchpoint(vaddr addr, vaddr len, int type)
     HWWatchpoint wp = {
         .wcr = R_DBGWCR_E_MASK, /* E=1, enable */
         .wvr = addr & (~0x7ULL),
-        .details = { .vaddr = addr, .len = len }
+        .details.itree.start = addr,
+        .details.itree.last = addr + len - 1,
     };
 
     if (cur_hw_wps >= max_hw_wps) {
-- 
2.43.0


