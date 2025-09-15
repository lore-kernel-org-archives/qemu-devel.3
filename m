Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C72CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyE8J-00014R-A8; Mon, 15 Sep 2025 14:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyE8E-000149-KC
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyE87-0003bK-Pn
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757961641;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yy3hWTKz1yeMWBg/dSxzWEOrMKxDIju37VQ+gDy7Ots=;
 b=ZhWlVivc8H672lh044/+fzaQ7XgLbHbxq+15TYMuFvKOtQON0Mj9T7T5oDubqWLlNktqlV
 jbEJzAgFAIJlCrqrKm1maDYWzhlM7IF6hp4M7NgJjaQkoeWe5RkqwCLcsUj4U1dT88/eAz
 addl5pamgI9lFpYT8cFh+tf93YINA0I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-ae1JozfLM7anKxfYt2LCFQ-1; Mon,
 15 Sep 2025 14:40:40 -0400
X-MC-Unique: ae1JozfLM7anKxfYt2LCFQ-1
X-Mimecast-MFC-AGG-ID: ae1JozfLM7anKxfYt2LCFQ_1757961639
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4090219107DD; Mon, 15 Sep 2025 18:40:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6500919560A2; Mon, 15 Sep 2025 18:40:36 +0000 (UTC)
Date: Mon, 15 Sep 2025 19:40:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/3] io/tls: Make qio_channel_tls_bye() always
 synchronous
Message-ID: <aMhdoWKdY_lxghVu@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-3-peterx@redhat.com>
 <aMQDuFI2hQQ8clAF@redhat.com> <aMQ-E8BkvQq6Pisx@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQ-E8BkvQq6Pisx@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 12, 2025 at 11:36:51AM -0400, Peter Xu wrote:
> On Fri, Sep 12, 2025 at 12:27:52PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Sep 11, 2025 at 05:23:54PM -0400, Peter Xu wrote:
> > > No issue I hit, the change is only from code observation when I am looking
> > > at a TLS premature termination issue.
> > > 
> > > qio_channel_tls_bye() API needs to be synchronous.  When it's not, the
> > > previous impl will attach an asynchronous task retrying but only until when
> > > the channel gets the relevant GIO event. It may be problematic, because the
> > > caller of qio_channel_tls_bye() may have invoked channel close() before
> > > that, leading to premature termination of the TLS session.
> > > 
> > > Remove the asynchronous handling, instead retry it immediately.  Currently,
> > > the only two possible cases that may lead to async task is either INTERRUPT
> > > or EAGAIN.  It should be suffice to spin retry as of now, until a solid
> > > proof showing that a more complicated retry logic is needed.
> > > 
> > > With that, we can remove the whole async model for the bye task.
> > > 
> > > When at it, making the function return bool, which looks like a common
> > > pattern in QEMU when errp is used.
> > > 
> > > Side note on the tracepoints: previously the tracepoint bye_complete()
> > > isn't used.  Start to use it in this patch.  bye_pending() and bye_cancel()
> > > can be dropped now.  Adding bye_retry() instead.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/io/channel-tls.h |  5 ++-
> > >  io/channel-tls.c         | 86 +++++-----------------------------------
> > >  io/trace-events          |  3 +-
> > >  3 files changed, 15 insertions(+), 79 deletions(-)
> > > 

> > > diff --git a/io/channel-tls.c b/io/channel-tls.c
> > > index 5a2c8188ce..8510a187a8 100644
> > > --- a/io/channel-tls.c
> > > +++ b/io/channel-tls.c
> > > @@ -253,84 +253,25 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
> > >      qio_channel_tls_handshake_task(ioc, task, context);
> > >  }
> > >  
> > > -static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
> > > -                                       gpointer user_data);
> > > -
> > > -static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
> > > -                                     GMainContext *context)
> > > +bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
> > >  {
> > > -    GIOCondition condition;
> > > -    QIOChannelTLSData *data;
> > >      int status;
> > > -    Error *err = NULL;
> > >  
> > > -    status = qcrypto_tls_session_bye(ioc->session, &err);
> > > +    trace_qio_channel_tls_bye_start(ioc);
> > > +retry:
> > > +    status = qcrypto_tls_session_bye(ioc->session, errp);
> > >  
> > >      if (status < 0) {
> > >          trace_qio_channel_tls_bye_fail(ioc);
> > 
> > snip
> > 
> > > +        return false;
> > > +    } else if (status != QCRYPTO_TLS_BYE_COMPLETE) {
> > > +        /* BYE event must be synchronous, retry immediately */
> > > +        trace_qio_channel_tls_bye_retry(ioc, status);
> > > +        goto retry;
> > >      }
> > 
> > We cannot do this. If the gnutls_bye() API needs to perform
> > socket I/O, and so when we're running over a non-blocking
> > socket we must expect EAGAIN. With this handling, QEMU will
> > busy loop burning 100% CPU when the socket is not ready.
> 
> Right.  That was the plan when drafting this, the hope is spinning will
> almost not happen, and even if it happens it'll finish soon (migration is
> completing, it means network mustn't be so bad), unless the network is
> stuck exactly at when we send the bye().

Don't forget that the machine can be running 5 migrations
of different VMs concurrently, and so may not be as quick
to finish sending traffic as we expect. Since QEMU's mig
protocol is essentially undirectional, I wonder if the
send buffer could still be full of VMstate data waiting
to be sent ? Perhaps its fine, but I don't like relying
on luck, or hard-to-prove scenarios.

> > A second point is that from a QIOChannel POV, we need to
> > ensure that all APIs can be used in a non-blocking scenario.
> > This is why in the QIOChannelSocket impl connect/listen APIs
> > we provide both _sync and _async variants of the APIs, or
> > in the QIOChannelTLS impl, the handshake API is always
> > async with a callback to be invokved on completion.
> 
> I agree.  The issue is if so, migration code needs to be always be prepared
> with a possible async op even if in 99.9999% cases it won't happen... we
> need to complicate the multifd logic a lot for this, but the gain is
> little..
> 
> This series still used patch 1 to fix the problem (rather than do real BYE
> on preempt channels, for example) only because it's the easiest, after all
> it's still a contract in tls channel impl to allow premature termination
> for explicit shutdown()s on the host.
> 
> If we want to do 100% graceful shutdowns, we'll need to apply this to all
> channels, and the async-possible model can definitely add more complexity
> more than multifd.  I hope it won't be necessary.. but just to mention it.

Even if the migration code is relying on non-blocking sockets
for most of its work, at the time we're ready to invoke "bye",
perhaps the migration code could simply call

 qio_channel_set_blocking(ioc, true)

to switch the socket over to blocking mode.


> > The QIOChanel 'bye' method is flawed in that it is
> > asynchronous, but has no callback for completion.
> > 
> > If migration is /always/ using a blocking socket for the
> > TLS channels this isn't a problem as gnutls will complete
> > immediately, but if any async sockets are used we have no
> > way to wait for completion. This requires improving the
> > API design in some manner.
> 
> I recall one of your future series on TLS would start to enable async for
> all channels?  In all cases, we definitely don't want to have this call to
> be relevant to the blocking mode of the channels.
> 
> Would it make sense to introduce a _sync() version of it, but keep the
> original bye(), leaving the rest until a real async user appears?
> 
> I can also at least drop this patch as of now, because we can still wish it
> almost always be synchronous.  However we have risk forgetting that forever
> and hit it a few years later..

If we leave the current code as-is, and relying on migration switching
to blocking mode first before calling bye, we'll be ok

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


