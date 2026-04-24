Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1977FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGM9x-0003CT-62; Fri, 24 Apr 2026 15:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGM9v-0003C6-Bm
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:25:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGM9s-0001Hz-9T
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:25:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b0046078so74431825e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058746; x=1777663546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yg9NGrFw4w9i67ta248F9C5oPYjEgGTbMKQDwpdrGME=;
 b=cpTQTmDNktyfz4TOxjlTuqfmLJIq+jCkgkKR7LPTMbatYNKokm9pJ6emja+/1vQEkd
 i+A9VygRm1ig6ZADw9PKJ54swcrrvBCCZNC58OizdvYdup4Of2ZsCB2ba51dtz5fu7H7
 XalaTFhLPDHBDXGpLZmb6NhMVl7WkZlx3QRL8dDjcvNEoFSau1GyY72O+kpaOMzuMOeF
 9ziC77ogDCM7pDky11xukVPpgwWI83dF2hkptpeah8edxk0cBWBZx43yoMU8fkqHiDdV
 irF80FYhkWMZXRCOY66yqVU0yeIKv/QvjhFj2hsZkorIOWa2PmMAhg9ifHT4EgcWKckh
 vVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058746; x=1777663546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yg9NGrFw4w9i67ta248F9C5oPYjEgGTbMKQDwpdrGME=;
 b=moxz29PRLN3lbctwWxCdreaF7M9LDLPNaSmSfZpZ1cEbidv8VA3hgbOezKWHpgVV4P
 t9X5y+GGtzXErB31ArtRN/qc+ChpO5YrjCMTDs1jvMOrRpqoe+53lE5mIaOwzLUq3KoF
 MK9u8vdLf8dS5khcoWmYWeFPDQ2VppExOIqUAc3aRkC4gDftueuS/zTJkmzLBBa8A0k/
 yRv2M70tIlyPiD2PW/J8ABjInMBd0idKxd9MgrvD8wuOh/sb+NV4qMfviE8w1VCqPSg9
 BJE8ll/XqsBirLvVPQpEj7gJinQvme4kkJ6YqA0nH0e1UP7m7KkOfD/XRZ8QJ6/DfDwq
 ahlA==
X-Gm-Message-State: AOJu0YyoDDyKNjLwyyg0JiKbbM/nCmfJxP7K0Cm0qyEAIdILAZ1rlHPS
 dm4WX+f4YwlKb32ifXzVOH3BNlDQdp40yGW86xLDc2RA08ZlIkmhInURpujJwQT/LgV2yeZb0so
 77d9tFd8=
X-Gm-Gg: AeBDiesrr1ZUOAih5fHmgy2UW8DUGHBiSkBk1A/leY9JIh+59TS6S7rLmPIHIOovsPc
 guR5kxwVWrM56CWlGslRAVLa4qMRydayd703Qbu1kiNIuCPAsavnxDdtfOjeMXnOkmE8TV+O7Bp
 J1Sx64B1DKXNrsYYgcMwTaJYXky2N1qbP0DbFiVZ8A2enRLtWJNzczMl4KCgKvSaDGCnhjATlWL
 T4OYSb7iRhumzEzrnb1vWAYZcp0VKjT4UoTyVAwNxLhzsoMszB2RHc6CnSkLL3iF/Kpz+YPjXGJ
 KaWd2tIqbIj1TxPiaqRuelRTVogWeceWS8mRSdqUmG2BZInCcmkAr6YX4rSlokyQYTnJOUL/x3R
 DgN368o/StpAi5aWHmOoOxledDNwJlKDUoc8ZkFOE9IXBNAZ5gI4S4W/lJKhOuwJyxA9Q3DR4gz
 lCtBsPHCfTa+EjDaaDsHsESGGuPgPlTHeTaS2/R8qNYjgZDgCRTdpLITsSJmuF+4aaoo0Vw7/pF
 JjEdrr700I=
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id
 5b1f17b1804b1-4890e49f7d8mr255925925e9.17.1777058745680; 
 Fri, 24 Apr 2026 12:25:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c773fsm691047775e9.12.2026.04.24.12.25.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:25:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 00/62] Misc HW patches for 2026-04-22
