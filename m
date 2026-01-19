Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CCBCCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuaw-0008Jd-HV; Mon, 19 Jan 2026 14:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vhuas-0008Eb-Mm
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vhuaq-0000fQ-4U
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768849633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rIQNguDHR9zKux4RbrR8PhkBdMeFMgTWdZr5aNFOebU=;
 b=TDcaZuPKZDIMaRI56hETn3jdCjuKOwU4e3g19+/tn0RQQgUMzhN4kzdbXB383RoDPvkijd
 FglUGyYCMQMxDAbLasXC7VTk5P6h1kOHf9O0gwyx1HHXuspCRgCx43K94CJ5CnP66HW4fK
 vjV5gG0VXu2FJBHPCM67pD7tETZ5Q0E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-E8BxE4xeMs211DnORXel9w-1; Mon, 19 Jan 2026 14:07:12 -0500
X-MC-Unique: E8BxE4xeMs211DnORXel9w-1
X-Mimecast-MFC-AGG-ID: E8BxE4xeMs211DnORXel9w_1768849631
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso43054465e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768849631; x=1769454431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rIQNguDHR9zKux4RbrR8PhkBdMeFMgTWdZr5aNFOebU=;
 b=ijEK/8O7bNnmLnJDKhy3uklMjn4ukcO+DvjM+3TanPWfp+aNugJx2jJocfmFWXPX9R
 tq0/OHKsoQV9Io2RAYTeB7iWokAGjxCdzDTrKtUtVF0mbHBQ0Xldgg6B+dtAkFc+qlkh
 4lq9qDfO17W0W4t8zhnPBn/E9K4XZwu5qFKPflJi3hHxhMPRcVwjJQUL6bpkeumGEqom
 cMNnQVAnc2fonAZDEQSomWwZ3I8/T3NHfikBVdyRnrLU/zidWVxVBENSxO07VYZKg8SA
 YU6r0EFP82MVFpC9kjGxtWyp9HtCzU6QipFVYJ9Xd6uGU60G501IhWxEFdZNsaNN7czd
 JKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849631; x=1769454431;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIQNguDHR9zKux4RbrR8PhkBdMeFMgTWdZr5aNFOebU=;
 b=aqJgx2Y1G/mhn283/sUxvH6DgYciUR8oLYP2+RCriAxLsKvbwRymjEZ3FiBganvLx/
 L94+wdxM8gDBKMt39n/kR9AFjy74r3GN5rIgNyBxUERLnsWw1fu4H2aC8IjwcpbCoVRj
 V3n3wFRcA+Bud8UAwxDkDh/+ZtDnLbz8aFMCegflNwaQOKhi9W3LWU11N0CRJvWWb1H3
 C1qDu60XBM8xI2PXA6eOU80cluWVjglVvbqfExtbAeBiE9QWzLUCDJcoJNnwKpijW4UW
 dV4RSoaft9wxvcsvung5G0+GomE0a8I9+PGbD3Z3ACoJ8PVy/RX66XrY5gzM4F+b6mS9
 W0dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9r+lIACkxGX3KVnYmcl2UBx4GeSCDPSri+/pKtVDYMk3m1mRkVvnJAppRLxt03K1Wzy4F4tnoRBWa@nongnu.org
X-Gm-Message-State: AOJu0YzrLozUPzoyBO+/MsMO+rQCD85kvN7yRbh+BZmuhUSEYEwLkT4E
 b7/jGDpTdfnWi1ZaOGxv5GO+7+jUZ2fj142hMw/q1pfMoDceQzwKJkugyui1RKzBrsIlMqe03In
 7gY3J8cHfZZJ81zYIsRiz7CnfhIUjrMrWVpjvTG7+4hGm8B0hpoKboiWp
X-Gm-Gg: AY/fxX7pcHnhhMlBdgsOuo5NDa9HRMcgiJc7dHgBFfilB+URvEbe1TKEuScwF4tGDfi
 MNYSPiOhWSd6tTenBDIy1JalugnW7eoVMvNiFowRWGZNOvOL50bsML/dm7foQQCNM1/0jPTqafQ
 cIHWr6AB5kmG4iuxGVCzh66cIx+La0wO+N4PtcPl9AFudWrV9Tj0qIP7zEitGJu4D2rHMsALOi7
 wYMILmVhuGodBLFcxybeI8UOeAvYKpZLjBiaMxNuw9xKDg7LQnKZ8ikjV/xZJYy5E2IHvc7mRDy
 ASRBH9xUd15f3Lp6t4g1O3iF9oYCer1gAQh44pkC5vVTZ5Rno37WKkLboLpKs2dIbXo0grNpKaM
 VmXNOM9YHEQLSE6m5sL6/26D8raYgXm+38TjTOW4E9SC9lNKh
X-Received: by 2002:a05:600c:4e50:b0:47e:e952:86cf with SMTP id
 5b1f17b1804b1-4801e3502bamr156260855e9.34.1768849630740; 
 Mon, 19 Jan 2026 11:07:10 -0800 (PST)
X-Received: by 2002:a05:600c:4e50:b0:47e:e952:86cf with SMTP id
 5b1f17b1804b1-4801e3502bamr156260365e9.34.1768849630282; 
 Mon, 19 Jan 2026 11:07:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999824csm24742876f8f.39.2026.01.19.11.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 11:07:09 -0800 (PST)
