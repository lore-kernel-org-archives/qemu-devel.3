Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CB7CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnIY-0005Vy-9z; Fri, 31 Oct 2025 07:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEnIR-0005US-14
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEnI1-0001PN-9i
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761910037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4L7lG7MOoqNduW6iirv7mIZh/hXVcTgK8iZWKB338Qk=;
 b=Zv2pDyqlMfWHqtFFk+Vrz2xxN0PbhlmeTpsvIJPmBipkiaADrMEqULi5NUtpbpePmNrEMc
 WqNyu9Zs6XNtQ+CBiR1yUY3eYdp9p2isZLg93XGAlb/0Ht5AV5YiG5LBCfT/RcyPiFxKdd
 NfON1qaO5KoGa7xUPd76SNclyRP7a+I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-SGLWdyOrNJ2qMdWboLSUNA-1; Fri,
 31 Oct 2025 07:27:16 -0400
X-MC-Unique: SGLWdyOrNJ2qMdWboLSUNA-1
X-Mimecast-MFC-AGG-ID: SGLWdyOrNJ2qMdWboLSUNA_1761910035
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AAE81956076; Fri, 31 Oct 2025 11:27:15 +0000 (UTC)
Received: from redhat.com (dhcp-17-192.lcy.redhat.com [10.42.17.192])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EAFA1800451; Fri, 31 Oct 2025 11:27:13 +0000 (UTC)
Date: Fri, 31 Oct 2025 11:27:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 13/21] crypto: introduce a wrapper around gnutls
 credentials
Message-ID: <aQSdDrcd0HmNsPvy@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-14-berrange@redhat.com>
 <CAMxuvazU6nyXUsmSATMNHz8jevDT2=7A+x=fZ7-K7fr+aVOkDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazU6nyXUsmSATMNHz8jevDT2=7A+x=fZ7-K7fr+aVOkDQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Oct 31, 2025 at 03:23:51PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Oct 30, 2025 at 6:49 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > The gnutls_credentials_set() method has a very suprising API contract
> > that requires the caller to preserve the passed in credentials pointer
> > for as long as the gnutls_session_t object is alive. QEMU is failing
> > to ensure this happens.
> >
> > In QEMU the GNUTLS credentials object is owned by the QCryptoTLSCreds
> > object instance while the GNUTLS session object is owned by the
> > QCryptoTLSSession object instance. Their lifetimes are not guaranteed
> > to be the same, though in most common usage the credentials will outlive
> > the session. This is notably not the case, however, after the VNC server
> > gained the ability to reload credentials on the fly with:
> >
> >   commit 1f08e3415120637cad7f540d9ceb4dba3136dbdd
> >   Author: Zihao Chang <changzihao1@huawei.com>
> >   Date:   Tue Mar 16 15:58:44 2021 +0800
> >
> >     vnc: support reload x509 certificates for vnc
> >
> > If that is triggered while a VNC client is in the middle of performing
> > a TLS handshake, we might hit a use-after-free.
> >
> > It is difficult to correct this problem because there's no way to deep-
> > clone a GNUTLS credentials object, nor is it reference counted. Thus we
> > introduce a QCryptoTLSCredsBox object whose only purpose is to add
> > reference counting around the GNUTLS credentials object.
> >
> > The DH parameters set against a credentials object also have to be kept
> > alive for as long as the credentials exist. So the box must also hold
> > the DH parameters pointer.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>


> > +#ifndef QCRYPTO_TLSCREDS_BOX_H
> > +#define QCRYPTO_TLSCREDS_BOX_H
> > +
> > +#include "qom/object.h"
> > +
> > +#ifdef CONFIG_GNUTLS
> > +#include <gnutls/gnutls.h>
> > +#endif
> > +
> > +typedef struct QCryptoTLSCredsBox QCryptoTLSCredsBox;
> > +
> > +struct QCryptoTLSCredsBox {
> > +    uint32_t ref;
> > +    bool server;
> > +    int type;
> > +    union {
> > +        void *any;
> >
> 
> since any is used in code to cast the variant to a void *, it may be worth
> a comment to say that all fields are expected to be pointers.

Yep, in practice almost all gnutls _t types are pointers, but
I'll explain that here since it is not obvious to casual
observers.

> 
> 
> > +#ifdef CONFIG_GNUTLS
> > +        gnutls_anon_server_credentials_t anonserver;
> > +        gnutls_anon_client_credentials_t anonclient;
> > +        gnutls_psk_server_credentials_t pskserver;
> > +        gnutls_psk_client_credentials_t pskclient;
> > +        gnutls_certificate_credentials_t cert;
> > +#endif
> > +    } data;
> > +#ifdef CONFIG_GNUTLS
> > +    gnutls_dh_params_t dh_params;
> > +#endif
> > +};
> > +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


