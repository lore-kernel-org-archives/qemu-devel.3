Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FC8C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSGg-0005rV-LL; Thu, 27 Aug 2026 01:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGb-0005ql-69
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:09 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGZ-0002JX-11
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:08 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-857d1184d29so19194417b3.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806986; x=1788411786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZnObpIoTaCD5yxi6xstyDb0vWidqbX29THsSMuAvPIs=;
 b=AOz6dFf8tzj8bh+BDVOuG/Dde6fh0y+RGXF31KsX3VvxhykDbjuAJQyMhF7kQCQUoO
 RgwkinHNER0u79Pn3MUf+D5woLvwKbQfwSXlMK0qOi11SIsY0P3GawCClddpUcsqgMSB
 JGIB2gyIdUBaTtzfFEWdGOyWOQzQvENEiKBOdVPAMjMmaa3mjFkLNZXqQcUWji5ybsjV
 kBhssrPQ9yYTIC/R+zUC84irPt3QlCvUSWdxhtVyoCbKRVFYuVkZeqT2ame2xk2f7U2f
 QrU5L2ee64b8xhwqb11IcugxEQ83NxQkp0i+425FSNmS11jJvUB2XyYuagy8lle4spWc
 dBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806986; x=1788411786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZnObpIoTaCD5yxi6xstyDb0vWidqbX29THsSMuAvPIs=;
 b=puDUsHMJ3GPaS8WXooTMPnSOlWryI8w/UYZ6rTU1FV8fs/Ia7xdma2zxJKmnOBWreC
 e5WfSHSCVlsYcifb8b+8EtYiaY8odludBvFZrNiZgPSQpn7kemSsJcHzBrETTvalGk60
 Py9t+F3Y01xW4Jv1myu50rdGck2LXeG0w/i68gH29P7snQ45Jf9cqF5iPdWBzI3sr1UG
 mNQYpBSYiUNlRnpJifqQgmzmThtV0+ji3MuiFJVW7Bp6ly+6TQ4RopcC18JAgxcgL7yz
 KQK8Omyh9lWtZLkuFiSce368pA7NTeo1yUfPDMVI7g3340fXbddJZE7qMiRuYqpJ3GHL
 6Vbw==
X-Gm-Message-State: AFuF++lF6guNoMg5o8FocqHEizdxabD/HDS1t49JlwUB+2/FSvZYoQxY
 GlGtkXCe9atzjqU7zygJtr4pVBb9EYwYJfUukf9m+o2DRdq7IJPzzXzasnFOCieg
X-Gm-Gg: AR+sD10ooAdnp5b+XTJX6kZyQM9xbsN94ERe+BmdVDCDnRb57s6OIf4YU/ZVFO6ftur
 7+rsgjmYwjSWU/ls3NKQdxJri4Sz4FH+vegKjNkhAp1ISXVlXPzgNr59KYvEV+vI5KLGl0u1Wtk
 Ur7UulieNRM5Mhw+RFaeLCoejX8cly/qBgpdbgIsThw8+ODCShzSSuyJS6/6fMTW71MIlQE8ZdO
 FDLHjCy6DmqgLXXs8+0KBKc/1J5UQUOmoyrY6JjtfGn7mYXjxfbFm8bzK4VTSF12EE4RhU9hrAL
 Vxh6FBdqwyJae11MX6LpEyjRinJOIpQ4n8I1JbQLmbXBAFt1QdVY8e8vMnmbz58W11bAcLgbhLU
 RRSDeYKQqO0q0wWAfh3DhOXm3miHxeQm+eem2slLD7ZMQoZFvqm4N2mLWVtKY2l+BGoLvwtOZ3W
 nkarwg2ssUEF+pXpD8Cf9Rc0iEH2j/DjSA9hbBGNVmAaYOAegNIXMGJqjlic90SZpW6FDRqLi7/
 ruU+LTagzAAi5P+MI8VkgYXOziSZioa1zrnldpT
