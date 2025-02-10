Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11580C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWbv-0003qi-7g; Mon, 10 Feb 2025 11:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWbU-0003R8-31
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:25:53 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWbS-0003Lz-An
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:25:47 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa3e20952fso4972291a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204744; x=1739809544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F+vQb65w5ucPsNi4RtMwRQW6iibbdzn5OGI1L+G1blk=;
 b=iU9nqp/RIHLYetuYB1PHzQlEU8xxwF+WVlKT+GEns6mdrjV5ejp8HnpJpAdgVeib7p
 WC5eiOjY4uHNL+IJwJ4a9ZYQS2V3+smgo+UOleQDADfz9dcVC0naDORuke6ycBvzG4dp
 Je/6hJukIkxI5LfxK/0hEBAq06QAOvAkthAEuHjw7Zw6/BVlMhtNAxRiLmsuSdOmTeYY
 YPPBDXSeYNwSbAAd5psfLJE/btwQkFH+MTc5bmYihk8ljoIGqM19w8nua48Azb6LtCUt
 0z8lsqsFmol76o6TYsZr9AN8fapvUjXabMLhYd7VpjhAfARL9Sq5XxRlISjoVz/Zp8n6
 hYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204744; x=1739809544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+vQb65w5ucPsNi4RtMwRQW6iibbdzn5OGI1L+G1blk=;
 b=l3YCq3BKjcsnHfcB1uW9G5xBXOJv4Uw6Hn7cenZYodHe3CBx9Vxg1hQ0Wttx37zRpz
 Wpl0jYQvcYOuq9iYhHM3/5/5lQhF/3KVWP7UHZZax8L3I8+L1/5gRxMaYdtrUiNuznOD
 //Bro8KUvzQ6dykVOYo4bQjfhlwd1fnzn8bAF1/CmQm39zMttJ9XloENKJNGJIkxGlO2
 gLE4sn2Qp+YfpOnuhHgm9fcG5R4rTHGh1x0a3KUIwUCDrCJRQsvM5onVn1ipoNtNiOLW
 L3hMD3GuPUlPOnT+x7Xby5p8kuS0mz091O3qqo1uigFB1ZVjBWSKfzZBqc6Kmv2SU6r4
 hxNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrWJbJiflybtBhvvwWMOf3E6HrzEElqBZO+SaVG6BFGXXKoIZGHjqVhjMW/7xN2RcYpi1acx29ox4V@nongnu.org
X-Gm-Message-State: AOJu0YzDCIHnYLl+DG8R40xMZHrqqAJwWQoAqkt2X6mWjCZRPVnF3W6k
 M8M7HOobyWn/TaiU2/tArnj4yOYnprH1RgsPWAtIw42Nqr7V4r0mCOSRyI8zsAa83kDuHpOUkJV
 T
X-Gm-Gg: ASbGncvhKwNFxSjT4Wp8rLppYChBNrX1vRSGGFV6HovL3Q/Gz+oI273pJTyXxNWt+zq
 RzLqIQnn2AfAGG5rRvnSufABZOcKVCtG31fTdKE51z9W6JMZZVDUOIXfsK9Nnatlf0iUg0fgKEG
 yKiC19m1oGzbH7bu2OmzsTOZdbqUbsouv+r5aeVHEMf4kmoVD8vQkhjxt0NPPb9EXoOVgVsxY/b
 SX0KPMT4UI7vW1Co2y1y9LGAz/1IYn1I2vOmK+VVtWf6haxk8K4Hk5SbFq2PJuRuGKoneTcRFnj
 QAP5N6PzLkKURjq+6R+bBigHOlSPxL3CjaPZKPX6NMqoAhDGscr6p9E=
X-Google-Smtp-Source: AGHT+IFVVDpNpjJwV/Llc5Upus4s/BJ5T9kqzmzF+oqz1vFRFCriOkFiGQBppk2uc6VyY7D4S60vCg==
X-Received: by 2002:a17:90b:3e87:b0:2ee:c9b6:c267 with SMTP id
 98e67ed59e1d1-2fa2406679bmr23468169a91.9.1739204744329; 
 Mon, 10 Feb 2025 08:25:44 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3e83esm8897775a91.38.2025.02.10.08.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:25:44 -0800 (PST)
Message-ID: <649207a1-6f54-4fa4-a8f0-40ef3a6a2385@linaro.org>
Date: Mon, 10 Feb 2025 08:25:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/xtensa: Finalize config in
 xtensa_register_core()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20250210102604.34284-1-philmd@linaro.org>
 <20250210102604.34284-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210102604.34284-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 2/10/25 02:25, Philippe Mathieu-Daudé wrote:
> Only modify XtensaConfig within xtensa_register_core(),
> when the class is registered, not when it is initialized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   target/xtensa/helper.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index 2978c471c1f..c4735989714 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -173,9 +173,8 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
>   {
>       CPUClass *cc = CPU_CLASS(oc);
>       XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
> -    XtensaConfig *config = data;
> +    const XtensaConfig *config = data;
>   
> -    xtensa_finalize_config(config);
>       xcc->config = config;
>   
>       /*
> @@ -189,12 +188,15 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
>   
>   void xtensa_register_core(XtensaConfigList *node)
>   {
> +    XtensaConfig *config = g_memdup2(node->config, sizeof(config));

Why are you introducing a new copy?
Previously we finalized in place.


r~

>       TypeInfo type = {
>           .parent = TYPE_XTENSA_CPU,
>           .class_init = xtensa_core_class_init,
> -        .class_data = (void *)node->config,
> +        .class_data = config,
>       };
>   
> +    xtensa_finalize_config(config);
> +
>       node->next = xtensa_cores;
>       xtensa_cores = node;
>       type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);


