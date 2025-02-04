Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3B1C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKeM-0008G2-PA; Tue, 04 Feb 2025 10:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfKeA-0008Dz-T1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfKe9-0007KN-8V
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738682128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WT/S80S7ib23qPdxnGGhvYVT+vNcHO/qRDiX4dY3REE=;
 b=E64V8QTy2wvnvvBCR94LTre10OXLW4fMbb6wKQbZysDk5/DWVotUNOUsK7PDZBALrvYzm5
 VgvMmwL6se0OjUoYZdWRCk4YjsqWU+7Ef57KdvqN93mwn4yw7+gszHvBaoD9mYbxzrpXET
 w+zNm+gQ5+xL38kO5QSrgE4VuNiMQtk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-GfCFNpCJNay3S7ALx_n4BA-1; Tue,
 04 Feb 2025 10:15:24 -0500
X-MC-Unique: GfCFNpCJNay3S7ALx_n4BA-1
X-Mimecast-MFC-AGG-ID: GfCFNpCJNay3S7ALx_n4BA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC8CE1805ED6; Tue,  4 Feb 2025 15:15:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A7FA18009AC; Tue,  4 Feb 2025 15:15:16 +0000 (UTC)
Date: Tue, 4 Feb 2025 15:15:13 +0000
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
Message-ID: <Z6IvAXXfIgDRYV5o@redhat.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <fdd9a0a6053ac6aed32e08cc284991a3630bbfec.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdd9a0a6053ac6aed32e08cc284991a3630bbfec.1738171076.git.maciej.szmigiero@oracle.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, Jan 30, 2025 at 11:08:28AM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Currently, hitting EOF on receive without sender terminating the TLS
> session properly causes the TLS channel to return an error (unless
> the channel was already shut down for read).
> 
> Add an optional setting whether we instead just return EOF in that
> case.
> 
> This possibility will be soon used by the migration multifd code.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/io/channel-tls.h | 11 +++++++++++
>  io/channel-tls.c         |  6 ++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
> index 26c67f17e2d3..8552c0d0266e 100644
> --- a/include/io/channel-tls.h
> +++ b/include/io/channel-tls.h
> @@ -49,6 +49,7 @@ struct QIOChannelTLS {
>      QCryptoTLSSession *session;
>      QIOChannelShutdown shutdown;
>      guint hs_ioc_tag;
> +    bool premature_eof_okay;
>  };
>  
>  /**
> @@ -143,4 +144,14 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
>  QCryptoTLSSession *
>  qio_channel_tls_get_session(QIOChannelTLS *ioc);
>  
> +/**
> + * qio_channel_tls_set_premature_eof_okay:
> + * @ioc: the TLS channel object
> + *
> + * Sets whether receiving an EOF without terminating the TLS session properly
> + * by used the other side is considered okay or an error (the
> + * default behaviour).
> + */
> +void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled);
> +
>  #endif /* QIO_CHANNEL_TLS_H */
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index aab630e5ae32..1079d6d10de1 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -147,6 +147,11 @@ qio_channel_tls_new_client(QIOChannel *master,
>      return NULL;
>  }
>  
> +void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled)
> +{
> +    ioc->premature_eof_okay = enabled;
> +}
> +
>  struct QIOChannelTLSData {
>      QIOTask *task;
>      GMainContext *context;
> @@ -279,6 +284,7 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>              tioc->session,
>              iov[i].iov_base,
>              iov[i].iov_len,
> +            tioc->premature_eof_okay ||
>              qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
>              errp);
>          if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {

IMHO a better way to do this is by defining an new flag for use with
the qio_channel_readv_full() method. That makes the ignoring of
premature shutdown a contextually scoped behaviour rather than a
global behaviour.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


