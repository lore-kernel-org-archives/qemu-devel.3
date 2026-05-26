Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29BDCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsJj-0004qr-1w; Tue, 26 May 2026 09:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsJi-0004qi-7t
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsJd-00077i-HK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779803967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tm+vk7b7hM9z9WUMCqJo2kSLoI0BR/fiYKzq/Qm41ao=;
 b=LqKAvmozwKzu0kLrI0k5D3sEvFZGjQkMq3e4t9FmkkUogIeQInreXeeRr3qCi6SCLRyuDU
 Ks9YGDj+q8QJcSPb7dtpGIg4hNjvmBwi5myuDe6k9pN9YztkEax04guAm4Ws8O+5KMFj/q
 HCtbEqmGWXw0G0oW1QJ+MBm2OsDB6Mo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-7py90pu7M9SBoL3hQFsNbg-1; Tue, 26 May 2026 09:58:13 -0400
X-MC-Unique: 7py90pu7M9SBoL3hQFsNbg-1
X-Mimecast-MFC-AGG-ID: 7py90pu7M9SBoL3hQFsNbg_1779803891
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44d79da8cf7so8003584f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779803891; x=1780408691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tm+vk7b7hM9z9WUMCqJo2kSLoI0BR/fiYKzq/Qm41ao=;
 b=JWvFpIH23ZL+c+uFY+J6iwREEEVjqOR6h3cfBlz1+7un5XR2nBDYH8N9HZagkfzoku
 iHC/xf19J1endUCQh37QIWTi7PdYJiVvcsQZhx2Tau2UrNYLV8K7/bT2EltqcTTuL1lT
 rLpb7VMsO5OBoI9Po11siOsKzkm8ClVxZ0ot5WYLPfgb8QeIaBkebIPwrmVCeqqAs/G+
 xShr/YqAiMxmcqokPr5a4O6S4ZKblYmoavOPZH6kzwzyYG3HTPRnHO26+0fsvIILIO/t
 PW+DMd8BNNQPfeQ9y+oYNFNnthc+ARUCDMqtyslPCnFQlkAo3V3/xkY+U33QoKz6P0nT
 3aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779803891; x=1780408691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tm+vk7b7hM9z9WUMCqJo2kSLoI0BR/fiYKzq/Qm41ao=;
 b=X9oz8Bk+u4AW8aeDiLcYmypV2nAJn+i+zPV5ITLn1eB7eJg7BB/uiUn2OT+AqGRxVJ
 N9V7SUQUn9uWAreqZJLWzE15MXNyTW5XhSB/EJnl4IiC05t2Dn4z3ZWcgUTrsXBlwzbZ
 dURDZEJbeb7iYxMmmJw0E2NoNCPK31uRANXtIz0vNDBZvfje947zFJIzlq0XLHXPr1YL
 lzZ7cOxy7gUFSpphT1HktUUOvxcxPVmUr9mWWDktkxQ5qy3tbKQcspJUdHUz+ZScT0NI
 TX00OUs+LtKPGs+ju07XRguK2QgOS6n3UH6N1PyEGsXZOkV+uN6cEKx5kx3WCk3hajjT
 L0/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qxqUznOirfvIym+D6xyPDLSxXpL+nKROFSWyclgFoS1TbUNaPtJmB6gFLNJwsii/rElfcqGaFN8v2@nongnu.org
X-Gm-Message-State: AOJu0YxHcZHHxTAcfnJ0+Cp3xqLo2MsfiK5y7fvPopmaKQ4jhyCtc/rV
 5D186/IFpA//NnjFfpaoNoKoALQDnmmFouX3kNtV+KhtSa/T6/hbhgXppnZbNxaVA8ENAjYIdqR
 JaRje6eBdraXAfnTLAkCAV3zLoUy4y3RijIGBiFaSJbc4RyixMfe0O76a
