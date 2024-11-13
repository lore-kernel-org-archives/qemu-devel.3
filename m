Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E4ED637A8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBIR8-0005vM-T6; Wed, 13 Nov 2024 13:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBIR7-0005v6-IE
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:49:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBIR5-0005RK-DG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731523789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9hq+/8jHZ+zHq8tOLX9HvOQ8Muoxo34sCEhoy+ibMCo=;
 b=VrCER6jSjkc+NDci5Qv4ZxbKsOSF1ubpiffuSbz7YzcnYc84d5dzDXzStEys5H2fyRZlKg
 3Lm2BIRtQekjOHg7Z/wL18W0Sn8f2rnBte+7KH+UZcsrxDXARPO1VJhXsLKrAEfuP/rJjT
 9TujqdCmRAaNjo5F7l174cNTBYzs/dg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-sectfVTuNL67cFBSMbol6Q-1; Wed, 13 Nov 2024 13:49:48 -0500
X-MC-Unique: sectfVTuNL67cFBSMbol6Q-1
X-Mimecast-MFC-AGG-ID: sectfVTuNL67cFBSMbol6Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso55851405e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731523787; x=1732128587;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9hq+/8jHZ+zHq8tOLX9HvOQ8Muoxo34sCEhoy+ibMCo=;
 b=GqUQFQPir1WP5ha3VwnF0M+FloL0KmFbtoT35mEk+djCmkJPh9ZUd6ii0p8MSF5cIk
 akkuYH4NrpXiI1+Y9gO+ex/oU5Q5J4ABSRHUZ2m+YqQSx1jFgD5Xphb9HsrrJ4gUlu94
 KQZOsREctFemOq+JpevKr/DGDMc5rn4OwHJLb786PHpI6qTFY18DJ7deRHSmp0LAWhGI
 pPWvpJChlmtGv1CZbJHmYJj9rM5yiYfohECY15urdx27X/RwrWt8ArSOSatBoSsEuz85
 2jIfApFzF6T5rCFFBeOaJRz6rmVZNcIwntiYHmacMTwPy44fueDwgB6vnf5g+e+9AiU3
 1vFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRkrQ6DkYUYzzklYho4PM1haQqxdI+ZFQHlD2foF3AztlHfsNebpO1S9TdNeyBmK897oGwveQYArRI@nongnu.org
X-Gm-Message-State: AOJu0YyBf1iX75M074DO/JYhGcFiUMbg/pmuR1tCavflGoWw7APoNK7f
 CjFjXdDd+EqYlYGgGAXcV7vWDRuUBxm+LDqOrnCWY6zx4HjBK/xWVdM/nIfhUIpk+K9UEFylfUq
 fxD2AcNNjHGvFQa/j7dTvAlLbAdb0kqsqu27Aoo/dGJaJ5/S/683O
X-Received: by 2002:a05:600c:3ba3:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-432b7481bdbmr198295785e9.0.1731523786876; 
 Wed, 13 Nov 2024 10:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvrMAJB4p0JDpXvNLFMKdmOb53DAxEuKGXPj+f77MIuB/dC5JVEg/4CPr7ro0y1mbiVInYLA==
