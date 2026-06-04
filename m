Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E032CCD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVBJh-0005w5-FJ; Thu, 04 Jun 2026 12:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wVBJf-0005vY-MJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wVBJd-0001CR-J9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780591988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFItENDyPpBiTwBuCCr8SoemaCOOgd3bZIS5gGdzw+s=;
 b=B4Otw0n8++dO+nWsoQde3Y8NnZGZlBqhIVpVJ/q6OkfYWFjxnm7tp6SInMt/gUZFmynZUG
 eyBHESaxQHTxQa7St0oQr5Jph7GmwG6imPibUAbz/YA3wXquaSZljEUejVsaV56hGiKGbZ
 VNrPcjxVuw6FpXfG3NRC4ECFLhLzqdE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-sDYqfGAeNXmzhNqXSYICuQ-1; Thu, 04 Jun 2026 12:53:07 -0400
X-MC-Unique: sDYqfGAeNXmzhNqXSYICuQ-1
X-Mimecast-MFC-AGG-ID: sDYqfGAeNXmzhNqXSYICuQ_1780591986
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490ae016853so6947845e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780591986; x=1781196786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zFItENDyPpBiTwBuCCr8SoemaCOOgd3bZIS5gGdzw+s=;
 b=JwbNxrjNAA1cv6LjOAgLsaabhEm2YWcjKP29zQz7u3dLBeFyVcch7R0GKHyTfOiHAp
 Bzt2pADZ8/CSu9tzCwZGlj7q3uk+x7QT4glyDFUpw6sO+Yv3FfeZ+1/M5w+rMW5Tks15
 +20GsX7aaItrYoeWIrnnmvjY78PWGOPmk50jaG1aSRFxmP3kJc6uwE4RKUIp8oITRSkF
 SY0XSTY0xQmFlIwHy/yqKjPHbj7uH+I1sB+mlek4UhGqGI4Zpjvqepy9tPVOHKNWueGg
 C7Mb7I7ARJybRvVH4X/ec3C5URtWVD+w7bP+Ib/MsftmvDAfHn6hqt/BQKMmHQ3zgQyj
 ZL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780591986; x=1781196786;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFItENDyPpBiTwBuCCr8SoemaCOOgd3bZIS5gGdzw+s=;
 b=sGlEdZQ78AS9TN9zkJNsAXVGDx/lRqVz4xlDSROPc+5iyMAsvbvRd3OGf3q7Pyunpr
 4MACtTX/87BQdzzobCJSx5CeQMDuIJliKdBED6vqSsczwf/ISFVvocL9fp9d051Dy6Om
 XC0q2tHjzM7AQiJrWhi4Xgj7j2hFHpkN2KFzlKZoSaRDWYhfTwjOU6VLxxuzycOo8LPZ
 Ut4BwNS8VKJeZ6Arjlt0hqomEVwJ7dm4hMKxFaonykRHoeYgCxwEVmzZgZiXaMAeWh3F
 AUMZOisQbInjUaVtMDw3AuHtf+OMT1iVlvay5VfeqFNvg1MDk7vfEoChSVLUqcElqJeJ
 T/Eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X6in/+MT/NAH0bDWvSMmXutBmhoNKSLB7LYG44Q8jxKbKSSKKIRt51pGUPE9iyqhv4cFZSSiqwMNC@nongnu.org
X-Gm-Message-State: AOJu0YwzAA4QEOBxWoY2HYFX8fYQQIC357IvNepzh5mk2qgRMK1OvdOm
 NDUW2SNWZqcYWQBVFigj24da3XGA/3cSw5Uia4ARKWyfQgfefzW2ci30kqR97a9NRM5VkpJ/+sk
 h+HNEqL3GTQFaaQmNQYkHDLtyd9M4N2iasN9xJHEuNKYrKPJs1AlPWxXG
X-Gm-Gg: Acq92OHuf5uZ8Q8jmc/V1oph1UqUAmQgbYmldGZ5m+C7Ij4JQn3IIi79mQpKOvAXH0n
 5zNBDtC/o1LfXR4c1P4exxvKedWaIe5p3LbecbxfWqbCJWX7DpD91vzoFPWagefMUmrbQrrxnjC
 kkY6+OKt38Yf2S9XU2+hZBBx5cpBpRBea5ZatwMNKMA23tYQM4NPXPGFHNkZknKTu8BGRVV+P4v
 WjBVcodGA1zuQWbX2iusj0xv1ICBpnJghRlA/jlYXka0Qx4Avo2l4Qf0VDlCJRTGdLj6KnZD1Dx
 iMi/fNBsJRa5KIkQJ9PzWBbso/FCk2zRoxFvsNGX1WqcdX6B+uqhz8yX1RrfKTaA2cpNEpyMZfP
 xzICKrgWoLOAZFMpUTSajFwOHNccBNpdT/qkUBHZ0tgo0iYLzbU6d5ht1rspihX1DVZJ3lYynNT
 Y=
