Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27549C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7bz5-0007zQ-9j; Wed, 23 Apr 2025 11:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7bz3-0007y7-4S
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:25:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7byy-0001Ku-4j
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:25:56 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f435c9f2f9so9976493a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745421949; x=1746026749; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N9XFLyURVXSicUwGCKg4nBPzQzk0kTSF5sRULwHGko4=;
 b=iQGERg2rSZEDtSU1M/ke6iGNOXRmOlEMdrCRKLM9+woS4QqtPj4k/NdIydLJHqzV7d
 6P38zQjH9oSCmC5+8LwHrncZO/vfpYMbJkR/xKcWyfgmG/cuLYA8Q9lyTrP14u8FgeeW
 p3KaqweoR/R+xN3UIBs8kKJ4PdpP3lT4Pq1njYA+Z/rD1acl/YTlwkBjvoz5Az+PSkW3
 fOp6jbgqkVKtdM3zkOO+SNT40iU5iNxLF+L94WFg3bSz6iMDCOG+tegeF0M81+jusfNI
 zfdMEqnv3XdOyMrgpxoQhK1JHgcJc1+y4zJT1pQIzVx2X6GN2nHbC2h4lMeDHi4pNaiD
 lNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745421949; x=1746026749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9XFLyURVXSicUwGCKg4nBPzQzk0kTSF5sRULwHGko4=;
 b=HKExU8NZLRs+++bUutdMVULWQHPP1LvKVbduulfxTO80gJ+PXF3xTLrwYhFNpO31fN
 B0gkAn893ofK3SiHVqEAm2RBL5SjpvV5lmGfelhHt0RU79iMLLTFYKpPEHFsx80toXGu
 5a+Vu9qP4jhdVxsJuMJpqOrQ49s2FH1hRDy+WhuWFp5ztWeY4fhpQc58svhlD1MbveYF
 UN1w4tPYmapHmHGWmTa1IzPYSxIY+6v5UZ74a0aFuTNWZ7/NaNEi2CbZqd83P/c/sTX9
 aMZ9rEl3rNSG+MxJxQmF7p+jT7udDPJy7dpuqP7ojJ4X2DXkWs42B35GuYMCQ89IdBiZ
 kZiA==
X-Gm-Message-State: AOJu0Yxx8UKdNhR/fx0ifDRpH29JVsnzaMu+HoEdQ9C/L2AaspBk9Tol
 hYTaNQVUeX3vvSlPOOR13BFaB1G5hkvTsX/d6sUJscWkgGaRpx4bhyxqppxTj/A=
X-Gm-Gg: ASbGncvqd833pl/ODPjKS7tn1B3SuTZQbBm5G77DDfcMvbXrynXwFE98qE0x0/YZzuG
 lmkXtpbWDyGYiD12NGE0vlHOXou2WUSytsV+JlZPwAAjnJeXJA9F/DVIcfVNVoGDIhxWPx+wWrh
 ESCVYuXImUh3FHQsInD9n4U1RxDC36LxAYEssZy1Tcq0X8x9VLzh4LZPrFVYOl6EnRIC0fKTwGE
 MUm+3cdsvBMzG5m3b3rgVvYiw9EX39R0RPrFKKSB/45VIxzPH8fHcFesrLfztXN80kxv3JSFLaN
 c4pEVjjt2qNeEKQdiEGFkVhMAbba2NEQMD5zddA=
X-Google-Smtp-Source: AGHT+IFx32/SdIGPmSOZ4pkMUj22RxvCpyjvTNquD6FHqVeaGhA27GCvbQjZFxO9jCfGGt2nFPf46w==
X-Received: by 2002:a05:6402:40cf:b0:5e5:debf:3f09 with SMTP id
 4fb4d7f45d1cf-5f6285e8a81mr19434519a12.27.1745421949383; 
 Wed, 23 Apr 2025 08:25:49 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62594985bsm7627558a12.74.2025.04.23.08.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 08:25:48 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:25:48 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 abologna@redhat.com
Subject: Re: [PATCH 5/7] target/riscv/kvm: do not read unavailable CSRs
Message-ID: <20250423-a12702769cccc76e1e56feca@orel>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
 <20250417124839.1870494-6-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417124839.1870494-6-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x529.google.com
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

