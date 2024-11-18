Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A923CD591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 18:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD62k-00031H-Q6; Mon, 18 Nov 2024 13:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tD62i-000312-OF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tD62e-0007Pr-T4
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731952803;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWAj8ZogZjR+IZnXH6mLyiZiLZQ6Ryb13oIqtQO94wI=;
 b=ajfv9mqT8kz0+fEZ1bFHDbi87Mn+lMWVvs0HJZ70paxJTc7zQWv0KILHm6tTLvp1oM4VWo
 RpfH6Sqi8VMiHuAZxgKwR57w8/iJyqWGaJqqi+xneAtfuH/pBMMcosuAAenYUMJBWijFGN
 KyGi5zKtraWMvweQzsHyRG0XybjTVrE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-wCto82HqOUKhgT3ebgczqQ-1; Mon, 18 Nov 2024 12:59:59 -0500
X-MC-Unique: wCto82HqOUKhgT3ebgczqQ-1
X-Mimecast-MFC-AGG-ID: wCto82HqOUKhgT3ebgczqQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d41a460386so917116d6.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731952799; x=1732557599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWAj8ZogZjR+IZnXH6mLyiZiLZQ6Ryb13oIqtQO94wI=;
 b=bmotO/2IIHKtrJgBeLwiOEo1YyOJ+5eU9lBAMTvAvIDajEOYr81+JWspM++iktUgUf
 //E0sZ7V+W7kdhopQVHWWwUdTcMv4oYcQkxlB7Pa99DltI6unkZcGJ2biEt1KHH4mWV6
 lBr5I2VHA6x3AJneQhKVaOhgByYf1oSpBIbO7UjLXaHHZ/UutwyXlNm3MpQk/dYwFzTW
 Y8fYFLswKLxIXlOJRssVYh/U9QuUnaHWm/VPEVQcnP5ThHUL7XOaQc4nmljMSk6chE0w
 ADx5N9lM+m9K8vtGIB2c7XdYUa7R4G/HzhhaaTzfSPKt095Hy9gB6PALdN6ZnjWF5BNW
 rYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsnE6qrvxsc7e06x88cb7sqT9G59VLXXLwX6UKQVvOGZELqRioyACOuuZLyUcCRrP3d5JFP16MVXT3@nongnu.org
X-Gm-Message-State: AOJu0YwELAJAPkiRjl5l44Aa+5ChujIxun5c4x/KC+MWC1d0I2LIEu5S
 u6T6XPWKv20aBqpMYQrBZSCuazjV1YvUUH35bUQR6gAu4OMP3ScI2rfWuXZphdCXdUG1ibP543F
 gbwBKXayW51T0oaoINN78ecAlBjrQuEmj/vLRNMlNjIsSuXfK8CuA
X-Received: by 2002:a05:6214:20c3:b0:6d4:f8d:144e with SMTP id
 6a1803df08f44-6d40f8d16d2mr181873046d6.36.1731952799306; 
 Mon, 18 Nov 2024 09:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY0+Q4kTCmJn2w25wuCjW8UMMl554D2XIGOt84bi2Vg8fE9cVVoCsiIQ0Hoxk9HJe4EGqZNg==
X-Received: by 2002:a05:6214:20c3:b0:6d4:f8d:144e with SMTP id
 6a1803df08f44-6d40f8d16d2mr181872516d6.36.1731952798940; 
 Mon, 18 Nov 2024 09:59:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a85cf6fsm11858985a.47.2024.11.18.09.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 09:59:58 -0800 (PST)
Message-ID: <e36a1c1c-c880-4c64-82f9-34d55a04bd00@redhat.com>
Date: Mon, 18 Nov 2024 18:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
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
 arighi@nvidia.com, ianm@nvidia.com, jan@nvidia.com, mochs@nvidia.com,
 Don Dutile <ddutile@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <1845a6b8-5214-4379-85f4-3d36b61059dd@redhat.com>
 <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,

On 11/7/24 21:31, Nicolin Chen wrote:
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
>>>    There should be some polishing changes depending on how the basic
>>>    nesting infrastructure would look like from Intel/Duan's work.
>>> 2) I got some help from NVIDIA folks for the libvirt task. And they
>>>    have done some drafting and are now verifying the PCI topology
>>>    with "iommu=none".
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
>> At Red Hat we may find some cycles to resume working on the QEMU
>> integration. Please can you sketch some tasks we could carry out in
>> coordination with you and Shameer? Adding Don in the loop.
> That is great!
>
> So, given that Shameer is working on pluggable module part and we
> have folks working on libvirt. I think the only big thing here is
> the SMMUv3 series itself. Please refer to the changes in the link:
>  - cover-letter: Add HW accelerated nesting support for arm SMMUv3
>  - https://github.com/nicolinc/qemu/commits/wip/for_smmuv3_nesting-v4/
Looking at your branch I see the following series (marked with cover-letter)
*

  *

    cover-letter: Add RMR WAR for MSI mappings (based on former RMR flat
    mapping and not related to *[PATCH RFCv1 0/7] vfio: Allow userspace
    to specify the address for each MSI vector
    <https://lore.kernel.org/kvm/cover.1731130093.git.nicolinc@nvidia.com/#r>
    I guess)*

  *

    cover-letter: hw/arm/virt: Add multiple nested SMMUs (Nicolin ->
    Shameer)

  *

    cover-letter: Add HW accelerated nesting support for arm SMMUv3
    (Nicolin)

  *

    cover-letter: Add VIOMMU infrastructure support (Nicolin)

  *

    cover-letter: intel_iommu: Enable stage-1 translation for
    passthrough device (Zhenzhong)

  *

    cover-letter: intel_iommu: Enable stage-1 translation for emulated
    device (Zhenzhong)

The last one is covered by *[PATCH v5 00/20] intel_iommu: Enable stage-1
translation for emulated device
<https://lore.kernel.org/all/20241111083457.2090664-1-zhenzhong.duan@intel.com/#r>
*

*I see there is a reference to *"Enable stage-1 translation for
passthrough device" series but has it been posted for review? Adding
Zhenzhong in copy.

**

*Are there any posts upstream for the rest, besides Shameer's respin?
*

*
>
> I expect the IOMMU_HWPT_ALLOC (backend APIs) will go with Intel's
> series once their current "emulated devices" one gets merged. And
> I think I can prepare IOMMU_VIOMMU_ALLOC patches for backend APIs
> aligning with HWPT's.
Can you point us to the actual series including this IOMMU_HWPT_ALLOC
support? This would clarify which part you are going to work on next.

>
> That being said, one thing I am not sure is how we should bridge
> between these backend APIs and a virtual IOMMUs (vSMMU/intel). I
> think it'd be better for you and Red Hat to provide some insight,
> if calling the backend APIs directly from a viommu module isn't a
> preferable way.
can you clarify what you call backend API in that context?
>
> We also need your comments on vSMMU module patches that are still
> roughly a draft requiring a rework at some small details I think.
> So, if your (and Don's) bandwidth allows, perhaps you could take
> over the vSMMU patches? Otherwise, we can also share the task for
> reworking.
So we have started the multi smmu instantiation review and provided
feedbacks.
Which part can we work on then?

Thanks

Eric
>
> Thanks!
> Nicolin
>


