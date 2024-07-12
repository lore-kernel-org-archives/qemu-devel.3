Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD88C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFIc-0004Uh-Lt; Fri, 12 Jul 2024 08:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFIX-0004QQ-5d; Fri, 12 Jul 2024 08:22:50 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFIS-0002Ks-Bk; Fri, 12 Jul 2024 08:22:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id DC65E61981;
 Fri, 12 Jul 2024 15:22:38 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:5fb9:9623:463f:792c] (unknown
 [2a02:6b8:0:419:5fb9:9623:463f:792c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cMfbx71IdKo0-bf9ihY0x; Fri, 12 Jul 2024 15:22:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1720786958;
 bh=ZRRUjjOvdOdx0iK1gMb0+lvS02BuVY7zYVqBXrtYgsQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Rq/hYqjs11BdqPbQfsdJtqthEuPcY5K20O1YqG+Shdt7twlnXn/YknSAznMsjP0Da
 0L9IT1rb20ftpua1JXFSTYH9g/Ujyt7/UtRQQDRxypGOJLaxbCDIQTTwmiEwqpf7ap
 WZPFx2TgHXrXeYJoysWpMLq/1f1Uwg0BqT6/FJrE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2d88a110-4038-4ebc-b373-92db2750d5ec@yandex-team.ru>
Date: Fri, 12 Jul 2024 15:22:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: zero data data corruption using prealloc-filter
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, eesposit@redhat.com, den@virtuozzo.com
References: <20240711133242.251061-1-andrey.drobyshev@virtuozzo.com>
 <20240711133242.251061-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240711133242.251061-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11.07.24 16:32, Andrey Drobyshev wrote:
> From: "Denis V. Lunev" <den@openvz.org>
> 
> We have observed that some clusters in the QCOW2 files are zeroed
> while preallocation filter is used.
> 
> We are able to trace down the following sequence when prealloc-filter
> is used:
>      co=0x55e7cbed7680 qcow2_co_pwritev_task()
>      co=0x55e7cbed7680 preallocate_co_pwritev_part()
>      co=0x55e7cbed7680 handle_write()
>      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>      co=0x7f9edb7fe500 do_fallocate()
> 
> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
> time to handle next coroutine, which
>      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>      co=0x55e7cbee91b0 handle_write()
>      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>      co=0x7f9edb7deb00 do_fallocate()
> 
> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
> the same area. This means that if (once fallocate is started inside
> 0x7f9edb7deb00) original fallocate could end and the real write will
> be executed. In that case write() request is handled at the same time
> as fallocate().
> 
> Normally we should protect s->file_end while it is detected that
> preallocation is need. The patch introduces file_end_lock for it to be
> protected when run in the coroutine context.
> 
> Note: the lock is taken only once it is detected that the preallocation
> is really required. This is not a frequent case due to the preallocation
> nature thus the patch should not have performance impact.
> 
> Originally-by: Denis V. Lunev <den@openvz.org>
> Co-authored-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/preallocate.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/block/preallocate.c b/block/preallocate.c
> index d215bc5d6d..9cb2c97635 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -78,6 +78,8 @@ typedef struct BDRVPreallocateState {
>   
>       /* Gives up the resize permission on children when parents don't need it */
>       QEMUBH *drop_resize_bh;
> +
> +    CoMutex file_end_lock;
>   } BDRVPreallocateState;
>   
>   static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
> @@ -170,6 +172,8 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>               bs->file->bs->supported_zero_flags);
>   
> +    qemu_co_mutex_init(&s->file_end_lock);
> +
>       return 0;
>   }
>   
> @@ -342,6 +346,7 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>               return false;
>           }
>   
> +        QEMU_LOCK_GUARD(&s->file_end_lock);
>           if (s->file_end < 0) {
>               s->file_end = s->data_end;
>           }
> @@ -353,6 +358,8 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>   
>       /* We have valid s->data_end, and request writes beyond it. */
>   
> +    QEMU_LOCK_GUARD(&s->file_end_lock);
> +
>       s->data_end = end;
>       if (s->zero_start < 0 || !want_merge_zero) {
>           s->zero_start = end;
> @@ -428,6 +435,8 @@ preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>       BDRVPreallocateState *s = bs->opaque;
>       int ret;
>   
> +    QEMU_LOCK_GUARD(&s->file_end_lock);
> +
>       if (s->data_end >= 0 && offset > s->data_end) {
>           if (s->file_end < 0) {
>               s->file_end = bdrv_co_getlength(bs->file->bs);
> @@ -501,6 +510,8 @@ preallocate_co_getlength(BlockDriverState *bs)
>           return s->data_end;
>       }
>   
> +    QEMU_LOCK_GUARD(&s->file_end_lock);
> +
>       ret = bdrv_co_getlength(bs->file->bs);
>   
>       if (has_prealloc_perms(bs)) {


Hmm, seems preallocate driver not thread-safe neither coroutine-safe. I think co-mutex is good idea. Still, protecting only s->file_end may be not enough

- we do want to keep data_end / zero_start / file_end variables correct
- probably, just make the whole preallocation code a critical section? Maybe, atomic read of variables for fast-path (for writes which doesn't need preallocation)


-- 
Best regards,
Vladimir


