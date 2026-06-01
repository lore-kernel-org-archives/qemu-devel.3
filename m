Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6D0CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5de-0002oQ-Qd; Mon, 01 Jun 2026 12:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wU5dc-0002o4-VU
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wU5da-0005eR-Gv
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780331832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tSxiMBSndbMFXZOgm5mdwE7OdYgcP8Sa5xOIDOQUYE=;
 b=MXNz6Cr+OoFxCQpm8hFizynja/Au1jO8EnW52gOUNx3NmXPvD+wk+Cw+p/a+6X/a0Pabx0
 nlrmmLMC9/Vscu2yRfMw0p/pS45Ya76NPXuS+epx109bvhfVRe3eAn/6KU1iSH7p0ie8OK
 OoWU8Sx/A1quvWowx+pux+1EvQ6kMyY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-b451DyFjOp2LCR7tclTHpg-1; Mon, 01 Jun 2026 12:37:11 -0400
X-MC-Unique: b451DyFjOp2LCR7tclTHpg-1
X-Mimecast-MFC-AGG-ID: b451DyFjOp2LCR7tclTHpg_1780331830
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef6417092so1799990f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780331830; x=1780936630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tSxiMBSndbMFXZOgm5mdwE7OdYgcP8Sa5xOIDOQUYE=;
 b=EkB/w2Fq0zi5n+v74K2mY92SgkAS82d90mLAWo/DPI3rKH4Uhw7nOCHaIarAvnAr+j
 EogsHwuSgRt21ANQBZX7wanPfJDUbf9dzRqA/U8MK4pAaemMHYaqqG0X9HIhM/Sk5qaJ
 nBR54x5sjQ/F0+EPcZHsUlQTxPGWFsDp7b13woUwwY42AWJuNS3ahDvJ+iWsLf8twvIo
 iDTuyz0bCqV8i/hNlOze7H//X0RS/WpLI2Jhal/yRO2t8DaJx9jekHxESDuOyUdagoTa
 DL0HyOY1gTvp9UDCEnWesfyntLS9pLkoZmVhty3AdAEZp5iOzlt50ZbEBEiKjFTcCY93
 a61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780331830; x=1780936630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tSxiMBSndbMFXZOgm5mdwE7OdYgcP8Sa5xOIDOQUYE=;
 b=LGwaHPZbHDAF1DCXRCWQfLBwEwhPzz0oSHU2rjGtOAPBRhDmsPiiZeSMQtg3bv9G1e
 i1YWDh/zqQ/M+Nfg7BhIM/3AIE8vauKRzg5lI8ZqXctM0CiM0sAQgIALhrrxR52n1oCu
 YSDE0hO1ndWDCRBZQYfaHctfaushBuL6YQTKadQJcT6xRDWQZ5mSKapHyHJUmLlExFow
 Sujjb9Ea70ZnXFAZU+gsDZZY6NFBKXc7DhEIEWwbkB4X5xUdwpt2SgtSuPksnpgNCHz0
 FuucA6lO3E/7QjSXNDr3fAu3n18VEBlNINvuz71/JQvg3VDOeDnskDL8a8H/qTgRwTef
 8XXQ==
X-Gm-Message-State: AOJu0Yw3pl++7nnfmmycwfNkj5ISaJBzPSIP36SGDsw9JlnfzEVgzLFf
 URf7dVg1z29ztT/Zk4S1lVdeR2gCPs2UNyiPlWyGgFu7TNZVgCZfXCWFSQ0Ru1nEvqLwkWLiRK/
 k49k0MCEfzL8EnDwxEcry9b9cP9+ifVW4p4eg3dz3uTsGI9tBI6oDwdd5