X-Received: by 2002:a05:600c:3ba3:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-432b7481bdbmr198295655e9.0.1731523786468; 
 Wed, 13 Nov 2024 10:49:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539?
 (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de.
 [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d54e2e19sm33561435e9.3.2024.11.13.10.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 10:49:45 -0800 (PST)
Message-ID: <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com>
Date: Wed, 13 Nov 2024 19:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: Peter Xu <peterx@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
 <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com> <ZzTkopUrLGL5iqSv@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzTkopUrLGL5iqSv@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
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

On 13.11.24 18:40, Peter Xu wrote:
> On Tue, Nov 12, 2024 at 11:08:44AM +0100, David Hildenbrand wrote:
>> On 11.11.24 12:37, Yong Huang wrote:
>>>
>>>
>>> On Mon, Nov 11, 2024 at 6:42 PM David Hildenbrand <david@redhat.com
>>> <mailto:david@redhat.com>> wrote:
>>>
>>>      On 11.11.24 11:08, Yong Huang wrote:
>>>       >
>>>       >
>>>       > On Mon, Nov 11, 2024 at 5:27 PM David Hildenbrand
>>>      <david@redhat.com <mailto:david@redhat.com>
>>>       > <mailto:david@redhat.com <mailto:david@redhat.com>>> wrote:
>>>       >
>>>       >     On 09.11.24 05:59, Hyman Huang wrote:
>>>       >      > The first iteration's RAMBlock dirty sync can be omitted
>>>      because QEMU
>>>       >      > always initializes the RAMBlock's bmap to all 1s by default.
>>>       >      >
>>>       >      > Signed-off-by: Hyman Huang <yong.huang@smartx.com
>>>      <mailto:yong.huang@smartx.com>
>>>       >     <mailto:yong.huang@smartx.com <mailto:yong.huang@smartx.com>>>
>>>       >      > ---
>>>       >      >   migration/cpu-throttle.c |  2 +-
>>>       >      >   migration/ram.c          | 11 ++++++++---
>>>       >      >   2 files changed, 9 insertions(+), 4 deletions(-)
>>>       >      >
>>>       >      > diff --git a/migration/cpu-throttle.c b/migration/cpu-
>>>      throttle.c
>>>       >      > index 5179019e33..674dc2004e 100644
>>>       >      > --- a/migration/cpu-throttle.c
>>>       >      > +++ b/migration/cpu-throttle.c
>>>       >      > @@ -141,7 +141,7 @@ void
>>>      cpu_throttle_dirty_sync_timer_tick(void
>>>       >     *opaque)
>>>       >      >        * effect on guest performance, therefore omit it to
>>>      avoid
>>>       >      >        * paying extra for the sync penalty.
>>>       >      >        */
>>>       >      > -    if (sync_cnt <= 1) {
>>>       >      > +    if (!sync_cnt) {
>>>       >      >           goto end;
>>>       >      >       }
>>>       >      >
>>>       >      > diff --git a/migration/ram.c b/migration/ram.c
>>>       >      > index 05ff9eb328..571dba10b7 100644
>>>       >      > --- a/migration/ram.c
>>>       >      > +++ b/migration/ram.c
>>>       >      > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
>>>       >      >   {
>>>       >      >       MigrationState *ms = migrate_get_current();
>>>       >      >       RAMBlock *block;
>>>       >      > -    unsigned long pages;
>>>       >      > +    unsigned long pages, clear_bmap_pages;
>>>       >      >       uint8_t shift;
>>>       >      >
>>>       >      >       /* Skip setting bitmap if there is no RAM */
>>>       >      > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
>>>       >      >
>>>       >      >           RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>>>       >      >               pages = block->max_length >> TARGET_PAGE_BITS;
>>>       >      > +            clear_bmap_pages = clear_bmap_size(pages, shift);
>>>       >      >               /*
>>>       >      >                * The initial dirty bitmap for migration
>>>      must be
>>>       >     set with all
>>>       >      >                * ones to make sure we'll migrate every
>>>      guest RAM
>>>       >     page to
>>>       >      > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
>>>       >      >                   block->file_bmap = bitmap_new(pages);
>>>       >      >               }
>>>       >      >               block->clear_bmap_shift = shift;
>>>       >      > -            block->clear_bmap =
>>>       >     bitmap_new(clear_bmap_size(pages, shift));
>>>       >      > +            block->clear_bmap = bitmap_new(clear_bmap_pages);
>>>       >      > +            /*
>>>       >      > +             * Set clear_bmap to 1 unconditionally, as we
>>>      always
>>>       >     set bmap
>>>       >      > +             * to all 1s by default.
>>>       >      > +             */
>>>       >      > +            bitmap_set(block->clear_bmap, 0,
>>>      clear_bmap_pages);
>>>       >      >           }
>>>       >      >       }
>>>       >      >   }
>>>       >      > @@ -2783,7 +2789,6 @@ static bool
>>>      ram_init_bitmaps(RAMState *rs,
>>>       >     Error **errp)
>>>       >      >               if (!ret) {
>>>       >      >                   goto out_unlock;
>>>       >      >               }
>>>       >      > -            migration_bitmap_sync_precopy(false);
>>>       >      >           }
>>>       >      >       }
>>>       >      >   out_unlock:
>>>       >
>>>       >
>>>       >     For virtio-mem, we rely on the
>>>      migration_bitmap_clear_discarded_pages()
>>>       >     call to clear all bits that correspond to unplugged memory
>>>      ranges.
>>>       >
>>>       >
>>>       >     If we ommit the sync, we can likely have bits of unplugged
>>>      ranges still
>>>       >     set to "1", meaning we would try migrate them later, although we
>>>       >     shouldn't?
>>>       >
>>>       >
>>>       >
>>>       > IIUC, migration_bitmap_clear_discarded_pagesis still called at
>>>      the end of
>>>       > ram_init_bitmaps no matter if we omit the first sync.
>>>        > > PRECOPY_NOTIFY_SETUPnotification is sent out at the end of
>>>       > ram_save_setup(ram_list_init_bitmaps),when
>>>       > virtio_balloon_free_page_start() is
>>>       > called,migration_bitmap_clear_discarded_pages() has already
>>>      completed
>>>       > and the
>>>       > bmap has been correctly cleared.
>>>       >
>>>       > ram_save_setup
>>>       >     -> ram_list_init_bitmaps
>>>       >         -> migration_bitmap_clear_discarded_pages
>>>       >      -> return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
>>>       >
>>>       > You can double check it.
>>>
>>>      That's not my concern, let me clarify :)
>>>
>>>
>>>      Assume in KVM the bitmap is all 1s ("everything dirty").
>>>
>>>      In current code, we will sync the bitmap once (IIRC, clearing any dirty
>>>      bits from KVM).
>>>
>>>
>>> For the old logic, write-protect and clear dirty bits are all done in
>>> the KVM_GET_DIRTY_LOG API, while with
>>> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 feature enabled, clearing
>>> dirty bits are postponed in the KVM_CLEAR_DIRTY_LOG API, which
>>> is called right before page sending in the migration thread in QEMU.
>>>
>>>
>>>      Then we call migration_bitmap_clear_discarded_pages() to clear all
>>>      "discarded" pages that we shouldn't touch.
>>>
>>>      When we do the next bitmap sync, we will not get a "1" for discarded
>>>      ranges, and we will never try migrating discarded ranges.
>>>
>>>
>>>      With your patch, we're omitting the first sync. Could we possibly get
>>>      discarded ranges reported from KVM as dirty during the "now first" sync
>>>      *after* the migration_bitmap_clear_discarded_pages() call, and try
>>>      migrating discarded ranges?
>>>
>>>      I did not dive deep into the code, maybe
>>>      migration_bitmap_clear_discarded_pages() ends up clearing the bits in
>>>
>>>
>>> Yes, the migration_bitmap_clear_discarded_pages clear the bits in
>>> KVM in:
>>> ramblock_dirty_bitmap_clear_discarded_pages
>>>       -> dirty_bitmap_clear_section
>>>           -> migration_clear_memory_region_dirty_bitmap_range
>>>               -> migration_clear_memory_region_dirty_bitmap
>>>                   -> memory_region_clear_dirty_bitmap
>>>                       -> KVM_CLEAR_DIRTY_LOG ioctl
>>>
>>
>> I just tried, and your patch breaks virtio-mem migration as I suspected.
>>
>> sudo build/qemu-system-x86_64 \
>>      --enable-kvm \
>>      -m 16G,maxmem=24G \
>>      -object memory-backend-ram,id=mem1,size=16G \
>>      -machine q35,memory-backend=mem1 \
>>      -cpu max \
>>      -smp 16 \
>>      -nographic \
>>      -nodefaults \
>>      -net nic -net user \
>>      -chardev stdio,nosignal,id=serial \
>>      -hda Fedora-Server-KVM-40-1.14.x86_64.qcow2 \
>>      -cdrom /home/dhildenb/git/cloud-init/cloud-init.iso \
>>      -device isa-serial,chardev=serial \
>>      -chardev socket,id=monitor,path=/var/tmp/mon_src,server,nowait \
>>      -mon chardev=monitor,mode=readline \
>>      -device pcie-root-port,id=root,slot=0 \
>>      -object memory-backend-file,share=on,mem-path=/dev/shm/vm,id=mem2,size=8G \
>>      -device virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=16M,bus=root,dynamic-memslots=on,prealloc=on \
>>
>>
>> Once the VM booted up, as expected we're consuming 16M
>>
>>
>> $ stat /dev/shm/vm
>>   Datei: /dev/shm/vm
>>   Größe: 8589934592      Blöcke: 32768      EA Block: 4096   reguläre Datei
>> Gerät: 0/25     Inode: 2087        Verknüpfungen: 1
>> tmpfs                   tmpfs             16G   16M   16G   1% /dev/shm
>>
>>
>> Let's start a migration:
>>
>> $ echo "migrate exec:cat>state" | sudo nc -U /var/tmp/mon_src
>>
>>
>> ... and we end up reading discarded memory:
>>
>> $ LANG=C df -ahT  | grep /dev/shm
>> tmpfs                   tmpfs             16G  8.0G  7.6G  52% /dev/shm
>>
>>
>>
>> Running with TCG only also doesn't work. So somewhere, we have a bitmap filled with
>> all 1s that is not cleared if we drop the first sync.
> 
> Hmm, I'm not yet sure why this happened, but indeed this reminds me that at
> least vhost can have similar issue: when vhost devices are used, it has its
> own bitmap so there it can keep having 1s in the unplugged regions when
> reported the 1st time.

