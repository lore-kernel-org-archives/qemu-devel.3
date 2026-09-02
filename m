Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209FAC624D5
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hhP-00017N-UX; Wed, 02 Sep 2026 05:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x1hhN-00017E-BP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:56:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x1hhJ-0001Ve-UN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:56:05 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxpvCr8pdq_LgHAA--.21894S3;
 Wed, 02 Sep 2026 17:55:55 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxBc2o8pdqHoIZAA--.26221S2;
 Wed, 02 Sep 2026 17:55:54 +0800 (CST)
Subject: Re: [PATCH v4 08/14] target/loongarch: Add LVZ guest CSR helpers
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1787739852.git.prcups@krgm.moe>
 <ff1b8657252d1247f22d68a0fb55dad2690357a4.1787739852.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4cbe86a0-1cd8-b5fc-ed58-f179599a533b@loongson.cn>
Date: Wed, 2 Sep 2026 17:55:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ff1b8657252d1247f22d68a0fb55dad2690357a4.1787739852.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxBc2o8pdqHoIZAA--.26221S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3uw43CF1rXw47tFyUXr17CFX_yoW8Gr45uo
 WfCF4aya1rJwsYvF9rCwsxXw4UtFy8Aw4DZF92kws8C3Z7Ar4Y934rJryvya1xtFn5WrWU
 CwnIga4DGF4fAryfl-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
 1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 2DUUUUUUU
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
> Add helper behavior for guest PGD, ESTAT, ASID and timer interrupt clearing,
> and for the host LVZ control CSRs.
> 
> Synchronize injected and currently pending passthrough interrupts into
> the guest ESTAT value whenever GINTC changes.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/tcg/csr_helper.c | 226 +++++++++++++++++++++++++-----
>   target/loongarch/tcg/helper.h     |  10 ++
>   2 files changed, 203 insertions(+), 33 deletions(-)
> 
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index fa75508244..ba30060ba4 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -18,9 +18,10 @@
>   #include "cpu-csr.h"
>   #include "cpu-mmu.h"
>   
> -target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
> +static target_ulong helper_csrwr_stlbps_impl(CPULoongArchState *env,
> +                                             target_ulong val, bool guest)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
>       int64_t old_v = sys->CSR_STLBPS;
>   
>       /*
> @@ -40,10 +41,21 @@ target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrrd_pgd(CPULoongArchState *env)
> +target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_stlbps_impl(env, val, false);
> +}
> +
> +target_ulong helper_gcsrwr_stlbps(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_stlbps_impl(env, val, true);
> +}
> +
> +static target_ulong helper_csrrd_pgd_impl(CPULoongArchState *env,
> +                                          bool guest)
>   {
>       int64_t v;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
>   
>       if (sys->CSR_TLBRERA & 0x1) {
>           v = sys->CSR_TLBRBADV;
> @@ -60,6 +72,16 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>       return v;
>   }
>   
> +target_ulong helper_csrrd_pgd(CPULoongArchState *env)
> +{
> +    return helper_csrrd_pgd_impl(env, false);
> +}
> +
> +target_ulong helper_gcsrrd_pgd(CPULoongArchState *env)
> +{
> +    return helper_csrrd_pgd_impl(env, true);
> +}
> +
>   target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
>   {
>       LoongArchCPU *lac = env_archcpu(env);
> @@ -70,18 +92,22 @@ target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
>       return sys->CSR_CPUID;
>   }
>   
> -target_ulong helper_csrrd_tval(CPULoongArchState *env)
> +static target_ulong helper_csrrd_tval_impl(CPULoongArchState *env,
> +                                           bool guest)
>   {
>       LoongArchCPU *cpu = env_archcpu(env);
>   
> -    return cpu_loongarch_get_constant_timer_ticks(cpu, false);
> +    return cpu_loongarch_get_constant_timer_ticks(cpu, guest);
>   }
>   
> -target_ulong helper_gcsrrd_tval(CPULoongArchState *env)
> +target_ulong helper_csrrd_tval(CPULoongArchState *env)
>   {
> -    LoongArchCPU *cpu = env_archcpu(env);
> +    return helper_csrrd_tval_impl(env, false);
> +}
>   
> -    return cpu_loongarch_get_constant_timer_ticks(cpu, true);
> +target_ulong helper_gcsrrd_tval(CPULoongArchState *env)
> +{
> +    return helper_csrrd_tval_impl(env, true);
>   }
>   
>   target_ulong helper_csrrd_msgir(CPULoongArchState *env)
> @@ -106,20 +132,45 @@ target_ulong helper_csrrd_msgir(CPULoongArchState *env)
>       return irq;
>   }
>   
> -target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
> +static target_ulong helper_csrwr_estat_impl(CPULoongArchState *env,
> +                                            target_ulong val, bool guest)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
>       int64_t old_v = sys->CSR_ESTAT;
>   
>       /* Only IS[1:0] can be written */
>       sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
> +    if (guest && env_vm_level(env) != LOONGARCH_VM_LEVEL_GUEST) {
> +        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 2, 11,
> +                                   extract64(val, 2, 11));
> +        if (extract64(val, 2, 8) &
> +            FIELD_EX64(host->CSR_GINTC, CSR_GINTC, HWIC)) {
> +            host->CSR_ESTAT = deposit64(host->CSR_ESTAT, 2, 8,
> +                                        extract64(host->CSR_ESTAT, 2, 8) &
> +                                        ~extract64(val, 2, 8));
> +        }
> +        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 16, 15,
> +                                   extract64(val, 16, 15));
> +    }
>   
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    return helper_csrwr_estat_impl(env, val, false);
> +}
> +
> +target_ulong helper_gcsrwr_estat(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_estat_impl(env, val, true);
> +}
> +
> +static target_ulong helper_csrwr_asid_impl(CPULoongArchState *env,
> +                                           target_ulong val, bool guest)
> +{
> +    CPUSysState *sys = get_sys(env, guest);
>       int64_t old_v = sys->CSR_ASID;
>   
>       /* Only ASID filed of CSR_ASID can be written */
> @@ -130,45 +181,132 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_asid_impl(env, val, false);
> +}
> +
> +target_ulong helper_gcsrwr_asid(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_asid_impl(env, val, true);
> +}
> +
> +static target_ulong helper_csrwr_tcfg_impl(CPULoongArchState *env,
> +                                           target_ulong val, bool guest)
>   {
>       LoongArchCPU *cpu = env_archcpu(env);
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
>       int64_t old_v = sys->CSR_TCFG;
>   
> -    cpu_loongarch_store_constant_timer_config(cpu, val, false);
> +    cpu_loongarch_store_constant_timer_config(cpu, val, guest);
>   
>       return old_v;
>   }
>   
> -target_ulong helper_gcsrwr_tcfg(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
>   {
> -    LoongArchCPU *cpu = env_archcpu(env);
> -    CPUSysState *guest = get_sys(env, LOONGARCH_VM_LEVEL_GUEST);
> -    int64_t old_v = guest->CSR_TCFG;
> -
> -    cpu_loongarch_store_constant_timer_config(cpu, val, true);
> +    return helper_csrwr_tcfg_impl(env, val, false);
> +}
>   
> -    return old_v;
> +target_ulong helper_gcsrwr_tcfg(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_tcfg_impl(env, val, true);
>   }
>   
> -target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
> +static target_ulong helper_csrwr_ticlr_impl(CPULoongArchState *env,
> +                                            target_ulong val, bool guest)
>   {
>       LoongArchCPU *cpu = env_archcpu(env);
>       int64_t old_v = 0;
>   
>       if (val & 0x1) {
>           bql_lock();
> -        loongarch_cpu_set_irq(cpu, IRQ_TIMER, 0);
> +        loongarch_cpu_set_irq_impl(cpu, IRQ_TIMER, 0, guest);
>           bql_unlock();
>       }
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_ticlr_impl(env, val, false);
> +}
> +
> +target_ulong helper_gcsrwr_ticlr(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_ticlr_impl(env, val, true);
> +}
> +
> +target_ulong helper_csrwr_gstat(CPULoongArchState *env, target_ulong val)
> +{
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
> +    int64_t old_v = host->CSR_GSTAT;
> +    uint8_t old_gid = FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, GID);
> +
> +    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM,
> +                                 FIELD_EX64(val, CSR_GSTAT, PVM));
> +    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, GID,
> +                                 FIELD_EX64(val, CSR_GSTAT, GID));
> +
> +    if (old_gid != FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, GID)) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    return old_v;
> +}
> +
> +target_ulong helper_csrwr_gtlbc(CPULoongArchState *env, target_ulong val)
> +{
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
> +    int64_t old_v = host->CSR_GTLBC;
> +    uint8_t old_use_tgid = FIELD_EX64(old_v, CSR_GTLBC, USETGID);
> +    uint8_t old_tgid = FIELD_EX64(old_v, CSR_GTLBC, TGID);
> +
> +    host->CSR_GTLBC = val;
> +    if (old_use_tgid != FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID) ||
> +        old_tgid != FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID)) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    return old_v;
> +}
> +
> +target_ulong helper_csrwr_gintc(CPULoongArchState *env, target_ulong val)
> +{
> +    CPUState *cs = env_cpu(env);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
> +    CPUSysState *guest = get_sys(env, LOONGARCH_VM_LEVEL_GUEST);
> +    int64_t old_v = host->CSR_GINTC;
> +    uint8_t hwis = FIELD_EX64(val, CSR_GINTC, HWIS);
> +    uint8_t hwip = FIELD_EX64(val, CSR_GINTC, HWIP);
> +    uint8_t pending = extract64(host->CSR_ESTAT, 2, 8);
> +
> +    host->CSR_GINTC = val & 0xffff00;
> +    guest->CSR_ESTAT = deposit64(guest->CSR_ESTAT, 2, 8,
> +                                 hwis | (pending & hwip));
> +
> +    bql_lock();
> +    if (FIELD_EX64(host->CSR_ESTAT, CSR_ESTAT, IS) & ~(hwip << 2)) {
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    } else {
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +    }
it is not necessary to check CSR_ESTAT of host, and inject irq to host.

> +    if (env_vm_level(env) == LOONGARCH_VM_LEVEL_GUEST &&
When writing register gintc, CPU should work in host mode, is that 
right? so it will never reach with env_vm_level(env) == 
LOONGARCH_VM_LEVEL_GUEST.
> +        FIELD_EX64(guest->CSR_ESTAT, CSR_ESTAT, IS)) {
> +        cpu_interrupt(cs, CPU_INTERRUPT_GUEST);
It should only set pending info and not necessary to kick cpu, how about 
something like this:
          cpu_set_interrupt(cs, CPU_INTERRUPT_GUEST);

> +    } else {
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
> +    }
> +    bql_unlock();
> +
> +    return old_v;
> +}
> +
> +static target_ulong helper_csrwr_pwcl_impl(CPULoongArchState *env,
> +                                           target_ulong val, bool guest)
>   {
>       uint8_t shift, ptbase;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, guest);
>       int64_t old_v = sys->CSR_PWCL;
>   
>       /*
> @@ -190,18 +328,40 @@ target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_pwch(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>   {
> -    uint8_t has_ptw;
> -    CPUSysState *sys = env_sys(env);
> +    return helper_csrwr_pwcl_impl(env, val, false);
> +}
> +
> +target_ulong helper_gcsrwr_pwcl(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_pwcl_impl(env, val, true);
> +}
> +
> +static target_ulong helper_csrwr_pwch_impl(CPULoongArchState *env,
> +                                           target_ulong val, bool guest)
> +{
> +    uint8_t host_has_ptw;
> +    CPUSysState *sys = get_sys(env, guest);
>       int64_t old_v = sys->CSR_PWCH;
>   
>       val = FIELD_DP64(val, CSR_PWCH, RESERVE, 0);
> -    has_ptw = FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW);
> -    if (!has_ptw) {
> +    //TODO: host can't read guest cpucfg
> +    host_has_ptw = FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW);
> +    if (!host_has_ptw) {
>           val = FIELD_DP64(val, CSR_PWCH, HPTW_EN, 0);
>       }
>   
>       sys->CSR_PWCH = val;
>       return old_v;
> - }
> +}
> +
> +target_ulong helper_csrwr_pwch(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_pwch_impl(env, val, false);
> +}
> +
> +target_ulong helper_gcsrwr_pwch(CPULoongArchState *env, target_ulong val)
> +{
> +    return helper_csrwr_pwch_impl(env, val, true);
> +}
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index b87de15a99..8e0ddd8693 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -98,18 +98,28 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   #ifndef CONFIG_USER_ONLY
>   /* CSRs helper */
>   DEF_HELPER_1(csrrd_pgd, i64, env)
> +DEF_HELPER_1(gcsrrd_pgd, i64, env)
>   DEF_HELPER_1(csrrd_cpuid, i64, env)
>   DEF_HELPER_1(csrrd_tval, i64, env)
>   DEF_HELPER_1(gcsrrd_tval, i64, env)
>   DEF_HELPER_1(csrrd_msgir, i64, env)
>   DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_stlbps, i64, env, tl)
>   DEF_HELPER_2(csrwr_estat, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_asid, i64, env, tl)
>   DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
>   DEF_HELPER_2(gcsrwr_tcfg, i64, env, tl)
>   DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_ticlr, i64, env, tl)
> +DEF_HELPER_2(csrwr_gstat, i64, env, tl)
> +DEF_HELPER_2(csrwr_gtlbc, i64, env, tl)
> +DEF_HELPER_2(csrwr_gintc, i64, env, tl)
It will be better if it is split into two patches, one is about 
gstat/gtlbc/gintc, the other is gcsrwr/gcsrrd operation.

Regards
Bibo Mao
>   DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_pwcl, i64, env, tl)
>   DEF_HELPER_2(csrwr_pwch, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_pwch, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_b, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_h, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_w, i64, env, tl)
> 


