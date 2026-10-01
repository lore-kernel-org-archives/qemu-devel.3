Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B8DCA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMdF-000632-3h; Thu, 01 Oct 2026 15:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xCMd7-00062I-KT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xCMd4-0004R9-RV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790883581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lgD/5Fz7JtIStuuhZPmhp3hbQocabtUF5be3NFPZ0V0=;
 b=PWt3G8cEqQAxYI4qEBSScDWm2Oy/YKxgGOFer34V2ZxEcKoi+s8RvHrCGN7P/XfpZMlm4d
 c8yCsmNWEF5dvsuusAbfdnrPkFoOSz6HFb9RtJU2G7FI2axTxPUaEUiwtKx48F8gC/wupz
 oP8W8mZGBHPbbAsYTUM3LnJRgYBl0ao=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-BEbWQIFHM9-DX2MuacNg8w-1; Thu,
 01 Oct 2026 15:39:40 -0400
X-MC-Unique: BEbWQIFHM9-DX2MuacNg8w-1
X-Mimecast-MFC-AGG-ID: BEbWQIFHM9-DX2MuacNg8w_1790883579
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A4EA19772E6; Thu,  1 Oct 2026 19:39:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D729F1800446; Thu,  1 Oct 2026 19:39:38 +0000 (UTC)
Date: Thu, 1 Oct 2026 15:39:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, nsoffer@redhat.com,
 Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] file-posix: add statx(STATX_DIOALIGN) support
Message-ID: <20261001193937.GB378684@shajnocz.csb>
References: <20260922154351.226540-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922154351.226540-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 22, 2026 at 11:43:51AM -0400, Stefan Hajnoczi wrote:
> Linux v6.1 commit 825cf206ed51 ("statx: add direct I/O alignment
> information") added an interface to fetch O_DIRECT alignment values for
> block devices and file systems.
> 
> Prefer STATX_DIOALIGN to older interfaces and probing, but keep them as
> fallbacks in case STATX_DIOALIGN cannot provide the information.
> 
> STATX_DIOALIGN support as of Linux 6.1:
> - btrfs: no
> - ext4: yes
> - XFS: yes
> - block devices: yes
> - dm-crypt: yes
> 
> This change fixes #1290 ("IO alignment probing delivers incorrect
> results on Linux when used with e.g. dm-crypt") on Linux host kernel
> version 6.1 or later by avoiding the problematic probing code in
> raw_probe_alignment(). It would be nice to fix the probing code but I
> have not been able to reproduce it. Stable/LTS distros ship Linux 6.1+,
> so the number of users without STATX_DIOALIGN is becoming small.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1290
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
> - Rebase and update commit description
> v2:
> - Make sure that XFS_IOC_DIOINFO takes priority over logical blocksize [Eric Biggers]
> ---
>  block/file-posix.c | 56 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 18 deletions(-)

Ping

> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 9aad156aad4..0dedd090068 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -426,28 +426,48 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
>  
>      bs->bl.request_alignment = 0;
>      s->buf_align = 0;
> -    /* Let's try to use the logical blocksize for the alignment. */
> -    if (probe_logical_blocksize(fd, &bs->bl.request_alignment) < 0) {
> -        bs->bl.request_alignment = 0;
> +
> +#if defined(__linux__) && defined(STATX_DIOALIGN)
> +    struct statx stx;
> +
> +    /*
> +     * Linux 6.1 introduced an interface for both block devices and file
> +     * systems. The system call returns with the STATX_DIOALIGN bit cleared
> +     * when the information is unavailable.
> +     */
> +    if (statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> +        (stx.stx_mask & STATX_DIOALIGN)) {
> +        bs->bl.request_alignment = stx.stx_dio_offset_align;
> +        s->buf_align = stx.stx_dio_mem_align;
>      }
> +#endif /* defined(__linux__) && defined(STATX_DIOALIGN) */
>  
>  #ifdef __linux__
> -    /*
> -     * The XFS ioctl definitions are shipped in extra packages that might
> -     * not always be available. Since we just need the XFS_IOC_DIOINFO ioctl
> -     * here, we simply use our own definition instead:
> -     */
> -    struct xfs_dioattr {
> -        uint32_t d_mem;
> -        uint32_t d_miniosz;
> -        uint32_t d_maxiosz;
> -    } da;
> -    if (ioctl(fd, _IOR('X', 30, struct xfs_dioattr), &da) >= 0) {
> -        bs->bl.request_alignment = da.d_miniosz;
> -        /* The kernel returns wrong information for d_mem */
> -        /* s->buf_align = da.d_mem; */
> +    if (!bs->bl.request_alignment) {
> +        /*
> +         * The XFS ioctl definitions are shipped in extra packages that might
> +         * not always be available. Since we just need the XFS_IOC_DIOINFO ioctl
> +         * here, we simply use our own definition instead:
> +         */
> +        struct xfs_dioattr {
> +            uint32_t d_mem;
> +            uint32_t d_miniosz;
> +            uint32_t d_maxiosz;
> +        } da;
> +        if (ioctl(fd, _IOR('X', 30, struct xfs_dioattr), &da) >= 0) {
> +            bs->bl.request_alignment = da.d_miniosz;
> +            /* The kernel returns wrong information for d_mem */
> +            /* s->buf_align = da.d_mem; */
> +        }
> +    }
> +#endif /* __linux__ */
> +
> +    /* Let's try to use the logical blocksize for the alignment. */
> +    if (!bs->bl.request_alignment) {
> +        if (probe_logical_blocksize(fd, &bs->bl.request_alignment) < 0) {
> +            bs->bl.request_alignment = 0;
> +        }
>      }
> -#endif
>  
>      /*
>       * If we could not get the sizes so far, we can only guess them. First try
> -- 
> 2.55.0
> 


