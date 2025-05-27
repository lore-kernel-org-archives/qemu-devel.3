Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F84C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJoyW-0001Xt-Dm; Tue, 27 May 2025 03:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoxW-0000ht-Cl
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoxN-00005t-0z
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VYdJRHhX8fm5rqQ85jtoqV7RbpM+0kpirv5uP+BgoFI=;
 b=dhcE+YvJbdtj5hcKvnx6c2L9YkEbFE67K78mrNcKM4zuvzB8sdURPum87tnJbxmBRK6aa5
 7ULwgrbHbxfvmPtyf/vCv8hU0PIUgzYjdZExOmM8UwufjAUBatG7qlYlz56lcGCHzUh/ju
 9+MewN/2xacVKgT28iRzOxrZsUwGqFI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-XOU3yxJWNge8Vh10Sy4lGQ-1; Tue,
 27 May 2025 03:42:35 -0400
X-MC-Unique: XOU3yxJWNge8Vh10Sy4lGQ-1
X-Mimecast-MFC-AGG-ID: XOU3yxJWNge8Vh10Sy4lGQ_1748331753
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 799EC180056F; Tue, 27 May 2025 07:42:33 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96CF719560AA; Tue, 27 May 2025 07:42:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 00/25] ACPI PCI Hotplug support on ARM
Date: Tue, 27 May 2025 09:40:02 +0200
Message-ID: <20250527074224.1197793-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series enables ACPI PCI hotplug/hotunplug on ARM
and makes it default for 10.1 machine type. This aligns with
x86 q35 machine. Expected benefits should be similar to
those listed in [1], ie. removal of some racy behaviors,
improved latencies.

It is still possible to disable it using a virt machine
option: virt,acpi-pcihp=off and restore the legacy behavior.

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
https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v2

previous series:
https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v1

History:
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


Eric Auger (22):
  hw/i386/acpi-build: Make aml_pci_device_dsm() static
  hw/arm/virt: Introduce machine state acpi pcihp flags and props
  hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
  hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
    acpi_dsdt_add_pci_osc
  hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
  hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine
    downto gpex
  hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
  hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
  hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
  hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
  hw/i386/acpi-build: Move build_append_notification_callback to pcihp
  hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
    pcihp
  hw/i386/acpi-build: Introduce and use acpi_get_pci_host
  hw/i386/acpi-build: Move aml_pci_edsm to a generic place
  hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
    hotplug
  hw/acpi/ged: Prepare the device to react to PCI hotplug events
  hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
    implementation
  hw/acpi/ged: Support migration of AcpiPciHpState
  hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
  hw/arm/virt: Let virt support pci hotplug/unplug GED event
  hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
  hw/arm/virt: Use ACPI PCI hotplug by default

Gustavo Romero (3):
  tests/qtest/bios-tables-test: Prepare for changes in the DSDT table
  tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change
  tests/qtest/bios-tables-test: Keep ACPI PCI hotplug off

 hw/i386/acpi-build.h                          |   4 -
 include/hw/acpi/aml-build.h                   |   2 +
 include/hw/acpi/generic_event_device.h        |   7 +
 include/hw/acpi/pci.h                         |   4 +-
 include/hw/acpi/pcihp.h                       |  19 +-
 include/hw/arm/virt.h                         |   4 +
 include/hw/pci-host/gpex.h                    |   1 +
 include/hw/sysbus.h                           |   1 +
 hw/acpi/aml-build.c                           |  50 ++
 hw/acpi/generic_event_device.c                |  54 ++
 hw/acpi/pci.c                                 |  20 +
 hw/acpi/pcihp.c                               | 482 ++++++++++++++-
 hw/arm/virt-acpi-build.c                      |  23 +
 hw/arm/virt.c                                 | 107 +++-
 hw/core/sysbus.c                              |  11 +
 hw/i386/acpi-build.c                          | 552 +-----------------
 hw/pci-host/gpex-acpi.c                       |  75 +--
 tests/qtest/bios-tables-test.c                |  13 +-
 hw/arm/Kconfig                                |   2 +
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5170 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5256 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6531 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7627 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5372 bytes
 24 files changed, 812 insertions(+), 619 deletions(-)

-- 
2.49.0


