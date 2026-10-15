Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747D0CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHH10-000450-KJ; Thu, 15 Oct 2026 04:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHH0n-0003xY-Ls; Thu, 15 Oct 2026 04:40:32 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHH0j-0000MX-QK; Thu, 15 Oct 2026 04:40:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-16.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-16.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:4d0c:0:640:10b6:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id B34DE805EB;
 Thu, 15 Oct 2026 11:40:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-16.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id KeQxjX02AiE0-wkFVmDhx; Thu, 15 Oct 2026 11:40:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792053621;
 bh=L0LfsFXaHpNZXobf3VFtajIVaKG7Cg4xiVEhUNV1UhI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fCt6WEDVp2KEyMWUlkessPAi3PshvsDk5ske7KrfEiJCvREUdJtw0U4zvag5BwgWZ
 pJM7UzRe+wsFT6PmYlxHM6e4QKP4vnsymhgbS1qTreDBmdWok71lySlpcbYaDNKK46
 ddYF+bWzOTAPIUSH5ma4FdV1i2KHcv7kFBKr4zgQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-16.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ca33ede3-3303-4fe7-a3f1-2c02d8661c86@yandex-team.ru>
Date: Thu, 15 Oct 2026 11:40:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] block/block-copy: don't reserve memory for zero
 tasks
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-6-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-6-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
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
> block_copy_dirty_clusters() charges task->req.bytes to the shared memory
> pool for every task, but a COPY_WRITE_ZEROES task allocates no bounce
> buffer, so there is nothing to account for. Add
> block_copy_task_shres_bytes() and use it at all three call sites.
> 
> Zero tasks lose the throttling the pool gave them incidentally and are
> bounded only by BLOCK_COPY_MAX_WORKERS (64).
> 
> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Still, this commit leaves extra mutex locking for accounting zero bytes
in shres. Worth checking for n==0 in co_*_shres functions.

> ---
>   block/block-copy.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 1826c2e1c7..21ebe8aec2 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -453,6 +453,11 @@ void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
>       s->progress = pm;
>   }
>   
> +static uint64_t block_copy_task_shres_bytes(BlockCopyTask *task)
> +{
> +    return task->method == COPY_WRITE_ZEROES ? 0 : task->req.bytes;
> +}
> +
>   /*
>    * Takes ownership of @task
>    *
> @@ -474,7 +479,7 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
>   
>       aio_task_pool_wait_slot(pool);
>       if (aio_task_pool_status(pool) < 0) {
> -        co_put_to_shres(task->s->mem, task->req.bytes);
> +        co_put_to_shres(task->s->mem, block_copy_task_shres_bytes(task));
>           block_copy_task_end(task, -ECANCELED);
>           g_free(task);
>           return -ECANCELED;
> @@ -605,7 +610,7 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
>               progress_work_done(s->progress, t->req.bytes);
>           }
>       }
> -    co_put_to_shres(s->mem, t->req.bytes);
> +    co_put_to_shres(s->mem, block_copy_task_shres_bytes(t));
>       block_copy_task_end(t, ret);
>   
>       if (s->discard_source && ret == 0) {
> @@ -816,7 +821,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
>   
>           trace_block_copy_process(s, task->req.offset);
>   
> -        co_get_from_shres(s->mem, task->req.bytes);
> +        co_get_from_shres(s->mem, block_copy_task_shres_bytes(task));
>   
>           offset = task_end(task);
>           bytes = end - offset;


-- 
Best regards,
Vladimir

