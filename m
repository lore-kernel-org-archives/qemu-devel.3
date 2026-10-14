Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9575CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpq8-0004qL-N3; Tue, 13 Oct 2026 23:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq1-0004oe-9W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:33 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGppr-0001KR-AM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:25 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so420642a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949161; x=1792553961; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gftAHR50HnB/eG7jT4PHBIGqprmtka/yJ6Mkt/QCv9M=;
 b=rJLqEEnN5aDAtTrFWCbQBRvhcQMznL43DDOE6LFKnG8NC194NsayVaawhr/E/kYU3A
 LEodkkSU72sz37/KyqQXvtfmla2MGB9geNQm8CCRXz2JbL45hiheUJPxNtbHNpoFQpKk
 VFwehoXG1cz1jUGoDOiGkqdh1vp/oFr+AaesshQUxG1vmkjUkWU1wlk8Mf0cL1CuTSmo
 A9+Nr9yNj5pNLvbpVanJOVIAbNmC/R9ypdjyISRVkSuv6VSvV5K2i1l9To74zQYSBXwL
 0+lhY9d+meRZnG1GYZv9REf76heyogBJHXv5PSA/v8DnSgUaCLxRLVuRPtMgzmxnQcdH
 2Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949161; x=1792553961;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gftAHR50HnB/eG7jT4PHBIGqprmtka/yJ6Mkt/QCv9M=;
 b=2kZb/4GGpVM3SQCBKD6YCmST0kkt1bK3ipXECeBAF50dzWIm00FmFeiLnpR3a3hmDl
 aeU5zUHWtCL7Z+x3DLAoUmejPW/YIZuRo5kFgYxGYULiKKGkUjD0iLTdnk1xj43G6ehw
 l+q9MLI/S0X08G7bzktFbnRBv6xr74V3YU+15jYJJvZVohdnbdG/TtrCE+lDlPKos3Aq
 nmTNr7B5t45UtRQsyEJT1znCGJ7mnYWw4/AY+BSg38m3kTACiIPOwzB3+OW62mylTnDV
 4hkxAwpRy7UfMcPcLSb9xzIgfvOaSTQFi5ZSQXLgvP+gZF7cgP4w059yYW2DLVUMWzxj
 ZhWQ==
X-Gm-Message-State: AFq9FYIE7qChw1Vp5xAIgZLJpXudWTqwX34I+M8ENcFKfgIWfPBE2S31
 X5Nl906UDBWhzMCjd3gteHWMd5AsuBM49coVmdoSravy/Kk6aavvQPs1lY2HSQ==
X-Gm-Gg: AYBFou1+IwoORg3WNYbaMJZuoakqKi3WAUuxdZtIeg8egoAXJC3yLuchUJLZaeACL/i
 PPrdJcKfo33ccRLi7NaHPJp3ObuSDQItbpmlMLGDW9ag4T8gXrQNPzUSCOaipivRE4mn/ClMOiU
 UW2EsGKzdOvlAKEY2X6b9iSjkvT951ohAyCmNKqKnHH7AIHup7E5DjGEtsDuXaLMfp2gvcCGwWv
 Fl3UMqU6JQbbDACzCU6ehQPcKEmE5Vom6PG6lNqmPx6jnxB4zMWXlQHafaTaGZm9yc1p70iCJs+
 1UnhHA5NYGC0kmFjqUPpGl7sqf1ehTLdkBC8hksP9uR0yfeFTiFW1YDuAAjN0tdd+QKUjvHMi5K
 Xy0/B/0kaHONwpxe/JPY2sFVJA/dczIXpWZmd3tXtWKn+2clDRxcnOfu29ogLTDsWALMn1zPTPn
 xwvMNdg3bkNdb9BP1EdqXjmHBJYhsXrFPR/2kC05MDPKWBvN+iPgMYGH9cY7EZJ2y+eyN1ksGZa
 BQ6V8mer/sJArde
X-Received: by 2002:a17:90b:5343:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3ab3a956dd3mr12514110a91.10.1791949160953; 
 Tue, 13 Oct 2026 20:39:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/52] riscv-to-apply queue
Date: Wed, 14 Oct 2026 13:38:15 +1000
Message-ID: <20261014033907.3332383-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

The following changes since commit a1c27ca02bcfeea7deb6d4634c70d5b3b421a76d:

  Merge tag 's390x-20261009' of https://gitlab.com/efarman/qemu into staging (2026-10-13 16:42:11 +0200)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20261014

for you to fetch changes up to 2deb4ce3eac9c8438f59f27fae07ba29feb37dfd:

  hw/riscv/tt-atlantis: Update UART and I2C to use clk from PRCM (2026-10-14 13:28:54 +1000)

----------------------------------------------------------------
RISC-V PR for 11.2

