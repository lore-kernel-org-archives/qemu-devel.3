Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE915CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMj-0001TD-Vo; Thu, 21 May 2026 20:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMa-0001SN-1l
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:44 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMX-0003CN-U6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b458ca2296so48478245ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408214; x=1780013014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P9Pfolid+JlCdFzegOqOvIpL/h39LxwWsCvQ2PJ0JqM=;
 b=BgiyrgUdlbLrpYrYuBufUW5DIbi8pbi9oao2MZ4f83EK/xCyx0sBfXbx0uLqgJBHOs
 eoTfAhysyd5sl0dC8v7leMc/Uy1f/ZBpMMHZPA6oKgNZnYR7UVLFWm0jjK1uZVgSYh61
 JniO2qDIY0QBWboWORxIRXY8w+B09+HUODR1C77vLWDyp3SCOgf29BlUtq7jXph+BZrj
 ieKwTV/839Nj9bXMEn6ID554hW0Q4DkHl4VXDS6OppJ+2HGSFSlNrJbZWI/9Sgb7Huhl
 jBHM8Q5QJSrw9oQnoUD6fTR2Gry7AGOnvaQ/rld1gP8ptpkbe9nwpLGqbevp+ecqR1aS
 tAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408214; x=1780013014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9Pfolid+JlCdFzegOqOvIpL/h39LxwWsCvQ2PJ0JqM=;
 b=gO7t9LxMiYzdjEUL9n1RFsoJaJggPl0QehogFDtl66TmQxXBokEOaCSivPVSvC3IZs
 pc/dQnQdKW9MqWetsQV9sGdaWQpEBsQe/shCRB+fM7E8COavMoQzV6MMcT3UaO9w+A5x
 IUebwvHm4psc6Fg/vOPzxWFLAznmOSMO2DKpViQ7om+BtygmAJIoA7pSCe20etfluJtw
 HPqmRidCrGalx5lUv4hUeObNxKZt9J2LkE9qvr3EdYv09guJUNCNEbdX33K1t9t3H6F6
 E650Pf+sS/8aQkbmuFUGRdgdHylK6mlgxacohgN4jjhOOoblLJ/O9RAUZ11dzMd7rTu7
 u7dA==
X-Gm-Message-State: AOJu0YwxOVN39120NxbLxdZ5Up73/4cyI6ESzwpnHUl5XUqwzzogfOEC
 DBhB7ZPUPJcz2I59cIvawNSmh61N/lWBsmf1XsmOam+7JvJaL0Uj7gXlW6nOJ6eE
X-Gm-Gg: Acq92OHJkjhFKfLz+BF/NAlwH0V4I/MySnwcA9T6SEwR5ffxfwr9GILx1jTZY4RFGqk
 Oml8S+9Y1kz5CE4S7KhDNheL+ewxc+BEnenhtsjuj9iLJL5SF/sj1v6wLG+H0IEgGjdGnmy1QVx
 Yc6UT1aWC1pu5S6tLk2hrh6FjtDsi0L0RIFun8a1y+81j7Y17ry6M4hYTqoCR6P0/ddwSyrMxow
 L/6khhA7Gx7CCJnEyvzDjV8vn5KqXOpqtZ1bVUqC/0UNMtsYeOTU85Gr8fKaBbuj+6FhviYQ6b1
 sqmKUZFZbye1TN2gq5XA7TtYkRJ2hW3c9rjsLTpWtRbpNASjFecZtf2pgxEI+5lnlLwIXagABQm
 t3Ww2ugJXMEnVUF/6kQOdAUt++UxsA4YiEyHjq0sZ8muVYfEyp9G+ETPchY1Dit/b3zbcUP6mKR
 OfVBye6DjtVVnwPcEwH4qpyyK0FgW6I8CuUuIC1GbPgA==
X-Received: by 2002:a17:903:2b0e:b0:2bd:a403:4ab8 with SMTP id
 d9443c01a7336-2beb06319ffmr11064245ad.25.1779408214187; 
 Thu, 21 May 2026 17:03:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/48] riscv-to-apply queue
Date: Fri, 22 May 2026 10:02:36 +1000
Message-ID: <20260522000324.23255-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

The following changes since commit f5a2438405d4ae8b62de7c9b39fac0b2155ee544:

  Merge tag 'pull-qapi-2026-05-21' of https://repo.or.cz/qemu/armbru into staging (2026-05-21 09:00:22 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260522

for you to fetch changes up to b7d87fb10d53a918e9c4a3dfe1fb06ce42c52526:

  hw/riscv: riscv-iommu: Re-process command queue after clearing CMD_ILL (2026-05-22 09:59:21 +1000)

----------------------------------------------------------------
RISC-V PR for 11.1.

* Remove spike as default machine
* Deprecate the shakti_c machine
* Set MISA.[C|X] based on the selected extensions
* Update Maintainers for OpenSBI Firmware
* Update OpenSBI to v1.8.1
* Avoid RISCVCPU copy in PMU FDT setup
* A collection of specification compliance improvements
* Fix Svnapot 64KB pages
* Handle source overlap of vector widening reduction instructions
* Check interrupt in SiFive UART after txctrl register is written
* Fix medeleg[11] read-only zero bit for M-mode ECALL
* Fix tail handling for vmv.s.x and vfmv.s.f
* Update the local AIA interrupt mask
* Add KVM support for Zicbop and BFloat16 extensions
* Fix the IOMMU FSC SV32 capability check
* Avoid caching PCI device IDs in the IOMMU
* Implement Microchip mpfs ioscb PLLs and sysreg clock dividers
* Remove the internal CPU riscv_cpu_* arrays
* Fix IOCOUNTINH.CY toggle detection
* Fix the read of pmpaddr(0-63) CSRs
* Make hpmcounterh return the upper 32-bits
* Minor fixes and enhancements of RISC-V AIA devices
* Re-process IOMMU command queue after clearing CMD_ILL

