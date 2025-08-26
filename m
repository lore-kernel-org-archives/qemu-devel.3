Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958F1CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsUj-0007ol-Vh; Tue, 26 Aug 2025 08:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsUS-0007kX-NY
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:09:34 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsUJ-00068A-CZ
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756210160; x=1787746160;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=k0ik53LE2h983spFI0XNsXb4damEif6c3PIjZP4j0AA=;
 b=klA89/DH3yBnUCOj3SXqPavEDSym6S81vDUPel4Sn2iXA5CCpU27Wfa0
 PFmozlbyDhfVVohwXlRmUzYua0DJk1DrddijqJ75xv2T1Zafg+qcy3M+n
 qjKMMADRUpFwVmuLhzLCceIOjUdMNOV1rgK0jBjiLqDBuZAbt8oH9qSHd
 awBO2D0T2R+QY2c4B3jka0OZOkwwQDqd/l20rpBY6IiaGu5X1PueWsjwq
 vglRVFE2eDq7UCu0ICRBgyNyZ8A1buEPNK/NMhTty8wWG/ti0Py+sq/Un
 x54z6u4JjfcjScxw7XFbdR3wuxfcUHa9QsnxRtDPFmtb0PFTl7wJa76Zt g==;
X-CSE-ConnectionGUID: QBYQwqqJSriWK+oSNQH1kg==
X-CSE-MsgGUID: j+48BfLQRbi2doLNhirt+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62274601"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62274601"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:09:13 -0700
X-CSE-ConnectionGUID: ASN/2j6BScWQnzmCWg9udA==
X-CSE-MsgGUID: 8Q5r2+1FS9K0s8cwLv2Pfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="173731080"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:09:10 -0700
Message-ID: <cfeb193e-6902-48eb-b8c5-c74b19f1c481@intel.com>
Date: Tue, 26 Aug 2025 20:09:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-16-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-16-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:12 PM, Mark Cave-Ayland wrote:
> PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
> in pc_init1().
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

some nits below, otherwise

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
>   1 file changed, 76 insertions(+), 118 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 49bd1a41e7..a776998504 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -71,7 +71,7 @@
>   
>   #define XEN_IOAPIC_NUM_PIRQS 128ULL
>   
> -#ifdef CONFIG_IDE_ISA
> +#ifdef CONFIG_ISAPC

This seems unrelated to this patch?

>   static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
>   static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>   static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
> @@ -125,6 +125,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>       MemoryRegion *rom_memory = system_memory;
>       ram_addr_t lowmem;
>       uint64_t hole64_size = 0;
> +    PCIDevice *pci_dev;
> +    DeviceState *dev;
> +    size_t i;

Suggest adding

	assert(pcmc->pci_enabled);

like what pc_q35_init() does.

