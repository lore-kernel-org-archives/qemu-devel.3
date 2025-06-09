Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEE2C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdrp-0001yu-Dc; Mon, 09 Jun 2025 10:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOdrn-0001yI-5o; Mon, 09 Jun 2025 10:52:51 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOdrk-0000xi-KZ; Mon, 09 Jun 2025 10:52:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 732B260CDF;
 Mon,  9 Jun 2025 17:52:44 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a98::1:26] (unknown
 [2a02:6bf:8080:a98::1:26])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hqiHwO8FeW20-wwA4giur; Mon, 09 Jun 2025 17:52:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749480763;
 bh=qqlL+gfILre4QunlojxfP1/EQMHxxZuLkpi1dGwyrhY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iVqQwvBtzkIderxhy9h3DaWnyilA/FHkVNArwKNCsfafUCn3RNlFWmK9p9WsHYw58
 kwAjI/FSGm/y5chO6gQA6s6kT8Xc+7IjYr6GgJgHS4qeMvNPc4At7u1k6nNUcAKL74
 Gkkz9UVrk7SdbgfO3YVnymDmCA2KXr+rSU7aHJ58=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <26000017-b3d4-4383-aeb3-557306aa0703@yandex-team.ru>
Date: Mon, 9 Jun 2025 17:52:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] block/copy-before-write: report partial block
 status to snapshot
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
References: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
 <20250528120732.2247150-5-andrey.zhadchenko@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250528120732.2247150-5-andrey.zhadchenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 28.05.25 15:07, Andrey Zhadchenko wrote:
> until the non-accessible area

Please write a bit more: what, why and how. What is the scenario when this change helps? I think the client of snapshot-access, should not try to read/get-block-status from "denied" areas?

Also, it's a lot more comfortable to read messages, starting from a full sentence, not just continuing a sentence of subject. It's OK to repeat the subject, may be in more detailed form.

> 
> Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
> ---
>   block/copy-before-write.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index 7e074ad569..c5e6e1c112 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -207,10 +207,11 @@ static int coroutine_fn GRAPH_RDLOCK cbw_co_flush(BlockDriverState *bs)
>    */

the comment above the function should be updated to cover new logic

>   static BlockReq * coroutine_fn GRAPH_RDLOCK
>   cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
> -                       int64_t *pnum, BdrvChild **file)
> +                       int64_t *pnum, BdrvChild **file, bool query)
>   {
>       BDRVCopyBeforeWriteState *s = bs->opaque;
>       BlockReq *req = g_new(BlockReq, 1);
> +    int64_t next_dirty;
>       bool done;
>   
>       QEMU_LOCK_GUARD(&s->lock);
> @@ -220,9 +221,13 @@ cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
>           return NULL;
>       }
>   
> -    if (bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes) != -1) {
> -        g_free(req);
> -        return NULL;
> +    next_dirty = bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes);
> +    if (next_dirty != -1) {
> +        if (!query || next_dirty == offset) {
> +            g_free(req);
> +            return NULL;
> +        }
> +        bytes = offset + bytes - next_dirty;

I don't follow. Shouldn't this be

     bytes = next_dirty - offset

I.e., number of bytes from offset up to first "denied" byte.

>       }
>   
>       done = bdrv_dirty_bitmap_status(s->done_bitmap, offset, bytes, pnum);
> @@ -270,7 +275,8 @@ cbw_co_preadv_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes,
>       while (bytes) {
>           int64_t cur_bytes;
>   
> -        req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &file);
> +        req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &file,
> +                                     false);
>           if (!req) {
>               return -EACCES;
>           }
> @@ -302,7 +308,7 @@ cbw_co_snapshot_block_status(BlockDriverState *bs,
>       int64_t cur_bytes;
>       BdrvChild *child;
>   
> -    req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &child);
> +    req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &child, true);
>       if (!req) {
>           return -EACCES;
>       }

-- 
Best regards,
Vladimir


