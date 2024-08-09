Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22374C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scL89-00051M-HQ; Fri, 09 Aug 2024 04:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scL86-00050D-ED
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scL83-0001Zo-IV
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723192662;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VKd3eR8jDeRz/IODE/Js+qkGQBKX4cfBn9uHikOevn0=;
 b=J6jmAdPKUmUWpk17Ad8G9OmQmUHmuZs4iJlqTDMm5+J4VoBn11F6Ck46sB8AP8RzNQjFUF
 HLvQzu1jl/e+bvpqTdklADGgACJ2+6t2nSagyj21KbNiSVA+a9kVrH06NuZrKqx+BwO7Js
 wFZ36TC5hDM+cD19cEnUQ6ZUZYnpGDw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-YUDCWqs5OIeM-INmBRvKtw-1; Fri,
 09 Aug 2024 04:37:37 -0400
X-MC-Unique: YUDCWqs5OIeM-INmBRvKtw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6AED195608D; Fri,  9 Aug 2024 08:37:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0421119560A7; Fri,  9 Aug 2024 08:37:31 +0000 (UTC)
Date: Fri, 9 Aug 2024 09:37:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Kris Conklin <kris.conklin@seagate.com>,
 Jonathan Henze <jonathan.henze@seagate.com>,
 Evan Burgess <evan.burgess@seagate.com>, "clg@kaod.org" <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 03/15] crypto/hash-gcrypt: Implement new hash API
Message-ID: <ZrXVR95hnQwg5zGh@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-4-alejandro.zeise@seagate.com>
 <ZrT62R_5HaQQxDqP@redhat.com>
 <LV8PR20MB6853CD119297E25B2218EC9FEFB92@LV8PR20MB6853.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV8PR20MB6853CD119297E25B2218EC9FEFB92@LV8PR20MB6853.namprd20.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 06:24:10PM +0000, Alejandro Zeise wrote:
> > On Wed, Aug 07, 2024 at 07:51:10PM +0000, Alejandro Zeise wrote:
> > > Implements the new hashing API in the gcrypt hash driver.
> > > Supports creating/destroying a context, updating the context with 
> > > input data and obtaining an output hash.
> > >
> > > Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> > > ---
> > >  crypto/hash-gcrypt.c | 79 
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 79 insertions(+)
> > >
> > > diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c index 
> > > 829e48258d..e05511cafa 100644
> > > --- a/crypto/hash-gcrypt.c
> > > +++ b/crypto/hash-gcrypt.c
> > > @@ -1,6 +1,7 @@
> > >  /*
> > >   * QEMU Crypto hash algorithms
> > >   *
> > > + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
> > >   * Copyright (c) 2016 Red Hat, Inc.
> > >   *
> > >   * This library is free software; you can redistribute it and/or @@ 
> > > -110,7 +111,85 @@ qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
> > >      return -1;
> > >  }
> > >
> > > +static
> > > +QCryptoHash *qcrypto_gcrypt_hash_new(QCryptoHashAlgorithm alg, Error 
> > > +**errp) {
> > > +    QCryptoHash *hash = NULL;
> > > +
> > > +    if (!qcrypto_hash_supports(alg)) {
> > > +        error_setg(errp,
> > > +                   "Unknown hash algorithm %d",
> > > +                   alg);
> > > +    } else {
> > > +        hash = g_new(QCryptoHash, 1);
> > > +        hash->alg = alg;
> > > +        hash->opaque = g_new(gcry_md_hd_t, 1);
> > > +
> > > +        gcry_md_open((gcry_md_hd_t *) hash->opaque, qcrypto_hash_alg_map[alg], 0);
> > > +    }
> > > +
> > > +    return hash;
> > > +}
> > > +
> > > +static
> > > +void qcrypto_gcrypt_hash_free(QCryptoHash *hash) {
> > > +    gcry_md_hd_t *ctx = hash->opaque;
> > > +
> > > +    if (ctx) {
> > > +        gcry_md_close(*ctx);
> > > +        g_free(ctx);
> > > +    }
> > > +
> > > +    g_free(hash);
> > > +}
> > > +
> > > +
> > > +static
> > > +int qcrypto_gcrypt_hash_update(QCryptoHash *hash,
> > > +                               const struct iovec *iov,
> > > +                               size_t niov,
> > > +                               Error **errp) {
> > > +    gcry_md_hd_t *ctx = hash->opaque;
> > > +
> > > +    for (int i = 0; i < niov; i++) {
> > > +        gcry_md_write(*ctx, iov[i].iov_base, iov[i].iov_len);
> >
> >   int ret = gcry_md_write(*ctx, iov[i].iov_base, iov[i].iov_len);
> >   if (ret != 0) {
> >       error_setg(....)
> >       return -1;
> >   }
> >
> >
> > With regards,
> > Daniel
> 
> gcry_md_write() is declared as void which is why I had no error variable present.

Opps, yes, I'm getting confused with the other APIs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


