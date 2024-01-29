Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09458C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadG-0005uy-Rw; Mon, 29 Jan 2024 18:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadA-0005u3-Ho
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:33 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUad7-0008MH-A9
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:32 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2066079b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569287; x=1707174087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nMJc6rnh2YFv7ccKB5cB0/QZvK1NoJrnABL8bZIM6R0=;
 b=dGFb6laTRQBpWpRiar0gXsFG3w7/BboR7GzgTJSsFqjI+soq3k65lK8DOSmXaXVC9z
 Ze7+X91ar1ti2ieDAKXz7T2iMFgBqac7ow3YyX3s9cljymmE9BAA1JfPDsgdSOL8odW1
 /73SclA2swwESQ+vvwd4W0Pm9KL6lm4X2dy2y2tdOiVto2dCPac8IeAPxuM871v2w/8U
 c+l3nyMvj4Qc4KGXA7QQ9DaSngTR8gHe1bITjF/Fz4U1pxxvXLVqw3hNalTt+ZEcDPNO
 dXXWbhDv6L3C8XlIgdX2Ak1iWqoYgiCQBd5l/iI3pmAPqFPbVCspvuhfb7BDYKMsfz/0
 TgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569287; x=1707174087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nMJc6rnh2YFv7ccKB5cB0/QZvK1NoJrnABL8bZIM6R0=;
 b=tyzXwWAZyfcMLAbz2eniqqFrDDoVZFO8KE+5l/GNeunOSOoTvsy76KjDV0cQVp6egh
 ycNyeZyex9hmThh3tBA7KLYxoZqw/4zbndvw3FhiPHjhTngzjnHZS37KlExtks3npRxB
 kYn2EaUBNJI+ThV2eMkIQlJle05GuS0LxBnOh6JT4GiNnW1G2GUbBXbwmqEPF2h1L5YV
 ikHwZawqpjwtlmAnSO9vQYN+sAgNwo3ucyuvseWhCZWLt47PwiMINRC0givk23Y2dmOx
 2h43GYyM9kYvJYTckHH/X27/I2xFCIcNPIBsefrbR1yUw7Gp9G4bK2VoFtviZELB+vPz
 GxSw==
X-Gm-Message-State: AOJu0YxGOjPLMNea8qFnpac8Mv6lpmesBGIBcJjyX9kqOey5RHqCZ/gw
 6WLSvFHDCmPoTJYsQK9X97IvuKhdbTrEeUPARTLCX6lKSJGON/QElxA03htISCZWS6hVrCON3MT
 F+jE=
X-Google-Smtp-Source: AGHT+IHYvGGaa+21njjdeUzJzdysrrUOw/imDzWr6WMadczZPTPAxGVQVb/4zUoqFuYB/9NUJfy7/Q==
X-Received: by 2002:a05:6a00:809:b0:6de:3833:425a with SMTP id
 m9-20020a056a00080900b006de3833425amr2232339pfk.5.1706569286916; 
 Mon, 29 Jan 2024 15:01:26 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/31] tcg patch queue
Date: Tue, 30 Jan 2024 09:00:50 +1000
Message-Id: <20240129230121.8091-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 7a1dc45af581d2b643cdbf33c01fd96271616fbd:

  Merge tag 'pull-target-arm-20240126' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-26 18:16:35 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240130

for you to fetch changes up to ec1d32af123e7f13d98754a72bcaa7aa8c8e9d27:

  target/i386: Extract x86_cpu_exec_halt() from accel/tcg/ (2024-01-29 21:04:10 +1000)

----------------------------------------------------------------
linux-user: Allow gdbstub to ignore page protection
cpu-exec: simplify jump cache management
include/exec: Cleanups toward building accel/tcg once

----------------------------------------------------------------
Anton Johansson (9):
      include/exec: Move vaddr defines to separate file
      hw/core: Include vaddr.h from cpu.h
      target: Use vaddr in gen_intermediate_code
      include/exec: Use vaddr in DisasContextBase for virtual addresses
      include/exec: typedef abi_ptr to vaddr
      include/exec: Move PAGE_* macros to common header
      include/exec: Move cpu_*()/cpu_env() to common header
      include/hw/core: Move do_interrupt in TCGCPUOps
      include/hw/core: Remove i386 conditional on fake_user_interrupt