X-Gm-Gg: Acq92OHPsYYDlkbOsiSP/E2z9GHaW4EGxfqWOiP1eLvy6VesamKSTRA5HZvEMCgEQiw
 qrbNZi+U1NQm2qaI292N6wSSCNlX97n4HMr2J5V/7Iu6yUZxlR33zR5S/4H+Tz3f2cOmnedUpot
 L9Phn/k+Sjs5QKOQ7zNuowS42L30oCsB5LvaDCkhhDBMBwxfA5rwwbDZhYnEHHN5Q+GMPCiBx56
 P4OZ2jLdTzu0niQw/1vXXNZBUUXSPa/a4haseBJqPlix+TmP5k/CSPRAe9R2sSUaJ2JXni41ACU
 rgcPM5jUjukYklwJZnx24C9QjZKm8tycCER48yN+2zWrU/WAAVe8+EUezbXKRq5LnGo2GL7+eNV
 V9Ruc6droRe2dOuaH3nSX/TdpjR52Aj+qC2o/QTVvS4KO1UULWGClN438vJdAfKOqvvtLmbr9ko
 c=
X-Received: by 2002:a05:6000:18af:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-45eb38badd5mr32703485f8f.30.1779803890863; 
 Tue, 26 May 2026 06:58:10 -0700 (PDT)
X-Received: by 2002:a05:6000:18af:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-45eb38badd5mr32703398f8f.30.1779803890309; 
 Tue, 26 May 2026 06:58:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ed1939c6asm14695725f8f.2.2026.05.26.06.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 06:58:09 -0700 (PDT)
Message-ID: <4cdd38f4-4efc-48c5-a236-a40449ad8e85@redhat.com>
Date: Tue, 26 May 2026 15:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] arm: virt: create sbsa_gwdt watchdog
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-10-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-10-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,

On 3/3/26 10:25 AM, Igor Mammedov wrote:
> Allow to use SBSA generic watchdog with virt machine type.
> (includes conditional generation of corresponding FDT and
> ACPI GTDT descriptors)
> 
> Use '-device sbsa_gwdt' to command line to enable it.
I thank that in general Peter is not a big fan of dynamic instantiation
of sysbus devices. Don't you have means to instantiate it statically in
arm virt memory map?

