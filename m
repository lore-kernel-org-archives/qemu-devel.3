Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C23FC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcTN-0004BN-Ve; Mon, 27 May 2024 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBcTM-0004B2-7I
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:41:16 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBcTJ-0004iQ-G0
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:41:15 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5788eaf5320so2037653a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716824472; x=1717429272; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9IhYPVlWcApAJIz6rVgdm1Mk4Va4rbpI9w76Xh4zH7o=;
 b=ZWRKY07XusMTFWfHkjtB27/ebt1aAP0ywNBddxLTysx7XwaWkDkVZMEFAemNMdrbx9
 AD1TB3sT4XdFTolsYkNldY2hTe7R2jZ5o+Tk0vaonMMtCO0PzpAWOTU5yfVq4sD/hqVr
 XzxxZbTn8NW0EbhLtggigjl4m8o9HhW/PHcKFdDwGOQFbHZ6i7+U7eqdMNZLqCHGpYP8
 w3izquEAH96NG8irWXuxxq9071QlbyBPSmnh6wZJIXkKHs4vOGn7tvvJExjI9L0pHhb1
 IOlUkeOXGmvAa9vrhy8RWUd/bDTNvxuXDnLKakmeL+quhTNxTgYBvidKun51Qvx5xnwp
 Oyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716824472; x=1717429272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IhYPVlWcApAJIz6rVgdm1Mk4Va4rbpI9w76Xh4zH7o=;
 b=pWLQfLwtD8yp3eVLwbeIrqf80TJIGEhgbz/vCHTYo3V99Sbsk/+6oXi8HhGX8lAiQx
 juinEQEb50kOW6+RrpTsV05yprif7ivdRNpeWBRN1EYlVvH+F2opJuHBmcHDttHgOqm+
 87APi7f+ZWSPnxQMx3wgRx44zbLZp5Q4pItLxyqFTCESfq6yzrCxO8YaNOUA0zI4+ik9
 C7s3K+Zkbi9fqEX2tdGaj2R3zt3lk+DvLAB8PeqSU2IsMG5STdV6GjZecxLOmsBafq1I
 vPKzw8X5zgJga/V4J9kAci+eyMaW+U2L9UNUPK25qQMG8w+nWXlrsD1z5RJ0YbxR8FHq
 Dbhg==
X-Gm-Message-State: AOJu0Ywu/rVWLcOyEsQKQLKlJKYmnELP/Oy2lZOisr9hNB0ZCQL97eEu
 7qdGelZQ71gchqHJ9Wlj4C+bg6BnCw+pXkR7EnBGMiV2nkLTCIQCJ+4P8hohtT0=
X-Google-Smtp-Source: AGHT+IFAzOoOjpds3KUw3vZvjjSxnKTjQDzP5DU9ZYocFfRpbUKLiSu1QwC7CoCbqE70fnG0DP6+eQ==
X-Received: by 2002:a50:ba83:0:b0:578:5fcb:1a4e with SMTP id
 4fb4d7f45d1cf-5785fcb1bdbmr5534525a12.24.1716824471761; 
 Mon, 27 May 2024 08:41:11 -0700 (PDT)
