Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98275C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxr57-00048w-MF; Sat, 22 Aug 2026 15:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr55-00048a-RQ
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:39 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr51-0005lz-LL
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:39 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66c82b32121so3202486d50.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787425714; x=1788030514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z9P/7RakXdfn5VCCXUOm88mF4ZhBdXuP/baYPcdZBcI=;
 b=BbzipP0pRttYvhKD9o/bX07UAKwzmYy6x+7G4AjJUowEdh21dNrJ1putjZ1l53cDS8
 dLZ5Ew3M2M9EvBRZzXX/GlAlVFuauV7eu56GHPAv0+5eeppkc7hnKrpoIaClONceGHsf
 q539UzeK9noURaokXm64CFRnwIDYmaAUBAKtxK1NBfmvCP2Yi2nmITW6A35sEIoinwhD
 hcIgc7JsqPfSnzXFee5X9n2Fe0Ke042/H8WcV1pUhz16j5tu7i7W8C6IXz/QQNW5Bzsb
 pu6EsX+Oj4gUHF2ea0b01SIRHkQ12/JkIINspTTkEZpNj++N1rMO7UnrWsUEo/i64+WH
 rB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425714; x=1788030514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z9P/7RakXdfn5VCCXUOm88mF4ZhBdXuP/baYPcdZBcI=;
 b=lVk0JybZvDHSdiupW2E+ZewjYXBlX8N8r2m240Ed23TpEvtNie5/Np0xtPJTHmdM3f
 SSiEc6dKxiw4hAZyk09/7EpIz4C2uRUOM4uJOd3Z3oJdtYvZjY47HDxMy4Xl9XuS7I6T
 nWLLRHgjQjvFlIOUXs320iYI3d6OOSd0rMav8QNth6oJXAOc7bVoqdXwcIAGyy54kgYJ
 YQK13erwyQ3s6WymL9sECXeI+GdKpaO+btGYmbL5wUlKjfXHXzL8xp6jjONgIxm9dMOZ
 8MWemfSjluAYjbagUUS04HEsWj1ZIyUuXeNWC+ff62ZAgKgbVSk2OVXrWwYbwQEuy52S
 822w==
X-Gm-Message-State: AFuF++nKAkYTOwR9DAwlI4kfYk3FbZQNBJVDYDqynjl8ZitBS68KY3LO
 BSqL982VMbyyS5OYajv1BsWY4fVUBVtSZb+7ABDYNfILrb7C8a0bt7bXP94Gn/RJP8s=
X-Gm-Gg: AR+sD11Rak2hOL28UqeObd1sw2jctq9rahAmq1lOOkgmg3HQOyfnJIBNOfvSYu0dQx4
 0k+tZcLBYhoIdUUzAN59pUVLdEvA0a29IUVRKCgNe/egNH1xbJqORT7oKR5TSD9Qa/Az73kvi32
 kRaMnNoOBsVFdp4S1GfUnYPWm8m8SWevScQXRrWLPOaRBf9ExKeTtbT14GgMa8lDLCSU3Hc7DjN
 8OJcK39ejV5GIsaQSqeA9Afmrt1L0syB4ocp6M99oeuLqSS+s4zs+kz/RvoepVP9rsZXgs/IY8m
 6QLfQVzQ4F5TRsVQRHOWds+3rAD2fhU7aQljzbp4oIbrkHkob2H53+Nv39doMX0Uca1rbHScFYy
 iftN9TKnohzxdc3GbieNzZra37xK3DBa6r3b7TU5RGQ0i/mdhwTwV7Xu70mlfJRmmhp3xxDupGt
 11PQEV10czIUfoIP4xq5LlSNWtOdP6jDVGU00aaAag98VOA1WUK/yJ7CsMXVhZFMCHOuzE33+cP
 uOEGq4BPGGHRvEV1dJKHL4z+g96xhQuu050ydg5H0dTB2r4vBg=
X-Received: by 2002:a05:690e:450c:10b0:66c:3483:8261 with SMTP id
 956f58d0204a3-66cf21bc221mr1560116d50.34.1787425713935; 
 Sat, 22 Aug 2026 12:08:33 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cf4665056sm1205893d50.8.2026.08.22.12.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:08:33 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 4/7] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
Date: Sat, 22 Aug 2026 15:08:15 -0400
Message-ID: <20260822190818.1829249-5-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12c.google.com
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

