Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C6AE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKw4s-0006q7-Ls; Tue, 10 Dec 2024 03:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKw4q-0006pg-P3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKw4p-0004gZ-2B
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733821121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t4BJRdwNQurxqauxwNSgswBL0p/1TnsgHbQY6bucoII=;
 b=YD9pJ/cw71Xvv9z+y050uyhtREgsWEoXPqe0j0mzucJ7lWejVwm3rv8Yspw0E6L6A1gVCC
 kG3VAbnltBI9olhCUC3Qh3d1qPZ4T3z9BKEsuRxMmCgbYozIRo1HxI2KD6OAXgB++Ka9Vj
 AI+v82BBu0Uri5VTk5pgO3jKiAq/XHU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-lgHOLVSfNeeYp5FUeM4SFw-1; Tue, 10 Dec 2024 03:58:40 -0500
X-MC-Unique: lgHOLVSfNeeYp5FUeM4SFw-1
X-Mimecast-MFC-AGG-ID: lgHOLVSfNeeYp5FUeM4SFw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so2193332f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 00:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733821119; x=1734425919;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t4BJRdwNQurxqauxwNSgswBL0p/1TnsgHbQY6bucoII=;
 b=EXM9G0ympUaDLG7i094QEOOmESNV4sQ/HdC8MMHM6f8mSrZV5qbuDZ62/5Mnmm2Ogq
 Zjz5+cehO0aUM6qWqvmoiPEe4TyTOaL9FqBGgFdf17AJNsc9vPFnlTprPuenEWkDm2Fi
 fr82rP0IfmFGuXSWWX8bZFxmzMtSpsUqIRZt526WDF6ir8HaiYD+L+0A/tCXO7VIi43q
 DDH3nDXFIfb+sUVD9g457mdOXaX5nV75S18AMTDb9IaArwrpIINlroeC6aEQKx3c/Etq
 v2Yg/Xys9dCAU6nbk6oBM/mweNMWFNjSOt63aiCneI7BFlbH2C/1DD6bDCojxeeshWlu
 7poQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX79KSdv+C+93ib+3Ag7jYPRQHEQkP6EOzrSpPhwcBdF/JbD9ZvX4dG0XpVskm9F9tVsQE1FbXGlBaW@nongnu.org
X-Gm-Message-State: AOJu0Yx2z7hnBfD//YGNQ2AyQ5Co/gFhmPGL3wLF0N8C5+HBGRK0STAP
 sICVxNKZq8x5isRbUGBMyTKQZyQx1q6geO6w4EAYrHJsff0VwHdLR+0YGGXCHsy34HBTWoSpFPS
 dgNfZyKGcrsARvJMPiNcmydzBnOYc6kWI+Ljly0RV8tKJCe5wXnoN
X-Gm-Gg: ASbGncv9gHQ1sbUoYiWA5k4QLNlXinXLVFLmysZE8wHnO9pS4Y1rf7VJt4glzZ/gNd9
 Kqwr/rzxxO3GnjnPun8d/Zww/pCRnbePodr1M71etzX+x5SoBYoOPgr8r+AuDmjpPAuuAIbzaiP
 AkvlxlfbJnkzWAWwGCaSc0HtAhGhbatc/4BMRqkZl/r45wNBhR5h4UQ2N2H3HlS+oJDnj/3wp4T
 Kq2V/VP+6QGwNCkG8lxlkH+rntYt1WfgB7OnO9DICUAxXk8p6whwDpKRQJ7v1er8IOZLIZ7HpW3
 mAbNs+LAGO7zFm4zmZj/iwEOOrlC7/4R/FhRtfySZndDvJz28jEXXFfcU19R2KC0+nNZt1FXn1R
 RcmVnCQ==
X-Received: by 2002:a05:6000:1f85:b0:385:ec8d:8ca9 with SMTP id
 ffacd0b85a97d-3862b3d09eamr11580301f8f.42.1733821118883; 
 Tue, 10 Dec 2024 00:58:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCrJpezS0a49S5zuW7aALUB8ibcl8pd4D8Go7ovRnZASns7GDBOTxNTrG1uW1GtCEzNNVBpQ==
