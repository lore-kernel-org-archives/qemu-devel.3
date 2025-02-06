Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C48C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Pa-0006cn-5a; Thu, 06 Feb 2025 13:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg6PU-0006b6-4H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg6PS-0005gZ-5x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738865728;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+TD6PuK7Z1HIcYUtXmzeeFVkEbnitwoXqqM8NfK1VXw=;
 b=IPk6XqyjITNy5yHKQZArvBhZrc3hwkJOnAkq+SPSaOZC2ZCHBtWgYRlKOtF1hbxFDFqTx2
 LF9VZF3tH402wz9xqdab6zofcGmvBvuzf0kb0HWVbCIv3EwJIObZ7lfAnRAPkr1YgkmDnP
 bJcJoMt/3Z1Svl2ezaGQrC8TJz/DnNg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-PesH3BSJPcmSbHv__Desew-1; Thu,
 06 Feb 2025 13:15:23 -0500
X-MC-Unique: PesH3BSJPcmSbHv__Desew-1
X-Mimecast-MFC-AGG-ID: PesH3BSJPcmSbHv__Desew
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 286E91801A1F; Thu,  6 Feb 2025 18:15:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0675D19560AE; Thu,  6 Feb 2025 18:15:19 +0000 (UTC)
Date: Thu, 6 Feb 2025 18:15:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 1/4] crypto: Allow gracefully ending the TLS session
Message-ID: <Z6T8NANLpq_DarEu@redhat.com>
References: <20250206175824.22664-1-farosas@suse.de>
 <20250206175824.22664-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206175824.22664-2-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 06, 2025 at 02:58:21PM -0300, Fabiano Rosas wrote:
> QEMU's TLS session code provides no way to call gnutls_bye() to
> terminate a TLS session. Callers of qcrypto_tls_session_read() can
> choose to ignore a GNUTLS_E_PREMATURE_TERMINATION error by setting the
> gracefulTermination argument.
> 
> The QIOChannelTLS ignores the premature termination error whenever
> shutdown() has already been issued. This is not enough anymore for the
> migration code due to changes [1] in the synchronization between
> migration source and destination.
> 
> Add support for calling gnutls_bye() in the tlssession layer so users
> of QIOChannelTLS can clearly identify the end of a TLS session.
> 
> 1- 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  crypto/tlssession.c         | 40 +++++++++++++++++++++++++++++++++++++
>  include/crypto/tlssession.h | 22 ++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 77286e23f4..d52714a3f3 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -585,6 +585,40 @@ qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *session)
>      }
>  }
>  
> +int
> +qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
> +{
> +    int ret;
> +
> +    if (!session->handshakeComplete) {
> +        return 0;
> +    }
> +
> +    ret = gnutls_bye(session->handle, GNUTLS_SHUT_WR);
> +
> +    if (!ret) {
> +        return QCRYPTO_TLS_BYE_COMPLETE;
> +    }
> +
> +    if (ret == GNUTLS_E_INTERRUPTED || ret == GNUTLS_E_AGAIN) {
> +        int direction = gnutls_record_get_direction(session->handle);
> +        return direction ? QCRYPTO_TLS_BYE_SENDING : QCRYPTO_TLS_BYE_RECVING;
> +    }
> +
> +    if (session->rerr || session->werr) {
> +        error_setg(errp, "TLS termination failed: %s: %s", gnutls_strerror(ret),
> +                   error_get_pretty(session->rerr ?
> +                                    session->rerr : session->werr));
> +    } else {
> +        error_setg(errp, "TLS termination failed: %s", gnutls_strerror(ret));
> +    }
> +
> +    error_free(session->rerr);
> +    error_free(session->werr);
> +    session->rerr = session->werr = NULL;
> +
> +    return -1;
> +}
>  
>  int
>  qcrypto_tls_session_get_key_size(QCryptoTLSSession *session,
> @@ -699,6 +733,12 @@ qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess)
>  }
>  
>  
> +int
> +qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
> +{
> +    return QCRYPTO_TLS_BYE_COMPLETE;
> +}
> +
>  int
>  qcrypto_tls_session_get_key_size(QCryptoTLSSession *sess,
>                                   Error **errp)
> diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
> index f694a5c3c5..c0f64ce989 100644
> --- a/include/crypto/tlssession.h
> +++ b/include/crypto/tlssession.h
> @@ -323,6 +323,28 @@ typedef enum {
>  QCryptoTLSSessionHandshakeStatus
>  qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess);
>  
> +typedef enum {
> +    QCRYPTO_TLS_BYE_COMPLETE,
> +    QCRYPTO_TLS_BYE_SENDING,
> +    QCRYPTO_TLS_BYE_RECVING,
> +} QCryptoTLSSessionByeStatus;
> +
> +/**
> + * qcrypto_tls_session_bye:
> + * @session: the TLS session object
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Start, or continue, a TLS termination sequence. If the underlying
> + * data channel is non-blocking, then this method may return control
> + * before the termination is complete. The return value will indicate
> + * whether the termination has completed, or is waiting to send or
> + * receive data. In the latter cases, the caller should setup an event
> + * loop watch and call this method again once the underlying data
> + * channel is ready to read or write again.
> + */
> +int
> +qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp);

For handshake I have separate methods

   qcrypto_tls_session_handshake
   qcrypto_tls_session_get_handshake_status

Essentially because I was missing gnutls which has the separate
method to get the record direction.

I would prefer if the handshake and bye code used the same design
pattern.

In retrospect the 2 separate methods for handshake appears redundant
as all uses of them invoke both from the same piece of code. So I'm
fine if you re-factor the existing handshake method to return the
status immediate and get rid of qcrypto_tls_session_get_handshake_status
to match you 'bye' design here.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


