Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D5EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIF0-0001YB-KD; Fri, 10 Jul 2026 16:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEy-0001V9-Dw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEm-0000jl-Tt
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1789718b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716859; x=1784321659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AH60zWDle7diIfRrGmEWIKGfqDNGJU7oKLZ50WZchqw=;
 b=TDJuJF4lMoea6rieQL6LVztyxKK4cqYT252U7XZVhFKXoy3T2uImnMfmI6Wrczm6jE
 tAlmR/zxYmJQwPSTlKeSQV0fMUer0ptk0rpj4c4Lf1O8oVlv7Rryfft+zU7KCcGPtOF4
 +XCV2v7eNZJzbQAB5L/wqJTxFOEBzaiTO7d0tx72OoHhtS2jhoAOfOBwy0+J4WEzQ/xG
 TnqgRKWbRvebkNopbsX+ZXOzjqKvyT4YOXDtWZF2irkRtPhZCmPaZlKC7gyhfJtR9feY
 +m078IHKz48PIJun/o5F8X3j8inzYU581hoJJN2UadIC03UPUYMvfDWuFjpkwPbK1vYS
 Q8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716859; x=1784321659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AH60zWDle7diIfRrGmEWIKGfqDNGJU7oKLZ50WZchqw=;
 b=VecK18chNbANLpPzqSgxr4Ft7zFDX3VT/CbB9ZVxJTipV+Ky3y5vewa9Alv4AWLz64
 SyHVLkbNOFheCuaNda4WcRyonihEiNSgZCLU9nzH1qXaJxke+SCHm1Arpe+mnbYjTkRh
 6AeWHqJcVxEKrZWg1O+vCFiIPKTn+a00lQfnPqJO69ChB4LGQqTxal2pmY/fcrds7Mkk
 soZByVlUx23Y+6ae6yedvlGaJXQ9l4hchT9rhsdIDYajie6bz4yUe+dIKDWFxo9yVxdx
 7oxamQmNOwbvDz4NKJCVgatqU8ygN98CCCrK+FSi9q6r9MRRY1KP15vSuD+m2U2OwUdU
 vSsg==
X-Gm-Message-State: AOJu0Yw1fKohnlh5BkJ7aCwZqEEB++1a4zWKxtfgxsqgc8WsCCBXvFmD
 vz45Egjj4Rtqp4PaJpQuLQw/ZFukhryhGvD8KGsc0rS+ETX+qQtZAzN4haEHqFo8pVaXw7ibLKE
 wZ1uL
X-Gm-Gg: AfdE7cmbF3oLAWTAhpXeKLtbzRbB28Nhzd2TG/7GdUvClW5fZA9bNx8v6uoC5Ia/ct4
 3MZr2Zbi/gnwlM+F22hXNeZzw0QKAO2dVgW8XTanlNl5+PcBVBeHAArgB1ub1KVjo0D0hirCY0a
 4oVd7W4bymIyr6EK6uly9NgPqb5B/DMFer6paHvgTS+6bLIwpTUP7DGddjeouGGzTJzAeKpNWYv
 oGTARJv8gEhSTODmGCVGqojMtOW7MnY6c4s0LFs1TOFYEM0BMGtY/ByecSvumgUPD+GZmoVTN81
 2pbFzZ8OSUFHCQZbtdcoF6EaWR6/i/Xz7lh+ASNybYiQvijO/hZtszvpyxAo/q1S1lstYV6xoeP
 SEhQw93meCg9ypzIL0rCe1CZTz4dLj2DmzzGnLvERzdnziIxRdRKDorbumNJhG6qzJLrZo0BLB2
 rAc+qwe5N0dOwfoCwZtw==
X-Received: by 2002:a05:6a00:c88:b0:848:2f77:e2dd with SMTP id
 d2e1a72fcca58-848897a7553mr512136b3a.70.1783716859449; 
 Fri, 10 Jul 2026 13:54:19 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 15/51] cpu: Use interval-tree for CPUBreakpoint