X-Received: by 2002:a05:690c:c507:b0:825:c3fc:e63f with SMTP id
 00721157ae682-8573c9cf6c7mr48415177b3.8.1787806985778; 
 Wed, 26 Aug 2026 22:03:05 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b6143e97bsm4133407b3.26.2026.08.26.22.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:03:03 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 5/9] accel/tcg: give the TB jump cache a second base
 pointer for generated code
Date: Thu, 27 Aug 2026 01:02:37 -0400
Message-ID: <20260827050241.3713332-6-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1136.google.com
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

Add CPUState::tb_jmp_cache_probe, a base pointer that only generated code
will read. Normally it is cpu->tb_jmp_cache. Pointing it instead at a
shared, permanently zero-filled CPUJumpCache makes every entry generated
code finds have a NULL tb, so every lookup done through it misses. The
real jump cache is not touched, so nothing is lost and recovery is a single
store.

Nothing reads it yet. The next patch probes the jump cache from generated
code, and that probe cannot check everything helper_lookup_tb_ptr() checks;
poisoning this pointer is how the conditions it cannot check force it back
into the helper. The one that matters here is breakpoints.
check_for_breakpoints() raises EXCP_DEBUG on an exact pc match and selects
CF_BP_PAGE cflags for the rest of the page, and inserting a breakpoint
deliberately invalidates no TB, so a block translated before the breakpoint
was set is still sitting in the jump cache and would be dispatched to
directly.

cpu_breakpoint_insert() poisons the target CPU, rather than leaving it to
that CPU's own main loop, because gdb inserts a breakpoint into every CPU
(tcg_insert_gdbstub_breakpoint()) and a thread already inside generated
code dispatching to itself need never return to its main loop. The main
loop puts the pointer back once the last breakpoint is gone, re-checking
after the store so that it loses a race with a concurrent insert in the
safe direction.

The poison cache is a plain static rather than a const one so that it lands
in .bss: a megabyte of const zeroes would be a megabyte of .rodata in every
emulator binary, whereas .bss costs nothing on disk and faults in only the
handful of pages a poisoned run happens to probe.

v4: Split out of "tcg: probe the TB jump cache inline instead of calling a
    helper". Requested by Richard Henderson.

v4: Make the poison a static object rather than allocating one on first
    use. Suggested by Richard Henderson, who asked for const; see above for
    why it is not.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/stubs/tcg-stub.c      |  6 ++-
 accel/tcg/cpu-exec.c        | 96 +++++++++++++++++++++++++++++++++++++
 accel/tcg/internal-common.h |  2 +
 cpu-common.c                | 11 +++++
 include/hw/core/cpu.h       |  9 ++++
 include/system/tcg.h        |  9 ++++
 6 files changed, 132 insertions(+), 1 deletion(-)