* Check G-stage write permission for VS-stage A/D updates
* Restore LCOFI handling in interrupt CSRs
* Fix csrrs disasembly decoding
* Stop translating after WFI
* Raise virtual instruction exception on svinval instructions
* Report WRS.NTO opcode in tval on illegal instruction
* Fix some KVM migration issues
* Save ELP in MPELP for NMIE=0 exceptions
* Add support for the Zvabd extension
* Add experimental Zvabd extension support
* Add support for Milk-V Duo board
* Make MIP accesses atomic and BQL-safe
* Add initial sdext support
* Add SiFive Xsfvqmaccdod/Xsfvqmaccqoq int8 matmul extensions
* Add the Server Platform Reference Board
* Revert invalidate reservations after stores for linux user
* Fix the UART register width in SPCR
* Check Svnapot PTE before updating A/D bits
* Add Tenstorrent Atlantis PRCM model

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

Mingliang Liu (2):
      disas/riscv: Support vabs.v pseudo-instruction
      tests/tcg/riscv64: Add Zvabd extension tests

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

Zephyr Li (3):
      target/riscv: stop translating after WFI
      target/riscv: report WRS.NTO opcode in tval on illegal instruction
      target/riscv: save ELP in MPELP for NMIE=0 exceptions

Zhibo Hong (1):
      target/riscv: Add support for the Zvabd extension

dodochicha (1):
      target/riscv: Check Svnapot PTE before updating A/D bits

imaginos (1):
      target/riscv: check G-stage write permission for VS-stage A/D updates

 MAINTAINERS                                        |  30 +
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
 target/riscv/helper.h                              |  42 +-
 target/riscv/kvm/kvm_riscv.h                       |   7 +
 target/riscv/cpu_cfg_fields.h.inc                  |   4 +
 target/riscv/insn32.decode                         |  11 +
 target/riscv/xsf.decode                            |  30 +
 disas/riscv-xsf.c                                  |  49 ++
 disas/riscv.c                                      |  19 +-
 hw/char/dw8250.c                                   | 130 ++++
 hw/intc/riscv_aclint.c                             |   2 +-
 hw/misc/cv1800b_clk.c                              |  98 +++
 hw/misc/tt_atlantis_prcm.c                         | 428 ++++++++++++
 hw/riscv/cv1800b.c                                 | 177 +++++
 hw/riscv/milkv_duo.c                               | 118 ++++
 hw/riscv/server_platform_ref.c                     | 776 +++++++++++++++++++++
 hw/riscv/tt_atlantis.c                             | 125 +++-
 hw/riscv/virt-acpi-build.c                         |   2 +-
 target/riscv/cpu.c                                 | 135 +++-
 target/riscv/kvm/kvm-cpu.c                         |  74 +-
 target/riscv/machine.c                             |  80 +++
 target/riscv/tcg/cpu_helper.c                      | 166 ++++-
 target/riscv/tcg/csr.c                             | 220 +++++-
 target/riscv/tcg/debug.c                           |  59 +-
 target/riscv/tcg/op_helper.c                       | 107 ++-
 target/riscv/tcg/tcg-cpu.c                         |  42 ++
 target/riscv/tcg/translate.c                       |  56 +-
 target/riscv/tcg/vector_helper.c                   |  56 ++
 target/riscv/tcg/xsf_helper.c                      |  87 +++
 target/riscv/time_helper.c                         |  12 +-
 tests/qtest/milkv-duo-test.c                       |  70 ++
 disas/riscv-op.c.inc                               |   9 +
 disas/riscv-xsf-op.c.inc                           |  11 +
 target/riscv/tcg/insn_trans/trans_privileged.c.inc |  25 +
 target/riscv/tcg/insn_trans/trans_rva.c.inc        |  24 -
 target/riscv/tcg/insn_trans/trans_rvi.c.inc        |  11 -
 target/riscv/tcg/insn_trans/trans_rvv.c.inc        |  45 ++
 target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc    |   5 +-
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
 target/riscv/meson.build                           |   1 +
 target/riscv/tcg/meson.build                       |   1 +
 tests/data/acpi/riscv64/virt/SPCR                  | Bin 90 -> 90 bytes
 tests/functional/riscv64/meson.build               |   3 +
 tests/functional/riscv64/test_milkv_duo.py         |  53 ++
 tests/functional/riscv64/test_opensbi.py           |   4 +
 tests/functional/riscv64/test_server_ref.py        |  90 +++
 tests/qtest/meson.build                            |   3 +-
 tests/tcg/riscv64/Makefile.softmmu-target          |  21 +
 tests/tcg/riscv64/system/meson.build               |  16 +
 tests/tcg/riscv64/test-minstret-wfi.S              | 100 +++
 tests/tcg/riscv64/test-sdext-sigill.S              |  83 +++
 tests/tcg/riscv64/test-xsfvqmacc.S                 | 260 +++++++
 tests/tcg/riscv64/test-zawrs-stval.S               |  87 +++
 tests/tcg/riscv64/test-zicfilp-smrnmi.S            | 117 ++++
 tests/tcg/riscv64/test-zvabd.S                     | 659 +++++++++++++++++
 82 files changed, 5181 insertions(+), 231 deletions(-)
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
 create mode 100644 tests/tcg/riscv64/test-minstret-wfi.S
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S
 create mode 100644 tests/tcg/riscv64/test-xsfvqmacc.S
 create mode 100644 tests/tcg/riscv64/test-zawrs-stval.S
 create mode 100644 tests/tcg/riscv64/test-zicfilp-smrnmi.S
 create mode 100644 tests/tcg/riscv64/test-zvabd.S

