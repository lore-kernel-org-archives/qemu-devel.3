Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D2CC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 13:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZrB2-00012A-GS; Thu, 10 Jul 2025 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZrB0-00011g-7A
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZrAv-0006Iu-7w
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752153532;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ieMhORgfmBBG5bBepU3cdNb5NDHvXS83Yq3AyCv89us=;
 b=ZMDpDD/mOTJ91qVJMdoMmaf1UaSCFrct7ka1iaXL+upg0IqipdSCAn7YOKClgZH/BlObXx
 7nWqaoHrTxu7OoSXO8mgXFfHiXTcQvOaeENKxK7lRt2Fr6gI0WeTPidZmrBlZu6B237lD5
 A3w6gNoGxMJnN+dqLYXoCPEXZ54PgIA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-avyE6EIEOKKB25iACzYQjQ-1; Thu, 10 Jul 2025 09:18:51 -0400
X-MC-Unique: avyE6EIEOKKB25iACzYQjQ-1
X-Mimecast-MFC-AGG-ID: avyE6EIEOKKB25iACzYQjQ_1752153530
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so419788f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 06:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752153530; x=1752758330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ieMhORgfmBBG5bBepU3cdNb5NDHvXS83Yq3AyCv89us=;
 b=EGULDqGlHdw/oAbhgDb/PXPkeAMBbHkC17t8rDFsO1TefzWf+qq1aP7yxGzYJulY59
 Ye4XYqYw/qPYKn3W41Npv+FT0n7korX3I2u79v/xgq3s6AUwbIzA+xzjSrGFQPUgof3c
 oCZVvqRPPJgr7/+VIRLJMZ5QftF+3bIA//cqtAjOrt94l7j2bl3u4R4h8nErpucINY3T
 7gI/Ku/GH4J5zXWwJ1b6xpEKKrA1svTLsSSP3gKNzrOXnNa8cxDTbl+in3VW0BKwvssZ
 Lpcplql77Ftln0wOm9u+U5ARtwtKiIMKlY9vSA1bRNBj7C+lJAY1rhzEZ7hNyTn/vrzq
 Ryug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzRqCFR770WXR4sC7+6FuRaBeB8VK+UsxpWupmlX9kyq7MQuotosJUKmthjbJF00oWAfas4+ayNnNJ@nongnu.org
X-Gm-Message-State: AOJu0YwuBs8n9RnbUXDxnct2zG5oZ+WWCBfn5LUbRbgGmMhsdrSkdTIw
 3aE977paBD73/BRaH1m/p/0gckhtQSNCVCUJV9eJcqCL2PJdCIc/vLd3mwYZHDu+xUVcwQAp9M8
 JbnDBWDXCRezN/EgVNVS+W86REtkddkD2L9YY9VQDE07kbiGhvbbFxKfh
X-Gm-Gg: ASbGncv+0dxE5sc1rOISSPXTWDmluO2yLh9EkzeVRFoJbF8QQPu6FTfh7KLrioM0bU5
 9Jy2ylOidDn7nzmw6Fh/FESEY/VyfLca9ENbSH//Hw9yryV/p31drdy4Vx6UgpbZKvvJ/b3fS02
 LuvHBdRJr5JxkQggmCq0Bt857AHWXtLMyxA8E/i7C5flF45kX1cL14ShmT2ErSnzcPqLceouSdK
 ox9eMK5/0kGSEyiRp3bZK3L6eVBqMUO/D4BID2PK7MIw4q/E/ch8TwLtonr9Qjda1/q1NOgOsfp
 5zY17j20SFfr3Sf/yPRKNS60tsUvVfAAZSlR/3IyNqOUz4QX5mEyqQtkyh0TKzb0cHRZlQ==
X-Received: by 2002:a05:6000:4715:b0:3b4:9dfa:b7 with SMTP id
 ffacd0b85a97d-3b5e8680fc3mr2720204f8f.25.1752153529969; 
 Thu, 10 Jul 2025 06:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqXAx5V0pJSsGUWbduhEEiuSrqgT3gBuQhwQfHhPeMnEeDjcBr6sSfpXGU6YgGZaC1pridvw==
