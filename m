Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9B5CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQij-0008Dg-3T; Mon, 12 Jan 2026 17:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQig-00089v-0p
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQic-0002RY-LN
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:05 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so64779925e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258139; x=1768862939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zA2TCc41WZsCmMa/LlDEdPqPXZSkBSOTZHpZgtcfKkc=;
 b=hbsIgzEdLl6oSsR9auFzKweT9wD0zAn7l7M3vsaAcPlgpDkZxKzDLmdtM6fb+Qkuhm
 0m7xiFp5jbC/u/Pr2m11V6tTSCFwDxn8AytUpa6lY9iMoxtTjb8ROp0dNAhwJptnahzb
 Vf7XbqWd2zdpQXIsrSRBTcYgPboEu7bJ6EI5NKROPwxe/Im9xgpy1KOJ51r56Er5sfrp
 CD95berSWJKZvm09EDJMw3dtKyNGykXZlaNWXkM335BmElstfR5zyN/+kHeHhWtb6R8E
 CMfhnDtu0LwDRbvHr6PCw+6g8n8Hxyl1Ylh6TpB6DPIkajVqhr6gLtyr8plpeUTHtpuV
 Fz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258139; x=1768862939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zA2TCc41WZsCmMa/LlDEdPqPXZSkBSOTZHpZgtcfKkc=;
 b=OVRSp1YoQAo2nZws52wwJ5eWYjrToojXgYeLsReqQtfcTEMTkiAxyB5ghlqgvptEcn
 iNMMhvP52gzSLnvRln2Bbzf2zUbgOPB8iowJ9Iu9F+6f4FAPEU72hd5NIt47X6Ll1bQI
 /Sp54jY7kqh95twRMV+MnfVzkUx69v/oA6Xg53ZaC73VWPPd+0FviSmeQXT/s2InyzU+
 4f3XrybrO8cBLPHdx1zXBlSmfpzuHRdG6WwtqzLVnnUDqLkOp0UQUH3oOaGWkGWAHjVt
 Z2kEMck+/ppoNpw/wM+oVudTPzeohp1Naz2v4UntAHLGja17WlMtHJwtvqS+uI7oc66r
 JGGw==
X-Gm-Message-State: AOJu0YwovvZwDNvs90oQ32Ev4PqwqO6iOaeb5Q2lz5osBEQ1M6944fiv
 NnYTvpyyz/BDkBJH65Ak003yslI6PvhwrSm33VoAtVeVWNd5EFtNAzef70QQffopMBJsbW2syod
 MqI78KFk=
X-Gm-Gg: AY/fxX71gLVaWE7lpn28XPUDOtA11UImi3NYL/Vd9bQLszmmAGmCyZpAq1IqX1IW5vL
 OIRbfgpsRvIFW8KcF5yYsJL8z6BA4PDCbg29TK8QjDuG6mabXqDwAwqK8Uzn120Iu7K1HRQDZZ1
 lQW/DI4OWyHAaMKhtfUtJWh18xN8v92wUe6YHQeFue5HOWuTgalkYDCYWHwH4UNOG4arJzgur3K
 kVHOPr061/FNPaS43XvQLZ9ZAuol3cQOsc1YXjiNqsy7Pd6WFkG0RCQhWBbyjlWdXZZR2D/x51N
 A8pmGl5+DK6dosXSo8lBGa3zGkJsfpB/eUoWRlrCiJeHAf164w96aqY4SeTnXKr0il+ItCr8uB1
 wZSxxApLPvTs0n9eJttOMZ6VOD2UEMZLY7xiFmFyGEZR7Flc/5iucVpduZ42U5f/CjqhEGxh4H7
 CEpe1EZ+d95gPjyCNI5ZBvL3nVFZATsOcg99wwBdUK6xtcxbZACD0tSRWV3D9D
X-Google-Smtp-Source: AGHT+IGJjCTILqo8nVx6IiAx+O4mJB+t3cVT5Kx1j9u1t7RCcrX/Q9f/0Q+yr/bNbpgDWZ4Vfg/prg==
X-Received: by 2002:a05:600c:3110:b0:479:3a86:dc1a with SMTP id
 5b1f17b1804b1-47d84b41176mr223837345e9.36.1768258138974; 
 Mon, 12 Jan 2026 14:48:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm364428585e9.5.2026.01.12.14.48.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:48:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/61] Misc single binary patches for 2026-01-12
Date: Mon, 12 Jan 2026 23:47:55 +0100
Message-ID: <20260112224857.42068-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

The following changes since commit 81f1fc471c053c9d3915c3e1f8b37503bd9a9cb7:

  Merge tag 'pull-loongarch-20260112' of https://github.com/bibo-mao/qemu into staging (2026-01-13 08:23:10 +1100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260112

for you to fetch changes up to f445b4a4b6fa5b03503bc8fdfa4c336e13afc48f:

  target/arm/gdbstub: make compilation unit common (2026-01-12 23:47:57 +0100)