X-Gm-Gg: Acq92OGAB6EtbgOm4CFVQ/mUxr5cnRGhuH473CPQ43HEtp6tl/e6QTt8Idu+07U6+aQ
 yGbUY4Thj0fp61hAA0xbdHBDDwmU5Kl75yfit8vvwKrOkgkMbeeIUy+fpTxSzHGl1JB+0Q103IN
 4TqLtwvk/+1RgW8RIglGrvLMUyQHeBwaY5XJHIkxuFK6R4cACY/lSI6f2CeHJFPPQBTSZNVbbXi
 nAWuE0+SaQU9Y0KzVPxJ+zeMWDMoBSbUhFNsvVUnguLwtILB/OkColLSqo/lmoqkwCsbtx7/Bmu
 i2t4RNgwIsOb5equKY9ktjrNyuiNsudv07L5GmI4CFFYYLYKBCSzJ7TTHmIBOKsKf5hencfLSHo
 lnyXlO3HiRIBX4H5Rpj0fOfYEdO81W50CnZ/Ajt7xqwKTopRMJeJN3rspVwE+P+aMSYbVosRfCg
 4=
X-Received: by 2002:adf:f5c2:0:b0:45e:ce28:666a with SMTP id
 ffacd0b85a97d-45ef6aec759mr16589358f8f.1.1780331829623; 
 Mon, 01 Jun 2026 09:37:09 -0700 (PDT)
X-Received: by 2002:adf:f5c2:0:b0:45e:ce28:666a with SMTP id
 ffacd0b85a97d-45ef6aec759mr16589300f8f.1.1780331829032; 
 Mon, 01 Jun 2026 09:37:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354b5bdsm25512370f8f.21.2026.06.01.09.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 09:37:08 -0700 (PDT)
Message-ID: <01f82785-b6c0-4436-ad93-251c837a5cdc@redhat.com>
Date: Mon, 1 Jun 2026 18:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] arm: virt: create sbsa_gwdt watchdog
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-10-imammedo@redhat.com>
 <4cdd38f4-4efc-48c5-a236-a40449ad8e85@redhat.com>
 <20260527144955.64eff309@imammedo>
 <affe914f-157f-4125-93c5-abb94df3ab5b@redhat.com>
 <b6895403-e294-44de-b77d-511cddadb567@redhat.com>
 <20260528163714.7efb851e@imammedo>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260528163714.7efb851e@imammedo>
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

Hi Igor,

