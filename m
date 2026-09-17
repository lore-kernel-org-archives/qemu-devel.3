Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53153C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7IrP-0007uz-Sb; Thu, 17 Sep 2026 16:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7IrN-0007ul-Uk; Thu, 17 Sep 2026 16:37:33 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7IrL-0004dH-2B; Thu, 17 Sep 2026 16:37:33 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68HKbCpb080176
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Sep 2026 05:37:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dPLXbKow37dh7WPmzkGAhMdpX+7mzyE6T5kzZTMPOOc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789677432; v=1;
 b=tSMnhTB5mN1/SwIZLDWQ83RlUnh+uHA7A2D5UCgL4mrikOOUo1kv5DGYmNi8L5Vv
 HQ2bZaHj7TvbX8CfwN6WSwwomxCqC07Bf/CWb3QMREPHbv8l+4svQVJJL5JN10Sd
 jJwOtGoJVj6PgAvqhsjdPk7kw1eA98gYyIGlarXCsmTnGznfVMXzuuFKyA5FGxnG
 zzS2cmlD2tLX2FnwkDLu4FNKZEc/T1v9ybbD3PPWEgzgcLIkxjDICG2779Zi8aKD
 2Q9gEIl6CK6JuVUv8WmRzIBV+JpQfNxHbCDYjW4n2140u+9LGsAArk/MVuGAoanN
 F+ZYZpPOo/F5TVuIHnJ52g==
