Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00B3FDEE4E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1NT-0008Mt-AY; Thu, 23 Apr 2026 17:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1NR-0008Mh-Px
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:14:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1NP-0002ok-Dv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:14:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3867072f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776978861; x=1777583661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kRnhgZOqgk3WtkKpeLYlJfjKtxNClIWVv+MHALxJ8lc=;
 b=D7z3a1ugd7HlChEnAP3rdUsuHSAmil0vpXR5PfA+zqiAN9CTWr/pe03bA+r+qNshL2
 I0bEsDewliCZvAYRGcbesZ110VDE37PAkWZtd0k3Yt4ZjAeKgiAUFNqNa+PwPWC7NznO
 43/9S6hiYaRcnxF/VQyWhDtk7LXTYHeEgej4O5Cp276NG+QleW5+f4E3VbY0NCZ/EbzL
 iVnadv4End+gpbWMAacIikYfcG4XTxKazNeXYaiAcnEx5uJe7fb+5ppCE6UT40kiwoKA
 ho67AZaTTuQ6Cz/ADSlhQG3ZAi8tFRqk8B2H3lzMN5fDZKlxnEvg/4gUsjd/yuD+vpUi
 kwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776978861; x=1777583661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kRnhgZOqgk3WtkKpeLYlJfjKtxNClIWVv+MHALxJ8lc=;
 b=bYuzlHcfVwwuTQV8q+vWLKOWJ067TbDMcQPcNZ4GPRRHRWCV/qKekxp9meYOHMfyHl
 cycNoiQfmtG5gFt7ZZib/zQ3zT6dWP6opQwiLqWd8zgEguZ2aQhBLEdYgnh71zKjRQnv
 tuOhSViiuoM7AQ117MRz8GzReiDgYK6+QelZsgh2qPsu2V4WTsl56F3bHhHiGJXBXPHk
 h/3nk4fCUYFpRqeObfoiXPkvvTKYA7bBw4ORmq8+zfJXXHtL8epEKEqobVCFScW0uyJf
 dkvJB78NR1LXkmZ0JNVDFFaGy2m8kuI3nG5n/QOhegOxS0ok38VfDGDrReHDgnrkusdK
 IL+A==
X-Gm-Message-State: AOJu0YzD/XMF4XO1/2POKV33gMsNYlA7u3A2+TQot6qGzTpwQA+tbHpq
 VXke5bvQqizkXz4ynnPAVAfvDTLx2xAY70Es2LZYwol8cpcI1VtK9vmkQIxl/tRA58wmfVzlI/U
 c3gSvILA=
X-Gm-Gg: AeBDiesSSB2NHVxwzJoEx1hmeANgZBXt3eqXz7uNmOVmTb/+LbjVgJt7ERAVZmXhVi1
 tgeSxYeZ1EwJi8Q+3bmTCzQNPlpw8vsbU8CTThkgozXcUH2H63q6CV1ntlVF4UR0poWgk3KQmMr
 KdcUxKZ6rOSSSXWagQVJ1Ejj0knoYKrPu0rldPjroeogCw8l1BkbGklLL53hL9iLhNS8d/2hTKq
 HWhcTTQ2RLQsiWoVFCCWd+ahSTfeT6u5p5dM6G6fzKcKrzLimytya7zMafvgNtmruE5WfWmjpZl
 s1Dw6nK7vmHf1a9urtDtmR66mP+pyx9kVyPTJmjRJwxZHsLQOsUXLYq/J4S2nSC0xHxacNoGNAL
 D1mtnTbMqlFM6eOz41IOXNnlkKFOYJaTLGbR3707y1gVw23BLl4JVmvan1piNa2F7WddU/Ni8UC
 VMfYb0ZCbANZWbxlEZcYYpi1/6QlIDzwN5R1IvG1+pSu49HhM5vLcw4UHwifxmj92sLzymTI7Kk
 tdba43KC+s=
X-Received: by 2002:a05:6000:2887:b0:43f:ea91:63ff with SMTP id
 ffacd0b85a97d-43fea916442mr37981326f8f.10.1776978860762; 
 Thu, 23 Apr 2026 14:14:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm61060748f8f.18.2026.04.23.14.14.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 14:14:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/49] Misc HW patches for 2026-04-22
Date: Thu, 23 Apr 2026 23:14:17 +0200
Message-ID: <20260423211418.67186-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

v2:
Rebased on top of
  Merge tag 's390x-20260423' of https://gitlab.com/cohuck/qemu into staging
to fix:
  CONFLICT (content): Merge conflict in include/hw/core/boards.h

The following changes since commit e5182fd198e85cb650cdfed1839ee8aac86e0b7e:

  Merge tag 'pull-11.1-virtio-gpu-hotfixes-230426-1' of https://gitlab.com/stsquad/qemu into staging (2026-04-23 13:52:08 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260422

for you to fetch changes up to 27a32a00aaa70aee148c9147abe3eb9231eb7a0d:

  MAINTAINERS: Transfer CI maintenance to Pierrick (2026-04-23 23:06:25 +0200)

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
----------------------------------------------------------------

Bin Guo (1):
  physmem: Simplify dirty memory type checks with loop

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

Philippe Mathieu-Daudé (36):
  hw/avr: Build as common unit files
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
  MAINTAINERS: Remove my unused git tree locations
  MAINTAINERS: Remove my disfunctional emails
  MAINTAINERS: Remove PhilMD from NVMe Block Driver
  MAINTAINERS: Transfer CI maintenance to Pierrick

Thomas Huth (2):
  hw/misc: Fix the valid access size to the avr-power device
  hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler

