Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42450C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgq2u-000691-B6; Mon, 06 Jul 2026 16:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgq2s-00062Z-LA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgq2q-0002ME-Gc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783370158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/e1k4vcry+BiCc1qvIDQSQP6/GcJ5oKM1W7IvvGS5A=;
 b=LanuWpts2BGfBBH3s6JXVABpiCSj1A4xLBlo3MFsCQCPNYotWwDi2JAaujJVkx+Hv80wSl
 mUzxdr7ip7WyVXqwgd62j/xA1oRHKMljvQ5UxYH96GxaEIYiJHXJgr0JyTcFy9xh7yNxsi
 0yuSHFWRpsc/59dwzmILOxYdVWaCipQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-sAd9tyPdMXy1QEcTYvRKuw-1; Mon, 06 Jul 2026 16:35:57 -0400
X-MC-Unique: sAd9tyPdMXy1QEcTYvRKuw-1
X-Mimecast-MFC-AGG-ID: sAd9tyPdMXy1QEcTYvRKuw_1783370156
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e632390d2so629634185a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783370156; x=1783974956; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3/e1k4vcry+BiCc1qvIDQSQP6/GcJ5oKM1W7IvvGS5A=;
 b=aI/NzcAvNURrFzuCNT1lJqaORdZj1qnmEXydN/srD2C1Ud7ahS1zIrDoeAfh6+TO2Q
 GGQzkBX0VrwXN+fxN4uZU6+kCBTmnThEcObRqzei7G1eVmwdbBRSmekRsH3uHHmBK3qX
 ayAHCdsBudobVTINYRD+rHkq+GNuMAIbfMteVmPXxPmq5jZFU2mU0D10TjajR+/rT/1F
 VDtG3Kp1aXvBODZIl7il22m7fJxL/NSEjN3HqcD6OEoO/7uaqpw69VL1Yc1s2CZNEKXt
 Ss99nKzeTTN0QqmFzb1b3jftb4ETsLIOmnEeSm4YazjA7GN+2PVR1/P7H+BjN6oI48Rh
 JnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783370156; x=1783974956;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3/e1k4vcry+BiCc1qvIDQSQP6/GcJ5oKM1W7IvvGS5A=;
 b=L9icr/Wb6M4VRmXP6esIJjMjAVEpWk6CDD/Nhhg+benwOhdxuxNRWabZe0MXWzj7pJ
 EwmniASEiMjkSy+SKBgklAZ+Jc2OZVFZ5shI+KStCCe62kOJ4pR1yc8cCjxvJrITETYU
 Rwu2fWZYFPZd3np7j8xxKk2v6Bft02mncuHE5StgR891PRdTWcpw1U8dyUlWet7i/a/q
 H0OAguh5NN4KVnhducZepaHQYv8hmeRu6KUAgYVvkdHD3e1q91BmJUJaktoOswTd6Rek
 UqyiifNJrTwNadF1s0bp9xnYKRsD3KhHWsFRTiYd9Ig7a8jeV7kXuL13idut68AyX+Oi
 5ipg==
X-Gm-Message-State: AOJu0YyCywTeqqnQG4yc7FCXmbxvWOTIyIc7LMrbygRKPhmzH5bQ6aLJ
 K3EvnHqn+W4zSEA+gq5ay++jD6u87QXeP8wVXiEWY0ishMPHRdz6GJKUbmUgeDHtT+dlGLMaQKd
 IzOzzUBtw+aTDysbaDgUy4rUAqtEkiTmQE+jKTNYEr0dJUPmu4UJKzVrS
X-Gm-Gg: AfdE7ckJOoO7dZzbrF/lZJDF8fs/DUBdmLFmlwaELSvzckbzsLBuOxQsLzB+rptsXdq
 OKoIbUQRn7QFqPNEN7MaMwKN5yF58WfM/fcdxNNj21zm5WsYjQM2nkE07mMeKMtLGyaO4zjMfrv
 kNXwmRxD4HY8mM6nk/oAkZN0tBJK/pMt2KD7CL+CFmw08tiTEUhK+MG56K8oap9r6q9PJeNbVP6
 sJngl2CsdJ5m6q3LfF/4YwyawCI6DURkUvad9eaWiLlhBfALb/ufNKVGLpiYWbkqmwS9Uo/DfIl
 iRnReCO2nObsDzvDvsR6AueOm5u3fECf/+TeMri6jVjtvGYLmbKh5TBKiPTRqEyxtD+OOGgjUKO
 KmmWftBzvUrzjSYmUzWg6t6y13U6Gv5J9MQv+NVJmk1maKruGS8mCkk4YC75crODB50N69A==
X-Received: by 2002:a05:620a:4041:b0:915:cb40:f774 with SMTP id
 af79cd13be357-92ebb57f369mr292560585a.31.1783370156102; 
 Mon, 06 Jul 2026 13:35:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4041:b0:915:cb40:f774 with SMTP id
 af79cd13be357-92ebb57f369mr292555385a.31.1783370155380; 
 Mon, 06 Jul 2026 13:35:55 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4718141e6sm144943416d6.24.2026.07.06.13.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 13:35:54 -0700 (PDT)
