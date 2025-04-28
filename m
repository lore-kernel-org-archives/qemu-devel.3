Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CB9C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Mzz-0006CH-O5; Mon, 28 Apr 2025 07:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9Mzx-0006Aj-0Y
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:50:09 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9Mzu-0000ys-83
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:50:08 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so3720269a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745841004; x=1746445804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j2ADhSuIthBp1J4HYSChgu9EVYJ2nKLsM6s7xvMZ8YA=;
 b=c5bggXz/7+jVJwhqMwQ/CO/ZrhyGdrPL6nNoavtGpGu+nyihAorMbS/dv+4+59Vb7Z
 25mzi7TTkgXqUI90+1xdZ4efLSch6p4EuajsBjvK4pZ0xenxTFE6Pd3p4Rdei4uLgBGv
 u6flHyaLN1OXpA2uqRNEoJRrugx5oMRMC/0/q70lRywiQlOS4KjyYymyuC0UUE0GYAwp
 jorNl/ApXdV0r3tknYvc0JWC8Ed9nCoUq2WyRAuy72BRb3+rKo82BVhLTB4N4S52Lmzm
 hU/Lb4+VIvToKJ7dwbRMPc36ISCBnF1dXcl017kEf4PIBBuVOQz3GZd7WACRvVBjup+p
 08/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745841004; x=1746445804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j2ADhSuIthBp1J4HYSChgu9EVYJ2nKLsM6s7xvMZ8YA=;
 b=Y0EMGVaYVB5Fc027efFg0FW0QA6unCNX2E8BdSZYMCueG3iA+QCMtVQlyzZv44S5Bc
 UbkLqQGLWvvRXLoU2jQCWH3d2kJrYhA8VhqjsEVR200CvgfqkoRH8Ln9jAfpQeoqS8my
 S//u8s2fsPm9upk7jfNVXg7i0aixEFdunGFqGyYP82z5C3IJmd8PvSm0sFnkkl0fM247
 eY8eo8udPMFP04OsJIHctLRob/jk7JvmSfkt+VGpMbyOrAyiegXypo/6L6rHl4SFGCZm
 rVWjF2YYXB2pk7GKsiV+EnKb28wzjoHgpPc3IJCtfcvSaEY404lbQVZket0wjH1K0FzX
 rBZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURFlmVKKrLo9OsnGi1Hx81HqbjDJKC7dWFzNw9bBeFm/aFToimAiljDlj9H72OcRtaXjs9Z5PUdrpj@nongnu.org
X-Gm-Message-State: AOJu0YxgtHuzfXHJGDJf18NcU447rvUHFjxxk+dXUWmJMx4eZdawa7My
 ilUBYoBV49tIUKxodUXv919RAPnPckW5y0nApgkpuDes61l8EEhAnrNvGc6MBSQ=
X-Gm-Gg: ASbGncvqsHbmDs1nN6o+FOEkouzTmfSgpyDvyfJW6aQMSRNoM3cAPgUowZ3d30jLhZX
 HyM+mKPC6OqQVskThMVfgTCuzb2vTGLFAtuRz192tqn1uTSJq4T2Pci/hE3bjw8xZEU61pv7xom
 1hcfhnDBPvlCBJzGRxQhsdKAUQCMWB5yImJyEXddw7tcbCXYIxmCpX50QObXzeGIGVrqg0lqEy1
 8f/AaXeSF6FIAnfYSOwx/hDHBTD2Ch2O4GZlbiFoot11Z9eJYIYocCcCBnRPtGbp5Z05ODr3pgL
 K4auXjd8qvVqZWc+jZnQZYWEeZuV3gldX7NRv6Do5xg/aW3BdaQhRIA=
X-Google-Smtp-Source: AGHT+IFdkRfz1L3DTc9i6rY2T/OHFNtBUGYtFEwPEqXl9DMrJClqquYcW8i6BeIkhPeLtuhhzBJS6g==
X-Received: by 2002:a17:90b:3dcf:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-30a013bcf66mr13211878a91.35.1745841003630; 
 Mon, 28 Apr 2025 04:50:03 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef146f92sm8738303a91.40.2025.04.28.04.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 04:50:03 -0700 (PDT)
