Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D98CD6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfWe-00086L-RP; Thu, 14 Nov 2024 14:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBfWc-00085s-Gt
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBfWa-0002Ke-TN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731612541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sp/xvwvR6XPsRu7j9cr6Bp6kgkyLJD+g6aLdS8MzeAc=;
 b=g+NniFt4zZRZGXWaSuJuA1fNMGg5SQk7Eu71aOf9wG4MGlk35MOZGvNrRkucyt4q+sWiY7
 k4dcOIYnBi6jUhxMLZIhmIkbiKyT80/5Uv6nLXmgcVIA7/60gmoRTlFPBHHFhxjvy6WvDn
 t86gu+1lZLExx+wbTVVy7HMiQCg8OuM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-g8eDPVigOH-gAskSNR_swA-1; Thu, 14 Nov 2024 14:28:59 -0500
X-MC-Unique: g8eDPVigOH-gAskSNR_swA-1
X-Mimecast-MFC-AGG-ID: g8eDPVigOH-gAskSNR_swA
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83abf68e7f0so93053939f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731612539; x=1732217339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sp/xvwvR6XPsRu7j9cr6Bp6kgkyLJD+g6aLdS8MzeAc=;
 b=UVgPYUGSVBZ8ydPMc0oz0TGhTMhKjX0beulDMPBhZ9d0E24T1bbwsciwwqnY9bGCVM
 9y6H39wV5VNcipf0oiJK06kxRYkh1ZocbruYTXWUpMoXeCLAAEgCBbw39UnIPpTGCag5
 V1rHzoMAdeROlBMajVmihqa3QTQ4fTPY083TMkzxr9sBUxZE1Vd89bE+y6Ckdfzs01qw
 pT77B0qredKw4JWwXlQ8MxLVPXT9fVoSnQzQjtawpLh0vrzSn27uJSeKw1rMB1SggCSo
 sYa1EgpOJWLjuVn/3zqToNRp6PcjMXEAamVCmFy1vPiBrw8jqVO7nYtA4KZn4jMng0uD
 +MiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5iHkpsPAtMp0QkEc877emkjkN0RNDFJvbXd29L1Rdw25jt82I2tXUkEuMj85iUVlCgd/QKCbB5IjQ@nongnu.org
X-Gm-Message-State: AOJu0YyqJJ2oWEz4vcsV75XdQYFb00N/cCorwNSLJDTY3mSb6fPgFZ91
 7beINKz6oyYxQOmGnWm9reNbWjHoYzhx/qJtMocPYccmR1IdgP3VZPG3E2Tk3dKgC3NhYLCssah
 u67Oy5IpO3hS3hj42Vsb1TIW7jn3sBxVOhcTQhbxoJJ5aBSySczPM
X-Received: by 2002:a05:6602:641e:b0:83d:e5e8:6fcd with SMTP id
 ca18e2360f4ac-83e6c32ed0cmr15766739f.15.1731612539023; 
 Thu, 14 Nov 2024 11:28:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHreNqu6clJLm0LlchHYG4w4/WSrr0pChpt19Jx9g2IDT+2qLIQxg5XLvqt2JxEoYGhM9P2cg==
X-Received: by 2002:a05:6602:641e:b0:83d:e5e8:6fcd with SMTP id
 ca18e2360f4ac-83e6c32ed0cmr15765239f.15.1731612538644; 
 Thu, 14 Nov 2024 11:28:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e60599965sm41095539f.21.2024.11.14.11.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 11:28:57 -0800 (PST)
Date: Thu, 14 Nov 2024 14:28:55 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
Message-ID: <ZzZPd7Ye09bjUjyR@x1n>
References: <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
 <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com>
 <ZzTkopUrLGL5iqSv@x1n>
 <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com>
 <ZzUIOFPtvHKDJPei@x1n>
 <8ee7d398-0139-4628-9276-f6a89fa35245@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ee7d398-0139-4628-9276-f6a89fa35245@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Nov 14, 2024 at 10:02:37AM +0100, David Hildenbrand wrote:
> On 13.11.24 21:12, Peter Xu wrote:
> > On Wed, Nov 13, 2024 at 07:49:44PM +0100, David Hildenbrand wrote:
> > > I think I had precisely that, and I recall you suggested to have it only
> > > after the initial sync. Would work for me, but I'd still like to understand
> > > why essentially none of the "discard" was effective -- all of guest RAM got
> > > touched.
> > 
> > Yes it'll be interesting to know..
> > 
> > One thing I'm wildly guessing is dirty_memory_extend(), so maybe after the
> > ramblock is created nobody yet to clear the "1"s there for each of the
> > client, including DIRTY_MEMORY_MIGRATION.  Then it'll be synced to ramblock
> > bmap only in the initial sync, once for each qemu lifecycle.
> 
> 
> In ram_block_add() we do the
> 
> cpu_physical_memory_set_dirty_range(new_block->offset,
> 				    new_block->used_length,
> 				    DIRTY_CLIENTS_ALL);
> 
> ramblock_dirty_bitmap_clear_discarded_pages()->...->migration_clear_memory_region_dirty_bitmap_range()->migration_clear_memory_region_dirty_bitmap()
> won't end up clearing the bits in the dirty bitmap.
> 
> First I thought because of:
> 
> if (!rb->clear_bmap || !clear_bmap_test_and_clear(rb, page)) {
>     return;
> }
> 
> But then I realized that even memory_region_clear_dirty_bitmap() will not
> clear the ramblock_dirty_bitmap_ bits! It's only concerned about
> listener->log_clear() calls.
> 
> Looking for DIRTY_MEMORY_BLOCK_SIZE users, only
> cpu_physical_memory_sync_dirty_bitmap() and
> cpu_physical_memory_clear_dirty_range() clear them, whereby the latter is
> only used when resizing RAMblocks.
> 
> At first I wondered whether ramblock_dirty_bitmap_clear_discarded_pages()
> should also call cpu_physical_memory_clear_dirty_range(), but then I am not
> so sure if that is really the right approach.

That sounds actually reasonable to me so far.. What's the concern in your
mind?

> 
> 
> virtio-balloon() calls qemu_guest_free_page_hint() which calls
> 
> migration_clear_memory_region_dirty_bitmap_range()
> bitmap_clear()
> 
> So it would maybe have the same issue.

Should virtio-balloon do the same?

So I suppose the idea here is some module may want to say "we should ignore
these pages in the dirty bitmap", and so far that's only about migration.

Then cpu_physical_memory_clear_dirty_range() does look like the right thing
to do, in which case the bmap in ram_list used to be overlooked.. it seems.

But of course, cpu_physical_memory_clear_dirty_range() still doesn't cover
the migration bitmap itself, which is ramblock->bmap.  So we'll need to
switch from migration_clear_memory_region_dirty_bitmap() to use things like
cpu_physical_memory_clear_dirty_range(), just to cover ram_list bitmaps.
Then keeping the rb->bmap operations like before..

-- 
Peter Xu


