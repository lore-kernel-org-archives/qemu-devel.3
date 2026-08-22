Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90A8C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxr4u-00040i-Ee; Sat, 22 Aug 2026 15:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr4s-00040L-Te
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:26 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr4q-0005kC-EM
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:26 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-836c590b61eso34090587b3.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787425703; x=1788030503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z0IhsnXCljV6fjz4eVZmXpcHm+0uuEkyQyR5ZDouewM=;
 b=Jv21TC31Q1kjmwrunZjjwbOKcRNXHt0ev8cfR739dEZMdqQHJW8N3O8/Fa1sDlsOFE
 KGyRoUVjG7rK/VYn4d1LGoOsdjFzESuJFhXm542gw5wZYWMEaz+TtfkHX+CD6eXyjMBt
 +R5i1+qRZAltO4BjqLBttGgFs/vUNMXbHxEsqvnsbEHcgmm9oqoSvFouHHVQF44WtmsX
 plfb3+afX22KemXvHUqrziZ2vUm1ubuyANajFao2yUYwDPeNzY+EhbmvljLyPvuZ9kA+
 MyXpt5rCIORdks1YA8w9mHfGE/o+rMdYAwLQYW89drGfBToYwsgFdvbQAS+4fMnwEvqz
 Fajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425703; x=1788030503;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z0IhsnXCljV6fjz4eVZmXpcHm+0uuEkyQyR5ZDouewM=;
 b=J6nHQ5XkXS3rPyZZgmB8p/9InkS6/IC0Gcea54xKLUwTiBhJWGiSjkSoJaKVrdOE6M
 9kaAZZUHdB9DtQ2MURmQrowbhFybCWcqY3dGvMpeItLtrcPMOu6Tlj8sDKKF1kk5DFA1
 0i/NrRm26mcSOEhapAmrVW3zkAt7Q9ajjBKSafqeHRdFX2KLP+jPt+sW+kyWosVu7bFp
 wbouJnsWZbHQbvUzFyWIDXclic8WLwG4oJyauLnimQ0rlLUjVlKp2z9H0MOoNdY3NPDB
 ihsJUe/Zbgi0OuVSZK838xhT9J4TAl4ZdZ3/DhnVxqOhlWHXpJQCnHw28mEhIlBxaDCJ
 2v4w==
X-Gm-Message-State: AFuF++nzVlDa0xAWn9afNjWkTjWZrdn7Hz/irE2aUH/j6An6d+zhqHrY
 58XzmGJqQjeVEXqkox7ri1AJnbEFQ2AxqewXPAySweNWM57BYc7JAF6LNSXp4GMoAWM=
X-Gm-Gg: AR+sD10AQiRjtac3og2sqDTM2VjDmbjIRNPHRs098R7J4YbZYKh9eFK4ayH3g0NvLdO
 19rl9tzhUpI2AE6kP9gjsBSFNogIOiTE8t6nQbNt08Gf3xLxR48spceQFrGuFZSQubnuMp2csFj
 flziTqrY33IP9mZJkEmAAW+rtnNDQao45uytHlOxyAZSNu1Ys+c/4P8bH2nkCPbwkroOGkssDeP
 7mJY20hi3ozkf9bi0vYho8M3vEhUahSNzUYFSJhzm105O65xmo4kaBHS6jjs7XziBSe+QADjSvK
 rv/njYCuwwBu4rJAMQXOA33RJ1Y+mqS0XV2KgEFKXzt568G1YuBja9niZ1XiN4ogTUp9b46wtUL
 0kEfxOhE5EDrLGF6LNqaLaripI9dQF42dqsQcelcaU4AZAN2juWu3U71rFEtFUGfviOGkohTvK/
 DYJCKviJr5S+PeLhFeHiaUr/9faW+oY5pxqByEWe4MBwLg6here7Dsj1H5zjk/pBeGT139TTOMC
 rfPwwhlOlMD0W5S92Z5j7fOBXXWHmL0Vqhb8Dye
X-Received: by 2002:a05:690c:7013:b0:820:10f1:b791 with SMTP id
 00721157ae682-84c9c96f7a0mr29071167b3.36.1787425702496; 
 Sat, 22 Aug 2026 12:08:22 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84caa9cfd29sm13677667b3.26.2026.08.22.12.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:08:19 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 0/7] accel/tcg: cut per-block dispatch overhead
