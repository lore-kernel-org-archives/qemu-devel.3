Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF53C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ak-0000AP-RG; Mon, 17 Aug 2026 15:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zm-0006XV-4F
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:50 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zj-0006k8-LX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:49 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81ea0b7d137so31285737b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786993246; x=1787598046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36OsLB5ufwRDhdUK7CGcFELdtjM2z4D2GMUmwLDmDN0=;
 b=NDCCkm/qgXpStnhDMu9ftD13+vrW9Gm5q4/5zf2z4mBbe3xr6nG5zdIHY5nadMGkeK
 ZH1ZPn9XxJm+xMZX4MBJ3CSYFeRBLVsi0n4XdyhyE44qkoXMcockCL+7xfZfvkTqa0XS
 s8M7BcM9NQ1Ag3G2/HQhpHQP2WgMGUADSL04a0f0uYV5MkFddmLDPqXMPtpMEUCxbJ2J
 7J+blnwwWoJGEhE/F7ehBp7mr4cdjGXaT4xOqx/nqwSsAZfgRHQVo6tgEpyWJo3ISsmx
 ImarAGjYyCWw/diCgkbQPzhwMfR6g2GR2bC7msXW3nHPLc9xkGYoYoseZHkkM1w85xSf
 qK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993246; x=1787598046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=36OsLB5ufwRDhdUK7CGcFELdtjM2z4D2GMUmwLDmDN0=;
 b=stmMvcAl0k2TizVn8HlVbHAbxnPW849eRc6+7C8zO85l6e5mGGslQDg8itOgGmunLy
 uNphj3rfXVmVw7pxFHd53V8DtrlWBl0epIWPEicUTWGNSGxSSTp8vleRSQlzQtnCAuxy
 kRv9rGJ4BxXtaMoTbLiCmtO1xPSOM5LMWhm6kGEC6eeBQC1EnNNG06Xa92UTeAx31UYR
 uT8sOdmuWNvD8S37G7+Bbon4z9CljZFepA8LZ0W6Jsa0Fly+vwcrs3Gsc5PvHjAVhomE
 uaqoskJ8QWc13QFajaI2p38N7Bs5xVjha99ZpCiwqwqB26yAB07LIH5SM0F9grfPAqrB
 baWg==
X-Gm-Message-State: AOJu0YxNRCURIQ2TwhbAAIBQonfqTo9eiLTezGKJkw6hnyyPBmIXDiTs
 HyRlLATzHMwqlkME2smDA5rXk3OLj5F/RbEiG8t6VTk6PqsDHaneTT7WVWasZ0ZSovc=
X-Gm-Gg: AR+sD12tRd/xnPf8YM/MYDRlWBK73Rwv6ZC3Osr9mATW1oIzQFdTdZ10GcAqZRvMCyL
 ZHvH9xvTnVDR1ip4fjZrGpZGP0GfU4uteWjG7+jVO+I/0UykNRcOQqNIooZ2cg/j4ILrFl8hdSW
 6mntgbHYxR4LkqFB8hIIgmZQz3mNihkoTdBjSuH0KQ4jS8UDLLHd2Kn1e7ymGbtSphKVa9Iu4ie
 OjkS94g9TGkg8LAjREaf4q4dL+Z2NUGGTL7AXyf5FplWqJpk2r32eiY5qDlvnive7pkzS7ew8Vz
 2bRj0KjFLFkAFI0KKiv+Cn2/DqXe7YA77yfUO10DSixwkFNdCPOsfuTbnCdNj599/qIX3RcXcKY
 2cGY/G8VonvA6Q98fgvljUtlABnjHS7hkAv/jn6z1CvL1sPdvJx2KFLc6nffy4CMV1nJJMT59pa
 OwTdoYslTUagvsSz985UMpiEXyU0tnTjWcrbqOtrOBl8uYU4D3TGJbBbn0l5KT
