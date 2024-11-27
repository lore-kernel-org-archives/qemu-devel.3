Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D27ED6D245
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 23:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGR4g-0005zF-Nb; Wed, 27 Nov 2024 18:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tGR4e-0005yh-6m
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 18:03:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tGR4c-0005Mp-Km
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 18:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732748631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B12QmkB/sHu/AYYcn0kiQkDRQSRXiLEWmIUis3o0v8w=;
 b=Blb851pzNUccVCHz+V9CAc/e9oXDYFEFk5EFgi04O2H4UMLewsTuChcg56JVmduhiesSfX
 2yJGvGdAQEKsfZHzFiSjhQbjcw9s0RwGMy0Aa8/WNgvFh6Jii050+iLh2rV8Liodyfkj8i
 wphoHw5u5b6oWlbOJ+gzxQejn7Rs/fc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-l-YzFG4_PhedZdT2P-ZfNg-1; Wed, 27 Nov 2024 18:03:47 -0500
X-MC-Unique: l-YzFG4_PhedZdT2P-ZfNg-1
X-Mimecast-MFC-AGG-ID: l-YzFG4_PhedZdT2P-ZfNg
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7ace5dd02so2543495ab.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 15:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732748627; x=1733353427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B12QmkB/sHu/AYYcn0kiQkDRQSRXiLEWmIUis3o0v8w=;
 b=h1ahj6ajyVK0eSVemDXBaA2Y9EdLazSo+sHxFmP7Td2uxlPxecGrVyJcXdxcpb/eS+
 yQJZm9pIJqaJht8VhkoKuQqoU4qxGfWdllxI87zYX7ibeThgf7h1Od1RMdqClMt6nlzO
 PeLiBP4QmDDNZ1D4b6R7HeXiL5NWpKJtJzUsK1mHtcK0IHVLHbSkvQbzu/i80QdSiyZ3
 DkKj4PVfOFygx2BZdeqx2igMXDnNaF/4uLY5xuLqYYt1uZgr4kTyFVa7BvZ6Y6ZiTCVc
 Aipt2WhfLy2VD5BgvbBhckaevHoZJZ/0MCtIIrkpi0V8rdIdy8DG96VZIiOFYwi4ystI
 2nPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmk2jgM5fLU/7w/AZZgkm3R1DZ+KFwQILfuF9fOMfhL5Evk5Vim3TR/mDYvhXRBYw8+mSjr6MgwVbn@nongnu.org
X-Gm-Message-State: AOJu0YwVrjYI6DG8AAK3f//luwFDMTfnCxbmpTf7qAf971CbzMa6ciRG
 HYA9/JFfMyUdODtW3v/cVNOAZ6XcJv059dT2dvhZkRg7ceLLwn4brWwKhv2G2uvvYN27za9+atK
 NbvS3mW1eP7R6E1ODgDIp0eCUP1gNkA4n82T13l7iFy+Tnh6n5eCP
X-Gm-Gg: ASbGnctA1FQFnF9ADxbVZMqjMRUK2YP31KZWoDrFKAG2CfINl3u8i/+BLDhu7A17Gcs
 lIUxyFNsKT5O/mF8xzSkh5XAStAatgd3aqNep9YlhWqJP2rH5DWl/IOZC6Cfy78Slq/hpnKxjEL
 rBgKfecCeX0ZnwRwK6sLzB5nABNManU30uBszDx2VsooZ3uIodoiDSUYOxP7hw36C3Y83KQF94z
 vzRDMpbhe7DkxfgvhTo23tNCNhbAhlFcTapoZJUcUl4RXrXfE8=
X-Received: by 2002:a05:6e02:3312:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3a7c5b1a78bmr45534805ab.0.1732748626751; 
 Wed, 27 Nov 2024 15:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEFPvcSRcdt27+r9AKdZQMAP/ep7Xe7LOkxD0twjxGQ6lgrTqjek+6BBIEKJ0q4COQyfIBKg==
X-Received: by 2002:a05:6e02:3312:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3a7c5b1a78bmr45534515ab.0.1732748626403; 
 Wed, 27 Nov 2024 15:03:46 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230e5ec80sm14862173.86.2024.11.27.15.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 15:03:45 -0800 (PST)
Message-ID: <9a62fa8d-a7a0-4bc1-bccb-2fcfaa119d65@redhat.com>
Date: Wed, 27 Nov 2024 18:03:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20241127160031.GA1253388@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/27/24 11:00 AM, Jason Gunthorpe wrote:
> On Wed, Nov 27, 2024 at 10:21:24AM +0000, Shameerali Kolothum Thodi wrote:
>>> For SMMUv3, NVIDIA-specific vCMDQ, it needs a parameter to state that
>>> specifically,
>>> since I'm concluding from reading the SMMUv3 version G.a spec, that
>>> ECMDQ was added
>>> to be able to assign an ECMDQ to a VM,
>>
>> Not sure the intention of ECMDQ as per that specification is to assign
>> it to a VM. I think the main idea behind it is to have one Command Queue
>> per host CPU to eliminate lock contention while submitting commands
>> to SMMU.
> 
> Right
> 
>> AFAIK it is not safe to assign one of the ECMDQ to guest yet. I think there is no
>> way you can associate a VMID with ECMDQ. So there is no plan to
>> support ARM ECMDQ now.
> 
> Yep
>
'Yet' ...
The association would be done via the VMM -- no different then what associates
an assigned device to a VM today -- no hw-level (VM-)ID needed; a matter of exposing
it to the VM, or not; or mapping the (virtual) CMDQ to the mapped/associated ECMDQ.
They are purposedly mapped 64K apart from each other, enabling page-level protection,
which I doubt is a per-CPU req for lock contention avoidance (large-cache-block
spaced would be sufficient, even 4k; it's 64k spaced btwn ECMDQ regs .. the largest
ARM page size.

Summary: let's not assume this can't happen, and the chosen cmdline prevents it.

>> NVIDIA VCMDQ is a completely vendor specific one. Perhaps ARM may come
>> up with an assignable CMDQ in future though.
> 
> Yes, it is easy to imagine an ECMDQ extension that provides the same HW
> features that VCMDQ has in future. I hope ARM will develop one.
> 
Right, so how to know what op is being "accel"'d wrt smmuv3.

>>> ... and all needs to be per-instance ....
>>> ... libvirt  (or any other VMM orchestrator) will need to determine
>>> compatibility for
>>>       live migration. e.g., can one live migrate an accel=nv-vcmdq-based VM to
>>> a host with
>>>       accel=ecmdq support?  only nv-vcmdq?  what if there are version diffs of
>>> nv-vcmdq over time?
>>>       -- apologies, but I don't know the minute details of nv-vcmdq to
>>> determine if that's unlikely or not.
>>
>> Yes. This require more thought. But our first aim is get the basic smmuv3-accel
>> support.
> 
> Yeah, there is no live migration support yet in the SMMU qmeu driver,
> AFAIK?
> 
> When it gets done the supported options will have to be considered
> 
> Jason
> 


