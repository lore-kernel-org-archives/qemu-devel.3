Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC55FC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpFg-0003HH-1h; Tue, 30 Jul 2024 11:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7GHu=O6=kaod.org=clg@ozlabs.org>)
 id 1sYpFX-0002k2-2m; Tue, 30 Jul 2024 11:58:59 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7GHu=O6=kaod.org=clg@ozlabs.org>)
 id 1sYpFT-0007ck-EW; Tue, 30 Jul 2024 11:58:54 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WYKdw6L45z4x8C;
 Wed, 31 Jul 2024 01:58:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WYKdt42Q7z4x89;
 Wed, 31 Jul 2024 01:58:42 +1000 (AEST)
Message-ID: <fdc53976-2000-46cd-a65a-c9976fc8c9d1@kaod.org>
Date: Tue, 30 Jul 2024 17:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] crypto: add support for accumulative hashing
To: Alejandro Zeise <alejandro.zeise@seagate.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
 <20240729190035.3419649-2-alejandro.zeise@seagate.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240729190035.3419649-2-alejandro.zeise@seagate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7GHu=O6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/29/24 21:00, Alejandro Zeise wrote:
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
>   crypto/hash-gcrypt.c  | 105 ++++++++++++++++++++++++++++++++++++++++++
>   crypto/hash-glib.c    |  89 +++++++++++++++++++++++++++++++++++
>   crypto/hash-gnutls.c  |  82 +++++++++++++++++++++++++++++++++
>   crypto/hash-nettle.c  |  93 +++++++++++++++++++++++++++++++++++++
>   crypto/hash.c         |  42 +++++++++++++++++
>   crypto/hashpriv.h     |  11 +++++
>   include/crypto/hash.h |  65 ++++++++++++++++++++++++++
>   7 files changed, 487 insertions(+)
> 
> diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
> index 829e48258d..6ef7e67711 100644
> --- a/crypto/hash-gcrypt.c
> +++ b/crypto/hash-gcrypt.c
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU Crypto hash algorithms
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (c) 2016 Red Hat, Inc.
>    *
>    * This library is free software; you can redistribute it and/or
> @@ -110,7 +111,111 @@ qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
>       return -1;
>   }
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
>   QCryptoHashDriver qcrypto_hash_lib_driver = {
>       .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
> +    .hash_accumulate_bytesv = qcrypto_gcrypt_hash_accumulate_bytesv,
> +    .accumulate_new_ctx = qcrypto_gcrypt_hash_accumulate_new_ctx,
> +    .accumulate_free_ctx = qcrypto_gcrypt_hash_accumulate_free_ctx,
>   };
> diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
> index 82de9db705..c0d1d72c88 100644
> --- a/crypto/hash-glib.c
> +++ b/crypto/hash-glib.c
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU Crypto hash algorithms
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (c) 2016 Red Hat, Inc.
>    *
>    * This library is free software; you can redistribute it and/or
> @@ -95,6 +96,94 @@ qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
>   }
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
>   QCryptoHashDriver qcrypto_hash_lib_driver = {
>       .hash_bytesv = qcrypto_glib_hash_bytesv,
> +    .hash_accumulate_bytesv = qcrypto_glib_hash_accumulate_bytesv,
> +    .accumulate_new_ctx = qcrypto_glib_hash_accumulate_new_ctx,
> +    .accumulate_free_ctx = qcrypto_glib_hash_accumulate_free_ctx,
>   };
> diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
> index 17911ac5d1..9464893213 100644
> --- a/crypto/hash-gnutls.c
> +++ b/crypto/hash-gnutls.c
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU Crypto hash algorithms
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (c) 2021 Red Hat, Inc.
>    *
>    * This library is free software; you can redistribute it and/or
> @@ -99,6 +100,87 @@ qcrypto_gnutls_hash_bytesv(QCryptoHashAlgorithm alg,
>   }
>   
>   
> +static
> +int qcrypto_gnutls_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
> +                                           qcrypto_hash_accumulate_ctx_t **hash_ctx,
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
> +    ret = gnutls_hash_init((gnutls_hash_hd_t *) hash_ctx, qcrypto_hash_alg_map[alg]);
> +    if (ret < 0) {
> +        error_setg(errp,
> +                   "Unable to initialize hash algorithm: %s",
> +                   gnutls_strerror(ret));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static
> +int qcrypto_gnutls_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
> +                                            Error **errp)
> +{
> +    if (hash_ctx != NULL) {
> +        gnutls_hash_deinit((gnutls_hash_hd_t) hash_ctx, NULL);
> +    }
> +
> +    return 0;
> +}
> +
> +static
> +int qcrypto_gnutls_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
> +                                          qcrypto_hash_accumulate_ctx_t *hash_ctx,
> +                                          const struct iovec *iov,
> +                                          size_t niov,
> +                                          uint8_t **result,
> +                                          size_t *resultlen,
> +                                          Error **errp)
> +{
> +    int i, ret;
> +
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +        return -1;
> +    }
> +
> +    ret = gnutls_hash_get_len(qcrypto_hash_alg_map[alg]);
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
> +    for (i = 0; i < niov; i++) {
> +        gnutls_hash((gnutls_hash_hd_t) hash_ctx,
> +                    iov[i].iov_base, iov[i].iov_len);
> +    }
> +
> +    /* Make a copy so we don't distort the main context */
> +    gnutls_hash_hd_t copy = gnutls_hash_copy((gnutls_hash_hd_t) hash_ctx);
> +    gnutls_hash_deinit(copy, *result);
> +
> +    return 0;
> +}
> +
> +
>   QCryptoHashDriver qcrypto_hash_lib_driver = {
>       .hash_bytesv = qcrypto_gnutls_hash_bytesv,
> +    .hash_accumulate_bytesv = qcrypto_gnutls_hash_accumulate_bytesv,
> +    .accumulate_new_ctx = qcrypto_gnutls_hash_accumulate_new_ctx,
> +    .accumulate_free_ctx = qcrypto_gnutls_hash_accumulate_free_ctx,
>   };
> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> index 1ca1a41062..e21d0c6cf9 100644
> --- a/crypto/hash-nettle.c
> +++ b/crypto/hash-nettle.c
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU Crypto hash algorithms
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (c) 2016 Red Hat, Inc.
>    *
>    * This library is free software; you can redistribute it and/or
> @@ -155,7 +156,99 @@ qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
>       return 0;
>   }
>   
> +static
> +int qcrypto_nettle_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
> +                                           qcrypto_hash_accumulate_ctx_t **hash_ctx,
> +                                           Error **errp)
> +{
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +        return -1;
> +    }
> +
> +    *((union qcrypto_hash_ctx **) hash_ctx) = g_malloc(sizeof(union qcrypto_hash_ctx));
> +
> +    qcrypto_hash_alg_map[alg].init(*((union qcrypto_hash_ctx **) accumulate_ctx));
> +
> +    return 0;
> +}
> +
> +static
> +int qcrypto_nettle_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
> +                                            Error **errp)
> +{
> +    g_free((union qcrypto_hash_ctx *) hash_ctx);
> +    return 0;
> +}
> +
> +static
> +int qcrypto_nettle_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
> +                                          qcrypto_hash_accumulate_ctx_t *hash_ctx,
> +                                          const struct iovec *iov,
> +                                          size_t niov,
> +                                          uint8_t **result,
> +                                          size_t *resultlen,
> +                                          Error **errp)
> +{
> +    union qcrypto_hash_ctx *ctx_copy;
> +    int i;
> +
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +        return -1;
> +    }
> +
> +    for (i = 0; i < niov; i++) {
> +        /* Some versions of nettle have functions
> +         * declared with 'int' instead of 'size_t'
> +         * so to be safe avoid writing more than
> +         * UINT_MAX bytes at a time
> +         */
> +        size_t len = iov[i].iov_len;
> +        uint8_t *base = iov[i].iov_base;
> +        while (len) {
> +            size_t shortlen = MIN(len, UINT_MAX);
> +            qcrypto_hash_alg_map[alg].write((union qcrypto_hash_ctx *) hash_ctx,
> +                                            len, base);
> +            len -= shortlen;
> +            base += len;
> +        }
> +    }
> +
> +    if (*resultlen == 0) {
> +        *resultlen = qcrypto_hash_alg_map[alg].len;
> +        *result = g_new0(uint8_t, *resultlen);
> +    } else if (*resultlen != qcrypto_hash_alg_map[alg].len) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is smaller than hash %zu",
> +                   *resultlen, qcrypto_hash_alg_map[alg].len);
> +        return -1;
> +    }
> +
> +    /*
> +    Make a copy so we don't distort the main context
> +    by calculating the intermediate hash
> +    */
> +    ctx_copy = g_new(union qcrypto_hash_ctx, 1);
> +    memcpy(ctx_copy, (union qcrypto_hash_ctx *) hash_ctx,
> +           sizeof(union qcrypto_hash_ctx));
> +
> +    qcrypto_hash_alg_map[alg].result(ctx_copy,
> +                                     *resultlen, *result);
> +
> +    g_free(ctx_copy);
> +
> +    return 0;
> +}
> +
>   
>   QCryptoHashDriver qcrypto_hash_lib_driver = {
>       .hash_bytesv = qcrypto_nettle_hash_bytesv,
> +    .hash_accumulate_bytesv = qcrypto_nettle_hash_accumulate_bytesv,
> +    .accumulate_new_ctx = qcrypto_nettle_hash_accumulate_new_ctx,
> +    .accumulate_free_ctx = qcrypto_nettle_hash_accumulate_free_ctx,
>   };
> diff --git a/crypto/hash.c b/crypto/hash.c
> index b0f8228bdc..0d45ce1e1b 100644
> --- a/crypto/hash.c
> +++ b/crypto/hash.c
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU Crypto hash algorithms
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (c) 2015 Red Hat, Inc.
>    *
>    * This library is free software; you can redistribute it and/or
> @@ -77,6 +78,47 @@ int qcrypto_hash_bytes(QCryptoHashAlgorithm alg,
>       return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
>   }
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
> +    return qcrypto_hash_lib_driver.hash_accumulate_bytesv(alg, accumulate_ctx,
> +                                                          iov, niov, result,
> +                                                          resultlen, NULL);
> +#endif /* CONFIG_AF_ALG */
> +}
> +
> +int qcrypto_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
> +                                    qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
> +                                    Error **errp)
> +{
> +#ifdef CONFIG_AF_ALG
> +    qemu_log_mask(LOG_UNIMP, "%s: AF_ALG support unimplemented.\n", __func__);
> +    return 1;
> +#else
> +    return qcrypto_hash_lib_driver.accumulate_new_ctx(alg, accumulate_ctx, errp);
> +#endif /* CONFIG_AF_ALG */
> +}
> +
> +int qcrypto_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
> +                                     Error **errp)
> +{
> +#ifdef CONFIG_AF_ALG
> +    qemu_log_mask(LOG_UNIMP, "%s: AF_ALG support unimplemented.\n", __func__);
> +    return 1;
> +#else
> +    return qcrypto_hash_lib_driver.accumulate_free_ctx(accumulate_ctx, errp);
> +#endif /* CONFIG_AF_ALG */
> +}
> +
>   static const char hex[] = "0123456789abcdef";
>   
>   int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
> diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
> index cee26ccb47..49b3927208 100644
> --- a/crypto/hashpriv.h
> +++ b/crypto/hashpriv.h
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU Crypto hash driver supports
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
>    *
>    * Authors:
> @@ -24,6 +25,16 @@ struct QCryptoHashDriver {
>                          uint8_t **result,
>                          size_t *resultlen,
>                          Error **errp);
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
>   };
>   
>   extern QCryptoHashDriver qcrypto_hash_lib_driver;
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 54d87aa2a1..fb8ae2d099 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU Crypto hash algorithms
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (c) 2015 Red Hat, Inc.
>    *
>    * This library is free software; you can redistribute it and/or
> @@ -25,6 +26,8 @@
>   
>   /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
>   
> +typedef void qcrypto_hash_accumulate_ctx_t;


QCryptoHmac defines a similar API. I would do the same for the hash
accumulative mode. See hmac files.

Thanks,

C.

  

  
> +
>   /**
>    * qcrypto_hash_supports:
>    * @alg: the hash algorithm
> @@ -120,6 +123,68 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
>                            char **digest,
>                            Error **errp);
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
> +
>   /**
>    * qcrypto_hash_digest:
>    * @alg: the hash algorithm


