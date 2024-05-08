Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9819BC25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lM2-0000JY-KY; Wed, 08 May 2024 13:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lLz-0000JK-9q
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:19 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lLv-0007EP-NS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:19 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5a1054cf61so55374666b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190313; x=1715795113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oBBbFe4scJXufU7+qVngaz38OX3PIMgChAbh7KcsYtg=;
 b=dTTe29djRVj9iSnRa+7ibHU1GyoaBCBD/wVCxhMfvI1HYoFNCynonBGr4ObZ40WaSW
 F4HO3bHyDSsRiEZiFOwi/qEbqox5z69sVBZ8iqAzGNq+xpBZy2zhQI3KTFHmfb8oqUUV
 HNfVNOLh/ZRLgvP57C5Rtxa3OsYU6oDEKa7oBISYkMMJb0o8q9BsD/0Lg/16wD8AGiK5
 C27fkQuwzR7ajVuTAdaAhmlqcQ6N+Ujl/C/No12yrf8FfB2d8OSZIANybzYuiISqQ6/N
 1jjvQVehZWKX+w40laUi5F+2ctf/J3KeFQMe2DyEqYmUjVUmO+Tt07x9G7GadH1uYBwf
 2KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190313; x=1715795113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBBbFe4scJXufU7+qVngaz38OX3PIMgChAbh7KcsYtg=;
 b=EyrN/e+cdaSN2ZRCqJFNRhJ1u9qktNi7bTeOhdmU9BRR5XjGWr6KtL1zynivnASByd
 V7Ok6qB75CXmBC/UIs+xCywRwuhgQc09UrwDHYISaTDClcH3v0eAKpMvrm2SD1wyhsc9
 cSZPMD3eCjC3LfYBz+bJAkdhkX75DXq0lr0QxN8eFClsz2DTu1biXH0Ux4lvZbpNmmQo
 sBQUMysO9R1Ma581U396I1TTePu8l8U5dFoJeuMBOp2PvpCOchttVzg0O/13SYsKCqAx
 pftZ5LykFhTdNfUk0fiDB9jXt3WQapSW9BVgmQSLp45q20hO4+OVR2Cm3XQ5kfaWmh+Y
 Ysqg==
X-Gm-Message-State: AOJu0Ywfas+lGcuSaQn1s9rQkHH20XIdmOg+ponYL+6HhI9tiOJIwt9t
 kYuc/LPlFS4GuZiIt+6bf5nZXdkRh0celaOI3+SDHc9uR4vaQ0LVrEJDVY9+rwlD6c4kB4EKEsN
 B
X-Google-Smtp-Source: AGHT+IEkojt1hnFGpA9tmDMLZpiywE5oQNygTya4+bzgIEHPv95u4uvGFUA2+K1wzKSucMDnP+qMaw==
X-Received: by 2002:a17:906:71c9:b0:a59:a033:3e2 with SMTP id
 a640c23a62f3a-a59fb9db732mr271065466b.74.1715190313305; 
 Wed, 08 May 2024 10:45:13 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 f10-20020a170906084a00b00a59a2ec20e4sm6100378ejd.175.2024.05.08.10.45.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/26] Misc HW patches for 2024-05-08
Date: Wed,  8 May 2024 19:44:44 +0200
Message-ID: <20240508174510.60470-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

The following changes since commit 4e66a08546a2588a4667766a1edab9caccf24ce3:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-05-07 09:26:30 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240508

for you to fetch changes up to 15a91d34f7b08635e3919105f7ad0b5aafc49f50:

  misc: Use QEMU header path relative to include/ directory (2024-05-08 19:43:23 +0200)

----------------------------------------------------------------
Misc HW patches

- Few more g_memdup() replaced by safer g_memdup2() wrapper (Phil)
- Endianness access fixed in vfio-user config space (Mattias)
- Replace qemu_mutex_lock() -> QEMU_LOCK_GUARD in system/physmem (Phil)
- Per-AddressSpace bounce buffering (Mattias)
- Allow to compile x86 PC machines without Floppy Controller (Thomas)
- Cleanups around i386 "isa-bios" memory regions (Bernhard)
- Remove unused usb rndis_config_parameter structure (David)
- Migrate missing clock in STM32L4x5 GPIOs (Inès)
- Deprecate PPC 'ref405ep' machine and 405 CPUs (Cédric)
- Memory leak fixed in Loongarch Virt machine (Song Gao)
- hw/loongarch/ code moved around (Paolo & Bibo Mao)
- Emulate S3 suspend in loongson3_virt machine (Jiaxun)
- Implement IOCSR address space in Loongson IPI (Jiaxun)
- Use QEMU header path relative to include/ directory (Phil)

----------------------------------------------------------------

Bernhard Beschow (3):
  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
  hw/i386: Have x86_bios_rom_init() take X86MachineState rather than
    MachineState
  hw/i386/x86: Don't leak "isa-bios" memory regions

