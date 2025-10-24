Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B690CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDpa-0001NN-3H; Fri, 24 Oct 2025 05:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vCDpY-0001N7-Es
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vCDpW-0001AP-66
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761297083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5yIlKy/i49ABKynfabvgrYuH4e0Mo3Lxsp/NgcWDGs=;
 b=AWD/9WQPQtX0hcq48OJaqAY41lHJEOkra1uiIJNwoAZ397HejBbtf9//6BfyzhSXKiIs16
 bciC0WnXNXc5lc2I127XVKN7syUv0tS3mUORB//tiDYH8Z7yDD4pBy0Tzp46XBwg08pL+u
 Us7or9N9mwRGN5qAL3Bid5D6mNDt354=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-mFV9reBIPHiJZzA89zN0yQ-1; Fri,
 24 Oct 2025 05:11:19 -0400
X-MC-Unique: mFV9reBIPHiJZzA89zN0yQ-1
X-Mimecast-MFC-AGG-ID: mFV9reBIPHiJZzA89zN0yQ_1761297078
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A5871800637; Fri, 24 Oct 2025 09:11:18 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.249])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D56930002E5; Fri, 24 Oct 2025 09:11:14 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:11:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: ~abombo <abombox@gmail.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fabiano =?iso-8859-1?Q?Fid=EAncio?= <fabiano@fidencio.org>,
 abombo@microsoft.com
Subject: Re: [PATCH qemu 1/1] block: Don't regress when prep_writev2 isn't
 present
Message-ID: <aPtCjFwqoT4bymGk@redhat.com>
References: <176126238504.17752.8775213803155377166-0@git.sr.ht>
 <176126238504.17752.8775213803155377166-1@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176126238504.17752.8775213803155377166-1@git.sr.ht>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 22.10.2025 um 17:55 hat ~abombo geschrieben:
> From: Aurélien Bombo <abombo@microsoft.com>
> 
> 984a32f17e8d introduced support for prep_writev2 as released in liburing 2.2
> and libaio 0.3.111. However, it also broke users of older versions of these
> libraries (without prep_writev2) who relied on flags being no-op, so we remove
> the check on flags.
> 
> Fixes: 984a32f17e8d
> 
> Signed-off-by: Aurélien Bombo <abombo@microsoft.com>
> ---
>  block/io_uring.c  | 1 -
>  block/linux-aio.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/block/io_uring.c b/block/io_uring.c
> index dd4f304910..b44edcd7a4 100644
> --- a/block/io_uring.c
> +++ b/block/io_uring.c
> @@ -349,7 +349,6 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
>                                luringcb->qiov->niov, offset, luring_flags);
>      }
>  #else
> -        assert(flags == 0);
>          io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
>                               luringcb->qiov->niov, offset);
>  #endif

This doesn't look right to me. We're now silently ignoring the flags,
i.e. with BDRV_REQ_FUA the caller believes the data is stable on disk
when it really isn't. That's a data corruption bug.

The right question to ask is which flag is set and why it's set when we
can't handle it. raw_open_common() has this code:

    bs->supported_write_flags = BDRV_REQ_FUA;
    if (s->use_linux_aio && !laio_has_fua()) {
        bs->supported_write_flags &= ~BDRV_REQ_FUA;
    } else if (s->use_linux_io_uring && !luring_has_fua()) {
        bs->supported_write_flags &= ~BDRV_REQ_FUA;
    }

The *_has_fua() functions look like this:

    bool luring_has_fua(void)
    {
    #ifdef HAVE_IO_URING_PREP_WRITEV2
        return true;
    #else
        return false;
    #endif
    }

So with a library version that doesn't support prep_writev2, the
expected state is bs->supported_write_flags == 0. This should mean that
bdrv_driver_pwritev() clears all flags before calling into file-posix
(and therefore Linux AIO or io_uring) code.

Can you please debug where these assumptions break down in your case?

Kevin


