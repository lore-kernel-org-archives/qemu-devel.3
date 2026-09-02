Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF476C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1h8G-00046N-DR; Wed, 02 Sep 2026 05:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x1h8D-00045u-TY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:19:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x1h8B-0002Jj-0X
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:19:45 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx69Eh6pdqDLYHAA--.21947S3;
 Wed, 02 Sep 2026 17:19:29 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxTs8f6pdq1XsZAA--.53874S2;
 Wed, 02 Sep 2026 17:19:27 +0800 (CST)
Subject: Re: [PATCH v4 07/14] target/loongarch: Add LVZ VM entry and exception
 handling
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1787739852.git.prcups@krgm.moe>
 <3470bfa14e997c73d106a796205b3f0030b2f41c.1787739852.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <16f54939-f140-e3fa-b614-d79160ee6b93@loongson.cn>
Date: Wed, 2 Sep 2026 17:19:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3470bfa14e997c73d106a796205b3f0030b2f41c.1787739852.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs8f6pdq1XsZAA--.53874S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3tr15ur1xCw17Kw1DKrykJFc_yoWDtF4rpF
 WIkF9xKayUKrZrZw1ftayYkF15Zw48Cw4I9FyxGrySyr4DXrWFqr4kK39rKFsrCw15uw48
 uFn3Zr4jgF47JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn
 UUUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.635,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/8/26 下午6:30, SignKirigami wrote:
> Enter guest mode when ERTN restores GSTAT.PVM, and return to the host CSR
> bank for guest-sensitive, hypercall and host interrupt exits. Select the
> exception CSR bank before updating state and expose guest mode in TCG
> flags and MMU indices.
> 
> Bound-check exceptions update the currently active CSR bank. HVC is
> available only to guest PLV0.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c           | 50 ++++++++++++++++++++++++++++++++
>   target/loongarch/tcg/helper.h    |  2 +-
>   target/loongarch/tcg/op_helper.c | 22 ++++++++++++++
>   target/loongarch/tcg/tcg_cpu.c   | 46 ++++++++++++++++++++++-------
>   4 files changed, 109 insertions(+), 11 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ff36294aa5..4b0acc7135 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -129,6 +129,56 @@ bool loongarch_cpu_has_work(CPUState *cs)
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   
> +uint8_t get_tgid(CPULoongArchState *env)
> +{
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
> +
> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +        return get_gid(env);
> +    }
> +
> +    if (FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID)) {
> +        return FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID);
> +    } else if (will_return_to_guest(env)) {
> +        return get_gid(env);
> +    }
> +    return 0;
> +}
> +
> +bool will_return_to_guest(CPULoongArchState *env)
> +{
> +    if (!has_lvz_capability(env) ||
> +        env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +        return false;
> +    }
> +    return FIELD_EX64(get_sys(env, LOONGARCH_VM_LEVEL_HOST)->CSR_GSTAT,
> +                      CSR_GSTAT, PVM);
> +}
> +
> +bool has_lvz_capability(CPULoongArchState *env)
> +{
> +    return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
> +}
> +
> +uint8_t get_gid(CPULoongArchState *env)
> +{
> +    return FIELD_EX64(get_sys(env, LOONGARCH_VM_LEVEL_HOST)->CSR_GSTAT,
> +                      CSR_GSTAT, GID);
> +}
> +
> +void trigger_vm_exit(CPULoongArchState *env)
> +{
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
> +
> +    if (env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
> +        return;
> +    }
> +
> +    cpu_loongarch_set_guest_timer(env_archcpu(env), false);
why to disable guest timer when exiting to VM?
> +    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM, 1);
I think it is unnecesary, PVM bit of CSR_GSTAT is set already when 
entering to VM mode.

