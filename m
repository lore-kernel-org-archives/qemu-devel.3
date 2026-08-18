Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C3DC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNq2-0002sO-OQ; Tue, 18 Aug 2026 13:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNq0-0002s6-V0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:00 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNpy-0007vF-Jh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:00 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66c70cff944so243729d50.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074977; x=1787679777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xl4pZZkibzAwOAwfGMWHQiwLvca4uGByR3vJ7CSBIek=;
 b=cHR66JRE1CW8M6XpGqIxgf5rR6ld7tCs+7kdNtitLkLaNpS6deYQC9/5Ua0M0X4TfD
 T+lmORGya35LP4Hd37ttR36Js2CVYigYpKKl2UoM730vk4sqdnRFxA+T7MwdubbuymTi
 xc/QbH8MsAJeTpu7S+sY8W6xa9lyo3/OFUwFHeJZfDdHXip2Sc/Pz9MP2nw2izPc0glj
 9zIs/vF7nupQAROWZVG4VWnPc7xFBgfZtEvIbZ6p2kag1DxoRg7HUla22fHU9TgyupN4
 QaCIUzGMj6xZpfom28grL3Yp49n9TXRKS5w0JrkRpQeydfpcPuImGqKmt0C8M6tREik5
 nAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074977; x=1787679777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xl4pZZkibzAwOAwfGMWHQiwLvca4uGByR3vJ7CSBIek=;
 b=AKNWWnGTHk6682mI10rrSIuarjQI+EW5v99bAyik7PfBZSmwFarlD7gVWYMctDJRMC
 W4vw0T+/VLOUDKoO//emModIqcwyuJhAkdS/gpbAA6kcvY8zTDhvfj4rCnr8fstkmLIt
 9hcEwJDuP7J4MkHuWDyz8icq9dMZDsx5GLLnZ/wSoGgFzQHUsAq9X1TvrjRlKZ75JHgq
 zIkq+VGvL47HOAGnqsaUa+yNEfI14lTJgWaoj84aYjMfNmL1hZRG5owv0Uva2GyEevCu
 6BlxA5DNxDCiDKK0poKVQ5jNz7P9QkwZmVFZQIRzTSLQ/xSmTXJoszZSYoobvFW+CSMD
 MzpQ==
X-Gm-Message-State: AOJu0YxLDYqFsf9jwTJJvcHqNywdO1M5vMKmODfAo8ZSPLIPl2GJCdsK
 nwyoJg4hrEvogm4BEB7wmvM8LdOkQ3rwn6EQqNngFyV8Jrs26pW6nWWhOHkhVkryrnw=
X-Gm-Gg: AR+sD12Eyje4hOap6g6k18m6CEperZn71BAem/XKnb6LQ4kUcQMGN2hSYEkOARkABuM
 lyMPLFqAKeT/B0SBlE0Su2rcVZpUC1M3kX+Qy5mLOMsy3qkhAU6suj85aBrzODSwTeJgvBf9S6t
 LqCWLp5DDMRhTpTAzlmRa/4ckmY0hwaZwWhgjDlCTTcBkIPSQTTgtb2XWkOUJogoVJP35wF1k7M
 P80iVKl/09vuKFSxs8BA6wrk0ergDMn0167nPv/b3kQ+TCkxDxpk4T1DzuudN2d54gUnclUKUOU
 7qXrvRJf3a9pZcz0L5t4O+UjA1GZ87lOs4eQLU6Ku6zpudN7mTB7nWv+TFOX/jy7YTHm7V5LApM
 D/ij0iZM6FbABS440XtMqARfVxKUcvjk+oOMgloAYqJZNFAXeINe4atHcJ+loZeEqUfUMLxs3pM
 IfSHU+2RbFwJG/UraN8WJCmY/eh9pMLvm9wePg9QdHAPyzC972u9i+zsXyHg4C
X-Received: by 2002:a05:690e:150e:b0:66c:484c:867f with SMTP id
 956f58d0204a3-66c72d2c9d0mr11133344d50.45.1787074977127; 
 Tue, 18 Aug 2026 10:42:57 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cb41e4389sm2617623d50.6.2026.08.18.10.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:42:55 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [RFC PATCH 0/8] accel/tcg: cut per-block dispatch overhead
