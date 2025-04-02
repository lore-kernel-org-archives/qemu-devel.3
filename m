Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C523C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Xd-0006l4-Fr; Wed, 02 Apr 2025 17:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u05Xa-0006kE-MA
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:22:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u05XY-0003ss-SG
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:22:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2255003f4c6so2699805ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743628945; x=1744233745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bUQKJq0F9HWYNid4yWwLG56s66i6+UQUSIp5L4gS1+M=;
 b=hu+4qsmTXbrTDhyy3fbAz7eGFXAGfsu9BadEklhD0UnKGRJ7vb3l7jLWjQKXhobHbG
 WZONQNTCR1ZFVgxX4aR7K0CPZUKnuJCpsrBHvTztG6JVheO8RDeScRIEYxzcr4t8GzJG
 PcsFtBhg1+b/VbGp6xwyjfaN4KJ5sAHyBcS+KPEjtvCsMPBLwCjJ3UCX0Ms6VhC1cC+e
 D55D9Y8cCWNnbJWlYIM8IJ6g/KnFAcmSU6CLcHr83Dek3kmqwNjfCu9KKAopr/+xxkVD
 ++t9PwDnywvmVu8hmLOYmZV09Tsk6nI+NpiTQFBd3lCDalFQBumtxGAvapgmxF65tBFX
 OYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628945; x=1744233745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bUQKJq0F9HWYNid4yWwLG56s66i6+UQUSIp5L4gS1+M=;
 b=YDe9eoxXoXLKJGJEBFPbLm7IwkAY2zRZHbBusixYowNMZ9yiJqvsyBE+VccJWNF1ZX
 vFjocj1PyCkH4liR2SV17EzJ/O4R7z87IhojRmMbG8gxjri7DCMjylgaydWanHnRjPbw
 Gq9bzF3at58KRsjlK4+VS/dDEADEiewoehsHMoVmOCg223GrgaKFplJHbbXeBOnH7hbl
 mutHR2LdP6ruTZBoyeDilKZ+k7fCrUNulSxkDDiyyORhTWK88eWDZS0eNPL5GWskx2Mk
 DG1JOp7E/TEe0Va5v49TLopEyem9QfVVJK1kEpsefhaLwtfoiL1Jdefy/Bn1uKouLirA
 AarQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg3ZAnT1v1LAgD9o50SQceJik91tPeX8rS3LTM8bxQYoWaVULgqGcgBuo+gZWD3mzt+EH6kKF60wuI@nongnu.org
X-Gm-Message-State: AOJu0Yy/mKEV9j+3ZH8NYtbG3LQ9Bjox7oqlhjSLqjxqdAn9pLtdoSAD
 p3eY7OTmwrvHXJqC+sJU2OGg2zI31+n/AweFh6++hcrKG1HLiRbjs24PK2ed8Dc=
X-Gm-Gg: ASbGncuylvQ8Ajhzv4J8RMca1nSIpQo0l9FDtmxYAKTqrDlU0aoEYIS5u7RnoBPazy0
 Q6k/MwR4icOGWy7cWkNOm9FQ7b+pK/bwJTLIVGtrpmC/kY9mX0vKTFbyCcARdcBWXU+t63MhQL4
 SAu0dljUAuximqcP4/8NOVVdo90NHnvcGWOrD30NPVXU6lMCuIDJCS4N7BJlBsnhye0Vl4H9qAW
 1/EVRzxE2on/v2yr3hQ/xueuD8dU/6xb/35KfnO4QHisEY2RKUksVPVwZilBEcmx4GQea8pnjKB
 5pz6vhgeGuv7TnYiQ0o3tL5ZVXu9MVTOgSQUhFfRit087Yje1dRgKzMprpAh
X-Google-Smtp-Source: AGHT+IEXPBQMAVjtae6prjHuFO7XLKlltHYKYH8Rujj7aW6UMIch0RJ5lhoGvZT1h5MJMD1QGBs0bQ==
X-Received: by 2002:a17:902:ce12:b0:226:3781:379d with SMTP id
 d9443c01a7336-2295c0ed130mr112706085ad.33.1743628945320; 
 Wed, 02 Apr 2025 14:22:25 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e413sm184405ad.123.2025.04.02.14.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 14:22:24 -0700 (PDT)
Message-ID: <6ac4e5d6-42c8-43b9-93e6-6842a7f66cd9@ventanamicro.com>
Date: Wed, 2 Apr 2025 18:22:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0?] target/riscv: Do not expose rv128 CPU on user
 mode emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250402205151.51415-1-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250402205151.51415-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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



On 4/2/25 5:51 PM, Philippe Mathieu-Daudé wrote:
> As Richard mentioned:
> 
>    We should allow RV128 in user-mode at all until there's a
>    kernel abi for it.

By the context I suppose Richard said 'We shouldn't allow RV128 ...'.

If this was said in a gitlab issue or something it would be nice to
add a link in the commit msg.

> 
> Remove the experimental 'x-rv128' CPU on user emulation
> (since it is experimental, no deprecation period is required).
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c         | 10 ++++------
>   target/riscv/tcg/tcg-cpu.c |  5 +++--
>   2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 430b02d2a58..ad534cee51f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -697,7 +697,7 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
>   #endif
>   }
>   
> -#ifdef CONFIG_TCG
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>   static void rv128_base_cpu_init(Object *obj)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> @@ -708,11 +708,9 @@ static void rv128_base_cpu_init(Object *obj)
>   
>       /* Set latest version of privileged specification */
>       env->priv_ver = PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> -#endif
>   }
> -#endif /* CONFIG_TCG */
> +#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
>   
>   static void rv64i_bare_cpu_init(Object *obj)
>   {
> @@ -3255,9 +3253,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                    MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
> -#ifdef CONFIG_TCG
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
> -#endif /* CONFIG_TCG */
> +#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 19ab324cb2a..50e81b2e521 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1048,7 +1048,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
>   static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
> -    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
>   
>       if (!riscv_cpu_tcg_compatible(cpu)) {
>           g_autofree char *name = riscv_cpu_get_name(cpu);
> @@ -1057,6 +1056,9 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
>           return false;
>       }
>   
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> +
>       if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
>           /* Missing 128-bit aligned atomics */
>           error_setg(errp,
> @@ -1065,7 +1067,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
>           return false;
>       }
>   
> -#ifndef CONFIG_USER_ONLY
>       CPURISCVState *env = &cpu->env;
>   
>       tcg_cflags_set(CPU(cs), CF_PCREL);


