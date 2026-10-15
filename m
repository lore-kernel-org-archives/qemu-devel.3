Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E11CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHNI5-0000V6-V8; Thu, 15 Oct 2026 11:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHNI3-0000UX-9a; Thu, 15 Oct 2026 11:22:43 -0400
Received: from forwardcorp2d.mail.yandex.net ([178.154.239.207])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHNI0-0003Nj-B7; Thu, 15 Oct 2026 11:22:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-63.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-63.yp-c.yandex.net)
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id 6E8B7809A8;
 Thu, 15 Oct 2026 18:22:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-63.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XMXPAZ2fdmI0-PVeYt27q; Thu, 15 Oct 2026 18:22:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792077753;
 bh=98OgYRSSN2z5HimXaCOsUKFlXrtDk7aRQ4aN/rErfSA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=nduoM6DHHkdODiMAUj3/Rzx6lDjDOVjkKzVyXkpv53bHD6VzRELFmEvUMPmSbzhKv
 wVe0Ji13NFJTZa4xK4uiev/hV+VWqOHz7Xhqyqm1ddHLbjGH+o53rom/gUeqYOqMM+
 40vWfjCkKIcVYgkce/iS20V9gypTq35mbZPNYJNQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-63.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a0ecaa25-82bc-4d17-97e6-b67d6fbb9a77@yandex-team.ru>
