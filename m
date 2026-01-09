Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339D4D16811
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAKC-00038a-9D; Fri, 09 Jan 2026 06:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veAKA-00038M-96
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veAK8-00067i-05
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767956790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FENiwgEZLuQ5yneEOOvk+PApKfzt2uwKLgb30m51p9w=;
 b=WTA/v3rrOi8nrBQKFZqcwoZQDSZvXMJIU1m6IZUbK0kYagFkfSb0pkrJjIRUGLSU6rcFGz
 3haRQOogCfkoug7VEPcQshPoCQuN5thUaPjSclbbE3tCp6Got/DaUgK1MkC2YE6SXlaZXc
 ixUGtEyXv/kf7hD0mfJG93Ix6I5xVWk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-iE6RoNcmNv6LSDA7wqcpdw-1; Fri, 09 Jan 2026 06:06:29 -0500
X-MC-Unique: iE6RoNcmNv6LSDA7wqcpdw-1
X-Mimecast-MFC-AGG-ID: iE6RoNcmNv6LSDA7wqcpdw_1767956788
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-64d1982d980so5388470a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767956788; x=1768561588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FENiwgEZLuQ5yneEOOvk+PApKfzt2uwKLgb30m51p9w=;
 b=MbXQbkCYK/CC6X+LIr22Vvo6pHzNpE4+xzewxBLGB46SLxV0Ea3NeCmcphXcZyCJG3
 bhl2rxvH8wo3vOw38ZNzLK2OUSxghsq+KR6E/ZljPF9RzH+IeFNxDBW02MtTZWG2RjFP
 A/XHlMCNalmXsrLULdx+zDR14TtiX4vEpwiMvRr4/fbNL/e66HBBD0aDF+UePNZyhpi/
 J6mARK1kt474aJHTLg5JxSdHo5Fe1vBpFyrSvCh6dEEKWwSLkKetANXP8WCTCwsPbWzE
 b850pimGPJ4ODzyCQAghi45k/lQLLvIt2CBM9y8Cn+9xmzo8I6GdiAIenqVKF3xbwXEQ
 R25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767956788; x=1768561588;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FENiwgEZLuQ5yneEOOvk+PApKfzt2uwKLgb30m51p9w=;
 b=NUCmIHz8ykljJF2DXDq5FNFUsjuif25wQ8ZJ4Wsev4WBwQoiVpxtAUPxGCaIttT8fm
 7//n/Jc4pEhIFhFnwLky0zJVvyIpERbx/tcUIn2kcQZNY+4TKAdLTlGhpC34gu5F2HXj
 R6AdE6ENQPE+cHJEJBpGqyajwXg7PGMOiLGqf5VzA/Ss2BTxVYkpemLuGgxpzbzHvxV0
 /UKISsfL9RsKLdhQmxUiWAD8SeiX6zBIXeIkNPf0qY9iri7q8OqQhZow4vxOeL+Gvy38
 1UqtI6ludSXA9PLAOmw41sAf6xiFPECrOLDtxwwbJEZBqGhVF0CvoxRI62/4v1VOxaxj
 q6QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEpAXI8KjP6t5mHqySlrOoik5o6PvAkpBhSZnGJe+kPzMwnP8nOz0Qx1y1zMOzgyncpwC+xwCWcZLi@nongnu.org
X-Gm-Message-State: AOJu0Yyp/JqJ7ifxiN5kvU2VNsKmZ1EbpSBsVwHdTh2+k8REQiYpqd1+
 muf9RC3O7PRb553x1m5Fjr7ltrKU8mPQCr37UyLFsT6oO5uZ1yLpZY8pCQgXARZaIKhcaYeGekJ
 03XkQKbgZ2RbclihtxNQREI1jwVx+J2uHQV0fNhZsJKyjQsVdlAgp2dyy
X-Gm-Gg: AY/fxX6L4u+KhKUSFBJ7il4x9o7N2j7F0X0gfCclWI/pGSq0e0g+bDNvetYm+gIyRv9
 JkVYtlurSBTOhL8tQPxLr+41G1gnXs5z3TB8nfvIUJcMhRWAvANQqXa98ldhF6vbmiN1tvg0GrH
 gs/BgqVdWa8BLZ51svLXbEIuM1sh/vXizjItHj2TXsQHEe+2hgg/GRhpunfN1U3tkYJiSMEVJN6
 debhir+Mq9SxEGDZDHQJ+SRgTBnH7sBkVP8HEczmm1RFBAbC52Z9IrWK9qqGSjX3Wxsu2Y7sP5s
 L0p/+aXmIlqsHrkz2yRam40Nd48JZMdwW25NgP/o3E/zhIxteB8QFacA+jtAZsicWuuUlttwGYL
 /K0q2JJE=
X-Received: by 2002:a05:6402:2346:b0:64b:5ee5:c6e5 with SMTP id
 4fb4d7f45d1cf-65097e6e330mr9102787a12.33.1767956788268; 
 Fri, 09 Jan 2026 03:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFkioBrqIlKj7EbbDslpUqbJiWc52Y7Hi39OhQCgbskJ99pOH+0rBsduhKa2h3RC3nZ6D8nQ==
X-Received: by 2002:a05:6402:2346:b0:64b:5ee5:c6e5 with SMTP id
 4fb4d7f45d1cf-65097e6e330mr9102757a12.33.1767956787817; 
 Fri, 09 Jan 2026 03:06:27 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be641e0sm9833164a12.22.2026.01.09.03.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 03:06:27 -0800 (PST)
