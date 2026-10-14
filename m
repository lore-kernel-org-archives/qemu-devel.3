Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD757CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuaj-0004AG-0t; Wed, 14 Oct 2026 04:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xGuag-00049t-IJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:44:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xGuad-0004Ha-5c
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:44:02 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxX9PFQM9qm7EVAA--.62972S3;
 Wed, 14 Oct 2026 16:43:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxNs3AQM9qtigsAA--.13981S2;
 Wed, 14 Oct 2026 16:43:44 +0800 (CST)
Subject: Re: [PATCH v5 18/23] target/loongarch: add gcsr instructions and vm
 level 1 csr management
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <6e609bcae12b73d8ddc7a7291afa2ba1b74ea4d0.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <6ffa3d86-c325-8837-ad28-48a50e690c34@loongson.cn>
Date: Wed, 14 Oct 2026 16:45:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6e609bcae12b73d8ddc7a7291afa2ba1b74ea4d0.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxNs3AQM9qtigsAA--.13981S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3uw47Kr15uF13JrW7ZFyrAFc_yoW8Ww4Uuo
 WxGF45ZFWrGw4FvasFkw4DXa17XF97C395Cas8uws8W3Z3Cr17Kr1rGrn5Zw4xKF1agrW8
 u3Z2q3Z8GFn3Zr93l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r
 17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 yCJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.783,
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



