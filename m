Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB032C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPA4-0003R3-0v; Wed, 12 Mar 2025 12:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsP9u-0003Pc-Ap
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsP9s-0005aY-GL
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741797735;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+r7bsbtle+KB1mP48b3nFlBGq/YpfB24NbYPdahLX5c=;
 b=HogYrPUAc2v7K2tieiD+YB2HZM3lcEoaKm30Ypb735VgZSO9ZGjgpHcowq5DjJ2B5xcmZe
 Z4XTQifT8RWCGn/nUmSgrE1YoFiLuvd0EGxWJsZf6hWl9z9Z5s49bMaVdX34rrjkrE0zMO
 nVF58q+v5G7T4ljcLbUlcq6TqSYY6x0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-0R0gTi0zOPGxZRFMRFH48Q-1; Wed, 12 Mar 2025 12:42:11 -0400
X-MC-Unique: 0R0gTi0zOPGxZRFMRFH48Q-1
X-Mimecast-MFC-AGG-ID: 0R0gTi0zOPGxZRFMRFH48Q_1741797731
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e8f4367446so1151796d6.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741797730; x=1742402530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+r7bsbtle+KB1mP48b3nFlBGq/YpfB24NbYPdahLX5c=;
 b=PIFfZsnqS3D3gV64a9ufyqSFm3VqN5NQBM6//dSwbwmltou+dFXx9HCDJ2iWKHItOq
 PU8WLMYtNJ079KkPzqOAKuMgoa+MvnAufOnLdgdkavD98VSzYz0dhCXrClJT0kAevP3L
 VbffeIRMAEFWn+bo1W8ivWXmaFav/9/tQwps3jwGjlCnNdIPN67kykXZjJyVgQ0ulFkP
 Iojb+zdcVxI73gjTpcGtdJNgGUnVKmKgojoCk/CJCQXxmeWY/D8oza4yOeahgIKZVoZS
 QjRNyfm1dct3VNmAiq1w+O6yABeQ8anSkHEoW3gkc/ZS++dDI817nUSkDLbHXZErAF52
 CTXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWywDTJG8jUByytxU7uUU0bwEH5CgHLarNEOIc0oSXxlU33SJFvvy09a0/Q7GsNhD/P7wpGTSF230dF@nongnu.org
X-Gm-Message-State: AOJu0Yz3F6TsmzolCWtk6IFcbG3EeWy0vVomijGbVSuHXZ5QOnN5dd5I
 D04s1j2uQB8JYPMLvKnCxEt3oPwQUE9a40Tz4Zt8LCwtcP5e67OFLKsTYUk7QC0VIT6g+qsnUiU
 w0JIsZTz2K3XJz/R7xN75e+x1BwBwFr1wwPVRCZqROfYt1VdWUted
X-Gm-Gg: ASbGncswTanFwK5phX8nCuH6zkcNPicw9ToWlKs4WdxTdZHIaX8HY2fEJCq06f8vFj3
 owaSS7UhyO/nx1YhlXlXpyLYa5gHqUsBq2d7ElsDPz6srwtItdbl2DDkhut9dUq0GG0SOQpU4nI
 bm1biPbZ1vyZpTyS8vIjzYxVy1HAXsODpUTsdMFyr1pypid1KYeW6K8MZo544byFJek2xXYMst8
 nFoRN3rLEkEMz+2sCvZG6+OFPJeXT0CvGs/ASSNcL2yeM1Cph6Dz8BLu7zYf4PKIbYs0uRQag1K
 35w8xwkjKqJBcDqSQ0WHCycdItokKqUzO/iiZau4RMn7jXr4qVxk5p38OdQFE18=
X-Received: by 2002:a05:6214:2a4b:b0:6e8:ddf6:d136 with SMTP id
 6a1803df08f44-6e90071396amr251537276d6.45.1741797730619; 
 Wed, 12 Mar 2025 09:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc5wv12dPqW9neV3F4rPHjf7U8MmfzSOE96azPbaIEO/N4lyxhnyeKHkQlefGmw5bqvgiSmQ==
