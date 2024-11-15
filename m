Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C949CD6DDEA
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 09:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBsN2-00033w-9I; Fri, 15 Nov 2024 04:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBsN0-0002yf-0e
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 04:12:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBsMy-0000ku-62
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 04:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731661916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i6PCWBR2M4iEjc03Lw6XbDSXnX8A+KNL2Cy8f9YsOTw=;
 b=aNsZ3fm8qxG/eRAx+KE1a2w/jeDX0GOO0kZk70eY0LsX4QjM8gHnHCA2k3ahojzJJGCocF
 qlauZ8MJ3ghG9Lhih97b/lBZjPbrd4vkevJRshhcD7Y6AkT08O2NLjAdkSP1tq/nLxP80e
 QcJ0Ldi1X95fJ4G9KRv2yePaAhywiBY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-UL2xr-A2PL6vzkahVvosng-1; Fri, 15 Nov 2024 04:11:55 -0500
X-MC-Unique: UL2xr-A2PL6vzkahVvosng-1
X-Mimecast-MFC-AGG-ID: UL2xr-A2PL6vzkahVvosng
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2fb50351d18so11037141fa.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 01:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731661913; x=1732266713;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i6PCWBR2M4iEjc03Lw6XbDSXnX8A+KNL2Cy8f9YsOTw=;
 b=KaUu+LxVGo0LLm2u+t/5wF5Y10lJL7he/hCLN4wj5BgWEOoB16MjfwfnbR6YQAfWtK
 MtvlpQ7QhMQnerC4JHxj/hPcjw2BCEl33qjxSqhe3OzLNV/vWwQtoM9yzzswWwuYO+Jc
 KNZbbXQQtMYDIglNfcntJ7R0s+eMZk+MrjKLMDoHuE2yxeHKuliGMPLj+5roB8sRmOxy
 kvB7CkUFjjvXc0OVMdQsKg1WQlf0u/T0k8mRt8fyqpFA+Gg6SunIGXAZvcsGHzbWfd9i
 +Q8HKnuWhp3relLYsxjqZOuM38cl2AfWjtQL5m0wRo4iXtDgpko3P82NQabVsXnqrjT9
 /VNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXOWTOJ5FtF5vMphGNccr0DnxsUpHVfNbEW5+YL4CnXC1GBW3RqUlDduEhtSfEs7et/5v4xfoPfcj@nongnu.org
X-Gm-Message-State: AOJu0Yzrxi7VBHrYJasPdckbY3YDz09hmwr3eTeWj+QDPo1yVi0j/0Xq
 cm6+lblH1jEjqdFIak9vl/0PrThBgKRYSuBrqPlZWJIJ3i/tN6Ocj7vunXs4OOCneUKh1sY9RBw
 KchIEPrhr3BcgXyfFMslHxChcRT/FkL6HeHjMTHu0yObwSCu0jpyG
X-Received: by 2002:a2e:b8c9:0:b0:2fb:8df2:13e6 with SMTP id
 38308e7fff4ca-2ff606efc9dmr10977081fa.26.1731661913259; 
 Fri, 15 Nov 2024 01:11:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlht6N5Z9vYxYBzfAQ5tA0unFbiQ1MoEHTc+a4CmkjcTAmNY6kySLduJcUb3REtN/ZCGRzrg==
