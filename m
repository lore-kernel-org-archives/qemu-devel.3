Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6515ED6AB18
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q1w-0008BW-12; Thu, 02 Apr 2026 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q1u-0008AU-55
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:46 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q1q-00070n-O1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66bb66db39dso2176741a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167001; x=1775771801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4PObQlThuLE5ltMUSrHMUcDNoBf7hiETI6gYFqvbHmc=;
 b=rxnBhLSG48eYlcUcw47MhzYF1ROU1uWDMTvWEN+W45o2UuCLZ+VLW5GfE91HFDeTCy
 dPM7LxDoC7FZoHcGKq1DSHxVnUie3qFA3bWMnFFsEi2kWulbMvwO8MCqnXD6XwKIeill
 IVGBu4JyYQtcRGGhNUwBpZgY9XIzdNaiqehbUooK5sH+op8svhsvneKE1lp7qiUw7+dZ
 j1aoLwCJsagefRBG4i0tEQ16FH+/89U/hxrvtTXYgveh0X7bcUHWzKXFKrHfPmyIgUYo
 66qgyZDNm338dSNdIgtdRy4+HkxBBYgwDrHfw+KdD/Y6wrB6LjRNx2ZWIEhrt/3UAI3z
 JXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167001; x=1775771801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PObQlThuLE5ltMUSrHMUcDNoBf7hiETI6gYFqvbHmc=;
 b=ORCk3m8V1T13/MHqlXN9jh2S2f0SP/Y5tbP2PNETDk5WxhPIalde72LqaffIkJfQUG
 9A7b+UxxyGwSY+qXxcPTWSKDXwOYebFP7+DC88rY2eI1wTMxcit7qWk4WkA/om2u8tib
 a+Y9So20yd++vMNy3iIYpKrPmVBaA7TGQCpbMxxEpMTc/qEAd1Sl0nDhieMR31ukkbQD
 CctZPa/EpLQKivtij0cFxfmRE2OwzpA+kUbAqABr3eRPA9ubonp6/PMotXo86W2alPvy
 pnMq46zRG2lbzS4E9wOBPgWMIz2XUZF4JrgwM7MaQm3HLkaSsrwnQYv+VghJzuMhn/by
 JSIw==
X-Gm-Message-State: AOJu0Yx5zsz883kgiRLveN2S5UlzQN17DnkwdFap+93z5SRYj0RMULEt
 GAWbdK2tt5PIxBuXyC3nze9i1Sk12bl9VABlxkspQegoVgm+yUAMsU1YIcO21Cxr
X-Gm-Gg: ATEYQzzFSZRA55U6/VrUJp0pMRYpF7seHEJKZDgmiRoubLVNzHe282tma/quEz23NYN
 a/y7uJ1sEduBZpCQdyNLlg5XDzA50ImmMKC7XDN5rG02OQ/0QuQSIvlR12UCaCACVhwYJERWfAb
 7C4QPf566oUalds+q+IHMyqkR/PJ594epkscDhvrRfP9kZL5Qpw6ivC+RhAA93YaK7PWFWPPDpN
 QlMZprQ978qmtSAU+Xq1orW/2VCTW/d240jYu0EYtJbyQwi7WRNrdOA6Gtol+XLulCx9ltRoDXr
 unXwKVVGLu0gk3GIFXoflC8lI6MLMGYdBqbs0TwH/JGTTB+IuiD+6vyPyF/CrE/Pi+5BCVDFAr1
 FOVVM9uHzUYzZwzdIe/vd5dPzsj6eOWQzBWQ3DMSbv73ludd/oHw2mUyNnX1sFT7g3es8aaSeHy
 jJdzQZNU9OdDycYNmI6EVliMYxCSTorDQIwBdeTi4Vud+QHESjL69pCIkwa8AONa3+BlVyFA==
X-Received: by 2002:a17:907:1b09:b0:b9b:5164:906b with SMTP id
 a640c23a62f3a-b9c672ae620mr22658566b.6.1775167000206; 
 Thu, 02 Apr 2026 14:56:40 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:39 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 00/33] hw/arm: Introduce generic FDT-driven machine
Date: Thu,  2 Apr 2026 23:55:45 +0200
Message-ID: <20260402215629.745866-1-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

This patch series introduces a new ARM machine model, arm-generic-fdt, and the underlying infrastructure required
to instantiate a QEMU machine entirely from a Device Tree.

Updates in v3:
- Added support for binding host memory backends.
- Simplified the main qdev initialization logic.
- Reworked logging withing the FDT framework.
- Moved the 'hw-dtb' parameter to be a machine option.
- Addressed other comments from v2.

Updates in v2:
This version add support for an sbsa-ref compatible platform. Major additions include:

