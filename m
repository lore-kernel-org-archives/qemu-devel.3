Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F37EC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHA0-0001e5-CJ; Wed, 11 Jun 2025 04:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPH9y-0001ay-25
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPH9u-0005NQ-T9
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749631810;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDAgyDQ1FPwQT/JvUxa0iGEzb5X5Iy/HtN0qD0xoRG4=;
 b=IwrhkLIkh3KT5CecI9HU7XduAaYLqzDTY/hw8bw6VMsCP8xoPw5zr3u0nslfNtSvnDo0+z
 w2v0XPLfuHSfDOPvFKyMGwLaySyviXlC9FjyuCL9MjyQTttM4t+FLxQ8bPmgm8UJjzcmrs
 9Y3cvgUioRojBKMXUzeQRVcKFZ/BEEc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-w8J9fMbHNwWtxVkjn3qRMQ-1; Wed, 11 Jun 2025 04:50:09 -0400
X-MC-Unique: w8J9fMbHNwWtxVkjn3qRMQ-1
X-Mimecast-MFC-AGG-ID: w8J9fMbHNwWtxVkjn3qRMQ_1749631808
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4ee113461so2300670f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 01:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749631808; x=1750236608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDAgyDQ1FPwQT/JvUxa0iGEzb5X5Iy/HtN0qD0xoRG4=;
 b=Q+K7QS3WOTHRyEkitbCyW6CEZyZ+Q79bjTw3YyRIkSPJNXjiQG3iiuZQtWy0GjaVmA
 xATrDQhmqlkON97dd+5yPdq1irFvX22DjoEpJyYinVTEaIM6wgYAfajTX/HE+56NibVo
 jOC/ZGSpNfA2ofhtaGQaN77Hu4uzAG2EEvs/mvHd/Xxhb+iGT3sifwTmdd9dHAQMIUqM
 amUzWvmNx3AHqEllUB9vjOqKwtknIZ7VAS+peImuTSxuk61v4LE2eb+Z8Ur/KkwFzgqe
 M1BG/5rrt29vNWsIaspZu5Sy61NnZUIAw02v02vGdsLqyGaqPeqQHrHy5vH4YwVDznPn
 nk9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQsbD4NW8fi9SF+naLLb03d8+J/SXPIxsWaHkSf7pZFdQFJ8FoCI6JIvA4UdCAp0tieMIqNlvz/RWg@nongnu.org
X-Gm-Message-State: AOJu0YwxvOOsK8l4xd2+HLCcLcvT3XKvd0iQEMEEu+HoguMF70c086fQ
 DHSmSxZextjpSmN3jPaqwBIJaZBkastnbLiNCvtzsbjQB6JNvH7B6RV6ZfUTza1i/VryTwUgBTq
 71/vh1IiOjPZ2h+6v2Fi4OGBZ43zrclh2PIn742618eeMkZksJHu3IJVR
X-Gm-Gg: ASbGncv7XhaENNHhnl2j4fpd5eYSJ0vm35imcp5/SaMwcKpeAu+q24YWRz29X46iy1D
 FzVzXiKT/YLFt7Qd1tYiXnjtyPpYd5PblFqlDC41EAhFihgHiFcY8iVsuOzQcRNdEYt21p9wwbM
 1mLzQXupCCx+0bNIIBkAjucAtDIc14jKvekYPto0/t8iSFKtiD2pxx0FecZ5gMT2YQK9Gl/lcAw
 95ygB3ATSyJlQHmPtNZSCGZKKVEVttmWhu7lePaBaMAWp88dbqqOLf+/NNUTJNJ/D8NOryjAGLd
 yIV/axL+JXHHuP545G3DXP0waqglD7OpwRHq2u7X63EqFyvv4oOgNP+CjVKxaRSSMa+f1g==
X-Received: by 2002:a05:6000:290f:b0:3a4:e193:e707 with SMTP id
 ffacd0b85a97d-3a558afde53mr1409416f8f.41.1749631807556; 
 Wed, 11 Jun 2025 01:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNuUf4eYhoMyRRHqoxmZ3xsGTQ9kEgQzo/oA85u5pgWfIFPz09URRziQ7vJo1Dnv9e6SBo+A==