On Thu, Apr 17, 2025 at 09:48:37AM -0300, Daniel Henrique Barboza wrote:
> [1] reports that commit 4db19d5b21 broke a KVM guest running kernel 6.6.
> This happens because the kernel does not know 'senvcfg', making it
> unable to boot because QEMU is reading/wriiting it without any checks.
> 
> After converting the CSRs to do "automated" get/put reg procedures in
> the previous patch we can now scan for availability. Two functions are
> created:
> 
> - kvm_riscv_read_csr_cfg_legacy() will check if the CSR exists by brute
>   forcing KVM_GET_ONE_REG in each one of them, interpreting an EINVAL
>   return as indication that the CSR isn't available. This will be use in
>   absence of KVM_GET_REG_LIST;
> 
> - kvm_riscv_read_csr_cfg() will use the existing result of get_reg_list
>   to check if the CSRs ids are present.
> 
> kvm_riscv_init_multiext_cfg() is now kvm_riscv_init_multiext_csr_cfg()
> to reflect that the function is also dealing with CSRs.
> 
> [1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/
> 
> Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 63 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 99a4f01b15..ec74520872 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -638,6 +638,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>      for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>          KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>  
> +        if (!csr_cfg->supported) {
> +            continue;
> +        }
> +
>          ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
>          if (ret) {
>              return ret;
> @@ -662,6 +666,10 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>          KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>  
> +        if (!csr_cfg->supported) {
> +            continue;
> +        }
> +
>          if (csr_cfg->prop_size == sizeof(uint32_t)) {
>              reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
>          } else {
> @@ -1088,6 +1096,32 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
>      }
>  }
>  
> +static void kvm_riscv_read_csr_cfg_legacy(KVMScratchCPU *kvmcpu)
> +{
> +    uint64_t val;
> +    int i, ret;
> +
> +    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
> +        struct kvm_one_reg reg;
> +
> +        reg.id = csr_cfg->kvm_reg_id;
> +        reg.addr = (uint64_t)&val;
> +        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +        if (ret != 0) {
> +            if (errno == EINVAL) {
> +                csr_cfg->supported = false;
> +            } else {
> +                error_report("Unable to read KVM CSR %s: %s",
> +                             csr_cfg->name, strerror(errno));
> +                exit(EXIT_FAILURE);
> +            }
> +        } else {
> +            csr_cfg->supported = true;
> +        }
> +    }
> +}
> +
>  static int uint64_cmp(const void *a, const void *b)
>  {
>      uint64_t val1 = *(const uint64_t *)a;
> @@ -1144,7 +1178,27 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
>      }
>  }
>  
> -static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
> +static void kvm_riscv_read_csr_cfg(struct kvm_reg_list *reglist)
> +{
> +    struct kvm_reg_list *reg_search;
> +    uint64_t reg_id;
> +
> +    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
> +
> +        reg_id = csr_cfg->kvm_reg_id;
> +        reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
> +                             sizeof(uint64_t), uint64_cmp);
> +        if (!reg_search) {
> +            continue;
> +        }
> +
> +        csr_cfg->supported = true;
> +    }
> +}
> +
> +static void kvm_riscv_init_multiext_csr_cfg(RISCVCPU *cpu,
> +                                            KVMScratchCPU *kvmcpu)

I'm not sure we want to keep extending the name of this function with each
thing it does (and it does SBI as well, which isn't in the name). Maybe
just shorten it instead to kvm_riscv_init_cfg()?

>  {
>      KVMCPUConfig *multi_ext_cfg;
>      struct kvm_one_reg reg;
> @@ -1161,7 +1215,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>       * (EINVAL). Use read_legacy() in this case.
>       */
>      if (errno == EINVAL) {
> -        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
> +        kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
> +        kvm_riscv_read_csr_cfg_legacy(kvmcpu);
> +        return;
>      } else if (errno != E2BIG) {
>          /*
>           * E2BIG is an expected error message for the API since we
> @@ -1224,6 +1280,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>      }
>  
>      kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
> +    kvm_riscv_read_csr_cfg(reglist);

Shouldn't there be a g_free(reglist) here?

>  }
>  
>  static void riscv_init_kvm_registers(Object *cpu_obj)
> @@ -1237,7 +1294,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
>  
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
> -    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
> +    kvm_riscv_init_multiext_csr_cfg(cpu, &kvmcpu);
>  
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> -- 
> 2.49.0
> 
> 

Thanks,
drew