diff --git ./accel/stubs/tcg-stub.c ./accel/stubs/tcg-stub.c
index f9e1bd22d6..8298e4a1f5 100644
--- ./accel/stubs/tcg-stub.c
+++ ./accel/stubs/tcg-stub.c
@@ -1,6 +1,6 @@
 /*
  * Stubs for the TCG entry points in system/tcg.h, for binaries that link
- * cpu-target.c or the HMP command handlers but not TCG.
+ * cpu-target.c, cpu-common.c or the HMP command handlers but not TCG.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -14,3 +14,7 @@ void tcg_update_cflags(CPUState *cpu)
 void tcg_update_all_cflags(void)
 {
 }
+
+void tcg_cpu_poison_jmp_cache(CPUState *cpu)
+{
+}
diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
index 148e0f583e..c2a9679cd7 100644
--- ./accel/tcg/cpu-exec.c
+++ ./accel/tcg/cpu-exec.c
@@ -752,6 +752,93 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
+/*
+ * The inline jump cache probe reads cpu->tb_jmp_cache_probe and takes the
+ * slow path when the entry it finds has a NULL tb.  Pointing the probe at a
+ * region that is all zeroes therefore forces every indirect dispatch into
+ * helper_lookup_tb_ptr(), which does the full lookup the inline probe only
+ * approximates.  The real jump cache is untouched, so no contents are lost
+ * and recovery is a single store.
+ *
+ * Only ever read from, and only one entry per dispatch, so one shared
+ * zero-filled cache is enough for every CPU.  Not const: that would put a
+ * megabyte of zeroes in .rodata and so in the binary, where .bss costs
+ * nothing on disk and only faults in the handful of pages a poisoned run
+ * happens to probe.
+ */
+static CPUJumpCache tb_jmp_cache_poison;
+
+/*
+ * Whether the generated code may dispatch to the next block by itself.
+ *
+ * The inline probe matches on the destination pc and on the flags and
+ * cflags the dispatching block was translated with.  It does not consult
+ * cpu->breakpoints, so it must not run while one is set: setting a
+ * breakpoint deliberately invalidates nothing, and check_for_breakpoints()
+ * both raises EXCP_DEBUG on an exact match and picks CF_BP_PAGE cflags for
+ * the rest of the page.  A block translated before the breakpoint was set is
+ * therefore still in the jump cache, and dispatching to it inline would step
+ * straight over the breakpoint.
+ */
+static bool tcg_cpu_may_dispatch(CPUState *cpu)
+{
+    return QTAILQ_EMPTY(&cpu->breakpoints);
+}
+
+/*
+ * Poison @cpu's probe, from any thread.  Called when a breakpoint is
+ * inserted, which is what makes the poison take effect at the dispatch
+ * after the insert rather than whenever @cpu next reaches its main loop:
+ * a vCPU chaining indirectly need never reach it, and would run past a
+ * breakpoint another thread had just set.
+ *
+ * A plain store is enough.  The value only ever costs a slow path that is
+ * correct on its own, and the generated code re-reads the base on every
+ * dispatch.  Un-poisoning is tcg_cpu_sync_jmp_cache()'s job.
+ */
+void tcg_cpu_poison_jmp_cache(CPUState *cpu)
+{
+    if (qatomic_read(&cpu->tb_jmp_cache_probe) != NULL) {
+        qatomic_set(&cpu->tb_jmp_cache_probe, &tb_jmp_cache_poison);
+    }
+}
+
+/*
+ * Called from the main loop, which is the only context that can establish
+ * that no reason to be poisoned is left.  Cheap enough to call every time
+ * round: the common case is a load, a compare and no store at all.
+ */
+void tcg_cpu_sync_jmp_cache(CPUState *cpu)
+{
+    CPUJumpCache *want;
+
+    if (qatomic_read(&cpu->tb_jmp_cache_probe) == NULL) {
+        return;  /* not realized, or already unrealized */
+    }
+
+    want = tcg_cpu_may_dispatch(cpu)
+           ? cpu->tb_jmp_cache
+           : &tb_jmp_cache_poison;
+
+    if (qatomic_read(&cpu->tb_jmp_cache_probe) != want) {
+        qatomic_set(&cpu->tb_jmp_cache_probe, want);
+
+        if (want == cpu->tb_jmp_cache) {
+            /*
+             * Un-poisoning races a concurrent tcg_cpu_poison_jmp_cache():
+             * the reason may have appeared after tcg_cpu_may_dispatch() read
+             * it, and the poison may have landed before the store above.
+             * Order that store against the re-read below, so that the race
+             * is lost in the safe direction.
+             */
+            smp_mb();
+            if (!tcg_cpu_may_dispatch(cpu)) {
+                tcg_cpu_poison_jmp_cache(cpu);
+            }
+        }
+    }
+}
+
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
     /*
@@ -964,6 +1051,13 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 break;
             }
 
+            /*
+             * Reaching here means the main loop has just re-evaluated
+             * everything the inline probe assumes, so this is where the
+             * probe is allowed to come back after a poison.
+             */
+            tcg_cpu_sync_jmp_cache(cpu);
+
             tb = tb_lookup(cpu, s);
             if (tb == NULL) {
                 CPUJumpCache *jc;
@@ -1072,6 +1166,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     tcg_update_cflags(cpu);
 
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
+    qatomic_set(&cpu->tb_jmp_cache_probe, cpu->tb_jmp_cache);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1089,5 +1184,6 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 #endif /* !CONFIG_USER_ONLY */
 
     tlb_destroy(cpu);
+    qatomic_set(&cpu->tb_jmp_cache_probe, NULL);
     g_free_rcu(cpu->tb_jmp_cache, rcu);
 }