X-Received: by 2002:a05:6000:290f:b0:3a4:e193:e707 with SMTP id
 ffacd0b85a97d-3a558afde53mr1409396f8f.41.1749631807067; 
 Wed, 11 Jun 2025 01:50:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324638e9sm14406721f8f.89.2025.06.11.01.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 01:50:06 -0700 (PDT)
Message-ID: <05680827-85d9-4ebd-91a7-93e262da52f5@redhat.com>
Date: Wed, 11 Jun 2025 10:50:04 +0200
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
 <d6bd4794-bcee-4701-8e63-4adee91120d9@redhat.com>
 <20250528123325.750529a4@imammedo.users.ipa.redhat.com>
 <13792b72-d336-41b8-8ac7-8790e10f833c@redhat.com>
 <20250611104511.55152616@imammedo.users.ipa.redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250611104511.55152616@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
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
On 6/11/25 10:45 AM, Igor Mammedov wrote:
> On Wed, 11 Jun 2025 08:53:28 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Gustavo, Alex,
>>
>> On 5/28/25 12:33 PM, Igor Mammedov wrote:
>>> On Tue, 27 May 2025 15:54:15 +0200
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
>>>> what is the status on q35, isn't it enabled by default? If so why
>>>> wouldn't we want the same setting on ARM? Is that because of the known
>>>> issue you report above?  
>>> Above issue is not a blocker (for thae lack of a good way to fix it)
>>>
>>> on q35 we have had a few complains and fixes, after pcihp was promoted
>>> to default (so hopefully that won't happen on with ARM). Also given
>>> that ARM VM is less popular like hood breaking someone setup is even less.
>>>
>>> That said I'd be cautions keep native hotplug as default,
>>> and only ones who need ACPI one, could turn it on explicitly.
>>>
>>> But well it's policies, so it's up to you ARM folks to decide what
>>> virt board should look like.  
>> What is your preference? Do you prefer enabling ACPI PCI HP by default
>> or the opposite.
> I'd prefer native PCIe hotplug being default,
> that way we have less chance of causing regressions not to mention
> less complexity (as acpi pcihp adds up quite a bit of it).
>
> And ones who want/need acpi-pcihp/acpi-index can enable it explicitly,
> to play with.

OK I will follow your suggestion. You have definitively more expertise
than me here ! ;-)

Thanks!

Eric
>
>> Anybody else?
>>
>> On my end I think I would prefer to have the same default setting than
>> on x86 (ie. ACPI PCI hotplug set by default) but I have no strong
>> opinion either.
>>
>> Thanks
>>
>> Eric
>>>  
>>>> The no_foo compat stuff was especially introduced to avoid breaking the
>>>> guest ABI for old machine types (like the NIC naming alternation you evoke).  
>>> no_foo is just another way to handle compat stuff,
>>> and when it's more than one knob per feature it gets ugly really fast.
>>> Hence, I'd prefer pcihp done in x86 way aka:
>>>    hw_compat_OLD(ged.use_acpi_hotplug_bridge, false|true)
>>> to manage presence of ACPI hotplug on desired machine version.
>>> Side benefit it's consistent with how pcihp works on x86
>>>  
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
>>>> no_foo still is a largely used pattern in arm virt: no_ged,
>>>> kvm_no_adjvtime, no_kvm_steal_time, no_tcg_lpa2, ../.. There are plenty
>>>> of them and I am not under the impression this is going to be changed.
>>>>
>>>> If you refer to 8d23b1df7212 ("hw/arm/virt: Remove
>>>> VirtMachineClass::no_its field") I think the no_its was removed because
>>>> the machine it applied was removed.
>>>>
>>>> If I understand correctly you would like the prop to be attached to the
>>>> GED device. However the GED device is internally created by the virt
>>>> machine code and not passed through a "-device" CLI option. So how would
>>>> you pass the option on the cmd line if you don't want it to be set by
>>>> default per machine type?
>>>>
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


