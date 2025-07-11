Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FB9C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEAz-0002ZE-HK; Fri, 11 Jul 2025 09:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaE6N-0007RZ-Q1
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaE6K-0001Pn-8q
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752241663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yj6hkJFvA8GA0GXwsYYlxejPO5E27MCPPSp2AT+TBAQ=;
 b=eEBVoHOLl2eFngiiQM2XY77cdZa0JmNebTmJZZjq5b8oinhjiwmtO2+NC61kGX8x58/A8r
 t/x8sRmcLMef0pUyBPfs46SEqn2CPPPeFCHoI2mkXjEJOygcoZdDJQp0uHtDLNQY0beSeP
 Ou1Gzmnng3LKz142qOsUOx9lwuI3B0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-vPmKCVoPOWCax6o95561HQ-1; Fri, 11 Jul 2025 09:47:41 -0400
X-MC-Unique: vPmKCVoPOWCax6o95561HQ-1
X-Mimecast-MFC-AGG-ID: vPmKCVoPOWCax6o95561HQ_1752241660
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450df53d461so16609305e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752241660; x=1752846460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yj6hkJFvA8GA0GXwsYYlxejPO5E27MCPPSp2AT+TBAQ=;
 b=KKEn8fEaIH1QsZu7tH9CxrC90sJfW025PY2aVomFwJHHi+a1+HcrvpqlcsXiRUTA27
 kvqwLFA1esyD/58+vzm7sFyAEOct6xe12CflYbuI6obtwULvLeFfb5qvaoet06V6zpVS
 g+CIfwZ0oZ61GkzYg3Xzo8g0KZfcLnHaX+uQBk6nC2jbhDhsoacaLIwbmwjuBd31T2ue
 GN7Di8otFErIobYR3MZVpm/hQkVsWjgtouhcrBCcaXMx/gPluWPK4ohmHF6sEIxTroij
 IpzBfN2Wa8Ko1GrmKBzPi+WY7wVwB0adzvCyqR4KH6VGAfpHPWWsTvYE9ARxf/B2EtyL
 6nIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoPKvbQGvjgnOAEkZAsOscSY8Uib3vqCpx8OjimpaGdppJ4VVx/+hfUp8/E2aCXDPJPtmWBFZ1h9Lk@nongnu.org
X-Gm-Message-State: AOJu0Yws/ZDN/lwa+sKO7sDxNKAykfLUKdkA8d9PnNvwD3lLIKI1JdK2
 UjaFQ6uQGxypR6JnuEzrZKyneWSWKEGktFo7GMhGnlBEWUn4n8o/fB6ew6XTeEzXUtnx44Pds7w
 6orzUtsJjuWdANCZ8TLuHLVmbfdXg1WU9tNSCWDvSEQDq3DzN54ktdyJw
X-Gm-Gg: ASbGncu6mGJ23qmtiO1PeivL7Ibjww/NX4Cu6IEY3Mwp0XWUDTRI4k5/Uvf4naQ1s7U
 71OAvXXghw6/x+GsPuwIvteB8y+D1Q7gNsT6dLn3ZvvX+RjJDMtGbnPq8YGi5SYEjoQCu9sbYIz
 2Qu4Vj2AzB16ixl41i7AJWrq8KV6Fi5bGTDt3s3IOBDFowai8npmAb3VaTfr+36QUxXcO/3ADgS
 lH4RdBNMc9rStD+EIMFEsmmjQDs7q0LkaN9Peb6AIUTp7mJKacPmpmijNtIiGFMu38F6c7Gymqc
 2gJjNPtQiz+V2vx4K/4pFrunuN2flw==
X-Received: by 2002:a05:600c:138d:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-454ec15f7bcmr31987195e9.12.1752241660228; 
 Fri, 11 Jul 2025 06:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjUrP35NvNJ7t7MbQclBI+fV2/g6snvBeNzKdYNqTDFYFC87IgW6LMRN1didX+WGy4F5PcKw==
X-Received: by 2002:a05:600c:138d:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-454ec15f7bcmr31986865e9.12.1752241659751; 
 Fri, 11 Jul 2025 06:47:39 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd485059sm102619115e9.0.2025.07.11.06.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:47:39 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:47:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v6 00/36] ACPI PCI Hotplug support on ARM
Message-ID: <20250711154738.1da27e78@fedora>
In-Reply-To: <20250708142437.1344644-1-eric.auger@redhat.com>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue,  8 Jul 2025 16:22:42 +0200
Eric Auger <eric.auger@redhat.com> wrote:

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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


