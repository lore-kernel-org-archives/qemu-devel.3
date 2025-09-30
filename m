Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CABCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YZq-0004dr-02; Tue, 30 Sep 2025 07:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3YZk-0004Zw-7L
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3YZb-0007ZP-KB
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759231846;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7UWBXoGxj4jmZyH2TqWRnhB/wrjTZt1zopdNfZ8FNo=;
 b=ZGfzYjauDbYuMfNiprwPpfT0tnMn+Gq0n2bPKq1IhY8n8S7iBMY1DyU4R3CqWX1JbgVQMm
 70cAZ8SRQv81eYK1kYU+ch/OzjlnBiA3MId8HzEVOMvRdn44OsAp92ORdALYGri3a9/ObZ
 WO0lVyxZdirE1BS2Up08YsUiL8kSJM0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-oTzBGAhTNkCu5trgj2ekIQ-1; Tue,
 30 Sep 2025 07:30:43 -0400
X-MC-Unique: oTzBGAhTNkCu5trgj2ekIQ-1
X-Mimecast-MFC-AGG-ID: oTzBGAhTNkCu5trgj2ekIQ_1759231842
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6D031955F2B; Tue, 30 Sep 2025 11:30:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EFB619560B4; Tue, 30 Sep 2025 11:30:40 +0000 (UTC)
Date: Tue, 30 Sep 2025 12:30:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Grant Millar | Cylo <rid@cylo.io>
Subject: Re: [PATCH 2/2] io: fix use after free in websocket handshake code
Message-ID: <aNu_XWvcKI5TwCxW@redhat.com>
References: <20250930110834.2551757-1-berrange@redhat.com>
 <20250930110834.2551757-3-berrange@redhat.com>
 <CAJ+F1CJsoevDyvzpfSpcTop06aUT_HQ9CFzdHAy0wKyMFuhbrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJsoevDyvzpfSpcTop06aUT_HQ9CFzdHAy0wKyMFuhbrQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 30, 2025 at 03:26:30PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Sep 30, 2025 at 3:08 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > If the QIOChannelWebsock object is freed while it is waiting to
