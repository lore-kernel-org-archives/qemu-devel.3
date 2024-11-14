Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA6DD65C5A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 08:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVQn-0007Ju-0Y; Thu, 14 Nov 2024 03:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBVQj-0007Ja-V1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 03:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBVQh-00065h-6I
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 03:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731573738;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQkc4NSGH486X0NuA7/FDzdTttRtFmtgf7xbXoHO2wI=;
 b=ithURzjXNfJqNOhHUdTKs6W5oGjWE3gYmj8NRFHIjh91Ooy2MrKS1RWZg+zOH/B+CH1MjY
 GzxwHqIFvf9q7hVPIy4kW/GKfHxaWsTk60oSDajzibCcZws/4uGSlc1103VNaOmru/zqOX
 QGaBa/evzkyA/1fmiGX1IYkJp28Tk/A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-5g4FFXwnMA2NO4eCgavqig-1; Thu, 14 Nov 2024 03:42:16 -0500
X-MC-Unique: 5g4FFXwnMA2NO4eCgavqig-1
X-Mimecast-MFC-AGG-ID: 5g4FFXwnMA2NO4eCgavqig
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-20c77c8352dso3754665ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 00:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731573736; x=1732178536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zQkc4NSGH486X0NuA7/FDzdTttRtFmtgf7xbXoHO2wI=;
 b=cbUnFb3wGLUqcbZbmDRRPu5XvSUxdkLfsfcbWSacU+4jo6gzHzxXnUrUq8hN7nzDW5
 xYwSWHgLMdvutQgjeFixUI98f0P1cEjgTnshMOYowgEPYzrfwBWJ+cLN0B9q0Vyh92rL
 Th4CZFtXRdL5TBzE5KI+rrhRYElhLcnGrqmXTnboeydiu+xSUYr6SA4N57pjIDxhCjQv
 ROx1mUgf10geWeDUzw4PLbzQ4pj/uIyxQSrDncSqV3wERSuGzMKGPqdYvO84ItLJ6559
 4yiJXF6MUIDsAsLQBkPzpjiAFTTWatJagP2+JxMiN5P5qOALTp45SgK3lsPo+rpC7sqK
 xi+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYHccTeiiM7TInZN8wRQ2eWNxY1NDjNJxpuf+pI+fAxhMcdW+wY98QMWIcWN79tw6+hdvqgD2+VYoR@nongnu.org
X-Gm-Message-State: AOJu0YxbWax05TvntiuJ1gYCmZa25v83DEK8r0vXkj5cw3gonPOylkGm
 lTOPNKq03g2SmIxwvqLizCEB0GgE6eWALXGjCvizYPLvpba9Sj9wiVnu1BEy8HLJrZGqKs7COtJ
 9des4nRsKXkIHKoqr7mxryFhCiylMtySFt4tTk4uM8NlKhyZeju/O
X-Received: by 2002:a05:6214:469b:b0:6cb:f0ec:b31e with SMTP id
 6a1803df08f44-6d39e1e92bdmr341064446d6.42.1731573724729; 
 Thu, 14 Nov 2024 00:42:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE06Me62CuweLjbeZb6N7rwHyocwcOQdhiiJlQuaiXowV1u4zuHJWow9a9x0WcTxJ38s6eH3Q==
X-Received: by 2002:a05:6214:469b:b0:6cb:f0ec:b31e with SMTP id
 6a1803df08f44-6d39e1e92bdmr341064186d6.42.1731573724224; 
 Thu, 14 Nov 2024 00:42:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3ee7ab148sm3135426d6.41.2024.11.14.00.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 00:42:03 -0800 (PST)
Message-ID: <991e3963-245e-41af-b128-431520c7d4e3@redhat.com>
Date: Thu, 14 Nov 2024 09:41:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <7a3b6dcb5db349f5a7e718784ef46c97@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7a3b6dcb5db349f5a7e718784ef46c97@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

Hi Shameer,

