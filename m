Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1456EC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cIx-0001c4-Q5; Wed, 23 Apr 2025 11:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7cIo-0001Xy-8g
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:46:22 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7cIm-0005Dm-4O
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:46:21 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso9327841a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745423178; x=1746027978; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JTj75WtDoLFx3vzMsRRH8+ZaRdR8VWsRj2KyFDl+Sk0=;
 b=bbz8qbxHxmY8x28XTnVVEE+jJDafsu1zpIhHbo8+hiYhnczRNSjqU4nRgTUcpcW6X8
 D0NJUp2IraS6hXgyrmyPhhpv6Y78VL1pTPnfgZ0wMUYmNrUEsTaq4BYQWAaeOtxx2jxp
 ljnEHOfxnNRsldnFAFi2Hy0QQCifgcjOsqB+GK/4YzZf8va1QVncSGD7MH9kmY/zhTIK
 nQS2PsVs7cUDw+i9WdJvIh7OrDbGni6DiIoO4oy8JS8LANsELGQ9fZS+1faN57cRxdym
 FUwOXNxYYn69LJIdscihUDYc7XhUv7Twiw9V6TH3PkA2S22RP/1KSv6BiCWluSA1Y36o
 pY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745423178; x=1746027978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTj75WtDoLFx3vzMsRRH8+ZaRdR8VWsRj2KyFDl+Sk0=;
 b=w88vH83TfABsMhEiU6Yqex44BxuxPT5niIu0x68gDMcgHmN2N0dHMOeJ7W8iBd6fck
 ybPipwy8x1z/KbCUFphr4LdyTp0thY/aPa1KMKGPoZwlgccQkhpQgEeT42osbN0Tux9W
 QWCP+9qvCLCQwECYr5mj2qSBHrkhXAA4r5tuo7KM7TrAgYnLswZdOA2pOtRbAWMog7hP
 5tY+R0tSeVGlNH2kIPnh/xzNVsdDm0jLkq/l0LUOmNQ2RhVsJIsKXXljUj72Fj9J8ZGt
 5K8Z4eaRmowHOHfoZXemA63n31k7gPBFk3ZpKdImVLfpolabiIH7bdPKZeP4vciXmRpv
 G/lg==
X-Gm-Message-State: AOJu0Yz0Chsb2TB9RQi7atbMWAu5FYusdvuDTaRGEQsb19EnndCzLLUP
 9xo1GQAW1XeMUmfYzWrIepGUjjAuxHicu02tYXb9GhsBEhRIl/QSlQSyeV67HO4=
X-Gm-Gg: ASbGncs4Sm7TxkSMeeaemHoBWtmEL3j4M5A4/22jSknj/sRjBfy6dyVfN4mpJwTRYlA
 e6TU/dVqgO+sKennqp6e6H9PisqakL1H6H3EPDlWMihkkJUUtallyBhqTDrzaGMcOYHZ7RT9jzW
 eUmS/FKXWiqYZIK1VX8DprATStWqoLSrlEGXb9lMmfb8If84P09BIcIFVkDQeNFvBhcT81GlDEt
 8sPegUo6tLhQnxxaNy2aYJ9zJNtGFYg8b7pw8h2gqcckyNI+uZHtirhjm3LbLBym7VdttqkILfx
 cfPj7m4L8HddFnpOgjhHIPGOVYLRUTAJbl05e4s=
X-Google-Smtp-Source: AGHT+IHPTD3C0jMp2SAnw/ZpnYKUa3Dd7VgIOjzKoAnWL5Cdxj9cc61hcLjhKztvTVB8PALwNdqbiQ==
X-Received: by 2002:a05:6402:354a:b0:5ed:2e84:4f1f with SMTP id
 4fb4d7f45d1cf-5f6285fbbe1mr19680782a12.22.1745423178227; 
 Wed, 23 Apr 2025 08:46:18 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f6255955a6sm7763939a12.43.2025.04.23.08.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 08:46:16 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:46:16 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 abologna@redhat.com
