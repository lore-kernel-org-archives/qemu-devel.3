Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F55AC54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebED-0008RI-6X; Mon, 26 Feb 2024 08:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebEA-0008Qh-NV
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:41:07 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebE8-0005L8-IX
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708954865; x=1740490865;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xOERUjUBA55FpSzL1epAsjFSjEkhtvuHM6DIMBxjZK8=;
 b=I63zWZUAca/iDQSYc3TI0E7MHLUlF3qQy4G8dpxYuFPsQ7UkxGXtseVN
 IxXRp9GXFa82mLP5LUu1EC/D3V+QM0+FaAKikddDBX9Dom4c58BFVtN2W
 wcuwnK+ItIHfCo0WMakDCah0jkpjVhAoxF5cD8ukJj1e6MWVBE38r/61a
 KbTWMEPpDD7az5aNqwfuU74rbgSjTNs7QUT06uX0IdfboBYcQ5Nityeil
 /WXrCcOOCJurP1zcKA0R19zismG7bnu/Gb06byFb3ZNCBX+spwspROmJF
 H19YFW8fGKavC7Ai+vdSFiPnEUjkAaHvTJp5U/2/B+OOAbVZPORE5q69i g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3111289"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3111289"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 05:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="44154501"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 26 Feb 2024 05:40:57 -0800
Date: Mon, 26 Feb 2024 21:54:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 01/10] hw/i386: Store pointers to IDE buses in
 PCMachineState
Message-ID: <ZdyYH1IwzaE+A4Cq@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Feb 20, 2024 at 04:06:13PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:13 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 01/10] hw/i386: Store pointers to IDE buses in
>  PCMachineState
> X-Mailer: git-send-email 2.34.1
> 
> Add the two IDE bus BusState pointers to the set we keep in PCMachineState.
> This allows us to avoid passing them to pc_cmos_init(), and also will
> allow a refactoring of how we call pc_cmos_init_late().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/i386/pc.h |  4 +++-
>  hw/i386/pc.c         |  5 ++---
>  hw/i386/pc_piix.c    | 16 +++++++---------
>  hw/i386/pc_q35.c     |  9 ++++-----
>  4 files changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ec0e5efcb28..8f8ac894b10 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -17,6 +17,8 @@
>  
>  #define HPET_INTCAP "hpet-intcap"
>  
> +#define MAX_IDE_BUS 2
> +
>  /**
>   * PCMachineState:
>   * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
> @@ -37,6 +39,7 @@ typedef struct PCMachineState {
>      PFlashCFI01 *flash[2];
>      ISADevice *pcspk;
>      DeviceState *iommu;
> +    BusState *idebus[MAX_IDE_BUS];
>  
>      /* Configuration options: */
>      uint64_t max_ram_below_4g;
> @@ -182,7 +185,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>                            bool create_fdctrl,
>                            uint32_t hpet_irqs);
>  void pc_cmos_init(PCMachineState *pcms,
> -                  BusState *ide0, BusState *ide1,
>                    ISADevice *s);
>  void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 196827531a5..8b0f54e284c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -574,7 +574,6 @@ static void pc_cmos_init_late(void *opaque)
>  }
>  
>  void pc_cmos_init(PCMachineState *pcms,
> -                  BusState *idebus0, BusState *idebus1,
>                    ISADevice *rtc)
>  {
>      int val;
> @@ -634,8 +633,8 @@ void pc_cmos_init(PCMachineState *pcms,
>  
>      /* hard drives and FDC */
>      arg.rtc_state = s;
> -    arg.idebus[0] = idebus0;
> -    arg.idebus[1] = idebus1;
> +    arg.idebus[0] = pcms->idebus[0];
> +    arg.idebus[1] = pcms->idebus[1];
>      qemu_register_reset(pc_cmos_init_late, &arg);
>  }
>  
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 999b7b806ca..8df88a6ccd1 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -68,7 +68,6 @@
>  #include "kvm/kvm-cpu.h"
>  #include "target/i386/cpu.h"
>  
> -#define MAX_IDE_BUS 2
>  #define XEN_IOAPIC_NUM_PIRQS 128ULL
>  
>  #ifdef CONFIG_IDE_ISA
> @@ -114,7 +113,6 @@ static void pc_init1(MachineState *machine,
>      Object *piix4_pm = NULL;
>      qemu_irq smi_irq;
>      GSIState *gsi_state;
> -    BusState *idebus[MAX_IDE_BUS];
>      ISADevice *rtc_state;
>      MemoryRegion *ram_memory;
>      MemoryRegion *pci_memory = NULL;
> @@ -299,8 +297,8 @@ static void pc_init1(MachineState *machine,
>          piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
>          dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
>          pci_ide_create_devs(PCI_DEVICE(dev));
> -        idebus[0] = qdev_get_child_bus(dev, "ide.0");
> -        idebus[1] = qdev_get_child_bus(dev, "ide.1");
> +        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
> +        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
>      } else {
>          isa_bus = isa_bus_new(NULL, system_memory, system_io,
>                                &error_abort);
> @@ -312,8 +310,8 @@ static void pc_init1(MachineState *machine,
>  
>          i8257_dma_init(OBJECT(machine), isa_bus, 0);
>          pcms->hpet_enabled = false;
> -        idebus[0] = NULL;
> -        idebus[1] = NULL;
> +        pcms->idebus[0] = NULL;
> +        pcms->idebus[1] = NULL;
>      }
>  
>      if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
> @@ -342,7 +340,7 @@ static void pc_init1(MachineState *machine,
>      pc_nic_init(pcmc, isa_bus, pci_bus);
>  
>      if (pcmc->pci_enabled) {
> -        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> +        pc_cmos_init(pcms, rtc_state);
>      }
>  #ifdef CONFIG_IDE_ISA
>      else {
> @@ -361,9 +359,9 @@ static void pc_init1(MachineState *machine,
>               * second one.
>               */
>              busname[4] = '0' + i;
> -            idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
> +            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>          }
> -        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> +        pc_cmos_init(pcms, rtc_state);
>      }
>  #endif
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d346fa3b1d6..71402c36eb2 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -126,7 +126,6 @@ static void pc_q35_init(MachineState *machine)
>      PCIBus *host_bus;
>      PCIDevice *lpc;
>      DeviceState *lpc_dev;
> -    BusState *idebus[MAX_SATA_PORTS];
>      ISADevice *rtc_state;
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *system_io = get_system_io();
> @@ -300,13 +299,13 @@ static void pc_q35_init(MachineState *machine)
>                                                           ICH9_SATA1_FUNC),
>                                                 "ich9-ahci");
>          ich9 = ICH9_AHCI(pdev);
> -        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
> -        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
> +        pcms->idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
> +        pcms->idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
>          g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
>          ide_drive_get(hd, ich9->ahci.ports);
>          ahci_ide_create_devs(&ich9->ahci, hd);
>      } else {
> -        idebus[0] = idebus[1] = NULL;
> +        pcms->idebus[0] = pcms->idebus[1] = NULL;
>      }
>  
>      if (machine_usb(machine)) {
> @@ -327,7 +326,7 @@ static void pc_q35_init(MachineState *machine)
>          smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>      }
>  
> -    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> +    pc_cmos_init(pcms, rtc_state);
>  
>      /* the rest devices to which pci devfn is automatically assigned */
>      pc_vga_init(isa_bus, host_bus);
> -- 
> 2.34.1
> 
> 