Date: Fri, 10 Jul 2026 13:53:25 -0700
Message-ID: <20260710205401.836304-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Use a balanced binary tree rather than a simple list for breakpoints.
Using an interval tree makes it easy to probe for all breakpoints on
a virtual page.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h   |  4 +--
 include/hw/core/cpu.h       |  3 +-
 accel/tcg/cpu-exec.c        | 58 +++++++++++++++++++++----------------
 accel/whpx/whpx-common.c    |  9 +++---
 cpu-common.c                | 46 +++++++++++++++--------------
 hw/core/cpu-common.c        |  1 -
 linux-user/main.c           | 14 ++++++---
 target/i386/whpx/whpx-all.c | 15 +++++-----
 8 files changed, 84 insertions(+), 66 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 6da8a007df..bb7cbc626d 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -8,6 +8,7 @@
 #ifndef EXEC_BREAKPOINT_H
 #define EXEC_BREAKPOINT_H
 
+#include "qemu/interval-tree.h"
 #include "qemu/queue.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
@@ -29,10 +30,9 @@ typedef uint32_t BreakpointFlags;
 #define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
 
 struct CPUBreakpoint {
-    vaddr pc;
+    IntervalTreeNode itree;     /* start == last == pc */
     BreakpointFlags flags;
     unsigned id;
-    QTAILQ_ENTRY(CPUBreakpoint) entry;
 };
 
 struct CPUWatchpoint {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5c01908f83..b8a1419860 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -30,6 +30,7 @@
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/interval-tree.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/lockcnt.h"
@@ -523,7 +524,7 @@ struct CPUState {
     QTAILQ_ENTRY(CPUState) node;
 
     /* ice debug support */
-    QTAILQ_HEAD(, CPUBreakpoint) breakpoints;
+    IntervalTreeRoot breakpoints;
 
     QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
     CPUWatchpoint *watchpoint_hit;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6547cc70c9..2762cf6705 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -296,8 +296,8 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
 static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
                                        uint32_t *cflags)
 {
+    IntervalTreeNode *n;
     CPUBreakpoint *bp;
-    bool match_page = false;
 
     /*
      * Singlestep overrides breakpoints.
@@ -312,33 +312,34 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
         return false;
     }
 
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        /*
-         * If we have an exact pc match, trigger the breakpoint.
-         * Otherwise, note matches within the page.
-         */
-        if (pc == bp->pc) {
-            bool match_bp = false;
-
-            if (bp->flags & BP_GDB) {
-                match_bp = true;
-            } else if (bp->flags & BP_CPU) {
+    n = interval_tree_iter_first(&cpu->breakpoints, pc, pc);
+    if (n) {
 #ifdef CONFIG_USER_ONLY
-                g_assert_not_reached();
+        bp = container_of(n, CPUBreakpoint, itree);
+        assert(bp->flags & BP_GDB);
+        goto found;
 #else
-                const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-                assert(tcg_ops->debug_check_breakpoint);
-                match_bp = tcg_ops->debug_check_breakpoint(cpu, bp);
-#endif
+        /* Prefer GDB breakpoint over architectural breakpoint. */
+        do {
+            bp = container_of(n, CPUBreakpoint, itree);
+            if (bp->flags & BP_GDB) {
+                goto found;
             }
+            n = interval_tree_iter_next(n, pc, pc);
+        } while (n);
 
-            if (match_bp) {
-                cpu->exception_index = EXCP_DEBUG;
-                return true;
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+        assert(tcg_ops->debug_check_breakpoint);
+
+        for (n = interval_tree_iter_first(&cpu->breakpoints, pc, pc); n;
+             n = interval_tree_iter_next(n, pc, pc)) {
+            bp = container_of(n, CPUBreakpoint, itree);
+            if ((bp->flags & BP_CPU) &&
+                tcg_ops->debug_check_breakpoint(cpu, bp)) {
+                goto found;
             }
-        } else if (((pc ^ bp->pc) & TARGET_PAGE_MASK) == 0) {
-            match_page = true;
         }
+#endif
     }
 
     /*
@@ -353,17 +354,24 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
      * invalidated, nor would any TB need to be invalidated as
      * breakpoints are removed.
      */
-    if (match_page) {
+    n = interval_tree_iter_first(&cpu->breakpoints,
+                                 pc & TARGET_PAGE_MASK,
+                                 pc | ~TARGET_PAGE_MASK);
+    if (n) {
         *cflags = (*cflags & ~CF_COUNT_MASK) | CF_NO_GOTO_TB | CF_BP_PAGE | 1;
     }
     return false;
+
+ found:
+    cpu->exception_index = EXCP_DEBUG;
+    return true;
 }
 
 static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
                                          uint32_t *cflags)
 {
-    return unlikely(!QTAILQ_EMPTY(&cpu->breakpoints)) &&
-        check_for_breakpoints_slow(cpu, pc, cflags);
+    return unlikely(!interval_tree_is_empty(&cpu->breakpoints)) &&
+           check_for_breakpoints_slow(cpu, pc, cflags);
 }
 
 /**
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db81..74113b1ec1 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -112,16 +112,17 @@ int whpx_first_vcpu_starting(CPUState *cpu)
 
     g_assert(bql_locked());
 
-    if (!QTAILQ_EMPTY(&cpu->breakpoints) ||
+    if (!interval_tree_is_empty(&cpu->breakpoints) ||
             (whpx->breakpoints.breakpoints &&
              whpx->breakpoints.breakpoints->used)) {
-        CPUBreakpoint *bp;
+        IntervalTreeNode *n;
         int i = 0;
         bool update_pending = false;
 
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+        for (n = interval_tree_iter_first(&cpu->breakpoints, 0, -1); n;
+             n = interval_tree_iter_next(n, 0, -1)) {
             if (i >= whpx->breakpoints.original_address_count ||
-                bp->pc != whpx->breakpoints.original_addresses[i]) {
+                n->start != whpx->breakpoints.original_addresses[i]) {
                 update_pending = true;
             }
 
diff --git a/cpu-common.c b/cpu-common.c
index 9476bb612a..0287022de4 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -392,13 +392,13 @@ void process_queued_cpu_work(CPUState *cpu)
 /* Return true if PC matches an installed breakpoint.  */
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask)
 {
-    CPUBreakpoint *bp;
+    IntervalTreeNode *n;
 
-    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (bp->pc == pc && (bp->flags & mask)) {
-                return true;
-            }
+    for (n = interval_tree_iter_first(&cpu->breakpoints, pc, pc); n;
+         n = interval_tree_iter_next(n, pc, pc)) {
+        CPUBreakpoint *bp = container_of(n, CPUBreakpoint, itree);
+        if (bp->flags & mask) {
+            return true;
         }
     }
     return false;
@@ -414,18 +414,14 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
         pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
-    bp = g_malloc(sizeof(*bp));
+    bp = g_new0(CPUBreakpoint, 1);
 
-    bp->pc = pc;
+    bp->itree.start = pc;
+    bp->itree.last = pc;
     bp->flags = flags;
     bp->id = id;
 
-    /* keep all GDB-injected breakpoints in front */
-    if (flags & BP_GDB) {
-        QTAILQ_INSERT_HEAD(&cpu->breakpoints, bp, entry);
-    } else {
-        QTAILQ_INSERT_TAIL(&cpu->breakpoints, bp, entry);
-    }
+    interval_tree_insert(&bp->itree, &cpu->breakpoints);
 
     if (breakpoint) {
         *breakpoint = bp;
@@ -438,36 +434,42 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
 /* Remove a specific breakpoint.  */
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags)
 {
-    CPUBreakpoint *bp;
+    IntervalTreeNode *n;
 
     if (cpu->cc->gdb_adjust_breakpoint) {
         pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        if (bp->pc == pc && bp->flags == flags) {
+    for (n = interval_tree_iter_first(&cpu->breakpoints, pc, pc); n;
+         n = interval_tree_iter_next(n, pc, pc)) {
+        CPUBreakpoint *bp = container_of(n, CPUBreakpoint, itree);
+        if (bp->flags == flags) {
             cpu_breakpoint_remove_by_ref(cpu, bp);
             return 0;
         }
     }
+
     return -ENOENT;
 }
 
 /* Remove a specific breakpoint by reference.  */
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
 {
-    QTAILQ_REMOVE(&cpu->breakpoints, bp, entry);
-
-    trace_breakpoint_remove(cpu->cpu_index, bp->pc, bp->flags);
+    interval_tree_remove(&bp->itree, &cpu->breakpoints);
+    trace_breakpoint_remove(cpu->cpu_index, bp->itree.start, bp->flags);
     g_free(bp);
 }
 
 /* Remove all matching breakpoints. */
 void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask)
 {
-    CPUBreakpoint *bp, *next;
+    IntervalTreeNode *n;
 
-    QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
+    n = interval_tree_iter_first(&cpu->breakpoints, 0, -1);
+    while (n) {
+        CPUBreakpoint *bp = container_of(n, CPUBreakpoint, itree);
+
+        n = interval_tree_iter_next(n, 0, -1);
         if (bp->flags & mask) {
             cpu_breakpoint_remove_by_ref(cpu, bp);
         }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f8..5c2d7ed42c 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -322,7 +322,6 @@ static void cpu_common_initfn(Object *obj)
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
     QSIMPLEQ_INIT(&cpu->work_list);
-    QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
     cpu_exec_initfn(cpu);
diff --git a/linux-user/main.c b/linux-user/main.c
index 83b9c88ac4..4372d0b5a6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -239,7 +239,6 @@ CPUArchState *cpu_copy(CPUArchState *env)
     CPUState *cpu = env_cpu(env);
     CPUState *new_cpu = cpu_create(cpu_type);
     CPUArchState *new_env = cpu_env(new_cpu);
-    CPUBreakpoint *bp;
 
     /* Reset non arch specific state */
     cpu_reset(new_cpu);
@@ -258,9 +257,16 @@ CPUArchState *cpu_copy(CPUArchState *env)
     /* Clone all break/watchpoints.
        Note: Once we support ptrace with hw-debug register access, make sure
        BP_CPU break/watchpoints are handled correctly on clone. */
-    QTAILQ_INIT(&new_cpu->breakpoints);
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, 0, NULL);
+    if (!interval_tree_is_empty(&cpu->breakpoints)) {
+        IntervalTreeNode *n;
+
+        memset(&new_cpu->breakpoints, 0, sizeof(new_cpu->breakpoints));
+        for (n = interval_tree_iter_first(&cpu->breakpoints, 0, -1); n;
+             n = interval_tree_iter_next(n, 0, -1)) {
+            CPUBreakpoint *bp = container_of(n, CPUBreakpoint, itree);
+            cpu_breakpoint_insert(new_cpu, bp->itree.start,
+                                  bp->flags, bp->id, NULL);
+        }
     }
 
     return new_env;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d542821..243413d94c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1688,8 +1688,8 @@ void whpx_translate_cpu_breakpoints(
     CPUState *cpu,
     int cpu_breakpoint_count)
 {
-    CPUBreakpoint *bp;
     int cpu_bp_index = 0;
+    IntervalTreeNode *n;
 
     breakpoints->original_addresses =
         g_renew(vaddr, breakpoints->original_addresses, cpu_breakpoint_count);
@@ -1721,14 +1721,15 @@ void whpx_translate_cpu_breakpoints(
     }
 
     /* 2. Map all CPU breakpoints to WHPX breakpoints */
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        int i;
+    for (n = interval_tree_iter_first(&cpu->breakpoints, 0, -1); n;
+         n = interval_tree_iter_next(n, 0, -1)) {
+        vaddr pc = n->start;
         bool found = false;
 
         /* This will be used to detect changed CPU breakpoints later. */
-        breakpoints->original_addresses[cpu_bp_index++] = bp->pc;
+        breakpoints->original_addresses[cpu_bp_index++] = pc;
 
-        for (i = 0; i < new_breakpoints->used; i++) {
+        for (int i = 0; i < new_breakpoints->used; i++) {
             /*
              * WARNING: This loop has O(N^2) complexity, where N is the
              * number of breakpoints. It should not be a bottleneck in
@@ -1738,7 +1739,7 @@ void whpx_translate_cpu_breakpoints(
              * high-level breakpoint objects in a tree or hash map.
              */
 
-            if (new_breakpoints->data[i].address == bp->pc) {
+            if (new_breakpoints->data[i].address == pc) {
                 /* There was already a breakpoint at this address. */
                 if (new_breakpoints->data[i].state == WHPX_BP_CLEAR_PENDING) {
                     new_breakpoints->data[i].state = WHPX_BP_SET;
@@ -1753,7 +1754,7 @@ void whpx_translate_cpu_breakpoints(
 
         if (!found && new_breakpoints->used < new_breakpoints->allocated) {
             /* No WHPX breakpoint at this address. Create one. */
-            new_breakpoints->data[new_breakpoints->used].address = bp->pc;
+            new_breakpoints->data[new_breakpoints->used].address = pc;
             new_breakpoints->data[new_breakpoints->used].state =
                 WHPX_BP_SET_PENDING;
             new_breakpoints->used++;
-- 
2.43.0