----------------------------------------------------------------
Various patches related to single binary effort:

- Endianness cleanups in memory core subsystem and for various targets
- Few cleanups around target_ulong type
- Build various compilation units as common

----------------------------------------------------------------

Alex Bennée (1):
  target/sh4: drop cpu_reset from realizefn

Anton Johansson (1):
  target/alpha: Introduce alpha_phys_addr_space_bits()

Philippe Mathieu-Daudé (56):
  MAINTAINERS: Cover 'system/memory_ldst*.h.inc' files
  docs/devel/loads-stores: Fix ld/stn_*_p() regexp
  bswap: Consistently use builtin bswap() functions
  tests/qtest: Remove unnecessary 'qemu/bswap.h' include
  system/physmem: Inline and remove leul_to_cpu()
  system/physmem: Convert DEBUG_SUBPAGE printf() to trace events
  system/memory: Split MemoryRegionCache API to 'memory_cached.h'
  system/memory: Inline address_space_stq_internal()
  system/ioport: Declare x86-specific I/O port in little-endian order
  system/ioport: Do not open-code address_space_ld/st_le() methods
  meson: Allow system binaries to not have target-specific units
  hw/alpha: Use explicit little-endian LD/ST API
  target/alpha: Inline cpu_ldl_code() call in do_unaligned_access()
  target/alpha: Inline translator_ldl()
  target/avr: Inline translator_lduw()
  target/hexagon: Inline translator_ldl()
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  target/hppa: Use big-endian variant of cpu_ld/st_data*()
  target/hppa: Remove unnecessary @cpu variable by using cpu_env()
  target/hppa: Use explicit big-endian LD/ST API
  target/hppa: Inline translator_ldl()
  target/hppa: Avoid target-specific migration headers in machine.c
  target/hppa: Remove target_ulong use in disas_log() handler
  hw/loongarch: Use explicit little-endian LD/ST API
  target/loongarch: Replace target_ulong -> uint64_t for DMW and
    TLBRBADV
  target/loongarch: Use hwaddr type for physical addresses
  target/loongarch: Replace MO_TE -> MO_LE
  target/loongarch: Inline cpu_ldl_code() call in cpu_do_interrupt()
  target/loongarch: Use explicit little-endian LD/ST API
  target/loongarch: Inline translator_ldl()
  target/m68k: Replace MD_TLONG -> MD_I32 in monitor.c
  target/microblaze: Directly check endianness via CPUConfig::endi flag
  target/microblaze: Avoid target-specific migration headers in
    machine.c
  target/microblaze: Build system files once
  hw/microblaze: Replace TARGET_BIG_ENDIAN -> target_big_endian()
  hw/microblaze: Build files once
  hw/intc: Mark OpenRISC-specific peripheral as big-endian
  target/openrisc: Use explicit big-endian LD/ST API
  target/openrisc: Inline translator_ldl()
  target/openrisc: Remove unused 'gdbstub/helpers.h' header in helper.c
  target/openrisc: Avoid target-specific migration headers in machine.c
  target/openrisc: Build system units in common source set
  target/rx: Use little-endian variant of cpu_ld/st_data*()
  target/rx: Use explicit little-endian LD/ST API
  target/rx: Inline translator_lduw() and translator_ldl()
  target/rx: Build system units in common source set
  target/sh4: Build system units in common source set
  hw/sparc: Mark SPARC-specific peripherals as big-endian
  hw/sparc: Use explicit big-endian LD/ST API
  target/sparc: Use explicit big-endian LD/ST API
  target/sparc: Inline translator_ldl()
  target/sparc: Inline cpu_ldl_code() call in cpu_do_interrupt()
  target/tricore: Use little-endian variant of cpu_ld/st_data*()
  target/tricore: Inline translator_lduw()
  target/tricore: Build system units in common source set
  accel/tcg: Un-inline WatchPoint API user-emulation stubs