Ilya Leoshkevich (8):
      linux-user: Allow gdbstub to ignore page protection
      tests/tcg: Factor out gdbstub test functions
      tests/tcg: Add the PROT_NONE gdbstub test
      target: Make qemu_target_page_mask() available for *-user
      accel/tcg: Make use of qemu_target_page_mask() in perf.c
      tcg: Make tb_cflags() usable from target-agnostic code
      accel/tcg: Remove #ifdef TARGET_I386 from perf.c
      accel/tcg: Move perf and debuginfo support to tcg/

Paolo Bonzini (1):
      cpu-exec: simplify jump cache management

Philippe Mathieu-Daudé (9):
      accel/tcg/cpu-exec: Use RCU_READ_LOCK_GUARD
      accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
      accel/tcg: Rename tcg_cpus_destroy() -> tcg_cpu_destroy()
      accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
      accel/tcg: Un-inline icount_exit_request() for clarity
      accel/tcg: Introduce TCGCPUOps::need_replay_interrupt() handler
      target/i386: Extract x86_need_replay_interrupt() from accel/tcg/
      accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
      target/i386: Extract x86_cpu_exec_halt() from accel/tcg/

Richard Henderson (4):
      include/qemu: Add TCGCPUOps typedef to typedefs.h
      target/loongarch: Constify loongarch_tcg_ops
      accel/tcg: Use CPUState.cc instead of CPU_GET_CLASS in cpu-exec.c
      accel/tcg: Inline need_replay_interrupt

 accel/tcg/tb-jmp-cache.h                           |   8 +-
 accel/tcg/tcg-accel-ops.h                          |   4 +-
 include/exec/cpu-all.h                             |  49 -----
 include/exec/cpu-common.h                          |  69 +++++--
 include/exec/cpu_ldst.h                            |   4 +-
 include/exec/exec-all.h                            |   6 -
 include/exec/translation-block.h                   |   6 +
 include/exec/translator.h                          |   8 +-
 include/exec/vaddr.h                               |  18 ++
 include/hw/core/cpu.h                              |   7 +-
 include/hw/core/tcg-cpu-ops.h                      |  19 +-
 include/qemu/typedefs.h                            |   1 +
 {accel => include}/tcg/debuginfo.h                 |   4 +-
 {accel => include}/tcg/perf.h                      |   4 +-
 target/i386/tcg/helper-tcg.h                       |   2 +
 target/mips/tcg/translate.h                        |   3 +-
 accel/tcg/cpu-exec.c                               | 223 +++++++++------------
 accel/tcg/tcg-accel-ops-mttcg.c                    |   4 +-
 accel/tcg/tcg-accel-ops-rr.c                       |   4 +-
 accel/tcg/tcg-accel-ops.c                          |   4 +-
 accel/tcg/translate-all.c                          |   2 +-
 bsd-user/signal.c                                  |   4 +-
 cpu-target.c                                       |  78 +++++--
 hw/core/loader.c                                   |   2 +-
 linux-user/elfload.c                               |   2 +-
 linux-user/exit.c                                  |   2 +-
 linux-user/main.c                                  |   2 +-
 linux-user/signal.c                                |   4 +-
 system/physmem.c                                   |   5 -
 system/vl.c                                        |   2 +-
 target/alpha/cpu.c                                 |   2 +-
 target/alpha/translate.c                           |   2 +-
 target/arm/cpu.c                                   |   2 +-
 target/arm/tcg/cpu32.c                             |   2 +-
 target/arm/tcg/translate.c                         |   2 +-
 target/avr/cpu.c                                   |   2 +-
 target/avr/translate.c                             |   2 +-
 target/cris/cpu.c                                  |   4 +-
 target/cris/translate.c                            |   2 +-
 target/hexagon/cpu.c                               |   2 +-
 target/hexagon/translate.c                         |   5 +-
 target/hppa/cpu.c                                  |   2 +-
 target/hppa/translate.c                            |   2 +-
 target/i386/tcg/sysemu/seg_helper.c                |  23 +++
 target/i386/tcg/tcg-cpu.c                          |   4 +-
 target/i386/tcg/translate.c                        |   2 +-
 target/loongarch/cpu.c                             |   2 +-
 target/loongarch/tcg/translate.c                   |   2 +-
 target/m68k/cpu.c                                  |   2 +-
 target/m68k/translate.c                            |   4 +-
 target/microblaze/cpu.c                            |   2 +-
 target/microblaze/translate.c                      |   2 +-
 target/mips/cpu.c                                  |   2 +-
 target/mips/tcg/translate.c                        |  14 +-
 target/nios2/cpu.c                                 |   2 +-
 target/nios2/translate.c                           |   2 +-
 target/openrisc/cpu.c                              |   2 +-
 target/openrisc/translate.c                        |   2 +-
 target/ppc/cpu_init.c                              |   2 +-
 target/ppc/translate.c                             |   2 +-
 target/riscv/tcg/tcg-cpu.c                         |   2 +-
 target/riscv/translate.c                           |   2 +-
 target/rx/cpu.c                                    |   2 +-
 target/rx/translate.c                              |   2 +-
 target/s390x/cpu.c                                 |   2 +-
 target/s390x/tcg/translate.c                       |   2 +-
 target/sh4/cpu.c                                   |   2 +-
 target/sh4/translate.c                             |   2 +-
 target/sparc/cpu.c                                 |   2 +-
 target/sparc/translate.c                           |   2 +-
 target/target-common.c                             |  10 +
 target/tricore/cpu.c                               |   2 +-
 target/tricore/translate.c                         |   2 +-
 target/xtensa/cpu.c                                |   2 +-
 target/xtensa/translate.c                          |   2 +-
 {accel/tcg => tcg}/debuginfo.c                     |   3 +-
 {accel/tcg => tcg}/perf.c                          |  14 +-
 tcg/tcg.c                                          |   2 +-
 tests/tcg/multiarch/prot-none.c                    |  40 ++++
 accel/tcg/meson.build                              |  16 +-
 target/meson.build                                 |   2 +
 tcg/meson.build                                    |   5 +
 tests/guest-debug/run-test.py                      |   7 +-
 tests/guest-debug/test_gdbstub.py                  |  60 ++++++
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py        |  34 +---
 tests/tcg/aarch64/gdbstub/test-sve.py              |  33 +--
 tests/tcg/multiarch/Makefile.target                |   9 +-
 tests/tcg/multiarch/gdbstub/interrupt.py           |  47 +----
 tests/tcg/multiarch/gdbstub/memory.py              |  39 +---
 tests/tcg/multiarch/gdbstub/prot-none.py           |  36 ++++
 tests/tcg/multiarch/gdbstub/registers.py           |  41 +---
 tests/tcg/multiarch/gdbstub/sha1.py                |  38 +---
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py  |  39 +---
 .../tcg/multiarch/gdbstub/test-qxfer-auxv-read.py  |  37 +---
 .../multiarch/gdbstub/test-thread-breakpoint.py    |  37 +---
 tests/tcg/s390x/gdbstub/test-signals-s390x.py      |  42 +---
 tests/tcg/s390x/gdbstub/test-svc.py                |  39 +---
 97 files changed, 580 insertions(+), 730 deletions(-)
 create mode 100644 include/exec/vaddr.h
 rename {accel => include}/tcg/debuginfo.h (96%)
 rename {accel => include}/tcg/perf.h (95%)
 create mode 100644 target/target-common.c
 rename {accel/tcg => tcg}/debuginfo.c (98%)
 rename {accel/tcg => tcg}/perf.c (97%)
 create mode 100644 tests/tcg/multiarch/prot-none.c
 create mode 100644 tests/guest-debug/test_gdbstub.py
 create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py