Date: Fri, 24 Apr 2026 21:25:32 +0200
Message-ID: <20260424192543.22614-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

v4:
  fixed QOM 'compat' properties on linux-user
v3:
  now than target-arm.next is merged, 3 more MAINTAINERS patches

The following changes since commit 4bde339ecb41b16e90810233ba5ee2fa87bd443f:

  Merge tag 'pull-11.1-virtio-gpu-hotfixes-230426-1' of https://gitlab.com/stsquad/qemu into staging (2026-04-23 20:51:57 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260422

for you to fetch changes up to 7754d268a0558b10c3bfdaaff0ccb1727a94918a:

  MAINTAINERS: Transfer CI maintenance to Pierrick (2026-04-24 21:20:45 +0200)

----------------------------------------------------------------
Misc HW patches

- Build hw/avr/ as common unit files
- Header cleanups around 'cpu.h', 'qemu/audio.h' or duplicated lines
- Remove obsolete TPMIfClass::ppi_enabled field
- Cleanups around load/store API
- Restrict 'compat' properties API to system emulation
- Correct TPM PPCI ACPI for Windows guests on ARM Virt machine
- Simplify physical_memory_range_includes_clean()
- Avoid including CONFIG_DEVICES in hw/arm/smmuv3
- Initialize bus frequency in PPC e500 device tree blob
- More ATI VGA fixes
- Fix fuzzing issues on AVR power controller and SH4 MCU
- MAINTAINERS updates
- Machine compat array for v11.0.0 release
- USB EHCI cleanups
----------------------------------------------------------------

Bin Guo (1):
  physmem: Simplify dirty memory type checks with loop

Cornelia Huck (1):
  hw: add compat machines for 11.1

Jamin Lin (6):
  hw/usb/hcd-ehci: Remove unused EHCIfstn structure and dead code
  hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch
  hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch
  hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with
    qemu_log_mask(LOG_GUEST_ERROR)
  hw/usb/hcd-ehci: Replace DPRINTF debug logs with trace events
  hw/usb/hcd-ehci: Introduce common properties macro for sysbus and pci

Junjie Cao (2):
  ati-vga: fix unsigned integer overflow in cursor bounds checks
  ati-vga: mask out lock bit from CUR_OFFSET in cursor offset
    calculation

Mohammadfaiz Bawa (3):
  docs/specs/tpm: document PPI support on ARM64 virt
  hw/acpi/tpm: parameterize PPI base address in tpm_build_ppi_acpi
  hw/tpm: add PPI support to tpm-tis-device for ARM64 virt

Osama Abdelkader (3):
  hw/virtio/virtio-iommu: remove duplicate include
  hw/hyperv: remove duplicate include
  hw/ppc/amigaone: remove duplicate include

Peter Maydell (1):
  hw/arm, hw/ppc: Remove unnecessary audio.h includes from board code