Received: from localhost ([176.74.158.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524b5898sm5965028a12.82.2024.05.27.08.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:41:11 -0700 (PDT)
Date: Mon, 27 May 2024 17:41:10 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
Subject: Re: [PATCH v1 1/4] target/riscv/kvm: add software breakpoints support
Message-ID: <20240527-48b296b1177d7a6abbf49886@orel>
References: <20240527021916.12953-1-duchao@eswincomputing.com>
 <20240527021916.12953-2-duchao@eswincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527021916.12953-2-duchao@eswincomputing.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 02:19:13AM GMT, Chao Du wrote:
> This patch implements insert/remove software breakpoint process:
> 
> Add an input parameter for kvm_arch_insert_sw_breakpoint() and
> kvm_arch_remove_sw_breakpoint() to pass the length information,
> which helps us to know whether it is a RVC instruction.
> For some remove cases, we do not have the length info, so we need
> to judge by ourselves.
> 
> For RISC-V, GDB treats single-step similarly to breakpoint: add a
> breakpoint at the next step address, then continue. So this also
> works for single-step debugging.
> 
> Add some stubs which are necessary for building, and will be
> implemented later.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> ---
>  accel/kvm/kvm-all.c        |  8 ++--
>  include/sysemu/kvm.h       |  6 ++-
>  target/arm/kvm.c           |  6 ++-
>  target/i386/kvm/kvm.c      |  6 ++-
>  target/mips/kvm.c          |  6 ++-
>  target/ppc/kvm.c           |  6 ++-
>  target/riscv/kvm/kvm-cpu.c | 79 ++++++++++++++++++++++++++++++++++++++
>  target/s390x/kvm/kvm.c     |  6 ++-
>  8 files changed, 107 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c0be9f5eed..d27e77dbb2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3357,7 +3357,7 @@ int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
>          bp = g_new(struct kvm_sw_breakpoint, 1);
>          bp->pc = addr;
>          bp->use_count = 1;
> -        err = kvm_arch_insert_sw_breakpoint(cpu, bp);
> +        err = kvm_arch_insert_sw_breakpoint(cpu, bp, len);
>          if (err) {
>              g_free(bp);
>              return err;
> @@ -3396,7 +3396,7 @@ int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
>              return 0;
>          }
>  
> -        err = kvm_arch_remove_sw_breakpoint(cpu, bp);
> +        err = kvm_arch_remove_sw_breakpoint(cpu, bp, len);
>          if (err) {
>              return err;
>          }
> @@ -3426,10 +3426,10 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
>      CPUState *tmpcpu;
>  
>      QTAILQ_FOREACH_SAFE(bp, &s->kvm_sw_breakpoints, entry, next) {
> -        if (kvm_arch_remove_sw_breakpoint(cpu, bp) != 0) {
> +        if (kvm_arch_remove_sw_breakpoint(cpu, bp, 0) != 0) {
>              /* Try harder to find a CPU that currently sees the breakpoint. */
>              CPU_FOREACH(tmpcpu) {
> -                if (kvm_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
> +                if (kvm_arch_remove_sw_breakpoint(tmpcpu, bp, 0) == 0) {

It's not nice to need to add 'len' to all arch insert/remove sw breakpoint
implementations, and the fact we have to pass zero sometimes implies it's
not the right approach.

>                      break;
>                  }
>              }
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index c31d9c7356..340e094ffb 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -391,9 +391,11 @@ struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
>  int kvm_sw_breakpoints_active(CPUState *cpu);
>  
>  int kvm_arch_insert_sw_breakpoint(CPUState *cpu,
> -                                  struct kvm_sw_breakpoint *bp);
> +                                  struct kvm_sw_breakpoint *bp,
> +                                  vaddr len);
>  int kvm_arch_remove_sw_breakpoint(CPUState *cpu,
> -                                  struct kvm_sw_breakpoint *bp);
> +                                  struct kvm_sw_breakpoint *bp,
> +                                  vaddr len);
>  int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
>  int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
>  void kvm_arch_remove_all_hw_breakpoints(void);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 7cf5cf31de..84593db544 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2402,7 +2402,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  /* C6.6.29 BRK instruction */
>  static const uint32_t brk_insn = 0xd4200000;
>  
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
>          cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
> @@ -2411,7 +2412,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>      return 0;
>  }
>  
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      static uint32_t brk;
>  
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index c5943605ee..6449f796d0 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4992,7 +4992,8 @@ static int kvm_handle_tpr_access(X86CPU *cpu)
>      return 1;
>  }
>  
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      static const uint8_t int3 = 0xcc;
>  
> @@ -5003,7 +5004,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>      return 0;
>  }
>  
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      uint8_t int3;
>  
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index a631ab544f..129964cf6d 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -111,13 +111,15 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu)
>      DPRINTF("%s\n", __func__);
>  }
>  
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      DPRINTF("%s\n", __func__);
>      return 0;
>  }
>  
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      DPRINTF("%s\n", __func__);
>      return 0;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 46fccff786..9b76bdaa05 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1378,7 +1378,8 @@ static int kvmppc_handle_dcr_write(CPUPPCState *env,
>      return 0;
>  }
>  
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      /* Mixed endian case is not handled */
>      uint32_t sc = debug_inst_opcode;
> @@ -1392,7 +1393,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>      return 0;
>  }
>  
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      uint32_t sc;
>  
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 473416649f..cba55c552d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1962,3 +1962,82 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>  };
>  
>  DEFINE_TYPES(riscv_kvm_cpu_type_infos)
> +
> +static const uint32_t ebreak_insn = 0x00100073;
> +static const uint16_t c_ebreak_insn = 0x9002;
> +
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
> +{
> +    if (len != 4 && len != 2) {
> +        return -EINVAL;
> +    }
> +
> +    uint8_t * insn = (len == 4) ? (uint8_t *)&ebreak_insn :
> +                                  (uint8_t *)&c_ebreak_insn;
> +
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, len, 0) ||
> +        cpu_memory_rw_debug(cs, bp->pc, insn, len, 1)) {
> +        return -EINVAL;
> +    }

