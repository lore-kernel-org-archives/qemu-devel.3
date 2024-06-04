Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293D7C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOdf-0005VG-Jc; Tue, 04 Jun 2024 03:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEOdc-0005S4-2Y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEOdZ-0002L9-P4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOe5HAyE0xfr3Cspq6gCWkXVKkXlYloeCN+g5nEU/iI=;
 b=hyMwwkuIKah6sNWT9Tny5XV4h+ZLWm2WgoQ/KRwPgooZAsodPi1ylr7fUtVJpAJg1x0LsR
 qhy5f5cK1V5HBQi/YdjYGI1wYCvr79+05zkMCPiC9dBdMx+NFgP6PFp47fQNy8ueLe84sY
 g4UG5kv58di0COuxcWnBM9RbdF9Vias=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-0_eZ4bgqM9GEvXTyCTjbBA-1; Tue, 04 Jun 2024 03:31:05 -0400
X-MC-Unique: 0_eZ4bgqM9GEvXTyCTjbBA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dc7e6e859so3406531f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717486264; x=1718091064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOe5HAyE0xfr3Cspq6gCWkXVKkXlYloeCN+g5nEU/iI=;
 b=CuFQrsxyM7C5dvF/TDZu6eNSmhxZuWWPPqF0WMwBnwdW+s/fY/xxjBpn11/GjVzaB4
 SWYmibTufHcXIsK64NDf4C3OppPKU68C7vjcUpjhv7Qc3BpVhexZQwAJ0Ao3BkYW3/QX
 SQroArbN40/pSwSLwiBWVSchyzyGE9+6oOpIxRkdqq43ARKyK9AZpsk4rRiwEALn54uU
 M5KofXEQ6WHyj42oUWpd6wKWTLAWaGd5gv9Up5uYHXw7twD2tvdr7Dd8UvNdjVYZcXCx
 ZEkfeHZBGMt235wHlzv5y9BDqE2Bjd4/ui8T4GR34wCP5WjyYFQBWLnSLVqdhctKFF+T
 nUZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEX+9DMpioA+VVLujoWzr0t+KURChOeTBu8Ef4JzVPI6T+UTNLfxtesEfwmWrWn6lB3C7hkMXudTRsX7MkykgnQtMHXn0=
X-Gm-Message-State: AOJu0YyonbKUC/cVma9inorFv71akBV8VFNuLQbhnZvnUA473RKQJFEV
 HiTLp8S9nW85OLfAjC2AXZfMaOKL03u0aEwtjhDjIiFKY8k26JohYVOymPO0d/dBis/5JvnTmtK
 ftV4GkC7azTl25e5P1O6PIPz+shMhJ1pqDkDZluIjiqazj77zqOe9
X-Received: by 2002:adf:f7c4:0:b0:349:8ba8:e26d with SMTP id
 ffacd0b85a97d-35e0f25ade5mr8174966f8f.13.1717486264570; 
 Tue, 04 Jun 2024 00:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYcvB1+0fgppTR2Jw5Mk2G4taz4okM9GGD3IpPcTlLSJn2d0qujqWFn1LQaqxUUqC2xqIrew==
X-Received: by 2002:adf:f7c4:0:b0:349:8ba8:e26d with SMTP id
 ffacd0b85a97d-35e0f25ade5mr8174937f8f.13.1717486264056; 
 Tue, 04 Jun 2024 00:31:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cafb8sm10605914f8f.37.2024.06.04.00.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:31:02 -0700 (PDT)
Message-ID: <999a8b13-61e9-4c5d-a02b-a608487f7114@redhat.com>
Date: Tue, 4 Jun 2024 09:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
 <e20c3fce-5a5a-4efb-9383-9ed7c9c6ef32@redhat.com>
 <SJ0PR11MB67441F9E6629728ABBF7655092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67441F9E6629728ABBF7655092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/4/24 04:58, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
>> HostIOMMUDeviceClass::realize() handler
>>
>> Hi Zhenzhong,
>>
>> On 6/3/24 08:10, Zhenzhong Duan wrote:
>>> It calls iommufd_backend_get_device_info() to get host IOMMU
>>> related information and translate it into HostIOMMUDeviceCaps
>>> for query with .get_cap().
>>>
>>> Introduce macro VTD_MGAW_FROM_CAP to get MGAW which equals to
>>> (aw_bits - 1).
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/i386/intel_iommu.h |  1 +
>>>  hw/vfio/iommufd.c             | 37
>> +++++++++++++++++++++++++++++++++++
>>>  2 files changed, 38 insertions(+)
>>>
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index 7fa0a695c8..7d694b0813 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState,
>> INTEL_IOMMU_DEVICE)
>>>  #define VTD_HOST_AW_48BIT           48
>>>  #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
>>>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>>> +#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
>>>
>>>  #define DMAR_REPORT_F_INTR          (1)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index e4a507d55c..9d2e95e20e 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -25,6 +25,7 @@
>>>  #include "qemu/cutils.h"
>>>  #include "qemu/chardev_open.h"
>>>  #include "pci.h"
>>> +#include "hw/i386/intel_iommu_internal.h"
>>>
>>>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer,
>> hwaddr iova,
>>>                              ram_addr_t size, void *vaddr, bool readonly)
>>> @@ -619,6 +620,41 @@ static void
>> vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>>>  };
>>>
>>> +static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void
>> *opaque,
>>> +                                      Error **errp)
>>> +{
>>> +    VFIODevice *vdev = opaque;
>>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>>> +    enum iommu_hw_info_type type;
>>> +    union {
>>> +        struct iommu_hw_info_vtd vtd;
>>> +    } data;
>>> +
>>> +    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>>> +                                         &type, &data, sizeof(data), errp)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    caps->type = type;
>>> +
>>> +    switch (type) {
>>> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>>> +        caps->aw_bits = VTD_MGAW_FROM_CAP(data.vtd.cap_reg) + 1;
>> Please can you remind me of why you can't reuse the iova_ranges method.
>> isn't it generic enough?
> Yes, iova_ranges method is only for iova_ranges, we want to make
> HostIOMMUDevice.get_cap() a common interface.
>
> When we want to pass iova_ranges, we can add HOST_IOMMU_DEVICE_CAP_IOVA_RANGES
> and HostIOMMUDevice.iova_ranges.

I rather meant that iova_ranges is part of VFIOContainerBase and you
could reuse the technics used in hiod_legacy_vfio_realize, relying on a
common helper instead of using

VTD_MGAW_FROM_CAP(data.vtd.cap_reg). Doesn't it work? 


>
>>> +        break;
>>> +    case IOMMU_HW_INFO_TYPE_NONE:
>> so what about other types?
> There is no other types for now. When there is, we can easily add the code

Thanks

Eric

>
> case IOMMU_HW_INFO_TYPE_ARM_SMMU:
>     caps->aw_bits = xxx;
>
> Thanks
> Zhenzhong
>
>> Eric
>>> +        break;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>>> +
>>> +    hiodc->realize = hiod_iommufd_vfio_realize;
>>> +};
>>> +
>>>  static const TypeInfo types[] = {
>>>      {
>>>          .name = TYPE_VFIO_IOMMU_IOMMUFD,
>>> @@ -627,6 +663,7 @@ static const TypeInfo types[] = {
>>>      }, {
>>>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
>>>          .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>>> +        .class_init = hiod_iommufd_vfio_class_init,
>>>      }
>>>  };
>>>