GICv3: via the FDTGenericIntc interface.
GPEX PCI Host: Dynamic mapping of MMIO windows via aliases and irq routing via a new gsi-irqs property.
Block Devices: New support for binding QEMU block backends to FDT nodes using blockdev.
Testing: Added two new functional tests ensuring the machine can boot successfully similar sbsa-ref platform.

Also addressed comments received in v1.

Origin & Motivation
This feature originates from the AMD QEMU repository (https://github.com/Xilinx/qemu).

Currently, adding support for a new ARM board in QEMU requires writing a dedicated C source file to define the memory map,
instantiate devices, and wire interrupts. Any modification to the board configuration requires a corresponding change in
the source code and a rebuild of the QEMU binary.

This series introduces an alternative approach: defining the board configuration via a Device Tree Blob (DTB) provided at
the command line. The new arm-generic-fdt machine parses this DTB at runtime to dynamically construct the system topology.

Beyond providing more flexible board creation, this infrastructure is a prerequisite for enabling Hardware Co-Simulation
workflows (e.g., using the Remote-Port protocol: https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg01760.html).
In mixed simulation environments where QEMU emulates the CPU subsystem and an external simulator (such as SystemC) handles
custom logic, the memory map and interrupt lines often need to change dynamically based on the external hardware configuration,
making static C models impractical.

Implementation Overview
The series implements an FDT loading framework in hw/core/fdt_generic_util.c capable of:

Parsing and creating device models from FDT nodes.
Setting QOM properties based on FDT properties.
Connecting IRQs for SysBus devices (via FDTGenericIntc).
Mapping memory regions for IO devices or system RAM (via FDTGenericMMap).
Attaching block devices specified via blockdev interface.
NOTE: GPIO wiring for non-SysBus devices is not supported.

Testing
Testing can be performed by two scripts within patch series.
Pre-compiled dtb binaries for tests are currently placed at tests/data/dtb/aarch64/arm-generic-fdt.

The Device Trees to emulate VM similar sources used for testing can be found by following links:

Hardware DTS: https://gist.github.com/ruslichenkor/82245d89fb2a64dc7f1b694504cb840e#file-arm64-sbsa-hw-dts
Guest DTS: https://gist.github.com/ruslichenkor/82245d89fb2a64dc7f1b694504cb840e#file-arm64-sbsa-guest-dts

Example command to launch a VM similar to SBSA-ref:

/qemu/build/qemu-system-aarch64 \
        --machine arm-generic-fdt,hw-dtb=arm64-sbsa-hw.dtb \
        -dtb arm64-sbsa-guest.dtb \
        -serial mon:stdio \
        -netdev user,id=net0 \
        -device e1000e,netdev=net0 \
        -device bochs-display \
        -blockdev driver=file,filename=./SBSA_FLASH0.fd,node-name=pflash0 \
        -blockdev driver=file,filename=./SBSA_FLASH1.fd,node-name=pflash1 \
        -device usb-kbd -device usb-tablet \
        -drive file=./alpine-standard-3.23.3-aarch64.iso,if=none,id=cdrom0,readonly=on \
        -device ide-cd,bus=ahci.0,unit=0,drive=cdrom0

Also it is possible to run simple ARM64 VM with direct kernel boot.
The example device tree for minimal VM machine can be found here:

Hardware DTS: https://gist.github.com/ruslichenkor/19a1b7d937dbf889190e670cb677e43e#file-arm64-virt-hw-dts
Guest DTS: https://gist.github.com/ruslichenkor/19a1b7d937dbf889190e670cb677e43e#file-arm64-virt-guest-dts

Example command for direct kernel boot:

./qemu-system-aarch64 \
    -machine arm-generic-fdt,hw-dtb=arm64-virt-hw.dtb \
    -dtb arm64-virt-guest.dtb \
    -cpu cortex-a57 -smp 4 -m 256 \
    -drive id=disk0,file=./core-image-minimal-qemuarm64.rootfs-20251218190831.ext4,if=none,format=raw \
    -device virtio-blk-device,drive=disk0 \
    -kernel ./Image \
    -nographic \
    -append 'root=/dev/vda console=ttyAMA0 mem=256M swiotlb=0 '

Open Questions
Location of Test Binaries:
I have added the compiled Device Tree Blobs (DTB) required for the functional tests into tests/data/dtb.

Question: Is this the preferred location for static test binaries, or should they be placed elsewhere?

Patch Summary
hw/core: Add Generic FDT parsing infrastructure and utility functions (fdt_generic_util)
hw/arm: Add the arm-generic-fdt machine model
hw/core/sysbus: Add IO memory mapping for standard SysBus devices
system/memory: Allow MemoryRegions to be configured from FDT
hw/intc: Add FDT support for ARM GICv3 (IRQ translation and default wiring)
hw/pci-host: Add gsi-irqs property for INTx mapping
target/arm: Add FDT support for CPU timers

Ruslan Ruslichenko (33):
  system/device_tree: update qemu_fdt_getprop_cell
  system/device_tree: add few parsing and traversal helpers
  util/log: add log entry for fdt generic utils
  hw/core: introduce generic FDT device model registry
  hw/core/fdt_generic: implement FDT machine creation helpers
  hw/core/fdt_generic: add cpu clusters management
  hw/core/fdt_generic_util: implement main fdt parse routine
  hw/core/fdt_generic_util: implement fdt_init_qdev
  qdev: Add qdev_prop_get_array_elem_type() helper
  qom/object: export object_resolve_link()
  hw/core/fdt_generic_util: initilize qdev properties from fdt
  hw/core/fdt_generic_util: actually realize device
  hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_MMAP
  hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_INTC
  hw/core/fdt_generic_util: implement fdt_get_irq/_info API
  hw/core/fdt_generic_util: map device memory regions
  hw/core/fdt_generic_util: Connect device irqs
  hw/core/fdt_generic_util: realize cpu clusters
  hw/core: add fdt_generic to the build
  hw/arm: add generic ARM machine initialized by FDT
  hw/arm/arm_generic_fdt: Add support for host-backed RAM regions
  hw/core/sysbus: implement FDT_GENERIC_MMAP_CLASS interface
  hw/intc/arm_gic: implement FDT_GENERIC_INTC and fdt support
  target/arm/cpu: add fdt support for armv8-timer
  system/memory: add setters for MemoryRegion properties
  system/memory: implement FDT_GENERIC_MMAP interface
  hw/core/fdt_generic_util: initialize serial devices
  system/memory: add QOM aliases for fdt support
  hw/intc/arm_gicv3: Implement FDTGenericIntc interface
  hw/core/fdt_generic_util: Add deferred device initialization support
  hw/core/fdt_generic_util: Add blockdev binding support
  hw/pci-host: add gsi-irqs property array
  tests/functional: Add functional tests for arm-generic-fdt machine

 hw/arm/arm_generic_fdt.c                      |  266 ++++
 hw/arm/boot.c                                 |    8 +-
 hw/arm/meson.build                            |    2 +
 hw/arm/raspi4b.c                              |    8 +-
 hw/arm/vexpress.c                             |    4 +-
 hw/core/fdt_generic.c                         |  259 ++++
 hw/core/fdt_generic_util.c                    | 1194 +++++++++++++++++
 hw/core/meson.build                           |    2 +
 hw/core/qdev-properties.c                     |   12 +
 hw/core/sysbus.c                              |   28 +
 hw/intc/arm_gic.c                             |   32 +
 hw/intc/arm_gic_common.c                      |   50 +
 hw/intc/arm_gicv3.c                           |   45 +
 hw/intc/arm_gicv3_common.c                    |   68 +
 hw/pci-host/gpex.c                            |    6 +
 include/hw/core/fdt_generic.h                 |  134 ++
 include/hw/core/fdt_generic_util.h            |  145 ++
 include/hw/core/qdev-properties.h             |    1 +
 include/hw/pci-host/gpex.h                    |    3 +
 include/qemu/log.h                            |    1 +
 include/qom/object.h                          |   12 +
 include/system/device_tree.h                  |   27 +-
 qom/object.c                                  |    2 +-
 system/device_tree.c                          |  210 ++-
 system/memory.c                               |  357 ++++-
 target/arm/cpu.c                              |  112 ++
 .../arm-generic-fdt/arm64-sbsa-guest.dtb      |  Bin 0 -> 673 bytes
 .../aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb |  Bin 0 -> 5290 bytes
 tests/functional/aarch64/meson.build          |    2 +
 .../aarch64/test_arm_generic_fdt.py           |  114 ++
 .../aarch64/test_arm_generic_fdt_alpine.py    |   61 +
 util/log.c                                    |    1 +
 32 files changed, 3138 insertions(+), 28 deletions(-)
 create mode 100644 hw/arm/arm_generic_fdt.c
 create mode 100644 hw/core/fdt_generic.c
 create mode 100644 hw/core/fdt_generic_util.c
 create mode 100644 include/hw/core/fdt_generic.h
 create mode 100644 include/hw/core/fdt_generic_util.h
 create mode 100644 tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-guest.dtb
 create mode 100644 tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb
 create mode 100755 tests/functional/aarch64/test_arm_generic_fdt.py
 create mode 100755 tests/functional/aarch64/test_arm_generic_fdt_alpine.py

-- 
2.43.0


