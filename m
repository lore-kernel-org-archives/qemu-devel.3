Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F4AC44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmdq-0006Ah-Tn; Thu, 09 Jul 2026 07:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmdp-0006A5-AG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:10:05 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmdn-0007CK-Qg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:10:05 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6649ffb1d01so2446054d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783595402; cv=none;
 d=google.com; s=arc-20260327;
 b=HAEOf7ooXzuWYuBeVdxdVlNIGHpgqQd+3phqpVMFGnTHaBJuVOZljA8RS24Qk0IARB
 O+h6MtFCSdpBranvY6zq0JFq0uwoTtNOc0b6gswqstklQ5k63znCbKLe1olFNOPBfZf8
 xnJMMT8bU61bCUZEoxFe29jS0GPodKnkzqQv6Itw4tWP2XasH7IKPDXhRiu+3rMEx95r
 k0+q0bewBE7KjAGDY0oi1YA6tdcPSLMldyWoOKRu6jyVLq48Ab6QVr+FSStzjyBnSsSc
 8wNj152LAyY8efLCxhvmHw2/gUZb1NxLsyqdr+KS0mMG8FCuUq4EXzasQTx92j+5KJKA
 vooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2cy4r1aLv3+SqsukA9CdP+qIivEgu2ttcn+KdatcOc8=;
 fh=Dy1bgM184w64VKBZfi1MicQwwMoaarsxjmPDS1/K5Sc=;
 b=cuG6g9zp+LNIKaHatVtz51Aad1VGu98LaZCzfXlipqukmn82uQ5gWEPG/JKRWoLn5a
 2lzlLhYmxWl/ELearyuoztlK7OATpi526YvxyBqcsBmz1Rm4BojjRrTH9usfb7SSmV/Z
 UgQx2j62PXSiFn3/fUcRB28hJ2iFRCQbihJHWDLXnz5CHkBpGE5szPbJsS2YA9OzdRh/
 oJs5J6VgVBNenChr8Ueu8xEMvy/Zfeyt22YaEdFOf9czoUFInkAe14yH3cou+VLQldXO
 btwDMYJgA72L4IpZNLlwGPKps1m5qH9jx2fiYGn4obcE4zHciwWJwyIrAyQ9LetXfLac
 OaYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783595402; x=1784200202; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2cy4r1aLv3+SqsukA9CdP+qIivEgu2ttcn+KdatcOc8=;
 b=zgli7USEF6oM62iEB7pRKS1LtgfS+2G2h93RjinuInQBhLfhObUuwwQJznYhqxauLF
 Gpz6mRnF3S78lF7IbWg5QMREFagjVAVW1YMNHpC9dFgMw+M/k364FNZ7l3dZbdIQmLjY
 y4zzQv206W4iO13VEwjlXm0vFm/cl0Jkr4gqSVXr8oQ9igC1FGNSkHvcLv/mJ6DkShm+
 wAs2nVeQ5EiS/ZO9QGuxpFxTNGfJyueIPzx5mV0eLlix5VeImvrpJDbt1XF/xFR3lXsC
 ltM7qfBnynV+lipwQT1g+yc7JYiPBW7jfdhPiJ1GuV0kqEPfXXId3ue9jCUJd0gx73sb
 7S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783595402; x=1784200202;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2cy4r1aLv3+SqsukA9CdP+qIivEgu2ttcn+KdatcOc8=;
 b=Ub8KZzmQNPD9vDVLY4wk1PNXicwFwu6kV6gQXgVgJF1nIp4pbjcO3w5LSE3Ods8aFo
 o/drF+1eXUfpdW7nYc4YSY+lon0n8pIx8b+9uG7lqBF1YPRldCrwoIMbK5xN7QUbWdSe
 SCw7IU6oqD6rUMmhlt+awmk7Aca/dJ6fLR+xa9bi/FFR2dNBh9vPswONKSRxicgnvnD0
 7m+nEd5aB6iVHfQNnbPibcSVT0CBv4fIZwwxHQCQdJL4nrPOhcVIT8jZfLm/abjUsEvy
 57W1+CQKR8e7v3BxsuG8PPhpGT0jAYBNlfgH3nSGJD0FXMDC3OEsKMoWDc2cOFT2ZQ1o
 XGSw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5YrFn8wkGASqIx4Otpshs2vPEnHMa6IQbUYMAKlJ5F6LKlAaL412U0wXPghzeuYNjsW3HGtb8oYRA@nongnu.org
