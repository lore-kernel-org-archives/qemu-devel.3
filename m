Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DDDC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ79h-0007gg-0L; Wed, 31 Jul 2024 07:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sZ79b-0007eU-T7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sZ79Z-0004cd-PK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722423955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C1dgIfrxTHcoygnjZ8tW0sN/9U9IrukaY4P8Tmposwc=;
 b=cPpp4VdbitIDgwEcH8AlvAP45am5EBtJs17jkn3QmCYC0UGhdsKLFD2JyGJZQRwhLC56en
 IFWmGiXt3LINl583t3ZLZd2w/tZ4k9/f4tJGU5vlCFfa2rzEBB1OgEHv3HbsTx1ktZyk+j
 3FvYe5agiGlHziXLaGutyevdkodNZ9I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-3jhoojdmOVGAclVMmTTULw-1; Wed, 31 Jul 2024 07:05:53 -0400
X-MC-Unique: 3jhoojdmOVGAclVMmTTULw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3686d709f6dso3026493f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722423952; x=1723028752;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C1dgIfrxTHcoygnjZ8tW0sN/9U9IrukaY4P8Tmposwc=;
 b=o84zrCGZcw+4G+0CNQNBBXv5MtEz7MTKHvzc9VKiMVHp7GrskbjdCr16igYiGuGg53
 HCrpLtSCNKr+gw4ntiN1RJvHlAAP7mXTda0JOpQCSLPFjvgtPPdxpgSFtc3v4iTsQ3ev
 M9A90bk6yxuABDnPPQU5MPGN0XLoLj9v5vQsek2tnTqqZyEakpo4QBBBBAxRRn08JWlO
 5t/ex6d9H6LWEzGpRc5noc8+PggLT35i20sys6AP038yoXBfD+lIE9O5U3CD3dIoLMz7
 ZVv1uP5ozO0gzO1zGvbvoL7GOTFGRdJyIeJgrFHi7wDUiMW2HfSAd++3UfeUsxillIRz
 PKAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUURjp9lu4+GHuctxjcMtykp5n8uDwdRc47XhP8v6i3BZ1nD70V4Pu8Ql4zpsQG1THb3GjKWKSrr17WXhgwpfzJK+x8QII=
X-Gm-Message-State: AOJu0YxUL5ZarivrGN/zUeNCI+GXqrZaxmvd9Bm0ouu5KaY6WJUyhnB+
 dfuU/2HVjiAo+HW3hakyesK7WIBzVEDV4E5Xd8okX2cPAuZB7Gq+uLdpCzocrAc99B7n5r7SoH8
 3C6/yczjAQw0dovnzw5m66E6Q1XRfrIJiJzUWhY2Di7Gj971F/5KU
X-Received: by 2002:adf:e64f:0:b0:368:6f64:3072 with SMTP id
 ffacd0b85a97d-36b5cee46b7mr9407374f8f.7.1722423952326; 
 Wed, 31 Jul 2024 04:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSUCOdkVJc0wbLcGmfjIq3JfIabhqwCZ1PrjP4T+bwuWDsO0/Yp/EEfrQ67qQRV57ei1eihw==
