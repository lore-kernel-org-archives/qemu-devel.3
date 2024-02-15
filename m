Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CF7C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag07-0001Ym-MZ; Thu, 15 Feb 2024 12:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag03-0001Sn-8m
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:19 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafzj-0001P7-HP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33cf7812777so637816f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019876; x=1708624676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KLFW9d6MtGVFIRF/ILtmv/tLLOjeEc5TXZ5cnpm3gU8=;
 b=KiLtTFoGx7b8JpG6bKmSli1FxFsvulhRaofmJVtVdA0GCX/sjtMx9GQwh+smOZWPMz
 ZdUJWOfv9iHPy1A2wMIIRuTYM9L/eSKjV5oO7LmnlQdXNUJ6SHuyM1zZvzT3Xayex54r
 lNrZ55HaNWMSb5dqe7bQqbif2oIWnIc50bzckIMQ2NhCmXAAel88PTSH6+FawBUl5Wl2
 SWl9ifee4QLjI0E01fS8JLxh82It24p3e8yexgfZK9g29+Q0oIgmTBt4U5iM7qaY6TcN
 m/AR6EobGbBvaM1JmYikd09rwcJ1C0rIn4j855UDk+EPmt8DXOZwgwCxs318x5wcaPPa
 rnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019876; x=1708624676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLFW9d6MtGVFIRF/ILtmv/tLLOjeEc5TXZ5cnpm3gU8=;
 b=aoQJVxnyBeU/syR2EHg/yuhVqgE2267Yal6SOUlfz47FJKA9mu12HLTAwbfzKu6CtG
 Qd7l/ehfKky3Pt3hw1fdtoGnSJnYAfEdGwFkLn3zcpderLjF0aXCr8sZ7CT4qZpsRQ4d
 S3nOxZgdRHXsldJSVv2TBs3mfajt+ORy48BAbj+pNtQzoYalO1u+ZXJJ1YiOF/Uww+ee
 ws+uOprbWqjO237tjInC+VYEOEXqihuIGsOYILt8o2nHNOluXKAtZM+UTK82U05Z/k3L
 /Eu2rENl0M/9eXmqChZsz9jk+iHuyIHG7ZC3x+NbqQF8yE/tp81Z7iDnA9wargdLBukk
 vAfA==
X-Gm-Message-State: AOJu0YwAPzU/8A4iuW/I4df+Fjo7wG0b/k6JklWhEmlHamGUhdEI+nzC
 bMauVdMowrfGbVvkYfGOj6Beyhle1QgnGxTP7BJOv6cMv25rrRA8mkXr6rwayCieuU1zBUcyCqE
 egLo=
X-Google-Smtp-Source: AGHT+IF0tdTP9qP48q3ZBOTw4pRzGbXGYiuNLhI+q5ZY6Klea1ko/CWIWupFMHoX1Ls0oSniiAb6UQ==
X-Received: by 2002:a5d:5591:0:b0:33b:2835:a1fe with SMTP id
 i17-20020a5d5591000000b0033b2835a1femr1888836wrv.47.1708019875960; 
 Thu, 15 Feb 2024 09:57:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 j15-20020adff54f000000b0033ce1ef4e7asm2445871wrp.13.2024.02.15.09.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:57:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/56] Misc HW patches for 2024-02-15
Date: Thu, 15 Feb 2024 18:56:54 +0100
Message-ID: <20240215175752.82828-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 5767815218efd3cbfd409505ed824d5f356044ae:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-02-14 15:45:52 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240215

for you to fetch changes up to 9a4b35f57eefbfc6977ed47d1f19d839e9e4784d:

  hw/ide/ich9: Use AHCIPCIState typedef (2024-02-15 16:58:47 +0100)

----------------------------------------------------------------
Misc HW patch queue

- Remove unused MIPS SAAR* registers (Phil)
- Remove warning when testing the TC58128 NAND EEPROM (Peter)
- KConfig cleanups around ISA SuperI/O and MIPS (Paolo)
- QDev API uses sanitization (Philippe)
- Split AHCI model as PCI / SysBus (Philippe)
- Add SMP support to SPARC Leon3 board (Clément)

