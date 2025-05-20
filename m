Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E70C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLtc-0008C9-G0; Tue, 20 May 2025 08:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHLta-0008Bm-Ps
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:16:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHLtV-0001Z3-Bs
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:16:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so44894015e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747743386; x=1748348186; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HO/OrTsRI4p9tXH5hOvU9I/gpjQf9bZBJeHuWpqaUKg=;
 b=YjKKWv/hp97pwg/FusvnTehxt9Haq9NMxCP814ISaZvVqoeqlvKEk18bpFi5UbcZ1K
 RNA2xSexXc3U5FjmI4GuvvF+6Nd/yJqLIK68gcWh57UkszHSu93cdSzZUBIc/in+lDTr
 5zXtLH6liX5hNrHH0POOEnHm8qick9ZNwKdK3dwl01eaDPyE6R83dKAwiBgC6Bs9y8Tj
 wNvB1BRGzyXuTuFXJinW5KvEtN9zux5/5JLTgZa5tr9a667N5AOjB41OE85eTmyS9NoL
 wtkAmA9VH/XVhpCVCfhGh58+bmG3N4OBhLSdgnt/5hw2OQe4yJXLlPz1w1ZpuH9Y+6Sn
 3NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747743386; x=1748348186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HO/OrTsRI4p9tXH5hOvU9I/gpjQf9bZBJeHuWpqaUKg=;
 b=AGF7LFmyR7gCTGVWATMrP/q76VByoYrrpcWy/ilgWEGeF61uQSxZfxeBfYDevQ0Idc
 LITuB+NXci6sLiEq6OpXNV2SC0sGqzUxorNkcgosGtHUKiZqgpt87uUJqvJpYKct59fj
 fDdZQH2Ybt2eLJcKISrntSq4jRtTZMSegvvVR/RPlJHVScTDk0C44hRoFFYp8STTpDRo
 FHKrUtCik5DuTIQVjxevSBi5MuF/vDdLyLYLk6KeOi3cWRm55y6PTMbkO4+A2CXhljGt
 VLePgHELwXaT9DFgNJFi4J/D5dE0a3Euwh9PVfCeM6Gr/UWwzsbx5rsNf6U/vhuyFHF1
 8bMA==
X-Gm-Message-State: AOJu0Yywjw1/G4J/+R9pm9okBaVALAX7Qn3lCLhUNdU57t2xB58IZC5v
 BX3n/vgxDysvZeBrMeX+esWV2i5Q5D+1l6dh4FEwf/KMmRPhBZNu0U3l3pc6Can2xqg=
X-Gm-Gg: ASbGncvYZt+JtlOurF2uqU1KT9udcC8ug1dIyR5pdEVNtWkn5AzPdkTWi0nqqnrP5pd
 N7i9j4hPZswi7PE7AH/jWt4kZtyxgQVxK7l2tb5ogH8YvHp95ybpPtzL2gu+9xKFF2Ni9V0RXRP
 zg+iIXzdbEwBHevasGTHJFHD+75LQgBhDWNe/UWeSpnaSR2t7kmB7da2uPk+H/YLm9La7cdohdS
 1njJMTpgAG2F8omoLdKx7mkJGovO3yZXzFwC92vUPiFvvTr2xqIdK3Ix4P0UeluS/dOmdHozhzX
 Yd879IbUEUNElB8XGu/P9MGBSSUt3MydK0yExXg=
X-Google-Smtp-Source: AGHT+IH+vbqiGv7IhAZbtEHpscm9CWbStdtuoVE2lDQPdAC8C7CGt+n+MVm9yBpSIxq0oWmjZZQfpQ==
X-Received: by 2002:a05:600c:64cc:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-442fd664f7dmr135228345e9.23.1747743386544; 
 Tue, 20 May 2025 05:16:26 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f0554fsm28650305e9.9.2025.05.20.05.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:16:25 -0700 (PDT)
Date: Tue, 20 May 2025 14:16:25 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3] target/riscv/kvm: add satp mode for host cpu
Message-ID: <20250520-6662f98a85c2e458d732887b@orel>
References: <20250520104103.89736-1-mengzhuo@iscas.ac.cn>
 <20250520-317e19aeb55fa93e30941e63@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-317e19aeb55fa93e30941e63@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x334.google.com
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

On Tue, May 20, 2025 at 01:58:45PM +0200, Andrew Jones wrote:
> On Tue, May 20, 2025 at 06:41:03PM +0800, Meng Zhuo wrote:
> > This patch adds host satp mode while kvm/host cpu satp mode is not
> > set.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
> > Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
> > ---
> 
> Please provide a changelog here. I had to go reread the comments on v1 to
> guess at what might have changed.
> 
> >  target/riscv/cpu.c         |  3 +--
> >  target/riscv/cpu.h         |  1 +
> >  target/riscv/kvm/kvm-cpu.c | 20 +++++++++++++++++++-
> >  3 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index d92874baa0..a84edd3a3b 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -433,8 +433,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
> >      g_assert_not_reached();
> >  }
> >  
> > -static void set_satp_mode_max_supported(RISCVCPU *cpu,
> > -                                        uint8_t satp_mode)
> > +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode)
> 
> In v1 I suggested we add some sanity checking to this function to ensure
> we can never set an invalid mode (one that's higher than the max
> supported).

It appears [1], which I just learned exists (that series doesn't CC
qemu-riscv) adds an assert for the check (among other changes).

[1] https://lore.kernel.org/all/20250406070254.274797-3-pbonzini@redhat.com/

Thanks,
drew

> 
> >  {
> >      bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
> >      const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index b56d3afa69..d7136f1d72 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -915,6 +915,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
> >  
> >  void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
> >  void riscv_add_satp_mode_properties(Object *obj);
> > +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode);
> >  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
> >  
> >  /* CSR function table */
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index 82f9728636..18fbca1a08 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -999,6 +999,23 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
> >      close(scratch->kvmfd);
> >  }
> >  
> > +static void kvm_riscv_init_satp_mode(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
> > +{
> > +    CPURISCVState *env = &cpu->env;
> > +    struct kvm_one_reg reg;
> > +    int ret;
> > +    uint64_t val;
> > +
> > +    reg.id = RISCV_CONFIG_REG(env, satp_mode);
> > +    reg.addr = (uint64_t)&val;
> > +    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> > +    if (ret != 0) {
> > +        error_report("Unable to retrieve satp from host, error %d", ret);
> 
> This will output "Unable..., error -1" on error. We should output at least
> the errno and preferably the errno string. I see that this is just a copy
> of a pattern used throughout this file though, so we need a patch fixing
> all of the ioctl call error_reports.
> 
> > +    }
> > +
> > +    set_satp_mode_max_supported(cpu, val);
> > +}
> > +
> >  static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
> >  {
> >      struct kvm_one_reg reg;
> > @@ -1302,6 +1319,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
> >      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
> >      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
> >      kvm_riscv_init_cfg(cpu, &kvmcpu);
> > +    kvm_riscv_init_satp_mode(cpu, &kvmcpu);
> >  
> >      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
> >  }
> > @@ -1980,7 +1998,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
> >          }
> >      }
> >  
> > -   return true;
> > +    return true;
> >  }
> >  
> >  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
> > -- 
> > 2.39.5
> > 
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