X-Received: by 2002:adf:e64f:0:b0:368:6f64:3072 with SMTP id
 ffacd0b85a97d-36b5cee46b7mr9407352f8f.7.1722423951724; 
 Wed, 31 Jul 2024 04:05:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:5f00:9b61:28a2:eea1:fa49?
 (p200300cbc70b5f009b6128a2eea1fa49.dip0.t-ipconnect.de.
 [2003:cb:c70b:5f00:9b61:28a2:eea1:fa49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d9b30sm16823751f8f.40.2024.07.31.04.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 04:05:51 -0700 (PDT)
Message-ID: <272e3dbf-ed4a-43f5-8b5f-56bf6d74930c@redhat.com>
Date: Wed, 31 Jul 2024 13:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Enable shared device assignment
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Wang, Wei W" <wei.w.wang@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
 <ace9bb98-1415-460f-b8f5-e50607fbce20@redhat.com>
 <BN9PR11MB527635939C0A2A0763E326A58CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c9556944-16e4-4eb0-b9cd-56426099f813@redhat.com>
 <Zqnj7PZKX6Rzh/yl@yilunxu-OptiPlex-7050>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zqnj7PZKX6Rzh/yl@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 31.07.24 09:12, Xu Yilun wrote:
> On Fri, Jul 26, 2024 at 09:08:51AM +0200, David Hildenbrand wrote:
>> On 26.07.24 07:02, Tian, Kevin wrote:
>>>> From: David Hildenbrand <david@redhat.com>
>>>> Sent: Thursday, July 25, 2024 10:04 PM
>>>>
>>>>> Open
>>>>> ====
>>>>> Implementing a RamDiscardManager to notify VFIO of page conversions
>>>>> causes changes in semantics: private memory is treated as discarded (or
>>>>> hot-removed) memory. This isn't aligned with the expectation of current
>>>>> RamDiscardManager users (e.g. VFIO or live migration) who really
>>>>> expect that discarded memory is hot-removed and thus can be skipped
>>>> when
>>>>> the users are processing guest memory. Treating private memory as
>>>>> discarded won't work in future if VFIO or live migration needs to handle
>>>>> private memory. e.g. VFIO may need to map private memory to support
>>>>> Trusted IO and live migration for confidential VMs need to migrate
>>>>> private memory.
>>>>
>>>> "VFIO may need to map private memory to support Trusted IO"
>>>>
>>>> I've been told that the way we handle shared memory won't be the way
>>>> this is going to work with guest_memfd. KVM will coordinate directly
>>>> with VFIO or $whatever and update the IOMMU tables itself right in the
>>>> kernel; the pages are pinned/owned by guest_memfd, so that will just
>>>> work. So I don't consider that currently a concern. guest_memfd private
>>>> memory is not mapped into user page tables and as it currently seems it
>>>> never will be.
>>>
>>> Or could extend MAP_DMA to accept guest_memfd+offset in place of
> 
> With TIO, I can imagine several buffer sharing requirements: KVM maps VFIO
> owned private MMIO, IOMMU maps gmem owned private memory, IOMMU maps VFIO
> owned private MMIO. These buffers cannot be found by user page table
> anymore. I'm wondering it would be messy to have specific PFN finding
> methods for each FD type. Is it possible we have a unified way for
> buffer sharing and PFN finding, is dma-buf a candidate?

No expert on that, so I'm afraid I can't help.

> 
>>> 'vaddr' and have VFIO/IOMMUFD call guest_memfd helpers to retrieve
>>> the pinned pfn.
>>
>> In theory yes, and I've been thinking of the same for a while. Until people
>> told me that it is unlikely that it will work that way in the future.
> 
> Could you help specify why it won't work? As Kevin mentioned below, SEV-TIO
> may still allow userspace to manage the IOMMU mapping for private. I'm
> not sure how they map private memory for IOMMU without touching gmemfd.

I raised that question in [1]:

"How would the device be able to grab/access "private memory", if not 
via the user page tables?"

Jason summarized it as "The approaches I'm aware of require the secure 
world to own the IOMMU and generate the IOMMU page tables. So we will 
not use a GUP approach with VFIO today as the kernel will not have any 
reason to generate a page table in the first place. Instead we will say 
"this PCI device translates through the secure world" and walk away."

I think for some cVM approaches it really cannot work without letting 
KVM/secure world handle the IOMMU (e.g., sharing of page tables between 
IOMMU and KVM).

For your use case it *might* work, but I am wondering if this is how it 
should be done, and if there are better alternatives.


[1] https://lkml.org/lkml/2024/6/20/920

-- 
Cheers,

David / dhildenb