Date: Tue, 18 Aug 2026 13:42:39 -0400
Message-ID: <20260818174247.649526-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb132.google.com
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
(the interrupt poll and the can_do_io stores on entry, the dispatch on
exit) ends up dominating everything else.

The workload throughout is qemu-alpha running an emulated alpha gcc 16.2.0
compiling the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64
host, in a --static --enable-lto --target-list=alpha-linux-user build. It
executes 34.2 billion TBs at 6.04 guest instructions each, and 24.6% of its
TB exits cannot use goto_tb. That is a representative shape for any guest
whose text is much larger than a page: indirect calls and returns
everywhere, plus direct branches that merely crossed a page boundary.

The first three patches are ordinary cleanups that stand on their own. The
remaining five are marked RFC individually and are where the interesting
questions are.

  1  accel/tcg: cache the result of curr_cflags()

     Recomputed on every one of the run's 8.4 billion dispatches, from
     state that changes only when gdb enables single-step or a log mask
     moves. Cache it in CPUState and recompute from the four places that
     can change an input.                                        -5.10%

  2  accel/tcg: enlarge the TB jump cache to 64K entries

     4096 entries is too small for a guest running a large program;
     tb_htable_lookup() is 5.73% of samples. 16 bits is the knee of the
     sizing curve, at 1 MiB per vCPU.                            -6.02%

  3  accel/tcg: skip the can_do_io stores in user-only builds

     Two stores per TB that nothing in a user-only build reads: 68 billion
     of them over the run.                              -4.55%, -4.32% wall

  4  RFC: tcg: probe the TB jump cache inline instead of calling a helper

     95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the jump
     cache. Emit the probe inline (hash, three guarded loads, goto_ptr)
     and call the helper only on a miss.               -36.51%, -27.05% wall

  5  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds

     translator_use_goto_tb() refuses to chain across a page. In user-only
     builds the invalidation path already covers what that was protecting
     against: every mmap/mprotect/munmap reaches page_set_flags(), which
     invalidates and unlinks. Lift it there, keep it for system mode.
                                                        -2.42%, -4.68% wall

  6  RFC: accel/tcg: only poll for interrupts in blocks that can close a
     cycle

     The icount_decr poll needs to happen once per cycle in the guest CFG,
     not once per block, and any cycle must contain either a backward edge
     or an indirect one. Record both during translation and emit the check
     only for blocks that have one.                     -6.81%, -3.10% wall

  7  RFC: accel/tcg: poison the jump cache instead of polling for indirect
     exits

     What patch 6 leaves behind is mostly blocks flagged for an indirect
     exit. Give the inline probe its own jump cache base pointer and point
     it at zeroes when an exit is requested: every dispatch then misses
     into the helper, which returns the epilogue. The poll becomes a
     pointer swap on the request path.                  -2.79%, -1.94% wall

  8  RFC: tcg: fold a guest displacement into the host addressing mode

     tcg_gen_qemu_ld/st cannot express a based access, so a target with a
     displacement in its encodings materializes the address with an lea
     that the host addressing mode would have done for free. Fold a
     preceding constant add into a new argument on the op, opt-in per
     backend, wired up for x86_64 user-only.            -6.29%, -3.29% wall

Each percentage is against the patch before it. End to end, measuring an
unmodified build of the same base against the full series, five runs each,
interleaved in one session so that host clock drift is shared rather than
attributed (mean, with the run-to-run spread):

    instructions retired: 1,646,129,294,236 -> 738,003,153,831   -55.17%
                                    (0.16%)           (0.03%)
    wall clock:                    134.934s ->          75.189s   -44.28%
                                    (0.30%)           (0.99%)

Both endpoints ran at the same 4.782 GHz effective clock, and the .s files
they produced are identical.

The two figures do not track each other, and that is the interesting part:
what the series removes is cheap, well-predicted, highly pipelined work, so
it retires far more instructions than it saves time. IPC falls from 2.55 to
2.05 as the remaining work gets less regular. Patch 4 also cuts
L1-icache load misses by 39.1%, because a dispatch no longer jumps into
qemu's .text and evicts translated code; qemu's own .text falls from 38.9%
to 5.4% of profile samples over the series.

