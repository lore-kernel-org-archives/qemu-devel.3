Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E83CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zqw-0007xv-Ea; Wed, 01 Oct 2025 12:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3zqr-0007vH-O6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3zqj-0007SP-GF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759336716;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yum00R55alYdIK8mAGDrE7V1l5Muj3zZnZ8uTuyHBNQ=;
 b=JbDvoTk1YhNEYNX3tTO1A06gN+RLCNviGQ5ukvHQCJ2xN05FYB37DjYNuUilKuDcOL7NKA
 XM4vWimb0EhwjdLWLLK7cZpMpBBg6FzlRAKOz7QXi5TXO0lT/tloslpFlHDYTichSvm5Ix
 DM6LNFNXWEBF50F24851mtK3DmG2tCE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-5M8r7wuMP_-iqKdEgYdPkQ-1; Wed, 01 Oct 2025 12:38:34 -0400
X-MC-Unique: 5M8r7wuMP_-iqKdEgYdPkQ-1
X-Mimecast-MFC-AGG-ID: 5M8r7wuMP_-iqKdEgYdPkQ_1759336713
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso904f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759336713; x=1759941513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yum00R55alYdIK8mAGDrE7V1l5Muj3zZnZ8uTuyHBNQ=;
 b=OCLQBDF7pOHnN0Vdl5wRgsxhy8YLdWGD73hOvtAGevJtwK65xF/Itx/U66pWURtbMg
 LCZlx8bsfoYv8dVrmZJaBBFRzArJIcMEb6TAOssPFr2ykvmeB68vp21yRh8n/eN5dtuw
 ZjPoUt+3lI3W9sbcRRZ7QQ93RV+ycVm3uOURJzHihiVWeaw2hHmcMIO/436zkHKl+Nhl
 pd/mlfgNWNfBjYDgCopsNsp+xkACqs9bJ/5gWBmo+U2YbL01ZHZsXoSP05oxkAUBUpXm
 JYrQB0DuNzmYFJNZ4PrT/abb5oVrW3mXeX9BP87Btxx75k9ZhTZeGH/uWEzBRa1+dW9E
 ChLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/8nDpw73bYNc3BHOGjRFGhCRHMLvOjEWxO8aBBFFwI7MAv140advWGe3DulBTb9zkqOcSDPjDvJxP@nongnu.org
X-Gm-Message-State: AOJu0YxXOxKpxFrIs/PV/o+jC1mosDSJzutGDlxzfTztpUNHZjDHMSAR
 HPQ5EAlYgJOV0ndJQEiCNY64c5l5rP15F25uZdXy3GK9g7t+MxlfTbb7aKu3VrFqhiuNNS+n2hw
 old1GUb7zRLeG4gQYwcieBAjycTgtjPaVblh/ojfvMhCRAeQ0cv7etkfW
X-Gm-Gg: ASbGncs7OSIRfAGGwtHptJ2c6tJjUE8DQGVsieEtox90pmVgcr0nwWRxV8AIMIT8YPx
 Mxs4BB1TuiQ4kFuglOTHHsgbrXbrUv1HwpDUrKHibOQ/9f36e9iBEw1mWdGDxu6W8MNUr8mLJIM
 Y7cOfXCdDmVX2ESlXix7M7jV185TQKg84grplZ/TVnRmNb5w/x/C9KYub6N6okk01H5aMeUiAm1
 VK5a47iz41Q1GfDBmiudstoH2wqB9ckHqDlVRxMpAZqCmtU9+HAxoSvQLW5o5LHqJd3PP9aJrN5
 Ls30JuLm0UtDDJBEDKg5cNn8cmXs9EQ3LDAFYoMTOi3JPKqZ6aijh1ZdlWE6TWsQ8IF97oSkgUP
 6akbuXYR146yh3viH
