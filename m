Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1FCCD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 07:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRmPp-0005nF-5j; Tue, 26 May 2026 03:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmPn-0005mV-06
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:41:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmPk-0005Sy-U1
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:41:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so75386855e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779781282; x=1780386082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uHX5Sa8IV2+bMPgLn5lbvz4boRjGhnMJfQeYkEH8gJY=;
 b=oof5P+nF6Aql1Hpdd6xFDJYL+YVOI72ChUPz8sEiogTsbcDNIoLBPc/krchS9IYhXC
 6OvHEQo1FQ9RlM31KGzYHPnaHs/g0MFemowzj+hB/nZN1CH9jy/WUz8inpB6ymIAU/4C
 hvfmrWvY83qRzkMy5aj6ARUreq1m/GNhIuyG3HPVkm2Ox9ZJf456P8gs2o0fe5C7aWw+
 upy0EUjX8pVhUd/LMV/sBLt8uOTW4gNJ+u0823YvckeNj8ToXdc4zScvyo4Y86byzFQW
 KLKlfdl4vv7FChTfSARRZp864bK6n74iNGakvmgLqXZrf+LDuYHPBUKX/PnzsxX7IoIA
 jBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779781282; x=1780386082;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHX5Sa8IV2+bMPgLn5lbvz4boRjGhnMJfQeYkEH8gJY=;
 b=qKF1R/MiQxCupeUTAFpUHJiuhwOcwag+ICNYz4JpWlG3FIr+Phu3RR3FPGqUto3qx2
 X+SVwt2TxFi6hghvQ3ag8CQ94gYAw19F5GWJ9/wNzLQRnIuXldRCa8MqCbFV0IWVf3sj
 KEPOvQLiqTbkHGres4y4ywc2gZXExYYFX23V6sf86DmibO3ln9yb3DBuitrtePyu1xoP
 phgg/7ArOkRkAbom2p2/5TYkjjUEo+VP7ydxgSmTmWsNqHgpZPVdAzMQnnNq/67FFWHa
 wmmGUBV5ca5Thmy6+UlpfVRh+odSn2Fo3hNY3OG3hwJj/K/2SpnV8tndMLLCrFrPmglz
 EKKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99yBzBgTjut8GUPsOUZHQ+WkwVSujJru9CXtb3rJP4T7swkKu8XA66e48HZ8BlA7MTWGVEcj2U6nGT@nongnu.org
X-Gm-Message-State: AOJu0Yx1WypaYGXGkEWh/AjB7yAv7YN/v2Dq+QIwwWsBLINRtuA1o+pw
 k+U/NzjnxT05BO7aEMvi9Xh/zaEMQQEBlbia8Uc4ZXZ/cngeJB2ilrKQBFKi+Va8VLw=
X-Gm-Gg: Acq92OFHcHUSHSImBuxDbrB4vTAEXyn3uLYCECjtCIYfvKuVojOtzdcqEyjaGWoieR1
 GgCQbGBPg4/0YAV4vZqL+ZyDWaZv40HvN44QLgaVWUhFalP0d3D05RC6uo2W+sDihfsTVS3INl+
 QX84WXcMlFUgHXA+7HP8oItgyiDo/LRHA//SHH+4xPaUDbgwWIWwizL1Dkb+f3xuw2HAsIuVQKt
 2gL2QVk+sPcTt4K3lTEc0gfp6jtgoMujfS4P6qMYsL5oXFbMdb/AUPhBmdxQTJ5V/xp2i/WbwKG
 y4feiWkghcIQIVHHvNc/nBWJRRccL0BDah6SUh0Jj5AW3IiC0Zi89WU2aom8qAcwhMLmClwciKO
 qh2yzqyqvHpigjpRT1yXUZXs3SjDijBIp2tn4PUZlKdBLlfpPYTAeZJnkKy61Yj35SDpuK5qaXB
 JuWR6uTRuyikYYqjBwfLEaH/ZFwoniXmbSNj+sZ8HXk6mxON7Bamon+WP6rhoz8p2HfA==
X-Received: by 2002:a05:600c:1381:b0:490:51e2:bc86 with SMTP id
 5b1f17b1804b1-49051e2be87mr204020555e9.23.1779781282459; 
 Tue, 26 May 2026 00:41:22 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm33395777f8f.24.2026.05.26.00.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:41:21 -0700 (PDT)
Message-ID: <d8faee69-7962-42ab-800d-803189730695@linaro.org>
Date: Tue, 26 May 2026 09:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix no-TCG build
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
References: <20260526024851.2014325-1-fritchleybohrer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526024851.2014325-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 26/5/26 04:48, Zephyr Li wrote:
> Building riscv64-softmmu with --disable-tcg currently fails because
> RISC-V still builds or references TCG-only sources and helpers in the
> no-TCG configuration.
> 
> Move TCG-only helper and translator sources under CONFIG_TCG, guard the
> remaining TCG-only code in common files, and move common CSR helpers out
> of TCG-only helper files.
> 
> misa writes still rely on the TCG extension validation path. Since
> x-misa-w is a TCG-only experimental property, reject it during CPU
> realize when TCG is not available.

Please split as one logical change per patch (i.e. moving FPU flags
in one, exception path in another, ...).

> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3483
> 
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---
> Testing:
> - riscv64-softmmu --enable-kvm --disable-tcg --enable-debug builds
>    successfully.
> - riscv64-softmmu --enable-debug builds successfully.
> - qemu-system-riscv64 -M virt,accel=qtest -cpu rv64,x-misa-w=true \
>        -S -nographic reports "x-misa-w requires TCG".
> 
>   target/riscv/cpu.c        |  9 +++++++
>   target/riscv/cpu_helper.c | 53 +++++++++++++++++++++++++++++++++++++++
>   target/riscv/csr.c        | 18 +++++++++++--
>   target/riscv/fpu_helper.c | 27 --------------------
>   target/riscv/meson.build  |  9 ++++---
>   target/riscv/op_helper.c  | 15 -----------
>   6 files changed, 84 insertions(+), 47 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 862834b480..3f4563fce2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -36,7 +36,9 @@
>   #include "system/tcg.h"
>   #include "kvm/kvm_riscv.h"
>   #include "tcg/tcg-cpu.h"
> +#ifdef CONFIG_TCG
>   #include "tcg/tcg.h"

Apparently this header isn't needed at all.

> +#endif
>   
>   /* RISC-V CPU definitions */
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
> @@ -956,6 +958,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> +#ifndef CONFIG_TCG
> +    if (cpu->cfg.misa_w) {
> +        error_setg(errp, "x-misa-w requires TCG");
> +        return;
> +    }
> +#endif
> +
>       cpu_exec_realizefn(cs, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 17305e1bb7..e53a5d567d 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -21,6 +21,7 @@
>   #include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   #include "cpu.h"
> +#include "fpu/softfloat.h"
>   #include "internals.h"
>   #include "pmu.h"
>   #include "exec/cputlb.h"
> @@ -28,8 +29,10 @@
>   #include "exec/target_page.h"
>   #include "system/memory.h"
>   #include "instmap.h"
> +#ifdef CONFIG_TCG
>   #include "tcg/tcg-op.h"
>   #include "accel/tcg/cpu-ops.h"
> +#endif
>   #include "trace.h"
>   #include "semihosting/common-semi.h"
>   #include "exec/icount.h"
> @@ -38,6 +41,52 @@
>   #include "pmp.h"
>   #include "qemu/plugin.h"
>   
> +/* Exceptions processing helpers */
> +G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> +                                      RISCVException exception,
> +                                      uintptr_t pc)
> +{
> +    CPUState *cs = env_cpu(env);
> +
> +    trace_riscv_exception(exception,
> +                          riscv_cpu_get_trap_name(exception, false),
> +                          env->pc);
> +
> +    cs->exception_index = exception;
> +#ifdef CONFIG_TCG
> +    cpu_loop_exit_restore(cs, pc);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +}
> +
> +target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
> +{
> +    int soft = get_float_exception_flags(&env->fp_status);
> +    target_ulong hard = 0;
> +
> +    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
> +    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
> +    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
> +    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
> +    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
> +
> +    return hard;
> +}
> +
> +void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
> +{
> +    int soft = 0;
> +
> +    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
> +    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
> +    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
> +    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
> +    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
> +
> +    set_float_exception_flags(soft, &env->fp_status);
> +}
> +
>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>   {
>   #ifdef CONFIG_USER_ONLY
> @@ -1667,6 +1716,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       return TRANSLATE_SUCCESS;
>   }
>   
> +#ifdef CONFIG_TCG
>   static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>                                   MMUAccessType access_type, bool pmp_violation,
>                                   bool first_stage, bool two_stage,
> @@ -1709,6 +1759,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>       env->two_stage_lookup = two_stage;
>       env->two_stage_indirect_lookup = two_stage_indirect;
>   }
> +#endif
>   
>   hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>   {
> @@ -1733,6 +1784,7 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>       return phys_addr;
>   }
>   
> +#ifdef CONFIG_TCG
>   void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                        vaddr addr, unsigned size,
>                                        MMUAccessType access_type,
> @@ -1957,6 +2009,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>       return true;
>   }
> +#endif
>   
>   static target_ulong riscv_transformed_insn(CPURISCVState *env,
>                                              target_ulong insn,
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5514e0f455..04fa320ff8 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2135,21 +2135,31 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
>   
>   static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
>   {
> +    /* Outside of a running cpu, env contains the next pc. */
> +    if (ra == 0) {
> +        return env->pc;
> +    }
> +
> +#ifdef CONFIG_TCG
>       uint64_t data[INSN_START_WORDS];
>   
> -    /* Outside of a running cpu, env contains the next pc. */
> -    if (ra == 0 || !cpu_unwind_state_data(env_cpu(env), ra, data)) {
> +    if (!cpu_unwind_state_data(env_cpu(env), ra, data)) {
>           return env->pc;
>       }
>   
>       /* Within unwind data, [0] is pc and [1] is the opcode. */
>       return data[0] + insn_len(data[1]);
> +#else
> +    qemu_build_not_reached();
> +#endif
>   }
>   
>   static RISCVException write_misa(CPURISCVState *env, int csrno,
>                                    target_ulong val, uintptr_t ra)
>   {
> +#ifdef CONFIG_TCG
>       RISCVCPU *cpu = env_archcpu(env);
> +#endif
>       uint32_t orig_misa_ext = env->misa_ext;
>       Error *local_err = NULL;
>   
> @@ -2178,7 +2188,11 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>       }
>   
>       env->misa_ext = val;
> +#ifdef CONFIG_TCG
>       riscv_cpu_validate_set_extensions(cpu, &local_err);

Maybe clearer to add as a stub?

> +#else
> +    qemu_build_not_reached();
> +#endif
>       if (local_err != NULL) {
>           /* Rollback on validation error */
>           qemu_log_mask(LOG_GUEST_ERROR, "Unable to write MISA ext value "