Every indirect branch that cannot use goto_tb ends in
tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For an
emulated compiler that is 8.4 billion helper calls in a single translation
unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
register destination and because goto_tb is restricted to same-page
targets.

The helper itself is already tight, but each call pays for a call frame,
the can_do_io store, the get_tb_cpu_state() indirect call through
TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
jump cache probe that almost always hits (95.8% for this workload).

Emit the probe inline instead. The destination PC is already in a TCG
temp, and the flags, cflags and cs_base the destination must match are
constants at translation time, so the fast path is a hash, four guarded
loads and a goto_ptr. Only a miss calls the helper, which still owns
filling the cache.

tcg_gen_lookup_and_goto_ptr() therefore takes the destination PC and the
TB being generated, and decides for itself whether to emit the probe or
the old helper call; there is no second entry point for targets that opt
in. A target that cannot name its destination in a single temp passes
NULL and gets the helper. Since the probe hashes and compares the PC as
one 64-bit value, a 32-bit guest PC also falls back.

The PC a target passes must be exactly what get_tb_cpu_state() reports for
the destination, which is the whole of the contract. alpha, loongarch,
mips, ppc and s390x pass their PC register, whose value is that pc by
construction. The rest pass NULL for now: avr's TB pc is the word address
doubled, i386's is eip before segmentation, riscv masks it to 32 bits when
xl is MXL_RV32, hppa derives it from the IAQ, hexagon adjusts it inside a
hardware loop, and sparc puts npc in cs_base so the guard could not hit
anyway. Each of those is a one-line change for whoever wants to measure it.

Two details matter for the generated code. The flags and cflags guards are
folded into a single aligned 64-bit load and compare, since the fields are
adjacent. And each path emits its own goto_ptr rather than branching to a
shared one: a temp live across the label is spilled and reloaded on every
dispatch, which cost 6.3% on its own.

The probe cannot check everything the helper checks, and the one that
matters is breakpoints. check_for_breakpoints() raises EXCP_DEBUG on an
exact pc match and selects CF_BP_PAGE cflags for the rest of the page, and
setting a breakpoint deliberately invalidates no TB, so a block translated
before the breakpoint was set is still sitting in the jump cache. Rather
than pay for a breakpoint test on the fast path, give the probe its own
base pointer, tb_jmp_cache_probe, that nothing else reads, and point it at
a page of zeroes while any breakpoint is set. Every entry the probe finds
then has a NULL tb, so every dispatch misses into the helper and the old
behaviour is restored exactly. cpu_breakpoint_insert() poisons the pointer,
so the poison takes effect at the next dispatch rather than whenever that
vCPU next reaches its main loop, which matters because a vCPU chaining
indirectly need never reach it. The main loop puts the pointer back once the
last breakpoint is gone; that is a load and a compare per block dispatched
from the main loop, and nothing at all in generated code.

The flags and cflags constants are safe against the other things that can
change them. CF_PARALLEL is only ever set by begin_parallel_context(),
which flushes first, so no block predating it survives to dispatch. gdb
single-step is only turned on with the CPU stopped, and a block translated
without CF_SINGLE_STEP can only be re-entered through tb_lookup(), which
from then on demands the new cflags -- so a stale-cflags block is never the
one running. What is left is one_insn_per_tb and -d nochain, which the
monitor can toggle under a running vCPU without a flush; see below.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
build, on top of the preceding three patches:

    before: 1,402,667,803,616 instructions
    after:    916,415,123,244 instructions   -34.67%

    before: 115.56s wall clock
    after:   85.59s wall clock               -25.94%

The gap between the two is the point at which this stops being a
straight-line win: the helper call was highly predictable work that the
host pipelined well, so removing it retires far fewer instructions than it
saves time. IPC falls from 2.48 to 2.17 across this patch for that reason.

Despite emitting more code, this also reduces instruction cache pressure,
because a dispatch no longer jumps into qemu's .text and evicts translated
code:

    before: 11,735,141,703 L1-icache-load-misses
    after:   7,154,863,292 L1-icache-load-misses   -39.0%

The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
falls from 31.01% of samples to 0.35%, and qemu's own .text falls from
38.8% to 5.3%, with the balance moving into generated code.

