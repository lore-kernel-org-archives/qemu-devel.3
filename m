Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED6CD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 07:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veqIL-0003cU-SU; Sun, 11 Jan 2026 02:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veqIE-0003UY-8A
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:55:22 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veqIC-00049Q-Pw
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:55:21 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso878848b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 23:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768118119; x=1768722919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xekyq0V/RxuIv0JdZwJ/jdXRO4YRJVI6B0V3IRqiQpU=;
 b=Ex2tfmVMUyWGRMpjg8+mIAAbNJcKurJfF16ErDsJW9GkVibnIHSR8jtTnuMgxWkoAi
 5ZaSGhpHSiYXEW6yVdc2l+8kiDTn6ExmwS30W73xg9YRl6R6JtWl6VPdozWMOodB5s7R
 irPUQPrNHlnTMrYGIPmrPrPwhlOexYQcI5f4kM0XjlnLixsoVjkARMI6efJpJs8eVeRq
 ZfXUXaqGPOp7CmN1+74W2M2wCik9I8KOJQW4BMAIOahap8Azfc6+pRmAGcv+zwEu0Y3/
 9MdqdRx19/Fdo7IhxGeqNSiWQymn3oHRpkfh/JlPb/bQ/0LPhXOIJ00CTf4ObpG9CsU4
 xZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768118119; x=1768722919;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xekyq0V/RxuIv0JdZwJ/jdXRO4YRJVI6B0V3IRqiQpU=;
 b=toMno8A9NqaGfGrVUt4+0Wp7eRy9Cxoxslov4fe+gw1cNakvZQ0zHFMUyU1C5jaYIo
 QIjeoYV1C6aCA60EhnIOS2bWwByV/FRuedCRdaBdJSWLkNcbb7JHhYQ9qEvjwY6WkYw6
 gH3VWsNoeO7yaJ0XkGguviNqVGOQbX97HEMYx8QHQx2ZEJp6gR4Fz8KMxKlBugW9JE1m
 +RI137wTMVE21Z2V0mbLlIkIPztELmEuJmDQylZA4gyDvze83ckxw6+YQxGYiJ6wQil8
 0nmFKDLZA6e+ytZD1IJm+Rgcf2rL2oIYUi2COrQDIw3pE0VvBYJ4Q5EBXYWxtMYN52sA
 8rZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcvv5OzB23AZM5CrR7l4KpLZpol9luzznXCipI8mAy63KweaI/6uKoHhxslaTH3nY5oxJppQZADdql@nongnu.org
X-Gm-Message-State: AOJu0Ywt4TCg5Qr8Ohf0NBqlvvMQy20U9QUMFnL9LWckOUNSnWgsa23Y
 dqowx83bDVZsBz/Hz4BkI93qZUU4QBTRN3cd5a1IP6jGfM8yAOJYdfbMNlMx7vZ4llc=
X-Gm-Gg: AY/fxX44tfLZ3s/Cvw22KNxzICEOUdWL5DM5xWd5RHMixjegFq2Fejk02E8gLI8VdF3
 k0BkVooZOBUu3XSX7jq9k0sP114FeGorF+nO0x2TIEGwhg3TWU5gDXLM2h6ILCbv8LsgU24NrK6
 ZJ8YIEZlD6SXuHBZUajrHgkyuZEsc7bK0314iWzVb0jqov1eWeVEys6Vg6DzbNkmmuubS2nbMe8
 9jYrJZoG3kOLSyUViq79jEf0Y3oE98kp83ZwTp618/1joblI96uHIhvgCI0VqVk1CZ0XZxt62Tb
 d8APjdFicdMxmPY1yVm1nLowbR6iGC+dcMiSeMR/jfXY+EajbwvCN65b8xxBGtvnuujgzNvNCS6
 QKVJVMd+u7VYA7luLaZZdis7kiG4l91gA9lXun/lQk0qsoIyYa3UvE4mCE1bHN5CX0lzArXWEyO
 IBEb05HRGC2O9lO81Yl2mCVPfvtqTECMnLmxV9
X-Google-Smtp-Source: AGHT+IEPBTPwQvuA8KlWnwa6m/062v7f+ete2XGydmKIKw7WpOZA95KX1XhnVlOHGB7j9HBsSKsNiQ==
X-Received: by 2002:a05:6a00:4143:b0:81f:4dff:336 with SMTP id
 d2e1a72fcca58-81f4dff08acmr1200552b3a.52.1768118119258; 
 Sat, 10 Jan 2026 23:55:19 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81efe4a95c7sm4290857b3a.37.2026.01.10.23.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 23:55:18 -0800 (PST)
Message-ID: <27914378-6d4d-41c9-98be-3a860f4964a5@linaro.org>
Date: Sun, 11 Jan 2026 18:55:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/12] target/m68k: drop cpu_reset on realizefn
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108143423.1378674-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 1/9/26 01:34, Alex Bennée wrote:
> Now all the m68k machines have cpu reset handlers we can drop this
> extra case here.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/m68k/cpu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index f1b673119d6..a540a754969 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -392,7 +392,6 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>       m68k_cpu_init_gdb(cpu);
>   
> -    cpu_reset(cs);
>       qemu_init_vcpu(cs);
>   
>       mcc->parent_realize(dev, errp);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

