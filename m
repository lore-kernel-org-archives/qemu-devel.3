Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF7FCFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sywLk-0006u4-TR; Thu, 10 Oct 2024 12:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sywLK-0006sh-KS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:48:58 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sywLI-0008Ae-2w
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:48:50 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so1638789a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728578925; x=1729183725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dx8LRZ6j50gd0TOpBMtXfdA3hs01aeUMPC+WO9ZDUdM=;
 b=jI9V1K39DoCf4zXoD9/KmO4TCYbbyP2cppt/u2OnbaxwGNndfFiSoyVPDA3MnAibD/
 w3FNyXCvJVDp5pYK7NupRaAeG/wNKUEb4i6ra28YFxVBd2jVS9LnXiWEOeonvpMkvYRJ
 LZEsi6OYO4C3hD9drfh1xsMRitcD/ZJ7W9i9ceV854SOOQ195a7d0tVvOe2oQCu/v5lG
 CTLlEQKiMlKVI8zSnqF0ZoxVS47+ZNU7zFzpXnIPxrVhn06qRJAwY5eIVCz5bMHR7AVz
 ZLsp7mEd9GKpNQIRvv6HmDOfwmG052CBacnsS9k5NIgULjFVGojZjPmXyEj2BLsP34s6
 upaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728578925; x=1729183725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dx8LRZ6j50gd0TOpBMtXfdA3hs01aeUMPC+WO9ZDUdM=;
 b=HS/nfirJFCSDYtzR1+g/fzPRPzfQ3QlhJ1L76gBGwTIqx97Jy0muJOG2PuZMUoqmzX
 yv8MnrIN+1iI9plpmL/kLTIpnRNwWulcbcjmXHAJ0D9Qbr1H0KRUurkrOq+2vI6mBUza
 zxNJGJSTiZ/kPpt984FGxOkvjXBHYnYAYJzxHB2CeDdZNfHCILC1uxF439d6YKu4Wgh9
 +V8u6oy/p7ErLWXQm8xPr9ns/gxdz6d4N7uHlcnXXDTwnkBA4U77KvZxQAcLxUMJmvjj
 Ap+PQOoy8rrxeJEdZHACl9mvfuOiH2kxxH1rCr+JhNmPvaFJ6aqgOEQGemO6O+E80av+
 PZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0UGefWJXqybZLk5yzQiXm4xmpbHbH245/xmlv4BocWOm0E5W122LFkpzR28zVkgVI4ReP5ZgvGr+E@nongnu.org
X-Gm-Message-State: AOJu0Yy/ItVKB8NCZYueQnoZMjsZ0Edd0MdqYyp8ZGVFbuM7Lq+922T6
 1Xhd2skvYPrOo6xyxnw2pk99EIotY9GS+fBruYjsunUPeLYJfB0KxD9ghHpRzFI=
X-Google-Smtp-Source: AGHT+IGvZiW7zbJ/sZTCCLbcBf9DB+1UT1kqH7HyyNOWR7HjHrOdkHaHSaVUO97qbKzrvKQZQQwdwg==
X-Received: by 2002:a17:902:e543:b0:206:aa47:adc0 with SMTP id
 d9443c01a7336-20c804faed7mr64469285ad.24.1728578925369; 
 Thu, 10 Oct 2024 09:48:45 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c93c5927csm7111155ad.93.2024.10.10.09.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 09:48:44 -0700 (PDT)
Message-ID: <5f62b35e-2b43-4a95-a6bb-2d2a9b020fef@linaro.org>
Date: Thu, 10 Oct 2024 13:48:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/17] crypto: drop obsolete back compat logic for old
 nettle
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20241010162024.988284-1-berrange@redhat.com>
 <20241010162024.988284-17-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241010162024.988284-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 13:20, Daniel P. Berrangé wrote:
> The nettle 2.x series declared all the hash functions with 'int' for
> the data size. Since we dropped support for anything older than 3.4
> we can assume nettle is using 'size_t' and thus avoid the back compat
> looping logic.
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/hash-nettle.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> index 570ce8a645..3b847aa60e 100644
> --- a/crypto/hash-nettle.c
> +++ b/crypto/hash-nettle.c
> @@ -135,20 +135,9 @@ int qcrypto_nettle_hash_update(QCryptoHash *hash,
>       union qcrypto_hash_ctx *ctx = hash->opaque;
>   
>       for (int i = 0; i < niov; i++) {
> -        /*
> -         * Some versions of nettle have functions
> -         * declared with 'int' instead of 'size_t'
> -         * so to be safe avoid writing more than
> -         * UINT_MAX bytes at a time
> -         */
> -        size_t len = iov[i].iov_len;
> -        uint8_t *base = iov[i].iov_base;
> -        while (len) {
> -            size_t shortlen = MIN(len, UINT_MAX);
> -            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
> -            len -= shortlen;
> -            base += len;
> -        }
> +        qcrypto_hash_alg_map[hash->alg].write(ctx,
> +                                              iov[i].iov_len,
> +                                              iov[i].iov_base);

Yay!


