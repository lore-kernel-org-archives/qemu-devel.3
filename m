Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D87D1BDEA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 19:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t837P-00009K-JE; Mon, 04 Nov 2024 14:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t837N-00008r-Sd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 14:52:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t837L-0006NG-9y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 14:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730749921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N4Jq7sOuJgfzA0HBZUW6rQkkwF17VoizreDrkc5hAZQ=;
 b=FyRm3JKs5CiBinTaGI1IlH+WDA8HjK9ovNINsnVEbIqCP5R/E9cK4GTt6JYd+sQaL7SFiC
 Q2OV5Qmx25IB+5WwZNDtz22rvcwoiJAS4emjYT35odzdLVvR1JkXazDa2jN/y/yYlSywyw
 JhylBPvvILAdVur2Hy6BRXqR5B3uaEY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-IknUn92TN1i8qPB8CEjWZQ-1; Mon, 04 Nov 2024 14:52:00 -0500
X-MC-Unique: IknUn92TN1i8qPB8CEjWZQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315d98a873so27337615e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 11:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730749919; x=1731354719;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N4Jq7sOuJgfzA0HBZUW6rQkkwF17VoizreDrkc5hAZQ=;
 b=IY0huSwChnx97PNBy3h3LpeXl8APkRQ/HPDjVZ2MJvFwnZUe0nsjZQ08h/lOQxkCKY
 ZbrDfiQiBsQO/Rt5uWubO9NdPxe6ZQVIYK7eTdRwsOm2cVc0twykwBkaJW7JSwyTnHjy
 IlG2gHxXTrNPRXlZ/u8PCqBfEGa0glo8x2xesibs7DOl4kymBK5SfDB5/b4yNA9QD+Rt
 OAcBnXDuJWSkydK2YiL77RCqx4ehh9hPIsc/p9wYk886D66idz2cmqgiApCqXfAGMo9m
 gekYMtt+7mCgASxjA9UYrI44T86K8YcvZWHE9y7fxTcP88n0oaFY/Tj8WvUX1Zd8BQEy
 aLZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAUEvkgJ/7qCPhn06/kETT7FbyQpfn7tsdIUDUHihzqC2X6m+Hz3eN6WS33ytwsgbGSiWpLdWmD2+v@nongnu.org
X-Gm-Message-State: AOJu0YwoqNKYUxvv6qKr1QsdmS/si66LvoD2TZkROIXVyxwHZL7czO34
 DdR21xTFGnnjpBo/yaTMoOsai7yrp7tNp6NsMHYA+z8x3riVPm304gwkfm1VzjCSGmuLS88qLFE
 tj47PVUn1wAPPzAe6ZSNlmcGnFA7Su4e8fxNDqeiu07w0F/k098w6
X-Received: by 2002:adf:e6ce:0:b0:37d:3a6f:80cf with SMTP id
 ffacd0b85a97d-381b7056bafmr15401026f8f.6.1730749918703; 
 Mon, 04 Nov 2024 11:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPeUK4ylrZlYmqmqyEhrIfTJ84x4Ur03dGK02blBUQI7h6hgxKE9Ufic5fJ1shEfvRuwdokQ==
