Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50600D6ACC3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGzo-0005Ei-0s; Wed, 27 Nov 2024 07:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tGGzf-000569-NN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:18:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tGGzd-0000Hg-JE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732709882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M9mzA8P4z44It+NfVfL4iSSjjQ3sYQYIK8zhXdpjXrQ=;
 b=e0UW/N1qJLaXYrMKfR2c+0bNfCDjlCTn0WKBFzhri6+ZDQn9rbCZAvUw7xNT6HUBLelkv5
 wGCV79OkHnxl2ahFhpZEum8BfY9dQ62Pkk/aHc8RB6Kf6I0P66zAhQwnhG6Gjl4dz6+0nX
 c/NNXfI9oy2LXkPR3Vms648DhLmB5kU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-TNPpEo2oOFyX-fMZQXm3-g-1; Wed, 27 Nov 2024 07:18:01 -0500
X-MC-Unique: TNPpEo2oOFyX-fMZQXm3-g-1
X-Mimecast-MFC-AGG-ID: TNPpEo2oOFyX-fMZQXm3-g
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-382412f3e62so3487542f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709880; x=1733314680;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M9mzA8P4z44It+NfVfL4iSSjjQ3sYQYIK8zhXdpjXrQ=;
 b=QS0AeSqlI5DfB4ZE/zbXjzii0cfWXlJ04fAmBjOfhkXVgpWvmclKA3TW+ElGvELQTe
 UJy9As7TKiqqNuBZPpgBND90Jkrf4ePtq9w9CCpBUSfFY7FJL+Uyo3CothjfV8ruixYO
 m8dGwxRZ26NlncQ8FSnUvFiOufiAkdHdfCkkZ9eYMWQSvjghNApyVpaukrs7bVLp5/jI
 aoPfkRR78QjIJA3TOoLOiqqjxMY6gsHvSn6rD9az8SWKEb4YDOzMaOhXBEPohAlNsVWv
 lcMg2UeONimSAhrwoN4S/ujpDWyV+cFtcJ3AQjKbfdEylJ44u7msFes0NG7n+ypcFUYg
 ///w==
X-Gm-Message-State: AOJu0YwkabQBaPKzH/dfYBjQNQxkaUP170I0iF7W/U5O0BLuLXPkglA0
 hmUHNiVIQ2ZNF5qE9l/bxx/jwusQIpmELalWYJPBTd67y6SOBBygsbw4K2rF2btF/A8h11BS3HX
 w3oanynYEjXPtR8HS1mVw6GVCXYE9VmCULoIcIc9+VL63ZULomXnL
X-Gm-Gg: ASbGnctmWk2kzFUD/bizwAVW0vwgBWnShd8tdif9iRLE0YeABzXkpRXKpT+Jk+iQE8B
 ypvLgekymWjGDLo7taJsdcS5QkXZZ5OJBj1giWcHkxFOmygX5csbsAistcnpls6Wa3UAGF214s3
 fRbXZ5khBZpHMGkPUjiK62WbP33Gt/U5Ny0QMoDKB3lQ2Qq5XuCajCP4udv+YRppJ+d7NK4UpnY
 gHrcDmtjRxS6fF7zV2ft3GIT4ReXif0wZbbPbRPAODPDLtWTN0aHy1YSfF5qVyjRs+gpIaV6Oc2
 y8oXULyebQniBJy2My4+0hXv86rHlnImPzW4AoMMg2pykqjBhNEWuM64ELyVbCt9Zg9iX0m7zY4
 Nrg==
X-Received: by 2002:a5d:5f50:0:b0:382:542d:39ac with SMTP id
 ffacd0b85a97d-385c6ebb9admr1878217f8f.19.1732709880127; 
 Wed, 27 Nov 2024 04:18:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGymb6ChZB/jAt4wIwa8vKGzxFk/8FgsBBZlZ+uC7IoGauMZxUmttwjvU4K0sAZiyVW6MXoqQ==
