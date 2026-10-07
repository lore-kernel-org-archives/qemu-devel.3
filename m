Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967C1CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESpM-00010j-1P; Wed, 07 Oct 2026 10:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xESp0-0000sM-3q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xESoy-0002MK-BC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791384038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pna3zDyigt0LMOycn0Yh2jd82chqGVuc3gIoo8W+uFg=;
 b=L9n7zXTD0KWZozGd1bhrQ6jdgmUI731cia0LIxgq1znUvfdCUOZV2FAJ4kHgl/UTbLQ7uk
 nHn43Rghu9BvnzGghFIkd3+NirofzId1DIxdYCgyuKlKmqXJwG7YyB1uaQjkN/d8JD2vq9
 GnSdqFimydnAgrNAm4eptiIFR7avnt4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-Y6T5mleCPyCzzKUuU_g9MQ-1; Wed,
 7 Oct 2026 14:40:37 +0000
X-MC-Unique: Y6T5mleCPyCzzKUuU_g9MQ-1
X-Mimecast-MFC-AGG-ID: Y6T5mleCPyCzzKUuU_g9MQ_1791384036
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D6C8180A8FD; Wed,  7 Oct 2026 14:40:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.219])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 300C0180058D; Wed,  7 Oct 2026 14:40:33 +0000 (UTC)
Date: Wed, 7 Oct 2026 16:40:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sanne Raymaekers <sraymaek@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, fam@euphon.net
Subject: Re: [PATCH 2/3] block/vmdk: skip RGD for stream optimized disks
Message-ID: <asZZ3_1EptsU4Uk7@redhat.com>
References: <20261005133316.198087-1-sraymaek@redhat.com>
 <20261005133316.198087-2-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005133316.198087-2-sraymaek@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Am 05.10.2026 um 15:33 hat Sanne Raymaekers geschrieben:
> Stream optimized disks the spec notes: "The rgdOffset should be ignored
> because bit 1 of the flags field is not set." Where bit 1 of the flags
> field indicates a redundant grain directory (RGD).[^1]
> 
> In short, stream optimized disks should have the RGD offset set to 0,
> and only write the main grain directory.
> 
> [^1] Virtual Disk Format 5.0 Technical Note.
> 
> Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
> ---
>  block/vmdk.c | 76 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 3cdca06fff..040f38cd1d 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2218,7 +2218,7 @@ vmdk_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
>  
>  static int coroutine_fn GRAPH_UNLOCKED
>  vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
> -                 bool zeroed_grain, Error **errp)
> +                 bool zeroed_grain, bool stream_optimized, Error **errp)

You changed quite a few functions to add a new stream_optimized
parameter. This seems unnecessary as there is already a compress
parameter, which originates in vmdk_co_do_create() like this:

    compress = subformat == BLOCKDEV_VMDK_SUBFORMAT_STREAMOPTIMIZED;

So stream_optimized duplicates the same information.

>  {
>      int ret, i;
>      VMDK4Header header;
> @@ -2239,9 +2239,10 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
>      } else {
>          header.version = 1;
>      }
> -    header.flags = VMDK4_FLAG_RGD | VMDK4_FLAG_NL_DETECT
> +    header.flags =  VMDK4_FLAG_NL_DETECT

Minor formatting issue: There are two spaces before VMDK4_FLAG_NL_DETECT.

>                     | (compress ? VMDK4_FLAG_COMPRESS | VMDK4_FLAG_MARKER : 0)
> -                   | (zeroed_grain ? VMDK4_FLAG_ZERO_GRAIN : 0);
> +                   | (zeroed_grain ? VMDK4_FLAG_ZERO_GRAIN : 0)
> +                   | (stream_optimized ? 0 : VMDK4_FLAG_RGD);
>      header.compressAlgorithm = compress ? VMDK4_COMPRESSION_DEFLATE : 0;
>      header.capacity = filesize / BDRV_SECTOR_SIZE;
>      header.granularity = 128;
> @@ -2255,8 +2256,15 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
>  
>      header.desc_offset = 1;
>      header.desc_size = 20;
> -    header.rgd_offset = header.desc_offset + header.desc_size;
> -    header.gd_offset = header.rgd_offset + gd_sectors + (gt_size * gt_count);
> +
> +    if (stream_optimized) {
> +        header.rgd_offset = 0;
> +        header.gd_offset = header.desc_offset + header.desc_size;
> +    } else {
> +        header.rgd_offset = header.desc_offset + header.desc_size;
> +        header.gd_offset = header.rgd_offset + gd_sectors + (gt_size * gt_count);
> +    }
> +
>      header.grain_offset =
>          ROUND_UP(header.gd_offset + gd_sectors + (gt_size * gt_count),
>                   header.granularity);
> @@ -2296,21 +2304,24 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
>          goto exit;
>      }
>  
> -    /* write grain directory */
> +    /* write backup grain directory */

Heh, good point, the existing code had them reversed in the comments.

It would be good to mention this in the commit message because it came
as a surprise that you seemingly swapped them.

>      gd_buf_size = gd_sectors * BDRV_SECTOR_SIZE;
>      gd_buf = g_malloc0(gd_buf_size);
> -    for (i = 0, tmp = le64_to_cpu(header.rgd_offset) + gd_sectors;
> -         i < gt_count; i++, tmp += gt_size) {
> -        gd_buf[i] = cpu_to_le32(tmp);
> -    }
> -    ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
> -                        gd_buf_size, gd_buf, 0);
> -    if (ret < 0) {
> -        error_setg_errno(errp, -ret, "failed to write VMDK grain directory");
> -        goto exit;
> +
> +    if (!stream_optimized) {
> +        for (i = 0, tmp = le64_to_cpu(header.rgd_offset) + gd_sectors;
> +             i < gt_count; i++, tmp += gt_size) {
> +            gd_buf[i] = cpu_to_le32(tmp);
> +        }
> +        ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
> +                            gd_buf_size, gd_buf, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "failed to write VMDK grain directory");

This should probably be "failed to write VMDK backup grain directory"
(you removed the "backup" below, but didn't add it here).

> +            goto exit;
> +        }
>      }
>  
> -    /* write backup grain directory */
> +    /* write grain directory */
>      for (i = 0, tmp = le64_to_cpu(header.gd_offset) + gd_sectors;
>           i < gt_count; i++, tmp += gt_size) {
>          gd_buf[i] = cpu_to_le32(tmp);
> @@ -2319,7 +2330,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
>                          gd_buf_size, gd_buf, 0);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
> -                         "failed to write VMDK backup grain directory");
> +                         "failed to write VMDK grain directory");
>      }
>  
>      ret = 0;

Kevin