On 11/14/24 09:20, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, November 13, 2024 5:12 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for
>> SMMUv3 Nested device
>>
>> Hi Shameer,
>> On 11/8/24 13:52, Shameer Kolothum wrote:
>>> Based on SMMUv3 as a parent device, add a user-creatable smmuv3-
>> nested
>>> device. Subsequent patches will add support to specify a PCI bus for
>>> this device.
>>>
>>> Currently only supported for "virt", so hook up the sybus mem & irq
>>> for that  as well.
>>>
>>> No FDT support is added for now.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/smmuv3.c         | 34 ++++++++++++++++++++++++++++++++++
>>>  hw/arm/virt.c           | 31 +++++++++++++++++++++++++++++--
>>>  hw/core/sysbus-fdt.c    |  1 +
>>>  include/hw/arm/smmuv3.h | 15 +++++++++++++++
>>>  include/hw/arm/virt.h   |  6 ++++++
>>>  5 files changed, 85 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c index
>>> 2101031a8f..0033eb8125 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -2201,6 +2201,19 @@ static void smmu_realize(DeviceState *d, Error
>> **errp)
>>>      smmu_init_irq(s, dev);
>>>  }
>>>
>>> +static void smmu_nested_realize(DeviceState *d, Error **errp) {
>>> +    SMMUv3NestedState *s_nested = ARM_SMMUV3_NESTED(d);
>> nit: s/s_nested/ns or just s?
>>> +    SMMUv3NestedClass *c =
>> ARM_SMMUV3_NESTED_GET_CLASS(s_nested);
>>> +    Error *local_err = NULL;
>>> +
>>> +    c->parent_realize(d, &local_err);
>> I think it is safe to use errp directly here.
> Ok.
>
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +}
>>> +
>>>  static const VMStateDescription vmstate_smmuv3_queue = {
>>>      .name = "smmuv3_queue",
>>>      .version_id = 1,
>>> @@ -2299,6 +2312,18 @@ static void smmuv3_class_init(ObjectClass
>> *klass, void *data)
>>>      device_class_set_props(dc, smmuv3_properties);  }
>>>
>>> +static void smmuv3_nested_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +    SMMUv3NestedClass *c = ARM_SMMUV3_NESTED_CLASS(klass);
>>> +
>>> +    dc->vmsd = &vmstate_smmuv3;
>>> +    device_class_set_parent_realize(dc, smmu_nested_realize,
>>> +                                    &c->parent_realize);
>>> +    dc->user_creatable = true;
>>> +    dc->hotpluggable = false;
>>> +}
>>> +
>>>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>>                                        IOMMUNotifierFlag old,
>>>                                        IOMMUNotifierFlag new, @@
>>> -2337,6 +2362,14 @@ static void
>> smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>>>      imrc->notify_flag_changed = smmuv3_notify_flag_changed;  }
>>>
>>> +static const TypeInfo smmuv3_nested_type_info = {
>>> +    .name          = TYPE_ARM_SMMUV3_NESTED,
>>> +    .parent        = TYPE_ARM_SMMUV3,
>>> +    .instance_size = sizeof(SMMUv3NestedState),
>>> +    .class_size    = sizeof(SMMUv3NestedClass),
>>> +    .class_init    = smmuv3_nested_class_init,
>>> +};
>>> +
>>>  static const TypeInfo smmuv3_type_info = {
>>>      .name          = TYPE_ARM_SMMUV3,
>>>      .parent        = TYPE_ARM_SMMU,
>>> @@ -2355,6 +2388,7 @@ static const TypeInfo
>>> smmuv3_iommu_memory_region_info = {  static void
>>> smmuv3_register_types(void)  {
>>>      type_register(&smmuv3_type_info);
>>> +    type_register(&smmuv3_nested_type_info);
>>>      type_register(&smmuv3_iommu_memory_region_info);
>>>  }
>>>
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
>>> 780bcff77c..38075f9ab2 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -181,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
>>>      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>>>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>>>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>>> +    [VIRT_SMMU_NESTED] =        { 0x0b000000, 0x01000000 },
>> I agree with Mostafa that the _NESTED terminology may not be the best
>> choice.
> Yes. Agree.
Nicolin's suggestion to use a reference to HW acceleration looks
sensible to me.
>
>> The motivation behind that multi-instance attempt, as introduced in
>> https://lore.kernel.org/all/ZEcT%2F7erkhHDaNvD@Asurada-Nvidia/
>> was:
>> - SMMUs with different feature bits
>> - support of VCMDQ HW extension for SMMU CMDQ
>> - need for separate S1 invalidation paths
>>
>> If I understand correctly this is mostly wanted for VCMDQ handling? if this
>> is correct we may indicate that somehow in the terminology.
>>
> Not just for VCMDQ, but it benefits when we have multiple physical SMMUv3
> instances as well.
>
>> If I understand correctly VCMDQ terminology is NVidia specific while ECMDQ
>> is the baseline (?).
> Yes, VCMDQ is NVIDIA specific. And ECMDQ is ARM SMMUv3, but don’t think we
> can associate ECMDQ with a virtual SMMUv3.
ok
>
>>>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that
>> size */
>>>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
>>>      [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
>>> @@ -226,6 +227,7 @@ static const int a15irqmap[] = {
>>>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>>>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
>>>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS
>>> -1 */
>>> +    [VIRT_SMMU_NESTED] = 200,
>> What is the max IRQs expected to be consumed. Wother to comment for
>> next interrupt user.
> Depends on how many we plan to support max  and each requires minimum 4. I will
> update with a  comment here.
>
>>>  };
>>>
>>>  static void create_randomness(MachineState *ms, const char *node) @@
>>> -2883,10 +2885,34 @@ static void
>> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>>                                          DeviceState *dev, Error
>>> **errp)  {
>>>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>>> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
>>>
>>> -    if (vms->platform_bus_dev) {
>>> -        MachineClass *mc = MACHINE_GET_CLASS(vms);
>>> +    /* For smmuv3-nested devices we need to set the mem & irq */
>>> +    if (device_is_dynamic_sysbus(mc, dev) &&
>>> +        object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_NESTED)) {
>> why did you choose not using the PLATFORM BUS infra which does that
>> kind of binding automatically (also it provisions for dedicated MMIOs and
>> IRQs). At least you would need to justify in the commit msg I think
> Because I was not  sure how to do this binding otherwise. I couldn't find
> any such precedence  for a  dynamic platform bus dev binding 
> MMIOs/IRQs(May be I didn't look hard). I mentioned it in cover letter.
>
> Could you please give me some pointers/example for this? I will also
> take another look.
vfio platform users such automatic binding (however you must check that
vfio platform bus mmio and irq space is large enough for your needs).

the binding is transparently handled by
    if (vms->platform_bus_dev) {
        if (device_is_dynamic_sysbus(mc, dev)) {
           
platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
                                     SYS_BUS_DEVICE(dev));
        }
    }


>
>>> +        hwaddr base = vms->memmap[VIRT_SMMU_NESTED].base;
>>> +        int irq =  vms->irqmap[VIRT_SMMU_NESTED];
>>> +
>>> +        if (vms->smmu_nested_count >= MAX_SMMU_NESTED) {
>>> +            error_setg(errp, "smmuv3-nested max count reached!");
>>> +            return;
>>> +        }
>>> +
>>> +        base += (vms->smmu_nested_count * SMMU_IO_LEN);
>>> +        irq += (vms->smmu_nested_count * NUM_SMMU_IRQS);
>>>
>>> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>> +        for (int i = 0; i < 4; i++) {
>>> +            sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>>> +                               qdev_get_gpio_in(vms->gic, irq + i));
>>> +        }
>>> +        if (vms->iommu != VIRT_IOMMU_SMMUV3_NESTED) {
>>> +            vms->iommu = VIRT_IOMMU_SMMUV3_NESTED;
>>> +        }
>>> +        vms->smmu_nested_count++;
>> this kind of check would definitively not integrated in the platform bus but
>> this could be introduced generically in the framework though or special
>> cased after the platform_bus_link_device
> Ok. So I assume there is a better way to link the MMIOs/IRQs as you mentioned 
> above and we can add another helper to track this count as well.
>
>>> +    }
>>> +
>>> +    if (vms->platform_bus_dev) {
>>>          if (device_is_dynamic_sysbus(mc, dev)) {
>>>              platform_bus_link_device(PLATFORM_BUS_DEVICE(vms-
>>> platform_bus_dev),
>>>                                       SYS_BUS_DEVICE(dev)); @@ -3067,6
>>> +3093,7 @@ static void virt_machine_class_init(ObjectClass *oc, void
>> *data)
>>>      machine_class_allow_dynamic_sysbus_dev(mc,
>> TYPE_VFIO_AMD_XGBE);
>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>>>      machine_class_allow_dynamic_sysbus_dev(mc,
>> TYPE_VFIO_PLATFORM);
>>> +    machine_class_allow_dynamic_sysbus_dev(mc,
>>> + TYPE_ARM_SMMUV3_NESTED);
>>>  #ifdef CONFIG_TPM
>>>      machine_class_allow_dynamic_sysbus_dev(mc,
>> TYPE_TPM_TIS_SYSBUS);
>>> #endif diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c index
>>> eebcd28f9a..0f0d0b3e58 100644
>>> --- a/hw/core/sysbus-fdt.c
>>> +++ b/hw/core/sysbus-fdt.c
>>> @@ -489,6 +489,7 @@ static const BindingEntry bindings[] = {  #ifdef
>>> CONFIG_LINUX
>>>      TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC,
>> add_calxeda_midway_xgmac_fdt_node),
>>>      TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
>>> +    TYPE_BINDING("arm-smmuv3-nested", no_fdt_node),
>>>      VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a",
>>> add_amd_xgbe_fdt_node),  #endif  #ifdef CONFIG_TPM diff --git
>>> a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h index
>>> d183a62766..87e628be7a 100644
>>> --- a/include/hw/arm/smmuv3.h
>>> +++ b/include/hw/arm/smmuv3.h
>>> @@ -84,6 +84,21 @@ struct SMMUv3Class {
>>>  #define TYPE_ARM_SMMUV3   "arm-smmuv3"
>>>  OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
>>>
>>> +#define TYPE_ARM_SMMUV3_NESTED   "arm-smmuv3-nested"
>>> +OBJECT_DECLARE_TYPE(SMMUv3NestedState, SMMUv3NestedClass,
>>> +ARM_SMMUV3_NESTED)
>>> +
>>> +struct SMMUv3NestedState {
>>> +    SMMUv3State smmuv3_state;
>>> +};
>>> +
>>> +struct SMMUv3NestedClass {
>>> +    /*< private >*/
>>> +    SMMUv3Class smmuv3_class;
>>> +    /*< public >*/
>>> +
>>> +    DeviceRealize parent_realize;
>>> +};
>>> +
>>>  #define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
>>>  #define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
>>>
>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
>>> 46f48fe561..50e47a4ef3 100644
>>> --- a/include/hw/arm/virt.h
>>> +++ b/include/hw/arm/virt.h
>>> @@ -50,6 +50,9 @@
>>>  /* MMIO region size for SMMUv3 */
>>>  #define SMMU_IO_LEN 0x20000
>>>
>>> +/* Max supported nested SMMUv3 */    if (vms->platform_bus_dev) {
>>>         if (device_is_dynamic_sysbus(mc, dev)) {
>>>             platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
>>>                                      SYS_BUS_DEVICE(dev));
>>>         }
>>>     }
>>>
>>> +#define MAX_SMMU_NESTED 128
>> Ouch, that many?!
> 😊. I just came up with the max we can support the allocated MMIO space.
> We do have systems at present which has 8 physical SMMUv3s at the moment.
> Probably 16/32 would be a better number I guess.
OK thanks

Eric
>
> Thanks,
> Shameer


