Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89BECCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 18:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEXCk-0001lQ-DC; Thu, 30 Oct 2025 14:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vEXCb-0001kw-II
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vEXCP-0000u5-1j
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761848186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+jh+zsJvuNtF138ol3pBNtWyA+YEd/2pcUUkqwCiA6M=;
 b=AkauvTxw6MzhIfZFZCBO5ChCCWg256IZPFYR/eOFH9i2dIHmgmiWggtIA8ICXS8TdTwpnb
 6/1x3uI9FBji8YeX7PC18LwUpE6jpVT9dtUwpukrMTCL2NfJ7fpybnHWMXpTJl0/iyiEpQ
 pgVuemaKlO1Vc3EVzutyJPiR6HiMTWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-kfWtM9IkNPKpLjo7pZMZ2Q-1; Thu,
 30 Oct 2025 14:16:22 -0400
X-MC-Unique: kfWtM9IkNPKpLjo7pZMZ2Q-1
X-Mimecast-MFC-AGG-ID: kfWtM9IkNPKpLjo7pZMZ2Q_1761848181
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DE2A18001D6; Thu, 30 Oct 2025 18:16:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.238])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CA3C180057E; Thu, 30 Oct 2025 18:16:13 +0000 (UTC)
Date: Thu, 30 Oct 2025 13:16:10 -0500
From: Eric Blake <eblake@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v3] file-posix: Tolerate unaligned hole at middle
Message-ID: <ikijqrvl3psokhrnnjs63lx73jngbfuhtpta2mx3ba6ac7lfhd@joni3xjywtt2>
References: <20251029-dio-v3-1-6ae3bb70db16@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-dio-v3-1-6ae3bb70db16@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 29, 2025 at 03:50:27PM +0900, Akihiko Odaki wrote:
> file-posix used to assume that existing holes satisfy the requested
> alignment, which equals to the estimated direct I/O alignment
> requirement if direct I/O is requested, and assert the assumption
> unless it is at EOF.
> 
> However, the estimation of direct I/O alignment requirement is sometimes
> inexact and can be overly strict. For example, I observed that QEMU
> estimated the alignment requirement as 16K while the real requirement
> is 4K when Btrfs is used on Linux 6.14.6 and the host page size is 16K.

If needed, it should be possible to use nbdkit and an NBD device to
force other unusual alignment scenarios.  But for this patch, I agree
with your analysis that...

> Moreover, even if we could figure out the direct I/O alignment
> requirement, I could not find a documentation saying it will exactly
> match with the alignment of holes.
> 
> So stop asserting the assumption on the holes and handle unaligned holes
> properly.

...not asserting, and merely handling rounding ourselves, is the best
path forward.

>  block/file-posix.c | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 8c738674cedb..b6d7a31b4d04 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3315,29 +3315,38 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,

> +         /*
> +          * We may have allocation unaligned with the requested
> +          * alignment due to the following reaons:

reasons

> +          * - unaligned file size
> +          * - inexact direct I/O alignment requirement estimation
> +          * - mismatches between the allocation size and
> +          *   direct I/O alignment requirement.
> +          *
> +          * We are not allowed to return partial sectors, though, so
> +          * round up the end of allocation if necessary.
> +          */
> +        *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
>          ret = BDRV_BLOCK_DATA;
>      } else {
>          /* On a hole, compute bytes to the beginning of the next extent.  */
>          assert(hole == offset);
>          *pnum = data - offset;
> -        ret = BDRV_BLOCK_ZERO;
> +
> +        /*
> +         * We may have allocation unaligned, so round down the beginning
> +         * of allocation if necessary.
> +         */
> +        if (*pnum < bs->bl.request_alignment) {
> +            *pnum = bs->bl.request_alignment;
> +            ret = BDRV_BLOCK_DATA;
> +        } else {
> +            *pnum = ROUND_DOWN(*pnum, bs->bl.request_alignment);
> +            ret = BDRV_BLOCK_ZERO;
> +        }

With the typo fix,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


