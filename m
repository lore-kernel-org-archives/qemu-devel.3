Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F6AD65C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 17:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVvWN-00033J-To; Wed, 17 Dec 2025 12:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVvWF-00031h-7f
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVvWC-00046m-OL
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765993210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OwVmD92ns0OZ1/fXDmcjec8wo0nIS6cBhKFT8id+tzQ=;
 b=gEDbAh5VBwvqptgljSwaxbcnmnZryG20NU0RJ4csn0aHrogJR6vVVh7UP9yzlVcw43vuos
 N08p4q4DyAZEpMvcgnj2B8YsrUNDlRqCRf6sZe6N+hjCHGxgpVKyabs2D90jwETAx0zaUy
 5c67yqyBJ7fskuYsGdJETT+Bnt05/nY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-IKZp-jE-OOu9Ipl7qgUWgw-1; Wed, 17 Dec 2025 12:39:01 -0500
X-MC-Unique: IKZp-jE-OOu9Ipl7qgUWgw-1
X-Mimecast-MFC-AGG-ID: IKZp-jE-OOu9Ipl7qgUWgw_1765993141
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so47715295e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765993140; x=1766597940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OwVmD92ns0OZ1/fXDmcjec8wo0nIS6cBhKFT8id+tzQ=;
 b=fsi2cHqWwDKo443duigqDx0K2a53T8SZ3zT5a32Afh/PcMiK5tmjEQQrkT8iR5rcdJ
 g+meBNdiwQx2zPc2ZelDQn5bDo+bqWc1PqJIvBF07mjWm6zL8DpmOc8qmlA3cchDjQHC
 yCb5YwLVg/kmmLmHHAEAM+xJ21C5ltmtOrGtvhU0yja43kHmyNVPlwIMFkc1I6NrjfU1
 n1NnWfdN5oJ3ZfHbr4GlVmMFhKMAPM/qUo7Tiao59yNLyvdNqAFb5PRPSelE+h8gibnA
 9jRBrdJaUE0SLuJYcpjqUzrVx4qjzyYd9S83WGopCbkBhYq8C4SczT9XGY/e5RV48urA
 m4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765993140; x=1766597940;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwVmD92ns0OZ1/fXDmcjec8wo0nIS6cBhKFT8id+tzQ=;
 b=owf+JSCqT19DBTz22pLuHNo1KLM4NrlNdHKdTUzw68/ZZn6FEuwuLuILUf6ttbEbb+
 3035PkNkW2O277SbaAeoe4xkK9OHcHegvbx5flUy1ERGY6nsbn/+bRFKnlIIUAfAfeex
 4rfOYoVggShg4c8CCUnU6M9La1iokyck2BfDxjF46UNSOZnxin4Go76GcX3WBArsfWut
 TiyxkzJ6ulwYDqu/B8GtDDuzkSj7CfcAdEZXCDaGH0qBEN3k/Tw65IfQR+LEFR1BV5c2
 QSdveuP0GE8YEKs353kShPDq5Vx/ov2q5CDguu3E0v3hbPt5pry35lqqDLIVk2D9iU0G
 ZioA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlKe3I3uJ5FlhkMpdlRWYxqggguy7l4OW5AW5qt4lgqQOrLQUIDUiy/mR8Tbgq6PWRZzYsfbFNZf0s@nongnu.org
X-Gm-Message-State: AOJu0Yyq+Zz8CH4d+mGN+6WwLx/3ld2ZwUiKKqzAQTWcs+nEmEnC1IJ7
 I64nTBajn24ig5eIFkum9qNlvEU19Ppoc7GpkZPH/9slOmIdI0KImQArKNfH5gYNqVjQlcs6Y/J
 Ue6H3z7PtmPZsEtWVSOQGhqbVauIB2/vGL1rpceKicD3CfOrEyZEcfNSA
