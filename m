Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488C1D68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByaG-0006hc-Lb; Fri, 15 Nov 2024 10:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tByaF-0006h4-3d
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tByaC-0001Ru-Uw
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731685803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jGhYDVybJZfO5/JeqESIeATlMiFtEYfw5VMdJ2YJqOA=;
 b=ZcsLAercP6zMBysyANgPPYUkhKUZctJGfjOevwhHga1+HEtIwnDVEcjmCk9bmMQiSKcsU3
 DnQn5ilg0ead62RADu0XM4DQXoHGYJDfUp+QGJyvb/V5QIOF0NyYh1/x9d0ebPr4Dkj/IE
 QLJBPB3NaoS+nsNUYap5JNagOKGcUb8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-jRzyWFZ2M92Os4VHICebVw-1; Fri, 15 Nov 2024 10:49:59 -0500
X-MC-Unique: jRzyWFZ2M92Os4VHICebVw-1
X-Mimecast-MFC-AGG-ID: jRzyWFZ2M92Os4VHICebVw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-432d9bb0f19so11792985e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685798; x=1732290598;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jGhYDVybJZfO5/JeqESIeATlMiFtEYfw5VMdJ2YJqOA=;
 b=rPG74vx1AQnMiuilhqTSpF6NbJm+2lsH/HSrG1KkY0ncYhtCRUYpVlgWTJTq/UtWX2
 gy0oyzEus2aWDLdcSATnqJWHGAPvPGdWWle8YBQ7/xkw7vw82d+zeSl6eeYz3IcmbkpZ
 vtzRq+JmAddsI6M0yIQXYYI4TQ+h8iL2mboG8q7GW0wyyfdHOHKt+Av8+VahzkIwXkJq
 PFr8b7FyZImy7yk1dr6+AMldgTWLi6vfyR0dj4rqtRERo5oO3AuCyGCa8ryf4P1TIPn9
 oy+Qr7TO+kNQ2sCmvidR2IKUgVLHgcQ5oqF7LE3uIHtHpS00oAe0dYYH4f+bYtzN9Hfx
 kxBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVg1AJ9Y1o+WUH+227dOs07XgrTwVLxCqR5TDI+D+gKtV9fK163DEULn+ov3pBXNZEF9uvwZi0MUsf@nongnu.org
X-Gm-Message-State: AOJu0YwjSHYIutLN6a5Y6QPvSeMUGWMBD6Rd5zHzq0zsqxdnDEjwotJ6
 OazaYiqPKIqjk0+EUl9O9KpMqMNJnXG5j1wks42TFtaCkNszUMpoBzayhmhWoJotzgR5O8G4Ceq
 MHikAzxy6k6THlmuZsGT819Ezs3gknocaSy/BlRiwdCpi3krwIA8y
X-Received: by 2002:a05:600c:46c3:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-432df025f56mr33074315e9.14.1731685798209; 
 Fri, 15 Nov 2024 07:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyFjJ+2hf5nWBTUXNT5Tztew6e0Emu4Afcs5gpPQXeVeBo6AhcMWTi47LsueKS2+g3YrOdaQ==
