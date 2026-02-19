Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B312E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt576-0008SF-34; Thu, 19 Feb 2026 09:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt573-0008OT-Ut
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt571-0002tt-0X
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:41 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4359a302794so832101f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511677; x=1772116477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S0JjDE11mVwIXFaABEqQvYNM+21Z6KM91LtkR11YKjA=;
 b=nZ6zeLKTSkL0ramphyIGZSVR1oyT0vZ6PKkywuyyFCAJ5c2HYdCfE8gSegtoDzz+WM
 JbJPGAtmdIhOGIz8UEx7HjUnYvsV0YxY7pHc2gKqM7KSscFvbg4N54MI8q0aopw5ZCSc
 nqBl0Gc88lJRC6aw+Wv2hGcTtQo0bqFLe7qjZwG45R3y8DQBUUeD2ktTJ8PQKdcKDYvq
 NwsKtNDDWvfhKwNkNt9MuSHhX8pjR6kuHtvPppaiatDMVqAyv75FYHlp0Y4R9QYHVXlT
 gX8G7nppPSWOZyQGKZJAdy0nF/2NTr/N949n3liLaCxUQ52qujARb3wzsj72tA3khZUb
 a3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511677; x=1772116477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0JjDE11mVwIXFaABEqQvYNM+21Z6KM91LtkR11YKjA=;
 b=XxQJfoejwEYp9erofoB0paCd9zlFStGK+9Q3AqU4Oy9xCA00B0iFSfj5nanKdRIi2m
 wzs8yhbzvWNabrPCZtEV3FV0mw5JIcdH3lXFVRtWpeIeyWtkXWV+uaZvZln6UomoXQJI
 UGyDKc0fEEkSBFs/b+fjh/I+1ESDbZS0LQDx0jyUMeedI69wvrJ41Znwj69WYAu5evwK
 ovTFUnhvXaLkAq2B75Ti7YuoaSl6fM1ORaJMI6e4dnQnhve86b1ZL2jdoYQECovUZQyC
 TicarQEtARYTj0BnHe0anM34N3UeEeFmbHZ/ntOCdbCX8iCTvKdV/78uoF3I3Wc6Ljcb
 uhMg==
X-Gm-Message-State: AOJu0YyiPLqk89AFj86ClhmtAsWWvCMRUBNyw9HFEICxBBu9Iqrnr3Qy
 r1qqcOzsX3SJ4GMrXaJWPxaOWcpgUrKn2hSy1BgdLzePO6SQIzDNG+NRMJnflsEU
X-Gm-Gg: AZuq6aIzU7VwgFLhSOQr1oYj2UbLwp7lNFS3Mkx4ew+VCze9Hv3Eq5WqIZ0Ou+Oihq/
 OehpFQUUTvQdlXTKEnKInf9iJyyf46+4hAw9McmDqTKJlyiv4Y4CRVUzQDz797KB8NPoPies7Pd
 nd9h7+sPtYwi/jsR9Vy1HzomWSZVUBLtPxxTysktekn9ZlQ6tdGoucq5wFlIRKEmrdYXhHGK4Ft
 YGz7pofnBn3mW8HeSsszcYj/jzHzvJyJA28j4KE7P+cE/ciqDl9qIdf3j6SBysGqjX6sbXwJfT6
 +UzuiUUoGaGq939hYwLAF9jz/CXLgzBRfDAdxEBePuj/ROtxELLCJ65UCBb3rUUsF0XUQgNZJid
 2Dr09kFGTolGtQiI37lHpYFo7ZBY7wvsqvNj0i3TOSZs3kP2flsnPRYuNLbHIodY54FZqdHiXQv
 S71cp49d4quS/ewENAYFTDGN8Kr+429+CcxkrQ8CRf0RHAiKcPfz2WbDhFXupTMiNGyw2+
X-Received: by 2002:a5d:64c7:0:b0:437:6dac:4580 with SMTP id
 ffacd0b85a97d-4379dbb0c62mr34908050f8f.62.1771511676469; 
 Thu, 19 Feb 2026 06:34:36 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:35 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 00/33] hw/arm: Introduce generic FDT-driven machine
Date: Thu, 19 Feb 2026 15:32:59 +0100
Message-ID: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42f.google.com
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

Key Features in v2
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
NOTE: GPIO wiring for non-SysBus devices is not supported yet.

Testing
Testing can be performed by two scripts within patch series.
Pre-compiled dtb binaries for tests are currently placed at tests/data/dtb/aarch64/arm-generic-fdt.

The Device Trees sources used for testing can be found by following links:

Hardware DTS (used with -hw-dtb): https://gist.github.com/ruslichenkor/82245d89fb2a64dc7f1b694504cb840e#file-arm64-sbsa-hw-dts

Guest DTS (used with -dtb): https://gist.github.com/ruslichenkor/82245d89fb2a64dc7f1b694504cb840e#file-arm64-sbsa-guest-dts

Also example command to launch VM is following:

/qemu/build/qemu-system-aarch64
	-machine arm-generic-fdt \
	-hw-dtb arm64-sbsa-hw.dtb
	-dtb sbsa-ref.dtb
	-serial mon:stdio \
	-netdev user,id=net0
	-device e1000e,netdev=net0 \
	-device bochs-display \
	-blockdev driver=file,filename=./SBSA_FLASH0.fd,node-name=pflash0 \
	-blockdev driver=file,filename=./SBSA_FLASH1.fd,node-name=pflash1 \
	-device usb-kbd -device usb-tablet \
	-drive file=./alpine-standard-3.23.3-aarch64.iso,if=none,id=cdrom0,readonly=on \
	-device ide-cd,bus=ahci.0,unit=0,drive=cdrom0

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

BR,
Ruslan Ruslichenko

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
  hw/core/fdt_generic_util: initilize qdev properties from fdt
  hw/core/fdt_generic_util: actually realize device
  hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_MMAP
  hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_INTC
  hw/core/fdt_generic_util: implement fdt_get_irq/_info API
  hw/core/fdt_generic_util: map device memory
  hw/core/fdt_generic_util: Connect device irqs
  hw/core/fdt_generic_util: realize cpu clusters
  hw/core: add fdt_generic to the build
  hw/core/machine: add '-hw-dtb' option for machine
  hw/arm: add generic ARM machine initialized by FDT
  hw/core/sysbus: implement FDT_GENERIC_MMAP_CLASS interface
  hw/intc/arm_gic: implement FDT_GENERIC_INTC and fdt support
  target/arm/cpu: add fdt support for armv8-timer
  qom/object: export object_resolve_link()
  system/memory: add setters for MemoryRegion properties
  system/memory: implement FDT_GENERIC_MMAP interface
  hw/core/fdt_generic_util: initialize serial devices
  system/memory: add QOM aliases for fdt support
  hw/intc/arm_gicv3: Implement FDTGenericIntc interface
  hw/core/fdt_generic_util: Add deferred device initialization support
  hw/core/fdt_generic_util: Add blockdev binding support
  hw/pci-host: add gsi-irqs property array
  tests/functional: Add functional tests for arm-generic-fdt machine

 hw/arm/arm_generic_fdt.c                      |  180 +++
 hw/arm/boot.c                                 |    8 +-
 hw/arm/meson.build                            |    2 +
 hw/arm/raspi4b.c                              |    8 +-
 hw/arm/vexpress.c                             |    4 +-
 hw/core/fdt_generic.c                         |  286 ++++
 hw/core/fdt_generic_util.c                    | 1414 +++++++++++++++++
 hw/core/machine.c                             |   19 +
 hw/core/meson.build                           |    2 +
 hw/core/qdev-properties.c                     |   12 +
 hw/core/sysbus.c                              |   28 +
 hw/intc/arm_gic.c                             |   32 +
 hw/intc/arm_gic_common.c                      |   50 +
 hw/intc/arm_gicv3.c                           |   45 +
 hw/intc/arm_gicv3_common.c                    |   68 +
 hw/pci-host/gpex.c                            |    6 +
 include/hw/core/boards.h                      |    1 +
 include/hw/core/fdt_generic.h                 |  135 ++
 include/hw/core/fdt_generic_util.h            |  140 ++
 include/hw/core/qdev-properties.h             |    1 +
 include/hw/pci-host/gpex.h                    |    3 +
 include/qemu/log.h                            |    1 +
 include/qom/object.h                          |   12 +
 include/system/device_tree.h                  |   35 +-
 qemu-options.hx                               |    9 +
 qom/object.c                                  |    2 +-
 system/device_tree.c                          |  237 ++-
 system/memory.c                               |  378 ++++-
 system/vl.c                                   |    3 +
 target/arm/cpu.c                              |  115 ++
 .../arm-generic-fdt/arm64-sbsa-guest.dtb      |  Bin 0 -> 673 bytes
 .../aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb |  Bin 0 -> 5414 bytes
 tests/functional/aarch64/meson.build          |    2 +
 .../aarch64/test_arm_generic_fdt.py           |  114 ++
 .../aarch64/test_arm_generic_fdt_alpine.py    |   61 +
 util/log.c                                    |    1 +
 36 files changed, 3386 insertions(+), 28 deletions(-)
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