Combined with the three preceding patches, against an unmodified LTO
build, 1,646,994,254,249 instructions fall to 916,415,123,244, or -44.36%.
The emulated compiler produces byte-identical output throughout.

Open issues, hence RFC:

- one_insn_per_tb and CPU_LOG_TB_NOCHAIN can be toggled from the monitor
  while a vCPU is inside a block that was translated without them. The
  block keeps dispatching inline with the old cflags until it exits for
  some other reason. Poisoning the probe from
  tcg_update_all_curr_cflags() would close it.
- The jump cache entry is read without qatomic_read(); entries are
  invalidated concurrently by setting tb to NULL.
- Only alpha has been measured. The other four targets that pass a PC are
  built and boot-tested only.

v3: Fold the fast path into tcg_gen_lookup_and_goto_ptr() instead of
    adding tcg_gen_lookup_and_goto_ptr_inline() beside it (Richard). It
    now takes the destination PC and the TB unconditionally, from all 38
    call sites, and picks the probe or the helper itself. Translators
    built for both values of TARGET_LONG_BITS -- arm, s390x, microblaze --
    cannot include tcg-op.h, so the common entry point takes a TCGTemp and
    reads the width from it, and tcg-op.h wraps that for everyone else;
    this is the same split as tcg_gen_qemu_ld_*_chk().

    Compare cs_base too. v2 listed this as an open issue, and closing it
    is what lets the choice be made generically rather than per target: a
    target that uses cs_base would otherwise have been enabled silently by
    a decision keyed on PC width alone. It costs a load and a compare on
    the fast path, and the numbers above were measured with it in place.

    Audited which targets may pass a real PC, the contract being that it
    is exactly what get_tb_cpu_state() reports for the destination. Five
    do; the rest pass NULL and keep the helper call, sparc among them
    because it puts npc in cs_base and so could essentially never hit.

    Poison the probe from cpu_breakpoint_insert() rather than only from
    the poisoned CPU's own main loop. gdb inserts a breakpoint into every
    CPU (tcg_insert_gdbstub_breakpoint()), and a thread already inside
    generated code, dispatching indirectly, need never return to the main
    loop -- so it would keep dispatching inline and run past a breakpoint
    another thread had just set. Upstream has no such window: its
    helper_lookup_tb_ptr() sees the new breakpoint at the next indirect
    branch. The un-poison in tcg_cpu_sync_jmp_cache() now re-checks after
    its store, with a barrier, so that it loses the race with a concurrent
    insert in the safe direction.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/cpu-exec.c                          | 102 ++++++++++++++++++
 accel/tcg/internal-common.h                   |   2 +
 cpu-common.c                                  |  11 ++
 include/hw/core/cpu.h                         |   9 ++
 include/system/tcg.h                          |   9 ++
 include/tcg/tcg-op-common.h                   |  16 ++-
 include/tcg/tcg-op.h                          |  12 +++
 stubs/tcg-cflags.c                            |   8 +-
 target/alpha/translate.c                      |   4 +-
 target/arm/tcg/translate-a64.c                |   4 +-
 target/arm/tcg/translate.c                    |  10 +-
 target/avr/translate.c                        |   4 +-
 target/hexagon/translate.c                    |   4 +-
 target/hppa/translate.c                       |   6 +-
 target/i386/tcg/translate.c                   |   2 +-
 .../tcg/insn_trans/trans_branch.c.inc         |   2 +-
 target/loongarch/tcg/translate.c              |   4 +-
 target/m68k/translate.c                       |   2 +-
 target/microblaze/translate.c                 |   4 +-
 target/mips/tcg/nanomips_translate.c.inc      |   2 +-
 target/mips/tcg/translate.c                   |   6 +-
 target/or1k/translate.c                       |   4 +-
 target/ppc/translate.c                        |   4 +-
 target/riscv/tcg/insn_trans/trans_rvzce.c.inc |   4 +-
 target/riscv/tcg/translate.c                  |   2 +-
 target/rx/translate.c                         |   4 +-
 target/s390x/tcg/translate.c                  |   5 +-
 target/sh4/translate.c                        |   4 +-
 target/sparc/translate.c                      |   4 +-
 target/tricore/translate.c                    |   4 +-
 tcg/tcg-op.c                                  |  92 +++++++++++++++-
 31 files changed, 300 insertions(+), 50 deletions(-)

diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
index 148e0f583e..e546f717e8 100644
--- ./accel/tcg/cpu-exec.c
+++ ./accel/tcg/cpu-exec.c
@@ -752,6 +752,99 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
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
+ * Only ever read from, and only the tb field of one entry per dispatch, so
+ * one shared zero-filled cache is enough for every CPU.
+ */
+static const CPUJumpCache *tb_jmp_cache_poison(void)
+{
+    static CPUJumpCache *poison;
+
+    if (unlikely(poison == NULL)) {
+        /* Raced allocations are harmless: both are all zeroes. */
+        qatomic_cmpxchg(&poison, NULL, g_new0(CPUJumpCache, 1));
+    }
+    return poison;
+}
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
+        qatomic_set(&cpu->tb_jmp_cache_probe,
+                    (CPUJumpCache *)tb_jmp_cache_poison());
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
+           : (CPUJumpCache *)tb_jmp_cache_poison();
+
+    if (qatomic_read(&cpu->tb_jmp_cache_probe) != want) {
+        qatomic_set(&cpu->tb_jmp_cache_probe, want);
+
+        /*
+         * Un-poisoning races a concurrent tcg_cpu_poison_jmp_cache(): the
+         * reason may have appeared after tcg_cpu_may_dispatch() read it and
+         * the poison may have landed before the store above.  Order the
+         * store against a re-read, and lose the race in the safe direction.
+         */
+        if (want == cpu->tb_jmp_cache) {
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
@@ -964,6 +1057,13 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
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
@@ -1072,6 +1172,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     tcg_update_cflags(cpu);
 
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
+    qatomic_set(&cpu->tb_jmp_cache_probe, cpu->tb_jmp_cache);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1089,5 +1190,6 @@ void tcg_exec_unrealizefn(CPUState *cpu)
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
diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
index 9b321f959c..ba580c7fb7 100644
--- ./include/tcg/tcg-op-common.h
+++ ./include/tcg/tcg-op-common.h
@@ -75,15 +75,25 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx);
 void tcg_gen_goto_tb(unsigned idx);
 
 /**
- * tcg_gen_lookup_and_goto_ptr() - look up the current TB, jump to it if valid
- * @addr: Guest address of the target TB
+ * tcg_gen_lookup_and_goto_ptr() - look up the destination TB, jump to it
+ * @pc: temp holding the destination guest PC, or NULL
+ * @tb: the translation block being generated
  *
  * If the TB is not valid, jump to the epilogue.
  *
+ * The lookup is normally a call to helper_lookup_tb_ptr().  If @pc is
+ * non-NULL and the destination can be keyed on it directly, the jump cache
+ * is probed inline instead and only a miss reaches the helper.  @pc must
+ * then hold exactly the value get_tb_cpu_state() reports as the pc for the
+ * destination; a target whose pc is derived (avr's word address, i386's
+ * eip before segmentation) must pass NULL.  The destination is required to
+ * match @tb's flags, cflags and cs_base, which is what makes them
+ * constants in the probe.
+ *
  * This operation is optional. If the TCG backend does not implement goto_ptr,
  * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
  */
-void tcg_gen_lookup_and_goto_ptr(void);
+void tcg_gen_lookup_and_goto_ptr_tmp(TCGTemp *pc, const TranslationBlock *tb);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
diff --git ./include/tcg/tcg-op.h ./include/tcg/tcg-op.h
index 3721164236..b6c7c6fea2 100644
--- ./include/tcg/tcg-op.h
+++ ./include/tcg/tcg-op.h
@@ -49,6 +49,18 @@ typedef TCGv_i64 TCGv;
 #error Unhandled TARGET_LONG_BITS value
 #endif
 
+/*
+ * See tcg_gen_lookup_and_goto_ptr_tmp().  @pc may be NULL, for a target
+ * whose guest PC is not directly the key the jump cache is indexed by.
+ * A translator that is built for more than one value of TARGET_LONG_BITS,
+ * and so cannot include this header, calls the _tmp() form directly.
+ */
+static inline void
+tcg_gen_lookup_and_goto_ptr(TCGv pc, const TranslationBlock *tb)
+{
+    tcg_gen_lookup_and_goto_ptr_tmp(pc ? tcgv_tl_temp(pc) : NULL, tb);
+}
+
 #if TARGET_LONG_BITS == 64
 #define tcg_gen_movi_tl tcg_gen_movi_i64
 #define tcg_gen_mov_tl tcg_gen_mov_i64
diff --git ./stubs/tcg-cflags.c ./stubs/tcg-cflags.c
index cb278e94aa..4ac8a82e92 100644
--- ./stubs/tcg-cflags.c
+++ ./stubs/tcg-cflags.c
@@ -1,6 +1,6 @@
 /*
- * Stub for tcg_update_all_cflags(), for binaries that link util/log.c
- * or cpu-target.c but not TCG.
+ * Stubs for the TCG entry points in system/tcg.h, for binaries that link
+ * util/log.c, cpu-target.c or cpu-common.c but not TCG.
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
diff --git ./target/alpha/translate.c ./target/alpha/translate.c
index c66e3f9c14..822f5cc120 100644
--- ./target/alpha/translate.c
+++ ./target/alpha/translate.c
@@ -449,7 +449,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
     }
 }
 
@@ -2917,7 +2917,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_pc_disp(ctx, cpu_pc, 0);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
         break;
     case DISAS_PC_UPDATED_NOCHAIN:
         tcg_gen_exit_tb(NULL, 0);
diff --git ./target/arm/tcg/translate-a64.c ./target/arm/tcg/translate-a64.c
index 4f9a93950b..d1dd33a1af 100644
--- ./target/arm/tcg/translate-a64.c
+++ ./target/arm/tcg/translate-a64.c
@@ -562,7 +562,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
         if (s->ss_active) {
             gen_step_complete_exception(s);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, s->base.tb);
             s->base.is_jmp = DISAS_NORETURN;
         }
     }
@@ -11250,7 +11250,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_a64_update_pc(dc, 4);
             /* fall through */
         case DISAS_JUMP:
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
             break;
         case DISAS_NORETURN:
         case DISAS_SWI:
diff --git ./target/arm/tcg/translate.c ./target/arm/tcg/translate.c
index c866148383..ca701b9cbc 100644
--- ./target/arm/tcg/translate.c
+++ ./target/arm/tcg/translate.c
@@ -1306,9 +1306,9 @@ void write_neon_element64(TCGv_i64 src, int reg, int ele, MemOp memop)
     }
 }
 