On 5/28/26 4:37 PM, Igor Mammedov wrote:
> On Thu, 28 May 2026 11:59:06 +0200
> Eric Auger <eauger@redhat.com> wrote:
> 
>> Hi,
>>
>> On 5/28/26 11:04 AM, Eric Auger wrote:
>>> Hi Igor,
>>>
>>> On 5/27/26 2:49 PM, Igor Mammedov wrote:  
>>>> On Tue, 26 May 2026 15:58:08 +0200
>>>> Eric Auger <eauger@redhat.com> wrote:
>>>>  
>>>>> Hi Igor,
>>>>>
>>>>> On 3/3/26 10:25 AM, Igor Mammedov wrote:  
>>>>>> Allow to use SBSA generic watchdog with virt machine type.
>>>>>> (includes conditional generation of corresponding FDT and
>>>>>> ACPI GTDT descriptors)
>>>>>>
>>>>>> Use '-device sbsa_gwdt' to command line to enable it.    
>>>>> I thank that in general Peter is not a big fan of dynamic instantiation
>>>>> of sysbus devices. Don't you have means to instantiate it statically in
>>>>> arm virt memory map?  
> 
> On Peter's part, there weren't any objection to the idea using -device.
> (neither in v1 nor in this revision).
> 
> 
>>>> /me neither
>>>>
>>>> in previous version there was a machine option to enable the feature
>>>> to that was rejected in favor of device.
>>>>
>>>> in this case for platform  -device of sysbus based device, I don't think
>>>> we can do better that dynamic sysbus.   
>>>
>>> sorry I may have missed some previous discussion details. As far as I
>>> can read, I understand you could instantiate the wdt in a free MMIO
>>> slot, unconfitionnaly just as it is done in hw/arm/sbsa-ref.c. Maybe add
>>> a compat to avoid having it by default on older machine types. Then
>>> about the type of the integration gtdt or wat, can't you have a device
>>> compat?  
>> After further reading of the previous version thread, I wonder if you
>> shouldn't always instantiate the watchdog in the machine instead.
>>
>> Add a device property allowing to switch between GWDT or WDAT version.
>>
>> In arm virt,
>>
>> 1) if you discover the GWDT version is selected (default) you generate
>> both dt and GTDT ACPI table
>> 2) if you discover the WDAT version is selected, you only generate WDAT
>> ACPI description and you output an error in case of DT boot.
>>
>> You may add a machine no_wdt flag to handle compats for older machine
>> types if needed.
> 
> rereading v1 thread it seems that there weren't much objection to adding
> a dedicated virt machine property to enable 'wdat' [1] /like what is done to q35/.
> 
> problem was in conflating too generic whatchdog=none/auto/native/acpi into
> one knob and discussion quickly went down rabbit hole of semantics.
> 
> For Q35, we don't really have a choice as it's already builtin device,
> but for arm/virt we can do better than a bunch of compats and proxy
> properties. (as Markus noted in v1 review, we've done that/still do
> but it doesn't scale well)
> 
> I can go old route and revert to simplified v1 that would:
>   * make gwdt builtin device on arm/virt board
>     (i.e. default to SBSA native watchdog with GTDT ACPI table
>      and relevant FDT entries)
would make sense to me.
>   * add a machine.gwdt-wdat=on|off property
>      1. that will make gwdt to use 1KHz frequency
>      2. enable WDAT ACPI table
>      3. disable GTDT ACPI table and relevant FDT entries
>         as they are mutually exclusive with #1 point 
>   * add a compat knob to disable gwdt on old machine types.
Either that or device prop setting as we have for ACPI PCI HP (technique
you advocated at some point).
> 
> Re-spinning that wouldn't take much effort, all the code already exist,
> just needs mostly reshuffling. 
> 
> 1) I think Daniel was ok having something like gwdt-wdat=on|off
>    from libvirt pov.
> 
> That said,
> Having watchdog as an optional -device is much cleaner compared to
> adding knobs to machine (both internal compats and external to enable
> specific watchdog).
I am OK with that too. However in general I think Peter prefers having
them statically instantiated if possible. All the more so I think that
having a watchdog, always instantiated, in its GTDT/FDT form (not WDAT
ACPI only) in machvirt would make sense in general and does not make
much trouble in terms of MMIO layout.> Good (well bad actualy) example
of compats/props is set of
> ITS ones, one eventually can untangle what depends on what
> and how that works together, but I'd rather avoid doing that. 
> 
> Perhaps I went overboard with move to -device.
> Anyways, all I can do is suggest in my opinion a better way,
> but it's upto arm folks to pick a preferred approach.
> 
>> Would that make sense?
>>
>> Otherwise, can you point me the msgid where the -device was prefered?
> Sorry, rereading v1 thread, -device was just an idea to try
> (but by no means a preferred/consensus one).
This is what I understood too.

Thanks