X-Received: by 2002:a05:600c:4fd5:b0:490:b02d:1529 with SMTP id
 5b1f17b1804b1-490b5eb6644mr146122605e9.6.1780591985945; 
 Thu, 04 Jun 2026 09:53:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd5:b0:490:b02d:1529 with SMTP id
 5b1f17b1804b1-490b5eb6644mr146122155e9.6.1780591985581; 
 Thu, 04 Jun 2026 09:53:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fcf5bsm94036115e9.9.2026.06.04.09.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 09:53:04 -0700 (PDT)
Message-ID: <dfd3f723-01c3-4b22-8fa5-b6493d08243a@redhat.com>
Date: Thu, 4 Jun 2026 18:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] arm: virt: create sbsa_gwdt watchdog
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-10-imammedo@redhat.com>
 <7d67628a-6fa0-4c4e-a469-a80adc902549@redhat.com>
In-Reply-To: <7d67628a-6fa0-4c4e-a469-a80adc902549@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/4/26 6:48 PM, Eric Auger wrote:
> Hi Igor,
> 
> On 3/3/26 10:25 AM, Igor Mammedov wrote:
>> Allow to use SBSA generic watchdog with virt machine type.
>> (includes conditional generation of corresponding FDT and
>> ACPI GTDT descriptors)
>>
>> Use '-device sbsa_gwdt' to command line to enable it.
> don't we use '-' instead of '_' in general. At least this is the case
> for dynamically instantiable arm-smmuv3 device. Better to align
> 
> also this is the terminology used in the fdt compat string
> $id: http://devicetree.org/schemas/watchdog/arm,sbsa-gwdt.yaml#
>     const: arm,sbsa-gwdt
I realize this is not your choice as the device is already named that
way. #define TYPE_WDT_SBSA "sbsa_gwdt"
So I don't think we can anything about that anymore

although in general other devices use "-" I think
#define TYPE_UEFI_VARS_SYSBUS    "uefi-vars-sysbus"

