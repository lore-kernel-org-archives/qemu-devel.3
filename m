Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B3606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hbflxGL9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTLQS-0004NG-0W; Tue, 17 Nov 2026 10:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTLQF-0004Le-SD
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 10:48:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTLQA-00083X-Rh
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 10:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794930513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Mc4J2lDb63h5sajd5x/zDwtbC6G68Ai+1pAe5r+iss=;
 b=hbflxGL9dLu9pnBXkDYJIHnm2lJLgNP/amXxY7rHqNxN2omcvyDEmlrTQdVxrdWia0cAg6
 BLVxwaHAwh4GWQKklXWxAkH57FW9mY4gYEX5nYUpDii0TvOg/D/nr1X1zPaXU+nnPH0AFC
 BNhNpIbvq/dXDw0+FOHS5XwS3Kn84o8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-gSr1hosOMx2tpou1s13Wpw-1; Tue,
 17 Nov 2026 10:48:29 -0500
X-MC-Unique: gSr1hosOMx2tpou1s13Wpw-1
X-Mimecast-MFC-AGG-ID: gSr1hosOMx2tpou1s13Wpw_1794930507
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 715B418002F7; Tue, 17 Nov 2026 15:48:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76B1C18011D4; Tue, 17 Nov 2026 15:48:25 +0000 (UTC)
Date: Tue, 17 Nov 2026 16:48:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH] hw/block: validate the fdc sector position fits
 within bounds
Message-ID: <avx3R-1e8EKwHvf4@redhat.com>
References: <20260812172842.60524-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812172842.60524-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.08.2026 um 19:28 hat Alex Bennée geschrieben:
> Previously the guest controlled the value of last_sec and wasn't
> particularly careful to check it didn't exceed the media size. We
> can't re-use drv->last_sec as that changes as we do operations so we
> set media_last_sect when the geometry is probed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3800
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

So first of all, I disagree with the report. If you attach a whole image
file to a device, then you have to expect that the device uses it and
can't make your security depend on the device not actually making use of
it.

>  hw/block/fdc-internal.h |  1 +
>  hw/block/fdc.c          | 28 ++++++++++++++++++++++------
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
> index e219623dc7a..81775fe55aa 100644
> --- a/hw/block/fdc-internal.h
> +++ b/hw/block/fdc-internal.h
> @@ -83,6 +83,7 @@ typedef struct FDrive {
>      uint8_t max_track;        /* Nb of tracks           */
>      uint16_t bps;             /* Bytes per sector       */
>      uint8_t ro;               /* Is read-only           */
> +    uint8_t media_last_sect;  /* last sector of current track according to media */
>      uint8_t media_changed;    /* Is media changed       */
>      uint8_t media_rate;       /* Data rate of medium    */
>  
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 1178b959a64..18a61f5ce87 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -192,6 +192,7 @@ static void fd_init(FDrive *drv)
>      drv->max_track = 0;
>      drv->ro = true;
>      drv->media_changed = 1;
> +    drv->media_last_sect = 0;
>  }
>  
>  #define NUM_SIDES(drv) ((drv)->flags & FDISK_DBL_SIDES ? 2 : 1)
> @@ -373,6 +374,7 @@ static int pick_geometry(FDrive *drv)
>      }
>      drv->max_track = parse->max_track;
>      drv->last_sect = parse->last_sect;
> +    drv->media_last_sect = parse->last_sect;
>      drv->disk = parse->drive;
>      drv->media_rate = parse->rate;
>      return 0;
> @@ -1905,6 +1907,17 @@ static void fdctrl_handle_partid(FDCtrl *fdctrl, int direction)
>      fdctrl_to_result_phase(fdctrl, 1);
>  }
>  
> +static bool fd_validate_last_sect(FDrive *drv, uint8_t new_last_sect_val)
> +{
> +    if (drv->media_validated && new_last_sect_val > drv->media_last_sect) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FDC: Guest attempted to set last_sect to %u, exceeding valid media max of %u\n",
> +                      new_last_sect_val, drv->media_last_sect);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static void fdctrl_handle_restore(FDCtrl *fdctrl, int direction)
>  {
>      FDrive *cur_drv = get_cur_drv(fdctrl);
> @@ -1919,6 +1932,10 @@ static void fdctrl_handle_restore(FDCtrl *fdctrl, int direction)
>      /* timers */
>      fdctrl->timer0 = fdctrl->fifo[7];
>      fdctrl->timer1 = fdctrl->fifo[8];
> +    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[9])) {
> +        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
> +        return;
> +    }
>      cur_drv->last_sect = fdctrl->fifo[9];

Does having a separate drv->media_last_sect actually have a practical
advantage here compared to just not letting the guest change
drv->last_sect? The spec only talks about restoring values that you got
from SAVE.

Are there any guests that would abuse RESTORE to temporarily set a
smaller number of sectors? I don't expect working with the floppy with a
wrong number of sectors could possibly work?

>      fdctrl->lock = fdctrl->fifo[10] >> 7;
>      cur_drv->perpendicular = (fdctrl->fifo[10] >> 2) & 0xF;

> @@ -1983,13 +2000,12 @@ static void fdctrl_handle_format_track(FDCtrl *fdctrl, int direction)
>          fdctrl->data_state &= ~FD_STATE_MULTI;
>      cur_drv->bps =
>          fdctrl->fifo[2] > 7 ? 16384 : 128 << fdctrl->fifo[2];
> -#if 0
> -    cur_drv->last_sect =
> -        cur_drv->flags & FDISK_DBL_SIDES ? fdctrl->fifo[3] :
> -        fdctrl->fifo[3] / 2;
> -#else
> +
> +    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[3])) {
> +        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
> +        return;
> +    }

I think it's perfectly valid to start with a medium formatted as a 720k
disk and then reformat it as 1.44M. And yes, after formatting you'll be
able to access parts of the image that weren't accessible before. I
don't even consider this a bug at all, let alone a security relevant
one.

Some questions that sound more valid to me would be:

1. Should FORMAT TRACK only accept formats from fd_formats instead of
   completely arbitrary values? Can physical floppy drives really do any
   arbitrary format? And maybe even more importantly, if you format a
   floppy with an unknown format, the next start of QEMU won't detect
   the same format again, but present something else.

2. Related to the same problem, should fdc truncate the image to the new
   size so that the next startup will detect the new format?

3. When formatting the floppy, should we zero out the whole image?

Kevin


