Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 10:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Xub-0001sz-Cj; Tue, 30 Sep 2025 06:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3XuZ-0001so-3c
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3XuS-0001A8-UE
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759229314;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMt8cZdbP9ADF0C5nwha38ZeffnBpnBXZWHK7GSxspg=;
 b=FqQImYh12dnI2kWc4bZJ8RQTcV6yrC56mkozRLao3RqGZgVta1aOzauofu+Cpw6tVGQqjp
 vTdwpDPebx78I1wy40eyZV2pecCV2grWJyL1HUnb07ogGFmMPy4hp/3Yaf+n3kExtXEERx
 zxzQARVWWh5COki/Q/1nEQtndNM1p+4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-kJU5ZSZbPO2q0wqW19Fy7w-1; Tue,
 30 Sep 2025 06:48:31 -0400
X-MC-Unique: kJU5ZSZbPO2q0wqW19Fy7w-1
X-Mimecast-MFC-AGG-ID: kJU5ZSZbPO2q0wqW19Fy7w_1759229310
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17348180034F; Tue, 30 Sep 2025 10:48:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 375B5195608E; Tue, 30 Sep 2025 10:48:27 +0000 (UTC)
Date: Tue, 30 Sep 2025 11:48:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Grant Millar | Cylo <rid@cylo.io>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] ui/vnc: Fix NULL pointer dereference in
 vnc_disconnect_start
Message-ID: <aNu1eJycWwySwx2l@redhat.com>
References: <CANdvy3dH9bBdopj_KUqaLD0Viq7uKn0jPObjqz6H7XvMgRnPrw@mail.gmail.com>
 <CAJ+F1CJwGZ-+dder5+icmuqSvtQ=fjce1zfrGKamYuYxVxOX9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJwGZ-+dder5+icmuqSvtQ=fjce1zfrGKamYuYxVxOX9w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

On Tue, Sep 30, 2025 at 02:38:40PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Sep 30, 2025 at 1:59 PM Grant Millar | Cylo <rid@cylo.io> wrote:
> >
> > From 0d1c4ac000a66ef22b4a0cd0c4bedd840192096a Mon Sep 17 00:00:00 2001
> > From: Rid <rid@cylo.io>
> > Date: Tue, 30 Sep 2025 10:23:58 +0100
> > Subject: [PATCH] ui/vnc: Fix NULL pointer dereference in vnc_disconnect_start
> >
> > When a WebSocket connection fails during the handshake, vs->ioc can be
> > NULL when vnc_disconnect_start() is called, leading to a segmentation
> > fault when qio_channel_close() tries to dereference it.
> >
> > This can be reproduced by sending incomplete HTTP requests to the
> > WebSocket port:
> >
> >   for i in {1..100}; do
> >     (echo -n "GET / HTTP/1.1" && sleep 0.05) | nc -w 1 <IP> <PORT> &
> >   done
> >
> 
> I tried to reproduce without success.

This loop sometimes needs to be run 3 or 4 or more times before it
will trigger.

> Could you provide a backtrace?

With valgrind the problem shows up as:

==2523108== Invalid read of size 4
==2523108==    at 0x4054A24: vnc_disconnect_start (vnc.c:1296)
==2523108==    by 0x4054A24: vnc_client_error (vnc.c:1392)
==2523108==    by 0x4068A09: vncws_handshake_done (vnc-ws.c:105)
==2523108==    by 0x44863B4: qio_task_complete (task.c:197)
==2523108==    by 0x448343D: qio_channel_websock_handshake_io (channel-websock.c:588)
==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==  Address 0x57a6e0dc is 28 bytes inside a block of size 103,608 free'd
==2523108==    at 0x5F2FE43: free (vg_replace_malloc.c:989)
==2523108==    by 0x6EDC444: g_free (gmem.c:208)
==2523108==    by 0x4053F23: vnc_update_client (vnc.c:1153)
==2523108==    by 0x4053F23: vnc_refresh (vnc.c:3225)
==2523108==    by 0x4042881: dpy_refresh (console.c:880)
==2523108==    by 0x4042881: gui_update (console.c:90)
==2523108==    by 0x45EFA1B: timerlist_run_timers.part.0 (qemu-timer.c:562)
==2523108==    by 0x45EFC8F: timerlist_run_timers (qemu-timer.c:495)
==2523108==    by 0x45EFC8F: qemu_clock_run_timers (qemu-timer.c:576)
==2523108==    by 0x45EFC8F: qemu_clock_run_all_timers (qemu-timer.c:663)
==2523108==    by 0x45EC765: main_loop_wait (main-loop.c:600)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==  Block was alloc'd at
==2523108==    at 0x5F343F3: calloc (vg_replace_malloc.c:1675)
==2523108==    by 0x6EE2F81: g_malloc0 (gmem.c:133)
==2523108==    by 0x4057DA3: vnc_connect (vnc.c:3245)
==2523108==    by 0x448591B: qio_net_listener_channel_func (net-listener.c:54)
==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108== 

I'm working on a fix for QIOChannelWebsock...  This VNC change is
wrong.

> 
> > Add a NULL check before calling qio_channel_close() to prevent the crash.
> >
> > Signed-off-by: Rid <rid@cylo.io>
> 
> Your mail is not properly formatted. git am fails.
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html
> 
 > 
> thanks
> 
> > ---
> >  ui/vnc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 77c823bf2e..1669ed1b80 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -1301,7 +1301,9 @@ static void vnc_disconnect_start(VncState *vs)
> >          g_source_remove(vs->ioc_tag);
> >          vs->ioc_tag = 0;
> >      }
> > -    qio_channel_close(vs->ioc, NULL);
> > +    if (vs->ioc) {
> > +        qio_channel_close(vs->ioc, NULL);
> > +    }
> >      vs->disconnecting = TRUE;
> >  }
> >
> > --
> > 2.39.5
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


