Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFC1C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsxP-0002GF-SW; Wed, 19 Jun 2024 06:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsxO-0002Fj-RB
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:54:26 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsxM-0003WK-Hz
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:54:26 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57cfe600cbeso2128101a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718794462; x=1719399262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TqP1SDPEBjPB1O4hjO+CGcXzRoBrG/UHn9LeEzlTHCA=;
 b=JSvBrIb95XqcD+vBqhjJ3NQF21DR6+JwJ6+ImrhyMqeS/rq/XhtSSNMDUwCZGK6M0E
 ogI3V45KxPfZycoAFkAr0slaEKQBj5Lc5H/3dCYystADmQ/V01skYSpWfXRDwtsV+h3P
 qUY1vMY8RHPHjyYyj4l2OvG0Anzva2ixRKythIay3MuMVjCA07GMep1WYoou2I++01OM
 5Gk+ym1rFL3JhaQSfuZqv44e8kjdaFGgv1i7Kjyq1pjaXwpQ9MSs587gUilrV5J7+B8z
 IYdpNCSxVzF///0Mthtc+B13P/67P4Zc7/yV0+/FYWvf1z0DEOsq6NIGzT9xpmS/BZ9S
 JlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718794462; x=1719399262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqP1SDPEBjPB1O4hjO+CGcXzRoBrG/UHn9LeEzlTHCA=;
 b=dfD1r75ScuFrjmXxzkeXdgU8pNNzZ3QiD3+mH8CRt1ryaDeX+IDofLpMZsNJ3/pId2
 dzGKoJh87CesVslyWGePDNdpTvKVej3NrIXhSGdHoi7l+grODf7gZN5v1WJjXbr3qvH5
 3Q0rZX87Z+P+v0ebKyf/SAo35i1VcTCZipNj6NHsx0OV2JE0CJiJfYBz0Tv2+4zeUmOB
 MCeZd8egLJrc3NU04pTEWx4I5SupMm07i2Zfti220WZvL7wHJLE8esZz31zLwxL8sPQk
 2Wp4HgA3JEzfisHEGoD27E0R2VcaXJcYLU8OubqreuCHkKvT02tZo4Ein7Kygq5y0IBK
 dbYQ==
X-Gm-Message-State: AOJu0YwXltfQebkNR/zMCFx+MWbL8az2bCt6JaiEZ3S3/eDnII1lWek3
 5Ykm+WQHJ+yuLsgQCXoNpGXFA3srxshvey4pAi30Am4LvKYXyXWXI2FTPW8aGMtrNXTiTMOKq71
 4
X-Google-Smtp-Source: AGHT+IFen1O1ePVN7PNrZyLa5cOOY/9bv4OINplJxs6KpBpmjAKGDBtGU6p3UPLJNykaLnA+Z9qQZA==
X-Received: by 2002:a05:6402:3414:b0:57c:a7dc:b0de with SMTP id
 4fb4d7f45d1cf-57d07ee7906mr1211677a12.39.1718794462181; 
 Wed, 19 Jun 2024 03:54:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cd24df611sm4921299a12.16.2024.06.19.03.54.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Jun 2024 03:54:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 00/74] Misc patches for 2024-06-19
Date: Wed, 19 Jun 2024 12:54:18 +0200
Message-ID: <20240619105419.49303-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

The following changes since commit 223696363bb117241ad9c2facbff0c474afa4104:

  Merge tag 'edgar/xilinx-queue-2024-06-17.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-06-18 13:08:01 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-20240619

for you to fetch changes up to fc0870c180872d0f40e63507cc6bf8565ffd8d98:

  exec: Make the MemOp enum cast explicit (2024-06-19 12:52:21 +0200)

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
. Constify few uses of IOMMUTLBEvent (Phil)
. Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
. Fix inclusion of tracing headers on s390x/TCG (Phil)
. Add few shortcuts missing to readline (Manos)
. Update ui/display entries in MAINTAINERS (Gerd)
. Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
. Fix Standard VGA screen blanking and cleanups (Gerd)
. Fix USB/MTP reported "free space" value (Fabio)
. Cast size_memop() returned value (Roman)

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

Roman Kiryanov (1):
  exec: Make the MemOp enum cast explicit

 MAINTAINERS                           |   8 +-
 docs/about/deprecated.rst             |   4 +-
 docs/about/removed-features.rst       |   2 +-
 qapi/machine.json                     |  17 ++
 hw/mips/loongson3_bootp.h             |   3 +
 hw/usb/hcd-xhci.h                     |   4 +-
 hw/usb/host.h                         |  44 ----
 include/exec/memop.h                  |   2 +-
 include/exec/memory.h                 |   4 +-
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
 target/i386/cpu.h                     |   3 -
 target/i386/kvm/kvm-cpu.h             |  41 ---
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
 target/i386/cpu.c                     |   2 -
 target/i386/kvm/kvm-cpu.c             |   3 +-
 target/i386/kvm/kvm.c                 |   7 +-
 target/s390x/mmu_helper.c             |  11 +-
 target/s390x/tcg/mem_helper.c         |  16 +-
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
 91 files changed, 743 insertions(+), 1416 deletions(-)
 delete mode 100644 hw/usb/host.h
 delete mode 100644 target/i386/kvm/kvm-cpu.h
 delete mode 100644 hw/intc/loongarch_ipi.c

-- 
2.41.0


