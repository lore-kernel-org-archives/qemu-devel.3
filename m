Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4756CD339A1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 17:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5T7m-0001ta-8J; Mon, 28 Oct 2024 13:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t5T7Z-0001sN-Ke
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 13:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t5T7X-0003Pv-Ni
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 13:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730134894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=knyVjinu2Mws85bdLGklnnsg+EFi+WIdDCzwpn7Dbgw=;
 b=gHabOiGPjD2gl7wESY6xqpEofhAUiCvcXf+bhiIy+T/aBIC2P/iYUJFtDE+V0on2h/QMHG
 ZvG1RJUqiE5eNvBRrLfik3WINZNV7aURCU9dAPbtD2mPyAprTEUhU/xhB4tJTtE43Rtrdd
 eEG0zxkcE0c9D9ctP5Od6yy01uK2d94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-nQ5ayKPPMl23CTLr1zIecA-1; Mon, 28 Oct 2024 13:01:33 -0400
X-MC-Unique: nQ5ayKPPMl23CTLr1zIecA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so2513369f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 10:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134892; x=1730739692;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=knyVjinu2Mws85bdLGklnnsg+EFi+WIdDCzwpn7Dbgw=;
 b=C4tM+E8q3K8dVEaw9vY1xGROaPVhaVNqJE096s2OLF8HigNILyyZthneYiENL/4iVP
 ZI73nc3Au78dBNVVx1Ko/s/sQsvVLyZS/BxYnAild4twpk5kez+SGhTuWbfC3e/2ev29
 rsRwGG3WkE3snURrh2r77kQHYXWn4gTyhF33SkE7RGRa0VfcxJ+4MCh9Ki6ZbshqJ5XZ
 +dEusObtbiQGDzbb1WaqW+eRXw+E6A9exlkxV/uueRrVsXMaIpbJc1m20O7FbZQ3v+Rl
 +ADVk06HWZ8FMY6oFZRG1GFQ5UdUcnvB+6t1Gu/YJelLPGyiUka3mzvRQ52OOX0ePAHf
 VV1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwJ6q4QWpP0eKQVSE3Pu5TjEKL1t1DqTgWrHhI8l6dbd+hdc1cXLTKtMul+zwNCf4Elb4x5P4KTgE+@nongnu.org
X-Gm-Message-State: AOJu0Yz2Git5yZiHQdfd5c2dkJNnjbP8iNgO7fmFOAbO1jUpFXonHpHg
 axctKGUZ4fweqMoxkLVWYeMKo9YSoCDtpUPKoPZ10fEdratS0BVcD1q0oQ2jiuXOlm7rrFFMwUn
 O1+cKBQEeBu6+s5qHJBGWHa4snqQcXPrknMc17SbBR0oAQspLptna
X-Received: by 2002:adf:fc46:0:b0:37d:3b31:7a9d with SMTP id
 ffacd0b85a97d-3808142425cmr219978f8f.23.1730134891690; 
 Mon, 28 Oct 2024 10:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3gv8jkidQj+gd787+D8ARLSgdIXqgR3pT51uiNdGbuO/X8+aC6K5vGCFsapMMHJg+R+DcA==