diff --git ./accel/tcg/internal-common.h ./accel/tcg/internal-common.h
index 853d1b51ee..9d1f6712d6 100644
--- ./accel/tcg/internal-common.h
+++ ./accel/tcg/internal-common.h
@@ -144,6 +144,8 @@ void page_table_config_init(void);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_USER_ONLY */
 
+void tcg_cpu_sync_jmp_cache(CPUState *cpu);
+
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
diff --git ./cpu-common.c ./cpu-common.c
index adb76b3a78..3aed0156e6 100644
--- ./cpu-common.c
+++ ./cpu-common.c
@@ -22,6 +22,7 @@
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
 #include "qemu/lockable.h"
+#include "system/tcg.h"
 #include "trace/trace-root.h"
 
 QemuMutex qemu_cpu_list_lock;
@@ -429,6 +430,16 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
         *breakpoint = bp;
     }
 
+    /*
+     * Nothing is invalidated here, so blocks translated before this point
+     * are still live and still dispatch to each other without consulting
+     * cpu->breakpoints.  Stop the ones that can: a TCG vCPU dispatching
+     * inline reads a base pointer that this poisons, so the next dispatch
+     * takes the slow path and sees the new breakpoint.  @cpu may be another
+     * thread, and may be running.
+     */
+    tcg_cpu_poison_jmp_cache(cpu);
+
     trace_breakpoint_insert(cpu->cpu_index, pc, flags);
     return 0;
 }
diff --git ./include/hw/core/cpu.h ./include/hw/core/cpu.h
index 81af7b9ee1..bd2cdd2a0b 100644
--- ./include/hw/core/cpu.h
+++ ./include/hw/core/cpu.h
@@ -519,6 +519,15 @@ struct CPUState {
     MemoryRegion *memory;
 
     struct CPUJumpCache *tb_jmp_cache;
+    /*
+     * @tb_jmp_cache_probe: base the inline jump cache probe reads.
+     *
+     * Normally @tb_jmp_cache.  Pointed at a shared page of zeroes to force
+     * every inline dispatch to miss and fall back to helper_lookup_tb_ptr();
+     * see tcg_cpu_sync_jmp_cache().  NULL before tcg_exec_realizefn() and
+     * after tcg_exec_unrealizefn().
+     */
+    struct CPUJumpCache *tb_jmp_cache_probe;
 
     GArray *gdb_regs;
     int gdb_num_regs;
diff --git ./include/system/tcg.h ./include/system/tcg.h
index 2c2dbc753b..bf05db1329 100644
--- ./include/system/tcg.h
+++ ./include/system/tcg.h
@@ -29,6 +29,15 @@ extern bool tcg_allowed;
 void tcg_update_cflags(CPUState *cpu);
 void tcg_update_all_cflags(void);
 
+/*
+ * Force @cpu's generated code back into the slow dispatch path, which
+ * re-checks everything the inline jump cache probe assumes.  Safe to call
+ * from any thread, and a no-op for a CPU that is not running TCG.  Call
+ * whenever something the probe cannot see changes under a running vCPU;
+ * the main loop undoes it once the reason is gone.
+ */
+void tcg_cpu_poison_jmp_cache(CPUState *cpu);
+
 /**
  * qemu_tcg_mttcg_enabled:
  * Check whether we are running MultiThread TCG or not.
-- 
2.54.0


