Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834C1C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWd4-0002ba-Th; Mon, 26 Feb 2024 03:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWd3-0002b9-VU
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:46:29 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWd1-0000OS-VG
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708937188; x=1740473188;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VELNa9s31lV8M3/meRGyZIK73J8vxwFi/ZmTbYrOvrI=;
 b=BDAiP0czKEve7hfinCi10RVzDLONlI/dVuENqieZhIhWO76jNXlttuL8
 +236Lwo/oshBVXPjQLnTfm4Rl9iBJJ/68T0H6FBkId4BcZrpPFfUkysAC
 cJy9IkdwDX944Sl19bRgvG/mq46Qh9Q0Z+3h8ZLjPsdc0vXBRNhj6gh0C
 qZBS0uYC2oUrPoYtsViq5swmEjZVI2V/jd86blquQU/aNcHVrVttJqieA
 +G9lKzXAS76I4QfxHZd+pBy3Lgy6fz1yjaK7cCPmjJL9HjIeFK8tGiIL3
 ZGn66mQB1vqEwFZHph00Bas/GS5XJ7hnF4qw6T2jgamGA/fbuHd4CJddc g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20753646"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="20753646"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11313196"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2024 00:46:23 -0800
Date: Mon, 26 Feb 2024 17:00:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 3/6] hw/i386/pc_{piix, q35}: Eliminate local
 pci_bus/pci_host variables
Message-ID: <ZdxTFI2uHA/efhCE@intel.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-4-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224135851.100361-4-shentey@gmail.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

On Sat, Feb 24, 2024 at 02:58:48PM +0100, Bernhard Beschow wrote:
> Date: Sat, 24 Feb 2024 14:58:48 +0100
> From: Bernhard Beschow <shentey@gmail.com>
> Subject: [PATCH v2 3/6] hw/i386/pc_{piix, q35}: Eliminate local
>  pci_bus/pci_host variables
> X-Mailer: git-send-email 2.44.0
> 
> There is no advantage in having these local variables which 1/ needlessly have
> different identifiers in both machines and 2/ which are redundant to pcms->bus
> which is almost as short.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/pc_piix.c | 14 ++++++--------
>  hw/i386/pc_q35.c  | 16 +++++++---------
>  2 files changed, 13 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3393b93007..814d24326d 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -108,7 +108,6 @@ static void pc_init1(MachineState *machine,
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *system_io = get_system_io();
>      Object *phb = NULL;
> -    PCIBus *pci_bus = NULL;
>      ISABus *isa_bus;
>      Object *piix4_pm = NULL;
>      qemu_irq smi_irq;
> @@ -212,11 +211,10 @@ static void pc_init1(MachineState *machine,
>                                  &error_fatal);
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>  
> -        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
> -        pci_bus_map_irqs(pci_bus,
> +        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
> +        pci_bus_map_irqs(pcms->pcibus,
>                           xen_enabled() ? xen_pci_slot_get_pirq
>                                         : pc_pci_slot_get_pirq);
> -        pcms->pcibus = pci_bus;
>  
>          hole64_size = object_property_get_uint(phb,
>                                                 PCI_HOST_PROP_PCI_HOLE64_SIZE,
> @@ -261,7 +259,7 @@ static void pc_init1(MachineState *machine,
>          for (i = 0; i < ISA_NUM_IRQS; i++) {
>              qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
>          }
> -        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
> +        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
>  
>          if (xen_enabled()) {
>              pci_device_set_intx_routing_notifier(
> @@ -273,7 +271,7 @@ static void pc_init1(MachineState *machine,
>               * connected to the IOAPIC directly.
>               * These additional routes can be discovered through ACPI.
>               */
> -            pci_bus_irqs(pci_bus, xen_intx_set_irq, pci_dev,
> +            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
>                           XEN_IOAPIC_NUM_PIRQS);
>          }
>  
> @@ -310,7 +308,7 @@ static void pc_init1(MachineState *machine,
>          x86_register_ferr_irq(x86ms->gsi[13]);
>      }
>  
> -    pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
> +    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
>  
>      assert(pcms->vmport != ON_OFF_AUTO__MAX);
>      if (pcms->vmport == ON_OFF_AUTO_AUTO) {
> @@ -321,7 +319,7 @@ static void pc_init1(MachineState *machine,
>      pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
>                           0x4);
>  
> -    pc_nic_init(pcmc, isa_bus, pci_bus);
> +    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>  
>  #ifdef CONFIG_IDE_ISA
>      if (!pcmc->pci_enabled) {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 734d9bedb2..2fa4efb52f 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -122,7 +122,6 @@ static void pc_q35_init(MachineState *machine)
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      X86MachineState *x86ms = X86_MACHINE(machine);
>      Object *phb;
> -    PCIBus *host_bus;
>      PCIDevice *lpc;
>      DeviceState *lpc_dev;
>      ISADevice *rtc_state;
> @@ -216,8 +215,7 @@ static void pc_q35_init(MachineState *machine)
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>  
>      /* pci */
> -    host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
> -    pcms->pcibus = host_bus;
> +    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
>  
>      /* irq lines */
>      gsi_state = pc_gsi_create(&x86ms->gsi, true);
> @@ -231,7 +229,7 @@ static void pc_q35_init(MachineState *machine)
>      for (i = 0; i < IOAPIC_NUM_PINS; i++) {
>          qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
>      }
> -    pci_realize_and_unref(lpc, host_bus, &error_fatal);
> +    pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
>  
>      rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
>  
> @@ -283,7 +281,7 @@ static void pc_q35_init(MachineState *machine)
>          AHCIPCIState *ich9;
>  
>          /* ahci and SATA device, for q35 1 ahci controller is built-in */
> -        pdev = pci_create_simple_multifunction(host_bus,
> +        pdev = pci_create_simple_multifunction(pcms->pcibus,
>                                                 PCI_DEVFN(ICH9_SATA1_DEV,
>                                                           ICH9_SATA1_FUNC),
>                                                 "ich9-ahci");
> @@ -297,14 +295,14 @@ static void pc_q35_init(MachineState *machine)
>  
>      if (machine_usb(machine)) {
>          /* Should we create 6 UHCI according to ich9 spec? */
> -        ehci_create_ich9_with_companions(host_bus, 0x1d);
> +        ehci_create_ich9_with_companions(pcms->pcibus, 0x1d);
>      }
>  
>      if (pcms->smbus_enabled) {
>          PCIDevice *smb;
>  
>          /* TODO: Populate SPD eeprom data.  */
> -        smb = pci_create_simple_multifunction(host_bus,
> +        smb = pci_create_simple_multifunction(pcms->pcibus,
>                                                PCI_DEVFN(ICH9_SMB_DEV,
>                                                          ICH9_SMB_FUNC),
>                                                TYPE_ICH9_SMB_DEVICE);
> @@ -316,8 +314,8 @@ static void pc_q35_init(MachineState *machine)
>      pc_cmos_init(pcms, rtc_state);
>  
>      /* the rest devices to which pci devfn is automatically assigned */
> -    pc_vga_init(isa_bus, host_bus);
> -    pc_nic_init(pcmc, isa_bus, host_bus);
> +    pc_vga_init(isa_bus, pcms->pcibus);
> +    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>  
>      if (machine->nvdimms_state->is_enabled) {
>          nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> -- 
> 2.44.0
> 
> 

