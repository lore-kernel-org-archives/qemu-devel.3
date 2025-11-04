Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FF2CCFA06
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGso-0004Wf-OK; Tue, 04 Nov 2025 08:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGGsg-0004IP-JN
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGGse-0006sW-Fp
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6NJ/4YZf51p1NXprw/LPKiiug67Gz5cHGvR9SFQ2Zs=;
 b=FtDCvMpmAN9I9xNpIE1Swt3EuOLGXoB3Ne8XMMyjJ5kyAaOmUJQD6Ksxg11DpUv1iAutYS
 VmMpCRRPS21AyLx/kdGFuQsy2llC1v2bg9QzN8ET9Cf/W/hdTT9+Eif/Lvg5zmA7oMJZrQ
 yPoioK8azePM81yzTkBXrZdd5GwFYGE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-jX2NtskBN8isXQGF379NYQ-1; Tue,
 04 Nov 2025 08:15:21 -0500
X-MC-Unique: jX2NtskBN8isXQGF379NYQ-1
X-Mimecast-MFC-AGG-ID: jX2NtskBN8isXQGF379NYQ_1762262120
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7DE31956066; Tue,  4 Nov 2025 13:15:20 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4ABB30001A1; Tue,  4 Nov 2025 13:15:18 +0000 (UTC)
Date: Tue, 4 Nov 2025 14:15:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 4/8] qio: Factor out helpers qio_net_listener_[un]watch
Message-ID: <aQn8ZITZmk3IWpED@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-14-eblake@redhat.com>
 <aQndkQ3knp-5d-YJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQndkQ3knp-5d-YJ@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

Am 04.11.2025 um 12:03 hat Daniel P. Berrangé geschrieben:
> On Mon, Nov 03, 2025 at 02:10:55PM -0600, Eric Blake wrote:
> > The code had three similar repetitions of an iteration over one or all
> > of nsiocs to set up a GSource, and likewise for teardown.  Since an
> > upcoming patch wants to tweak whether GSource or AioContext is used,
> > its better to consolidate that into one helper function for fewer
> > places to edit later.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  io/net-listener.c | 109 +++++++++++++++++++---------------------------
> >  1 file changed, 45 insertions(+), 64 deletions(-)
> > 
> > diff --git a/io/net-listener.c b/io/net-listener.c
> > index 15df673fb6e..e1378b9a612 100644
> > --- a/io/net-listener.c
> > +++ b/io/net-listener.c
> > @@ -106,6 +106,45 @@ int qio_net_listener_open_sync(QIONetListener *listener,
> >      }
> >  }
> 
> >  void qio_net_listener_add(QIONetListener *listener,
> >                            QIOChannelSocket *sioc)
> > @@ -125,17 +164,7 @@ void qio_net_listener_add(QIONetListener *listener,
> >      object_ref(OBJECT(sioc));
> >      listener->connected = true;
> > 
> > -    if (listener->io_func != NULL) {
> > -        trace_qio_net_listener_watch_enabled(listener, listener->io_func,
> > -                                             "add");
> > -        object_ref(OBJECT(listener));
> > -        listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
> > -            QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
> > -            qio_net_listener_channel_func,
> > -            listener, (GDestroyNotify)object_unref, listener->context);
> > -    }
> > -
> > -    listener->nsioc++;
> > +    qio_net_listener_watch(listener, listener->nsioc++, "add");
> 
> Nit-picking, I'd have a slight preference to keep the 'nsioc' increment
> on the following line from the qio_net_listener_watch call, as I don't
> like side effects in passing the function arguments.

It actually wouldn't work any more because qio_net_listener_watch()
iterates up to listener->nsioc. It needs the increased value in
listener->nsioc, and the previous one for i, so that we get exactly one
loop iteration.

Kevin


