Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9181CFCB604
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWUl-0006lg-M1; Fri, 06 Mar 2026 09:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyWUj-0006gJ-9i
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyWUg-0000bZ-TG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772808573;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sCsWAMeZm3P2Dc1lVbRc3TpazSb714n0pST0OwkVcA=;
 b=ACg3GogCK72bRjsU8rWnL+yk3JJhSI1B+YrWKo4bSFYnOgsOwbXBvBCwmdG+5MbrXE6nrc
 6FDRmeCPkM4RVHdWndtemez+A1qi+jxC4MB4xrEL2n9aodwC3jsQva1LNwfwUkijorOXgf
 inA6EWuvYm77bt9fZc57GmXmb6BQn5s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-OsJ4AgIcPH614uN7zVRLYA-1; Fri,
 06 Mar 2026 09:49:29 -0500
X-MC-Unique: OsJ4AgIcPH614uN7zVRLYA-1
X-Mimecast-MFC-AGG-ID: OsJ4AgIcPH614uN7zVRLYA_1772808568
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A08A9195605F; Fri,  6 Mar 2026 14:49:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.197])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90CD61956095; Fri,  6 Mar 2026 14:49:26 +0000 (UTC)
Date: Fri, 6 Mar 2026 14:49:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 4/4] chardev: Introduce a lock for hup_source
Message-ID: <aarpcvImyt35Hido@redhat.com>
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-5-farosas@suse.de>
 <aCsPOyZCu-AcZOI3@redhat.com>
 <CAFEAcA_BvkKaF-qgJm25wSwuLEBedxL_pRVedQadCh1fVQBr8w@mail.gmail.com>
 <aagKqykyAO1svo_f@redhat.com>
 <CAFEAcA88RR05VXhz=j_+EiDYHUUtsMW0kX9PV04B1toK_dd95Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA88RR05VXhz=j_+EiDYHUUtsMW0kX9PV04B1toK_dd95Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 06, 2026 at 01:57:45PM +0000, Peter Maydell wrote:
> On Wed, 4 Mar 2026 at 10:34, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Sat, Feb 28, 2026 at 03:16:11PM +0000, Peter Maydell wrote:
> > > I had a look at this, and although I couldn't get a specific
> > > backtrace, I got enough information from asan leak backtraces
> > > and looking at the code that I think I understand where the race
> > > is here:
> > >
> > > vhost-user-test.c:test_server_create_chr() sets up a chardev with:
> > >  qemu_chr_new()
> > >  qemu_chr_fe_init()
> > >  qemu_chr_fe_set_handlers()
> > >
> > > For the "connect-fail" and "flags-mismatch" tests, it includes in
> > > the options to the chardev "reconnect-ms=1000".
> > >
> > > qemu_chr_new() ends up in tcp_chr_open(), which calls
> > > qmp_chardev_open_socket_client().
> > >
> > > If reconnect_ms is not 0, qmp_chardev_open_socket_client() calls
> > > tcp_chr_connect_client_async() instead of doing the connect synchronously.
> > > That kicks off a qio_task_new() to do the connecting, and immediately
> > > returns, so we return successfully from qemu_chr_new(). So
> > > test_server_create_chr() will continue execution into qemu_chr_fe_init()
> > > and qemu_chr_fe_set_handlers().
> > >
> > > qemu_chr_fe_set_handlers() calls qemu_chr_be_update_read_handlers(), which
> > > calls the chr_update_read_handler method for the ChardevClass, which here
> > > is tcp_chr_update_read_handler(). That function calls update_ioc_handlers().
> > >
> > > Meanwhile, the thread that got kicked off to do the connect is
> > > running in parallel. If the connect succeeds then qemu_chr_socket_conneted()
> > > will call tcp_chr_connect(), which will also call
> > > update_ioc_handlers(). (If the connect fails then presumably we end
> > > up in the tcp_char_disconnect or otherwise destroying the chardev,
> > > though I haven't figured out exactly what happens in this case.)
> > >
> > > None of this appears to be taking any kind of lock while it modifies
> > > the SocketChardev fields, so we could have two threads in
> > > update_ioc_handlers() simultaneously.
> >
> > It is subtle, as the QIOTask object deals with 2 separate callbacks.
> >
> > The callback that is provided to qio_task_new() is what is invoked when
> > the task is marked as completed. This is guaranteed to always be
> > invoked in main event loop context.
> >
> > The callback that is provided to qio_task_run_in_thread() is what runs
> > in the throwaway background thread.  When this callback returns, the
> > QIOTask creates a glib idle source in the main event loop to run the
> > completion callback.
> >
> >
> > So wrt char-socket.c, tcp_chr_connect_client_task will run in the
> > background thread, but it only calls QIOChannel APIs so is safe.
> >
> > The qemu_chr_socket_connected method will run in main event loop
> > context, so it does not need locking wrt other chardev I/O
> > callbacks.
> 
> This is starting to sound like the problem is the test code. The
> test code is calling qemu_chr_new() and qemu_chr_fe_set_handlers()
> from a random thread it created by directly calling g_thread_new().
> So these calls from this thread do not have any kind of lock and
> can run in parallel with the qemu_chr_socket_connected method from
> the main event loop.
> 
> I guess we need to take a lock here, but which one?
> 
> > >  How is this intended to work ? Is the test case code incorrect to assume
> > > it can work with the chardev it got back from qemu_chr_new(), or should
> > > the chardev be handling this case?
> >
> > The test is really rather had to understand, but I feel like something
> > in the test ought to be looking at the CHR_EVENT_OPENED event to
> > identify when the connection is actually established ?
> 
> The way to get a CHR_EVENT_OPENED would be to set the frontend
> handlers with qemu_chr_fe_set_handlers(). It's the call to set
> the frontend handlers that is already going wrong. (But the test
> doesn't really need to care about the EVENT_OPENED: it can
> just wait til it gets the "you have some data to read" callback.)

I'm rather feeling that the test program would be better off not
using chardevs at all, and instead using QIOChannelSocket directly.
The chardevs are horribly complex when trying to deal with
connection oriented semantics, as they are really not a connection
based API; the event stuff is a hacky afterthought that barely
gets us by.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