Date: Sat, 22 Aug 2026 15:08:11 -0400
Message-ID: <20260822190818.1829249-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
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
3 picked up review tags in v2. The remaining four are marked RFC individually
and are where the interesting questions are.

  1  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags

     curr_cflags() recomputed three unlikely tests on every one of the run's
     8.4 billion dispatches, from state that changes only when gdb enables
     single-step, when one-insn-per-tb is toggled, or when the log mask
     moves. Fold each into tcg_cflags where it changes.          -5.15%

  2  accel/tcg: enlarge the TB jump cache to 64K entries

     4096 entries is too small for a guest running a large program;
     tb_htable_lookup() is 6.10% of samples. 16 bits is the knee of the
     sizing curve, at 1 MiB per vCPU.                   -5.92%, -8.71% wall

  3  accel/tcg: skip the can_do_io stores in user-only builds

     Two stores per TB that nothing in a user-only build reads: 68 billion
     of them over the run.                              -4.57%, -4.53% wall

  4  RFC: tcg: probe the TB jump cache inline instead of calling a helper

     95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the jump
     cache. Emit the probe inline (hash, four guarded loads, goto_ptr) and
     call the helper only on a miss.                   -34.67%, -25.94% wall

  5  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds

     translator_use_goto_tb() refuses to chain across a page. In user-only
     builds the invalidation path already covers what that was protecting
     against: every mmap/mprotect/munmap reaches page_set_flags(), which
     invalidates and unlinks. Lift it there for runs that can never acquire
     a breakpoint, keep it for system mode.             -2.75%, -4.84% wall

  6  RFC: accel/tcg: poison the jump cache instead of polling for indirect
     exits

     A block only needs the icount_decr poll if it can leave by goto_tb;
     every other exit already passes through a dispatch. Give the inline
     probe its own jump cache base pointer and point it at zeroes when an
     exit is requested, so every dispatch misses into the helper, which
     returns the epilogue. Emit the poll only in blocks that emitted a
     goto_tb.                                           -2.52%, -1.96% wall

  7  RFC: tcg: fold a guest displacement into the host addressing mode

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

The two figures do not track each other, and that is the interesting part:
what the series removes is cheap, well-predicted, highly pipelined work, so
it retires far more instructions than it saves time. Patch 4 also cuts L1
icache load misses by 39.0%, because a dispatch no longer jumps into qemu's
.text and evicts translated code; qemu's own .text falls from 38.8% to 5.3%
of profile samples.

Every revision was built and measured separately, so the series bisects, and
the emulated compiler produces byte-identical assembly output at every step,
which is the correctness check these patches most need. Three new alpha
tests cover the hazards the series creates: tests/tcg/alpha/test-xpage-chain.c
and tests/tcg/alpha/gdbstub/xpage-bp.py (patch 5) and test-indirect-irq.c
(patch 6). Each fails or hangs if the mechanism it covers is removed, which
is what makes them tests of the new behavior rather than of the old.

Changes since v2
================

The biggest change is that "RFC: accel/tcg: only poll for interrupts in
blocks that can close a cycle" is dropped. Richard pointed out that it let a
straight-line run of arbitrary length go unchecked, since a block with no
backward edge polled nowhere. Patch 6 now keeps the poll where a block can
leave by goto_tb and relies on the dispatch everywhere else, which holds the
one-block bound without any analysis of the guest's control flow graph. All
of v2's measurements for that patch were taken with the dropped patch
underneath and have been replaced by a fresh measurement of the series as it
now stands.

  1  Rewritten as folding the dynamic bits into CPUState::tcg_cflags where
     they change, rather than caching curr_cflags() in a second field.
     Monitor-side updates ('one-insn-per-tb on', 'log nochain') are queued
     with async_safe_run_on_cpu() so each CPU writes its own cflags.

  2  Sizing curve re-measured on top of the new patch 1, now with wall clock
     alongside instructions retired.

  3  Back to #ifndef CONFIG_USER_ONLY. QEMU's IS_ENABLED() is IS_EMPTY(),
     true only for a symbol Meson defines empty, and CONFIG_USER_ONLY is
     defined as 1, so v2's test was always false and the stores were emitted
     after all. Review tags carried over; the numbers are from the working
     form.

  4  Folded into tcg_gen_lookup_and_goto_ptr() instead of adding a second
     entry point beside it (Richard), which changed all 38 call sites.
     cs_base is compared too, which is what lets the probe be enabled
     generically rather than per target. Audited which targets may pass a
     real PC: five do, the rest pass NULL and keep the helper call. The
     breakpoint poison now happens in cpu_breakpoint_insert() rather than
     only from the poisoned CPU's own main loop, since a thread dispatching
     indirectly need never reach that loop.

  5  Only take the shortcut when no gdbstub was requested: the same-page rule
     also forces a breakpoint check on entry to every page, and without that
     a chain established earlier runs past a breakpoint set later. Reported
     by Richard. Changed translator_use_goto_tb() rather than
     translator_is_same_page(), which i386, riscv and s390x use for something
     else and which v2 perturbed as a side effect. Added the gdbstub half of
     the test.

  6  Rebased onto the removal described above, with the deferred-emission
     machinery moved here from the dropped patch, and re-measured.

  7  Unchanged in substance, re-measured on the new baseline.

