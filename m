Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11478CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WtF-0006zV-9g; Tue, 30 Sep 2025 05:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3WtD-0006z1-BD
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Wt9-0002uT-80
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759225388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nCu/5gybyIX1fQM2Drvp2/KFXjl8gHsSBAvBJoRF3UY=;
 b=T63nFD1ENCnSog1F0MOhYPmVUPgvFrRpM3ySRHq/MbdipG5O13o097TysgE4TCK/dDirbE
 ioHr5mDmsxpATai2c/jpagr1aBHHbn0Tp1r6XF+Fg85BRkJlRxgiAbtl59NgWLgp4ZhyQb
 ILEIj1EcfWtEdMqkDRVzwls5YxLFfa8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-yUncf6iQPom649-wLIwzSA-1; Tue, 30 Sep 2025 05:43:05 -0400
X-MC-Unique: yUncf6iQPom649-wLIwzSA-1
X-Mimecast-MFC-AGG-ID: yUncf6iQPom649-wLIwzSA_1759225385
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e31191379so36089265e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759225384; x=1759830184;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCu/5gybyIX1fQM2Drvp2/KFXjl8gHsSBAvBJoRF3UY=;
 b=lNDYPhxAGXZ6kKb4utk0+D/JqCsCxWhDKLcH8cvAK8vvEoPtof1GpK6KDy76gdVSbC
 bIvYXGlUFCLvaESDOaLETqhrFdMhFTHvc8X7GjqJq7HIb6DN2BxUAs3rnqkJHYbHJWR1
 83fEEcdKjuqTeqFgIFmBNcGTg3p093SaRNA56GOMiy0RqGhjbiOEjiscJdLoZq70DKPx
 w8WLdl1Q6UejiRgeZ719xvHDeEVoidlkh33034fB4oXLDtw+IK+8Kc8k/5Mn8BDxPe27
 zi+fDeV+BgFS/Rg2wHkS7FuXjvKyNZR/jxZI0PGFvsnIeNee58MM7OVvr85Bv1dosLa6
 zzqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNmG9ZKcvcKx9MJTI0M4ljv0Mw9aov3w6iQe0G7ImzbkMTlA2KP+B4DIyDLyvwldZYTTyTTGJKquVU@nongnu.org
X-Gm-Message-State: AOJu0Yyp4lCGHn5IzVqgdJdg/S1vgFYD+B4B7gnwDNkPNH2Kq7A4Dn0t
 wtbfKdSIhyozIt4gz3VupCVhUmVe5THWkKQwCU/tXCF//m1ormGPq0yHRsALrULvtFw8f4jsyWb
 WsPE0o+ewfmlr5RGaR/Od8b+V+nzF4EJ2HVCkIye0Tj5PaWSShOSYXf/R
X-Gm-Gg: ASbGncupvhfOC2/VX2xryPORyHL7wI4Jsj5r3453ao2dqR+fCFVjARhRRy52ypvlxRU
 LbqhvjYi5oDycK63dUBiEjsFig3p+IB5H+QI5rC7pISBJNdQbmkeUvRu0Re322BxFafEbWNrqE1
 IQU1iZ7tNBHrvOoDdLJ6bLtTSkDdvQvllyZwApkH9+rZLsyDs6SptWhGRpGvAWu2h9W/VhNTqVC
 X4R0VrTgWqWRRFh2mTbhDRMJkI43rv0EPkVTToe++1ltfRIY+a0He8R9zcJC445j6FgF6JplZvH
 pVtl1dS6dxot49H/2E/5YokUdpoSVeAoK4SBvtcGE5b/HVlu+l7CwuPXdPIKlHN/tWWfGP8T9Tu
 qtyHS7HF4kg==
X-Received: by 2002:a05:600c:4e4a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e4b7906ecmr115705125e9.31.1759225384623; 
 Tue, 30 Sep 2025 02:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5uuR1xa/hBfsW+KrHe4MZhAtyBxwUCd7aXDBc8Z/1xF/VBDg9idicFHZFkb9W2GR9JL34Bw==
X-Received: by 2002:a05:600c:4e4a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e4b7906ecmr115704555e9.31.1759225384096; 
 Tue, 30 Sep 2025 02:43:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm260491395e9.17.2025.09.30.02.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 02:43:03 -0700 (PDT)
Message-ID: <d8659ca0-ea69-4288-922e-a237e7fec8fa@redhat.com>
Date: Tue, 30 Sep 2025 11:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/28] crypto/x509-utils: Add helper functions for
 certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-4-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Introduce new helper functions for x509 certificate, which will be used
> by the certificate store:
> 
> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
> 
> These functions provide support for certificate format conversion.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   crypto/x509-utils.c         | 50 +++++++++++++++++++++++++++++++++++++
>   include/crypto/x509-utils.h | 20 +++++++++++++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 6176a88653..5d43b0ec96 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -81,6 +81,47 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>       return ret;
>   }
>   
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result, size_t *resultlen,
> +                                  Error **errp)
> +{
> +    int ret = -1;
> +    int rc;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_datum_t datum_der = {.data = NULL, .size = 0};
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_export2(crt, GNUTLS_X509_FMT_DER, &datum_der);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to convert certificate to DER format: %s",
> +                   gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *result = g_new0(uint8_t, datum_der.size);
> +    *resultlen = datum_der.size;
> +    memcpy(*result, datum_der.data, datum_der.size);
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_free(datum_der.data);
> +    return ret;
> +}
> +
>   #else /* ! CONFIG_GNUTLS */
>   
>   int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> @@ -93,4 +134,13 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>       return -1;
>   }
>   
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to export X.509 certificate");
> +    return -1;
> +}
> +
>   #endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index 1e99661a71..4239e3e55a 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -19,4 +19,24 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                         size_t *resultlen,
>                                         Error **errp);
>   
> +/**
> + * qcrypto_x509_convert_cert_der
> + * @cert: pointer to the raw certificate data in PEM format
> + * @size: size of the certificate
> + * @result: output location for the allocated buffer for the certificate in DER format
> +            (the function allocates memory which must be freed by the caller)

Please try to fit the comments into the 80 columns boundary.

  Thanks,
   Thomas

> + * @resultlen: pointer to the size of the buffer
> +               (will be updated with the actual size of the DER-encoded certificate)
> + * @errp: error pointer
> + *
> + * Convert the given @cert from PEM to DER format.
> + *
> + * Returns: 0 on success,
> + *         -1 on error.
> + */
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp);
> +
>   #endif