Message-ID: <bea1f8ac-4dd0-4c98-b3b5-9040b6d6f771@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Sep 2026 05:37:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 04/10] target/arm/hvf, whpx: wire ISV=0 emulation
 for data aborts
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Lucas Amaral <lucaaamaral@gmail.com>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-5-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260916100021.73825-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/09/16 19:00, Mohamed Mediouni wrote:
> From: Lucas Amaral <lucaaamaral@gmail.com>
> 
> When a data abort with ISV=0 occurs during MMIO emulation, the
> syndrome register does not carry the access size or target register.
> Previously this hit an assert(isv) and killed the VM.
> 
> Replace the assert with instruction fetch + decode + emulate using the
> shared library in target/arm/emulate/.  The faulting instruction is read
> from guest memory via cpu_memory_rw_debug(), decoded by the decodetree-
> generated decoder, and emulated against the vCPU register file.
> 
> Both HVF (macOS) and WHPX (Windows Hyper-V) use the same pattern:
>    1. cpu_synchronize_state() to flush hypervisor registers
>    2. Fetch 4-byte instruction at env->pc
>    3. arm_emul_insn(env, insn)
>    4. On success, advance PC past the emulated instruction
> 
> If the instruction is unhandled or a memory error occurs, a synchronous
> external abort is injected into the guest via syn_data_abort_no_iss()
> with fnv=1 and fsc=0x10, matching the syndrome that KVM uses in
> kvm_inject_arm_sea().  The guest kernel's fault handler then reports
> the error through its normal data abort path.
> 
> WHPX adds a whpx_inject_data_abort() helper and adjusts the
> whpx_handle_mmio() return convention so the caller skips PC advancement
> when an exception has been injected.
> 
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
>   target/arm/hvf/hvf.c       | 46 ++++++++++++++++++++++++++--
>   target/arm/whpx/whpx-all.c | 61 +++++++++++++++++++++++++++++++++++++-
>   2 files changed, 103 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b00a7e1a84..a087e920e9 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -34,6 +34,7 @@
>   #include "arm-powerctl.h"
>   #include "target/arm/cpu.h"
>   #include "target/arm/internals.h"
> +#include "emulate/arm_emulate.h"
>   #include "target/arm/multiprocessing.h"
>   #include "target/arm/gtimer.h"
>   #include "target/arm/trace.h"
> @@ -2441,10 +2442,49 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>           assert(!s1ptw);
>   
>           /*
> -         * TODO: ISV will be 0 for SIMD or SVE accesses.
> -         * Inject the exception into the guest.
> +         * ISV=0: syndrome doesn't carry access size/register info.
> +         * Fetch and emulate via target/arm/emulate/.
>            */
> -        assert(isv);
> +        if (!isv) {
> +            ARMCPU *arm_cpu = ARM_CPU(cpu);
> +            CPUARMState *env = &arm_cpu->env;
> +            uint32_t insn;
> +            ArmEmulResult r;
> +
> +            cpu_synchronize_state(cpu);
> +
> +            if (cpu_memory_rw_debug(cpu, env->pc,
> +                                    (uint8_t *)&insn, 4, false) != 0) {
> +                bool same_el = arm_current_el(env) == 1;

This hardcodes exception target EL1, including failures at guest EL2 
with virtualization=on. arm_cpu_do_interrupt() then selects VBAR_EL1, 
overwrites EL1 exception registers, and changes execution to EL1. Derive 
the abort target and same_el from the current EL and exception routing. 
The instruction-fetch failure branch has the same defect.

Regards,
Akihiko Odaki

> +                uint32_t esr = syn_data_abort_no_iss(same_el,
> +                    1, 0, 0, 0, iswrite, 0x10);
> +
> +                error_report("HVF: cannot read insn at pc=0x%" PRIx64,
> +                             (uint64_t)env->pc);
> +                env->exception.vaddress = excp->virtual_address;
> +                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
> +                break;
> +            }
> +
> +            r = arm_emul_insn(env, insn);
> +            if (r == ARM_EMUL_UNHANDLED || r == ARM_EMUL_ERR_MEM) {
> +                bool same_el = arm_current_el(env) == 1;
> +                uint32_t esr = syn_data_abort_no_iss(same_el,
> +                    1, 0, 0, 0, iswrite, 0x10);
> +
> +                error_report("HVF: ISV=0 %s insn 0x%08x at "
> +                             "pc=0x%" PRIx64 ", injecting data abort",
> +                             r == ARM_EMUL_UNHANDLED ? "unhandled"
> +                                                     : "memory error",
> +                             insn, (uint64_t)env->pc);
> +                env->exception.vaddress = excp->virtual_address;
> +                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
> +                break;
> +            }
> +
> +            advance_pc = true;
> +            break;
> +        }
>   
>           /*
>            * Emulate MMIO.
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index d106400686..c916df35a7 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -29,6 +29,7 @@
>   #include "syndrome.h"
>   #include "target/arm/cpregs.h"
>   #include "internals.h"
> +#include "emulate/arm_emulate.h"
>   
>   #include "system/whpx-internal.h"
>   #include "system/whpx-accel-ops.h"
> @@ -350,6 +351,27 @@ static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
>       whpx_set_reg(cpu, reg, reg_val);
>   }
>   
> +/*
> + * Inject a synchronous external abort (data abort) into the guest.
> + * Used when ISV=0 instruction emulation fails.  Matches the syndrome
> + * that KVM uses in kvm_inject_arm_sea().
> + */
> +static void whpx_inject_data_abort(CPUState *cpu, bool iswrite)
> +{
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +    bool same_el = arm_current_el(env) == 1;
> +    uint32_t esr = syn_data_abort_no_iss(same_el, 1, 0, 0, 0, iswrite, 0x10);
> +
> +    cpu->exception_index = EXCP_DATA_ABORT;
> +    env->exception.target_el = 1;
> +    env->exception.syndrome = esr;
> +
> +    bql_lock();
> +    arm_cpu_do_interrupt(cpu);
> +    bql_unlock();
> +}
> +
>   static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
>   {
>       uint64_t syndrome = ctx->Syndrome;
> @@ -365,7 +387,40 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
>   
>       assert(syn_get_ec(syndrome) == EC_DATAABORT);
>       assert(!cm);
> -    assert(isv);
> +
> +    /*
> +     * ISV=0: syndrome doesn't carry access size/register info.
> +     * Fetch and decode the faulting instruction via the emulation library.
> +     */
> +    if (!isv) {
> +        ARMCPU *arm_cpu = ARM_CPU(cpu);
> +        CPUARMState *env = &arm_cpu->env;
> +        uint32_t insn;
> +        ArmEmulResult r;
> +
> +        cpu_synchronize_state(cpu);
> +
> +        if (cpu_memory_rw_debug(cpu, env->pc,
> +                                (uint8_t *)&insn, 4, false) != 0) {
> +            error_report("WHPX: cannot read insn at pc=0x%" PRIx64,
> +                         (uint64_t)env->pc);
> +            whpx_inject_data_abort(cpu, iswrite);
> +            return 1;
> +        }
> +
> +        r = arm_emul_insn(env, insn);
> +        if (r == ARM_EMUL_UNHANDLED || r == ARM_EMUL_ERR_MEM) {
> +            error_report("WHPX: ISV=0 %s insn 0x%08x at "
> +                         "pc=0x%" PRIx64 ", injecting data abort",
> +                         r == ARM_EMUL_UNHANDLED ? "unhandled"
> +                                                 : "memory error",
> +                         insn, (uint64_t)env->pc);
> +            whpx_inject_data_abort(cpu, iswrite);
> +            return 1;
> +        }
> +
> +        return 0;
> +    }
>   
>       if (iswrite) {
>           val = whpx_get_gp_reg(cpu, srt);
> @@ -451,6 +506,10 @@ int whpx_vcpu_run(CPUState *cpu)
>               }
>   
>               ret = whpx_handle_mmio(cpu, &vcpu->exit_ctx.MemoryAccess);
> +            if (ret > 0) {
> +                advance_pc = false;
> +                ret = 0;
> +            }
>               break;
>           case WHvRunVpExitReasonCanceled:
>               cpu->exception_index = EXCP_INTERRUPT;