>       /*
>        * Calculate ram split, for memory below and above 4G.  It's a bit
> @@ -195,38 +198,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>           kvmclock_create(pcmc->kvmclock_create_always);
>       }
>   
> -    if (pcmc->pci_enabled) {
> -        pci_memory = g_new(MemoryRegion, 1);
> -        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> -        rom_memory = pci_memory;
> -
> -        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
> -        object_property_add_child(OBJECT(machine), "i440fx", phb);
> -        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
> -                                 OBJECT(ram_memory), &error_fatal);
> -        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
> -                                 OBJECT(pci_memory), &error_fatal);
> -        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
> -                                 OBJECT(system_memory), &error_fatal);
> -        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
> -                                 OBJECT(system_io), &error_fatal);
> -        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
> -                                 x86ms->below_4g_mem_size, &error_fatal);
> -        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
> -                                 x86ms->above_4g_mem_size, &error_fatal);
> -        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
> -                                &error_fatal);
> -        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
> -
> -        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
> -        pci_bus_map_irqs(pcms->pcibus,
> -                         xen_enabled() ? xen_pci_slot_get_pirq
> -                                       : pc_pci_slot_get_pirq);
> -
> -        hole64_size = object_property_get_uint(phb,
> -                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
> -                                               &error_abort);
> -    }
> +    pci_memory = g_new(MemoryRegion, 1);
> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> +    rom_memory = pci_memory;
> +
> +    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
> +    object_property_add_child(OBJECT(machine), "i440fx", phb);
> +    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
> +                                OBJECT(ram_memory), &error_fatal);
> +    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
> +                                OBJECT(pci_memory), &error_fatal);
> +    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
> +                                OBJECT(system_memory), &error_fatal);
> +    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
> +                                OBJECT(system_io), &error_fatal);
> +    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
> +                                x86ms->below_4g_mem_size, &error_fatal);
> +    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
> +                                x86ms->above_4g_mem_size, &error_fatal);
> +    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
> +                            &error_fatal);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
> +
> +    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
> +    pci_bus_map_irqs(pcms->pcibus,
> +                        xen_enabled() ? xen_pci_slot_get_pirq
> +                                    : pc_pci_slot_get_pirq);
> +
> +    hole64_size = object_property_get_uint(phb,
> +                                            PCI_HOST_PROP_PCI_HOLE64_SIZE,
> +                                            &error_abort);
>   
>       /* allocate ram and load rom/bios */
>       if (!xen_enabled()) {
> @@ -242,72 +243,51 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>           }
>       }
>   
> -    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
> -
> -    if (pcmc->pci_enabled) {
> -        PCIDevice *pci_dev;
> -        DeviceState *dev;
> -        size_t i;
> -
> -        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
> -        object_property_set_bool(OBJECT(pci_dev), "has-usb",
> -                                 machine_usb(machine), &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
> -                                 x86_machine_is_acpi_enabled(x86ms),
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
> -                                 &error_abort);
> -        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
> -        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
> -                                 x86_machine_is_smm_enabled(x86ms),
> -                                 &error_abort);
> -        dev = DEVICE(pci_dev);
> -        for (i = 0; i < ISA_NUM_IRQS; i++) {
> -            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
> -        }
> -        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
> -
> -        if (xen_enabled()) {
> -            pci_device_set_intx_routing_notifier(
> -                        pci_dev, piix_intx_routing_notifier_xen);
> -
> -            /*
> -             * Xen supports additional interrupt routes from the PCI devices to
> -             * the IOAPIC: the four pins of each PCI device on the bus are also
> -             * connected to the IOAPIC directly.
> -             * These additional routes can be discovered through ACPI.
> -             */
> -            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
> -                         XEN_IOAPIC_NUM_PIRQS);
> -        }
> +    gsi_state = pc_gsi_create(&x86ms->gsi, true);
> +
> +    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
> +    object_property_set_bool(OBJECT(pci_dev), "has-usb",
> +                                machine_usb(machine), &error_abort);
> +    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
> +                                x86_machine_is_acpi_enabled(x86ms),
> +                                &error_abort);
> +    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
> +                                &error_abort);
> +    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
> +                                &error_abort);
> +    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
> +    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
> +                                x86_machine_is_smm_enabled(x86ms),
> +                                &error_abort);
> +    dev = DEVICE(pci_dev);
> +    for (i = 0; i < ISA_NUM_IRQS; i++) {
> +        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
> +    }
> +    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
>   
> -        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
> -        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
> -                                                              "rtc"));
> -        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
> -        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
> -        pci_ide_create_devs(PCI_DEVICE(dev));
> -        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
> -        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
> -    } else {
> -        uint32_t irq;
> +    if (xen_enabled()) {
> +        pci_device_set_intx_routing_notifier(
> +                    pci_dev, piix_intx_routing_notifier_xen);
>   
> -        isa_bus = isa_bus_new(NULL, system_memory, system_io,
> -                              &error_abort);
> -        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
> +        /*
> +         * Xen supports additional interrupt routes from the PCI devices to
> +         * the IOAPIC: the four pins of each PCI device on the bus are also
> +         * connected to the IOAPIC directly.
> +         * These additional routes can be discovered through ACPI.
> +         */
> +        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
> +                        XEN_IOAPIC_NUM_PIRQS);
> +    }
>   
> -        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
> -        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
> -        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
> -        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
> -                                       &error_fatal);
> -        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
> +    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
> +    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
> +                                                            "rtc"));
> +    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
> +    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
> +    pci_ide_create_devs(PCI_DEVICE(dev));
> +    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
> +    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
>   
> -        i8257_dma_init(OBJECT(machine), isa_bus, 0);
> -        pcms->hpet_enabled = false;
> -    }
>   
>       if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
>           pc_i8259_create(isa_bus, gsi_state->i8259_irq);
> @@ -321,7 +301,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>           x86_register_ferr_irq(x86ms->gsi[13]);
>       }
>   
> -    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
> +    pc_vga_init(isa_bus, pcms->pcibus);
>   
>       /* init basic PC hardware */
>       pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
> @@ -329,28 +309,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>   
>       pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>   
> -#ifdef CONFIG_IDE_ISA
> -    if (!pcmc->pci_enabled) {
> -        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> -        int i;
> -
> -        ide_drive_get(hd, ARRAY_SIZE(hd));
> -        for (i = 0; i < MAX_IDE_BUS; i++) {
> -            ISADevice *dev;
> -            char busname[] = "ide.0";
> -            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
> -                               ide_irq[i],
> -                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
> -            /*
> -             * The ide bus name is ide.0 for the first bus and ide.1 for the
> -             * second one.
> -             */
> -            busname[4] = '0' + i;
> -            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
> -        }
> -    }
> -#endif
> -
>       if (piix4_pm) {
>           smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
>   


