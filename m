Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5162FD30014
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1o6g-0006GD-1d; Fri, 18 Oct 2024 10:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1o6f-0006G5-7X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1o6d-0001mC-Gj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xsxqH5pdeYLajhn0xKm4MvB1EDXfIRywkreURuisrug=;
 b=JRAZMvPPao18RdNlMB2mTtWDRhF2TcXjMh/P/eOWJ/NZbSuJPqf9itYHkYTZG/OMrFvQUI
 stnK9ReIswQMBLPmgbgAjiTmNYlmJcpgRHOek4BXXOLdihdYtk3/q1nF/Vmq7eDnVxpmUO
 +eto6+ZdzNeglh4IZCh5Pe0ilu+DfkU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-VELDQwmrMHC-ePigQem4gA-1; Fri,
 18 Oct 2024 10:37:29 -0400
X-MC-Unique: VELDQwmrMHC-ePigQem4gA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C98D1956058; Fri, 18 Oct 2024 14:37:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.196])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8987130001A6; Fri, 18 Oct 2024 14:37:20 +0000 (UTC)
Date: Fri, 18 Oct 2024 16:37:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, dlemoal@kernel.org
Subject: Re: [PATCH v2] block/file-posix: optimize append write
Message-ID: <ZxJynt-0ySt3DG7W@redhat.com>
References: <20241004104123.236457-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004104123.236457-1-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 04.10.2024 um 12:41 hat Sam Li geschrieben:
> When the file-posix driver emulates append write, it holds the lock
> whenever accessing wp, which limits the IO queue depth to one.
> 
> The write IO flow can be optimized to allow concurrent writes. The lock
> is held in two cases:
> 1. Assumed that the write IO succeeds, update the wp before issuing the
> write.
> 2. If the write IO fails, report that zone and use the reported value
> as the current wp.

What happens with the concurrent writes that started later and may not
have completed yet? Can we really just reset to the reported value
before all other requests have completed, too?

> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 57 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 90fa54352c..a65a23cb2c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2482,18 +2482,46 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
>      BDRVRawState *s = bs->opaque;
>      RawPosixAIOData acb;
>      int ret;
> -    uint64_t offset = *offset_ptr;
> +    uint64_t end_offset, end_zone, offset = *offset_ptr;
> +    uint64_t *wp;

Without CONFIG_BLKZONED, these are unused variables and break the build.

They are only used in the first CONFIG_BLKZONED block, so you could just
declare them locally there.

>  
>      if (fd_open(bs) < 0)
>          return -EIO;
>  #if defined(CONFIG_BLKZONED)
>      if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
>          bs->bl.zoned != BLK_Z_NONE) {
> -        qemu_co_mutex_lock(&bs->wps->colock);
> -        if (type & QEMU_AIO_ZONE_APPEND) {
> -            int index = offset / bs->bl.zone_size;
> -            offset = bs->wps->wp[index];
> +        BlockZoneWps *wps = bs->wps;
> +        int index = offset / bs->bl.zone_size;
> +
> +        qemu_co_mutex_lock(&wps->colock);

This is preexisting, but what is the reason for using coroutine locks
here? There doesn't seem to be any code running under the lock that can
yield, so a normal mutex might be more efficient.

Hm... Looking a bit closer, get_zones_wp() could probably be a
coroutine_fn and call hdev_co_ioctl() instead of calling ioctl()
directly in order to avoid blocking.

> +        wp = &wps->wp[index];

Also preexisting, but who guarantees that index is within the bounds? A
stacked block driver may try to grow the file size.

> +        if (!BDRV_ZT_IS_CONV(*wp)) {
> +            if (type & QEMU_AIO_WRITE && offset != *wp) {
> +                error_report("write offset 0x%" PRIx64 " is not equal to the wp"
> +                             " of zone[%d] 0x%" PRIx64 "", offset, index, *wp);

We can't error_report() in an I/O path that can be triggered by the
guest, it could result in unbounded log file growth.

> +                qemu_co_mutex_unlock(&wps->colock);
> +                return -EINVAL;
> +            }
> +
> +            if (type & QEMU_AIO_ZONE_APPEND) {
> +                offset = *wp;
> +                *offset_ptr = offset;
> +            }
> +
> +            end_offset = offset + bytes;
> +            end_zone = (index + 1) * bs->bl.zone_size;
> +            if (end_offset > end_zone) {
> +                error_report("write exceeds zone boundary with end_offset "
> +                             "%" PRIu64 ", end_zone %" PRIu64 "",
> +                             end_offset, end_zone);

Same error_report() problem.

> +                qemu_co_mutex_unlock(&wps->colock);
> +                return -EINVAL;
> +            }
> +
> +            /* Advance the wp */
> +            *wp = end_offset;
>          }
> +        qemu_co_mutex_unlock(&bs->wps->colock);
>      }
>  #endif
>  
> @@ -2540,28 +2568,19 @@ out:
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

Kevin


