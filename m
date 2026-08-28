Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81436C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpp4-0001Ue-Hs; Fri, 28 Aug 2026 02:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpoz-0001BT-Ef; Fri, 28 Aug 2026 02:12:13 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpox-0001Xv-4y; Fri, 28 Aug 2026 02:12:13 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B94260A8B;
 Fri, 28 Aug 2026 06:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3C81F000E9;
 Fri, 28 Aug 2026 06:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897529;
 bh=UFPElJnUXqTd55dttDAu3yb9ihVgM0+HLoF3lSR03Mw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bop4OAJQdY3iHZkooq/5ENSEl+5/Le4U19me6LSPpvx+RCrgUflgSAVh+h34eXSMi
 Jq31knm3ru32hWvbswwMd5DL2lfVsdP9Aggua7aeNIFzp9Tvx2EDMnGgfEFjZbKMte
 zxZAOgD0pz+tqHD/Ngp/takW86xzbTq/HtpbB12gLpp1lrEndV+mjMO4vOPpUHCwQa
 YhoIAWW2GZ3WfjuxypG3JfPDmXHXQnRm+ErGEMRG3pxYN4LRKOs2HyzH5rEbEdcNT8
 4N3LvIIEv6TQj8o6Nw+Y7RHTwCRJB2GCiQOwVap2ss/ChwtDPFaGN9qrTc67XEsXoy
 IS+6n8Y9huzmQ==
Message-ID: <38424bc3-c8d7-4167-9b5d-b139becea55e@kernel.org>
Date: Fri, 28 Aug 2026 15:12:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/block: reject a zoned device whose write
 pointers are unaddressable
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-7-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=dlemoal@kernel.org;
 helo=tor.source.kernel.org
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

On 8/26/26 05:57, Niklas Cassel wrote:
> The write pointers of a zoned device outlive any particular use of it,
> whether the device keeps them itself or a backend records them, while the
> logical block size is a property of the frontend and is chosen afresh
> every time the device is attached. Nothing ties the two together. A zone
> written while the device was configured with logical_block_size=512
> leaves a write pointer that is a multiple of 512, and attaching the same
> device with logical_block_size=4096 makes that pointer unaddressable.
> 
> Such a pointer is not merely misaligned. The guest addresses the device
> in logical blocks, and a zone report expresses the write pointer in 512
> byte sectors, so the guest is told about a position that does not fall on
> a logical block boundary. It can neither read nor write there, and the
> zone can only be recovered by resetting it. The reverse direction is
> harmless: a pointer laid down with a larger logical block size is still a
> multiple of a smaller one.
> 
> On a zoned null_blk device with a logical block size of 512, a 512 byte
> append to a sequential zone leaves the write pointer half a logical block
> into it:
> 
>   $ qemu-io --image-opts -n driver=host_device,filename=/dev/nullb0 \
>         -c "zap -p 0x20000000 0x200" -c "zrp 0x20000000 1"
>   start: 0x100000, len 0x80000, cap 0x80000, wptr 0x100001, zcond:2
> 
> Attaching that disk with logical_block_size=4096 handed the guest a zone
> it could not write to.
> 
> Check at realize time that the zone size and every write pointer of a
> sequential zone are multiples of the write granularity that the device is
> about to report, and refuse to start otherwise. The write pointers are
> already held in memory by the driver, so this costs no I/O.
> 
> The check uses blkconf_zone_write_granularity(), the same value that a
> frontend reports to its guest and validates requests against, so the
> three cannot disagree.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/block.c         | 46 ++++++++++++++++++++++++++++++++++++++++
>  hw/block/virtio-blk.c    |  4 ++++
>  include/hw/block/block.h |  1 +
>  3 files changed, 51 insertions(+)
> 
> diff --git a/hw/block/block.c b/hw/block/block.c
> index 1c3135843d..b908e0ef64 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -208,6 +208,52 @@ uint32_t blkconf_zone_write_granularity(BlockConf *conf)
>      return MAX(bs->bl.write_granularity, conf->logical_block_size);
>  }
>  
> +bool blkconf_zoned(BlockConf *conf, Error **errp)
> +{
> +    BlockDriverState *bs = blk_bs(conf->blk);
> +    uint32_t wg;
> +
> +    if (bs->bl.zoned == BLK_Z_NONE) {

This test and the name of the function are making things very confusing...
Maybe rename the function: blkconf_zoned_alignement_ok() or something like that?

> +        return true;
> +    }
> +
> +    wg = blkconf_zone_write_granularity(conf);
> +
> +    if (!QEMU_IS_ALIGNED(bs->bl.zone_size, wg)) {
> +        error_setg(errp, "zone size %" PRIu64 " is not a multiple of the zone "
> +                   "write granularity %" PRIu32, bs->bl.zone_size, wg);
> +        return false;
> +    }
> +
> +    /*
> +     * A write pointer that is not a multiple of the write granularity does not
> +     * fall on a logical block boundary, so the guest can neither read nor write
> +     * at it and the zone can only be recovered by resetting it. A backend that
> +     * records its write pointers, rather than reading them back from a device,
> +     * can hand us such a pointer when the zones were written while the device
> +     * was configured with a smaller logical block size.
> +     */
> +    for (uint32_t i = 0; i < bs->bl.nr_zones; i++) {
> +        uint64_t wp = bs->wps->wp[i];
> +
> +        if (BDRV_ZT_IS_CONV(wp)) {
> +            continue;
> +        }
> +
> +        if (!QEMU_IS_ALIGNED(wp, wg)) {
> +            error_setg(errp, "write pointer 0x%" PRIx64 " of zone %" PRIu32
> +                       " is not a multiple of the zone write granularity %"
> +                       PRIu32, wp, i, wg);
> +            error_append_hint(errp, "The zones were written with a smaller "
> +                              "logical_block_size. Reset them, or keep using "
> +                              "the smaller size.\n");
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>                                     bool resizable, Error **errp)
>  {
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 7977f4abe5..61f7b3cdc1 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1821,6 +1821,10 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (!blkconf_zoned(&conf->conf, errp)) {
> +        return;
> +    }
> +
>      bs = blk_bs(conf->conf.blk);
>      if (bs->bl.zoned != BLK_Z_NONE) {
>          virtio_add_feature(&s->host_features, VIRTIO_BLK_F_ZONED);
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index f98525c01a..3c96de3222 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -122,6 +122,7 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp);
>   * value to its guest and validate requests against it.
>   */
>  uint32_t blkconf_zone_write_granularity(BlockConf *conf);
> +bool blkconf_zoned(BlockConf *conf, Error **errp);
>  bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>                                     bool resizable, Error **errp);
>  


-- 
Damien Le Moal
Western Digital Research

