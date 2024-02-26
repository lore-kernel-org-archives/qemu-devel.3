Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717CDC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWoM-0003PJ-KW; Mon, 26 Feb 2024 03:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWoL-0003P5-0z
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:58:09 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWoI-0002MF-3i
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708937886; x=1740473886;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kUqIkPJ14Gl4qquGCiY20Z/DBb7sZ+e0EVZNBMiPFZs=;
 b=YS2QjyLmoKlxZzz5lBdpxFeAqPv7vvxGwxI4wVdwoOLIuAVbxwb3yqFn
 0FO1n86OOWSMC6nnPLJdSYn0qMhe/Hw4rbKjH2rVpzTJChmTqjHsV2SY8
 Nx/V+weg83mMVIiL7IFnHlNPZ/B0ipnBG1LBmG4+WtoObC/A/rWwMjo6/
 XnVpedjoxf6KmW3Gxh318W/1TVqVa4gnDGtV8FuQmEbXEckt6bK+p4bVr
 hKqjXqEjo2rLVu7chTVDAC9j8gpDxA99s1a9CMCwbNMqZyXx6NqcMNZGu
 oWpv+3tohDqBRfEyBal0eU3Z31QM88caSpYWLzB+V7EtO6YEHJdwlCqc2 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14644352"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="14644352"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="37600389"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2024 00:57:59 -0800
Date: Mon, 26 Feb 2024 17:11:41 +0800
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
Subject: Re: [PATCH v2 5/6] hw/i386/pc: Populate RTC attribute directly
Message-ID: <ZdxVzaa5gp8wS/gz@intel.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-6-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224135851.100361-6-shentey@gmail.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Sat, Feb 24, 2024 at 02:58:50PM +0100, Bernhard Beschow wrote:
> Date: Sat, 24 Feb 2024 14:58:50 +0100
> From: Bernhard Beschow <shentey@gmail.com>
> Subject: [PATCH v2 5/6] hw/i386/pc: Populate RTC attribute directly
> X-Mailer: git-send-email 2.44.0
> 
> Both the piix and the q35 machines introduce an rtc_state variable and defer the
> initialization of the X86MachineState::rtc attribute to pc_cmos_init(). Resolve
> this complication which makes pc_cmos_init() do what it says on the tin.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/pc.c      |  8 --------
>  hw/i386/pc_piix.c | 15 +++++++--------
>  hw/i386/pc_q35.c  |  7 +++----
>  3 files changed, 10 insertions(+), 20 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index a80f809b83..880e95de26 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -611,14 +611,6 @@ void pc_cmos_init(PCMachineState *pcms,
>      mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
>      mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
>  
> -    object_property_add_link(OBJECT(pcms), "rtc_state",
> -                             TYPE_ISA_DEVICE,
> -                             (Object **)&x86ms->rtc,
> -                             object_property_allow_set_link,
> -                             OBJ_PROP_LINK_STRONG);
> -    object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
> -                             &error_abort);
> -
>      set_boot_dev(s, MACHINE(pcms)->boot_config.order, &error_fatal);
>  
>      val = 0;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 49d5d48db9..ce6aad758d 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -112,7 +112,6 @@ static void pc_init1(MachineState *machine,
>      Object *piix4_pm = NULL;
>      qemu_irq smi_irq;
>      GSIState *gsi_state;
> -    ISADevice *rtc_state;
>      MemoryRegion *ram_memory;
>      MemoryRegion *pci_memory = NULL;
>      MemoryRegion *rom_memory = system_memory;
> @@ -276,8 +275,8 @@ static void pc_init1(MachineState *machine,
>          }
>  
>          isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
> -        rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
> -                                                             "rtc"));
> +        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
> +                                                              "rtc"));
>          piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
>          dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
>          pci_ide_create_devs(PCI_DEVICE(dev));
> @@ -288,9 +287,9 @@ static void pc_init1(MachineState *machine,
>                                &error_abort);
>          isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>  
> -        rtc_state = isa_new(TYPE_MC146818_RTC);
> -        qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
> -        isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
> +        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
> +        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
> +        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>  
>          i8257_dma_init(OBJECT(machine), isa_bus, 0);
>          pcms->hpet_enabled = false;
> @@ -316,7 +315,7 @@ static void pc_init1(MachineState *machine,
>      }
>  
>      /* init basic PC hardware */
> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, true,
>                           0x4);
>  
>      pc_nic_init(pcmc, isa_bus, pcms->pcibus);
> @@ -343,7 +342,7 @@ static void pc_init1(MachineState *machine,
>      }
>  #endif
>  
> -    pc_cmos_init(pcms, rtc_state);
> +    pc_cmos_init(pcms, x86ms->rtc);
>  
>      if (piix4_pm) {
>          smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 2fa4efb52f..e0b3f55a02 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -124,7 +124,6 @@ static void pc_q35_init(MachineState *machine)
>      Object *phb;
>      PCIDevice *lpc;
>      DeviceState *lpc_dev;
> -    ISADevice *rtc_state;
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *system_io = get_system_io();
>      MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
> @@ -231,7 +230,7 @@ static void pc_q35_init(MachineState *machine)
>      }
>      pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
>  
> -    rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
> +    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
>  
>      object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
>                               TYPE_HOTPLUG_HANDLER,
> @@ -273,7 +272,7 @@ static void pc_q35_init(MachineState *machine)
>      }
>  
>      /* init basic PC hardware */
> -    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
> +    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_floppy,
>                           0xff0104);
>  
>      if (pcms->sata_enabled) {
> @@ -311,7 +310,7 @@ static void pc_q35_init(MachineState *machine)
>          smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>      }
>  
> -    pc_cmos_init(pcms, rtc_state);
> +    pc_cmos_init(pcms, x86ms->rtc);
>  
>      /* the rest devices to which pci devfn is automatically assigned */
>      pc_vga_init(isa_bus, pcms->pcibus);
> -- 
> 2.44.0
> 
> 

