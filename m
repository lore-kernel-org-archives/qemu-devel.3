Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228E6C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wzh-00079k-2y; Wed, 16 Sep 2026 17:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x6wze-00079E-Ge; Wed, 16 Sep 2026 17:16:38 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x6wzc-0004Wh-Fc; Wed, 16 Sep 2026 17:16:38 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2ECE74036F;
 Wed, 16 Sep 2026 21:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB781F000FF;
 Wed, 16 Sep 2026 21:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789593391;
 bh=xaGNt5x3yXI1AdTj8Y1f3qi4/X1vi2tpkvNlsux1V1Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B8f1/DrxaECCwD74kedbsLShOwh5tXGhL87cviyhbF0xeQqu3v+/7ZLveqHshw80g
 e2KEq0+dGQbklEgE7aoocCn6OvdmepBIov8TiXEaxwS35Je6YRm3ChaoIsyinSlwp+
 QY/VTm5jGx7NZoHTmb3Mie5blavfBUilFOBAqpRfpgtGHjr3jKL/L7MfDLd0Gd8JX7
 qGM6/m+F2KKnfpHMnx8fFnAX5RrTeGANA8TrNUUnIEwV5fyDh6xFy4iz2hg5VEuDTB
 8OT+Y6VFDHQPXsZLtjkvowYvFJX/+293F4AJTorr88SMcNcJTTDHJJkqyzQ4zHQfvO
 6778g0h6gPw7w==
Date: Wed, 16 Sep 2026 23:16:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/12] virtio-blk: derive the maximum zone append size
Message-ID: <aqsHK1AeZ_q34TMb@ryzen>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-11-cassel@kernel.org>
 <20260909185247.GJ20134@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909185247.GJ20134@fedora>
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

On Wed, Sep 09, 2026 at 02:52:47PM -0400, Stefan Hajnoczi wrote:
> On Mon, Sep 07, 2026 at 01:07:45PM +0200, Niklas Cassel wrote:
> > @@ -1313,7 +1330,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
> >          virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
> >                       blkconf_zone_write_granularity(conf));
> >          virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
> > -                     bs->bl.max_append_sectors);
> > +                     virtio_blk_max_append_sectors(s));
> 
> This has the same issue as the write_granularity patch earlier in this
> patch series, except that max_append_sectors was already exposing the
> BlockBackends BlockLimits, which we shouldn't do.

If we can't derive it from any field in bs->blk, then the best thing I can
think of (that hay precedence) is to add a virtio-blk property:

DEFINE_PROP_UINT32("max-append-sectors", VirtIOBlock,
                   conf.max_append_sectors, BDRV_REQUEST_MAX_SECTORS),

Since it is very similar to the existing virtio-blk properties:

    DEFINE_PROP_UINT32("max-discard-sectors", VirtIOBlock,                      
                       conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS),     
    DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,                 
                       conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),



However, your argument reaches beyond this patch:
zoned.model, zone_sectors, max_open_zones and max_active_zones are all
read from bs->bl in virtio_blk_update_config(), and VIRTIO_BLK_F_ZONED
itself is set from bs->bl.zoned at realize.

Should I just let them be?

Seems out of scope of this series, but following your argument, I'm
wondering if they shouldn't have been virtio-blk properties as well.


Kind regards,
Niklas

