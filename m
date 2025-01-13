Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394BBE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXI5b-00059S-WB; Mon, 13 Jan 2025 05:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXI5Z-00058t-9F
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 05:54:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXI5X-0006kP-Fx
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 05:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736765668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9HQOfMOM95s+EYJU8hmkRhPiA1PBXDgzbMrXSQJD8gI=;
 b=LIt5VkaRS4Bhji3HJNr414NLizBbi+Z91JMM4wsvCSwxtAI2eEOzGC+vfL7PNWmaWuy1JX
 sLOADvAetS+ydR5XXl/0OoJfQfKdE9CN6HOWpByyVzr0Sa0nDBL9nLmGRVY1tI2SFt8Jzr
 sc5R9rwf337VG+LDbiTsu9NJlsftUu4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-SUWjHim3MOuj1CsxhvJMJA-1; Mon, 13 Jan 2025 05:54:26 -0500
X-MC-Unique: SUWjHim3MOuj1CsxhvJMJA-1
X-Mimecast-MFC-AGG-ID: SUWjHim3MOuj1CsxhvJMJA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so23154695e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 02:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736765665; x=1737370465;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9HQOfMOM95s+EYJU8hmkRhPiA1PBXDgzbMrXSQJD8gI=;
 b=dNhpLaX+GbGZS4qBMiszNUgPJbbLM3ysiZHtLe7VZHaK+EtNckM4n0JhHnahei0Emd
 y+G8XZO+tyOsY1nvULMEmcXxoqc0PFWIGAVpPOk6KJ4G05bwE5sU6laKaNjOUvOVoM48
 9BpyN3vbBXz4j23EuxLJlJcY4QoR+d29JqbSSd7cZd6hP8b/rxikAcc/4FfBfMf9t2Vb
 a+XjApsTh4RRvQni6BtZfmnv5i6sW/eCogK+GwGjrhgmF7jfvVdyfkq+yDR59ylnCb2y
 R0+cTmta1Dh3lWHnchdGkb341Js5LbCUXgNDeaKxeoBzz3XMox62pV+AkZPoyrzSTIvd
 r+9A==
X-Gm-Message-State: AOJu0YxD8qEr8fqOipwJOLDrsH04EudoBIDpS7XUJJ7aHbH5GJ/73MiR
 iibwEM+8dRmuMHgIqtTj80n+MM6qY4lgS+MJcivcsVy0BZqwymI6rUH+2F1qieCHw3WmlVDzigB
 xl0RhNbeT36CZshZfqeRwC/AWTrxAd7XFI3cjb0OPGcPVnPBccQue
X-Gm-Gg: ASbGncuHwmrh0IO6m8ztazjLJ71FnQLTjPMgoh9VsPuJM1kqgyqhYgLL7TGz70ENFIo
 1R682JxY1Fsy8oUeYm7Ip6tlHQrRUPVyiJvRqWyMAyNhEhzK7Q5j+lMpe1c/mR3uxryhcgcBuyX
 1JPUVh48L+EL1HrVgnwRmoAqEQpVOIP7R7H+zsel47wk5ATnTWYx2HRWW3nJTrnHQxwsegjh2MX
 iJSbGGdOwFUg9UFv5aQeyC2p7vxe7hmMJ7GYG1j4B9TJs31MPXBNYhHD4a6uvZdnTCNWpFo+PmS
 RCASF6vEmWopVYQ=
X-Received: by 2002:a05:600c:3584:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-436e26f47efmr114821975e9.23.1736765665683; 
 Mon, 13 Jan 2025 02:54:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyL+SmsZ0teQQ4tuEt73eTUidVAJRv36R6SY49pOR4C8+5lo76tUXh61eXsqtBs68kHDjhqw==
X-Received: by 2002:a05:600c:3584:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-436e26f47efmr114821745e9.23.1736765665332; 
 Mon, 13 Jan 2025 02:54:25 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fb99sm141190115e9.3.2025.01.13.02.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 02:54:24 -0800 (PST)
Message-ID: <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
Date: Mon, 13 Jan 2025 11:54:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
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

On 08.01.25 11:56, Chenyi Qiang wrote:
> 
> 
> On 1/8/2025 12:48 PM, Alexey Kardashevskiy wrote:
>> On 13/12/24 18:08, Chenyi Qiang wrote:
>>> As the commit 852f0048f3 ("RAMBlock: make guest_memfd require
>>> uncoordinated discard") highlighted, some subsystems like VFIO might
>>> disable ram block discard. However, guest_memfd relies on the discard
>>> operation to perform page conversion between private and shared memory.
>>> This can lead to stale IOMMU mapping issue when assigning a hardware
>>> device to a confidential VM via shared memory (unprotected memory
>>> pages). Blocking shared page discard can solve this problem, but it
>>> could cause guests to consume twice the memory with VFIO, which is not
>>> acceptable in some cases. An alternative solution is to convey other
>>> systems like VFIO to refresh its outdated IOMMU mappings.
>>>
>>> RamDiscardManager is an existing concept (used by virtio-mem) to adjust
>>> VFIO mappings in relation to VM page assignment. Effectively page
>>> conversion is similar to hot-removing a page in one mode and adding it
>>> back in the other, so the similar work that needs to happen in response
>>> to virtio-mem changes needs to happen for page conversion events.
>>> Introduce the RamDiscardManager to guest_memfd to achieve it.
>>>
>>> However, guest_memfd is not an object so it cannot directly implement
>>> the RamDiscardManager interface.
>>>
>>> One solution is to implement the interface in HostMemoryBackend. Any
>>
>> This sounds about right.
>>
>>> guest_memfd-backed host memory backend can register itself in the target
>>> MemoryRegion. However, this solution doesn't cover the scenario where a
>>> guest_memfd MemoryRegion doesn't belong to the HostMemoryBackend, e.g.
>>> the virtual BIOS MemoryRegion.
>>
>> What is this virtual BIOS MemoryRegion exactly? What does it look like
>> in "info mtree -f"? Do we really want this memory to be DMAable?
> 
> virtual BIOS shows in a separate region:
> 
>   Root memory region: system
>    0000000000000000-000000007fffffff (prio 0, ram): pc.ram KVM
>    ...
>    00000000ffc00000-00000000ffffffff (prio 0, ram): pc.bios KVM
>    0000000100000000-000000017fffffff (prio 0, ram): pc.ram
> @0000000080000000 KVM
> 
> We also consider to implement the interface in HostMemoryBackend, but
> maybe implement with guest_memfd region is more general. We don't know
> if any DMAable memory would belong to HostMemoryBackend although at
> present it is.
> 
> If it is more appropriate to implement it with HostMemoryBackend, I can
> change to this way.

Not sure that's the right place. Isn't it the (cc) machine that controls 
the state?

It's not really the memory backend, that's just the memory provider.

-- 
Cheers,

David / dhildenb