Message-ID: <9f622221-5012-4f12-8fc2-3a721a0ce111@redhat.com>
Date: Fri, 9 Jan 2026 12:06:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/29] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-9-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Introduce new helper functions to extract certificate metadata:
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
>   crypto/x509-utils.c         | 248 ++++++++++++++++++++++++++++++++++++
>   include/crypto/x509-utils.h |  73 +++++++++++
>   2 files changed, 321 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 2696d48155..f91fa56563 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -27,6 +27,25 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>       [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>   };
>   
> +static const int gnutls_to_qcrypto_pk_alg_map[] = {

Could you do me a favour and add a line like this at the beginning of this 
array:

  [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,

and then also set QCRYPTO_PK_ALGO_UNKNOWN = 0 in the enum in the header?
That way we can be sure that zero values are not accidentally mapped to a 
valid algorithm.

> +    [GNUTLS_PK_RSA] = QCRYPTO_PK_ALGO_RSA,
> +    [GNUTLS_PK_DSA] = QCRYPTO_PK_ALGO_DSA,
> +    [GNUTLS_PK_ECDSA] = QCRYPTO_PK_ALGO_ECDSA,
> +    [GNUTLS_PK_RSA_OAEP] = QCRYPTO_PK_ALGO_RSA_OAEP,
> +    [GNUTLS_PK_EDDSA_ED25519] = QCRYPTO_PK_ALGO_ED25519,
> +    [GNUTLS_PK_EDDSA_ED448] = QCRYPTO_PK_ALGO_ED448,
> +};
> +
> +static const int qcrypto_to_gnutls_keyid_flags_map[] = {
> +    [QCRYPTO_HASH_ALGO_MD5] = -1,
> +    [QCRYPTO_HASH_ALGO_SHA1] = GNUTLS_KEYID_USE_SHA1,
> +    [QCRYPTO_HASH_ALGO_SHA224] = -1,
> +    [QCRYPTO_HASH_ALGO_SHA256] = GNUTLS_KEYID_USE_SHA256,
> +    [QCRYPTO_HASH_ALGO_SHA384] = -1,
> +    [QCRYPTO_HASH_ALGO_SHA512] = GNUTLS_KEYID_USE_SHA512,
> +    [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
> +};
> +
>   int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                         QCryptoHashAlgo alg,
>                                         uint8_t *result,
> @@ -121,6 +140,207 @@ cleanup:
>       return ret;
>   }
>   
> +int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    time_t now = time(0);

time() takes a pointer, so "time(NULL)" would be more appropriate here.

> +    time_t exp_time;
> +    time_t act_time;
> +
> +    if (now == ((time_t)-1)) {
> +        error_setg_errno(errp, errno, "Cannot get current time");
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
> +    exp_time = gnutls_x509_crt_get_expiration_time(crt);
> +    if (exp_time == ((time_t)-1)) {
> +        error_setg(errp, "Failed to get certificate expiration time");
> +        goto cleanup;
> +    }
> +    if (exp_time < now) {
> +        error_setg(errp, "The certificate has expired");
> +        goto cleanup;
> +    }
> +
> +    act_time = gnutls_x509_crt_get_activation_time(crt);
> +    if (act_time == ((time_t)-1)) {
> +        error_setg(errp, "Failed to get certificate activation time");
> +        goto cleanup;
> +    }
> +    if (act_time > now) {
> +        error_setg(errp, "The certificate is not yet active");
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
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
> +    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_pk_alg_map) || rc < 0) {
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
> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map) ||
> +        qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1) {
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
> +
> +static int qcrypto_x509_get_ecc_curve(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_ecc_curve_t curve_id;
> +    gnutls_datum_t x = {.data = NULL, .size = 0};
> +    gnutls_datum_t y = {.data = NULL, .size = 0};
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
> +    rc = gnutls_x509_crt_get_pk_ecc_raw(crt, &curve_id, &x, &y);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to get ECC public key curve: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    ret = curve_id;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_free(x.data);
> +    gnutls_free(y.data);
> +    return ret;
> +}
> +
> +int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
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
> +
>   #else /* ! CONFIG_GNUTLS */
>   
>   int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> @@ -142,4 +362,32 @@ int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
>       return -1;
>   }
>   
> +int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get certificate times");
> +    return -1;
> +}
> +
> +int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get public key algorithm");
> +    return -1;
> +}
> +
> +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoHashAlgo hash_alg,
> +                                 uint8_t **result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get key ID");
> +    return -1;
> +}
> +
> +int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to determine ecc curve");
> +    return -1;
> +}
> +
>   #endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index 91ae79fb03..f65be67a2c 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -13,6 +13,15 @@
>   
>   #include "crypto/hash.h"
>   
> +typedef enum {

Please add QCRYPTO_PK_ALGO_UNKNOWN here (or maybe rather 
QCRYPTO_PK_ALGO_INVALID ?)

> +    QCRYPTO_PK_ALGO_RSA,
> +    QCRYPTO_PK_ALGO_DSA,
> +    QCRYPTO_PK_ALGO_ECDSA,
> +    QCRYPTO_PK_ALGO_RSA_OAEP,
> +    QCRYPTO_PK_ALGO_ED25519,
> +    QCRYPTO_PK_ALGO_ED448,
> +} QCryptoPkAlgo;

  Thanks,
   Thomas


