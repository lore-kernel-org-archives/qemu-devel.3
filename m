Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9195DC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 05:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPwbz-0001Pa-Uj; Fri, 13 Jun 2025 01:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPwbW-0001NW-E6
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 01:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPwbR-00005j-Nh
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 01:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749791119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMxIr67GsAt1Z4qW9pogz4vadnhRgUPhQ68fi5VaJBs=;
 b=fnWuEtfm8X0AQN+ez668iOZo5EmNKVMLgrfcbcVRAo3edcJBgh6KvFsKuxI38qlBVVfycx
 PYPh+xzD3IMiSikg1bjI5V1lyubn/jPV0k72OtNbvx25zyg1sAMtMxhx7QLB/ujah6lXGE
 0p8Jt80af3d/PGgRO6f6qntnZnE5ldw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-aDJOSIjyOjyhS6Q1SWE3pA-1; Fri, 13 Jun 2025 01:05:17 -0400
X-MC-Unique: aDJOSIjyOjyhS6Q1SWE3pA-1
X-Mimecast-MFC-AGG-ID: aDJOSIjyOjyhS6Q1SWE3pA_1749791117
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso1283304f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 22:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749791116; x=1750395916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mMxIr67GsAt1Z4qW9pogz4vadnhRgUPhQ68fi5VaJBs=;
 b=gvys4f5NnT9NhbysltzIFROQaFTUzIaq/zpkssTDGE4hbSug0wTwwAICxG6YTiMoQj
 cqbL/Td2taQUGqOuIqxX6g9QqUtyRZGucJ3LSruyiEOAwzBpt/Ja3A6IGI+3VennDXZ1
 0/oiM51My3QUqzXxXJaAhrjAdskrzGBr0m2fXr0LNoXdFxW1DaUMJB2k3COHDDtLJzr9
 S6+HGbXZ7GLAweoFgFL+2W0JJwA2Y/XeoqS7we4A98iwOfz4KuK2GjIv3qcAVY5BpU0c
 GdcZeGudBazrs3GH+L1C0lhpVOjEnhnhy1VQsgoi7WIo6h3QtRWb7Us80tEKCMurnPpY
 Lx6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsWKjQNrh0NVcDMF+l4ZmfjLJq/oF84MxuCpqn6oWzfmdY3M1yPw4V6TORs/yiPGodIv5EsKCc5Gow@nongnu.org
X-Gm-Message-State: AOJu0Yw0A50NB6uSXtsLj92kEGIf+MSr6TxnQy41x8igNd/yc9cIBFgK
 r88PKztXz52j+tEtd6el4Al83SuuZ9t2X0uzEyBmNsVL7Dg+C0q9iop9y9nOaz6M43Qqbsp50Fy
 n3r7ocOdrBFkxkhAIoxnbe5S8h6ypH3RQqemHwEzQG5JUGnQ9kmD6gtVG
X-Gm-Gg: ASbGncvUd6CfCVeryJhDY3N3Fnn2GpV3xoGcLQ5u1rJWBBotmh8BjT80bhoMCAMEhrH
 3agqeho3+wvUaa2XiH/Sw5GxKBr4iyDgGcnT1XRdVNIORUUUTHjxE2M1ICrlTN9Gqab8wpEWBe+
 FVAdbcfa39YV+q4eY7OZBbfGWn8vjrsnrIBRmmPf9sqpQ8+PJXm1WFIf4zjCIR7tzz1MukP3EMn
 P1KFckqPe3j86xO6ceYriI0yFqibOriZQ/r7nf6xfU5q2tKFPGTvf28lYopo5Gbshm+4MGx6+2W
 2dKGVWdm15DBmRrnlcmthMatOrLZsKZYsw59rpOfBFbljXhH03KYDwJe8JqqFl1rUzlSow==
X-Received: by 2002:a05:6000:310e:b0:3a5:52d4:5b39 with SMTP id
 ffacd0b85a97d-3a5686831camr1278051f8f.8.1749791116436; 
 Thu, 12 Jun 2025 22:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYzQli9l+CeCil/JQSfu5phOSxFlx43BZ5XJcfNYDR1q5Drwy4uXFnaoUY5VbQqTkU2XFsqg==
X-Received: by 2002:a05:6000:310e:b0:3a5:52d4:5b39 with SMTP id
 ffacd0b85a97d-3a5686831camr1278022f8f.8.1749791115841; 
 Thu, 12 Jun 2025 22:05:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b087b4sm1194957f8f.51.2025.06.12.22.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 22:05:14 -0700 (PDT)