X-Received: by 2002:a05:600c:46c3:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-432df025f56mr33074185e9.14.1731685797859; 
 Fri, 15 Nov 2024 07:49:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec?
 (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de.
 [2003:cb:c721:8100:177e:1983:5478:64ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244924sm61346855e9.7.2024.11.15.07.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 07:49:57 -0800 (PST)
Message-ID: <91a7fcc0-f4b6-4129-bde2-c776c1e09859@redhat.com>
Date: Fri, 15 Nov 2024 16:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: Peter Xu <peterx@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com> <ZzTkopUrLGL5iqSv@x1n>
 <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com> <ZzUIOFPtvHKDJPei@x1n>
 <8ee7d398-0139-4628-9276-f6a89fa35245@redhat.com> <ZzZPd7Ye09bjUjyR@x1n>
 <5f04a1dc-ca0a-488b-812e-7cebf393f59f@redhat.com> <ZzZ8Tzw9WV9dHo_R@x1n>
 <5577f4cc-63f9-4f4a-b857-48a9405075c1@redhat.com> <ZzdrjTXgNFlrqqEu@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzdrjTXgNFlrqqEu@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
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

>> We better double check and document that, because it must be guaranteed, not
>> "let's cross fingers".
> 
> Yes, we should double check on at least known good use cases, maybe not
> all.
> 
> E.g., I see nvmm_log_sync() and whpx_log_sync() unconditionally set dirty
> to all mem always.  I actually don't know how some of these trackers work
> for live migration, or if it works at all.
> 
> If by accident this change breaks something, I also wonder whether we
> should fix the patch that breaks it, or fix the assumption that the 1st
> sync must happen at setup.  That's simply wrong to me.. and not all dirty
> track users have such either.  E.g. vga tracking won't even have a SETUP
> phase at all.
> 
> The simplest solution for any potential breakage is to provide a
> log_global_start() and sync once there, that's exactly what SETUP should
> do.  But I hope it won't happen at all..
> 
> This is legacy tech debt to me.  The earlier we understand it the better,
> so I'm personally ok if someone would try to do this as long as major archs
> will be safe.
> 
>>
>> Also, I'm not 100% sure how KVM internals implement that (I recall some
>> s390x oddities, but might be wrong ...).
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> virtio-balloon() calls qemu_guest_free_page_hint() which calls
>>>>>>
>>>>>> migration_clear_memory_region_dirty_bitmap_range()
>>>>>> bitmap_clear()
>>>>>>
>>>>>> So it would maybe have the same issue.
>>>>>
>>>>> Should virtio-balloon do the same?
>>>>
>>>> virtio-balloon is more interesting, because I assume here we could run after
>>>> the "initial clearing" and would want to mark it clean everywhere.
>>>
>>> Yes, if it does what I mentioned below, IIUC it'll clear all dirty bits
>>> across the whole stack.  Only the ram_list bitmap is missing.  IIUC it
>>> could mean it could stop working for at least tcg, as tcg sololy uses
>>> it.. even with kvm some MRs may use it.  Maybe we want to fix it
>>> separately.
>>
>> Yes, that definitely needs care.
>>
>> [...]
>>
>>>> (but I'm confused because we have way too many bitmaps, and maybe the KVM
>>>> one could be problematic without an initial sync ... we'd want an initial
>>>> clearing for that as well ...)
>>>
>>> So IMHO most of the bitmaps should be initialized with zeros, not
>>> ones.. like I mentioned above.
>>>
>>> Migration bitmap is special, because it's not about dirty tracking
>>> capability / reporting but that we know we need to migrate the first round.
>>> So setting all ones makes sense for migration only, not a reporting
>>> facility.  While KVM_DIRTY_LOG_INITIALLY_SET existed for its own reasoning
>>> on speeding up migration starts..
>>>
>>> So, now I am thinking whether we should not set all ones in ram_list bitmap
>>> at all, corresponds to this change:
>>>
>>> ===8<===
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index dc1db3a384..10966fa68c 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -1913,10 +1913,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>        ram_list.version++;
>>>        qemu_mutex_unlock_ramlist();
>>> -    cpu_physical_memory_set_dirty_range(new_block->offset,
>>> -                                        new_block->used_length,
>>> -                                        DIRTY_CLIENTS_ALL);
>>> -
>>>        if (new_block->host) {
>>>            qemu_ram_setup_dump(new_block->host, new_block->max_length);
>>>            qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
>>> ===8<===
>>>
>>
>> It will leave things in an inconsistent state with regards of
>> qemu_ram_resize() though. So we'd want to do the same thing there as well.
>>
>> I don't know about DIRTY_CLIENTS_ALL, though ... no expert on that, which
>> side effects it has.
>>
>> Because saying "initially, all memory is dirty" can make sense, depending on
>> from which angle you look at it.
> 
> Migration definitely doesn't need it, so to be safe we could also make
> CLIENT_ALL to CODE|VGA.
> 
> And if we agree virtio-mem will need to punch holes on all the bitmaps,
> then this patch is even not needed.  For that, more below.

Yes, it's fine for me as a fix. It's not optimal, but I don't really 
care as long as it works :)

> 
>>
>>> I'm guessing whether above could fix the virtio-mem regression after
>>> Hyman's current patch applied.
>>>
>>> Said that, IMHO virtio-mem should still use the same helper just like
>>> virtio-balloon as I discussed previously, so as to reset bitmap for the
>>> whole stack (which seems to always be the right thing to do to not miss one
>>> layer of them)?
>>
>> Well, the difference is that virtio-mem really only gets called exactly once
>> initially. If we can just reset all bitmaps initially, then virtio-mem
>> really only has to zap the rb->bmap.
> 
> I think virtio-mem should better always punch through, regardless of
> whether we can have above change. Consider cases like KVM "initial-all-set"
> feature I mentioned above, when that feature bit is set by QEMU, KVM sets
> all ones to the bitmap initially.  So that may be required for virtio-mem
> to clear 1s in KVM at least.

Yes.

Anyhow, I'm happy as long as we don't break virtio-mem. Clearing all 
bitmaps will work.

Getting virtio-mem to clear discarded after every bitmap sync would be 
even more robust, for example, if we'd had some stupid sync() 
implementation that simply always sets all memory dirty ...

-- 
Cheers,

David / dhildenb


