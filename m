Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75982C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpgJ-0004Sw-Uz; Tue, 30 Jul 2024 12:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYpgH-0004Go-Sk
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYpgE-0004Lg-Bm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722356788;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wJjYVzvrtTYnNZwYb7O7HeA6MaQiVN2uJOKozifbdmA=;
 b=jVEmjakQ4RslExPjbYQaEkM5J5Pi4aX/MTzfNIzg5yBhel5X/qHT1l1B01UYN814jzWrSQ
 yRxMZeMkcjz/WnFUqCc0RpXJ/acg5VcSIv8OjN3mZS48tQgZFpLhmInCI75Gu21uDewK/0
 P+HR5wd5w8pr6/q8q4d8a32p1puarQc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-BTWNgCaLPpy8sigfEiWgwQ-1; Tue,
 30 Jul 2024 12:26:24 -0400
X-MC-Unique: BTWNgCaLPpy8sigfEiWgwQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C4121955D55; Tue, 30 Jul 2024 16:26:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EC4919560AE; Tue, 30 Jul 2024 16:26:20 +0000 (UTC)
Date: Tue, 30 Jul 2024 17:26:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 1/2] crypto: add support for accumulative hashing
Message-ID: <ZqkUKLtbCvfnrDWX@redhat.com>
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
 <20240729190035.3419649-2-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729190035.3419649-2-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 29, 2024 at 07:00:34PM +0000, Alejandro Zeise wrote:
> This change adds an accumulative hashing function
> (qcrypto_hash_accumulate_bytesv) and implementation
> for each of the crypto library backends that QEMU supports.
> 
> The QCrypto API did not support hashing in an accumulative mode.
> As such, hardware hash modules (like the HACE from Aspeed's SoCs) are
> unable to perform such operations correctly when the guest requires it.
> 
> The creation and freeing of each library's context is abstracted by
> the qcrypto_hash_accumulate_new_ctx and qcrypto_hash_accumulate_free_ctx
> functions.
> 
> Changes in V2:
> * Fixed error checking bug in libgcrypt backend
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  crypto/hash-gcrypt.c  | 105 ++++++++++++++++++++++++++++++++++++++++++
>  crypto/hash-glib.c    |  89 +++++++++++++++++++++++++++++++++++
>  crypto/hash-gnutls.c  |  82 +++++++++++++++++++++++++++++++++
>  crypto/hash-nettle.c  |  93 +++++++++++++++++++++++++++++++++++++
>  crypto/hash.c         |  42 +++++++++++++++++
>  crypto/hashpriv.h     |  11 +++++
>  include/crypto/hash.h |  65 ++++++++++++++++++++++++++
>  7 files changed, 487 insertions(+)
> 
> diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
> index 829e48258d..6ef7e67711 100644
> --- a/crypto/hash-gcrypt.c
> +++ b/crypto/hash-gcrypt.c
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto hash algorithms
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2016 Red Hat, Inc.
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -110,7 +111,111 @@ qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
>      return -1;
>  }
>  
> +static
> +int qcrypto_gcrypt_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
> +                                           qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
> +                                           Error **errp)
> +{
> +    int ret;
> +
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +        return -1;
> +    }
> +
> +    ret = gcry_md_open((gcry_md_hd_t *) accumulate_ctx, qcrypto_hash_alg_map[alg], 0);
> +
> +    if (ret < 0) {
> +        error_setg(errp,
> +                   "Unable to initialize hash algorithm: %s",
> +                   gcry_strerror(ret));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static
> +int qcrypto_gcrypt_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
> +                                            Error **errp)
> +{
> +    if (hash_ctx != NULL) {
> +        gcry_md_close((gcry_md_hd_t) hash_ctx);
> +    }
> +
> +    return 0;
> +}
> +
> +static
> +int qcrypto_gcrypt_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
> +                                          qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
> +                                          const struct iovec *iov,
> +                                          size_t niov,
> +                                          uint8_t **result,
> +                                          size_t *resultlen,
> +                                          Error **errp)
> +{
> +    int i, ret;
> +    gcry_md_hd_t ctx_copy;
> +    unsigned char *digest;
> +
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +        return -1;
> +    }
> +
> +    for (i = 0; i < niov; i++) {
> +        gcry_md_write((gcry_md_hd_t) accumulate_ctx, iov[i].iov_base, iov[i].iov_len);
> +    }
> +
> +    ret = gcry_md_get_algo_dlen(qcrypto_hash_alg_map[alg]);
> +    if (ret <= 0) {
> +        error_setg(errp,
> +                   "Unable to get hash length: %s",
> +                   gcry_strerror(ret));
> +        return -1;
> +    }
> +
> +    if (*resultlen == 0) {
> +        *resultlen = ret;
> +        *result = g_new0(uint8_t, *resultlen);
> +    } else if (*resultlen != ret) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is smaller than hash %d",
> +                   *resultlen, ret);
> +        return -1;
> +    }
> +
> +    /*
> +     * Make a copy so we don't distort the main context
> +     * by calculating the intermediate hash
> +     */
> +    ret = gcry_md_copy(&ctx_copy, (gcry_md_hd_t) accumulate_ctx);
> +    if (ret) {
> +        error_setg(errp, "Unable to make copy: %s", gcry_strerror(ret));
> +        return -1;
> +    }
> +
> +    digest = gcry_md_read(ctx_copy, 0);
> +    if (!digest) {
> +        error_setg(errp,
> +                   "No digest produced");
> +        return -1;
> +    }
> +    memcpy(*result, digest, *resultlen);
> +    gcry_md_close(ctx_copy);
> +
> +    return 0;
> +}
> +
>  
>  QCryptoHashDriver qcrypto_hash_lib_driver = {
>      .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
> +    .hash_accumulate_bytesv = qcrypto_gcrypt_hash_accumulate_bytesv,
> +    .accumulate_new_ctx = qcrypto_gcrypt_hash_accumulate_new_ctx,
> +    .accumulate_free_ctx = qcrypto_gcrypt_hash_accumulate_free_ctx,
>  };
> diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
> index 82de9db705..c0d1d72c88 100644
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
> @@ -95,6 +96,94 @@ qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
>  }
>  
>  
> +static
> +int qcrypto_glib_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
> +                                         qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
> +                                         Error **errp)
> +{
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +        return -1;
> +    }
> +
> +    *accumulate_ctx = g_checksum_new(qcrypto_hash_alg_map[alg]);
> +
> +    return 0;
> +}
> +
> +static
> +int qcrypto_glib_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
> +                                          Error **errp)
> +{
> +    if (hash_ctx != NULL) {
> +        g_checksum_free((GChecksum *) hash_ctx);
> +    }
> +
> +    return 0;
> +}
> +
> +
> +static
> +int qcrypto_glib_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
> +                                        qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
> +                                        const struct iovec *iov,
> +                                        size_t niov,
> +                                        uint8_t **result,
> +                                        size_t *resultlen,
> +                                        Error **errp)
> +{
> +    int i, ret;
> +    GChecksum *ctx_copy;
> +
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +        return -1;
> +    }
> +
> +    for (i = 0; i < niov; i++) {
> +        g_checksum_update((GChecksum *) accumulate_ctx, iov[i].iov_base, iov[i].iov_len);
> +    }
> +
> +    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[alg]);
> +    if (ret < 0) {
> +        error_setg(errp, "%s",
> +                   "Unable to get hash length");
> +        return -1;
> +    }
> +    if (*resultlen == 0) {
> +        *resultlen = ret;
> +        *result = g_new0(uint8_t, *resultlen);
> +    } else if (*resultlen != ret) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is smaller than hash %d",
> +                   *resultlen, ret);
> +        return -1;
> +    }
> +
> +    /*
> +    Make a copy so we don't distort the main context
> +    by calculating the intermediate hash.
> +    */
> +    ctx_copy = g_checksum_copy((GChecksum *) accumulate_ctx);
> +    if (ctx_copy == NULL) {
> +        error_setg(errp, "Unable to make copy: %s", __func__);
> +        return -1;
> +    }
> +
> +    g_checksum_get_digest((GChecksum *) ctx_copy, *result, resultlen);
> +    g_checksum_free(ctx_copy);
> +
> +    return 0;
> +}
> +
> +
>  QCryptoHashDriver qcrypto_hash_lib_driver = {
>      .hash_bytesv = qcrypto_glib_hash_bytesv,
> +    .hash_accumulate_bytesv = qcrypto_glib_hash_accumulate_bytesv,

These two methods are 99% copy+pate of each other which is
highly undesirable. To address this we should get rid of
the 'hash_bytesv' callback entirely. The existing single shot
methods can be implemented entirely in terms of the new methods
you are adding.

> +    .accumulate_new_ctx = qcrypto_glib_hash_accumulate_new_ctx,
> +    .accumulate_free_ctx = qcrypto_glib_hash_accumulate_free_ctx,
>  };

> diff --git a/crypto/hash.c b/crypto/hash.c
> index b0f8228bdc..0d45ce1e1b 100644
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
> @@ -77,6 +78,47 @@ int qcrypto_hash_bytes(QCryptoHashAlgorithm alg,
>      return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
>  }
>  
> +int qcrypto_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
> +                                   qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
> +                                   const struct iovec *iov,
> +                                   size_t niov,
> +                                   uint8_t **result,
> +                                   size_t *resultlen,
> +                                   Error **errp)
> +{
> +#ifdef CONFIG_AF_ALG
> +    qemu_log_mask(LOG_UNIMP, "%s: AF_ALG support unimplemented.\n", __func__);
> +    return 1;
> +#else

This isn't ok - we need to have this new API design supported by the afalg
implementation.



> diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
> index cee26ccb47..49b3927208 100644
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
> @@ -24,6 +25,16 @@ struct QCryptoHashDriver {
>                         uint8_t **result,
>                         size_t *resultlen,
>                         Error **errp);
> +    int (*hash_accumulate_bytesv)(QCryptoHashAlgorithm alg,
> +                                  void *hash_ctx,
> +                                  const struct iovec *iov,
> +                                  size_t niov,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp);
> +    int (*accumulate_new_ctx)(QCryptoHashAlgorithm alg, void **hash_ctx,
> +                              Error **errp);
> +    int (*accumulate_free_ctx)(void *hash_ctx, Error **errp);
>  };