Subject: Re: [PATCH 7/7] target/riscv/kvm: reset 'scounteren' with host val
Message-ID: <20250423-7d7e348ed0ec6cadb1efe399@orel>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
 <20250417124839.1870494-8-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417124839.1870494-8-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52e.google.com
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

On Thu, Apr 17, 2025 at 09:48:39AM -0300, Daniel Henrique Barboza wrote:
> The Linux kernel, up until at least version 6.12, has issues with a KVM
> guest setting scounteren to 0 during reset. No error will be thrown
> during boot, but trying to use rdtime in the guest (by executing 'ping'
> for example) will result in a stack trace and an illegal instruction
> error:
> 
> / # ping 8.8.8.8
> PING 3.33.130.190 (8.8.8.8): 56 data bytes
> [   19.464484] ping[56]: unhandled signal 4 code 0x1 at 0x00007fffae0665f4
> [   19.493332] CPU: 0 PID: 56 Comm: ping Not tainted 6.9.0-rc3-dbarboza #7
> [   19.523249] Hardware name: riscv-virtio,qemu (DT)
> [   19.546641] epc : 00007fffae0665f4 ra : 00000000000c6316 sp : 00007fffc7cfd9f0
> [   19.576214]  gp : 0000000000172408 tp : 00000000001767a0 t0 : 0000000000000000
> [   19.606719]  t1 : 0000000000000020 t2 : 0000000000000000 s0 : 00007fffc7cfda00
> [   19.640938]  s1 : 00007fffc7cfda30 a0 : 0000000000000001 a1 : 00007fffc7cfda30
> [   19.676698]  a2 : 0000000000000000 a3 : 00000000000009ee a4 : 00007fffae064000
> [   19.721036]  a5 : 0000000000000001 a6 : 0000000000000000 a7 : 00000000001784d0
> [   19.765061]  s2 : 00000000001784d0 s3 : 000000000011ca38 s4 : 000000000011d000
> [   19.801985]  s5 : 0000000000000001 s6 : 0000000000000000 s7 : 0000000000000000
> [   19.841235]  s8 : 0000000000177788 s9 : 0000000000176828 s10: 0000000000000000
> [   19.882479]  s11: 00000000001777a8 t3 : ffffffffffffffff t4 : 0000000000172f60
> [   19.923651]  t5 : 0000000000000020 t6 : 000000000000000a
> [   19.950491] status: 0000000200004020 badaddr: 00000000c01027f3 cause: 0000000000000002
> [   19.995864] Code: 431c f613 0017 869b 0007 ea59 000f 0220 435c cfbd (27f3) c010
> Illegal instruction
> / #
> 
> Reading the host scounteren val and using it during reset, instead of
> zeroing it, will prevent this error. It is worth noting that scounteren
> is a WARL reg according to the RISC-V ISA spec, and in theory the kernel
> should accept a zero val and convert it to something that won't break
> the guest.

0 is legal, so the kernel (KVM) shouldn't change what userspace selects.
Userspace, which includes user policy knowledge, knows best and indeed 0
is the best selection when no other policy is provided. Changing from 0
to whatever KVM has put there is wrong.

> 
> We can't tell from userspace if the host kernel handles scounteren = 0
> during reset accordingly, so to prevent this error we'll assume that it
> won't. Read the reg from the host and use it as reset value.

