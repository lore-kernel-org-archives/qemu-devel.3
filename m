Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBDBCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2A7-000353-Vt; Thu, 06 Nov 2025 10:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH2A5-00034n-T3
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:44:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH2A4-0005pc-4R
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762443871;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrtS7OE5fFjS+4EEx4jxL+x5VIOHBSmVKkH0CYWuIOw=;
 b=edL2GD5cVV9uOdiVRyKOoEQ0ohIySNxVFjmqCx6bem5V7KqmDiWotKE036uIdzINSQtt6x
 6AXB39dWg7FHjEz4YHBqEmgo9ykncrmOqwdvtcgxOs/Hb0PuG+W9uuCjZJNhXu/tlJtUwj
 fsAMWracL6Z2BkuH5ok4FBYFKaZWkqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Cqcb65deOMm7mhDf6pytIw-1; Thu, 06 Nov 2025 10:44:29 -0500
X-MC-Unique: Cqcb65deOMm7mhDf6pytIw-1
X-Mimecast-MFC-AGG-ID: Cqcb65deOMm7mhDf6pytIw_1762443868
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so599887f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443867; x=1763048667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrtS7OE5fFjS+4EEx4jxL+x5VIOHBSmVKkH0CYWuIOw=;
 b=Y5VBPimST5EjVuzOT+YoPKfG1GfkJmzYQPtjnx5yc04g2gCA0rIcDgOIC4/YmCvHCr
 CXkX8Z+0vqbavPRXHgQNjwDYNGpLwqifQdR1cQAEDzi/ZOM1XQEYtsNpgJl3JihZY3h9
 wJKDvUgfJNdNDCCR8AatkOoclozXJsPmWpyCkiyDlKO1SYfIj8MS+65RteGSLWNNLFuT
 DFiTApo0erNoczgNVKsP00cii9I9NtjoZ/wXhCLqDfzv/LvFUtzkA8rSr59ysp8FcjOQ
 qqwUSganx1xx7O8XqDwgx2nk/79l0/AwC1XJ5X5XOQDwFoEnXv7TD8xNLvbhiMZdmfsq
 X2SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf9v7OBgzUBU5nyrpb33zb/pjd3cEDR9RCTIKE4eF/3tBi3pCp5Hf1L75njzbDjB13rQdf3SOT0fWN@nongnu.org
X-Gm-Message-State: AOJu0YzjZedHxVxIm8Lc4u6vXPtF3EunjUDK50gajOanL1suXso+xlYK
 Ole7sMV6o2i3wnVEEL92XmQAA++EhZbRAh0C5AIVBvNb0yU6uCez9CsQ00v/Q/zZZzGbLW9lu44
 R5pg/jSMSYpcOtFECw89oodlmfrx7zX4oHTlFu+ABsqgzaEY5gFrSaP2h
X-Gm-Gg: ASbGncvLtcZMPDwSePDzs8/WJnlDNdWamRmQAUJ4rD933xFcxsiC23FHinDQg59+udx
 N8LoqVNEeB5DS4xGYetuTSrHNGg1P6Tr/hF4UE8wUB1G7sABHo6GopklshICQm2doOC3Q9E+Sdq
 6Ao6/BjbLr6tOJgK8x7f8zVVD8BvntLbkztmTx180EW2w901nB6lisWqJA44HwX3WLFTTvFghSI
 ovS2hfyuOoTx3stDoWLJ3gQCcc5/+xr5B+L3jTBxrFLb9OjUZz0iMiTUK0xXwYIX3nYqunjyIw/
 eybeYkWcgCLuGI/raX/arzOmBXBY9fF3EZRKsGy1LIHDCMvKyfS49/GGpybFZTYm+8Bqml4axHJ
 XJJFQxaMoS9+Yz32kzgMMo39akCH4YaHPPM2ToY2Z7xjIpQ==
X-Received: by 2002:a05:6000:410a:b0:429:c7dc:e613 with SMTP id
 ffacd0b85a97d-429e3307985mr5812495f8f.41.1762443866699; 
 Thu, 06 Nov 2025 07:44:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5N2Q5PmUJ+DEDiJjXNzpnOOQkuogmPzPprtDwWHGK2mo0kIowWXjfL++0E4ks6e0Z1ohHug==
X-Received: by 2002:a05:6000:410a:b0:429:c7dc:e613 with SMTP id
 ffacd0b85a97d-429e3307985mr5812456f8f.41.1762443866226; 
 Thu, 06 Nov 2025 07:44:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb4771cfsm5696426f8f.30.2025.11.06.07.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:44:25 -0800 (PST)
