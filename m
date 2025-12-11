Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09602D41D56
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiIM-0006FR-OK; Thu, 11 Dec 2025 10:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiIH-0006EG-97
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:09:28 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiIF-00007c-Je
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:09:25 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e80c483a13so103215fac.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765465761; x=1766070561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aNuLwcdDA39rMxdwv29H0zqBdMPOsk+Gv+J0nRsSfJ4=;
 b=OHlvJJNMuVigXQNDODKuPozmF79Qmd6ItB32umXrfQT0MXa+MBIuqP9jZpln+qgOcX
 XCABvVfJ6Ox1uutG3t3zUsZVANgSinhhQnt2YkX3Qb1YJHVU+2/Ne/lKmNFrfo0kAdBC
 ccPvWRQtXDGjN5JQy7mKLXJgpygIlqzlej5Vy8dBmuG5Bswcv21bOAsreo92gqXV/2oi
 R01xaWal/NhpOnQqGcYE6YLvoBC1dAly9ny+34GX0pSos2aC+LT+MVRn/SV2a10wOgqg
 pRcBImxSGBqT7dKv182YzHnlyfRbs0xPS+KL2gXBU3B6RInC19/e1nb5B9L1XerQqT6S
 ohmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765465761; x=1766070561;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aNuLwcdDA39rMxdwv29H0zqBdMPOsk+Gv+J0nRsSfJ4=;
 b=mF2kJW0zC5behcG9ZJoieVt5dhoCKYfxlpFRebnSFTv09xqr3c6NjZ3c60lvrRfxcU
 GW+APcV60Z5HLDvSSWH9SCWbucQs+Deik3MuN8xwXn61O7bkaCOoRbpiruyNmWFv6ANw
 WSy1x6ShvtwpikZB3VnkuNXuxoIg1EpYHL/0IZZGXeXW4h2aTGWpVEPN5KSS6bVxjF4K
 146rmKVYmbp54G+ikZf42lDo6xY6fdJEdY3kS96dlfvixSGtnzYDCvQBqDMGwt8q6tHv
 oHFYIPN3hTuNJ7uJG6JWRewFzs69tICI95hSZtVH65LHJxln/uUYb2HqVcVLrWepVyyS
 QrMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh95MX+OntY70aIOaiB/AAnRyNliK3W3y4iFFSXSCUsB5F3IMHa/WEqi9NM0+AQj0NYtZey9GeLe1V@nongnu.org
X-Gm-Message-State: AOJu0YzgahTbZO1/z6U9YcZCtij2qo/0y8mKAZaXcVjctx7KoKr9S0Ar
 IxI4kPrqjm99FNSIQGQQrOCp4ynlK2iW6Bmkrs0NEkihFOEVwje6/YsNAwQBLBXMyUI=
X-Gm-Gg: AY/fxX4cmd72fpC16UeuYOJLj9I8AxFdczKHj9xLdcYDUqz0i/p6pcOMZ/q7Vp/x0pj
 zKs+riGD3mjaQMt5SFG5kjHqwfdAZ8+wTR6ineYk32E61gVDW76PZrPXJ7QFd2GGd2tGxapxPjA
 U3aixqvVPb4jCOfSuZW5j/hD8YEc9nOOVJ2Zcqkigh1AVCZeF0LPZvYpVCvi0KK3J1+y7JLUb4j
 tUJg5GbtepC2EEmGruqjvdfDO4Ch1JV4q/CRl1LAlaGv9gislBTWJwvmXMTy6UqKcj0lTY+n09Z
 wV4hQYMNrV2SB49H+QW5M1jzBjxQ6evxa9DYx/4tiVL/MlWKOJ+lIS5mECyxbB4eKZg+SeZ8vUM
 KQQW5UtOr6MfcQcED1T2pPEHl3gsVkxQYUlwIUycRnKvp5Ic0DKLXg6bkjPl1u4Tcm+5yQUBvxD
 5UmAmo7qieOYKs6bF0gS3/ru4oi5nt5mgK6ayE8/NyIaHRx3aS7s9WUJ9Ppxsvr+IK
X-Google-Smtp-Source: AGHT+IFdKNVAjLJy300bSmBPGzmuzxgYFZwrGCrurIuRGBjCgzAp5IlTTYCb0SK201zDY0p/vA0rrw==
X-Received: by 2002:a05:6870:d629:b0:3ec:5e8e:87fc with SMTP id
 586e51a60fabf-3f5bdda0e5amr3771549fac.31.1765465761441; 
 Thu, 11 Dec 2025 07:09:21 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e81697sm1867224fac.8.2025.12.11.07.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:09:21 -0800 (PST)
Message-ID: <ae2c9404-59b7-4b51-b22d-5a3947211917@linaro.org>
Date: Thu, 11 Dec 2025 09:09:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] target/alpha: Introduce alpha_phys_addr_space_bits()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
 <20251209-phys_addr-v1-1-c387f3e72d77@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251209-phys_addr-v1-1-c387f3e72d77@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 12/9/25 07:56, Anton Johansson wrote:
> In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, add a
> a runtime function to correctly represent the size of the physical
> address space for EV4-6 based on the current CPU version.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   linux-user/alpha/target_proc.h |  2 +-
>   target/alpha/cpu.h             |  1 +
>   target/alpha/helper.c          | 18 ++++++++++++++++++
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
> index da437ee0e5..bcdd1e343c 100644
> --- a/linux-user/alpha/target_proc.h
> +++ b/linux-user/alpha/target_proc.h
> @@ -57,7 +57,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
>               "L1 Dcache\t\t: n/a\n"
>               "L2 cache\t\t: n/a\n"
>               "L3 cache\t\t: n/a\n",
> -            model, TARGET_PAGE_SIZE, TARGET_PHYS_ADDR_SPACE_BITS,
> +            model, TARGET_PAGE_SIZE, alpha_phys_addr_space_bits(cpu_env),
>               max_cpus, num_cpus, cpu_mask);
>   
>       return 0;
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 45944e46b5..9ee8d93b72 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -286,6 +286,7 @@ bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>   hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   #endif /* !CONFIG_USER_ONLY */
>   void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
> +uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env);
>   int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>   int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>   
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index a9af52a928..0f0cf73bf3 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -523,6 +523,24 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       qemu_fprintf(f, "\n");
>   }
>   
> +uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env)
> +{
> +    switch (env->implver) {
> +    case IMPLVER_2106x:
> +        /* EV4 */
> +        return 34;
> +    case IMPLVER_21164:
> +        /* EV5 */
> +        return 40;
> +    case IMPLVER_21264:
> +    case IMPLVER_21364:
> +        /* EV6 and EV7*/
> +        return 44;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>   /* This should only be called from translate, via gen_excp.
>      We expect that ENV->PC has already been updated.  */
>   G_NORETURN void helper_excp(CPUAlphaState *env, int excp, int error)
> 

This could just as well be a static function within linux-user/alpha/target_proc.h.


r~