X-Gm-Message-State: AOJu0YyKv5NroisaorhuwOCXcxIvpZrCslkcT2tHlDB1GYV3PSZM1P4R
 v6NQbccNfJVXTefCNd33APiJdqWgC4/hoL9cFzAzCAsYZB/ayh51Cn7qo/Y/KcmKlF8C+lWztNm
 Mb+uVR/uY68pptNR8GOf4JXvQaXFMIMrRBLkIhjRtUA==
X-Gm-Gg: AfdE7ckIglmEJWFumkKuqfiDfNx35k98KLlk8s6m3aW3FCNs0x0vpUBrOHHMSKUXQGy
 4J2BytUAjx3NlEzeeSA1NSG2cfBJqp8yS8/5vr5rwIQX/0a8Fbs5I9zYD5eEyy6jQJZ3XS5mLp0
 Qjf7PgksHjI0ZrsNM32SQsQSzW8RZNlSq8npuMqxSlkq8TXl64fz2lq5nGQNYE5+278qBIXg3Wf
 S0N4Qj9qzJKTG9dPVIxI3tmOD/J2qR8meYPQRCIhJjqlGd70NlunI2RRGXe3edeYBLkhZeAuZRu
 hxy9FA63vf/GmTz89uQizWQhC7jlqBiY10uTAbgR6Bm7MjWIqAyyAE9p
X-Received: by 2002:a05:690e:c4f:b0:664:b514:a086 with SMTP id
 956f58d0204a3-6679f140856mr5029775d50.52.1783595402209; Thu, 09 Jul 2026
 04:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
 <20260706230056.1888992-2-titusr@google.com>
In-Reply-To: <20260706230056.1888992-2-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:09:50 +0100
X-Gm-Features: AUfX_myERs1L9279KhurrylH9bbHwFfzyNfR2pwyiBgR0pjJvzaW3aewwEEuWT0
Message-ID: <CAFEAcA9kmrEFCiWLfL1FSLv7W34hSqvFaY7=BpcT+h-WnpKC_Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] osdep: add DIV_ROUND_CLOSEST
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 7 Jul 2026 at 00:01, Titus Rwantare <titusr@google.com> wrote:
>
> This is taken from linux/include/uapi/linux/const.h to match the driver
> behaviour when reading sensor values.
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  include/qemu/osdep.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1ec5b42230..a6a40ab8df 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -522,6 +522,20 @@ void QEMU_ERROR("code path is reachable")
>  #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>  #endif
>
> +#ifndef DIV_ROUND_CLOSEST
> +#define DIV_ROUND_CLOSEST(n, d) \
> +({ \
> +    typeof(n) __n = n; \
> +    typeof(d) __d = d; \
> +    (((typeof(n))-1) > 0 || \
> +     ((typeof(d))-1) > 0 || \
> +     (((__n) > 0) == ((__d) > 0))) ? \
> +        (((__n) + ((__d) / 2)) / (__d)) : \
> +        (((__n) - ((__d) / 2)) / (__d)); \
> +})
> +#endif

Can we also have the comment from the kernel header that
tells us what it does, please?

/*
 * Divide positive or negative dividend by positive or negative divisor
 * and round to closest integer. Result is undefined for negative
 * divisors if the dividend variable type is unsigned and for negative
 * dividends if the divisor variable type is unsigned.
 */

-- PMM

