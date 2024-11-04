Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFCFD132C5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xAM-0004Hn-VU; Mon, 04 Nov 2024 08:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t7xAH-0004F2-5E
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t7xAE-0001E3-Tm
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730727035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aGiEtRKqelpqDSUzw09EH7hKIXBP+iprJTrDTUj8CNs=;
 b=ay8YCvc9m6oAp5DIR1k9VeCgShPmgp7vr5ABRoyyXIBUmkjx3YV2aO5mbfBMM/ZmDPBEIT
 pMUAhZCpjFnoKkzrRgG5Q3j+8ydGKqfN7ucYvs2Aw4DNlWuNQAR75jYd8Q/d9waFNiK0tK
 gmnxrk1hrIcR4J4GqCipIS7SPJOW8JI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-o7kd3Cf5PNGDhU7IDQQlEA-1; Mon, 04 Nov 2024 08:30:32 -0500
X-MC-Unique: o7kd3Cf5PNGDhU7IDQQlEA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539ed93e08aso2516684e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727031; x=1731331831;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aGiEtRKqelpqDSUzw09EH7hKIXBP+iprJTrDTUj8CNs=;
 b=mlltor6Dvv5Jr0S8d9KWED8bIWT5hvaaYgoF5dqe9C/T9G/Pkskwu+zNIP+GSkK1dg
 dnE5eWP2EitGfRsx/z8FQM0yjUONveREzTiW2MTKKgq8fxIXRwDjX7fQf0FwB71cecqe
 KPmPwlF8meI+hGKkO3ldtqCumKOYjM/DYvpkH5LLlbY69QRR1emmEDCyOfeHg25pO7Zy
 Xef1HIbHHLFBlNdU3qwjtQSXtBTL0AF/2AVsPlJkYCjlUDVrh/Av5pqE3gNZUDM6GdO8
 Hz/X3Zn8Hs7Y9fTEmvDNRGM0nnCozQp4HTCidk+STmhpfDpJ5cO3DIS/+rdG6E/DGkjZ
 /lQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJVospz+r8JxAzq+LGHJZBPetW0zynGC3xzQdJPolzKCmI/yMi/RmHXL0sveXVaxFZbUlj58B2FdnT@nongnu.org
X-Gm-Message-State: AOJu0YwAjFYzSj3baKZPU82QL0J49Pmq98hrDPV2QBgsz74Ro7XHgM0+
 sLaH7x+IpHiU9uVw7l4KvOqNEP6BE6SAgdgdAmozyLh7mk2/EMztqi1VPbxXrAM8mEBle8OWukm
 z2z2cur7B/MQS06FayP/cpPZ3+jZl6HzoQJpBoRRxLzI9t9ATUMmK
X-Received: by 2002:a05:6512:1047:b0:53a:40e:d547 with SMTP id
 2adb3069b0e04-53b7ecd58damr10405414e87.5.1730727030542; 
 Mon, 04 Nov 2024 05:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEu70+9VEpBhJV/6ZV29SVUscDAC5NTYpysQnlRRUYzhBxE6sqcIKpndZ2qmPIhXBt9CPcswA==
X-Received: by 2002:a05:6512:1047:b0:53a:40e:d547 with SMTP id
 2adb3069b0e04-53b7ecd58damr10405390e87.5.1730727029838; 
 Mon, 04 Nov 2024 05:30:29 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7c9asm158736435e9.21.2024.11.04.05.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 05:30:28 -0800 (PST)
Message-ID: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
Date: Mon, 4 Nov 2024 14:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] system/physmem: Largepage punch hole before reset
 of memory pages
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 joao.m.martins@oracle.com
References: <ZwalK7Dq_cf-EA_0@x1n>
 <20241022213503.1189954-1-william.roche@oracle.com>
 <20241022213503.1189954-4-william.roche@oracle.com>
 <0cda6b34-d62c-49c7-b30c-33f171985817@redhat.com>
 <e9f8e404-50db-4e0f-a5e1-749acad49325@oracle.com>
 <6cc00e04-6e38-4970-9d6b-52b56ee20a64@redhat.com>
 <416a47ff-3324-444b-a2e2-9ea775e61244@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <416a47ff-3324-444b-a2e2-9ea775e61244@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

>>>
>>> Remapping the page is needed to get rid of the poison. So if we want to
>>> avoid the mmap(), we have to shrink the memory address space -- which
>>> can be a real problem if we imagine a VM with 1G large pages for
>>> example. qemu_ram_remap() is used to regenerate the lost memory and the
>>> mmap() call looks mandatory on the reset phase.
>>
>> Why can't we use ram_block_discard_range() to zap the poisoned page
>> (unmap from page tables + conditionally drop from the page cache)? Is
>> there anything important I am missing?
> 
> Or maybe _I'm_ missing something important, but what I understand is that:
>      need_madvise = (rb->page_size == qemu_real_host_page_size());
> 
> ensures that the madvise call on ram_block_discard_range() is not done
> in the case off hugepages.
> In this case, we need to call mmap the remap the hugetlbfs large page.

