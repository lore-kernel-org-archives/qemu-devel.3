Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8817FCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWLT-0000Es-5T; Thu, 15 Oct 2026 21:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLS-0000Ej-5Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:02:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLP-0004Br-QZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:02:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e86dce4510so30383625ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112566; x=1792717366; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CvTv9r0tZj6PfssqiJ1v1eqmrslaM+3Hwcy8B0ocDeI=;
 b=crUVY/3+Y26ELaASJ4z7PoKNtPw70ZsWqL/ynVphFkGpDszrQLNtcVRhu0+jyYdSV+
 zboI2eRWdhw41mTo6cQkJTkLcWxlCYwUW7WQnl4P/l5E9f0Nto/GMap2gfXzScyMN5/L
 5+VS41GxS0GiwY8pDx2f2RDIJy4OokCsdbdb/8wVTs7k5af0O+8Ly39bBWhtMdrl2PxU
 QNV8jFgA+bYUwmvTOL1+h53xtW1BBrQ3PwcKqh384gqIrnidbrQrhRz55Ko2LFVPFliQ
 5oHf5/qZqDFTe9ksYVe/k/EPBDmtwjZNQlEFy6vVjcRc1/y7xjL8LplMXGsDjBmEKcEH
 MiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112566; x=1792717366;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CvTv9r0tZj6PfssqiJ1v1eqmrslaM+3Hwcy8B0ocDeI=;
 b=tyrHT3ZEurPtd7HNDPGToel/X4NEYll9lKVBWOyZLlJlhbzDXTGZ/6MQ4WBOyu3Dwp
 lW2fWjWDrXa6XjckhUl5ihF5vrxb+N8uvB8ezRynnJcXkNMeu8hhTO+SQnNMD6oZR2g2
 5AjRS99TtL3IumkHZO3UNU30s4hDqfEnGBwPpARhCwZafAKFmOWRk+Z1CFua/9RO/aSS
 kJVp1ujhk1ZkssSx3o42cEqL/ZV9H/Y/n3OKYeX2Bxi49JjukwAjrRP9tKU56ytNa0F3
 y2JabLuMgEZP2sAbzJ0cwD/1uL61icmllNpsKf53BwQige24xlixxDXlk7W0RiXZnGYT
 xf+g==
X-Gm-Message-State: AFq9FYLWQ+ytyhZNir9T4izRb/6rsI4MYZZ2+7Ei/VWLKoAWEWGnHCls
 iryr9DU0QUYXs5wbNsEL0rHiWssLNR1T7odTaJ9AK8tqj3VixQV/jAnd93a/fQ==
X-Gm-Gg: AYBFou3pboCWjQKHzCKR4Y8bZOEXBxna+19To2BfOYlAWDGghv+bxt9lGR9t8R0S3jK
 m54gQBXNh5lIhEoWe8yEhCAbNzjYP7FJAMIv3GyDQb8Hyvgf9E5dL/KZutwhVTvR1HcjKeUKtKA
 5emS4qDlllJN3r2f0YScJH+zi96Fpifr7bLoYe2M5mq2tPgZXRcQstYJHHpvIiA1KCSqhHHxylJ
 1YyQjehWBNLvGmzzcFAbLzxvo9BKBh3dFPaBqmugKVnhdYRzw7xUO2iZIivSAqA+U50nsRNivGj
 uca+9MTUYHXkWCxlOn6TW8JOW9DHnz2UF5tHydIz5HSJsnkzxpD4TQ4LcHfvAhNxyjnXwP+onEu
 gqWCvD8eVDp9u0MAbK/HWMPb4Hu9Mr597/u3HHpJ6ZHV52uPocjS/v9GDkS6hSkBVvUrwBtTa4g
 SgVjdlxAp+06UM/ok6oqSUwg9y1zGeMwgCnVz6BrMciBVc4+DilukezSWK3858Cg0tcgVRKKTe3
 mz4np/mB3OBKNro