----------------------------------------------------------------

Bernhard Beschow (1):
  hw/mips/Kconfig: Remove ISA dependencies from MIPSsim board

Clément Chigot (9):
  hw/sparc/grlib: split out the headers for each peripherals
  hw/intc/grlib_irqmp: add ncpus property
  hw/intc/grlib_irqmp: implements the multiprocessor status register
  hw/intc/grlib_irqmp: implements multicore irq
  target/sparc: implement asr17 feature for smp
  hw/sparc/leon3: remove SP initialization
  hw/sparc/leon3: implement multiprocessor
  hw/sparc/leon3: check cpu_id in the tiny bootloader
  MAINTAINERS: replace Fabien by myself as Leon3 maintainer

Paolo Bonzini (5):
  hw/mips: remove unnecessary "select PTIMER"
  hw/isa: clean up Kconfig selections for ISA_SUPERIO
  hw/isa: fix ISA_SUPERIO dependencies
  hw/isa: specify instance_size in isa_superio_type_info
  hw/isa: extract FDC37M81X to a separate file

Peter Maydell (1):
  hw/block/tc58128: Don't emit deprecation warning under qtest

Philippe Mathieu-Daudé (39):
  target/mips: Use qemu_irq typedef for CPUMIPSState::irq member
  target/mips: Remove helpers accessing SAAR registers
  hw/misc/mips: Reduce itc_reconfigure() scope
  target/mips: Remove MIPSITUState::itu field
  target/mips: Remove CPUMIPSState::saarp field
  hw/misc/mips_itu: Remove MIPSITUState::cpu0 field
  hw/misc/mips_itu: Remove MIPSITUState::saar field
  target/mips: Remove unused mips_def_t::SAARP field
  target/mips: Remove CPUMIPSState::CP0_SAAR[2] field
  target/mips: Remove helpers accessing SAARI register
  target/mips: Remove CPUMIPSState::CP0_SAARI field
  target/mips: Remove the unused DisasContext::saar field
  hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
  hw/rx/rx62n: Only call qdev_get_gpio_in() when necessary
  hw/i386/q35: Realize LPC PCI function before accessing it
  hw/ppc/prep: Realize ISA bridge before accessing it
  hw/misc/macio: Realize IDE controller before accessing it
  hw/sh4/r2d: Realize IDE controller before accessing it
  hw/dma: Pass parent object to i8257_dma_init()
  hw/sparc/sun4m: Realize DMA controller before accessing it
  hw/sparc64/cpu: Initialize GPIO before realizing CPU devices
  target/sparc: Provide hint about CPUSPARCState::irq_manager member
  hw/sparc/leon3: Remove duplicate code
  hw/sparc/leon3: Remove unused 'env' argument of write_bootloader()
  hw/sparc/leon3: Have write_bootloader() take a void pointer argument
  hw/sparc/leon3: Pass DeviceState opaque argument to leon3_set_pil_in()
  hw/sparc/leon3: Pass DeviceState opaque argument to leon3_start_cpu()
  hw/sparc/leon3: Initialize GPIO before realizing CPU devices
  hw/i386/q35: Simplify pc_q35_init() since PCI is always enabled
  hw/i386/q35: Use DEVICE() cast macro with PCIDevice object
  hw/ide/ahci: Expose AHCIPCIState structure
  hw/ide/ahci: Rename AHCI PCI function as 'pdev'
  hw/ide/ahci: Inline ahci_get_num_ports()
  hw/ide/ahci: Pass AHCI context to ahci_ide_create_devs()
  hw/ide/ahci: Convert AHCIState::ports to unsigned
  hw/ide/ahci: Do not pass 'ports' argument to ahci_realize()
  hw/ide/ahci: Remove SysbusAHCIState::num_ports field
  hw/ide/ahci: Move SysBus definitions to 'ahci-sysbus.h'
  hw/ide/ich9: Use AHCIPCIState typedef