Date: Mon, 6 Jul 2026 16:35:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 6/7] migration: add support for fault thread to
 load pages from disk
Message-ID: <akwRqYY3vfzafZ_X@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-7-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-7-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

On Tue, Jun 30, 2026 at 01:49:39PM +0530, Aadeshveer Singh wrote:
> In fast snapshot load, we would like to serve faults as soon as possible
> hence loading pages directly instead of requesting a source
> 
> Add postcopy_mapped_ram_load_page() function which serves single page
> fault by reading the snapshot file. It uses bitmap_test_and_clear_atomic
> on pending_bmap to coordinate between threads so each page is loaded
> exactly once. Non-zero pages are read using qemu_get_buffer_at into a
> temporary page (for loading page atomically), which is then placed using
> postcopy_place_page. Zero pages are placed directly using
> postcopy_place_page_zero.
> 
> Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> instead of requesting source in case of fast snapshot load. to_src_file
> check is bypassed in fast snapshot load case as there is no source.
> 
> Add postcopy-blocktime support by calling mark_postcopy_blocktime_begin
> on every fault. We need to aqcuire the page_request_mutex lock and check
> the recv bitmap to make sure we prevent a race condition when a fault
> occurs but before the fault thread can mark the page for tracking the
> eager thread loads in the page making us fail the assert for recv bitmap
> being clear while marking in mark_postcopy_blocktime_begin().
> 
> Allocate another channel in postcopy_temp_pages_setup(like the preempt
> case), for both the fault thread and eager thread to load pages
> independently.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/postcopy-ram.c | 121 +++++++++++++++++++++++++++++++++------
>  1 file changed, 104 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 96a65aa976..be9edac572 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -949,6 +949,68 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                         pagesize);
>  }
>  
> +/**
> + * postcopy_mapped_ram_load_page() - Load a page to given host address.
> + * @mis: Migration Incoming State.
> + * @rb: RAMBlock from where page is loaded.
> + * @rb_offset: Offset of page in RAMBlock.
> + * @haddr: Base of page where to load in page.
> + * @channel: Used to identify between threads and use corresponding temp.

Missing @errp.

> + *
> + * Load a page from RAMBlock at offset at given host address. Used by postcopy
> + * ram fault thread and eager thread in fast snapshot load case.
> + *
> + * Return: True on success.
> + */
> +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> +                                          RAMBlock *rb, ram_addr_t rb_offset,
> +                                          uint64_t haddr, int channel,
> +                                          Error **errp)
> +{
> +    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
> +    size_t page;
> +    size_t read;
> +
> +    page = rb_offset / qemu_ram_pagesize(rb);

Yes, here it is correct to use qemu_ram_pagesize().

> +
> +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> +        if (test_bit(page, rb->file_bmap)) {

We'll need to be careful here when you add huge page support, because
file_bmap so far is guest-psize based.  This line will start to break for
huge pages, I am not sure if this is the bug you hit when developing huge
page support, maybe yes?

Not sure how you resolved it there if this is the case, but one idea is
when postcopy-ram is enabled, you can convert the per-guest-psize bitmap
into per-host-psize bitmap (when any bit set within the huge page range,
set the bit in the new bitmap), then here it will be correct.

> +            /*
> +             * This can happen concurrently, but it's thread-safe because
> +             * qemu_get_buffer_at() is thread-safe, and the caller will be using
> +             * different temporary buffers.
> +             */
> +            read = qemu_get_buffer_at(mis->from_src_file, place_source,
> +                                      qemu_ram_pagesize(rb),
> +                                      rb->pages_offset + rb_offset);
> +
> +            if (read != qemu_ram_pagesize(rb)) {
> +                error_setg(errp, "Could not read page %zu from RAM Block %s",
> +                           page, rb->idstr);
> +                return false;
> +            }
> +
> +            if (postcopy_place_page(mis, (void *)haddr, place_source, rb)) {
> +                error_setg(errp,
> +                           "Failed to place page %zu from RAM Block %s at "
> +                           "address %" PRIu64,
> +                           page, rb->idstr, haddr);
> +                return false;
> +            }
> +

Nit: unnecessary newline.

> +        } else {
> +            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
> +                error_setg(errp,
> +                           "Failed to place zero page %zu from RAM Block %s at "
> +                           "address %" PRIu64,
> +                           page, rb->idstr, haddr);
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  /*
>   * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
>   * also optional: when zero is provided, the fault accounting will be ignored.
> @@ -1279,6 +1341,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
>      int ret;
>      size_t index;
>      RAMBlock *rb = NULL;
> +    Error *local_err = NULL;
>  
>      trace_postcopy_ram_fault_thread_entry();
>      rcu_register_thread();
> @@ -1320,11 +1383,13 @@ static void *postcopy_ram_fault_thread(void *opaque)
>              break;
>          }
>  
> -        if (!mis->to_src_file) {
> +        if (!migrate_mapped_ram() && !mis->to_src_file) {
>              /*
> -             * Possibly someone tells us that the return path is
> -             * broken already using the event. We should hold until
> -             * the channel is rebuilt.
> +             * Possibly someone tells us that the return path is broken already
> +             * using the event. We should hold until the channel is rebuilt.
> +             * Fast snapshot load doesn't support pause and recover, because
> +             * it's not necessary: we can fail right away when QEMU just booted
> +             * with nothing to lose.
>               */
>              postcopy_pause_fault_thread(mis);
>          }
> @@ -1387,18 +1452,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
>                                                  qemu_ram_get_idstr(rb),
>                                                  rb_offset,
>                                                  msg.arg.pagefault.feat.ptid);
> +
> +            if (migrate_mapped_ram()) {
> +                /* Load page directly in case of fast snapshot load */
> +                WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
> +                    if (!ramblock_recv_bitmap_test(
> +                            rb, (void *)msg.arg.pagefault.address)) {
> +                        mark_postcopy_blocktime_begin(
> +                            msg.arg.pagefault.address,
> +                            msg.arg.pagefault.feat.ptid, rb);
> +                    }
> +                }

