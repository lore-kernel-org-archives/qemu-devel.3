Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2191DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 23:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEyXG-00022O-6Z; Fri, 31 Oct 2025 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEyXE-00022B-NU
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 19:27:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEyX5-00052B-LF
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 19:27:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 63D5D5972FE;
 Sat, 01 Nov 2025 00:27:38 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id VBh9SqrYgvWJ; Sat,  1 Nov 2025 00:27:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 438925972E8; Sat, 01 Nov 2025 00:27:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 412415972E4;
 Sat, 01 Nov 2025 00:27:36 +0100 (CET)
Date: Sat, 1 Nov 2025 00:27:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5] hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug
 field
In-Reply-To: <20251031142825.179239-1-imammedo@redhat.com>
Message-ID: <4b92d159-1bcd-5672-977f-6741a9d26c8f@eik.bme.hu>
References: <20250508133550.81391-3-philmd@linaro.org>
 <20251031142825.179239-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-192398665-1761953256=:97242"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-192398665-1761953256=:97242
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 31 Oct 2025, Igor Mammedov wrote:
> For compatibility reasons PC/Q35 will start with legacy
> CPU hotplug interface by default but with new CPU hotplug
> AML code since 2.7 machine type. That way legacy firmware
> that doesn't use QEMU generated ACPI tables was able to
> continue using legacy CPU hotplug interface.
>
> While later machine types, with firmware supporting QEMU
> provided ACPI tables, generate new CPU hotplug AML,
> which will switch to new CPU hotplug interface when
> guest OS executes its _INI method on ACPI tables
> loading.
>
> Since 2.6 machine type is now gone, drop legacy CPU hotplug
> code (both ACPI and related hardware bits) and initialize
> 'modern' hotplug from the very beginning.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   PS:
>   it does compile but I do not remember if I've actually tested hotplug path
>
> ---
> include/hw/acpi/cpu.h                       |   1 -
> include/hw/acpi/cpu_hotplug.h               |  37 ------
> include/hw/acpi/ich9.h                      |   3 -
> include/hw/acpi/piix4.h                     |   4 +-
> tests/qtest/bios-tables-test-allowed-diff.h |  42 +++++++
> hw/acpi/acpi-cpu-hotplug-stub.c             |  18 +--
> hw/acpi/cpu.c                               |  10 --
> hw/acpi/cpu_hotplug.c                       | 118 --------------------
> hw/acpi/generic_event_device.c              |   1 +
> hw/acpi/ich9.c                              |  61 ++--------
> hw/acpi/meson.build                         |   2 +-
> hw/acpi/piix4.c                             |  60 ++--------
> hw/i386/acpi-build.c                        |   4 +-
> hw/i386/pc.c                                |   3 +-
> hw/i386/pc_piix.c                           |   2 -
> hw/i386/pc_q35.c                            |   2 -
> hw/i386/x86-common.c                        |   1 -
> hw/loongarch/virt-acpi-build.c              |   1 -
> 18 files changed, 65 insertions(+), 305 deletions(-)
> delete mode 100644 include/hw/acpi/cpu_hotplug.h
> delete mode 100644 hw/acpi/cpu_hotplug.c
>
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 32654dc274..2cb0ca4f3d 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -54,7 +54,6 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>
> typedef struct CPUHotplugFeatures {
>     bool acpi_1_compatible;
> -    bool has_legacy_cphp;
>     bool fw_unplugs_cpu;
>     const char *smi_path;
> } CPUHotplugFeatures;
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> deleted file mode 100644
> index aeee630cf0..0000000000
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/*
> - * QEMU ACPI hotplug utilities
> - *
> - * Copyright (C) 2013 Red Hat Inc
> - *
> - * Authors:
> - *   Igor Mammedov <imammedo@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - */
> -
> -#ifndef HW_ACPI_CPU_HOTPLUG_H
> -#define HW_ACPI_CPU_HOTPLUG_H
> -
> -#include "hw/acpi/acpi.h"
> -#include "hw/acpi/pc-hotplug.h"
> -#include "hw/acpi/aml-build.h"
> -#include "hw/hotplug.h"
> -#include "hw/acpi/cpu.h"
> -
> -typedef struct AcpiCpuHotplug {
> -    Object *device;
> -    MemoryRegion io;
> -    uint8_t sts[ACPI_GPE_PROC_LEN];
> -} AcpiCpuHotplug;
> -
> -void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
> -                             AcpiCpuHotplug *g, DeviceState *dev, Error **errp);
> -
> -void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
> -                                  AcpiCpuHotplug *gpe_cpu, uint16_t base);
> -
> -void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
> -                                CPUHotplugState *cpuhp_state,
> -                                uint16_t io_port);
> -#endif
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 245fe08dc2..5a1986edbd 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -22,7 +22,6 @@
> #define HW_ACPI_ICH9_H
>
> #include "hw/acpi/acpi.h"
> -#include "hw/acpi/cpu_hotplug.h"
> #include "hw/acpi/cpu.h"
> #include "hw/acpi/pcihp.h"
> #include "hw/acpi/memory_hotplug.h"
> @@ -53,8 +52,6 @@ typedef struct ICH9LPCPMRegs {
>     uint32_t pm_io_base;
>     Notifier powerdown_notifier;
>
> -    bool cpu_hotplug_legacy;
> -    AcpiCpuHotplug gpe_cpu;
>     CPUHotplugState cpuhp_state;
>
>     bool keep_pci_slot_hpc;
> diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
> index eb1c122d80..863382a814 100644
> --- a/include/hw/acpi/piix4.h
> +++ b/include/hw/acpi/piix4.h
> @@ -24,11 +24,11 @@
>
> #include "hw/pci/pci_device.h"
> #include "hw/acpi/acpi.h"
> -#include "hw/acpi/cpu_hotplug.h"
> #include "hw/acpi/memory_hotplug.h"
> #include "hw/acpi/pcihp.h"
> #include "hw/i2c/pm_smbus.h"
> #include "hw/isa/apm.h"
> +#include "hw/acpi/cpu.h"
>
> #define TYPE_PIIX4_PM "PIIX4_PM"
> OBJECT_DECLARE_SIMPLE_TYPE(PIIX4PMState, PIIX4_PM)
> @@ -63,8 +63,6 @@ struct PIIX4PMState {
>     uint8_t disable_s4;
>     uint8_t s4_val;
>
> -    bool cpu_hotplug_legacy;
> -    AcpiCpuHotplug gpe_cpu;
>     CPUHotplugState cpuhp_state;
>
>     MemHotplugState acpi_memory_hotplug;
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..7191854857 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,43 @@

Does this belong here?

> /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/pc/DSDT",
> +"tests/data/acpi/x86/q35/DSDT",
> +"tests/data/acpi/x86/pc/DSDT.bridge",
> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> +"tests/data/acpi/x86/pc/DSDT.cphp",
> +"tests/data/acpi/x86/pc/DSDT.numamem",
> +"tests/data/acpi/x86/pc/DSDT.nohpet",
> +"tests/data/acpi/x86/pc/DSDT.memhp",
> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> +"tests/data/acpi/x86/pc/DSDT.acpierst",
> +"tests/data/acpi/x86/pc/DSDT.roothp",
> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
> +"tests/data/acpi/x86/q35/DSDT.bridge",
> +"tests/data/acpi/x86/q35/DSDT.noacpihp",
> +"tests/data/acpi/x86/q35/DSDT.multi-bridge",
> +"tests/data/acpi/x86/q35/DSDT.ipmibt",
> +"tests/data/acpi/x86/q35/DSDT.cphp",
> +"tests/data/acpi/x86/q35/DSDT.numamem",
> +"tests/data/acpi/x86/q35/DSDT.nohpet",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
> +"tests/data/acpi/x86/q35/DSDT.memhp",
> +"tests/data/acpi/x86/q35/DSDT.dimmpxm",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat",
> +"tests/data/acpi/x86/q35/DSDT.mmio64",
> +"tests/data/acpi/x86/q35/DSDT.acpierst",
> +"tests/data/acpi/x86/q35/DSDT.applesmc",
> +"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
> +"tests/data/acpi/x86/q35/DSDT.ivrs",
> +"tests/data/acpi/x86/q35/DSDT.type4-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count2",
> +"tests/data/acpi/x86/q35/DSDT.thread-count",
> +"tests/data/acpi/x86/q35/DSDT.thread-count2",
> +"tests/data/acpi/x86/q35/DSDT.viot",
> +"tests/data/acpi/x86/q35/DSDT.cxl",
> +"tests/data/acpi/x86/q35/DSDT.ipmismbus",
> +"tests/data/acpi/x86/q35/DSDT.xapic",

Regards,
BALATON Zoltan
--3866299591-192398665-1761953256=:97242--

