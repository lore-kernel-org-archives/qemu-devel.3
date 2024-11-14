Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D48D6A254
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBiVo-0005Ma-4T; Thu, 14 Nov 2024 17:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBiVm-0005MC-52
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:40:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBiVk-0007md-8f
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731624022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dG90QAv3+Zc1JlaDfIXyyh81xv3rqztRu7UCVinwi+k=;
 b=JCvF3fsS3eOPiOCXIw38gSG9rJA9LjQBKxHeLZYRA7WYjeVoCt5B3xteKDtwr5S0wqQ45Y
 rC0UF66KuU6BgdyKskxT98Vvqu0MaIUTOMifyYJ5J93DOV0qstmuGSGi/BWUkpjRDawXoO
 HnlRS3Jo6nVedNyfpgUQS8OXycQ2418=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-yDeEBcXpOhiQWmFNbM8y_Q-1; Thu, 14 Nov 2024 17:40:20 -0500
X-MC-Unique: yDeEBcXpOhiQWmFNbM8y_Q-1
X-Mimecast-MFC-AGG-ID: yDeEBcXpOhiQWmFNbM8y_Q
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83dff8bc954so118947539f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731624020; x=1732228820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dG90QAv3+Zc1JlaDfIXyyh81xv3rqztRu7UCVinwi+k=;
 b=fMOH/847G9vlheEnBIPj/GZncO0NklRQ1JJZ6nR39OIDGPJ6I2qTesj8uOU/5O5S06
 2lOPcqynL73ewzkPeH4MBJeAvGbL/QNYFlLImEoYAfknioYOirj5P/pGbQQ537mtbD4R
 mwSqysjJ/bK5JJzygdjes8RnTd9i09fFeNwW8grjKco/Zndn7WKvUcRt8RMA/q6LUof4
 9pjLxOAUysiNvw2sL7g/LC43KZ/d9ixSE3Yc0YQVptZTRy2Td4CqC3mMETgRbA6qP07N
 9/eIddEdaZzqNcu21Gs63kIotLQP2aP2+O+/nnnPuOxyatIOw+Pd6XEg8yqs6fPG/+65
 B+Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCEIeAlnXucxaiLvM55lxhNtwEujvpXwge9GlYzDz8XgUYkJEC0fXg7FFSthGQ1vPdfCev+VMGqjMv@nongnu.org
X-Gm-Message-State: AOJu0YyqALbq+8/HoRvtWpDeVDNc9RT6ObU+BJ7FBq8W8TxuElsaFgEp
 haudLFbpnXq8lTnce1H9ik6dfBQp7iGYR0SNPRnOlqYtooFt9IQJIgyzaHVO6B+/+ziIHz2fjNQ
 aJWmzKTcYxKFPitX1fWfDPdG88VqAleFcEEtOn43u3KUjqzAr9HOn
X-Received: by 2002:a05:6e02:2193:b0:39f:53b3:ca63 with SMTP id
 e9e14a558f8ab-3a747ff8d4dmr5389015ab.3.1731624020068; 
 Thu, 14 Nov 2024 14:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo0+vhS56LF62r1l7becpsFYvH0Cn7TiYzGW3S/xzP3QYJLMtJo8dL+UanZSVEyPsopWDwqw==
X-Received: by 2002:a05:6e02:2193:b0:39f:53b3:ca63 with SMTP id
 e9e14a558f8ab-3a747ff8d4dmr5388855ab.3.1731624019693; 
 Thu, 14 Nov 2024 14:40:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a74806fc57sm514805ab.16.2024.11.14.14.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 14:40:18 -0800 (PST)
Date: Thu, 14 Nov 2024 17:40:15 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
Message-ID: <ZzZ8Tzw9WV9dHo_R@x1n>
References: <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
 <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com>
 <ZzTkopUrLGL5iqSv@x1n>
 <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com>
 <ZzUIOFPtvHKDJPei@x1n>
 <8ee7d398-0139-4628-9276-f6a89fa35245@redhat.com>
 <ZzZPd7Ye09bjUjyR@x1n>
 <5f04a1dc-ca0a-488b-812e-7cebf393f59f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f04a1dc-ca0a-488b-812e-7cebf393f59f@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
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

