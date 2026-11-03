Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33846606D816
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ckIF8+No
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEco-0002XD-T0; Tue, 03 Nov 2026 08:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOEcn-0002Wr-H7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:32:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOEcl-0005l1-Ue
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793712746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+d3Fu+hipt6BDdUo4zhqI788XOdPwO9WWDizuxUouo=;
 b=ckIF8+NoNZabEYOfye3JhTH8BH86zJjJEsFuUUXnSngp2kZKMofAzFOJUbo3n8UFXaayrj
 xTzH5ZteLleIQ30Rbiz9LS6oCEgwoOHosYV9ALZox9faVij7E/PkDbuIHv5yHcpmFzIh9X
 3uz7aGyKdtY6rj9QK89HSN16F2MkqRE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-fJU_XN3IMvSsGqeA_6QfKA-1; Tue,
 03 Nov 2026 08:32:23 -0500
X-MC-Unique: fJU_XN3IMvSsGqeA_6QfKA-1
X-Mimecast-MFC-AGG-ID: fJU_XN3IMvSsGqeA_6QfKA_1793712742
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 290021955F14; Tue,  3 Nov 2026 13:32:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 682BF30001B9; Tue,  3 Nov 2026 13:32:19 +0000 (UTC)
Date: Tue, 3 Nov 2026 14:32:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 11/13] block/blkdebug: make a breakpoint work across
 AioContexts
Message-ID: <auniYL3dbcxJ3gqV@redhat.com>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-12-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930165000.303236-12-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 30.09.2026 um 18:49 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> A request that stops at a breakpoint belongs to whichever AioContext
> issued it, and the monitor or qemu-io that resumes it runs somewhere
> else. Two things go wrong once those are not the same thread.
> 
> resume_req_by_tag() woke the request with qemu_coroutine_enter(), which
> enters the coroutine on the caller's thread. That moves the request off
> its own thread for the rest of its life, and it aborts outright when it
> wins the race against the yield, because the request is published to
> the list before the coroutine gets there.
> 
> wait_break polled the block backend's AioContext, where the event will
> never arrive, so it slept through the suspension it was waiting for.
> 
> Wake the request in the context it came from and wait for it the way
> the rest of the block layer waits across contexts. Where the two
> contexts are the same the coroutine is still entered directly, so
> single-threaded behaviour, and the output tests depending on it, do not
> change.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Maybe order this one before the patch that lets qemu-io start requests
in iothreads? In practice, this is what exposes the problem. (Though
yes, theoretically you could provoke it in other ways, too.)

>  block/blkdebug.c | 3 ++-
>  qemu-io-cmds.c   | 5 ++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 78cc03746f..1522015b34 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -813,6 +813,7 @@ static void suspend_request(BlockDriverState *bs, BlkdebugRule *rule)
>  
>      remove_rule(rule);
>      QLIST_INSERT_HEAD(&s->suspended_reqs, r, next);
> +    aio_wait_kick();

Could this use a comment to tell that this wakes up the 'wait_break'
command in qemu-io?

Kevin


