Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A80C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwf7M-0006fS-KP; Wed, 19 Aug 2026 08:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwf7K-0006f7-AM; Wed, 19 Aug 2026 08:10:02 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwf7H-0008VF-NH; Wed, 19 Aug 2026 08:10:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:118b:0:640:b49:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 7394280603;
 Wed, 19 Aug 2026 15:09:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c60::1:5] (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id r9V4J31e94Y0-FYQ7RuiV; Wed, 19 Aug 2026 15:09:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787141393;
 bh=vthY8+x7q1hpfG5ceEEbt+Ecx3kbikIDAjuYFiFrvNg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lpMlz4sJ/4Dpk6ZsPp8t6MfEsG3yRFOTyVsUcgRcNjXyK/IvNrinp9pAzwYi6CHuR
 q38Ca5dleNZFqs3IE/5LgI1zlP+Wb1BhfQBI2KyJppTxH3NUUdWmjopYjUcjRxYkHs
 uTSQdXX61TQphc9XWcMSAOPXWd+bywTZFRyHPLM4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4378dac7-cca1-4b4b-857a-c67cc454c1d9@yandex-team.ru>
Date: Wed, 19 Aug 2026 15:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block/nbd: never index requests[] with an unchecked
 cookie
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260812102906.894063-1-den@openvz.org>
 <20260812102906.894063-3-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260812102906.894063-3-den@openvz.org>
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

On 12.08.26 13:29, Denis V. Lunev wrote:
> Cookies are converted into indices of s->requests[] in several places
> and the result is used right away, without any check:
> 
>      int i = COOKIE_TO_INDEX(cookie);
>      ...
>      return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,
> 
> COOKIE_TO_INDEX() subtracts one, so a zero cookie becomes an index of
> -1 and the access lands in front of the array. This is undefined and,
> depending on the type of the index and on what the compiler has put
> there, it can as well pass silently: at the site above i is signed, so
> even a plain i < MAX_NBD_REQUESTS check would happily let -1 through.
> 
> The only cookie which is checked today is the one taken from the wire,
> in nbd_receive_replies(), where an invalid value is a protocol error
> rather than an internal inconsistency and thus has to stay a channel
> error. Route every other conversion through a helper which asserts the
> range before it returns the slot, so that the check can not be
> forgotten again.
> 
> The cookie of the reply in flight goes through the helper as well. It
> is not an unchecked value: it has either passed the check above, or it
> has been cleared by the previous commit, so a stale index there is an
> internal inconsistency too.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   block/nbd.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index d9b776283f..21f0f9d40d 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -136,6 +136,16 @@ static void nbd_clear_bdrvstate(BlockDriverState *bs)
>       s->x_dirty_bitmap = NULL;
>   }
>   
> +/* Not for cookies coming from the wire, those are checked separately. */

Still, I think, if we do such a wrapper, better to call it always with no
exclusions.

For example, add errp, and pass &error_abort when don't expect an error.

> +static NBDClientRequest *nbd_request_by_cookie(BDRVNBDState *s, uint64_t cookie)
> +{
> +    uint64_t ind = COOKIE_TO_INDEX(cookie);
> +
> +    assert(ind < MAX_NBD_REQUESTS);
> +
> +    return &s->requests[ind];
> +}
> +
>   /* Called with s->receive_mutex taken.  */
>   static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
>   {
> @@ -422,7 +432,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
>                                               Error **errp)
>   {
>       int ret;
> -    uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
> +    NBDClientRequest *req = nbd_request_by_cookie(s, cookie);
> +    uint64_t ind2;
>       QEMU_LOCK_GUARD(&s->receive_mutex);
>   
>       while (true) {
> @@ -437,10 +448,9 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
>                * woken by whoever set s->reply.cookie (or never wait in this
>                * yield). So, we should not wake it here.
>                */
> -            ind2 = COOKIE_TO_INDEX(s->reply.cookie);
> -            assert(!s->requests[ind2].receiving);
> +            assert(!nbd_request_by_cookie(s, s->reply.cookie)->receiving);
>   
> -            s->requests[ind].receiving = true;
> +            req->receiving = true;
>               qemu_co_mutex_unlock(&s->receive_mutex);
>   
>               qemu_coroutine_yield();
> @@ -454,7 +464,7 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
>                */
>   
>               qemu_co_mutex_lock(&s->receive_mutex);
> -            assert(!s->requests[ind].receiving);
> +            assert(!req->receiving);
>               continue;
>           }
>   
> @@ -861,7 +871,6 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
>   {
>       ERRP_GUARD();
>       int ret;
> -    int i = COOKIE_TO_INDEX(cookie);
>       void *local_payload = NULL;
>       NBDStructuredReplyChunk *chunk;
>   
> @@ -919,8 +928,8 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
>               return -EINVAL;
>           }
>   
> -        return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,
> -                                                  qiov, errp);
> +        return nbd_co_receive_offset_data_payload(
> +                s, nbd_request_by_cookie(s, cookie)->offset, qiov, errp);
>       }
>   
>       if (nbd_reply_type_is_error(chunk->type)) {
> @@ -1067,7 +1076,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
>   
>   break_loop:
>       qemu_mutex_lock(&s->requests_lock);
> -    s->requests[COOKIE_TO_INDEX(cookie)].coroutine = NULL;
> +    nbd_request_by_cookie(s, cookie)->coroutine = NULL;
>       s->in_flight--;
>       qemu_co_queue_next(&s->free_sema);
>       qemu_mutex_unlock(&s->requests_lock);


-- 
Best regards,
Vladimir

