Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66939D11702
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSro-0004oB-9C; Tue, 02 Dec 2025 11:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSrO-0004iO-8c; Tue, 02 Dec 2025 11:04:17 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSrL-00066J-8q; Tue, 02 Dec 2025 11:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764691451; x=1796227451;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gl+I3qRUk/2kD6tcKA1cj0SEcivTN17lu7FLN59Ycg4=;
 b=oJFm/X4Yq0Yyb6HtMxeuFJo6LuFvH9vGsibsO3YQ8RleFmIGjLppPhPD
 AG1bGIa3a1PIjPx7hp99UchPhhkrRb7WMkbS8fumWIW6iP+x7z8RqAvFC
 Auxd06n0fPVqbCwSvVvf8xiO8owM/BC+42wYhAIH9uJQulMBi7pt0PwSD
 0y9DAIYUwyGn5I2nok0xTsCbwO7qxGmbRbSG4Oedf/lVwwKHNjLheaALP
 Wa0GDeY0UbRos6Rloi45pnatRNvddPFcQvrwSY7ae/rm7LDkGBCbjB61o
 XOCORlF2llV9X3sPv5Zocn33OoO5znQsheh9tZdaHVmvxd/UzACSV2ki9 g==;
X-CSE-ConnectionGUID: varC3Z0bTNuj1G7RYpVjYQ==
X-CSE-MsgGUID: e17FVQ9eRpy5mp9h9XwicA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92142170"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="92142170"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:04:08 -0800
X-CSE-ConnectionGUID: bzzD33gAS+6lPd5xdA7mbA==
X-CSE-MsgGUID: IhCA6L4sQFiUFoTfizwXUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="199536863"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 08:03:59 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 00/28] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
Date: Wed,  3 Dec 2025 00:28:07 +0800
Message-Id: <20251202162835.3227894-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

A brief introduction from Philippe's v4:

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated three releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.6 and 2.7 machines removal,
as it is a big enough number of LoC removed. Rest will
follow.