-static void gen_goto_ptr(void)
+static void gen_goto_ptr(DisasContext *s)
 {
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr_tmp(NULL, s->base.tb);
 }
 
 /* This will end the TB but doesn't guarantee we'll return to
@@ -1336,7 +1336,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
         tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
     } else {
         gen_update_pc(s, diff);
-        gen_goto_ptr();
+        gen_goto_ptr(s);
     }
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1373,7 +1373,7 @@ static void gen_jmp_tb(DisasContext *s, int64_t diff, int tbno)
          * and don't chain to another TB.
          */
         gen_update_pc(s, diff);
-        gen_goto_ptr();
+        gen_goto_ptr(s);
         s->base.is_jmp = DISAS_NORETURN;
         break;
     default:
@@ -6858,7 +6858,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_update_pc(dc, curr_insn_len(dc));
             /* fall through */
         case DISAS_JUMP:
-            gen_goto_ptr();
+            gen_goto_ptr(dc);
             break;
         case DISAS_UPDATE_EXIT:
             gen_update_pc(dc, curr_insn_len(dc));
diff --git ./target/avr/translate.c ./target/avr/translate.c
index 3c57606097..8f2e0baa67 100644
--- ./target/avr/translate.c
+++ ./target/avr/translate.c
@@ -992,7 +992,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
         tcg_gen_exit_tb(tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -2778,7 +2778,7 @@ static void avr_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         /* fall through */
     case DISAS_LOOKUP:
         if (!force_exit) {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
             break;
         }
         /* fall through */
diff --git ./target/hexagon/translate.c ./target/hexagon/translate.c
index 06a8159d28..cc230b08d1 100644
--- ./target/hexagon/translate.c
+++ ./target/hexagon/translate.c
@@ -181,7 +181,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
         if (move_to_pc) {
             tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], dest);
         }
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
 }
 
@@ -218,7 +218,7 @@ static void gen_end_tb(DisasContext *ctx)
         gen_set_label(skip);
         gen_goto_tb(ctx, 1, ctx->next_PC, false);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
 
     ctx->base.is_jmp = DISAS_NORETURN;
