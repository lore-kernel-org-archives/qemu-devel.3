Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDE8C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUS-0000b7-0p; Mon, 31 Aug 2026 23:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUP-0000a3-Dq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:49 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUL-0004Ks-Nl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:49 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66c7127a73dso3837811d50.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234524; x=1788839324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eWjXDAoAoNO1Xa1CL1NbLIHI1iMJN5aLKQTrDCXvIg0=;
 b=kx6SyDg3Ye/bYZwVxi6c/dQekB0+uzmg7+SucTm+rz99x23vrwikVt4nv4E83/hcrB
 NxujaYcZbP/1RX1VDiDKA4DMkgM3i4z2PKalvVSMFk+n+5p3SMX4mQckwFatDXCN2DX/
 dbGOq17RmirpIAilBQYVt9l8qUjvEkmAlgwtjS/1GNHpRm51zzD+WOulMiAqMmWwBvHK
 cFoAO00gt5aZsWiU5VPcpVBPYpYv/j2Hm0KuX/rcxF9Z/57wpgvyhbPu8zUUJ+Z6eouC
 mOtjS0chWsD7KpT/sdpkMFGndTqk1WupLuPT1YRS1BBeTh1wGXJglS/+z3tbIE7en2CD
 VY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234524; x=1788839324;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eWjXDAoAoNO1Xa1CL1NbLIHI1iMJN5aLKQTrDCXvIg0=;
 b=jiGfBZ+2t4KDqYP3HhXoO+xZUsucXeEwkDZnOpBRqEqZ7ZQv/x7JX+3eY5YdI2BA8Q
 NHlkVfjyMZaEVoSykt9aUO6nH/Mo8uQTk+fB4diKNdGdeGTpozmjHj4BxdA8OXCW1k1l
 xNw1bWzidR2qdCSgeHtv+YYkdgiAvTz8fNBj9Zu346v4MOIozAmbN7Cr/e9KJn8SxdRv
 HmEw+qtw5IzYD67GYFXJXFnkTo5jGIrELjzWFuS1zqtinqCsR1A1ndrHCinhVkfv42dx
 ZONIESr2wqWlo+FmXwr6BA1hoc9xGKHzt49zsMh6GCGpaoU7MKwmG5D6rNcCkDzvra8a
 xoeA==
X-Gm-Message-State: AFuF++kRyYhM3d+EKg9PJKQh++91a4Z84Q7McP4jW2SJ/j3WO/LjScvZ
 9tgGqzLQSa9qAf+dY976d5oLVyBa5cFLurzS+BeM2fQQEZhq1y5f2pKI7/D1Zg==
X-Gm-Gg: AYBFou2s2zxWpbHXFV195VY4lJV2WSmjFvRJ1ni/0dOhSeQ4eJjsXX6xum/VeQTKPO/
 JTpUNKZnzl5I6T3uxRdLmKF1RljFO0P3lkSpS/pcb/Y0w3dF6QYW1zv/baqq8WrG3PfnzVYAgp+
 9gfDqx20rI1TNzBZB08Ce3Ja5p8Pe8EwMFpQylg4AXzR9pgrhaFhZA5sOaK09IuiWr4I28GsBU9
 y87t2VmgjfYdqa+785fI1OwFwLe6x66umeBawabwsI9xCfiQY91JPRm9Dl6IdCPWc7x4MGoEizi
 B0scdzLslgqZIMkL46+kRk5tZlA5POm+oEipq/43yKk0nAbbp82ijETYu2sQ1M7u8FSSx9ZunIU
 EcoGcGGI1LQTZP72mDwKmmTXQhjmJPi0yZkqP0MYL/hTLF0/5+gC3RCzUXqzQlzayaZMZyN5m5H
 2tbyrHzYSLAlDQyinjm62vrUwuYjlvppf2hXkn9VxMkwp3MjMfIxm847XYjN81bzOa6QoUc3wSt
 5OvE9iG0biPDXnCO/7CHWjTgvMN33Oz5bZamA63L/YjiFzNyo4=
