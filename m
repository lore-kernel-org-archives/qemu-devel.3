Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27271CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9P8K-0008Hv-Ek; Thu, 16 Oct 2025 10:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9P8I-0008Gx-2a
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9P8B-0005Pp-2K
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760625539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXIc7uYw5yjylmv2o7e4hnvZIn6ZMrFZ11fOEvUtlj8=;
 b=B4yIRlGwkXV4e5xFxhcF01S2oXkAmzcXqIAH5RtqF577/9sQ9QM9wzMPSlgQl1a2rcTgyv
 4YWGzJLHX9pWq6zHByXyW0X+URve2evvYff/brMqjv0xeTeKK9LxUh1MT6fjSc7/bIcNYs
 SlAlHXTXGzs3qy03rMLjZFR+3teYn5I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-dvnOVLYAN7yh1-gvz0iTMQ-1; Thu,
 16 Oct 2025 10:38:56 -0400
X-MC-Unique: dvnOVLYAN7yh1-gvz0iTMQ-1
X-Mimecast-MFC-AGG-ID: dvnOVLYAN7yh1-gvz0iTMQ_1760625535
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37F2F1801312; Thu, 16 Oct 2025 14:38:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DE4719560AD; Thu, 16 Oct 2025 14:38:54 +0000 (UTC)
Date: Thu, 16 Oct 2025 15:38:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Henry Kleynhans <hkleynhans@fb.com>
Subject: Re: [PATCH v2 1/6] crypto: only verify CA certs in chain of trust
Message-ID: <aPEDeg5p3-7q5KRM@redhat.com>
References: <20250919101022.1491007-1-berrange@redhat.com>
 <20250919101022.1491007-2-berrange@redhat.com>
 <yzqgr2jqxrpt3xxw7gzuwsgwo6q6xehcadiuelkqsvzcfoisr3@isqvazofm6m5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yzqgr2jqxrpt3xxw7gzuwsgwo6q6xehcadiuelkqsvzcfoisr3@isqvazofm6m5>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 09:37:51AM -0500, Eric Blake wrote:
> On Fri, Sep 19, 2025 at 11:10:17AM +0100, Daniel P. Berrangé wrote:
> > From: Henry Kleynhans <hkleynhans@fb.com>
> > 
> > The CA file provided to qemu may contain CA certificates which do not
> > form part of the chain of trust for the specific certificate we are
> > sanity checking.
> > 
> > This patch changes the sanity checking from validating every CA
> > certificate to only checking the CA certificates which are part of the
> > chain of trust (issuer chain).  Other certificates are ignored.
> 
> I agree that relaxing this will permit more certs than before (and
> possibly with less CPU cycles spent on the irrelevant portions of the
> cert), without weakening the security of the chain we are actually
> interested in.
> 
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Henry Kleynhans <hkleynhans@fb.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  crypto/tlscredsx509.c                 | 57 ++++++++++++++++++++++++---
> >  tests/unit/test-crypto-tlscredsx509.c | 25 +++++++++++-
> >  2 files changed, 75 insertions(+), 7 deletions(-)
> > 
> > diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> > index cd1f504471..797854ac89 100644
> > --- a/crypto/tlscredsx509.c
> > +++ b/crypto/tlscredsx509.c
> > @@ -315,6 +315,51 @@ qcrypto_tls_creds_check_cert(QCryptoTLSCredsX509 *creds,
> >      return 0;
> >  }
> >  
> > +static int
> > +qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
> > +                                        gnutls_x509_crt_t cert,
> > +                                        gnutls_x509_crt_t *cacerts,
> > +                                        unsigned int ncacerts,
> > +                                        const char *cacertFile,
> > +                                        bool isServer,
> > +                                        bool isCA,
> > +                                        Error **errp)
> > +{
> > +    gnutls_x509_crt_t *cert_to_check = &cert;
> > +    int checking_issuer = 1;
> 
> Why is this int instead of bool?  It's only assigned 1 or 0, and local
> to the function.

No good reason.

> 
> That's a trivial cleanup, so I'm okay if you make that change and add:

I'll change to bool.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


