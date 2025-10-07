Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E794CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64SU-0001p1-0H; Tue, 07 Oct 2025 05:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64SR-0001oV-Nz
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64SP-000417-T8
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759831087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0PMCmAYMtS8goZVoz7dN5ks+POJFcyTa16DT+/pYYIU=;
 b=FF/cEOpBFczVy13wYzrfBrox5vHzvdjlfVEeazQpXEbdlMuquvm4XDLpGHgJkMmKBf+BpX
 Ri7w5mUFT1IXO7/HlaeD9iQi7DlV8VWBNGj8EoDlj6tX/LxFXq+O9Oz5c9Kg1gmhS8nJ+Q
 f5rZNN8Bm5Byr2T3Oj4WFqGmTLZtvV8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-WtX5sxggPaeCiV3UR6rfWQ-1; Tue, 07 Oct 2025 05:58:06 -0400
X-MC-Unique: WtX5sxggPaeCiV3UR6rfWQ-1
X-Mimecast-MFC-AGG-ID: WtX5sxggPaeCiV3UR6rfWQ_1759831085
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e35baddc1so30928555e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759831085; x=1760435885;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0PMCmAYMtS8goZVoz7dN5ks+POJFcyTa16DT+/pYYIU=;
 b=io0IlB+lPA3O28TtJ99p1vtbh5N5o1w32H1YoZWPxtA8Klemw/yMvR1TOT9oCPbLnd
 rX+1+jPHGqG9vrahaZlAip1Ta8xV/s66vkoWx9FUDAC3M75hqagXZKVoyZzTUVs/pYhz
 6AWbUV0vrWVfNi9i6C227EPdofm/H/aVTjyiSlSDBwVJLfJri0uPivlezk24u8lYXJHU
 8eIn8pUOWJwrzzX7ZwYqXXCogaZIJt5y1kV16tkilifyBrWPS2VNu0gkrbaC/lzCYG8T
 qwjGkDO0+i6HPBqazQLnpspq3qBYBvPvfzzuyto7x6Laorc6J9U9KdyXCglbIyAnX1JM
 EvFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtrwUEkhukTOi7m11VYanZoxdBGYkYlhIebDPnXs4nsH7yA8r6eu+nyUhOUZj7YNGI73lR+alLQ3Kp@nongnu.org
X-Gm-Message-State: AOJu0Yyb2v/ZywU04bKFTyfPI6ubOV0LlKNzrP4nnyrNZbKAKGgMkXQP
 X8J9PbZ47LahPnVQlVFJ7yAYbB+RUQ2T8DbvGI8a9k0AvEEAlA+ZGkfjWC/bRUYTB3dNcyPyfJh
 kr12/vpHmFCm4LgZjQNKJnJ0ogvi9tCDVaLS2RB5SB6mPVJPOZK4+hVzP
X-Gm-Gg: ASbGncufmLHVqu1nqZ8RB2Fvq6j6YCgvcEgUpcMae+QCo+DQ4PyeUjP5qTMzz10IXo7
 DMk++bPnQbmn6oqlcjPZhH9SToQjEdEu3NqIJwAUucKmiqQkd+Ma+ywQeXKsqv2uGUcdy/W/6y6
 zsKxLVLfYzvE3S7zIWzl40kHQgn0xNV4DTiL7R8rbdj7gc/9UUnpteTRvqb8wJmuFH0KHp04hkx
 IaIzUGrAkTuYaWH4n/F4etvQlIqU1Jw+Dys27cDsnYHCW+lKui/YIt/k+RS8CTe0m9cGptd/ncH
 IxKQ+sfKNFCNM5FpOh2YCfF4U1ZRA9juHyOPc0eenklo2n7YZqVaC6hghHbIiE6sDGBhbig=
X-Received: by 2002:a05:600c:3149:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-46e7114829cmr91449365e9.32.1759831085157; 
 Tue, 07 Oct 2025 02:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6JpjHqvhE5PgMDeq6o3JfPYa9MzS4e3dR8JGduZgRH8jHCb8r2gWUY6zSSxbZHCEb88zP2Q==
