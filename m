Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A27C61DFD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 01:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Did-0006rw-J9; Mon, 31 Aug 2026 21:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x1DiZ-0006rh-KG
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 21:55:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x1DiW-0005WM-J5
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 21:55:19 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxpvB8MJZqmzkHAA--.20217S3;
 Tue, 01 Sep 2026 09:55:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx2c15MJZq65cYAA--.52001S2;
 Tue, 01 Sep 2026 09:55:07 +0800 (CST)
Subject: Re: [PATCH V4] target/loongarch: clear the registers when cpu is reset
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 Song Gao <gaosong@loongson.cn>
References: <20260709111901.61597-1-lixianglai@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <3f7a0590-53f6-4248-485a-07199ae32acb@loongson.cn>
Date: Tue, 1 Sep 2026 09:54:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260709111901.61597-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx2c15MJZq65cYAA--.52001S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4Dtw1fXFWxZF48GrW8KrX_yoWxCw43pr
 45KFZFkw45Kr4UCr45X398AFn8Zr18Gw4Iq3sxKr1FkrW5Xr9aqFW0qr4FkFZrA34fCr48
 XFnFgrZFqF4UA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOF4_U
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.034,
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

Applied in loongarch-next

On 2026/7/9 下午7:19, Xianglai Li wrote:
> Use virt-manager to start a virtual machine, and then use the following
> command to manually trigger the crash of the virtual machine:
> echo c > /proc/sysrq-trigger
> 
> After the VM is abnormal, the ESTAT register has a certain probability of
> remaining interrupted. Then the VM is forced to restart and the VM is
> suspended in the interrupt handling function during startup.
> 
> In order to clear the remaining interrupt information in the ESTAT
> register, we performed this operation during the reset process, while also
> checking and optimizing the status of other CSR registers.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Cc: Song Gao <gaosong@loongson.cn>
> 
> changelog:
> V3->V4:
> Remove the field end_reset_fields from the CPUSysState structure, and
> rearrange other fields as needed to avoid them being zeroed out.
> 
> V2->V3:
> Remove or update outdated comments related to this patch.
> 
> V1->V2:
> 1.Add a description of the issues related to this patch
> 2.Replace the macro definition MAX_PERF_EVENTS with the variable
> perf_event_num as the condition for the for loop.
> 3.Rebase against the latest codebase.
> 4.Refer to the usage of end_reset_fields on ARM and other architectures,
> and modify the current implementation accordingly.
> 
>   target/loongarch/cpu.c | 56 ++++++++----------------------------------
>   target/loongarch/cpu.h | 19 ++++++++------
>   2 files changed, 22 insertions(+), 53 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fb03424ffa..11b7e374c3 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -601,11 +601,19 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
>       CPULoongArchState *env = cpu_env(cs);
>       CPUSysState *sys = env_sys(env);
> +    uint64_t reg_prcfg2;
>   
>       if (lacc->parent_phases.hold) {
>           lacc->parent_phases.hold(obj, type);
>       }
>   
> +    reg_prcfg2 = sys->CSR_PRCFG2;
> +    /*
> +     * Workaround for edk2-stable202408, CSR PGD register is set only if
> +     * its value is equal to zero for boot cpu, it causes reboot issue.
> +     */
> +    memset(env, 0, offsetof(CPULoongArchState, end_reset_fields));
> +
>   #ifdef CONFIG_TCG
>       env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
>   
> @@ -620,47 +628,12 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>                              R_TLBENTRY_32_PPN_MASK;
>       }
>   #endif
> -    env->fcsr0 = 0x0;
>   
> -    int n;
> -    /* Set csr registers value after reset, see the manual 6.4. */
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
>       sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
> -
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
> -
> -    sys->CSR_MISC = 0;
> -
> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
> -
> -    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
> -    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
>       sys->CSR_CPUID = cs->cpu_index;
> -    sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
> -    sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
> -    sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
> -    sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
>       sys->CSR_TID = cs->cpu_index;
> -    /*
> -     * Workaround for edk2-stable202408, CSR PGD register is set only if
> -     * its value is equal to zero for boot cpu, it causes reboot issue.
> -     *
> -     * Here clear CSR registers relative with TLB.
> -     */
> -    sys->CSR_PGDH = 0;
> -    sys->CSR_PGDL = 0;
> -    sys->CSR_PWCH = 0;
> -    sys->CSR_EENTRY = 0;
> -    sys->CSR_TLBRENTRY = 0;
> -    sys->CSR_MERRENTRY = 0;
> +    sys->CSR_PRCFG2 = reg_prcfg2;
> +
>       /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
>       if (sys->CSR_PRCFG2 == 0) {
>           sys->CSR_PRCFG2 = 0x3fffff000;
> @@ -668,18 +641,9 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       tlb_ps = ctz32(sys->CSR_PRCFG2);
>       sys->CSR_STLBPS = FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
>       sys->CSR_PWCL = FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
> -    for (n = 0; n < 4; n++) {
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV0, 0);
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV1, 0);
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV2, 0);
> -        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV3, 0);
> -    }
>   
>   #ifndef CONFIG_USER_ONLY
>       env->pc = 0x1c000000;
> -#ifdef CONFIG_TCG
> -    memset(env->tlb, 0, sizeof(env->tlb));
> -#endif
>       if (kvm_enabled()) {
>           kvm_arch_reset_vcpu(cs);
>       }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ad30c73167..28760bdca4 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -390,16 +390,11 @@ typedef struct CPUArchState {
>       uint32_t fcsr0;
>       lbt_t  lbt;
>   
> -    uint32_t cpucfg[21];
> -    uint32_t pv_features;
> -    uint64_t vendor_id;
> -    uint64_t cpu_id;
>       CPUSysState sys_states[1];
>   
>       struct {
>           uint64_t guest_addr;
>       } stealtime;
> -    uint32_t perf_event_num;
>   
>   #ifdef CONFIG_TCG
>       float_status fp_status;
> @@ -409,12 +404,22 @@ typedef struct CPUArchState {
>       uint64_t llval_high; /* For 128-bit atomic SC.Q */
>       uint64_t llbit_scq; /* Potential LL.D+LD.D+SC.Q sequence in effect */
>       uint64_t hw_pte_mask; /* Mask of architecturally-defined (hardware) PTE bits. */
> -#endif
> +
>   #ifndef CONFIG_USER_ONLY
> -#ifdef CONFIG_TCG
>       LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
> +#endif
>   #endif
>   
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
> +    uint32_t cpucfg[21];
> +    uint32_t pv_features;
> +    uint64_t vendor_id;
> +    uint64_t cpu_id;
> +    uint32_t perf_event_num;
> +
> +#ifndef CONFIG_USER_ONLY
>       AddressSpace *address_space_iocsr;
>       uint32_t mp_state;
>   #endif
> 