X-Received: by 2002:adf:e6ce:0:b0:37d:3a6f:80cf with SMTP id
 ffacd0b85a97d-381b7056bafmr15401009f8f.6.1730749918177; 
 Mon, 04 Nov 2024 11:51:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:e500:e96a:8043:1211:8e6a?
 (p200300cbc72fe500e96a804312118e6a.dip0.t-ipconnect.de.
 [2003:cb:c72f:e500:e96a:8043:1211:8e6a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e5e3sm14059662f8f.82.2024.11.04.11.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 11:51:57 -0800 (PST)
Message-ID: <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
Date: Mon, 4 Nov 2024 20:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04.11.24 18:38, Steven Sistare wrote:
> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>> On 01.11.24 14:47, Steve Sistare wrote:
>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>> on the value of the anon-alloc machine property.  This option applies to
>>> memory allocated as a side effect of creating various devices. It does
>>> not apply to memory-backend-objects, whether explicitly specified on
>>> the command line, or implicitly created by the -m command line option.
>>>
>>> The memfd option is intended to support new migration modes, in which the
>>> memory region can be transferred in place to a new QEMU process, by sending
>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>> and if the mode also transfers device descriptors, then pages that are
>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>
>> A more portable, non-Linux specific variant of this will be using shm,
>> similar to backends/hostmem-shm.c.
>>
>> Likely we should be using that instead of memfd, or try hiding the
>> details. See below.
> 
> For this series I would prefer to use memfd and hide the details.  It's a
> concise (and well tested) solution albeit linux only.  The code you supply
> for posix shm would be a good follow on patch to support other unices.

Unless there is reason to use memfd we should start with the more 
generic POSIX variant that is available even on systems without memfd. 
Factoring stuff out as I drafted does look quite compelling.

I can help with the rework, and send it out separately, so you can focus 
on the "machine toggle" as part of this series.

Of course, if we find out we need the memfd internally instead under 
Linux for whatever reason later, we can use that instead.

But IIUC, the main selling point for memfd are additional features 
(hugetlb, memory sealing) that you aren't even using.

> 
> We could drop
>     -machine anon-alloc=mmap|memfd

Right, the memfd here might be an unnecessary detail. Especially, 
because all things here are mmap'ed ... so I don't quite like this 
interface :)


> and define
>     -machine anon-shared
> 
> as you suggest at the end.

Likely we should remove the "anon" part from the interface as well ... 
hmm ...

We want to instruct QEMU: "all guest RAM that is not explicitly 
specified should be sharable with another process".

"internal-ram-share=true"

"default-ram-share=true"

Maybe we can come up with something even better. But getting rid of the 
"anon" would be great. I think I prefer the latter (below).

> 
>> [...]
>>
>>> @@ -69,6 +70,8 @@
>>>    #include "qemu/pmem.h"
>>> +#include "qapi/qapi-types-migration.h"
>>> +#include "migration/options.h"
>>>    #include "migration/vmstate.h"
>>>    #include "qemu/range.h"
>>> @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>                    qemu_mutex_unlock_ramlist();
>>>                    return;
>>>                }
>>> +
>>> +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
>>> +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
>>> +                                        TYPE_MEMORY_BACKEND)) {
>>
>> This looks a bit and hackish,
> 
> OK. I can revert parts of the previous version which passed in RAM_SHARED from
> various call sites to request anonymous shared memory:
>     https://lore.kernel.org/qemu-devel/1714406135-451286-18-git-send-email-steven.sistare@oracle.com
> See the various sites that do
>       uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
> Does that look OK to you?

That's one option, or we just handle it in qemu_ram_alloc_internal() as 
I drafted below.

Or we simply have another interface to allocate this "default RAM that 
does not come from a memory backend and is subject to the global 
toggle", and hide that detail (conditionally setting RAM_SHARED) in there.

> 
>> and I don't think ram_block_add() is the right
>> place where this should be. It should likely happen in the caller.
> 
> I agree, but I received no feedback when I proposed to refactor allocation
> vs ram_block_add, so I dropped them to simplify the live update review.
> These refactor but do not change functionality.  Are you OK with something
> like this?  Is this overkill?
> 

Probably overkill :)

