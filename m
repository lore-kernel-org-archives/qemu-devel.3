Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E79C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp491-0005JW-2W; Wed, 29 Jul 2026 09:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wp48v-0005Iu-9g; Wed, 29 Jul 2026 09:16:18 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wp48t-0006dy-D5; Wed, 29 Jul 2026 09:16:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21538600BB;
 Wed, 29 Jul 2026 13:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026691F00A3A;
 Wed, 29 Jul 2026 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785330964;
 bh=evAvWUfQ1WJQi9YR6wUf0+FTw/54fnlp+3u3zzxLd0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=L7G+QeFZKOIfCRV4DOv0UbUoNK+6rZ6WvHpQUsS/Tw0r54X1IV+xj0XxNp4kxyPSl
 vwOWqZn52ccVoGxQdnHMxVe5U5u7j5LmwjfXY8yTWDHneyuYdIaILzV2gxFwHtOPrS
 6Ge60HTInb52iXCRjBydsIwNrTzarnJBxssbcjJMYiaEo/XzmE0eBlIhqZQ5skVwr4
 zn5dJp2li6M+IKB9MkS5e4rH2RsUCAQlj3X8w+hEruN/B7jvdkj3EVth1RsYjlkbZx
 /Mf/XvuAfpAlQfUZw+s1g8RL8Z70V/LXGh8uUCMc1b4Pbcid64gCemc2mM9Zpta8P9
 ENwQARI81OZRg==
Date: Wed, 29 Jul 2026 15:16:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] file-posix: fix cache.direct=on check for zoned block
 devices
Message-ID: <amn9EN4bj7YLpyIB@ryzen>
References: <20260617133658.2022750-1-cassel@kernel.org>
 <20260618150025.GC720244@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618150025.GC720244@fedora>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 18, 2026 at 11:00:25AM -0400, Stefan Hajnoczi wrote:
> On Wed, Jun 17, 2026 at 03:36:58PM +0200, Niklas Cassel wrote:
> > For zoned block devices with SWR zones, the order of the writes must be
> > maintained to avoid write not at write pointer errors.
> > Thus, cache.direct=on must be used to bypass the page cache, since the
> > page cache uses write-back caching, where the physical order of the writes
> > is not guaranteed.
> > 
> > There is already a check for cache.direct=on in raw_open_common(),
> > however, this check is done before raw_refresh_zoned_limits() has been
> > called (which initializes bs->bl.zoned), so it is currently dead code.
> > 
> > Fix this by moving the check to raw_refresh_zoned_limits(), such that the
> > check is done after bs->bl.zoned has been initialized.
> > 
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > Fixes: 774c726ceb2a ("block: add zoned BlockDriver check to block layer")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v1:
> > -Picked up tags from Damien and Dmitry
> > -Modified existing code comment to use plural instead of singular
> > 
> >  block/file-posix.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Gentle ping on this patch.

Would be nice if anyone could pick it up :)


Kind regards,
Niklas

