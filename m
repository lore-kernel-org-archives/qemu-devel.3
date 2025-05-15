Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5E4C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmp-0004HK-Ch; Thu, 15 May 2025 06:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmm-0004ED-NA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmi-00085w-Kb
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so7522015e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304749; x=1747909549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=u9mG6y4xoR1LCYvf2y/P3l0KsSNltHkZr32oqmKaggQ=;
 b=N9MTsMrX16k5GlDsMCji7Bs6nL6ERMpDxwNhrYBa0LsSdg6W2MzP9w/i4n9fgQRWK6
 6PpxFWkpyFixRlckz4neBVv6vOJ+ckh/nigAxZcJjWeG0gUKFxY2h6+b8OzDZPwQVSeq
 nTSTD9b6Fr4hHOKq1kaRAUG029uDjqUn/f3MAeaKU2uYt+eQRhdnGoo2CezYvOFVSomg
 MTKAnLmsp4xpzM0mjXDMTQZM/16HhlnDrPkiBHa6jVkLJuMxBrK2rDZCsvSSK4l4eOcd
 7LbC/tmQmJHkydVjqSxZKZ37OuSxZwsW9HVhqTFBTZ0ilUiMNyiC66cWTXGMe5n3FNp8
 v/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304749; x=1747909549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u9mG6y4xoR1LCYvf2y/P3l0KsSNltHkZr32oqmKaggQ=;
 b=HSjsVg3iDjLNG9bKPxW7VCtJrNIRRrTPbaSPgaj8x+Hauu++ptjt9rfu9DmbMnY6Sp
 U9tDj+gmDwjLQtltkNQmeZAtSevUEmpAK7GCRlTHV2NtDD4TAe0bG3ioJJIZhqIoYKP7
 A2m9L0HV0ENSO5wjUqDONDmCAegVNEAslQ4i/UB3JrZ4jGVeM/EP0NlXYu1bsye7QDi2
 D1R/A1siG07ScyHqO0MENcz8YY9yMV3OD6ckaIuk9arozkJkqHONoDwedMjxQ0gHtQ2e
 V/1xNVi/XbeRoRXxlcawswUOm034QWPqP/ncWkgktZYROF1yYoYliAAWgZGk58tGi3sf
 PV6Q==
X-Gm-Message-State: AOJu0Yzsbi6Gl1iXHPoU72ClIcGUt3sfenxH91T4UA+0sTN1YaoaPY8M
 NKJmxjr2mGiwcVUHtlMqXPhnmwucVGphSf71AQSCDCQ0hIg5PUeI/uk5gWc2L0XuFcTcsYM9bAS
 c5YY=
X-Gm-Gg: ASbGncuzKf/3sSp3ajQF1YkNT/mFZRvM5G52qd8eeEj8jnr8fzjaKttZPpoEK4NkDj6
 tY3UOy3CMtKrLNYhcTFebdPDYze1UEiuV9CeYXG9r/szUQEyU9b9weAVVgpC3vOZaCZQB0LHLvR
 M6Td7Jv7VDEKMQgcjSoDsQhdw7hNF14sHIvwtnl1hhNhf9tkTBFjmGvZtO06G7+SqPp4Vl7mCax
 +8xmTT3miq9uJo8uTxziQV01Tv+40syh7kftMPkMEF4KxrkT5Ioc950FC8PAfjErtReyoBya+Y5
 Zoru9+N79Bvl63tUix1E6Lqg17r4gZDtSBodh3GW3p3Gz/MDpHDpBsJctg==
X-Google-Smtp-Source: AGHT+IHdoJc6uV10x8dY6T3xIpPpuHD/0Kllt8GYa98KZ+sHYM/mUZgBXk0MgxsorzMDCF7Es9GFnA==
X-Received: by 2002:a05:600c:3b02:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-442f20baee4mr66263115e9.2.1747304749558; 
 Thu, 15 May 2025 03:25:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/58] target-arm queue
