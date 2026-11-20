Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEEE606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JA4bFnN5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUS9A-0002ar-P4; Fri, 20 Nov 2026 12:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xUS98-0002aP-9F
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xUS96-000281-B0
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795194689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//cOl7cdJveGHPoJGEEjDQz4iG3zI7Pl7b8l5PeDqy0=;
 b=JA4bFnN5O9xP2GnbC1VEoLdYZepntLaKqf8mhTN6GKfrZCsTjNDX3BigKTSi5d7iA3q4MW
 +3+6YNlma8C745W9TvZCkczlbnB0pQ56i1yHkRJc9qvOx5FylAIEI23rYMpQaiqeA7oZyk
 dUvcmnsF7Ra67LZQginua1vmlcOORqs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-jlmpaedoPCinUc8Mth8z9A-1; Fri,
 20 Nov 2026 17:11:27 +0000
X-MC-Unique: jlmpaedoPCinUc8Mth8z9A-1
X-Mimecast-MFC-AGG-ID: jlmpaedoPCinUc8Mth8z9A_1795194685
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A78A180059D; Fri, 20 Nov 2026 17:11:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51466195B3C8; Fri, 20 Nov 2026 17:11:21 +0000 (UTC)
Date: Fri, 20 Nov 2026 18:11:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Hongyan Xu <getshell@seu.edu.cn>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <awB_NzfDzZiML2n_@redhat.com>
References: <20261119145311.1144878-1-peterx@redhat.com>
 <20261119222936.GB780462@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119222936.GB780462@shajnocz.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.11.2026 um 23:29 hat Stefan Hajnoczi geschrieben:
> On Thu, Nov 19, 2026 at 09:53:11AM -0500, Peter Xu wrote:
> > Hongyan reported a possible use-after-free of RDMA migration code:
> > 
> > https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> > 
> > The issue seems real, while this patch is a proposal to fix it in a simpler
> > way, meanwhile it should be a problem to the yield_until_fd_readable()
> > helper in general, so it should make more sense to be fixed there too.
> > 
> > The problem is about the use of the stack allocated FDYieldUntilData where
> > we must make sure after yield_until_fd_readable() returns it's not used
> > anywhere.  If the coroutine yielded can be entered from outside of this
> > helper (fd_coroutine_enter()), then the aio handler might be installed even
> > after yield_until_fd_readable() returns, and that makes the stack variable
> > accessible by aio codd, even if stack gone.
> > 
> > Fix it by moving the aio handler removal outside the handler.
> > 
> > Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > Cc: Hongyan Xu <getshell@seu.edu.cn>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > NOTE: I targeted this for 12.0 because the bug was not introduced in 11.2,
> > however this seems to be a real bug fix to coroutine in general, I'll leave
> > that to maintainers to decide if to pick it for 11.2.
> > ---
> >  util/qemu-coroutine-io.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
> > index 364f4d5abf..3c0a7feafa 100644
> > --- a/util/qemu-coroutine-io.c
> > +++ b/util/qemu-coroutine-io.c
> > @@ -74,7 +74,6 @@ typedef struct {
> >  static void fd_coroutine_enter(void *opaque)
> >  {
> >      FDYieldUntilData *data = opaque;
> > -    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
> >      qemu_coroutine_enter(data->co);
> >  }
> >  
> > @@ -89,4 +88,9 @@ void coroutine_fn yield_until_fd_readable(int fd)
> >      aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> >                         &data);
> >      qemu_coroutine_yield();
> > +    /*
> > +     * Always remove the fd handler, no matter the re-entering of this
> > +     * coroutine was caused by fd_coroutine_enter() or something else.
> > +     */
> > +    aio_set_fd_handler(data.ctx, fd, NULL, NULL, NULL, NULL, NULL);
> >  }
> 
> Why would the coroutine be entered? Should there be a loop around
> qemu_coroutine_yield() - otherwise we fix the invalid stack memory
> access but return to the caller without fulfilling the purpose of the
> function (waiting for the fd to become readable), which could cause
> further bugs?

A loop around qemu_coroutine_yield() is almost never what you want. It
may happen in cases where you spawn multiple operations and wait for all
of them to complete, but if you're just waiting for a condition to
become true, then entering the coroutine before the condition is true
means that the caller is doing something wrong.

In this case, I think the additional caller intentionally wants to
cancel the waiting.

Having multiple places that can reenter a coroutine tends to be tricky
because aio_co_wake() introduces a window where both places could
trigger, which leads to an abort(). But here, qemu_coroutine_enter() is
directly used (which also implies that the coroutine and all the places
that reenter it are in the same thread), so it should be okay.

Kevin