Pierrick Bouvier (3):
  gdbstub/helpers.h: allow header to be called from common code
  target/arm/gdbstub: extract aarch64_cpu_register_gdb_regs_for_features
  target/arm/gdbstub: make compilation unit common

 MAINTAINERS                                   |   2 +
 docs/devel/loads-stores.rst                   |   8 +-
 meson.build                                   |   8 +-
 include/accel/tcg/cpu-ops.h                   |  17 --
 include/exec/watchpoint.h                     |  23 --
 include/gdbstub/helpers.h                     |   9 +-
 include/hw/virtio/virtio-access.h             |   1 +
 include/qemu/bswap.h                          |  11 -
 include/qemu/host-utils.h                     |   6 +-
 include/qemu/int128.h                         |   5 +-
 include/system/memory.h                       | 185 ---------------
 include/system/memory_cached.h                | 210 ++++++++++++++++++
 linux-user/alpha/target_proc.h                |  23 +-
 target/arm/internals.h                        |   1 +
 target/hexagon/macros.h                       |   6 +-
 tests/qtest/pnv-xive2-common.h                |   1 -
 accel/tcg/user-exec-stub.c                    |  33 +++
 hw/alpha/dp264.c                              |  11 +-
 hw/alpha/typhoon.c                            |   4 +-
 hw/audio/cs4231.c                             |   2 +-
 hw/char/grlib_apbuart.c                       |   2 +-
 hw/display/cg3.c                              |   2 +-
 hw/display/tcx.c                              |  14 +-
 hw/dma/sparc32_dma.c                          |   2 +-
 hw/intc/grlib_irqmp.c                         |   2 +-
 hw/intc/ompic.c                               |   2 +-
 hw/intc/slavio_intctl.c                       |   4 +-
 hw/loongarch/virt.c                           |  18 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |   4 +-
 hw/misc/eccmemctl.c                           |   2 +-
 hw/misc/slavio_misc.c                         |  16 +-
 hw/rtc/sun4v-rtc.c                            |   2 +-
 hw/sparc/leon3.c                              |  42 ++--
 hw/sparc/sun4m.c                              |   6 +-
 hw/sparc64/sun4u.c                            |   6 +-
 hw/timer/grlib_gptimer.c                      |   2 +-
 hw/timer/slavio_timer.c                       |   2 +-
 system/ioport.c                               |  34 ++-
 system/physmem.c                              |  35 +--
 target/alpha/mem_helper.c                     |   4 +-
 target/alpha/translate.c                      |   4 +-
 target/arm/cpu32-stubs.c                      |  21 ++
 target/arm/gdbstub.c                          |  61 +----
 target/arm/gdbstub64.c                        |  57 +++++
 target/avr/translate.c                        |   2 +-
 target/hexagon/op_helper.c                    |   6 +-
 target/hexagon/translate.c                    |  11 +-
 target/hppa/gdbstub.c                         |   8 +-
 target/hppa/int_helper.c                      |   2 +-
 target/hppa/machine.c                         |   3 +-
 target/hppa/op_helper.c                       |  44 ++--
 target/hppa/translate.c                       |   5 +-
 target/loongarch/cpu_helper.c                 |  12 +-
 target/loongarch/tcg/iocsr_helper.c           |  24 +-
 target/loongarch/tcg/tcg_cpu.c                |   4 +-
 target/loongarch/tcg/tlb_helper.c             |  10 +-
 target/loongarch/tcg/translate.c              |   3 +-
 target/m68k/monitor.c                         |  60 ++---
 target/microblaze/machine.c                   |   3 +-
 target/microblaze/translate.c                 |   8 +-
 target/openrisc/gdbstub.c                     |   2 +-
 target/openrisc/interrupt.c                   |   1 -
 target/openrisc/machine.c                     |   3 +-
 target/openrisc/mmu.c                         |   1 -
 target/openrisc/translate.c                   |   3 +-
 target/rx/cpu.c                               |   2 +-
 target/rx/gdbstub.c                           |  24 +-
 target/rx/helper.c                            |  14 +-
 target/rx/op_helper.c                         |   6 +-
 target/rx/translate.c                         |  10 +-
 target/sh4/cpu.c                              |   1 -
 target/sparc/int32_helper.c                   |   4 +-
 target/sparc/ldst_helper.c                    |  36 +--
 target/sparc/mmu_helper.c                     |  32 +--
 target/sparc/translate.c                      |   2 +-
 target/tricore/op_helper.c                    | 152 ++++++-------
 target/tricore/translate.c                    |   9 +-
 tests/qtest/aspeed_smc-test.c                 |   1 -
 tests/qtest/ast2700-smc-test.c                |   1 -
 tests/qtest/endianness-test.c                 |  10 +-
 tests/qtest/libqos/fw_cfg.c                   |   1 -
 tests/qtest/libqos/i2c-omap.c                 |   1 -
 tests/qtest/libqtest.c                        |  13 +-
 tests/qtest/pnv-spi-seeprom-test.c            |   1 -
 system/memory_ldst.c.inc                      |   2 +-
 .../tcg/insn_trans/trans_atomic.c.inc         |  80 +++----
 .../tcg/insn_trans/trans_fmemory.c.inc        |  32 +--
 .../tcg/insn_trans/trans_memory.c.inc         |  64 +++---
 .../loongarch/tcg/insn_trans/trans_vec.c.inc  |  16 +-
 hw/microblaze/meson.build                     |   2 +-
 system/trace-events                           |   6 +
 target/arm/meson.build                        |  12 +-
 target/microblaze/meson.build                 |   2 +-
 target/openrisc/meson.build                   |   2 +-
 target/rx/meson.build                         |   2 +-
 target/sh4/meson.build                        |   2 +-
 target/tricore/meson.build                    |   2 +-
 97 files changed, 863 insertions(+), 806 deletions(-)
 create mode 100644 include/system/memory_cached.h

-- 
2.52.0


