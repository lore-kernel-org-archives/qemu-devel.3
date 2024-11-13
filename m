Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583ECD637A3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHMY-0001X3-HX; Wed, 13 Nov 2024 12:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBHMW-0001Wv-Rj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBHMT-0006Id-GM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731519658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKX37nO7zxuZ02FuqT2yXAqt1Lod8HPUpFv3d9aKTDU=;
 b=e4W6CUubCWoeiAH01F7QV5FqiSqOiln16O+ewKB1ZkeEJOaAn1cpfqJsxXOeJydMZhUlZh
 r7/b7azWb8v4+yzkTmpFTvgiGID2FLo3MjACxrC4QM1MBi6dsmljtWMihWVTy3XieCD7EW
 JlByN+XFpiHaSHrNTXxckcpaqhQ3oUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-n6-UKNUROrO1oqSICdDMRA-1; Wed, 13 Nov 2024 12:40:57 -0500
X-MC-Unique: n6-UKNUROrO1oqSICdDMRA-1
X-Mimecast-MFC-AGG-ID: n6-UKNUROrO1oqSICdDMRA
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b2f2db16cfso965070385a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731519654; x=1732124454;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aKX37nO7zxuZ02FuqT2yXAqt1Lod8HPUpFv3d9aKTDU=;
 b=dMJN2R6ECrPerJ8audenubZJ82rypmEMPfQA54QOfv091JPabfNtjMUB8KMuzhPN6U
 BglUOO0YhNMo7ooWU/NkrxuXZOMYfUI7340V8QCyfmW8ldtweTOHR/jRsl+x2CWLCCAq
 6Sw7QLASRRY+4sLpIQGEA8bEHq2jQGhfcbVF72EVJyjdoQ6el4aLLIL0uE2A3T6pVprw
 mzLUMnhvJLDQQu0vmsy4UpIdCL8DGQh4rVsNIAMrApMnKD468xK2Y/976yWH13rx9Fwr
 Z/sMXn6YoxQ/eSyc55YVBeYzhmlXj5uObsZX8PglVjFZ4RfmR5rIg6aMya1rp9g2Eab4
 QYyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBF8OzG7ADmVsqR2pKvasMOZr+JFxpOcrbLGAgKXwsTd5W6fAgAw4zbkSfscbv+Z9CCCHM0eH6nc7C@nongnu.org
X-Gm-Message-State: AOJu0YyrYDBaEtSpYfxcyi8MSBO0EkNSjolzOna7UNXjGiiIhBAc0gLo
 1a3GY61WuWMTdImWiowOvthYlHZxbCMV6sZKdnP1iVIGtZ/ISYyyTI6mHUOzFz2N7wqDnnjeC0s
 e8fOhEgCuxk1cgOJEL95LAhIoZCGQcIhUASdOXFJwu9IwVsvANvbh
X-Received: by 2002:a05:620a:19a3:b0:7b1:4276:ea4e with SMTP id
 af79cd13be357-7b3528a9cddmr500344985a.13.1731519654105; 
 Wed, 13 Nov 2024 09:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHArF7jNWGkwtOLIN7o8nO5LAttS8Zlu7NuihxJbFlAL4YTlAns9KDnYVJmUxTA7MfqUDR64g==
X-Received: by 2002:a05:620a:19a3:b0:7b1:4276:ea4e with SMTP id
 af79cd13be357-7b3528a9cddmr500340385a.13.1731519653672; 
 Wed, 13 Nov 2024 09:40:53 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac57015sm713613185a.50.2024.11.13.09.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:40:52 -0800 (PST)
Date: Wed, 13 Nov 2024 12:40:50 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
Message-ID: <ZzTkopUrLGL5iqSv@x1n>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
 <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Nov 12, 2024 at 11:08:44AM +0100, David Hildenbrand wrote:
> On 11.11.24 12:37, Yong Huang wrote:
> > 
> > 
> > On Mon, Nov 11, 2024 at 6:42 PM David Hildenbrand <david@redhat.com
> > <mailto:david@redhat.com>> wrote:
> > 
> >     On 11.11.24 11:08, Yong Huang wrote:
> >      >
> >      >
> >      > On Mon, Nov 11, 2024 at 5:27 PM David Hildenbrand
> >     <david@redhat.com <mailto:david@redhat.com>
> >      > <mailto:david@redhat.com <mailto:david@redhat.com>>> wrote:
> >      >
> >      >     On 09.11.24 05:59, Hyman Huang wrote:
> >      >      > The first iteration's RAMBlock dirty sync can be omitted
> >     because QEMU
> >      >      > always initializes the RAMBlock's bmap to all 1s by default.
> >      >      >
> >      >      > Signed-off-by: Hyman Huang <yong.huang@smartx.com
> >     <mailto:yong.huang@smartx.com>
> >      >     <mailto:yong.huang@smartx.com <mailto:yong.huang@smartx.com>>>
> >      >      > ---
> >      >      >   migration/cpu-throttle.c |  2 +-
> >      >      >   migration/ram.c          | 11 ++++++++---
> >      >      >   2 files changed, 9 insertions(+), 4 deletions(-)
> >      >      >
> >      >      > diff --git a/migration/cpu-throttle.c b/migration/cpu-
> >     throttle.c
> >      >      > index 5179019e33..674dc2004e 100644
> >      >      > --- a/migration/cpu-throttle.c
> >      >      > +++ b/migration/cpu-throttle.c
> >      >      > @@ -141,7 +141,7 @@ void
> >     cpu_throttle_dirty_sync_timer_tick(void
> >      >     *opaque)
> >      >      >        * effect on guest performance, therefore omit it to
> >     avoid
> >      >      >        * paying extra for the sync penalty.
> >      >      >        */
> >      >      > -    if (sync_cnt <= 1) {
> >      >      > +    if (!sync_cnt) {
> >      >      >           goto end;
> >      >      >       }
> >      >      >
> >      >      > diff --git a/migration/ram.c b/migration/ram.c
> >      >      > index 05ff9eb328..571dba10b7 100644
> >      >      > --- a/migration/ram.c
> >      >      > +++ b/migration/ram.c
> >      >      > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> >      >      >   {
> >      >      >       MigrationState *ms = migrate_get_current();
> >      >      >       RAMBlock *block;
> >      >      > -    unsigned long pages;
> >      >      > +    unsigned long pages, clear_bmap_pages;
> >      >      >       uint8_t shift;
> >      >      >
> >      >      >       /* Skip setting bitmap if there is no RAM */
> >      >      > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> >      >      >
> >      >      >           RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >      >      >               pages = block->max_length >> TARGET_PAGE_BITS;
> >      >      > +            clear_bmap_pages = clear_bmap_size(pages, shift);
> >      >      >               /*
> >      >      >                * The initial dirty bitmap for migration
> >     must be
> >      >     set with all
> >      >      >                * ones to make sure we'll migrate every
> >     guest RAM
> >      >     page to
> >      >      > @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
> >      >      >                   block->file_bmap = bitmap_new(pages);
> >      >      >               }
> >      >      >               block->clear_bmap_shift = shift;
> >      >      > -            block->clear_bmap =
> >      >     bitmap_new(clear_bmap_size(pages, shift));
> >      >      > +            block->clear_bmap = bitmap_new(clear_bmap_pages);
> >      >      > +            /*
> >      >      > +             * Set clear_bmap to 1 unconditionally, as we
> >     always
> >      >     set bmap
> >      >      > +             * to all 1s by default.
> >      >      > +             */
> >      >      > +            bitmap_set(block->clear_bmap, 0,
> >     clear_bmap_pages);
> >      >      >           }
> >      >      >       }
> >      >      >   }
> >      >      > @@ -2783,7 +2789,6 @@ static bool
> >     ram_init_bitmaps(RAMState *rs,
> >      >     Error **errp)
> >      >      >               if (!ret) {
> >      >      >                   goto out_unlock;
> >      >      >               }
> >      >      > -            migration_bitmap_sync_precopy(false);
> >      >      >           }
> >      >      >       }
> >      >      >   out_unlock:
> >      >
> >      >
> >      >     For virtio-mem, we rely on the
> >     migration_bitmap_clear_discarded_pages()
> >      >     call to clear all bits that correspond to unplugged memory
> >     ranges.
> >      >
> >      >
> >      >     If we ommit the sync, we can likely have bits of unplugged
> >     ranges still
> >      >     set to "1", meaning we would try migrate them later, although we
> >      >     shouldn't?
> >      >
> >      >
> >      >
> >      > IIUC, migration_bitmap_clear_discarded_pagesis still called at
> >     the end of
> >      > ram_init_bitmaps no matter if we omit the first sync.
> >       > > PRECOPY_NOTIFY_SETUPnotification is sent out at the end of
> >      > ram_save_setup(ram_list_init_bitmaps),when
> >      > virtio_balloon_free_page_start() is
> >      > called,migration_bitmap_clear_discarded_pages() has already
> >     completed
> >      > and the
> >      > bmap has been correctly cleared.
> >      >
> >      > ram_save_setup
> >      >     -> ram_list_init_bitmaps
> >      >         -> migration_bitmap_clear_discarded_pages
> >      >      -> return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
> >      >
> >      > You can double check it.
> > 
> >     That's not my concern, let me clarify :)
> > 
> > 
> >     Assume in KVM the bitmap is all 1s ("everything dirty").
> > 
> >     In current code, we will sync the bitmap once (IIRC, clearing any dirty
> >     bits from KVM).
> > 
> > 
> > For the old logic, write-protect and clear dirty bits are all done in
> > the KVM_GET_DIRTY_LOG API, while with
> > KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 feature enabled, clearing
> > dirty bits are postponed in the KVM_CLEAR_DIRTY_LOG API, which
> > is called right before page sending in the migration thread in QEMU.
> > 
> > 
> >     Then we call migration_bitmap_clear_discarded_pages() to clear all
> >     "discarded" pages that we shouldn't touch.
> > 
> >     When we do the next bitmap sync, we will not get a "1" for discarded
> >     ranges, and we will never try migrating discarded ranges.
> > 
> > 
> >     With your patch, we're omitting the first sync. Could we possibly get
> >     discarded ranges reported from KVM as dirty during the "now first" sync
> >     *after* the migration_bitmap_clear_discarded_pages() call, and try
> >     migrating discarded ranges?
> > 
> >     I did not dive deep into the code, maybe
> >     migration_bitmap_clear_discarded_pages() ends up clearing the bits in
> > 
> > 
> > Yes, the migration_bitmap_clear_discarded_pages clear the bits in
> > KVM in:
> > ramblock_dirty_bitmap_clear_discarded_pages
> >      -> dirty_bitmap_clear_section
> >          -> migration_clear_memory_region_dirty_bitmap_range
> >              -> migration_clear_memory_region_dirty_bitmap
> >                  -> memory_region_clear_dirty_bitmap
> >                      -> KVM_CLEAR_DIRTY_LOG ioctl
> > 
> 
> I just tried, and your patch breaks virtio-mem migration as I suspected.
> 
> sudo build/qemu-system-x86_64 \
>     --enable-kvm \
>     -m 16G,maxmem=24G \
>     -object memory-backend-ram,id=mem1,size=16G \
>     -machine q35,memory-backend=mem1 \
>     -cpu max \
>     -smp 16 \
>     -nographic \
>     -nodefaults \
>     -net nic -net user \
>     -chardev stdio,nosignal,id=serial \
>     -hda Fedora-Server-KVM-40-1.14.x86_64.qcow2 \
>     -cdrom /home/dhildenb/git/cloud-init/cloud-init.iso \
>     -device isa-serial,chardev=serial \
>     -chardev socket,id=monitor,path=/var/tmp/mon_src,server,nowait \
>     -mon chardev=monitor,mode=readline \
>     -device pcie-root-port,id=root,slot=0 \
>     -object memory-backend-file,share=on,mem-path=/dev/shm/vm,id=mem2,size=8G \
>     -device virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=16M,bus=root,dynamic-memslots=on,prealloc=on \
> 
> 
> Once the VM booted up, as expected we're consuming 16M
> 
> 
> $ stat /dev/shm/vm
>  Datei: /dev/shm/vm
>  Größe: 8589934592      Blöcke: 32768      EA Block: 4096   reguläre Datei
> Gerät: 0/25     Inode: 2087        Verknüpfungen: 1
> tmpfs                   tmpfs             16G   16M   16G   1% /dev/shm
> 
> 
> Let's start a migration:
> 
> $ echo "migrate exec:cat>state" | sudo nc -U /var/tmp/mon_src
> 
> 
> ... and we end up reading discarded memory:
> 
> $ LANG=C df -ahT  | grep /dev/shm
> tmpfs                   tmpfs             16G  8.0G  7.6G  52% /dev/shm
> 
> 
> 
> Running with TCG only also doesn't work. So somewhere, we have a bitmap filled with
> all 1s that is not cleared if we drop the first sync.

Hmm, I'm not yet sure why this happened, but indeed this reminds me that at
least vhost can have similar issue: when vhost devices are used, it has its
own bitmap so there it can keep having 1s in the unplugged regions when
reported the 1st time.

Is virtio-mem plug/unplug allowed during migration?  I'm wondering whether
below could happen while migration in progress:

  migration starts..
  bitmap init, disgard all unplugged mem in dirty bmap
  plug mem region X, dirty some pages
  unplug mem region X
  dirty sync, reports mem region X dirty (even though unplugged..)
  ...

So if unplugged mem should never be touched by qemu, then not sure whether
above can trigger this case too.

With/without above, I wonder if migration_bitmap_clear_discarded_pages()
shouldn't rely on the initial sync of dirty bitmap, instead it could be
done after each global sync: either another log_global_after_sync() hook,
or just move it over in migration_bitmap_sync().

Thanks,

-- 
Peter Xu