Pierrick Bouvier (1):
  MAINTAINERS: Add myself as reviewer for TCG Plugins

 MAINTAINERS                                   |   4 +-
 hw/ide/ahci_internal.h                        |  10 +-
 include/hw/arm/allwinner-a10.h                |   2 +-
 include/hw/arm/allwinner-r40.h                |   2 +-
 include/hw/arm/xlnx-zynqmp.h                  |   2 +-
 include/hw/char/grlib_uart.h                  |  32 ++++
 include/hw/dma/i8257.h                        |   2 +-
 include/hw/ide/ahci-pci.h                     |  22 +++
 include/hw/ide/ahci-sysbus.h                  |  35 +++++
 include/hw/ide/ahci.h                         |  38 +----
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  |  18 +--
 include/hw/misc/mips_itu.h                    |   6 -
 include/hw/rx/rx62n.h                         |   2 -
 include/hw/timer/grlib_gptimer.h              |  32 ++++
 target/mips/cpu.h                             |   6 +-
 target/mips/internal.h                        |   1 -
 target/mips/tcg/translate.h                   |   1 -
 target/sparc/cpu.h                            |   5 +-
 target/sparc/helper.h                         |   1 +
 target/mips/tcg/sysemu_helper.h.inc           |   6 -
 hw/arm/highbank.c                             |   2 +-
 hw/arm/sbsa-ref.c                             |   1 +
 hw/block/tc58128.c                            |   4 +-
 hw/char/grlib_apbuart.c                       |   6 +-
 hw/dma/i82374.c                               |   2 +-
 hw/dma/i8257.c                                |   4 +-
 hw/i386/pc_piix.c                             |   2 +-
 hw/i386/pc_q35.c                              |  57 +++----
 hw/ide/ahci-allwinner.c                       |   3 +-
 hw/ide/ahci.c                                 |  29 ++--
 hw/ide/ich.c                                  |  10 +-
 hw/intc/grlib_irqmp.c                         | 110 ++++++++-----
 hw/isa/fdc37m81x-superio.c                    |  32 ++++
 hw/isa/isa-superio.c                          |  18 ---
 hw/isa/lpc_ich9.c                             |   2 +-
 hw/isa/piix.c                                 |   2 +-
 hw/isa/smc37c669-superio.c                    |   1 -
 hw/isa/vt82c686.c                             |   2 +-
 hw/mips/boston.c                              |  14 +-
 hw/mips/cps.c                                 |   3 -
 hw/mips/jazz.c                                |   2 +-
 hw/mips/mipssim.c                             |   7 +-
 hw/misc/macio/macio.c                         |   9 +-
 hw/misc/mips_itu.c                            |  35 +----
 hw/ppc/prep.c                                 |   2 +-
 hw/rx/rx-gdbsim.c                             |   1 +
 hw/rx/rx62n.c                                 |  17 ++-
 hw/sh4/r2d.c                                  |   2 +-
 hw/sparc/leon3.c                              | 144 ++++++++++++------
 hw/sparc/sun4m.c                              |   7 +-
 hw/sparc64/sparc64.c                          |   4 +-
 hw/timer/grlib_gptimer.c                      |   6 +-
 target/mips/sysemu/machine.c                  |   4 +-
 target/mips/tcg/sysemu/cp0_helper.c           |  63 --------
 target/mips/tcg/translate.c                   |  62 --------
 target/sparc/helper.c                         |  16 ++
 target/sparc/translate.c                      |  13 +-
 hw/isa/Kconfig                                |  20 +--
 hw/isa/meson.build                            |   1 +
 hw/mips/Kconfig                               |   6 +-
 60 files changed, 491 insertions(+), 461 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 create mode 100644 include/hw/ide/ahci-pci.h
 create mode 100644 include/hw/ide/ahci-sysbus.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (83%)
 create mode 100644 include/hw/timer/grlib_gptimer.h
 create mode 100644 hw/isa/fdc37m81x-superio.c

-- 
2.41.0


