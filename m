Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEC4C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlOfX-0001N0-BV; Fri, 21 Feb 2025 03:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlOfH-00015I-Ht
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:45:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlOfD-0002Kl-6A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:45:43 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-439a2780b44so11377405e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 00:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740127537; x=1740732337; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HW4cB7zY+a/g+kKXEB06zgRHhOYLfuD5pJeV64/vSDw=;
 b=irpmHSLaAhWD0DCeWePYDSLBHSbiEEnHnx9qV7JxEEx4IX2k9WHmlYzxjJwugFjdKT
 9Xi+5Iq2360rT0aD58WTDWLjMldvLEfr10NzFMKEK0RjYkQWAGdSuTPM//+qYLDXdQKd
 owWhjqJZfQoXPbKZHcUVRk0x1SCTEkEtjeS5+/JDq+2WhwTDt6mPEhRBZ6iQ6CKxs0ET
 VsJ81wyMaGOAObU7RlzQBa7TuONj9eeWliNXx58X+5FjgF+XTeCQbScRvyNGU8T793Sd
 x1TrH3IDc0xo3NdWUIriKag27jCYYOf9QepUNk7+sSDQj+CYDN1g5pgoV734Spbt0Fo1
 2Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740127537; x=1740732337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HW4cB7zY+a/g+kKXEB06zgRHhOYLfuD5pJeV64/vSDw=;
 b=OpQ6opra/hRvyKj0XbjUAhT8raxcKwYcrPo1pyAZNanCpvIst+GHwbJFsW1hnXRBRG
 SZ2c8Jx0diRvr+FP0lufT5iGjSjumKfIHo3tEy1ge34drYoTu+K+1TYpP6M+w059QjZd
 fe62Ur3NDD0cy4rv8igqUeUnyftuYSKvghs/30mlG8bve1OYjHMRE/iQ2kVsqlS3q/Ng
 SPYyOVRtaqXQE4t+nt6dCYTSC7NjpEtk6wTTJgMV9KJFO0YeTmTw4pSlPO0BQkzNnDux
 /Cvxn5yB1F9Q0vuxKS6GUV9VF8aWQ4U2OsTEl9mq3IJFdodtaBz8On/A8c2GEWCEQxXE
 E3sg==
X-Gm-Message-State: AOJu0YxxUiva1Ky2hzeaxv5dKvkooab/2xW3HJgscBjytn018uo/0pW3
 a9eYiuS0MJiX12unl/NvcyLFj5F3rO+wQwjdxTs/nugDMTH+TdA7gG2ULsGqycU=
X-Gm-Gg: ASbGncsct0C2wO03WCQOgHpAoNF4McjyCTDcjMUuuaAwinLP6HMUJLBPIutYMMRV70q
 lU/W3pQrGlISVrYJ5NHq27xqylEex96JIp1zW2TZZdbanAhNaG9O57JAEeTlG42bB3pu6UwOQfP
 DSqUNulaIDsIBWo/BIsp82+F9mxBlcQKwz8JbjaYJR2TizQikpaAdMfPF9Dz7eduD0tZkQL0JfY
 cd0cE22kiOw8iTFMiofnt8fbFVswrzWWBGMs4bXhqBIYSqqq+VdcVNrOCdr/avHksTfF9v/WNoW
 FVev424d1G/jKg==
X-Google-Smtp-Source: AGHT+IHxppOqllza0Vk46hLx6ehT443j0OfTzsOjcpUwENTCA/MbdXM6mP/AcK37oGeagbS/jYHuog==
X-Received: by 2002:a05:600c:19cc:b0:439:5766:7232 with SMTP id
 5b1f17b1804b1-439ae212996mr16144455e9.21.1740127537122; 
 Fri, 21 Feb 2025 00:45:37 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030be5esm10376675e9.30.2025.02.21.00.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 00:45:36 -0800 (PST)
Date: Fri, 21 Feb 2025 09:45:35 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 3/3] target/riscv/kvm: reset all available KVM CSRs in
 kvm_reset()
Message-ID: <20250221-1fab8b0e1e23a31880880f11@orel>
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
 <20250220161313.127376-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220161313.127376-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
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

On Thu, Feb 20, 2025 at 01:13:13PM -0300, Daniel Henrique Barboza wrote:
> Explictly reset env->mstatus and env->sie.

mie was already getting set to zero, so that should have just been renamed
in the last patch, but I still think we should drop the last patch.

> Add a comment about env->mip
> being read/written into KVM 'sip' CSR.
> 
> We're also not read/writing 'scounteren' which is available in the KVM
> UAPI. Add it in kvm_reset() and get/put_regs_csr().
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index fea03f3657..ee7a9295b4 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -618,6 +618,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>      KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);

senvcfg is also missing.

>  
>      return 0;
>  }
> @@ -635,6 +636,7 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
>  
>      return 0;
>  }
> @@ -1609,6 +1611,10 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      env->pc = cpu->env.kernel_addr;
>      env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
>      env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
> +
> +    /* sstatus is read/written into mstatus */

How about just a single comment above this function stating that we
reset all registers that we will s/r with csr get/put. Interested
parties can go look at get or put to see the mappings.

> +    env->mstatus = 0;
> +    env->sie = 0;
>      env->satp = 0;
>      env->mie = 0;
>      env->stvec = 0;
> @@ -1616,7 +1622,9 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      env->sepc = 0;
>      env->scause = 0;
>      env->stval = 0;
> +    /* sip is read/written into mip */
>      env->mip = 0;
> +    env->scounteren = 0;
>  }
>  
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
> -- 
> 2.48.1
> 
>

Thanks,
drew

