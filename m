Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9169DC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twjE6-0003Ss-1Q; Mon, 24 Mar 2025 10:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twjE1-0003SE-Mw
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twjDw-0004LX-G2
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742828177;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UHDPO/kN0G4XquNdLIr90piQ8a/PRGewVN32e5YMjI=;
 b=TUJY6eGy7w1ZbRyZUHar0ibrjm/rOB6ubILcT9ouycrRFpeCD/k5576y8srj36tZjeSteu
 PkFhC2yYbAQQxTyJIidOJJ3Qfg5q+VGP4SDZB0DgiKhXT9bcUxyjGpIxBipXOPpyZWt0xq
 gacogODlbyREn+IuWMdgwljMQKgy28w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-gXx9_RU-O0iYsRNkjEs2Xg-1; Mon, 24 Mar 2025 10:56:16 -0400
X-MC-Unique: gXx9_RU-O0iYsRNkjEs2Xg-1
X-Mimecast-MFC-AGG-ID: gXx9_RU-O0iYsRNkjEs2Xg_1742828175
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3914bc0cc4aso2309519f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742828175; x=1743432975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9UHDPO/kN0G4XquNdLIr90piQ8a/PRGewVN32e5YMjI=;
 b=bUB6JGR45oQmOcw+3sr9Kk1UB3hoVWcIfEmiDMwe36kBvuNI6+1i2OmBDiXldy62Zn
 JTZ+HtID1IegR+WLIdX2t4Z77dxpJCk6F74lNJDD5jSa6XnlKhW9usYm/rYs6k4dsRZ8
 7rNFpSubZZZpRcarl2UeABFVdq6FdVj68Y6TGU3BwzfZJLMseYaqZY97+sRYp4KPyoEf
 6/rwRxTTqJ6F4tPY6SDrsgBdNXMyW7xxUImDIX5NJRjNLJfkixYyMOm0VLHdVSt9AV3Y
 p3okoqTCk3ig1/64xhogKh8BtzqYwg3k12jQiFXK2OUpDwJfZZrB2pZ4LDqrXm4RIsaa
 lrLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQrqniW7d/v/ZegE683N3NYjn7hieVQbT48h/408h8R8Wk3iTdLPn2gFXRou8edIjnAiyYAaI06yLL@nongnu.org
X-Gm-Message-State: AOJu0Ywqa4iA+DV1EmxG2u8MKXH8Ha4DPWBt4HGEF0NyqNlSImMT3r2u
 RiKRdCr4gv5f35uDw5TZnU5jK/teDPPgpA+2PudKDXu2ro0/bQ2ktKSoe3C1AgdmSoVxyhBiSYd
 TghptL744Emk3tbXFjgeU5PKMZi6OBjqQflCXPSkFsLyFw8cwopdV
X-Gm-Gg: ASbGncs2tzNt7VUUcomP7VOMNoHxQjP22p/IGmTjBdOBTqiby3nHTAXlkYExu+BIqfT
 khiEqgbj8GVzrePlNLKkbPqCISzYMlJ7EhzAqpwEfhbJ4/Ijns8EMvXmQw9tboabWZEVxeQlLJz
 h4ufD4ZhAYAmA8Bs/S1wYtAUEPjQGrVFmWeHUVBHWLsl0sjUN6SdfT/CvV40bdTcemlez0fMwSj
 Bsw+mQmyvq1c/hbLPzprLkE4EHHNuk3boYamhJPvvVwB/rnT9za1KJ06b3h4GTKXIN3FZLD/M7Q
 CMCpOJSbh5vfwVAA58sdpiy73Lha3HEOOo4CYTvhMnZUQ09DSVzn1Y466HRbzOs=
X-Received: by 2002:a05:6000:1f86:b0:391:4743:6de4 with SMTP id
 ffacd0b85a97d-3997f940e28mr10720696f8f.50.1742828174970; 
 Mon, 24 Mar 2025 07:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWY2BFZxHXsxP0ascpwaqDyY1auI2qGyfZyRyQmU9wqlq+zHsWyWPZGGVjW5Wka0maVLap5Q==
