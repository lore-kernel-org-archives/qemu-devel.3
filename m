Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296F7C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGP4-0007Xn-I0; Wed, 28 May 2025 09:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKGOk-0007SU-9i
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKGOh-0002wB-Lq
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748437241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8fC/fU2wds07m+i/gGccRD1da/gu5a2V1OyxtYYgsNk=;
 b=NNga0RxqnEE4kel8qkdNEgBBXdpwfg9o/Es3IBNENo9MIFpVWr8gggbdh7INMdFGL4qR6X
 5f+cmzduDdYiFXdvoOgE0UpLozDSKjni2knOmo0gAI2w1+sfnHbMRmKKeB6AUPl7xBLmkr
 HD3k6CDSsAxRB1Dh4gmt2qF31Gaodm8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-k7Xenp4ONqCQK23Vp4GgnQ-1; Wed,
 28 May 2025 09:00:37 -0400
X-MC-Unique: k7Xenp4ONqCQK23Vp4GgnQ-1
X-Mimecast-MFC-AGG-ID: k7Xenp4ONqCQK23Vp4GgnQ_1748437236
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58F301955E79; Wed, 28 May 2025 13:00:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E94C51956095; Wed, 28 May 2025 13:00:33 +0000 (UTC)
Date: Wed, 28 May 2025 08:00:30 -0500
From: Eric Blake <eblake@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, devel@daynix.com
Subject: Re: [PATCH] file-posix: Tolerate unaligned hole at middle
Message-ID: <wh5wbm4cfu6jxt3lchkktqnduxyxctpn7byeilmvdt7li4jllp@ol7geqo2t76q>
References: <20250528-dio-v1-1-633066a71b8c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528-dio-v1-1-633066a71b8c@daynix.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 28, 2025 at 08:30:05PM +0900, Akihiko Odaki wrote:
> file-posix used to assume that existing holes satisfy the requested
> alignment, which equals to the estimated direct I/O alignment
> requirement if direct I/O is requested, and assert the assumption
> unless it is at EOF.
> 
> However, the estimation of direct I/O alignment requirement is sometimes
> inexact and can be overly strict. For example, I observed that QEMU
> estimated the alignment requirement as 16K while the real requirement
> is 4K when Btrfs is used on Linux 6.14.6 and the host page size is 16K.
> 
> For direct I/O alignment, open(2) sugguests as follows:
> > Since Linux 6.1, O_DIRECT support and alignment restrictions for a
> > file can be queried using statx(2), using the STATX_DIOALIGN flag.
> > Support for STATX_DIOALIGN varies by filesystem; see statx(2).

We really should be using statx() in the block/ subdirectory (even
though we aren't yet) - over time, more and more filesystems WILL
support it, and it is a more precise answer than anything else.

> >
> > Some filesystems provide their own interfaces for querying O_DIRECT
> > alignment restrictions, for example the XFS_IOC_DIOINFO operation in
> > xfsctl(3). STATX_DIOALIGN should be used instead when it is available.
> >
> > If none of the above is available, then direct I/O support and
> > alignment restrictions can only be assumed from known characteristics
> > of the filesystem, the individual file, the underlying storage
> > device(s), and the kernel version. In Linux 2.4, most filesystems
> > based on block devices require that the file offset and the length and
> > memory address of all I/O segments be multiples of the filesystem
> > block size (typically 4096 bytes). In Linux 2.6.0, this was relaxed to
> > the logical block size of the block device (typically 512 bytes). A
> > block device's logical block size can be determined using the ioctl(2)
> > BLKSSZGET operation or from the shell using the command:
> 
> Apparently Btrfs doesn't support STATX_DIOALIGN nor provide its own
> interface for querying the requirement. Using BLKSSZGET brings another
> problem to determine the underlying block device, which also involves
> heuristics.
> 
> Moreover, even if we could figure out the direct I/O alignment
> requirement, I could not find a documentation saying it will exactly
> matche with the alignment of holes.

s/matche/match/

> 
> So stop asserting the assumption on the holes and tolerate them being
> unaligned.

Tolerating unaligned holes is wise, even if we can improve our probing
to be more accurate in other patches.  That said...

> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  block/file-posix.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ec95b748696b..7b686ce6817d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3307,22 +3307,21 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
>          *pnum = bytes;
>          ret = BDRV_BLOCK_DATA;
>      } else if (data == offset) {
> -        /* On a data extent, compute bytes to the end of the extent,
> -         * possibly including a partial sector at EOF. */
> +        /* On a data extent, compute bytes to the end of the extent. */
>          *pnum = hole - offset;
>  
>          /*
> +         * We may have allocation unaligned with the requested alignment due to
> +         * the following reaons:
> +         * - unaligned file size
> +         * - inexact direct I/O alignment requirement estimation
> +         * - mismatches between the allocation size and
> +         *   direct I/O alignment requirement.
> +         *
>           * We are not allowed to return partial sectors, though, so
>           * round up if necessary.
>           */
> -        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
> -            int64_t file_length = raw_getlength(bs);
> -            if (file_length > 0) {
> -                /* Ignore errors, this is just a safeguard */
> -                assert(hole == file_length);
> -            }
> -            *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
> -        }
> +        *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
>  
>          ret = BDRV_BLOCK_DATA;

...rounding data extent sizes up to the alignment that the rest of the
block layer sees is always safe.  But I would expect some symmetry -
anywhere we are rounding up to report data instead of hole, there
either needs to be counterpart code on the holes or else a good reason
why the holes don't need matching code, where unaligned holes are
rounded down to alignment boundaries (and if that rounds down to 0,
report data instead).  That way, you can't get different answers based
on where in the sector you are asking the question.  We do know that
the block layer is supposed to only be asking the question at the
start of an alignment boundary (even when our alignment boundaries are
too large, such as your mention of 16k alignment when the filesystem
supports 4k holes).  At best, it may just be a matter of adding
comments to document why we are safe, but I'm not sure that is
sufficient for this patch.

Restated visually, if we have | at 16k boundaries (what qemu picked as
the dio alignment), + at 4k boundaries (the granularity of holes that
the fs supports), and the following file structure with Data and Holes
marked:

|+++|+++|+++|+++|+++|
DDDDDHHHHDDHDDDDHHHH

Then the claim is that the block layer will only ever ask for status
at the | points (and not at the +), and the results that it should see
after rounding are as follows (where lowercase respresents changed
results due to rounding to alignment):

|+++|+++|+++|+++|+++|
DDDDDHHHHDDHDDDDHHHH
DDDDDddddDDdDDDDHHHH
        ^

But the important question I don't see in your patch is whether you
handle a block_status query at the point of ^ correctly (it lands in a
hole, but since there is data also present in that alignment boundary,
you have to report the entire 16k as data).

>      } else {
> 
> ---
> base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
> change-id: 20250528-dio-db04a66a7848
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


