Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68724C982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x91me-0004zr-1Y; Tue, 22 Sep 2026 10:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x91ma-0004zQ-A8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x91mY-0006nz-Sp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790088461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f58hdF1t6iQ1JKx70CUgHewSMNQxcl03sX179DMng2w=;
 b=cP55mJ9i/a2aSBmmA2pUj1s4ujccSKBiCKRVtopnJRXwk8UTxKvkZKZh8LboUV1agJw3/s
 ZsJbOqCeWM0g2E7cEKMKyxQwLFbLNZgOlKjr3Q6VZhM4dtnnovhSKLUZqOfh7Tz+OTikhX
 xO8NI6dz36WU1ivXZUSEyTfrk1cc31s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-GsZL8QqhNOS4Di0TjpVvIg-1; Tue,
 22 Sep 2026 10:47:37 -0400
X-MC-Unique: GsZL8QqhNOS4Di0TjpVvIg-1
X-Mimecast-MFC-AGG-ID: GsZL8QqhNOS4Di0TjpVvIg_1790088456
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373261830363; Tue, 22 Sep 2026 14:47:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B160B30001B9; Tue, 22 Sep 2026 14:47:33 +0000 (UTC)
Date: Tue, 22 Sep 2026 16:47:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 0/1] block/throttle-groups: fix a NULL token crash on
 group creation
Message-ID: <arKVA0G7iRblbxkv@redhat.com>
References: <20260908145554.3215221-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908145554.3215221-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 08.09.2026 um 16:55 hat Denis V. Lunev geschrieben:
> Applying I/O limits to a disk that is already serving requests from an
> iothread can kill QEMU:
> 
>   #0  throttle_group_next_tgm (tgm=0x0) at block/throttle-groups.c:185
>   #1  next_throttle_token (tgm=..., direction=THROTTLE_READ)
>   #2  throttle_group_co_io_limits_intercept (bytes=8192, ...)
>   #3  blk_co_do_preadv_part (blk=..., bytes=8192, ...)
>   #4  blk_aio_read_entry (opaque=...)
>   #5  coroutine_trampoline (i0=..., i1=...)
> 
> throttle_group_register_tgm() publishes tgm->throttle_state before it
> takes tg->lock, and the group it points at is only filled in afterwards.
> A request that samples the pointer in between and wins tg->lock finds
> tg->tokens[] still NULL. The ordering is as old as the throttle group
> code, 76f4afb40f ("throttle: Add throttle group support").
> 
> This was found from a production core. The group in it was brand new -
> name matching the disk, refcount 1, empty member list, both tokens NULL,
> a zeroed config because throttle_group_config() had not run yet, and
> tg->lock owned by the crashing iothread while the main thread sat
> blocked on the same lock inside throttle_group_register_tgm(). The
> trigger was libvirt applying blkdeviotune right after attaching a
> volume, while the guest was probing the new disk.
> 
> The window is a couple of instructions wide. To see the bug on demand,
> widen it by hand:
> 
>     --- a/block/throttle-groups.c
>     +++ b/block/throttle-groups.c
>     @@ -584,6 +584,7 @@ void throttle_group_register_tgm(...)
>          tgm->throttle_state = ts;
>          tgm->aio_context = ctx;
>          qatomic_set(&tgm->restart_pending, 0);
> 
>     +    g_usleep(1000);
>          QEMU_LOCK_GUARD(&tg->lock);
> 
> With that in place, any I/O against the disk during a
> block_set_io_throttle that creates the group crashes at once, and the
> patch below makes it stop.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>

Thanks, applied to the block branch.

Kevin


