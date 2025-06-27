Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E714C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5p5-0003aY-P4; Fri, 27 Jun 2025 05:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5oz-0003Zl-4t
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5ox-0007TG-29
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751018193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S355JKBbdPhEjZ/KXIkxC3zRQlqLVOr3hO2Q9RhYIZ8=;
 b=aXNZvVkEbnUL8d+ssCWL6nkJ7qwkpRBUq7ZokD23hgSadcQWiQ2KGotGe58uN0JJgq25tl
 KfC6aQQYioTZ/bLt3dW0xBs696V9cWzzC4pPsF9WGxIPRWcZsayPZH6I7eeRoAjKTG4yNs
 oK3wZcb83cRM4FZlZDHK7Cq3OgdY27Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-bRFNCjxFPcOTv0YV2OcCVQ-1; Fri,
 27 Jun 2025 05:56:29 -0400
X-MC-Unique: bRFNCjxFPcOTv0YV2OcCVQ-1
X-Mimecast-MFC-AGG-ID: bRFNCjxFPcOTv0YV2OcCVQ_1751018188
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2678A1944AA5; Fri, 27 Jun 2025 09:56:28 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 822FF19560A7; Fri, 27 Jun 2025 09:56:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v4 00/32] ACPI PCI Hotplug support on ARM
Date: Fri, 27 Jun 2025 11:54:49 +0200
Message-ID: <20250627095620.3300028-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series enables ACPI PCI hotplug/hotunplug on ARM.
It is not enabled by default and ACPI PCI hotplug can
be selected by setting:

-global acpi-ged.acpi-pci-hotplug-with-bridge-support=on

Expected benefits should be similar to those listed in [1],
ie. removal of some racy behaviors, improved latencies.

The infrastructure used in x86 is heavily reused and a
huge part of the series consists in moving code from
hw/i386/acpi-build.c to a generic place and slightly
adapting it to make it usable on ARM. The DSDT table is
augmented to support ACPI PCI hotplug elements.
  
On ARM we use use a GED event to notify the OS about
hotplug events.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v4

previous series:
https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v3
https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v2

History:
v3 -> v4:
- toook into account all comments on v3
- static acpi-index is now supported unconditionally
  from acpi pcihp option. See indiviual patches.
- I hit a problem with ref block generation at
  [19/32] tests/qtest/bios-tables-test: Update ARM DSDT reference
  blobs: despite I regenerate the blobs, I get some errors.
v2 -> v3:
- lot of changes taking into account various feedbacks
  (many thanks to all reviewers). Please refer to
  individual patches for details. Main changes:
  - no more machine option, acpi pci hp is not set by
    default.
  - removal of 2 unused variables in the osc method
  - introduction of GED property to set the bus
  - rework of the init/reset sequence
  - fix virtio-mem-pci hotplug regression
v1 -> v2:
- collected a bunch of R-bs from Gustavo (many thanks!)
- Fixed the breakage of bios-tables-test in TCG mode by
  incorporating Gustavo's patches (part of
  [PATCH 0/5] ACPI tests for PCI Hotplug on ARM
  https://lore.kernel.org/all/20250526053123.1434204-1-gustavo.romero@linaro.org/)
- Tweeked the dsdt aml changes to avoid any dsdt blob difference when
  acpi-pcihp is off.

RFC -> v1:
- First 3 trivial patches were pulled separately
- Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
- addition of aml_pci_edsm which was not called in RFC
- acpi-index feature is now fixed. vms->bus was not set on
  acpi_pcihp_init. The init sequence is still hacky though. Suggestions
  are welcome.

[1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/


Eric Auger (28):
  hw/i386/acpi-build: Make aml_pci_device_dsm() static
  hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
  hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
    acpi_dsdt_add_pci_osc
  hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
  hw/acpi/ged: Add a acpi-pci-hotplug-with-bridge-support property
  hw/pci-host/gpex-acpi: Use GED acpi pcihp property
  hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
  hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
  tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change
  hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
  hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
  hw/i386/acpi-build: Move build_append_notification_callback to pcihp
  hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
    pcihp
  hw/i386/acpi-build: Use AcpiPciHpState::root in acpi_set_pci_info
  hw/i386/acpi-build: Move aml_pci_edsm to a generic place
  hw/arm/virt-acpi-build: Let non hotplug ports support static
    acpi-index
  tests/qtest/bios-tables-test: Update ARM DSDT reference blobs
  hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
    hotplug
  hw/acpi/ged: Add a bus link property
  hw/arm/virt: Pass the bus on the ged creation
  hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
    implementation
  hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
  hw/acpi/ged: Prepare the device to react to PCI hotplug events
  hw/acpi/ged: Support migration of AcpiPciHpState
  hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
  hw/arm/virt: Minor code reshuffling in create_acpi_ged
  hw/arm/virt: Let virt support pci hotplug/unplug GED event
  qtest/bios-tables-test: Create DSDT acpipcihp and hpoffacpiindex
    variant blobs

Gustavo Romero (4):
  tests/qtest/bios-tables-test: Prepare for changes in the DSDT table
  tests/qtest/bios-tables-test: Prepare for changes in the arm virt DSDT
    table
  tests/qtest/bios-tables-test: Prepare for addition of acpi pci hp
    tests
  tests/qtest/bios-tables-test: Add aarch64 ACPI PCI hotplug test

 hw/i386/acpi-build.h                          |   4 -
 include/hw/acpi/generic_event_device.h        |   7 +
 include/hw/acpi/pci.h                         |   5 +-
 include/hw/acpi/pcihp.h                       |  19 +-
 include/hw/arm/virt.h                         |   1 +
 include/hw/pci-host/gpex.h                    |   1 +
 include/hw/sysbus.h                           |   1 +
 hw/acpi/acpi-pci-hotplug-stub.c               |   2 +-
 hw/acpi/generic_event_device.c                |  73 +++
 hw/acpi/ich9.c                                |   7 +-
 hw/acpi/pci-bridge.c                          |  54 ++
 hw/acpi/pci.c                                 |  50 ++
 hw/acpi/pcihp.c                               | 439 ++++++++++++++-
 hw/acpi/piix4.c                               |   5 +-
 hw/arm/virt-acpi-build.c                      |  30 +
 hw/arm/virt.c                                 |  27 +-
 hw/core/sysbus.c                              |  11 +
 hw/i386/acpi-build.c                          | 532 +-----------------
 hw/pci-host/gpex-acpi.c                       |  74 +--
 tests/qtest/bios-tables-test.c                |  52 ++
 hw/arm/Kconfig                                |   2 +
 hw/pci-host/Kconfig                           |   1 +
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5310 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5379 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 0 -> 6294 bytes
 .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 0 -> 5347 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6654 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7768 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5495 bytes
 tests/data/acpi/riscv64/virt/DSDT             | Bin 3576 -> 3538 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
 31 files changed, 790 insertions(+), 607 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex

-- 
2.49.0