----------------------------------------------------------------
Abhigyan Kumar (1):
      target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL

Alistair Francis (4):
      target/riscv: Remove spike as default machine
      target/riscv: Deprecate the shakti_c machine
      MAINTAINERS: Maintain OpenSBI Firmware
      target/riscv: Update the local interrupt mask

Andrew Jones (1):
      hw/riscv/riscv-iommu: Fix Svnapot 64KB pages

Anton Blanchard (1):
      target/riscv: rvv: Handle source overlap of vector widening reduction instructions

Chengbo Gao (1):
      hw/riscv/riscv-iommu: Avoid caching PCI device IDs

Daniel Henrique Barboza (16):
      roms/opensbi: Update to v1.8.1
      target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
      target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
      target/riscv: make riscv-qmp-cmds use isa_data_arr[]
      target/riscv/tcg: treat all exts equally in cpu_disable_priv_spec_isa_exts
      target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_name()
      target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
      target/riscv: remove riscv_cpu_named_features[]
      target/riscv/tcg: use isa_edata_arr[] in riscv_cpu_update_misa_x()
      target/riscv/kvm: use isa_edata_arr[] for unavailable props
      target/riscv/tcg: use isa_edata_arr[] to enable max exts
      target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb opaque
      target/riscv: do not set defaults in cpu prop callback
      target/riscv/tcg: use isa_edata_arr[] to create user props
      target/riscv/cpu: remove riscv_cpu_* arrays
      target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs

Fangyu Yu (1):
      hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection

Frank Chang (3):
      target/riscv: Update MISA.C for Zc* extensions
      target/riscv: Update MISA.X for non-standard extensions
      hw/char: Check interrupt after txctrl register is written

Guenter Roeck (1):
      hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg clock dividers

Jay Chang (1):
      hw/riscv: riscv-iommu: Re-process command queue after clearing CMD_ILL

Jim Shu (4):
      hw/intc: riscv_aplic: Fix level trigger IRQ in direct delivery mode
      hw/intc: riscv_aplic: Add reset API to APLIC
      hw/intc: riscv_imsic: Add reset API to IMSIC
      hw/intc: riscv_aplic: add trace events of APLIC read/write function

Mohamed Ayman (1):
      riscv: virt: avoid RISCVCPU copy in PMU FDT setup

Portia Stephens (1):
      target/riscv: Make hpmcounterh return the upper 32-bits

Zishun Yi (9):
      target/riscv: Allow mseccfg access based on ext_zicfilp
      target/riscv: add Zvknha as an implied extension for Zvknhb
      target/riscv: Remove unconditional MENVCFG_CDE from mask
      target/riscv: Fix missing CDE check for scountinhibit
      target/riscv/pmp: Fix integer overflow in TOR and NA4 address computation
      target/riscv: Add mseccfg to VMStateDescription
      target/riscv: clear mseccfg on reset for all dependent extensions
      hw/riscv/riscv-iommu: fix FSC SV32 capability check
      hw/riscv/virt-acpi-build: Fix off-by-one error in RIMT ID mapping

Zongmin Zhou (2):
      target/riscv/kvm: add KVM support for Zicbop extension
      target/riscv/kvm: Add BFloat16 extensions support

chen.zhongyao@zte.com.cn (1):
      target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f

 MAINTAINERS                                    |   2 +
 docs/about/deprecated.rst                      |  21 +-
 docs/about/removed-features.rst                |  14 ++
 include/hw/misc/mchp_pfsoc_ioscb.h             |   2 +
 target/riscv/cpu.h                             |  13 +-
 target/riscv/helper.h                          |   4 +
 hw/char/sifive_uart.c                          |   1 +
 hw/intc/riscv_aplic.c                          | 116 ++++++---
 hw/intc/riscv_imsic.c                          |  19 ++
 hw/misc/mchp_pfsoc_ioscb.c                     |  47 +++-
 hw/misc/mchp_pfsoc_sysreg.c                    |  13 +
 hw/riscv/riscv-iommu-hpm.c                     |   3 +-
 hw/riscv/riscv-iommu.c                         |  96 ++++++--
 hw/riscv/shakti_c.c                            |   1 +
 hw/riscv/spike.c                               |   1 -
 hw/riscv/virt-acpi-build.c                     |   3 +-
 hw/riscv/virt.c                                |   4 +-
 target/riscv/cpu.c                             | 327 +++++++++----------------
 target/riscv/csr.c                             |  36 ++-
 target/riscv/kvm/kvm-cpu.c                     |  62 +++--
 target/riscv/machine.c                         |  20 ++
 target/riscv/pmp.c                             |   4 +-
 target/riscv/riscv-qmp-cmds.c                  |  30 +--
 target/riscv/tcg/tcg-cpu.c                     | 192 +++++++--------
 target/riscv/vector_helper.c                   |  18 ++
 target/riscv/insn_trans/trans_rvv.c.inc        |  45 ++--
 hw/intc/trace-events                           |   4 +
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 268752 -> 270384 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 273048 -> 275928 bytes
 roms/opensbi                                   |   2 +-
 30 files changed, 613 insertions(+), 487 deletions(-)