Eric
> 
>>
>> Tested with Fedora 43:
>>   FDT: -M virt,acpi=off -device sbsa_gwdt
>>   ACPI: -M virt -device sbsa_gwdt
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  hw/arm/Kconfig           |  1 +
>>  hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++++++--
>>  hw/arm/virt.c            |  2 ++
>>  hw/core/sysbus-fdt.c     | 32 ++++++++++++++++++++++++++++++++
>>  hw/watchdog/sbsa_gwdt.c  |  1 +
>>  5 files changed, 67 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index c66c452737..1222efadd1 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -36,6 +36,7 @@ config ARM_VIRT
>>      select VIRTIO_MEM_SUPPORTED
>>      select ACPI_CXL
>>      select ACPI_HMAT
>> +    select WDT_SBSA
>>  
>>  config CUBIEBOARD
>>      bool
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 719d2f994e..9c14b1d4d5 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -64,6 +64,7 @@
>>  #include "hw/virtio/virtio-acpi.h"
>>  #include "target/arm/cpu.h"
>>  #include "target/arm/multiprocessing.h"
>> +#include "hw/watchdog/sbsa_gwdt.h"
>>  
>>  #define ARM_SPI_BASE 32
>>  
>> @@ -863,6 +864,8 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>      const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
>>      AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
>>                          .oem_table_id = vms->oem_table_id };
>> +    uint32_t gtdt_start = table_data->len;
>> +    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
>>  
>>      acpi_table_begin(&table, table_data);
>>  
>> @@ -893,10 +896,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>      build_append_int_noprefix(table_data, irqflags, 4);
>>      /* CntReadBase Physical address */
>>      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
>> +
>>      /* Platform Timer Count */
>> -    build_append_int_noprefix(table_data, 0, 4);
>> +    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
>>      /* Platform Timer Offset */
>> -    build_append_int_noprefix(table_data, 0, 4);
>> +    build_append_int_noprefix(table_data,
>> +        wdt ? (table_data->len - gtdt_start) +
>> +              4 + 4 + 4 /* len of this & following 2 fields to skip */
>> +            : 0, 4);
>> +
>>      if (vms->ns_el2_virt_timer_irq) {
>>          /* Virtual EL2 Timer GSIV */
>>          build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
>> @@ -906,6 +914,27 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>          build_append_int_noprefix(table_data, 0, 4);
>>          build_append_int_noprefix(table_data, 0, 4);
>>      }
>> +
>> +    /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
> 5.124
>> +    if (wdt) {
>> +        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>> +        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
>> +        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
>> +        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
>> +        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
>> +        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
>> +                  platform_bus_get_irqn(pbus, sd, 0);
>> +
>> +        build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
>> +        build_append_int_noprefix(table_data, 28 /* Length */, 2);
>> +        build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
>> +        /* RefreshFrame Physical Address */
>> +        build_append_int_noprefix(table_data, rbase, 8);
>> +        /* WatchdogControlFrame Physical Address */
>> +        build_append_int_noprefix(table_data, cbase, 8);
>> +        build_append_int_noprefix(table_data, irq, 4); /* Watchdog Timer GSIV */
>> +        build_append_int_noprefix(table_data, 0, 4); /* Watchdog Timer Flags */
> level, active high, non secure
>> +    }
>>      acpi_table_end(linker, &table);
>>  }
>>  
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index cab2e21e8a..a87991b591 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -95,6 +95,7 @@
>>  #include "hw/cxl/cxl.h"
>>  #include "hw/cxl/cxl_host.h"
>>  #include "qemu/guest-random.h"
>> +#include "hw/watchdog/sbsa_gwdt.h"
>>  
>>  static GlobalProperty arm_virt_compat_defaults[] = {
>>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>> @@ -3474,6 +3475,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
>> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_WDT_SBSA);
>>  #ifdef CONFIG_TPM
>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>>  #endif
>> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
>> index 89d0c46445..76aa1bc579 100644
>> --- a/hw/core/sysbus-fdt.c
>> +++ b/hw/core/sysbus-fdt.c
>> @@ -36,6 +36,7 @@
>>  #include "hw/display/ramfb.h"
>>  #include "hw/uefi/var-service-api.h"
>>  #include "hw/arm/fdt.h"
>> +#include "hw/watchdog/sbsa_gwdt.h"
>>  
>>  /*
>>   * internal struct that contains the information to create dynamic
>> @@ -118,6 +119,36 @@ static int add_uefi_vars_node(SysBusDevice *sbdev, void *opaque)
>>      return 0;
>>  }
>>  
>> +static int add_sbsa_gwdt_node(SysBusDevice *sbdev, void *opaque)
>> +{
>> +    PlatformBusFDTData *data = opaque;
>> +    PlatformBusDevice *pbus = data->pbus;
>> +    const char *parent_node = data->pbus_node_name;
>> +    void *fdt = data->fdt;
>> +    uint64_t cbase, rbase;
>> +    char *nodename;
>> +    int irq;
>> +
>> +    cbase = platform_bus_get_mmio_addr(pbus, sbdev, 1);  /* control frame */
>> +    rbase = platform_bus_get_mmio_addr(pbus, sbdev, 0);  /* refresh frame */
>> +    irq = platform_bus_get_irqn(pbus, sbdev, 0);
>> +
>> +    nodename = g_strdup_printf("%s/watchdog@%" PRIx64, parent_node, cbase);
>> +    qemu_fdt_add_subnode(fdt, nodename);
>> +
>> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "arm,sbsa-gwdt");
>> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
>> +                           cbase, SBSA_GWDT_CMMIO_SIZE,
>> +                           rbase, SBSA_GWDT_RMMIO_SIZE);
>> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
>> +                           GIC_FDT_IRQ_TYPE_SPI, data->irq_start + irq,
>> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>> +    qemu_fdt_setprop_cell(fdt, nodename, "timeout-sec", 30);
>> +
>> +    g_free(nodename);
>> +    return 0;
>> +}
>> +
>>  static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
>>  {
>>      return 0;
>> @@ -140,6 +171,7 @@ static const BindingEntry bindings[] = {
>>      TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
>>      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>>      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
>> +    TYPE_BINDING(TYPE_WDT_SBSA, add_sbsa_gwdt_node),
>>      TYPE_BINDING("", NULL), /* last element */
>>  };
>>  
>> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
>> index acb970e8b3..c4dd8005b7 100644
>> --- a/hw/watchdog/sbsa_gwdt.c
>> +++ b/hw/watchdog/sbsa_gwdt.c
>> @@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
>>      dc->realize = wdt_sbsa_gwdt_realize;
>>      device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
>>      dc->hotpluggable = false;
>> +    dc->user_creatable = true;
>>      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
>>      dc->vmsd = &vmstate_sbsa_gwdt;
>>      dc->desc = "SBSA-compliant generic watchdog device";
> Thanks
> 
> Eric
> 
> 


