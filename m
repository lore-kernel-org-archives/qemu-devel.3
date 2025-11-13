Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12577CD8C8C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZ1R-0002tI-SU; Thu, 13 Nov 2025 10:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJZ1P-0002lE-7T
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:14:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJZ1M-0001gJ-Kk
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763046838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yva3LCtc3Ow4XCdx5nA6inOwBN2KOHi6jfPM4BIbA70=;
 b=J79fY/H1KKBk8uHaDNV9HQh8tflOeN9ntj2sbgB5bpj9xnNscSILW3MsOG+3LlLGO481eF
 Ml82OcGTa8lKZ+VDJVh0vQGraohJpFtIdgahVKcA1pBIBnJ6R2bpBadI/r0xdaxBT6Tqm3
 Yj8KiQsY4/jR7M3NGvbM6Sl0ofi1tfI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-WdySCN4jMAyM9bIj4OlCZQ-1; Thu,
 13 Nov 2025 10:13:56 -0500
X-MC-Unique: WdySCN4jMAyM9bIj4OlCZQ-1
X-Mimecast-MFC-AGG-ID: WdySCN4jMAyM9bIj4OlCZQ_1763046835
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D233418AB425; Thu, 13 Nov 2025 15:13:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45BCA19540E6; Thu, 13 Nov 2025 15:13:51 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:13:49 -0600
From: Eric Blake <eblake@redhat.com>
To: Jie Song <mail@jiesong.me>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 qemu-block@nongnu.org, Jie Song <songjie_yewu@cmss.chinamobile.com>
Subject: Re: [PATCH] monitor/qmp: cleanup socket listener sources early to
 avoid fd handling race
Message-ID: <beet4rbab75nrontyxnmhyswiuyiu2rbmuvuiq6gwwy5klsbep@yjkeb32mw2rc>
References: <20251111150144.76751-1-mail@jiesong.me>
 <cslgtf2v45soo57j2qfrkefitokjkhpywllz6wait4d2nx5yt6@q34i6bk37gvk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cslgtf2v45soo57j2qfrkefitokjkhpywllz6wait4d2nx5yt6@q34i6bk37gvk>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 12, 2025 at 03:48:07PM -0600, Eric Blake wrote:
> On Tue, Nov 11, 2025 at 11:01:44PM +0800, Jie Song wrote:
> > From: Jie Song <songjie_yewu@cmss.chinamobile.com>
> > 
> > When starting a dummy QEMU process with virsh, monitor_init_qmp() enables
> > IOThread monitoring of the QMP fd by default. However, a race condition
> > exists during the initialization phase: the IOThread only removes the
> > main thread's fd watch when it reaches qio_net_listener_set_client_func_full(),
> > which may be delayed under high system load.
> > 
> > This creates a window between monitor_qmp_setup_handlers_bh() and
> > qio_net_listener_set_client_func_full() where both the main thread and
> > IOThread are simultaneously monitoring the same fd and processing events.
> > This race can cause either the main thread or the IOThread to hang and
> > become unresponsive.
> > 
> > Fix this by proactively cleaning up the listener's IO sources in
> > monitor_init_qmp() before the IOThread initializes QMP monitoring,
> > ensuring exclusive fd ownership and eliminating the race condition.
> > 
> > The fix introduces socket_chr_listener_cleanup() to destroy and unref
> > all existing IO sources on the socket chardev listener, guaranteeing
> > that no concurrent fd monitoring occurs during the transition to
> > IOThread handling.
> > 
> > Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> > ---
> >  chardev/char-socket.c         | 18 ++++++++++++++++++
> >  include/chardev/char-socket.h |  2 ++
> >  monitor/qmp.c                 |  6 ++++++
> >  3 files changed, 26 insertions(+)
> > 
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 62852e3caf..073a9da855 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -656,6 +656,24 @@ static void tcp_chr_telnet_destroy(SocketChardev *s)
> >      }
> >  }
> >  
> > +void socket_chr_listener_cleanup(Chardev *chr)
> > +{
> > +    SocketChardev *s = SOCKET_CHARDEV(chr);
> > +
> > +    if (s->listener) {
> > +        QIONetListener *listener = s->listener;
> > +        size_t i;
> > +
> > +        for (i = 0; i < listener->nsioc; i++) {
> 
> This directly accesses listener->nsioc outside of net-listener.c.
> I've got a pending patch that frowns on this type of usage (here's the
> link to v2; v3 is coming soon):
> 
> https://lore.kernel.org/qemu-devel/20251108230525.3169174-14-eblake@redhat.com/T/#m69a13da54c24ad55351b6a004ec1c0cba7a7b49c
> 
> But it might be possible to do what you want without peeking inside
> the listener; have you tested calling
> qio_net_listener_set_client_func_full() to change the callback to NULL
> prior to doing the handover to iothread, and then reregistering
> tcp_chr_accept after that point?

Thinking further, I think we may still have a problem in
QIONetListener even with my v3 patches:

| static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
|                                               GIOCondition condition,
|                                               gpointer opaque)
| {
|     QIONetListener *listener = QIO_NET_LISTENER(opaque);
|     QIOChannelSocket *sioc;
|     QIONetListenerClientFunc io_func;
|     gpointer io_data;
|     GMainContext *context;
|     AioContext *aio_context;
| 
|     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
|                                      NULL);

This unconditionally tries to accept() the client's socket...

|     if (!sioc) {
|         return TRUE;
|     }
| 
|     WITH_QEMU_LOCK_GUARD(&listener->lock) {
|         io_func = listener->io_func;
|         io_data = listener->io_data;
|         context = listener->context;
|         aio_context = listener->aio_context;
|     }
| 
|     trace_qio_net_listener_callback(listener, io_func, context, aio_context);
|     if (io_func) {
|         io_func(listener, sioc, io_data);

...and if accepted, only then does it trigger the callback to let the
user know the sioc to work with.  But if there is no io_func currently
registered...

|     }
| 
|     object_unref(OBJECT(sioc));

...the client connection is discarded, with the client being unable to
connect if it managed to land in the window when the netlistener had
no async callback registered.

I have to wonder if we should be changing the order in this function
to not attempt the qemu_channel_socket_accept() unless there is a
callback registered, so that a client that is pending service in the
window where the user code does not have an async callback installed
will still be in the queue to accept the moment an async function is
registered.  (Plus thinking of any ripple effects on whether we also
need to ensure that we aren't burning CPU in a busy loop on polling
but not clearing what the poll is looking for)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