X-Received: by 2002:a5d:5f50:0:b0:382:542d:39ac with SMTP id
 ffacd0b85a97d-385c6ebb9admr1878196f8f.19.1732709879692; 
 Wed, 27 Nov 2024 04:17:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:be00:66fa:83a6:8803:977e?
 (p200300cbc70dbe0066fa83a68803977e.dip0.t-ipconnect.de.
 [2003:cb:c70d:be00:66fa:83a6:8803:977e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fcff017sm16171141f8f.108.2024.11.27.04.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 04:17:58 -0800 (PST)
Message-ID: <6714e754-8d2d-4751-8b3b-dd7ce469a469@redhat.com>
Date: Wed, 27 Nov 2024 13:17:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] vhost-user: Add VIRTIO Shared Memory map request
From: David Hildenbrand <david@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, slp@redhat.com, hi@alyssa.is, mst@redhat.com,
 jasowang@redhat.com, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, stevensd@chromium.org
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-2-aesteve@redhat.com>
 <abfd06b7-ad85-454b-a973-6c939c4588e3@redhat.com>
 <CADSE00+Yg+ufOT1NQ+8H7DSaE0zCFrWbn-yTajx72G0BZdUw9g@mail.gmail.com>
 <c998c231-5034-4a7e-bf97-1470959c052d@redhat.com>
 <44de54b5-8336-4d84-96f0-36f809f48eff@redhat.com>
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
In-Reply-To: <44de54b5-8336-4d84-96f0-36f809f48eff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 27.11.24 13:10, David Hildenbrand wrote:
> On 27.11.24 11:50, David Hildenbrand wrote:
>>
>>>> RAM memory region/ RAMBlock that has properly set flags/fd/whatssoever
>>>> and map whatever you want in there.
>>>>
>>>> Likely you would need a distinct RAMBlock/RAM memory region per mmap(),
>>>> and would end up mmaping implicitly via qemu_ram_mmap().
>>>>
>>>> Then, your shared region would simply be an empty container into which
>>>> you map these RAM memory regions.
>>>
>>
>> Hi,
>>
>>> Hi, sorry it took me so long to get back to this. Lately I have been
>>> testing the patch and fixing bugs, and I am was going to add some
>>> tests to be able to verify the patch without having to use a backend
>>> (which is what I am doing right now).
>>>
>>> But I wanted to address/discuss this comment. I am not sure of the
>>> actual problem with the current approach (I am not completely aware of
>>> the concern in your first paragraph), but I see other instances where
>>> qemu mmaps stuff into a MemoryRegion.
>>
>> I suggest you take a look at the three relevant MAP_FIXED users outside
>> of user emulation code.
>>
>> (1) hw/vfio/helpers.c: We create a custom memory region + RAMBlock with
>>        memory_region_init_ram_device_ptr(). This doesn't mmap(MAP_FIXED)
>>        into any existing RAMBlock.
>>
>> (2) system/physmem.c: I suggest you take a close look at
>>        qemu_ram_remap() and how it is one example of how RAMBlock
>>        properties describe exactly what is mmaped.
>>
>> (3) util/mmap-alloc.c: Well, this is the code that performs the mmap(),
>>        to bring a RAMBlock to life. See qemu_ram_mmap().
>>
>> There is some oddity hw/xen/xen-mapcache.c; XEN mapcache seems to manage
>> guest RAM without RAMBlocks.
>>
>>> Take into account that the
>>> implementation follows the definition of shared memory region here:
>>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-10200010
>>> Which hints to a memory region per ID, not one per required map. So
>>> the current strategy seems to fit it better.
>>
>> I'm confused, we are talking about an implementation detail here? How is
>> that related to the spec?
>>
>>>
>>> Also, I was aware that I was not the first one attempting this, so I
>>> based this code in previous attempts (maybe I should give credit in
>>> the commit now that I think of):
>>> https://gitlab.com/virtio-fs/qemu/-/blob/qemu5.0-virtiofs-dax/hw/virtio/vhost-user-fs.c?ref_type=heads#L75
>>> As you can see, it pretty much follows the same strategy.
>>
>> So, people did some hacky things in a QEMU fork 6 years ago ... :) That
>> cannot possibly be a good argument why we should have it like that in QEMU.
>>
>>> And in my
>>> examples I have been able to use this to video stream with multiple
>>> queues mapped into the shared memory (used to capture video frames),
>>> using the backend I mentioned above for testing. So the concept works.
>>> I may be wrong with this, but for what I understood looking at the
>>> code, crosvm uses a similar strategy. Reserve a memory block and use
>>> for all your mappings, and use an allocator to find a free slot.
>>>
>>
>> Again, I suggest you take a look at what a RAMBlock is, and how it's
>> properties describe the containing mmap().
>>
>>> And if I were to do what you say, those distinct RAMBlocks should be
>>> created when the device starts? What would be their size? Should I
>>> create them when qemu receives a request to mmap? How would the driver
>>> find the RAMBlock?
>>
>> You'd have an empty memory region container into which you will map
>> memory regions that describe the memory you want to share.
>>
>> mr = g_new0(MemoryRegion, 1);
>> memory_region_init(mr, OBJECT(TODO), "vhost-user-shm", region_size);
>>
>>
>> Assuming you are requested to mmap an fd, you'd create a new
>> MemoryRegion+RAMBlock that describes the memory and performs the mmap()
>> for you:
>>
>> map_mr = g_new0(MemoryRegion, 1);
>> memory_region_init_ram_from_fd(map_mr, OBJECT(TODO), "TODO", map_size,
>> 			       RAM_SHARED, map_fd, map_offs, errp);
>>
>> To then map it into your container:
>>
>> memory_region_add_subregion(mr, offset_within_container, map_mr);
>>
>>
>> To unmap, you'd first remove the subregion, to then unref the map_mr.
>>
>>
>>
>> The only alternative would be to do it like (1) above: you perform all
>> of the mmap() yourself, and create it using
>> memory_region_init_ram_device_ptr(). This will set RAM_PREALLOC on the
>> RAMBlock and tell QEMU "this is special, just disregard it". The bad
>> thing about RAM_PREALLOC will be that it will not be compatible with
>> vfio, not communicated to other vhost-user devices etc ... whereby what
>> I describe above would just work with them.
>>
> 
> FWIW, I took another look at this patch and I cannot really make sense
> of what you are doing.
> 
> In virtio_new_shmem_region(), you allocate a region, but I don't see how
> it would ever get initialized?
> 
> In vhost_user_backend_handle_shmem_map(), you then assume that it is
> suddenly a RAM memory region? For example, that
> memory_region_get_ram_ptr() returns something reasonable.
> 
> Likely, you really just want to initialize that MR using
> memory_region_init_ram_from_fd(), and have that just perform the proper
> mmap() for you and setup the RAMBlock?

In patch #4 I find: memory_region_init_ram_ptr(vdev->shmem_list[i].mr ...

Which does what I describe as the alternative. That makes it clearer 
that you are not operating on arbitrary RAMBlocks. So that should indeed 
work.

The way you structured these patches really is suboptimal for review.

-- 
Cheers,

David / dhildenb