X-Gm-Gg: AY/fxX60mop2sgI9EaEWXlEDkZvdA0h3zdhRnKyE2l5akkebG1ozW4x7D/PPg3YCJpF
 Hq1/jGGFpdTa28eptcpaOWd5gJC+zev4+FooldSsZe8bSMX0bd7RuObRGYCcXS+GRehJcUoumSm
 wsikd9L4MJ+ykbwp6H90CZNr4EIaHkZXfjrJyMgeoOWlfdQm3pYS7JH1IsP90mwGTSSgq76/Xox
 NYYUyAoZuUtOdsLMm5DfPvibyBif3jBAzmop8tbEN1oB7db8+5Ga+TUZWTiF7AptI13W1IVLNNM
 OHbgvvGadJXaFFLNfMppzbsvRvVY+AheWrNx87oXWfpuB6Rzy5kWFs9RU7yTKCPmb94n+qm2tug
 OHh8SiE2haVWzn0ox9R/Lbb3qi1ZxvbkMzSHQuxCSZ45EQENU
X-Received: by 2002:a05:600c:468c:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-47a8f9149e7mr214673955e9.33.1765993140170; 
 Wed, 17 Dec 2025 09:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkVAiPPB+AUInEnn8VQDhERLUxxQFg0jRl5Ut5HvjKO8bNDmapU1d69Xxp08Gh6YrCV13jhQ==
X-Received: by 2002:a05:600c:468c:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-47a8f9149e7mr214673565e9.33.1765993139681; 
 Wed, 17 Dec 2025 09:38:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd9936809sm35759525e9.6.2025.12.17.09.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 09:38:59 -0800 (PST)
Message-ID: <5b17d7e8-e4d0-4087-b104-c50a418ff24c@redhat.com>
Date: Wed, 17 Dec 2025 18:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-6-skolothumtho@nvidia.com>
 <6a062129-2b8f-420a-a4b9-87dde7574481@redhat.com>
 <CH3PR12MB7548E01E6CC271356D4D4208ABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR12MB7548E01E6CC271356D4D4208ABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Shameer,

