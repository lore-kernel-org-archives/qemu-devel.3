Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66B5C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpkD-0008Cj-PZ; Mon, 08 Apr 2024 10:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rtpkC-0008Bi-Lr
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rtpkA-0002Gm-7U
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712585583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GvTCKk98N55J9VZYlDEKNLD0jDSRmSx/9utSsAeQgVw=;
 b=HIIQUKhnIUwljXEalr34AuaWIUeJTcVNw5gZOE+SF2fDgXEe1rAfG6e19l1I7I+0j+oSQM
 zCa5/gpYI0KOXepURdDotM3dcaNtr99kgYGCPRXvGmZr9jqsaNvY7oxLAyTPe7OXeXTKKk
 kh87GY5W/OxAKCCE2hl8WYeaeLjLkFs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515--u2rruqWNW64biHPr75q7A-1; Mon,
 08 Apr 2024 10:12:59 -0400
X-MC-Unique: -u2rruqWNW64biHPr75q7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 640693C1014E;
 Mon,  8 Apr 2024 14:12:58 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C427200B09C;
 Mon,  8 Apr 2024 14:12:56 +0000 (UTC)
Date: Mon, 8 Apr 2024 09:12:51 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Zhu Yangyang <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v4] nbd/server: do not poll within a coroutine context
Message-ID: <y4qsq4xdhhne6kgwolmelw4cafyb3tj5qyow6batuljzmj5rpi@fvwfysulqvkf>
References: <20240405174523.844181-2-eblake@redhat.com>
 <7c0f6e62-2ad5-44f5-a4b2-c1518ae86af2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c0f6e62-2ad5-44f5-a4b2-c1518ae86af2@yandex-team.ru>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 08, 2024 at 11:46:39AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 05.04.24 20:44, Eric Blake wrote:
> > From: Zhu Yangyang <zhuyangyang14@huawei.com>
> > 
> > Coroutines are not supposed to block. Instead, they should yield.
> > 
> > The client performs TLS upgrade outside of an AIOContext, during
> > synchronous handshake; this still requires g_main_loop.  But the
> > server responds to TLS upgrade inside a coroutine, so a nested
> > g_main_loop is wrong.  Since the two callbacks no longer share more
> > than the setting of data.complete and data.error, it's just as easy to
> > use static helpers instead of trying to share a common code path.
> > 
> > Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
> > Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> > [eblake: move callbacks to their use point]
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I'm debating whether it is worth trying to shove this into 9.0; -rc3
is very late, and the problem is pre-existing, so I'm leaning towards
no.  At which point, it's better to get this right.

> 
> still, some notes below
> 
> > ---
> > 
> > v3: https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00375.html
> > 
> > in v4, factor even the struct to the .c files, avoiding a union [Vladimir]
> > 
> >   nbd/nbd-internal.h | 10 ----------
> >   nbd/client.c       | 27 +++++++++++++++++++++++----
> >   nbd/common.c       | 11 -----------
> >   nbd/server.c       | 29 +++++++++++++++++++++++------
> >   4 files changed, 46 insertions(+), 31 deletions(-)
> > 

> > +++ b/nbd/client.c
> > @@ -596,13 +596,31 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool strict,
> >       return 1;
> >   }
> > 
> > +/* Callback to learn when QIO TLS upgrade is complete */
> > +struct NBDTLSClientHandshakeData {
> > +    bool complete;
> > +    Error *error;
> > +    GMainLoop *loop;
> > +};
> > +
> > +static void nbd_client_tls_handshake(QIOTask *task, void *opaque)
> > +{
> > +    struct NBDTLSClientHandshakeData *data = opaque;
> > +
> > +    qio_task_propagate_error(task, &data->error);
> > +    data->complete = true;
> > +    if (data->loop) {
> > +        g_main_loop_quit(data->loop);
> > +    }
> > +}
> > +
> >   static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
> >                                           QCryptoTLSCreds *tlscreds,
> >                                           const char *hostname, Error **errp)
> >   {
> >       int ret;
> >       QIOChannelTLS *tioc;
> > -    struct NBDTLSHandshakeData data = { 0 };
> > +    struct NBDTLSClientHandshakeData data = { 0 };
> > 
> >       ret = nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, true, errp);
> >       if (ret <= 0) {
> > @@ -619,18 +637,19 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
> >           return NULL;
> >       }
> >       qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
> > -    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
> >       trace_nbd_receive_starttls_tls_handshake();
> >       qio_channel_tls_handshake(tioc,
> > -                              nbd_tls_handshake,
> > +                              nbd_client_tls_handshake,
> >                                 &data,
> >                                 NULL,
> >                                 NULL);
> > 
> >       if (!data.complete) {
> > +        data.loop = g_main_loop_new(g_main_context_default(), FALSE);
> >           g_main_loop_run(data.loop);
> > +        g_main_loop_unref(data.loop);
> 
> probably good to assert(data.complete);

Seems reasonable.

> > +++ b/nbd/server.c
> > @@ -748,6 +748,23 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
> >       return rc;
> >   }
> > 
> > +/* Callback to learn when QIO TLS upgrade is complete */
> > +struct NBDTLSServerHandshakeData {
> > +    bool complete;
> > +    Error *error;
> > +    Coroutine *co;
> > +};
> > +
> > +static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> > +{
> > +    struct NBDTLSServerHandshakeData *data = opaque;
> > +
> > +    qio_task_propagate_error(task, &data->error);
> > +    data->complete = true;
> > +    if (!qemu_coroutine_entered(data->co)) {
> > +        aio_co_wake(data->co);
> > +    }
> > +}
> > 
> >   /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
> >    * new channel for all further (now-encrypted) communication. */
> > @@ -756,7 +773,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
> >   {
> >       QIOChannel *ioc;
> >       QIOChannelTLS *tioc;
> > -    struct NBDTLSHandshakeData data = { 0 };
> > +    struct NBDTLSServerHandshakeData data = { 0 };
> > 
> >       assert(client->opt == NBD_OPT_STARTTLS);
> > 
> > @@ -777,17 +794,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
> 
> preexisting: lack coroutine_fn, as well as caller nbd_negotiate_options()

Indeed, so now would not hurt to add them now that a callback is no
longer shared between callers in different context.  But probably as a
separate patch.

> 
> > 
> >       qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
> >       trace_nbd_negotiate_handle_starttls_handshake();
> > -    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
> > +    data.co = qemu_coroutine_self();
> >       qio_channel_tls_handshake(tioc,
> > -                              nbd_tls_handshake,
> > +                              nbd_server_tls_handshake,
> >                                 &data,
> >                                 NULL,
> >                                 NULL);
> > 
> > -    if (!data.complete) {
> > -        g_main_loop_run(data.loop);
> > +    while (!data.complete) {
> 
> not "if", but "while".. Do we expect entering from somewhere except nbd_server_tls_handshake?
> 
> if not, probably safer construction would be
> 
> if (!data.complete) {
>    qemu_coroutine_yield();
>    assert(data.complete);
> }
> 
> - to avoid hiding unexpected coroutine switching bugs

TLS handshake is early enough in the NBD connection that there should
not be any parallel I/O yet (we can't switch to parallel outstanding
transactions until after successful NBD_OPT_GO), so I like your idea
of asserting that the coroutine is entered at most once.

v5 coming up

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


