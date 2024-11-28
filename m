Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDB1D6D25F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 04:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGW9p-0000qJ-Mt; Wed, 27 Nov 2024 23:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tGW9o-0000pv-6v
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 23:29:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tGW9m-0001SS-2m
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 23:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732768172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBoK3VTlTgbiTi148Sb9bV/nwHkROeav43fp9fq7+cQ=;
 b=Jqo0YjX5dj6ZzjCScuRvNU1vFQwD/tZ3eOR9fk4LQLBGGw/rklqtuIuumKbFD0dCh5xZXZ
 pWtlSPJ54sPjxcyMqkvifLeMPSWwP1FjIzZ14tKNy4ZDF58owbrG2Kh3oScH1cfLjM+MzG
 R/hDOOzCcu6oAboAcjWogbck+Zr9uwk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-NkUPSCVeOLey2yQqcG8crQ-1; Wed, 27 Nov 2024 23:29:29 -0500
X-MC-Unique: NkUPSCVeOLey2yQqcG8crQ-1
X-Mimecast-MFC-AGG-ID: NkUPSCVeOLey2yQqcG8crQ
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-843e5314cb8so36921339f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 20:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732768168; x=1733372968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WBoK3VTlTgbiTi148Sb9bV/nwHkROeav43fp9fq7+cQ=;
 b=CEYOWfjD/nC5Scs9kCEq9d2c0obgm091lXr8hUnjnF25r5ifmP9CgwwZc+eSZI3ewt
 Dd5cB50Q5HzYAn+YQCngnVuTekHgBR7W3D6Ns/+2Vm2Goz56p4TSj2rBzvO6g3T6lq81
 rJz3DtZjtkiqlyY66Da0mBTMiPAnnHOsSBDmGejP75IptGuca1LiqwmzSWp1BYHotnX1
 VpdEYWDt9hMukEY3KUwJUzB7Y574YbybQlTCY7ukFnaL7jwNtsD+griyL/8oe1mw7HV+
 nMLeep1jztsAihrSVi74hx5+plHY1mOGZUNZJsAaM6Hh8iekZEDwoRKjUdI7ykI7Dn+H
 guBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNeBTU+qbHuZQQs/W88PJSUuaWo4GgJAA2UQv9vDg1nAogkDaPv6Gr17Lu8bO/uvYatZGHg4NfLnSL@nongnu.org
X-Gm-Message-State: AOJu0YyA8a517pKnlh/r060usm5fjzLq7Yk3ErX/0eEMj6Y1fph4QFtD
 211PJ9hm2FcW31Cle5rqFWQ9DIwIK0zZ9cxwaLrDrqJQSTRMgBE5DXMPkWpE3SUUZz+Xaw5K2hd
 R91sqCzNaoR3Oefik7DiS07eH5a6aHZClo1MRa1rPFEfviU3fLXgn
X-Gm-Gg: ASbGnctGmHAo2qbhTrmIrTyYfVCvNeYQE9lWiqSGRTukvK6N5p4ek+8ZrvPSHsDljtG
 hMT/aH7BGud9Us1Q3jUJyxEEefQ2Zt1jJV3kxxd6hoUaYfn6qA2atrKSaATs/UCOMeoTG1HBczP
 9VosbZb+41XAo0y0uJ8WZwSGg1YAni9wOIh52KClNEv0mbJTB0Cw1nNqnPMzfdqtT8a/qKPHtIo
 kK8nXOODC3hJIZwh/mOhiX/ktVFcpUouclTiBJyrOSQSOVFzgo=
X-Received: by 2002:a05:6602:6b84:b0:843:eb5b:5293 with SMTP id
 ca18e2360f4ac-843ecf676b0mr684453039f.2.1732768168641; 
 Wed, 27 Nov 2024 20:29:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJlarvZiwULhpWAa+STdGx/5AIqz3vfz83AdoVH85mWxsrt3/Ujw8bXl+3/EO12kHp82BS4g==
X-Received: by 2002:a05:6602:6b84:b0:843:eb5b:5293 with SMTP id
 ca18e2360f4ac-843ecf676b0mr684451439f.2.1732768168328; 
 Wed, 27 Nov 2024 20:29:28 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ef129esm12108439f.27.2024.11.27.20.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 20:29:27 -0800 (PST)
