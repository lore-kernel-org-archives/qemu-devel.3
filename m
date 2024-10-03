Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CF0CF34D3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUpg-0000xa-MJ; Thu, 03 Oct 2024 19:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUpf-0000xQ-6M
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:02:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUpd-0002EP-Gz
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:02:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-718f4fd89e5so1483679b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727996520; x=1728601320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tg0Pc4L9aTrL2GaSDCaVgrqx+ntS6Yu+5qvhc6yR++8=;
 b=F6SYywt8djlDibz50mX/NCqEX4M50KphWmydF5SIOqtUsNQ5WVDHODhKkb96No/eAY
 oDXjCSaWmXOUQ/QdldidDyuP7Qqu6T79EaK8KxBOV5ynkdXkLvtx1lGwFgCQGoVANW80
 3fFb1u60XrSFr6Xvkn1eOHwEXYH8JAoiC5vqSWQnCwzQzmE0YPfuE29h0XpRJBw/7rUX
 fOGS8WZK79HrXF2HoEl6Sx/wHhIXYSqLB8W/LvvZWgRdlNGMKRaEXZiBWI1BkMb6iNeI
 pg9/5YRBqPrFABy/PrAF7QOua+RtvzluDdMdyu4zpf07nIY9/jg33XxsbA1PFx9eKolL
 KQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727996520; x=1728601320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tg0Pc4L9aTrL2GaSDCaVgrqx+ntS6Yu+5qvhc6yR++8=;
 b=H2+8CIRiEwNeEAzFZtkdTHDW/YRs2TbqHEioMa11C6OnLGymEiFwr5TJTp86c1BTrd
 wU2UfYWITg6Hf8dSzdH0EeVYzYggyQs4/duZqU3AeIORNTPjsfC44uM+CgpFkAkrDOkD
 szo+reMJMpbsDPCBN80fgomXGm/353Folv9kcIfej1d2ol0sTQpDybxv4dHaBHSsaj6V
 oAWYpZTnABztEu0U6BZyKCFxPMQhBDxipzZLKdzuicHFb3de4HCIfrK8eyMbeUNtcmyu
 YABunl3JSUwtEBERYmYM7Pi8A+AYnSnel+zJBGTnUjxoYg3gF0veOB7k7p/SvHYJmC0i
 7J1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfn73iftY8vleh+fqCXpyGtgelEI+lVOdhZn91vGdQ1kE27vjGb4M6gpA3gANBrhukFPILUhd/A+Ma@nongnu.org
X-Gm-Message-State: AOJu0YwDogIbfUk8XXZQIGX5W8j8oSWYrK+hZmeT8+l8kcwyYQ6+SQFr
 X496RFlWd+VyoLYjm5YFPck1eJ6jKql+bL0B9XRDbgYojdq8YQ1GIa14uUHgttM=
X-Google-Smtp-Source: AGHT+IEMn3uK7U6M0ZktLa3icW4WJzyuEjVsS0iR64N4/tGLwbnAwRheHxMxm46Nt2Vwmo6I0U65EA==
X-Received: by 2002:a05:6a00:850:b0:717:8d81:e548 with SMTP id
 d2e1a72fcca58-71de239e806mr1158386b3a.1.1727996519837; 
 Thu, 03 Oct 2024 16:01:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9df50ecsm1917611b3a.181.2024.10.03.16.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 16:01:59 -0700 (PDT)
Message-ID: <dade7ca6-71d0-40f8-9431-5d3fb4685bc9@linaro.org>
Date: Thu, 3 Oct 2024 16:01:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] target/mips: Remove target-specific code in
 mips_cpu_reset_hold()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
References: <20240930091101.40591-1-philmd@linaro.org>
 <20240930091101.40591-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930091101.40591-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 9/30/24 02:11, Philippe Mathieu-Daudé wrote:
> Since all code creating vCPUs now set the 'cpu-big-endian' property,
> we can remove the target-specific #ifdef'ry in mips_cpu_reset_hold():
> the CP0C0_BE bit is set using the property cpu->is_big_endian value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 02e2e72f2d..9724e71a5e 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -202,9 +202,6 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
>       env->CP0_PRid = env->cpu_model->CP0_PRid;
>       env->CP0_Config0 = deposit32(env->cpu_model->CP0_Config0,
>                                    CP0C0_BE, 1, cpu->is_big_endian);
> -#if TARGET_BIG_ENDIAN
> -    env->CP0_Config0 |= (1 << CP0C0_BE);
> -#endif
>       env->CP0_Config1 = env->cpu_model->CP0_Config1;
>       env->CP0_Config2 = env->cpu_model->CP0_Config2;
>       env->CP0_Config3 = env->cpu_model->CP0_Config3;

I think this must be merged into patch 8, or patch 8 doesn't work.


r~

