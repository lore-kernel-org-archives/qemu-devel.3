Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E589C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 22:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pZO-0006VK-Pn; Wed, 08 May 2024 18:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZM-0006TP-UB
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZK-0003iE-Cv
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41bab13ca81so2865205e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715206520; x=1715811320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KPciD0RnLdi/EiIAasxmM+IZ939lNo1qM1/wC9rlA3o=;
 b=yPLHYoQIDhN6XuvBEF9fs47Yi+imYUmjKjO9VjYdZ3gYSOaBsHEvgOuHlfH1XOUFW0
 LmXrQu7bcRANrazYyToYl3KKLGXuoxlT4dIcdGlnAv7ocktgQ9+70WqY7kwQ9l7Lxd9b
 htrzgLErMk/gCK2xla+Y8RKcvXFQEeU/Z425IlYrv8nXnbt/KNSh0pAIHbI2EcU27pnx
 LCSFCQpp2FbZVCccyuaQpg/4GoFgHikdUqTjK6rEl9Ze8ezretF9UlvOUIN5v4YAZ60r
 KTDuNJ3uC5Z2GcwgrETElAz6TRF0IOJ+Aw08bBoSwkrQrNPlNo3RP6vd7W0y4MaeXpAb
 rMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715206520; x=1715811320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KPciD0RnLdi/EiIAasxmM+IZ939lNo1qM1/wC9rlA3o=;
 b=MkSIV3rSgkHc92qmeNmkJDtc8Ufvl6mT2buHodXj3R0seqEGxDgXt4X5VvgeeKqhm6
 whURWfEggnhXIQUWGBCVfdPWEP2CWIjjueE3JSRZUmVRCIntUrdBET+HdBUflyrsR25J
 Lo/5AG2LvbzMr667alv6wovDxqdoWIZmoD2wHTC8VJQrLOtRaSBjScWVI45PWMk5HttL
 1p2/x6gEN4pNwFTxGxchMvbA89pRiRpeaYlYVJG7Dk10tPbqZ37o0brzHfq+m29H9gmn
 IqRQpYx5dCd6cuJ6Y2yOdaVv5fC20snUv2iz4lQweNYR0oOpViiVtNM/25hIIGXXWpCD
 Nh8Q==
X-Gm-Message-State: AOJu0YwUjY91Ht0cVun7qfA6FwbkM8P/RXriGAYfZytExeXRS4W7EumS
 ZrHRb81QKxYIr9klQZKO88EqbkHvlay2u+xtrnFEd5u6z39OIlt56dJzmUF6Y9BZO1lj5j+GVQr
 W
X-Google-Smtp-Source: AGHT+IFR5jp4pVBUaBqzBY/et07c9FyuVEtBJz2LpnWlA8D0zDqKcZF6steOnahJl/l9+2uX202fng==
X-Received: by 2002:a5d:58ca:0:b0:347:2b42:a397 with SMTP id
 ffacd0b85a97d-34fca0550cemr4061604f8f.4.1715206520582; 
 Wed, 08 May 2024 15:15:20 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a7907sm8968f8f.63.2024.05.08.15.15.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 15:15:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 00/28] Misc HW patches for 2024-05-08
Date: Thu,  9 May 2024 00:15:15 +0200
Message-ID: <20240508221518.72350-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

v2: Updated Bernhard's patches

The following changes since commit 4e66a08546a2588a4667766a1edab9caccf24ce3:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-05-07 09:26:30 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240508

for you to fetch changes up to 8b4d80bb53af30db5de91749216d0bb73fa93cab:

  misc: Use QEMU header path relative to include/ directory (2024-05-09 00:07:21 +0200)

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

Bernhard Beschow (5):
  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
  hw/i386: Have x86_bios_rom_init() take X86MachineState rather than
    MachineState
  hw/i386/x86: Don't leak "isa-bios" memory regions
  hw/i386/x86: Don't leak "pc.bios" memory region
  hw/i386/x86: Extract x86_isa_bios_init() from x86_bios_rom_init()

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
 include/hw/i386/x86.h                         |  17 +-
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
 hw/i386/x86.c                                 |  45 +--
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
 44 files changed, 836 insertions(+), 411 deletions(-)
 rename include/hw/intc/{loongarch_ipi.h => loongson_ipi.h} (84%)
 create mode 100644 hw/intc/loongson_ipi.c

-- 
2.41.0


