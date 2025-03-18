Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B1BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuePD-0007OL-G7; Tue, 18 Mar 2025 17:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tueOs-0007KV-3p
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tueOp-0005yK-9z
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742332977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIHMvr7swYGcIj3kvWaTE+mkZ1Ye9htvacqmYNN0ZWY=;
 b=QbFnkr0DN1baBees6G+kVILCISAuvCpK2CJ1lsAWIAqJYsItW/hq5xvGn1s41FY5nq4PfY
 7ocdmexXNl4OORHaOJmtu9UO3zEwpa/U43WW3nbJk5nPNI0tTPmDQi8WXNUWA84n0LROd6
 RO1GDgvaA4Rz9bhVz3cuID0SHPMcBcE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-80jPpHT0OlK8ofWPtZaSeQ-1; Tue, 18 Mar 2025 17:22:55 -0400
X-MC-Unique: 80jPpHT0OlK8ofWPtZaSeQ-1
X-Mimecast-MFC-AGG-ID: 80jPpHT0OlK8ofWPtZaSeQ_1742332974
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3d2b3a2f2d4so104592175ab.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742332974; x=1742937774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aIHMvr7swYGcIj3kvWaTE+mkZ1Ye9htvacqmYNN0ZWY=;
 b=Py28GVYjo0+qdYKN6xD1vTq4ZuYKCt20FH95KhBiTIxG5NB3cc0GDpk9h7qAwRRf/X
 5PY2wOIjEBz6SwzoipDccHW5RjgP60vhHUzl2PeYt39YPoPgQDkKv2c6pvAbt5bYT/VZ
 KlRiGsUANPSVc7xtm6bsgJMCEav3Ey6JFzk+P5ELnPh/PKcBC7UHiw0iRV/iFaVAZNDZ
 kLV6eDzIFKHlXR/ufI2dniGy02oKP+amz4+dyJItd9OgP7xdG1LKMAOHAKeblN8/2kCM
 dDr/XBldkimZO2ObijBRgIyamrQDX9yNcVWfUbkk9AeORQkvzpp0OklALPe3Ubb/Xwze
 olAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcg3VNd861Gd+fcZPypCCiUFEzCYSz/Gnxc0N5gz10btj0KYg/Ocqju7rMJvn32VRvzbo8kO5noTDO@nongnu.org
X-Gm-Message-State: AOJu0YzAYgYGZLZhu48T67xbIsaKbN5K3yHDhTrxX13dzAlEGEucmdco
 5obchHAn3cX4pGXC+5drDKJUawJa8KfPRbEYjpDv7cJFmqe5FYj7G3TTX1tQRPgCytRd8TZECJv
 SgnaIiQcXlzfU6foZVqg7fQeza7iohT8JoUt7kPLoyt3OzLqyW7KG
X-Gm-Gg: ASbGncuS1eVKCuhbI1veprew/rpDZjYtQuMHKRvcqO3tgBwAZGugrSDBZ/X7nNbBnVz
 UxgQPaPNeh757/lQdm6katXrZOlIjeF7yJ5jnpcI25ZbmykCxAyarI1vK89HrlvbXM8Z0wZHX8e
 A8oTPXJoOfebv5W0Mk6Ur7wt+ynZcPtNfNfo9tCVlzltM+h3TArcaqlEp8rc4Vtl+uPKkq3d96g
 PgbRrh8Tcnau3XyLFBshc7IeheBhJ5mGLqEJe4ZBSdNz8jQhERH2sqVrbQSfrC0KkfdKQB+a4aP
 +WDtRdRki0dztwIB
X-Received: by 2002:a05:6e02:1b0c:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d586b5a5e6mr3869095ab.13.1742332974256; 
 Tue, 18 Mar 2025 14:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhjXP0z19T8hMcFvpIb7DlNVgsEOgMBggnvLCcwV/VX2gMqTIx3JMSV7HTJKcGArgVGHDbxg==
X-Received: by 2002:a05:6e02:1b0c:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d586b5a5e6mr3868765ab.13.1742332973911; 
 Tue, 18 Mar 2025 14:22:53 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f26372760asm2891455173.67.2025.03.18.14.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 14:22:53 -0700 (PDT)