> https://lore.kernel.org/qemu-devel/1714406135-451286-1-git-send-email-steven.sistare@oracle.com/
>     physmem: ram_block_create
>     physmem: hoist guest_memfd creation
>     physmem: hoist host memory allocation
> 
>> We already do have two ways of allocating "shared anonymous memory":
>>
>> (1) memory-backend-ram,share=on
>> (2) memory-backend-shm
>>
>> (2) gives us an fd as it uses shm_open(), (1) doesn't give us an fd as it
>> uses MAP_ANON|MAP_SHARED. (1) is really only a corner case use case [1].
>>
>> [there is also Linux specific memfd, which gives us more flexibility with
>> hugetlb etc, but for the purpose here shm should likely be sufficient?]
>>
>> So why not make (1) behave like (2) and move that handling into
>> qemu_ram_alloc_internal(), from where we can easily enable it using a
>> new RMA_SHARED flag? So as a first step, something like:
> 
> I prefer that, and an earlier version did so, but only if anon-alloc==memfd.
> 
> To be clear, do you propose that memory-backend-ram,shared=on unconditionally
> mmap fd-based shared memory, independently of the setting of anon-alloc?
> And drop the MAP_ANON|MAP_SHARED possibility?

Yes, as done in my draft patch. MAP_ANON|MAP_SHARED was primarily a hack 
to make this RDMA thingy fly that could not deal with anonymous memory, 
and we didn't have

memory-backend-ram,share=on was added via 
06329ccecfa022494fdba288b3ab5bcb8dff4159 before
memory-backend-memfd was added via dbb9e0f40d7d561dcffcf7e41ac9f6a5ec90e5b5

Both ended up in the same QEMU release.

So likely memory-backend-ram,share=on could just have used 
memory-backend-memfd if it would have been available earlier, at least 
on Linux ...


But, it looks like the use case for memory-backend-ram,share=on does no 
longer even exist, because

commit 1dfd42c4264bbf47415a9e73f0d6b4e6a7cd7393
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Thu Mar 28 12:53:00 2024 +0100

     hw/rdma: Remove deprecated pvrdma device and rdmacm-mux helper

Removed that mremap() from the code base.

So we can change how memory-backend-ram,share=on is implemented 
internally, as long as it keeps on working in a similar way.

If "memory-backend-ram,share=on" will be the same as specifying 
"default-ram-share=on", that would actually be quite nice ... no need to 
bring in memfds at all as long as we only want some memory with an fd to 
share with other processes.

> 
> Or, do you propose that for memory-backend-ram,shared=on:
>     if anon-shared
>       mmap fd
>     else
>        MAP_ANON|MAP_SHARED


My suggestion would be to unconditionally use shm (which is available 
even on kernels without memfd support; if required use memfd first and 
fallback to shmem) as in the patch I drafted.

> 
> The former is simpler from a user documentation point of view, but either
> works for me.  I could stop listing memory-backend-ram  as an exception in
> the docs, which currently state:
>     #     Memory-backend objects must have the share=on attribute, but
>     #     memory-backend-epc and memory-backend-ram are not supported.

Likely that was never updated to document the memory-backend-ram use case.

> 
> [...]
>>
>> Then, you only need a machine option to say "anon-shared", to make all
>> anonymous memory sharable between processes. All it would do is setting
>> the RAM_SHARED flag in qemu_ram_alloc_internal() when reasonable
>> (!(ram_flags & RAM_PREALLOC)).
>>
>> To handle "memory-backend-ram,share=off", can we find a way to bail out if
>> memory-backend-ram,share=off was used while the machine option "anon-shared"
>> would be active?
> 
> In later patches I install migration blockers for various conditions, including
> when a ram block does not support CPR.

Good!

> 
>> Or just document that the "anon-shared" will win?
> 
> IMO a blocker is sufficient.
> 
> I think you are also suggesting that an unadorned "memory-backend-ram"
> specification (with implicit shared=off), plus anon-shared, should cause
> shared anon to be allocated:
>     "you only need a machine option to say "anon-shared", to make all anonymous
>      memory sharable"
> 
> I did that previously, and Peter objected, saying the explicit anon-shared
> should not override the implicit shared=off.

Yes, it's better if we can detect that somehow. There should be easy 
ways to make that work, so I wouldn't worry about that.

-- 
Cheers,

David / dhildenb