diff --git ./target/hppa/translate.c ./target/hppa/translate.c
index 002189ddfb..cf8f1a2c13 100644
--- ./target/hppa/translate.c
+++ ./target/hppa/translate.c
@@ -816,7 +816,7 @@ static void gen_goto_tb(DisasContext *ctx, int which,
         tcg_gen_goto_tb(which);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
 }
 
@@ -2027,7 +2027,7 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
         store_psw_xb(ctx, PSW_B);
     }
 
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 }
@@ -4838,7 +4838,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         }
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         break;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
diff --git ./target/i386/tcg/translate.c ./target/i386/tcg/translate.c
index 2115c5cd24..66a0ee3cdf 100644
--- ./target/i386/tcg/translate.c
+++ ./target/i386/tcg/translate.c
@@ -2005,7 +2005,7 @@ gen_eob(DisasContext *s, int mode)
     } else if (mode == DISAS_JUMP &&
                /* give irqs a chance to happen */
                !inhibit_reset) {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, s->base.tb);
     } else {
         tcg_gen_exit_tb(NULL, 0);
     }
diff --git ./target/loongarch/tcg/insn_trans/trans_branch.c.inc ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
index da07778658..57d9d47353 100644
--- ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ ./target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -27,7 +27,7 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
     tcg_gen_mov_tl(cpu_pc, addr);
     tcg_gen_movi_tl(dest, make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_set_gpr(a->rd, dest, EXT_NONE);
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
diff --git ./target/loongarch/tcg/translate.c ./target/loongarch/tcg/translate.c
index 124dce6269..a45a51852a 100644
--- ./target/loongarch/tcg/translate.c
+++ ./target/loongarch/tcg/translate.c
@@ -111,7 +111,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
     }
 }
 
@@ -311,7 +311,7 @@ static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_pc, ctx->base.tb);
         break;
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, ctx->base.pc_next);
diff --git ./target/m68k/translate.c ./target/m68k/translate.c
index 138c89d3e5..73691bc0d1 100644
--- ./target/m68k/translate.c
+++ ./target/m68k/translate.c
@@ -6095,7 +6095,7 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         if (dc->ss_active) {
             gen_raise_exception_format2(dc, EXCP_TRACE, dc->pc_prev);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
         }
         break;
     case DISAS_EXIT:
diff --git ./target/microblaze/translate.c ./target/microblaze/translate.c
index 8b219afb5d..851b372f8f 100644
--- ./target/microblaze/translate.c
+++ ./target/microblaze/translate.c
@@ -127,7 +127,7 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(dc->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_tmp(NULL, dc->base.tb);
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -1764,7 +1764,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         /* Indirect jump (or direct jump w/ goto_tb disabled) */
         tcg_gen_mov_i32(cpu_pc, cpu_btarget);
         tcg_gen_discard_i32(cpu_btarget);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_tmp(NULL, dc->base.tb);
         return;
 
     default:
diff --git ./target/mips/tcg/nanomips_translate.c.inc ./target/mips/tcg/nanomips_translate.c.inc
index 4b0b01ba37..007e29f9ac 100644
--- ./target/mips/tcg/nanomips_translate.c.inc
+++ ./target/mips/tcg/nanomips_translate.c.inc
@@ -2406,7 +2406,7 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
 
     /* unconditional branch to register */
     tcg_gen_mov_tl(cpu_PC, btarget);
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
 }
 
 /* nanoMIPS Branches */
diff --git ./target/mips/tcg/translate.c ./target/mips/tcg/translate.c
index e3467d1525..73abfbb5d4 100644
--- ./target/mips/tcg/translate.c
+++ ./target/mips/tcg/translate.c
@@ -4374,7 +4374,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         gen_save_pc(dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
     }
 }
 
@@ -11014,7 +11014,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
             } else {
                 tcg_gen_mov_tl(cpu_PC, btarget);
             }
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
             break;
         default:
             LOG_DISAS("unknown branch 0x%x\n", proc_hflags);
