Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE3C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQjt-0003Yw-SD; Tue, 20 May 2025 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHQjr-0003YX-9Z
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHQjp-0005wO-BH
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747762007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k+m0yBgcR8xs7F6tbDNlb3p8tktDAMNv9aTQCX5+bUE=;
 b=LAZetUhh0Q9uyH0yV3hoMUNDtPaCjgICorZaoyvv/pBV9tjk+QvN79O9eK+7ixaVf38862
 Idz+IN3HjgVOsenLkZauVMo47VlCxPIgsqIden5PZ4DSvyTFqMqjkBXrGdThy3K87uTkbd
 AqiSpAkBjGhiTee6lPy4bU7R6ndneCI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-gV645vPuPTu2f0mE7xPDSQ-1; Tue,
 20 May 2025 13:26:44 -0400
X-MC-Unique: gV645vPuPTu2f0mE7xPDSQ-1
X-Mimecast-MFC-AGG-ID: gV645vPuPTu2f0mE7xPDSQ_1747762003
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C53871956050; Tue, 20 May 2025 17:26:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2AFA195608F; Tue, 20 May 2025 17:26:39 +0000 (UTC)
Date: Tue, 20 May 2025 12:26:37 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org, 
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: Re: [PATCH 3/4] block/copy-before-write: reverse access bitmap
Message-ID: <exbcf5hpdrc7lbcyhjgh4movj3fo2xt3sync62icuierlbtzeq@3z6venb5sxfc>
References: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
 <20250513013238.1213539-4-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513013238.1213539-4-andrey.zhadchenko@virtuozzo.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Tue, May 13, 2025 at 03:32:37AM +0200, Andrey Zhadchenko wrote:
> HBitmaps allow us to search set bits pretty fast. On the contrary,
> when searching zeroes, we may be forced to fully traverse the lower
> level.
> When we run blockdev-backup with mode=full on top of snapshot filter
> + cbw filter, the job fills copy bitmap by calling block_status()
> with range (X, virtual_size). The problem is that we check for zeroes
> in this whole range. We also hit the worst case here, as access
> bitmap is fully set and we need to scan the entire lowest level.
> After scanning the full bitmap we actually ask the block status of
> original image, which may return significantly lower amount of empty
> clusters.
> Beacuse of this, the backup job 'hangs' on block copy initializaiton
> for a long time with 100% CPU.
> 
> Example copy bitmap buildup time for image with clu_size=65536 and
> preallocated metadata
> size                 10T   11T
> blockdev-backup      52s   57s
> cbw + snap           325s  413s
> cbw + snap + patch   55s   61s
> 
> To fix it, reverse the access bitmap in cbw filter: rather set it

s/reverse/invert/

> when the user is not allowed to read the cluster.
> 
> Update qemu-iotest 257: now access bitmap have count 0 instead of
> the image size 67108864
> 
> Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
> ---
> @@ -501,9 +501,12 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>          return -EINVAL;
>      }
>      bdrv_disable_dirty_bitmap(s->access_bitmap);
> -    bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
> -                                     block_copy_dirty_bitmap(s->bcs), NULL,
> -                                     true);
> +    if (bitmap) {
> +        bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
> +                                         block_copy_dirty_bitmap(s->bcs), NULL,
> +                                         true);
> +        bdrv_dirty_bitmap_reverse(s->access_bitmap);

Is this setting the bits correctly?  Inverting a bitmap is a
reversible operation, but it looks odd that you are only reversing
once around the merge.  Either the two sources of the merge have the
same sense (whether that be 0 for dirty 1 for clean, or 0 for readable
1 for avoid) and no inverting is needed before or after the merge, or
the two sources have opposite sense (in which case, I would have
expected inverting one of the bitmaps before the merge to get them to
agree on sense, then merging, then inverting back to the desired
sense).  Am I missing something?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


