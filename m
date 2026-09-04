Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5846C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2aJh-000391-7N; Fri, 04 Sep 2026 16:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x2aJf-000381-L2; Fri, 04 Sep 2026 16:15:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x2aJd-0001kR-3x; Fri, 04 Sep 2026 16:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1788552875; bh=1WcCCGfI7GXe0lY6xWdRNUMR8mENsppKe4GyBjrBYmc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tig2FuFVy45YBIR5DmaPhGP5vyirv4CZkcc1eFCXGmuZAHuuyT/NXbsTNTDC/VeMB
 2idac5YhapzZ7/DO4HPCZwJ5RiDdlITAHHZ7/fVOoIcMRJ4S/fCQWSZOPbvt1OZ4e/
 JCFpTJYMqAsJn/5OqjXKOQVVni4BWcFEFMjwRWxhhSsY+PTPgPxxqR24WdDS1pAS3G
 ofrvaOF/XEY5wnckkvfTCQw/NTVIj2ZA0R/F4lMVKAm20SWosFYE+4o/yFh0a4PV4Y
 GfxrFXcMHe7n7PhI1733Zz5S4vmY9THYm4xDcCAamh0DhAJuGf4KrUgnDmreFDlWZg
 2v9aj8S7MqCjw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 22B031D1BB9;
 Fri, 04 Sep 2026 23:14:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 83477420D72;
 Fri, 04 Sep 2026 23:14:54 +0300 (MSK)
Message-ID: <aacc2da7-2bb7-4964-b416-a8b795f3c142@tls.msk.ru>
Date: Fri, 4 Sep 2026 23:14:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block/nbd: fix a race in reply processing
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260820115228.587427-1-den@openvz.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260820115228.587427-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/20/26 14:52, Denis V. Lunev wrote:
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

> Denis V. Lunev (3):
>    block/nbd: clear reply.cookie when the reply is rejected
>    block/nbd: never index requests[] with an unchecked cookie
>    block/nbd: clear reply.cookie under receive_mutex
> 
>   block/nbd.c | 65 +++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 43 insertions(+), 22 deletions(-)

This too looks like a good candidate for the stable qemu series.
I guess it's the same situation as with changes in the IDE subsystem,
when the changes are tricky enough to have some doubts about their
correctness?

I'm queuing this series up for the next-to-next stable series :)
Please let me know if I shouldn't do that.

Thanks,

/mjt

