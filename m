Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB7BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 07:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGYFT-0007Bd-D1; Wed, 05 Nov 2025 02:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGYFS-0007An-Ap
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:48:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGYFP-0004yX-Bz
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762328881;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+URNvpmOhOpLByQMwBQsqRi6zQqDbVw1Rv4S1E6+8Y=;
 b=hGO8BP4DucXEhAz5g798PFcCjiQtKMxLUw01VbDEVEd8h+Fw8o+XeEfg11CWSMlk2A6x07
 MA0xUD9wAaGTqOuenAVYbNyxpKP+exiICRjW9atHgg+vxPeBNLLmlS1NB3lxggr9kjRjwc
 xobu68YA5WE3+j/mg4AUzSargCLKX5Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-V4ZLc_IKMU2hBX-DZm6Yrw-1; Wed, 05 Nov 2025 02:48:00 -0500
X-MC-Unique: V4ZLc_IKMU2hBX-DZm6Yrw-1
X-Mimecast-MFC-AGG-ID: V4ZLc_IKMU2hBX-DZm6Yrw_1762328879
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4298da9fc21so3330173f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 23:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762328879; x=1762933679;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/+URNvpmOhOpLByQMwBQsqRi6zQqDbVw1Rv4S1E6+8Y=;
 b=X5XU6arZ3Xf/6ALE6o8tiuW1Z8C9u/XjzHnccuFF0mTl2uJqsKIWXupof2EaRpNx7X
 anzymLxMUMzurPx+MNb2YCm0HZmVGroNPFplbazgzGgRrs7CtTfHQlVakOgyHkjwkhL7
 RhkHENMatdusJE4AwNRNnPcQeLNuM4IWFKVCXuafOD07w3S3vEgxyTRgOjYNuyI58omZ
 GUOTUV6V8BhU1WLeYyIXEcIXOrIr1RXNvIsJNAA29vC1o41fx92aPHtIy5oLHnGNv+j+
 GpSf9XGqIq6KvIVYJqz9vrIh/1wHdzU+CFdHBFZRvlPzY64yvtej5rkLFy13S1be7a3L
 0w+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYbdT7LK3Jsjxvxl7vBVTUC7J0Ljxu5N5IO066+32VRkKSQHTBIlA35Jz9Gk9gzNaXpIeeZCwSb5ay@nongnu.org
X-Gm-Message-State: AOJu0Yx0GNn89NifMhQeu+aQiWXPcRja0OltkspF1UEZ+3XKYgaDrFVU
 3BCctyTQXHqKbAdNfvNROBqIVMaD+y0FFk8GgZI0dTrpOvOvvEKFq1sjRM4rOxssC8XmahfKg4k
 8gV3DDiunkbjtFdoR3Ajjmmp7DwPJWmf6DTRVZ7Zc+dev8ZLIo5wcXb1N
X-Gm-Gg: ASbGnct5BQ5PPvvewHxLsJwHaus5bPW/VQREHS5yRW115WdCTBSV6a88xZLdZpVXQ1f
 PWdOhi/FQ014G0W8d+GfauGtK8VRScwFqptYhWXqfPzyy/cy3k18nfCBgfXvm2YWHL+SxL6V5Kc
 F4dmTcSzkHUmUNOEcRAib1Zg+MlI3GsJmF3IPwYhqVewefjpA1QaG7Z5Yf8Q/znbkxcU0u/laBJ
 CSM07wKu2vYh90lzrm4dh/vb2u0Cx5Wj8xpdDiaN8UBZOw6hhJB+J6rX4FL0WXvJ6v7r1vwYn25
 cvnGrqIhasxVinq+FpEthb1WJ8rnFZcCDvfD6dadyCnD6U5VUWSk2hOcZ8AiGqv1jTFvzEHUfpX
 JVhd9c+zT0n1f/9ZmT6TyteWu6bVAh2x+hGUSAxwrVUzU1A==
X-Received: by 2002:a05:6000:616:b0:3ec:dd12:54d3 with SMTP id
 ffacd0b85a97d-429e33063cbmr1659859f8f.35.1762328878891; 
 Tue, 04 Nov 2025 23:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQzeV1UkXf5f8N0jjf5Sf+vsSXULrwOZNuNgFNVC6CZXahXUeBACfWQzHlL4hyh6rEKei1sg==
X-Received: by 2002:a05:6000:616:b0:3ec:dd12:54d3 with SMTP id
 ffacd0b85a97d-429e33063cbmr1659829f8f.35.1762328878355; 
 Tue, 04 Nov 2025 23:47:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1fbeadsm8856800f8f.37.2025.11.04.23.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 23:47:57 -0800 (PST)
Message-ID: <413ca488-1301-4f0c-90bf-ab3ef5a0791e@redhat.com>
Date: Wed, 5 Nov 2025 08:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
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
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <3c9e00f5-de9e-4e5c-8312-75eb4fcef81b@redhat.com>
 <aQo8MPCrr82wh3LI@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aQo8MPCrr82wh3LI@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Nicolin,