Message-ID: <30770d2b-ac76-4d13-b8f2-ca39c0b82e0f@ventanamicro.com>
Date: Mon, 28 Apr 2025 08:50:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/26] target/riscv: store RISCVCPUDef struct directly in
 the class
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
References: <20250428073442.315770-1-pbonzini@redhat.com>
 <20250428073442.315770-9-pbonzini@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250428073442.315770-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
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



On 4/28/25 4:34 AM, Paolo Bonzini wrote:
> Prepare for adding more fields to RISCVCPUDef and reading them in
> riscv_cpu_init: instead of storing the misa_mxl_max field in
> RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
> and go through it.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/riscv/cpu.h         |  2 +-
>   hw/riscv/boot.c            |  2 +-
>   target/riscv/cpu.c         | 23 ++++++++++++++++++-----
>   target/riscv/gdbstub.c     |  6 +++---
>   target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
>   target/riscv/machine.c     |  2 +-
>   target/riscv/tcg/tcg-cpu.c | 10 +++++-----
>   target/riscv/translate.c   |  2 +-
>   8 files changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 62e303f0635..842c9d3f194 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -553,7 +553,7 @@ struct RISCVCPUClass {
>   
>       DeviceRealize parent_realize;
>       ResettablePhases parent_phases;
> -    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +    RISCVCPUDef *def;
>   };
>   
>   static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 765b9e2b1ab..828a867be39 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -37,7 +37,7 @@
>   bool riscv_is_32bit(RISCVHartArrayState *harts)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(&harts->harts[0]);
> -    return mcc->misa_mxl_max == MXL_RV32;
> +    return mcc->def->misa_mxl_max == MXL_RV32;
>   }
>   
>   /*
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f30cf1b532b..d8c189d596b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -357,7 +357,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
>   
>   int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
>   {
> -    return 16 << mcc->misa_mxl_max;
> +    return 16 << mcc->def->misa_mxl_max;
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>           mcc->parent_phases.hold(obj, type);
>       }
>   #ifndef CONFIG_USER_ONLY
> -    env->misa_mxl = mcc->misa_mxl_max;
> +    env->misa_mxl = mcc->def->misa_mxl_max;
>       env->priv = PRV_M;
>       env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>       if (env->misa_mxl > MXL_RV32) {
> @@ -1450,7 +1450,7 @@ static void riscv_cpu_init(Object *obj)
>       RISCVCPU *cpu = RISCV_CPU(obj);
>       CPURISCVState *env = &cpu->env;
>   
> -    env->misa_mxl = mcc->misa_mxl_max;
> +    env->misa_mxl = mcc->def->misa_mxl_max;
>   
>   #ifndef CONFIG_USER_ONLY
>       qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> @@ -1544,7 +1544,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
>       CPUClass *cc = CPU_CLASS(mcc);
>   
>       /* Validate that MISA_MXL is set properly. */
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>   #ifdef TARGET_RISCV64
>       case MXL_RV64:
>       case MXL_RV128:
> @@ -3071,12 +3071,24 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
>       device_class_set_props(dc, riscv_cpu_properties);
>   }
>   
> +static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
> +{
> +    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
> +    RISCVCPUClass *pcc = RISCV_CPU_CLASS(object_class_get_parent(c));
> +
> +    if (pcc->def) {
> +        mcc->def = g_memdup2(pcc->def, sizeof(*pcc->def));
> +    } else {
> +        mcc->def = g_new0(RISCVCPUDef, 1);
> +    }
> +}
> +
>   static void riscv_cpu_class_init(ObjectClass *c, const void *data)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
>       const RISCVCPUDef *def = data;
>   
> -    mcc->misa_mxl_max = def->misa_mxl_max;
> +    mcc->def->misa_mxl_max = def->misa_mxl_max;
>       riscv_cpu_validate_misa_mxl(mcc);
>   }
>   
> @@ -3227,6 +3239,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .abstract = true,
>           .class_size = sizeof(RISCVCPUClass),
>           .class_init = riscv_cpu_common_class_init,
> +        .class_base_init = riscv_cpu_class_base_init,
>       },
>       {
>           .name = TYPE_RISCV_DYNAMIC_CPU,
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 18e88f416af..1934f919c01 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -62,7 +62,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>           return 0;
>       }
>   
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>       case MXL_RV32:
>           return gdb_get_reg32(mem_buf, tmp);
>       case MXL_RV64:
> @@ -82,7 +82,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>       int length = 0;
>       target_ulong tmp;
>   
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>       case MXL_RV32:
>           tmp = (int32_t)ldl_p(mem_buf);
>           length = 4;
> @@ -359,7 +359,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>                                    ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs),
>                                    0);
>       }
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>       case MXL_RV32:
>           gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
>                                    riscv_gdb_set_virtual,
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 75724b6af4f..41b6f34552a 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
>   }
>   type_init(kvm_cpu_accel_register_types);
>   
> -static void riscv_host_cpu_class_init(ObjectClass *c, const void *data)
> -{
> -    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
> -
> -#if defined(TARGET_RISCV32)
> -    mcc->misa_mxl_max = MXL_RV32;
> -#elif defined(TARGET_RISCV64)
> -    mcc->misa_mxl_max = MXL_RV64;
> -#endif
> -}
> -
>   static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>       {
>           .name = TYPE_RISCV_CPU_HOST,
>           .parent = TYPE_RISCV_CPU,
> -        .class_init = riscv_host_cpu_class_init,
> +#if defined(TARGET_RISCV32)
> +        .class_data = &((const RISCVCPUDef) {
> +            .misa_mxl_max = MXL_RV32,
> +        },
> +#elif defined(TARGET_RISCV64)
> +        .class_data = &((const RISCVCPUDef) {
> +            .misa_mxl_max = MXL_RV64,
> +        },
> +#endif
>       }
>   };

Are we sure this patch compiles? As I said in the v3 this except opening 2 parentheses
and closing just one after RISCVCPUDef:


> -        .class_init = riscv_host_cpu_class_init,
> +#if defined(TARGET_RISCV32)
> +        .class_data = &(( <-----
                        const RISCVCPUDef) {
> +            .misa_mxl_max = MXL_RV32,
> +        },
> +#elif defined(TARGET_RISCV64)
> +        .class_data = &(( <-----
                       const RISCVCPUDef) {
> +            .misa_mxl_max = MXL_RV64,
> +        },
> +#endif
>       }
>   };


In v3 this is the error I was having:


../target/riscv/kvm/kvm-cpu.c:2013:5: error: expected expression before '}' token
   2013 |     }
        |     ^
