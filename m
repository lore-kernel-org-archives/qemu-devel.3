Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A239D2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KOo-0007yg-C7; Thu, 17 Oct 2024 02:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t1KOj-0007xh-Ko
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t1KOi-0000M3-4V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729148049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4TW1i1jC2YbrdTB34eQsH8JD9MkGiP3sfabqdeGSSXg=;
 b=CHzsMTxTB2Ce1GRQO7/CvVWfdFE0G4VtU+9S4CS9xLw98Tf5JEy1IMcgnNTRAMDoo1W1Js
 ZYAWytiXls34nBa4XtW8QdH3RZ1HxagqpqtqQ+bYbBKwVNMm4sjm++e74u9+menhL3Vgb0
 M4U1iGemICAHeZMIPHjnmMeW2XD9yUs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-5KDqmP6tPgK2IL07oRRHOg-1; Thu, 17 Oct 2024 02:54:08 -0400
X-MC-Unique: 5KDqmP6tPgK2IL07oRRHOg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso704325e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729148047; x=1729752847;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TW1i1jC2YbrdTB34eQsH8JD9MkGiP3sfabqdeGSSXg=;
 b=NW2K+2bTGvmLaxLiBszZgmiKv9w4viHNnYr89GbUhvrACeXYbUyCbcLcRUdZoVOrJF
 NZVDtSe2cHOyqZXoMA1wq7Iaxx5ZPYGKRcTyMNeiVpXtyUcGnRwAJ/PwJfL1N43Kh6gf
 ODwv/p0q3/I+JA6tT+vACoob6H/JCf0q4ecoNVMX/J9e5nbuC4lm+YoO8Vjk7j42WYgZ
 Qp+x8PIHpat0z2YscTueVo0gOaenVx0UO92x/1KT0L13j1cLpEJlIi4JcW9pakXpsZg2
 qesUQja+5F6HBRhlL4nQpMidXC0YySHwbZ05fNq42xzTg8FvRMcSawQSLb15R2knY0ly
 KPvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi1uXQSMzAvGEkQwwZA9egH8SwYgXTvwhq1B3Vn1CchP+knLaWC9AE2qwZvsN32DrfyrxU2cre0ICY@nongnu.org
X-Gm-Message-State: AOJu0Yy5oSj58Je3nZmH40yhfe8T7vmi1p4Krsqb1HMAlQMi8xbonn9C
 3Hza3HM/JwmCxXrRr0FDMEn9kO3f20lvvhXySAGAWC8JtudspcRND0RI7YBkUPkdj7Nla13fYXN
 JgQLdcX0efez5pjg3cy4a+shIayIgv6sW3BtFHTpROeTyZ0nA0EAF
X-Received: by 2002:a05:600c:3583:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-43152cc888fmr41334915e9.34.1729148046674; 
 Wed, 16 Oct 2024 23:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDnNAHzhZ7pWE2/qz7/KCATJ7cVoNkJ/3ubzc50aShD/G+C97m2ZslwadIo7xNbtsyAn7ahQ==
X-Received: by 2002:a05:600c:3583:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-43152cc888fmr41334775e9.34.1729148046190; 
 Wed, 16 Oct 2024 23:54:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc2e305sm6246577f8f.98.2024.10.16.23.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 23:54:05 -0700 (PDT)
Message-ID: <0a727cfe-af7c-4838-9336-2a6b2b555b8e@redhat.com>
Date: Thu, 17 Oct 2024 08:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/hash-afalg: Fix broken build
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alejandro.zeise@seagate.com, peter.maydell@linaro.org
References: <20241017064742.2770242-1-armbru@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241017064742.2770242-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/17/24 08:47, Markus Armbruster wrote:
> Fux build broken by semantic conflict with commit
> 8f525028bc6 (qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo).
> 
> Fixes: 90c3dc60735a (crypto/hash-afalg: Implement new hash API)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

My bad :/ Obviously, I didn't catch this at compile time, nor did CI.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   crypto/hash-afalg.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
> index 06e1e4699c..8c0ce5b520 100644
> --- a/crypto/hash-afalg.c
> +++ b/crypto/hash-afalg.c
> @@ -142,7 +142,7 @@ QCryptoHash *qcrypto_afalg_hash_new(QCryptoHashAlgo alg, Error **errp)
>   static
>   void qcrypto_afalg_hash_free(QCryptoHash *hash)
>   {
> -    QCryptoAFAlg *ctx = hash->opaque;
> +    QCryptoAFAlgo *ctx = hash->opaque;
>   
>       if (ctx) {
>           qcrypto_afalg_comm_free(ctx);
> @@ -159,7 +159,7 @@ void qcrypto_afalg_hash_free(QCryptoHash *hash)
>    * be provided to calculate the final hash.
>    */
>   static
> -int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
> +int qcrypto_afalg_send_to_kernel(QCryptoAFAlgo *afalg,
>                                    const struct iovec *iov,
>                                    size_t niov,
>                                    bool more_data,
> @@ -183,7 +183,7 @@ int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
>   }
>   
>   static
> -int qcrypto_afalg_recv_from_kernel(QCryptoAFAlg *afalg,
> +int qcrypto_afalg_recv_from_kernel(QCryptoAFAlgo *afalg,
>                                      QCryptoHashAlgo alg,
>                                      uint8_t **result,
>                                      size_t *result_len,
> @@ -222,7 +222,7 @@ int qcrypto_afalg_hash_update(QCryptoHash *hash,
>                                 size_t niov,
>                                 Error **errp)
>   {
> -    return qcrypto_afalg_send_to_kernel((QCryptoAFAlg *) hash->opaque,
> +    return qcrypto_afalg_send_to_kernel((QCryptoAFAlgo *) hash->opaque,
>                                           iov, niov, true, errp);
>   }
>   
> @@ -232,7 +232,7 @@ int qcrypto_afalg_hash_finalize(QCryptoHash *hash,
>                                    size_t *result_len,
>                                    Error **errp)
>   {
> -    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlg *) hash->opaque,
> +    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlgo *) hash->opaque,
>                                             hash->alg, result, result_len, errp);
>   }
>   


