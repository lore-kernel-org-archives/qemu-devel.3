Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A116E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 12:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQnCi-0002l7-6F; Thu, 26 Dec 2024 07:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnCf-0002km-Q8
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:43:01 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnCd-00080Y-D5
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:43:01 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-219f8263ae0so37755965ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 04:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1735216976; x=1735821776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N70kubq//hJAgDacuTzeWXwnpt/XymuYIgUizZZ9AoQ=;
 b=CB3CQZIgI1C7qqbYvheyD9n5ehSmNtoUctjrBannpK0a4XDJBLbCdczmt+F+aUm3Ng
 tDSDapxniX2ld5vfzDm+7dhXPkKyAf25tAQ3n8cP96goOQh1Esl/rpYnJic3Qf3qLRBV
 1LyJy4Tc6nX/JxaDNoFr14xrctj/3+z7ssYdlW82tJOe6TwaMjYDyeNeAJZCu2uTYQkR
 UjiKc5gJp5aGmQkSxeMtu3SADbA6mt8kEiQ+pj9JhwsApf5LxP9uf46xm+JKiN1TdCAq
 UkS8nd6khukUhfekxmueXzErNHb70tBu+d2cA0F8I46LsUqKQyrbhXyTOn47OaxtN1yZ
 F09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735216976; x=1735821776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N70kubq//hJAgDacuTzeWXwnpt/XymuYIgUizZZ9AoQ=;
 b=DohqiFCjqnbOWjdBSU4mPOyqxDFggl8Te4tlPUe7jJo+C0gg2SC4WB/eneh0umM/au
 Ent77KctkzX0kY2E0CtsI1yQ792CgZKQQ+xr0XaM0ZjnU1EVYyt2TaMzQk3YaLDEtDxz
 MxGi0b2iOJLgl51nUgtqI7TKOw/+Vhiic8GWprnl7Kr5FL7Fg/1aiiYW++uw5U/z0Rni
 VBVxQ9NY8deFvEGcxjoTAExjp/oeinM8ZEWE57PGy9bOHytgo3kAGhjUxm3wanl2zaM1
 BNl9yIJo6Cs+gSN8yzz26NRqKu4y/3x7QkpOk7l7A1NYsHxKgOBvHXIp1KL6/+RDTqwh
 bL0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmPox5Q4kY9WW3DP+b83p6QZlRrvHNNVZvLjSd5JGRUJpn3tcXAB3+oM6b036CO6NGAOBNhWH1y+gt@nongnu.org
X-Gm-Message-State: AOJu0YxTMluD6AqybMnOG+0b47yd6wKeZ56MgfK+MqLPRrjI53lhhRiO
 TGSSc/SM5EHZYQtrbnOZtu/dpduDP9weW9P3+lmZDQR8LkUxjhVKK+Vt1go0eBA=
X-Gm-Gg: ASbGnctZQfEHmGI4iF5+4b63uQWcGPi4+kJT5SKchOvAJrcswACZyf3NAUbWumr8gPB
 byVohS5nRO8o4V4q6SixBFGcu521s2udZADw4rZHLjb/3RC1n76MzrXJEDWHqNis+7b/1qKIdBt
 XpVTdlUhjDbI75NjziHUICeJsxiR2k3go+omhypy+bhUwvy4C/4YWuljWx/lRv+27Xbo7OQeiIm
 aPQ/95TTvsnlzC1Y6TTPC3B7z9Xrh7xJNKCp8siIKQRvjhKFEs/N62WecDekwOQ7nk7PQ==
X-Google-Smtp-Source: AGHT+IF8OTOE49CWh0d2SDtlOLV0N03WadzITFzuto8/URJfrsms6DMKwz3rxDJx2YnYfGkNyDunhA==
X-Received: by 2002:a17:903:32c5:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-219e6e894f4mr337070335ad.9.1735216976509; 
 Thu, 26 Dec 2024 04:42:56 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cddf2sm119310685ad.166.2024.12.26.04.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 04:42:55 -0800 (PST)
Message-ID: <b243b6b0-a35d-4dc0-a87a-03b61ea2acbc@ventanamicro.com>
Date: Thu, 26 Dec 2024 09:42:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/7] target/riscv: Handle Smrnmi interrupt and
 exception
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tommy Wu <tommy.wu@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
 <20241217062440.884261-4-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241217062440.884261-4-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 12/17/24 3:24 AM, frank.chang@sifive.com wrote:
> From: Tommy Wu <tommy.wu@sifive.com>
> 
> Because the RNMI interrupt trap handler address is implementation defined.
> We add the 'rnmi-interrupt-vector' and 'rnmi-exception-vector' as the property
> of the harts. It’s very easy for users to set the address based on their
> expectation. This patch also adds the functionality to handle the RNMI signals.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---
>   hw/riscv/riscv_hart.c         | 40 +++++++++++++++++
>   include/hw/riscv/riscv_hart.h |  4 ++
>   target/riscv/cpu.c            | 11 +++++
>   target/riscv/cpu.h            |  3 ++
>   target/riscv/cpu_bits.h       | 12 +++++
>   target/riscv/cpu_helper.c     | 85 ++++++++++++++++++++++++++++++++---
>   6 files changed, 150 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 0df454772f..f5e40e608d 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -26,6 +26,7 @@
>   #include "target/riscv/cpu.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/riscv/riscv_hart.h"
> +#include "qemu/error-report.h"
>   
>   static const Property riscv_harts_props[] = {
>       DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
> @@ -33,6 +34,22 @@ static const Property riscv_harts_props[] = {
>       DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
>       DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
>                          DEFAULT_RSTVEC),
> +    /*
> +     * Smrnmi implementation-defined interrupt and exception trap handlers.
> +     *
> +     * When an RNMI interrupt is detected, the hart then enters M-mode and
> +     * jumps to the address defined by "rnmi-interrupt-vector".
> +     *
> +     * When the hart encounters an exception while executing in M-mode with
> +     * the mnstatus.NMIE bit clear, the hart then jumps to the address
> +     * defined by "rnmi-exception-vector".
> +     */
> +    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
> +                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
> +                      uint64_t),
> +    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
> +                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
> +                      uint64_t),
>       DEFINE_PROP_END_OF_LIST(),

This except will result in a conflict because "DEFINE_PROP_END_OF_LIST()," was removed
in master.