X-Received: by 2002:adf:fc46:0:b0:37d:3b31:7a9d with SMTP id
 ffacd0b85a97d-3808142425cmr219916f8f.23.1730134891180; 
 Mon, 28 Oct 2024 10:01:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:3c00:70fc:90a8:2c65:79b4?
 (p200300cbc7223c0070fc90a82c6579b4.dip0.t-ipconnect.de.
 [2003:cb:c722:3c00:70fc:90a8:2c65:79b4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b712bfsm10008386f8f.79.2024.10.28.10.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 10:01:30 -0700 (PDT)
Message-ID: <6cc00e04-6e38-4970-9d6b-52b56ee20a64@redhat.com>
Date: Mon, 28 Oct 2024 18:01:29 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e9f8e404-50db-4e0f-a5e1-749acad49325@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

On 26.10.24 01:27, William Roche wrote:
> On 10/23/24 09:30, David Hildenbrand wrote:
> 
>> On 22.10.24 23:35, “William Roche wrote:
>>> From: William Roche <william.roche@oracle.com>
>>>
>>> When the VM reboots, a memory reset is performed calling
>>> qemu_ram_remap() on all hwpoisoned pages.
>>> While we take into account the recorded page sizes to repair the
>>> memory locations, a large page also needs to punch a hole in the
>>> backend file to regenerate a usable memory, cleaning the HW
>>> poisoned section. This is mandatory for hugetlbfs case for example.
>>>
>>> Signed-off-by: William Roche <william.roche@oracle.com>
>>> ---
>>>    system/physmem.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index 3757428336..3f6024a92d 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -2211,6 +2211,14 @@ void qemu_ram_remap(ram_addr_t addr,
>>> ram_addr_t length)
>>>                    prot = PROT_READ;
>>>                    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
>>>                    if (block->fd >= 0) {
>>> +                    if (length > TARGET_PAGE_SIZE &&
>>> fallocate(block->fd,
>>> +                        FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
>>> +                        offset + block->fd_offset, length) != 0) {
>>> +                        error_report("Could not recreate the file
>>> hole for "
>>> +                                     "addr: " RAM_ADDR_FMT "@"
>>> RAM_ADDR_FMT "",
>>> +                                     length, addr);
>>> +                        exit(1);
>>> +                    }
>>>                        area = mmap(vaddr, length, prot, flags, block->fd,
>>>                                    offset + block->fd_offset);
>>>                    } else {
>>
>> Ah! Just what I commented to patch #3; we should be using
>> ram_discard_range(). It might be better to avoid the mmap() completely
>> if ram_discard_range() worked.
> 

Hi!

> 
> I think you are referring to ram_block_discard_range() here, as
> ram_discard_range() seems to relate to VM migrations, maybe not a VM reset.

Please take a look at the users of ram_block_discard_range(), including 
virtio-balloon to completely zap guest memory, so we will get fresh 
memory on next access. It takes care of process-private and file-backed 
(shared) memory.

> 
> Remapping the page is needed to get rid of the poison. So if we want to
> avoid the mmap(), we have to shrink the memory address space -- which
> can be a real problem if we imagine a VM with 1G large pages for
> example. qemu_ram_remap() is used to regenerate the lost memory and the
> mmap() call looks mandatory on the reset phase.

Why can't we use ram_block_discard_range() to zap the poisoned page 
(unmap from page tables + conditionallydrop from the page cache)? Is 
there anything important I am missing?

> 
> 
>>
>> And as raised, there is the problem with memory preallocation (where
>> we should fail if it doesn't work) and ram discards being disabled
>> because something relies on long-term page pinning ...
> 
> 
> Yes. Do you suggest that we add a call to qemu_prealloc_mem() for the
> remapped area in case of a backend->prealloc being true ?

Yes. Otherwise, with hugetlb, you might run out of hugetlb pages at 
runtime and SIGBUS QEMU :(

> 
> Or as we are running on posix machines for this piece of code (ifndef
> _WIN32) maybe we could simply add a MAP_POPULATE flag to the mmap call
> done in qemu_ram_remap() in the case where the backend requires a
> 'prealloc' ?  Can you confirm if this flag could be used on all systems
> running this code ?

Please use qemu_prealloc_mem(). MAP_POPULATE has no guarantees, it's 
really weird :/ mmap() might succeed even though MAP_POPULATE didn't 
work ... and it's problematic with NUMA policies because we essentially 
lose (overwrite) them.

And the whole mmap(MAP_FIXED) is an ugly hack. For example, we wouldn't 
reset the memory policy we apply in 
host_memory_backend_memory_complete() ... that code really needs a 
rewrite to do it properly.


Ideally, we'd do something high-level like


if (ram_block_discard_is_disabled()) {
	/*
	 * We cannot safely discard RAM,  ... for example we might have
	 * to remap all guest RAM into vfio after discarding the 	
	 * problematic pages ... TODO.
	 */
	exit(0);
}

/* Throw away the problematic (poisoned) page. *./
if (ram_block_discard_range()) {
	/* Conditionally fallback to MAP_FIXED workaround */
	...
}

/* If prealloction was requested, we really must re-preallcoate. */
if (prealloc && qemu_prealloc_mem()) {
	/* Preallocation failed .... */
	exit(0);
}

As you note the last part is tricky. See bwloe.

> 
> Unfortunately, I don't know how to get the MEMORY_BACKEND corresponding
> to a given memory block. I'm not sure that MEMORY_BACKEND(block->mr) is
> a valid way to retrieve the Backend object and its 'prealloc' property
> here. Could you please give me a direction here ?

We could add a RAM_PREALLOC flag to hint that this memory has "prealloc" 
semantics.

I once had an alternative approach: Similar to ram_block_notify_resize() 
we would implement ram_block_notify_remap().

That's where the backend could register and re-apply mmap properties 
like NUMA policies (in case we have to fallback to MAP_FIXED) and handle 
the preallocation.

So one would implement a ram_block_notify_remap() and maybe indicate if 
we had to do MAP_FIXED or if we only discarded the page.

I once had a prototype for that, let me dig ...

> 
> I can send a new version using ram_block_discard_range() as you
> suggested to replace the direct call to fallocate(), if you think it
> would be better.
> Please let me know what other enhancement(s) you'd like to see in this
> code change.

Something along the lines above. Please let me know if you see problems 
with that approach that I am missing.

-- 
Cheers,

David / dhildenb