X-Received: by 2002:a05:690c:4027:b0:81f:a7b5:7f0e with SMTP id
 00721157ae682-83711ffe649mr79221277b3.26.1786993246004; 
 Mon, 17 Aug 2026 12:00:46 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-84068d1a5a1sm11090507b3.14.2026.08.17.12.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:44 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [RFC PATCH 1/8] accel/tcg: cache the result of curr_cflags()
Date: Mon, 17 Aug 2026 15:00:31 -0400
Message-ID: <20260817190038.580257-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817190038.580257-1-mattst88@gmail.com>
References: <20260817190038.580257-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
and from the cpu_exec() loop. It recomputes the same value every time:

    uint32_t cflags = cpu->tcg_cflags;
    if (unlikely(cpu_single_stepping(cpu))) { ... }
    else if (qatomic_read(&one_insn_per_tb)) { ... }
    else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }

That is three loads and three branches on the hottest path in the
interpreter, for state that changes only when gdb enables single-step,
when one-insn-per-tb is toggled, or when the log mask changes.

Compute the value once into CPUState::tcg_curr_cflags and recompute it
from the four places that can change an input: tcg_cflags_set(),
cpu_single_step(), tcg_set_one_insn_per_tb() and qemu_set_log_internal().
curr_cflags() becomes a single load.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, in a
build configured with --enable-lto:

    before: 1,647,901,588,726 instructions
    after:  1,563,829,403,943 instructions   -5.10%

That workload issues 8.4 billion dispatches, so the per-call saving is
small but the aggregate is not. The emulated compiler produces
byte-identical output before and after.

Wall clock does not move: 133.57s to 133.13s, a 0.33% difference against a
run-to-run spread of the same size. The removed work is a few predictable
loads and branches that the host executes largely in parallel with the
surrounding dispatch, so this patch is worth taking for the instruction
count and for what it enables, not for a time saving that can be measured
on its own.

Note that tcg_set_one_insn_per_tb() does not tb_flush(), so the cache
cannot piggyback on TB flushing and needs its own update call.

Caching makes the pre-computed cflags one half of a pair that has to be
kept in step, and nothing in C enforces that. The cost of getting it
wrong is not a crash but silently wrong code generation: a stale cache
that is missing CF_PARALLEL makes TCG emit the non-atomic form of guest
atomics, and the guest then corrupts its own mutexes. linux-user's
cpu_copy() is exactly such a trap. do_fork() calls
begin_parallel_context() on the parent before cpu_copy(), so the child
inherits CF_PARALLEL and never calls tcg_cflags_set() itself; assigning
the field directly would leave every cloned thread dispatching with a
cflags of zero.

Close the hole from both ends.

Name the field tcg_cflags_priv and add tcg_cflags_get(), so that
tcg_cflags_has()/get()/set() are the only ways to reach it. C cannot
really make a struct member private, but an open-coded access now fails
to compile rather than quietly going stale, which is enough to force a
rebased or newly written user to look at the accessors. target/alpha's
CF_PCREL setup is converted along with it: it would be benign either way
today, because tcg_cpu_init_cflags() refreshes the cache afterwards in
system mode, but it is the same pattern and only ordering saved it.

Then have curr_cflags() recompute the value and compare, under
CONFIG_DEBUG_TCG. That is the check that catches a missed update on the
first dispatch, rather than days later by way of corrupted guest mutexes.
It cannot be unconditional, as recomputing on every dispatch is the very
cost the cache exists to avoid.

Verified by dropping the tcg_cflags_set() call from cpu_copy() against a
debug-tcg build: the assert fires immediately, reporting the cached and
recomputed values and the bits that differ.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/cpu-exec-common.c      | 48 +++++++++++++++++++++++++++++---
 accel/tcg/internal-common.h      | 19 ++++++++++++-
 accel/tcg/tcg-all.c              |  1 +
 cpu-target.c                     |  3 ++
 include/exec/translation-block.h |  6 ++++
 include/hw/core/cpu.h            | 13 +++++++--
 include/system/tcg.h             |  9 ++++++
 linux-user/main.c                |  2 +-
 stubs/meson.build                |  1 +
 stubs/tcg-cflags.c               | 16 +++++++++++
 target/alpha/cpu.c               |  2 +-
 util/log.c                       |  4 +++
 12 files changed, 114 insertions(+), 10 deletions(-)
 create mode 100644 stubs/tcg-cflags.c