Message-ID: <46cb9903-7a00-4e43-9b0e-03707e4952d3@redhat.com>
Date: Fri, 13 Jun 2025 07:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi pcihp
 flags and props
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, Jonathan.Cameron@huawei.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-3-eric.auger@redhat.com>
 <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
 <d6bd4794-bcee-4701-8e63-4adee91120d9@redhat.com>
 <20250528123325.750529a4@imammedo.users.ipa.redhat.com>
 <13792b72-d336-41b8-8ac7-8790e10f833c@redhat.com>
 <20250611104511.55152616@imammedo.users.ipa.redhat.com>
 <05680827-85d9-4ebd-91a7-93e262da52f5@redhat.com>
 <20250612145537.7dff93a8@imammedo.users.ipa.redhat.com>
 <61599d8b-d83d-44ff-8c4d-86bf90ebbb4c@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <61599d8b-d83d-44ff-8c4d-86bf90ebbb4c@linaro.org>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/13/25 5:01 AM, Gustavo Romero wrote:
> Hi Eric,
>
> On 6/12/25 09:55, Igor Mammedov wrote:
>> On Wed, 11 Jun 2025 10:50:04 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> Hi Igor,
>>> On 6/11/25 10:45 AM, Igor Mammedov wrote:
>>>> On Wed, 11 Jun 2025 08:53:28 +0200
>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>  
>>>>> Hi Gustavo, Alex,
>>>>>
>>>>> On 5/28/25 12:33 PM, Igor Mammedov wrote:
>>>>>> On Tue, 27 May 2025 15:54:15 +0200
>>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>>    
>>>>>>> Hi Igor,
>>>>>>>
>>>>>>> On 5/27/25 1:58 PM, Igor Mammedov wrote:
>>>>>>>> On Tue, 27 May 2025 09:40:04 +0200
>>>>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>>>>      
>>>>>>>>> acpi_pcihp VirtMachineClass state flag will allow
>>>>>>>>> to opt in for acpi pci hotplug. This is guarded by a
>>>>>>>>> class no_acpi_pcihp flag to manage compats (<= 10.0
>>>>>>>>> machine types will not support ACPI PCI hotplug).
>>>>>>>> there is no reason to put an effort in force disabling it
>>>>>>>> on old machines, as long as code works when explicitly
>>>>>>>> enabled property on CLI.
>>>>>>>>
>>>>>>>> See comment below on how to deal with it
>>>>>>>>      
>>>>>>>>> Machine state acpi_pcihp flag must be set before the creation
>>>>>>>>> of the GED device which will use it.
>>>>>>>>>
>>>>>>>>> Currently the ACPI PCI HP is turned off by default. This will
>>>>>>>>> change later on for 10.1 machine type.
>>>>>>>> one thing to note, is that turning it on by default might
>>>>>>>> cause change of NIC naming in guest as this brings in
>>>>>>>> new "_Sxx" slot naming. /so configs tied to nic  go down the
>>>>>>>> drain/
>>>>>>>>
>>>>>>>> Naming, we have, also happens to be broken wrt spec
>>>>>>>> (it should be unique system wide, there was a gitlab issue for
>>>>>>>> that,
>>>>>>>> there is no easy fix that though)
>>>>>>>>
>>>>>>>> So I'd leave it disabled by default and let users to turn
>>>>>>>> it on explicitly when needed.
>>>>>>> what is the status on q35, isn't it enabled by default? If so why
>>>>>>> wouldn't we want the same setting on ARM? Is that because of the
>>>>>>> known
>>>>>>> issue you report above?
>>>>>> Above issue is not a blocker (for thae lack of a good way to fix it)
>>>>>>
>>>>>> on q35 we have had a few complains and fixes, after pcihp was
>>>>>> promoted
>>>>>> to default (so hopefully that won't happen on with ARM). Also given
>>>>>> that ARM VM is less popular like hood breaking someone setup is
>>>>>> even less.
>>>>>>
>>>>>> That said I'd be cautions keep native hotplug as default,
>>>>>> and only ones who need ACPI one, could turn it on explicitly.
>>>>>>
>>>>>> But well it's policies, so it's up to you ARM folks to decide what
>>>>>> virt board should look like.
>>>>> What is your preference? Do you prefer enabling ACPI PCI HP by
>>>>> default
>>>>> or the opposite.
>>>> I'd prefer native PCIe hotplug being default,
>>>> that way we have less chance of causing regressions not to mention
>>>> less complexity (as acpi pcihp adds up quite a bit of it).
>>>>
>>>> And ones who want/need acpi-pcihp/acpi-index can enable it explicitly,
>>>> to play with.
>>>
>>> OK I will follow your suggestion. You have definitively more expertise
>>> than me here ! ;-)
>>
>> So far what I suggest looks like better option compared to multiple
>> machine knobs
>> fiddling. But I can easily change my mind once I see respin, if
>> experiment
>> with compat props is not coming well together.
>
> For now, I think it's okay to let ACPI PCI hotplug stabilize (while
> not being the
> default) for at least one release cycle. So I'm fine with keeping
> acpi-pcihp=off as
> the default.
>
> As I mentioned elsewhere, I don't consider native PCIe hotplug to be
> legacy.
>
> We can make acpi-pcihp=on the default in a future release once it's
> been more
> widely exercised.
>
> I'll update the bios-tables-test.c test accordingly, then you can
> either put them
> in the v3 (if you happen to send v3 next week) or add them to a v4.