Date: Thu, 15 Oct 2026 18:22:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] block/backup: pre-fill zero_bitmap for full/bitmap
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-9-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-9-den@openvz.org>
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
> Only sync=top runs an up-front scan, so the previous patch did nothing
> for the other modes. FULL and BITMAP know their complete copy_bitmap
> before copying starts, and the same copy-before-write guarantee holds:
> a cluster still dirty when the copy loop reaches it has not been written
> since the scan.
> 
> Add block_copy_calculate_zero_bitmap(), driven one query at a time from
> backup_scan_source() so the graph rdlock and the pause point are taken
> per query, and query each confirmed span once however many dirty areas
> it covers. The scan only fills zero_bitmap and never clears copy_bitmap,
> so sync=full still writes zeroes for clusters the source never
> allocated; it just stops re-querying to find that out. Unlike the
> per-task queries it replaces the scan is serial, so a sparsely dirtied
> job against a slow source may spend more time here than it saves. The
> sync=top loop had the same shape, so both fold into
> backup_scan_source().
> 
> sync=none keeps the per-task query. Its bitmap says "anything may be
> copied", not "this will be copied", and it only ever copies what the
> guest writes during the fleecing window, so scanning the whole image at
> attach is the wrong trade.
> 
> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/backup.c             | 94 ++++++++++++++++++++++++--------------
>   block/block-copy.c         | 41 +++++++++++++++++
>   include/block/block-copy.h |  4 ++
>   3 files changed, 105 insertions(+), 34 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 11d70243e2..38b0838d69 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -247,59 +247,85 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
>       job_progress_set_remaining(&job->common.job, estimate);
>   }
>   
> -static int coroutine_fn backup_run(Job *job, Error **errp)
> +/*
> + * Walk the source before copying starts: fill zero_bitmap and, for sync=top,
> + * drop the clusters that are not allocated above the backing.
> + */
> +static int coroutine_fn backup_scan_source(BackupBlockJob *s)
>   {
> -    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
> -    int ret;
> -
> -    backup_init_bcs_bitmap(s);
> -
> -    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
> -        int64_t offset = 0;
> -        int64_t count;
> +    Job *job = &s->common.job;
> +    bool top = s->sync_mode == MIRROR_SYNC_MODE_TOP;
> +    int64_t offset, cached_end = 0, count;
> +    int ret = 0;
>   
> -        for (offset = 0; offset < s->len; ) {
> -            if (job_is_cancelled(job)) {
> -                return -ECANCELED;
> -            }
> +    for (offset = 0; offset < s->len; offset += count) {
> +        if (job_is_cancelled(job)) {
> +            return -ECANCELED;
> +        }
>   
> -            job_pause_point(job);
> +        job_pause_point(job);
>   
> -            if (job_is_cancelled(job)) {
> -                return -ECANCELED;
> -            }
> +        if (job_is_cancelled(job)) {
> +            return -ECANCELED;
> +        }
>   
> -            /* rdlock protects the subsequent call to bdrv_is_allocated() */
> -            bdrv_graph_co_rdlock();
> +        /* rdlock protects the block-status queries below */
> +        bdrv_graph_co_rdlock();
> +        if (top) {
>               ret = block_copy_reset_unallocated(s->bcs, offset, &count);
> -            bdrv_graph_co_rdunlock();
> -            if (ret < 0) {
> -                return ret;
> -            }
> +        } else {
> +            block_copy_calculate_zero_bitmap(s->bcs, offset, &cached_end,
> +                                             &count);
> +        }
> +        bdrv_graph_co_rdunlock();
>   
> -            offset += count;
> +        if (ret < 0) {
> +            return ret;
>           }
> +    }
> +
> +    if (top) {
>           block_copy_set_skip_unallocated(s->bcs, false);
> -        block_copy_set_zero_bitmap_valid(s->bcs);
>       }
> +    block_copy_set_zero_bitmap_valid(s->bcs);
>   
> -    if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
> +    return 0;
> +}
> +
> +static int coroutine_fn backup_run(Job *job, Error **errp)
> +{
> +    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
> +    int ret;
> +
> +    backup_init_bcs_bitmap(s);
> +
> +    switch (s->sync_mode) {
> +    case MIRROR_SYNC_MODE_TOP:
> +    case MIRROR_SYNC_MODE_FULL:
> +    case MIRROR_SYNC_MODE_BITMAP:
> +        ret = backup_scan_source(s);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        break;
> +
> +    case MIRROR_SYNC_MODE_NONE:
>           /*
>            * All bits are set in bcs bitmap to allow any cluster to be copied.
> -         * This does not actually require them to be copied.
> +         * This does not actually require them to be copied. Yield until the
> +         * job is cancelled and let the before_write notify callback service
> +         * CoW requests.
>            */
>           while (!job_is_cancelled(job)) {
> -            /*
> -             * Yield until the job is cancelled.  We just let our before_write
> -             * notify callback service CoW requests.
> -             */
>               job_yield(job);
>           }
> -    } else {
> -        return backup_loop(s);
> +        return 0;
> +
> +    default:
> +        g_assert_not_reached();
>       }
>   
> -    return 0;
> +    return backup_loop(s);
>   }
>   
>   static void coroutine_fn backup_pause(Job *job)
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 94d4f3dd69..c0a3359938 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -813,6 +813,47 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
>       return ret;
>   }
>   
> +/*
> + * One scan step, like block_copy_reset_unallocated(); @cached_end
> + * tracks progress across calls, @count how far @offset should move.
> + */
> +void coroutine_fn GRAPH_RDLOCK
> +block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
> +                                 int64_t *cached_end, int64_t *count)
> +{
> +    int64_t dirty_offset, dirty_bytes, dirty_end;
> +    bool found;
> +
> +    /* CBW mutates copy_bitmap from its own AioContext meanwhile. */
> +    WITH_QEMU_LOCK_GUARD(&s->lock) {
> +        found = bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset,
> +                                                  s->len, INT64_MAX,
> +                                                  &dirty_offset, &dirty_bytes);
> +    }
> +
> +    if (!found) {
> +        *count = s->len - offset;
> +        return;
> +    }
> +    dirty_end = dirty_offset + dirty_bytes;
> +
> +    if (*cached_end < dirty_end) {
> +        int64_t clusters;
> +        int64_t query_offset = MAX(dirty_offset, *cached_end);
> +        int ret = block_copy_is_cluster_allocated(s, query_offset, &clusters);
> +
> +        if (ret >= 0) {
> +            *cached_end = query_offset + clusters * s->cluster_size;
> +        } else {
> +            /* Best-effort: leave this area unmarked; it copies as data. */
> +            *cached_end = dirty_end;
> +        }
> +    }
> +
> +    /* 0 if the query above didn't yet reach dirty_end: try again next call. */
> +    *count = *cached_end >= dirty_end ? dirty_end - offset : 0;

Hm. In case of *count = 0, we'll call bdrv_dirty_bitmap_next_dirty_area() again and
again, to search for the same dirty area. For full backup (bitmap intialized to
full-dirty) and big fragmented source, this can become very expensive.

> +}
> +
>   /*
>    * Decide how @task is copied: COPY_WRITE_ZEROES if it reads as zero. May
>    * shrink @task. Returns false if @task is to be skipped (already ended,
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index e4e5b56753..3a61066b55 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -44,6 +44,10 @@ void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes);
>   int64_t coroutine_fn GRAPH_RDLOCK
>   block_copy_reset_unallocated(BlockCopyState *s, int64_t offset, int64_t *count);
>   
> +void coroutine_fn GRAPH_RDLOCK
> +block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
> +                                 int64_t *cached_end, int64_t *count);
> +
>   int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
>                               bool ignore_ratelimit, uint64_t timeout_ns,
>                               BlockCopyAsyncCallbackFunc cb,


-- 
Best regards,
Vladimir