Message-ID: <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
Date: Wed, 27 Nov 2024 23:29:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <d8fbaa677771425dac985438b4b1db59@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/27/24 5:21 AM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Donald Dutile <ddutile@redhat.com>
>> Sent: Tuesday, November 26, 2024 6:29 PM
>> To: Nicolin Chen <nicolinc@nvidia.com>; Eric Auger
>> <eric.auger@redhat.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>> Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for
>> SMMUv3 Nested device
>>
>>
>>
>> On 11/13/24 1:05 PM, Nicolin Chen wrote:
>>> Hi Eric,
>>>
>>> On Wed, Nov 13, 2024 at 06:12:15PM +0100, Eric Auger wrote:
>>>> On 11/8/24 13:52, Shameer Kolothum wrote:
>>>>> @@ -181,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
>>>>>        [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>>>>>        [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>>>>>        [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>>>>> +    [VIRT_SMMU_NESTED] =        { 0x0b000000, 0x01000000 },
>>>
>>>> I agree with Mostafa that the _NESTED terminology may not be the best
>>>> choice.
>>>> The motivation behind that multi-instance attempt, as introduced in
>>>> https://lore.kernel.org/all/ZEcT%2F7erkhHDaNvD@Asurada-Nvidia/
>>>> was:
>>>> - SMMUs with different feature bits
>>>> - support of VCMDQ HW extension for SMMU CMDQ
>>>> - need for separate S1 invalidation paths
>>>>
>>>> If I understand correctly this is mostly wanted for VCMDQ handling? if
>>>> this is correct we may indicate that somehow in the terminology.
>>>>
>>>> If I understand correctly VCMDQ terminology is NVidia specific while
>>>> ECMDQ is the baseline (?).
>>>
>>> VCMDQ makes a multi-vSMMU-instance design a hard requirement, yet
>>> the point (3) for separate invalidation paths also matters. Jason
>>> suggested VMM in base case to create multi vSMMU instances as the
>>> kernel doc mentioned here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
>> next.git/tree/Documentation/userspace-api/iommufd.rst#n84
>>>
>>> W.r.t naming, maybe something related to "hardware-accelerated"?
>>>
>> Given that 'accel' has been used for hw-acceleration elsewhere, that seems
>> like a reasonable 'mode'.
>> But, it needs a paramater to state was is being accelerated.
>> i.e., the more global 'accel=kvm' has 'kvm'.
> 
> I was thinking more like calling this hw accelerated nested SMMUv3 emulation
> as 'smmuv3-accel'.  This avoids confusion with the already existing
> 'iommu=smmuv3' that also has a nested emulation support.
> 
> ie,
> -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1 \
> 
I -think- you are saying below, that we have to think a bit more about this
device tagging.  I'm thinking more like
  - device arm-smmuv3,accel=<vcmdq>,id=smmu1,bus=pcie.1 \

>>
>> For SMMUv3, NVIDIA-specific vCMDQ, it needs a parameter to state that
>> specifically,
>> since I'm concluding from reading the SMMUv3 version G.a spec, that
>> ECMDQ was added
>> to be able to assign an ECMDQ to a VM,
> 
> Not sure the intention of ECMDQ as per that specification is to assign
> it to a VM. I think the main idea behind it is to have one Command Queue
> per host CPU to eliminate lock contention while submitting commands
> to SMMU.
> 
> AFAIK it is not safe to assign one of the ECMDQ to guest yet. I think there is no
> way you can associate a VMID with ECMDQ. So there is no plan to
> support ARM ECMDQ now.
> 
> NVIDIA VCMDQ is a completely vendor specific one. Perhaps ARM may come
> up with an assignable CMDQ in future though.
> 
>   and let the VM do CMDQ driven
>> invalidations via
>> a similar mechanism as assigned PCI-device mmio space in a VM.
>> So, how should the QEMU invocation select what parts to 'accel' in the
>> vSMMUv3 given
>> to the VM?  ... and given the history of hw-based, virt-acceleration, I can
>> only guess
>> more SMMUv3 accel tweaks will be found/desired/implemented.
>>
>> So, given there is an NVIDIA-specific/like ECMDQ, but different, the accel
>> parameter
>> chosen has to consider 'name-space collision', i.e., accel=nv-vcmdq  and
>> accel=ecmdq,
>> unless sw can be made to smartly probe and determine the underlying
>> diffs, and have
>> equivalent functionality, in which case, a simpler 'accel=vcmdq' could be
>> used.
>>
> 
> Yep. Probably we could abstract that from the user and handle it within
> Qemu when the kernel reports the capability based on physical SMMUv3.
> 
>> Finally, wrt libvirt, how does it know/tell what can and should be used?
>> For ECMDQ, something under sysfs for an SMMUv3 could expose its
>> presence/capability/availability
>> (tag for use/alloc'd for a VM), or an ioctl/cdev i/f to the SMMUv3.
>> But how does one know today that there's NVIDIA-vCMDQ support on its
>> SMMUv3? -- is it
>> exposed in sysfs, ioctl, cdev?
> 
> I think the capability will be reported through a IOCTL.  Nicolin ?
> 
>> ... and all needs to be per-instance ....
>> ... libvirt  (or any other VMM orchestrator) will need to determine
>> compatibility for
>>       live migration. e.g., can one live migrate an accel=nv-vcmdq-based VM to
>> a host with
>>       accel=ecmdq support?  only nv-vcmdq?  what if there are version diffs of
>> nv-vcmdq over time?
>>       -- apologies, but I don't know the minute details of nv-vcmdq to
>> determine if that's unlikely or not.
> 
> Yes. This require more thought. But our first aim is get the basic smmuv3-accel
> support.
> 
> Thanks,
> Shameer
> 