On 2026/10/9 上午11:05, SignKirigami wrote:
> Add gcsrrd, gcsrwr and gcsrxchg. Make all csr helper be used by both vm level
> 0 and 1.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/disas.c                      |   3 +
>   target/loongarch/insns.decode                 |   6 +
>   target/loongarch/tcg/csr_helper.c             |  78 +++++++-----
>   target/loongarch/tcg/helper.h                 |  22 ++--
>   .../tcg/insn_trans/trans_privileged.c.inc     | 111 ++++++++++++++----
>   5 files changed, 161 insertions(+), 59 deletions(-)
> 
> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> index 03d1e560dd..2436c9eec3 100644
> --- a/target/loongarch/disas.c
> +++ b/target/loongarch/disas.c
> @@ -682,6 +682,9 @@ INSN(bgeu,         rr_offs)
>   INSN(csrrd,        r_csr)
>   INSN(csrwr,        r_csr)
>   INSN(csrxchg,      rr_csr)
> +INSN(gcsrrd,        r_csr)
> +INSN(gcsrwr,        r_csr)
> +INSN(gcsrxchg,      rr_csr)
>   INSN(iocsrrd_b,    rr)
>   INSN(iocsrrd_h,    rr)
>   INSN(iocsrrd_w,    rr)
> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
> index 3089d42044..4612af9433 100644
> --- a/target/loongarch/insns.decode
> +++ b/target/loongarch/insns.decode
> @@ -493,6 +493,12 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
>     csrxchg           0000 0100 .............. ..... .....     @rr_csr
>   }
>   
> +{
> +  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
> +  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
> +  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
> +}
> +
>   iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
>   iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
>   iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index ecfba63228..7ef0032f5d 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -18,9 +18,10 @@
>   #include "cpu-csr.h"
>   #include "cpu-mmu.h"
>   
> -target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_stlbps(CPULoongArchState *env,
> +                                 target_ulong val, uint32_t vm_level)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>       int64_t old_v = sys->CSR_STLBPS;
>   
>       /*
> @@ -40,10 +41,10 @@ target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrrd_pgd(CPULoongArchState *env)
> +target_ulong helper_csrrd_pgd(CPULoongArchState *env, uint32_t vm_level)
>   {
>       int64_t v;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>   
>       if (sys->CSR_TLBRERA & 0x1) {
>           v = sys->CSR_TLBRBADV;
> @@ -60,25 +61,30 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>       return v;
>   }
>   
> -target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
> +target_ulong helper_csrrd_cpuid(CPULoongArchState *env, uint32_t vm_level)
>   {
>       LoongArchCPU *lac = env_archcpu(env);
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
> +
> +    if (vm_level) {
> +        return sys->CSR_CPUID;
> +    }
>   
>       sys->CSR_CPUID = CPU(lac)->cpu_index;
>   
>       return sys->CSR_CPUID;
>   }
>   
> -target_ulong helper_csrrd_tval(CPULoongArchState *env)
> +target_ulong helper_csrrd_tval(CPULoongArchState *env, uint32_t vm_level)
>   {
> -    return cpu_loongarch_get_timer_ticks(env_timer(env));
> +    CPUTimerState *timer = vm_level ? env_guest_timer(env) : env_timer(env);
> +    return cpu_loongarch_get_timer_ticks(timer);
>   }
>   
> -target_ulong helper_csrrd_msgir(CPULoongArchState *env)
> +target_ulong helper_csrrd_msgir(CPULoongArchState *env, uint32_t vm_level)
>   {
>       int irq, new;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>   
>       irq = find_first_bit((unsigned long *)sys->CSR_MSGIS, 256);
>       if (irq < 256) {
> @@ -97,13 +103,23 @@ target_ulong helper_csrrd_msgir(CPULoongArchState *env)
>       return irq;
>   }
>   
> -target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_estat(CPULoongArchState *env,
> +                                target_ulong val, uint32_t vm_level)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>       int64_t old_v = sys->CSR_ESTAT;
>   
> -    /* Only IS[1:0] can be written */
> +    /* When guest = 0, only IS[1:0] can be written.
> +     * When guest = 1, ecode and esubcode of
> +     * VM_LEVEL1 can be written by VM_LEVEL0.
> +     */
>       sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
> +    if (vm_level) {
> +        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 2, 11,
> +                                   extract64(val, 2, 11));
> +        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 16, 15,
> +                                   extract64(val, 16, 15));
> +    }
>       /*
>        * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
>        * Make sure the CPU interrupt request state tracks the pending bits,
> @@ -111,16 +127,17 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>        */
>       if (sys->CSR_ESTAT != old_v) {
>           bql_lock();
> -        loongarch_cpu_update_irq(env_archcpu(env), false);
> +        loongarch_cpu_update_irq(env_archcpu(env), vm_level);
>           bql_unlock();
>       }
>   
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_asid(CPULoongArchState *env,
> +                               target_ulong val, uint32_t vm_level)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>       int64_t old_v = sys->CSR_ASID;
>   
>       /* Only ASID filed of CSR_ASID can be written */
> @@ -131,9 +148,10 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_tcfg(CPULoongArchState *env,
> +                               target_ulong val, uint32_t vm_level)
>   {
> -    CPUTimerState *timer = env_timer(env);
> +    CPUTimerState *timer = vm_level ? env_guest_timer(env) : env_timer(env);
>       CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
>       int64_t old_v = sys->CSR_TCFG;
>   
> @@ -142,9 +160,10 @@ target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_ticlr(CPULoongArchState *env,
> +                                target_ulong val, uint32_t vm_level)
>   {
> -    CPUTimerState *timer = env_timer(env);
> +    CPUTimerState *timer = vm_level ? env_guest_timer(env) : env_timer(env);
>       int64_t old_v = 0;
>   
>       if (val & 0x1) {
> @@ -155,10 +174,11 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_pwcl(CPULoongArchState *env,
> +                               target_ulong val, uint32_t vm_level)
>   {
>       uint8_t shift, ptbase;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>       int64_t old_v = sys->CSR_PWCL;
>   
>       /*
> @@ -180,18 +200,20 @@ target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> -target_ulong helper_csrwr_pwch(CPULoongArchState *env, target_ulong val)
> +target_ulong helper_csrwr_pwch(CPULoongArchState *env,
> +                               target_ulong val, uint32_t vm_level)
>   {
> -    uint8_t has_ptw;
> -    CPUSysState *sys = env_sys(env);
> +    uint8_t host_has_ptw;
> +    CPUSysState *sys = get_sys(env, vm_level);
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
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index a27b80b087..bce5f46dc2 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -93,17 +93,17 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   
>   #ifndef CONFIG_USER_ONLY
>   /* CSRs helper */
> -DEF_HELPER_1(csrrd_pgd, i64, env)
> -DEF_HELPER_1(csrrd_cpuid, i64, env)
> -DEF_HELPER_1(csrrd_tval, i64, env)
> -DEF_HELPER_1(csrrd_msgir, i64, env)
> -DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
> -DEF_HELPER_2(csrwr_estat, i64, env, tl)
> -DEF_HELPER_2(csrwr_asid, i64, env, tl)
> -DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
> -DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
> -DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
> -DEF_HELPER_2(csrwr_pwch, i64, env, tl)
> +DEF_HELPER_2(csrrd_pgd, i64, env, i32)
> +DEF_HELPER_2(csrrd_cpuid, i64, env, i32)
> +DEF_HELPER_2(csrrd_tval, i64, env, i32)
> +DEF_HELPER_2(csrrd_msgir, i64, env, i32)
> +DEF_HELPER_3(csrwr_stlbps, i64, env, tl, i32)
> +DEF_HELPER_3(csrwr_estat, i64, env, tl, i32)
> +DEF_HELPER_3(csrwr_asid, i64, env, tl, i32)
> +DEF_HELPER_3(csrwr_tcfg, i64, env, tl, i32)
> +DEF_HELPER_3(csrwr_ticlr, i64, env, tl, i32)
> +DEF_HELPER_3(csrwr_pwcl, i64, env, tl, i32)
> +DEF_HELPER_3(csrwr_pwch, i64, env, tl, i32)
>   DEF_HELPER_2(iocsrrd_b, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_h, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_w, i64, env, tl)
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 00e8f61e42..139dbd6e2a 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -39,11 +39,14 @@ GEN_FALSE_TRANS(lddir)
>   GEN_FALSE_TRANS(ertn)
>   GEN_FALSE_TRANS(dbcl)
>   GEN_FALSE_TRANS(idle)
> +GEN_FALSE_TRANS(gcsrrd)
> +GEN_FALSE_TRANS(gcsrwr)
> +GEN_FALSE_TRANS(gcsrxchg)
>   
>   #else
>   
> -typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
> -typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
> +typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env, TCGv_i32 vm_level);
> +typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src, TCGv_i32 vm_level);
>   
>   static bool check_plv(DisasContext *ctx)
>   {
> @@ -88,10 +91,14 @@ void loongarch_csr_translate_init(void)
>   }
>   #undef SET_CSR_FUNC
>   
> -static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
> +static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr,
> +                            bool write, int vm_level)
>   {
>       if ((csr->flags & CSRFL_READONLY) && write) {
> -        return false;
> +        /* host writes guest read-only CSRs is allowed */
> +        if (is_guest_mmu_idx(ctx->mem_idx) || vm_level == VM_LEVEL0) {
> +            return false;
> +        }
>       }
>       if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
>           ctx->base.is_jmp = DISAS_EXIT_UPDATE;
> @@ -101,7 +108,7 @@ static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
>       return true;
>   }
>   
> -static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
> +static bool trans_csrrd_impl(DisasContext *ctx, arg_r_csr *a, int vm_level)
>   {
>       TCGv dest;
>       const CSRInfo *csr;
> @@ -116,21 +123,29 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
>           /* CSR is undefined: read as 0. */
>           dest = tcg_constant_tl(0);
>       } else {
> -        check_csr_flags(ctx, csr, false);
> -        dest = gpr_dst(ctx, a->rd, EXT_NONE);
> -        readfn = (GenCSRRead)csr->readfn;
> -        if (readfn) {
> -            readfn(dest, tcg_env);
> +        check_csr_flags(ctx, csr, false, vm_level);
> +        if (vm_level && (csr->flags & CSRFL_GSPR)) {
> +            if (is_guest_mmu_idx(ctx->mem_idx)) {
> +                generate_exception(ctx, EXCCODE_GSPR);
> +                return true;
> +            }
> +            dest = tcg_constant_tl(0);
>           } else {
> -            offset = get_csr_offset(csr, 0);
> -            tcg_gen_ld_tl(dest, tcg_env, offset);
> +            dest = gpr_dst(ctx, a->rd, EXT_NONE);
> +            readfn = (GenCSRRead)csr->readfn;
> +            if (readfn) {
> +                readfn(dest, tcg_env, tcg_constant_i32(vm_level));
> +            } else {
> +                offset = get_csr_offset(csr, vm_level);
> +                tcg_gen_ld_tl(dest, tcg_env, offset);
> +            }
Can this patch be split into three smaller verson? such as:
   1. lvz support with csrrd/csrwr/csrxchg instruction.
   2. lvz support with new gcsrrd/gcsrwr/gcsrxchg instruction.
   3. Common API for csrrd/gcsrrd.
or
   1. lvz support with csrrd/csrwr/csrxchg instruction.
   2. Common API extraction for csrrd/gcsrr.
   3. lvz support with new gcsrrd/gcsrwr/gcsrxchg instruction.

With the smaller versions, it is easier to review and find the potential 
issues.

Regards
Bibo Mao
>           }
>       }
>       gen_set_gpr(a->rd, dest, EXT_NONE);
>       return true;
>   }
>   
> -static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
> +static bool trans_csrwr_impl(DisasContext *ctx, arg_r_csr *a, int vm_level)
>   {
>       TCGv dest, src1;
>       const CSRInfo *csr;
> @@ -146,18 +161,26 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>           gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>           return true;
>       }
> -    if (!check_csr_flags(ctx, csr, true)) {
> +    if (!check_csr_flags(ctx, csr, true, vm_level)) {
>           /* CSR is readonly: trap. */
>           return false;
>       }
> +    if (vm_level && (csr->flags & CSRFL_GSPR)) {
> +        if (is_guest_mmu_idx(ctx->mem_idx)) {
> +            generate_exception(ctx, EXCCODE_GSPR);
> +            return true;
> +        }
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
>       src1 = gpr_src(ctx, a->rd, EXT_NONE);
>       writefn = (GenCSRWrite)csr->writefn;
>       if (writefn) {
>           dest = gpr_dst(ctx, a->rd, EXT_NONE);
> -        writefn(dest, tcg_env, src1);
> +        writefn(dest, tcg_env, src1, tcg_constant_i32(vm_level));
>       } else {
>           dest = tcg_temp_new();
> -        offset = get_csr_offset(csr, 0);
> +        offset = get_csr_offset(csr, vm_level);
>           tcg_gen_ld_tl(dest, tcg_env, offset);
>           tcg_gen_st_tl(src1, tcg_env, offset);
>       }
> @@ -165,7 +188,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>       return true;
>   }
>   
> -static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
> +static bool trans_csrxchg_impl(DisasContext *ctx, arg_rr_csr *a, int vm_level)
>   {
>       TCGv src1, mask, oldv, newv, temp;
>       const CSRInfo *csr;
> @@ -182,11 +205,20 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>           return true;
>       }
>   
> -    if (!check_csr_flags(ctx, csr, true)) {
> +    if (!check_csr_flags(ctx, csr, true, vm_level)) {
>           /* CSR is readonly: trap. */
>           return false;
>       }
>   
> +    if (vm_level && (csr->flags & CSRFL_GSPR)) {
> +        if (is_guest_mmu_idx(ctx->mem_idx)) {
> +            generate_exception(ctx, EXCCODE_GSPR);
> +            return true;
> +        }
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
> +
>       /* So far only readonly csrs have readfn. */
>       assert(csr->readfn == NULL);
>   
> @@ -196,7 +228,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       newv = tcg_temp_new();
>       temp = tcg_temp_new();
>   
> -    offset = get_csr_offset(csr, 0);
> +    offset = get_csr_offset(csr, vm_level);
>       tcg_gen_ld_tl(oldv, tcg_env, offset);
>       tcg_gen_and_tl(newv, src1, mask);
>       tcg_gen_andc_tl(temp, oldv, mask);
> @@ -204,7 +236,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>   
>       writefn = (GenCSRWrite)csr->writefn;
>       if (writefn) {
> -        writefn(oldv, tcg_env, newv);
> +        writefn(oldv, tcg_env, newv, tcg_constant_i32(vm_level));
>       } else {
>           tcg_gen_st_tl(newv, tcg_env, offset);
>       }
> @@ -212,6 +244,45 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       return true;
>   }
>   
> +static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
> +{
> +    return trans_csrrd_impl(ctx, a, is_guest_mmu_idx(ctx->mem_idx));
> +}
> +
> +static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
> +{
> +    return trans_csrwr_impl(ctx, a, is_guest_mmu_idx(ctx->mem_idx));
> +}
> +
> +static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
> +{
> +    return trans_csrxchg_impl(ctx, a, is_guest_mmu_idx(ctx->mem_idx));
> +}
> +
> +static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
> +{
> +    if (!avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    return trans_csrrd_impl(ctx, a, VM_LEVEL1);
> +}
> +
> +static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
> +{
> +    if (!avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    return trans_csrwr_impl(ctx, a, VM_LEVEL1);
> +}
> +
> +static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
> +{
> +    if (!avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
> +        return false;
> +    }
> +    return trans_csrxchg_impl(ctx, a, VM_LEVEL1);
> +}
> +
>   static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
>                           void (*func)(TCGv, TCGv_ptr, TCGv))
>   {
> 