We can also read 2 bytes. So how about 

  if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 0)) {
      return -EINVAL;
  }

  if ((bp->saved_insn & 0x3) == 0x3) {
      if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
          cpu_memory_rw_debug(cs, bp->pc, &ebreak_insn, 4, 1)) {
              return -EINVAL;
      }
   } else {
      if (cpu_memory_rw_debug(cs, bp->pc, &c_ebreak_insn, 2, 1)) {
          return -EINVAL;
      }
   }

> +
> +    return 0;
> +}
> +
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
> +{
> +    uint8_t length;
> +
> +    if (len == 4 || len == 2) {
> +        length = (uint8_t)len;
> +    } else if (len == 0) {
> +        /* Need to decide the instruction length in this case. */
> +        uint32_t read_4_bytes;
> +        uint16_t read_2_bytes;
> +
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&read_4_bytes, 4, 0) ||
> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&read_2_bytes, 2, 0)) {
> +            return -EINVAL;
> +        }
> +
> +        if (read_4_bytes == ebreak_insn) {
> +            length = 4;
> +        } else if (read_2_bytes == c_ebreak_insn) {
> +            length = 2;
> +        } else {
> +            return -EINVAL;
> +        }
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn,
> +                            length, 1)) {
> +        return -EINVAL;
> +    }

Also no need need for 'len'.

   uint16_t ebreak;

   if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak, 2, 0)) {
       return -EINVAL;
   }

   if ((ebreak & 0x3) == 0x3) {
       if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
          return -EINVAL;
       }
   } else {
       if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 1)) {
          return -EINVAL;
       }
   }

Thanks,
drew

> +
> +    return 0;
> +}
> +
> +int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    /* TODO; To be implemented later. */
> +    return -EINVAL;
> +}
> +
> +int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    /* TODO; To be implemented later. */
> +    return -EINVAL;
> +}
> +
> +void kvm_arch_remove_all_hw_breakpoints(void)
> +{
> +    /* TODO; To be implemented later. */
> +}
> +
> +void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
> +{
> +    /* TODO; To be implemented later. */
> +}
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 1b494ecc20..132952cc84 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -865,7 +865,8 @@ static void determine_sw_breakpoint_instr(void)
>          }
>  }
>  
> -int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      determine_sw_breakpoint_instr();
>  
> @@ -877,7 +878,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>      return 0;
>  }
>  
> -int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp,
> +                                  vaddr len)
>  {
>      uint8_t t[MAX_ILEN];
>  
> -- 
> 2.17.1
> 
> 

