Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96158C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wtb-0005nR-D0; Mon, 07 Sep 2026 06:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3WtK-0005mq-1R; Mon, 07 Sep 2026 06:47:58 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3WtI-0007Ky-33; Mon, 07 Sep 2026 06:47:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0DEE43BB4;
 Mon,  7 Sep 2026 10:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39221F00A3A;
 Mon,  7 Sep 2026 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788778066;
 bh=uPakz6g9S6IYr3m3+2ruW1OMG9zJ4zlj5TBVznfTWkA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=E81t/CtSr5SLq3v7xrGPh/RwwLRSca7zGDclcO2BlsZCmBnRcEZuV2byJsXwnfQFI
 yYIVV8zuz52yJp3m0Y17z1+RqEnsV81ffxSPRF8R7ZT9B5DK5Q1SZM7TK6JxWXBqdS
 9WhpmxtViCdapkBkgG3SR7psWVJPkYy1t1ZKMHu28T+gdIwn2ByOBxAdpnx5hzk6tM
 doOZwaXCyd4D8HCgZgy+zkJ0ovlRfHSJrZp+gzqLneaBeOIi64flBJuPfyhJhV7AdP
 jhjjeVai3IkddWYMiDvss21jwCiSIbL/tL8DBtXF3Fjpm0trva9E0hwRMrZpkw9XlI
 E1USpMcsm3qVw==
Date: Mon, 7 Sep 2026 12:47:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 12/12] file-posix: reject a zone append to a full or
 conventional zone
Message-ID: <ap6WTkOuuXVqNEEw@ryzen>
References: <20260904161801.1568841-1-cassel@kernel.org>
 <20260904161801.1568841-13-cassel@kernel.org>
 <08401f4f-1bb6-4445-b157-9135458d32ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08401f4f-1bb6-4445-b157-9135458d32ea@kernel.org>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Sep 05, 2026 at 09:38:08AM +0900, Damien Le Moal wrote:
> On 9/5/26 01:18, Niklas Cassel wrote:
> > raw_co_prw() replaces the offset of a zone append with the write pointer
> > of the addressed zone, which assumes that the stored value names a
> > position inside that zone. It does not in two cases.
> > 
> > A full zone has its write pointer recorded at the end of the zone, since
> > get_zones_wp() stores start + len for BLK_ZONE_COND_FULL. That is the
> > first sector of the following zone, so the append is submitted there. The
> > kernel accepts it whenever that zone is empty, because it is a legal
> > write at its write pointer, and the completion path advances the wrong
> > zone because it recomputes the zone index from the replaced offset. The
> > data is written to a zone that was never addressed and success is
> > returned:
> > 
> >   zone 2 finished, then a 4 KiB append to zone 2:
> >   After zap done, the append sector is 0x180000     <- zone 3
> >   zone 2: wptr 0x180000, zcond:14 (full)
> >   zone 3: wptr 0x180008                             <- advanced
> > 
> > A conventional zone has no write pointer at all, and its array entry
> > carries only the type marker in the top bit, so the offset becomes
> > negative and the write fails with EINVAL. That is harmless but it reports
> > nothing about the actual mistake.
> > 
> > Reject both while the write pointer lock is held, since the state has to
> > be read and acted on atomically. check_zoned_request() in virtio-blk
> > refuses an append to a conventional zone, so that case needs a caller
> > that goes to the driver directly, but nothing there examines whether a
> > zone is full, so a guest can reach the misdirected write.
> > 
> > Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Looks good, modulo the comment below that needs to be addressed.
> With that fixed, feel free to add:
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> > diff --git a/block/io.c b/block/io.c
> > index b59c7fdf3e..452254bc63 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -3378,6 +3378,15 @@ uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
> >      return offset >> ctz64(bs->bl.zone_size);
> >  }
> >  
> > +bool bdrv_zone_is_full(BlockDriverState *bs, uint32_t index)
> > +{
> > +    uint64_t zone_end = MIN((uint64_t)(index + 1) * bs->bl.zone_size,
> 
> I think this should look at zone capacity, not size. For cases where we have
> zone cap < zone size, zone full condition is reached when the write pointer is
> at the zone capacity.

There is no concept of zone capacity in QEMU upstream yet.

It is added in Sam Li's QCOW2 zoned patch series.

But yes, I already have a patch that modifies bdrv_zone_is_full() to use
zone capacity rather than zone size, once it is introduced.


Kind regards,
Niklas

