Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B91CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvf7-0004jR-P9; Mon, 20 Oct 2025 15:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvf3-0004jD-7u
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:35:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvez-0006TT-BG
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:35:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so2977015e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760988910; x=1761593710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jaN2fVV1wsh0DwsQzB7r2Q/gBhx0XAbLVHodaWI+img=;
 b=xSpB9VckWPsZgvUwuVvli0i1dPm9CGbzjxnw9KofibQN3828T5l9nobXC1siM//4Zd
 r5Zq7mvMaLzrGOd2SJXndF6CMuRAU7euQwe1LBiFQcM31dW0/5Ijbu0zM0sAqy623LS+
 aPzfP4Y/bszEFEk+A2/1y6IXI/ZgljMa99f8PtWZKl6h41bHtvAxMQJNQCK6HvUAd/JN
 CA7ZNrpoqzMr8yNC1rpo7ZJ3RMs75wwCJeKsIv35264CmJxZNs2zyR8jbRx1zeJbOzTT
 KGU5Bz42C+r6dU6u+pBYHziZOTuE+zQwfRNQyOoBxMtAxwysatKYJ+uKMc1ESgNS9cij
 Jbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760988910; x=1761593710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jaN2fVV1wsh0DwsQzB7r2Q/gBhx0XAbLVHodaWI+img=;
 b=XaLAQpYpVCY3dh34BnzuqjXHfgCsBAO//jAYj+wQGaxq9zFVmKd9iRhBn6ck3E9q/O
 mmNCHWgkpkezu3MMvh1/8wTC4+P4M0fTyS2+HSqluM+syAjfstVcoPuclU8OA9KblkKj
 epUzFyoc0mGNiv0nfqsEXCwiW/VY1zlkAxzwGq9nb4riFG2QWRIu/1Q7980JmKFHyDJJ
 pWNoXGQTmDxF3ZScZbSv8nTEjUMvQdG1qQsT1TUvfSdD9wlsGsJRjml1tlJZ06wuhlce
 UnAVJfVH1hQROEjuY887UA0Zp/qenZOobK/OryWK72fNPi1XUc1Rn3XKkFGo9bfSBw/W
 2LgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9vPVLXJhe4x+kKyiT1EjA+7WA0J9Q/xh4m4wZ5Jwh1iWd4VFbdhItJrxcxDc/5idKmIaoTosRlBv6@nongnu.org
X-Gm-Message-State: AOJu0YxJASmwNu13Tz34G/8u2RUnXhH/9vRAZ6BAwFrL/ClEVf3Jw4WB
 OTbB7JSOC3qwKkjni1hvzm9McrYsvJLOG8d7KFFeePCQ2jrwc8VOM+ThC3RqNWPtcjA=
X-Gm-Gg: ASbGnctYJQaUjjQyOu3OSVoerbMWocNBieLM5cvnoqv9ZL6KxFW4w+7ZGru4drmdABk
 yI6i4dxFVv9aTlUiRdhgQymtX9K/nkiFEEubFHrTOQqOTZZbqhZvPy3RqawqLHnPknocVzTZjaK
 guKi/Wl7o9hY9SMzO+lXrO4m2nrr9vpBcAqVh3s0Iu3miCWpG5wPwnJLQO6FWcvA2WszP61gN1U
 0hxOBIXa0aXO6KU0gO1Bzz4KnXhTbFTnJb3HwvltpHEgxXhYO06pBXAt6ikV/+yXMXGSHeQvw/P
 SDHxLGfJ0stCaJmRsJq9SRVU9/j9lIxl/zTBq0cKVmgSiNW3pLcO6gQYmacIAyRI18qyHYPefT5
 jIA8S2Q2WYTf0/Y4XbqyzN/RqhbY/9gl2Phl48ybdF6DT3jY7npp51Fr18EkTWRkAHfpnvG1bIn
 92iIWnfbFH0p5xQIobzjjHud9786r3F8K0k5WZsCNwc4Y/h8gsvz7nYpoSUu5YwU+E
X-Google-Smtp-Source: AGHT+IEortQaRQqsnGFTLyF0O3CiUobcR15LVNL9FqvXtS25mKvOaAzLm6SfEfrmm6v967fQ2Sh9HA==
X-Received: by 2002:a05:600c:45c9:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-47117913764mr109385205e9.31.1760988910478; 
 Mon, 20 Oct 2025 12:35:10 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239bdsm293410415e9.3.2025.10.20.12.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 12:35:10 -0700 (PDT)
Message-ID: <74bd5f4d-c6a9-495d-8842-fe3432c892d7@linaro.org>
Date: Mon, 20 Oct 2025 21:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/7] vfio/migration: Add x-migration-load-config-after-iter
 VFIO property
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>
References: <20250715163703.243975-1-clg@redhat.com>
 <20250715163703.243975-7-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715163703.243975-7-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 15/7/25 18:37, Cédric Le Goater wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This property allows configuring whether to start the config load only
> after all iterables were loaded, during non-iterables loading phase.
> Such interlocking is required for ARM64 due to this platform VFIO
> dependency on interrupt controller being loaded first.
> 
> The property defaults to AUTO, which means ON for ARM, OFF for other
> platforms.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Link: https://lore.kernel.org/qemu-devel/0e03c60dbc91f9a9ba2516929574df605b7dfcb4.1752589295.git.maciej.szmigiero@oracle.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/devel/migration/vfio.rst     |  6 +++
>   hw/vfio/migration-multifd.h       |  3 ++
>   hw/vfio/vfio-helpers.h            |  2 +
>   hw/vfio/vfio-migration-internal.h |  1 +
>   include/hw/vfio/vfio-device.h     |  1 +
>   hw/core/machine.c                 |  1 +
>   hw/vfio/helpers.c                 | 17 +++++++
>   hw/vfio/migration-multifd.c       | 79 +++++++++++++++++++++++++++++++
>   hw/vfio/migration.c               | 10 +++-
>   hw/vfio/pci.c                     | 10 ++++
>   10 files changed, 129 insertions(+), 1 deletion(-)


> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 9a5f62154554e1df36545b8c315b9ae25534d0fb..23d13e5db5f2cb10d6914c81497494a98775a78b 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -209,3 +209,20 @@ retry:
>   
>       return info;
>   }
> +
> +bool vfio_arch_wants_loading_config_after_iter(void)
> +{
> +    /*
> +     * Starting the config load only after all iterables were loaded (during
> +     * non-iterables loading phase) is required for ARM64 due to this platform
> +     * VFIO dependency on interrupt controller being loaded first.
> +     *
> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
> +     * the right place in VFIO migration").
> +     */
> +#if defined(TARGET_ARM)

You mention ARM64 but uses the generic ARM definition, is that expected?

> +    return true;
> +#else
> +    return false;
> +#endif
> +}