X-Received: by 2002:a53:d848:0:b0:66d:1e2e:9cd0 with SMTP id
 956f58d0204a3-66e4c6db69bmr7199812d50.28.1788234521805; 
 Mon, 31 Aug 2026 20:48:41 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66e4ecf24a6sm7518849d50.11.2026.08.31.20.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:40 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 0/9] accel/tcg: cut per-block dispatch overhead
Date: Mon, 31 Aug 2026 23:47:59 -0400
Message-ID: <20260901034808.3524945-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827050241.3713332-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb133.google.com
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
1 picked up a review tag in v4 and patch 3 in v2. Patches 4 and 5 are
preparation and move nothing on their own. The remaining four are marked RFC
individually and are where the interesting questions are.

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

  4  tcg: add tcg_gen_goto_jc_{i32,i64,tl}()

     Preparation. A second dispatch interface alongside
     tcg_gen_lookup_and_goto_ptr(), which is unchanged. The caller passes
     the destination PC and thereby states that the CPU state is already
     the destination's, which is what an inline lookup needs and what the
     existing interface cannot promise. --enable-debug-tcg checks that
     claim at runtime. Five targets are migrated; every other target and
     every unmigrated call site is untouched.

  5  accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present

     Preparation. The one thing an inline jump cache probe cannot check is
     breakpoints, and it does not have to: the probe compares cflags, so a
     cflag set while cpu->breakpoints is non-empty keeps such blocks both
     from dispatching inline and from being reached by a block that does.
     Nothing reads it yet.

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
     every other exit already passes through a dispatch. Give generated
     code its own jump cache base pointer and point it at a read-only page
     of zeroes when an exit is requested, so every dispatch misses into the
     helper, which returns the epilogue. Emit the poll only in blocks that
     emitted a goto_tb.                                 -2.52%, -1.96% wall

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

Those are still the v3 measurements, unchanged and not re-run; the machine
they were taken on is busy. Nothing in v4 or v5 is expected to move them --
both revisions are reorganization, and the emulated compiler's output is
still byte-identical -- but they are not a measurement of this posting and
should not be read as one.

The two figures do not track each other, and that is the interesting part:
what the series removes is cheap, well-predicted, highly pipelined work, so
it retires far more instructions than it saves time. Patch 6 also cuts L1
icache load misses by 39.0%, because a dispatch no longer jumps into qemu's
.text and evicts translated code; qemu's own .text falls from 38.8% to 5.3%
of profile samples.

Every step builds and runs on its own, so the series bisects, and the
emulated compiler produces byte-identical assembly output at every step,
which is the correctness check these patches most need. Three tests under
tests/tcg/multiarch cover the hazards the series creates: test-xpage-chain.c
and gdbstub/xpage-bp.py (patch 7) and test-indirect-irq.c (patch 8). Each
fails or hangs if the mechanism it covers is removed, which is what makes
them tests of the new behavior rather than of the old.

Changes since v4
================

The structural change is that v4's patches 4 and 5 are gone, replaced by
different patches with the same job.

v4's patch 4 added an argument to tcg_gen_lookup_and_goto_ptr() and made
every caller pass NULL. Richard's example is target/arm, where
DISAS_UPDATE_NOCHAIN needs the helper because the state has changed while
DISAS_JUMP does not; that subtlety, he pointed out, means the existing
interface should not be adjusted at all, and that targets should migrate to
a new one instead. So v5 leaves tcg_gen_lookup_and_goto_ptr(void) as it was
and adds tcg_gen_goto_jc_{i32,i64,tl}() beside it. Only the five migrated
targets are touched, rather than all twenty; the diffstat is a good summary
of the difference.