We should split updating from finalizing, and use QCryptoHash
as the type name for the context object. ie we need 4 callbacks
in total:

   QCryptoHash *(*hash_new)(QCryptoHashAlgorithm alg, Error **errp);
   int (*hash_update)(QCryptoHashAlgorithm alg,
                      const struct iovec *iov,
                      size_t niov,
                      Error **errp);
   int (*hash_finalize)(QCryptoHashAlgorithm alg,
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp);
   (*hash_free)(QCryptoHash *hash);

> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 54d87aa2a1..fb8ae2d099 100644
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
> @@ -25,6 +26,8 @@
>  
>  /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
>  
> +typedef void qcrypto_hash_accumulate_ctx_t;
> +

Style convention for types is initial caps, rather snake case.
Also this can be massively shortened. So we get just

  typedef struct QCryptoHash QCryptoHash;

>  /**
>   * qcrypto_hash_supports:
>   * @alg: the hash algorithm
> @@ -120,6 +123,68 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
>                           char **digest,
>                           Error **errp);
>  
> +/**
> + * qcrypto_hash_accumulate_bytesv:
> + * @alg: the hash algorithm
> + * @accumulate_ctx: pointer to the algorithm's context for further hash operations
> + * @iov: the array of memory regions to hash
> + * @niov: the length of @iov
> + * @result: pointer to hold output hash
> + * @resultlen: pointer to hold length of @result
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Computes the hash across all the memory regions
> + * present in @iov using the existing hash context
> + * given in @accumulate_ctx. The @result pointer will be
> + * filled with raw bytes representing the computed
> + * hash, which will have length @resultlen. The
> + * memory pointer in @result must be released
> + * with a call to g_free() when no longer required.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
> +                                   qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
> +                                   const struct iovec *iov,
> +                                   size_t niov,
> +                                   uint8_t **result,
> +                                   size_t *resultlen,
> +                                   Error **errp);

Again, separate updating from finalizing, but in the public
API we'll need the three finalizing variants. 

Passing in 'alg' every time is also redundant when we have a context.

So this should result in the following

  int qcrypto_hash_update(QCryptoHash *hash,
                          const struct iovec *iov,
                          size_t niov,
                          Error **errp);
  int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
                                  uint8_t **result,
                                  size_t *resultlen,
                                  Error **errp);
  int qcrypto_hash_finalize_digest(QCryptoHash *hash,
                                   char **result,
                                   Error **errp);
  int qcrypto_hash_finalize_base64(QCryptoHash *hash,
                                   char **result,
                                   Error **errp);



> +
> +/**
> + * qcrypto_hash_accumulate_new_ctx:
> + * @alg: the hash algorithm
> + * @accumulate_ctx: pointer to the pointer holding the algorithm's
> + *                  context for further hash operations. The pointer will
> + *                  be modified to point to the memory this function
> + *                  allocates to hold the context.
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Creates a new hashing context for the chosen algorithm for
> + * usage with qcrypto_hash_accumulate_bytesv().
> + * This is useful for when one has multiple inputs to compute a hash, but
> + * not all are available at a single point in time, making qcrypto_hash_bytesv()
> + * inadequate. The @accumulate_ctx pointer must be released with a call to
> + * qcrypto_hash_accumulate_free_ctx() once all hash operations are complete.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
> +                                    qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
> +                                    Error **errp);

Needs to be

  QCryptoHash *qcrypto_hash_new(QCryptoHashAlgorithm alg,
                                Error **errp);

> +
> +/**
> + * qcrypto_hash_accumulate_free_ctx:
> + * @accumulate_ctx: pointer to the algorithm's context for further hash operations
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * frees a hashing context for the chosen algorithm.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int qcrypto_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
> +                                     Error **errp);

Needs to be

  QCryptoHash *qcrypto_hash_free(QCryptoHash *hash)

We shouldn't have an Error **errp for the destructor, as we need to be
able to create an cleanup func for it:

  G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHash, qcrypto_hash_free)


Basically this ends up with the hash code looking very like the
cipher.c code in terms of both public API and the internal driver
design.

Finally, overall I'd like this patch to be split into multiple patches,
since the changes are going to be quite large

 * Define the new public API in hash.h & hash.c
 * Provide the new impl for each backend (one patch per driver please)
 * Add test cases to test-crypto-hash.c for the new APIs
 * Re-implement the existing public APIs in terms of the new
   public APIs
 * Drop the old impl for each backend (one patch per driver please)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


