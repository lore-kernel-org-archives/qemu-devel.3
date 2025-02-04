Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D57C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLaF-0004qT-9F; Tue, 04 Feb 2025 11:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfLZj-0004Rp-3q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:15:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfLZa-00074K-6j
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738685686;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siN3PyqS+aBuJblehcz5YYt0ExagD0LCmLsZDG18aXk=;
 b=OSifeIWfevMGED6qta4++Fc68lSASZp5VvtC4X479YUoBXdKWucvE98u22r9FKoY25jczp
 xiHtatTeNEgrbUsuCVm2f2H+7LvdbrB1x8T8Wb46KV8QVXNtPmrT0HP3YpURjlLqVUAlSP
 ZqiJ493Zd7teEupfWwoWX5M1gi6djPo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-GqhnRn4ENLi5ttUirK5SiQ-1; Tue,
 04 Feb 2025 11:14:43 -0500
X-MC-Unique: GqhnRn4ENLi5ttUirK5SiQ-1
X-Mimecast-MFC-AGG-ID: GqhnRn4ENLi5ttUirK5SiQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D19F01955F69; Tue,  4 Feb 2025 16:14:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 747E719560AA; Tue,  4 Feb 2025 16:14:36 +0000 (UTC)
Date: Tue, 4 Feb 2025 16:14:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/33] io: tls: Allow terminating the TLS session
 gracefully with EOF
Message-ID: <Z6I86e-hzJAlxk0r@redhat.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <fdd9a0a6053ac6aed32e08cc284991a3630bbfec.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6IvAXXfIgDRYV5o@redhat.com>
 <493dd3bc-8a3d-4b3c-8eea-08e674c38f40@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <493dd3bc-8a3d-4b3c-8eea-08e674c38f40@maciej.szmigiero.name>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 04, 2025 at 05:02:23PM +0100, Maciej S. Szmigiero wrote:
> On 4.02.2025 16:15, Daniel P. Berrangé wrote:
> > On Thu, Jan 30, 2025 at 11:08:28AM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Currently, hitting EOF on receive without sender terminating the TLS
> > > session properly causes the TLS channel to return an error (unless
> > > the channel was already shut down for read).
> > > 
> > > Add an optional setting whether we instead just return EOF in that
> > > case.
> > > 
> > > This possibility will be soon used by the migration multifd code.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   include/io/channel-tls.h | 11 +++++++++++
> > >   io/channel-tls.c         |  6 ++++++
> > >   2 files changed, 17 insertions(+)
> > > 
> > > diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
> > > index 26c67f17e2d3..8552c0d0266e 100644
> > > --- a/include/io/channel-tls.h
> > > +++ b/include/io/channel-tls.h
> > > @@ -49,6 +49,7 @@ struct QIOChannelTLS {
> > >       QCryptoTLSSession *session;
> > >       QIOChannelShutdown shutdown;
> > >       guint hs_ioc_tag;
> > > +    bool premature_eof_okay;
> > >   };
> > >   /**
> > > @@ -143,4 +144,14 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
> > >   QCryptoTLSSession *
> > >   qio_channel_tls_get_session(QIOChannelTLS *ioc);
> > > +/**
> > > + * qio_channel_tls_set_premature_eof_okay:
> > > + * @ioc: the TLS channel object
> > > + *
> > > + * Sets whether receiving an EOF without terminating the TLS session properly
> > > + * by used the other side is considered okay or an error (the
> > > + * default behaviour).
> > > + */
> > > +void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled);
> > > +
> > >   #endif /* QIO_CHANNEL_TLS_H */
> > > diff --git a/io/channel-tls.c b/io/channel-tls.c
> > > index aab630e5ae32..1079d6d10de1 100644
> > > --- a/io/channel-tls.c
> > > +++ b/io/channel-tls.c
> > > @@ -147,6 +147,11 @@ qio_channel_tls_new_client(QIOChannel *master,
> > >       return NULL;
> > >   }
> > > +void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled)
> > > +{
> > > +    ioc->premature_eof_okay = enabled;
> > > +}
> > > +
> > >   struct QIOChannelTLSData {
> > >       QIOTask *task;
> > >       GMainContext *context;
> > > @@ -279,6 +284,7 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
> > >               tioc->session,
> > >               iov[i].iov_base,
> > >               iov[i].iov_len,
> > > +            tioc->premature_eof_okay ||
> > >               qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
> > >               errp);
> > >           if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
> > 
> > IMHO a better way to do this is by defining an new flag for use with
> > the qio_channel_readv_full() method. That makes the ignoring of
> > premature shutdown a contextually scoped behaviour rather than a
> > global behaviour.
> 
> Something named like QIO_CHANNEL_READ_FLAG_TLS_EARLY_EOF_OKAY?

Since the flags are defined at the non-TLS layer in the API, I would
pick  "QIO_CHANNEL_READ_RELAXED_EOF", as it could conceptually make
sense to other layered channel protocols beyond TLS, even if we only
ever implement it for TLS.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