On 11/4/25 6:47 PM, Nicolin Chen wrote:
> On Tue, Nov 04, 2025 at 05:01:57PM +0100, Eric Auger wrote:
>>>>>> On 10/31/25 11:49 AM, Shameer Kolothum wrote:
>>>>>>> On ARM, devices behind an IOMMU have their MSI doorbell addresses
>>>>>>> translated by the IOMMU. In nested mode, this translation happens in
>>>>>>> two stages (gIOVA → gPA → ITS page).
>>>>>>>
>>>>>>> In accelerated SMMUv3 mode, both stages are handled by hardware, so
>>>>>>> get_address_space() returns the system address space so that VFIO
>>>>>>> can setup stage-2 mappings for system address space.
>>>>>> Sorry but I still don't catch the above. Can you explain (most probably
>>>>>> again) why this is a requirement to return the system as so that VFIO
>>>>>> can setup stage-2 mappings for system address space. I am sorry for
>>>>>> insisting (at the risk of being stubborn or dumb) but I fail to
>>>>>> understand the requirement. As far as I remember the way I integrated it
>>>>>> at the old times did not require that change:
>>>>>> https://lore.kernel.org/all/20210411120912.15770-1-
>>>>>> eric.auger@redhat.com/
>>>>>> I used a vfio_prereg_listener to force the S2 mapping.
>>>>> Yes I remember that.
>>>>>
>>>>>> What has changed that forces us now to have this gym
>>>>> This approach achieves the same outcome, but through a
>>>>> different mechanism. Returning the system address space
>>>>> here ensures that VFIO sets up the Stage-2 mappings for
>>>>> devices behind the accelerated SMMUv3.
>>>>>
>>>>> I think, this makes sense because, in the accelerated case, the
>>>>> device is no longer managed by QEMU’s SMMUv3 model. The
>>>> On the other hand, as we discussed on v4 by returning system as you
>>>> pretend there is no translation in place which is not true. Now we use
>>>> an alias for it but it has not really removed its usage. Also it forces
>>>> use to hack around the MSI mapping and introduce new PCIIOMMUOps.
>>>> Have
>>>> you assessed the feasability of using vfio_prereg_listener to force the
>>>> S2 mapping. Is it simply not relevant anymore or could it be used also
>>>> with the iommufd be integration? Eric
>>> IIUC, the prereg_listener mechanism just enables us to setup the s2
>>> mappings. For MSI, In your version, I see that smmu_find_add_as()
>>> always returns IOMMU as. How is that supposed to work if the Guest
>>> has s1 bypass mode STE for the device?
>> I need to delve into it again as I forgot the details. Will come back to
>> you ...
> We aligned with Intel previously about this system address space.
> You might know these very well, yet here are the breakdowns:
>
> 1. VFIO core has a container that manages an HWPT. By default, it
>    allocates a stage-1 normal HWPT, unless vIOMMU requests for a
You may precise this stage-1 normal HWPT is used to map GPA to HPA (so
eventually implements stage 2).
>    nesting parent HWPT for accelerated cases.
> 2. VFIO core adds a listener for that HWPT and sets up a handler
>    vfio_container_region_add() where it checks the memory region
>    whether it is iommu or not.
>    a. In case of !IOMMU as (i.e. system address space), it treats
>       the address space as a RAM region, and handles all stage-2
>       mappings for the core allocated nesting parent HWPT.
>    b. In case of IOMMU as (i.e. a translation type) it sets up
>       the IOTLB notifier and translation replay while bypassing
>       the listener for RAM region.
yes S1+S2 are combined through vfio_iommu_map_notify()
>
> In an accelerated case, we need stage-2 mappings to match with the
> nesting parent HWPT. So, returning system address space or an alias
> of that notifies the vfio core to take the 2.a path.
>
> If we take 2.b path by returning IOMMU as in smmu_find_add_as, the
> VFIO core would no longer listen to the RAM region for us, i.e. no
> stage-2 HWPT nor mappings. vIOMMU would have to allocate a nesting
except if you change the VFIO common.c as I did the past to force the S2
mapping in the nested config.
See
https://lore.kernel.org/all/20210411120912.15770-16-eric.auger@redhat.com/
and vfio_prereg_listener()
Again I do not say this is the right way to do but using system address
space is not the "only" implementation choice I think and it needs to be
properly justified, especially has it has at least 2 side effects:
- somehow abusing the semantic of returned address space and pretends
there is no IOMMU translation in place and
- also impacting the way MSIs are handled (introduction of a new
PCIIOMMUOps).
This kind of explanation you wrote is absolutely needed in the commit
msg for reviewers to understand the design choice I think.

Eric
> parent and manage the stage-2 mappings by adding a listener in its
> own code, which is largely duplicated with the core code.
>
> -------------- so far this works for Intel and ARM--------------
>
> 3. On ARM, vPCI device is programmed with gIOVA, so KVM has to
>    follow what the vPCI is told to inject vIRQs. This requires
>    a translation at the nested stage-1 address space. Note that
>    vSMMU in this case doesn't manage translation as it doesn't
>    need to. But there is no other sane way for KVM to know the
>    vITS page corresponding to the given gIOVA. So, we invented
>    the get_msi_address_space op.
>
> (3) makes sense because there is a complication in the MSI that
> does a 2-stage translation on ARM and KVM must follow the stage-1
> input address, leaving us no choice to have two address spaces.
>
> Thanks
> Nicolin
>