@@ -15244,7 +15244,7 @@ static void mips_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
         gen_save_pc(ctx->base.pc_next);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_PC, ctx->base.tb);
         break;
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
diff --git ./target/or1k/translate.c ./target/or1k/translate.c
index eb4485312f..4907284a6d 100644
--- ./target/or1k/translate.c
+++ ./target/or1k/translate.c
@@ -1605,7 +1605,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             /* The jump destination is indirect/computed; use jmp_pc.  */
             tcg_gen_mov_i32(cpu_pc, jmp_pc);
             tcg_gen_discard_i32(jmp_pc);
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
             break;
         }
         /* The jump destination is direct; use jmp_pc_imm.
@@ -1622,7 +1622,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         }
         tcg_gen_movi_i32(cpu_pc, jmp_dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
         break;
 
     case DISAS_EXIT:
diff --git ./target/ppc/translate.c ./target/ppc/translate.c
index 06ed2adf10..42924281b0 100644
--- ./target/ppc/translate.c
+++ ./target/ppc/translate.c
@@ -3664,7 +3664,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_nip, ctx->base.tb);
     }
 }
 
@@ -6690,7 +6690,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(cpu_nip, ctx->base.tb);
         break;
 
     case DISAS_EXIT_UPDATE:
diff --git ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc
index 71b4ca5473..3f1e7c039e 100644
--- ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc
+++ ./target/riscv/tcg/insn_trans/trans_rvzce.c.inc
@@ -213,7 +213,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
         }
 #endif
         tcg_gen_mov_tl(cpu_pc, ret_addr);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         ctx->base.is_jmp = DISAS_NORETURN;
     }
 
@@ -334,7 +334,7 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
 
     tcg_gen_mov_tl(cpu_pc, addr);
 
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
diff --git ./target/riscv/tcg/translate.c ./target/riscv/tcg/translate.c
index 9684dbe752..8475ab43b4 100644
--- ./target/riscv/tcg/translate.c
+++ ./target/riscv/tcg/translate.c
@@ -287,7 +287,7 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
         gen_helper_itrigger_match(tcg_env);
     }
 #endif
-    tcg_gen_lookup_and_goto_ptr();
+    tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
 }
 
 static void exit_tb(DisasContext *ctx)
diff --git ./target/rx/translate.c ./target/rx/translate.c
index 132d495710..e5a9783d84 100644
--- ./target/rx/translate.c
+++ ./target/rx/translate.c
@@ -161,7 +161,7 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(dc->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -2242,7 +2242,7 @@ static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         gen_goto_tb(ctx, 0, dcbase->pc_next);
         break;
     case DISAS_JUMP:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         break;
     case DISAS_UPDATE:
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
diff --git ./target/s390x/tcg/translate.c ./target/s390x/tcg/translate.c
index 1b6023168b..607c039419 100644
--- ./target/s390x/tcg/translate.c
+++ ./target/s390x/tcg/translate.c
@@ -1162,7 +1162,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         tcg_gen_goto_tb(0);
         tcg_gen_exit_tb(s->base.tb, 0);
     } else {
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr_tmp(tcgv_i64_temp(psw_addr), s->base.tb);
     }
 
     gen_set_label(lab);
@@ -6477,7 +6477,8 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (dc->exit_to_mainloop) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr_tmp(tcgv_i64_temp(psw_addr),
+                                            dc->base.tb);
         }
         break;
     default:
diff --git ./target/sh4/translate.c ./target/sh4/translate.c
index 373950fd66..a4be456bd9 100644
--- ./target/sh4/translate.c
+++ ./target/sh4/translate.c
@@ -242,7 +242,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         }
     }
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -258,7 +258,7 @@ static void gen_jump(DisasContext * ctx)
         if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         }
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
diff --git ./target/sparc/translate.c ./target/sparc/translate.c
index 3156be6a94..2ae0a02c44 100644
--- ./target/sparc/translate.c
+++ ./target/sparc/translate.c
@@ -376,7 +376,7 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx,
         /* jump to another page: we can use an indirect jump */
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, s->base.tb);
     }
 }
 
@@ -5807,7 +5807,7 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             tcg_gen_movi_tl(cpu_npc, dc->npc);
         }
         if (may_lookup) {
-            tcg_gen_lookup_and_goto_ptr();
+            tcg_gen_lookup_and_goto_ptr(NULL, dc->base.tb);
         } else {
             tcg_gen_exit_tb(NULL, 0);
         }
