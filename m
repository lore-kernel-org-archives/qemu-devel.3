Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AD8C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWXZ-0005I8-CE; Mon, 26 Feb 2024 03:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWXX-0005Hj-0T
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:40:47 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWXV-0007Iq-0g
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708936845; x=1740472845;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=br1WkH1phXgm1RMAK2+mgUZNLEHz4CnmsvUPZjpmXU0=;
 b=lWy18JME83xa3ictx6uD6dsckEMpR356YFlJPbcR7tQ7F/Xek3ZVGU7I
 BX/gi0YIptJX7BMeHpMyFS/lfKwMj7q9tDX5PhAYxK1KUU9PwTtjPWa0a
 JGrU1Iac/ht92VLhxoaGjeDmhGedpOefQ+2XRXzmOrfMeSxfZN6Y45eAL
 D89jeNZBaR522xColQXgkK7Eq9ZLnXDYm0hs6GER6Ui9ie5CF1vyJTUzy
 bdk2aMXD3IUoT/1WWihMt2NhXbzS9q2faBqFTuEMDSzpPdkceY5+MQZvy
 S4jn+PTWjN9IUPoNVohJRwZtA4wd5mBuE1k1SUUo2cw/9HGv5vT/73fMT A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6994274"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6994274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="37595417"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 26 Feb 2024 00:40:39 -0800
Date: Mon, 26 Feb 2024 16:54:21 +0800
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
Subject: Re: [PATCH v2 1/6] hw/i386/x86: Let ioapic_init_gsi() take parent as
 pointer
Message-ID: <ZdxRvRw1hUXoHvbr@intel.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-2-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224135851.100361-2-shentey@gmail.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Sat, Feb 24, 2024 at 02:58:46PM +0100, Bernhard Beschow wrote:
> Date: Sat, 24 Feb 2024 14:58:46 +0100
> From: Bernhard Beschow <shentey@gmail.com>
> Subject: [PATCH v2 1/6] hw/i386/x86: Let ioapic_init_gsi() take parent as
>  pointer
> X-Mailer: git-send-email 2.44.0
> 
> Rather than taking a QOM name which has to be resolved, let's pass the parent
> directly as pointer. This simplifies the code.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/i386/x86.h | 2 +-
>  hw/i386/microvm.c     | 2 +-
>  hw/i386/pc_piix.c     | 7 +++----
>  hw/i386/pc_q35.c      | 2 +-
>  hw/i386/x86.c         | 7 +++----
>  5 files changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 8e306db7bb..4dc30dcb4d 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -139,7 +139,7 @@ typedef struct GSIState {
>  
>  qemu_irq x86_allocate_cpu_irq(void);
>  void gsi_handler(void *opaque, int n, int level);
> -void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
> +void ioapic_init_gsi(GSIState *gsi_state, Object *parent);
>  DeviceState *ioapic_init_secondary(GSIState *gsi_state);
>  
>  /* pc_sysfw.c */
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index ca55aecc3b..61a772dfe6 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -175,7 +175,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>                            &error_abort);
>      isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>  
> -    ioapic_init_gsi(gsi_state, "machine");
> +    ioapic_init_gsi(gsi_state, OBJECT(mms));
>      if (ioapics > 1) {
>          x86ms->ioapic2 = ioapic_init_secondary(gsi_state);
>      }
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ec7c07b362..7724396ead 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -107,6 +107,7 @@ static void pc_init1(MachineState *machine,
>      X86MachineState *x86ms = X86_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *system_io = get_system_io();
> +    Object *phb = NULL;
>      PCIBus *pci_bus = NULL;
>      ISABus *isa_bus;
>      Object *piix4_pm = NULL;
> @@ -189,8 +190,6 @@ static void pc_init1(MachineState *machine,
>      }
>  
>      if (pcmc->pci_enabled) {
> -        Object *phb;
> -
>          pci_memory = g_new(MemoryRegion, 1);
>          memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>          rom_memory = pci_memory;
> @@ -303,8 +302,8 @@ static void pc_init1(MachineState *machine,
>          pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>      }
>  
> -    if (pcmc->pci_enabled) {
> -        ioapic_init_gsi(gsi_state, "i440fx");
> +    if (phb) {
> +        ioapic_init_gsi(gsi_state, phb);
>      }
>  
>      if (tcg_enabled()) {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 53fb3db26d..c89ff63579 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -263,7 +263,7 @@ static void pc_q35_init(MachineState *machine)
>          pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>      }
>  
> -    ioapic_init_gsi(gsi_state, "q35");
> +    ioapic_init_gsi(gsi_state, OBJECT(phb));
>  
>      if (tcg_enabled()) {
>          x86_register_ferr_irq(x86ms->gsi[13]);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 684dce90e9..807e09bcdb 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -640,20 +640,19 @@ void gsi_handler(void *opaque, int n, int level)
>      }
>  }
>  
> -void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
> +void ioapic_init_gsi(GSIState *gsi_state, Object *parent)
>  {
>      DeviceState *dev;
>      SysBusDevice *d;
>      unsigned int i;
>  
> -    assert(parent_name);
> +    assert(parent);
>      if (kvm_ioapic_in_kernel()) {
>          dev = qdev_new(TYPE_KVM_IOAPIC);
>      } else {
>          dev = qdev_new(TYPE_IOAPIC);
>      }
> -    object_property_add_child(object_resolve_path(parent_name, NULL),
> -                              "ioapic", OBJECT(dev));
> +    object_property_add_child(parent, "ioapic", OBJECT(dev));
>      d = SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(d, &error_fatal);
>      sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
> -- 
> 2.44.0
> 
> 

