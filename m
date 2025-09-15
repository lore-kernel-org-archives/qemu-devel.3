Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33460CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyE0G-0006In-EK; Mon, 15 Sep 2025 14:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyE0F-0006F2-3Q
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyE05-0002K6-Hv
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757961141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7sdjI5UJAzCMl9q8Cylr+GT8o3v+QIHTInZaiv3F5A=;
 b=i3toDosXyHVKZYP1GxVMbevkPdA3T8jqN1QqUGau5Eft4e+onK+xhdlEpgA68iBBVeGlK8
 phRHjYGjeJcgBYyQFg/k6FC+ZXfoRF20E+JAwAL9wuiYghUJ+q6UmY5sqyMMRAV32MUA0L
 daZ/MIOeh0W5OVGMB6FBB4AkcAptnZk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-Gt8SA-XCNfGKoI_0Lto0MA-1; Mon,
 15 Sep 2025 14:31:54 -0400
X-MC-Unique: Gt8SA-XCNfGKoI_0Lto0MA-1
X-Mimecast-MFC-AGG-ID: Gt8SA-XCNfGKoI_0Lto0MA_1757961109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 716061800451; Mon, 15 Sep 2025 18:31:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B41F11954126; Mon, 15 Sep 2025 18:31:43 +0000 (UTC)
Date: Mon, 15 Sep 2025 19:31:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/3] io/crypto: Move tls premature termination
 handling into QIO layer
Message-ID: <aMhbiyrIvFQseuCq@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-2-peterx@redhat.com>
 <aMQBehejwDPEO5C1@redhat.com> <aMQ7MgPj_TQKvdXN@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQ7MgPj_TQKvdXN@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 11:24:34AM -0400, Peter Xu wrote:
> On Fri, Sep 12, 2025 at 12:18:18PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Sep 11, 2025 at 05:23:53PM -0400, Peter Xu wrote:
> > > QCryptoTLSSession allows TLS premature termination in two cases, one of the
> > > case is when the channel shutdown() is invoked on READ side.
> > > 
> > > It's possible the shutdown() happened after the read thread blocked at
> > > gnutls_record_recv().  In this case, we should allow the premature
> > > termination to happen.
> > > 
> > > The problem is by the time qcrypto_tls_session_read() was invoked,
> > > tioc->shutdown may not have been set, so this may instead be treated as an
> > > error if there is concurrent shutdown() calls.
> > > 
> > > To allow the flag to reflect the latest status of tioc->shutdown, move the
> > > check upper into the QIOChannel level, so as to read the flag only after
> > > QEMU gets an GNUTLS_E_PREMATURE_TERMINATION.
> > > 
> > > When at it, introduce qio_channel_tls_allow_premature_termination() helper
> > > to make the condition checks easier to read.
> > > 
> > > This patch will fix a qemu qtest warning when running the preempt tls test,
> > > reporting premature termination:
> > > 
> > > QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
> > > ...
> > > qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> > > ...
> > > 
> > > In this specific case, the error was set by postcopy_preempt_thread, which
> > > normally will be concurrently shutdown()ed by the main thread.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/crypto/tlssession.h |  7 +------
> > >  crypto/tlssession.c         |  7 ++-----
> > >  io/channel-tls.c            | 21 +++++++++++++++++++--
> > >  3 files changed, 22 insertions(+), 13 deletions(-)
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > > diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
> > > index 2f62ce2d67..6b4fcadee7 100644
> > > --- a/include/crypto/tlssession.h
> > > +++ b/include/crypto/tlssession.h
> > > @@ -110,6 +110,7 @@
> > >  typedef struct QCryptoTLSSession QCryptoTLSSession;
> > >  
> > >  #define QCRYPTO_TLS_SESSION_ERR_BLOCK -2
> > > +#define QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION -3
> > >  
> > >  /**
> > >   * qcrypto_tls_session_new:
> > > @@ -259,7 +260,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
> > >   * @sess: the TLS session object
> > >   * @buf: to fill with plain text received
> > >   * @len: the length of @buf
> > > - * @gracefulTermination: treat premature termination as graceful EOF
> > >   * @errp: pointer to hold returned error object
> > >   *
> > >   * Receive up to @len bytes of data from the remote peer
> > > @@ -267,10 +267,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
> > >   * qcrypto_tls_session_set_callbacks(), decrypt it and
> > >   * store it in @buf.
> > >   *
> > > - * If @gracefulTermination is true, then a premature termination
> > > - * of the TLS session will be treated as indicating EOF, as
> > > - * opposed to an error.
> > > - *
> > 
> > 
> > Could you say something about QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION
> > being a possible return code here (no need to repost just for that). 
> 
> Definitely, I overlooked the doc there..
> 
> I'll squash this when repost:
> 
> diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
> index 6b4fcadee7..2e9fe11cf6 100644
> --- a/include/crypto/tlssession.h
> +++ b/include/crypto/tlssession.h
> @@ -273,7 +273,8 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
>   *
>   * Returns: the number of bytes received,
>   * or QCRYPTO_TLS_SESSION_ERR_BLOCK if the receive would block,
> - * or -1 on error.
> + * or QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION if a premature termination
> + * is detected, or -1 on error.
>   */
>  ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
>                                   char *buf,

ACK,


> 
> > 
> > >   * It is an error to call this before
> > >   * qcrypto_tls_session_handshake() returns
> > >   * QCRYPTO_TLS_HANDSHAKE_COMPLETE
> > > @@ -282,7 +278,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
> > >  ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
> > >                                   char *buf,
> > >                                   size_t len,
> > > -                                 bool gracefulTermination,
> > >                                   Error **errp);
> > >  
> > >  /**
> > 
> > > +static bool
> > > +qio_channel_tls_allow_premature_termination(QIOChannelTLS *tioc, int flags)
> > > +{
> > > +    if (flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF) {
> > > +        return true;
> > > +    }
> > > +
> > > +    if (qatomic_read(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ) {
> > > +        return true;
> > > +    }
> > > +
> > > +    return false;
> > > +}
> > >  
> > >  static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
> > >                                       const struct iovec *iov,
> > > @@ -364,8 +377,6 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
> > >              tioc->session,
> > >              iov[i].iov_base,
> > >              iov[i].iov_len,
> > > -            flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF ||
> > > -            qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
> > >              errp);
> > 
> > 
> > The original code uses qatomic_load_acquire() while the new code
> > uses qatomic_read() which imposes weaker ordering constraints.
> > 
> > Does this matter ? I'm not familiar enough with atomics to say
> > which we need here ?
> 
> My bad, I explicitly changed it but I forgot to mention it in the commit
> message.
> 
> I don't think we need memory barriers here, because memory barriers are
> only used to describe ordering of at least more than one memory operation.
> Here we sololy want to read the flag which implies whether a shutdown READ
> was initiated, so IMHO qatomic_read() is the thing we want.  Comparing to
> raw access to tioc->shutdown, it's almost "volatile" making sure we fetch
> from memory, so when another thread modifies it on the fly we'll see.
> 
> I'll explain it in the commit message when repost.

Thanks, that all sounds good.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


