Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3BBC36011
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSh3-0000sj-Qq; Wed, 26 Mar 2025 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh1-0000r7-5X
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSgy-0005iZ-8W
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224191d92e4so140013315ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002958; x=1743607758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/ga05oIQt5pQbv/54+dzw70ryFJGf+eBcLJAbnSf5E=;
 b=y0SnM7Vu4ZND3Q2TKFGx7WVMhZ57bxYk1N6oPH54l18HkY5qce80e/3JfDB02+cXj4
 xk9QOhEVkVHA42jWsp0nOWKEvQ1AiA1KEL2+OnM7zRSQlYgG+CrlPJgWuiZ3cns3c3Bs
 DIo3b6Cto1gWsLhd3bJofuaI4wr8by5y+0QruYT7e/DYTRTNsQyCJxmPd+oOvT5Pin0U
 MuW3eOXgJAUd6UASMsA0bpdjVs8h7qYqEjg8KVSMmZZ2DWgWJTOtEuQFhsGCT4cTiZlo
 n3V3CAq7g2gf8YuUXBYtHhZeY49vl1HzcTYjsAdzI+5v43dZxZyyOJoZCisycK+svQU4
 xKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002958; x=1743607758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/ga05oIQt5pQbv/54+dzw70ryFJGf+eBcLJAbnSf5E=;
 b=bHhAzQuA7Ha1b6Ps4ftiZYUobz4HStC0mdBYf+xy2Tz75mZN3+FXjj3UDqhJD6nKWm
 HafBAx3fU8/UutP4RXT9W/TAxfe0El5zOavcaIgznLZuDH0Q2jrOxTaHCJejvyE0mOF3
 wuAlFsFeuGinP6zXJo1WJazrM+gVPaUKbf/zQT92C9z5JkLasp2dxai/j0jgguKPceUc
 X/ZN4DrKj2d4oAeAV1rp1oX1wxZ+sjngtN9ofASzpJ9ji+/NTQ5naAl//uRaEUObzEHr
 S1A7C6LSiRcZ/kpTTTfT4meloWeWhWCBcHSHT8aEsHI1FlWAheqKoJGsAowf//IfpqjB
 z0PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrW4cyLR4eFG3jS3K0rYHwFnaBuN9HUoeI8mK5yvsc/cRx+7wMWoY3o8ty6Necgn6rquwoIBjkSlOL@nongnu.org
X-Gm-Message-State: AOJu0Yz6N0Ou0ExJDjjtLv+ta6qkZ86DtUz3UrxiGwclhgJCDl4la22E
 MPpm0ErwD0kllCngmuDXzOj+kCsCiVHDb1cA7Yxm9M851cXEZRQ6gQkI2ilBMSk=
X-Gm-Gg: ASbGncsUYKKY1Dsu8zAObE7fwv/tJzzTjBt9us3HHO5Ud+eyO0q5vaiCVyxsT+x+z3v
 zUmstrZhp0jnWCvHxtc/svIoOxKRQ7BAWskmpd1SJ9dOUF+CS2i7PtTNLbXgAhiXrQWIvtP0lFa
 uozPaKD/Fmq9+TZsbMM7X11mTQMfmJlxrrlEx2SjYFNBpzf869lBscEyoTY1CUOH8C7Hu/3hZDX
 La0fXgZU0X6Y71HLbuuBTYZ4FKeqJy7z3WVSq7XOpAR4CvdWH1Q2ePPMRuPdkisy+NNo0mDF3S5
 Zih39qGVc8juHB3LCIRi/odSL9rAvpDykJRF8TtUreS4bOaq145PIv7yGw==
X-Google-Smtp-Source: AGHT+IEAjSzlcsv9xN3afDMDtHbPu6KrD/wnjB6DISgkLSua7YH0k/L/EewdgMltHAm54eq4cpDiIQ==
X-Received: by 2002:a17:902:f64d:b0:21f:6a36:7bf3 with SMTP id
 d9443c01a7336-22780d8b817mr362400045ad.12.1743002958003; 
 Wed, 26 Mar 2025 08:29:18 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:17 -0700 (PDT)