On 12/12/25 06:48, Shameer Kolothum wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: 11 December 2025 12:55
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
>> ddutile@redhat.com; berrange@redhat.com; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v6 05/33] hw/arm/smmuv3-accel: Introduce smmuv3
>> accel device
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 11/20/25 14:21, Shameer Kolothum wrote:
>>> Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
>>> different callback handling in upcoming patches. This also adds a
>>> CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
>>> at compile time. Because we now include CONFIG_DEVICES in the header to
>>> check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs
>> to
>>> be changed to arm_ss.add.
>>>
>>> The “accel” property isn’t user visible yet and it will be introduced in
>>> a later patch once all the supporting pieces are ready.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>    hw/arm/Kconfig          |  5 ++++
>>>    hw/arm/meson.build      |  3 ++-
>>>    hw/arm/smmuv3-accel.c   | 59
>> +++++++++++++++++++++++++++++++++++++++++
>>>    hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++
>>>    hw/arm/smmuv3.c         |  5 ++++
>>>    include/hw/arm/smmuv3.h |  3 +++
>>>    6 files changed, 101 insertions(+), 1 deletion(-)
>>>    create mode 100644 hw/arm/smmuv3-accel.c
>>>    create mode 100644 hw/arm/smmuv3-accel.h
>>>
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>> index 0cdeb60f1f..702b79a02b 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -12,6 +12,7 @@ config ARM_VIRT
>>>        select ARM_GIC
>>>        select ACPI
>>>        select ARM_SMMUV3
>>> +    select ARM_SMMUV3_ACCEL
>>>        select GPIO_KEY
>>>        select DEVICE_TREE
>>>        select FW_CFG_DMA
>>> @@ -629,6 +630,10 @@ config FSL_IMX8MP_EVK
>>>    config ARM_SMMUV3
>>>        bool
>>>
>>> +config ARM_SMMUV3_ACCEL
>>> +    bool
>>> +    depends on ARM_SMMUV3 && IOMMUFD
>>> +
>>>    config FSL_IMX6UL
>>>        bool
>>>        default y
>>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>>> index aeaf654790..c250487e64 100644
>>> --- a/hw/arm/meson.build
>>> +++ b/hw/arm/meson.build
>>> @@ -84,7 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE',
>> if_true: files('armsse.c'))
>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c',
>> 'mcimx7d-sabre.c'))
>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-
>> imx8mp.c'))
>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
>> files('imx8mp-evk.c'))
>>> -arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true:
>> files('smmuv3.c'))
>>> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>>> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true:
>> files('smmuv3-accel.c'))
>>>    arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-
>> imx6ul.c', 'mcimx6ul-evk.c'))
>>>    arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true:
>> files('nrf51_soc.c'))
>>>    arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> new file mode 100644
>>> index 0000000000..99ef0db8c4
>>> --- /dev/null
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -0,0 +1,59 @@
>>> +/*
>>> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
>>> + * Copyright (C) 2025 NVIDIA
>>> + * Written by Nicolin Chen, Shameer Kolothum
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +
>>> +#include "hw/arm/smmuv3.h"
>>> +#include "smmuv3-accel.h"
>>> +
>>> +static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs,
>> SMMUPciBus *sbus,
>>> +                                               PCIBus *bus, int devfn)
>>> +{
>>> +    SMMUDevice *sdev = sbus->pbdev[devfn];
>>> +    SMMUv3AccelDevice *accel_dev;
>>> +
>>> +    if (sdev) {
>>> +        return container_of(sdev, SMMUv3AccelDevice, sdev);
>>> +    }
>>> +
>>> +    accel_dev = g_new0(SMMUv3AccelDevice, 1);
>>
>> oh. This is not a QOM object :/
> 
> Right.
> 
>>
>>> +    sdev = &accel_dev->sdev;
>>> +
>>> +    sbus->pbdev[devfn] = sdev;
>>> +    smmu_init_sdev(bs, sdev, bus, devfn);
>>> +    return accel_dev;
>>> +}
>>> +
>>> +/*
>>> + * Find or add an address space for the given PCI device.
>>> + *
>>> + * If a device matching @bus and @devfn already exists, return its
>>> + * corresponding address space. Otherwise, create a new device entry
>>> + * and initialize address space for it.
>>> + */
>>> +static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>> *opaque,
>>> +                                              int devfn)
>>> +{
>>> +    SMMUState *bs = opaque;
>>> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>>> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus,
>> bus, devfn);
>>> +    SMMUDevice *sdev = &accel_dev->sdev;
>>> +
>>> +    return &sdev->as;
>>> +}
>>> +
>>> +static const PCIIOMMUOps smmuv3_accel_ops = {
>>> +    .get_address_space = smmuv3_accel_find_add_as,
>>> +};
>>> +
>>> +void smmuv3_accel_init(SMMUv3State *s)
>>> +{
>>> +    SMMUState *bs = ARM_SMMU(s);
>>> +
>>> +    bs->iommu_ops = &smmuv3_accel_ops;
>>
>> again, I think this should be a sSMMUv3Class attribute.
> 
> See below.
>>
>>> +}
>>> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>>> new file mode 100644
>>> index 0000000000..0dc6b00d35
>>> --- /dev/null
>>> +++ b/hw/arm/smmuv3-accel.h
>>> @@ -0,0 +1,27 @@
>>> +/*
>>> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
>>> + * Copyright (C) 2025 NVIDIA
>>> + * Written by Nicolin Chen, Shameer Kolothum
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HW_ARM_SMMUV3_ACCEL_H
>>> +#define HW_ARM_SMMUV3_ACCEL_H
>>> +
>>> +#include "hw/arm/smmu-common.h"
>>> +#include CONFIG_DEVICES
>>> +
>>> +typedef struct SMMUv3AccelDevice {
>>> +    SMMUDevice sdev;
>>> +} SMMUv3AccelDevice;
>>> +
>>> +#ifdef CONFIG_ARM_SMMUV3_ACCEL
>>> +void smmuv3_accel_init(SMMUv3State *s);
>>> +#else
>>> +static inline void smmuv3_accel_init(SMMUv3State *s)
>>> +{
>>> +}
>>> +#endif
>>> +
>>> +#endif /* HW_ARM_SMMUV3_ACCEL_H */
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index bcf8af8dc7..ef991cb7d8 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -32,6 +32,7 @@
>>>    #include "qapi/error.h"
>>>
>>>    #include "hw/arm/smmuv3.h"
>>> +#include "smmuv3-accel.h"
>>>    #include "smmuv3-internal.h"
>>>    #include "smmu-internal.h"
>>>
>>> @@ -1882,6 +1883,10 @@ static void smmu_realize(DeviceState *d, Error
>> **errp)
>>>        SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>>        Error *local_err = NULL;
>>>
>>> +    if (s->accel) {
>>> +        smmuv3_accel_init(s);
>>> +    }
>>> +
>>>        c->parent_realize(d, &local_err);
>>>        if (local_err) {
>>>            error_propagate(errp, local_err);
>>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>>> index d183a62766..bb7076286b 100644
>>> --- a/include/hw/arm/smmuv3.h
>>> +++ b/include/hw/arm/smmuv3.h
>>> @@ -63,6 +63,9 @@ struct SMMUv3State {
>>>        qemu_irq     irq[4];
>>>        QemuMutex mutex;
>>>        char *stage;
>>> +
>>> +    /* SMMU has HW accelerator support for nested S1 + s2 */
>>> +    bool accel;
>>
>> Have you considered modeling with a QOM object instead ?
> 
> A bit of history on this:
> 
> The SMMUv3 accel support was introduced first as a separate device,
> -device arm-smmuv3-accel
> 
> https://lore.kernel.org/qemu-devel/20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com/
> 
> However, the general consensus at that time was that we should instead
> model it on the -device arm-smmuv3 itself, with an added "accel" property.
> 
> Eric had also suggested making use of something similar to the
> TYPE_VFIO_IOMMU_IOMMUFD / LEGACY classes for selecting the iommu_ops.
> https://lore.kernel.org/qemu-devel/1105d100-dd1e-4aca-b518-50f903967416@redhat.com/
> 
> In RFCv3, I did introduce a TYPE_ARM_SMMUV3_ACCEL object class, but we
> later found that it wasn’t doing much beyond helping to retrieve the iommu_ops
> based on the object type, so decided to drop it.
> https://lore.kernel.org/qemu-devel/71ca9132-8deb-4f57-abb0-2bcc0fe93ae9@redhat.com/
> 
>  From your feedback, I understand that you would like to revisit that approach
> again. Just to make sure I get this right, is the SMMUv3AccelClass you have in
> mind meant to be an abstract object, like HOST_IOMMU_DEVICE, or are
> you suggesting another child device object?

HOST_IOMMU_DEVICE are for host IOMMU backends (VFIO IOMMU Type1
legacy and IOMMUFD). I was imagining an "arm-smmuv3" children class
for acceleration.

I understand I am jumping a bit late in the discussion. Sorry about
that and the late reply also.

I have been experimenting with your series on other systems and on
an ARM system with MLX5 VFs and an L4 GPU. I had to fake CANWBS
support in the host kernel to make progress. On a side note, I also
pulled in a patch from Nicolin to add dmabuf support and it seemed
to behave ok. This would require more in-depth P2P testing. That's
another topic we should discuss in the QEMU 11.0 cycle.


> Please let me know if there is an example/precedent, I can look at for a similar
> object model in QEMU.

Now regarding modeling, it is more or less a design choice. But while
I scanned through the code, I felt there was some problems that could
be solved in a cleaner way with a sub class. The changes are mostly
about moving code in different places and changing/removing the
"if (s->accel) parts". Don't change everything now, I will check RFCv3.

Nevertheless, they are several more issues, build breakages and also
runtime breakage that should be addressed. Let's do that first.

Furthermore, an (idealistic) design principle of QEMU that we tend to
forget is to offer acceleration when possible and else fallback to
emulation, in order to guarantee parity of features between different
hardware. I expected the "arm-smmuv3" device to decide to operate in
accelerated mode when ever possible, i.e when the IOMMUFD backend
(the SMMUV3 + the FW) offers the right level of functionality. This
would allow the machine to maintain a constant view of the sMMUv3
device and facilitate its integration with management layers and
ease migration too.

I understand this is complex, it has been done for some interrupt
controllers, and this is not the approach of the series.

That said, what about integration with libvirt ?


Thanks,

C.


