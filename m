Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E107BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIFH-0001oh-44; Fri, 10 Jul 2026 16:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIF4-0001eW-84
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEp-0000lH-ER
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84864b41100so1173809b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716862; x=1784321662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I8oM6zA995h2YqemG4RaUvMUdlMqbrs5DxUx8iaXoJQ=;
 b=FwPNQHe6kT/SxBQXjmesrPIw0u5v7SMoYJWma2G+DSjFJlkfVvoegVjisLd1uVIs8s
 RPdL+FPzQEd2nX/dCC3YLPd2EWIn7Df+S5W1pUBBvDv0sVCtfCyTk7Vlga/ZzCAcsXUL
 7AvizZI+8T3sEh6IB29UdG/43xNdTyjxBJLpNefpqGwSP26AIii2uI+O5EgNcvOmlJRl
 1Nqd4Z88srvpWs0IA1vaJ6Gpa4Ksgqs5wQ1ryEyLw4XPKkBk0x/JhL/0uAI4+QFUYV4m
 O+WfLZU0hvpHzmXuAuvnoQUJZG1NHvzViIULNUqB2nRBVyp2Hrk04aTl3U/VG66sWt49
 AKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716862; x=1784321662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I8oM6zA995h2YqemG4RaUvMUdlMqbrs5DxUx8iaXoJQ=;
 b=b2YEjUvAoaqtxFoEwhohJfVsSqzRLyxZwj5UQNvk2rBzeJcswezOVpHiiwICdaz9fG
 YKPmM7AwIthXZjG1/zkCssIiJRhmEEHfQYrRYhuk/s6uchPpJnmHPXZ+eyKKQT+aUemn
 d0MRmBrdr6xhTD1+J1d2LfMGMj/o4utq0eZUvHAb4Xrz2CbSaeu+CpKB+jxeXfC4+fal
 pxXbWtqZQ07zudpbG1guZ2By0fwBjheUcRcowF9w1fHU1Yv488C2LnxXDeLxpt1kX17t
 CYpWt0zkGTeTj7kzfiyKeJ8ccs5d0Xj+M2RFKx+0ci1A3SN3MDRui/r+6UdW1I7QuxLg
 lE8w==
X-Gm-Message-State: AOJu0Yxgn9yZ/Hl0jrfEhXhu8mix697MX7syny3QB5Pg5jTZWwtG5fna
 kimqBN5rck599C8YKiuivUb8cjGaPPwJwEhRAQEhIev6adQYvJoTmxpk9LcinAzlxEYCJYPCWcf
 g8fWI
X-Gm-Gg: AfdE7clYrVS+FsVcKzmSNMOcZnhg9f/ZkjkJ2gKes/uirImclNP4SWjQwjZsxd27spZ
 mnYWrx/t1d4SuKEGu/KwlXOwJwOrKqKNkHkB8Zu1inOxaeBpJyp5gJZLie1PaTpEzu3PG3q7rN5
 X3jl6FRQvwz6gkXONRNiWBAG0wKVrEfm240jyC97EoVn2wj0IV5J8XqG6KrVic0mLBdn7HPVrA8
 ETFsrTX0uahvKAkvnvOePhEDQyNQ9ki/SbUkHiEc5PgQdYd+mMxHfeZvb1c9cy3S5w+4cGAiCfb
 xHX1VJ/F30amok1zleCreOfI6rY6FPWKSyKvOKBYhAHUPFKCAL7WjDExY7WqGKyCJGq7zJJgWPQ
 pqrg+PyNNyoiTg5HiCphyCTB70dnizD1lxQCnty5+zjVMh30Ujm8lp/0YFW5zW1NoLZ6C18FAIk
 CIH+SwzMHnKrrQCXJqJw==
X-Received: by 2002:a05:6a00:ab88:b0:848:411f:3969 with SMTP id
 d2e1a72fcca58-8488979fc3cmr487713b3a.20.1783716861885; 
 Fri, 10 Jul 2026 13:54:21 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 18/51] cpu: Use interval-tree for CPUWatchpoint
Date: Fri, 10 Jul 2026 13:53:28 -0700
Message-ID: <20260710205401.836304-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index bb7cbc626d..e0826a1a2d 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -9,7 +9,6 @@
 #define EXEC_BREAKPOINT_H
 
 #include "qemu/interval-tree.h"
-#include "qemu/queue.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
@@ -36,13 +35,11 @@ struct CPUBreakpoint {
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
index b8a1419860..7e19ea418d 100644
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
index 2762cf6705..ab299387e3 100644
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
index c91efa7495..8dd1fbd440 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -130,7 +130,8 @@ int insert_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type)
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