X-Received: by 2002:a05:6000:4212:b0:411:f07a:680b with SMTP id
 ffacd0b85a97d-42557824e06mr3581613f8f.33.1759336712903; 
 Wed, 01 Oct 2025 09:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPdeBn7Ij/Jw+B/QnrKQVAdQUXStjp2yNVqo8Km0yxEZP9iSuo7rdIX9ZO9hpvMS1mPFvpSw==
X-Received: by 2002:a05:6000:4212:b0:411:f07a:680b with SMTP id
 ffacd0b85a97d-42557824e06mr3581584f8f.33.1759336712418; 
 Wed, 01 Oct 2025 09:38:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9e1bd14sm29341444f8f.28.2025.10.01.09.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 09:38:31 -0700 (PDT)
Message-ID: <41e361a0-5b61-4731-b12f-9a42b34b50e2@redhat.com>
Date: Wed, 1 Oct 2025 18:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <20250929170839.00002db9@huawei.com>
 <CH3PR12MB7548CD6223A90CD41D216353AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548CD6223A90CD41D216353AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 9/30/25 10:03 AM, Shameer Kolothum wrote:
>
>> -----Original Message-----
>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Sent: 29 September 2025 17:09
>> To: Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
>> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
>> SMMUv3 to vfio-pci endpoints with iommufd
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On Mon, 29 Sep 2025 14:36:22 +0100
>> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>>
>>> Accelerated SMMUv3 is only useful when the device can take advantage of
>>> the host's SMMUv3 in nested mode. To keep things simple and correct, we
>>> only allow this feature for vfio-pci endpoint devices that use the iommufd
>>> backend. We also allow non-endpoint emulated devices like PCI bridges and
>>> root ports, so that users can plug in these vfio-pci devices. We can only
>>> enforce this if devices are cold plugged. For hotplug cases, give appropriate
>>> warnings.
>>>
>>> Another reason for this limit is to avoid problems with IOTLB
>>> invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an
>> associated
>>> SID, making it difficult to trace the originating device. If we allowed
>>> emulated endpoint devices, QEMU would have to invalidate both its own
>>> software IOTLB and the host's hardware IOTLB, which could slow things
>>> down.
>>>
>>> Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
>>> translation (S1+S2), their get_address_space() callback must return the
>>> system address space so that VFIO core can setup correct S2 mappings
>>> for guest RAM.
>>>
>>> So in short:
>>>  - vfio-pci devices(with iommufd as backend) return the system address
>>>    space.
>>>  - bridges and root ports return the IOMMU address space.
>>>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> One question that really applies to earlier patch and an even more trivial
>> comment on a comment than the earlier ones ;)
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>
>>> ---
>>>  hw/arm/smmuv3-accel.c               | 68 ++++++++++++++++++++++++++++-
>>>  hw/pci-bridge/pci_expander_bridge.c |  1 -
>>>  include/hw/pci/pci_bridge.h         |  1 +
>>>  3 files changed, 68 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index 79f1713be6..44410cfb2a 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>>  static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>> *opaque,
>>
>> I should have noticed this in previous patch...
>> What does add stand for here?  This name is not particularly clear to me.
> Good question 😊.
>
> I believe the name comes from the smmu-common.c implementation of
> get_address_space:
>
> static const PCIIOMMUOps smmu_ops = {
>     .get_address_space = smmu_find_add_as,
> };
> Looking at it again, that version allocates a new MR and creates a
> new address space per sdev, so perhaps "add" referred to the address
> space creation.
this stems from the original terminology used in intel-iommu.c
(vtd_find_add_as)

the smmu-common code looks for a registered device corresponding to @bus
and @devfn (this is the 'find'). If it exists it returns it, otherwise
it allocates a bus and SMMUDevice object according to what exists and
initializes the AddressSpace (this is the 'add').


>
> This callback here originally did something similar but no longer does. 
I don't get why it does not do something similar anymore?
> So, I think it’s better to just rename it to smmuv3_accel_get_as()
Well I would prefer we keep the original terminology to match other
viommu code. Except of course if I misunderstood the existing code.

Thanks

Eric
>
> Thanks,
> Shameer


