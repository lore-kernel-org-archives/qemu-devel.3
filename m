Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6802C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpl3-0005kW-R3; Fri, 28 Aug 2026 02:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpkz-0005ii-G7; Fri, 28 Aug 2026 02:08:05 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpkx-0000rx-Oh; Fri, 28 Aug 2026 02:08:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C42084034E;
 Fri, 28 Aug 2026 06:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BD31F000E9;
 Fri, 28 Aug 2026 06:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897281;
 bh=bqxzWgz2btkSRFknNgfQBDQkotarayQgcLuD9bMo+1k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RR0fuiwRlP7jFVu2almKXQ9K83IU3gyRaRu2cfyCaNJn1gYBt7Uuzi4TdmPS9W470
 f6Nt0RJqSItrrdNUvzJuh275MaRlg+wH7gfVTbrpNIUZBb+qTyYO0URxC0fjy+xHRB
 WsmIUkcoZwvOcl2vLnGQGp2mwyjFZafMJPczGk/E2Kut30GTZ4BUVxKU/h++drivY3
 XRHlSoGCid7zPPp9DaqspbHY41CRePwlR8c76LA7CU1OOwUTU7okv1VKdu/6XTdCZ4
 H1sqioA8bBCpCQi+2xYjYxzvGm7dc2gwO5EcPMS01kANTpdEri+QAU/QDbDxmQtmkn
 jourQ9fr8Avuw==
Message-ID: <e8df71f8-25bf-4daf-856a-ccd4728a2a8f@kernel.org>
Date: Fri, 28 Aug 2026 15:07:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] virtio-blk: check the write granularity of writes
 to sequential zones
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-6-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=dlemoal@kernel.org;
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

On 8/26/26 05:57, Niklas Cassel wrote:
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
> a write, against blkconf_zone_write_granularity(), so that every request the
> device accepts is one that the guest driver was told is valid. Writes to
> conventional zones keep no alignment constraint beyond the logical block
> size. The write path performs the check after virtio_blk_sect_range_ok()
> so that the zone index derived from the guest supplied sector is known to
> be in range.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/virtio-blk.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index f8cda1baa7..7977f4abe5 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -522,7 +522,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
>      if (append) {
>          uint32_t wg_mask = blkconf_zone_write_granularity(&s->conf.conf) - 1;
>  
> -        if (offset & wg_mask) {
> +        if (offset & wg_mask || len & wg_mask) {
>              *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
>              return false;
>          }
> @@ -911,6 +911,29 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>              return 0;
>          }
>  
> +        if (is_write) {
> +            BlockDriverState *bs = blk_bs(s->blk);
> +            int64_t offset = req->sector_num << BDRV_SECTOR_BITS;
> +            uint32_t wg_mask =
> +                blkconf_zone_write_granularity(&s->conf.conf) - 1;

Getting this without having first checked that this is a write to a zoned disk
is odd...

> +
> +            /*
> +             * Both the offset and the size of a write to a sequential zone
> +             * must be a multiple of the write granularity reported by the
> +             * device. Conventional zones are not constrained. The zone index
> +             * is derived from a guest supplied sector, so this must come after
> +             * virtio_blk_sect_range_ok() has bounded it.
> +             */
> +            if (bs->bl.zoned != BLK_Z_NONE &&

"!=" ??? Why ? The write granularity alignment applies only to zoned disks, no?
So why is this not "bs->bl.zoned == BLK_Z_NONE" ?

> +                (offset & wg_mask || req->qiov.size & wg_mask) &&
> +                !BDRV_ZT_IS_CONV(bs->wps->wp[offset / bs->bl.zone_size])) {

This condition is a little complex. A little inline helper
"virtio_blk_zoned_write_is_aligned()" or something like that would be nice.

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

