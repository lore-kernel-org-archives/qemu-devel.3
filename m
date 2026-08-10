Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDEDC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtS7R-0002fm-1N; Mon, 10 Aug 2026 11:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtS7O-0002fZ-9f
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtS7L-000678-OT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786376446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9hcGwP/37a/aK8SF3RwhtVxcTHn2tTifryGPKesXa8=;
 b=QNbGaHrh1fnvm1hb54aJP6JbHBNF3MBz8RgllHx5E0l6ZsBeJltZt/TtcOT24Du+svopgv
 Rm6qE6kwZQfZPbQ9i8piUS2mcktyw9CfBrMzal5vkY09eMDCaIG/JcQGlrkjqeydw5mr+G
 xSpPMXN+0WB6IUFAS7M96h+BcpRq7bM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-QbYZq2q2NAimevPyc0__Iw-1; Mon, 10 Aug 2026 11:40:39 -0400
X-MC-Unique: QbYZq2q2NAimevPyc0__Iw-1
X-Mimecast-MFC-AGG-ID: QbYZq2q2NAimevPyc0__Iw_1786376439
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso25656861cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786376439; x=1786981239; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W9hcGwP/37a/aK8SF3RwhtVxcTHn2tTifryGPKesXa8=;
 b=a6Zj9JhKVwrZ1xEUrCU3n6bNJ09Chl1ZBqzcV8+wbHEgQSVqGVvgkhJOTNezQD/tW+
 u+wBc7SBMy3KvMaW81s5fEgk8Ad0M23wLjlVHGvnb/7hiq4Q7izmNybI3348gtBZFtQ9
 13cpzidOMIBF2t42caP/zEywUyeDX0AWQfdq1O9ZJQYnBKgDgiGaDG6Me4H7T4vFz1Jt
 6A7RnFOMAs3U5SOd6/2bPaDjlBrWKvVvm39BvMQNJLZh46etijdv1AN9QYCB90osjBN7
 VvjsFDD2X8MoHxR6wX5pcxDHxMX1S9ebrYiPkiIkZchXzzNhjNakP4ZrfPhIiG7cku8K
 1YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376439; x=1786981239;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W9hcGwP/37a/aK8SF3RwhtVxcTHn2tTifryGPKesXa8=;
 b=m24kbc1Sy2E8uQtRO6ZEjuIMhuxnc6hrn50dThoWTEfCV3aIL0zUTFoOz2hPd00aGc
 R1WMpXfI0aGxmg76JthkHJNRUa9NRoQTHIUMFknAt8o+YCO66rl9bT7h9lS39qzcc41i
 8Orkh6MvleTw04qnnwzVQQ3lGUsTZLcCnPuvuYAURVkpGyUk3lUVofkBVlrtolQIMXkg
 W0riDR60qt6tj+7SNQuaIPjHKqw/ZZ7noNSf5iI/llEuXhxyLJuiWjaKX7sT4tMutM+Q
 046zylq5A/T5Jgp1nZkGNybQs2tLusf04xrctjajaa6GfDRBP08pG2ntf2wOWtnwVeRP
 dEaQ==
X-Gm-Message-State: AOJu0YxCWHMkbYmTv5PRHqv4icbYkMqP1hA8neEb7l4NLvHVnZPKEQYA
 +Vd+Av/GJJaU79UytTNIXZH3fqeUJ43TCwGLCv2pDmFtNWnpUv6zPRP2AJAhXjQo3FyRmZI2Krz
 nUeHkqFXIBOj+bEpRuD/PM5/c6JRGzM5vyfg+u9ShmMT+cGzZCNqY804l
X-Gm-Gg: AR+sD103kCp1npgX5fxcWrc/XDxmvH/Uu1YePyPznuDM6JNajcBqdTz7681Fp4Ulk3O
 /JbkPlrdKRaShYoXrrHBi75OZrokuX4VE+q/DkBz9xKo4u27zjT73nrcR06L7XjGnfRlfyqi+CJ
 hO4Aw53fOQ/qwoj6juFS5ui7jcmXKM0f/2CsZcyd/wGpW5T76VHGn7sHB9VINknLMXAT0zt5jNs
 Vq59I+OCJuW7HGsEitVEJsUUBbcTXpMHseA6sZZ5UtxDjTn5YgMtIS1+LiBevFYuRWSe8nGg1um
 meqQd/LYnyolw/RwOZwi1mw0AkzD4QSV133gVeTX5Ap8tpifr+Np2dCgqsrtpXmR6nvz
X-Received: by 2002:ac8:5854:0:b0:51b:f40b:2fb5 with SMTP id
 d75a77b69052e-52d4bf50928mr29698641cf.17.1786376438446; 
 Mon, 10 Aug 2026 08:40:38 -0700 (PDT)
