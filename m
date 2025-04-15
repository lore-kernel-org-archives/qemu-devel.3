Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70884C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 16:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ihS-0007tr-HL; Tue, 15 Apr 2025 11:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4ihJ-0007l6-35; Tue, 15 Apr 2025 11:59:41 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4ih8-0001tk-D6; Tue, 15 Apr 2025 11:59:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:921:0:640:f23d:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6C5D761C04;
 Tue, 15 Apr 2025 18:59:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:16e::1:36] (unknown
 [2a02:6bf:8080:16e::1:36])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FxJGQP0FUmI0-onwCjIOL; Tue, 15 Apr 2025 18:59:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744732755;
 bh=wK/sW/tZhrT5vnIpdyAKdfStaxHOxPKFFqCDEN3wXO0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Jpcm7Xbb+yrg7wbbyVUKR/q9PO4T3KY7Zlv8/cdhq8BO1xunPKMcLUHr8QIPadtiJ
 5EAsdETPFBB21HX1TlUk6EdCBpifIOr+nkZr6yfkd9TPz2MJtUZMo3LS//oT6A8x92
 VquSqV6r5TCyqWqUSP0rEu/rqLNcHE8C19aMSa9w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c3044546-b921-4cbc-959d-4f23e0e3c49e@yandex-team.ru>
Date: Tue, 15 Apr 2025 18:59:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mirror: Skip writing zeroes when target is already
 zero
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:Block Jobs"
 <qemu-block@nongnu.org>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-11-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250411010732.358817-11-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11.04.25 04:04, Eric Blake wrote:
