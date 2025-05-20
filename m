Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1089BC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLcX-0003AD-H7; Tue, 20 May 2025 07:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHLcU-00039e-DD
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:58:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHLcQ-0006AJ-3T
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:58:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a374f727dbso1297253f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747742328; x=1748347128; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ekay5ATUmymj64lvw47pKScSIpuDbkuWCdB08R8tMnQ=;
 b=EriRlAd4+8QdcFqGVC03XT8l23lYXF3qURW7yHvFcLHLNg9q+qp8iz2Rl5NbefIKsT
 2Ky2WD7KkEOgTHid7IQnNM6HNXj+WRezI7Xeg0PWmQ+/fmb3bthFoM54aFH9/90Gi2Xb
 prRfhCVpdpb/s9lRDTxuHmvccFWhNgEZAp9TX2UAFHnH+QNFa3rzHj4wD47cmhGATH5p
 4DSicg1beR6uBQAmhWJVS6AGLDRNpYRYhDqF9dZnde+z45lBby+hYKUrJ0i1kw0K0DDc
 gEDCsKwCejUeFlEIpgyRbSXMvkh1Nvja7rxae5VeS9unWhV9mYoDINe743AbOTCPvWVk
 Fo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747742328; x=1748347128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ekay5ATUmymj64lvw47pKScSIpuDbkuWCdB08R8tMnQ=;
 b=p2rwXfBZ+b9FvSg5anvNFV6iyMwgUDyqzPfPmL1AaqP8zZYCHdt8zMxSek4BlmTy+5
 hj+kx4WJurnHkVEbsTyO6qpLxSrc8yFUNeEuDBRBUdTiu7599lmk3kyA4Iz6KcMJSzNV
 AmpmJNzbkxcTSpba5OBDlPmBLSpCkaRAJEaWCfxOHwIeGbxqfOsNvjQ8cmfd0GaBGT+G
 J5fBGQo3CdB+zEY7W5DJu8DlVGbv/B9/7TqyPwGpk0qBckZ7WMbD4rLSdXji17/ysLVN
 7ZLOhWqTch560vlgdUYl0maEN5pLgi6egOcUUn0h7aIKEcapnu+Ar0EEbbkFmU7xCBzR
 gnkw==
X-Gm-Message-State: AOJu0YwVELdLby4lPMgqgSWKqLilE749jA8/l5pELX7bNqy7qfO1PPfE
 Cut+EGxlpMu9WHtTKXKm7Ss6pVUhUuXRJIf2VYDavQdaK8hLVl7rE4lI9jRQb184Imo=
X-Gm-Gg: ASbGnctjMQtjdRcf77SWKn+NRc1O01jN2gEvFyDiFLlmiVf99yPLEXXTu2Yl+/NoDBv
 yKBjP0kf0J5NZ1ItngT/DLzb6ngHv4WhO7qXYkoeykGobt0ItzwP8o3I9ONcDDI3Ai0fQvcCQIV
 Zx0E4gCS19jzK3d3rIUg5huZbsjzyYgSsSG9/RdMEGVQFEEDRgRHr+8FLFilnVXeBgIW7+DicQo
 MopQuWdqzEeL0nRrGafbWuXgYM0yDlALWx0HGHC0H/713u7s1f/9kxatzmR7x6XrB9n5vxF1Kvv
 BmbUBuUR9WCpY4aPqLbumxn3Y5x1Z9LySlMxG50=
X-Google-Smtp-Source: AGHT+IEyUlizeWlJwTbUjKMYgA0bvJv70xzG8fLemSfdgwV58z61OxcIxi7yXV4PwmnReBxpRvYrnQ==
X-Received: by 2002:a5d:64c7:0:b0:3a3:6584:3fa1 with SMTP id
 ffacd0b85a97d-3a365844ba6mr12791010f8f.44.1747742327240; 
 Tue, 20 May 2025 04:58:47 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a360b0b766sm15862603f8f.56.2025.05.20.04.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:58:46 -0700 (PDT)
Date: Tue, 20 May 2025 13:58:45 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3] target/riscv/kvm: add satp mode for host cpu
Message-ID: <20250520-317e19aeb55fa93e30941e63@orel>
References: <20250520104103.89736-1-mengzhuo@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520104103.89736-1-mengzhuo@iscas.ac.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42d.google.com
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

On Tue, May 20, 2025 at 06:41:03PM +0800, Meng Zhuo wrote:
> This patch adds host satp mode while kvm/host cpu satp mode is not
> set.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
> ---

Please provide a changelog here. I had to go reread the comments on v1 to
guess at what might have changed.

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

In v1 I suggested we add some sanity checking to this function to ensure
we can never set an invalid mode (one that's higher than the max
supported).

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

This will output "Unable..., error -1" on error. We should output at least
the errno and preferably the errno string. I see that this is just a copy
of a pattern used throughout this file though, so we need a patch fixing
all of the ioctl call error_reports.

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

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