X-Received: by 2002:ac8:5854:0:b0:51b:f40b:2fb5 with SMTP id
 d75a77b69052e-52d4bf50928mr29697791cf.17.1786376437794; 
 Mon, 10 Aug 2026 08:40:37 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d165fc55fsm73751431cf.25.2026.08.10.08.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:40:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:40:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 07/11] migration: add support for fault thread to load
 pages from disk
Message-ID: <annw8X51cEa6yvdp@x1.local>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-8-aadeshveer07@gmail.com>
 <CA++cPvLsRpqcqhPg4fY_uhnZqeET0OpdxDDM1i4_rGFuR_4Hag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++cPvLsRpqcqhPg4fY_uhnZqeET0OpdxDDM1i4_rGFuR_4Hag@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Aadeshveer,

Thanks for looking into this problem.  Below solution should work in
general, but there's still one problem..

On Sat, Aug 08, 2026 at 10:04:48AM +0530, Aadeshveer Singh wrote:
> A subtle concurrency bug exists in the current patch; this small patch
> should fix it.
> 
> Current patch uses bitmap_test_and_clear_atomic assuming it performs
> an atomic operation over a range, which as pointer out by Peter is not
> the case. It performs atomic word by word operations making the
> overall operation unsafe.
> Therefore, keeping the same bitmap would require protection by a mutex
> lock which might not be as efficient. Hence this small patch resizes
> the pending_bmap to have exactly one bit per load operation(loading
> the larger of host page and guest page).
> 
> Thank you,
> Aadeshveer Singh
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index e01ac628f5..0bf0f837ad 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1031,9 +1031,13 @@ static bool
> postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
>      host_page = rb_offset / qemu_ram_pagesize(rb);
>      page = rb_offset >> qemu_target_page_bits();
> 
> -    if (bitmap_test_and_clear_atomic(
> -            rb->pending_bmap, host_page,
> -            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))) {
> +    /*
> +     * pending_bmap needs the index of host or guest page based on which is
> +     * larger. As page index is inversely proportional to page size we use the
> +     * minimum of both.
> +     */
> +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, MIN(host_page, page),
> +                                     1)) {
>          if (find_next_bit(rb->file_bmap, page + guest_pages_to_load, page) ==
>              page + guest_pages_to_load) {
>              /* It is efficient to use UFFDIO_ZERO if all pages are zero */

Consider the case where guest psize > host psize, here the current code
will invoke postcopy_place_page_zero() or postcopy_place_page() only once
for each guest page. But IIUC that's not enough: we'll need to loop over
the few host pages that is covered by the same guest page.

I confess this is really a rare corner case..  so you can decide how to
"fix" it.  There's always the option to disable this feature for now when
guest psize is larger than host psize (OTOH, host psize > guest psize is
much more common, because that's normally how huge page backed VMs work on
linux systems).

Or just provide the loops over host pages, I think it will start working
and IIUC it's indeed the most efficient.  But then, to make it slightly
easier to future readers (I still think the bitmap definition will be
slightly hard to grasp for future readers.. your comments all over
hopefully will help), maybe we can also rename "page"; it implies guest
page index but it's not obvious.  We can make it "guest_page" to match
"host_page".  The "haddr" seems fine.

When preparing the new version, let's also split this diff into
corresponding patches.

Thanks,

> diff --git a/migration/ram.c b/migration/ram.c
> index 734fd90e12..52a3af9245 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -269,7 +269,14 @@ static void ramblock_pending_bmap_init(void)
> 
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          assert(!rb->pending_bmap);
> -        size_t size = rb->max_length / qemu_ram_pagesize(rb);
> +        /*
> +         * The pending_bmap granularity must match the maximum of
> host and guest
> +         * page sizes. This ensures that every load operation checks for one
> +         * bit, allowing lockless thread coordination via a single-bit atomic
> +         * test-and-clear.
> +         */
> +        size_t size = rb->max_length /
> +                      MAX(qemu_ram_pagesize(rb), qemu_target_page_size());
>          rb->pending_bmap = bitmap_new(size);
>          bitmap_set(rb->pending_bmap, 0, size);
>      }
> 
> On Sat, Aug 1, 2026 at 8:07 AM Aadeshveer Singh <aadeshveer07@gmail.com> wrote:
> >
> > In fast snapshot load, we would like to serve faults as soon as possible
> > hence loading pages directly instead of requesting a source
> >
> > Add postcopy_mapped_ram_load_page() function which serves single page
> > fault. It uses bitmap_test_and_clear_atomic() on pending_bmap to prevent
> > multiple threads from loading same page. It loads a page or pages
> > depending on size of guest pages and host pages, loading exactly the
> > larger of two. If the entire page is zero postcopy_place_page_zero() is
> > used for efficiency and in case some part is non zero it is part by part
> > loaded on loop using new function postcopy_mapped_ram_load_guest_page()
> > which loads a single guest page in a buffer which is then placed using
> > postcopy_place_page(). This covers all possible cases for various page
> > sizes of host and guest.
> >
> > Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> > instead of requesting source in case of fast snapshot load. to_src_file
> > check is bypassed in fast snapshot load case as there is no source.
> >
> > Call try_mark_postcopy_blocktime_begin on every page fault to support
> > postcopy-blocktime.
> >
> > Allocate another channel in postcopy_temp_pages_setup(like the preempt
> > case), for both the fault thread and eager thread to load pages
> > independently.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/postcopy-ram.c | 174 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 157 insertions(+), 17 deletions(-)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 2e2c9fae10..1da9c4309b 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -949,6 +949,121 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
> >                         pagesize);
> >  }
> >
> > +/*
> > + * Load a single guest page from source file into the buffer.
> > + * NOTE: This is not an atomic operation and should not be used to directly load
> > + * pages on page faults in postcopy. It is meant to fill in buffer that can then
> > + * be copied into the faulting location using UFFDIO_COPY.
> > + */
> > +static bool postcopy_mapped_ram_load_guest_page(MigrationIncomingState *mis,
> > +                                                RAMBlock *rb,
> > +                                                ram_addr_t rb_offset, void *buf,
> > +                                                Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    size_t page = rb_offset / qemu_target_page_size();
> > +    size_t read;
> > +
> > +    if (test_bit(page, rb->file_bmap)) {
> > +        /*
> > +         * This can happen concurrently, but it's thread-safe because
> > +         * qemu_get_buffer_at() is thread-safe, and the caller will be using
> > +         * different temporary buffers.
> > +         */
> > +        read =
> > +            qemu_get_buffer_at(mis->from_src_file, buf, qemu_target_page_size(),
> > +                               rb->pages_offset + rb_offset, errp);
> > +
> > +        if (read != qemu_target_page_size()) {
> > +            error_prepend(errp,
> > +                          "Could not read page %zu from RAM Block %s: ", page,
> > +                          rb->idstr);
> > +            return false;
> > +        }
> > +    } else {
> > +        memset(buf, '\0', qemu_target_page_size());
> > +    }
> > +    return true;
> > +}
> > +
> > +/**
> > + * postcopy_mapped_ram_load_page() - Load pages required to access host address.
> > + * @mis: Migration Incoming State.
> > + * @rb: RAMBlock from where page is loaded.
> > + * @rb_offset: Offset of target page in RAMBlock.
> > + * @haddr: Base of target page where to load in page.
> > + * @channel: Used to identify between threads and use corresponding temp.
> > + * @errp: Set error in case of failure
> > + *
> > + * Load page(s) from RAMBlock covering the faulting address. We might need to
> > + * load multiple pages in the case when host page size is greater than guest
> > + * page size. As userfaultfd works on granularity of host pages, we might need
> > + * to load guest pages in single operation.
> > + *
> > + * Return: True on success.
> > + */
> > +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> > +                                          RAMBlock *rb, ram_addr_t rb_offset,
> > +                                          uint64_t haddr, int channel,
> > +                                          Error **errp)
> > +{
> > +    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
> > +    char *buffer_ptr = (char *)place_source;
> > +    size_t guest_pages_to_load =
> > +        MAX(1, qemu_ram_pagesize(rb) / qemu_target_page_size());
> > +    size_t host_page;
> > +    size_t page;
> > +
> > +    /*
> > +     * If guest page size is greater than host page size uffd needs to load one
> > +     * guest page and multiple host pages, hence the offsets need to aligned
> > +     * with guest pages (which is automatically aligned with host pages). In the
> > +     * same case we need to check range of bits on pending_bmap(bit per host
> > +     * page) to decide whether all the page have been loaded
> > +     */
> > +    rb_offset = ROUND_DOWN(rb_offset, qemu_target_page_size());
> > +    haddr = ROUND_DOWN(haddr, qemu_target_page_size());
> > +    host_page = rb_offset / qemu_ram_pagesize(rb);
> > +    page = rb_offset >> qemu_target_page_bits();
> > +
> > +    if (bitmap_test_and_clear_atomic(
> > +            rb->pending_bmap, host_page,
> > +            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))) {
> > +        if (find_next_bit(rb->file_bmap, page + guest_pages_to_load, page) ==
> > +            page + guest_pages_to_load) {
> > +            /* It is efficient to use UFFDIO_ZERO if all pages are zero */
> > +            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
> > +                error_setg(errp,
> > +                           "Failed to place zero page %zu from RAM Block %s at "
> > +                           "address %" PRIu64,
> > +                           page, rb->idstr, haddr);
> > +                return false;
> > +            }
> > +        } else {
> > +            size_t load_size = guest_pages_to_load * qemu_target_page_size();
> > +            size_t offset;
> > +
> > +            for (offset = 0; offset < load_size;
> > +                 offset += qemu_target_page_size()) {
> > +                if (!postcopy_mapped_ram_load_guest_page(
> > +                        mis, rb, rb_offset + offset, buffer_ptr + offset,
> > +                        errp)) {
> > +                    return false;
> > +                }
> > +            }
> > +
> > +            if (postcopy_place_page(mis, (void *)haddr, place_source, rb)) {
> > +                error_setg(errp,
> > +                           "Failed to place page %zu from RAM Block %s at "
> > +                           "address %" PRIu64,
> > +                           page, rb->idstr, haddr);
> > +                return false;
> > +            }
> > +        }
> > +    }
> > +    return true;
> > +}
> > +
> >  /*
> >   * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
> >   * also optional: when zero is provided, the fault accounting will be ignored.
> > @@ -1310,6 +1425,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >      int ret;
> >      size_t index;
> >      RAMBlock *rb = NULL;
> > +    Error *local_err = NULL;
> >
> >      trace_postcopy_ram_fault_thread_entry();
> >      rcu_register_thread();
> > @@ -1351,11 +1467,13 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >              break;
> >          }
> >
> > -        if (!mis->to_src_file) {
> > +        if (!migrate_mapped_ram() && !mis->to_src_file) {
> >              /*
> > -             * Possibly someone tells us that the return path is
> > -             * broken already using the event. We should hold until
> > -             * the channel is rebuilt.
> > +             * Possibly someone tells us that the return path is broken already
> > +             * using the event. We should hold until the channel is rebuilt.
> > +             * Fast snapshot load doesn't support pause and recover, because
> > +             * it's not necessary: we can fail right away when QEMU just booted
> > +             * with nothing to lose.
> >               */
> >              postcopy_pause_fault_thread(mis);
> >          }
> > @@ -1418,18 +1536,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >                                                  qemu_ram_get_idstr(rb),
> >                                                  rb_offset,
> >                                                  msg.arg.pagefault.feat.ptid);
> > +
> > +            if (migrate_mapped_ram()) {
> > +                /* Load page directly in case of fast snapshot load */
> > +
> > +                uintptr_t aligned = (uintptr_t)ROUND_DOWN(
> > +                    msg.arg.pagefault.address, qemu_ram_pagesize(rb));
> > +
> > +                if (try_mark_postcopy_blocktime_begin(
> > +                        mis, rb, rb_offset, (uintptr_t)aligned,
> > +                        msg.arg.pagefault.feat.ptid)) {
> > +                    if (!postcopy_mapped_ram_load_page(
> > +                            mis, rb, rb_offset, aligned, RAM_CHANNEL_POSTCOPY,
> > +                            &local_err)) {
> > +                        error_report_err(local_err);
> > +                        break;
> > +                    }
> > +                }
> > +            } else {
> >  retry:
> > -            /*
> > -             * Send the request to the source - we want to request one
> > -             * of our host page sizes (which is >= TPS)
> > -             */
> > -            ret = postcopy_request_page(mis, rb, rb_offset,
> > -                                        msg.arg.pagefault.address,
> > -                                        msg.arg.pagefault.feat.ptid);
> > -            if (ret) {
> > -                /* May be network failure, try to wait for recovery */
> > -                postcopy_pause_fault_thread(mis);
> > -                goto retry;
> > +                /*
> > +                 * Send the request to the source - we want to request one
> > +                 * of our host page sizes (which is >= TPS)
> > +                 */
> > +                ret = postcopy_request_page(mis, rb, rb_offset,
> > +                                            msg.arg.pagefault.address,
> > +                                            msg.arg.pagefault.feat.ptid);
> > +                if (ret) {
> > +                    /* May be network failure, try to wait for recovery */
> > +                    postcopy_pause_fault_thread(mis);
> > +                    goto retry;
> > +                }
> >              }
> >          }
> >
> > @@ -1501,8 +1638,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
> >      unsigned i, channels;
> >      void *temp_page;
> >
> > -    if (migrate_postcopy_preempt()) {
> > -        /* If preemption enabled, need extra channel for urgent requests */
> > +    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
> > +        /*
> > +         * If preemption enabled or it is fast snapshot load, need extra channel
> > +         * for urgent requests/faults
> > +         */
> >          mis->postcopy_channels = RAM_CHANNEL_MAX;
> >      } else {
> >          /* Both precopy/postcopy on the same channel */
> > --
> > 2.55.0
> >
> 

-- 
Peter Xu