> When mirroring, the goal is to ensure that the destination reads the
> same as the source; this goal is met whether the destination is sparse
> or fully-allocated.  However, if the destination cannot efficiently
> write zeroes, then any time the mirror operation wants to copy zeroes
> from the source to the destination (either during the background over
> sparse regions when doing a full mirror, or in the foreground when the
> guest actively writes zeroes), we were causing the destination to
> fully allocate that portion of the disk, even if it already read as
> zeroes.
> 
> We could just teach mirror_co_zero() to do a block_status() probe of
> the destination, and skip the zeroes if the destination already reads
> as zero, but we know from past experience that block_status() calls
> are not always cheap (tmpfs, anyone?).  So this patch takes a slightly
> different approach: any time we have to transfer the full image,
> mirror_dirty_init() is _already_ doing a pre-zero pass over the entire
> destination.  Therefore, if we track which clusters of the destination
> are zero at any given moment, we don't have to do a block_status()
> call on the destination, but can instead just refer to the zero bitmap
> associated with the job.
> 
> With this patch, if I externally create a raw sparse destination file
> ('truncate --size=$N dst.raw'), connect it with QMP 'blockdev-add'
> while leaving it at the default "discard":"ignore", then run QMP
> 'blockdev-mirror' with "sync":"full", the destination remains sparse
> rather than fully allocated.
> 
> However, a raw destination file created with 'blockdev-create' still
> gets fully allocated, because more work is needed in file-posix to
> still identify reads-as-zeroes even when the first 4k has to be
> allocated to make alignment probing work.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/mirror.c | 94 +++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 78 insertions(+), 16 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 2e1e14c8e7e..98da5a6dc27 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -73,6 +73,7 @@ typedef struct MirrorBlockJob {
>       size_t buf_size;
>       int64_t bdev_length;
>       unsigned long *cow_bitmap;
> +    unsigned long *zero_bitmap;
>       BdrvDirtyBitmap *dirty_bitmap;
>       BdrvDirtyBitmapIter *dbi;
>       uint8_t *buf;
> @@ -408,15 +409,32 @@ static void coroutine_fn mirror_co_read(void *opaque)
>   static void coroutine_fn jk(void *opaque)
>   {
>       MirrorOp *op = opaque;
> -    int ret;
> +    bool write_needed = true;
> +    int ret = 0;
> 
>       op->s->in_flight++;
>       op->s->bytes_in_flight += op->bytes;
>       *op->bytes_handled = op->bytes;
>       op->is_in_flight = true;
> 
> -    ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
> -                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
> +    if (op->s->zero_bitmap) {
> +        unsigned long last = (op->offset + op->bytes) / op->s->granularity;

Maybe, call it "end", not "last, as it's not last element of the range, but first after the range.

Also, seems we need still do DIV_ROUND_UP, for ..

> +        assert(QEMU_IS_ALIGNED(op->offset, op->s->granularity));
> +        assert(QEMU_IS_ALIGNED(op->bytes, op->s->granularity) ||
> +               op->offset + op->bytes == op->s->bdev_length);

.. ^ this case, when bytes is unaligned to granularity but aligned to bdev_length.

> +        if (find_next_zero_bit(op->s->zero_bitmap, last,
> +                               op->offset / op->s->granularity) == last) {
> +            write_needed = false;
> +        }
> +    }
> +    if (write_needed) {
> +        ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
> +                                   op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
> +    }
> +    if (ret >= 0 && op->s->zero_bitmap) {
> +        bitmap_set(op->s->zero_bitmap, op->offset / op->s->granularity,
> +                   op->bytes / op->s->granularity);

and here we want to align up bytes, for the corner case

> +    }

Also, I'm not sure, what guarantees we have in case of write-zeroes failure. Should we clear the bitmap in this case, like we do MIRROR_METHOD_COPY and MIRROR_METHOD_DISCARD below

>       mirror_write_complete(op, ret);
>   }
> 
> @@ -441,6 +459,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
>       Coroutine *co;
>       int64_t bytes_handled = -1;
> 
> +    assert(QEMU_IS_ALIGNED(offset, s->granularity));
> +    assert(QEMU_IS_ALIGNED(bytes, s->granularity) ||
> +           offset + bytes == s->bdev_length);
>       op = g_new(MirrorOp, 1);
>       *op = (MirrorOp){
>           .s              = s,
> @@ -452,12 +473,21 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
> 
>       switch (mirror_method) {
>       case MIRROR_METHOD_COPY:
> +        if (s->zero_bitmap) {
> +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> +                         bytes / s->granularity);

again, align up for corner case

> +        }
>           co = qemu_coroutine_create(mirror_co_read, op);
>           break;
>       case MIRROR_METHOD_ZERO:
> +        /* s->zero_bitmap handled in mirror_co_zero */
>           co = qemu_coroutine_create(mirror_co_zero, op);
>           break;
>       case MIRROR_METHOD_DISCARD:
> +        if (s->zero_bitmap) {
> +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> +                         bytes / s->granularity);
> +        }
>           co = qemu_coroutine_create(mirror_co_discard, op);
>           break;
>       default:
> @@ -851,10 +881,17 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>       }
>       bdrv_graph_co_rdunlock();
> 
> -    if (s->zero_target && ret <= 0) {
> +    if (s->zero_target) {
> +        int64_t length;
> +
>           if (ret < 0) {
>               return ret;
>           }
> +        length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> +        s->zero_bitmap = bitmap_new(length);
> +        if (ret > 0) {
> +            bitmap_set(s->zero_bitmap, 0, length);

hmm, we should not continue zeroing target in case of ret > 0.

I didn't like that we set ret in one if-block, and handle in another, but now it gets even more confusing.

Maybe, just move bdrv_co_is_zero_fast() call into big "if (s->zero_target) {" ?



> +        }
>           if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>               bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
>               return 0;
> @@ -1169,6 +1206,7 @@ immediate_exit:
>       assert(s->in_flight == 0);
>       qemu_vfree(s->buf);
>       g_free(s->cow_bitmap);
> +    g_free(s->zero_bitmap);
>       g_free(s->in_flight_bitmap);
>       bdrv_dirty_iter_free(s->dbi);
> 
> @@ -1347,7 +1385,8 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
>   {
>       int ret;
>       size_t qiov_offset = 0;
> -    int64_t bitmap_offset, bitmap_end;
> +    int64_t dirty_bitmap_offset, dirty_bitmap_end;
> +    int64_t zero_bitmap_offset, zero_bitmap_end;
> 
>       if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
>           bdrv_dirty_bitmap_get(job->dirty_bitmap, offset))
> @@ -1391,31 +1430,54 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
>       }
> 
>       /*
> -     * Tails are either clean or shrunk, so for bitmap resetting
> -     * we safely align the range down.
> +     * Tails are either clean or shrunk, so for dirty bitmap resetting
> +     * we safely align the range down.  But for zero bitmap, round range
> +     * up for checking or clearing, and down for setting.
>        */
> -    bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
> -    bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
> -    if (bitmap_offset < bitmap_end) {
> -        bdrv_reset_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
> -                                bitmap_end - bitmap_offset);
> +    dirty_bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
> +    dirty_bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
> +    if (dirty_bitmap_offset < dirty_bitmap_end) {
> +        bdrv_reset_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
> +                                dirty_bitmap_end - dirty_bitmap_offset);
>       }
> +    zero_bitmap_offset = offset / job->granularity;
> +    zero_bitmap_end = DIV_ROUND_UP(offset + bytes, job->granularity);
> 
>       job_progress_increase_remaining(&job->common.job, bytes);
>       job->active_write_bytes_in_flight += bytes;
> 
>       switch (method) {
>       case MIRROR_METHOD_COPY:
> +        if (job->zero_bitmap) {
> +            bitmap_clear(job->zero_bitmap, zero_bitmap_offset,
> +                         zero_bitmap_end - zero_bitmap_offset);
> +        }
>           ret = blk_co_pwritev_part(job->target, offset, bytes,
>                                     qiov, qiov_offset, flags);
>           break;
> 
>       case MIRROR_METHOD_ZERO:
> +        if (job->zero_bitmap) {
> +            if (find_next_zero_bit(job->zero_bitmap, zero_bitmap_end,
> +                                   zero_bitmap_offset) == zero_bitmap_end) {
> +                ret = 0;
> +                break;
> +            }
> +        }
>           assert(!qiov);
>           ret = blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
> +        if (job->zero_bitmap && ret >= 0) {
> +            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granularity,
> +                       (dirty_bitmap_end - dirty_bitmap_offset) /
> +                       job->granularity);
> +        }

Same thing, probably we should clear the bitmap in case of write failure.

>           break;
> 
>       case MIRROR_METHOD_DISCARD:
> +        if (job->zero_bitmap) {
> +            bitmap_clear(job->zero_bitmap, zero_bitmap_offset,
> +                         zero_bitmap_end - zero_bitmap_offset);
> +        }
>           assert(!qiov);
>           ret = blk_co_pdiscard(job->target, offset, bytes);
>           break;
> @@ -1436,10 +1498,10 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
>            * at function start, and they must be still dirty, as we've locked
>            * the region for in-flight op.
>            */
> -        bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
> -        bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
> -        bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
> -                              bitmap_end - bitmap_offset);
> +        dirty_bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
> +        dirty_bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
> +        bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
> +                              dirty_bitmap_end - dirty_bitmap_offset);

Not really matter, but still, renaming in a separate patch would make this one a bit simpler.

>           qatomic_set(&job->actively_synced, false);
> 
>           action = mirror_error_action(job, false, -ret);

-- 
Best regards,
Vladimir


