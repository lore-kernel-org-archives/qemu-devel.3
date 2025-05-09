Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B889EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPNu-00045U-PI; Fri, 09 May 2025 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPNr-00045J-TT
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPNo-00056Q-QY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746803487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZulmzDKQXwZ7ueqTXftlQWjvyzit8KwDILw9vIY+coc=;
 b=FKAZso430O51LIpTscj2mCM25xvnq5+E4n5rsnstq0arMy9FqbPlOJ16CHivK4aR28yrVg
 Lb/O9bOiNpd/vTTZ9g/eb8KI8pisYX9iM2Dy3Q/kt2pVOeFW+IlhEHwyNOYVQonSs7ynqM
 wy1sM/mbApxk0VZ5H0mTyNNrDyJXr1U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-A1-5Q18LN5Ow6pQ_WW6omQ-1; Fri, 09 May 2025 11:11:26 -0400
X-MC-Unique: A1-5Q18LN5Ow6pQ_WW6omQ-1
X-Mimecast-MFC-AGG-ID: A1-5Q18LN5Ow6pQ_WW6omQ_1746803485
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f5462cdfb2so43411106d6.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746803485; x=1747408285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZulmzDKQXwZ7ueqTXftlQWjvyzit8KwDILw9vIY+coc=;
 b=lL2Bv7jFpKuANjT6a5haw5w6ExGXpdd8dwjg2w/Rz81Od8/Aycw2IeIQk9Jiinl/6K
 Ru0t6iiur9QZ0mRyqf9E2VFstsmoaojioryoYGMtqcJXd2C0i8E7Q9uovyZlAXyYoqgC
 N4/0B3p322DFGMxWikuUU787ysZtnpvVSEsbZoQFvH7eG+K6qhiPbtiJytJMcj1KDt/f
 co5A37aZYh2zowGyA7Y4+cQ17alw9uytt2btydyQxEl+uNM6sfUftx9GbK6IMyb81nwe
 o5DJBFvqNXQdl7vz/N0c2IimYgkxIYTj6rbJk/E3ohRvBQGKoet0qUaI00D2CERts9eL
 S1Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhDyH84FNHlk3AlqeAdM9uuOhJIDuYs8iUHsvD+iZFpJbS2FoUdCN1ATrGuhD2UC4rX1+8g5YCUkpT@nongnu.org
X-Gm-Message-State: AOJu0YwJKUoHHrHYlEknbXjHQGAve/9929mWJZMzv8ywU5OFKskrBbnq
 P2Xeg/e+/4Z99jX17c24fYaboewohbEyq6PJ2Tk4FlqJAn3Z4DEniRjgLiSN5gBH0rBsOWuSWjE
 ap27iwhhgu0JtTbs3d275Nlc/Jaa1aqy/BQVQsUpoNLZuKTlYPePI
X-Gm-Gg: ASbGncuR+wOUnUdniKCW+UnC6Vk5G63jSUvfnilYODzGAfXGQf+4xP4sGn7A67wbXnE
 Mr76Oi9bZko9w63YxP9xwv5HfRh4YfRa6ABIyTtXHJzgu1OcGbMGEJE9Gr9sWh7JEsIOIPCRTKu
 dGOFzJKoYU2evPZjthRjr0UX360Mzi2VIttA4dU4JNv9dNDqXCRrhCcNuyYySc1ctOt0+84bbDp
 0qkogbd76p0lK48khZ81PSsSfh97OQdWcVwizzvZ/rj5j39CLc0Gc7AGAGfavr/bt+U/m5QKvDR
 Wm4=
X-Received: by 2002:ad4:5fca:0:b0:6d8:a8e1:b57b with SMTP id
 6a1803df08f44-6f6e4814d2dmr61257326d6.36.1746803485230; 
 Fri, 09 May 2025 08:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEihM+ZDmQGo4Qvj3eqQcYQW5WdYum8gS6+0jya5ULv6M6qMLaLfgI1pFGe5k17zBn1tV/GxA==
X-Received: by 2002:ad4:5fca:0:b0:6d8:a8e1:b57b with SMTP id
 6a1803df08f44-6f6e4814d2dmr61256416d6.36.1746803484434; 
 Fri, 09 May 2025 08:11:24 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a472b3sm14716736d6.77.2025.05.09.08.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:11:24 -0700 (PDT)
