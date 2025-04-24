Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE22C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 13:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7x0D-0001T4-PQ; Thu, 24 Apr 2025 09:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7x0C-0001So-8H
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 09:52:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7x09-0006cD-KY
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 09:52:32 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-309f3bf23b8so282583a91.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745502748; x=1746107548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gzT3e0wZ+lcoHZB1GDwZ7xbAB+OUzdKJjCMuev6oyb0=;
 b=YQT/iaxuEX4DBTaM9qu0s3qaShQZaUIuSdEH4bFoorDYk+BADSUa0U29y0c5/Qk2td
 rXWYD1N4eWm+ZzdPlBEL5nS1NalLHMcrgP+jU+iNWNP8le1lp+Tkr/OA8PoiMBdOrz/+
 /hDmqh2PO2/fVSWzDkPU2w3AckVeQBZM04v/NCCMm9ijirPLf4FVFpW07xUuuWU78g5Y
 iaqbN2hT84cNbkvmkyabG5Lw4+fX20K+D4SfeBeAAW73Q3FjznzkA5fGip0KX9wkdExm
 gENH9Scya98xKrg9uAVnZlBV5xSWWtISRdDaRHO2EgrlXHArXRLYx3tCDeHDGedVy2YC
 t0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745502748; x=1746107548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gzT3e0wZ+lcoHZB1GDwZ7xbAB+OUzdKJjCMuev6oyb0=;
 b=kN2GRAz/RkD9JmBNvMeV6RVKjhwf1uXMbR7nObfDXV3n8UwlUkdwLrbAg0E0gcMgqz
 dy3lwAyz4nMDNQGhfqfi0+4IpMusoa0xFsOwEKotVrDS+qK2LPdpXgGI3sz5bxwQM1ed
 o7W7tUDt0ofpk5/w/TY4Py7VChnc10tgoCebCJXK4xTb5XBKhFjfwrTgJVY/i7L6rPXc
 CHPzIXPvsxUV7teAqRp2ydM8mUPhy4Yss09ZgmJ4AwsxqI5xd8dd91IaHUtnopYleToO
 0RmAOugUVJO5dMjKNSwD27ujMGtr6Agw3LpJdRqDgQt6DEJVj1vI+SQpLY+rDA2+X3gM
 JwVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/FZB+sP6xA4/XWWT4gRkLQLMDlX5/y+JEFfZILVg4+rHM3R1ulqt/1e18qHoJip2yD1LejmIWyiiY@nongnu.org
X-Gm-Message-State: AOJu0Yzz2SlajtC+LMaLgguKVLFWqhHkXmXGOvi83PLN5XSZnCQYHSEK
 1JKwgwRtN1iwfNGAOxt4ODHe0AEVhXGMcBtMJCDajEoeh6gCj7Vc/g/zY9Q5nRM=
X-Gm-Gg: ASbGncu6RkTAPJYk/fgkZEsFn+R305OB2vE2ibxFEfkPA4gKxD3FT7JiczDVtki6/DN
 +aGqP2yxxuBqCbS51CFkFB8XHPf0WXTyDAQfB6WIBZUxQCaOUptDzoQm7GzaQ6C1I96JYez8TYL
 F5//j1fOQITpEdW2tLm5r+fbOtn6vUG/WvGJRYipRJ0PdzLN4LDPcJb0lFbWwdPt3gEnFyfxjm2
 433K5DzSHy8Cq+hD56oHYHLFZgCnHhHJ9pWf0qvtjnRtBo5XVDSDsTY9cuPohEPO9e6k8+NLLJG
 /4F+4SAcmNNvmECCM7zuD7vnSyDMzIXV5Jlk1U5Uv5IWhOXAr4IEigs=
X-Google-Smtp-Source: AGHT+IHdzOZlah6vqdXRXeaynCpOe1IAggNQMbERih0bdXCtFHFS/Fce1MWGwo2wVe8N++VZuX6ikw==
X-Received: by 2002:a17:90b:2644:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-309ed27244emr4283759a91.11.1745502747611; 
 Thu, 24 Apr 2025 06:52:27 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef0b8c4asm1368583a91.31.2025.04.24.06.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 06:52:27 -0700 (PDT)
Message-ID: <8f3bae37-e1f3-4e55-9dc6-b7876992b47e@ventanamicro.com>
Date: Thu, 24 Apr 2025 10:52:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/27] target/riscv: store RISCVCPUDef struct directly in
 the class
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-9-pbonzini@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250406070254.274797-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
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