Message-ID: <fdbd8501-13e2-40a0-99b1-a79965d0c336@linaro.org>
Date: Wed, 26 Mar 2025 08:16:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] target/avr: Move cpu register accesses into
 system memory
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325224403.4011975-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/25/25 15:43, Richard Henderson wrote:
> Integrate the i/o 0x00-0x1f and 0x38-0x3f loopbacks into
> the cpu registers with normal address space accesses.
> We no longer need to trap accesses to the first page within
> avr_cpu_tlb_fill but can wait until a write occurs.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h       |   7 ++
>   target/avr/helper.h    |   3 -
>   target/avr/cpu.c       |  16 +++
>   target/avr/helper.c    | 223 +++++++++++++++++------------------------
>   target/avr/translate.c |  42 ++++----
>   5 files changed, 138 insertions(+), 153 deletions(-)
> 
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index ebcdda20ac..9862705c6a 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -23,6 +23,7 @@
>   
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> +#include "exec/memory.h"
>   
>   #ifdef CONFIG_USER_ONLY
>   #error "AVR 8-bit does not support user mode"
> @@ -150,6 +151,9 @@ struct ArchCPU {
>   
>       CPUAVRState env;
>   
> +    MemoryRegion cpu_reg1;
> +    MemoryRegion cpu_reg2;
> +
>       /* Initial value of stack pointer */
>       uint32_t init_sp;
>   };
> @@ -250,6 +254,9 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                         MMUAccessType access_type, int mmu_idx,
>                         bool probe, uintptr_t retaddr);
>   
> +extern const MemoryRegionOps avr_cpu_reg1;
> +extern const MemoryRegionOps avr_cpu_reg2;
> +
>   #include "exec/cpu-all.h"
>   
>   #endif /* QEMU_AVR_CPU_H */
> diff --git a/target/avr/helper.h b/target/avr/helper.h
> index 4d02e648fa..e8d13e925f 100644
> --- a/target/avr/helper.h
> +++ b/target/avr/helper.h
> @@ -23,7 +23,4 @@ DEF_HELPER_1(debug, noreturn, env)
>   DEF_HELPER_1(break, noreturn, env)
>   DEF_HELPER_1(sleep, noreturn, env)
>   DEF_HELPER_1(unsupported, noreturn, env)
> -DEF_HELPER_3(outb, void, env, i32, i32)
> -DEF_HELPER_2(inb, tl, env, i32)
>   DEF_HELPER_3(fullwr, void, env, i32, i32)
> -DEF_HELPER_2(fullrd, tl, env, i32)
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 834c7082aa..0b14b36c17 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -23,6 +23,7 @@
>   #include "qemu/qemu-print.h"
>   #include "exec/exec-all.h"
>   #include "exec/translation-block.h"
> +#include "exec/address-spaces.h"
>   #include "cpu.h"
>   #include "disas/dis-asm.h"
>   #include "tcg/debug-assert.h"
> @@ -110,6 +111,8 @@ static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
>   static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> +    CPUAVRState *env = cpu_env(cs);
> +    AVRCPU *cpu = env_archcpu(env);
>       AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> @@ -122,6 +125,19 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
>       cpu_reset(cs);
>   
>       mcc->parent_realize(dev, errp);
> +
> +    /*
> +     * Two blocks in the low data space loop back into cpu registers.
> +     */
> +    memory_region_init_io(&cpu->cpu_reg1, OBJECT(cpu), &avr_cpu_reg1, env,
> +                          "avr-cpu-reg1", 32);
> +    memory_region_add_subregion(get_system_memory(),
> +                                OFFSET_DATA, &cpu->cpu_reg1);
> +
> +    memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), &avr_cpu_reg2, env,
> +                          "avr-cpu-reg2", 8);
> +    memory_region_add_subregion(get_system_memory(),
> +                                OFFSET_DATA + 0x58, &cpu->cpu_reg2);
>   }
>   
>   static void avr_cpu_set_int(void *opaque, int irq, int level)
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index f8ada8b106..d0e86f5614 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -108,7 +108,7 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                         MMUAccessType access_type, int mmu_idx,
>                         bool probe, uintptr_t retaddr)
>   {
> -    int prot, page_size = TARGET_PAGE_SIZE;
> +    int prot;
>       uint32_t paddr;
>   
>       address &= TARGET_PAGE_MASK;
> @@ -133,23 +133,9 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>           /* Access to memory. */
>           paddr = OFFSET_DATA + address;
>           prot = PAGE_READ | PAGE_WRITE;
> -        if (address < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
> -            /*
> -             * Access to CPU registers, exit and rebuilt this TB to use
> -             * full access in case it touches specially handled registers
> -             * like SREG or SP.  For probing, set page_size = 1, in order
> -             * to force tlb_fill to be called for the next access.
> -             */
> -            if (probe) {
> -                page_size = 1;
> -            } else {
> -                cpu_env(cs)->fullacc = 1;
> -                cpu_loop_exit_restore(cs, retaddr);
> -            }
> -        }
>       }
>   
> -    tlb_set_page(cs, address, paddr, prot, mmu_idx, page_size);
> +    tlb_set_page(cs, address, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
>       return true;
>   }
>   
> @@ -203,134 +189,78 @@ void helper_wdr(CPUAVRState *env)
>   }
>   
>   /*
> - * This function implements IN instruction
> - *
> - * It does the following
> - * a.  if an IO register belongs to CPU, its value is read and returned
> - * b.  otherwise io address is translated to mem address and physical memory
> - *     is read.
> - * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
> - *
> + * The first 32 bytes of the data space are mapped to the cpu regs.
> + * We cannot write these from normal store operations because TCG
> + * does not expect global temps to be modified -- a global may be
> + * live in a host cpu register across the store.  We can however
> + * read these, as TCG does make sure the global temps are saved
> + * in case the load operation traps.
>    */
> -target_ulong helper_inb(CPUAVRState *env, uint32_t port)
> +
> +static uint64_t avr_cpu_reg1_read(void *opaque, hwaddr addr, unsigned size)
>   {
> -    target_ulong data = 0;
> +    CPUAVRState *env = opaque;
>   
> -    switch (port - 0x38) {
> -    case REG_38_RAMPD:
> -        data = 0xff & (env->rampD >> 16);
> -        break;
> -    case REG_38_RAMPX:
> -        data = 0xff & (env->rampX >> 16);
> -        break;
> -    case REG_38_RAMPY:
> -        data = 0xff & (env->rampY >> 16);
> -        break;
> -    case REG_38_RAMPZ:
> -        data = 0xff & (env->rampZ >> 16);
> -        break;
> -    case REG_38_EIDN:
> -        data = 0xff & (env->eind >> 16);
> -        break;
> -    case REG_38_SPL:
> -        data = env->sp & 0x00ff;
> -        break;
> -    case REG_38_SPH:
> -        data = env->sp >> 8;
> -        break;
> -    case REG_38_SREG:
> -        data = cpu_get_sreg(env);
> -        break;
> -    default:
> -        /* not a special register, pass to normal memory access */
> -        data = address_space_ldub(&address_space_memory,
> -                                  OFFSET_IO_REGISTERS + port,
> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
> -    }
> -
> -    return data;
> +    assert(addr < 32);
> +    return env->r[addr];
>   }
>   
>   /*
> - *  This function implements OUT instruction
> - *
> - *  It does the following
> - *  a.  if an IO register belongs to CPU, its value is written into the register
> - *  b.  otherwise io address is translated to mem address and physical memory
> - *      is written.
> - *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
> - *
> + * The range 0x38-0x3f of the i/o space is mapped to cpu regs.
> + * As above, we cannot write these from normal store operations.
>    */
> -void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
> -{
> -    data &= 0x000000ff;
>   
> -    switch (port - 0x38) {
> +static uint64_t avr_cpu_reg2_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    CPUAVRState *env = opaque;
> +
> +    switch (addr) {
>       case REG_38_RAMPD:
> -        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
> -            env->rampD = (data & 0xff) << 16;
> -        }
> -        break;
> +        return 0xff & (env->rampD >> 16);
>       case REG_38_RAMPX:
> -        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
> -            env->rampX = (data & 0xff) << 16;
> -        }
> -        break;
> +        return 0xff & (env->rampX >> 16);
>       case REG_38_RAMPY:
> -        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
> -            env->rampY = (data & 0xff) << 16;
> -        }
> -        break;
> +        return 0xff & (env->rampY >> 16);
>       case REG_38_RAMPZ:
> -        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
> -            env->rampZ = (data & 0xff) << 16;
> -        }
> -        break;
> +        return 0xff & (env->rampZ >> 16);
>       case REG_38_EIDN:
> -        env->eind = (data & 0xff) << 16;
> -        break;
> +        return 0xff & (env->eind >> 16);
>       case REG_38_SPL:
> -        env->sp = (env->sp & 0xff00) | (data);
> -        break;
> +        return env->sp & 0x00ff;
>       case REG_38_SPH:
> -        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
> -            env->sp = (env->sp & 0x00ff) | (data << 8);
> -        }
> -        break;
> +        return 0xff & (env->sp >> 8);
>       case REG_38_SREG:
> -        cpu_set_sreg(env, data);
> -        break;
> -    default:
> -        /* not a special register, pass to normal memory access */
> -        address_space_stb(&address_space_memory, OFFSET_IO_REGISTERS + port,
> -                          data, MEMTXATTRS_UNSPECIFIED, NULL);
> +        return cpu_get_sreg(env);
>       }
> +    g_assert_not_reached();
>   }
>   
> -/*
> - *  this function implements LD instruction when there is a possibility to read
> - *  from a CPU register
> - */
> -target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
> +static void avr_cpu_trap_write(void *opaque, hwaddr addr,
> +                               uint64_t data64, unsigned size)
>   {
> -    uint8_t data;
> +    CPUAVRState *env = opaque;
> +    CPUState *cs = env_cpu(env);
>   
> -    env->fullacc = false;
> -
> -    if (addr < NUMBER_OF_CPU_REGISTERS) {
> -        /* CPU registers */
> -        data = env->r[addr];
> -    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
> -        /* IO registers */
> -        data = helper_inb(env, addr - NUMBER_OF_CPU_REGISTERS);
> -    } else {
> -        /* memory */
> -        data = address_space_ldub(&address_space_memory, OFFSET_DATA + addr,
> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
> -    }
> -    return data;
> +    env->fullacc = true;
> +    cpu_loop_exit_restore(cs, cs->mem_io_pc);
>   }
>   
> +const MemoryRegionOps avr_cpu_reg1 = {
> +    .read = avr_cpu_reg1_read,
> +    .write = avr_cpu_trap_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 1,
> +};
> +
> +const MemoryRegionOps avr_cpu_reg2 = {
> +    .read = avr_cpu_reg2_read,
> +    .write = avr_cpu_trap_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 1,
> +};
> +
>   /*
>    *  this function implements ST instruction when there is a possibility to write
>    *  into a CPU register
> @@ -339,19 +269,50 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
>   {
>       env->fullacc = false;
>   
> -    /* Following logic assumes this: */
> -    assert(OFFSET_IO_REGISTERS == OFFSET_DATA +
> -                                  NUMBER_OF_CPU_REGISTERS);
> -
> -    if (addr < NUMBER_OF_CPU_REGISTERS) {
> +    switch (addr) {
> +    case 0 ... 31:
>           /* CPU registers */
>           env->r[addr] = data;
> -    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
> -        /* IO registers */
> -        helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
> -    } else {
> -        /* memory */
> +        break;
> +
> +    case REG_38_RAMPD + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
> +            env->rampD = data << 16;
> +        }
> +        break;
> +    case REG_38_RAMPX + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
> +            env->rampX = data << 16;
> +        }
> +        break;
> +    case REG_38_RAMPY + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
> +            env->rampY = data << 16;
> +        }
> +        break;
> +    case REG_38_RAMPZ + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
> +            env->rampZ = data << 16;
> +        }
> +        break;
> +    case REG_38_EIDN + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        env->eind = data << 16;
> +        break;
> +    case REG_38_SPL + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        env->sp = (env->sp & 0xff00) | data;
> +        break;
> +    case REG_38_SPH + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
> +            env->sp = (env->sp & 0x00ff) | (data << 8);
> +        }
> +        break;
> +    case REG_38_SREG + 0x38 + NUMBER_OF_CPU_REGISTERS:
> +        cpu_set_sreg(env, data);
> +        break;
> +
> +    default:
>           address_space_stb(&address_space_memory, OFFSET_DATA + addr, data,
>                             MEMTXATTRS_UNSPECIFIED, NULL);
> +        break;
>       }
>   }
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index e7f8ced9b3..0490936cd5 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -194,6 +194,9 @@ static bool avr_have_feature(DisasContext *ctx, int feature)
>   static bool decode_insn(DisasContext *ctx, uint16_t insn);
>   #include "decode-insn.c.inc"
>   
> +static void gen_inb(DisasContext *ctx, TCGv data, int port);
> +static void gen_outb(DisasContext *ctx, TCGv data, int port);
> +
>   /*
>    * Arithmetic Instructions
>    */
> @@ -1293,9 +1296,8 @@ static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
>   static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
>   {
>       TCGv data = tcg_temp_new_i32();
> -    TCGv port = tcg_constant_i32(a->reg);
>   
> -    gen_helper_inb(data, tcg_env, port);
> +    gen_inb(ctx, data, a->reg);
>       tcg_gen_andi_tl(data, data, 1 << a->bit);
>       ctx->skip_cond = TCG_COND_EQ;
>       ctx->skip_var0 = data;
> @@ -1311,9 +1313,8 @@ static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
>   static bool trans_SBIS(DisasContext *ctx, arg_SBIS *a)
>   {
>       TCGv data = tcg_temp_new_i32();
> -    TCGv port = tcg_constant_i32(a->reg);
>   
> -    gen_helper_inb(data, tcg_env, port);
> +    gen_inb(ctx, data, a->reg);
>       tcg_gen_andi_tl(data, data, 1 << a->bit);
>       ctx->skip_cond = TCG_COND_NE;
>       ctx->skip_var0 = data;
> @@ -1502,11 +1503,18 @@ static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
>   
>   static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
>   {
> -    if (ctx->base.tb->flags & TB_FLAGS_FULL_ACCESS) {
> -        gen_helper_fullrd(data, tcg_env, addr);
> -    } else {
> -        tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, MO_UB);
> -    }
> +    tcg_gen_qemu_ld_tl(data, addr, MMU_DATA_IDX, MO_UB);
> +}
> +
> +static void gen_inb(DisasContext *ctx, TCGv data, int port)
> +{
> +    gen_data_load(ctx, data, tcg_constant_i32(port + NUMBER_OF_CPU_REGISTERS));
> +}
> +
> +static void gen_outb(DisasContext *ctx, TCGv data, int port)
> +{
> +    gen_helper_fullwr(tcg_env, data,
> +                      tcg_constant_i32(port + NUMBER_OF_CPU_REGISTERS));
>   }
>   
>   /*
> @@ -2126,9 +2134,8 @@ static bool trans_SPMX(DisasContext *ctx, arg_SPMX *a)
>   static bool trans_IN(DisasContext *ctx, arg_IN *a)
>   {
>       TCGv Rd = cpu_r[a->rd];
> -    TCGv port = tcg_constant_i32(a->imm);
>   
> -    gen_helper_inb(Rd, tcg_env, port);
> +    gen_inb(ctx, Rd, a->imm);
>       return true;
>   }
>   
> @@ -2139,9 +2146,8 @@ static bool trans_IN(DisasContext *ctx, arg_IN *a)
>   static bool trans_OUT(DisasContext *ctx, arg_OUT *a)
>   {
>       TCGv Rd = cpu_r[a->rd];
> -    TCGv port = tcg_constant_i32(a->imm);
>   
> -    gen_helper_outb(tcg_env, port, Rd);
> +    gen_outb(ctx, Rd, a->imm);
>       return true;
>   }
>   
> @@ -2407,11 +2413,10 @@ static bool trans_SWAP(DisasContext *ctx, arg_SWAP *a)
>   static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
>   {
>       TCGv data = tcg_temp_new_i32();
> -    TCGv port = tcg_constant_i32(a->reg);
>   
> -    gen_helper_inb(data, tcg_env, port);
> +    gen_inb(ctx, data, a->reg);
>       tcg_gen_ori_tl(data, data, 1 << a->bit);
> -    gen_helper_outb(tcg_env, port, data);
> +    gen_outb(ctx, data, a->reg);
>       return true;
>   }
>   
> @@ -2422,11 +2427,10 @@ static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
>   static bool trans_CBI(DisasContext *ctx, arg_CBI *a)
>   {
>       TCGv data = tcg_temp_new_i32();
> -    TCGv port = tcg_constant_i32(a->reg);
>   
> -    gen_helper_inb(data, tcg_env, port);
> +    gen_inb(ctx, data, a->reg);
>       tcg_gen_andi_tl(data, data, ~(1 << a->bit));
> -    gen_helper_outb(tcg_env, port, data);
> +    gen_outb(ctx, data, a->reg);
>       return true;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


