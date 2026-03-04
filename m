Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DE4EB7EBC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjYz-0003ev-EE; Wed, 04 Mar 2026 05:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxjYr-0003df-MB
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxjYo-0004cr-NE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772620470;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtkVAO8gLh6LrO5U/dgL9troBE+x5DI20Z2PgqQ3Z/Y=;
 b=DeIa0h70gbPUUxcVc0KQ0afwO7kJEuWEhdFPGaJX3wTeWUpyj47kYfCGAruECDuaQpjJtS
 nbLUJdI04o7PaLwhMDXBL9Gz58joi162UGUssYFOFe06HWm4m4b7RD4UGzHPrY0JTNwDCK
 HySd5Aycq4wnqTGYOm+u2VdzUAh2r8A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Hypiw1stPYWzFuCNvpp-AA-1; Wed,
 04 Mar 2026 05:34:26 -0500
X-MC-Unique: Hypiw1stPYWzFuCNvpp-AA-1
X-Mimecast-MFC-AGG-ID: Hypiw1stPYWzFuCNvpp-AA_1772620465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA78019560A7; Wed,  4 Mar 2026 10:34:25 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FC971800759; Wed,  4 Mar 2026 10:34:23 +0000 (UTC)
Date: Wed, 4 Mar 2026 10:34:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 4/4] chardev: Introduce a lock for hup_source
Message-ID: <aagKqykyAO1svo_f@redhat.com>
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-5-farosas@suse.de>
 <aCsPOyZCu-AcZOI3@redhat.com>
 <CAFEAcA_BvkKaF-qgJm25wSwuLEBedxL_pRVedQadCh1fVQBr8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_BvkKaF-qgJm25wSwuLEBedxL_pRVedQadCh1fVQBr8w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 28, 2026 at 03:16:11PM +0000, Peter Maydell wrote:
> On Mon, 19 May 2025 at 12:00, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, May 15, 2025 at 07:20:14PM -0300, Fabiano Rosas wrote:
> > > It's possible for the hup_source to have its reference decremented by
> > > remove_hup_source() while it's still being added to the context,
> > > leading to asserts in glib:
> >
> > IIUC this must mean that
> >
> >   tcp_chr_free_connection
> >
> > is being called concurrently with
> >
> >   update_ioc_handlers
> >
> > I'm wondering if that is really intended, or a sign of a deeper
> > bug that we'll just paper over if we add the mutex proposed here.
> >
> > Are you able to provide stack traces showing the 2 concurrent
> > operations that are triggering this problem ?
> 
> (Pulling up this thread from last year since I ran into something
> similar running the sanitizers, and Fabiano pointed me at this series
> he'd sent that fixes most/all of the problems.)
> 
> I had a look at this, and although I couldn't get a specific
> backtrace, I got enough information from asan leak backtraces
> and looking at the code that I think I understand where the race
> is here:
> 
> vhost-user-test.c:test_server_create_chr() sets up a chardev with:
>  qemu_chr_new()
>  qemu_chr_fe_init()
>  qemu_chr_fe_set_handlers()
> 
> For the "connect-fail" and "flags-mismatch" tests, it includes in
> the options to the chardev "reconnect-ms=1000".
> 
> qemu_chr_new() ends up in tcp_chr_open(), which calls
> qmp_chardev_open_socket_client().
> 
> If reconnect_ms is not 0, qmp_chardev_open_socket_client() calls
> tcp_chr_connect_client_async() instead of doing the connect synchronously.
> That kicks off a qio_task_new() to do the connecting, and immediately
> returns, so we return successfully from qemu_chr_new(). So
> test_server_create_chr() will continue execution into qemu_chr_fe_init()
> and qemu_chr_fe_set_handlers().
> 
> qemu_chr_fe_set_handlers() calls qemu_chr_be_update_read_handlers(), which
> calls the chr_update_read_handler method for the ChardevClass, which here
> is tcp_chr_update_read_handler(). That function calls update_ioc_handlers().
> 
> Meanwhile, the thread that got kicked off to do the connect is
> running in parallel. If the connect succeeds then qemu_chr_socket_conneted()
> will call tcp_chr_connect(), which will also call
> update_ioc_handlers(). (If the connect fails then presumably we end
> up in the tcp_char_disconnect or otherwise destroying the chardev,
> though I haven't figured out exactly what happens in this case.)
> 
> None of this appears to be taking any kind of lock while it modifies
> the SocketChardev fields, so we could have two threads in
> update_ioc_handlers() simultaneously.

It is subtle, as the QIOTask object deals with 2 separate callbacks.

The callback that is provided to qio_task_new() is what is invoked when
the task is marked as completed. This is guaranteed to always be
invoked in main event loop context.

The callback that is provided to qio_task_run_in_thread() is what runs
in the throwaway background thread.  When this callback returns, the
QIOTask creates a glib idle source in the main event loop to run the
completion callback.


So wrt char-socket.c, tcp_chr_connect_client_task will run in the
background thread, but it only calls QIOChannel APIs so is safe.

The qemu_chr_socket_connected method will run in main event loop
context, so it does not need locking wrt other chardev I/O
callbacks.

>  How is this intended to work ? Is the test case code incorrect to assume
> it can work with the chardev it got back from qemu_chr_new(), or should
> the chardev be handling this case?

The test is really rather had to understand, but I feel like something
in the test ought to be looking at the CHR_EVENT_OPENED event to
identify when the connection is actually established ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