Bibo Mao (2):
  hw/loongarch: Rename LOONGARCH_MACHINE with LOONGARCH_VIRT_MACHINE
  hw/loongarch: Rename LoongArchMachineState with
    LoongArchVirtMachineState

Cédric Le Goater (1):
  hw/ppc: Deprecate 'ref405ep' machine and 405 CPUs

Dr. David Alan Gilbert (1):
  hw/usb/dev-network: Remove unused struct 'rndis_config_parameter'

Inès Varhol (1):
  hw/gpio: Handle clock migration in STM32L4x5 gpios

Jiaxun Yang (4):
  hw/mips/loongson3_virt: Emulate suspend function
  hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
  hw/intc/loongarch_ipi: Rename as loongson_ipi
  hw/intc/loongson_ipi: Implement IOCSR address space for MIPS

Mattias Nissler (3):
  hw/remote/vfio-user: Fix config space access byte order
  system/physmem: Propagate AddressSpace to MapClient helpers
  system/physmem: Per-AddressSpace bounce buffering

Paolo Bonzini (1):
  hw/loongarch: move memory map to boot.c

Philippe Mathieu-Daudé (6):
  block/qcow2-bitmap: Replace g_memdup() by g_memdup2()
  target/ppc: Replace g_memdup() by g_memdup2()
  hw/hppa/machine: Replace g_memdup() by g_memdup2()
  hw/ppc/spapr_pci: Replace g_memdup() by g_memdup2()
  system/physmem: Replace qemu_mutex_lock() calls with QEMU_LOCK_GUARD
  misc: Use QEMU header path relative to include/ directory

Song Gao (1):
  hw/loongarch/virt: Fix memory leak

Thomas Huth (3):
  hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
  hw/i386/Kconfig: Allow to compile Q35 without FDC_ISA
  hw/i386: Add the possibility to use i440fx and isapc without FDC

 MAINTAINERS                                   |   4 +
 docs/about/deprecated.rst                     |   8 +
 hw/loongarch/fw_cfg.h                         |   2 +-
 include/exec/cpu-common.h                     |   2 -
 include/exec/memory.h                         |  45 ++-
 include/hw/i386/x86.h                         |   4 +-
 .../intc/{loongarch_ipi.h => loongson_ipi.h}  |  12 +-
 include/hw/loongarch/boot.h                   |  10 +
 include/hw/loongarch/virt.h                   |  21 +-
 block/qcow2-bitmap.c                          |   2 +-
 hw/audio/virtio-snd.c                         |   2 +-
 hw/gpio/stm32l4x5_gpio.c                      |   6 +-
 hw/hppa/machine.c                             |  16 +-
 hw/i386/microvm.c                             |   2 +-
 hw/i386/pc.c                                  |  13 +-
 hw/i386/pc_piix.c                             |   6 +-
 hw/i386/pc_sysfw.c                            |  11 +-
 hw/i386/x86.c                                 |  19 +-
 hw/intc/loongarch_ipi.c                       |  19 +-
 hw/intc/loongson_ipi.c                        | 368 ++++++++++++++++++
 hw/loongarch/acpi-build.c                     |  89 +++--
 hw/loongarch/boot.c                           |  13 +-
 hw/loongarch/fw_cfg.c                         |   2 +-
 hw/loongarch/virt.c                           | 353 ++++++++---------
 hw/mips/loongson3_bootp.c                     |   1 +
 hw/mips/loongson3_virt.c                      |  20 +
 hw/ppc/ppc405_boards.c                        |   1 +
 hw/ppc/spapr_pci.c                            |   7 +-
 hw/remote/vfio-user-obj.c                     |   4 +-
 hw/rtc/ls7a_rtc.c                             |   2 +-
 hw/usb/dev-network.c                          |   8 -
 system/dma-helpers.c                          |   4 +-
 system/memory.c                               |   7 +
 system/physmem.c                              |  99 ++---
 target/i386/gdbstub.c                         |   2 +-
 target/ppc/mmu-hash64.c                       |   2 +-
 tests/qtest/nvme-test.c                       |   2 +-
 tests/qtest/ufs-test.c                        |   2 +-
 .gitlab-ci.d/buildtest.yml                    |   2 +-
 hw/i386/Kconfig                               |   2 +-
 hw/intc/Kconfig                               |   2 +-
 hw/intc/meson.build                           |   2 +-
 hw/intc/trace-events                          |   8 +-
 hw/loongarch/Kconfig                          |   2 +-
 44 files changed, 807 insertions(+), 401 deletions(-)
 rename include/hw/intc/{loongarch_ipi.h => loongson_ipi.h} (84%)
 create mode 100644 hw/intc/loongson_ipi.c

-- 
2.41.0


