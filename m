Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B32C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7c1W-0000ro-Um; Wed, 23 Apr 2025 11:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7c1V-0000rA-4g
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:28:29 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7c1S-0001fF-TK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:28:28 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so9930200a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745422105; x=1746026905; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cCLtZH3yIAfLfv91Tw9IjFXviCCLe4P5y5XxLIxfQkI=;
 b=lfnysI7fFGzwg2Pz6Kcyl2eBOiaHs3H1c/6lBWDIl5+3133QSDjQQpAtLINlYb3LY1
 ltWVEL1dl4Ukrlnuf2pxdl+NCHXs8/soTLp/NyTpfQm6hcwB4QgoZ/j/8m5jjJTdFJB7
 ouHr7ffZDx7K4CcRK79o6k+oN8OP/71hb30PG9uSqRVkNYne7tW5GMCVJ5uOm9uy0iPk
 rfKhTHAFvELPbwdNn44RWnhJ181SY6/aVdxFikqIjE9T+E04kyCflhh2WwHh3JCnrzQN
 sR29Pnf0JaY+B/rN7icDYIvV4yInzlWO6jQG7Vkp+bTe+KKknOVUapg/qFnx1VHnjwaH
 RrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745422105; x=1746026905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCLtZH3yIAfLfv91Tw9IjFXviCCLe4P5y5XxLIxfQkI=;
 b=XUkOPjIz520D6fgThJbp0W+wzAClvc+qGCxCauydEwh9l0v/rF9M1YAiOkr9Tuql3F
 XzULdiXW/rgPIC09mhzDkbcSnX5l8Wy2EwS8VLRvpcKiu1wJFIDYZvei6JdeihYs3Mr/
 Wwt19VRde3OeyRkn2nM79Z2vBG0vTY5h9O7zjfL2LOB3EgjpkyfGNMxmOXUevfkLHs2F
 uh+qoFGU2m6z3H9DVKFMb9qvzP92egvNc3gcZXCAUduI5/jsYjFq/12uxPcVRB9jWQV1
 GD7iZV7yCtqSExF+I7HOnX4aj7ccWOCAp9Ykcd18kLdgTFIrOgK34CpIvqfxM/rFiom0
 11fA==
X-Gm-Message-State: AOJu0Yy3xvWtN+W3RGIB8icAw15JyjwWXdsQFHt9krTvu0nsvR2AKJvi
 5YRWsYirqZhJdtZ7j0nHEX5bOiiqBAi9qZo8xsSlVOPEBfDwAGCXmOGfKnivpUY=
X-Gm-Gg: ASbGncuEBCPmfeaJYu+t3d/PNE46fAci1E5NOLl762T/juDk02od+zz4mmkCGx1u01D
 N8HcENFUhzExHznAUTccAH8tiy3VH8UtniyB/bowQKGO19bFhXBUHxdPp1Y8H/EO5UcW3PXkMg3
 4e/rGDIlAtr/s1IIu0KiF7qqnpLy9QN4cH8mROywCsKH/zFQcjq4nLYRCTiYmnAfrXlr5N23otK
 cV3mYpBDMsOfZb7dQGKK4dcEsqZS4pWPwSGcXgMhk90DTk1beXin7bXOn8TAbwMjhAaYruOEcYM
 d06ns6/mQYf5ivLm1gBV/Keo1CKyrAkh62iCszw=
X-Google-Smtp-Source: AGHT+IGIwFfGhorM4HBPVRXwlnI/z+Yj9X/ZhPqpsEK4noaxXRtCYCDG3YR9fygStol4b4Xpe9brOA==
X-Received: by 2002:a05:6402:5110:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5f62854878bmr17576465a12.15.1745422105191; 
 Wed, 23 Apr 2025 08:28:25 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f632be9742sm7148212a12.52.2025.04.23.08.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 08:28:24 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:28:24 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 abologna@redhat.com
Subject: Re: [PATCH 6/7] target/riscv/kvm: add missing KVM CSRs
Message-ID: <20250423-d3ca1926d6eb9b1d273b1367@orel>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
 <20250417124839.1870494-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417124839.1870494-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x530.google.com
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

On Thu, Apr 17, 2025 at 09:48:38AM -0300, Daniel Henrique Barboza wrote:
> We're missing scounteren and senvcfg CSRs, both already present in the
> KVM UAPI.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

The patch changed enough that it's not an r-b anymore, but it probably
should have been a reported-by in the first place anyway.

> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index ec74520872..a91a87b175 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -251,6 +251,11 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
>      KVM_CSR_CFG("stval", stval, sizeof(target_ulong), RISCV_CSR_REG(stval)),
>      KVM_CSR_CFG("sip", mip, sizeof(uint64_t), RISCV_CSR_REG(sip)),
>      KVM_CSR_CFG("satp", satp, sizeof(target_ulong), RISCV_CSR_REG(satp)),
> +    KVM_CSR_CFG("scounteren", scounteren, sizeof(uint32_t),
> +                RISCV_CSR_REG(scounteren)),
> +    KVM_CSR_CFG("senvcfg", senvcfg, sizeof(target_ulong),
> +                RISCV_CSR_REG(senvcfg)),
> +

Extra blank here and the sizeof() stuff should go away.

>  };
>  
>  static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
> @@ -696,6 +701,8 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>      env->stval = 0;
>      env->mip = 0;
>      env->satp = 0;
> +    env->scounteren = 0;
> +    env->senvcfg = 0;
>  }
>  
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
> -- 
> 2.49.0
>

Thanks,
drew

