Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA849C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6eh-0007oY-Hd; Thu, 08 Aug 2024 13:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6eg-0007nc-S7
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6ee-0005EV-Tb
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723137024;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=d/QWo6CsMP+e5XaOMkLMmP3WP0F/4YPJaDWuFx2XqkA=;
 b=alB0cenSjnZyW9anGX/HczwnwetVxGL7S19UAxfHzutyACcC7rmntD4qd5hKM3PRlfBlEX
 eZcZ2yIyTtfD7wJ0VzpCgtGK52HLYp8TQAzJCMZ6mw7gN8ecTlN6Us+opAcL8Mvx92WtlE
 YIhJIQsRNOEo7sByUKFMnSS/0qnxdBE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-vdETzv0TNiyCpqYfz6-t8Q-1; Thu,
 08 Aug 2024 13:10:18 -0400
X-MC-Unique: vdETzv0TNiyCpqYfz6-t8Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7495B196E09E; Thu,  8 Aug 2024 17:10:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 294173000197; Thu,  8 Aug 2024 17:10:13 +0000 (UTC)
Date: Thu, 8 Aug 2024 18:10:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/15] crypto/hash-gnutls: Implement new hash API
Message-ID: <ZrT78tp2D9YfnO8_@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-5-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807195122.2827364-5-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, Aug 07, 2024 at 07:51:11PM +0000, Alejandro Zeise wrote:
> Implements the new hashing API in the gnutls hash driver.
> Supports creating/destroying a context, updating the context
> with input data and obtaining an output hash.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  crypto/hash-gnutls.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
> index 17911ac5d1..15fc630a11 100644
> --- a/crypto/hash-gnutls.c
> +++ b/crypto/hash-gnutls.c
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto hash algorithms
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2021 Red Hat, Inc.
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -98,7 +99,79 @@ qcrypto_gnutls_hash_bytesv(QCryptoHashAlgorithm alg,
>      return 0;
>  }
>  
> +static
> +QCryptoHash *qcrypto_gnutls_hash_new(QCryptoHashAlgorithm alg, Error **errp)
> +{
> +    QCryptoHash *hash = NULL;
> +
> +    if (!qcrypto_hash_supports(alg)) {
> +        error_setg(errp,
> +                   "Unknown hash algorithm %d",
> +                   alg);
> +    } else {
> +        hash = g_new(QCryptoHash, 1);
> +        hash->alg = alg;
> +        hash->opaque = g_new(gnutls_hash_hd_t, 1);
> +
> +        gnutls_hash_init(hash->opaque, qcrypto_hash_alg_map[alg]);

  int ret = gnutls_hash_init(...)
  if (ret < 0) {
      error_setg(errp, ....)
      g_free(hash->opaque);
      g_free(hash);
      return NULL;
  }

> +    }
> +
> +    return hash;
> +}
> +
> +static
> +void qcrypto_gnutls_hash_free(QCryptoHash *hash)
> +{
> +    gnutls_hash_hd_t *ctx = hash->opaque;
> +
> +    g_free(ctx);
> +    g_free(hash);
> +}
> +
> +
> +static
> +int qcrypto_gnutls_hash_update(QCryptoHash *hash,
> +                               const struct iovec *iov,
> +                               size_t niov,
> +                               Error **errp)
> +{
> +    int fail = 0;
> +    gnutls_hash_hd_t *ctx = hash->opaque;
> +
> +    for (int i = 0; i < niov; i++) {
> +        fail = gnutls_hash(*ctx, iov[i].iov_base, iov[i].iov_len) || fail;

Needs to report in 'errp'  when failure happens & return immediately. eg

   int ret = gnutls_hash(*ctx, iov[i].iov_base, iov[i].iov_len);
   if (ret != 0) {
       error_setg(errp, ....)
       return -1;
   }

> +    }
> +
> +    return fail;

Just 'return 0'

> +}
> +
> +static
> +int qcrypto_gnutls_hash_finalize(QCryptoHash *hash,
> +                                 uint8_t **result,
> +                                 size_t *result_len,
> +                                 Error **errp)
> +{
> +    int ret = 0;
> +    gnutls_hash_hd_t *ctx = hash->opaque;
> +
> +    *result_len = gnutls_hash_get_len(qcrypto_hash_alg_map[hash->alg]);
> +    if (*result_len == 0) {
> +        error_setg(errp, "%s",
> +                   "Unable to get hash length");
> +        ret = -1;
> +    } else {
> +        *result = g_new(uint8_t, *result_len);
> +
> +        gnutls_hash_deinit(*ctx, *result);

We should use  gnutls_hash_output() here instead, and call
gnutls_hash_deinit() in the qcrypto_gnutls_hash_free()
method.  That ensures all memory is freed if the user
never calls qcrypto_hash_finalize()

> +    }
> +
> +    return ret;
> +}
>  
>  QCryptoHashDriver qcrypto_hash_lib_driver = {
>      .hash_bytesv = qcrypto_gnutls_hash_bytesv,
> +    .hash_new      = qcrypto_gnutls_hash_new,
> +    .hash_update   = qcrypto_gnutls_hash_update,
> +    .hash_finalize = qcrypto_gnutls_hash_finalize,
> +    .hash_free     = qcrypto_gnutls_hash_free,
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


