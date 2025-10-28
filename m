Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2ADCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlU8-0005RB-6z; Tue, 28 Oct 2025 11:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDlU5-0005R2-Om
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDlU0-0000nU-4z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761664772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JC0GIqw2O7YTkRJTFGv1P1AWLNiOx5mJ+rxEXV6EMK8=;
 b=fEl2HbKMu6c17ip6+sba5ThBzMUciYO3avgGJeLavon+VMU0EQ4a/tsIcBY2kznIuFB46Z
 fwn1O57svW8ZWskqOw9/E2UBp/80Mwsq01pRQarHyg91wL8dzd41ObLws8x57aY6swawlR
 JyecWw6TWV6JAwaFx67gJTSsZdUHfQM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-afJQ7a3wMBmEt7XT3YLFNQ-1; Tue, 28 Oct 2025 11:19:30 -0400
X-MC-Unique: afJQ7a3wMBmEt7XT3YLFNQ-1
X-Mimecast-MFC-AGG-ID: afJQ7a3wMBmEt7XT3YLFNQ_1761664770
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-426ce339084so5809091f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761664769; x=1762269569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JC0GIqw2O7YTkRJTFGv1P1AWLNiOx5mJ+rxEXV6EMK8=;
 b=R6URP7zlbiFFa07xh9U/O677W6RagTODvXrAsLH8jCMZVARvxPEO+aJNl2AQ7bJWv5
 xGFt7qNUgolX/RQoCd1S3OvqD09N4tvgojwwWvPodpCuIwjRnSECyw7Z9yt7ypgkieT1
 weoCb7c9JLdRNslpyoaRxiJ6368/3oTYh61LSEGDXFEqRj6J3WvnRCE8qPuet1bwOqLO
 h3nO84xdD7O4Vo/+TJPqrb+dIxs0M0xCSPQFL6V+S1MS1rBB3aOOQndo4ejSvfwp5DBv
 twFlHfqdedPSl+DB64siP7uqkhuqsBG/2OsTSIrgmDr6AD2ldIapw3knjQPN7v9tONdq
 m5sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlh4uu0vJKLajPGD8397m0sAIyeV5cHcNV7gaUa++AJz87Yb4Ou5xHF1Y00K9++JLRDu/2Cn/VoisB@nongnu.org
X-Gm-Message-State: AOJu0YxZtGnPsOqXiuy8f9uJhdvOV/G1TbiJ7rHrIBRDKElCswZ8ha6+
 N3L8+bMRkbkCBCRhQ+nEbRTM/1YAoX0Uk8CZ0Qn4P5l+i0ylRlw5p9ePcfuRAAVJC6lOmEN0zkZ
 DczNqG7I/CpVFwL7srQm5WrgkfPpvE0/aK81oID2MTO6dqs/YY+eshLqV
X-Gm-Gg: ASbGncuZ7HghDiVVGcibkqMkm5pliIPEYPQ94X9NTrF7BYU1no4sxZ/qIBo3661iz/F
 wKO2XUV1t2WSSgLr4Fioc3XQGtkT0ASYPcIp0QC3bNNk8M8AAD6lRTzgse8/4pC+o9ScCWasv3N
 B9+D+I7vsNNeLueS986GY81b6SwOAMDu8wCbbE0a9gx6i0pTFrb+tGZdAEHxtjeMi4qq/MqFWO4
 VaSN94jmknknggu1fgWDNES2tGpRq09h/a1ZX6md0O4cw7wM16EyKSl3UNqUk4jywWiqEl+MF2u
 EimGgq1CbAx5+gM29Nx74bPkJsDMDa6vjXlhj8LgWf15UwzOs8g3XOEpYIDsJFVYZ7jkpaY+BYz
 t6Gg7B0pCFfmNQBCyVEIqW2ayXK5TIYHtlGoROVIgy4u+IA==
X-Received: by 2002:a5d:5d10:0:b0:426:ee08:8ea3 with SMTP id
 ffacd0b85a97d-429a7e86d08mr3651559f8f.53.1761664769513; 
 Tue, 28 Oct 2025 08:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyXezkF84YNRnE8OeqnuevOMKMWNXr5CGZKIAaE5UW7Twok9UwksgHhFGQuygS57ILhZFOYw==
X-Received: by 2002:a5d:5d10:0:b0:426:ee08:8ea3 with SMTP id
 ffacd0b85a97d-429a7e86d08mr3651524f8f.53.1761664769032; 
 Tue, 28 Oct 2025 08:19:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db964sm21053966f8f.33.2025.10.28.08.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 08:19:28 -0700 (PDT)
Message-ID: <dbdf9aaa-e238-4680-a66d-5759017c9e65@redhat.com>
Date: Tue, 28 Oct 2025 16:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/23] hw/pci: Introduce pci_device_get_viommu_flags()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-6-zhenzhong.duan@intel.com>
 <8dccb89a-f41b-4ae0-9f9d-f39f609766ee@redhat.com>
 <IA3PR11MB9136877A703966CA28C91D1792FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136877A703966CA28C91D1792FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/28/25 7:57 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v7 05/23] hw/pci: Introduce
