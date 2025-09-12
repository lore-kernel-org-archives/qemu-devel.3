Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1378CCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 11:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux1nu-0004ID-Mh; Fri, 12 Sep 2025 07:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux1nh-0004Fs-Sl
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux1nZ-0005VT-SK
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757675908;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhXhGWrzDthFEh5BZnKdQG/eOWAgCh3NRy37NOjuXeI=;
 b=V5hu+tAw76KNjI8g+1/hrCFrGA3mt5dUXOPE7NrZh9NLhnbB1fPhNAA1DhRSsatuURK9rA
 4RjZUF5nuapRHIUBYMgNRQB4rPBBJjcp3Y75AZmwBbuwn+Yv+lI+yY4VLnhomz4NApGcOo
 Eu2qXVB5ZBCgE7WS0wn5+RWGxSOJoAg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-j3DnC4BNPEWYAjTOBNIUsA-1; Fri,
 12 Sep 2025 07:18:26 -0400
X-MC-Unique: j3DnC4BNPEWYAjTOBNIUsA-1
X-Mimecast-MFC-AGG-ID: j3DnC4BNPEWYAjTOBNIUsA_1757675905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22391944F03; Fri, 12 Sep 2025 11:18:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7272218003FC; Fri, 12 Sep 2025 11:18:22 +0000 (UTC)
Date: Fri, 12 Sep 2025 12:18:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/3] io/crypto: Move tls premature termination
 handling into QIO layer
Message-ID: <aMQBehejwDPEO5C1@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911212355.1943494-2-peterx@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 05:23:53PM -0400, Peter Xu wrote:
> QCryptoTLSSession allows TLS premature termination in two cases, one of the
> case is when the channel shutdown() is invoked on READ side.
> 
> It's possible the shutdown() happened after the read thread blocked at
> gnutls_record_recv().  In this case, we should allow the premature
> termination to happen.
> 
> The problem is by the time qcrypto_tls_session_read() was invoked,
> tioc->shutdown may not have been set, so this may instead be treated as an
> error if there is concurrent shutdown() calls.
> 
> To allow the flag to reflect the latest status of tioc->shutdown, move the
> check upper into the QIOChannel level, so as to read the flag only after
> QEMU gets an GNUTLS_E_PREMATURE_TERMINATION.
> 
> When at it, introduce qio_channel_tls_allow_premature_termination() helper
> to make the condition checks easier to read.
> 
> This patch will fix a qemu qtest warning when running the preempt tls test,
> reporting premature termination:
> 
> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
> ...
> qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> ...
> 
> In this specific case, the error was set by postcopy_preempt_thread, which
> normally will be concurrently shutdown()ed by the main thread.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/crypto/tlssession.h |  7 +------
>  crypto/tlssession.c         |  7 ++-----
>  io/channel-tls.c            | 21 +++++++++++++++++++--
>  3 files changed, 22 insertions(+), 13 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
> index 2f62ce2d67..6b4fcadee7 100644
> --- a/include/crypto/tlssession.h
> +++ b/include/crypto/tlssession.h
> @@ -110,6 +110,7 @@
>  typedef struct QCryptoTLSSession QCryptoTLSSession;
>  
>  #define QCRYPTO_TLS_SESSION_ERR_BLOCK -2
> +#define QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION -3
>  
>  /**
>   * qcrypto_tls_session_new:
> @@ -259,7 +260,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
>   * @sess: the TLS session object
>   * @buf: to fill with plain text received
>   * @len: the length of @buf
> - * @gracefulTermination: treat premature termination as graceful EOF
>   * @errp: pointer to hold returned error object
>   *
>   * Receive up to @len bytes of data from the remote peer
> @@ -267,10 +267,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
>   * qcrypto_tls_session_set_callbacks(), decrypt it and
>   * store it in @buf.
>   *
> - * If @gracefulTermination is true, then a premature termination
> - * of the TLS session will be treated as indicating EOF, as
> - * opposed to an error.
> - *


Could you say something about QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION
being a possible return code here (no need to repost just for that). 

>   * It is an error to call this before
>   * qcrypto_tls_session_handshake() returns
>   * QCRYPTO_TLS_HANDSHAKE_COMPLETE
> @@ -282,7 +278,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
>  ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
>                                   char *buf,
>                                   size_t len,
> -                                 bool gracefulTermination,
>                                   Error **errp);
>  
>  /**

> +static bool
> +qio_channel_tls_allow_premature_termination(QIOChannelTLS *tioc, int flags)
> +{
> +    if (flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF) {
> +        return true;
> +    }
> +
> +    if (qatomic_read(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ) {
> +        return true;
> +    }
> +
> +    return false;
> +}
>  
>  static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>                                       const struct iovec *iov,
> @@ -364,8 +377,6 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>              tioc->session,
>              iov[i].iov_base,
>              iov[i].iov_len,
> -            flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF ||
> -            qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
>              errp);


The original code uses qatomic_load_acquire() while the new code
uses qatomic_read() which imposes weaker ordering constraints.

Does this matter ? I'm not familiar enough with atomics to say
which we need here ?

>          if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
>              if (got) {
> @@ -373,6 +384,12 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>              } else {
>                  return QIO_CHANNEL_ERR_BLOCK;
>              }
> +        } else if (ret == QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION) {
> +            if (qio_channel_tls_allow_premature_termination(tioc, flags)) {
> +                ret = 0;
> +            } else {
> +                return -1;
> +            }
>          } else if (ret < 0) {
>              return -1;
>          }
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


