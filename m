Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C8FC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 01:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvQjo-0008Im-Bk; Thu, 20 Mar 2025 20:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvQjm-0008IB-1X
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvQjj-0006Et-D1
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742518785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNQuGkuOojxbTctffvW3xyBknRtXGVmfbkBsNlqOf4A=;
 b=GaRWoFrEs42UBF/ohrsxjZsakkjTSmsbW7I7Jo8OxhjSTCp/Jqsbmu9v4TB+aNjaDsFpdI
 KAr/rv4qgd5cl2QyuAe8qV74dv4TwgbrYfv1/mbZGl1FNahPSJDNOjJQGE4ylf6FiKDnm8
 7pQ76qlxWRqWOADsWA9Thd3h5R7g0m4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-w_m4SvifMkavQYKDZGTT3Q-1; Thu, 20 Mar 2025 20:59:43 -0400
X-MC-Unique: w_m4SvifMkavQYKDZGTT3Q-1
X-Mimecast-MFC-AGG-ID: w_m4SvifMkavQYKDZGTT3Q_1742518783
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85b3f480d86so123647139f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 17:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742518783; x=1743123583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wNQuGkuOojxbTctffvW3xyBknRtXGVmfbkBsNlqOf4A=;
 b=UmwPR0IJ0onKcAR9P0FLQpkpAZ7nNMJYLWvfk0FxPkALdM2EPtTBQoTBHvQTD4E6Us
 RkvtXXsi8gMf//Ip963RJpf62hkR2ZbnLylm2/oHJJllWr7KMFvvfmV8WjEt9etv0QC2
 TDCWoT+MYQHtLiOa8tPiFjyT+81ilH/ySb2VsJLZIrMm5+sYl/yXAobvvh+DUR0nFHRC
 oChneXvHbT/9FkJ8abJLUL3g9ej/8tFyJQCDFA2kKPWD7QLF+E2wrRGDHCLvINpwV9w2
 7Pg6qzcMaUxGd5LY/kaig0GbRa2VV+Q3xWWtnfMedwiImFKEO9DSK3WA/8UUjB3H1+Ke
 dh5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6n0QrBRKmd/QyRTffADodtJqyuoS+x/H1D3M1KTuWdl8H9fMd3K4AfAkdtkXwrcol+vvYsVyALUeX@nongnu.org
X-Gm-Message-State: AOJu0Yxq3kU6khh/55beG/HQ8eADbvP3yGYgXAGXPCW2Jc9inMJhHf9l
 RyKYNX7VBkhauHI4QWdUoxWRHZ9+pI3WIbYg1ocXVZrK9ihNQgMTZEC00lmCr4FVBxi/BQFVJEX
 dvDNl6csVDDJbQ4WZAy0eGzXJ6C2Sr6mSMYDJgLVlMh6hTSHsW7or
X-Gm-Gg: ASbGnctp5Qp9te9S1I1LdaxITobrGVwqU13ZQ5T8s59xRfy0RnUhN+9is5LQCH4b35n
 AUq8BX0zrvsv68yOpy0DZgdcpQagmLrSbLIkfSnuiGp2stNJLPukb9pOGoM3uyFDDUX7FhthrW6
 5+urJJy/sX18CHRZhYWhux4K+f14aaEPOfiO+yr+3YSkoHUZHQVO0pVCiKwXIxnRoOD17u7euFm
 X4yU3u9gXz8kaD6dDRLBwwyV18LaP+taM+VMp/TYanNVVvUx9Q3UIUd5jxQUGPnq3vMeRAEPeKp
 eoTSy+x2WU5yKl3F
X-Received: by 2002:a05:6602:3e90:b0:85b:41cc:f709 with SMTP id
 ca18e2360f4ac-85e2cc7c804mr137565639f.14.1742518783070; 
 Thu, 20 Mar 2025 17:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5DI+0GECHAoLWgtzh9jpOwdwXVEpY6IlTNWn2ly5JSGysjUvHwQirKSp+WowNDh5UJ/QZYQ==
X-Received: by 2002:a05:6602:3e90:b0:85b:41cc:f709 with SMTP id
 ca18e2360f4ac-85e2cc7c804mr137563339f.14.1742518782639; 
 Thu, 20 Mar 2025 17:59:42 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85e2bdb5495sm17204039f.46.2025.03.20.17.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 17:59:41 -0700 (PDT)
Message-ID: <1b838258-7d30-4d9e-b350-3950617419e2@redhat.com>
Date: Thu, 20 Mar 2025 20:59:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: eric.auger@redhat.com,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
 <1c603ab2-4fbb-4838-a544-d88bc2608506@redhat.com>
 <44ed64f0-8e8b-4a87-9a85-074b9d283bc8@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <44ed64f0-8e8b-4a87-9a85-074b9d283bc8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 3/19/25 2:21 PM, Eric Auger wrote:
> Hi Don,
> 
> 
> On 3/19/25 5:21 PM, Donald Dutile wrote:
>>
>>
>> On 3/19/25 5:26 AM, Shameerali Kolothum Thodi wrote:
>>> Hi Don,
>>>
>> Hey!
>>
>>>> -----Original Message-----
>>>> From: Donald Dutile <ddutile@redhat.com>
>>>> Sent: Tuesday, March 18, 2025 10:12 PM
>>>> To: Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>>>> qemu-devel@nongnu.org
>>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>>>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>>>> pcie bus
>>>>
>>>> Shameer,
>>>>
>>>> Hi!
>>>>
>>>> On 3/11/25 10:10 AM, Shameer Kolothum wrote:
>>>>> User must associate a pxb-pcie root bus to smmuv3-accel
>>>>> and that is set as the primary-bus for the smmu dev.
>>>>>
>>>>> Signed-off-by: Shameer Kolothum
>>>> <shameerali.kolothum.thodi@huawei.com>
>>>>> ---
>>>>>     hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
>>>>>     1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>>>> index c327661636..1471b65374 100644
>>>>> --- a/hw/arm/smmuv3-accel.c
>>>>> +++ b/hw/arm/smmuv3-accel.c
>>>>> @@ -9,6 +9,21 @@
>>>>>     #include "qemu/osdep.h"
>>>>>
>>>>>     #include "hw/arm/smmuv3-accel.h"
>>>>> +#include "hw/pci/pci_bridge.h"
>>>>> +
>>>>> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
>>>>> +{
>>>>> +    DeviceState *d = opaque;
>>>>> +
>>>>> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
>>>>> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
>>>>> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus-
>>>>> name)) {
>>>>> +            object_property_set_link(OBJECT(d), "primary-bus",
>>>>> OBJECT(bus),
>>>>> +                                     &error_abort);
>>>>> +        }
>>>>> +    }
>>>>> +    return 0;
>>>>> +}
>>>>>
>>>>>     static void smmu_accel_realize(DeviceState *d, Error **errp)
>>>>>     {
>>>>> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d, Error
>>>> **errp)
>>>>>         SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>>>         Error *local_err = NULL;
>>>>>
>>>>> +    object_child_foreach_recursive(object_get_root(),
>>>>> +                                   smmuv3_accel_pxb_pcie_bus, d);
>>>>> +
>>>>>         object_property_set_bool(OBJECT(dev), "accel", true,
>>>>> &error_abort);
>>>>>         c->parent_realize(d, &local_err);
>>>>>         if (local_err) {
>>>>> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass
>>>> *klass, void *data)
>>>>>         device_class_set_parent_realize(dc, smmu_accel_realize,
>>>>>                                         &c->parent_realize);
>>>>>         dc->hotpluggable = false;
>>>>> +    dc->bus_type = TYPE_PCIE_BUS;
>>>>>     }
>>>>>
>>>>>     static const TypeInfo smmuv3_accel_type_info = {
>>>>
>>>> I am not seeing the need for a pxb-pcie bus(switch) introduced for each
>>>> 'accel'.
>>>> Isn't the IORT able to define different SMMUs for different RIDs?
>>>> if so,
>>>> itsn't that sufficient
>>>> to associate (define) an SMMU<->RID association without introducing a
>>>> pxb-pcie?
>>>> and again, I'm not sure how that improves/enables the device<->SMMU
>>>> associativity?
>>>
>>> Thanks for taking a look at the series. As discussed elsewhere in
>>> this thread(with
>>> Eric), normally in physical world (or atleast in the most common
>>> cases) SMMUv3
>>> is attached to PCIe Root Complex and if you take a look at the IORT
>>> spec, it describes
>>> association of ID mappings between a RC node and SMMUV3 node.
>>>
>>> And if my understanding is correct, in Qemu, only pxb-pcie allows you
>>> to add
>>> extra root complexes even though it is still plugged to
>>> parent(pcie.0). ie, for all
>>> devices downstream it acts as a root complex but still plugged into a
>>> parent pcie.0.
>>> This allows us to add/describe multiple "smmuv3-accel" each
>>> associated with a RC.
>>>
>> I find the qemu statements a bit unclear here as well.
>> I looked at the hot plug statement(s) in docs/pcie.txt, as I figured
>> that's where dynamic
>> IORT changes would be needed as well.  There, it says you can hot-add
>> PCIe devices to RPs,
>> one has to define/add RP's to the machine model for that plug-in.
>>
>> Using libvirt, it could auto-add the needed RPs to do dynmaic smmuv3
>> additions,
> I am not sure I understand your statement here. we don't want "dynamic"
> SMMUv3 instantiation. SMMUv3 is a platform device which is supposed to
> be coldplugged on a pre-existing PCIe hierarchy. The SMMUv3 device is
> not something that is meant to be hotplugged or hotunplugged.
> To me we hijack the bus= property to provide information about the IORT
> IDMAP
> 
Dynamic in the sense that if one adds smmuv3 for multiple devices,
libvirt will dynamically figure out how to instantiate one, two, three... smmu's
in the machine at cold boot.
If you want a machine to be able to hot-plug a device that would require another smmu,
than the config, and smmu, would have to be explicilty stated; as is done today for
hot-plug PCIe if the simple machine that libvirt would make is not sufficient to
hot-add a PCIe device.

> Thanks
> 
> Eric
>> if I understand how libvirt does that today for pcie devices now (/me
>> looks at danpb for feedback).
>>
>>> Having said that,  current code only allows pxb-pcie root complexes
>>> avoiding
>>> the pcie.0. The idea behind this was, user can use pcie.0 with a non
>>> accel SMMUv3
>>> for any emulated devices avoiding the performance bottlenecks we are
>>> discussing for emulated dev+smmuv3-accel cases. But based on the
>>> feedback from
>>> Eric and Daniel I will relax that restriction and will allow
>>> association with pcie.0.
>>>
>> So, I think this isn't a restriction that this smmuv3 feature should
>> enforce;
>> lack of a proper RP or pxb-pcie will yield an invalid config
>> issue/error, and
>> the machine definition will be modified to meet the needs for IORT.
>>
>>> Thanks,
>>> Shameer
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>   
>>>>>> to root complexes.
>>>> Feel free to enlighten me where I may have mis-read/interpreted the
>>>> IORT
>>>> & SMMUv3 specs.
>>>>
>>>> Thanks,
>>>> - Don
>>>>
>>>
>>
> 