diff --git ./accel/tcg/cpu-exec-common.c ./accel/tcg/cpu-exec-common.c
index 44e84344f3..c75fbd344d 100644
--- ./accel/tcg/cpu-exec-common.c
+++ ./accel/tcg/cpu-exec-common.c
@@ -28,17 +28,23 @@ bool tcg_allowed;
 
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
 {
-    return cpu->tcg_cflags & flags;
+    return cpu->tcg_cflags_priv & flags;
+}
+
+uint32_t tcg_cflags_get(CPUState *cpu)
+{
+    return cpu->tcg_cflags_priv;
 }
 
 void tcg_cflags_set(CPUState *cpu, uint32_t flags)
 {
-    cpu->tcg_cflags |= flags;
+    cpu->tcg_cflags_priv |= flags;
+    tcg_update_curr_cflags(cpu);
 }
 
-uint32_t curr_cflags(CPUState *cpu)
+static uint32_t compute_curr_cflags(CPUState *cpu)
 {
-    uint32_t cflags = cpu->tcg_cflags;
+    uint32_t cflags = cpu->tcg_cflags_priv;
 
     /*
      * Record gdb single-step.  We should be exiting the TB by raising
@@ -58,6 +64,40 @@ uint32_t curr_cflags(CPUState *cpu)
     return cflags;
 }
 
+void tcg_update_curr_cflags(CPUState *cpu)
+{
+    cpu->tcg_curr_cflags = compute_curr_cflags(cpu);
+}
+
+void tcg_update_all_curr_cflags(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        tcg_update_curr_cflags(cpu);
+    }
+}
+
+#ifdef CONFIG_DEBUG_TCG
+/*
+ * Catch a cached value that has gone stale because an input changed without
+ * a matching tcg_update_curr_cflags().  Called from curr_cflags() on the
+ * dispatch path, so it exists only in debug-tcg builds.
+ */
+void tcg_assert_curr_cflags(CPUState *cpu)
+{
+    uint32_t cached = cpu->tcg_curr_cflags;
+    uint32_t fresh = compute_curr_cflags(cpu);
+
+    if (unlikely(cached != fresh)) {
+        fprintf(stderr, "stale tcg_curr_cflags on CPU %d: "
+                "cached 0x%08x, recomputed 0x%08x (differ in 0x%08x)\n",
+                cpu->cpu_index, cached, fresh, cached ^ fresh);
+        g_assert_not_reached();
+    }
+}
+#endif
+
 /* exit the current TB, but without causing any exception to be raised */
 void cpu_loop_exit_noexc(CPUState *cpu)
 {
diff --git ./accel/tcg/internal-common.h ./accel/tcg/internal-common.h
index 9e7be2d78d..dc713a6e1a 100644
--- ./accel/tcg/internal-common.h
+++ ./accel/tcg/internal-common.h
@@ -70,7 +70,24 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
 /* current cflags for hashing/comparison */
-uint32_t curr_cflags(CPUState *cpu);
+/*
+ * Cached by tcg_update_curr_cflags().  This is on the hot TB dispatch
+ * path, so it must stay a single load; see commit message.  A debug-tcg
+ * build pays for a recompute here to prove the cache is still in step,
+ * which turns a missed update into a loud failure rather than subtly
+ * wrong code generation.
+ */
+#ifdef CONFIG_DEBUG_TCG
+void tcg_assert_curr_cflags(CPUState *cpu);
+#endif
+
+static inline uint32_t curr_cflags(CPUState *cpu)
+{
+#ifdef CONFIG_DEBUG_TCG
+    tcg_assert_curr_cflags(cpu);
+#endif
+    return cpu->tcg_curr_cflags;
+}
 
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
diff --git ./accel/tcg/tcg-all.c ./accel/tcg/tcg-all.c
index 7186c10cf0..8f892f580f 100644
--- ./accel/tcg/tcg-all.c
+++ ./accel/tcg/tcg-all.c
@@ -254,6 +254,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     s->one_insn_per_tb = value;
     /* Set the global also: this changes the behaviour */
     qatomic_set(&one_insn_per_tb, value);
+    tcg_update_all_curr_cflags();
 }
 
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
diff --git ./cpu-target.c ./cpu-target.c
index 4783845c9b..9affbcd9c5 100644
--- ./cpu-target.c
+++ ./cpu-target.c
@@ -24,6 +24,7 @@
 #include "exec/replay-core.h"
 #include "exec/log.h"
 #include "hw/core/cpu.h"
+#include "system/tcg.h"
 #include "trace/trace-root.h"
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
@@ -35,6 +36,8 @@ void cpu_single_step(CPUState *cpu, unsigned flags)
                                           cpu->singlestep_flags, flags);
         cpu->singlestep_flags = flags;
 