It's not the host kernel that needs to change how it handles things. It's
the guest kernel. When the guest uses ping, which likely calls gtod, which
uses rdtime, or if the guest uses anything that results in an rdtime use,
then it'll hit this issue if the host doesn't support sscofpmf (which the
QEMU rv64 cpu type doesn't). The reason is because KVM won't expose the
SBI PMU without sscofpmf and then the guest kernel pmu driver won't run,
and currently the only place scounteren is getting set up is in the pmu
driver. The guest kernel should unconditionally set up scounteren to
match what it expects userspace to use (like enable rdtime, since the
guest kernel actually implements gtod in vdso with it)

> 
> We'll end up repeating code from kvm_riscv_get_regs_csr() to do that.
> Create a helper that will get a single CSR and use it in get_regs_csr()
> and in kvm_riscv_reset_regs_csr() to avoid code duplication.
> 
> Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")

This isn't the right tag since that is already fixed by checking
get-reg-list in a previous patch. This patch is trying to fix a guest
kernel bug, which it shouldn't be doing, at least not without some user
toggle allowing the workaround to be turned on/off.

> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 73 ++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index a91a87b175..918fe51257 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -634,29 +634,40 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>      return ret;
>  }
>  
> -static int kvm_riscv_get_regs_csr(CPUState *cs)
> +static int kvm_riscv_get_reg_csr(CPUState *cs,
> +                                 KVMCPUConfig *csr_cfg)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      uint64_t reg;
> -    int i, ret;
> +    int ret;
>  
> -    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> -        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
> +    if (!csr_cfg->supported) {
> +        return 0;
> +    }
>  
> -        if (!csr_cfg->supported) {
> -            continue;
> -        }
> +    ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (csr_cfg->prop_size == sizeof(uint32_t)) {
> +        kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
> +    } else {
> +        kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
> +    }
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_get_regs_csr(CPUState *cs)
> +{
> +    int i, ret;
>  
> -        ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
> +    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        ret = kvm_riscv_get_reg_csr(cs, &kvm_csr_cfgs[i]);
>          if (ret) {
>              return ret;
>          }
> -
> -        if (csr_cfg->prop_size == sizeof(uint32_t)) {
> -            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
> -        } else {
> -            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
> -        }
>      }
>  
>      return 0;
> @@ -690,8 +701,11 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      return 0;
>  }
>  
> -static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
> +static void kvm_riscv_reset_regs_csr(CPUState *cs, CPURISCVState *env)
>  {
> +    uint64_t scounteren_kvm_id = RISCV_CSR_REG(scounteren);
> +    int ret;
> +
>      env->mstatus = 0;
>      env->mie = 0;
>      env->stvec = 0;
> @@ -701,8 +715,30 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>      env->stval = 0;
>      env->mip = 0;
>      env->satp = 0;
> -    env->scounteren = 0;
>      env->senvcfg = 0;
> +
> +    /*
> +     * Some kernels will take issue with env->scounteren = 0
> +     * causing problems inside the KVM guest with 'rdtime'.
> +     * Read 'scounteren' from the host and use it.
> +     */
> +    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
> +        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
> +
> +        if (csr_cfg->kvm_reg_id != scounteren_kvm_id) {
> +            continue;
> +        }
> +
> +        if (!csr_cfg->supported) {
> +            break;
> +        }
> +
> +        ret = kvm_riscv_get_reg_csr(cs, &kvm_csr_cfgs[i]);
> +        if (ret) {
> +            error_report("Unable to retrieve scounteren from host ,"
> +                         "error %d", ret);
> +        }
> +    }
>  }
>  
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
> @@ -1711,16 +1747,17 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>  {
>      CPURISCVState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
>      int i;
>  
>      for (i = 0; i < 32; i++) {
>          env->gpr[i] = 0;
>      }
>      env->pc = cpu->env.kernel_addr;
> -    env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
> +    env->gpr[10] = kvm_arch_vcpu_id(cs);       /* a0 */
>      env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
>  
> -    kvm_riscv_reset_regs_csr(env);
> +    kvm_riscv_reset_regs_csr(cs, env);
>  }
>  
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
> -- 
> 2.49.0
> 
>

I would just drop this patch and make the default 'virt' cpu type 'max',
then nobody will hit the issue. We should also fix the [guest] kernel,
which I'll try to do soon.

Thanks,
drew