X-Received: by 2002:a05:6000:1f86:b0:391:4743:6de4 with SMTP id
 ffacd0b85a97d-3997f940e28mr10720665f8f.50.1742828174413; 
 Mon, 24 Mar 2025 07:56:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b2654sm11021073f8f.41.2025.03.24.07.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 07:56:13 -0700 (PDT)
Message-ID: <b7201a78-f2ea-4aee-a973-b02e4dc78652@redhat.com>
Date: Mon, 24 Mar 2025 15:56:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Donald Dutile <ddutile@redhat.com>,
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
 <1b838258-7d30-4d9e-b350-3950617419e2@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <1b838258-7d30-4d9e-b350-3950617419e2@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 3/21/25 1:59 AM, Donald Dutile wrote:
>
>
> On 3/19/25 2:21 PM, Eric Auger wrote:
>> Hi Don,
>>
>>
>> On 3/19/25 5:21 PM, Donald Dutile wrote:
>>>
>>>
>>> On 3/19/25 5:26 AM, Shameerali Kolothum Thodi wrote:
>>>> Hi Don,
>>>>
>>> Hey!
>>>
>>>>> -----Original Message-----
>>>>> From: Donald Dutile <ddutile@redhat.com>
>>>>> Sent: Tuesday, March 18, 2025 10:12 PM
>>>>> To: Shameerali Kolothum Thodi
>>>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>>>>> qemu-devel@nongnu.org
>>>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>>>>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>>>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>>>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a
>>>>> pxb-
>>>>> pcie bus
>>>>>
>>>>> Shameer,
>>>>>
>>>>> Hi!
>>>>>
>>>>> On 3/11/25 10:10 AM, Shameer Kolothum wrote:
>>>>>> User must associate a pxb-pcie root bus to smmuv3-accel
>>>>>> and that is set as the primary-bus for the smmu dev.
>>>>>>
>>>>>> Signed-off-by: Shameer Kolothum
>>>>> <shameerali.kolothum.thodi@huawei.com>
>>>>>> ---
>>>>>>     hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
>>>>>>     1 file changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>>>>> index c327661636..1471b65374 100644
>>>>>> --- a/hw/arm/smmuv3-accel.c
>>>>>> +++ b/hw/arm/smmuv3-accel.c
>>>>>> @@ -9,6 +9,21 @@
>>>>>>     #include "qemu/osdep.h"
>>>>>>
>>>>>>     #include "hw/arm/smmuv3-accel.h"
>>>>>> +#include "hw/pci/pci_bridge.h"
>>>>>> +
>>>>>> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
>>>>>> +{
>>>>>> +    DeviceState *d = opaque;
>>>>>> +
>>>>>> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
>>>>>> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
>>>>>> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus-
>>>>>> name)) {
>>>>>> +            object_property_set_link(OBJECT(d), "primary-bus",
>>>>>> OBJECT(bus),
>>>>>> +                                     &error_abort);
>>>>>> +        }
>>>>>> +    }
>>>>>> +    return 0;
>>>>>> +}
>>>>>>
>>>>>>     static void smmu_accel_realize(DeviceState *d, Error **errp)
>>>>>>     {
>>>>>> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d,
>>>>>> Error
>>>>> **errp)
>>>>>>         SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>>>>         Error *local_err = NULL;
>>>>>>
>>>>>> +    object_child_foreach_recursive(object_get_root(),
>>>>>> +                                   smmuv3_accel_pxb_pcie_bus, d);
>>>>>> +
>>>>>>         object_property_set_bool(OBJECT(dev), "accel", true,
>>>>>> &error_abort);
>>>>>>         c->parent_realize(d, &local_err);
>>>>>>         if (local_err) {
>>>>>> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass
>>>>> *klass, void *data)
>>>>>>         device_class_set_parent_realize(dc, smmu_accel_realize,
>>>>>>                                         &c->parent_realize);
>>>>>>         dc->hotpluggable = false;
>>>>>> +    dc->bus_type = TYPE_PCIE_BUS;
>>>>>>     }
>>>>>>
>>>>>>     static const TypeInfo smmuv3_accel_type_info = {
>>>>>
>>>>> I am not seeing the need for a pxb-pcie bus(switch) introduced for
>>>>> each
>>>>> 'accel'.
>>>>> Isn't the IORT able to define different SMMUs for different RIDs?
>>>>> if so,
>>>>> itsn't that sufficient
>>>>> to associate (define) an SMMU<->RID association without introducing a
>>>>> pxb-pcie?
>>>>> and again, I'm not sure how that improves/enables the device<->SMMU
>>>>> associativity?
>>>>
>>>> Thanks for taking a look at the series. As discussed elsewhere in
>>>> this thread(with
>>>> Eric), normally in physical world (or atleast in the most common
>>>> cases) SMMUv3
>>>> is attached to PCIe Root Complex and if you take a look at the IORT
>>>> spec, it describes
>>>> association of ID mappings between a RC node and SMMUV3 node.
>>>>
>>>> And if my understanding is correct, in Qemu, only pxb-pcie allows you
>>>> to add
>>>> extra root complexes even though it is still plugged to
>>>> parent(pcie.0). ie, for all
>>>> devices downstream it acts as a root complex but still plugged into a
>>>> parent pcie.0.
>>>> This allows us to add/describe multiple "smmuv3-accel" each
>>>> associated with a RC.
>>>>
>>> I find the qemu statements a bit unclear here as well.
>>> I looked at the hot plug statement(s) in docs/pcie.txt, as I figured
>>> that's where dynamic
>>> IORT changes would be needed as well.  There, it says you can hot-add
>>> PCIe devices to RPs,
>>> one has to define/add RP's to the machine model for that plug-in.
>>>
>>> Using libvirt, it could auto-add the needed RPs to do dynmaic smmuv3
>>> additions,
>> I am not sure I understand your statement here. we don't want "dynamic"
>> SMMUv3 instantiation. SMMUv3 is a platform device which is supposed to
>> be coldplugged on a pre-existing PCIe hierarchy. The SMMUv3 device is
>> not something that is meant to be hotplugged or hotunplugged.
>> To me we hijack the bus= property to provide information about the IORT
>> IDMAP
>>
> Dynamic in the sense that if one adds smmuv3 for multiple devices,
> libvirt will dynamically figure out how to instantiate one, two,
> three... smmu's
> in the machine at cold boot.
> If you want a machine to be able to hot-plug a device that would
> require another smmu,
> than the config, and smmu, would have to be explicilty stated; as is
> done today for
> hot-plug PCIe if the simple machine that libvirt would make is not
> sufficient to
> hot-add a PCIe device.

Hum this will need to be discussed with libvirt guys but I am not sure
they will be inclined to support such kind of policy, esp because vIOMMU
is a pretty marginal use case as of now. They do automatic instantiation
for pcie, usb controllers but I am not sure they will take care of the
vIOMMU tbh

Eric
>
>> Thanks
>>
>> Eric
>>> if I understand how libvirt does that today for pcie devices now (/me
>>> looks at danpb for feedback).
>>>
>>>> Having said that,  current code only allows pxb-pcie root complexes
>>>> avoiding
>>>> the pcie.0. The idea behind this was, user can use pcie.0 with a non
>>>> accel SMMUv3
>>>> for any emulated devices avoiding the performance bottlenecks we are
>>>> discussing for emulated dev+smmuv3-accel cases. But based on the
>>>> feedback from
>>>> Eric and Daniel I will relax that restriction and will allow
>>>> association with pcie.0.
>>>>
>>> So, I think this isn't a restriction that this smmuv3 feature should
>>> enforce;
>>> lack of a proper RP or pxb-pcie will yield an invalid config
>>> issue/error, and
>>> the machine definition will be modified to meet the needs for IORT.
>>>
>>>> Thanks,
>>>> Shameer
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>  
>>>>>>> to root complexes.
>>>>> Feel free to enlighten me where I may have mis-read/interpreted the
>>>>> IORT
>>>>> & SMMUv3 specs.
>>>>>
>>>>> Thanks,
>>>>> - Don
>>>>>
>>>>
>>>
>>
>