This v5 is based on the master branch at the commit 66ec38b6fa59
("Merge tag 'pull-target-arm-20251201' of https://gitlab.com/pm215/qemu
into staging").

(Main) changes since v4:
 * Completely remove the legacy CPU hotplug approach.
   - New patch 2-8.
   - Test CPU hot-plug & hot-unplug via qmp.

 * Keep "dma_enabled" property in fw_cfg_io_properties[] since Sun4u &
   Sun4v are still using it.
   - About more details, please see commit message of patch 15.

 * Temporarily keep these properties: "cpuid-0xb" (of X86CPU),
   "fill-mtrr-mask" (of X86CPU), "version" (of IOAPICCommonState).
   - These properties will be deprecated first before removal, in
     another series.

 * Keep "l3-cache" (of X86CPU) and "page-per-vq" (of VirtIOPCIProxy),
   since they are still in use (e.g., libvirt).

Thank you everyone for the reviews and patience, and also thank you
Philippe for the guidance and Igor for the patch.

Best Regards,
Zhao
---
Igor Mammedov (3):
  tests/acpi: Allow DSDT table change for x86 machines
  pc: Start with modern CPU hotplug interface by default
  acpi: Remove legacy cpu hotplug utilities

Philippe Mathieu-Daudé (22):
  hw/i386/pc: Remove deprecated pc-q35-2.6 and pc-i440fx-2.6 machines
  hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug field
  hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with '_nodma' suffix
  hw/mips/loongson3_virt: Prefer using fw_cfg_init_mem_nodma()
  hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
  hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
    fw_cfg_init_mem_dma()
  hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
  hw/i386/pc: Remove multiboot.bin
  hw/i386: Assume fw_cfg DMA is always enabled
  hw/i386: Remove linuxboot.bin
  hw/i386/pc: Remove pc_compat_2_6[] array
  hw/intc/apic: Remove APICCommonState::legacy_instance_id field
  hw/core/machine: Remove hw_compat_2_6[] array
  hw/virtio/virtio-mmio: Remove
    VirtIOMMIOProxy::format_transport_address field
  hw/i386/pc: Remove deprecated pc-q35-2.7 and pc-i440fx-2.7 machines
  hw/i386/pc: Remove pc_compat_2_7[] array
  target/i386/cpu: Remove CPUX86State::full_cpuid_auto_level field
  hw/audio/pcspk: Remove PCSpkState::migrate field
  hw/core/machine: Remove hw_compat_2_7[] array
  hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
  hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features
    field
  hw/char/virtio-serial: Do not expose the 'emergency-write' property

Zhao Liu (3):
  docs/specs/acpi_cpu_hotplug: Remove legacy cpu hotplug descriptions
  tests/acpi: Update DSDT tables for pc machine
  tests/acpi: Update DSDT tables for q35 machine

 docs/specs/acpi_cpu_hotplug.rst               |  28 +-
 hw/acpi/acpi-cpu-hotplug-stub.c               |  19 +-
 hw/acpi/cpu.c                                 |  10 -
 hw/acpi/cpu_hotplug.c                         | 348 ------------------
 hw/acpi/generic_event_device.c                |   1 +
 hw/acpi/ich9.c                                |  61 +--
 hw/acpi/meson.build                           |   2 +-
 hw/acpi/piix4.c                               |  61 +--
 hw/arm/virt.c                                 |   2 +-
 hw/audio/pcspk.c                              |  10 -
 hw/char/virtio-serial-bus.c                   |   9 +-
 hw/core/machine.c                             |  17 -
 hw/hppa/machine.c                             |   2 +-
 hw/i386/acpi-build.c                          |   7 +-
 hw/i386/fw_cfg.c                              |  16 +-
 hw/i386/intel_iommu.c                         |   5 +-
 hw/i386/microvm.c                             |   3 -
 hw/i386/multiboot.c                           |   7 +-
 hw/i386/pc.c                                  |  25 +-
 hw/i386/pc_piix.c                             |  23 --
 hw/i386/pc_q35.c                              |  24 --
 hw/i386/x86-common.c                          |   8 +-
 hw/i386/x86.c                                 |   2 -
 hw/intc/apic_common.c                         |   5 -
 hw/loongarch/fw_cfg.c                         |   4 +-
 hw/loongarch/virt-acpi-build.c                |   1 -
 hw/mips/loongson3_virt.c                      |   2 +-
 hw/nvram/fw_cfg.c                             |  22 +-
 hw/riscv/virt.c                               |   4 +-
 hw/virtio/virtio-mmio.c                       |  15 -
 hw/virtio/virtio-pci.c                        |   5 +-
 include/hw/acpi/cpu.h                         |   1 -
 include/hw/acpi/cpu_hotplug.h                 |  40 --
 include/hw/acpi/ich9.h                        |   4 +-
 include/hw/acpi/piix4.h                       |   4 +-
 include/hw/boards.h                           |   6 -
 include/hw/i386/apic_internal.h               |   1 -
 include/hw/i386/intel_iommu.h                 |   1 -
 include/hw/i386/pc.h                          |   9 -
 include/hw/i386/x86.h                         |   2 -
 include/hw/nvram/fw_cfg.h                     |   9 +-
 include/hw/virtio/virtio-mmio.h               |   1 -
 include/hw/virtio/virtio-pci.h                |   1 -
 include/hw/virtio/virtio-serial.h             |   2 -
 pc-bios/meson.build                           |   2 -
 pc-bios/multiboot.bin                         | Bin 1024 -> 0 bytes
 pc-bios/optionrom/Makefile                    |   2 +-
 pc-bios/optionrom/linuxboot.S                 | 195 ----------
 pc-bios/optionrom/multiboot.S                 | 232 ------------
 pc-bios/optionrom/multiboot_dma.S             | 234 +++++++++++-
 pc-bios/optionrom/optionrom.h                 |   4 -
 target/i386/cpu.c                             | 111 +++---
 target/i386/cpu.h                             |   3 -
 tests/data/acpi/x86/pc/DSDT                   | Bin 8611 -> 8598 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8522 -> 8509 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9936 -> 9923 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15482 -> 15469 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9075 -> 9062 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10265 -> 10252 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8562 -> 8549 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5100 -> 5087 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8683 -> 8670 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9970 -> 9957 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8469 -> 8456 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8617 -> 8604 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12404 -> 12391 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8440 -> 8427 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8457 -> 8444 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9765 -> 9752 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12650 -> 12637 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8719 -> 8706 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8486 -> 8473 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12053 -> 12040 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12998 -> 12985 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33855 -> 33842 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8904 -> 8891 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13231 -> 13218 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10094 -> 10081 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8515 -> 8502 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8528 -> 8515 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8457 -> 8444 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9799 -> 9786 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9570 -> 9557 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13293 -> 13280 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8302 -> 8289 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8298 -> 8285 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8446 -> 8433 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8541 -> 8528 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12998 -> 12985 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33855 -> 33842 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9046 -> 9033 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9072 -> 9059 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18674 -> 18661 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14697 -> 14684 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35803 -> 35790 bytes
 tests/qtest/test-x86-cpuid-compat.c           |  11 -
 96 files changed, 359 insertions(+), 1264 deletions(-)
 delete mode 100644 hw/acpi/cpu_hotplug.c
 delete mode 100644 include/hw/acpi/cpu_hotplug.h
 delete mode 100644 pc-bios/multiboot.bin
 delete mode 100644 pc-bios/optionrom/linuxboot.S
 delete mode 100644 pc-bios/optionrom/multiboot.S

-- 
2.34.1