X-Received: by 2002:a05:6000:1f85:b0:385:ec8d:8ca9 with SMTP id
 ffacd0b85a97d-3862b3d09eamr11580277f8f.42.1733821118404; 
 Tue, 10 Dec 2024 00:58:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3?
 (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de.
 [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b14csm224634875e9.2.2024.12.10.00.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 00:58:37 -0800 (PST)
Message-ID: <f38ed904-d235-43b5-a351-ea64e54984b4@redhat.com>
Date: Tue, 10 Dec 2024 09:58:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
 <f7451934-bf20-4c50-8780-4d5ebf932096@redhat.com>
 <31b6b62b-4656-4ca0-a8ac-99fe4293de45@linux.ibm.com>
 <7bd2018a-df16-4ede-b7d7-dfdb9cbfc7c0@redhat.com>
 <a6bfbf15-cbe4-4023-9a8e-d172cf8c8128@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a6bfbf15-cbe4-4023-9a8e-d172cf8c8128@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 10.12.24 00:22, Matthew Rosato wrote:
> On 12/9/24 5:09 PM, David Hildenbrand wrote:
>> On 09.12.24 22:45, Matthew Rosato wrote:
>>> On 12/9/24 4:01 PM, David Hildenbrand wrote:
>>>> On 09.12.24 20:29, Matthew Rosato wrote:
>>>>
>>>> Hi,
>>>>
>>>> Trying to wrap my head around that ... you mention that "pin the entirety of guest memory".
>>>>
>>>> Do you mean that we will actually end up longterm pinning all guest RAM in the kernel, similar to what vfio ends up doing?
>>>
>>> Yes.  Actually, the usecase here is specifically PCI passthrough via vfio-pci on s390.  Unlike other platforms, the default s390 approach only pins on-demand and doesn't longterm pin all guest RAM, which is nice from a memory footprint perspective but pays a price via all those guest-2 RPCIT instructions.  The goal here is now provide the optional alternative to longterm pin like other platforms.
>>
>> Okay, thanks for confirming. One more question: who will trigger this longterm-pinning? Is it vfio?
>>
>> (the code flow from your code to the pinning code would be nice)
>>

Thanks for the details.

> 
> Yes, the vfio IOMMU code triggers it.  My s390_pci_setup_stage2_map added by this patch calls memory_region_notify_iommu in a loop such that we trigger iommu notifications to map iova X+pba -> GPA X for all GPA, where pba = a "base address" offset that has to be applied when mapping on s390.

Ah, now I see that you use "ms->ram_size", so indeed, this will map 
initial RAM only.

The more-future-proof approach would indeed be to register a memory 
listener on &address_space_memory, to then map/unmap whenever notified 
about map/unmap.

See "struct vfio_memory_listener" with its region_add/region_del 
callbacks that do that, and also implement the RAMDiscardManager plumbing.


And now I wonder if there would be a way to just reuse "struct 
vfio_memory_listener" here some way? Or at least reuse the map/unmap 
functions, because ...

The notifications are sent in the largest batches possible to minimize 
vfio ioctls / use the least number of vfio dma mappings.
> 
> The iommu notifications get picked up in vfio_iommu_map_notify where we will follow the container DMA path down to vfio_legacy_dma_map; then ultimately vfio is handling the pinning via the VFIO_IOMMU_MAP_DMA ioctl.

... vfio_listener_region_add() will also just call vfio_container_dma_map().

Maybe there is a reason s390x needs to handle this using 
memory_region_notify_iommu() callbacks instead of doing it similar to 
"struct vfio_memory_listener" when registered on &address_space_memory 
without a viommu.

> 
>>>
>>>>
>>>> In that case, it would be incompatible with virtio-balloon (and without modifications with upcoming virtio-mem). Is there already a mechanism in place to handle that -- a call  to ram_block_discard_disable() -- or even a way to support coordinated discarding of RAM (e.g., virtio-mem + vfio)?
>>>
>>> Good point, should be calling add ram_block_discard_disable(true) when set register + a corresponding (false) during deregister...  Will add for v2.
>>>
>>> As for supporting coordinated discard, I was hoping to subsequently look at virtio-mem for this.
>>
>> As long as discarding is blocked for now, we're good. To support it, the RAMDiscardManager would have to be wired up, similar to vfio.
>>
>> I think the current way of handling it via
>> vf
>> +    IOMMUTLBEvent event = {
>> +        .type = IOMMU_NOTIFIER_MAP,
>> +        .entry = {
>> +            .target_as = &address_space_memory,
>> +            .translated_addr = 0,
>> +            .perm = IOMMU_RW,
>> +        },
>> +    };
>>
>>
>> Is probably not ideal: it cannot cope with memory holes (which virtio-mem would create).
>>
>> Likely, you'd instead want an address space notifier, and really only map the memory region sections you get notified about.
>>
>> There, you can test for RAMDiscardManager and handle it like vfio does.
>>
> 
> I'll start looking into this; for the moment I'll plan on blocking discarding in this series with a follow-on to then enable virtio-mem, but if I get something working sooner I'll add it to this series.  Either way I'll put you on CC.

Thanks, exploring whether we can reuse the vfio bits to map/unmap might 
be very valuable and simplify things.

-- 
Cheers,

David / dhildenb