> +    env->vm_exit = true;
> +}
> +
>   static void loongarch_la464_init_csr(DeviceState *dev)
>   {
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index a003266827..b87de15a99 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -14,7 +14,7 @@ DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
>   
>   DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
>   DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
> -DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
> +DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_WG_SE, tl, env, tl)
>   
>   /* Floating-point helper */
>   DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_WG, i64, env, i64, i64)
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index e63ac66daa..11d204c61c 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -12,6 +12,7 @@
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "internals.h"
> +#include "qemu/main-loop.h"
>   #include "qemu/crc32c.h"
>   #include <zlib.h> /* for crc32 */
>   #include "cpu-csr.h"
> @@ -19,6 +20,9 @@
>   /* Exceptions helpers */
>   void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
>   {
> +    if (exception == EXCCODE_GSPR || exception == EXCCODE_HVC) {
> +        trigger_vm_exit(env);
> +    }
Had better to add space line here though it is not forcly.
>       do_raise_exception(env, exception, GETPC());
>   }
>   
> @@ -85,6 +89,10 @@ target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
>   
>   target_ulong helper_cpucfg(CPULoongArchState *env, target_ulong rj)
>   {
> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +        trigger_vm_exit(env);
> +        do_raise_exception(env, EXCCODE_GSPR, GETPC());
> +    }
>       return rj >= ARRAY_SIZE(env->cpucfg) ? 0 : env->cpucfg[rj];
>   }
>   
> @@ -111,6 +119,8 @@ void helper_ertn(CPULoongArchState *env)
>   {
>       uint64_t csr_pplv, csr_pie;
>       CPUSysState *sys = env_sys(env);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
> +    CPUSysState *guest = get_sys(env, LOONGARCH_VM_LEVEL_GUEST);
>   
>       if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>           csr_pplv = FIELD_EX64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
> @@ -134,6 +144,18 @@ void helper_ertn(CPULoongArchState *env)
>       sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, csr_pie);
>   
>       env->lladdr = 1;
> +    if (will_return_to_guest(env)) {
> +        host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM, 1);
> +        set_sys(env, LOONGARCH_VM_LEVEL_GUEST);
> +        cpu_loongarch_set_guest_timer(env_archcpu(env), true);
I think it is not necessary to enable guest timer, it is always on even 
if system enter host mode.
> +        bql_lock();
> +        if (FIELD_EX64(guest->CSR_ESTAT, CSR_ESTAT, IS)) {
> +            cpu_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
> +        } else {
> +            cpu_reset_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
> +        }
> +        bql_unlock();
> +    }
>   }
>   
>   void helper_idle(CPULoongArchState *env)
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index e84ef5f305..6af885cda1 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -44,6 +44,10 @@ static const struct TypeExcp excp_names[] = {
>       {EXCCODE_BCE, "Bound Check Exception"},
>       {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
>       {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
> +    {EXCCODE_GSPR, "Guest Sensitive and Privileged Resources"},
> +    {EXCCODE_HVC, "Hypervisor call"},
> +    {EXCCODE_GCSC, "Guest CSR visited by Software"},
> +    {EXCCODE_GCHC, "Guest CSR visited by Hardware"},
>       {EXCP_HLT, "EXCP_HLT"},
>   };
>   
> @@ -78,9 +82,11 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
>   static void loongarch_cpu_do_interrupt(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> -    CPUSysState *sys = env_sys(env);
>       bool update_badinstr = 1;
>       int cause = -1;
> +    bool real_guest = !env->vm_exit && env_vm_level(env);
> +    CPUSysState *sys = get_sys(env, real_guest);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
>       bool tlbfill = FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
>       uint32_t vec_size = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS);
>       uint64_t last_pc = env->pc;
> @@ -96,17 +102,17 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>   
>       switch (cs->exception_index) {
>       case EXCCODE_DBP:
> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
> +        host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DCL, 1);
> +        host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, ECODE, 0xC);
>           goto set_DERA;
>       set_DERA:
> -        sys->CSR_DERA = env->pc;
> -        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
> -        set_pc(env, sys->CSR_EENTRY + 0x480);
> +        host->CSR_DERA = env->pc;
> +        host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DST, 1);
> +        set_pc(env, host->CSR_EENTRY + 0x480);
>           break;
>       case EXCCODE_INT:
> -        if (FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
> -            sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DEI, 1);
> +        if (FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)) {
> +            host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DEI, 1);
>               goto set_DERA;
>           }
>           QEMU_FALLTHROUGH;
> @@ -117,6 +123,10 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           update_badinstr = 0;
>           break;
>       case EXCCODE_BCE:
> +    case EXCCODE_GSPR:
> +    case EXCCODE_GCHC:
> +    case EXCCODE_GCSC:
> +    case EXCCODE_HVC:
>           sys->CSR_BADV = env->pc;
>           QEMU_FALLTHROUGH;
>       case EXCCODE_SYS:
> @@ -218,6 +228,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           qemu_plugin_vcpu_exception_cb(cs, last_pc);
>       }
>       cs->exception_index = -1;
> +    if (env->vm_exit) {
> +        host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM, 0);
> +        set_sys(env, LOONGARCH_VM_LEVEL_HOST);
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
why clear CPU_INTERRUPT_GUEST when exiting to host mode?

I think loongarch_cpu_has_work() need modified as following:
    1. If cpu work in VM mode, checking both CPU_INTERRUPT_HARD and 
CPU_INTERRUPT_GUEST.
    2. If cpu work in host mode, only checking CPU_INTERRUPT_HARD.

Regards
Bibo Mao
> +    }
> +    env->vm_exit = false;
>   }
>   
>   static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> @@ -228,9 +244,9 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                                   uintptr_t retaddr)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
>   
> -    sys->CSR_BADV = addr;
> +    host->CSR_BADV = addr;
>       if (access_type == MMU_INST_FETCH) {
>           do_raise_exception(env, EXCCODE_ADEF, retaddr);
>       } else {
> @@ -293,6 +309,9 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
>       uint32_t flags;
>   
>       flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +        flags |= HW_FLAGS_GUEST_MODE;
> +    }
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
> @@ -320,6 +339,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
>       CPULoongArchState *env = cpu_env(cs);
>       CPUSysState *sys = env_sys(env);
>   
> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST) {
> +        if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
> +            return MMU_GUEST_IDX + FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
> +        }
> +        return MMU_GUEST_DA_IDX;
> +    }
> +
>       if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
>           return FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
>       }
> 


