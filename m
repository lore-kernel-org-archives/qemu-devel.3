Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707E6C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfJr-00063H-4Y; Tue, 18 Jun 2024 16:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfJp-00062i-7O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:20:41 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfJm-000205-Dy
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:20:40 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cc14815c3so1653644e87.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718742036; x=1719346836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FWu01uaMr/ci/nwpjfA/VaJlCH6vbBEpUmnnUg4eOZY=;
 b=ytkJjtTw+hvGJw88coLx4AXNw8NDLWcB+K4SWe2/RZf+piFYLSfkWZbtxb/jIc1X+3
 Do+2T1pc1QIQfxteV84c2yFFN15qtgqe84OE/bheXSJpfYUYDD8y6yRqFekCS8QfGEkJ
 sYqlwzOv+BRRe6kthfzFlDHFYeCUi3pFlt5HCvE99Q/jUr6TLYonHVpf8NymDDUJUVo0
 mQAH8aC1gXwSogizgpeYLtmdEiIjVL629P/LmUCfl+PIVWfT2e93UY8CsGopb8EAugCe
 Z+qfRznbhEu7zIUl1csCCiX/1TZ356lfBsRbntAg49MBdA1TK+rnXruqEO4Ojcmwctzu
 wpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718742036; x=1719346836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FWu01uaMr/ci/nwpjfA/VaJlCH6vbBEpUmnnUg4eOZY=;
 b=ozJhZkmYd9O1ont4hsxKYoFMgI5EIKtlgRBV6Tkg+/zP7C6cqmOkZTvX07cbl3t+88
 iLT9mbpUohHClhjjW62xnt/fE2/xvrfVE0f0IUFRBKrmCFzBeL/qlMu4EuXI+cSTkJBv
 RwwVI3kdfvH5x+jPSvDjzBTf/hrHmP9vrbl6qkYDOGJm0tEomdl7pas/K7FBDi/X1wse
 p0IBD/L6b/WqYt1ccIfm0nmssnlXSZFc6DP68mLbtvGPBEmIh2hoLWYXbBtis9O/FV2y
 sqV8ZMBR341xIX0z7TqEMYx7AX+wJJIlGgaBfFQvg3UF1HjIezFTGVW77d9NgB7UXbao
 T/Gw==
X-Gm-Message-State: AOJu0YxkdzWqBqS+4/9iRAT+shw+F2DSkgF0azv2meeHoMvGKT41IJcL
 gv3bM2RL+mHEYM0sZKrluBy9Mezd8951Ko9KD3dZ0X7LbpNxRWUPhvNApQsr4IQOAcFewTTtyns
 U
X-Google-Smtp-Source: AGHT+IEG9x7f5LlE+Gz2P4oXo6x3xLuARB1zGzoUDZB36xYG654WiVIjcugLaV5tG02/WRhjYh2K5g==
X-Received: by 2002:a05:6512:3696:b0:52c:8abe:5204 with SMTP id
 2adb3069b0e04-52ccaa3689fmr342612e87.32.1718742035444; 
 Tue, 18 Jun 2024 13:20:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42471e65fb7sm17699055e9.1.2024.06.18.13.20.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 13:20:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 00/76] Misc patches for 2024-06-18
Date: Tue, 18 Jun 2024 22:20:31 +0200
Message-ID: <20240618202032.40268-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 900536d3e97aed7fdd9cb4dadd3bf7023360e819:

  Merge tag 'dirtylimit-dirtyrate-pull-request-20240617' of https://github.com/newfriday/qemu into staging (2024-06-17 11:40:24 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-20240618

for you to fetch changes up to 9bf66ef9c7bacd410084f285fbcac6ee4189bab2:

  ui+display: rename is_buffer_shared() -> surface_is_allocated() (2024-06-18 22:17:15 +0200)

Spurious warning (3 times):

 WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Deliberately ignored in ui/ (also 3 times):

  WARNING: line over 80 characters

----------------------------------------------------------------
Misc patches queue

. Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
. Always use little endian audio format in virtio-snd (Phil)
. Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
. Introduce x-query-interrupt-controllers QMP command (Phil)
. Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use (Cédric)
. Set arm_v7m_tcg_ops::cpu_exec_halt & mandate TCGCPUOps::cpu_exec_halt (Peter)
. Constify few uses of IOMMUTLBEvent (Phil)
. Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
. Fix inclusion of tracing headers on s390x/TCG (Phil)
. Add few shortcuts missing to readline (Manos)
. Update ui/display entries in MAINTAINERS (Gerd)
. Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
. Fix Standard VGA screen blanking and cleanups (Gerd)
. Fix USB/MTP reported "free space" value (Fabio)

----------------------------------------------------------------

Akihiko Odaki (1):
  ui/cocoa: Use qemu_add_mouse_change_notifier

Cédric Le Goater (1):
  ppc/pnv: Introduce pnv_chip_foreach_cpu()

Fabio D'Urso (1):
  hw/usb/dev-mtp: Correctly report free space

