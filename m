Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B5BC52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6fU-0000pj-Nr; Thu, 08 Aug 2024 13:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6fP-0000e7-Id
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6fN-0005La-Sc
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723137068;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QcUlKu0d3TMsMOhpizMIuhkeNtJvX9T9Yb6EiCvD520=;
 b=i9Ib3GvsgiiNJqYga/ofE8mlxNEHVa4eT7tHvNacbQRqamIm+cr7QXuhQqy9hODOiYnBm9
 0OLlHa+vstPbIUOgzzkBPKrwmnwOTdMGNbhq464TpzE3qTlowM7cLQvhBAwfpGqOb9Zdsk
 y80ItkJ1d7DZIlp9mx11FR/Chhoda5U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-KIcfrlRsOqKf6cJ4l0yJuw-1; Thu,
 08 Aug 2024 13:11:05 -0400
X-MC-Unique: KIcfrlRsOqKf6cJ4l0yJuw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1606219772EF; Thu,  8 Aug 2024 17:11:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8261B19560A3; Thu,  8 Aug 2024 17:10:59 +0000 (UTC)
Date: Thu, 8 Aug 2024 18:10:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 03/15] crypto/hash-gcrypt: Implement new hash API
Message-ID: <ZrT8IHnlmjsl0mYd@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-4-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807195122.2827364-4-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Wed, Aug 07, 2024 at 07:51:10PM +0000, Alejandro Zeise wrote:
> Implements the new hashing API in the gcrypt hash driver.
> Supports creating/destroying a context, updating the context
> with input data and obtaining an output hash.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  crypto/hash-gcrypt.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
> index 829e48258d..e05511cafa 100644
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
> @@ -110,7 +111,85 @@ qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
>      return -1;
>  }
>  
> +static
> +QCryptoHash *qcrypto_gcrypt_hash_new(QCryptoHashAlgorithm alg, Error **errp)
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
> +        hash->opaque = g_new(gcry_md_hd_t, 1);
> +
> +        gcry_md_open((gcry_md_hd_t *) hash->opaque, qcrypto_hash_alg_map[alg], 0);

Need to check for error from gcry_md_open and report it, and
free hash & hash->opaque

> +    }
> +
> +    return hash;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


