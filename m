Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDC1D5D695
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 22:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Ajh-0003mf-Tr; Thu, 07 Nov 2024 17:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1t9Ajd-0003m1-FU
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 17:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1t9AjX-0005Xi-BJ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 17:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731017522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLj/r2S6FL5GjaiB48pVfo7q+aIuXmWCPCeY3VuXw6A=;
 b=dN0Nrq4oQ1nqRpnIDjdQkUQ3h6XNfhwiD1EDHr1mkKCHReOYjzNBbMx8b0npBMqn38NGiU
 MN4h/FQxZ3QI7DgTR/JTCvI5b6tFBTVg1bMAAy7gMoMp80NMbEGu556LkecznavLpZm95w
 uaoQ/ZTvFD2vLhRfjFFpJcS8FEMzvqA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-braSND52MNC2kJhloBFXaQ-1; Thu, 07 Nov 2024 17:10:33 -0500
X-MC-Unique: braSND52MNC2kJhloBFXaQ-1
X-Mimecast-MFC-AGG-ID: braSND52MNC2kJhloBFXaQ
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7180ab6e01dso1602118a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 14:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731017433; x=1731622233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLj/r2S6FL5GjaiB48pVfo7q+aIuXmWCPCeY3VuXw6A=;
 b=O7ivLVjWnjBNsWbPeUGl2iGCOit1HIJiXfmviHcqSGXfuTAIzagjuk3JRn5lfz7dKc
 gFKLWhe++4eipY37uP5aHLECbBtQ5cwUyClD7zKnX5pXO2GUKXL4NLBeCdZHacO9rFF6
 dPwKYmz2hya+PQSeq3RYDeJJ6Bhgu7SLhsiBgtyGtPJmJaZQ+Bj3+GeJ702e1WrGRBuo
 utohHQ+Dhgf66+8SZRgFQ1kS0J2AWmZhebT7iRZ/03G99Kux+21odtPdNZdYbNp20gkV
 J8HZbAbqfgxTHeRQtN0sQMkVILAlRguyE1xjhio+qXq6QePi/VtS0JLpQp7diEa6jNuL
 X+Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF682ZJ98DjrSpG5chvcCCTbx3rO0kzagktUxqvZ9obIPLsD0qUZi4JieC9YOOP6eIX4oHx+vT80IQ@nongnu.org
X-Gm-Message-State: AOJu0YzX8ZoSHwkV52SJtv/uNCPjIPdzJ9KtBnxX63YcLZhdCoLsqr2z
 d+9pc4m1SuevMxeLoVwaWvQSOQuUUUJhygqNskEbMAb1pX/9Vo3Z9lM96jV7VVUiu59Sj9eTdAX
 cCYQ631BwMr17Ql4kcENNT0MANxt9+STy/Qnz05RTDhlmZL5jDEvA
X-Received: by 2002:a05:6830:d8a:b0:717:ffa8:2481 with SMTP id
 46e09a7af769-71a1c1de35emr869914a34.3.1731017432986; 
 Thu, 07 Nov 2024 14:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa6yPmW5mzU/zWQQyftMlPwDBPtkxZ9m84bxJAiUUvGyyG0zAl1UuKqT4Q05mg7DmXp+AvPw==
X-Received: by 2002:a05:6830:d8a:b0:717:ffa8:2481 with SMTP id
 46e09a7af769-71a1c1de35emr869894a34.3.1731017432710; 
 Thu, 07 Nov 2024 14:10:32 -0800 (PST)
Received: from [192.168.40.163] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff57e913sm12412771cf.70.2024.11.07.14.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 14:10:32 -0800 (PST)
Message-ID: <d54115c8-f359-42c1-b402-b3d82064434a@redhat.com>
Date: Thu, 7 Nov 2024 17:10:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>,
 Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, nathanc@nvidia.com,
 arighi@nvidia.com, ianm@nvidia.com, jan@nvidia.com, mochs@nvidia.com
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <1845a6b8-5214-4379-85f4-3d36b61059dd@redhat.com>
 <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 11/7/24 3:31 PM, Nicolin Chen wrote:
> Hi Eric,
> 
> On Thu, Nov 07, 2024 at 12:11:05PM +0100, Eric Auger wrote:
>> On 11/1/24 05:09, Nicolin Chen wrote:
>>> Hi,
>>>
>>> This is a continued discussion following previous month's:
>>> https://lore.kernel.org/qemu-devel/Zvr%2Fbf7KgLN1cjOl@Asurada-Nvidia/
>>>
>>> Kernel changes are getting closer to merge, as Jason's planning to
>>> take vIOMMU series and smmuv3_nesting series into the iommufd tree:
>>> https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
>>> https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
>>> https://lore.kernel.org/all/0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com/
>>>
>>> So, I think it's probably a good time to align with each others and
>>> talk about kicking off some QEMU upstream work in the month ahead.
>>>
>>> @Shameer,
>>> Do you have some update on the pluggable smmuv3 module?
>>>
>>> Updates on my side:
>>> 1) I have kept uAPI updated to the latest version and verified too.
>>>     There should be some polishing changes depending on how the basic
>>>     nesting infrastructure would look like from Intel/Duan's work.
>>> 2) I got some help from NVIDIA folks for the libvirt task. And they
>>>     have done some drafting and are now verifying the PCI topology
>>>     with "iommu=none".
>>>
>>> Once the pluggable smmuv3 module is ready to test, we will make some
>>> change to libvirt for that and drop the auto-assigning patches from
>>> the VIRT code, so as to converge for a libvirt+QEMU test.
>>>
>>> FWIW, Robin requested a different solution for MSI mapping [1], v.s.
>>> the RMR one that we have been using since Eric's work. I drafted a
>>> few VFIO/IOMMUFD patches for that, yet paused for getting the vIOMMU
>>> series merged to this kernel cycle. I plan to continue in Nov/Dec.
>>> So, for the near term we will continue with the RMR solution, until
>>> we have something solid later.
>>>
>>> [1] https://lore.kernel.org/linux-iommu/ZrVN05VylFq8lK4q@Asurada-Nvidia/
>>
>> At Red Hat we may find some cycles to resume working on the QEMU
>> integration. Please can you sketch some tasks we could carry out in
>> coordination with you and Shameer? Adding Don in the loop.
> 
> That is great!
> 
> So, given that Shameer is working on pluggable module part and we
> have folks working on libvirt. I think the only big thing here is
> the SMMUv3 series itself. Please refer to the changes in the link:
>   - cover-letter: Add HW accelerated nesting support for arm SMMUv3
>   - https://github.com/nicolinc/qemu/commits/wip/for_smmuv3_nesting-v4/
> 
> I expect the IOMMU_HWPT_ALLOC (backend APIs) will go with Intel's
> series once their current "emulated devices" one gets merged. And
> I think I can prepare IOMMU_VIOMMU_ALLOC patches for backend APIs
> aligning with HWPT's.
> 
> That being said, one thing I am not sure is how we should bridge
> between these backend APIs and a virtual IOMMUs (vSMMU/intel). I
> think it'd be better for you and Red Hat to provide some insight,
> if calling the backend APIs directly from a viommu module isn't a
> preferable way.
> 
> We also need your comments on vSMMU module patches that are still
> roughly a draft requiring a rework at some small details I think.
> So, if your (and Don's) bandwidth allows, perhaps you could take
> over the vSMMU patches? Otherwise, we can also share the task for
> reworking.
> 
> Thanks!
> Nicolin
> 
Nicolin,
Hi!
Sounds like a plan.  Glad to join the effort.
- Don


