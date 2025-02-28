Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068A3C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to08T-0003kd-0v; Fri, 28 Feb 2025 08:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to08Q-0003g1-DC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:10:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to08O-00081M-Ai
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:10:34 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-439a4dec9d5so22105015e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740748230; x=1741353030; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E2QnH5o6lgPeJQHV/ipzaYZh1DWE+6vrm6rUOmZoVvQ=;
 b=WjK5iUQGPfuAtuUFRDZCn2YR58c2FHlqFfb3BLqQRpxicbk7tTDOjeMTLA1PV5wY0N
 GcQz+7cFozFtoBJn6Xsl1UEWNH0XBWU6jdYlg+dsmIi9DBoY+p64Uuv6OvT46vtvbfRM
 2gEDbi35Hv9H0XGxYWgLDFKgS8kFfgMGf+GEnuhxSHoE25Hs4Rk0uOn5CAxmlCPceFjU
 GZYQW54xEJXiqjwoykvsyHTE2Wix0heBvAZuo1j9tLCtxpjZ75bL16VcLgvbIXoBK5Sr
 DW2d9PiSm/pgWKr8MYBgPlsLhCeKainlunf/yAIDTLrAtwqmdcFshdSVhIppDW4IDaSb
 oiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740748230; x=1741353030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2QnH5o6lgPeJQHV/ipzaYZh1DWE+6vrm6rUOmZoVvQ=;
 b=UbYRfw0t49ezBtwXTKQiqlCg7tPJ9E0cWISF3MDHsRCSwmz109AAtExoShVfTeZwEp
 yRLCzSAmPnf++Cly3IkRlGptIsAslHekBGBw0AwjlQKqEg+T/4LIhCaBx3SQtsM7WHVd
 ULeQc0Zyb7bfkx8U1N4Uv4r8EMhA20whCcuPme2Re7v3Yyeve16LLll0kq08hADsd4ir
 j/9n0okTPZj83Jj+JdPc/SaNbKiaBTSgHE06A/IROgWjOrJrBkuRO1vxuj9n1+I5Akls
 Gb0MGHjI9QUgKezP9R3M2pZObNDBgE2VxxqRe9YlSO3kNkC8WiKNUXaywMFQBKAbhGGj
 23XQ==
X-Gm-Message-State: AOJu0Yz0Jjw5xeydcdAkP81c7d5nIVmWjLykHhPbeRaHP/vAUmcNUh0A
 cTi0eJCzJMpiVJQOYhXUL3Eggdd/NXxSFdUwvS5Z4wnuf0DDD1oGuOsljD/sg0U=
X-Gm-Gg: ASbGncvTfSpZv5wFGwPDWVcLDZ1NZp353NNylrOTtJx8ZaAVHNqE9XPUtrhKPs7FTFV
 chskKmtaq9Wt9u7hVU/Cp8z4CVbm9pb7m/uX6pQmClajodjxmvTNrmz5eOn+zkbdzbp+VlPXf9u
 iqecOqQZUy6OhCK6FB9OyYoPyZwDc3Ax0oLGEX7BGkkspt2+wraA49krLm5EslnwXR7Jo4c/knI
 mvjrWHL9SG7ViIdyt7O/kySnDa5jvw/PiBi6HYG8/f8ka6GlWXSGXToNZpta/4B1hRk4Z4/mhex
 bIlyIvL8pixQlA==
X-Google-Smtp-Source: AGHT+IF95Az6f4ptfo+FiMlcd9ZLDE2Ef1Fkt6JH8PWeC9du+yU4jsFB8pH4O8zaBMhy/JewpiIb+w==
X-Received: by 2002:a05:600c:190d:b0:439:8b05:66a6 with SMTP id
 5b1f17b1804b1-43ba674c9a2mr30283245e9.22.1740748230302; 
 Fri, 28 Feb 2025 05:10:30 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b73717ac0sm55102405e9.20.2025.02.28.05.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:10:29 -0800 (PST)
Date: Fri, 28 Feb 2025 14:10:29 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/8] target/riscv/kvm: rewrite get/set for
 KVM_REG_RISCV_CSR
Message-ID: <20250228-0947621811d6951e12ae55ab@orel>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
 <20250224082417.31382-2-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224082417.31382-2-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
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

On Mon, Feb 24, 2025 at 04:24:08PM +0800, Yong-Xuan Wang wrote:
> As KVM_REG_RISCV_CSR includes several subtypes of CSR, rewrite the
> related macros and functions to prepare for other subtypes.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 70 +++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 471fd554b369..ff1211d2fe39 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -111,9 +111,8 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
>                             KVM_REG_RISCV_CORE_REG(name))
>  
> -#define RISCV_CSR_REG(env, name) \
> -    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, \
> -                           KVM_REG_RISCV_CSR_REG(name))
> +#define RISCV_CSR_REG(env, idx) \
> +    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, idx)
>  
>  #define RISCV_CONFIG_REG(env, name) \
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
> @@ -130,17 +129,20 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
>                             KVM_REG_RISCV_VECTOR_CSR_REG(name))
>  
> -#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
> +#define RISCV_GENERAL_CSR_REG(name) \
> +    (KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(name))
> +
> +#define KVM_RISCV_GET_CSR(cs, env, idx, reg) \
>      do { \
> -        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
> +        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
>          if (_ret) { \
>              return _ret; \
>          } \
>      } while (0)
>  
> -#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
> +#define KVM_RISCV_SET_CSR(cs, env, idx, reg) \
>      do { \
> -        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
> +        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
>          if (_ret) { \
>              return _ret; \
>          } \
> @@ -608,36 +610,50 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>      return ret;
>  }
>  
> -static int kvm_riscv_get_regs_csr(CPUState *cs)
> +static int kvm_riscv_get_regs_general_csr(CPUState *cs)
>  {
>      CPURISCVState *env = &RISCV_CPU(cs)->env;
>  
> -    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
> -    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
> -    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
> -    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
> -    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
> -    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
> -    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
> -    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
> -    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sstatus), env->mstatus);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sie), env->mie);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stvec), env->stvec);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sscratch), env->sscratch);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sepc), env->sepc);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(scause), env->scause);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stval), env->stval);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sip), env->mip);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_GENERAL_CSR_REG(satp), env->satp);
>  
>      return 0;
>  }
>  
> -static int kvm_riscv_put_regs_csr(CPUState *cs)
> +static int kvm_riscv_put_regs_general_csr(CPUState *cs)
>  {
>      CPURISCVState *env = &RISCV_CPU(cs)->env;
>  
> -    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
> -    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
> -    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
> -    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
> -    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
> -    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
> -    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
> -    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
> -    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sstatus), env->mstatus);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sie), env->mie);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stvec), env->stvec);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sscratch), env->sscratch);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sepc), env->sepc);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(scause), env->scause);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(stval), env->stval);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(sip), env->mip);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_GENERAL_CSR_REG(satp), env->satp);
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_get_regs_csr(CPUState *cs)
> +{
> +    kvm_riscv_get_regs_general_csr(cs);

KVM_RISCV_GET/SET_CSR() can return errors so the return value should be
checked here and below (just kvm_arch_get/put_registers() checks the
returns values of kvm_riscv_get/put_regs_csr()).

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_put_regs_csr(CPUState *cs)
> +{
> +    kvm_riscv_put_regs_general_csr(cs);
>  
>      return 0;
>  }
> -- 
> 2.17.1
> 