X-Received: by 2002:a2e:b8c9:0:b0:2fb:8df2:13e6 with SMTP id
 38308e7fff4ca-2ff606efc9dmr10976841fa.26.1731661912751; 
 Fri, 15 Nov 2024 01:11:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec?
 (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de.
 [2003:cb:c721:8100:177e:1983:5478:64ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab72184sm46765195e9.2.2024.11.15.01.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 01:11:52 -0800 (PST)
Message-ID: <5577f4cc-63f9-4f4a-b857-48a9405075c1@redhat.com>
Date: Fri, 15 Nov 2024 10:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: Peter Xu <peterx@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
 <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com> <ZzTkopUrLGL5iqSv@x1n>
 <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com> <ZzUIOFPtvHKDJPei@x1n>
 <8ee7d398-0139-4628-9276-f6a89fa35245@redhat.com> <ZzZPd7Ye09bjUjyR@x1n>
 <5f04a1dc-ca0a-488b-812e-7cebf393f59f@redhat.com> <ZzZ8Tzw9WV9dHo_R@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzZ8Tzw9WV9dHo_R@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>>>>
>>>> But then I realized that even memory_region_clear_dirty_bitmap() will not
>>>> clear the ramblock_dirty_bitmap_ bits! It's only concerned about
>>>> listener->log_clear() calls.
>>>>
>>>> Looking for DIRTY_MEMORY_BLOCK_SIZE users, only
>>>> cpu_physical_memory_sync_dirty_bitmap() and
>>>> cpu_physical_memory_clear_dirty_range() clear them, whereby the latter is
>>>> only used when resizing RAMblocks.
>>>>
>>>> At first I wondered whether ramblock_dirty_bitmap_clear_discarded_pages()
>>>> should also call cpu_physical_memory_clear_dirty_range(), but then I am not
>>>> so sure if that is really the right approach.
>>>
>>> That sounds actually reasonable to me so far.. What's the concern in your
>>> mind?
>>
>> I think what I had in mind was that for the initial bitmap sync, when we set
>> the bmap to all-1s already, we could just clear the whole
>> ramblock_dirty_bitmap_ + KVM ... bitmaps.
>>
>> So, instead of an "initial sync" we might just want to do an "initial
>> clearing" of all bitmaps.
> 
> Logically most dirty tracking bitmaps should start with all zeros.  KVM old
> kernels are like that; KVM_DIRTY_LOG_INITIALLY_SET is not, but it's a
> separate feature.  I still hope it's pretty common for the rest, e.g. vhost
> should have all zeros in its init bitmap even without initial sync.

We better double check and document that, because it must be guaranteed, 
not "let's cross fingers".

Also, I'm not 100% sure how KVM internals implement that (I recall some 
s390x oddities, but might be wrong ...).

> 
>>
>>>
>>>>
>>>>
>>>> virtio-balloon() calls qemu_guest_free_page_hint() which calls
>>>>
>>>> migration_clear_memory_region_dirty_bitmap_range()
>>>> bitmap_clear()
>>>>
>>>> So it would maybe have the same issue.
>>>
>>> Should virtio-balloon do the same?
>>
>> virtio-balloon is more interesting, because I assume here we could run after
>> the "initial clearing" and would want to mark it clean everywhere.
> 
> Yes, if it does what I mentioned below, IIUC it'll clear all dirty bits
> across the whole stack.  Only the ram_list bitmap is missing.  IIUC it
> could mean it could stop working for at least tcg, as tcg sololy uses
> it.. even with kvm some MRs may use it.  Maybe we want to fix it
> separately.

Yes, that definitely needs care.

[...]

>> (but I'm confused because we have way too many bitmaps, and maybe the KVM
>> one could be problematic without an initial sync ... we'd want an initial
>> clearing for that as well ...)
> 
> So IMHO most of the bitmaps should be initialized with zeros, not
> ones.. like I mentioned above.
> 
> Migration bitmap is special, because it's not about dirty tracking
> capability / reporting but that we know we need to migrate the first round.
> So setting all ones makes sense for migration only, not a reporting
> facility.  While KVM_DIRTY_LOG_INITIALLY_SET existed for its own reasoning
> on speeding up migration starts..
> 
> So, now I am thinking whether we should not set all ones in ram_list bitmap
> at all, corresponds to this change:
> 
> ===8<===
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a384..10966fa68c 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1913,10 +1913,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       ram_list.version++;
>       qemu_mutex_unlock_ramlist();
>   
> -    cpu_physical_memory_set_dirty_range(new_block->offset,
> -                                        new_block->used_length,
> -                                        DIRTY_CLIENTS_ALL);
> -
>       if (new_block->host) {
>           qemu_ram_setup_dump(new_block->host, new_block->max_length);
>           qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
> ===8<===
> 

It will leave things in an inconsistent state with regards of 
qemu_ram_resize() though. So we'd want to do the same thing there as well.

I don't know about DIRTY_CLIENTS_ALL, though ... no expert on that, 
which side effects it has.

Because saying "initially, all memory is dirty" can make sense, 
depending on from which angle you look at it.

> I'm guessing whether above could fix the virtio-mem regression after
> Hyman's current patch applied.
> 
> Said that, IMHO virtio-mem should still use the same helper just like
> virtio-balloon as I discussed previously, so as to reset bitmap for the
> whole stack (which seems to always be the right thing to do to not miss one
> layer of them)?

Well, the difference is that virtio-mem really only gets called exactly 
once initially. If we can just reset all bitmaps initially, then 
virtio-mem really only has to zap the rb->bmap.

The most robust solution would be to process discards after every bitmap 
sync of course.

> 
> Hence: 1 patch to virtio-balloon covering ram_list bitmap (which could be a
> real fix to virtio-balloon on e.g. tcg?); 1 patch to virtio-mem reusing
> that helper of virtio-balloon just as a cleanup to also cover all bitmaps;
> 1 patch like above to avoid setting ones at all in ram_list bitmap as
> cleanup; then finally remove the sync() in SETUP, which is this patch.
> IIUC after all these changes applied it'll work for all cases.

Would work for me.

BTW, I was wondering if we could get rid of one of the bitmaps with KVM 
... but likely not that easy.

-- 
Cheers,

David / dhildenb