This part needs some more thought.

First of all, if the page is set already in receivedmap, it means it's
already installed, we shouldn't bother postcopy_mapped_ram_load_page().

But the problem is not only about that.

So far looks like the blocktime feature relies on the receivedmap, then it
means the easy way for this series is to support receivedmap too.  Then
with receivedmap, we should unify the receivedmap detection rather than
testing the bit at multiple places.

Say, you can provide a small helper like this:

diff --git a/migration/migration.c b/migration/migration.c
index 278cad502a..79f737bc69 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -573,12 +573,10 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
     return migrate_send_rp_message(mis, msg_type, msglen, bufc);
 }

-int migrate_send_rp_req_pages(MigrationIncomingState *mis,
-                              RAMBlock *rb, ram_addr_t start, uint64_t haddr,
-                              uint32_t tid)
+bool postcopy_page_received(MigrationIncomingState *mis, RAMBlock *rb,
+                            ram_addr_t start, uint64_t haddr, uint32_t tid)
 {
-    void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
-    bool received = false;
+    bool received;

     WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
         received = ramblock_recv_bitmap_test_byte_offset(rb, start);
@@ -598,11 +596,20 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
         }
     }

+    return received;
+}
+
+int migrate_send_rp_req_pages(MigrationIncomingState *mis,
+                              RAMBlock *rb, ram_addr_t start, uint64_t haddr,
+                              uint32_t tid)
+{
+    void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
+
     /*
      * If the page is there, skip sending the message.  We don't even need the
      * lock because as long as the page arrived, it'll be there forever.
      */
-    if (received) {
+    if (postcopy_page_received(mis, rb, start, aligned, tid)) {
         return 0;
     }

Then I think we can use postcopy_page_received() here to avoid duplicating
the code.

It means with your feature we will also maintain the tree of page_requested
but I think it's fine; if we really want we can make that optional based on
whether mapped-ram enabled, but not yet required.

PS: I feel like there was a bug in existing code passing "haddr" (rather
than "aligned") into mark_postcopy_blocktime_begin() in the current impl of
migrate_send_rp_req_pages().  Please help to check if it's an issue, if
true we can have a separate patch fixing that first.  In general, I think
we should use a page-aligned address in both the tree and blocktime.

> +                if (!postcopy_mapped_ram_load_page(
> +                        mis, rb, rb_offset, msg.arg.pagefault.address,
> +                        RAM_CHANNEL_POSTCOPY, &local_err)) {
> +                    error_report_err(local_err);
> +                    break;
> +                }
> +            } else {
>  retry:
> -            /*
> -             * Send the request to the source - we want to request one
> -             * of our host page sizes (which is >= TPS)
> -             */
> -            ret = postcopy_request_page(mis, rb, rb_offset,
> -                                        msg.arg.pagefault.address,
> -                                        msg.arg.pagefault.feat.ptid);
> -            if (ret) {
> -                /* May be network failure, try to wait for recovery */
> -                postcopy_pause_fault_thread(mis);
> -                goto retry;
> +                /*
> +                 * Send the request to the source - we want to request one
> +                 * of our host page sizes (which is >= TPS)
> +                 */
> +                ret = postcopy_request_page(mis, rb, rb_offset,
> +                                            msg.arg.pagefault.address,
> +                                            msg.arg.pagefault.feat.ptid);
> +                if (ret) {
> +                    /* May be network failure, try to wait for recovery */
> +                    postcopy_pause_fault_thread(mis);
> +                    goto retry;
> +                }
>              }
>          }
>  
> @@ -1470,8 +1554,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
>      unsigned i, channels;
>      void *temp_page;
>  
> -    if (migrate_postcopy_preempt()) {
> -        /* If preemption enabled, need extra channel for urgent requests */
> +    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
> +        /*
> +         * If preemption enabled or it is fast snapshot load, need extra channel
> +         * for urgent requests/faults
> +         */
>          mis->postcopy_channels = RAM_CHANNEL_MAX;
>      } else {
>          /* Both precopy/postcopy on the same channel */
> -- 
> 2.54.0
> 

-- 
Peter Xu


