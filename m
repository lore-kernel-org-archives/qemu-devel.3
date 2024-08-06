Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068A8C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbMNp-00086P-Px; Tue, 06 Aug 2024 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbMNm-00085B-O7
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbMNh-000096-Lt
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722959148;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mIO7xqBTaoyEN7ZsSFP9XMCE92/9T1bjuY1ONexFQ20=;
 b=Vrg35GiaVhwqPYu67nJn2i7j+XWIh+DqGZAeTvvY5Zw2g530RP7BoyS79QYKgq3W5l7HfC
 TjpsnVnA2Yr5IeOszRUloNTszWBttQ968EXZe0dM35b6iDKN6VMhv+zEGN26U7UppGB4hM
 ZBjEzTxUQxY6J4bcXvKBTrmmce5D0ok=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-ScSH8WPaPpKv3wNt1igfbQ-1; Tue,
 06 Aug 2024 11:45:45 -0400
X-MC-Unique: ScSH8WPaPpKv3wNt1igfbQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 678481955D5C; Tue,  6 Aug 2024 15:45:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CB821955D42; Tue,  6 Aug 2024 15:45:39 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:45:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 01/12] crypto: accumulative hashing API
Message-ID: <ZrJFH3GjBRAsQpI9@redhat.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
 <20240805155047.3151540-2-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805155047.3151540-2-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Aug 05, 2024 at 03:50:36PM +0000, Alejandro Zeise wrote:
> Changes the hash API to support accumulative hashing.
> Hash objects are created with "qcrypto_hash_new",
> updated with data with "qcrypto_hash_update", and
> the hash obtained with "qcrypto_hash_finalize".
> 
> These changes bring the hashing API more in line with the
> hmac API.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  crypto/hash.c         | 136 +++++++++++++++++++++++++++++++-----------
>  crypto/hashpriv.h     |  19 ++++--
>  include/crypto/hash.h | 106 ++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+), 41 deletions(-)
> 
> diff --git a/crypto/hash.c b/crypto/hash.c
> index b0f8228bdc..5c60973bde 100644
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
> +        fail = qcrypto_hash_update(ctx, iov, niov, errp) ||
> +               qcrypto_hash_finalize_bytes(ctx, result, resultlen, errp);
> +
> +        /* Ensure context is always freed regardless of error */
> +        fail = qcrypto_hash_free(ctx) || fail;
> +    } else {
> +        fail = -1;
>      }
> -#endif
>  
> -    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
> -                                               result, resultlen,
> -                                               errp);
> +    return fail;
>  }

You can't do this conversion in this patch, because all the hash impls
are still using the old driver API, and haven't implemented the new
API yet.

QEMU requires "make check" succeed for *every* individual patch in
a series, so that 'git bisect' can be used in future.

> diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
> index cee26ccb47..8a7d80619e 100644
> --- a/crypto/hashpriv.h
> +++ b/crypto/hashpriv.h
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto hash driver supports
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
>   *
>   * Authors:
> @@ -15,15 +16,21 @@
>  #ifndef QCRYPTO_HASHPRIV_H
>  #define QCRYPTO_HASHPRIV_H
>  
> +#include "crypto/hash.h"
> +
>  typedef struct QCryptoHashDriver QCryptoHashDriver;
>  
>  struct QCryptoHashDriver {
> -    int (*hash_bytesv)(QCryptoHashAlgorithm alg,
> -                       const struct iovec *iov,
> -                       size_t niov,
> -                       uint8_t **result,
> -                       size_t *resultlen,
> -                       Error **errp);

Keep this present. It can only be removed at the very end of the
series once all the drivers are converted.

> +   QCryptoHash *(*hash_new)(QCryptoHashAlgorithm alg, Error **errp);
> +   int (*hash_update)(QCryptoHash *hash,
> +                      const struct iovec *iov,
> +                      size_t niov,
> +                      Error **errp);
> +   int (*hash_finalize)(QCryptoHash *hash,
> +                        uint8_t **result,
> +                        size_t *resultlen,
> +                        Error **errp);
> +   int (*hash_free)(QCryptoHash *hash);

I'd expect 'free' functions to always be 'void'

> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 54d87aa2a1..96d080eeb5 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto hash algorithms
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2015 Red Hat, Inc.
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -25,6 +26,13 @@
>  
>  /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
>  
> +typedef struct QCryptoHash QCryptoHash;
> +struct QCryptoHash {
> +    QCryptoHashAlgorithm alg;
> +    void *opaque;
> +    void *driver;
> +};
> +
>  /**
>   * qcrypto_hash_supports:
>   * @alg: the hash algorithm
> @@ -120,6 +128,102 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
>                           char **digest,
>                           Error **errp);
>  
> +/**
> + * qcrypto_hash_update:
> + * @hash: hash object from qcrypto_hash_new
> + * @iov: the array of memory regions to hash
> + * @niov: the length of @iov
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Updates the given hash object with all the memory regions
> + * present in @iov.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_update(QCryptoHash *hash,
> +                        const struct iovec *iov,
> +                        size_t niov,
> +                        Error **errp);

This should be renamed 'qcrypto_hash_updatev', and we should have a
separate non-iovec variant

 int qcrypto_hash_update(QCryptoHash *hash,
                         const char *data,
                         size_t len,
                         Error **errp);

This can simply pack data+len into an iovec, and then call
qcrypto_hash_updatev.


> +
> +/**
> + * qcrypto_hash_finalize_digest:
> + * @hash: the hash object to finalize
> + * @digest: pointer to hold output hash
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hash from the given hash object. Hash object
> + * is expected to have its data updated from the qcrypto_hash_update function.
> + * The @digest pointer will be filled with the printable hex digest of the
> + * computed hash, which will be terminated by '\0'. The memory pointer
> + * in @digest must be released with a call to g_free() when
> + * no longer required.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_finalize_digest(QCryptoHash *hash,
> +                                 char **digest,
> +                                 Error **errp);
> +
> +/**
> + * qcrypto_hash_finalize_base64:
> + * @hash_ctx: hash object to finalize

s/hash_ctx/hash/

> + * @base64: pointer to store the hash result in
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hash from the given hash object. Hash object
> + * is expected to have it's data updated from the qcrypto_hash_update function.
> + * The @base64 pointer will be filled with the base64 encoding of the computed
> + * hash, which will be terminated by '\0'. The memory pointer in @base64
> + * must be released with a call to g_free() when no longer required.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_finalize_base64(QCryptoHash *hash,
> +                                 char **base64,
> +                                 Error **errp);
> +
> +/**
> + * qcrypto_hash_finalize_bytes:
> + * @hash_ctx: hash object to finalize
> + * @result: pointer to store the hash result in
> + * @result_len: Pointer to store the length of the result in
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hash from the given hash object. Hash object
> + * is expected to have it's data updated from the qcrypto_hash_update function.
> + * The memory pointer in @result must be released with a call to g_free()
> + * when no longer required.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
> +                                uint8_t **result,
> +                                size_t *result_len,
> +                                Error **errp);
> +
> +/**
> + * qcrypto_hash_new:
> + * @alg: the hash algorithm
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Creates a new hashing context for the chosen algorithm for
> + * usage with qcrypto_hash_update.
> + *
> + * Returns: New hash object with the given algorithm

....  ", or NULL on error"

> + */
> +QCryptoHash *qcrypto_hash_new(QCryptoHashAlgorithm alg,
> +                              Error **errp);
> +
> +/**
> + * qcrypto_hash_free:
> + * @hash: hash object to free
> + *
> + * Frees a hashing context for the chosen algorithm.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_free(QCryptoHash *hash);

Again I'd expect this to be 'void' and have a g_autoptr support
added using:

  G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHash, qcrypto_hash_free)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


