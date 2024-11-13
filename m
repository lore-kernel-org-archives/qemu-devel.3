Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E2AD41C3E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 13:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBD5k-0001Et-Gh; Wed, 13 Nov 2024 08:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBD5h-0001EK-62
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:07:26 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBD5f-0007tY-9b
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:07:24 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso65028205ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 05:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731503240; x=1732108040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VwoT6KZSYbbMX+LfLh9Fk9l1HaNJ+aLMGQqiZlgwPKY=;
 b=my80tVNesEJtqRRU7g0CA1hOGlK7pK2samR7XQIOKr3OF9z3763jCkp7DZT+NNGz7p
 CYYkwvELEDkSzJz5gCD2zqukktQwy96KLnw1nYTGdg1KzvJ741kCz2DYbzv69pTEqbUE
 jqVZ8hA0+aSEG+KuoF2Yc3/M8mbgXpXl516Gjas/ziWiM36WhS95t/Tdfdfab84fo+PM
 2Ihzbnk9X1YdUEFfTo1o2Y7lnbii3F9x36wnV8pVZVNjRCeTXhUiaB7SMw/aPMfnAkUO
 y6/EoQhp1r+Ui+E92eSMhNIi5vW3GoUJCkOeU6xWG+BPkGHbcNeB5n7vlIzM8XeoVISX
 3zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731503240; x=1732108040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VwoT6KZSYbbMX+LfLh9Fk9l1HaNJ+aLMGQqiZlgwPKY=;
 b=C3oY3SV5ONb/YkpWaHIpFFJAsOypgoC7nL73mKf4vUgxVfPgbYKKyiIW3GVzquMCW9
 8D293QU3ADBtZJZdgFCRU27gpLtFXKRnHR3nSdlpOKNxZFzp7yMhEQJ7ilymV7U2EHE2
 0X7EPXBbezviCJz5oOlmFp+egIkmOFV0YIy6GcACVLaxmJvUm3ORcWeYlXOJ20jJZZFj
 1PeteRoFJpowcrps0wzB5kH+K119Vh6unRztKAAlsNFusG5+3q9PWMMNXJj7Dua/c6Sm
 4tlGmS3GP5SuWBcc4KR14v1yLzpecVlNrxxtJr0vWWlubJBa/ekLvz3m2PwpSIoEhO0f
 V04g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE01gS9H62GGbobj/RoLpoqMXyzl7pyDOIqMxHb7lC6yN68STWBtz8Ol5JZu2UpzU8rdfA7eWnfqi2@nongnu.org
X-Gm-Message-State: AOJu0Yx1glEeGDInwEcg/ruHGeDTeJramZk3h0iojpbk+UfZDQt3TpmK
 W0/k1E2sAzdnbXfm8Volu2dh4rQ7Znrs+MGT0C0TbcUHap+o08GZcFu9yP0QRKabkM9EmR5jyc7
 9
X-Google-Smtp-Source: AGHT+IHM0+VmU4DTujno+dwjf8wUlX1woCnh4hKXuI8kzHlIkhquvRaknYPEVc1D69mIHfQhKPHfgw==
X-Received: by 2002:a17:902:f541:b0:20d:1866:ed6f with SMTP id
 d9443c01a7336-21183ccf11bmr271520905ad.4.1731503238175; 
 Wed, 13 Nov 2024 05:07:18 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dde2d5sm108632065ad.70.2024.11.13.05.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 05:07:17 -0800 (PST)
Message-ID: <fb79d615-3f19-4f8e-952d-747b81f957bb@ventanamicro.com>
Date: Wed, 13 Nov 2024 10:07:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Add Tenstorrent Ascalon CPU
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241113110459.1607299-1-antonb@tenstorrent.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241113110459.1607299-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 11/13/24 8:04 AM, Anton Blanchard wrote:
> Add a CPU entry for the Tenstorrent Ascalon CPU, a series of 2 wide to
> 8 wide RV64 cores. More details can be found at
> https://tenstorrent.com/ip/tt-ascalon
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 62115375cd..6547642287 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -49,6 +49,7 @@
>   #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
>   #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
> +#define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..8447ad0dfb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -579,6 +579,72 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>   #endif
>   }
>   
> +/* Tenstorrent Ascalon */
> +static void rv64_tt_ascalon_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +
> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
> +    env->priv_ver = PRIV_VERSION_1_13_0;
> +
> +    /* Enable ISA extensions */
> +    cpu->cfg.mmu = true;
> +    cpu->cfg.vlenb = 256 >> 3;
> +    cpu->cfg.elen = 64;
> +    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
> +    cpu->cfg.rvv_ma_all_1s = true;
> +    cpu->cfg.rvv_ta_all_1s = true;
> +    cpu->cfg.misa_w = true;
> +    cpu->cfg.pmp = true;
> +    cpu->cfg.cbom_blocksize = 64;
> +    cpu->cfg.cbop_blocksize = 64;
> +    cpu->cfg.cboz_blocksize = 64;
> +    cpu->cfg.ext_zic64b = true;
> +    cpu->cfg.ext_zicbom = true;
> +    cpu->cfg.ext_zicbop = true;
> +    cpu->cfg.ext_zicboz = true;
> +    cpu->cfg.ext_zicntr = true;
> +    cpu->cfg.ext_zicond = true;
> +    cpu->cfg.ext_zicsr = true;
> +    cpu->cfg.ext_zifencei = true;
> +    cpu->cfg.ext_zihintntl = true;
> +    cpu->cfg.ext_zihintpause = true;
> +    cpu->cfg.ext_zihpm = true;
> +    cpu->cfg.ext_zimop = true;
> +    cpu->cfg.ext_zawrs = true;
> +    cpu->cfg.ext_zfa = true;
> +    cpu->cfg.ext_zfbfmin = true;
> +    cpu->cfg.ext_zfh = true;
> +    cpu->cfg.ext_zfhmin = true;
> +    cpu->cfg.ext_zcb = true;
> +    cpu->cfg.ext_zcmop = true;
> +    cpu->cfg.ext_zba = true;
> +    cpu->cfg.ext_zbb = true;
> +    cpu->cfg.ext_zbs = true;
> +    cpu->cfg.ext_zkt = true;
> +    cpu->cfg.ext_zvbb = true;
> +    cpu->cfg.ext_zvbc = true;
> +    cpu->cfg.ext_zvfbfmin = true;
> +    cpu->cfg.ext_zvfbfwma = true;
> +    cpu->cfg.ext_zvfh = true;
> +    cpu->cfg.ext_zvfhmin = true;
> +    cpu->cfg.ext_zvkng = true;
> +    cpu->cfg.ext_smaia = true;
> +    cpu->cfg.ext_smstateen = true;
> +    cpu->cfg.ext_ssaia = true;
> +    cpu->cfg.ext_sscofpmf = true;
> +    cpu->cfg.ext_sstc = true;
> +    cpu->cfg.ext_svade = true;
> +    cpu->cfg.ext_svinval = true;
> +    cpu->cfg.ext_svnapot = true;
> +    cpu->cfg.ext_svpbmt = true;
> +
> +#ifndef CONFIG_USER_ONLY
> +    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
> +#endif
> +}
> +
>   #ifdef CONFIG_TCG
>   static void rv128_base_cpu_init(Object *obj)
>   {
> @@ -2982,6 +3048,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
>   #ifdef CONFIG_TCG
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),