X-Received: by 2002:a17:902:dac9:b0:2e3:1d30:8658 with SMTP id
 d9443c01a7336-2e842836264mr183097255ad.10.1792112565628; 
 Thu, 15 Oct 2026 18:02:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:02:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/50] riscv-to-apply queue
Date: Fri, 16 Oct 2026 11:01:47 +1000
Message-ID: <20261016010237.1102834-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269:

  Merge tag 'pull-aspeed-20261015' of https://github.com/legoater/qemu into staging (2026-10-15 14:58:28 +0200)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20261016

for you to fetch changes up to bfdd4f6a918ffad4f013d4f53a9adca1adc0aa3b:

  target/riscv: normalize Zcmt jvt.mode on writes (2026-10-16 10:40:39 +1000)

----------------------------------------------------------------
RISC-V PR for 11.2

* Check G-stage write permission for VS-stage A/D updates
* Restore LCOFI handling in interrupt CSRs
* Fix csrrs disasembly decoding
* Stop translating after WFI
* Raise virtual instruction exception on svinval instructions
* Fix some KVM migration issues
* Add support for Milk-V Duo board
* Make MIP accesses atomic and BQL-safe
* Add initial sdext support
* Add SiFive Xsfvqmaccdod/Xsfvqmaccqoq int8 matmul extensions
* Add the Server Platform Reference Board
* Revert invalidate reservations after stores for linux user
* Fix the UART register width in SPCR
* Check Svnapot PTE before updating A/D bits
* Add Tenstorrent Atlantis PRCM model
* Fix RV32 fixed counter accesses
* Write back fsgnjn.h and fsgnjx.h results
* Ensure Zcmt jvt.mode is WARL

----------------------------------------------------------------
Alistair Francis (1):
      Revert "linux-user/riscv: invalidate reservations after stores"

Anirudh Srinivasan (3):
      hw/misc: Add Tenstorrent Atlantis PRCM model
      hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis model
      hw/riscv/tt-atlantis: Update UART and I2C to use clk from PRCM

Chao Liu (6):
      target/riscv: add sdext debug CSRs state
      target/riscv: add sdext Debug Mode helpers
      target/riscv: add dret instruction
      target/riscv: add sdext enter Debug Mode on ebreak
      target/riscv: add sdext single-step support
      target/riscv: add sdtrig trigger action=debug mode

Christian S. Lima (1):
      targetriscv: svinval instructions raise virtual instruction exception

Daniel Henrique Barboza (6):
      tests/tcg/riscv64: add sdext "not on Debug mode" sigill tests
      target/riscv/cpu.c: remove 'bare' condition for .profile
      target/riscv: add riscv-server-ref CPU
      hw/riscv: server platform reference machine
      tests/functional/riscv64: add riscv-server-ref tests
      docs: add riscv-server-ref.rst

Frank Chang (2):
      target/riscv/cpu: Add SiFive custom int8 matmul extension implied rules
      target/riscv: rvv: Add SiFive custom int8 matmul instructions

Jason Chien (1):
      disas/riscv: Add disassembler support for Xsfvqmaccdod/Xsfvqmaccqoq

Kuan-Wei Chiu (7):
      hw/char: Add dw8250 UART
      hw/misc: Add Sophgo CV1800B clock controller
      hw/riscv: Add Sophgo CV1800B SoC support
      hw/riscv: Add Milk-V Duo board support
      tests/qtest: Add qtest for Milk-V Duo board
      tests/functional/riscv64: Add boot test for Milk-V Duo board
      docs/system/riscv: Add Milk-V Duo board documentation

Max Chou (3):
      target/riscv: Add cfg property for SiFive int8 matmul extensions
      target/riscv/cpu: List one implied-ext rule per line
      tests/tcg/riscv64: Add tests for SiFive int8 matmul extensions

Mayuresh Chitale (1):
      target/riscv: Restore LCOFI handling in interrupt CSRs

