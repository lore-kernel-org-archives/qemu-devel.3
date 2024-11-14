Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC2CD68B31
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBbfU-0004cL-E1; Thu, 14 Nov 2024 10:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBbfP-0004bQ-6N
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 10:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBbfM-0007qo-Gl
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 10:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731597710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kc9WrGQYFC+CseghwNoBXrcEizvnsn9eu3Xxo64vVW8=;
 b=f0H6jRy8MjyOcOlY+O8CnVJqTKN+oP/UCAz263LXfzDMJHsgtG6pw86wf2KUnSjGniKSom
 Hs7YOXn2oyVT9WyakmEcE+Li08X3yVt9viVHJ8uygggg3QMm5U57BN8cN3QTBxNFafjMLp
 xT582g4Q8PjKlB6NecLKoyjLbrDY0l8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-DXaxYBhSMuO-tIL0DQYedg-1; Thu,
 14 Nov 2024 10:21:47 -0500
X-MC-Unique: DXaxYBhSMuO-tIL0DQYedg-1
X-Mimecast-MFC-AGG-ID: DXaxYBhSMuO-tIL0DQYedg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DDD419560B5; Thu, 14 Nov 2024 15:21:45 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC0A130000DF; Thu, 14 Nov 2024 15:21:40 +0000 (UTC)
Date: Thu, 14 Nov 2024 16:21:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, hreitz@redhat.com, jjelen@redhat.com,
 mpitt@redhat.com
Subject: Re: [PATCH ssh] ssh: Do not switch session to non-blocking mode
Message-ID: <ZzYVgRo_l2ZHQztg@redhat.com>
References: <20241113115000.2494785-1-rjones@redhat.com>
 <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
 <20241113130021.GA20898@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113130021.GA20898@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 13.11.2024 um 14:00 hat Richard W.M. Jones geschrieben:
> On Wed, Nov 13, 2024 at 03:02:59PM +0300, Michael Tokarev wrote:
> > Heh. I was creating a qemu bug report on gitlab when this email arrived :)
> > 
> > 13.11.2024 14:49, Richard W.M. Jones wrote:
> > >From: Jakub Jelen <jjelen@redhat.com>
> > >
> > >The libssh does not handle non-blocking mode in SFTP correctly. The
> > >driver code already changes the mode to blocking for the SFTP
> > >initialization, but for some reason changes to non-blocking mode.
> > 
> > "changes to non-blocking mode LATER", I guess, - or else it's a bit
> > difficult to read.  But this works too.
> > 
> > >This used to work accidentally until libssh in 0.11 branch merged
> > >the patch to avoid infinite looping in case of network errors:
> > >
> > >https://gitlab.com/libssh/libssh-mirror/-/merge_requests/498
> > >
> > >Since then, the ssh driver in qemu fails to read files over SFTP
> > >as the first SFTP messages exchanged after switching the session
> > >to non-blocking mode return SSH_AGAIN, but that message is lost
> > >int the SFTP internals and interpretted as SSH_ERROR, which is
> > >returned to the caller:
> > >
> > >https://gitlab.com/libssh/libssh-mirror/-/issues/280
> > >
> > >This is indeed an issue in libssh that we should address in the
> > >long term, but it will require more work on the internals. For
> > >now, the SFTP is not supported in non-blocking mode.
> > 
> > The comment at init where the code sets socket to blocking mode, says:
> > 
> >     /*
> >      * Make sure we are in blocking mode during the connection and
> >      * authentication phases.
> >      */
> >     ssh_set_blocking(s->session, 1);
> > 
> > 
> > There are a few other places where the code expect "some" blocking
> > mode, changes it to blocking, and restores the mode later, - eg,
> > see ssh_grow_file().  It looks all this has to be fixed too.

I agree, if we're moving away from non-blocking sessions, then we should
remove the switching everywhere.

But obviously...

> I'll just note that I'm only forwarding on the patch from Jakub.
> I didn't write it.
> 
> I did lightly test it, and it seems to work.  However it seems also
> likely that it is causing qemu to block internally.  Probably not
> noticable for light use, but not something that we'd want for serious
> use.  However if libssh doesn't support non-blocking SFTP there's not
> much we can do about that in qemu.

...just making it blocking is not acceptable. It will potentially make
the guest hang while we're waiting for sftp responses.

I see that there is an sftp_aio_*() API, but it looks weird. Instead of
allowing you to just poll the next request that is ready, you have to
call a (blocking) wait on a specific request.

co_yield(), which is currently used when sftp_read() returns SSH_AGAIN,
makes sure that we poll the socket fd, so we can know that _something_
new has arrived. However it's unclear to me how to know _which_ request
received a reply and can be completed now. It seems you have to call
sftp_aio_wait_*() in non-blocking mode on all requests to do that, which
probably is affected by the libssh bug, too.

So I'm not sure if sftp_aio_*() can be combined with something else into
a working solution, and I also don't know if it's affected by the same
libssh bug.

Jakub, can you help with that?

> I would recommend using nbdkit-ssh-plugin instead anyway as it is much
> more featureful and doesn't have this problem as we use real threads
> instead of coroutines.

Telling people to switch away from QEMU is not an appropriate fix for
the problem.

QEMU has all of the infrastructure with thread pools etc., that's not a
unique thing of nbdkit. So if libssh can't provide working non-blocking
connections, we'll have to use blocking sftp_read() in a worker thread.
It's uglier than using a proper asynchronous interface, but we'll have
to work with whatever we get from the library.

As far as I can see, libssh sessions aren't thread safe, so we'll have
to make sure to have only one request going at the same time, but I
assume that calling ssh_read/write() from different threads sequentially
isn't a problem?

> > I wonder if qemu ssh driver needs to mess with blocking mode of this
> > socket in the first place, ever.  Is there a way qemu can get non-blocking
> > socket in this context?  I can only think of fd=NNN, but is it
> > possible for this socket to be non-blocking?

I'm not sure if this is actually related to blocking sockets
specifically. It seems to me that it's more about blocking behaviour in
libssh itself, while it internally uses poll() to avoid blocking.

Kevin


