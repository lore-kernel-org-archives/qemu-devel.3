Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD770C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 13:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPiO4-0001iS-2F; Thu, 12 Jun 2025 09:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPiO1-0001i5-Jp
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPiNz-0001yw-0S
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749736468;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lu2mr4y8OdPui3AMYal/e+Sma5lEYyu6NBOk1XGioEc=;
 b=GYJOT5tLucDk5jcr21J3nWfkX2PV2g3l7wPbmihWrE8Sr/Kejy0eLer2vlPyM3BKsAvd2Y
 H7TbPTRpRXz0o9tuetzIJ8Xti5FWG+AGTtWFVE04pclevT67tMTsJvGuN1K+wI9SsQQhZ1
 9OIoTOsPVInVqI91jC2J1Qi65oefuGs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-gYoRVKN3MPGEi4NJ-E1GIQ-1; Thu, 12 Jun 2025 09:54:26 -0400
X-MC-Unique: gYoRVKN3MPGEi4NJ-E1GIQ-1
X-Mimecast-MFC-AGG-ID: gYoRVKN3MPGEi4NJ-E1GIQ_1749736465
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so502486f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 06:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749736465; x=1750341265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lu2mr4y8OdPui3AMYal/e+Sma5lEYyu6NBOk1XGioEc=;
 b=oxegp0eWQ74fB3f3AlEZJUzbRV+OqQy237ZkhITtjjoZmHqAAJF2phmKthUuIc5AhR
 Ho1ClT3xE7eZMsoHN4J9JJGGe5awDu9GFtH/C/jTyPNSXTIbmsCfViOBFq7cksNZoPLm
 tGiM0DwBQRsZCIVtz4t7I49AcnurL3rq79x80gjkAeKzjZ92PoFBYyUDCwkX93nnn8kw
 S+VTrWFpmvHYFIKveQ7cCDVI4fZCxhvNgPabNngcf956Umexyxe2UK2b4aElRjCZrJCD
 aNFhKUjGKaXEalxu7jk6wiHgXJH07N6KE8zsGeUYN3BtS3k+X3twRBPSOKGmDsF++w13
 WfHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4HK6LpVPJn+51bNA7iymscINdBBvAIzWUG4bAJXBfd2vg8RZ5mAbz+WZcU75fyhY9/wPTpSLdcT2B@nongnu.org
X-Gm-Message-State: AOJu0Yw1yW950M1xZk7xfvXmNasEpo4gzQra4NSLfbVAOvRuTRXoG0BV
 WALbAJIcGMNKMJuECvcKdS0adKuKFZFJJ2SGqdufT9mKpmYwZsEW/T3DgEVyRuFeQcbLGr3iut2
 84H8yKkye63jQyfkoaWL+AeueYf2S6e3kIsDWR3UGv/fJg0lLFdrDaF0t
X-Gm-Gg: ASbGncsa6lQqzQmzPeABVMcL/kU2RRhPZx2Qf6zadsdiAlRlnfMF98CFOMquktaw++6
 RJ5TdnhNEkngemLaLnkN1fbZ3fg4iaMBZdY9FzyrGGgD73lBTRK4YdE5Lvo/aJbo7amQnY7Jqkh
 WaQpXklck5/4FR2rDHHD/E+qL6G6rN+FnUbGsYATDTl2lKs2afuqoU29JlRGCsAbcDnki4oH3dF
 mQY1IvJrm4EWCrlBX3YtfyjTPWMuhqKjGty3yqiKElSheeg/K0w8sHm8B2aSTPsccaMhXFiWmU4
 nSZxe2CY4BudM4EUjnaErRNOOIEQQFXgR719cPjOOp4Ugf94Ke7MXejcruW5YE/WQiCqtA==
X-Received: by 2002:a05:6000:2010:b0:3a4:eee4:cdec with SMTP id
 ffacd0b85a97d-3a56076f948mr3098096f8f.6.1749736465005; 
 Thu, 12 Jun 2025 06:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnFpP4Ar9bWrTZUbS0kW0lxD+WEl6vB+25IkREDAuNJvB1OutvJ+5zUYh3THx7QK1reIe/dw==
