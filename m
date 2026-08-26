Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BB7C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzA2x-0001nK-3o; Wed, 26 Aug 2026 05:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzA2v-0001mh-Bo; Wed, 26 Aug 2026 05:35:49 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzA2t-0002sj-7R; Wed, 26 Aug 2026 05:35:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id DE524C01E8;
 Wed, 26 Aug 2026 12:35:40 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a6b::1:10] (unknown
 [2a02:6bf:8080:a6b::1:10])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id dZZI4iOaYqM0-KyeR5U4f; Wed, 26 Aug 2026 12:35:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787736940;
 bh=92BnQscclCLPaIxwbL2XL3B+sVzyuom1iOJOgIilIr8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GjwObn1TtcwsEG3a8MZnIkHQ5Hcg8VintT3zOzbYf8clj92K7B6794nATo9gq5g5K
 xACqYQKXpDzh3zWHIEhOQHonthWWXXAyxwmCP4iTI5x6RTsfhUmt8iFDY+uKXtQhud
 tZMDSlScSRFCQL2J+2TvR5ZAxLBBRySoCyOmy42s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7b35c619-dcf7-45f7-b645-f3e6f18ce3ae@yandex-team.ru>
Date: Wed, 26 Aug 2026 12:35:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block/nbd: fix a race in reply processing
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260820115228.587427-1-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260820115228.587427-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 20.08.26 14:52, Denis V. Lunev wrote:
> s->reply is documented as protected by s->receive_mutex, but the cookie
> which owns it is cleared without that mutex. A request waiting for its
> own reply reads the very same field under the mutex, and reads it twice
> in a row, so the owner can clear it in between. The second read returns
> 0, COOKIE_TO_INDEX() turns that into an index of -1, and s->requests[]
> is accessed in front of the array:
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
> 
> requests[-1].receiving lands on in_flight, which is non-zero while
> requests are outstanding, so the read comes back true and the assertion
> fires. Without the assertion it is a plain out of bounds read.
> 
> This was hit in the field, on a virtio-blk disk whose backing chain ends
> in an NBD node, with the virtqueues of that disk spread over three
> iothreads. Two coroutines of one NBD node then run in different threads,
> which is what the race needs: there is no yield point between the two
> reads for the owner to squeeze into, so a single AioContext cannot
> produce it.
> 
> Patch 3 is the fix, patches 1 and 2 are what I ran into on the way to
> it. The order is dictated by patch 2: it routes every cookie to index
> conversion through a helper which checks the cookie, and for the cookie
> of the reply in flight that check only holds once patch 1 stops the
> error paths from leaving a value chosen by the server behind.
> 
> Reproduced with a scratch harness which drives one NBD client node from
> two AioContexts against a real qemu-nbd. At -O2 gcc merges all three
> reads of s->reply.cookie in nbd_receive_replies() into a single load, so
> the race is not observable at all in such a build; the gdb output above
> comes from an -O1 build of this branch with the two scratch commits on
> top. The report itself came from a build with coverage instrumentation,
> which is the kind of build that keeps the reads apart.
> 
> v1:
> https://lore.kernel.org/qemu-devel/20260812102906.894063-1-den@openvz.org/
> 
> Changes in v2
> -------------
> 
>   - patch 2: the helper takes an Error ** and checks every cookie, the
>     one taken from the wire included, so it is no longer called with an
>     exception; the callers which can only hand it a cookie of their own
>     pass &error_abort. (Vladimir)
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Denis V. Lunev (3):
>    block/nbd: clear reply.cookie when the reply is rejected
>    block/nbd: never index requests[] with an unchecked cookie
>    block/nbd: clear reply.cookie under receive_mutex
> 
>   block/nbd.c | 65 +++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 43 insertions(+), 22 deletions(-)
> 
> 
> base-commit: ae4f3443209ab154b48b706a146e5f557ab147cb

I think, we waited enough for comments:

Thanks, applied to my block branch.

-- 
Best regards,
Vladimir