diff --git ./target/tricore/translate.c ./target/tricore/translate.c
index 8cd6b58f66..1d7f54f6df 100644
--- ./target/tricore/translate.c
+++ ./target/tricore/translate.c
@@ -2857,7 +2857,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_index);
     } else {
         gen_save_pc(dest);
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -8478,7 +8478,7 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         tcg_gen_exit_tb(NULL, 0);
         break;
     case DISAS_JUMP:
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_lookup_and_goto_ptr(NULL, ctx->base.tb);
         break;
     case DISAS_NORETURN:
         break;
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index 28d3b2a847..ce77541eab 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -28,6 +28,8 @@
 #include "tcg/tcg-op-common.h"
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
+#include "hw/core/cpu.h"
+#include "../accel/tcg/tb-jmp-cache.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
@@ -2715,7 +2717,81 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
-void tcg_gen_lookup_and_goto_ptr(void)
+static void gen_jmp_cache_probe(TCGv_i64 pc, const TranslationBlock *tb)
+{
+    TCGv_ptr jc, ent, tbp, ptr;
+    TCGv_i64 h, tmp;
+    TCGLabel *slow;
+    uint64_t fpair;
+
+    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
+                      offsetof(TranslationBlock, flags) + 4);
+
+    jc = tcg_temp_ebb_new_ptr();
+    ent = tcg_temp_ebb_new_ptr();
+    tbp = tcg_temp_ebb_new_ptr();
+    ptr = tcg_temp_ebb_new_ptr();
+    h = tcg_temp_ebb_new_i64();
+    tmp = tcg_temp_ebb_new_i64();
+    slow = gen_new_label();
+
+    /* h = tb_jmp_cache_hash_func(pc) * sizeof(array[0]) */
+    tcg_gen_shri_i64(h, pc, TB_JMP_CACHE_BITS);
+    tcg_gen_xor_i64(h, h, pc);
+    tcg_gen_andi_i64(h, h, TB_JMP_CACHE_SIZE - 1);
+    tcg_gen_shli_i64(h, h, 4);
+
+    /*
+     * Not cpu->tb_jmp_cache: the probe reads its own base so that the main
+     * loop can poison it, which is how conditions the probe cannot test for
+     * itself force every dispatch back into the helper.  See
+     * tcg_cpu_sync_jmp_cache().
+     */
+    tcg_gen_ld_ptr(jc, tcg_env,
+                   offsetof(CPUState, tb_jmp_cache_probe) - sizeof(CPUState));
+    tcg_gen_trunc_i64_ptr(ent, h);
+    tcg_gen_add_ptr(ent, jc, ent);
+
+    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
+    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
+
+    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);
+
+    /*
+     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
+     * and compare covers both.
+     */
+#if HOST_BIG_ENDIAN
+    fpair = ((uint64_t)tb->flags << 32) | tb->cflags;
+#else
+    fpair = ((uint64_t)tb->cflags << 32) | tb->flags;
+#endif
+    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);
+
+    /*
+     * The destination must have been translated with the same cs_base, which
+     * the pc alone does not imply on a target that uses it.
+     */
+    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, cs_base));
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, tb->cs_base, slow);
+
+    tcg_gen_ld_ptr(ptr, tbp, offsetof(TranslationBlock, tc.ptr));
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+
+    /*
+     * Emit a second goto_ptr rather than branching to a shared one: a temp
+     * live across the label would be spilled and reloaded on every dispatch.
+     */
+    gen_set_label(slow);
+    ptr = tcg_temp_ebb_new_ptr();
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+}
+
+void tcg_gen_lookup_and_goto_ptr_tmp(TCGTemp *pc, const TranslationBlock *tb)
 {
     TCGv_ptr ptr;
 
@@ -2724,7 +2800,21 @@ void tcg_gen_lookup_and_goto_ptr(void)
         return;
     }
 
+    /*
+     * No icount_decr poll is needed for this exit: the helper is called on
+     * every dispatch and returns to the main loop while an exit is pending.
+     */
     plugin_gen_disable_mem_helpers();
+
+    /*
+     * The inline probe hashes and compares the pc as a single 64-bit value.
+     * A target with a 32-bit guest PC keeps the helper call.
+     */
+    if (pc && pc->type == TCG_TYPE_I64) {
+        gen_jmp_cache_probe(temp_tcgv_i64(pc), tb);
+        return;
+    }
+
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-- 
2.54.0