X-Received: by 2002:a05:6000:4715:b0:3b4:9dfa:b7 with SMTP id
 ffacd0b85a97d-3b5e8680fc3mr2720160f8f.25.1752153529477; 
 Thu, 10 Jul 2025 06:18:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26ff9sm1847174f8f.93.2025.07.10.06.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 06:18:48 -0700 (PDT)
Message-ID: <bc2625dc-ac1b-4ac3-99ea-a82ee2b48c9f@redhat.com>
Date: Thu, 10 Jul 2025 15:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/36] ACPI PCI Hotplug support on ARM
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250708142437.1344644-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708142437.1344644-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Michael,

On 7/8/25 4:22 PM, Eric Auger wrote:
> This series enables ACPI PCI hotplug/hotunplug on ARM.
> It is not enabled by default and ACPI PCI hotplug can
> be selected by setting: 
>
> -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
>
> Expected benefits should be similar to those listed in [1],
> ie. removal of some racy behaviors, improved latencies.
>
> The infrastructure used in x86 is heavily reused and a
> huge part of the series consists in moving code from
> hw/i386/acpi-build.c to a generic place and slightly
> adapting it to make it usable on ARM. The DSDT table is 
> augmented to support ACPI PCI hotplug elements.
>
> On ARM we use use a GED event to notify the OS about
> hotplug events.