Date: Thu, 15 May 2025 11:24:48 +0100
Message-ID: <20250515102546.2149601-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi; this is a big series but most of it is the refactoring
from Pierrick for preparations for single-binary work.

thanks
-- PMM

The following changes since commit 864813878951b44e964eb4c012d832fd21f8cc0c:

  Merge tag 'pull-loongarch-20250514' of https://github.com/gaosong715/qemu into staging (2025-05-14 07:16:57 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250515

for you to fetch changes up to 9eb5427ac0d56ca050e34776b6de428892609bd5:

  target/arm/tcg/vfp_helper: compile file twice (system, user) (2025-05-14 15:12:41 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: refactoring for compile-twice changes
 * MAINTAINERS: Add an entry for the Bananapi machine
 * arm/omap: remove hard coded tabs
 * rust: pl011: Cut down amount of text quoted from PL011 TRM
 * target/arm: refactor Arm CPU class hierarchy

----------------------------------------------------------------
Peter Maydell (8):
      target/microblaze: Use 'obj' in DEVICE() casts in mb_cpu_initfn()
      target/microblaze: Delay gdb_register_coprocessor() to realize
      hw/core/cpu-common: Don't init gdbstub until cpu_exec_realizefn()
      target/arm: Present AArch64 gdbstub based on ARM_FEATURE_AARCH64
      target/arm: Move aarch64 CPU property code to TYPE_ARM_CPU
      target/arm/kvm: don't check TYPE_AARCH64_CPU
      target/arm: Remove TYPE_AARCH64_CPU
      rust: pl011: Cut down amount of text quoted from PL011 TRM

Philippe Mathieu-Daudé (1):
      target/arm: Replace target_ulong -> vaddr for HWBreakpoint

Pierrick Bouvier (47):
      include/system/hvf: missing vaddr include
      meson: add common libs for target and target_system
      target/arm: move kvm stubs and remove CONFIG_KVM from kvm_arm.h
      target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
      target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
      target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
      target/arm/cpu: remove TARGET_AARCH64 around aarch64_cpu_dump_state common
      target/arm/cpu: remove TARGET_AARCH64 in arm_cpu_finalize_features
      target/arm/cpu: compile file twice (user, system) only
      target/arm/cpu32-stubs.c: compile file twice (user, system)
      tcg: add vaddr type for helpers
      target/arm/helper: use vaddr instead of target_ulong for exception_pc_alignment
      target/arm/helper: use vaddr instead of target_ulong for probe_access
      target/arm/helper: extract common helpers
      target/arm/debug_helper: only include common helpers
      target/arm/debug_helper: remove target_ulong
      target/arm/debug_helper: compile file twice (user, system)
      target/arm/helper: restrict include to common helpers
      target/arm/helper: replace target_ulong by vaddr
      target/arm/helper: expose aarch64 cpu registration
      target/arm/helper: remove remaining TARGET_AARCH64
      target/arm/helper: compile file twice (user, system)
      target/arm/vfp_fpscr: compile file twice (user, system)
      target/arm/arch_dump: remove TARGET_AARCH64 conditionals
      target/arm/arch_dump: compile file once (system)
      target/arm/arm-powerctl: compile file once (system)
      target/arm/cortex-regs: compile file once (system)
      target/arm/ptw: replace target_ulong with int64_t
      target/arm/ptw: replace TARGET_AARCH64 by CONFIG_ATOMIC64 from arm_casq_ptw
      target/arm/ptw: compile file once (system)
      target/arm/meson: accelerator files are not needed in user mode
      target/arm/kvm-stub: compile file once (system)
      target/arm/machine: reduce migration include to avoid target specific definitions
      target/arm/machine: remove TARGET_AARCH64 from migration state
      target/arm/machine: move cpu_post_load kvm bits to kvm_arm_cpu_post_load function
      target/arm/kvm-stub: add missing stubs
      target/arm/machine: compile file once (system)
      target/arm/tcg/vec_internal: use forward declaration for CPUARMState
      target/arm/tcg/crypto_helper: compile file once
      target/arm/tcg/hflags: compile file twice (system, user)
      target/arm/tcg/iwmmxt_helper: compile file twice (system, user)
      target/arm/tcg/neon_helper: compile file twice (system, user)
      target/arm/tcg/tlb_helper: compile file twice (system, user)
      target/arm/helper: restrict define_tlb_insn_regs to system target
      target/arm/tcg/tlb-insns: compile file once (system)
      target/arm/tcg/arith_helper: compile file once
      target/arm/tcg/vfp_helper: compile file twice (system, user)

Santiago Monserrat Campanello (1):
      hw/arm: Replace TABs for spaces in OMAP board and device code

Thomas Huth (1):
      MAINTAINERS: Add an entry for the Bananapi machine

 MAINTAINERS                         |   10 +
 meson.build                         |   78 ++-
 include/hw/arm/omap.h               |  534 ++++++++--------
 include/hw/arm/sharpsl.h            |    2 +-
 include/hw/arm/soc_dma.h            |    4 +-
 include/system/hvf.h                |    1 +
 include/tcg/tcg-op-common.h         |    1 +
 include/tcg/tcg.h                   |   14 +
 target/arm/cpu-qom.h                |    5 -
 target/arm/cpu.h                    |    4 -
 target/arm/helper.h                 | 1152 +---------------------------------
 target/arm/internals.h              |    9 +-
 target/arm/kvm_arm.h                |   87 +--
 target/arm/tcg/helper.h             | 1153 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/vec_internal.h       |    2 +
 include/exec/helper-head.h.inc      |   11 +
 hw/arm/omap1.c                      | 1016 +++++++++++++++---------------
 hw/arm/omap_sx1.c                   |    2 +-
 hw/core/cpu-common.c                |    3 +-
 hw/dma/omap_dma.c                   |  334 +++++-----
 hw/gpio/omap_gpio.c                 |   28 +-
 hw/i2c/omap_i2c.c                   |  178 +++---
 hw/intc/omap_intc.c                 |  154 ++---
 hw/misc/omap_clk.c                  |  470 +++++++-------
 hw/timer/pxa2xx_timer.c             |   76 +--
 target/arm/arch_dump.c              |    6 -
 target/arm/cpu.c                    |   83 ++-
 target/arm/cpu32-stubs.c            |   26 +
 target/arm/cpu64.c                  |   82 +--
 target/arm/debug_helper.c           |    6 +-
 target/arm/helper.c                 |   24 +-
 target/arm/hyp_gdbstub.c            |    6 +-
 target/arm/kvm-stub.c               |   97 +++
 target/arm/kvm.c                    |   45 +-
 target/arm/machine.c                |   15 +-
 target/arm/ptw.c                    |    6 +-
 target/arm/tcg/arith_helper.c       |    5 +-
 target/arm/tcg/cpu64.c              |    2 +-
 target/arm/tcg/crypto_helper.c      |    6 +-
 target/arm/tcg/hflags.c             |    4 +-
 target/arm/tcg/iwmmxt_helper.c      |    4 +-
 target/arm/tcg/neon_helper.c        |    4 +-
 target/arm/tcg/op_helper.c          |    2 +-
 target/arm/tcg/tlb-insns.c          |    7 -
 target/arm/tcg/tlb_helper.c         |    5 +-
 target/arm/tcg/translate-a64.c      |    2 +-
 target/arm/tcg/translate.c          |    2 +-
 target/arm/tcg/vfp_helper.c         |    4 +-
 target/microblaze/cpu.c             |   22 +-
 tcg/tcg.c                           |    5 +
 rust/hw/char/pl011/src/registers.rs |  261 ++------
 target/arm/meson.build              |   45 +-
 target/arm/tcg/meson.build          |   29 +-
 53 files changed, 3033 insertions(+), 3100 deletions(-)
 create mode 100644 target/arm/tcg/helper.h
 create mode 100644 target/arm/cpu32-stubs.c