Hi,

This patch breaks RISC-V KVM build in my env. The issues are down there:

On 4/6/25 4:02 AM, Paolo Bonzini wrote:
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
> index 65c8d6855ec..9bbfdcf6758 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -557,7 +557,7 @@ struct RISCVCPUClass {
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
> index 3bd2bff1328..25132e57380 100644
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
> @@ -1055,7 +1055,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>           mcc->parent_phases.hold(obj, type);
>       }
>   #ifndef CONFIG_USER_ONLY
> -    env->misa_mxl = mcc->misa_mxl_max;
> +    env->misa_mxl = mcc->def->misa_mxl_max;
>       env->priv = PRV_M;
>       env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>       if (env->misa_mxl > MXL_RV32) {
> @@ -1457,7 +1457,7 @@ static void riscv_cpu_init(Object *obj)
>       RISCVCPU *cpu = RISCV_CPU(obj);
>       CPURISCVState *env = &cpu->env;
>   
> -    env->misa_mxl = mcc->misa_mxl_max;
> +    env->misa_mxl = mcc->def->misa_mxl_max;
>   
>   #ifndef CONFIG_USER_ONLY
>       qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> @@ -1554,7 +1554,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
>       CPUClass *cc = CPU_CLASS(mcc);
>   
>       /* Validate that MISA_MXL is set properly. */
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>   #ifdef TARGET_RISCV64
>       case MXL_RV64:
>       case MXL_RV128:
> @@ -3079,12 +3079,24 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
>       device_class_set_props(dc, riscv_cpu_properties);
>   }
>   
> +static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
>   static void riscv_cpu_class_init(ObjectClass *c, void *data)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
>       const RISCVCPUDef *def = data;
>   
> -    mcc->misa_mxl_max = def->misa_mxl_max;
> +    mcc->def->misa_mxl_max = def->misa_mxl_max;
>       riscv_cpu_validate_misa_mxl(mcc);
>   }
>   
> @@ -3235,6 +3247,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
> index 0f4997a9186..d7e6970a670 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
>   }
>   type_init(kvm_cpu_accel_register_types);
>   
> -static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
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


../target/riscv/kvm/kvm-cpu.c:2013:5: error: expected expression before '}' token
  2013 |     }
       |     ^
../target/riscv/kvm/kvm-cpu.c:2011:10: error: value computed is not used [-Werror=unused-value]
  2011 |         },
       |          ^
cc1: all warnings being treated as errors
[11/13] Linking target qemu-nbd


We're missing closing parenthesis after the "}".

If we fix that we'll get another error:

../target/riscv/kvm/kvm-cpu.c:2009:23: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  2009 |         .class_data = &((const RISCVCPUDef) {
       |                       ^
cc1: all warnings being treated as errors


Removing the 'const' qualifier fixes this other error.


This diff fixes the KVM build with this patch:


diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index d7e6970a67..c94110a726 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2002,13 +2002,13 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
          .name = TYPE_RISCV_CPU_HOST,
          .parent = TYPE_RISCV_CPU,
  #if defined(TARGET_RISCV32)
-        .class_data = &((const RISCVCPUDef) {
+        .class_data = &((RISCVCPUDef) {
              .misa_mxl_max = MXL_RV32,
-        },
+        }),
  #elif defined(TARGET_RISCV64)
-        .class_data = &((const RISCVCPUDef) {
+        .class_data = &((RISCVCPUDef) {
              .misa_mxl_max = MXL_RV64,
-        },
+        }),
  #endif
      }
  };



Thanks,

Daniel

>   
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 889e2b65701..df2d5bad8d6 100644
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
> index 2f93e2dd285..b43bd3d35b7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -581,7 +581,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> -    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
> +    if (mcc->def->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
>           error_setg(errp, "Zcf extension is only relevant to RV32");
>           return;
>       }
> @@ -678,7 +678,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> -    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
> +    if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
>           error_setg(errp, "svukte is not supported for RV32");
>           return;
>       }
> @@ -916,7 +916,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
>   
> -        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
> +        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
>               cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
>           }
>       }
> @@ -925,7 +925,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
>       if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
>   
> -        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
> +        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
>               cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
>           }
>   
> @@ -1049,7 +1049,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
>           return false;
>       }
>   
> -    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
> +    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
>           /* Missing 128-bit aligned atomics */
>           error_setg(errp,
>                      "128-bit RISC-V currently does not work with Multi "
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d6651f244f6..e22ecd11565 100644
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