X-Received: by 2002:a05:600c:3149:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-46e7114829cmr91449035e9.32.1759831084673; 
 Tue, 07 Oct 2025 02:58:04 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374b8dsm223062265e9.19.2025.10.07.02.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 02:58:04 -0700 (PDT)
Message-ID: <896998e3-9e11-4aaf-9900-1ab1773fd18b@redhat.com>
Date: Tue, 7 Oct 2025 11:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/28] crypto/x509-utils: Add helper functions for DIAG
 508 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-12-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-12-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Introduce helper functions to support signature verification required by
> DIAG 508 subcode 1:
> 
> qcrypto_pkcs7_convert_sig_pem() – converts a signature from DER to PEM format
> qcrypto_x509_verify_sig() – verifies the provided data against the given signature
> 
> These functions enable basic signature verification support.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   crypto/x509-utils.c         | 109 ++++++++++++++++++++++++++++++++++++
>   include/crypto/x509-utils.h |  39 +++++++++++++
>   2 files changed, 148 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 763eccb190..8f3c895d7c 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -16,6 +16,7 @@
>   #include <gnutls/gnutls.h>
>   #include <gnutls/crypto.h>
>   #include <gnutls/x509.h>
> +#include <gnutls/pkcs7.h>
>   
>   static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>       [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
> @@ -342,6 +343,97 @@ int qcrypto_x509_is_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
>       return 0;
>   }
>   
> +int qcrypto_pkcs7_convert_sig_pem(uint8_t *sig, size_t sig_size,
> +                                  uint8_t **result, size_t *resultlen,
> +                                  Error **errp)
> +{
> +    int ret = -1;
> +    int rc;
> +    gnutls_pkcs7_t signature;
> +    gnutls_datum_t sig_datum_der = {.data = sig, .size = sig_size};
> +    gnutls_datum_t sig_datum_pem = {.data = NULL, .size = 0};
> +
> +    rc = gnutls_pkcs7_init(&signature);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initalize pkcs7 data: %s", gnutls_strerror(rc));
> +        return ret;
> +     }

Indentation of the "}" is off by one.

> +    rc = gnutls_pkcs7_import(signature, &sig_datum_der, GNUTLS_X509_FMT_DER);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import signature: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_pkcs7_export2(signature, GNUTLS_X509_FMT_PEM, &sig_datum_pem);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to convert signature to PEM format: %s",
> +                   gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *result = g_new0(uint8_t, sig_datum_pem.size);
> +    *resultlen = sig_datum_pem.size;
> +    memcpy(*result, sig_datum_pem.data, sig_datum_pem.size);

I think you could replace the g_new0 + memcpy with a g_memdup2() here.

> +    ret = 0;
> +
> +cleanup:
> +    gnutls_pkcs7_deinit(signature);
> +    gnutls_free(sig_datum_pem.data);
> +    return ret;
> +}
> +
> +int qcrypto_x509_verify_sig(uint8_t *cert, size_t cert_size,
> +                            uint8_t *comp, size_t comp_size,
> +                            uint8_t *sig, size_t sig_size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt = NULL;
> +    gnutls_pkcs7_t signature = NULL;
> +    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
> +    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
> +    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;

So if you go to cleanup here, signature is still NULL ...

> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &cert_datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_pkcs7_init(&signature);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initalize pkcs7 data: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +     }
> +
> +    rc = gnutls_pkcs7_import(signature, &sig_datum , GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import signature: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_pkcs7_verify_direct(signature, crt, 0, &data_datum, 0);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to verify signature: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_pkcs7_deinit(signature);

... did you check whether gnutls_pkcs7_deinit() is able to deal with NULL 
pointers? The man-page does not mention it ... so just to be on the save 
side, maybe it would be better to have to cleanup labels, and only do the 
gnutls_pkcs7_deinit() if it has been initialized before?

> +    return ret;
> +}

  Thomas


