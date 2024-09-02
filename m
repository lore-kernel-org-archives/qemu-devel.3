Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1B6CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4Oo-0000lk-Eh; Mon, 02 Sep 2024 06:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sl4OT-0000bk-PI
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:34:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sl4ON-0000kr-2j
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:34:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bc19e94bdso18193655e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725273273; x=1725878073;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3w7iZ/Y4L7ZjNAxJn5gUM3G+Cq0FPuARPEKbtKN5LO8=;
 b=J1tftsu0QA5QMDKgCas3NAWN1/OmxqyAU8n9zI5XADzAT7C29me1UeUgNT1Ec7RY0y
 2VjDFQepR8sEvzkuuRMl3FfX1E4VFJPYN7cbot19PsuUqMr3ads8HlUuAmcZQAiQz6pu
 QVtDSq/4dRTzVQfrBoW9Kch6KS+w5mZIhegFUNdjxpzIxC2/FlTHbzkpSSs+moUxv3t+
 fxcwCjt4HpPJuRvMzgSUMasdpbwiwm8SCvGhvid6wpZLEpzE9/xgnwXL9oV/9C72zrH9
 BqTIk+Ncs96GdnlMf2wBBpzZRd5RxNL8F5ugiCMKoqUblpSG/0N++cZza/YJsI6Pnkpc
 S25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725273273; x=1725878073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3w7iZ/Y4L7ZjNAxJn5gUM3G+Cq0FPuARPEKbtKN5LO8=;
 b=RQqyMnMU5GbbpoLj7jcIvSwgpljp5ZNUAhk54MNuynn+W2aptm7JDHZ0eHMfiHaZ8U
 onmT9WP31Ce9I6xQE8aEmpxNjb3HxK7QAP1ngIuG5pCKyx4/SjCHtulPv0/gdyF8SBjt
 wCoybk5d0N4XDdAFE/F5sjJeDeMisf26QyFXh54hS3O15bzs2bXVAM7+dPOTcBzkXVab
 MvA75ZijCXOXbnJKuhYfG+eiAVPO6BGi3MU4IMya4ucimEk91ipmsRKntMBQZODe0f33
 bI1n5kW4rDGOj7FWMfehUpXaAxKQ6H9izcgw2gxoelSe476ouC57KbQS+7VQwfw60dpY
 kLdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+fwGhgG1yLU+pwDLuiJC48p9gHNV9gBXA8Np3QA1efnUlWqj9zJzaiVPmdOSRZarty7s9lIsCkPOB@nongnu.org
X-Gm-Message-State: AOJu0Yzr9yZ14qTss2f+m0kV6JCGy8Gb0bMyphOIQGmuXF/Z3oJ+8hMC
 NmGFDQnqODXiCqhkNbUSnctX3qkQwI9izXCXtS61nBFujawxVBhl5UL7vww7S70=
X-Google-Smtp-Source: AGHT+IEVZvErh27zs3aifE1ADYpkd7xDdYeByZsp9pm3MmUbthw0V54afouHBKrE2uOuU/sSMKOo0g==
X-Received: by 2002:a05:600c:1389:b0:428:ea8e:b48a with SMTP id
 5b1f17b1804b1-42bb01ae3b1mr103740785e9.8.1725273272010; 
 Mon, 02 Sep 2024 03:34:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e367b3sm132452655e9.48.2024.09.02.03.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 03:34:31 -0700 (PDT)
Message-ID: <c348c088-d72e-402a-a640-23b74af009c4@rivosinc.com>
Date: Mon, 2 Sep 2024 12:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] target/riscv: Handle Smrnmi interrupt and
 exception.
To: Tommy Wu <tommy.wu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, ajones@ventanamicro.com
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
 <20240902071358.1061693-3-tommy.wu@sifive.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240902071358.1061693-3-tommy.wu@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 02/09/2024 09:13, Tommy Wu wrote:
> Because the RNMI interrupt trap handler address is implementation defined.
> We add the `rnmi-interrupt-vector` and `rnmi-exception-vector` as the property
> of the harts. It’s very easy for users to set the address based on their
> expectation. This patch also adds the functionality to handle the RNMI signals.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---
>  hw/riscv/riscv_hart.c         | 18 ++++++++
>  include/hw/riscv/riscv_hart.h |  4 ++
>  target/riscv/cpu.c            | 11 +++++
>  target/riscv/cpu.h            |  6 +++
>  target/riscv/cpu_bits.h       | 12 ++++++
>  target/riscv/cpu_helper.c     | 80 ++++++++++++++++++++++++++++++++---
>  6 files changed, 126 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 613ea2aaa0..b7d73f7a82 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -33,6 +33,12 @@ static Property riscv_harts_props[] = {
>      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
>      DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
>                         DEFAULT_RSTVEC),
> +    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
> +                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
> +                      uint64_t),
> +    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
> +                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
> +                      uint64_t),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -47,6 +53,18 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>  {
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
>      qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
> +    if (s->harts[idx].cfg.ext_smrnmi) {
> +        if (s->rnmi_irqvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-interrupt-vector",
> +                                 s->rnmi_irqvec[idx]);
> +        }
> +        if (s->rnmi_excpvec) {
> +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> +                                 "rnmi-exception-vector",
> +                                 s->rnmi_excpvec[idx]);
> +        }
> +    }
>      s->harts[idx].env.mhartid = s->hartid_base + idx;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
>      return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
> diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
> index 912b4a2682..a6ed73a195 100644
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -38,6 +38,10 @@ struct RISCVHartArrayState {
>      uint32_t hartid_base;
>      char *cpu_type;
>      uint64_t resetvec;
> +    uint32_t num_rnmi_irqvec;
> +    uint64_t *rnmi_irqvec;
> +    uint32_t num_rnmi_excpvec;
> +    uint64_t *rnmi_excpvec;
>      RISCVCPU *harts;
>  };
>  
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..2f64b3df22 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1309,6 +1309,11 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>          g_assert_not_reached();
>      }
>  }
> +
> +static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> +{
> +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
> +}
>  #endif /* CONFIG_USER_ONLY */
>  
>  static bool riscv_cpu_is_dynamic(Object *cpu_obj)
> @@ -1332,6 +1337,8 @@ static void riscv_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
>                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> +                            "riscv.cpu.rnmi", RNMI_MAX);
>  #endif /* CONFIG_USER_ONLY */
>  
>      general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
> @@ -2681,6 +2688,10 @@ static Property riscv_cpu_properties[] = {
>  
>  #ifndef CONFIG_USER_ONLY
>      DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
> +    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU, env.rnmi_irqvec,
> +                       DEFAULT_RNMI_IRQVEC),
> +    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpvec,
> +                       DEFAULT_RNMI_EXCPVEC),
>  #endif
>  
>      DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string, false),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1619c3acb6..d8ad04ec31 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -472,6 +472,11 @@ struct CPUArchState {
>      uint64_t kvm_timer_state;
>      uint64_t kvm_timer_frequency;
>  #endif /* CONFIG_KVM */
> +
> +    /* RNMI */
> +    target_ulong rnmip;
> +    uint64_t rnmi_irqvec;
> +    uint64_t rnmi_excpvec;
>  };
>  
>  /*
> @@ -568,6 +573,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
>  uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
>                                uint64_t value);
> +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
>  void riscv_cpu_interrupt(CPURISCVState *env);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
>  void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 32b068f18a..e14b654c35 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -662,6 +662,12 @@ typedef enum {
>  /* Default Reset Vector address */
>  #define DEFAULT_RSTVEC      0x1000
>  
> +/* Default RNMI Interrupt Vector address */
> +#define DEFAULT_RNMI_IRQVEC     0x0
> +
> +/* Default RNMI Exception Vector address */
> +#define DEFAULT_RNMI_EXCPVEC    0x0
> +
>  /* Exception causes */
>  typedef enum RISCVException {
>      RISCV_EXCP_NONE = -1, /* sentinel value */
> @@ -711,6 +717,9 @@ typedef enum RISCVException {
>  /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>  #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>  
> +/* RNMI causes */
> +#define RNMI_MAX                           16
> +
>  /* mip masks */
>  #define MIP_USIP                           (1 << IRQ_U_SOFT)
>  #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> @@ -942,6 +951,9 @@ typedef enum RISCVException {
>  #define MHPMEVENT_IDX_MASK                 0xFFFFF
>  #define MHPMEVENT_SSCOF_RESVD              16
>  
> +/* RISC-V-specific interrupt pending bits. */
> +#define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
> +
>  /* JVT CSR bits */
>  #define JVT_MODE                           0x3F
>  #define JVT_BASE                           (~0x3F)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d9140..9d0400035f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -434,6 +434,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>      uint64_t vsbits, irq_delegated;
>      int virq;
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
>      /* Determine interrupt enable state of all privilege modes */
>      if (env->virt_enabled) {
>          mie = 1;
> @@ -496,7 +508,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>  
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
> -    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +    uint32_t mask = CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
> +
> +    if (interrupt_request & mask) {
>          RISCVCPU *cpu = RISCV_CPU(cs);
>          CPURISCVState *env = &cpu->env;
>          int interruptno = riscv_cpu_local_irq_pending(env);
> @@ -619,6 +633,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
>      env->geilen = geilen;
>  }
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
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
>  {
>      CPURISCVState *env = &cpu->env;
> @@ -1654,6 +1692,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      bool virt = env->virt_enabled;
>      bool write_gva = false;
>      uint64_t s;
> +    int mode;
>  
>      /*
>       * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
> @@ -1670,6 +1709,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong tinst = 0;
>      target_ulong htval = 0;
>      target_ulong mtval2 = 0;
> +    bool nmi_execp = false;
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
> +        riscv_cpu_set_mode(env, PRV_M, virt);
> +        return;
> +    }
>  
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
> @@ -1755,8 +1808,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                    __func__, env->mhartid, async, cause, env->pc, tval,
>                    riscv_cpu_get_trap_name(cause, async));
>  
> -    if (env->priv <= PRV_S && cause < 64 &&
> -        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
> +    mode = env->priv <= PRV_S && cause < 64 &&
> +        (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
> +
> +    /*
> +     * If the hart encounters an exception while executing in M-mode,
> +     * with the mnstatus.NMIE bit clear, the program counter is set to
> +     * the RNMI exception trap handler address.
> +     */
> +    nmi_execp = cpu->cfg.ext_smrnmi &&
> +                !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> +                !async &&
> +                mode == PRV_M;

Since nmi_excep is only use in the else statement (mode == PRV_M), maybe
it would be better to move the computation there. And it will also allow
to get rid of the mode == PRV_M check in the boolean expression.

BTW, I think the variable should be named "nnmi_excep" rather than
"nmi_execp".

Thanks,

Clément

> +
> +    if (mode == PRV_S) {
>          /* handle the trap in S-mode */
>          if (riscv_has_ext(env, RVH)) {
>              uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
> @@ -1832,8 +1897,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mtval = tval;
>          env->mtval2 = mtval2;
>          env->mtinst = tinst;
> -        env->pc = (env->mtvec >> 2 << 2) +
> -                  ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
> +
> +        if (cpu->cfg.ext_smrnmi && nmi_execp) {
> +            env->pc = env->rnmi_excpvec;
> +        } else {
> +            env->pc = (env->mtvec >> 2 << 2) +
> +                      ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
> +        }
>          riscv_cpu_set_mode(env, PRV_M, virt);
>      }
>  


