Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E26BC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 16:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6Tu-0001Sz-VD; Thu, 08 Aug 2024 12:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6Tb-0001P0-BZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6TZ-00036A-Ke
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723136336;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=86BwQotMW+4xsWckG+Z8aKQsw9F9jcj5IED0Q+iVpMk=;
 b=Jl1YRBvnHXig2jE08SMj2Kgz8cmIEjgYYAihFobkOSj1wPLLFk++vliEYB0/PBtxlcGXFd
 d2DbrzSTYGb0+tisxQNH7kf/J/vjVfYjoblt7jWUuDnZ1Cp7DhcchEumga0lJ5ZZEJtqvI
 pYwo8iIXFoLN5cqfCdWKWUBBKuN5sJI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-a9meFE-MOiyqyDkJ22e25A-1; Thu,
 08 Aug 2024 12:58:51 -0400
X-MC-Unique: a9meFE-MOiyqyDkJ22e25A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F3D219775FE; Thu,  8 Aug 2024 16:58:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28EDD1955E99; Thu,  8 Aug 2024 16:58:44 +0000 (UTC)
Date: Thu, 8 Aug 2024 17:58:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 02/15] crypto/hash-glib: Implement new hash API
Message-ID: <ZrT5QTOWFxv5gD1Z@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-3-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807195122.2827364-3-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 07, 2024 at 07:51:09PM +0000, Alejandro Zeise wrote:
> Implements the new hashing API in the GLib hash driver.
> Supports creating/destroying a context, updating the context
> with input data and obtaining an output hash.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  crypto/hash-glib.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
> index 82de9db705..9f4490762a 100644
> --- a/crypto/hash-glib.c
> +++ b/crypto/hash-glib.c
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto hash algorithms
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2016 Red Hat, Inc.
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -95,6 +96,81 @@ qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
>  }
>  
>  
> +static
> +QCryptoHash *qcrypto_glib_hash_new(QCryptoHashAlgorithm alg,
> +                                   Error **errp)
> +{
> +    QCryptoHash *hash = NULL;
> +
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);

This check should be removed from all the drivers, since we
can do it once in qcrypto_hash_new.

> +    } else {
> +        hash = g_new(QCryptoHash, 1);
> +        hash->alg = alg;
> +        hash->opaque = g_checksum_new(qcrypto_hash_alg_map[alg]);
> +    }
> +
> +    return hash;
> +}
> +
> +static
> +void qcrypto_glib_hash_free(QCryptoHash *hash)
> +{
> +    if (hash->opaque) {
> +        g_checksum_free((GChecksum *) hash->opaque);

The cast to "(GChecksum *)" is not required since 'opaque' is 'void *'
which auto-casts to anything in C, and we don't need to support C++
compilers.

> +    }
> +
> +    g_free(hash);
> +}
> +
> +
> +static
> +int qcrypto_glib_hash_update(QCryptoHash *hash,
> +                             const struct iovec *iov,
> +                             size_t niov,
> +                             Error **errp)
> +{
> +    GChecksum *ctx = hash->opaque;
> +
> +    for (int i = 0; i < niov; i++) {
> +        g_checksum_update(ctx, iov[i].iov_base, iov[i].iov_len);
> +    }
> +
> +    return 0;
> +}
> +
> +static
> +int qcrypto_glib_hash_finalize(QCryptoHash *hash,
> +                               uint8_t **result,
> +                               size_t *result_len,
> +                               Error **errp)
> +{
> +    int ret;
> +    GChecksum *ctx = hash->opaque;
> +
> +    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[hash->alg]);
> +    if (ret < 0) {
> +        error_setg(errp, "%s",
> +                   "Unable to get hash length");
> +        *result_len = 0;
> +        ret = -1;

Just do an immediate 'return -1' here, and avoid the
'} else {' clause.

> +    } else {
> +        *result_len = ret;
> +        *result = g_new(uint8_t, *result_len);
> +
> +        g_checksum_get_digest(ctx, *result, result_len);
> +        ret = 0;
> +    }
> +
> +    return ret;
> +}
> +
>  QCryptoHashDriver qcrypto_hash_lib_driver = {
>      .hash_bytesv = qcrypto_glib_hash_bytesv,
> +    .hash_new      = qcrypto_glib_hash_new,
> +    .hash_update   = qcrypto_glib_hash_update,
> +    .hash_finalize = qcrypto_glib_hash_finalize,
> +    .hash_free     = qcrypto_glib_hash_free,
>  };
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


