Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682BCC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc17V-00038k-Iv; Wed, 16 Jul 2025 08:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uc0wr-0005fq-Dv
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uc0wo-0002ro-OK
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752667755;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSiRsUrxMoHrzvFRd0P/VSpkA5IMslaEtgN3IawZPkw=;
 b=SJSOJS8CDUoXvO+1skIYPMiU2btxApBR2b6NPaVuRv/im5fShkkC641UztxQhCZhAz5Qlk
 ATYBfWjBF9IAKexFdE7fnfA8H5vfrWHIkyj0TLwDUJVSPxlSGQGPDAaXUCfwfVBtuh9zzA
 2Dg21GWrxVNLhFj1sMWzvEzov1xyXMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Gk3uUfUQNsCkCxRuKYcReg-1; Wed, 16 Jul 2025 08:09:13 -0400
X-MC-Unique: Gk3uUfUQNsCkCxRuKYcReg-1
X-Mimecast-MFC-AGG-ID: Gk3uUfUQNsCkCxRuKYcReg_1752667753
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so2899649f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752667752; x=1753272552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSiRsUrxMoHrzvFRd0P/VSpkA5IMslaEtgN3IawZPkw=;
 b=HuLSW/fvhqJ0IToU7XPPJwnX3Tb3GjtmWLyw6cs0D2znZtuO6CcK1vt8sl/Iyewy4i
 pxfh/AzINfuKxU5cV4s+WGzjSGWpAvcGqHuDmjPH3Df5C4PXoL7TH6+ECofN0wnOZCts
 gMxQyNc2sUeEeNCykJ6eIa/2omA/HROqnUDvuD8rs5dQNLH+wFJBty8t2bG+z803LHj1
 2J/m6crtTjw37G912NBfOGjmMYv+F0lM0kFzWIuiyW6WszYk3S8C8TVU26cDksq1WNoH
 ArXRsXyhuiZtWku9NYDRrLLC6L3DVyWK/qnQf4h+t0HUTjn7GlCm22SgNiaSDPCWiB/0
 Kdtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcSGZ+bqWFSZk6SXXrW0LUkpqKyExJMzCTD6S70ct5lwP6Q5vYIHPvt8mhV58psWCRABb9U5EQsUNG@nongnu.org
X-Gm-Message-State: AOJu0YwjLyja7pewmin4D90NBgR+P+xJUKCn9a7lKtw96ziPAwSSXP/a
 +fgTVKS+bVEIjc/VnK8XZv7ekBxb6X0e0B0cwQySmVBuSqWufKAgXCCz0SFKQB2k089W5chjz32
 AmuqOtnTGLgEVrDyntTG4ge5yMJcb+8LcmR7sUaqNkYD9mHbNEYJLBK8/
X-Gm-Gg: ASbGnctTMTELD1zNFuY5i5i5ehX5xob35/i3iVrRD6NmrnH3L3+lUZsideNbj4/zq0l
 O0jMJZTDmMHmPU/tyHlRunsq1hOQ/Xkn3MK9qc3AJMVkQtWqP75kRcAHtNUEcAkh/xRSGDuE4rM
 b+BiB3zv0ccu+OLH+jXkg4HTotNUsLyCJYgJOV4bXz5Enqw08VNMVRZTicE+bx0NmnecZe6g1jU
 5YZG8aTW/GoGYkUrRxMGeXS/Q5EPOpxBKQOoxxF6jGApPodqZ/dwWsBFUWGXYUP8vLzxKUeiKY+
 Gdn/YY+ZJkNmvOZto25wHtU1ONAq/8lAR8lod9TDDBNkA7UWa74mixeasHNhD5Ic4wFhv8RbNE9
 tamYP1kqk1ms=
X-Received: by 2002:a05:6000:430a:b0:3a5:3930:f57 with SMTP id
 ffacd0b85a97d-3b60e54b8d0mr2167750f8f.51.1752667752445; 
 Wed, 16 Jul 2025 05:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQQbthpOeBBBT/kolveiAWmpcRfuTFgiCTlaFeWyuvBm1QmUi/FxZ9LNFhmxpAJ9JWGQLYnw==
