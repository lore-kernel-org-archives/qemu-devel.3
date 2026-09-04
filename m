Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C46C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WQ1-00017L-Oj; Fri, 04 Sep 2026 12:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WPr-0000s9-MY; Fri, 04 Sep 2026 12:05:24 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WPk-0006Bz-UX; Fri, 04 Sep 2026 12:05:23 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 123A9439F3;
 Fri,  4 Sep 2026 16:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1715F1F00A3E;
 Fri,  4 Sep 2026 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788537911;
 bh=0/+cQdU9QiAMH9awHwUK1+cWU1qxHmtmjfG/sYWSvHs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ld7gLLE7jhs8QgDwwxP8A7/vdBRxIjWhKScRPTvpb1myv29lkrCLVhv1Kmmq5j8ZO
 Jk8xhktxFkwwKVjG+XLNE8cnxbT/y8RzZpKZ/E0oOUO+g6Jpg41hqynvYzxskorQZN
 6j8rWN33vYA4O0hK3LF+3qAgd2V+B7RztlwMGcd/zAOasWnXVKDxaw2ZOZWlrYSc05
 K5D7gDi5yD/UBXisrDwON08TMj1YAA+hG/NsmiwNjNv8gFvTxKTPhej+cxkr+xrW8N
 yysiSUpjIw/eIW3/mCtszj75msZMA7SDcODBtA5NpalT4qbQVdfyWSresr29YZ5gcR
 gsXe25trMYjrQ==
Date: Fri, 4 Sep 2026 18:05:06 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 04/11] virtio-blk: check the write granularity of
 writes to sequential zones
Message-ID: <aprsMv0_DgfmMf9M@ryzen>
References: <20260902194423.759355-1-cassel@kernel.org>
 <20260902194423.759355-5-cassel@kernel.org>
 <d4b0f1a3-02b5-417e-928a-808b065e7cc2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b0f1a3-02b5-417e-928a-808b065e7cc2@kernel.org>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
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

On Thu, Sep 03, 2026 at 09:51:01AM +0900, Damien Le Moal wrote:
> On 9/3/26 04:44, Niklas Cassel wrote:
> > All VIRTIO_BLK_T_OUT requests issued to sequential zones and all
> > VIRTIO_BLK_T_ZONE_APPEND requests must have an offset and a data size
> > that are multiples of the write granularity reported by the device
> > (virtio 1.4, 5.2.6.1), and a violation is reported as
> > VIRTIO_BLK_S_ZONE_UNALIGNED_WP (virtio 1.4, 5.2.6).
> > 
> > Neither request type was fully checked. Zone appends validated only the
> > offset, while writes were not checked at all.
> > 
> > Check the size of the appended data, and both the offset and the size of
> > a write, against blkconf_zone_write_granularity(), so that every request the
> > device accepts is one that the guest driver was told is valid. Writes to
> > conventional zones keep no alignment constraint beyond the logical block
> > size. The write path performs the check after virtio_blk_sect_range_ok()
> > so that the zone index derived from the guest supplied sector is known to
> > be in range.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  hw/block/virtio-blk.c | 37 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index b22aed04a1..247af53ae2 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -398,6 +398,32 @@ static bool virtio_blk_sect_range_ok(VirtIOBlock *dev,
> >      return true;
> >  }
> >  
> > +/*
> > + * Both the offset and the size of a write to a sequential zone must be a
> > + * multiple of the write granularity that the device reports. Conventional
> > + * zones are not constrained. The zone index is derived from a guest supplied
> > + * sector, so this must only be called once virtio_blk_sect_range_ok() has
> > + * bounded it.
> > + */
> > +static bool virtio_blk_zone_write_granularity_ok(VirtIOBlock *dev,
> > +                                                 uint64_t sector, size_t size)
> > +{
> > +    BlockDriverState *bs = blk_bs(dev->blk);
> > +    uint64_t offset = sector << BDRV_SECTOR_BITS;
> > +    uint32_t wg_mask;
> > +
> > +    if (bs->bl.zoned == BLK_Z_NONE) {
> > +        return true;
> > +    }
> > +
> > +    wg_mask = blkconf_zone_write_granularity(&dev->conf.conf) - 1;
> > +    if (!(offset & wg_mask) && !(size & wg_mask)) {
> > +        return true;
> > +    }
> > +
> > +    return BDRV_ZT_IS_CONV(bs->wps->wp[offset / bs->bl.zone_size]);
> > +}
> 
> Even though in practice I do not think it would ever happen, technically,
> conventional zones are not bound by the physical sector size/write granularity
> and can accept LBA aligned writes even when LBA size < physical block size
> (write granularity).

Well, that is how the code works already :)

And the function comment does also already say that conventional
zones are not constrained.

Yes, I guess swapping the order does make the code slightly easier to read,
so let me do that.


> 
> SO I think this should be:
> 
> +static bool virtio_blk_zone_write_granularity_ok(VirtIOBlock *dev,
> +                                                 uint64_t sector, size_t size)
> +{
> +    BlockDriverState *bs = blk_bs(dev->blk);
> +    uint64_t offset = sector << BDRV_SECTOR_BITS;
> +    uint32_t wg_mask;
> +
> +    if (bs->bl.zoned == BLK_Z_NONE) {
> +        return true;
> +    }
> +
> +    if (BDRV_ZT_IS_CONV(bs->wps->wp[offset / bs->bl.zone_size]) {
> +        return true;
> +    }
> +
> +    wg_mask = blkconf_zone_write_granularity(&dev->conf.conf) - 1;
> +    return !(offset & wg_mask) && !(size & wg_mask);
> +}
> 
> Side note not for this patch: it really would be nice to have a helper that
> gives a zone number from an offset, using a bit shift (bs->bl.zone_size_shift)
> instead of a costly division.

Will add a helper as a new patch.


Kind regards,
Niklas