Every revision was built and measured separately, so the series bisects, and
the emulated compiler produces byte-identical assembly output at every step,
which is the correctness check these patches most need. Two new alpha
tests cover the hazards the series creates: tests/tcg/alpha/test-xpage-chain.c
(patch 5) and test-indirect-irq.c (patch 7). Both fail or hang if the
mechanism they cover is removed, which is what makes them tests of the new
behavior rather than of the old.

The RFC patches need eyes I cannot supply myself. In rough order of how much
I would like someone to look at them:

  - Patch 5 reverses a deliberate decision made in d3a2a1d803 on the
    strength of an argument about the user-only invalidation paths.

  - Patch 6 moves system-mode interrupt latency from "bounded by block
    count" to "bounded by guest control flow". The bound is one
    straight-line run between cycles, but timer-driven guests want a closer
    look than I can give them. Its soundness also assumes every goto_tb
    destination passes through translator_use_goto_tb(); no target in the
    tree bypasses it today, but nothing enforces that.

  - Patch 4 treats cpu flags and cflags as translation-time constants in
    its guards, reads a jump cache entry without qatomic_read(), and puts
    knowledge of the CPUJumpCache layout in tcg/tcg-op.c, where it does not
    belong.

  - Patch 7's restore in cpu_handle_interrupt() races a concurrent poison
    from another thread. I believe the existing barrier around
    icount_decr.u16.high covers it, but my testing was single-threaded user
    mode.

  - Patch 8 only examines the immediately preceding op, refuses any access
    with a slow path (so user-only, and no alignment check), and leaves the
    i128 pairs alone.

  - Patch 2's 1 MiB per vCPU is easy to justify for a single-vCPU
    linux-user process and less obvious for system emulation with many
    vCPUs. It may want to be sized per target or made tunable rather than
    raised unconditionally.

Patches 4 and 8 are wired up for alpha and x86_64 respectively; everything
else is target-independent, and no other backend changes behavior or needs
touching.

Matt Turner (8):
  accel/tcg: cache the result of curr_cflags()
  accel/tcg: enlarge the TB jump cache to 64K entries
  accel/tcg: skip the can_do_io stores in user-only builds
  RFC: tcg: probe the TB jump cache inline instead of calling a helper
  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
  RFC: accel/tcg: only poll for interrupts in blocks that can close a
    cycle
  RFC: accel/tcg: poison the jump cache instead of polling for indirect
    exits
  RFC: tcg: fold a guest displacement into the host addressing mode

 accel/tcg/cpu-exec-common.c         |  48 +++++++++++-
 accel/tcg/cpu-exec.c                |  54 ++++++++++++++
 accel/tcg/internal-common.h         |  22 +++++-
 accel/tcg/tb-jmp-cache.h            |   2 +-
 accel/tcg/tcg-accel-ops.c           |   2 +
 accel/tcg/tcg-all.c                 |   1 +
 accel/tcg/translator.c              |  77 ++++++++++++++++++-
 cpu-target.c                        |   3 +
 include/exec/translation-block.h    |   6 ++
 include/exec/translator.h           |   2 +
 include/hw/core/cpu.h               |  23 +++++-
 include/system/tcg.h                |   9 +++
 include/tcg/tcg-op-common.h         |   2 +
 include/tcg/tcg-opc.h               |   9 ++-
 linux-user/main.c                   |   2 +-
 stubs/meson.build                   |   1 +
 stubs/tcg-cflags.c                  |  16 ++++
 target/alpha/cpu.c                  |   2 +-
 target/alpha/translate.c            |   6 +-
 tcg/tcg-op-ldst.c                   |   3 +-
 tcg/tcg-op.c                        |  86 +++++++++++++++++++++
 tcg/tcg.c                           |  86 ++++++++++++++++++++-
 tcg/x86_64/tcg-target.c.inc         |  61 +++++++++++++++
 tcg/x86_64/tcg-target.h             |   3 +
 tests/tcg/alpha/Makefile.target     |   3 +-
 tests/tcg/alpha/test-indirect-irq.c |  53 +++++++++++++
 tests/tcg/alpha/test-xpage-chain.c  | 111 ++++++++++++++++++++++++++++
 util/log.c                          |   4 +
 28 files changed, 676 insertions(+), 21 deletions(-)
 create mode 100644 stubs/tcg-cflags.c
 create mode 100644 tests/tcg/alpha/test-indirect-irq.c
 create mode 100644 tests/tcg/alpha/test-xpage-chain.c

-- 
2.54.0


