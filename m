Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC811C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDRr-0007Br-B3; Thu, 06 Mar 2025 10:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDRo-0007Am-Cm
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:47:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDRl-0006BX-2M
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:47:43 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so484223f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276059; x=1741880859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wuI7V/wj7tWMmMltqycpG0sxIIJcyAqxcbZTwRonqDg=;
 b=X/TbEFMz2lNZ5z5kfySHQ19j5ZewU1KBQH+topVpXEodH9unjicPjw2l3nsn5WrK4U
 eGCT10Xs6DU3JmuLJNvgETa3TadzuHBKTaffM3ZSt+lh50LUM11UsmyYV7SSyiS2dnMF
 440TLxGnM3xIrxWK99Kc70H82OcXdcK1PXQNyPNYatdVgdStrfhWOdGYDgP6iIKNkcZp
 1vpao0JcNi5cNLzkEvA9ZOfLk7Tcg3794Ub1SY+DF+S+o8ZxHsrRx+g4R7Z9zIlTxQcU
 0rtUYEu4X9rAiEEPRs8bcNijm4GOcwFBp+b5cD5gl5pg1O+K4imh2Du+tMQVNUWbbfLM
 4B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276059; x=1741880859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wuI7V/wj7tWMmMltqycpG0sxIIJcyAqxcbZTwRonqDg=;
 b=CIATTzE60NQP3iCL+/ijJpWEm3xSKw8lVqkHGoajUnTTDDDG/JnHOByhxQ8jEzj7Mg
 ReiaD6Tuwo9i3LOixRy1y8p4bDD2Q3Doba3WkSj+UuIiEf2UH8ufXflkyBzhg1U4MMC+
 oEPJ5ypjjhF5UmWgrNvJWvjNwXX+vmlPL4ZyemAwrX1Sxf7DuefyAbqLolKdWm+PqTPY
 zZe123DUED4oI5s3QNSJN51Sjce7RpsG0rNXYrUkT3Yi1FkMqZK8u2sJ0ytDPiJ+G6Yk
 /PyMvd56CFhEMna58z06vacg6+9h+pTQXRAvaUH2HswiL1YT9zbwqq4kHfILl5vl2b/b
 eUGQ==
X-Gm-Message-State: AOJu0YxgHERNcLKFDUsZbf4EOk1ktHhwLacLdjVQa5XJfjFgi69xKFhp
 kOFBIXDYdvNbW2v+y88RAtbw/j+G4VujwtXv68bhpJOFCca2iJ0SxnbmMahOyvYYtI6PphwbxVX
 KioU=
X-Gm-Gg: ASbGncuuW1RhwwKJPFVy+XrurZweZw9py0btgtdymqez30mfIZANU+JQQ0l2TemXyxF
 csqhIthRF3TllMdlf963e63T8YbfVSYjQ6ThzRwG7RVvNrw0RpZt3D7+l0a1RY9oWqIDiZ0rNk8
 wuq13KdTkAGmNHPfFHDuppOnVQ43eWfd+GxMS9eWLgy4diV8kWRs01Iy1b2B1W+pXKjLREdFK+L
 wwUw2eXAt/nAbp1gsa8yoQYthBtHur3s4JeKDW6Q2kqzhtJBAemljipOE2iDy2dGxaWJmvpARgK
 YLAdERZ9UUvQGaCApXUjRwZAZoL9oB5pTUo3qrNern3iOdGRq67HxgZG5WUfB1wbAmPKIrA0I8d
 n+zSeFdRaz7sFsaTJ5WI=
X-Google-Smtp-Source: AGHT+IFNuDy9qaomZ5Ip64d3cr+C6HWVcRKzks9V0PzmykU7nCtwWnNf1gxzgUKJ1DhMDBY7r0u1rg==
X-Received: by 2002:a05:6000:1844:b0:391:304f:34e7 with SMTP id
 ffacd0b85a97d-391304f3856mr1083691f8f.44.1741276058703; 
 Thu, 06 Mar 2025 07:47:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e344esm2381259f8f.73.2025.03.06.07.47.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:47:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/54] Accelerators & CPU patches
Date: Thu,  6 Mar 2025 16:46:42 +0100
Message-ID: <20250306154737.70886-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

The following changes since commit e8a01102936286e012ed0f00bd7f3b7474d415c9:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-03-05 21:58:23 +0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-cpus-20250306

for you to fetch changes up to 92941c94e7f4858fdd61b4c1b85f6d1c6f164359:

  include: Poison TARGET_PHYS_ADDR_SPACE_BITS definition (2025-03-06 15:46:18 +0100)

----------------------------------------------------------------
Generic CPUs / accelerators patch queue

- Merge "qemu/clang-tsa.h" within "qemu/compiler.h"
- Various cleanups around accelerators initialization code
  (better user/system split)
- Various trivial cleanups in accel/tcg/,
  Guard few TCG calls with tcg_enabled()
- Explicit disassemble_info endianness
- Improve dual-endianness support for MicroBlaze

Ignored checkpatch error:

  WARNING: architecture specific defines should be avoided
  #215: FILE: include/qemu/compiler.h:215:
  +#ifdef __clang__