Right, madvise(DONTNEED) works ever since "90e7e7f5ef3f ("mm: enable 
MADV_DONTNEED for hugetlb mappings")".

But as you note, in QEMU we never called madvise(DONTNEED) for hugetlb 
as of today. But note that we always have an "fd" with hugetlb, because 
we never use mmap(MAP_ANON|MAP_PRIVATE|MAP_HUGETLB) in QEMU.

The weird thing is that if you have a mmap(fd, MAP_PRIVATE) hugetlb 
mapping, fallocate(fd, FALLOC_FL_PUNCH_HOLE) will *also* zap any private 
pages. So in contrast to "ordinary" memory, the madvise(DONTNEED) is not 
required.

(yes, it's very weird)

So the fallocate(fd, FALLOC_FL_PUNCH_HOLE) will zap the hugetlb page and 
you will get a fresh one on next fault.

For all the glorious details, see:

https://lore.kernel.org/linux-mm/2ddd0a26-33fd-9cde-3501-f0584bbffefc@redhat.com/


> 
> As I said in the previous email, recent kernels start to implement these
> calls for hugetlbfs, but I'm not sure that changing the mechanism of
> this ram_block_discard_range() function now is appropriate.
> Do you agree with that ?

The key point is that it works for hugetlb without madvise(DONTNEED), 
which is weird :)

Which is also why the introducing kernel change added "Do note that 
there is no compelling use case for adding this support.
This was discussed in the RFC [1].  However, adding support makes sense
as it is fairly trivial and brings hugetlb functionality more in line
with 'normal' memory."

[...]

>>
>> So one would implement a ram_block_notify_remap() and maybe indicate if
>> we had to do MAP_FIXED or if we only discarded the page.
>>
>> I once had a prototype for that, let me dig ...
> 
> That would be great !  Thanks.

Found them:

https://gitlab.com/virtio-mem/qemu/-/commit/f528c861897d1086ae84ea1bcd6a0be43e8fea7d

https://gitlab.com/virtio-mem/qemu/-/commit/c5b0328654def8f168497715409d6364096eb63f

https://gitlab.com/virtio-mem/qemu/-/commit/15e9737907835105c132091ad10f9d0c9c68ea64

But note that I didn't realize back then that the mmap(MAP_FIXED) is the 
wrong way to do it, and that we actually have to DONTNEED/PUNCH_HOLE to 
do it properly. But to get the preallocation performed by the backend, 
it should still be valuable.

Note that I wonder if we can get rid of the mmap(MAP_FIXED) handling 
completely: likely we only support Linux with MCE recovery, and 
ram_block_discard_range() should do what we need under Linux.

That would make it a lot simpler.

> 
>>
>>>
>>> I can send a new version using ram_block_discard_range() as you
>>> suggested to replace the direct call to fallocate(), if you think it
>>> would be better.
>>> Please let me know what other enhancement(s) you'd like to see in this
>>> code change.
>>
>> Something along the lines above. Please let me know if you see problems
>> with that approach that I am missing.
> 
> 
> Let me check the madvise use on hugetlbfs and if it works as expected,
> I'll try to implement a V2 version of the fix proposal integrating a
> modified ram_block_discard_range() function.

As discussed, it might all be working. If not, we would have to fix 
ram_block_discard_range().

> 
> I'll also remove the page size information from the signal handlers
> and only keep it in the kvm_hwpoison_page_add() function.

That's good. Especially because there was talk in the last bi-weekly MM 
sync [1] about possibly indicating only the actually failed cachelines 
in the future, not necessarily the full page.

So relying on that interface to return the actual pagesize would no be 
future proof.

That session was in general very interesting and very relevant for your 
work; did you by any chance attend it? If not, we should find you the 
recordings, because the idea is to be able to configure to 
not-unmap-during-mce, and instead only inform the guest OS about the MCE 
(forward it). Which avoids any HGM (high-granularity mapping) issues 
completely.

Only during reboot of the VM we will have to do exactly what is being 
done in this series: zap the whole *page* so our fresh OS will see "all 
non-faulty" memory.

[1] 
https://lkml.kernel.org/r/9242f7cc-6b9d-b807-9079-db0ca81f3c6d@google.com

> 
> I'll investigate how to keep track of the 'prealloc' attribute to
> optionally use when remapping the hugepages (on older kernels).
> And if you find the prototype code you talked about that would
> definitely help :)

Right, the above should help getting that sorted out (but code id 4 
years old, so it won't "just apply").

-- 
Cheers,

David / dhildenb


