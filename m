Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBC6CF11D0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 11:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrZx-0002cd-7m; Thu, 10 Oct 2024 07:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrZu-0002cQ-1o
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrZr-0008PP-9s
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728560609;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUkp91qm3yX5jzcL5NzNG/U3FqwOZJnW+Jskg1GDnJw=;
 b=bcBQC1/wPXDqmEfvETb7sCBbROibI2us4mXp5BZYTPKZvXHAdf7/HN4EormjmMgWImhgTL
 3Fon+VQnKtrO/WlEk6HkBk7ws7xcD1GxhPENu+5vFlLz6kbk8ODcmn1ucxBzMGPk+Dja8x
 mt/1W8nBtc8izD3cPV4K52q1jB9i0iM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-c57UYM-JMiSKzrV3qQlAiw-1; Thu,
 10 Oct 2024 07:43:28 -0400
X-MC-Unique: c57UYM-JMiSKzrV3qQlAiw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19E31956064; Thu, 10 Oct 2024 11:43:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE3D319560A3; Thu, 10 Oct 2024 11:43:23 +0000 (UTC)
Date: Thu, 10 Oct 2024 12:43:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com,
 peter.maydell@linaro.org, Alejandro Zeise <alejandro.zeise@seagate.com>
Subject: Re: [PATCH v5 05/16] crypto/hash-nettle: Implement new hash API
Message-ID: <Zwe91xD7yeSoiCB4@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
 <20241008075724.2772149-6-clg@redhat.com>
 <ZwexMpP8SidNul6G@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwexMpP8SidNul6G@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 10, 2024 at 11:49:22AM +0100, Daniel P. Berrangé wrote:
> On Tue, Oct 08, 2024 at 09:57:12AM +0200, Cédric Le Goater wrote:
> > From: Alejandro Zeise <alejandro.zeise@seagate.com>
> > 
> > Implements the new hashing API in the nettle hash driver.
> > Supports creating/destroying a context, updating the context
> > with input data and obtaining an output hash.
> > 
> > Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> > [ clg: - Dropped qcrypto_hash_supports() in qcrypto_nettle_hash_new() ]
> > Signed-off-by: Cédric Le Goater <clg@redhat.com>
> > ---
> >  crypto/hash-nettle.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> > 
> > diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> > index 8b08a9c67531..07e18ce26cba 100644
> > --- a/crypto/hash-nettle.c
> > +++ b/crypto/hash-nettle.c
> 
> > +static
> > +int qcrypto_nettle_hash_update(QCryptoHash *hash,
> > +                               const struct iovec *iov,
> > +                               size_t niov,
> > +                               Error **errp)
> > +{
> > +    union qcrypto_hash_ctx *ctx = hash->opaque;
> > +
> > +    for (int i = 0; i < niov; i++) {
> > +        /*
> > +         * Some versions of nettle have functions
> > +         * declared with 'int' instead of 'size_t'
> > +         * so to be safe avoid writing more than
> > +         * UINT_MAX bytes at a time
> > +         */
> 
> This is copying the pre-existing code, and I've just
> realized this is now obsolete. We bumped min nettle
> to 3.4 ages ago and >= 3.0 is using size_t, so we can
> simplify now.
> 
> No need to change this though. I'll do that as a 
> distinct patch to make it a visible change.
> 
> > +        size_t len = iov[i].iov_len;
> > +        uint8_t *base = iov[i].iov_base;
> > +        while (len) {
> > +            size_t shortlen = MIN(len, UINT_MAX);
> > +            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
> > +            len -= shortlen;
> > +            base += len;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}

I'm going to add the following patch on the end of your series:

commit 638ae66c176f8077ccaac10028812e177224a99f
Author: Daniel P. Berrangé <berrange@redhat.com>
Date:   Thu Oct 10 12:40:49 2024 +0100

    crypto: drop obsolete back compat logic for old nettle
    
    The nettle 2.x series declared all the hash functions with 'int' for
    the data size. Since we dropped support for anything older than 3.4
    we can assume nettle is using 'size_t' and thus avoid the back compat
    looping logic.
    
    Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 570ce8a645..3b847aa60e 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -135,20 +135,9 @@ int qcrypto_nettle_hash_update(QCryptoHash *hash,
     union qcrypto_hash_ctx *ctx = hash->opaque;
 
     for (int i = 0; i < niov; i++) {
-        /*
-         * Some versions of nettle have functions
-         * declared with 'int' instead of 'size_t'
-         * so to be safe avoid writing more than
-         * UINT_MAX bytes at a time
-         */
-        size_t len = iov[i].iov_len;
-        uint8_t *base = iov[i].iov_base;
-        while (len) {
-            size_t shortlen = MIN(len, UINT_MAX);
-            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
-            len -= shortlen;
-            base += len;
-        }
+        qcrypto_hash_alg_map[hash->alg].write(ctx,
+                                              iov[i].iov_len,
+                                              iov[i].iov_base);
     }
 
     return 0;



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