Message-ID: <3716d39d-3f88-4914-a9d6-440d379db3d7@redhat.com>
Date: Tue, 18 Mar 2025 17:22:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 3/18/25 3:13 PM, Nicolin Chen wrote:
> On Tue, Mar 18, 2025 at 07:31:36PM +0100, Eric Auger wrote:
>> On 3/17/25 9:19 PM, Nicolin Chen wrote:
>>> On Mon, Mar 17, 2025 at 04:24:53PM -0300, Jason Gunthorpe wrote:
>>>> On Mon, Mar 17, 2025 at 12:10:19PM -0700, Nicolin Chen wrote:
>>>>> Another question: how does an emulated device work with a vSMMUv3?
>>>>> I could imagine that all the accel steps would be bypassed since
>>>>> !sdev->idev. Yet, the emulated iotlb should cache its translation
>>>>> so we will need to flush the iotlb, which will increase complexity
>>>>> as the TLBI command dispatching function will need to be aware what
>>>>> ASID is for emulated device and what is for vfio device..
>>>> I think you should block it. We already expect different vSMMU's
>>>> depending on the physical SMMU under the PCI device, it makes sense
>>>> that a SW VFIO device would have it's own, non-accelerated, vSMMU
>>>> model in the guest.
>>> Yea, I agree and it'd be cleaner for an implementation separating
>>> them.
>>>
>>> In my mind, the general idea of "accel=on" is also to keep things
>>> in a more efficient way: passthrough devices go to HW-accelerated
>>> vSMMUs (separated PCIE buses), while emulated ones go to a vSMMU-
>>> bypassed (PCIE0).
> 
>> Originally a specific SMMU device was needed to opt in for MSI reserved
>> region ACPI IORT description which are not needed if you don't rely on
>> S1+S2. However if we don't rely on this trick this was not even needed
>> with legacy integration
>> (https://patchwork.kernel.org/project/qemu-devel/cover/20180921081819.9203-1-eric.auger@redhat.com/).
>>
>> Nevertheless I don't think anything prevents the acceleration granted
>> device from also working with virtio/vhost devices for instance unless
>> you unplug the existing infra. The translation and invalidation just
>> should use different control paths (explicit translation requests,
>> invalidation notifications towards vhost, ...).
> 
> smmuv3_translate() is per sdev, so it's easy.
> 
> Invalidation is done via commands, which could be tricky:
> a) Broadcast command
> b) ASID validation -- we'll need to keep track of a list of ASIDs
>     for vfio device to compare the ASID in each per-ASID command,
>     potentially by trapping all CFGI_CD(_ALL) commands? Note that
>     each vfio device may have multiple ASIDs (for multiple CDs).
> Either a or b above will have some validation efficiency impact.
> 
>> Again, what does legitimate to have different qemu devices for the same
>> IP? I understand that it simplifies the implementation but I am not sure
>> this is a good reason. Nevertheless it worth challenging. What is the
>> plan for intel iommu? Will we have 2 devices, the legacy device and one
>> for nested?
> 
> Hmm, it seems that there are two different topics:
> 1. Use one SMMU device model (source code file; "iommu=" string)
>     for both an emulated vSMMU and an HW-accelerated vSMMU.
> 2. Allow one vSMMU instance to work with both an emulated device
>     and a passthrough device.
> And I get that you want both 1 and 2.
> 
> I'm totally okay with 1, yet see no compelling benefit from 2 for
> the increased complexity in the invalidation routine.
> 
> And another question about the mixed device attachment. Let's say
> we have in the host:
>    VFIO passthrough dev0 -> pSMMU0
>    VFIO passthrough dev1 -> pSMMU1
> Should we allow emulated devices to be flexibly plugged?
>    dev0 -> vSMMU0 /* Hard requirement */
>    dev1 -> vSMMU1 /* Hard requirement */
>    emu0 -> vSMMU0 /* Soft requirement; can be vSMMU1 also */
>    emu1 -> vSMMU1 /* Soft requirement; can be vSMMU0 also */
> 
> Thanks
> Nicolin
> 
I agree w/Jason & Nicolin: different vSMMUs for pass-through devices than emulated, & vice-versa.
Not mixing... because... of the next agreement:

I agree with Eric that 'accel' isn't needed -- this should be ascertained from the pSMMU that a physical device is attached to.
Now... how does vfio(?; why not qemu?) layer determine that? -- where are SMMUv3 'accel' features exposed either: a) in the device struct (for the smmuv3) or (b) somewhere under sysfs? ... I couldn't find anything under either on my g-h system, but would appreciate a ptr if there is.
and like Eric, although 'accel' is better than the original 'nested', it's non-obvious what accel feature(s) are being turned on, or not.
In fact, if broken accel hw occurs ('if' -> 'when'), how should it be turned off? ... if info in the kernel, a kernel boot-param will be needed;
if in sysfs, a write to 0 an enable(disable) it maybe an alternative as well.
Bottom line: we need a way to (a) ascertain the accel feature (b) a way to disable it when it is broken,
so qemu's smmuv3 spec will 'just work'.
[This may also help when migrating from a machine that has accel working to one that does not.[

... and when an emulated device is assigned a vSMMU, there are no accel features ... unless we have tunables like batch iotlb invalidation for perf reasons, which can be viewed as an 'accel' option.