v4's patch 5 gave generated code a second jump cache base pointer and
poisoned it when a breakpoint was inserted, which needed a cross-thread
poison, an un-poison, and a double check of the breakpoint list. Richard
suggested a cflag instead, which is both simpler and sufficient: the probe
already compares cflags, so CF_NO_GOTO_JC alone keeps both the block itself
and anything chaining to it off the inline path. The whole poison mechanism
leaves this patch. The base pointer moves down to patch 8, where a pending
exit is the only reason left to want one, that being a per-execution
condition no cflag can express.

  1  Reviewed-by: Richard Henderson.

  2  Unchanged.

  3  Unchanged.

  4  Replaces "tcg: pass the destination to tcg_gen_lookup_and_goto_ptr()".
     New interface rather than a changed one; _i32 and _i64 entry points
     with a _tl alias in tcg-op.h rather than one entry point taking a
     TCGTemp, since single-binary targets build once and stop relying on
     TARGET_LONG_BITS; and a new helper_goto_jc_check() that asserts pc,
     flags and cs_base against get_tb_cpu_state() under CONFIG_DEBUG_TCG.
     (All Richard.) The contract is now written on the declaration rather
     than left to be inferred.

  5  Replaces "accel/tcg: give the TB jump cache a second base pointer for
     generated code" (Richard, as above). That leaves a residual window,
     in which blocks translated before the insert keep chaining on their
     old cflags until the vCPU reaches its main loop. It is the same window
     goto_tb chaining already has, and in system mode gdb inserts
     breakpoints with the vCPUs stopped, so there is none. The commit
     message says so rather than leaving it implicit.

  6  Build the folded flags/cflags constant with deposit64() rather than
     under #if HOST_BIG_ENDIAN, so both arms compile on every host
     (Richard). Read cpu->tb_jmp_cache directly and honor CF_NO_GOTO_JC,
     following patch 5. Commit message notes the backend expansion this
     wants as a follow-up, which is Richard's list: x86_64 and s390x can
     compare against a memory operand, and aarch64 has shift-add for the
     entry address, ldp to load (tb, pc) and (cs_base, flags), and ccmp to
     halve the branches. Not attempted here: the probe as posted is correct
     on every backend, and the expansions are strictly additive and deserve
     their own numbers, particularly the aarch64 one, which changes the
     shape enough that it should be measured on aarch64 hardware.

  7  Unchanged.

  8  Gains CPUState::tb_jmp_cache_probe from v4's patch 5. With breakpoints
     handled by a cflag, a pending exit is the only reason left to poison,
     so there is one condition rather than two, no cross-thread poison from
     cpu_breakpoint_insert(), and no unrealized or NULL state for either
     helper to consider: the probe is initialized alongside tb_jmp_cache
     and unrealize leaves it pointing at the poison (Richard). The poison
     is now a page-aligned allocation mapped read-only at startup rather
     than a writable .bss object (Richard); qemu_mprotect_ro() is added for
     it beside the existing _rw, _rwx and _none forms. That also settles
     v4's own note about a 1 MiB object that is never written.

  9  Unchanged.

Testing
=======

alpha, loongarch64, mips, mipsel, mips64, ppc, ppc64 and s390x all build and
run an indirect-dispatch exerciser (computed-goto back edges, function
pointer calls, returns and a longjmp out of a SIGALRM handler) to
completion under --enable-debug-tcg, so helper_goto_jc_check()'s assertions
have actually been exercised on every migrated target rather than only on
alpha. The gdbstub path (insert, hit, backtrace, delete, continue) and
test-indirect-irq still pass, and the emulated compiler's output is still
byte-identical.

What I would most like reviewed
===============================

  - Patch 7 reverses a deliberate decision made in d3a2a1d803 on the
    strength of an argument about the user-only invalidation paths, plus a
    gate on whether gdb can ever attach.

  - Patch 8's un-poison in the main loop races a concurrent poison from
    another thread. I believe the existing barrier around
    icount_decr.u16.high covers it, but my testing was single-threaded user
    mode.

  - Patch 5's argument that a cflag is sufficient rests on the probe
    comparing cflags and on the residual window being one goto_tb chaining
    already accepts. Both seem clearly true to me, which is why they are
    worth a second reader.

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