Vivien LEGER (1):
  hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT
    node

 MAINTAINERS                                 |   9 +-
 docs/specs/tpm.rst                          |  24 ++++
 hw/arm/smmuv3-accel.h                       |  41 +------
 hw/avr/boot.h                               |   2 +-
 hw/ppc/e500.h                               |   1 +
 hw/s390x/ipl.h                              |   2 +-
 hw/s390x/s390-hypercall.h                   |   2 +-
 hw/sd/sdmmc-internal.h                      |   2 +-
 hw/tpm/tpm_tis.h                            |   3 +-
 hw/xtensa/xtensa_memory.h                   |   2 +-
 include/crypto/tls-cipher-suites.h          |   2 +-
 include/hw/acpi/tpm.h                       |   3 +-
 include/hw/arm/digic.h                      |   2 +-
 include/hw/arm/fsl-imx6.h                   |   2 +-
 include/hw/arm/fsl-imx6ul.h                 |   2 +-
 include/hw/arm/fsl-imx7.h                   |   2 +-
 include/hw/arm/fsl-imx8mp.h                 |   2 +-
 include/hw/core/boards.h                    |  11 ++
 include/hw/core/qdev-properties.h           |   1 +
 include/hw/core/qdev.h                      |  27 -----
 include/hw/i2c/arm_sbcon_i2c.h              |   2 +-
 include/hw/i386/apic_internal.h             |   2 +-
 include/hw/intc/mips_gic.h                  |   2 +-
 include/hw/misc/bcm2835_thermal.h           |   2 +-
 include/hw/misc/led.h                       |   2 +-
 include/hw/ppc/pnv.h                        |   2 +-
 include/hw/ppc/spapr.h                      |  18 +--
 include/hw/ppc/spapr_fadump.h               |   2 +-
 include/hw/timer/bcm2835_systmr.h           |   2 +-
 include/qemu/units.h                        |   2 +-
 include/qom/compat-properties.h             |  40 +++++++
 include/qom/object.h                        |   8 --
 include/system/memory.h                     |   2 +-
 include/system/tpm.h                        |   9 ++
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
 hw/arm/smmuv3-accel-stubs.c                 |  52 +++++++++
 hw/arm/smmuv3-accel.c                       |   3 +-
 hw/arm/smmuv3.c                             |  13 +--
 hw/arm/versatilepb.c                        |   1 -
 hw/arm/vexpress.c                           |   1 -
 hw/arm/virt-acpi-build.c                    |   9 +-
 hw/arm/xlnx-zcu102.c                        |   1 -
 hw/core/machine.c                           |   1 +
 hw/core/qdev-properties.c                   |   1 +
 hw/core/qdev.c                              |   1 +
 hw/display/ati.c                            |  12 +-
 hw/hppa/machine.c                           |   2 +-
 hw/hyperv/hyperv.c                          |   6 +-
 hw/hyperv/vmbus.c                           |   1 -
 hw/i386/acpi-build.c                        |   4 +-
 hw/i386/fw_cfg.c                            |   2 +-
 hw/i386/multiboot.c                         |   2 +-
 hw/i386/pc_q35.c                            |   1 +
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
 hw/m68k/virt.c                              |   2 +-
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
 hw/ppc/spapr_rtas.c                         |  15 +++
 hw/ppc/spapr_vhyp_mmu.c                     |   2 +-
 hw/ppc/virtex_ml507.c                       |   2 +-
 hw/riscv/microblaze-v-generic.c             |   2 +-
 hw/s390x/ap-bridge.c                        |   2 +-
 hw/s390x/s390-hypercall.c                   |   2 +-
 hw/s390x/s390-stattrib.c                    |   2 +-
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
 hw/tpm/tpm_crb.c                            |  13 +--
 hw/tpm/tpm_tis_common.c                     |   4 +-
 hw/tpm/tpm_tis_i2c.c                        |   2 +-
 hw/tpm/tpm_tis_isa.c                        |  12 +-
 hw/tpm/tpm_tis_sysbus.c                     |  13 ++-
 hw/tricore/tricore_testboard.c              |   2 +-
 hw/usb/bus-stub.c                           |   2 +-
 hw/virtio/virtio-iommu.c                    |   1 -
 hw/xtensa/pic_cpu.c                         |   2 +-
 hw/xtensa/xtfpga.c                          |   2 +-
 qom/compat-properties.c                     | 116 ++++++++++++++++++++
 qom/object.c                                | 102 +----------------
 stubs/fw_cfg.c                              |   2 +-
 stubs/hotplug-stubs.c                       |   2 +-
 stubs/qdev.c                                |   2 +-
 stubs/qom-compat-properties.c               |  20 ++++
 system/memory.c                             |   2 +-
 system/physmem.c                            |  16 +--
 system/rtc.c                                |   1 +
 system/vl.c                                 |   1 +
 target/i386/sev.c                           |   1 +
 tests/qtest/fuzz-sb16-test.c                |   2 +-
 tests/qtest/fuzz-sdcard-test.c              |   2 +-
 tests/qtest/sdhci-test.c                    |   2 +-
 ui/vdagent.c                                |   1 +
 hw/arm/meson.build                          |   5 +-
 hw/misc/meson.build                         |   2 +-
 hw/timer/meson.build                        |   2 +-
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
 168 files changed, 499 insertions(+), 382 deletions(-)
 create mode 100644 include/qom/compat-properties.h
 create mode 100644 hw/arm/smmuv3-accel-stubs.c
 create mode 100644 qom/compat-properties.c
 create mode 100644 stubs/qom-compat-properties.c

-- 
2.53.0


