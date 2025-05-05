Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B098CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uByya-0004QZ-43; Mon, 05 May 2025 12:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uByyP-0004N7-3n
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:47:24 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uByyM-0001gk-8y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:47:20 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso767399166b.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746463636; x=1747068436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S4bVQBqy5WbVd5CKOxzKRJHSi3jSTIVWjAUu/SPA/1o=;
 b=rtp18yPDzejE27QpgbK0lzF3N//myeIb9hpj/Y5L0B8fQVACxaw8EwFm6+/ZSjVjRh
 PWKqCzPFX7dECMIMRuhxCUW88ngdEvH3Zj1UMiCH3qfCYEd5Mt0Ye+UbUIBjZRi63zrx
 BLZE7jNNG2eF3FtEK9MHxGE77rmCJnehseOlh6AI3qDgQLfGcj3mBYB7xLVI0+aWlbXY
 FQhIGhmVCAtkPBaqPoFW96yjX1xfWAdxXod/SqitaJyz7FORwvMQToBKyG0+cH2tZm98
 nbS6CrN6fS/LcoVB2G6JWaQn+RSRShIhywLNSmUe5csmtX7AdZ923wxskaafxI2rI/v7
 q2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463636; x=1747068436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S4bVQBqy5WbVd5CKOxzKRJHSi3jSTIVWjAUu/SPA/1o=;
 b=N6pjUF0ftOQGJuuAtLUHAONPxyeFsJ6cQMt1UnVT5/n+GyEMxAFEkcS8lu3+YCXx/g
 iB1VeADo73MqK2GD8b/rgd8aUBzOmGr6M9nHjvftk6MX7zGVHuCEBuV8Z4w3pYpcCNLA
 t0a3G/lvdFT0DmKvS3e3vZfLS1NhhcmoKTWNEkHzRb2kc3gB8dKWgZ62kCnNi0UjIgeq
 CZbJCwAJCmSppjMO5dnE280L8qvICYM2Z5bSiH7P9l64OIMmd/cr7Isw/b5HlJiaAT9Y
 gg9Y0skf2jcIzCWRBhogR4FsCHGd0ubGxRznTNnnMvVzwPCFw+g/zWlTUoN8i3NF0T3S
 tgEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIjPnLo4pejcmi6ls+GnLUJbJi931WrfIGukHp8Isuc/46qEoSyWUMlUwNvrfyxqB/RAdTetJHbDtZ@nongnu.org
X-Gm-Message-State: AOJu0YxtEI2B/IibN3orZa4AyeX8kq/CysnjA2u8JyPjKab0D10Fq08e
 wO7h3sFdoxAx+yOzF76g37Gk7IfBGkiojoNu/Idt2UCf8mvxxJdUvyOEWOezFxI=
X-Gm-Gg: ASbGncsuHKEDRzMRjad7DRh40U6gInuq5UsWqTDKcdWQ99plJP/q+KFDZBG04UNAgKU
 0qi6EJ6EYiYLvn2CfLFUWgo6RT4e2r4l9KrtvPusRwLrwts6tpcR0OrRpW1OvbdXtcOz+fXc8Gb
 CQYY655EgKCdtGpPC1UoL7ZwVGDhsrafiQO2ut3cNW4sfri7rf+SYFsP610ao4sHm/MtyYtQCcq
 I++4/Eh9xkTvyGHJ4Y8qPM2jaXoLDkdDrPomkIRyN+7TVQ0QHOAagYWHL6WsXC6+wyGav7gOoij
 8oVFezWIYIYDw8rLSgjt4AmOu1zyBd499FdtL4v186Nj5VpMe0433jKyR8DJ6lPAciv22AOn69b
 A+LfOG3Q4ZqA=
X-Google-Smtp-Source: AGHT+IEgypn/eACiUFAayFoR46H48HADz2u33jK26xI1eZrrPXV3Z+BUVXMOAeEX5AjN2Xqvw3rekg==
X-Received: by 2002:a17:906:6a24:b0:ace:c540:ffda with SMTP id
 a640c23a62f3a-ad1906a0036mr880040566b.26.1746463635918; 
 Mon, 05 May 2025 09:47:15 -0700 (PDT)
Received: from [10.194.152.213] (69.21.205.77.rev.sfr.net. [77.205.21.69])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c3853sm519939166b.94.2025.05.05.09.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:47:15 -0700 (PDT)
Message-ID: <e8db1ec3-fcb3-42d1-a488-cf55d6060904@linaro.org>
Date: Mon, 5 May 2025 18:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] target/riscv: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-riscv@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Check 32 vs 64-bit and pointer masking state.
> 
> Cc: qemu-riscv@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/tcg/tcg-cpu.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 55e00972b7..267186e5e3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -237,6 +237,31 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>       env->excp_uw2 = data[2];
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
> +                                vaddr result, vaddr base)
> +{
> +    CPURISCVState *env = cpu_env(cs);
> +    uint32_t pm_len;
> +    bool pm_signext;
> +
> +    if (cpu_address_xl(env) == MXL_RV32) {
> +        return (uint32_t)result;
> +    }
> +
> +    pm_len = riscv_pm_get_pmlen(riscv_pm_get_pmm(env));
> +    if (pm_len == 0) {
> +        return result;
> +    }
> +
> +    pm_signext = riscv_cpu_virt_mem_enabled(env);
> +    if (pm_signext) {
> +        return sextract64(result, 0, 64 - pm_len);
> +    }
> +    return extract64(result, 0, 64 - pm_len);

Is this safe for MXL_RV128?

> +}
> +#endif
> +
>   const TCGCPUOps riscv_tcg_ops = {
>       .mttcg_supported = true,
>       .guest_default_memory_order = 0,
> @@ -250,6 +275,7 @@ const TCGCPUOps riscv_tcg_ops = {
>   
>   #ifndef CONFIG_USER_ONLY
>       .tlb_fill = riscv_cpu_tlb_fill,
> +    .pointer_wrap = riscv_pointer_wrap,
>       .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
>       .cpu_exec_halt = riscv_cpu_has_work,
>       .cpu_exec_reset = cpu_reset,


