Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B227CC35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy3Q-00088C-Ty; Wed, 19 Mar 2025 14:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuy3M-00086e-2S
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuy3J-0006JK-UG
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742408523;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okPMf6cCHQbe28vUxCLh9bHn7x3G8lNwSs6TkpJtphc=;
 b=IgHLO7An80TyO85J8PbddyMfkj4gyl9oXkxvEZEcYMDAvEgNr0ebuhrQqZphXDDGMdebwr
 bVBOFjr0FXKcL9SAJIdHhKVNu+imwLuKknYELnFTqt+tN5Vrh2pmYoSJa1lJm6wZ5AG188
 ocbc5+28KE5Pcq6JzjoJ86kQkuVG7kw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9aTRnCjGPm6M8ZSRWJloHA-1; Wed, 19 Mar 2025 14:22:01 -0400
X-MC-Unique: 9aTRnCjGPm6M8ZSRWJloHA-1
X-Mimecast-MFC-AGG-ID: 9aTRnCjGPm6M8ZSRWJloHA_1742408520
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so2867401f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408520; x=1743013320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okPMf6cCHQbe28vUxCLh9bHn7x3G8lNwSs6TkpJtphc=;
 b=owU375M8tZNeIAPbCB6wvoeGmBK4OF88ePkEH6cC9F9B3CNGtZmgBXpLDZbsqgCYWw
 WpVPhMZyGtwuhuDxZodgWe9oCJqSaPqEd6yW3m60/EWqhvE3gpG2R04DcpdmKmXZnQRw
 TzJa32L8HRumbjt7RwNoeheLEJvCRR6+BbyuBZMUSld1iR7gZPhTD7cbKf2y2D2Rcih+
 ldcYW/SaWKf9BLGqgdpCTgksBRVad8+spZ8432z7xbyUxXE6SYeZdbIhpdvktsDm/PQL
 euLA+OR5gaDntvxs2mRkeucbsSiOz5KYPZpU6Ia2ih0QVArjoMcjCqxmQFRQlx0o3I/H
 11Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHJqDwF9zokNVVRrUDTJHXOn5xBNGG9LPzlXzESwSoruv1tpW2EqiTvs5gidB4DFOttKV3x0fdjBuO@nongnu.org
X-Gm-Message-State: AOJu0YyNV6evJTYjF/+wTEADmQMJGe2KoiCyTtb3a8/0gfRyBhVD676c
 Ou96J/8tunl5Rb1JpLx9dIWD7bWSmhYHPVpxOINKGHGokaqd3ueQi3d9WvXYaTr7n6wPyLd+tkD
 AexSqohSZO4qUzsc7OCpWr34CEL+jIFoUvC8x2wtKeIae4hl+bov0
X-Gm-Gg: ASbGnct5GGfhxFo1ptcIWRz8CI8OuqoOdv/gtLE+b4ke4yp0IqeT/vO09co/z0MAD6R
 p4rSFibL/V3IfckoIV4h7z6Ge3/vKnEhnQ6FxRxyJttVINpjkVjbmpXa7fLGW+HWXZhoDzLayts
 WarbxCMbVu0Ptk7LSfsnzCzdV9NL2w1v6p6eswWQlkkprUQ7h17HBoUx4vwT4Jg+fPNYHvG/gSY
 bSbh9pFm0/P+yq9x9KyVaRuLFdydUYpsMo13B8rNqN7yRVzBRObWTHTtYGyAI1Bz6k3JBbPr2ao
 Xd+PmWcZmwMP9QeY6/9EHceqBEG1y5+2GFyUOtB37Yq4vh89iyZL5mRFAlgMj5s=
X-Received: by 2002:a05:6000:400b:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-39973b0474cmr2631846f8f.49.1742408520465; 
 Wed, 19 Mar 2025 11:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDlWbpZvkb9usbrHbka7b/CabiUmdmrFYJvsv1+jxDLZL541bI/RywrEQgFi4onNy8hmYGTw==
X-Received: by 2002:a05:6000:400b:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-39973b0474cmr2631828f8f.49.1742408520002; 
 Wed, 19 Mar 2025 11:22:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ebaa5sm21525608f8f.87.2025.03.19.11.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 11:21:59 -0700 (PDT)
Message-ID: <44ed64f0-8e8b-4a87-9a85-074b9d283bc8@redhat.com>
Date: Wed, 19 Mar 2025 19:21:57 +0100
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <1c603ab2-4fbb-4838-a544-d88bc2608506@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Don,


