Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0B2C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwvrr-0007Jx-Kv; Thu, 20 Aug 2026 02:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wwvrq-0007Ji-J8; Thu, 20 Aug 2026 02:03:10 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wwvrn-0008Ma-OQ; Thu, 20 Aug 2026 02:03:10 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3821643D1A;
 Thu, 20 Aug 2026 06:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28601F00A3A;
 Thu, 20 Aug 2026 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787205786;
 bh=I54/khN16Xlie2DX6X482I1h4axFgncNGgp+dI3x8cg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HDf3gWlA4mS5oKu2gkUK1oLYjHeV16Np64hMga9NqsCLymFeB/r/pveubY8aQGvyn
 Ia49l0zaV9NkifQ9q9FFH8vUfK89+cXw/Zh7SUM/iT3NajpGfaioWJ5u2U8QKqV1Iw
 D0GYzQu6b7EN3sauYqw1Lq9pyWEiGj9+poT3U5NXq9A62zz3B1sFif43E7K6CeKLFu
 w1PE4UXiwEwFG1wl42glod0oKSgOT5YjkQRrVBhzXC33ewUvt8ZDnirEohU4OhWX5K
 sKoxMo9mb/RGWTUxhdqxhSugW6/43DAmgZEVO3EPDhcZfTAFqb3O2vwqT0wwFwA6x2
 gxdvx7WEtbiLQ==
Message-ID: <c5c4c68f-a8ad-4f1f-852f-c53c0141f836@kernel.org>
Date: Thu, 20 Aug 2026 15:03:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-blk: check the write granularity of writes to
 sequential zones
To: Niklas Cassel <cassel@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260819191031.3001633-1-cassel@kernel.org>
 <20260819191031.3001633-3-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260819191031.3001633-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=dlemoal@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On 8/20/26 04:10, Niklas Cassel wrote:
> All VIRTIO_BLK_T_OUT requests issued to sequential zones and all
> VIRTIO_BLK_T_ZONE_APPEND requests must have an offset and a data size
> that are multiples of the write granularity reported by the device
> (virtio 1.4, 5.2.6.1), and a violation is reported as
> VIRTIO_BLK_S_ZONE_UNALIGNED_WP (virtio 1.4, 5.2.6).
> 
> Neither request type was fully checked. Zone appends validated only the
> offset, while writes were not checked at all.
> 
> Check the size of the appended data, and both the offset and the size of
> a write, against virtio_blk_write_granularity(), so that every request
> the device accepts is one that the driver was told is valid. Writes to
> conventional zones keep no alignment constraint beyond the logical block
> size. The write path performs the check after virtio_blk_sect_range_ok()
> so that the zone index derived from the guest supplied sector is known to
> be in range.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/virtio-blk.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index ef5581c1e6..b1be0e9eda 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -514,7 +514,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
>      if (append) {
>          uint32_t wg = virtio_blk_write_granularity(s);
>  
> -        if ((offset % wg) != 0) {
> +        if ((offset % wg) != 0 || (len % wg) != 0) {

uint32_t wg_mask = virtio_blk_write_granularity(s) - 1;

if (offset & wg_mask || len & wg_mask)

>              *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
>              return false;
>          }
> @@ -903,6 +903,28 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>              return 0;
>          }
>  
> +        if (is_write) {
> +            BlockDriverState *bs = blk_bs(s->blk);
> +            int64_t offset = req->sector_num << BDRV_SECTOR_BITS;
> +            uint32_t wg = virtio_blk_write_granularity(s);
> +
> +            /*
> +             * Both the offset and the size of a write to a sequential zone
> +             * must be a multiple of the write granularity reported by the
> +             * device. Conventional zones are not constrained. The zone index
> +             * is derived from a guest supplied sector, so this must come after
> +             * virtio_blk_sect_range_ok() has bounded it.
> +             */
> +            if (bs->bl.zoned != BLK_Z_NONE &&
> +                ((offset % wg) != 0 || (req->qiov.size % wg) != 0) &&
> +                !BDRV_ZT_IS_CONV(bs->wps->wp[offset / bs->bl.zone_size])) {
> +                virtio_blk_req_complete(req, VIRTIO_BLK_S_ZONE_UNALIGNED_WP);
> +                block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
> +                g_free(req);
> +                return 0;
> +            }
> +        }
> +
>          block_acct_start(blk_get_stats(s->blk), &req->acct, req->qiov.size,
>                           is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
>  


-- 
Damien Le Moal
Western Digital Research

