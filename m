Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F9CC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSGV-0005pH-HK; Thu, 27 Aug 2026 01:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGR-0005oW-B8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:00 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGO-0002HZ-Jg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:02:59 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-836c91bd782so31336627b3.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806974; x=1788411774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2EEergYUCU7k8E/1bWPun6TvyEfD1Vl1lZgEJ9OgzXE=;
 b=ow16cGZookDyo6ck4NvwjM0He67OspazpjCzAL1SjKfHKr2SxsjTnzLOd1sKDOtDni
 SAp58roWXfWgc2Tl1o5COWMH1b37HPvVhgXsqhOubqgt9ud8Yo1YUy4fEMA8H2U4P/sI
 YdI7aZikLH+U01I9XCGclYu9Nl8IoiZZh8qC5MSyouXls/XpbRyztdjEn6/GTYo9H49f
 uSVThclL7vlnB6xpBi4IJeI6UTlgFVxCAotVh4vPfQNNrY6qODIXH9JPanhae783LZl3
 Gzmk2ExzCWx4X1yZEH+kySGoFNoN1c99M9hX26SxfNZ2cIFeJpRWJMbAYl6sfJywd8pC
 7utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806974; x=1788411774;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2EEergYUCU7k8E/1bWPun6TvyEfD1Vl1lZgEJ9OgzXE=;
 b=TqbDTYFPl1enJCUc3vZxaQdh9SHXP/VDpQnNguXtsgvp/IyYB/PTr/KQnj43sgYdgZ
 NOJdnBX8inJReYVQafB9nHmxbU9AduOBPDD3tzNeVQV3gLJsr0Wohn7p5ZVt/htJLBfC
 pvCYAY8nP93ITJHiR3Rv4Jbbqt9VavZ9W5SkjPw9vKCpUlZO7sOMCGemcvLJOT/PKjK7
 0aKkcY8/8caZ9tJ6DcosHdiemFkhmjQoIsL9vfOAMnqr/x0GZyV6AJ4REQGT/vbJlvcZ
 6lGGgeQGjY8SxNVJ5z3TZ4/FIMrEHCYoytJEYaYEk177ftg9AqrMSLEOmybcJ1QufsxI
 QQlA==
X-Gm-Message-State: AFuF++lMKyXGR1AsyDnY4U7ROnx6SswjJ9ZKVuDqzDib4Rlr0iCvQDRu
 D8mFbPPvBT7LTG8LVCAMMvwzga6k8FZajdb8Nb6m9zVmFfJP+vFhvWJfGJUz0L1D
X-Gm-Gg: AR+sD13Rr7vyw76Z7rffzXG0mMRNfaEDk6Xrwx5U+Sb2Qjwn7tuLRsCEqodACF0iPio
 7a9guU5z7ThqrxP+bEJh+s4lX+oU8Go8/cJbOaiSEiW+4rfv9US0CWlEu9uqnvnJkRKSkzwMvr1
 mz1/oTmm5CdC0OAVXWTC4SbZnvSSbclJ/3ez/1skORo8M/JQ0i4KrazrX9QTRXbW/WMhnt9HBx0
 WQER1aFtK5ifT1mWhDWIrJROrs8AL8pgnWnAgyHwe/l76X8jdlwh5kw76Y2sPNbeYcmxO5qGrfs
 ghIW4nk6TvbAOrg76Hfzz/Y/Aoh5jAPlkp2uM0opF4VaL6ec8gXPc/1qmxBF93RWSI2Ilpor8R+
 1vtD36Uki9eYGE/++BVx3uj0ptYUkWzJzkYpP4RBRzcTQOOEprt6oZTYVqPQRTcnAZB79vQm0oz
 HQn1al5YRufz5r5oXyy/7xk5AWzm8nIBs/inJt5+sfkr1OsbdZgPKSnQbxeSO9eBhVcxUx49WbH
 eDb4ZOdQkQ8HepknBFx2gzz4beh77SqOO/peE7s
X-Received: by 2002:a05:690c:e154:b0:7fd:4ef9:e5a4 with SMTP id
 00721157ae682-8574088a19bmr47564397b3.29.1787806973821; 
 Wed, 26 Aug 2026 22:02:53 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b61a406f2sm4146487b3.35.2026.08.26.22.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:02:52 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 0/9] accel/tcg: cut per-block dispatch overhead
Date: Thu, 27 Aug 2026 01:02:32 -0400
Message-ID: <20260827050241.3713332-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112d.google.com
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

For guests running large amounts of code, most of what TCG executes is not
translated guest work but the fixed overhead around it. Blocks are short and
there are a great many of them, so the constant cost at each end of a block
(the interrupt poll and the can_do_io stores on entry, the dispatch on exit)
ends up dominating everything else.