Philippe Mathieu-Daudé (6):
      target/riscv: Document riscv_cpu_update_mip()
      target/riscv: Document kvm_riscv_set_irq()
      target/riscv: Clarify riscv_accel_set_irq() arguments
      target/riscv: Have riscv_cpu_set_mode() call riscv_cpu_interrupt()
      target/riscv: Add riscv_cpu_get_mip()
      target/riscv: Access MIP atomically

Richard Henderson (1):
      disas/riscv: Fix csrrs decode

Rick Richard (3):
      tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
      hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
      tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden reference

Xie Bo (3):
      target/riscv/kvm: Preserve FCSR across migration
      target/riscv/kvm: Reject migration with a different timer frequency
      target/riscv/kvm: Preserve VCSR across migration

Zephyr Li (2):
      target/riscv: stop translating after WFI
      target/riscv: fix RV32 fixed counter accesses

dodochicha (1):
      target/riscv: Check Svnapot PTE before updating A/D bits

imaginos (1):
      target/riscv: check G-stage write permission for VS-stage A/D updates

wangyang (2):
      target/riscv: write back fsgnjn.h and fsgnjx.h results
      target/riscv: normalize Zcmt jvt.mode on writes

 MAINTAINERS                                        |  31 +
 docs/system/riscv/milkv-duo.rst                    |  49 ++
 docs/system/riscv/riscv-server-ref.rst             |  65 ++
 docs/system/riscv/tt_atlantis.rst                  |   1 +
 docs/system/target-riscv.rst                       |   2 +
 configs/devices/riscv64-softmmu/default.mak        |   2 +
 disas/riscv-xsf.h                                  |  16 +
 disas/riscv.h                                      |   1 +
 include/exec/translation-block.h                   |   4 +-
 include/hw/char/dw8250.h                           |  28 +
 include/hw/misc/cv1800b_clk.h                      |  26 +
 include/hw/misc/tt_atlantis_prcm.h                 |  51 ++
 include/hw/riscv/cv1800b.h                         |  56 ++
 include/hw/riscv/tt_atlantis.h                     |  28 +
 linux-user/riscv/target_cpu.h                      |   2 -
 target/riscv/cpu-qom.h                             |   1 +
 target/riscv/cpu.h                                 |  37 +-
 target/riscv/cpu_bits.h                            |  33 +
 target/riscv/cpu_cfg.h                             |   5 +
 target/riscv/helper.h                              |  16 +-
 target/riscv/kvm/kvm_riscv.h                       |   7 +
 target/riscv/cpu_cfg_fields.h.inc                  |   3 +
 target/riscv/insn32.decode                         |   1 +
 target/riscv/xsf.decode                            |  30 +
 disas/riscv-xsf.c                                  |  49 ++
 disas/riscv.c                                      |   5 +-
 hw/char/dw8250.c                                   | 130 ++++
 hw/intc/riscv_aclint.c                             |   2 +-
 hw/misc/cv1800b_clk.c                              |  98 +++
 hw/misc/tt_atlantis_prcm.c                         | 428 ++++++++++++
 hw/riscv/cv1800b.c                                 | 177 +++++
 hw/riscv/milkv_duo.c                               | 118 ++++
 hw/riscv/server_platform_ref.c                     | 776 +++++++++++++++++++++
 hw/riscv/tt_atlantis.c                             | 125 +++-
 hw/riscv/virt-acpi-build.c                         |   2 +-
 target/riscv/cpu.c                                 | 134 +++-
 target/riscv/kvm/kvm-cpu.c                         |  74 +-
 target/riscv/machine.c                             |  80 +++
 target/riscv/tcg/cpu_helper.c                      | 148 +++-
 target/riscv/tcg/csr.c                             | 254 ++++++-
 target/riscv/tcg/debug.c                           |  59 +-
 target/riscv/tcg/op_helper.c                       | 107 ++-
 target/riscv/tcg/tcg-cpu.c                         |  36 +
 target/riscv/tcg/translate.c                       |  56 +-
 target/riscv/tcg/xsf_helper.c                      |  87 +++
 target/riscv/time_helper.c                         |  12 +-
 tests/qtest/milkv-duo-test.c                       |  70 ++
 disas/riscv-xsf-op.c.inc                           |  11 +
 target/riscv/tcg/insn_trans/trans_privileged.c.inc |  25 +
 target/riscv/tcg/insn_trans/trans_rva.c.inc        |  24 -
 target/riscv/tcg/insn_trans/trans_rvi.c.inc        |  11 -
 target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc    |   3 -
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc      |   2 +
 target/riscv/tcg/insn_trans/trans_svinval.c.inc    |   3 +
 target/riscv/tcg/insn_trans/trans_xsf.c.inc        |  98 +++
 target/riscv/tcg/insn_trans/trans_xthead.c.inc     |  12 +-
 disas/meson.build                                  |   3 +-
 hw/char/Kconfig                                    |   4 +
 hw/char/meson.build                                |   1 +
 hw/misc/Kconfig                                    |   3 +
 hw/misc/meson.build                                |   2 +
 hw/misc/trace-events                               |   4 +
 hw/riscv/Kconfig                                   |  31 +
 hw/riscv/meson.build                               |   4 +
 meson_options.txt                                  |   4 +
 scripts/meson-buildoptions.sh                      |   2 +
 target/riscv/meson.build                           |   1 +
 target/riscv/tcg/meson.build                       |   1 +
 tests/data/acpi/riscv64/virt/SPCR                  | Bin 90 -> 90 bytes
 tests/functional/riscv64/meson.build               |   3 +
 tests/functional/riscv64/test_milkv_duo.py         |  53 ++
 tests/functional/riscv64/test_opensbi.py           |   4 +
 tests/functional/riscv64/test_server_ref.py        |  90 +++
 tests/qtest/meson.build                            |   3 +-
 tests/tcg/meson.build                              |   1 +
 tests/tcg/riscv32/meson.build                      |   6 +
 tests/tcg/riscv32/semihost.ld                      |  23 +
 tests/tcg/riscv32/system/meson.build               |  36 +
 tests/tcg/riscv32/test-mcycle.S                    |  45 ++
 tests/tcg/riscv64/system/meson.build               |  16 +
 tests/tcg/riscv64/test-minstret-wfi.S              | 100 +++
 tests/tcg/riscv64/test-sdext-sigill.S              |  83 +++
 tests/tcg/riscv64/test-xsfvqmacc.S                 | 260 +++++++
 83 files changed, 4263 insertions(+), 231 deletions(-)
 create mode 100644 docs/system/riscv/milkv-duo.rst
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 disas/riscv-xsf.h
 create mode 100644 include/hw/char/dw8250.h
 create mode 100644 include/hw/misc/cv1800b_clk.h
 create mode 100644 include/hw/misc/tt_atlantis_prcm.h
 create mode 100644 include/hw/riscv/cv1800b.h
 create mode 100644 target/riscv/xsf.decode
 create mode 100644 disas/riscv-xsf.c
 create mode 100644 hw/char/dw8250.c
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 hw/misc/tt_atlantis_prcm.c
 create mode 100644 hw/riscv/cv1800b.c
 create mode 100644 hw/riscv/milkv_duo.c
 create mode 100644 hw/riscv/server_platform_ref.c
 create mode 100644 target/riscv/tcg/xsf_helper.c
 create mode 100644 tests/qtest/milkv-duo-test.c
 create mode 100644 disas/riscv-xsf-op.c.inc
 create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc
 create mode 100755 tests/functional/riscv64/test_milkv_duo.py
 create mode 100755 tests/functional/riscv64/test_server_ref.py
 create mode 100644 tests/tcg/riscv32/meson.build
 create mode 100644 tests/tcg/riscv32/semihost.ld
 create mode 100644 tests/tcg/riscv32/system/meson.build
 create mode 100644 tests/tcg/riscv32/test-mcycle.S
 create mode 100644 tests/tcg/riscv64/test-minstret-wfi.S
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S
 create mode 100644 tests/tcg/riscv64/test-xsfvqmacc.S