On Thu, Nov 14, 2024 at 10:16:41PM +0100, David Hildenbrand wrote:
> On 14.11.24 20:28, Peter Xu wrote:
> > On Thu, Nov 14, 2024 at 10:02:37AM +0100, David Hildenbrand wrote:
> > > On 13.11.24 21:12, Peter Xu wrote:
> > > > On Wed, Nov 13, 2024 at 07:49:44PM +0100, David Hildenbrand wrote:
> > > > > I think I had precisely that, and I recall you suggested to have it only
> > > > > after the initial sync. Would work for me, but I'd still like to understand
> > > > > why essentially none of the "discard" was effective -- all of guest RAM got
> > > > > touched.
> > > > 
> > > > Yes it'll be interesting to know..
> > > > 
> > > > One thing I'm wildly guessing is dirty_memory_extend(), so maybe after the
> > > > ramblock is created nobody yet to clear the "1"s there for each of the
> > > > client, including DIRTY_MEMORY_MIGRATION.  Then it'll be synced to ramblock
> > > > bmap only in the initial sync, once for each qemu lifecycle.
> > > 
> > > 
> > > In ram_block_add() we do the
> > > 
> > > cpu_physical_memory_set_dirty_range(new_block->offset,
> > > 				    new_block->used_length,
> > > 				    DIRTY_CLIENTS_ALL);
> > > 
> > > ramblock_dirty_bitmap_clear_discarded_pages()->...->migration_clear_memory_region_dirty_bitmap_range()->migration_clear_memory_region_dirty_bitmap()
> > > won't end up clearing the bits in the dirty bitmap.
> > > 
> > > First I thought because of:
> > > 
> > > if (!rb->clear_bmap || !clear_bmap_test_and_clear(rb, page)) {
> > >      return;
> > > }
> > > 
> > > But then I realized that even memory_region_clear_dirty_bitmap() will not
> > > clear the ramblock_dirty_bitmap_ bits! It's only concerned about
> > > listener->log_clear() calls.
> > > 
> > > Looking for DIRTY_MEMORY_BLOCK_SIZE users, only
> > > cpu_physical_memory_sync_dirty_bitmap() and
> > > cpu_physical_memory_clear_dirty_range() clear them, whereby the latter is
> > > only used when resizing RAMblocks.
> > > 
> > > At first I wondered whether ramblock_dirty_bitmap_clear_discarded_pages()
> > > should also call cpu_physical_memory_clear_dirty_range(), but then I am not
> > > so sure if that is really the right approach.
> > 
> > That sounds actually reasonable to me so far.. What's the concern in your
> > mind?
> 
> I think what I had in mind was that for the initial bitmap sync, when we set
> the bmap to all-1s already, we could just clear the whole
> ramblock_dirty_bitmap_ + KVM ... bitmaps.
> 
> So, instead of an "initial sync" we might just want to do an "initial
> clearing" of all bitmaps.

Logically most dirty tracking bitmaps should start with all zeros.  KVM old
kernels are like that; KVM_DIRTY_LOG_INITIALLY_SET is not, but it's a
separate feature.  I still hope it's pretty common for the rest, e.g. vhost
should have all zeros in its init bitmap even without initial sync.

> 
> > 
> > > 
> > > 
> > > virtio-balloon() calls qemu_guest_free_page_hint() which calls
> > > 
> > > migration_clear_memory_region_dirty_bitmap_range()
> > > bitmap_clear()
> > > 
> > > So it would maybe have the same issue.
> > 
> > Should virtio-balloon do the same?
> 
> virtio-balloon is more interesting, because I assume here we could run after
> the "initial clearing" and would want to mark it clean everywhere.

Yes, if it does what I mentioned below, IIUC it'll clear all dirty bits
across the whole stack.  Only the ram_list bitmap is missing.  IIUC it
could mean it could stop working for at least tcg, as tcg sololy uses
it.. even with kvm some MRs may use it.  Maybe we want to fix it
separately.

> 
> > 
> > So I suppose the idea here is some module may want to say "we should ignore
> > these pages in the dirty bitmap", and so far that's only about migration.
> > 
> > Then cpu_physical_memory_clear_dirty_range() does look like the right thing
> > to do, in which case the bmap in ram_list used to be overlooked.. it seems.
> > 
> > But of course, cpu_physical_memory_clear_dirty_range() still doesn't cover
> > the migration bitmap itself, which is ramblock->bmap.  So we'll need to
> > switch from migration_clear_memory_region_dirty_bitmap() to use things like
> > cpu_physical_memory_clear_dirty_range(), just to cover ram_list bitmaps.
> > Then keeping the rb->bmap operations like before..
> 
> For virtio-balloon likely yes. Regarding virtio-mem, maybe "initial
> clearing" + only modifying the rb->bmap when processing discards could work
> and would even be more efficient.
> 
> (but I'm confused because we have way too many bitmaps, and maybe the KVM
> one could be problematic without an initial sync ... we'd want an initial
> clearing for that as well ...)

So IMHO most of the bitmaps should be initialized with zeros, not
ones.. like I mentioned above.

Migration bitmap is special, because it's not about dirty tracking
capability / reporting but that we know we need to migrate the first round.
So setting all ones makes sense for migration only, not a reporting
facility.  While KVM_DIRTY_LOG_INITIALLY_SET existed for its own reasoning
on speeding up migration starts..

So, now I am thinking whether we should not set all ones in ram_list bitmap
at all, corresponds to this change:

===8<===
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..10966fa68c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1913,10 +1913,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     ram_list.version++;
     qemu_mutex_unlock_ramlist();
 
-    cpu_physical_memory_set_dirty_range(new_block->offset,
-                                        new_block->used_length,
-                                        DIRTY_CLIENTS_ALL);
-
     if (new_block->host) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
===8<===

I'm guessing whether above could fix the virtio-mem regression after
Hyman's current patch applied.

Said that, IMHO virtio-mem should still use the same helper just like
virtio-balloon as I discussed previously, so as to reset bitmap for the
whole stack (which seems to always be the right thing to do to not miss one
layer of them)?

Hence: 1 patch to virtio-balloon covering ram_list bitmap (which could be a
real fix to virtio-balloon on e.g. tcg?); 1 patch to virtio-mem reusing
that helper of virtio-balloon just as a cleanup to also cover all bitmaps;
1 patch like above to avoid setting ones at all in ram_list bitmap as
cleanup; then finally remove the sync() in SETUP, which is this patch.
IIUC after all these changes applied it'll work for all cases.

Thanks,

-- 
Peter Xu


