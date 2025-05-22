Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EB8C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 11:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3l9-0008Jd-Vl; Thu, 22 May 2025 07:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uI3l4-0008Iq-0u
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:06:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uI3kz-000344-QZ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:06:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a375d758a0so3141124f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747911995; x=1748516795; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EmkKu4dXe17v+ipMwHVL5iZj6DkLedZ1oACq7kJUUco=;
 b=krLV4YoiVgzFbbCxiQCv/zfx1ZISXE2Dngkbo6HqTz/6ytGU2zcv0tZ8eWppT1/fDR
 8VWQjyfArALKC3/ru5H4GAWtwEwmhMkOWrgtdmW5FXNPHJQL/u/aPzgFHwuKbopeabtg
 D/VbqD5H4yWyKeJXhcKnsKj/HwwtHrbG5pmIwL2TOx74AR0aW/b9s+8bZBWXX//Uy/yn
 dzAuDD9IOUS/qoEs2pUy9UD1z7Q8tdyPI73nTulDnybfDr0AISkd90gEylLKDRC5eWov
 h1/sQAa0ZGtdVLDGU84vIkgFQZOxqGDXMLA3gDv5oVT4i+7Y17XjgVHh65SPD1YUYO+y
 V7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747911995; x=1748516795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmkKu4dXe17v+ipMwHVL5iZj6DkLedZ1oACq7kJUUco=;
 b=mRswxMs+vWADNSX13++ppRaQJlSr4tH9Dn6sy4CHBd5vRBnhdhRJPQgWY7LimA59g3
 WyyrCUkohqHpdV5ktx/J3gt7VlXskcVJ21k8UwZOuTOcfOAHBDQcXLjvlXGiPpP1Z56I
 ZVQWU24xyowjwwO/aiPgyfic7lOQXHr6Q7Nb9LFJxE14MJdbmGt+6KAOX9u5KFJ69m9O
 o7tW5UNhpeViaStAKmSCUyhGV4XMcWSHoJLnpWtEMAVfhGba4OpIGVMHiYI/qpSQ0O9t
 5WTmTgWNa3LKPDN7ooglVGwQvW6l8uMFRIPqLNGCLSSOuW0Z/3wagVUnY6D8SfnDqS60
 UvVQ==
X-Gm-Message-State: AOJu0Yx0i46oda3RIR/5Ym2+wPFm2566dDWUf3zCA5JIIqeJPSVb6hA4
 K51LGgaNue6oY6rrFFgTz9pRo9h3anVrmejlv6OVJpZEpZMkO/6HoziZGbC6M4fp9vE=
X-Gm-Gg: ASbGncs2qR1qbxHKsro/p7JdE9xuHctD+s/uxXDzRLy8qCSYB3kNfwNAxi9zl4N7XcH
 laprdI4C+1+jYNihDNxTgKu1Z+QUNkeel85ACLQwTzKOwORe1DKskwjWTvbDZPRjqGWMkaS03+a
 UnWpuB/pG86N/Qtj0n0ubewAQiCGTgX6L6syxMl7tm+rd0OrRIa5hHR6p0WedCpicjZYzy3lIqg
 230LYxJQyj9Nx2pmidNMLYrTLQC/vS4GJtgZ5UjwbGXRIjClWnBgtWJS6VbF/BQle3PoNXHU4lw
 a6p4LmyumlV/lhzWDwbJ7dVgtNRxiNHMbAj78bg=
X-Google-Smtp-Source: AGHT+IEOfE7awJOz9bcfOBx6FnE7FNgOt/04FSZfhMvO3f0uNsodmDkWxN+Y2WJgXauWehreSTlJug==
X-Received: by 2002:a05:6000:2907:b0:3a3:64b7:620b with SMTP id
 ffacd0b85a97d-3a364b7643cmr18553751f8f.20.1747911995488; 
 Thu, 22 May 2025 04:06:35 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d305sm23197700f8f.16.2025.05.22.04.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 04:06:35 -0700 (PDT)
Date: Thu, 22 May 2025 13:06:34 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v4] target/riscv/kvm: add satp mode for host cpu
Message-ID: <20250522-e8815a2dbdeedbb6ea9fdd7a@orel>
References: <20250522101320.96217-1-mengzhuo@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522101320.96217-1-mengzhuo@iscas.ac.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x429.google.com
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

On Thu, May 22, 2025 at 06:13:20PM +0800, Meng Zhuo wrote:
> This patch adds host satp mode while kvm/host cpu satp mode is not
> set.
> 
> This patch not change the output of errno nor errno strings pattern
> like other functions do. See [v3] for further information.
> 
> Change in v4:
> - Adds changelog in commit message
> - Link to v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg04629.html
> 
> Change in v3:
> - Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>   as requested
> - Link to v2: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/msg05203.html
> 
> Changes in v2:
> - use set_satp_mode_max_supported instead of hard code
> - Link to v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/msg05094.html
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>

I gave my r-b on the last version of this patch (please include those when
posting again without major changes), here it is again

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

drew

> ---
>  target/riscv/cpu.c         |  3 +--
>  target/riscv/cpu.h         |  1 +
>  target/riscv/kvm/kvm-cpu.c | 20 +++++++++++++++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d92874baa0..a84edd3a3b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -433,8 +433,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
>      g_assert_not_reached();
>  }
>  
> -static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        uint8_t satp_mode)
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode)
>  {
>      bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
>      const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b56d3afa69..d7136f1d72 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -915,6 +915,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
>  
>  void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  void riscv_add_satp_mode_properties(Object *obj);
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>  
>  /* CSR function table */
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 82f9728636..18fbca1a08 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -999,6 +999,23 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
>      close(scratch->kvmfd);
>  }
>  
> +static void kvm_riscv_init_satp_mode(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    struct kvm_one_reg reg;
> +    int ret;
> +    uint64_t val;
> +
> +    reg.id = RISCV_CONFIG_REG(env, satp_mode);
> +    reg.addr = (uint64_t)&val;
> +    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +    if (ret != 0) {
> +        error_report("Unable to retrieve satp from host, error %d", ret);
> +    }
> +
> +    set_satp_mode_max_supported(cpu, val);
> +}
> +
>  static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>  {
>      struct kvm_one_reg reg;
> @@ -1302,6 +1319,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
>      kvm_riscv_init_cfg(cpu, &kvmcpu);
> +    kvm_riscv_init_satp_mode(cpu, &kvmcpu);
>  
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> @@ -1980,7 +1998,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>          }
>      }
>  
> -   return true;
> +    return true;
>  }
>  
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
> -- 
> 2.39.5
> 
> 

