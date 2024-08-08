Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72177C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 16:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc5dV-0006s1-Am; Thu, 08 Aug 2024 12:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc5dC-0006mi-En
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc5dA-0002eh-IA
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 12:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723133087;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+9sL8w5QsojHmEMAyRA5Dd5G7XNuy64k2XrWFYyv56c=;
 b=I+dOKbokBnw++a6ANiFUGeJHNbfXssCF0yKxissFqpih7R5q5j1axFaiRLoYssbnawyrBa
 xHk9kn3xTE/dyM+sxDT9iCZeMM+UysiGghRwdUR842n0xlcb7V6hpAh9hEWzwYF/7V0N8M
 sRAqhAza1d8yaXSFkgelzSbFBt+IU9Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-4k9LryapMFyJFgihj67nbQ-1; Thu,
 08 Aug 2024 12:04:43 -0400
X-MC-Unique: 4k9LryapMFyJFgihj67nbQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA25D196CDFE; Thu,  8 Aug 2024 16:04:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99ECF19560AA; Thu,  8 Aug 2024 16:04:38 +0000 (UTC)
Date: Thu, 8 Aug 2024 17:04:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 01/15] crypto: accumulative hashing API
Message-ID: <ZrTskk2UCzWbmupd@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-2-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807195122.2827364-2-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Wed, Aug 07, 2024 at 07:51:08PM +0000, Alejandro Zeise wrote:
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
>  crypto/hashpriv.h     |  13 +++++
>  include/crypto/hash.h | 119 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
> 
> diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
> index cee26ccb47..02f17ee99f 100644
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
> @@ -15,6 +16,8 @@
>  #ifndef QCRYPTO_HASHPRIV_H
>  #define QCRYPTO_HASHPRIV_H
>  
> +#include "crypto/hash.h"
> +
>  typedef struct QCryptoHashDriver QCryptoHashDriver;
>  
>  struct QCryptoHashDriver {
> @@ -24,6 +27,16 @@ struct QCryptoHashDriver {
>                         uint8_t **result,
>                         size_t *resultlen,
>                         Error **errp);
> +    QCryptoHash *(*hash_new)(QCryptoHashAlgorithm alg, Error **errp);
> +    int (*hash_update)(QCryptoHash *hash,
> +                       const struct iovec *iov,
> +                       size_t niov,
> +                       Error **errp);
> +    int (*hash_finalize)(QCryptoHash *hash,
> +                         uint8_t **result,
> +                         size_t *resultlen,
> +                         Error **errp);
> +    void (*hash_free)(QCryptoHash *hash);
>  };
>  
>  extern QCryptoHashDriver qcrypto_hash_lib_driver;
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 54d87aa2a1..6d7222867e 100644
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
> @@ -120,6 +128,117 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
>                           char **digest,
>                           Error **errp);
>  
> +/**
> + * qcrypto_hash_updatev:
> + * @hash: hash object from qcrypto_hash_new
> + * @iov: the array of memory regions to hash
> + * @niov: the length of @iov
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Updates the given hash object with all the memory regions
> + * present in @iov.
> + *
> + * Returns: 0 on success, non-zero on error

Minor point, this and all the other APIs should be saying
'or -1 on error' to follow QEMU's error reporting standards.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