>> pci_device_get_viommu_flags()
>>
>> On 10/24/25 10:43, Zhenzhong Duan wrote:
>>> Introduce a new PCIIOMMUOps optional callback, get_viommu_flags()
>> which
>>> allows to retrieve flags exposed by a vIOMMU. The first planned vIOMMU
>>> device flag is VIOMMU_FLAG_WANT_NESTING_PARENT that advertises the
>>> support of HW nested stage translation scheme and wants other sub-system
>>> like VFIO's cooperation to create nesting parent HWPT.
>>>
>>> pci_device_get_viommu_flags() is a wrapper that can be called on a PCI
>>> device potentially protected by a vIOMMU.
>>>
>>> get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
>>> flags which are only determined by user's configuration, no host
>>> capabilities involved. Reasons are:
>>>
>>> 1. host may has heterogeneous IOMMUs, each with different capabilities
>>> 2. this is migration friendly, return value is consistent between source
>>>     and target.
>>>
>>> Note that this op will be invoked at the attach_device() stage, at which
>>> point host IOMMU capabilities are not yet forwarded to the vIOMMU
>> through
>>> the set_iommu_device() callback that will be after the attach_device().
>>>
>>> See below sequence:
>>>
>>>    vfio_device_attach():
>>>        iommufd_cdev_attach():
>>>            pci_device_get_viommu_flags() for HW nesting cap
>>>            create a nesting parent HWPT
>>>            attach device to the HWPT
>>>            vfio_device_hiod_create_and_realize() creating hiod
>>>    ...
>>>    pci_device_set_iommu_device(hiod)
>>>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>>   MAINTAINERS          |  1 +
>>>   include/hw/iommu.h   | 25 +++++++++++++++++++++++++
>>
>> Hmm, why not under include/hw/pci/ ?
> I'm not sure if it's better to restrict iommu to pci subsystem.
> I have a vague memory there is iommu supporting non-PCI devices.

effectively on ARM we may need to support SMMU for platform devices too

Eric
>
>> Was this discussed ?
> No.
>
> Thanks
> Zhenzhong
>
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>   include/hw/pci/pci.h | 22 ++++++++++++++++++++++
>>>   hw/pci/pci.c         | 11 +++++++++++
>>>   4 files changed, 59 insertions(+)
>>>   create mode 100644 include/hw/iommu.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 36eef27b41..d94fbcbdfb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2338,6 +2338,7 @@ F: include/system/iommufd.h
>>>   F: backends/host_iommu_device.c
>>>   F: include/system/host_iommu_device.h
>>>   F: include/qemu/chardev_open.h
>>> +F: include/hw/iommu.h
>>>   F: util/chardev_open.c
>>>   F: docs/devel/vfio-iommufd.rst
>>>
>>> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
>>> new file mode 100644
>>> index 0000000000..9b8bb94fc2
>>> --- /dev/null
>>> +++ b/include/hw/iommu.h
>>> @@ -0,0 +1,25 @@
>>> +/*
>>> + * General vIOMMU flags
>>> + *
>>> + * Copyright (C) 2025 Intel Corporation.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HW_IOMMU_H
>>> +#define HW_IOMMU_H
>>> +
>>> +#include "qemu/bitops.h"
>>> +
>>> +/*
>>> + * Theoretical vIOMMU flags. Only determined by the vIOMMU device
>> properties and
>>> + * independent on the actual host IOMMU capabilities they may depend on.
>> Each
>>> + * flag can be an expectation or request to other sub-system or just a pure
>>> + * vIOMMU capability. vIOMMU can choose which flags to expose.
>>> + */
>>> +enum viommu_flags {
>>> +    /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>>> +    VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
>>> +};
>>> +
>>> +#endif /* HW_IOMMU_H */
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index bde9dca8e2..cf99b5bb68 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -462,6 +462,18 @@ typedef struct PCIIOMMUOps {
>>>        * @devfn: device and function number of the PCI device.
>>>        */
>>>       void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>>> +    /**
>>> +     * @get_viommu_flags: get vIOMMU flags
>>> +     *
>>> +     * Optional callback, if not implemented, then vIOMMU doesn't
>> support
>>> +     * exposing flags to other sub-system, e.g., VFIO.
>>> +     *
>>> +     * @opaque: the data passed to pci_setup_iommu().
>>> +     *
>>> +     * Returns: bitmap with each representing a vIOMMU flag defined in
>>> +     * enum viommu_flags.
>>> +     */
>>> +    uint64_t (*get_viommu_flags)(void *opaque);
>>>       /**
>>>        * @get_iotlb_info: get properties required to initialize a device
>> IOTLB.
>>>        *
>>> @@ -644,6 +656,16 @@ bool pci_device_set_iommu_device(PCIDevice
>> *dev, HostIOMMUDevice *hiod,
>>>                                    Error **errp);
>>>   void pci_device_unset_iommu_device(PCIDevice *dev);
>>>
>>> +/**
>>> + * pci_device_get_viommu_flags: get vIOMMU flags.
>>> + *
>>> + * Returns: bitmap with each representing a vIOMMU flag defined in
>>> + * enum viommu_flags. Or 0 if vIOMMU doesn't report any.
>>> + *
>>> + * @dev: PCI device pointer.
>>> + */
>>> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
>>> +
>>>   /**
>>>    * pci_iommu_get_iotlb_info: get properties required to initialize a
>>>    * device IOTLB.
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index d0e81651aa..c9932c87e3 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -3010,6 +3010,17 @@ void
>> pci_device_unset_iommu_device(PCIDevice *dev)
>>>       }
>>>   }
>>>
>>> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev)
>>> +{
>>> +    PCIBus *iommu_bus;
>>> +
>>> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
>>> +    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_flags) {
>>> +        return
>> iommu_bus->iommu_ops->get_viommu_flags(iommu_bus->iommu_opaque);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>>   int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>>>                            bool exec_req, hwaddr addr, bool lpig,
>>>                            uint16_t prgi, bool is_read, bool is_write)


