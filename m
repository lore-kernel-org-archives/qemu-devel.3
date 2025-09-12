Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE96CAC58F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5e2-0008US-WE; Fri, 12 Sep 2025 11:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5dw-0008TZ-CZ
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5dt-0004eU-M0
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757690690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BI7NQZDsHpptl+69ZLHqHqt7XzpXOCRk9KoYawQIovc=;
 b=i7vQqgHYc3Ft/mKXAuf9wDrmJtSZ/vO0ebNm55qIkEjAgOIZX+6V64CJD4uOJyOoThhapY
 SxQjaOjNVcFUI1K27eTlB+rYuhQxZKNhy88fkMfDUZ4SzRR6EAgL15iMPEtDsyCOsO844F
 d1/7/D8Sp83WE2DiKTHicKAiBZPRRZU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-0yByNRUEOfe7LzpwUivznA-1; Fri, 12 Sep 2025 11:24:48 -0400
X-MC-Unique: 0yByNRUEOfe7LzpwUivznA-1
X-Mimecast-MFC-AGG-ID: 0yByNRUEOfe7LzpwUivznA_1757690688
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b633847b94so52638301cf.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 08:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757690688; x=1758295488;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BI7NQZDsHpptl+69ZLHqHqt7XzpXOCRk9KoYawQIovc=;
 b=sMiDwVV7irBSgj97bakaoganhXBBfgPVcNIxmmx106wEOyN16M9VMIvA/MbZ9A929p
 XyIaFXWUn1pWsUPAx6K98TSp80dfNaIhuUm95JmupUMFrEEep5uZhTPYsL93KIxaBEzN
 ZUoYoTl9ZgR22nSMAKJSzjfmcM8+0X5ZOwIWZHZNiiiOjoCexlk5eQqb4sf2VdtCDvTm
 2Wc7yyybro4K9+x4E0si3XPu1rGzeZ7p2CKiOOzZWLGbHOvbUdiELNwt+bKlg85sMxgK
 hRQG90uYIf3Wiz7j7OgXbp0T1KTeTcIQ0/adufFj9zOcl7udomV8rOMYYe9Jgjuxbh3P
 SvMw==
X-Gm-Message-State: AOJu0Yy02wrkypSuSB1kyo8qvxcFoG8fRn/SJVqwS/775m+D9+yeiOnr
 AbYsJZ1FezuaxnrH2QxV+TsfX4CZL+vvQGF4vWzXNHJIIjMmvzEbxtJFiq9ZVfFjK8z9bEzXY4U
 vE0w6XX1BIoUD5534tc+9uibRLeYaK3NcBOdKAprRS7Y4zoIMbdR0rZ1o
X-Gm-Gg: ASbGnctgZz9FyZafl5260k2dOHIK7lPA2StpM2CTuSDInwsF+OtrXAUdx55uptYyPhs
 PS3oYv/tRLs393diDPvzarPhSjCinGQLmBovZjEu5pgQfG0YPzrfRsbHpeSsD74v63N+v2JJsWQ
 Q6CIkkTowQqvc4tVoXS2AfnSbrjfSFHJTXy1YkadHlN5+0JF0OzMKgABVt2v5FoQuO8At0eTG7L
 RrX9c85AeT8SOYNygRRnmKDD3sbGyyHzoyE6ix3SYGaguMmXgyJuQM+mSsdrMwX2FbQValnVCsJ
 xvAkEZnwYlwLgHPd3rOOw/zKx4seiEjw
X-Received: by 2002:a05:622a:1813:b0:4b5:f7d4:3a0a with SMTP id
 d75a77b69052e-4b77d044460mr41054061cf.52.1757690687830; 
 Fri, 12 Sep 2025 08:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhLCY4YW7DIQL7hGU8c2PMrOHU8COf165kwKKckd9u/PjZFdnbOKqXYrxCPb/MMKrokCKvZg==
X-Received: by 2002:a05:622a:1813:b0:4b5:f7d4:3a0a with SMTP id
 d75a77b69052e-4b77d044460mr41053521cf.52.1757690687120; 
 Fri, 12 Sep 2025 08:24:47 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639b98927sm25623581cf.1.2025.09.12.08.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:24:46 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:24:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/3] io/crypto: Move tls premature termination
 handling into QIO layer
Message-ID: <aMQ7MgPj_TQKvdXN@x1.local>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-2-peterx@redhat.com>
 <aMQBehejwDPEO5C1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQBehejwDPEO5C1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 12, 2025 at 12:18:18PM +0100, Daniel P. Berrangé wrote:
> On Thu, Sep 11, 2025 at 05:23:53PM -0400, Peter Xu wrote:
> > QCryptoTLSSession allows TLS premature termination in two cases, one of the
> > case is when the channel shutdown() is invoked on READ side.
> > 
> > It's possible the shutdown() happened after the read thread blocked at
> > gnutls_record_recv().  In this case, we should allow the premature
> > termination to happen.
> > 
> > The problem is by the time qcrypto_tls_session_read() was invoked,
> > tioc->shutdown may not have been set, so this may instead be treated as an
> > error if there is concurrent shutdown() calls.
> > 
> > To allow the flag to reflect the latest status of tioc->shutdown, move the
> > check upper into the QIOChannel level, so as to read the flag only after
> > QEMU gets an GNUTLS_E_PREMATURE_TERMINATION.
> > 
> > When at it, introduce qio_channel_tls_allow_premature_termination() helper
> > to make the condition checks easier to read.
> > 
> > This patch will fix a qemu qtest warning when running the preempt tls test,
> > reporting premature termination:
> > 
> > QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
> > ...
> > qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> > ...
> > 
> > In this specific case, the error was set by postcopy_preempt_thread, which
> > normally will be concurrently shutdown()ed by the main thread.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/crypto/tlssession.h |  7 +------
> >  crypto/tlssession.c         |  7 ++-----
> >  io/channel-tls.c            | 21 +++++++++++++++++++--
> >  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> > diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
> > index 2f62ce2d67..6b4fcadee7 100644
> > --- a/include/crypto/tlssession.h
> > +++ b/include/crypto/tlssession.h
> > @@ -110,6 +110,7 @@
> >  typedef struct QCryptoTLSSession QCryptoTLSSession;
> >  
> >  #define QCRYPTO_TLS_SESSION_ERR_BLOCK -2
> > +#define QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION -3
> >  
> >  /**
> >   * qcrypto_tls_session_new:
> > @@ -259,7 +260,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
> >   * @sess: the TLS session object
> >   * @buf: to fill with plain text received
> >   * @len: the length of @buf
> > - * @gracefulTermination: treat premature termination as graceful EOF
> >   * @errp: pointer to hold returned error object
> >   *
> >   * Receive up to @len bytes of data from the remote peer
> > @@ -267,10 +267,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
> >   * qcrypto_tls_session_set_callbacks(), decrypt it and
> >   * store it in @buf.
> >   *
> > - * If @gracefulTermination is true, then a premature termination
> > - * of the TLS session will be treated as indicating EOF, as
> > - * opposed to an error.
> > - *
> 
> 
> Could you say something about QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION
> being a possible return code here (no need to repost just for that). 

Definitely, I overlooked the doc there..

I'll squash this when repost:

diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 6b4fcadee7..2e9fe11cf6 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -273,7 +273,8 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
  *
  * Returns: the number of bytes received,
  * or QCRYPTO_TLS_SESSION_ERR_BLOCK if the receive would block,
- * or -1 on error.
+ * or QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION if a premature termination
+ * is detected, or -1 on error.
  */
 ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
                                  char *buf,

> 
> >   * It is an error to call this before
> >   * qcrypto_tls_session_handshake() returns
> >   * QCRYPTO_TLS_HANDSHAKE_COMPLETE
> > @@ -282,7 +278,6 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
> >  ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
> >                                   char *buf,
> >                                   size_t len,
> > -                                 bool gracefulTermination,
> >                                   Error **errp);
> >  
> >  /**
> 
> > +static bool
> > +qio_channel_tls_allow_premature_termination(QIOChannelTLS *tioc, int flags)
> > +{
> > +    if (flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF) {
> > +        return true;
> > +    }
> > +
> > +    if (qatomic_read(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ) {
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> >  
> >  static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
> >                                       const struct iovec *iov,
> > @@ -364,8 +377,6 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
> >              tioc->session,
> >              iov[i].iov_base,
> >              iov[i].iov_len,
> > -            flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF ||
> > -            qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
> >              errp);
> 
> 
> The original code uses qatomic_load_acquire() while the new code
> uses qatomic_read() which imposes weaker ordering constraints.
> 
> Does this matter ? I'm not familiar enough with atomics to say
> which we need here ?

My bad, I explicitly changed it but I forgot to mention it in the commit
message.

I don't think we need memory barriers here, because memory barriers are
only used to describe ordering of at least more than one memory operation.
Here we sololy want to read the flag which implies whether a shutdown READ
was initiated, so IMHO qatomic_read() is the thing we want.  Comparing to
raw access to tioc->shutdown, it's almost "volatile" making sure we fetch
from memory, so when another thread modifies it on the fly we'll see.

I'll explain it in the commit message when repost.

Thanks,

> 
> >          if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
> >              if (got) {
> > @@ -373,6 +384,12 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
> >              } else {
> >                  return QIO_CHANNEL_ERR_BLOCK;
> >              }
> > +        } else if (ret == QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION) {
> > +            if (qio_channel_tls_allow_premature_termination(tioc, flags)) {
> > +                ret = 0;
> > +            } else {
> > +                return -1;
> > +            }
> >          } else if (ret < 0) {
> >              return -1;
> >          }
> > -- 
> > 2.50.1
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

-- 
Peter Xu