This morning Peter applied several series on target-arm.next and
9d8ade51a20d ("hw/arm/virt: Basic CXL enablement on pci_expander_bridge
instances pxb-cxl")
introduced a minor context conflict with my series  (with
hw/pci-host/gpex-acpi: Use GED acpi pcihp property),
in hw/arm/virt-acpi-build.c. This is straightforward to fix.

I have a branch where this conflict is resolved
https://github.com/eauger/qemu.git
arm-acpi-pcihp-v6-on-target-arm.next
6a8c8f69a0  hw/pci-host/gpex-acpi: Use GED acpi pcihp property

Please let me know if you want me to respin

Eric

>
> Best Regards
>
> Eric
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v6
>
> previous series:
> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v5
>
> History:
> v5 -> v6:
> - collected Jonathan's R-bs
> - cropped last 2 patch commit messages (Jonathan)
>
> v4 -> v5:
> - Collected Jonathan's R-bs (many thanks!)
> - fixed the tests/qtest/bios-tables-test issue by
>   creating a variant for the viot test
> - use the 3 phase reset API
> - fixed qom-test failures that were due to unconditionnal
>   fetches of the GED property
>
> v3 -> v4:
> - toook into account all comments on v3
> - static acpi-index is now supported unconditionally
>   from acpi pcihp option. See indiviual patches.
> - I hit a problem with ref block generation at
>   [19/32] tests/qtest/bios-tables-test: Update ARM DSDT reference
>   blobs: despite I regenerate the blobs, I get some errors.
>
> v2 -> v3:
> - lot of changes taking into account various feedbacks
>   (many thanks to all reviewers). Please refer to
>   individual patches for details. Main changes:
>   - no more machine option, acpi pci hp is not set by
>     default.
>   - removal of 2 unused variables in the osc method
>   - introduction of GED property to set the bus
>   - rework of the init/reset sequence
>   - fix virtio-mem-pci hotplug regression
>
> v1 -> v2:
> - collected a bunch of R-bs from Gustavo (many thanks!)
> - Fixed the breakage of bios-tables-test in TCG mode by
>   incorporating Gustavo's patches (part of
>   [PATCH 0/5] ACPI tests for PCI Hotplug on ARM
>   https://lore.kernel.org/all/20250526053123.1434204-1-gustavo.romero@linaro.org/)
> - Tweeked the dsdt aml changes to avoid any dsdt blob difference when
>   acpi-pcihp is off.
>
> RFC -> v1:
> - First 3 trivial patches were pulled separately
> - Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
> - addition of aml_pci_edsm which was not called in RFC
> - acpi-index feature is now fixed. vms->bus was not set on
>   acpi_pcihp_init. The init sequence is still hacky though. Suggestions
>   are welcome.
>
> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
>
>
> Eric Auger (32):
>   hw/i386/acpi-build: Make aml_pci_device_dsm() static
>   hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>   hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
>     acpi_dsdt_add_pci_osc
>   hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>   hw/acpi/ged: Add a acpi-pci-hotplug-with-bridge-support property
>   hw/pci-host/gpex-acpi: Use GED acpi pcihp property
>   hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>   hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change
>   hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>   hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>   hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>   hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
>     pcihp
>   hw/i386/acpi-build: Use AcpiPciHpState::root in acpi_set_pci_info
>   hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>   qtest/bios-tables-test: Prepare for fixing the aarch64 viot test
>   qtest/bios-tables-test: Add a variant to the aarch64 viot test
>   qtest/bios-tables-test: Generate DSDT.viot
>   hw/arm/virt-acpi-build: Let non hotplug ports support static
>     acpi-index
>   tests/qtest/bios-tables-test: Update ARM DSDT reference blobs
>   hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
>     hotplug
>   hw/acpi/ged: Add a bus link property
>   hw/arm/virt: Pass the bus on the ged creation
>   hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
>     implementation
>   hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
>   hw/acpi/ged: Prepare the device to react to PCI hotplug events
>   hw/acpi/ged: Support migration of AcpiPciHpState
>   hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>   hw/arm/virt: Minor code reshuffling in create_acpi_ged
>   hw/arm/virt: Let virt support pci hotplug/unplug GED event
>   qtest/bios-tables-test: Generate reference blob for
>     DSDT.hpoffacpiindex
>   qtest/bios-tables-test: Generate reference blob for DSDT.acpipcihp
>
> Gustavo Romero (4):
>   tests/qtest/bios-tables-test: Prepare for changes in the DSDT table
>   tests/qtest/bios-tables-test: Prepare for changes in the arm virt DSDT
>     table
>   tests/qtest/bios-tables-test: Prepare for addition of acpi pci hp
>     tests
>   tests/qtest/bios-tables-test: Add aarch64 ACPI PCI hotplug test
>
>  hw/i386/acpi-build.h                          |   4 -
>  include/hw/acpi/generic_event_device.h        |  17 +-
>  include/hw/acpi/pci.h                         |   5 +-
>  include/hw/acpi/pcihp.h                       |  17 +-
>  include/hw/arm/virt.h                         |   1 +
>  include/hw/pci-host/gpex.h                    |   1 +
>  include/hw/sysbus.h                           |   1 +
>  hw/acpi/acpi-pci-hotplug-stub.c               |   2 +-
>  hw/acpi/generic_event_device.c                |  77 +++
>  hw/acpi/ich9.c                                |   7 +-
>  hw/acpi/pci-bridge.c                          |  54 ++
>  hw/acpi/pci.c                                 |  50 ++
>  hw/acpi/pcihp.c                               | 439 ++++++++++++++-
>  hw/acpi/piix4.c                               |   5 +-
>  hw/arm/virt-acpi-build.c                      |  38 ++
>  hw/arm/virt.c                                 |  27 +-
>  hw/core/sysbus.c                              |  11 +
>  hw/i386/acpi-build.c                          | 532 +-----------------
>  hw/pci-host/gpex-acpi.c                       |  74 +--
>  tests/qtest/bios-tables-test.c                |  53 ++
>  hw/arm/Kconfig                                |   2 +
>  hw/pci-host/Kconfig                           |   1 +
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5293 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5379 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 0 -> 6202 bytes
>  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 0 -> 5347 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6654 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7768 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5495 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 0 -> 5310 bytes
>  tests/data/acpi/riscv64/virt/DSDT             | Bin 3576 -> 3538 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
>  32 files changed, 811 insertions(+), 607 deletions(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.viot
>