Date: Fri, 9 May 2025 11:11:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v10 3/3] migration: write zero pages when postcopy enabled
Message-ID: <aB4bGYf-EuGES73h@x1.local>
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-4-ppandit@redhat.com>
 <87ecwzfbnk.fsf@suse.de> <aBzQYslYtUZgXjgO@x1.local>
 <CAE8KmOzi8Zzy5hE2SMdTbMZJQD5_XH34rfEP_B85jstUF9E08g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzi8Zzy5hE2SMdTbMZJQD5_XH34rfEP_B85jstUF9E08g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 09, 2025 at 11:34:06AM +0530, Prasad Pandit wrote:
> > > This patch should come before 1/3, otherwise it'll break bisect.
> > We could squash the two together, IMHO.
> 
> * It is adjusting the specific optimisation behaviour for the use case
> of when Multifd and Postcopy are enabled together. I think it's better
> as a separate patch. It'll help to see how that optimization
> changed/evolved over time.

I'd say it'll not help me.. no more than if you squash it with the first.
Both of them are tiny patches, and one should never apply this one alone.
I can just find no good reason to keep this single change separate.

But it's fine to me - you can keep it separate if you prefer, as long as
reorderd.

> 
> > > s/ones/once/
> > >
> > > > +         *
> > > > +         * It becomes a problem when both Multifd & Postcopy options are
> > > > +         * enabled. If the zero page which was skipped during multifd phase,
> > > > +         * is accessed during the Postcopy phase of the migration, a page
> > > > +         * fault occurs. But this page fault is not served because the
> > > > +         * 'receivedmap' says the zero page is already received. Thus the
> > > > +         * migration hangs.
> >
> > More accurate version could be: "the thread accessing the page may hang".
> > As discussed previously, in most cases IIUC it won't hang migration when
> > accessed in vcpu contexts, and will move again when all pages migrated
> > (triggers uffd unregistrations).
> 
> * Okay.
> 
> > Meanwhile when at it.. for postcopy if we want we don't need to set all
> > zeros.. just fault it in either using one inst.  Summary:
> >
> > void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> > {
> >     bool received;
> >
> >     for (int i = 0; i < p->zero_num; i++) {
> >         void *page = p->host + p->zero[i];
> >
> >         received = ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i]);
> >         if (!received) {
> >             ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
> >         }
> 
> * Okay.
> 
> >         if (received) {
> >             /* If it has an older version, we must clear the whole page */
> >             memset(page, 0, multifd_ram_page_size());
> >         } else if (migrate_postcopy_ram()) {
> >             /*
> >              * If postcopy is enabled, we must fault in the page because
> >              * XXX (please fill in..).  Here we don't necessarily need to
> >              * zero the whole page because we know it must be pre-filled
> >              * with zeros anyway.
> >              */
> >             *(uint8_t *)page = 0;
> >
> > We could also use MADV_POPULATE_WRITE but not sure which one is faster, and
> > this might still be easier to follow anyway..
> 
> * Not sure how this is to work; During Multifd phase (Postcopy not
> running), when migrate_postcopy_ram() returns true, we shall raise a
> page fault here?

Yes, it's already received==0 reaching here, the page must be zero.  A
fault-in should be enough.

Well.. after a second thought, maybe better memset().. I need to double
check if "migration didn't receive this page" always means it's empty.  I
worry we have other part of code pre-loads the chunk.  So better not do
this trivial trick until some of us is sure..

My apologies of the confusion, please keep the good part of my comments,
and stick with memset().  Please ignore the fault inst and madvise for now.

> 
> * Could we zero-initialise the destination guest memory when migration
> starts? And not migrate the zero pages from the source at all? ie. we
> mark the page received in the 'receivedmap' as is done now, but page
> fault should also not happen for that guest address, because the
> memory was already zero-initialised at the beginning. I think there
> might be some scope to send zero-page entries piggy-backed with
> non-zero pages, whose contents are migrated anyway.
> 
> * Say there are 10 pages (4KB each, Total: 40KB). Of these 10 pages:
> 
>         Non-zero pages: 1, 2, 4, 7, 9, 10
>                Zero Pages: 3, 5-6 and 8
> 
> * We only migrate/send non-zero pages from source to the destination.
> When non-zero page-4 is migrated, an entry/hint of page-3 being zero
> one is piggy-backed with it. When non-zero page-7 is sent an
> entry/hint of pages-5-6 being zero pages is sent with it. Similarly a
> hint of page-8 being zero page is sent along with page-9. (thinking
> aloud)

Isn't that what multifd is doing already?

typedef struct {
    ...
    /*
     * This array contains the pointers to:
     *  - normal pages (initial normal_pages entries)
     *  - zero pages (following zero_pages entries)
     */
    uint64_t offset[];
} __attribute__((packed)) MultiFDPacket_t;

Or maybe I missed what you meant.

Thanks,

-- 
Peter Xu


