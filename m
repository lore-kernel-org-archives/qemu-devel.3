Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7287606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z3PsMIaa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURzL-0007ob-UK; Fri, 20 Nov 2026 12:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xURzI-0007n9-7G
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xURzG-0001iH-1d
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795194080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFGlvP1/MpDiLwH6kW8flSRRtyI3dl+UO+j5Xex2f14=;
 b=Z3PsMIaa0MqP3wqa6QaJWPTf5RFxVjCVRrjY2hHpYrh+DW2brTFD0NvWL/RyFcDll3M5Ye
 n1WYCttXKCIJL0U7V/MnEwSN3njkztfe4noW2SaXCgTSIt+95HhW/FTvJO67aNQZUhRJSt
 EN7EAbeeblPQyH4M0g9AZlh11C+Pj1A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-3HeX0NfcO6aUbV67NnnzTg-1; Fri,
 20 Nov 2026 17:01:16 +0000
X-MC-Unique: 3HeX0NfcO6aUbV67NnnzTg-1
X-Mimecast-MFC-AGG-ID: 3HeX0NfcO6aUbV67NnnzTg_1795194075
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C03B41955D91; Fri, 20 Nov 2026 17:01:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC11B1801A67; Fri, 20 Nov 2026 17:01:13 +0000 (UTC)
Date: Fri, 20 Nov 2026 12:01:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <20261120170112.GD780462@shajnocz.csb>
References: <20261119145311.1144878-1-peterx@redhat.com>
 <20261119222936.GB780462@shajnocz.csb>
 <av-AweS887ZVL9HO@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av-AweS887ZVL9HO@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 19, 2026 at 06:05:37PM -0500, Peter Xu wrote:
> On Thu, Nov 19, 2026 at 05:29:36PM -0500, Stefan Hajnoczi wrote:
> > On Thu, Nov 19, 2026 at 09:53:11AM -0500, Peter Xu wrote:
> > > Hongyan reported a possible use-after-free of RDMA migration code:
> > > 
> > > https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> > > 
> > > The issue seems real, while this patch is a proposal to fix it in a simpler
> > > way, meanwhile it should be a problem to the yield_until_fd_readable()
> > > helper in general, so it should make more sense to be fixed there too.
> > > 
> > > The problem is about the use of the stack allocated FDYieldUntilData where
> > > we must make sure after yield_until_fd_readable() returns it's not used
> > > anywhere.  If the coroutine yielded can be entered from outside of this
> > > helper (fd_coroutine_enter()), then the aio handler might be installed even
> > > after yield_until_fd_readable() returns, and that makes the stack variable
> > > accessible by aio codd, even if stack gone.
> > > 
> > > Fix it by moving the aio handler removal outside the handler.
> > > 
> > > Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Cc: Kevin Wolf <kwolf@redhat.com>
> > > Cc: Fabiano Rosas <farosas@suse.de>
> > > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > > Cc: Hongyan Xu <getshell@seu.edu.cn>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > 
> > > NOTE: I targeted this for 12.0 because the bug was not introduced in 11.2,
> > > however this seems to be a real bug fix to coroutine in general, I'll leave
> > > that to maintainers to decide if to pick it for 11.2.
> > > ---
> > >  util/qemu-coroutine-io.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
> > > index 364f4d5abf..3c0a7feafa 100644
> > > --- a/util/qemu-coroutine-io.c
> > > +++ b/util/qemu-coroutine-io.c
> > > @@ -74,7 +74,6 @@ typedef struct {
> > >  static void fd_coroutine_enter(void *opaque)
> > >  {
> > >      FDYieldUntilData *data = opaque;
> > > -    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
> > >      qemu_coroutine_enter(data->co);
> > >  }
> > >  
> > > @@ -89,4 +88,9 @@ void coroutine_fn yield_until_fd_readable(int fd)
> > >      aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> > >                         &data);
> > >      qemu_coroutine_yield();
> > > +    /*
> > > +     * Always remove the fd handler, no matter the re-entering of this
> > > +     * coroutine was caused by fd_coroutine_enter() or something else.
> > > +     */
> > > +    aio_set_fd_handler(data.ctx, fd, NULL, NULL, NULL, NULL, NULL);
> > >  }
> > 
> > Why would the coroutine be entered?
> 
> In case of RDMA, rdma_cm_poll_handler() could receive a disconnect event on
> another management fd, then it knows the link is down, hence it needs to
> kickoff this coroutine to quit.  See 923709896b1.

Commit 923709896b1 is not safe in general. It would be necessary to
audit all yield points and see how they react to an unexpected coroutine
re-entry. There could be more bugs related to this.

> > Should there be a loop around
> > qemu_coroutine_yield() - otherwise we fix the invalid stack memory
> > access but return to the caller without fulfilling the purpose of the
> > function (waiting for the fd to become readable), which could cause
> > further bugs?
> 
> I feel like these are two separate things.
> 
> IMO fixing reset of aio handler should be a pure positive fix, because not
> fixing it doesn't stop user from re-entering of the coroutine and bypass
> fd_coroutine_enter().
> 
> My understanding is the caller should have full control of this: when the
> caller requires "fd must be readable", it should always wait until
> fd_coroutine_enter() returns.  This patch should have no functional
> difference.

I don't understand this paragraph because the caller has no way of
knowing whether fd_coroutine_enter() ran when yield_until_fd_readable()
returns with this patch applied. How can the caller wait until
fd_coroutine_enter() returns?

> But it seems still legal if the caller is benign and can properly handle
> the case even if fd is still not readable.  In this case, this patch fixes
> a real issue.
> 
> In case of RDMA migration, only the quit path can cause it to re-enter, so
> either there is IO or we need to quit.  RDMA code works well with either
> event, it can even loop back and wait on the fd again, but since quit is
> the only path kicking this off, it's also not possible even if the caller
> handles this.

The caller of yield_until_fd_readable() expects the function return to
mean the fd is now readable, not that the fd is readable or something
else happened. At minimum this patch would need to add a comment to
clarify this and then audit all callers to be sure they can handle those
semantics correctly.

It would be better to also add a return value differentiating between
success and failure (due to interruption) so that callers can propagate
the interruption (a caller may be several frames into a call stack where
a parent function will loop on early return, defeating the purpose of
reentering the coroutine to notify it that the connection on a separate
fd was dropped, so it must be possible to propagate the interruption up
the call stack).

Any part of QEMU could use util/qemu-coroutine-io.c, so even if this
patch happens to work for RDMA migration, the yield_until_fd_readable()
API needs a more disciplined approach so that it can be used correctly
by anyone.

Stefan


