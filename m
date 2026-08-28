Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404BAC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpfu-0003Us-3M; Fri, 28 Aug 2026 02:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpfs-0003UB-FT; Fri, 28 Aug 2026 02:02:48 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpfq-0008AW-S3; Fri, 28 Aug 2026 02:02:48 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4500F418FB;
 Fri, 28 Aug 2026 06:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FCE1F000E9;
 Fri, 28 Aug 2026 06:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787896965;
 bh=40S5/LoXjIQJHxYjEKRwlU9vwqXpU+WxrE2Dkgv2feg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=n838HW6SOXxfZYwr7J5nUVEIV1AD8S0S34wksME+ODChTVoL0wqPmKOqfjPrw3QN5
 mBN42PduGC+FlEcl4whdzH5zkSm+acVT/+mU9ZulSSME43FvdWtVy0KbdHzlyXgVuq
 z0wKZFK/cZ1jQh1O7jHYqKzmhROT6/xg9lwhPu8VxCs2avVAOukakhBp9f2WjFTl5X
 wlju/Z0fDISoZA6qhGKv/wX5cKNR5P+T7vgZscvaBCwKYsJwHJrlg1tTcmWiySkvAs
 MQfmRudMUqeEnWJ5xDMHg0j4zXC8FVBbOslPIFhHVy6euroTRuQrStAqkdmG45rjuR
 yTdlPM1bKXQjQ==
Message-ID: <2c5edc3b-87cd-49e0-81d4-06c0036831f5@kernel.org>
Date: Fri, 28 Aug 2026 15:02:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] virtio-blk: do not merge writes across a zone
 boundary
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-3-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-3-cassel@kernel.org>
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
> From: Sam Li <faithilikerun@gmail.com>
> 
> virtio_blk_submit_multireq() fuses adjacent in-zone requests into a
> single request. On a zoned backend, a merged zone append request
> that straddles a zone boundary is rejected by the device because
> each write must stay within a single zone.
> 
> Add a bail condition to the merge coalescer: if combining the
> candidate request into the current batch would cross a zone
> boundary, flush the current batch and start a new one.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

A couple of minor nit below.

> @@ -309,17 +312,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
>      for (i = 0; i < mrb->num_reqs; i++) {
>          VirtIOBlockReq *req = mrb->reqs[i];
>          if (num_reqs > 0) {
> +            zone_cross = false;

Move this as a else of the if below.

> +
> +            /*
> +             * On zoned backends, a single backend write/read must not span
> +             * a zone boundary. Bail out of merging if combining req into
> +             * the current batch would straddle a zone.
> +             */
> +            if (zone_size > 0) {
> +                zone_sector = zone_size / BDRV_SECTOR_SIZE;

Super confusing name. Can we have this be zone_nr_sectors ?

> +                end_sector = req->sector_num
> +                                + req->qiov.size / BDRV_SECTOR_SIZE - 1;
> +                zone_cross = (sector_num / zone_sector) !=
> +                             (end_sector / zone_sector);
> +            }

-- 
Damien Le Moal
Western Digital Research