v4: https://lore.kernel.org/qemu-devel/20260827050241.3713332-1-mattst88@gmail.com/
v3: https://lore.kernel.org/qemu-devel/20260822190818.1829249-1-mattst88@gmail.com/
v2: https://lore.kernel.org/qemu-devel/20260817190038.580257-1-mattst88@gmail.com/

Matt Turner (9):
  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags
  accel/tcg: enlarge the TB jump cache to 64K entries
  accel/tcg: skip the can_do_io stores in user-only builds
  tcg: add tcg_gen_goto_jc_{i32,i64,tl}()
  accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present
  RFC: tcg: probe the TB jump cache inline instead of calling a helper
  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
  RFC: accel/tcg: poison the jump cache instead of polling for indirect
    exits
  RFC: tcg: fold a guest displacement into the host addressing mode

 accel/stubs/meson.build                       |   1 +
 accel/stubs/tcg-stub.c                        |  16 +
 accel/tcg/cpu-exec-common.c                   |  44 ++-
 accel/tcg/cpu-exec.c                          | 121 +++++++
 accel/tcg/internal-common.h                   |  20 +-
 accel/tcg/tb-jmp-cache.h                      |   2 +-
 accel/tcg/tcg-accel-ops.c                     |   2 +
 accel/tcg/tcg-runtime.h                       |   4 +
 accel/tcg/translator.c                        |  94 ++++-
 cpu-common.c                                  |   7 +
 cpu-target.c                                  |   3 +
 gdbstub/user.c                                |  14 +
 include/exec/translation-block.h              |   1 +
 include/gdbstub/user.h                        |  11 +
 include/hw/core/cpu.h                         |   9 +
 include/qemu/mprotect.h                       |   1 +
 include/system/tcg.h                          |  12 +
 include/tcg/tcg-op-common.h                   |  21 ++
 include/tcg/tcg-op.h                          |   2 +
 include/tcg/tcg-opc.h                         |   9 +-
 include/tcg/tcg.h                             |   2 +
 monitor/hmp-cmds.c                            |   5 +
 system/runstate-hmp-cmds.c                    |   4 +
 target/alpha/translate.c                      |   4 +-
 .../tcg/insn_trans/trans_branch.c.inc         |   2 +-
 target/loongarch/tcg/translate.c              |   4 +-
 target/mips/tcg/nanomips_translate.c.inc      |   2 +-
 target/mips/tcg/translate.c                   |   6 +-
 target/ppc/translate.c                        |   4 +-
 target/s390x/tcg/translate.c                  |   4 +-
 tcg/tcg-op-ldst.c                             |   3 +-
 tcg/tcg-op.c                                  | 182 +++++++++-
 tcg/tcg.c                                     | 132 ++++++-
 tcg/x86_64/tcg-target.c.inc                   |  41 +++
 tcg/x86_64/tcg-target.h                       |   3 +
 tests/tcg/multiarch/Makefile.target           |  12 +-
 tests/tcg/multiarch/gdbstub/xpage-bp.py       |  37 ++
 tests/tcg/multiarch/test-indirect-irq.c       |  62 ++++
 tests/tcg/multiarch/test-xpage-chain.c        | 336 ++++++++++++++++++
 util/osdep.c                                  |   9 +
 40 files changed, 1216 insertions(+), 32 deletions(-)
 create mode 100644 accel/stubs/tcg-stub.c
 create mode 100644 tests/tcg/multiarch/gdbstub/xpage-bp.py
 create mode 100644 tests/tcg/multiarch/test-indirect-irq.c
 create mode 100644 tests/tcg/multiarch/test-xpage-chain.c


base-commit: eea8fe61b8be8f3016e522e6af24924a0266ca95
-- 
2.54.0


