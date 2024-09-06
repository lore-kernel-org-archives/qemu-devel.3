Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D9FCE7B1D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaFy-00077G-JG; Fri, 06 Sep 2024 10:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smaFx-00076T-0S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:48:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smaFv-0000VQ-5F
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:48:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42c2e50ec13so16735165e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725634089; x=1726238889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gcZNcPexkcBoySjOqRROGeohrvWqNqmcuMeW6mDz/bg=;
 b=vBTmC36GAeXl674gggO/42/ONc7H+MTYzMs4ojS9DT/8O3WgO600b1+QnkffzlbZu9
 uKDy1yAozzuq0od6HsFW1QB1+GDjZrqCnwkyMrO02Zki6zNmO8qAZ03RCxz4UUI/B4F9
 ghZL3B1jGggYFKbpErUKkM1yvFWsfFEfPIKt7E8wcICMBUjS6I07b073KcRQdV2z+z0Z
 ACGvddoCio5rV4wnoT49GwVhfO5XhJ8olXGvX0IZ5t3Y3Ff/DlGIkE3pRL4mhosE3Qjn
 QGW+hl76b3dwzbdoUxxI1etKBr23WbcqQl8FPaSF9d572QUAqI05MzrNokZ5gkPGs6+O
 Xi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725634089; x=1726238889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gcZNcPexkcBoySjOqRROGeohrvWqNqmcuMeW6mDz/bg=;
 b=vxY+t3SQdcVF5BZHHIReFYIhpH7MdR9ZW5b8Yj5OyjOXqeYnIyynSMdxPYHuEog90F
 fvmmtl6jFDRFCBSkFzg0I+2rXYOgidGKSkcjO2xp3wPgIowJqKxnv+PG2S2VCAnnWQDc
 eNhyj59dn6AyfPMDoy6JGfmqHKPZrdpeNuneu3gBZI5j7WkQB2YleKfc5wyjR8bCTxuB
 YN0fvkweqOBFbwywaOiL9kOt5I3lrr7qz6JRdQoQ1kB6xzJ9hAev5lH6BZUAEgVD4fZO
 C9HB7S5Y4xaY2cdk30jFLySjDGSwv68UJ2bHgKAcmHyg92BAWkdMEZ3vTc2Nr/xFCCWq
 7sIA==
X-Gm-Message-State: AOJu0YyE0b+xfVvwrG1YE1mTG3pCuSj2i42zB4UApgqxwy6bjPtPtWiW
 1GGzpqzjroWGoxipfOJTat7EQ293UjHAqAkPNITLMLcgBiZ7zfiEOmSdv7OMxsM=
X-Google-Smtp-Source: AGHT+IEKtlXdi0Gmm15P+N7f6fmBmWyElRjMVRZDJx07qdoqt++o+hY3otUP5YzTRl4kfblYO3Cglg==
X-Received: by 2002:adf:ed0b:0:b0:374:c1c5:859e with SMTP id
 ffacd0b85a97d-3788967e478mr2024702f8f.42.1725634089171; 
 Fri, 06 Sep 2024 07:48:09 -0700 (PDT)
Received: from [192.168.254.175] (110.170.88.92.rev.sfr.net. [92.88.170.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789160d85asm89011f8f.34.2024.09.06.07.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 07:48:08 -0700 (PDT)
Message-ID: <fbba1d59-1f06-4bfc-944a-ce76499c4de3@linaro.org>
Date: Fri, 6 Sep 2024 16:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] crypto: Introduce x509 utils
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
 <20240905195735.16911-4-dorjoychy111@gmail.com> <ZtsImlL43_dzUTp9@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZtsImlL43_dzUTp9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 15:50, Daniel P. Berrangé wrote:
> On Fri, Sep 06, 2024 at 01:57:30AM +0600, Dorjoy Chowdhury wrote:
>> An utility function for getting fingerprint from X.509 certificate
>> has been introduced. Implementation only provided using gnutls.
>>
>> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>> ---
>>   crypto/meson.build          |  4 ++
>>   crypto/x509-utils.c         | 75 +++++++++++++++++++++++++++++++++++++
>>   include/crypto/x509-utils.h | 22 +++++++++++
>>   3 files changed, 101 insertions(+)
>>   create mode 100644 crypto/x509-utils.c
>>   create mode 100644 include/crypto/x509-utils.h
> 
> 
>> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>> +                                      QCryptoHashAlgorithm alg,
>> +                                      uint8_t *result,
>> +                                      size_t *resultlen,
>> +                                      Error **errp)
>> +{
>> +    int ret;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +
>> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>> +        error_setg(errp, "Unknown hash algorithm");
>> +        return -1;
>> +    }
>> +
>> +    if (result == NULL) {
>> +        error_setg(errp, "No valid buffer given");
>> +        return -1;
>> +    }
>> +
>> +    gnutls_x509_crt_init(&crt);
>> +
>> +    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
>> +        error_setg(errp, "Failed to import certificate");
>> +        goto cleanup;
>> +    }
>> +
>> +    ret = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
>> +    if (*resultlen < ret) {
>> +        error_setg(errp,
>> +                   "Result buffer size %zu is smaller than hash %d",
>> +                   *resultlen, ret);
>> +        goto cleanup;
>> +    }
>> +
>> +    if (gnutls_x509_crt_get_fingerprint(crt,
>> +                                        qcrypto_to_gnutls_hash_alg_map[alg],
>> +                                        result, resultlen) != 0) {
>> +        error_setg(errp, "Failed to get fingerprint from certificate");
>> +        goto cleanup;
>> +    }
>> +
>> +    return 0;
>> +
>> + cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return -1;
>> +}
> 
> This fails to call gnutls_x509_crt_deinit in the success path.
> 
> I'm going to squash in the following change:
> 
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 593eb8968b..6e157af76b 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -31,7 +31,8 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                         size_t *resultlen,
>                                         Error **errp)
>   {
> -    int ret;
> +    int ret = -1;
> +    int hlen;
>       gnutls_x509_crt_t crt;
>       gnutls_datum_t datum = {.data = cert, .size = size};
>   
> @@ -52,11 +53,11 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>           goto cleanup;
>       }
>   
> -    ret = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> -    if (*resultlen < ret) {
> +    hlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> +    if (*resultlen < hlen) {
>           error_setg(errp,
>                      "Result buffer size %zu is smaller than hash %d",
> -                   *resultlen, ret);
> +                   *resultlen, hlen);
>           goto cleanup;
>       }
>   
> @@ -67,9 +68,9 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>           goto cleanup;
>       }
>   
> -    return 0;
> +    ret = 0;
>   
>    cleanup:
>       gnutls_x509_crt_deinit(crt);
> -    return -1;
> +    return ret;
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


