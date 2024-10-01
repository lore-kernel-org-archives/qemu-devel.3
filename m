Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E14CEB2CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 00:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svQdR-0003J3-9r; Mon, 30 Sep 2024 20:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1svQdO-0003GX-W1; Mon, 30 Sep 2024 20:20:59 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1svQdN-0000Qh-C5; Mon, 30 Sep 2024 20:20:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5AB9B5C276E;
 Tue,  1 Oct 2024 00:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB67C4CEC7;
 Tue,  1 Oct 2024 00:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727742048;
 bh=BBOzXYji1lh4kZyMeF6kgwwRl+GigQy2WdHq9tFiyoA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KOQMQXhuc5NsVcLUYWh0wpYbMAntUYwUXKRUD5S218rSeXermLOJedti7srgKbNmK
 ozalunZ+vqozr70tzboGr1xybRp1peELXYJY60SHLmBCJw8Ofs994gRKZXsIsPlcNi
 YasTtAKrUDJtUbwdTgC21Ud9FEdIaHn3l2utk5ZloqwxDvtpTjJhx6AHB5K3xDe/4h
 1pHT3NjDCpr2ak6dp8u3XrJJc3XVuMdY81TcScgr+o3I/eFlBxMhefQyBqQWZOzE+E
 EKIuxuPQsAVwFLenvb2U5uuJNTHOROhXny3uVgle5hQsuHoicAqtdr4grASzzr0zZ0
 XhdKoN6AZLxtw==
Message-ID: <1bf857b1-d8ee-4fa5-ae63-074a1533b5f6@kernel.org>
Date: Tue, 1 Oct 2024 09:20:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/file-posix: optimize append write
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Hanna Reitz <hreitz@redhat.com>
References: <20240929160359.581141-1-faithilikerun@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240929160359.581141-1-faithilikerun@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=dlemoal@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/30/24 01:03, Sam Li wrote:
> When the file-posix driver emulates append write, it holds the lock
> whenever accessing wp, which limits the IO queue depth to one.
> 
> The write IO flow can be optimized to allow concurrent writes. The lock
> is held in two cases:
> 1. Assumed that the write IO succeeds, update the wp before issuing the
> write.
> 2. If the write IO fails, report that zone and use the reported value
> as the current wp.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ff928b5e85..64a57fadb1 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2489,11 +2489,19 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
>  #if defined(CONFIG_BLKZONED)
>      if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
>          bs->bl.zoned != BLK_Z_NONE) {
> -        qemu_co_mutex_lock(&bs->wps->colock);
> +        BlockZoneWps *wps = bs->wps;
> +        int index = offset / bs->bl.zone_size;

A blank line after this declaration (to separate declarations from code) woule
make this code more readable...

> +        qemu_co_mutex_lock(&wps->colock);
> +        uint64_t *wp = &wps->wp[index];
>          if (type & QEMU_AIO_ZONE_APPEND) {
> -            int index = offset / bs->bl.zone_size;
> -            offset = bs->wps->wp[index];
> +            offset = *wp;
> +            *offset_ptr = offset;
> +        }
> +        /* Advance the wp if needed */
> +        if (offset + bytes > *wp) {

Why the if ? offset MUST be equal to wp for writes, and for zone append we do
not need to check the offset at all. So advancing the wp should be unconditional.

BUT ! where are the checks for "zone is full" and "offset == wp" for write
operations ? These must be checked while holding the zone lock.

> +            *wp = offset + bytes;
>          }
> +        qemu_co_mutex_unlock(&bs->wps->colock);
>      }
>  #endif
>  
> @@ -2540,28 +2548,19 @@ out:
>  #if defined(CONFIG_BLKZONED)
>      if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
>          bs->bl.zoned != BLK_Z_NONE) {
> -        BlockZoneWps *wps = bs->wps;
>          if (ret == 0) {
> -            uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
> -            if (!BDRV_ZT_IS_CONV(*wp)) {
> -                if (type & QEMU_AIO_ZONE_APPEND) {
> -                    *offset_ptr = *wp;
> -                    trace_zbd_zone_append_complete(bs, *offset_ptr
> -                        >> BDRV_SECTOR_BITS);
> -                }
> -                /* Advance the wp if needed */
> -                if (offset + bytes > *wp) {
> -                    *wp = offset + bytes;
> -                }
> +            if (type & QEMU_AIO_ZONE_APPEND) {
> +                trace_zbd_zone_append_complete(bs, *offset_ptr
> +                    >> BDRV_SECTOR_BITS);
>              }
>          } else {
> +            qemu_co_mutex_lock(&bs->wps->colock);
>              /*
>               * write and append write are not allowed to cross zone boundaries
>               */
>              update_zones_wp(bs, s->fd, offset, 1);
> +            qemu_co_mutex_unlock(&bs->wps->colock);
>          }
> -
> -        qemu_co_mutex_unlock(&wps->colock);
>      }
>  #endif
>      return ret;


-- 
Damien Le Moal
Western Digital Research