The workload throughout is qemu-alpha running an emulated alpha gcc 16.2.0
compiling the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64
host, in a --static --enable-lto --target-list=alpha-linux-user build. It
executes 34.2 billion TBs at 6.04 guest instructions each, and 24.6% of its
TB exits cannot use goto_tb. That is a representative shape for any guest
whose text is much larger than a page: indirect calls and returns
everywhere, plus direct branches that merely crossed a page boundary.

The first three patches are ordinary cleanups that stand on their own; patch
3 picked up review tags in v2. Patches 4 and 5 are preparation split out of
v3's patch 4 at Richard's request and move nothing on their own. The
remaining four are marked RFC individually and are where the interesting
questions are.

  1  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags

     curr_cflags() recomputed three unlikely tests on every one of the run's
     8.4 billion dispatches, from state that changes only when gdb enables
     single-step, when one-insn-per-tb is toggled, or when the log mask
     moves. Fold each into tcg_cflags where it changes.          -5.15%

  2  accel/tcg: enlarge the TB jump cache to 64K entries

     4096 entries is too small for a guest running a large program;
     tb_htable_lookup() is 6.10% of samples. 16 bits is the knee of the
     sizing curve, at 1 MiB per CPUState.               -5.92%, -8.71% wall

  3  accel/tcg: skip the can_do_io stores in user-only builds

     Two stores per TB that nothing in a user-only build reads: 68 billion
     of them over the run.                              -4.57%, -4.53% wall

  4  tcg: pass the destination to tcg_gen_lookup_and_goto_ptr()

     Preparation. The destination PC is already in a TCG temp at every one
     of the 38 call sites; give the helper wrapper the option of taking it
     rather than discarding it. Five targets pass it; the rest pass NULL
     and keep today's behavior.

  5  accel/tcg: give the TB jump cache a second base pointer for generated
     code

     Preparation. CPUState::tb_jmp_cache_probe is a base pointer only
     generated code reads. Pointing it at a shared zero-filled cache makes
     every lookup through it miss, which is how the conditions an inline
     probe cannot check force it back into the helper. Nothing reads it
     yet.

  6  RFC: tcg: probe the TB jump cache inline instead of calling a helper

     95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the jump
     cache. Emit the probe inline (hash, four guarded loads, goto_ptr) and
     call the helper only on a miss.                   -34.67%, -25.94% wall

  7  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds

     translator_use_goto_tb() refuses to chain across a page. In user-only
     builds the invalidation path already covers what that was protecting
     against: every mmap/mprotect/munmap reaches page_set_flags(), which
     invalidates and unlinks. Lift it there for runs that can never acquire
     a breakpoint, keep it for system mode.             -2.75%, -4.84% wall

  8  RFC: accel/tcg: poison the jump cache instead of polling for indirect
     exits

     A block only needs the icount_decr poll if it can leave by goto_tb;
     every other exit already passes through a dispatch. Poison the probe
     pointer from patch 5 when an exit is requested, so every dispatch
     misses into the helper, which returns the epilogue. Emit the poll only
     in blocks that emitted a goto_tb.                  -2.52%, -1.96% wall

  9  RFC: tcg: fold a guest displacement into the host addressing mode

     tcg_gen_qemu_ld/st cannot express a based access, so a target with a
     displacement in its encodings materializes the address with an lea
     that the host addressing mode would have done for free. Fold a
     preceding constant add into a new argument on the op, opt-in per
     backend, wired up for x86_64 user-only.            -5.70%, -3.20% wall

Each percentage is against the patch before it. Every stage was measured in
one session on the same host, so end to end, from an unmodified LTO build of
the same base to the full series:

    instructions retired: 1,646,994,254,249 -> 819,262,147,022   -50.26%
    wall clock:                     133.19s ->          77.30s   -41.96%

Those are the v3 measurements. The machine they were taken on is busy, so v4
has not been re-measured. Nothing in the v4 changes is expected to move them
-- the splits are pure reorganization, the new alignment test in patch 9
reaches the same answer for everything the alpha frontend emits, and the
emulated compiler's output is unchanged -- but they are not a measurement of
this posting and should not be read as one.

The two figures do not track each other, and that is the interesting part:
what the series removes is cheap, well-predicted, highly pipelined work, so
it retires far more instructions than it saves time. Patch 6 also cuts L1
icache load misses by 39.0%, because a dispatch no longer jumps into qemu's
.text and evicts translated code; qemu's own .text falls from 38.8% to 5.3%
of profile samples.

