Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23C7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpnl-0001Zm-I2; Tue, 30 Jul 2024 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYpnj-0001TN-SD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYpni-0005Qt-0I
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722357253;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+f3k17eQadsbAgEbGJb1Y9DtYp+3wVinJe3pKCPgLo=;
 b=VU0GzUBi1KkzmF2ayarAeal2JubsHXptzgQv/gtI4SP/lvZmEOIQuC3fa6PaQeK/FuKmKZ
 ZoC13E2GTtXvy/qk+Ajg+WwHkNudJSgGPmMkNuzbxDeYhZefJWL9UpYI+03Pr/4kBT7ABF
 eRqheYc/dra1/R86qp+1C31ETafRXsE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-pJIY0PuKNsST1RVY7QzdJQ-1; Tue,
 30 Jul 2024 12:34:07 -0400
X-MC-Unique: pJIY0PuKNsST1RVY7QzdJQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3098D195609E; Tue, 30 Jul 2024 16:34:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D6A41955F40; Tue, 30 Jul 2024 16:34:03 +0000 (UTC)
Date: Tue, 30 Jul 2024 17:34:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Alejandro Zeise <alejandro.zeise@seagate.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH v2 1/2] crypto: add support for accumulative hashing
Message-ID: <ZqkV-OQizSWac5yo@redhat.com>
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
 <20240729190035.3419649-2-alejandro.zeise@seagate.com>
 <fdc53976-2000-46cd-a65a-c9976fc8c9d1@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdc53976-2000-46cd-a65a-c9976fc8c9d1@kaod.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 30, 2024 at 05:58:38PM +0200, Cédric Le Goater wrote:
> On 7/29/24 21:00, Alejandro Zeise wrote:
> > This change adds an accumulative hashing function
> > (qcrypto_hash_accumulate_bytesv) and implementation
> > for each of the crypto library backends that QEMU supports.
> > 
> > The QCrypto API did not support hashing in an accumulative mode.
> > As such, hardware hash modules (like the HACE from Aspeed's SoCs) are
> > unable to perform such operations correctly when the guest requires it.
> > 
> > The creation and freeing of each library's context is abstracted by
> > the qcrypto_hash_accumulate_new_ctx and qcrypto_hash_accumulate_free_ctx
> > functions.
> > 
> > Changes in V2:
> > * Fixed error checking bug in libgcrypt backend
> > 
> > Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> > ---
> >   crypto/hash-gcrypt.c  | 105 ++++++++++++++++++++++++++++++++++++++++++
> >   crypto/hash-glib.c    |  89 +++++++++++++++++++++++++++++++++++
> >   crypto/hash-gnutls.c  |  82 +++++++++++++++++++++++++++++++++
> >   crypto/hash-nettle.c  |  93 +++++++++++++++++++++++++++++++++++++
> >   crypto/hash.c         |  42 +++++++++++++++++
> >   crypto/hashpriv.h     |  11 +++++
> >   include/crypto/hash.h |  65 ++++++++++++++++++++++++++
> >   7 files changed, 487 insertions(+)

> > diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> > index 54d87aa2a1..fb8ae2d099 100644
> > --- a/include/crypto/hash.h
> > +++ b/include/crypto/hash.h
> > @@ -1,6 +1,7 @@
> >   /*
> >    * QEMU Crypto hash algorithms
> >    *
> > + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
> >    * Copyright (c) 2015 Red Hat, Inc.
> >    *
> >    * This library is free software; you can redistribute it and/or
> > @@ -25,6 +26,8 @@
> >   /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
> > +typedef void qcrypto_hash_accumulate_ctx_t;
> 
> 
> QCryptoHmac defines a similar API. I would do the same for the hash
> accumulative mode. See hmac files.

Yes, ideally the hmac APIs would match the hash APIs.

That said, the changes I've just requested are already a
large amount of work, so I'm not going to demand that
the hmac.c code is also changed.

Alejandro: if have you time to update hmac.c that would
be awesome, but consider it optional.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