+        tcg_update_curr_cflags(cpu);
+
 #if !defined(CONFIG_USER_ONLY)
         const AccelOpsClass *ops = cpus_get_accel();
         if (ops->update_guest_debug) {
diff --git ./include/exec/translation-block.h ./include/exec/translation-block.h
index 40cc699031..ed2ce87503 100644
--- ./include/exec/translation-block.h
+++ ./include/exec/translation-block.h
@@ -158,7 +158,13 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
     return qatomic_read(&tb->cflags);
 }
 
+/*
+ * CPUState::tcg_cflags_priv is reached only through these.  The setter keeps
+ * the derived CPUState::tcg_curr_cflags in step, and assigning the field
+ * directly would silently leave that cache stale.
+ */
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
+uint32_t tcg_cflags_get(CPUState *cpu);
 void tcg_cflags_set(CPUState *cpu, uint32_t flags);
 
 static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
diff --git ./include/hw/core/cpu.h ./include/hw/core/cpu.h
index b54035fb13..172872d005 100644
--- ./include/hw/core/cpu.h
+++ ./include/hw/core/cpu.h
@@ -411,10 +411,16 @@ struct qemu_work_item;
  *   to a cluster this will be UNASSIGNED_CLUSTER_INDEX; otherwise it will
  *   be the same as the cluster-id property of the CPU object's TYPE_CPU_CLUSTER
  *   QOM parent.
- *   Under TCG this value is propagated to @tcg_cflags.
+ *   Under TCG this value is propagated to @tcg_cflags_priv.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
  * @start_powered_off: Indicates whether the CPU starts in powered-off state.
- * @tcg_cflags: Pre-computed cflags for this cpu.
+ * @tcg_cflags_priv: Pre-computed cflags for this cpu.  Private to
+ *   tcg_cflags_has() and tcg_cflags_set(): @tcg_curr_cflags is derived from
+ *   it and is refreshed by the setter, so a direct assignment here would
+ *   leave the two out of step.  The name is deliberately awkward to make an
+ *   open-coded access fail to compile rather than silently go stale.
+ * @tcg_curr_cflags: Cached result of curr_cflags(), recomputed by
+ *   tcg_update_curr_cflags() whenever any of its inputs change.
  * @nr_threads: Number of threads within this CPU core.
  * @thread: Host thread details, only live once @created is #true
  * @sem: WIN32 only semaphore used only for qtest
@@ -557,7 +563,8 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
-    uint32_t tcg_cflags;
+    uint32_t tcg_cflags_priv;
+    uint32_t tcg_curr_cflags;
     uint32_t halted;
     int32_t exception_index;
 
