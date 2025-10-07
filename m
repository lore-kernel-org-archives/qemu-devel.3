Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA19BCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v645g-0000xW-RK; Tue, 07 Oct 2025 05:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v645f-0000x4-3T
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v645c-0001K5-If
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759829674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=erhl4C8yRDJ7u3mDTbyS/Qua5V62aTYxjkp1MSDfUeA=;
 b=bhHndh+ArhrAgybQgt299SGHieIKjswTq5SwDFStGKMTVlJ6hvYzMJjSpBYac/KX/P8Dbv
 ibYL5r0eT8+R2JstLkrDvFrE/Cxet5+Swg4RQjhCtLG0GtkSL3vM8HcXYq0heyBtskq64w
 lRiVRPAL/rtalAV1FxCsKNu0DMClGVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-iPSfaXntPTOBFuDFBcwpWA-1; Tue, 07 Oct 2025 05:34:33 -0400
X-MC-Unique: iPSfaXntPTOBFuDFBcwpWA-1
X-Mimecast-MFC-AGG-ID: iPSfaXntPTOBFuDFBcwpWA_1759829672
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso31139455e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759829672; x=1760434472;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=erhl4C8yRDJ7u3mDTbyS/Qua5V62aTYxjkp1MSDfUeA=;
 b=mi5jWa/LwtHUMFYgdscqOW7oeiMhxteiJUftFnXGGYBOxmZr0TQDTowQNlG02UWmKH
 T9Q6SobN2NVbNpjo1GBX5DkUd8mzWcpL55Y2PEW3PEg3AwsiJ7iDH64i7gqAL2h+gw6D
 7hElujbQnGGpahvoEu/3U0AqjHuCmCwnF2pjqSa7tNLcojjGe+4DuwgGS2Y2fpUTVbKC
 MhXUhSwMeefOcCOK1CwpYA+DrjuTBBFuKLfWbliClM7MMdqVy2k30pGYJWzpRvvyBDBv
 6J6vg/xzePfrmPMqpDyGvyQTKyrrexbC8aXKOmswkWPgMPIMpHKLJ+P/z2RekoZJ0EXf
 luBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqnMMcZfug/g3YhlV/G0L9zvNsxFkbOdkjeXo0HbZXKD4v/0PlWDKOYTPhV1MkivOYlIsl7OGUlCGX@nongnu.org
X-Gm-Message-State: AOJu0YwHhw5Mer4ERFZAp3TLN3PZHFpzE5Y4SUUnFeKj4QSRygfcYC+j
 JrJKSQ47hsKmnMGysfOoT4XBj4tjyQEYYskCpCBeSEaxHpL2cSMv9RqyqMxOYgn2TP9ZBWtawFW
 f8S7FOgvLjYib3q75IWvOx8F0jVlfO9ymACkVDk7Mzo/LfFVUgoCaebbg
X-Gm-Gg: ASbGncvqgulgE6C/aXuH5JGuvawSU/qmPkW2H3f+9X36kkmER3mes0m0SDvTu/pPzKL
 2Ybbgzn5Jf/Ny1WHoakXEyjQAvcrsKYFtU0yvQPHPHLU/oWevmeIox4AqHzczLlfEy2+oN8nis2
 uylLlctLFctQm1E7U2EfWv7AF6UNhtavsyBkh6cQvZD6CQcoOXuKpEBRii2Rg28IhWG0n0tt0C6
 qpyctvQQdIAeMnHIbnWOLGaFI/EzOxKDehi6zUgtqiLeSwTtuxlyin2GM+F1TuKnCrGlxYCz4X+
 ASzJ8L24i7qgAvEVorLcQDgNZdKCsPDpD5ZNXvsjczsRWg21A28e8SqmdTMA+Idp7CkkRVU=
X-Received: by 2002:a05:600c:354a:b0:46e:1a07:7bd5 with SMTP id
 5b1f17b1804b1-46e7114e5aamr100626955e9.29.1759829671838; 
 Tue, 07 Oct 2025 02:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPOSsSQ2QF5YacTFnlwxEWpqb4PQ6dlhPE3NDxw0FgHTdOM8vTMsngpTvi8YLZzTRMSjFs+A==
X-Received: by 2002:a05:600c:354a:b0:46e:1a07:7bd5 with SMTP id
 5b1f17b1804b1-46e7114e5aamr100626675e9.29.1759829671389; 
 Tue, 07 Oct 2025 02:34:31 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8507sm295195075e9.3.2025.10.07.02.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 02:34:30 -0700 (PDT)
Message-ID: <dd3ebdf4-3d80-475b-8739-65b6b771a0b6@redhat.com>
Date: Tue, 7 Oct 2025 11:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/28] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-9-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Introduce new helper functions to extract certificate metadata needed for
> DIAG 320 subcode 2:
> 
> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
> 
> These functions provide support for metadata extraction and validity checking
> for X.509 certificates.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> +int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    unsigned int bits;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
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
> +    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
> +    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_pk_alg_map)) {

gnutls_x509_crt_get_pk_algorithm can also return a negative value according 
to the documentation, so I think you should also check for "rc < 0" in 
addition here.

> +        error_setg(errp, "Unknown public key algorithm %d", rc);
> +        goto cleanup;
> +    }
> +
> +    ret = gnutls_to_qcrypto_pk_alg_map[rc];
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
> +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoHashAlgo hash_alg,
> +                                 uint8_t **result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        error_setg(errp, "Unknown hash algorithm %d", hash_alg);
> +        return ret;
> +    }
> +
> +    if (qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1 ||
> +        hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {

Since "||" conditions are evaluated from left to right, please check for the 
boundary first before using hash_alg as index into the array (i.e. swapt the 
two sides of the "||").

> +        error_setg(errp, "Unsupported key id flag %d", hash_alg);
> +        return ret;
> +    }
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
> +    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
> +    if (*resultlen == 0) {
> +        error_setg(errp, "Failed to get hash algorithn length: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *result = g_malloc0(*resultlen);
> +    if (gnutls_x509_crt_get_key_id(crt,
> +                                   qcrypto_to_gnutls_keyid_flags_map[hash_alg],
> +                                   *result, resultlen) != 0) {
> +        error_setg(errp, "Failed to get key ID from certificate");
> +        g_clear_pointer(result, g_free);
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
...
> +int qcrypto_x509_is_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int curve_id;
> +
> +    curve_id = qcrypto_x509_get_ecc_curve(cert, size, errp);
> +    if (curve_id == -1) {
> +        return -1;
> +    }
> +
> +    if (curve_id == GNUTLS_ECC_CURVE_INVALID) {
> +        error_setg(errp, "Invalid ECC curve");
> +        return -1;
> +    }
> +
> +    if (curve_id == GNUTLS_ECC_CURVE_SECP521R1) {
> +        return 1;
> +    }
> +
> +    return 0;
> +}

Bikeshedding, but IMHO, if you name a function "..._is_something", I'd 
prefer if it returns a bool, and not an "int". Otherwise this might get 
confusing if you read something like this later in the code:

    if (qcrypto_x509_is_ecc_curve_p521(...)) {
    }

The caller could use errp to distinguish between the error case and a
simple "false" as answer to the question.
  Thomas


