Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19BFC52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6ms-0007Ea-NF; Thu, 08 Aug 2024 13:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6mq-0007Dv-Nx
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6mo-0006aN-Ou
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723137529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KyLcyHSKZEiNL+6JBjA5g0ip0FsPMv0vlE8ZzEyToFE=;
 b=F4dNxFFO3uJX2x98NXXCkd1V6dPiSyUGjxR1x8pcrnS7ce/EkN4t/NvdUsVNakJpT16WWK
 p6dwD+0wS2CH75e+mNCIfjDDEF34i7pkLjpV5ltSdgufA3VDcOzXjcqkAiVWrShfM4+0LX
 O8lN5qsKAKJQ844KqQM5kobr/ypNZhg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-2vvKD27oOGmaUVNTpQZSFQ-1; Thu,
 08 Aug 2024 13:18:47 -0400
X-MC-Unique: 2vvKD27oOGmaUVNTpQZSFQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 505DF1955F69; Thu,  8 Aug 2024 17:18:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CDBE300018D; Thu,  8 Aug 2024 17:18:42 +0000 (UTC)
Date: Thu, 8 Aug 2024 18:18:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] tests/unit/test-crypto-hash: accumulative hashing
Message-ID: <ZrT972O-HcxMkT9L@redhat.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-9-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807195122.2827364-9-alejandro.zeise@seagate.com>
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

On Wed, Aug 07, 2024 at 07:51:15PM +0000, Alejandro Zeise wrote:
> Added an accumulative hashing test. Checks for functionality of
> the new hash create, update, finalize and free functions.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>  tests/unit/test-crypto-hash.c | 48 +++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
> index 1f4abb822b..2bf9bcb6a0 100644
> --- a/tests/unit/test-crypto-hash.c
> +++ b/tests/unit/test-crypto-hash.c
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Crypto hash algorithms
>   *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>   * Copyright (c) 2015 Red Hat, Inc.
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -241,6 +242,52 @@ static void test_hash_base64(void)
>      }
>  }
>  
> +static void test_hash_accumulate(void)
> +{
> +    QCryptoHash *hash;

Move this inside the for() and use 'g_autoptr(QCryptoHash) hash = NULL'

> +    size_t i;
> +
> +    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
> +        struct iovec iov[3] = {

Don't need to declare it '[3]' just '[]' as, then....

> +            { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
> +            { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
> +            { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
> +        };
> +        uint8_t *result = NULL;

g_autofree uint8_t *result = NULL;

> +        size_t resultlen = 0;
> +        int ret;
> +        size_t j;
> +
> +        if (!qcrypto_hash_supports(i)) {
> +            continue;
> +        }
> +
> +        hash = qcrypto_hash_new(i, &error_fatal);
> +        g_assert(hash != NULL);
> +
> +        /* Add each iovec to the hash context separately */
> +        for (j = 0; j < 3; j++) {

...instead of 'j < 3' use  'j < G_N_ELEMENTS(iov)'

> +            ret = qcrypto_hash_updatev(hash,
> +                                      &iov[j], 1,
> +                                      &error_fatal);
> +
> +            g_assert(ret == 0);
> +        }
> +
> +        ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen,
> +                                          &error_fatal);
> +
> +        g_assert(ret == 0);
> +        g_assert(resultlen == expected_lens[i]);
> +        for (j = 0; j < resultlen; j++) {
> +            g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
> +            g_assert(expected_outputs[i][j * 2 + 1] == hex[result[j] & 0xf]);
> +        }
> +        g_free(result);
> +        qcrypto_hash_free(hash);

Drop these two frees.

> +    }
> +}
> +
>  int main(int argc, char **argv)
>  {
>      int ret = qcrypto_init(&error_fatal);
> @@ -252,5 +299,6 @@ int main(int argc, char **argv)
>      g_test_add_func("/crypto/hash/prealloc", test_hash_prealloc);
>      g_test_add_func("/crypto/hash/digest", test_hash_digest);
>      g_test_add_func("/crypto/hash/base64", test_hash_base64);
> +    g_test_add_func("/crypto/hash/accumulate", test_hash_accumulate);
>      return g_test_run();
>  }
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


