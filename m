Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE31DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6ka-0002Im-1E; Thu, 08 Aug 2024 13:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6kY-0002II-1e
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6kV-0006N3-4z
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723137385;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qATsfQvZRQpEus1b6elonCSh37yd0/FzBbxfPDhrYB4=;
 b=TmjSeaoU9pOSnsf7poQE3zOYUzU9T/o7ly9onlmdmGFjrAuQaNWL4s21vClgOq+sQoieVr
 B14odNU7Rznjy2ijUwwZwzWXIeN4oYBEo1+iZhFQRiVkIPkZrqFHuctVpAfEVQxIKCbYb1
 3FDE2q+JnT87U2++NT64eK3p3uQvu5k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-avCQWeqiMH-u-Idyc4aVhw-1; Thu,
 08 Aug 2024 13:16:23 -0400
X-MC-Unique: avCQWeqiMH-u-Idyc4aVhw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4AD61955D5D; Thu,  8 Aug 2024 17:16:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81B5B300018D; Thu,  8 Aug 2024 17:16:19 +0000 (UTC)
Date: Thu, 8 Aug 2024 18:16:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 06/15] crypto/hash-afalg: Implement new hash API
Message-ID: <ZrT9X6N51gE_IX3W@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-7-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807195122.2827364-7-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 07, 2024 at 07:51:13PM +0000, Alejandro Zeise wrote:
> Updates the afalg hash driver to support the new accumulative
> hashing changes as part of the patch series.
> 
> Implements opening/closing of contexts, updating hash data
> and finalizing the hash digest.
> 
> In order to support the update function, a flag needs to be passed
> to the kernel via the socket send call (MSG_MORE) to notify it that more
> data is to be expected to calculate the hash correctly.
> As a result, a new function was added to the iov helper utils to allow
> passing a flag to the socket send call.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  crypto/hash-afalg.c | 126 ++++++++++++++++++++++++++++++++++++++++++++
>  include/qemu/iov.h  |  26 +++++++++
>  util/iov.c          |  22 +++++---
>  3 files changed, 167 insertions(+), 7 deletions(-)
> 
> diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
> index 3ebea39292..9548c04933 100644
> --- a/crypto/hash-afalg.c
> +++ b/crypto/hash-afalg.c
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto af_alg-backend hash/hmac support
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
>   *
>   * Authors:
> @@ -113,6 +114,127 @@ qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
>      return qcrypto_afalg_hash_hmac_ctx_new(alg, key, nkey, true, errp);
>  }
>  
> +static
> +QCryptoHash *qcrypto_afalg_hash_new(QCryptoHashAlgorithm alg, Error **errp)
> +{
> +    /* Check if hash algorithm is supported */
> +    char *alg_name = qcrypto_afalg_hash_format_name(alg, false, NULL);
> +    QCryptoHash *hash = NULL;
> +
> +    if (alg_name == NULL) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +    } else {
> +        hash = g_new(QCryptoHash, 1);
> +        hash->alg = alg;
> +        hash->opaque = qcrypto_afalg_hash_ctx_new(alg, errp);

This can return NULL, in which case we need to 'free(hash)' and
return NULL from this method.

> +    }
> +
> +    return hash;
> +}
> +
> +static
> +void qcrypto_afalg_hash_free(QCryptoHash *hash)
> +{
> +    QCryptoAFAlg *ctx = hash->opaque;
> +
> +    if (ctx) {
> +        qcrypto_afalg_comm_free(ctx);
> +    }
> +
> +    g_free(hash);
> +}
> +
> +/**
> + * Send data to the kernel's crypto core.
> + *
> + * The more_data parameter is used to notify the crypto engine
> + * that this is an "update" operation, and that more data will
> + * be provided to calculate the final hash.
> + */
> +static
> +int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
> +                                 const struct iovec *iov,
> +                                 size_t niov,
> +                                 bool more_data,
> +                                 Error **errp)
> +{
> +    int ret = 0;
> +    int flags = (more_data ? MSG_MORE : 0);
> +
> +    /* send data to kernel's crypto core */
> +    ret = iov_send_recv_with_flags(afalg->opfd, flags, iov, niov,
> +                                   0, iov_size(iov, niov), true);
> +    if (ret < 0) {
> +        error_setg_errno(errp, errno, "Send data to afalg-core failed");
> +        ret = -1;
> +    } else {
> +        /* No error, so return 0 */
> +        ret = 0;
> +    }
> +
> +    return ret;
> +}
> +
> +static
> +int qcrypto_afalg_recv_from_kernel(QCryptoAFAlg *afalg,
> +                                   QCryptoHashAlgorithm alg,
> +                                   uint8_t **result,
> +                                   size_t *result_len,
> +                                   Error **errp)
> +{
> +    struct iovec outv;
> +    int ret = 0;
> +    const int expected_len = qcrypto_hash_digest_len(alg);
> +
> +    if (*result_len == 0) {
> +        *result_len = expected_len;
> +        *result = g_new0(uint8_t, *result_len);
> +    } else if (*result_len != expected_len) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is not match hash %d",
> +                   *result_len, expected_len);
> +        ret = -1;
> +    }

Check the error condition first, and do an immediate
'return -1', avoiding the following conditional

> +
> +    if (ret == 0) {
> +        /* hash && get result */
> +        outv.iov_base = *result;
> +        outv.iov_len = *result_len;
> +        ret = iov_send_recv(afalg->opfd, &outv, 1,
> +                            0, iov_size(&outv, 1), false);
> +        if (ret < 0) {
> +            error_setg_errno(errp, errno, "Recv result from afalg-core failed");
> +            ret = -1;

Again do an imediate 'return -1'.

> +        } else {
> +            ret = 0;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static
> +int qcrypto_afalg_hash_update(QCryptoHash *hash,
> +                              const struct iovec *iov,
> +                              size_t niov,
> +                              Error **errp)
> +{
> +    return qcrypto_afalg_send_to_kernel((QCryptoAFAlg *) hash->opaque,
> +                                        iov, niov, true, errp);
> +}
> +
> +static
> +int qcrypto_afalg_hash_finalize(QCryptoHash *hash,
> +                                 uint8_t **result,
> +                                 size_t *result_len,
> +                                 Error **errp)
> +{
> +    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlg *) hash->opaque,
> +                                          hash->alg, result, result_len, errp);
> +}
> +
>  static int
>  qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlg *hmac,
>                                 QCryptoHashAlgorithm alg,
> @@ -205,6 +327,10 @@ static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
>  
>  QCryptoHashDriver qcrypto_hash_afalg_driver = {
>      .hash_bytesv = qcrypto_afalg_hash_bytesv,
> +    .hash_new      = qcrypto_afalg_hash_new,
> +    .hash_free     = qcrypto_afalg_hash_free,
> +    .hash_update   = qcrypto_afalg_hash_update,
> +    .hash_finalize = qcrypto_afalg_hash_finalize
>  };
>  
>  QCryptoHmacDriver qcrypto_hmac_afalg_driver = {
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index 63a1c01965..43884cdd64 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h

snip

> diff --git a/util/iov.c b/util/iov.c
> index 7e73948f5e..5644e0b73c 100644
> --- a/util/iov.c
> +++ b/util/iov.c

snip

Could you split the iov.h/.c changes into  a separate patch that comes
before this one, since they're under a separate maintainer, and thus
desirable to split out for visibility.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