Eric
> 
> Tested with Fedora 43:
>   FDT: -M virt,acpi=off -device sbsa_gwdt
>   ACPI: -M virt -device sbsa_gwdt
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/Kconfig           |  1 +
>  hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++++++--
>  hw/arm/virt.c            |  2 ++
>  hw/core/sysbus-fdt.c     | 32 ++++++++++++++++++++++++++++++++
>  hw/watchdog/sbsa_gwdt.c  |  1 +
>  5 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c66c452737..1222efadd1 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -36,6 +36,7 @@ config ARM_VIRT
>      select VIRTIO_MEM_SUPPORTED
>      select ACPI_CXL
>      select ACPI_HMAT
> +    select WDT_SBSA
>  
>  config CUBIEBOARD
>      bool
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 719d2f994e..9c14b1d4d5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -64,6 +64,7 @@
>  #include "hw/virtio/virtio-acpi.h"
>  #include "target/arm/cpu.h"
>  #include "target/arm/multiprocessing.h"
> +#include "hw/watchdog/sbsa_gwdt.h"
>  
>  #define ARM_SPI_BASE 32
>  
> @@ -863,6 +864,8 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
>      AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
> +    uint32_t gtdt_start = table_data->len;
> +    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
>  
>      acpi_table_begin(&table, table_data);
>  
> @@ -893,10 +896,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, irqflags, 4);
>      /* CntReadBase Physical address */
>      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
> +
>      /* Platform Timer Count */
> -    build_append_int_noprefix(table_data, 0, 4);
> +    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
>      /* Platform Timer Offset */
> -    build_append_int_noprefix(table_data, 0, 4);
> +    build_append_int_noprefix(table_data,
> +        wdt ? (table_data->len - gtdt_start) +
> +              4 + 4 + 4 /* len of this & following 2 fields to skip */
> +            : 0, 4);
> +
>      if (vms->ns_el2_virt_timer_irq) {
>          /* Virtual EL2 Timer GSIV */
>          build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
> @@ -906,6 +914,27 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          build_append_int_noprefix(table_data, 0, 4);
>          build_append_int_noprefix(table_data, 0, 4);
>      }
> +
> +    /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
> +    if (wdt) {
> +        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
> +        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> +        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
> +        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
> +        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
> +                  platform_bus_get_irqn(pbus, sd, 0);
> +
> +        build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
> +        build_append_int_noprefix(table_data, 28 /* Length */, 2);
> +        build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> +        /* RefreshFrame Physical Address */
> +        build_append_int_noprefix(table_data, rbase, 8);
> +        /* WatchdogControlFrame Physical Address */
> +        build_append_int_noprefix(table_data, cbase, 8);
> +        build_append_int_noprefix(table_data, irq, 4); /* Watchdog Timer GSIV */
> +        build_append_int_noprefix(table_data, 0, 4); /* Watchdog Timer Flags */
> +    }
>      acpi_table_end(linker, &table);
>  }
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cab2e21e8a..a87991b591 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -95,6 +95,7 @@
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_host.h"
>  #include "qemu/guest-random.h"
> +#include "hw/watchdog/sbsa_gwdt.h"
>  
>  static GlobalProperty arm_virt_compat_defaults[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> @@ -3474,6 +3475,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_WDT_SBSA);
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index 89d0c46445..76aa1bc579 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -36,6 +36,7 @@
>  #include "hw/display/ramfb.h"
>  #include "hw/uefi/var-service-api.h"
>  #include "hw/arm/fdt.h"
> +#include "hw/watchdog/sbsa_gwdt.h"
>  
>  /*
>   * internal struct that contains the information to create dynamic
> @@ -118,6 +119,36 @@ static int add_uefi_vars_node(SysBusDevice *sbdev, void *opaque)
>      return 0;
>  }
>  
> +static int add_sbsa_gwdt_node(SysBusDevice *sbdev, void *opaque)
> +{
> +    PlatformBusFDTData *data = opaque;
> +    PlatformBusDevice *pbus = data->pbus;
> +    const char *parent_node = data->pbus_node_name;
> +    void *fdt = data->fdt;
> +    uint64_t cbase, rbase;
> +    char *nodename;
> +    int irq;
> +
> +    cbase = platform_bus_get_mmio_addr(pbus, sbdev, 1);  /* control frame */
> +    rbase = platform_bus_get_mmio_addr(pbus, sbdev, 0);  /* refresh frame */
> +    irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +
> +    nodename = g_strdup_printf("%s/watchdog@%" PRIx64, parent_node, cbase);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "arm,sbsa-gwdt");
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +                           cbase, SBSA_GWDT_CMMIO_SIZE,
> +                           rbase, SBSA_GWDT_RMMIO_SIZE);
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, data->irq_start + irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop_cell(fdt, nodename, "timeout-sec", 30);
> +
> +    g_free(nodename);
> +    return 0;
> +}
> +
>  static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
>  {
>      return 0;
> @@ -140,6 +171,7 @@ static const BindingEntry bindings[] = {
>      TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
>      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
> +    TYPE_BINDING(TYPE_WDT_SBSA, add_sbsa_gwdt_node),
>      TYPE_BINDING("", NULL), /* last element */
>  };
>  
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index acb970e8b3..c4dd8005b7 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
>      dc->realize = wdt_sbsa_gwdt_realize;
>      device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
>      dc->hotpluggable = false;
> +    dc->user_creatable = true;
>      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
>      dc->vmsd = &vmstate_sbsa_gwdt;
>      dc->desc = "SBSA-compliant generic watchdog device";