I'm also surprised that it triggers even with TCG. Somewhere seems to be 
a bitmap with all 1s hiding :)

> 
> Is virtio-mem plug/unplug allowed during migration?  I'm wondering whether
> below could happen while migration in progress:
> 
>    migration starts..
>    bitmap init, disgard all unplugged mem in dirty bmap
>    plug mem region X, dirty some pages
>    unplug mem region X
>    dirty sync, reports mem region X dirty (even though unplugged..)
>    ...

No, for this (and other) reasons virtio_mem_is_busy() checks for 
"migration_in_incoming_postcopy() || migration_is_running();" and 
rejects any memory plug/unplug requests.

So the discarded state is stable while migration is running.

> 
> So if unplugged mem should never be touched by qemu, then not sure whether
> above can trigger this case too.
> 
> With/without above, I wonder if migration_bitmap_clear_discarded_pages()
> shouldn't rely on the initial sync of dirty bitmap, instead it could be
> done after each global sync: either another log_global_after_sync() hook,
> or just move it over in migration_bitmap_sync().

I think I had precisely that, and I recall you suggested to have it only 
after the initial sync. Would work for me, but I'd still like to 
understand why essentially none of the "discard" was effective -- all of 
guest RAM got touched.

-- 
Cheers,

David / dhildenb