X-Received: by 2002:a05:6000:2010:b0:3a4:eee4:cdec with SMTP id
 ffacd0b85a97d-3a56076f948mr3098066f8f.6.1749736464405; 
 Thu, 12 Jun 2025 06:54:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232e0asm21153035e9.14.2025.06.12.06.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 06:54:23 -0700 (PDT)
Message-ID: <80b29f75-5992-4646-82e6-9a8bcf0c09e0@redhat.com>
Date: Thu, 12 Jun 2025 15:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi pcihp
 flags and props
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-3-eric.auger@redhat.com>
 <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
 <6374e8f1-8eee-49cb-9c7f-75aaed1a0f08@redhat.com>
 <20250611104915.5a5a2bea@imammedo.users.ipa.redhat.com>
 <b0be20a1-6b7f-4a0a-a228-b2f0eaca88e1@redhat.com>
 <20250612150002.6bd9b330@imammedo.users.ipa.redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250612150002.6bd9b330@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,
On 6/12/25 3:00 PM, Igor Mammedov wrote:
> On Wed, 11 Jun 2025 10:56:36 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> On 6/11/25 10:49 AM, Igor Mammedov wrote:
>>> On Wed, 11 Jun 2025 08:47:36 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>  
>>>> Hi Igor,
>>>>
>>>> On 5/27/25 1:58 PM, Igor Mammedov wrote:  
>>>>> On Tue, 27 May 2025 09:40:04 +0200
>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>    
>>>>>> acpi_pcihp VirtMachineClass state flag will allow
>>>>>> to opt in for acpi pci hotplug. This is guarded by a
>>>>>> class no_acpi_pcihp flag to manage compats (<= 10.0
>>>>>> machine types will not support ACPI PCI hotplug).    
>>>>> there is no reason to put an effort in force disabling it
>>>>> on old machines, as long as code works when explicitly
>>>>> enabled property on CLI.
>>>>>
>>>>> See comment below on how to deal with it 
>>>>>    
>>>>>> Machine state acpi_pcihp flag must be set before the creation
>>>>>> of the GED device which will use it.
>>>>>>
>>>>>> Currently the ACPI PCI HP is turned off by default. This will
>>>>>> change later on for 10.1 machine type.    
>>>>> one thing to note, is that turning it on by default might
>>>>> cause change of NIC naming in guest as this brings in
>>>>> new "_Sxx" slot naming. /so configs tied to nic  go down the drain/
>>>>>
>>>>> Naming, we have, also happens to be broken wrt spec
>>>>> (it should be unique system wide, there was a gitlab issue for that,
>>>>> there is no easy fix that though)
>>>>>
>>>>> So I'd leave it disabled by default and let users to turn
>>>>> it on explicitly when needed. 
>>>>>    
>>>>>> We also introduce properties to allow disabling it.
>>>>>>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>> ---
>>>>>>  include/hw/arm/virt.h |  2 ++
>>>>>>  hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>>>>>>  2 files changed, 29 insertions(+)
>>>>>>
>>>>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>>>>> index 9a1b0f53d2..10ea581f06 100644
>>>>>> --- a/include/hw/arm/virt.h
>>>>>> +++ b/include/hw/arm/virt.h
>>>>>> @@ -129,6 +129,7 @@ struct VirtMachineClass {
>>>>>>      bool no_tcg_lpa2;
>>>>>>      bool no_ns_el2_virt_timer_irq;
>>>>>>      bool no_nested_smmu;
>>>>>> +    bool no_acpi_pcihp;
>>>>>>  };
>>>>>>  
>>>>>>  struct VirtMachineState {
>>>>>> @@ -150,6 +151,7 @@ struct VirtMachineState {
>>>>>>      bool mte;
>>>>>>      bool dtb_randomness;
>>>>>>      bool second_ns_uart_present;
>>>>>> +    bool acpi_pcihp;
>>>>>>      OnOffAuto acpi;
>>>>>>      VirtGICType gic_version;
>>>>>>      VirtIOMMUType iommu;
>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>> index 9a6cd085a3..a0deeaf2b3 100644
>>>>>> --- a/hw/arm/virt.c
>>>>>> +++ b/hw/arm/virt.c
>>>>>> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState *machine)
>>>>>>      create_pcie(vms);
>>>>>>  
>>>>>>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>>>>>> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;    
>>>>> I don't particularly like no_foo naming as it makes code harder to read
>>>>> and combined with 'duplicated' field in machine state it make even things worse.
>>>>> (if I recall right Philippe was cleaning mess similar flags usage
>>>>> have introduced with ITS)
>>>>>
>>>>> instead of adding machine property (both class and state),
>>>>> I'd suggest adding the only property to GPE device (akin to what we have in x86 world)
>>>>> And then one can meddle with defaults using hw_compat_xxx    
>>>> What I fail to understand is whether you want me to attach this property
>>>> to the GPEX host bridge device or to the GED device. Comment on patch  
>>> I'd say GED.
>>>  
>>>> 6/25 seems to indicate you expect it to be attached to the GPEX. I ask
>>>> here because also the GED device will need to be configured depending on
>>>> the hp setting. Maybe we can retrieve the info from the gpex at that
>>>> time. on x86 it is attached to piix4 or ich9 I/O controller hub which do
>>>> not have direct equivalent on ARM.  
>>> for ARM, equivalent would be GED device which hosts our paravirt acpi registers.  
>> OK thank you for the clarification. I will add a property to the GED device.
>>
>> As the GED device is directly instantiated by the virt machine code (not
>> exposed to the end user CLI) I guess we still want a virt machine option
>> that would allow to set the property explicitly from CLI?
> Instead of machine option,
> I'd go pc/q35 way (aka -global ged.acpi-pci-hotplug-with-bridges=on/off).
> it's not as pretty as machine specific option but that would work just as well
> and as bonus could be used for microvm in the same form.

Ah OK. Then I need to rework it.

Thanks!

Eric
>
>> Thanks
>>
>> Eric  
>>>  
>>>> Thanks
>>>>
>>>> Eric  
>>>>>    
>>>>>>          vms->acpi_dev = create_acpi_ged(vms);
>>>>>>      } else {
>>>>>> +        vms->acpi_pcihp = false;
>>>>>>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>>>>>      }
>>>>>>  
>>>>>> @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>>>>>>      vms->its = value;
>>>>>>  }
>>>>>>  
>>>>>> +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
>>>>>> +{
>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>> +
>>>>>> +    return vms->acpi_pcihp;
>>>>>> +}
>>>>>> +
>>>>>> +static void virt_set_acpi_pcihp(Object *obj, bool value, Error **errp)
>>>>>> +{
>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>> +
>>>>>> +    vms->acpi_pcihp = value;
>>>>>> +}
>>>>>> +
>>>>>>  static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>>>>>>  {
>>>>>>      VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>> @@ -3310,6 +3326,10 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>>>>>>                                            "in ACPI table header."
>>>>>>                                            "The string may be up to 8 bytes in size");
>>>>>>  
>>>>>> +    object_class_property_add_bool(oc, "acpi-pcihp",
>>>>>> +                                   virt_get_acpi_pcihp, virt_set_acpi_pcihp);
>>>>>> +    object_class_property_set_description(oc, "acpi-pcihp",
>>>>>> +                                          "Force ACPI PCI hotplug");
>>>>>>  }
>>>>>>  
>>>>>>  static void virt_instance_init(Object *obj)
>>>>>> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
>>>>>>          vms->tcg_its = true;
>>>>>>      }
>>>>>>  
>>>>>> +    /* default disallows ACPI PCI hotplug */
>>>>>> +    vms->acpi_pcihp = false;
>>>>>> +
>>>>>>      /* Default disallows iommu instantiation */
>>>>>>      vms->iommu = VIRT_IOMMU_NONE;
>>>>>>  
>>>>>> @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>>>>>>  
>>>>>>  static void virt_machine_10_0_options(MachineClass *mc)
>>>>>>  {
>>>>>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>>>>>> +
>>>>>>      virt_machine_10_1_options(mc);
>>>>>>      compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
>>>>>> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
>>>>>> +    vmc->no_acpi_pcihp = true;
>>>>>>  }
>>>>>>  DEFINE_VIRT_MACHINE(10, 0)
>>>>>>      