diff --git ./include/system/tcg.h ./include/system/tcg.h
index 7622dcea30..f41e6b3219 100644
--- ./include/system/tcg.h
+++ ./include/system/tcg.h
@@ -17,6 +17,15 @@ extern bool tcg_allowed;
 #define tcg_enabled() 0
 #endif
 
+/*
+ * Recompute CPUState::tcg_curr_cflags.  Must be called whenever any input
+ * to the computation changes: CPUState::tcg_cflags_priv, gdb single-step
+ * state, one-insn-per-tb, or the CPU_LOG_TB_NOCHAIN log flag.  The first of
+ * those is covered already, tcg_cflags_set() being the only way to change it.
+ */
+void tcg_update_curr_cflags(CPUState *cpu);
+void tcg_update_all_curr_cflags(void);
+
 /**
  * qemu_tcg_mttcg_enabled:
  * Check whether we are running MultiThread TCG or not.
diff --git ./linux-user/main.c ./linux-user/main.c
index 60a695b7ca..ba04773398 100644
--- ./linux-user/main.c
+++ ./linux-user/main.c
@@ -242,7 +242,7 @@ CPUArchState *cpu_copy(CPUArchState *env)
     /* Reset non arch specific state */
     cpu_reset(new_cpu);
 
-    new_cpu->tcg_cflags = cpu->tcg_cflags;
+    tcg_cflags_set(new_cpu, tcg_cflags_get(cpu));
     memcpy(new_env, env, sizeof(CPUArchState));
 #if defined(TARGET_I386) || defined(TARGET_X86_64)
     new_env->gdt.base = target_mmap(0, sizeof(uint64_t) * TARGET_GDT_ENTRIES,
diff --git ./stubs/meson.build ./stubs/meson.build
index 3b2f2680b1..0025e79226 100644
--- ./stubs/meson.build
+++ ./stubs/meson.build
@@ -3,6 +3,7 @@
 # below, so that it is clear who needs the stubbed functionality.
 
 stub_ss.add(files('cpu-get-clock.c'))
+stub_ss.add(files('tcg-cflags.c'))
 stub_ss.add(files('fdset.c'))
 stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
diff --git ./stubs/tcg-cflags.c ./stubs/tcg-cflags.c
new file mode 100644
index 0000000000..bd74fabf0e
--- /dev/null
+++ ./stubs/tcg-cflags.c
@@ -0,0 +1,16 @@
+/*
+ * Stubs for the cached cflags update hooks, for binaries that link
+ * util/log.c or cpu-target.c without linking TCG.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "system/tcg.h"
+
+void tcg_update_curr_cflags(CPUState *cpu)
+{
+}
+
+void tcg_update_all_curr_cflags(void)
+{
+}
diff --git ./target/alpha/cpu.c ./target/alpha/cpu.c
index 0c35067b20..fcc676c7fb 100644
--- ./target/alpha/cpu.c
+++ ./target/alpha/cpu.c
@@ -114,7 +114,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     /* Use pc-relative instructions in system-mode */
-    cs->tcg_cflags |= CF_PCREL;
+    tcg_cflags_set(cs, CF_PCREL);
 #endif
 
     cpu_exec_realizefn(cs, &local_err);
diff --git ./util/log.c ./util/log.c
index 7cffbc1bf8..62c7f09609 100644
--- ./util/log.c
+++ ./util/log.c
@@ -27,6 +27,7 @@
 #include "qemu/thread.h"
 #include "qemu/lockable.h"
 #include "qemu/rcu.h"
+#include "system/tcg.h"
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #endif
@@ -301,6 +302,9 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
 #endif
     qemu_loglevel = log_flags;
 
+    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cached cflags. */
+    tcg_update_all_curr_cflags();
+
     daemonized = is_daemonized();
     need_to_open_file = false;
     if (!daemonized) {
-- 
2.54.0