Philippe Mathieu-Daudé (42):
  hw/avr: Build as common unit files
  hw/core/cpu: Expose CPUState::start_powered_off docstring
  hw/misc/cpc: Include missing 'hw/core/cpu.h' header
  hw/alpha: Include full path to target 'cpu.h' header
  hw/arm: Include full path to target 'cpu.h' header
  hw/avr: Include full path to target 'cpu.h' header
  hw/hppa: Include full path to target 'cpu.h' header
  hw/i386: Include full path to target 'cpu.h' header
  hw/m68k: Include full path to target 'cpu.h' header
  hw/microblaze: Include full path to target 'cpu.h' header
  hw/mips: Include full path to target 'cpu.h' header
  hw/or1k: Include full path to target 'cpu.h' header
  hw/ppc: Include full path to target 'cpu.h' header
  hw/riscv: Include full path to target 'cpu.h' header
  hw/s390x: Include full path to target 'cpu.h' header
  hw/sh4: Include full path to target 'cpu.h' header
  hw/sparc: Include full path to target 'cpu.h' header
  hw/tricore: Include full path to target 'cpu.h' header
  hw/xtensa: Include full path to target 'cpu.h' header
  hw/tpm: Factor tpm_ppi_enabled() out
  hw/tpm: Add TPMIfClass::ppi_enabled field
  hw/tpm: Remove CRBState::ppi_enabled field
  hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
    TPMState
  hw/tpm: Simplify tpm_ppi_enabled()
  hw/ppc/spapr: Un-inline rtas_load/store() helpers
  hw/hyperv: Replace legacy ld_phys() -> address_space_ld()
  system/memory: Constify various AddressSpace arguments (flatview)
  hw/core: Move compat_props_add() to 'hw/core/boards.h'
  qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
  qom: Declare compat properties API in 'qom/compat-properties.h'
  qom: Restrict compat properties API to system emulation
  hw/arm/smmuv3: Have smmuv3_accel_init() take an Error* parameter
  hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/ header
  hw/cxl: Define cxl_fmws_get_all_sorted() stub
  hw/arm/virt: Do not select Kconfig symbol PCI_EXPRESS
  MAINTAINERS: Merge PCIe DOE section within SPDM
  MAINTAINERS: Cover hexloader tests under the Generic Loader section
  MAINTAINERS: Remove my unused git tree locations
  MAINTAINERS: Remove my disfunctional emails
  MAINTAINERS: Remove PhilMD from NVMe Block Driver
  MAINTAINERS: Maintain MIPS Boston
  MAINTAINERS: Transfer CI maintenance to Pierrick

Thomas Huth (2):
  hw/misc: Fix the valid access size to the avr-power device
  hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler

Vivien LEGER (1):
  hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT
    node

 MAINTAINERS                                 |  28 +--
 docs/specs/tpm.rst                          |  24 +++
 hw/arm/smmuv3-accel.h                       |  41 +---
 hw/avr/boot.h                               |   2 +-
 hw/ppc/e500.h                               |   1 +
 hw/s390x/ipl.h                              |   2 +-
 hw/s390x/s390-hypercall.h                   |   2 +-
 hw/sd/sdmmc-internal.h                      |   2 +-
 hw/tpm/tpm_tis.h                            |   3 +-
 hw/usb/hcd-ehci.h                           |  37 ++--
 hw/xtensa/xtensa_memory.h                   |   2 +-
 include/crypto/tls-cipher-suites.h          |   2 +-
 include/hw/acpi/tpm.h                       |   3 +-
 include/hw/arm/digic.h                      |   2 +-
 include/hw/arm/fsl-imx6.h                   |   2 +-
 include/hw/arm/fsl-imx6ul.h                 |   2 +-
 include/hw/arm/fsl-imx7.h                   |   2 +-
 include/hw/arm/fsl-imx8mp.h                 |   2 +-
 include/hw/core/boards.h                    |  14 ++
 include/hw/core/cpu.h                       |   2 +-
 include/hw/core/qdev-properties.h           |   1 +
 include/hw/core/qdev.h                      |  27 ---
 include/hw/i2c/arm_sbcon_i2c.h              |   2 +-
 include/hw/i386/apic_internal.h             |   2 +-
 include/hw/i386/pc.h                        |   3 +
 include/hw/intc/mips_gic.h                  |   2 +-
 include/hw/misc/bcm2835_thermal.h           |   2 +-
 include/hw/misc/led.h                       |   2 +-
 include/hw/ppc/pnv.h                        |   2 +-
 include/hw/ppc/spapr.h                      |  18 +-
 include/hw/ppc/spapr_fadump.h               |   2 +-
 include/hw/timer/bcm2835_systmr.h           |   2 +-
 include/qemu/units.h                        |   2 +-
 include/qom/compat-properties.h             |  40 ++++
 include/qom/object.h                        |   8 -
 include/system/memory.h                     |   2 +-
 include/system/tpm.h                        |   9 +
 system/memory-internal.h                    |   5 +-
 accel/accel-system.c                        |   1 +
 backends/hostmem.c                          |   1 +
 crypto/tls-cipher-suites.c                  |   2 +-
 hw/acpi/tpm.c                               |  10 +-
 hw/alpha/dp264.c                            |   2 +-
 hw/alpha/typhoon.c                          |   2 +-
 hw/arm/boot.c                               |   2 +-
 hw/arm/exynos4210.c                         |   2 +-
 hw/arm/integratorcp.c                       |   1 -
 hw/arm/mps3r.c                              |   2 +-
 hw/arm/musicpal.c                           |   1 -
 hw/arm/omap1.c                              |   2 +-
 hw/arm/realview.c                           |   3 +-
 hw/arm/smmuv3-accel-stubs.c                 |  52 +++++
 hw/arm/smmuv3-accel.c                       |   3 +-
 hw/arm/smmuv3.c                             |  13 +-
 hw/arm/versatilepb.c                        |   1 -
 hw/arm/vexpress.c                           |   1 -
 hw/arm/virt-acpi-build.c                    |   9 +-
 hw/arm/virt.c                               |  11 +-
 hw/arm/xlnx-zcu102.c                        |   1 -
 hw/core/machine.c                           |   4 +
 hw/core/qdev-properties.c                   |   1 +
 hw/core/qdev.c                              |   1 +
 hw/cxl/cxl-host-stubs.c                     |   5 +
 hw/display/ati.c                            |  12 +-
 hw/hppa/machine.c                           |   2 +-
 hw/hyperv/hyperv.c                          |   6 +-
 hw/hyperv/vmbus.c                           |   1 -
 hw/i386/acpi-build.c                        |   4 +-
 hw/i386/fw_cfg.c                            |   2 +-
 hw/i386/multiboot.c                         |   2 +-
 hw/i386/pc.c                                |   3 +
 hw/i386/pc_piix.c                           |  13 +-
 hw/i386/pc_q35.c                            |  14 +-
 hw/i386/pc_sysfw_ovmf-stubs.c               |   2 +-
 hw/i386/pc_sysfw_ovmf.c                     |   2 +-
 hw/i386/vmmouse.c                           |   2 +-
 hw/intc/arm_gicv3_cpuif.c                   |   2 +-
 hw/intc/arm_gicv3_cpuif_common.c            |   2 +-
 hw/intc/m68k_irqc.c                         |   2 +-
 hw/intc/sh_intc.c                           |   2 +-
 hw/isa/lpc_ich9.c                           |   2 +-
 hw/m68k/an5206.c                            |   2 +-
 hw/m68k/mcf5206.c                           |   2 +-
 hw/m68k/mcf5208.c                           |   2 +-
 hw/m68k/mcf_intc.c                          |   2 +-
 hw/m68k/q800-glue.c                         |   2 +-
 hw/m68k/q800.c                              |   2 +-
 hw/m68k/virt.c                              |  13 +-
 hw/microblaze/boot.c                        |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c         |   2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c    |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c             |   2 +-
 hw/mips/bootloader.c                        |   2 +-
 hw/mips/fuloong2e.c                         |   2 +-
 hw/mips/jazz.c                              |   2 +-
 hw/mips/malta.c                             |   2 +-
 hw/misc/avr_power.c                         |   3 +
 hw/misc/bcm2835_thermal.c                   |   2 +-
 hw/misc/led.c                               |   2 +-
 hw/misc/mips_cpc.c                          |   3 +-
 hw/misc/riscv_cmgcr.c                       |   2 +-
 hw/misc/riscv_cpc.c                         |   3 +-
 hw/or1k/boot.c                              |   2 +-
 hw/or1k/cputimer.c                          |   2 +-
 hw/or1k/or1k-sim.c                          |   2 +-
 hw/or1k/virt.c                              |   2 +-
 hw/ppc/amigaone.c                           |   1 -
 hw/ppc/e500.c                               |   2 +-
 hw/ppc/e500plat.c                           |   1 +
 hw/ppc/fw_cfg.c                             |   2 +-
 hw/ppc/mpc8544_guts.c                       |   2 +-
 hw/ppc/mpc8544ds.c                          |   3 +-
 hw/ppc/ppc440_uc.c                          |   2 +-
 hw/ppc/ppc4xx_devs.c                        |   2 +-
 hw/ppc/ppc_booke.c                          |   2 +-
 hw/ppc/prep.c                               |   1 -
 hw/ppc/prep_systemio.c                      |   2 +-
 hw/ppc/spapr.c                              |  17 +-
 hw/ppc/spapr_rtas.c                         |  15 ++
 hw/ppc/spapr_vhyp_mmu.c                     |   2 +-
 hw/ppc/virtex_ml507.c                       |   2 +-
 hw/riscv/microblaze-v-generic.c             |   2 +-
 hw/s390x/ap-bridge.c                        |   2 +-
 hw/s390x/s390-hypercall.c                   |   2 +-
 hw/s390x/s390-stattrib.c                    |   2 +-
 hw/s390x/s390-virtio-ccw.c                  |  14 +-
 hw/s390x/tod-tcg.c                          |   2 +-
 hw/sd/sd.c                                  |   2 +-
 hw/sh4/r2d.c                                |   2 +-
 hw/sh4/sh7750.c                             |   1 -
 hw/sparc/leon3.c                            |   2 +-
 hw/sparc/sun4m.c                            |   2 +-
 hw/sparc64/niagara.c                        |   2 +-
 hw/sparc64/sparc64.c                        |   2 +-
 hw/sparc64/sun4u.c                          |   2 +-
 hw/timer/bcm2835_systmr.c                   |   2 +-
 hw/tpm/tpm_crb.c                            |  13 +-
 hw/tpm/tpm_tis_common.c                     |   4 +-
 hw/tpm/tpm_tis_i2c.c                        |   2 +-
 hw/tpm/tpm_tis_isa.c                        |  12 +-
 hw/tpm/tpm_tis_sysbus.c                     |  13 +-
 hw/tricore/tricore_testboard.c              |   2 +-
 hw/usb/bus-stub.c                           |   2 +-
 hw/usb/hcd-ehci-pci.c                       |   2 +-
 hw/usb/hcd-ehci-sysbus.c                    |   2 +-
 hw/usb/hcd-ehci.c                           | 228 ++++++++++----------
 hw/virtio/virtio-iommu.c                    |   1 -
 hw/xtensa/pic_cpu.c                         |   2 +-
 hw/xtensa/xtfpga.c                          |   2 +-
 qom/compat-properties.c                     |  76 +++++++
 qom/object.c                                |  62 +-----
 stubs/fw_cfg.c                              |   2 +-
 stubs/hotplug-stubs.c                       |   2 +-
 stubs/qdev.c                                |   2 +-
 stubs/qom-compat-properties.c               |  14 ++
 system/memory.c                             |   2 +-
 system/physmem.c                            |  16 +-
 system/rtc.c                                |   1 +
 system/vl.c                                 |   1 +
 target/i386/sev.c                           |   1 +
 tests/qtest/fuzz-sb16-test.c                |   2 +-
 tests/qtest/fuzz-sdcard-test.c              |   2 +-
 tests/qtest/sdhci-test.c                    |   2 +-
 ui/vdagent.c                                |   1 +
 hw/arm/Kconfig                              |   1 -
 hw/arm/meson.build                          |   5 +-
 hw/misc/meson.build                         |   2 +-
 hw/timer/meson.build                        |   2 +-
 hw/usb/trace-events                         |   9 +
 qom/meson.build                             |   3 +
 rust/bindings/qom-sys/lib.rs                |   2 +-
 stubs/meson.build                           |   1 +
 tests/functional/aarch64/test_raspi3.py     |   2 +-
 tests/functional/arm/test_bflt.py           |   2 +-
 tests/functional/arm/test_raspi2.py         |   2 +-
 tests/functional/m68k/test_nextcube.py      |   2 +-
 tests/functional/mips/test_malta.py         |   2 +-
 tests/functional/mips64el/test_fuloong2e.py |   2 +-
 tests/functional/mips64el/test_malta.py     |   2 +-
 tests/functional/mipsel/test_malta.py       |   2 +-
 tests/functional/ppc/test_40p.py            |   2 +-
 tests/functional/qemu_test/tesseract.py     |   2 +-
 182 files changed, 687 insertions(+), 504 deletions(-)
 create mode 100644 include/qom/compat-properties.h
 create mode 100644 hw/arm/smmuv3-accel-stubs.c
 create mode 100644 qom/compat-properties.c
 create mode 100644 stubs/qom-compat-properties.c

-- 
2.53.0


