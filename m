Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D523BE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 17:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQrn7-0003ac-4h; Thu, 26 Dec 2024 12:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQrn5-0003a5-Jc
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 12:36:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQrn4-0004Gr-3S
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 12:36:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so70440795e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 09:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735234612; x=1735839412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6jDuuLJjvLq3B5zgsKAAfTUjIgVl2eSiRr5t3Z0qcEI=;
 b=zL5xl9313HipSBedIuXR5FkKkBH/WGqCPF5DrFndWzq8OCjqtzFKNoZzKpKGU5nI8H
 ivJFKaCYMm6beGGPcOg5ar4z1BRMKgLp8XlUFpTyWrKB+JvD9BEL/17PLlJW2g1mh058
 dCmQEGtn8MaG/j/QsMwKVAugmMUsJ4D8d0CKTknEbq0pHAz+0MBb9IblEx0hx5GKzlxm
 SDpBs1ijUYm9/Xzpzv/6jyLxJ1O3XG+CHPXtY5DkPc1Ocs2bP+8b2xD/CFzQ3eJsYxiv
 oyGq7flA0BOfcsN2B47rvZV9Zi10AAGUNIQzuRPfIH5qbeHlwdpA2BwWW6OfsWmkzILR
 xFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735234612; x=1735839412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jDuuLJjvLq3B5zgsKAAfTUjIgVl2eSiRr5t3Z0qcEI=;
 b=ZYH5iLxgorakxz2wGiJaQ6MeNpgo9nUcC0X/kyF/SIhnm0zNy7zhxw9vSSboExGAhe
 6mQV//awQzzsgiM+DG6CFqBJ9Yqcj8my/w4MtKwoIii9cuWaN8OyVQpo4HYOpm6HgIoF
 OUKU5SncffIrYYzeg/pj/gGVduEY8Yr911go6tjAJIu3Xd3xrOpBxmGe+X4tAnm911pN
 bkKNAc7jxRvvJsYstTVFcbVlYKDjVIw8anvQ/0aE2MW1WjRiFPN9voLEvkXoY68HeEH8
 z0cU2cHobQG6MJP2b5R7swE5gjZnmnrP++nRX3D4c2iB2u9Hh6p3fJSIusG9lva77yUj
 G+rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPQ4VWJmDZxELlYSYqbvLxsDIxyMq4BvQeUdl2KpKmPH4Y+tEFswt7jQwF/0yHyxbDXjD+VTW2eWJM@nongnu.org
X-Gm-Message-State: AOJu0YwEB3Ez5g2vlYho4o97+idy7wIi7ZyVl7Em8vShdBgLt9J3suao
 yvJsfDjZR0RKdTk9F4MsFaNTviisJ44rJ2PhoKgK0OVK235H3+/YAijIG3dDiKY=
X-Gm-Gg: ASbGncvIc2OqZ5g0QD5MNuuUaSXyfpNRY8QkyeVViPEak4a3DX363+JhB7ecjsEQX6V
 r3SPYHOsgfcTpOUpq9rBjmfw1KGUdeOOGs4mDwTcTxhjgrp+uhccSUJ/AyeTd8EYx8huMeOxnJy
 W0hg8Mm1NH62NpbsrP+Gcgi60Tb85i8j09Dv7bcnEufHEIoMmIk0iesSm7p8dELvznXzQSH5U5O
 pQIe1cXcVAlvwYaiYeS5ZMKk8oOAJ19nYkvStSZZYpQYfW0v5x2kZ5q0S2yInA1eaY3VwFd1A8B
 xz3h3IJ7VCRq5K8woiPqUq6zBOmHLUKoeg4Y
X-Google-Smtp-Source: AGHT+IHjdEqcn47UKDBYIRo2QUami9XzrYy7jYu4P05Rf0BC4n0Rm5ByNBThh2dNxtosabc+CsA+zQ==
X-Received: by 2002:a5d:6c64:0:b0:385:f6f4:f8e with SMTP id
 ffacd0b85a97d-38a223ff1cemr16935449f8f.50.1735234611869; 
 Thu, 26 Dec 2024 09:36:51 -0800 (PST)
Received: from [10.217.61.213] (180.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.180]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6ca5sm20440819f8f.86.2024.12.26.09.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 09:36:51 -0800 (PST)
Message-ID: <f16425be-46a1-4989-a7a2-9d7bb005d257@linaro.org>
Date: Thu, 26 Dec 2024 18:36:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: cast 1 to 1ULL
To: Tigran Sogomonian <tsogomonian@astralinux.ru>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20241226095815.15377-1-tsogomonian@astralinux.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241226095815.15377-1-tsogomonian@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 26/12/24 10:58, Tigran Sogomonian wrote:
> To prevent integer overflow it is worth casting 1 to 1ULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
> ---
>   hw/misc/mps2-fpgaio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
> index d07568248d..297cb1b602 100644
> --- a/hw/misc/mps2-fpgaio.c
> +++ b/hw/misc/mps2-fpgaio.c
> @@ -198,7 +198,7 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
>   
>               s->led0 = value & MAKE_64BIT_MASK(0, s->num_leds);
>               for (i = 0; i < s->num_leds; i++) {
> -                led_set_state(s->led[i], value & (1 << i));
> +                led_set_state(s->led[i], value & (1ULL << i));

Let's use extract64() and call it a day?

>               }
>           }
>           break;


