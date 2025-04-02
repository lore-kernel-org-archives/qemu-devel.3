Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA57C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 04:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzpSo-0008K2-8x; Wed, 02 Apr 2025 00:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzpSk-0008JW-9z
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:12:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzpSi-0007lQ-I4
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:12:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso47241665e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 21:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743567142; x=1744171942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UmfAKa47SZL4PKMK/dmI8//uTNLj7jfJ1CyM1dfSs1Q=;
 b=fqNU6dqlqc3kiBe/yNDeHrAhFDm3iUJRhnyUoLU/E1osc1MOx00Yj9vdPiomHo1gpy
 qhzHlFGY2D1IUV3S/6LehZfV6N1alx06jip9ujcOzSV/k2fh8obLregfALTAVNB5MH41
 M4aT2MKhWdovofM0yQVmIgI7hFGCP9wvERJ9Xh4ynT40/SDSYMgZT1yEkfFYgbxDERql
 E1PdE5BoRWjmNVIdOm1EXg3s8M3DXrrouLbptzuAiyGUv99Y7Uj3OPhU4Lh/bS+AQw+5
 0yazSSCYuYHHH5o6wZiNh2d1+gCs7VJJT0XUl8fq3VuKpMuQ8HaDWX3INgbq69O9nUh8
 Re2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743567142; x=1744171942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UmfAKa47SZL4PKMK/dmI8//uTNLj7jfJ1CyM1dfSs1Q=;
 b=XOpGBBlXMA4Fs2oREAFyli8vEpwlj7I30L0v0a9/haCr9R21fAwAjskPb6VN45oF7U
 eOs2/cKJ0EZ3yteh2JbDNGM4TwUUKEQFIPy9q210jWnIwntEqdKzQZqb//+ObTTAj/+b
 P4xIOdAlAymah+xqcAkK6c91E4Qnr9c5j7RA8JGx4kUq0radp0HDpwlfPmP5x6+axWSJ
 IN6Tr9KfT/2Z5KaBUNvpNub1Tsel54NRtm/sJXulJAfhlNEQWuV2jl7JJLCpqhkk7iz6
 gs12gn3k/FTVFwhiZGzWhsEsoZbBuVB9FWK4SzBiIPaE+d8nVf8Ic+dyu8K5V/R+0jyN
 OLqQ==
X-Gm-Message-State: AOJu0Yy2Ex2ynjgF5Nd5gHnJtnPl6gxgnq9VAEjHmQd1LhpBJqfItF20
 fcp1WYnFcxt/+LgUxaFJ6QPIjRXW7OR1oJECaf/qqqW/u8B5HO1umnZL1wLO6krtvHIxELHm8h9
 9
X-Gm-Gg: ASbGnctBfxndbDim8mvd7ZAVYiBmke9VsjpjKTtZB08d+gCXLuLCz2CjCB3J9YC+Ztw
 KJ194PlSr+mKNXX3198MLxER+AcB1twyDfddt7vjGgNoDhe2Bx01qlF1jtHD9BpWhlS0GS/pquC
 YOr53qkhU2MCNODZQQLP3dFeAbe0ygYhdQXCr5NFuWvE7JjBiqhhStbcC1DaAkilYQg1tfk+GB7
 FHRWhFTWE2qRoRzBW7JRtC6QwVsWi7rAT+jL8pQQ0U2KcCyGuMeOo/mbhXuqAiWLDWDOYj58VbV
 6Yu+5BrJfZc4BPaGd+ILv6/xWCzcZiqX502RSYDeLY6YSBJd2RyK8qKZ8CiMaA33RQ+sjyf94Vp
 f0A7kShIdF84Y
X-Google-Smtp-Source: AGHT+IE6LYT+T4wnlmzBzA8+CQk4NYVAKV0kC/lC7aDY+wixcQCKbwWMQUS8OlxPd8iwvZoLCkzsSQ==
X-Received: by 2002:a05:600c:3150:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-43db8526be1mr122886025e9.29.1743567142310; 
 Tue, 01 Apr 2025 21:12:22 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb60eb01dsm8042185e9.25.2025.04.01.21.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 21:12:21 -0700 (PDT)
Message-ID: <333d9e55-fc5e-43ef-a932-c1b8fd97b6b3@linaro.org>
Date: Wed, 2 Apr 2025 06:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] hw/arm/fsl-imx: Correct GPIO/GPT index in QOM tree
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Rob Herring <robh@kernel.org>, Antony Pavlov <antonynpavlov@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Beniamino Galvani <b.galvani@gmail.com>
References: <20230110164406.94366-1-philmd@linaro.org>
 <20230110164406.94366-14-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230110164406.94366-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/1/23 17:44, Philippe Mathieu-Daudé wrote:
> GPT and GPIO are numbered from #1.
> 
> Fixes: 757282ada8 ("i.MX: Add i.MX7 SOC.")
> Fixes: 31cbf933f0 ("i.MX: Add i.MX6UL SOC")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/fsl-imx6ul.c | 4 ++--
>   hw/arm/fsl-imx7.c   | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index d88d6cc1c5..568317117c 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -72,7 +72,7 @@ static void fsl_imx6ul_init(Object *obj)
>        * GPIOs 1 to 5

FWIW it is even  ^^^^^^ commented.

>        */
>       for (i = 0; i < FSL_IMX6UL_NUM_GPIOS; i++) {
> -        snprintf(name, NAME_SIZE, "gpio%d", i);
> +        snprintf(name, NAME_SIZE, "gpio%d", i + 1);
>           object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
>       }
>   
> @@ -80,7 +80,7 @@ static void fsl_imx6ul_init(Object *obj)
>        * GPT 1, 2

                ^^^^

>        */
>       for (i = 0; i < FSL_IMX6UL_NUM_GPTS; i++) {
> -        snprintf(name, NAME_SIZE, "gpt%d", i);
> +        snprintf(name, NAME_SIZE, "gpt%d", i + 1);
>           object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX6UL_GPT);
>       }
>   
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index afc7480799..6115677d43 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -52,7 +52,7 @@ static void fsl_imx7_init(Object *obj)
>        * GPIOs 1 to 7

                  ^^^^^^

>        */
>       for (i = 0; i < FSL_IMX7_NUM_GPIOS; i++) {
> -        snprintf(name, NAME_SIZE, "gpio%d", i);
> +        snprintf(name, NAME_SIZE, "gpio%d", i + 1);
>           object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
>       }
>   
> @@ -60,7 +60,7 @@ static void fsl_imx7_init(Object *obj)
>        * GPT1, 2, 3, 4

               ^^^^^^^^^^

>        */
>       for (i = 0; i < FSL_IMX7_NUM_GPTS; i++) {
> -        snprintf(name, NAME_SIZE, "gpt%d", i);
> +        snprintf(name, NAME_SIZE, "gpt%d", i + 1);
>           object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX7_GPT);
>       }
>   


