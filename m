Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0827FC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9grg-0005eR-Lf; Tue, 29 Apr 2025 05:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9gr4-0004wT-6C
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:02:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9gqz-0001xD-HO
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:02:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso4193196f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745917326; x=1746522126; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XyA0tMwCI7b12RVauWthMdgxj8PnsEqcTlJi3RVP+I8=;
 b=U1GPX45IR7nlbmmi3ImSq/xQ5ONx0/RGX9D3YhCRRUDd+atpwWjuhOSZbMS6tthFFx
 /zGCVx3SOA7XceFdUw5UUvbxPV7Z1xRIjGOjf98tCSBJBtATp1+7/YW7EbvxnBOaCDQ3
 5EADl84rl+dfkGiXN7/H2CS4QUjj7qbsoSIJPCh3/mF1nmEsSGUJXV2JlOzw+LHGj++7
 yQf8AoVA1mREvPenO6bwdhpabkInxzQM5pvAYYkcARAZSV7UihlW44tCvrvxK3aymuml
 d51kiHyuDjkt8OOBqco6vwXdRAcuQJpr8mNsM8UXsbUD3S5Hj5H0Gty7UiDuqxxTEhxP
 94uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745917326; x=1746522126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyA0tMwCI7b12RVauWthMdgxj8PnsEqcTlJi3RVP+I8=;
 b=ciec9TqqnoGRSH4/QkYSV7z4Z4qlrQmudb0gruLeHJA4n4pDg6J3zA/yC/ms/GKrAY
 sPs05cFJAH1O3BfPIq3l5NrJD03Tyor5LNOKO1TeC23/NM9b4TN0AaaXZGDnwdiBo30h
 fDRaUjrANMqtn5n4hKh4sHZcLJ1HLPzT/jh1jbgZTfWbXrsihVrUwx1cg/lZABRxs5Kw
 7+9HKn8XJ8LE4792qXGpi786/UzlkUAKlbjtr+gaHI8OvzIaq351xudoxY5e7bjKaG4e
 D/QViIBlu1MuFej7chI+Di61j9I5rp6d4eQIKb8/GwS7HeZ9k/JVRsjSk4drXhALqGUt
 ZzOg==
X-Gm-Message-State: AOJu0Yww+c6BYDlI/SbsQhUk23yQ0M2o/lDT/E4cc6PC5fOLCO1PLNIF
 0yfiZolzM7fsnsnIMJtRimE2kEKJXAZYBSUovYFSWtxDWCoIUAkEeehPqp7WiNI=
X-Gm-Gg: ASbGncurKNdaybaWSgbcjh+03HLD5yniE6HlEB98m92BeLKbiND2Un4GbQ5IgZXg0cI
 VW1VJuRm4xMPZKtFNDaYKAFHJFhs3pC4Qsr5yBab6EocKV3G4NcEsCZftCjBzDdTN2N0vqO0OQ1
 azNWgKy0YP8lmuCbsGpPpqNneDEJWucgxSePfbKX4jl1PxArcQnKWAPvw8Ufe2rUCRUVQ9ZpZpd
 iWb2u8osQuSfmfk7L55f9MhabPM3aJd29IcRt7KOZhbsHIdQT5qQKsj0KE5QSoQhxKG7TtmH9sP
 OFlHdHVrilQRjd7Hnkz/hDyRFf+k
X-Google-Smtp-Source: AGHT+IFPfPS9rJomZxUj1s5cv3VfTlrEXwJIA27+Dwu0cnh7O9dAIYpf71vQuFvcRg+oVO7UNnFOpg==
X-Received: by 2002:a05:6000:2907:b0:3a0:7a7c:27d0 with SMTP id
 ffacd0b85a97d-3a07ab85ba7mr10202121f8f.45.1745917326248; 
 Tue, 29 Apr 2025 02:02:06 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbf04dsm13577028f8f.52.2025.04.29.02.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 02:02:05 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:02:05 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH v4 8/9] target/riscv/kvm: read/write KVM regs via env size
Message-ID: <20250429-cfab3ab0131af8d6da2f0a14@orel>
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
 <20250428192323.84992-9-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428192323.84992-9-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x436.google.com
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

On Mon, Apr 28, 2025 at 04:23:22PM -0300, Daniel Henrique Barboza wrote:
> We're going to add support for scounteren in the next patch. KVM defines
> as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
> field. This will cause the current code to read/write a 64 bit CSR in a
> 32 bit field when running in a 64 bit CPU.
> 
> To prevent that, change the current logic to honor the size of the QEMU
> storage instead of the KVM CSR reg.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5efee8adb2..53c34b43a2 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
>      const char *description;
>      target_ulong offset;
>      uint64_t kvm_reg_id;
> +    uint32_t prop_size;
>      bool user_set;
>      bool supported;
>  } KVMCPUConfig;
> @@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
>  
>  #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
>      {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
> +     .prop_size = sizeof(((CPURISCVState *)0)->_env_prop), \
>       .kvm_reg_id = reg_id}
>  
>  static KVMCPUConfig kvm_csr_cfgs[] = {
> @@ -632,6 +634,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      uint64_t reg;
> +    uint32_t reg32;

We don't need this variable.

>      int i, ret;
>  
>      for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> @@ -646,9 +649,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>              return ret;
>          }
>  
> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
> -            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
> +            reg32 = reg & 0xFFFF;

This is masking off too many bits. We want the lower 32, not just the
lower 16.

> +            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg32);

If the compiler warns when giving this function reg, then we can cast it.

 kvm_cpu_csr_set_u32(cpu, csr_cfg, (uint32_t)reg);

otherwise we don't need to do anything special.

> +        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
>              kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
>          } else {
>              g_assert_not_reached();
> @@ -671,9 +675,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>              continue;
>          }
>  
> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
>              reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
> +        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
>              reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
>          } else {
>              g_assert_not_reached();
> -- 
> 2.49.0
>

Thanks,
drew

