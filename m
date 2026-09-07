Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE2C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3P9A-0008Kn-3G; Sun, 06 Sep 2026 22:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1x3P97-0008Kb-T5
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:31:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1x3P94-0007W8-De
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:31:45 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxS_AEIp5qlkoJAA--.26850S3;
 Mon, 07 Sep 2026 10:31:34 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJCxtMwCIp5qeD0cAA--.33102S2;
 Mon, 07 Sep 2026 10:31:32 +0800 (CST)
Subject: Re: [PATCH V5] target/loongarch: clear the registers when cpu is reset
To: qemu-devel@nongnu.org
References: <20260903075808.1175159-1-lixianglai@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <fac9ed3e-21eb-17c4-4afc-43d7268b0d42@loongson.cn>
Date: Mon, 7 Sep 2026 10:30:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260903075808.1175159-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxtMwCIp5qeD0cAA--.33102S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4Dtw1fXFWxZF48GrW8KrX_yoW3WFWUpr
 43KFZI9a15KF4fCrn5X398AFsxZr1xGa1Iq3srKr1FkayFqr9aqFWvqr1SkFWDAryrCr4r
 ZFnrWr47tF47Z3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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

for testing
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
> V4->V5:
> In the `CPUSysState` structure, the members `CSR_ASID`, `CSR_PRCFG1`,
> `CSR_PRCFG2`, and `CSR_PRCFG3` cannot be directly cleared to zero.
> Therefore, we have also added the `end_reset_fields` member to the
> `CPUSysState` structure to prevent them from being directly zeroed out.
>
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
>   target/loongarch/cpu.c | 54 +++++++-----------------------------------
>   target/loongarch/cpu.h | 34 ++++++++++++++++----------
>   2 files changed, 29 insertions(+), 59 deletions(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 84a130956d..18d73ebc1b 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -623,6 +623,13 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>           lacc->parent_phases.hold(obj, type);
>       }
>   
> +    /*
> +     * Workaround for edk2-stable202408, CSR PGD register is set only if
> +     * its value is equal to zero for boot cpu, it causes reboot issue.
> +     */
> +    memset(env, 0, offsetof(CPULoongArchState, end_reset_fields));
> +    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
> +
>   #ifdef CONFIG_TCG
>       env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
>   
> @@ -637,47 +644,11 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
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
> +
>       /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
>       if (sys->CSR_PRCFG2 == 0) {
>           sys->CSR_PRCFG2 = 0x3fffff000;
> @@ -685,18 +656,9 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
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
> index 97db3b453f..d83dcef6f8 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -334,7 +334,6 @@ typedef struct CPUSysState {
>       uint64_t CSR_TLBEHI;
>       uint64_t CSR_TLBELO0;
>       uint64_t CSR_TLBELO1;
> -    uint64_t CSR_ASID;
>       uint64_t CSR_PGDL;
>       uint64_t CSR_PGDH;
>       uint64_t CSR_PGD;
> @@ -343,9 +342,6 @@ typedef struct CPUSysState {
>       uint64_t CSR_STLBPS;
>       uint64_t CSR_RVACFG;
>       uint64_t CSR_CPUID;
> -    uint64_t CSR_PRCFG1;
> -    uint64_t CSR_PRCFG2;
> -    uint64_t CSR_PRCFG3;
>       uint64_t CSR_SAVE[16];
>       uint64_t CSR_TID;
>       uint64_t CSR_TCFG;
> @@ -380,6 +376,14 @@ typedef struct CPUSysState {
>       uint64_t CSR_MSGIS[N_MSGIS];
>       uint64_t CSR_MSGIR;
>       uint64_t CSR_MSGIE;
> +
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
> +    uint64_t CSR_ASID;
> +    uint64_t CSR_PRCFG1;
> +    uint64_t CSR_PRCFG2;
> +    uint64_t CSR_PRCFG3;
>   } CPUSysState;
>   
>   typedef struct CPUArchState {
> @@ -391,16 +395,9 @@ typedef struct CPUArchState {
>       uint32_t fcsr0;
>       lbt_t  lbt;
>   
> -    uint32_t cpucfg[21];
> -    uint32_t pv_features;
> -    uint64_t vendor_id;
> -    uint64_t cpu_id;
> -    CPUSysState sys_states[1];
> -
>       struct {
>           uint64_t guest_addr;
>       } stealtime;
> -    uint32_t perf_event_num;
>   
>   #ifdef CONFIG_TCG
>       float_status fp_status;
> @@ -410,12 +407,23 @@ typedef struct CPUArchState {
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
> +    CPUSysState sys_states[1];
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


