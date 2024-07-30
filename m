Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC734C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYciK-0003OL-KI; Mon, 29 Jul 2024 22:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYciG-0003M4-Rk
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYciF-0000xX-CT
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722306942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x/lf1fnpWqoPcd+N8YM0a4CV8DWy42YlWbuLK1nNl9I=;
 b=iyHc+kos/buA2Ex+Fgc//EWxymGmRdsp0USgSmXNrpVoRKx+jD7x/WxxdipMSQz6N0d2SJ
 q3X4nhWoJwaomlcZrm3ePYzwV91fsyuYwDy311mKOIN/O49tPE+k165pVSRFcA0OaqBLP8
 gbUKpISwLPLPAkN+PQCF/o33voO1RBg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-zKIBzAReP-OUEhuaC5Maiw-1; Mon,
 29 Jul 2024 22:35:33 -0400
X-MC-Unique: zKIBzAReP-OUEhuaC5Maiw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A20D21955D44; Tue, 30 Jul 2024 02:35:31 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 738431955D42; Tue, 30 Jul 2024 02:35:28 +0000 (UTC)
Date: Mon, 29 Jul 2024 21:35:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 andrey.drobyshev@virtuozzo.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com
Subject: Re: [PATCH] nbd: Prevent NULL pointer dereference in
 nbd_blockdev_client_closed()
Message-ID: <ikmoveaqtlvx4y4xfy5cggn5ws37yryuwrhs3tum6xp23tpmhi@mwuwvhm6aavv>
References: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
 <0a6671e8-58ce-4f63-9e51-b9f33e6d0a2d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6671e8-58ce-4f63-9e51-b9f33e6d0a2d@virtuozzo.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jun 28, 2024 at 11:58:37AM GMT, Alexander Ivanov wrote:
> Ping?
> 
> On 6/7/24 17:00, Alexander Ivanov wrote:
> >   static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
> >   {
> >       nbd_client_put(client);
> > +    if (nbd_server == NULL) {
> > +        return;
> > +    }
> >       assert(nbd_server->connections > 0);
> >       nbd_server->connections--;
> >       nbd_update_server_watch(nbd_server);
>

I've spent more time looking at this, and I'm stumped.  Maybe Dan can
help out.  If I understand correctly, here's the race situation we
have:

qemu main loop                coroutine                    client
QMP nbd-server-start
 - calls nbd_server_start
   - assigns nbd_server = g_new0()
   - calls qio_net_listener_open_sync
   - calls nbd_server_update_watch
     - calls qio_net_listener_set_client_func(, nbd_accept, )
     - waiting for client is now in coroutine
- returns control to QMP main loop
                                                           opens TCP socket
                              - qio notices incoming connection
                                - calls nbd_accept callback
                                - starts NBD handshake nbd_client_new(, nbd_blockdev_client_closed)
QMP nbd-server-stop
 - calls nbd_server_stop
   - calls nbd_server_free
     - calls qio_net_listener_disconnect()
       - marks qio channel as useless
   - sets nbd_server = NULL
                                - qio sees channel is useless, disconnects
                                                           client deals gracefully with dead connection
                                - calls nbd_blockdev_client_closed callback
                                - segfault since nbd_server->connections derefs NULL


Thread 1 "qemu-kvm" received signal SIGSEGV, Segmentation fault.
0x000055555600af59 in nbd_blockdev_client_closed (client=0x55555810dfc0, 
    ignored=false) at ../blockdev-nbd.c:56
56	    assert(nbd_server->connections > 0);
(gdb) p nbd_server
$1 = (NBDServerData *) 0x0
(gdb) bt
#0  0x000055555600af59 in nbd_blockdev_client_closed
    (client=0x55555810dfc0, ignored=false) at ../blockdev-nbd.c:56
#1  0x0000555555ff72f9 in client_close
    (client=0x55555810dfc0, negotiated=false) at ../nbd/server.c:1624
#2  0x0000555555ffbc49 in nbd_co_client_start (opaque=0x55555810dfc0)
    at ../nbd/server.c:3198
#3  0x0000555556220629 in coroutine_trampoline (i0=1488434896, i1=21845)

Worse, the race could go another way: if another QMP nbd-server-start
is called fast enough before the coroutine finishes the nbd_accept
code from the first connection, it could attempt to modify the second
nbd_server object, which may be associated with a completely different
socket.

As far as I can tell, the problem stems from the fact that the attempt
to establish the connection with the client is continuing in a
background coroutine despite our efforts to honor the QMP
nbd-server-stop command.  But I'm not sure on the proper way to inform
qio to abandon all incoming traffic to a given net listener.  Or maybe
I should just change the semantics of QMP nbd-server-stop to fail if
there are known connections from and nbd_accept() - but I still don't
want that to wait indefinitely, so I still want some way to tell the
qio channel that the server is going away and to tear down sockets as
soon as possible.

As a stopgap, something like this might prevent the SEGV:

diff --git i/blockdev-nbd.c w/blockdev-nbd.c
index 213012435f4..2f5ea094407 100644
--- i/blockdev-nbd.c
+++ w/blockdev-nbd.c
@@ -277,6 +277,12 @@ void qmp_nbd_server_stop(Error **errp)

     blk_exp_close_all_type(BLOCK_EXPORT_TYPE_NBD);

+    if (qio_net_listener_is_connected(nbd_server->listener) ||
+        nbd_server->connections > 0) {
+        error_setg(errp, "NBD server still has connected clients");
+        return;
+    }
+
     nbd_server_free(nbd_server);
     nbd_server = NULL;
 }

but it's not as graceful as I'd like (it would be nicer to have the
nbd-server-stop command wait until it knows all connections are
cleaned, instead of failing up front).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


