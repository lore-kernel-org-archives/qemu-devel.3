Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C4C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 16:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc5u4-0005ZA-6i; Thu, 08 Aug 2024 12:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc5u3-0005Ye-HX
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc5tz-0005Gd-6h
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723134129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7ZNi2oTApSCJG/gNtlnFTLs8ETuTCgIq/g7wjQBDvLo=;
 b=VLNBxPJUhQ+GMSVpCRh+jhwspgTPodxFfRHsWGrtIihTLq8eDx7H7Oy9bZeMmFLIecwx57
 F5xUDbLX3FrjdgjMroYsXsGt6FyWBi1OttOgEwPUAsNhBFJQJlX+Y0r09XZWCFBcdzRpGb
 O+mWdRnAfy2kHOhw85sON5UJJutx+Zs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-tC2tNrEfOnarrCjnxKuwSw-1; Thu,
 08 Aug 2024 12:22:06 -0400
X-MC-Unique: tC2tNrEfOnarrCjnxKuwSw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6936C1944B2A; Thu,  8 Aug 2024 16:22:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C74A1959166; Thu,  8 Aug 2024 16:22:02 +0000 (UTC)
Date: Thu, 8 Aug 2024 17:21:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/15] crypto/hash: Implement and use new hash API
Message-ID: <ZrTwphQDG20aGtsP@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-8-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807195122.2827364-8-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Wed, Aug 07, 2024 at 07:51:14PM +0000, Alejandro Zeise wrote:
> Changes the public hash API implementation to support accumulative hashing.
> 
> Implementations for the public functions are added to call the new
> driver functions that implement context creation, updating,
> finalization, and destruction.
> 
> Additionally changes the "shortcut" functions to use these 4 new core
> functions.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  crypto/hash.c | 163 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 128 insertions(+), 35 deletions(-)
> 
> diff --git a/crypto/hash.c b/crypto/hash.c
> index b0f8228bdc..f3c18cdd74 100644
> --- a/crypto/hash.c
> +++ b/crypto/hash.c
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto hash algorithms
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2015 Red Hat, Inc.
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -45,23 +46,20 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
>                          size_t *resultlen,
>                          Error **errp)
>  {
> -#ifdef CONFIG_AF_ALG
> -    int ret;
> -    /*
> -     * TODO:
> -     * Maybe we should treat some afalg errors as fatal
> -     */
> -    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
> -                                                result, resultlen,
> -                                                NULL);
> -    if (ret == 0) {
> -        return ret;
> +    int fail;
> +    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
> +
> +    if (ctx) {
> +        fail = qcrypto_hash_updatev(ctx, iov, niov, errp) ||
> +               qcrypto_hash_finalize_bytes(ctx, result, resultlen, errp);
> +
> +        /* Ensure context is always freed regardless of error */
> +        qcrypto_hash_free(ctx);
> +    } else {
> +        fail = -1;
>      }
> -#endif

Generally I'd prefer immediate return on error, and you can
use g_autoptr to free the object too. With that you'll end
up without the extra 'fail' variable:

    g_autoptr(QCryptoHash) ctx = qcrypto_hash_new(alg, errp);

    if (!ctx) {
        return -1;
    }

    if (qcrypto_hash_updatev(ctx, iov, niov, errp) < 0 ||
        qcrypto_hash_finalize_bytes(ctx, result, resultlen, errp) < 0) {
	return -1;
    }

    return 0;

> @@ -77,30 +75,121 @@ int qcrypto_hash_bytes(QCryptoHashAlgorithm alg,
>      return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
>  }
>  
> -static const char hex[] = "0123456789abcdef";
> -
> -int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
> +int qcrypto_hash_updatev(QCryptoHash *hash,
>                           const struct iovec *iov,
>                           size_t niov,
> -                         char **digest,
>                           Error **errp)
>  {
> +#ifdef CONFIG_AF_ALG
> +    return qcrypto_hash_afalg_driver.hash_update(hash, iov, niov, errp);
> +#else
> +    return qcrypto_hash_lib_driver.hash_update(hash, iov, niov, errp);
> +#endif /* CONFIG_AF_ALG */
> +}

This isn't quite the same as the old code. That would try afalg, and then
dynamically fallback to the userspace driver.

I think we need to deal with this all in the qcrypto_hash_new() method.
Attempt to create an AF_ALG driver instance via its 'hash_new' method,
and if that fails create the normal driver 'hash_new' method. We need
to record which we created in QCryptoHash struct, and then in the
update, finalize & free methods we need to call the corresponding
driver.

> +
> +int qcrypto_hash_update(QCryptoHash *hash,
> +                        const char *buf,
> +                        size_t len,
> +                        Error **errp)
> +{
> +    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
> +
> +    return qcrypto_hash_updatev(hash, &iov, 1, errp);
> +}
> +
> +QCryptoHash *qcrypto_hash_new(QCryptoHashAlgorithm alg, Error **errp)
> +{

Here we should call

   if (!qcrypto_hash_supports(alg)) {
      error_setg(errp, "Unsupported hash algorithm %s",
                 QCryptoHashAlgorithm_lookup[alg]);
      return NULL;
   }

That way, we avoid repeating this check in every single
'hash_new' method impl

> +#ifdef CONFIG_AF_ALG
> +    return qcrypto_hash_afalg_driver.hash_new(alg, errp);
> +#else
> +    return qcrypto_hash_lib_driver.hash_new(alg, errp);
> +#endif /* CONFIG_AF_ALG */
> +}
> +
> +void qcrypto_hash_free(QCryptoHash *hash)
> +{
> +#ifdef CONFIG_AF_ALG
> +    qcrypto_hash_afalg_driver.hash_free(hash);
> +#else
> +    qcrypto_hash_lib_driver.hash_free(hash);
> +#endif /* CONFIG_AF_ALG */
> +}
> +
> +int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
> +                                uint8_t **result,
> +                                size_t *result_len,
> +                                Error **errp)
> +{
> +#ifdef CONFIG_AF_ALG
> +    return qcrypto_hash_afalg_driver.hash_finalize(hash, result, result_len,
> +                                                   errp);
> +#else
> +    return qcrypto_hash_lib_driver.hash_finalize(hash, result, result_len, errp);
> +#endif /* CONFIG_AF_ALG */
> +}
> +
> +static const char hex[] = "0123456789abcdef";
> +
> +int qcrypto_hash_finalize_digest(QCryptoHash *hash,
> +                                 char **digest,
> +                                 Error **errp)
> +{
> +    int ret;
>      uint8_t *result = NULL;

declare this

  g_autofree uint8_t *result = NULL;

then you can drop the later g_free(result)

>      size_t resultlen = 0;
>      size_t i;
>  
> -    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
> -        return -1;
> +    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
> +    if (ret == 0) {
> +        *digest = g_new0(char, (resultlen * 2) + 1);
> +        for (i = 0 ; i < resultlen ; i++) {
> +            (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
> +            (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
> +        }
> +        (*digest)[resultlen * 2] = '\0';
> +        g_free(result);
> +    }
> +
> +    return ret;
> +}
> +
> +int qcrypto_hash_finalize_base64(QCryptoHash *hash,
> +                                 char **base64,
> +                                 Error **errp)
> +{
> +    int ret;
> +    uint8_t *result = NULL;

g_autofree for this too

> +    size_t resultlen = 0;
> +
> +    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
> +    if (ret == 0) {
> +        *base64 = g_base64_encode(result, resultlen);
> +        g_free(result);
>      }
>  
> -    *digest = g_new0(char, (resultlen * 2) + 1);
> -    for (i = 0 ; i < resultlen ; i++) {
> -        (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
> -        (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
> +    return ret;
> +}
> +
> +int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         char **digest,
> +                         Error **errp)
> +{
> +    bool fail;
> +    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
> +
> +    if (ctx) {
> +        fail = qcrypto_hash_updatev(ctx, iov, niov, errp) ||
> +               qcrypto_hash_finalize_digest(ctx, digest, errp);
> +
> +        /* Ensure context is always freed regardless of error */
> +        qcrypto_hash_free(ctx);
> +    } else {
> +        fail = false;
>      }
> -    (*digest)[resultlen * 2] = '\0';
> -    g_free(result);
> -    return 0;
> +
> +    return fail;
>  }

Same comment about re-arranging the code that I mentioned higher
up against qcrypto_hash_bytesv

>  
>  int qcrypto_hash_digest(QCryptoHashAlgorithm alg,
> @@ -120,16 +209,20 @@ int qcrypto_hash_base64v(QCryptoHashAlgorithm alg,
>                           char **base64,
>                           Error **errp)
>  {
> -    uint8_t *result = NULL;
> -    size_t resultlen = 0;
> +    bool fail;
> +    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
> +
> +    if (ctx) {
> +        fail = qcrypto_hash_updatev(ctx, iov, niov, errp) ||
> +               qcrypto_hash_finalize_base64(ctx, base64, errp);
>  
> -    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
> -        return -1;
> +        /* Ensure context is always freed regardless of error */
> +        qcrypto_hash_free(ctx);
> +    } else {
> +        fail = 1;
>      }
>  
> -    *base64 = g_base64_encode(result, resultlen);
> -    g_free(result);
> -    return 0;
> +    return fail;
>  }

And same comment again.

>  
>  int qcrypto_hash_base64(QCryptoHashAlgorithm alg,
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