Gerd Hoffmann (5):
  MAINTAINERS: drop virtio-gpu maintainership
  MAINTAINERS: drop spice+ui maintainership
  stdvga: fix screen blanking
  ui+display: rename is_placeholder() -> surface_is_placeholder()
  ui+display: rename is_buffer_shared() -> surface_is_allocated()

Jiaxun Yang (4):
  hw/intc: Remove loongarch_ipi.c
  hw/intc/loongson_ipi: Provide per core MMIO address spaces
  hw/intc/loongson_ipi: Replace ipi_getcpu with cpu_by_arch_id
  hw/mips/loongson3_virt: Wire up loongson_ipi device

Manos Pitsidianakis (3):
  util/readline: Fix lints for readline_handle_byte
  util/readline: Add C-n, C-p shortcuts
  util/readline: Add C-u shortcut

Peter Maydell (3):
  target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt()
  target: Set TCGCPUOps::cpu_exec_halt to target's has_work
    implementation
  accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory

Philippe Mathieu-Daudé (58):
  hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
  hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
  hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
  hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
  hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
  hw/acpi/ich9: Remove 'memory-hotplug-support' property
  hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
  hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
  target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
  hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
  hw/smbios: Remove 'uuid_encoded' argument from smbios_set_defaults()
  hw/smbios: Remove 'smbios_uuid_encoded', simplify smbios_encode_uuid()
  hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
  hw/mem/pc-dimm: Remove legacy_align argument from pc_dimm_pre_plug()
  hw/mem/memory-device: Remove legacy_align from
    memory_device_pre_plug()
  hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
  hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
  hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
  hw/i386/acpi: Remove AcpiBuildState::rsdp field
  hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine
  hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
  target/i386: Remove X86CPU::kvm_no_smi_migration field
  hw/i386/pc: Replace PCMachineClass::acpi_data_size by
    PC_ACPI_DATA_SIZE
  hw/audio/virtio-snd: Always use little endian audio format
  hw/ppc: Avoid using Monitor in pnv_phb3_msi_pic_print_info()
  hw/ppc: Avoid using Monitor in icp_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
  hw/ppc: Avoid using Monitor in ics_pic_print_info()
  hw/ppc: Avoid using Monitor in PnvChipClass::intc_print_info()
  hw/ppc: Avoid using Monitor in xive_end_queue_pic_print_info()
  hw/ppc: Avoid using Monitor in spapr_xive_end_pic_print_info()
  hw/ppc: Avoid using Monitor in spapr_xive_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_source_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_end_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_end_eas_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_end_queue_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
  hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
  hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
  hw/ppc: Avoid using Monitor in
    SpaprInterruptControllerClass::print_info()
  hw/ppc: Avoid using Monitor in spapr_irq_print_info()
  hw/ppc: Avoid using Monitor in pnv_chip_power9_pic_print_info_child()
  hw/ppc: Avoid using Monitor in pic_print_info()
  hw/intc: Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info()
  hw/intc: Introduce x-query-interrupt-controllers QMP command
  memory: Constify IOMMUTLBEvent in memory_region_notify_iommu_one()
  memory: Constify IOMMUTLBEvent in memory_region_notify_iommu()
  hw/i386/iommu: Constify IOMMUTLBEvent in vtd_page_walk_hook prototype
  hw/usb: Remove unused 'host.h' header
  hw/s390x: Introduce s390_skeys_get|set() helpers
  target/s390x: Use s390_skeys_get|set() helper

 MAINTAINERS                           |   8 +-
 docs/about/deprecated.rst             |   4 +-
 docs/about/removed-features.rst       |   2 +-
 qapi/machine.json                     |  17 ++
 hw/mips/loongson3_bootp.h             |   3 +
 hw/usb/hcd-xhci.h                     |   4 +-
 hw/usb/host.h                         |  44 ----
 include/exec/memory.h                 |   4 +-
 include/hw/core/tcg-cpu-ops.h         |   9 +-
 include/hw/firmware/smbios.h          |   3 +-
 include/hw/i386/pc.h                  |  22 --
 include/hw/intc/intc.h                |   2 +-
 include/hw/intc/loongson_ipi.h        |   2 +
 include/hw/mem/memory-device.h        |   2 +-
 include/hw/mem/pc-dimm.h              |   3 +-
 include/hw/pci-host/pnv_phb3.h        |   2 +-
 include/hw/pci-host/pnv_phb4.h        |   2 +-
 include/hw/ppc/pnv_chip.h             |   4 +-
 include/hw/ppc/pnv_psi.h              |   2 +-
 include/hw/ppc/pnv_xive.h             |   4 +-
 include/hw/ppc/spapr_irq.h            |   4 +-
 include/hw/ppc/xics.h                 |   4 +-
 include/hw/ppc/xive.h                 |   4 +-
 include/hw/ppc/xive2_regs.h           |   8 +-
 include/hw/ppc/xive_regs.h            |   8 +-
 include/hw/s390x/storage-keys.h       |  10 +
 include/ui/surface.h                  |   6 +-
 target/arm/internals.h                |   3 +
 target/i386/cpu.h                     |   3 -
 target/i386/kvm/kvm-cpu.h             |  41 ---
 target/riscv/internals.h              |   3 +
 accel/tcg/cpu-exec.c                  |   7 +-
 hw/acpi/ich9.c                        |  46 +---
 hw/arm/virt.c                         |   5 +-
 hw/audio/virtio-snd.c                 |   2 +-
 hw/core/machine-qmp-cmds.c            |  29 +++
 hw/display/qxl-render.c               |   2 +-
 hw/display/vga.c                      |  25 +-
 hw/display/xenfb.c                    |   5 +-
 hw/i386/acpi-build.c                  |  96 +------
 hw/i386/fw_cfg.c                      |   3 +-
 hw/i386/intel_iommu.c                 |   8 +-
 hw/i386/pc.c                          | 107 ++------
 hw/i386/pc_piix.c                     | 171 +++----------
 hw/intc/goldfish_pic.c                |   8 +-
 hw/intc/i8259_common.c                |  14 +-
 hw/intc/ioapic_common.c               |  57 ++---
 hw/intc/loongarch_ipi.c               | 347 --------------------------
 hw/intc/loongson_ipi.c                | 125 +++++-----
 hw/intc/m68k_irqc.c                   |   5 +-
 hw/intc/pnv_xive.c                    |  38 +--
 hw/intc/pnv_xive2.c                   |  48 ++--
 hw/intc/slavio_intctl.c               |  11 +-
 hw/intc/spapr_xive.c                  |  41 ++-
 hw/intc/xics.c                        |  25 +-
 hw/intc/xics_spapr.c                  |   7 +-
 hw/intc/xive.c                        | 108 ++++----
 hw/intc/xive2.c                       |  87 ++++---
 hw/loongarch/virt.c                   |   4 +-
 hw/mem/memory-device.c                |  12 +-
 hw/mem/pc-dimm.c                      |   6 +-
 hw/mips/loongson3_bootp.c             |   2 -
 hw/mips/loongson3_virt.c              |  39 ++-
 hw/pci-host/pnv_phb3_msi.c            |  21 +-
 hw/pci-host/pnv_phb4.c                |  17 +-
 hw/ppc/pnv.c                          |  96 ++++---
 hw/ppc/pnv_psi.c                      |   9 +-
 hw/ppc/spapr.c                        |  13 +-
 hw/ppc/spapr_irq.c                    |   4 +-
 hw/riscv/virt.c                       |   2 +-
 hw/s390x/s390-skeys.c                 |  27 ++
 hw/smbios/smbios.c                    |  13 +-
 hw/usb/dev-mtp.c                      |   2 +-
 hw/usb/hcd-xhci-nec.c                 |   4 -
 hw/usb/hcd-xhci-pci.c                 |   4 +-
 hw/usb/hcd-xhci.c                     |  42 +---
 hw/virtio/virtio-md-pci.c             |   2 +-
 monitor/hmp-cmds.c                    |  27 --
 system/memory.c                       |   6 +-
 target/alpha/cpu.c                    |   1 +
 target/arm/cpu.c                      |   2 +-
 target/arm/tcg/cpu-v7m.c              |   1 +
 target/avr/cpu.c                      |   1 +
 target/cris/cpu.c                     |   2 +
 target/hppa/cpu.c                     |   1 +
 target/i386/cpu.c                     |   2 -
 target/i386/kvm/kvm-cpu.c             |   3 +-
 target/i386/kvm/kvm.c                 |   7 +-
 target/loongarch/cpu.c                |   1 +
 target/m68k/cpu.c                     |   1 +
 target/microblaze/cpu.c               |   1 +
 target/mips/cpu.c                     |   1 +
 target/openrisc/cpu.c                 |   1 +
 target/ppc/cpu_init.c                 |   2 +
 target/riscv/cpu.c                    |   2 +-
 target/riscv/tcg/tcg-cpu.c            |   2 +
 target/rx/cpu.c                       |   1 +
 target/s390x/cpu.c                    |   1 +
 target/s390x/mmu_helper.c             |  11 +-
 target/s390x/tcg/mem_helper.c         |  16 +-
 target/sh4/cpu.c                      |   1 +
 target/sparc/cpu.c                    |   1 +
 target/xtensa/cpu.c                   |   1 +
 ui/console.c                          |   3 +-
 ui/sdl2-2d.c                          |   2 +-
 ui/sdl2-gl.c                          |   2 +-
 util/readline.c                       |  35 ++-
 hmp-commands-info.hx                  |   2 +-
 hw/mips/Kconfig                       |   1 +
 hw/s390x/trace-events                 |   4 +
 target/s390x/trace-events             |   4 -
 tests/avocado/mem-addr-space-check.py |   9 +-
 ui/cocoa.m                            |  62 +++--
 113 files changed, 777 insertions(+), 1426 deletions(-)
 delete mode 100644 hw/usb/host.h
 delete mode 100644 target/i386/kvm/kvm-cpu.h
 delete mode 100644 hw/intc/loongarch_ipi.c

-- 
2.41.0