../target/riscv/kvm/kvm-cpu.c:2011:10: error: value computed is not used [-Werror=unused-value]
   2011 |         },
        |          ^
cc1: all warnings being treated as errors


The error is fixable by closing both parentheses right before the comma, e.g:

> +        }),


Can you mention the pull requests you based this series on top of? I can apply the
dependencies and this series on top of it to see if it builds. Thanks,


Daniel





>   
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index a1f70cc9556..c97e9ce9df1 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -170,7 +170,7 @@ static bool rv128_needed(void *opaque)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
>   
> -    return mcc->misa_mxl_max == MXL_RV128;
> +    return mcc->def->misa_mxl_max == MXL_RV128;
>   }
>   
>   static const VMStateDescription vmstate_rv128 = {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1192b4e1545..f3ca61103c4 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -592,7 +592,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> -    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
> +    if (mcc->def->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
>           error_setg(errp, "Zcf extension is only relevant to RV32");
>           return;
>       }
> @@ -689,7 +689,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> -    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
> +    if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
>           error_setg(errp, "svukte is not supported for RV32");
>           return;
>       }
> @@ -927,7 +927,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
>   
> -        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
> +        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
>               cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
>           }
>       }
> @@ -936,7 +936,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
>       if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
>   
> -        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
> +        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
>               cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
>           }
>   
> @@ -1062,7 +1062,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
>   #ifndef CONFIG_USER_ONLY
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
>   
> -    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
> +    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
>           /* Missing 128-bit aligned atomics */
>           error_setg(errp,
>                      "128-bit RISC-V currently does not work with Multi "
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index cef61b5b290..26ac7cdcaa1 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1282,7 +1282,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
>       ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
>       ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
> -    ctx->misa_mxl_max = mcc->misa_mxl_max;
> +    ctx->misa_mxl_max = mcc->def->misa_mxl_max;
>       ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
>       ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
>       ctx->cs = cs;