Every step builds and runs on its own, so the series bisects, and the
emulated compiler produces byte-identical assembly output at every step,
which is the correctness check these patches most need. Three new tests
cover the hazards the series creates, all under tests/tcg/multiarch as of
this revision: test-xpage-chain.c and gdbstub/xpage-bp.py (patch 7) and
test-indirect-irq.c (patch 8). Each fails or hangs if the mechanism it
covers is removed, which is what makes them tests of the new behavior rather
than of the old.

Changes since v3
================

The biggest change is that v3's patch 4 is split three ways, as Richard
asked: the tcg_gen_lookup_and_goto_ptr() API change is now patch 4, the
tb_jmp_cache_probe base pointer and its poison are patch 5, and the inline
probe itself is patch 6. The other structural change is that both guest
tests move from tests/tcg/alpha to tests/tcg/multiarch, as Alex asked, so
every *-user target runs them. tests/tcg/alpha is now byte-identical to
master again.

  1  Update the cflags from the HMP handlers for 'log' and
     'one-insn-per-tb' rather than from qemu_set_log_internal() and the
     accelerator property setter; those are the paths that reach a running
     vCPU, and the monitor is the only thing that does (Richard). Queue the
     per-CPU update with async_run_on_cpu() rather than
     async_safe_run_on_cpu(): halting the other vCPUs buys nothing, since
     the queued work already runs on the owning CPU's own thread (Alex).
     Alex also asked whether there are cross-vCPU updates of tcg_cflags at
     all; with this change the monitor path has none, and the only
     remaining writer from another thread is cpu_single_step(), which is
     neither new nor made worse here. Stub moved to accel/stubs/, where the
     other accelerator stubs live (Philippe).

  2  Commit message only: a linux-user process is not a single vCPU. The
     cache is per CPUState and linux-user creates one per guest thread, so
     a threaded guest pays the 1 MiB per thread, exactly as system
     emulation pays it per vCPU (Richard).

  3  Unchanged.

  4  New, split out of v3's patch 4. No functional change from v3. Its
     commit message no longer claims most targets can simply pass a PC:
     five do, six cannot because their TB pc is derived (avr doubles it,
     i386's is pre-segmentation, riscv masks it, hppa derives it from the
     IAQ, hexagon adjusts it in hardware loops, sparc puts npc in cs_base),
     and seven look like they could but are untested.

  5  Also new, split out of v3's patch 4. The poison cache is a static
     object rather than one allocated on first use (Richard, who asked for
     const; the commit message says why it is plain static and lands in
     .bss).

  6  What remains of v3's patch 4. Emit the softmmu form of
     tb_jmp_cache_hash_func() under CONFIG_SOFTMMU rather than the
     user-only form everywhere: v3 was wrong for system mode, and only not
     a correctness bug because a wrong index simply misses (Richard).
     Compare the pc before testing tb for NULL, assert that
     TranslationBlock::flags is 8-byte aligned since folding the two guards
     into one 64-bit load relies on it, zero-extend a 32-bit guest PC
     instead of falling back to the helper, and describe cs_base in the
     probe as a second word of target-specific flags rather than by name
     (all Richard).

  7  Test moved to tests/tcg/multiarch (Alex). The hand-written branch went
     with it: falling off the end of a page is a cross-page goto_tb just
     the same, and needs no per-architecture branch encoding or
     displacement arithmetic, only "set the return value" and "return".
     Built and run under qemu-user on aarch64, alpha, arm, hppa,
     loongarch64, m68k, mips, ppc, ppc64le, riscv64, s390x, sh4, sparc64
     and x86_64; ppc64 ELFv1 skips, because a function pointer there is a
     descriptor rather than a code address.

  8  Test likewise moved to tests/tcg/multiarch (Alex). Nothing in it is
     architecture specific: the loop is a computed goto, which every
     target's compiler supports, so it covers whichever targets go on to
     use the inline probe.

  9  Hoist the compilation mode tests -- tcg_use_softmmu and the 64-bit
     address type -- out of the backend hook into fold_ldst_disp(), so the
     loop is not entered at all when the mode rules the fold out. Pass
     MemOp rather than MemOpIdx to the hook; nothing about the mmu_idx is
     relevant to it. Move the alignment test into generic code as
     ldst_disp_needs_align(), so a backend need not repeat the
     atom_and_align_for_opc() call; the exact answer depends on the host's
     atomicity capabilities, which the generic pass does not know, so it
     answers for the most restrictive host. That is the same answer for
     everything the frontends actually emit, and conservative for the
     handful of MO_ATOM_WITHIN16 and MO_ATOM_SUBALIGN accesses. (All
     Richard.) What is left of the x86_64 hook is the guest_base test, so
     it now lives beside x86_guest_base under the CONFIG_USER_ONLY that
     declares it. Also refuse a displacement that does not fit the int32_t
     out_disp() takes, which is unreachable with any real guest_base but
     which the interface could not have carried.