X-Received: by 2002:a05:6000:430a:b0:3a5:3930:f57 with SMTP id
 ffacd0b85a97d-3b60e54b8d0mr2167709f8f.51.1752667751913; 
 Wed, 16 Jul 2025 05:09:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d872sm17894043f8f.60.2025.07.16.05.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 05:09:11 -0700 (PDT)
Message-ID: <081c3534-332f-454a-985b-4dc81a3dd2a7@redhat.com>
Date: Wed, 16 Jul 2025 14:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-8-zhenzhong.duan@intel.com>
 <342129d6-0b96-440c-83ac-e9b8bc5b18a0@redhat.com>
 <IA3PR11MB9136C85F0799CB91572121FB9256A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136C85F0799CB91572121FB9256A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 7/16/25 12:31 PM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v3 07/20] intel_iommu: Check for compatibility with
>> IOMMUFD backed device when x-flts=on
>>
>> Hi Zhenzhong,
>>
>> On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
>>> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
>>> is passed to host to construct nested page table. We need to check
>>> compatibility of some critical IOMMU capabilities between vIOMMU and
>>> host IOMMU to ensure guest stage-1 page table could be used by host.
>>>
>>> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
>>> does not, then this IOMMUFD backed device should fail.
>>>
>>> Even of the checks pass, for now we willingly reject the association
>>> because all the bits are not there yet.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/i386/intel_iommu.c          | 30
>> +++++++++++++++++++++++++++++-
>>>  hw/i386/intel_iommu_internal.h |  1 +
>>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index e90fd2f28f..c57ca02cdd 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -40,6 +40,7 @@
>>>  #include "kvm/kvm_i386.h"
>>>  #include "migration/vmstate.h"
>>>  #include "trace.h"
>>> +#include "system/iommufd.h"
>>>
>>>  /* context entry operations */
>>>  #define VTD_CE_GET_RID2PASID(ce) \
>>> @@ -4355,7 +4356,34 @@ static bool vtd_check_hiod(IntelIOMMUState *s,
>> HostIOMMUDevice *hiod,
>>>          return true;
>>>      }
>>>
>>> -    error_setg(errp, "host device is uncompatible with stage-1
>> translation");
>>> +#ifdef CONFIG_IOMMUFD
>>> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>>> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
>> I am now confused about how this relates to vtd_get_viommu_cap().
>> PCIIOMMUOps.set_iommu_device = vtd_dev_set_iommu_device calls
>> vtd_check_hiod()
>> viommu might return HW_NESTED_CAP through
>> PCIIOMMUOps.get_viommu_cap
>> without making sure the underlying HW IOMMU does support it. Is that a
>> correct understanding? Maybe we should clarify the calling order between
>> set_iommu_device vs get_viommu_cap? Could we check HW IOMMU
>> prerequisites in vtd_get_viommu_cap() by enforcing this is called after
>> set_iommu_device. I think we should clarify the exact semantic of
>> get_viommu_cap().Thanks Eric
> My understanding get_viommu_cap() returns pure vIOMMU's capabilities
> with no host IOMMU's capabilities involved.
>
> For example, returned HW_NESTED_CAP means this vIOMMU has code
> to support creating nested hwpt and attaching, no matter if host IOMMU
> supports nesting or not.

Then I think you need to refine the description in 2/20 to make this clear.
stating explicitly get_viommu_cap returns theoretical capabilities which
are independent on the actual host capabilities they may depend on.
>
> The compatibility check between host IOMMU vs vIOMMU is done in
> set_iommu_device(), see vtd_check_hiod().
>
> It's too late for VFIO to call get_viommu_cap() after set_iommu_device()
> because we need get_viommu_cap() to determine if creating nested parent
> hwpt or not at attaching stage.
isn't it possible to rework the call sequence?

Eric
>
> If host doesn't support nesting, then creating nested parent hwpt will fail
> early in vfio realize before vtd_check_hiod() is called and we fail the hotplug.
>
> Thanks
> Zhenzhong


