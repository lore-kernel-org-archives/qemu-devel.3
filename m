Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5458ACF34D2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUnI-00009T-Q7; Thu, 03 Oct 2024 18:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUnH-00009G-7R
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:59:35 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUnF-0001nP-Nu
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:59:35 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e18aa9f06dso1132753a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727996372; x=1728601172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6fUjC/r1BiNPLkXVH5U7muy5GSG888GqF23jVBvV4N4=;
 b=wGbowRheobZip8nNOvQJuqt1y1FySJeCH2dT73he011HObRnwSwW+Pgd/R4vBaEtD7
 nCrgNjXh4NDGUBAf8foOI7ilTEtvbB9s2ARD3GQiEkVVpPhIAdQQ7liNth5Lpw5Vm3hR
 VpVbV583emRdKotQ6Hmyap7FUUccHplVovkwp3WGfL6BgeHL9FZ+WNwWkUs/v3sp1gMy
 ftg0rieW4bPWdxTHzwzE4A7Wh/n7p5W2lhCfkQOxsdoAxp0cHVTdhOZjUbM/jr0plvQS
 wlh3wCLj7nLk+7dTWYBAZYfqLlrVTrM3wLUfDhC2Av/IqjkAvQekutEPhV9jEbaH4JlU
 LRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727996372; x=1728601172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6fUjC/r1BiNPLkXVH5U7muy5GSG888GqF23jVBvV4N4=;
 b=cLBFfBUrE+Ze4viKLPRl6cf201Ct+ihdZl0nuSczNZnQ715vl1hOhpTCnqqXcn+a9g
 BcT+RDZGR/o+1dhDA4zHHsYE91jFp2ePP3YUJq5xmaGBkYgFV2grDtqHqoA2n8sdXRlQ
 q9d2LXeKyt4IEgXqlXsyFie/b3pqZF+Zq/v/hkGz4QwgiALTbu7c7eL7SXW5yibPfNLv
 RbhT9WKi+sMYOteRlyI9Z5dkqryjIfXvUaazoXUamI2qalqQ/Gmv1BjMNWUz/S3LMPc4
 Cf212SBO4OprQtC7NvVUCKQFU1SDwQ8tRtqINLe3zj62jwVd7jeHDJiWTvjKz0v2edtK
 wvNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjxLq7mpmfMK5T/kbb8xdkpFUNOzgqZgP/ZAPD12EKEp7cGu84i+TYkgzN5opeIcc2NqgvBGa0c9lP@nongnu.org
X-Gm-Message-State: AOJu0YxYgT1QdbEYLFfoVfh2Mu9tvf1xt7w4ck5PXWEvcFOx5Tqm51w3
 K0pHxTPYf7fGzXqDI+P9ZpzF+bnZe19w4Ppj1wWdOs3QBnDhjBgLLcb5XjZB3tk=
X-Google-Smtp-Source: AGHT+IHS7d2IgscbCCGD2qV6wnjgQawthRS/htZ5IbUeO7aVc6gxRAqGgqV4MA80GUGNO7/3o8GYGw==
X-Received: by 2002:a17:90a:4945:b0:2d8:7445:7ab2 with SMTP id
 98e67ed59e1d1-2e1e5dbc50amr835811a91.20.1727996372307; 
 Thu, 03 Oct 2024 15:59:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85d34desm57323a91.19.2024.10.03.15.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:59:31 -0700 (PDT)
Message-ID: <0a892c40-e8b0-437b-89cc-fe1127a330ef@linaro.org>
Date: Thu, 3 Oct 2024 15:59:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/mips: Expose MIPSCPU::is_big_endian property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
References: <20240930091101.40591-1-philmd@linaro.org>
 <20240930091101.40591-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930091101.40591-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 9/30/24 02:10, Philippe Mathieu-Daudé wrote:
> Add the "big-endian" property and set the CP0C0_BE bit in CP0_Config0.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.h | 3 +++
>   target/mips/cpu.c | 9 ++++++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 3e906a175a..070e11fe0d 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1209,6 +1209,9 @@ struct ArchCPU {
>   
>       Clock *clock;
>       Clock *count_div; /* Divider for CP0_Count clock */
> +
> +    /* Properties */
> +    bool is_big_endian;
>   };
>   
>   /**
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 89655b1900..982f5bb4e2 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -200,7 +200,8 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
>   
>       /* Reset registers to their default values */
>       env->CP0_PRid = env->cpu_model->CP0_PRid;
> -    env->CP0_Config0 = env->cpu_model->CP0_Config0;
> +    env->CP0_Config0 = deposit32(env->cpu_model->CP0_Config0,
> +                                 CP0C0_BE, 1, cpu->is_big_endian);
>   #if TARGET_BIG_ENDIAN
>       env->CP0_Config0 |= (1 << CP0C0_BE);
>   #endif

Missed removing this ifdef.


r~