OK thank you for the confirmation. So following Igor's suggestion I
indeed kept the current default value (legacy PCIe hotplug) and I don't
use a machine option anymore. Instead I use the x86 trick, ie.

-global acpi-ged.acpi-pci-hotplug-with-bridge-support=on

I can easily update your tests with that option, don't bother
respinning. I should be able to send the v3 by beginning of next week.

Thanks!

Eric

>
>
> Cheers,
> Gustavo
>
>>> Thanks!
>>>
>>> Eric
>>>>  
>>>>> Anybody else?
>>>>>
>>>>> On my end I think I would prefer to have the same default setting
>>>>> than
>>>>> on x86 (ie. ACPI PCI hotplug set by default) but I have no strong
>>>>> opinion either.
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>>    
>>>>>>> The no_foo compat stuff was especially introduced to avoid
>>>>>>> breaking the
>>>>>>> guest ABI for old machine types (like the NIC naming alternation
>>>>>>> you evoke).
>>>>>> no_foo is just another way to handle compat stuff,
>>>>>> and when it's more than one knob per feature it gets ugly really
>>>>>> fast.
>>>>>> Hence, I'd prefer pcihp done in x86 way aka:
>>>>>>     hw_compat_OLD(ged.use_acpi_hotplug_bridge, false|true)
>>>>>> to manage presence of ACPI hotplug on desired machine version.
>>>>>> Side benefit it's consistent with how pcihp works on x86
>>>>>>    
>>>>>>>>      
>>>>>>>>> We also introduce properties to allow disabling it.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>>>>> ---
>>>>>>>>>   include/hw/arm/virt.h |  2 ++
>>>>>>>>>   hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>>>>>>>>>   2 files changed, 29 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>>>>>>>>> index 9a1b0f53d2..10ea581f06 100644
>>>>>>>>> --- a/include/hw/arm/virt.h
>>>>>>>>> +++ b/include/hw/arm/virt.h
>>>>>>>>> @@ -129,6 +129,7 @@ struct VirtMachineClass {
>>>>>>>>>       bool no_tcg_lpa2;
>>>>>>>>>       bool no_ns_el2_virt_timer_irq;
>>>>>>>>>       bool no_nested_smmu;
>>>>>>>>> +    bool no_acpi_pcihp;
>>>>>>>>>   };
>>>>>>>>>     struct VirtMachineState {
>>>>>>>>> @@ -150,6 +151,7 @@ struct VirtMachineState {
>>>>>>>>>       bool mte;
>>>>>>>>>       bool dtb_randomness;
>>>>>>>>>       bool second_ns_uart_present;
>>>>>>>>> +    bool acpi_pcihp;
>>>>>>>>>       OnOffAuto acpi;
>>>>>>>>>       VirtGICType gic_version;
>>>>>>>>>       VirtIOMMUType iommu;
>>>>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>>>>> index 9a6cd085a3..a0deeaf2b3 100644
>>>>>>>>> --- a/hw/arm/virt.c
>>>>>>>>> +++ b/hw/arm/virt.c
>>>>>>>>> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState
>>>>>>>>> *machine)
>>>>>>>>>       create_pcie(vms);
>>>>>>>>>         if (has_ged && aarch64 && firmware_loaded &&
>>>>>>>>> virt_is_acpi_enabled(vms)) {
>>>>>>>>> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
>>>>>>>> I don't particularly like no_foo naming as it makes code harder
>>>>>>>> to read
>>>>>>>> and combined with 'duplicated' field in machine state it make
>>>>>>>> even things worse.
>>>>>>>> (if I recall right Philippe was cleaning mess similar flags usage
>>>>>>>> have introduced with ITS)
>>>>>>>>
>>>>>>>> instead of adding machine property (both class and state),
>>>>>>>> I'd suggest adding the only property to GPE device (akin to
>>>>>>>> what we have in x86 world)
>>>>>>>> And then one can meddle with defaults using hw_compat_xxx
>>>>>>> no_foo still is a largely used pattern in arm virt: no_ged,
>>>>>>> kvm_no_adjvtime, no_kvm_steal_time, no_tcg_lpa2, ../.. There are
>>>>>>> plenty
>>>>>>> of them and I am not under the impression this is going to be
>>>>>>> changed.
>>>>>>>
>>>>>>> If you refer to 8d23b1df7212 ("hw/arm/virt: Remove
>>>>>>> VirtMachineClass::no_its field") I think the no_its was removed
>>>>>>> because
>>>>>>> the machine it applied was removed.
>>>>>>>
>>>>>>> If I understand correctly you would like the prop to be attached
>>>>>>> to the
>>>>>>> GED device. However the GED device is internally created by the
>>>>>>> virt
>>>>>>> machine code and not passed through a "-device" CLI option. So
>>>>>>> how would
>>>>>>> you pass the option on the cmd line if you don't want it to be
>>>>>>> set by
>>>>>>> default per machine type?
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Eric
>>>>>>>>      
>>>>>>>>>           vms->acpi_dev = create_acpi_ged(vms);
>>>>>>>>>       } else {
>>>>>>>>> +        vms->acpi_pcihp = false;
>>>>>>>>>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>>>>>>>>       }
>>>>>>>>>   @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj,
>>>>>>>>> bool value, Error **errp)
>>>>>>>>>       vms->its = value;
>>>>>>>>>   }
>>>>>>>>>   +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>>> +
>>>>>>>>> +    return vms->acpi_pcihp;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static void virt_set_acpi_pcihp(Object *obj, bool value,
>>>>>>>>> Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>>> +
>>>>>>>>> +    vms->acpi_pcihp = value;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>   static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>>>>>>>>>   {
>>>>>>>>>       VirtMachineState *vms = VIRT_MACHINE(obj);
>>>>>>>>> @@ -3310,6 +3326,10 @@ static void
>>>>>>>>> virt_machine_class_init(ObjectClass *oc, const void *data)
>>>>>>>>>                                             "in ACPI table
>>>>>>>>> header."
>>>>>>>>>                                             "The string may be
>>>>>>>>> up to 8 bytes in size");
>>>>>>>>>   +    object_class_property_add_bool(oc, "acpi-pcihp",
>>>>>>>>> +                                   virt_get_acpi_pcihp,
>>>>>>>>> virt_set_acpi_pcihp);
>>>>>>>>> +    object_class_property_set_description(oc, "acpi-pcihp",
>>>>>>>>> +                                          "Force ACPI PCI
>>>>>>>>> hotplug");
>>>>>>>>>   }
>>>>>>>>>     static void virt_instance_init(Object *obj)
>>>>>>>>> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
>>>>>>>>>           vms->tcg_its = true;
>>>>>>>>>       }
>>>>>>>>>   +    /* default disallows ACPI PCI hotplug */
>>>>>>>>> +    vms->acpi_pcihp = false;
>>>>>>>>> +
>>>>>>>>>       /* Default disallows iommu instantiation */
>>>>>>>>>       vms->iommu = VIRT_IOMMU_NONE;
>>>>>>>>>   @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>>>>>>>>>     static void virt_machine_10_0_options(MachineClass *mc)
>>>>>>>>>   {
>>>>>>>>> +    VirtMachineClass *vmc =
>>>>>>>>> VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>>>>>>>>> +
>>>>>>>>>       virt_machine_10_1_options(mc);
>>>>>>>>>       compat_props_add(mc->compat_props, hw_compat_10_0,
>>>>>>>>> hw_compat_10_0_len);
>>>>>>>>> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
>>>>>>>>> +    vmc->no_acpi_pcihp = true;
>>>>>>>>>   }
>>>>>>>>>   DEFINE_VIRT_MACHINE(10, 0)
>>>>>>>>>         
>>>
>>
>


