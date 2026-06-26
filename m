Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6EACDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4yr-0006qz-8G; Fri, 26 Jun 2026 07:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd4yo-0006qF-KD; Fri, 26 Jun 2026 07:44:18 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd4ym-0006Jk-OE; Fri, 26 Jun 2026 07:44:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F31F7600AE;
 Fri, 26 Jun 2026 11:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A611F000E9;
 Fri, 26 Jun 2026 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782474254;
 bh=CCbRBV1ruM4jrI8L+q5LnY7ywIPaizChfDf2tSxSQu8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VNnjGv1rbQ5J/+DY0XLOS/Q+1t+5Ol+8+Z+pfesq/8jpcx6gVMJAfotnTeD4kVh6j
 fnZYj68galGrUYeFdkkrNnCRTBkDv9yo2fm8W/77P5Upng5vG7zdH1tNaX9oTUtboJ
 4iuIsqVTG1bm36OLYU386e9uHnedvhd9Yaf7wSqbZqRW0HilOVFR6U+52TTkrxDfm0
 1Z2T6FgaaHKOlnQBYB1BWhJ4p+j91Kyt3Kp4fO4VyXeZ/0Aa8XyjDoZwHyrPY7j4fw
 iXSDRwC1ryGXtJFLgnl5VGTv/CfxrT51q4HOoNWWUcEbfktQEsFHcoh6XmY+r+Gf9x
 yYHhSl7hM7gDA==
Date: Fri, 26 Jun 2026 13:44:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 dlemoal@kernel.org, qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v12 3/5] virtio-blk: do not merge writes across a zone
 boundary
Message-ID: <aj5mCUdALSdJUdCL@ryzen>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623184830.373232-4-faithilikerun@gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hello Sam,

On Tue, Jun 23, 2026 at 08:48:28PM +0200, Sam Li wrote:
> virtio_blk_submit_multireq() fuses adjacent in-zone writes into a
> single request. On a zoned backend, a merged zone append request
> that straddles a zone boundary is rejected by the device because
> each write must stay within a single zone.
> 
> Add a bail condition to the merge coalescer: if combining the
> candidate request into the current batch would cross a zone
> boundary, flush the current batch and start a new one.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/block-backend.c             | 11 +++++++++++
>  hw/block/virtio-blk.c             | 22 +++++++++++++++++++++-
>  include/system/block-backend-io.h |  1 +
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 37ba7e9fc4..049e70ddcb 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2326,6 +2326,17 @@ uint32_t blk_get_request_alignment(BlockBackend *blk)
>      return bs ? bs->bl.request_alignment : BDRV_SECTOR_SIZE;
>  }
>  
> +/*
> + * Returns the zone size in bytes for a zoned backend, or 0 if @blk does
> + * not present zoned geometry.
> + */
> +uint64_t blk_get_zone_size(BlockBackend *blk)
> +{
> +    BlockDriverState *bs = blk_bs(blk);
> +    IO_CODE();
> +    return bs ? bs->bl.zone_size : 0;
> +}

Personally, I would add this new API in a separate patch, but either way
is fine with me.


> +
>  /* Returns the optimal write zeroes alignment, in bytes; guaranteed nonzero */
>  uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk)
>  {
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 6b92066aff..39750fa1c0 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -294,6 +294,9 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
>      int i = 0, start = 0, num_reqs = 0, niov = 0, nb_sectors = 0;
>      uint32_t max_transfer;
>      int64_t sector_num = 0;
> +    uint64_t zone_size = blk_get_zone_size(s->blk);
> +    bool zone_cross;
> +    int64_t zone_sector, end_sector;
>  
>      if (mrb->num_reqs == 1) {
>          submit_requests(s, mrb, 0, 1, -1);
> @@ -309,17 +312,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
>      for (i = 0; i < mrb->num_reqs; i++) {
>          VirtIOBlockReq *req = mrb->reqs[i];
>          if (num_reqs > 0) {
> +            zone_cross = false;
> +
> +            /*
> +             * On zoned backends, a single backend write must not span a zone
> +             * boundary. Bail out of merging if combining req into the current
> +             * batch would straddle a zone.
> +             */

Like Stefan said in v11, as per the virtio spec, this applies to both
reads and writes. The code is doing the right thing, but the comment
should probably be updated to reflect that.


Kind regards,
Niklas