On 3/19/25 5:21 PM, Donald Dutile wrote:
>
>
> On 3/19/25 5:26 AM, Shameerali Kolothum Thodi wrote:
>> Hi Don,
>>
> Hey!
>
>>> -----Original Message-----
>>> From: Donald Dutile <ddutile@redhat.com>
>>> Sent: Tuesday, March 18, 2025 10:12 PM
>>> To: Shameerali Kolothum Thodi
>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>>> qemu-devel@nongnu.org
>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>>> pcie bus
>>>
>>> Shameer,
>>>
>>> Hi!
>>>
>>> On 3/11/25 10:10 AM, Shameer Kolothum wrote:
>>>> User must associate a pxb-pcie root bus to smmuv3-accel
>>>> and that is set as the primary-bus for the smmu dev.
>>>>
>>>> Signed-off-by: Shameer Kolothum
>>> <shameerali.kolothum.thodi@huawei.com>
>>>> ---
>>>>    hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>>> index c327661636..1471b65374 100644
>>>> --- a/hw/arm/smmuv3-accel.c
>>>> +++ b/hw/arm/smmuv3-accel.c
>>>> @@ -9,6 +9,21 @@
>>>>    #include "qemu/osdep.h"
>>>>
>>>>    #include "hw/arm/smmuv3-accel.h"
>>>> +#include "hw/pci/pci_bridge.h"
>>>> +
>>>> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
>>>> +{
>>>> +    DeviceState *d = opaque;
>>>> +
>>>> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
>>>> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
>>>> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus-
>>>> name)) {
>>>> +            object_property_set_link(OBJECT(d), "primary-bus",
>>>> OBJECT(bus),
>>>> +                                     &error_abort);
>>>> +        }
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>>
>>>>    static void smmu_accel_realize(DeviceState *d, Error **errp)
>>>>    {
>>>> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d, Error
>>> **errp)
>>>>        SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>>        Error *local_err = NULL;
>>>>
>>>> +    object_child_foreach_recursive(object_get_root(),
>>>> +                                   smmuv3_accel_pxb_pcie_bus, d);
>>>> +
>>>>        object_property_set_bool(OBJECT(dev), "accel", true,
>>>> &error_abort);
>>>>        c->parent_realize(d, &local_err);
>>>>        if (local_err) {
>>>> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass
>>> *klass, void *data)
>>>>        device_class_set_parent_realize(dc, smmu_accel_realize,
>>>>                                        &c->parent_realize);
>>>>        dc->hotpluggable = false;
>>>> +    dc->bus_type = TYPE_PCIE_BUS;
>>>>    }
>>>>
>>>>    static const TypeInfo smmuv3_accel_type_info = {
>>>
>>> I am not seeing the need for a pxb-pcie bus(switch) introduced for each
>>> 'accel'.
>>> Isn't the IORT able to define different SMMUs for different RIDs?  
>>> if so,
>>> itsn't that sufficient
>>> to associate (define) an SMMU<->RID association without introducing a
>>> pxb-pcie?
>>> and again, I'm not sure how that improves/enables the device<->SMMU
>>> associativity?
>>
>> Thanks for taking a look at the series. As discussed elsewhere in
>> this thread(with
>> Eric), normally in physical world (or atleast in the most common
>> cases) SMMUv3
>> is attached to PCIe Root Complex and if you take a look at the IORT
>> spec, it describes
>> association of ID mappings between a RC node and SMMUV3 node.
>>
>> And if my understanding is correct, in Qemu, only pxb-pcie allows you
>> to add
>> extra root complexes even though it is still plugged to
>> parent(pcie.0). ie, for all
>> devices downstream it acts as a root complex but still plugged into a
>> parent pcie.0.
>> This allows us to add/describe multiple "smmuv3-accel" each
>> associated with a RC.
>>
> I find the qemu statements a bit unclear here as well.
> I looked at the hot plug statement(s) in docs/pcie.txt, as I figured
> that's where dynamic
> IORT changes would be needed as well.  There, it says you can hot-add
> PCIe devices to RPs,
> one has to define/add RP's to the machine model for that plug-in.
>
> Using libvirt, it could auto-add the needed RPs to do dynmaic smmuv3
> additions,
I am not sure I understand your statement here. we don't want "dynamic"
SMMUv3 instantiation. SMMUv3 is a platform device which is supposed to
be coldplugged on a pre-existing PCIe hierarchy. The SMMUv3 device is
not something that is meant to be hotplugged or hotunplugged.
To me we hijack the bus= property to provide information about the IORT
IDMAP

Thanks

Eric
> if I understand how libvirt does that today for pcie devices now (/me
> looks at danpb for feedback).
>
>> Having said that,  current code only allows pxb-pcie root complexes
>> avoiding
>> the pcie.0. The idea behind this was, user can use pcie.0 with a non
>> accel SMMUv3
>> for any emulated devices avoiding the performance bottlenecks we are
>> discussing for emulated dev+smmuv3-accel cases. But based on the
>> feedback from
>> Eric and Daniel I will relax that restriction and will allow
>> association with pcie.0.
>>
> So, I think this isn't a restriction that this smmuv3 feature should
> enforce;
> lack of a proper RP or pxb-pcie will yield an invalid config
> issue/error, and
> the machine definition will be modified to meet the needs for IORT.
>
>> Thanks,
>> Shameer
>>
>>
>>
>>
>>
>>
>>
>>
>>  
>>>>> to root complexes.
>>> Feel free to enlighten me where I may have mis-read/interpreted the
>>> IORT
>>> & SMMUv3 specs.
>>>
>>> Thanks,
>>> - Don
>>>
>>
>


