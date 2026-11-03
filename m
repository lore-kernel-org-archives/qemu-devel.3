Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E7606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZG0dMh0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xODtk-0002uC-JW; Tue, 03 Nov 2026 07:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xODth-0002t1-Pf
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xODtf-0007Dp-Om
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793709949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0LNavlsjsBUMlraiXtipN+aBXWu+MLDERi1KfkWkHM=;
 b=NZG0dMh0f3HgKii85lrhk43MJiB6MOWPrFUGFTiiSP6WAylflR+OGCSEayIx3aij/ei1T5
 +8dun+5UEHuW7ZWYJQFuPp3LtYrPi+BdSbF1UzlNUgtBqDnkuLlK8aK4WgnXocwk/jPX1c
 h1L0W0DH+jMBKNxwdPXejSPYp/6/KSo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-UQWWmqbEO3Spp8MPFIESmQ-1; Tue,
 03 Nov 2026 07:45:45 -0500
X-MC-Unique: UQWWmqbEO3Spp8MPFIESmQ-1
X-Mimecast-MFC-AGG-ID: UQWWmqbEO3Spp8MPFIESmQ_1793709944
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87A2918011EA; Tue,  3 Nov 2026 12:45:43 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9C4630002CE; Tue,  3 Nov 2026 12:45:40 +0000 (UTC)
Date: Tue, 3 Nov 2026 13:45:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 04/13] block/preallocate: serialise the filter state
Message-ID: <aunXci0uI8_NkmVL@redhat.com>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-5-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930165000.303236-5-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 30.09.2026 um 18:49 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> The filter keeps the file length it has seen, the length it has
> reserved and where the trailing zeroes start in plain fields, and
> updates them with a read, a compare and a store. That was indivisible
> while one node was driven by one AioContext. It is not any more:
> virtio-blk with iothread-vq-mapping drives one node from several.
> 
> Two writers extending the file then both pass the compare, and the
> smaller end lands last:
> 
>   writer A, [1G, 1G+64k)            writer B, [1G+64k, 1G+128k)
>   --------------------------------  --------------------------------
>   reads data_end 1G, 1G+64k > 1G
>                                     reads data_end 1G, 1G+128k > 1G
>                                     stores data_end = 1G+128k
>   stores data_end = 1G+64k
> 
> Both writes are acknowledged, and data_end now sits below B's data.
> Nothing raises it again except a later write ending beyond it, and
> closing the image truncates the file to it, so B's data is cut off the
> end. The last pair of extending writes before a shutdown is exactly
> where this bites.
> 
> Take a mutex across handle_write() and preallocate_co_getlength(). The
> remaining readers, apart from preallocate_co_truncate(), reach the
> state from global state code with the node drained, where no request
> is in flight.

I wanted to complain that you forgot preallocate_co_truncate(), but you
even mention it here explicitly. So I'll change my complaint into a
question: Why is leaving preallocate_co_truncate() alone okay?

I think it would be best to start with just taking the lock everywhere
where it could be potentially relevant, so that we have a state that we
can be reasonably confident in. If then optimisations are needed,
additional patches can explain how they replace the obvious mechanism.

When we never have this state that is quite obviously correct, then it
becomes a lot more difficult to tell if the result covers everything
that needs to be covered.

Another thought I had was that maybe I should give TSA for per-BDS locks
another try, so that we could mark data_end as GUARDED_BY(lock). The
changes made to TSA for the kernel in the past year or two might be
enough to make it workable now.

> Holding it cannot deadlock. A writer waiting for it has not reached
> bs->file yet, so it owns nothing below the filter, and the only calls
> made under it go to the child. preallocate_co_truncate() is left out
> for that reason: growing the file waits for the requests in flight on
> the child, and once the next patch issues the preallocation without
> the mutex, one of those can be a preallocation that needs it back.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: qemu-stable@nongnu.org
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/preallocate.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 8cd98684f4..442cdb0176 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -76,6 +76,8 @@ typedef struct BDRVPreallocateState {
>       * BLK_PERM_WRITE permissions on file child.
>       */
>  
> +    CoMutex lock;
> +
>      /* Gives up the resize permission on children when parents don't need it */
>      QEMUBH *drop_resize_bh;
>  } BDRVPreallocateState;
> @@ -155,6 +157,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>       * For this to work, mark them invalid.
>       */
>      preallocate_set_state(s, -EINVAL);
> +    qemu_co_mutex_init(&s->lock);
>      s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
>  
>      ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
> @@ -324,8 +327,8 @@ static bool GRAPH_RDLOCK has_prealloc_perms(BlockDriverState *bs)
>   * one bdrv_co_pwrite_zeroes() call.
>   */
>  static bool coroutine_fn GRAPH_RDLOCK
> -handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
> -             bool want_merge_zero)
> +handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
> +                    bool want_merge_zero)
>  {
>      BDRVPreallocateState *s = bs->opaque;
>      int64_t end = offset + bytes;
> @@ -404,6 +407,20 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>      return want_merge_zero;
>  }
>  
> +static bool coroutine_fn GRAPH_RDLOCK
> +handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
> +             bool want_merge_zero)
> +{
> +    BDRVPreallocateState *s = bs->opaque;
> +    bool ret;
> +
> +    qemu_co_mutex_lock(&s->lock);
> +    ret = handle_write_locked(bs, offset, bytes, want_merge_zero);
> +    qemu_co_mutex_unlock(&s->lock);
> +
> +    return ret;
> +}

Even at the end of the series, handle_write() is the only called of
handle_write_locked(). Why don't you just take the lock in the existing
function instead of splitting it?

Kevin


