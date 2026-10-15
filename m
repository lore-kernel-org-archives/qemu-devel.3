Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB53CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMLY-0002Fa-V1; Thu, 15 Oct 2026 10:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHMLW-0002Es-UN; Thu, 15 Oct 2026 10:22:14 -0400
Received: from forwardcorp2d.mail.yandex.net ([178.154.239.207])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHMLT-000485-Ga; Thu, 15 Oct 2026 10:22:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net)
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id 7667080297;
 Thu, 15 Oct 2026 17:22:06 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 5MWPN95vM0U0-kvr3ukcy; Thu, 15 Oct 2026 17:22:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792074125;
 bh=3aqhe5/CXFtzJABlktz4u/FCdrW4F9Mm0i8VkoNRlBI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CPVMTqL2Uvc4AYm2f+1My0DJJhknGaLKwdLY5FdO3HVzX0qrz6ckYJjckAj0RIyqz
 g2atxADlkA/vbJWl3y+zDaa3/wlWH1HhONZn/kR4MFZa+KF5DHhMnuJsoF1Z8m2rQT
 DaVCveShtzKwseins+swlHkOETe2KwBjrwZ0LGY0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0e602b4d-89a0-427f-850f-22b07232d889@yandex-team.ru>
Date: Thu, 15 Oct 2026 17:22:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] block/block-copy: coalesce write-zeroes tasks
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-10-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-10-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.207;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On 29.09.26 18:51, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Task size was capped to block_copy_chunk_size() regardless of method,
> which sizes a task by the copy buffer. A write-zeroes task carries no
> buffer, so that cap only splits one long known-zero run into a crowd of
> small COPY_WRITE_ZEROES tasks, each with its own request against the
> target.
> 
> block_copy_task_create() already decides from zero_bitmap how far a task
> may run, so add block_copy_widen_zero_area() to that decision: for a
> write-zeroes task, re-search the dirty area under BDRV_REQUEST_MAX_BYTES
> instead of the buffer chunk size, and let the existing clamp cut it back
> to where the zero run ends. That bound is INT_MAX rounded down to a
> sector, so nothing has aligned it to cluster_size and it is aligned down
> at the use site. Widening is safe: an overlapping caller waits on the
> task's BlockReq via reqlist_wait_one() rather than observing it
> mid-flight.
> 
> A request that large is only cheap where the target zeroes by metadata.
> BDRV_REQ_NO_FALLBACK in supported_zero_flags rules out the targets which
> cannot, qcow2 v2 and iscsi among them, but it is optimistic for the rest:
> file-posix advertises it at open and only learns from a failing
> fallocate. So a write-zeroes request asks for it while the target is
> believed to oblige, which costs nothing when it does. A refusal ends the
> widening, and the range is written in buffer-sized chunks, as is any
> task widened before the refusal came. -ENOTSUP says the fast path is
> unavailable, not that the target wrote nothing, so the range is
> rewritten whole: zeroes over zeroes change nothing.
> 

This may work bad with speed= parameter: big zero request will be accounted
as data, blocking further requests. Seems, we should not account fast-zeroes
as data.

> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/block-copy.c | 94 ++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 87 insertions(+), 7 deletions(-)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index c0a3359938..94ca2a10ed 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -159,6 +159,8 @@ typedef struct BlockCopyState {
>       bool skip_unallocated; /* atomic */
>       /* State fields that use a thread-safe API */
>       BdrvDirtyBitmap *copy_bitmap;
> +    /* Whether a write-zeroes task may widen; see block_copy_write_zeroes(). */
> +    bool zero_widen; /* atomic */
>       /* Clusters reading as zero; allocated on demand, frozen once valid. */
>       HBitmap *zero_bitmap;
>       /* Published only after the scan, with skip_unallocated already false. */
> @@ -187,6 +189,34 @@ static int64_t block_copy_chunk_size(BlockCopyState *s)
>       }
>   }
>   
> +/*
> + * A write-zeroes task carries no buffer, so it may cover far more than
> + * block_copy_chunk_size(). Return how far it may run; the caller clamps it
> + * to where the zero run ends.
> + */
> +static int64_t block_copy_widen_zero_area(BlockCopyState *s,
> +                                          BlockCopyCallState *call_state,
> +                                          int64_t offset, int64_t search_end,
> +                                          int64_t bytes)
> +{
> +    int64_t aligned = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
> +                                      s->cluster_size);
> +    int64_t zero_chunk = MIN_NON_ZERO(MAX(aligned, s->cluster_size),

aligned < s->cluster_size case looks like a bug. I think we don't supprt cluser_size > BDRV_REQUEST_MAX_BYTES anyway.

> +                                      call_state->max_chunk);