----------------------------------------------------------------

Denis Rastyogin (1):
  target/mips: Fix possible MSA int overflow

Phil Dennis-Jordan (1):
  target/i386/hvf: Variable type fixup in decoder

Philippe Mathieu-Daudé (52):
  qemu/compiler: Absorb 'clang-tsa.h'
  gdbstub: Clarify no more than @gdb_num_core_regs can be accessed
  gdbstub: Check for TCG before calling tb_flush()
  cpus: Cache CPUClass early in instance_init() handler
  cpus: Keep default fields initialization in cpu_common_initfn()
  accel/accel: Make TYPE_ACCEL abstract
  accel/tcg: Remove pointless initialization of cflags_next_tb
  accel/tcg: Build tcg_flags helpers as common code
  accel/tcg: Restrict tlb_init() / destroy() to TCG
  accel/tcg: Restrict 'icount_align_option' global to TCG
  accel/tcg: Rename 'hw/core/tcg-cpu-ops.h' -> 'accel/tcg/cpu-ops.h'
  accel: Rename 'hw/core/accel-cpu.h' -> 'accel/accel-cpu-target.h'
  accel: Forward-declare AccelOpsClass in 'qemu/typedefs.h'
  accel/accel-cpu-target.h: Include missing 'cpu.h' header
  accel/tcg: Include missing bswap headers in user-exec.c
  accel/tcg: Take mmap lock in the whole cpu_memory_rw_debug() function
  accel/tcg: Avoid using lock_user() in cpu_memory_rw_debug()
  accel/tcg: Move cpu_memory_rw_debug() user implementation to
    user-exec.c
  accel/kvm: Remove unused 'system/cpus.h' header in kvm-cpus.h
  cpus: Fix style in cpu-target.c
  cpus: Restrict cpu_common_post_load() code to TCG
  cpus: Have cpu_class_init_props() per user / system emulation
  cpus: Have cpu_exec_initfn() per user / system emulation
  cpus: Restrict cpu_get_memory_mapping() to system emulation
  hw/core/generic-loader: Do not open-code cpu_set_pc()
  target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
  target/microblaze: Set MO_TE once in do_load() / do_store()
  target/microblaze: Introduce mo_endian() helper
  target/microblaze: Consider endianness while translating code
  target/openrisc: Call cpu_openrisc_clock_init() in cpu_realize()
  target/hexagon: Ensure not being build on system emulation
  target/rx: Ensure not being build on user emulation
  target/tricore: Ensure not being build on user emulation
  target: Set disassemble_info::endian value for little-endian targets
  target: Set disassemble_info::endian value for big-endian targets
  target/arm: Set disassemble_info::endian value in disas_set_info()
  target/microblaze: Set disassemble_info::endian value in
    disas_set_info
  target/mips: Set disassemble_info::endian value in disas_set_info()
  target/ppc: Set disassemble_info::endian value in disas_set_info()
  target/riscv: Set disassemble_info::endian value in disas_set_info()
  target/sh4: Set disassemble_info::endian value in disas_set_info()
  target/xtensa: Set disassemble_info::endian value in disas_set_info()
  disas: Remove target_words_bigendian() call in
    initialize_debug_target()
  target/i386: Constify X86CPUModel uses
  target/sparc: Constify SPARCCPUClass::cpu_def
  target/xtensa: Finalize config in xtensa_register_core()
  target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
  target/riscv: Convert misa_mxl_max using GLib macros
  target/alpha: Do not mix exception flags and FPCR bits
  target/i386: Mark WHPX APIC region as little-endian
  system: Open-code qemu_init_arch_modules() using target_name()
  include: Poison TARGET_PHYS_ADDR_SPACE_BITS definition

 MAINTAINERS                                   |   5 +-
 accel/kvm/kvm-cpus.h                          |   2 -
 accel/tcg/internal-common.h                   |  13 ++
 bsd-user/qemu.h                               |   1 -
 .../accel-cpu.h => accel/accel-cpu-target.h}  |   7 +-
 .../tcg-cpu-ops.h => accel/tcg/cpu-ops.h}     |   0
 include/block/block_int-common.h              |   1 -
 include/block/graph-lock.h                    |   2 -
 include/exec/exec-all.h                       |  16 --
 include/exec/page-protection.h                |   2 -
 include/exec/poison.h                         |   1 +
 include/hw/core/cpu.h                         |   6 +-
 include/qemu/clang-tsa.h                      | 114 ----------
 include/qemu/compiler.h                       |  96 ++++++++
 include/qemu/thread.h                         |   1 -
 include/qemu/typedefs.h                       |   1 +
 include/system/accel-ops.h                    |   1 -
 include/system/arch_init.h                    |   2 -
 include/system/cpus.h                         |   4 -
 target/hexagon/cpu.h                          |   4 +
 target/i386/cpu.h                             |   2 +-
 target/microblaze/cpu.h                       |   7 +
 target/riscv/cpu.h                            |   2 +-
 target/rx/cpu.h                               |   6 +-
 target/sparc/cpu.h                            |   2 +-
 target/tricore/cpu.h                          |   4 +
 target/xtensa/cpu.h                           |   2 +-
 accel/accel-system.c                          |   1 +
 accel/accel-target.c                          |   3 +-
 accel/hvf/hvf-accel-ops.c                     |   1 +
 accel/kvm/kvm-accel-ops.c                     |   1 +
 accel/qtest/qtest.c                           |   1 +
 accel/stubs/tcg-stub.c                        |   4 -
 accel/tcg/cpu-exec-common.c                   |  34 ++-
 accel/tcg/cpu-exec.c                          |  35 +--
 accel/tcg/cputlb.c                            |   2 +-
 accel/tcg/icount-common.c                     |   2 +
 accel/tcg/monitor.c                           |   1 -
 accel/tcg/tcg-accel-ops.c                     |   1 +
 accel/tcg/translate-all.c                     |   3 +-
 accel/tcg/user-exec-stub.c                    |  11 +
 accel/tcg/user-exec.c                         |  84 ++++++-
 accel/tcg/watchpoint.c                        |   2 +-
 accel/xen/xen-all.c                           |   1 +
 block/create.c                                |   1 -
 bsd-user/signal.c                             |   2 +-
 cpu-common.c                                  |   1 -
 cpu-target.c                                  | 205 ++----------------
 disas/disas-common.c                          |   8 +-
 gdbstub/system.c                              |   6 +-
 hw/core/cpu-common.c                          |   6 +-
 hw/core/cpu-system.c                          |  47 ++++
 hw/core/cpu-user.c                            |  32 +++
 hw/core/generic-loader.c                      |   5 +-
 hw/mips/jazz.c                                |   2 +-
 hw/openrisc/openrisc_sim.c                    |   2 -
 hw/openrisc/virt.c                            |   2 -
 linux-user/signal.c                           |   2 +-
 system/arch_init.c                            |   9 -
 system/cpus.c                                 |   1 +
 system/globals.c                              |   1 -
 system/physmem.c                              |   2 +-
 system/vl.c                                   |   7 +-
 target/alpha/cpu.c                            |   3 +-
 target/alpha/fpu_helper.c                     |  15 +-
 target/arm/cpu.c                              |  12 +-
 target/arm/tcg/cpu-v7m.c                      |   2 +-
 target/arm/tcg/cpu32.c                        |   2 +-
 target/arm/tcg/mte_helper.c                   |   2 +-
 target/arm/tcg/sve_helper.c                   |   2 +-
 target/avr/cpu.c                              |   3 +-
 target/avr/helper.c                           |   2 +-
 target/hexagon/cpu.c                          |   3 +-
 target/hppa/cpu.c                             |   3 +-
 target/i386/cpu.c                             |   9 +-
 target/i386/hvf/hvf-cpu.c                     |   2 +-
 target/i386/hvf/x86_decode.c                  |   4 +-
 target/i386/kvm/kvm-cpu.c                     |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c             |   1 +
 target/i386/tcg/tcg-cpu.c                     |   4 +-
 target/i386/whpx/whpx-accel-ops.c             |   1 +
 target/i386/whpx/whpx-apic.c                  |   2 +-
 target/loongarch/cpu.c                        |   3 +-
 target/m68k/cpu.c                             |   3 +-
 target/microblaze/cpu.c                       |   4 +-
 target/microblaze/gdbstub.c                   |   5 -
 target/microblaze/translate.c                 |  49 +++--
 target/mips/cpu.c                             |  12 +-
 target/mips/tcg/msa_helper.c                  |   6 +-
 target/openrisc/cpu.c                         |   7 +-
 target/openrisc/gdbstub.c                     |   5 -
 target/ppc/cpu_init.c                         |   4 +-
 target/ppc/kvm.c                              |   2 +-
 target/riscv/cpu.c                            |  19 +-
 target/riscv/cpu_helper.c                     |   2 +-
 target/riscv/kvm/kvm-cpu.c                    |   2 +-
 target/riscv/tcg/tcg-cpu.c                    |   4 +-
 target/rx/cpu.c                               |   9 +-
 target/rx/helper.c                            |   4 -
 target/s390x/cpu.c                            |   3 +-
 target/s390x/tcg/mem_helper.c                 |   2 +-
 target/sh4/cpu.c                              |   4 +-
 target/sparc/cpu.c                            |   3 +-
 target/tricore/cpu.c                          |   2 +-
 target/xtensa/cpu.c                           |   4 +-
 target/xtensa/helper.c                        |   5 +-
 tests/unit/test-bdrv-drain.c                  |   1 -
 tests/unit/test-block-iothread.c              |   1 -
 util/qemu-thread-posix.c                      |   1 -
 hw/core/meson.build                           |   5 +-
 110 files changed, 544 insertions(+), 533 deletions(-)
 rename include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} (92%)
 rename include/{hw/core/tcg-cpu-ops.h => accel/tcg/cpu-ops.h} (100%)
 delete mode 100644 include/qemu/clang-tsa.h
 create mode 100644 hw/core/cpu-user.c

-- 
2.47.1