> > complete a handshake, a GSource is leaked. This can lead to the
> > callback firing later on and triggering a use-after-free in the
> > use of the channel. This was observed in the VNC server with the
> > following trace from valgrind:
> >
> > ==2523108== Invalid read of size 4
> > ==2523108==    at 0x4054A24: vnc_disconnect_start (vnc.c:1296)
> > ==2523108==    by 0x4054A24: vnc_client_error (vnc.c:1392)
> > ==2523108==    by 0x4068A09: vncws_handshake_done (vnc-ws.c:105)
> > ==2523108==    by 0x44863B4: qio_task_complete (task.c:197)
> > ==2523108==    by 0x448343D: qio_channel_websock_handshake_io (channel-websock.c:588)
> > ==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
> > ==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
> > ==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
> > ==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
> > ==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
> > ==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
> > ==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
> > ==2523108==    by 0x454F300: qemu_default_main (main.c:37)
> > ==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
> > ==2523108==  Address 0x57a6e0dc is 28 bytes inside a block of size 103,608 free'd
> > ==2523108==    at 0x5F2FE43: free (vg_replace_malloc.c:989)
> > ==2523108==    by 0x6EDC444: g_free (gmem.c:208)
> > ==2523108==    by 0x4053F23: vnc_update_client (vnc.c:1153)
> > ==2523108==    by 0x4053F23: vnc_refresh (vnc.c:3225)
> > ==2523108==    by 0x4042881: dpy_refresh (console.c:880)
> > ==2523108==    by 0x4042881: gui_update (console.c:90)
> > ==2523108==    by 0x45EFA1B: timerlist_run_timers.part.0 (qemu-timer.c:562)
> > ==2523108==    by 0x45EFC8F: timerlist_run_timers (qemu-timer.c:495)
> > ==2523108==    by 0x45EFC8F: qemu_clock_run_timers (qemu-timer.c:576)
> > ==2523108==    by 0x45EFC8F: qemu_clock_run_all_timers (qemu-timer.c:663)
> > ==2523108==    by 0x45EC765: main_loop_wait (main-loop.c:600)
> > ==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
> > ==2523108==    by 0x454F300: qemu_default_main (main.c:37)
> > ==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
> > ==2523108==  Block was alloc'd at
> > ==2523108==    at 0x5F343F3: calloc (vg_replace_malloc.c:1675)
> > ==2523108==    by 0x6EE2F81: g_malloc0 (gmem.c:133)
> > ==2523108==    by 0x4057DA3: vnc_connect (vnc.c:3245)
> > ==2523108==    by 0x448591B: qio_net_listener_channel_func (net-listener.c:54)
> > ==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
> > ==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
> > ==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
> > ==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
> > ==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
> > ==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
> > ==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
> > ==2523108==    by 0x454F300: qemu_default_main (main.c:37)
> > ==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
> > ==2523108==
> >
> > The above can be reproduced by launching QEMU with
> >
> >   $ qemu-system-x86_64 -vnc localhost:0,websocket=5700
> >
> > and then repeatedly running:
> >
> >   for i in {1..100}; do
> >      (echo -n "GET / HTTP/1.1" && sleep 0.05) | nc -w 1 localhost 5700 &
> >   done
> >
> > Reported-by: Grant Millar | Cylo <rid@cylo.io>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/io/channel-websock.h |  1 +
> >  io/channel-websock.c         | 16 ++++++++++------
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
> > index e180827c57..d1e760e449 100644
> > --- a/include/io/channel-websock.h
> > +++ b/include/io/channel-websock.h
> > @@ -61,6 +61,7 @@ struct QIOChannelWebsock {
> >      size_t payload_remain;
> >      size_t pong_remain;
> >      QIOChannelWebsockMask mask;
> > +    guint hs_io_tag;
> >      guint io_tag;
> 
> I think it's worth a comment on why it needs two tags, and how they
> relate to each other.
> 
> >      Error *io_err;
> >      gboolean io_eof;
> > diff --git a/io/channel-websock.c b/io/channel-websock.c
> > index 56d53355d5..588c313dfb 100644
> > --- a/io/channel-websock.c
> > +++ b/io/channel-websock.c
> > @@ -597,7 +597,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
> >      error_propagate(&wioc->io_err, err);
> >
> >      trace_qio_channel_websock_handshake_reply(ioc);
> > -    qio_channel_add_watch(
> > +    wioc->hs_io_tag = qio_channel_add_watch(
> >          wioc->master,
> >          G_IO_OUT,
> >          qio_channel_websock_handshake_send,
> > @@ -907,11 +907,12 @@ void qio_channel_websock_handshake(QIOChannelWebsock *ioc,
> >
> >      trace_qio_channel_websock_handshake_start(ioc);
> >      trace_qio_channel_websock_handshake_pending(ioc, G_IO_IN);
> > -    qio_channel_add_watch(ioc->master,
> > -                          G_IO_IN,
> > -                          qio_channel_websock_handshake_io,
> > -                          task,
> > -                          NULL);
> > +    ioc->hs_io_tag = qio_channel_add_watch(
> > +        ioc->master,
> > +        G_IO_IN,
> > +        qio_channel_websock_handshake_io,
> > +        task,
> > +        NULL);
> 
> There is still an untracked qio_channel_add_watch(). I suppose you
> checked that, it could use a comment explaining why it's left.

I don't see any untracked add_watch remaining ? (If you're just doing a
grep, you'll miss the prior line context where it captures the return
value)

> 
> >  }
> >
> >
> > @@ -1212,6 +1213,9 @@ static int qio_channel_websock_close(QIOChannel *ioc,
> >      buffer_free(&wioc->encinput);
> >      buffer_free(&wioc->encoutput);
> >      buffer_free(&wioc->rawinput);
> > +    if (wioc->hs_io_tag) {
> > +        g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
> > +    }
> >      if (wioc->io_tag) {
> >          g_clear_handle_id(&wioc->io_tag, g_source_remove);
> >      }
> > --
> > 2.50.1
> >
> 
> 
> -- 
> Marc-André Lureau
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


