Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E79EC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfF8-0000pD-8T; Wed, 19 Aug 2026 08:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwfF3-0000oR-9F; Wed, 19 Aug 2026 08:18:01 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwfEz-0001WG-5C; Wed, 19 Aug 2026 08:18:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id D798DC0D1A;
 Wed, 19 Aug 2026 15:17:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c60::1:5] (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id hHV0PLDaiSw0-8z6q8yBk; Wed, 19 Aug 2026 15:17:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787141863;
 bh=ypfjAzUdoGwbkeXfTVYQcT358Z+4XRMqU4ExQ7vLrwo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ah+5GjcTNmx3lrjK1mh0XA/h9X3KfV0GvIzX5o7LbRhOkrQZ9gpv/W57Vyla+lf/K
 NxUp/rWtpDs+OAojojMTkaHT401M62qyhyouU5OP64MUw/2ARfKKrulSuAEdSuZ/6q
 aUtbl0LuaEj98bt/U9LB3ct3G5VJjo5zblSU17K8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ea0ace10-e6c6-4311-bfb4-ecf2352309f6@yandex-team.ru>
Date: Wed, 19 Aug 2026 15:17:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/nbd: clear reply.cookie under receive_mutex
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260812102906.894063-1-den@openvz.org>
 <20260812102906.894063-4-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260812102906.894063-4-den@openvz.org>
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
> s->reply is documented as protected by s->receive_mutex, but the cookie
> is cleared without it once the owning request has consumed its chunk.
> A waiter in nbd_receive_replies() inspects the very same field under
> the mutex, and does so with two separate loads:
> 
>      if (s->reply.cookie != 0) {
>          ind2 = COOKIE_TO_INDEX(s->reply.cookie);
>          assert(!s->requests[ind2].receiving);
> 
> Nothing keeps those two loads consistent. If the owner clears the
> cookie in between, the second one reads 0, COOKIE_TO_INDEX() turns it
> into an index of -1, and s->requests[] is accessed out of bounds:
> 
>    Assertion `!s->requests[ind2].receiving' failed.
> 
>    (gdb) p cookie
>    $1 = 8
>    (gdb) p s->reply.cookie
>    $2 = 0
>    (gdb) p &((NBDClientRequest *)s->requests)[-1].receiving
>    $3 = (_Bool *) 0x5555558416c0
>    (gdb) p &s->in_flight
>    $4 = (unsigned int *) 0x5555558416c0
>    (gdb) p s->in_flight
>    $5 = 8
> 
> The cookie we wait for is 8, yet reply.cookie reads 0 one line after it
> was found non-zero, so the index is -1. requests[-1].receiving lands on
> in_flight, which is non-zero while requests are outstanding, and that is
> what the assertion trips over.
> 
> Hitting this requires two coroutines of one NBD node to run in
> different threads, as there is no yield point between the two loads
> for the owner to squeeze into. A multiqueue configuration provides
> exactly that, with the virtqueues of one disk spread over several
> iothreads. Note that a compiler is free to merge the two loads into
> one, in which case the race is invisible, so builds with reduced
> optimization are much more likely to trip over it.
> 
> Accessing s->reply without the mutex is fine for the coroutine that
> owns the reply: a non-zero cookie makes the field private to it.
> Releasing that ownership is not, as it races with the waiters which
> are explicitly allowed to look at the cookie. Clear it under the
> mutex, in the same critical section as the wakeup, and make
> nbd_recv_coroutines_wake() caller-locked, as CoMutex is not
> recursive. It has a single caller.
> 
> The added acquisition cannot block behind the header read in
> nbd_receive_replies(), because that path is only reachable with
> reply.cookie == 0 while we still own a non-zero cookie. Merging the
> clear with the wakeup also keeps a newcomer from starting a header
> read in between, which would stall this already completed request for
> the duration of that read.
> 
> There is no cookie to own when we get here after an error, and then a
> newcomer can indeed be inside that read. It does not hold us for long
> either, as the channel has been shut down before the error was
> reported, so the read it sits in returns right away.
> 
> Fixes: 4ddb5d2fde ("block/nbd: drop connection_co")
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> Cc: Eric Blake<eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