Message-ID: <b4ec85e7-2142-44b1-9cc1-315b75e6d2bb@redhat.com>
Date: Thu, 6 Nov 2025 16:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
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
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-32-skolothumtho@nvidia.com>
 <1be3383e-843f-49b8-a246-59375c42aaae@redhat.com>
 <CH3PR12MB7548610D1BE66DA63CFE788EABC2A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548610D1BE66DA63CFE788EABC2A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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



On 11/6/25 3:27 PM, Shameer Kolothum wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 06 November 2025 13:56
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>> On 10/31/25 11:50 AM, Shameer Kolothum wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> If user wants to expose PASID capability in vIOMMU, then VFIO would also
>> need to report?
>>> report the PASID cap for this device if the underlying hardware supports
>>> it as well.
>>>
>>> As a start, this chooses to put the vPASID cap in the last 8 bytes of the
>>> vconfig space. This is a choice in the good hope of no conflict with any
>>> existing cap or hidden registers. For the devices that has hidden registers,
>>> user should figure out a proper offset for the vPASID cap. This may require
>>> an option for user to config it. Here we leave it as a future extension.
>>> There are more discussions on the mechanism of finding the proper offset.
>>>
>>>
>> https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8C
>> BE2@BN9PR11MB5276.namprd11.prod.outlook.com/
>>> Since we add a check to ensure the vIOMMU supports PASID, only devices
>>> under those vIOMMUs can synthesize the vPASID capability. This gives
>>> users control over which devices expose vPASID.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/vfio/pci.c      | 37 +++++++++++++++++++++++++++++++++++++
>>>  include/hw/iommu.h |  1 +
>>>  2 files changed, 38 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 06b06afc2b..2054eac897 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -24,6 +24,7 @@
>>>  #include <sys/ioctl.h>
>>>
>>>  #include "hw/hw.h"
>>> +#include "hw/iommu.h"
>>>  #include "hw/pci/msi.h"
>>>  #include "hw/pci/msix.h"
>>>  #include "hw/pci/pci_bridge.h"
>>> @@ -2500,7 +2501,12 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice
>> *vdev, uint16_t pos)
>>>  static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>>  {
>>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>>> +    HostIOMMUDeviceClass *hiodc =
>> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>      PCIDevice *pdev = PCI_DEVICE(vdev);
>>> +    uint64_t max_pasid_log2 = 0;
>>> +    bool pasid_cap_added = false;
>>> +    uint64_t hw_caps;
>>>      uint32_t header;
>>>      uint16_t cap_id, next, size;
>>>      uint8_t cap_ver;
>>> @@ -2578,12 +2584,43 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>>>                  pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>>              }
>>>              break;
>>> +        case PCI_EXT_CAP_ID_PASID:
>>> +             pasid_cap_added = true;
>>> +             /* fallthrough */
>>>          default:
>>>              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>>          }
>>>
>>>      }
>>>
>>> +#ifdef CONFIG_IOMMUFD
>>> +    /*
>>> +     * Although we check for PCI_EXT_CAP_ID_PASID above, the Linux VFIO
>>> +     * framework currently hides this capability. Try to retrieve it
>>> +     * through alternative kernel interfaces (e.g. IOMMUFD APIs).
>> I don't catch this sentence . When are you supposed to read above
>> PCI_EXT_CAP_ID_PASID cap id then?
> That’s to make it future proof in case VFIO relaxes that.  If that happens
> the code above by default, will add the CAP and we may end with a
> duplicate at below offset.
OK thanks for the clarification. Then I would move the comment about
VFIO kernel code currently hiding the extended cap along with

+             pasid_cap_added = true;

and explain it is added to make it future proof in case VFIO relaxes that

Eric

>
>>> +     */
>>> +    if (!pasid_cap_added && hiodc->get_cap) {
>>> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_GENERIC_HW,
>> &hw_caps, NULL);
>>> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2,
>>> +                       &max_pasid_log2, NULL);
>>> +    }
>>> +
>>> +    /*
>>> +     * If supported, adds the PASID capability in the end of the PCIe config
>>> +     * space. TODO: Add option for enabling pasid at a safe offset.
>>> +     */
>>> +    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
>>> +                           VIOMMU_FLAG_PASID_SUPPORTED)) {
>>> +        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC) ?
>> true : false;
>> can't you direct set exec_perm = (hw_caps &
>> IOMMU_HW_CAP_PCI_PASID_EXEC);
> True 😊
>
> Thanks,
> Shameer