max_chunk comes from experimental backup QAPI parameter x-perf.max_chunk. I don't
think we should limit fast-zero requests by it. And it's unstable, so we can change
the contract.

> +    int64_t wide_offset, wide_bytes;
> +
> +    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset, search_end,
> +                                           zero_chunk, &wide_offset,
> +                                           &wide_bytes)) {

offset must be dirty at this point.. so bdrv_dirty_bitmap_next_zero() would be enough,
we don't need bdrv_dirty_bitmap_next_dirty_area().

> +        return bytes;
> +    }
> +
> +    /* @offset is dirty, so the search cannot have moved past it. */
> +    assert(wide_offset == offset);
> +
> +    return wide_bytes;
> +}
> +
>   /*
>    * Search for the first dirty area in offset/bytes range and create task at
>    * the beginning of it.
> @@ -198,6 +228,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>       BlockCopyTask *task;
>       BlockCopyMethod method;
>       int64_t max_chunk;
> +    int64_t search_end = offset + bytes;
>   
>       QEMU_LOCK_GUARD(&s->lock);
>       max_chunk = MIN_NON_ZERO(block_copy_chunk_size(s), call_state->max_chunk);
> @@ -219,6 +250,10 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
>   
>           if (hbitmap_get(s->zero_bitmap, offset)) {
>               method = COPY_WRITE_ZEROES;
> +            if (qatomic_read(&s->zero_widen)) {
> +                bytes = block_copy_widen_zero_area(s, call_state, offset,
> +                                                   search_end, bytes);
> +            }
>               boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
>           } else {
>               boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
> @@ -465,6 +500,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>           .max_transfer = QEMU_ALIGN_DOWN(
>                                       block_copy_max_transfer(source, target),
>                                       cluster_size),
> +        .zero_widen = target->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK,
>       };
>   
>       s->discard_source = discard_source;
> @@ -521,6 +557,56 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
>       return 0;
>   }
>   
> +/*
> + * Widening a write-zeroes request only pays off where the target zeroes by
> + * metadata, so while the target is believed to oblige, a request asks to fail
> + * instead of falling back to writing the zeroes out. That costs nothing when
> + * it does oblige, and a refusal ends the widening for the rest of the run.
> + */
> +static int coroutine_fn GRAPH_RDLOCK
> +block_copy_write_zeroes(BlockCopyState *s, int64_t offset, int64_t bytes,
> +                        bool *error_is_read)
> +{
> +    BdrvRequestFlags flags = s->write_flags & ~BDRV_REQ_WRITE_COMPRESSED;
> +    int64_t chunk;
> +    int ret = 0;
> +
> +    if (qatomic_read(&s->zero_widen)) {
> +        ret = bdrv_co_pwrite_zeroes(s->target, offset, bytes,
> +                                    flags | BDRV_REQ_NO_FALLBACK);
> +        if (ret != -ENOTSUP) {
> +            goto out;
> +        }
> +
> +        /* Redoing the range is safe: zeroes over zeroes change nothing. */
> +        qatomic_set(&s->zero_widen, false);
> +    }
> +
> +    WITH_QEMU_LOCK_GUARD(&s->lock) {
> +        chunk = block_copy_chunk_size(s);
> +    }
> +
> +    while (bytes) {
> +        int64_t n = MIN(bytes, chunk);
> +
> +        ret = bdrv_co_pwrite_zeroes(s->target, offset, n, flags);

That's a problem actually. We do synchronous writing of large area: we lose
parllelism (max-workers), and probably block guest writes to the while big
area, until it written.

> +        if (ret < 0) {
> +            break;
> +        }
> +
> +        offset += n;
> +        bytes -= n;
> +    }
> +
> +out:
> +    if (ret < 0) {
> +        trace_block_copy_write_zeroes_fail(s, offset, ret);
> +        *error_is_read = false;
> +    }
> +
> +    return ret;
> +}
> +
>   /*
>    * block_copy_do_copy
>    *
> @@ -552,13 +638,7 @@ block_copy_do_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
>   
>       switch (*method) {
>       case COPY_WRITE_ZEROES:
> -        ret = bdrv_co_pwrite_zeroes(s->target, offset, nbytes, s->write_flags &
> -                                    ~BDRV_REQ_WRITE_COMPRESSED);
> -        if (ret < 0) {
> -            trace_block_copy_write_zeroes_fail(s, offset, ret);
> -            *error_is_read = false;
> -        }
> -        return ret;
> +        return block_copy_write_zeroes(s, offset, nbytes, error_is_read);
>   
>       case COPY_RANGE_SMALL:
>       case COPY_RANGE_FULL:


-- 
Best regards,
Vladimir