With that said:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   };
>   
> @@ -47,6 +64,29 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>   {
>       object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
>       qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
> +
> +    if (s->harts[idx].cfg.ext_smrnmi) {
> +        if (idx < s->num_rnmi_irqvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-interrupt-vector", s->rnmi_irqvec[idx]);
> +        }
> +
> +        if (idx < s->num_rnmi_excpvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-exception-vector", s->rnmi_excpvec[idx]);
> +        }
> +    } else {
> +        if (s->num_rnmi_irqvec > 0) {
> +            warn_report_once("rnmi-interrupt-vector property is ignored "
> +                             "because Smrnmi extension is not enabled.");
> +        }
> +
> +        if (s->num_rnmi_excpvec > 0) {
> +            warn_report_once("rnmi-exception-vector property is ignored "
> +                             "because Smrnmi extension is not enabled.");
> +        }
> +    }
> +
>       s->harts[idx].env.mhartid = s->hartid_base + idx;
>       qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
>       return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
> diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
> index 912b4a2682..a6ed73a195 100644
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -38,6 +38,10 @@ struct RISCVHartArrayState {
>       uint32_t hartid_base;
>       char *cpu_type;
>       uint64_t resetvec;
> +    uint32_t num_rnmi_irqvec;
> +    uint64_t *rnmi_irqvec;
> +    uint32_t num_rnmi_excpvec;
> +    uint64_t *rnmi_excpvec;
>       RISCVCPU *harts;
>   };
>   
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ade9e6e190..e6988f44c6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1419,6 +1419,11 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>           g_assert_not_reached();
>       }
>   }
> +
> +static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> +{
> +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
> +}
>   #endif /* CONFIG_USER_ONLY */
>   
>   static bool riscv_cpu_is_dynamic(Object *cpu_obj)
> @@ -1442,6 +1447,8 @@ static void riscv_cpu_init(Object *obj)
>   #ifndef CONFIG_USER_ONLY
>       qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
>                         IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> +                            "riscv.cpu.rnmi", RNMI_MAX);
>   #endif /* CONFIG_USER_ONLY */
>   
>       general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
> @@ -2797,6 +2804,10 @@ static const Property riscv_cpu_properties[] = {
>   
>   #ifndef CONFIG_USER_ONLY
>       DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
> +    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU, env.rnmi_irqvec,
> +                       DEFAULT_RNMI_IRQVEC),
> +    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpvec,
> +                       DEFAULT_RNMI_EXCPVEC),
>   #endif
>   
>       DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string, false),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a2cb471b3c..8dc5b4d002 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -493,6 +493,8 @@ struct CPUArchState {
>       target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
>       target_ulong mnstatus;
>       target_ulong rnmip;
> +    uint64_t rnmi_irqvec;
> +    uint64_t rnmi_excpvec;
>   };
>   
>   /*
> @@ -591,6 +593,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>   int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
>   uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
>                                 uint64_t value);
> +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
>   void riscv_cpu_interrupt(CPURISCVState *env);
>   #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
>   void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 9e9637263d..17787fd693 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -680,6 +680,12 @@ typedef enum {
>   /* Default Reset Vector address */
>   #define DEFAULT_RSTVEC      0x1000
>   
> +/* Default RNMI Interrupt Vector address */
> +#define DEFAULT_RNMI_IRQVEC     0x0
> +
> +/* Default RNMI Exception Vector address */
> +#define DEFAULT_RNMI_EXCPVEC    0x0
> +
>   /* Exception causes */
>   typedef enum RISCVException {
>       RISCV_EXCP_NONE = -1, /* sentinel value */
> @@ -734,6 +740,9 @@ typedef enum RISCVException {
>   /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>   #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>   
> +/* RNMI causes */
> +#define RNMI_MAX                           16
> +
>   /* mip masks */
>   #define MIP_USIP                           (1 << IRQ_U_SOFT)
>   #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> @@ -972,6 +981,9 @@ typedef enum RISCVException {
>   #define MHPMEVENT_IDX_MASK                 0xFFFFF
>   #define MHPMEVENT_SSCOF_RESVD              16
>   
> +/* RISC-V-specific interrupt pending bits. */
> +#define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
> +
>   /* JVT CSR bits */
>   #define JVT_MODE                           0x3F
>   #define JVT_BASE                           (~0x3F)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 750c0537ca..e5ffbbbd83 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -505,6 +505,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>       uint64_t vsbits, irq_delegated;
>       int virq;
>   
> +    /* Priority: RNMI > Other interrupt. */
> +    if (riscv_cpu_cfg(env)->ext_smrnmi) {
> +        /* If mnstatus.NMIE == 0, all interrupts are disabled. */
> +        if (!get_field(env->mnstatus, MNSTATUS_NMIE)) {
> +            return RISCV_EXCP_NONE;
> +        }
> +
> +        if (env->rnmip) {
> +            return ctz64(env->rnmip); /* since non-zero */
> +        }
> +    }
> +
>       /* Determine interrupt enable state of all privilege modes */
>       if (env->virt_enabled) {
>           mie = 1;
> @@ -567,7 +579,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>   
>   bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
> -    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +    uint32_t mask = CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
> +
> +    if (interrupt_request & mask) {
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
>           int interruptno = riscv_cpu_local_irq_pending(env);
> @@ -699,6 +713,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
>       env->geilen = geilen;
>   }
>   
> +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +    bool release_lock = false;
> +
> +    if (!bql_locked()) {
> +        release_lock = true;
> +        bql_lock();
> +    }
> +
> +    if (level) {
> +        env->rnmip |= 1 << irq;
> +        cpu_interrupt(cs, CPU_INTERRUPT_RNMI);
> +    } else {
> +        env->rnmip &= ~(1 << irq);
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_RNMI);
> +    }
> +
> +    if (release_lock) {
> +        bql_unlock();
> +    }
> +}
> +
>   int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
>   {
>       CPURISCVState *env = &cpu->env;
> @@ -1849,6 +1887,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>       bool write_gva = false;
>       bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
>       uint64_t s;
> +    int mode;
>   
>       /*
>        * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
> @@ -1867,6 +1906,23 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>       target_ulong mtval2 = 0;
>       int sxlen = 0;
>       int mxlen = 0;
> +    bool nnmi_excep = false;
> +
> +    if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
> +        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
> +        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV,
> +                                  env->virt_enabled);
> +        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP,
> +                                  env->priv);
> +        env->mncause = cause | ((target_ulong)1U << (TARGET_LONG_BITS - 1));
> +        env->mnepc = env->pc;
> +        env->pc = env->rnmi_irqvec;
> +
> +        /* Trapping to M mode, virt is disabled */
> +        riscv_cpu_set_mode(env, PRV_M, false);
> +
> +        return;
> +    }
>   
>       if (!async) {
>           /* set tval to badaddr for traps with address information */
> @@ -1960,8 +2016,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                     __func__, env->mhartid, async, cause, env->pc, tval,
>                     riscv_cpu_get_trap_name(cause, async));
>   
> -    if (env->priv <= PRV_S && cause < 64 &&
> -        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
> +    mode = env->priv <= PRV_S && cause < 64 &&
> +        (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
> +
> +    if (mode == PRV_S) {
>           /* handle the trap in S-mode */
>           /* save elp status */
>           if (cpu_get_fcfien(env)) {
> @@ -2016,6 +2074,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                     ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
>           riscv_cpu_set_mode(env, PRV_S, virt);
>       } else {
> +        /*
> +         * If the hart encounters an exception while executing in M-mode
> +         * with the mnstatus.NMIE bit clear, the exception is an RNMI exception.
> +         */
> +        nnmi_excep = cpu->cfg.ext_smrnmi &&
> +                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> +                     !async;
> +
>           /* handle the trap in M-mode */
>           /* save elp status */
>           if (cpu_get_fcfien(env)) {
> @@ -2049,8 +2115,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           env->mtval = tval;
>           env->mtval2 = mtval2;
>           env->mtinst = tinst;
> -        env->pc = (env->mtvec >> 2 << 2) +
> -                  ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
> +
> +        /*
> +         * For RNMI exception, program counter is set to the RNMI exception
> +         * trap handler address.
> +         */
> +        if (nnmi_excep) {
> +            env->pc = env->rnmi_excpvec;
> +        } else {
> +            env->pc = (env->mtvec >> 2 << 2) +
> +                      ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
> +        }
>           riscv_cpu_set_mode(env, PRV_M, virt);
>       }
>   