What I would most like reviewed
===============================

  - Patch 5 reverses a deliberate decision made in d3a2a1d803 on the
    strength of an argument about the user-only invalidation paths, plus a
    gate on whether gdb can ever attach.

  - Patch 6's un-poison in the main loop races a concurrent poison from
    another thread. I believe the existing barrier around
    icount_decr.u16.high covers it, but my testing was single-threaded user
    mode.

  - Patch 4 treats cpu flags, cflags and cs_base as translation-time
    constants in its guards, reads a jump cache entry without qatomic_read(),
    and leaves one_insn_per_tb and -d nochain toggles visible only at the
    next non-inline exit.

  - Patch 7 only examines the immediately preceding op, refuses any access
    with a slow path (so user-only, and no alignment check), and leaves the
    i128 pairs alone.

  - Patch 2's 1 MiB per vCPU is easy to justify for a single-vCPU
    linux-user process and less obvious for system emulation with many
    vCPUs. It may want to be sized per target or made tunable rather than
    raised unconditionally.

Patches 4 and 7 are wired up for alpha and x86_64 respectively; everything
else is target-independent, and no other backend changes behavior or needs
touching.

v2: https://lore.kernel.org/qemu-devel/20260817190038.580257-1-mattst88@gmail.com/

Matt Turner (7):
  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags
  accel/tcg: enlarge the TB jump cache to 64K entries
  accel/tcg: skip the can_do_io stores in user-only builds
  RFC: tcg: probe the TB jump cache inline instead of calling a helper
  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
  RFC: accel/tcg: poison the jump cache instead of polling for indirect
    exits
  RFC: tcg: fold a guest displacement into the host addressing mode

 accel/tcg/cpu-exec-common.c                   |  33 +++-
 accel/tcg/cpu-exec.c                          | 122 +++++++++++++++
 accel/tcg/internal-common.h                   |  13 +-
 accel/tcg/tb-jmp-cache.h                      |   2 +-
 accel/tcg/tcg-accel-ops.c                     |   1 +
 accel/tcg/tcg-all.c                           |   1 +
 accel/tcg/translator.c                        |  94 +++++++++++-
 cpu-common.c                                  |  11 ++
 cpu-target.c                                  |   3 +
 gdbstub/user.c                                |  14 ++
 include/gdbstub/user.h                        |  11 ++
 include/hw/core/cpu.h                         |  11 ++
 include/system/tcg.h                          |  21 +++
 include/tcg/tcg-op-common.h                   |  16 +-
 include/tcg/tcg-op.h                          |  12 ++
 include/tcg/tcg-opc.h                         |   9 +-
 include/tcg/tcg.h                             |   2 +
 stubs/meson.build                             |   1 +
 stubs/tcg-cflags.c                            |  20 +++
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
 tcg/tcg-op.c                                  | 101 +++++++++++-
 tcg/tcg.c                                     |  86 ++++++++++-
 tcg/x86_64/tcg-target.c.inc                   |  61 ++++++++
 tcg/x86_64/tcg-target.h                       |   3 +
 tests/tcg/alpha/Makefile.target               |  18 ++-
 tests/tcg/alpha/gdbstub/xpage-bp.py           |  34 +++++
 tests/tcg/alpha/test-indirect-irq.c           |  55 +++++++
 tests/tcg/alpha/test-xpage-chain.c            | 144 ++++++++++++++++++
 util/log.c                                    |   4 +
 51 files changed, 932 insertions(+), 63 deletions(-)
 create mode 100644 stubs/tcg-cflags.c
 create mode 100644 tests/tcg/alpha/gdbstub/xpage-bp.py
 create mode 100644 tests/tcg/alpha/test-indirect-irq.c
 create mode 100644 tests/tcg/alpha/test-xpage-chain.c

-- 
2.54.0