What I would most like reviewed
===============================

  - Patch 7 reverses a deliberate decision made in d3a2a1d803 on the
    strength of an argument about the user-only invalidation paths, plus a
    gate on whether gdb can ever attach.

  - Patch 8's un-poison in the main loop races a concurrent poison from
    another thread. I believe the existing barrier around
    icount_decr.u16.high covers it, but my testing was single-threaded user
    mode.

  - Patch 6 treats cpu flags, cflags and cs_base as translation-time
    constants in its guards, reads a jump cache entry without qatomic_read(),
    and leaves one_insn_per_tb and -d nochain toggles visible only at the
    next non-inline exit.

  - Patch 9 only examines the immediately preceding op, refuses any access
    with a slow path (so user-only, and no alignment check), and leaves the
    i128 pairs alone. Richard asked whether the alignment test could stay on
    the base register when the displacement is itself aligned; it can, and
    the reason the fold is still refused there is the slow path handing
    addr_reg to the helper. Recording the displacement in TCGLabelQemuLdst
    and emitting one lea on the slow path would cover alignment-checked
    accesses too, at no fast path cost. Not attempted here.

  - Patch 2's 1 MiB per CPUState is easy to justify for a single-threaded
    linux-user process and less obvious for system emulation with many
    vCPUs, or for a heavily threaded guest. It may want to be sized per
    target or made tunable rather than raised unconditionally.

Patches 6 and 9 are wired up for alpha and x86_64 respectively; everything
else is target-independent, and no other backend changes behavior or needs
touching.

v3: https://lore.kernel.org/qemu-devel/20260822190818.1829249-1-mattst88@gmail.com/
v2: https://lore.kernel.org/qemu-devel/20260817190038.580257-1-mattst88@gmail.com/

Matt Turner (9):
  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags
  accel/tcg: enlarge the TB jump cache to 64K entries
  accel/tcg: skip the can_do_io stores in user-only builds
  tcg: pass the destination to tcg_gen_lookup_and_goto_ptr()
  accel/tcg: give the TB jump cache a second base pointer for generated
    code
  RFC: tcg: probe the TB jump cache inline instead of calling a helper
  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
  RFC: accel/tcg: poison the jump cache instead of polling for indirect
    exits
  RFC: tcg: fold a guest displacement into the host addressing mode

 accel/stubs/meson.build                       |   1 +
 accel/stubs/tcg-stub.c                        |  20 ++
 accel/tcg/cpu-exec-common.c                   |  33 +-
 accel/tcg/cpu-exec.c                          | 116 ++++++
 accel/tcg/internal-common.h                   |  13 +-
 accel/tcg/tb-jmp-cache.h                      |   2 +-
 accel/tcg/tcg-accel-ops.c                     |   1 +
 accel/tcg/translator.c                        |  94 ++++-
 cpu-common.c                                  |  11 +
 cpu-target.c                                  |   3 +
 gdbstub/user.c                                |  14 +
 include/gdbstub/user.h                        |  11 +
 include/hw/core/cpu.h                         |  11 +
 include/system/tcg.h                          |  21 ++
 include/tcg/tcg-op-common.h                   |  15 +-
 include/tcg/tcg-op.h                          |  12 +
 include/tcg/tcg-opc.h                         |   9 +-
 include/tcg/tcg.h                             |   2 +
 monitor/hmp-cmds.c                            |   5 +
 system/runstate-hmp-cmds.c                    |   4 +
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
 tcg/tcg-op-ldst.c                             |   3 +-
 tcg/tcg-op.c                                  | 142 +++++++-
 tcg/tcg.c                                     | 132 ++++++-
 tcg/x86_64/tcg-target.c.inc                   |  41 +++
 tcg/x86_64/tcg-target.h                       |   3 +
 tests/tcg/multiarch/Makefile.target           |  12 +-
 tests/tcg/multiarch/gdbstub/xpage-bp.py       |  37 ++
 tests/tcg/multiarch/test-indirect-irq.c       |  62 ++++
 tests/tcg/multiarch/test-xpage-chain.c        | 336 ++++++++++++++++++
 51 files changed, 1192 insertions(+), 63 deletions(-)
 create mode 100644 accel/stubs/tcg-stub.c
 create mode 100644 tests/tcg/multiarch/gdbstub/xpage-bp.py
 create mode 100644 tests/tcg/multiarch/test-indirect-irq.c
 create mode 100644 tests/tcg/multiarch/test-xpage-chain.c


base-commit: eea8fe61b8be8f3016e522e6af24924a0266ca95
-- 
2.54.0