X-Received: by 2002:a05:6214:2a4b:b0:6e8:ddf6:d136 with SMTP id
 6a1803df08f44-6e90071396amr251537046d6.45.1741797730324; 
 Wed, 12 Mar 2025 09:42:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f716ee35sm86276256d6.96.2025.03.12.09.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 09:42:09 -0700 (PDT)
Message-ID: <5fcaf9ee-4c95-400d-a641-20e0f17be87b@redhat.com>
Date: Wed, 12 Mar 2025 17:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
 <9ffee8119fc441aeb760073c5f152fa4@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9ffee8119fc441aeb760073c5f152fa4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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




On 3/12/25 5:34 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, March 12, 2025 4:08 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>> pcie bus
>>
>> Hi Shameer,
>>
>>
>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>> User must associate a pxb-pcie root bus to smmuv3-accel
>>> and that is set as the primary-bus for the smmu dev.
>> why do we require a pxb-pcie root bus? why can't pci.0 root bus be used
>> for simpler use cases (ie. I just want to passthough a NIC in
>> accelerated mode). Or may pci.0 is also called a pax-pcie root bus?
> The idea was since pcie.0 is the default RC with virt, leave that to cases where
> we want to attach any emulated devices and use pxb-pcie based RCs for vfio-pci.
yes but for simpler use case you may not want the extra pain to
instantiate a pxb-pcie device. Actually libvirt does not instantiate it
by default.
>
>> Besides, why do we put the constraint to plug on a root bus. I know that
>> at this point we always plug to pci.0 but with the new -device option it
>> would be possible to plug it anywhere in the pcie hierarchy. At SOC
>> level can't an SMMU be plugged anywhere protecting just a few RIDs?
> In my understanding normally(or atleast in the most common cases) it is attached 
> to root complexes. Also IORT mappings are at the root complex level, right?
Yes I do agree the IORT describes ID mappings between RC and SMMU but
the actual ID mappings allow you to be much more precise and state that
a given SMMU only translates few RIDs within that RID space. If you
force the device bus to be a root bus you can't model that anymore.

Eric
>
> To 
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index c327661636..1471b65374 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -9,6 +9,21 @@
>>>  #include "qemu/osdep.h"
>>>
>>>  #include "hw/arm/smmuv3-accel.h"
>>> +#include "hw/pci/pci_bridge.h"
>>> +
>>> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
>>> +{
>>> +    DeviceState *d = opaque;
>>> +
>>> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
>>> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
>>> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus-
>>> name)) {
>>> +            object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
>>> +                                     &error_abort);
>> if you want to stop the recursive search I think you need to return
>> something != 0 here.
> Ok.
>  
>> I don't really understand why we don't simply set the primary-bus to
>> <bus> where -device arm-smmuv3-accel, bus=<bus>? or maybe enforce that
>> this bus is an actual root bus if we really need that?
> The primary-bus here is actually the property of the parent SMMU device.
> This one now has,
>
> -device arm-smmuv3-accel, bus format.
>
>
>>> +        }
>>> +    }
>>> +    return 0;
>>> +}
>>>
>>>  static void smmu_accel_realize(DeviceState *d, Error **errp)
>>>  {
>>> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d, Error
>> **errp)
>>>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>      Error *local_err = NULL;
>>>
>>> +    object_child_foreach_recursive(object_get_root(),
>>> +                                   smmuv3_accel_pxb_pcie_bus, d);
>>> +
>>>      object_property_set_bool(OBJECT(dev), "accel", true, &error_abort);
>>>      c->parent_realize(d, &local_err);
>>>      if (local_err) {
>>> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass
>> *klass, void *data)
>>>      device_class_set_parent_realize(dc, smmu_accel_realize,
>>>                                      &c->parent_realize);
>>>      dc->hotpluggable = false;
>>> +    dc->bus_type = TYPE_PCIE_BUS;
>> shouldn't it below to 3/20? It is not really related to primary_bus
>> setting?
> This is to set the bus property of this smmuv3-accel device. As mentioned 
> above primary-bus is the property of parent TYPE_ARM_SMMU device.
>
> Thanks,
> Shameer