Message-ID: <0713641f-7173-4cff-a4c6-0e6a2872be65@redhat.com>
Date: Mon, 19 Jan 2026 20:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-36-skolothumtho@nvidia.com>
 <d285998e-0250-40eb-97a3-996d5471abac@redhat.com>
 <CH3PR12MB7548AB6F73A2143E1B01E5C4AB88A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR12MB7548AB6F73A2143E1B01E5C4AB88A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/19/26 18:22, Shameer Kolothum wrote:
> 
> 
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 19 January 2026 16:17
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
>> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
>> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>
>> Subject: Re: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
>> vfio-pci devices
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 1/11/26 8:53 PM, Shameer Kolothum wrote:
>>> Add support for synthesizing a PCIe PASID extended capability for
>>> vfio-pci devices when PASID is enabled via a vIOMMU and supported by
>>> the host IOMMU backend.
>>>
>>> PASID capability parameters are retrieved via IOMMUFD APIs and the
>>> capability is inserted into the PCIe extended capability list using
>>> the insertion helper. A new x-vpasid-cap-offset property allows
>>> explicit control over the placement; by default the capability is
>>> placed at the end of the PCIe extended configuration space.
>>>
>>> If the kernel does not expose PASID information or insertion fails,
>>> the device continues without PASID support.
>>>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>   hw/vfio/pci.c           | 84
>> +++++++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/pci.h           |  1 +
>>>   include/hw/core/iommu.h |  1 +
>>>   3 files changed, 86 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index c734472721..96990576ac 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -24,6 +24,7 @@
>>>   #include <sys/ioctl.h>
>>>
>>>   #include "hw/core/hw-error.h"
>>> +#include "hw/core/iommu.h"
>>>   #include "hw/pci/msi.h"
>>>   #include "hw/pci/msix.h"
>>>   #include "hw/pci/pci_bridge.h"
>>> @@ -2498,9 +2499,71 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice
>> *vdev, uint16_t pos)
>>>       return 0;
>>>   }
>>>
>>> +/*
>>> + * Try to retrieve PASID capability information via IOMMUFD APIs and,
>>> + * if supported, synthesize a PASID PCIe extended capability for the
>>> + * VFIO device.
>>> + *
>>> + * Use user-specified PASID capability offset if provided, otherwise
>>> + * place it at the end of the PCIe extended configuration space.
>>> + */
>>> +static void vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev)
>>> +{
>>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>>> +    HostIOMMUDeviceClass *hiodc;
>>> +    PasidInfo pasid_info;
>>> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>>> +    uint16_t pasid_offset;
>>> +
>>> +    if (vdev->vbasedev.mdev) {
>>> +        return;
>>> +    }
>>> +
>>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>> +    if (!hiodc || !hiodc->get_pasid_info ||
>>> +        !hiodc->get_pasid_info(hiod, &pasid_info) ||
>>> +        !(pci_device_get_viommu_flags(pdev) &
>> VIOMMU_FLAG_PASID_SUPPORTED)) {
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * Check if user has specified an offset to place PASID CAP,
>>> +     * else select the last offset as default
>>> +     */
>>> +    if (vdev->vpasid_cap_offset) {
>>> +        if (!QEMU_IS_ALIGNED(vdev->vpasid_cap_offset,
>> PCI_EXT_CAP_ALIGN) ||
>> For other checks you put an assert i pcie_insert_capability()
>>> +            vdev->vpasid_cap_offset < PCI_CONFIG_SPACE_SIZE ||
>>> +            vdev->vpasid_cap_offset + PCI_EXT_CAP_PASID_SIZEOF >
>>> +                PCIE_CONFIG_SPACE_SIZE) {
>>> +            error_report("vfio: invalid x-vpasid-cap-offset 0x%x, skipping PASID",
>>> +                        vdev->vpasid_cap_offset);
>>> +            return;
>>> +        }
>>> +        pasid_offset = vdev->vpasid_cap_offset;
>>> +    } else {
>>> +        pasid_offset = PCIE_CONFIG_SPACE_SIZE -
>> PCI_EXT_CAP_PASID_SIZEOF;
>>> +        warn_report("vfio: PASID capability offset(x-vpasid-cap-offset) not
>> specified, "
>>> +                    "placing at the default offset 0x%x",
>>> +                    pasid_offset);
>> I am not sure we want a warn_report() if this is a normal behavior. Add
>> a trace point instead?
> 
> Ok. I will replace this with a common trace for this function.
> 
>>> +    }
>>> +
>>> +    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER,
>>> +                                pasid_offset, PCI_EXT_CAP_PASID_SIZEOF)) {
>>> +        error_report("vfio: Placing PASID capability at offset 0x%x failed",
>>> +                     pasid_offset);
>> instead of having asserts in pcie_insert_capability() you could
>> factorize all checks there including the 4B alignment check and return
>> false if any fails. Then you could propably get rifd of above checks
>> which are partially redundant. Thanks Eric
> 
> Agreed, will refactor accordingly.
Please add an 'Error *' parameter to vfio_pci_synthesize_pasid_cap() and
propagate the error.

Thanks,

C.