Eric
> 
>>
>> Thanks
>>
>> Eric
>>>
>>> Thanks
>>>
>>> Eric
>>>   
>>>>
>>>>    
>>>>>
>>>>> Eric  
>>>>>>
>>>>>> Tested with Fedora 43:
>>>>>>   FDT: -M virt,acpi=off -device sbsa_gwdt
>>>>>>   ACPI: -M virt -device sbsa_gwdt
>>>>>>
>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>> ---
>>>>>>  hw/arm/Kconfig           |  1 +
>>>>>>  hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++++++--
>>>>>>  hw/arm/virt.c            |  2 ++
>>>>>>  hw/core/sysbus-fdt.c     | 32 ++++++++++++++++++++++++++++++++
>>>>>>  hw/watchdog/sbsa_gwdt.c  |  1 +
>>>>>>  5 files changed, 67 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>>>>> index c66c452737..1222efadd1 100644
>>>>>> --- a/hw/arm/Kconfig
>>>>>> +++ b/hw/arm/Kconfig
>>>>>> @@ -36,6 +36,7 @@ config ARM_VIRT
>>>>>>      select VIRTIO_MEM_SUPPORTED
>>>>>>      select ACPI_CXL
>>>>>>      select ACPI_HMAT
>>>>>> +    select WDT_SBSA
>>>>>>  
>>>>>>  config CUBIEBOARD
>>>>>>      bool
>>>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>>>> index 719d2f994e..9c14b1d4d5 100644
>>>>>> --- a/hw/arm/virt-acpi-build.c
>>>>>> +++ b/hw/arm/virt-acpi-build.c
>>>>>> @@ -64,6 +64,7 @@
>>>>>>  #include "hw/virtio/virtio-acpi.h"
>>>>>>  #include "target/arm/cpu.h"
>>>>>>  #include "target/arm/multiprocessing.h"
>>>>>> +#include "hw/watchdog/sbsa_gwdt.h"
>>>>>>  
>>>>>>  #define ARM_SPI_BASE 32
>>>>>>  
>>>>>> @@ -863,6 +864,8 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>>>>      const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
>>>>>>      AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
>>>>>>                          .oem_table_id = vms->oem_table_id };
>>>>>> +    uint32_t gtdt_start = table_data->len;
>>>>>> +    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
>>>>>>  
>>>>>>      acpi_table_begin(&table, table_data);
>>>>>>  
>>>>>> @@ -893,10 +896,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>>>>      build_append_int_noprefix(table_data, irqflags, 4);
>>>>>>      /* CntReadBase Physical address */
>>>>>>      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
>>>>>> +
>>>>>>      /* Platform Timer Count */
>>>>>> -    build_append_int_noprefix(table_data, 0, 4);
>>>>>> +    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
>>>>>>      /* Platform Timer Offset */
>>>>>> -    build_append_int_noprefix(table_data, 0, 4);
>>>>>> +    build_append_int_noprefix(table_data,
>>>>>> +        wdt ? (table_data->len - gtdt_start) +
>>>>>> +              4 + 4 + 4 /* len of this & following 2 fields to skip */
>>>>>> +            : 0, 4);
>>>>>> +
>>>>>>      if (vms->ns_el2_virt_timer_irq) {
>>>>>>          /* Virtual EL2 Timer GSIV */
>>>>>>          build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
>>>>>> @@ -906,6 +914,27 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>>>>>          build_append_int_noprefix(table_data, 0, 4);
>>>>>>          build_append_int_noprefix(table_data, 0, 4);
>>>>>>      }
>>>>>> +
>>>>>> +    /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
>>>>>> +    if (wdt) {
>>>>>> +        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>>>>>> +        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
>>>>>> +        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
>>>>>> +        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
>>>>>> +        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
>>>>>> +        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
>>>>>> +                  platform_bus_get_irqn(pbus, sd, 0);
>>>>>> +
>>>>>> +        build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
>>>>>> +        build_append_int_noprefix(table_data, 28 /* Length */, 2);
>>>>>> +        build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
>>>>>> +        /* RefreshFrame Physical Address */
>>>>>> +        build_append_int_noprefix(table_data, rbase, 8);
>>>>>> +        /* WatchdogControlFrame Physical Address */
>>>>>> +        build_append_int_noprefix(table_data, cbase, 8);
>>>>>> +        build_append_int_noprefix(table_data, irq, 4); /* Watchdog Timer GSIV */
>>>>>> +        build_append_int_noprefix(table_data, 0, 4); /* Watchdog Timer Flags */
>>>>>> +    }
>>>>>>      acpi_table_end(linker, &table);
>>>>>>  }
>>>>>>  
>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>> index cab2e21e8a..a87991b591 100644
>>>>>> --- a/hw/arm/virt.c
>>>>>> +++ b/hw/arm/virt.c
>>>>>> @@ -95,6 +95,7 @@
>>>>>>  #include "hw/cxl/cxl.h"
>>>>>>  #include "hw/cxl/cxl_host.h"
>>>>>>  #include "qemu/guest-random.h"
>>>>>> +#include "hw/watchdog/sbsa_gwdt.h"
>>>>>>  
>>>>>>  static GlobalProperty arm_virt_compat_defaults[] = {
>>>>>>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>>>>>> @@ -3474,6 +3475,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>>>>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>>>>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>>>>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
>>>>>> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_WDT_SBSA);
>>>>>>  #ifdef CONFIG_TPM
>>>>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>>>>>>  #endif
>>>>>> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
>>>>>> index 89d0c46445..76aa1bc579 100644
>>>>>> --- a/hw/core/sysbus-fdt.c
>>>>>> +++ b/hw/core/sysbus-fdt.c
>>>>>> @@ -36,6 +36,7 @@
>>>>>>  #include "hw/display/ramfb.h"
>>>>>>  #include "hw/uefi/var-service-api.h"
>>>>>>  #include "hw/arm/fdt.h"
>>>>>> +#include "hw/watchdog/sbsa_gwdt.h"
>>>>>>  
>>>>>>  /*
>>>>>>   * internal struct that contains the information to create dynamic
>>>>>> @@ -118,6 +119,36 @@ static int add_uefi_vars_node(SysBusDevice *sbdev, void *opaque)
>>>>>>      return 0;
>>>>>>  }
>>>>>>  
>>>>>> +static int add_sbsa_gwdt_node(SysBusDevice *sbdev, void *opaque)
>>>>>> +{
>>>>>> +    PlatformBusFDTData *data = opaque;
>>>>>> +    PlatformBusDevice *pbus = data->pbus;
>>>>>> +    const char *parent_node = data->pbus_node_name;
>>>>>> +    void *fdt = data->fdt;
>>>>>> +    uint64_t cbase, rbase;
>>>>>> +    char *nodename;
>>>>>> +    int irq;
>>>>>> +
>>>>>> +    cbase = platform_bus_get_mmio_addr(pbus, sbdev, 1);  /* control frame */
>>>>>> +    rbase = platform_bus_get_mmio_addr(pbus, sbdev, 0);  /* refresh frame */
>>>>>> +    irq = platform_bus_get_irqn(pbus, sbdev, 0);
>>>>>> +
>>>>>> +    nodename = g_strdup_printf("%s/watchdog@%" PRIx64, parent_node, cbase);
>>>>>> +    qemu_fdt_add_subnode(fdt, nodename);
>>>>>> +
>>>>>> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "arm,sbsa-gwdt");
>>>>>> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
>>>>>> +                           cbase, SBSA_GWDT_CMMIO_SIZE,
>>>>>> +                           rbase, SBSA_GWDT_RMMIO_SIZE);
>>>>>> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
>>>>>> +                           GIC_FDT_IRQ_TYPE_SPI, data->irq_start + irq,
>>>>>> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>>>>>> +    qemu_fdt_setprop_cell(fdt, nodename, "timeout-sec", 30);
>>>>>> +
>>>>>> +    g_free(nodename);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>  static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
>>>>>>  {
>>>>>>      return 0;
>>>>>> @@ -140,6 +171,7 @@ static const BindingEntry bindings[] = {
>>>>>>      TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
>>>>>>      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>>>>>>      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
>>>>>> +    TYPE_BINDING(TYPE_WDT_SBSA, add_sbsa_gwdt_node),
>>>>>>      TYPE_BINDING("", NULL), /* last element */
>>>>>>  };
>>>>>>  
>>>>>> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
>>>>>> index acb970e8b3..c4dd8005b7 100644
>>>>>> --- a/hw/watchdog/sbsa_gwdt.c
>>>>>> +++ b/hw/watchdog/sbsa_gwdt.c
>>>>>> @@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
>>>>>>      dc->realize = wdt_sbsa_gwdt_realize;
>>>>>>      device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
>>>>>>      dc->hotpluggable = false;
>>>>>> +    dc->user_creatable = true;
>>>>>>      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
>>>>>>      dc->vmsd = &vmstate_sbsa_gwdt;
>>>>>>      dc->desc = "SBSA-compliant generic watchdog device";    
>>>>>  
>>>>  
>>>   
>>
> 


