Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01205C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwt6-0003PQ-3b; Thu, 11 Jul 2024 12:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwt4-0003OT-RS; Thu, 11 Jul 2024 12:43:18 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwt2-0004P9-3v; Thu, 11 Jul 2024 12:43:18 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKgWx4Q6Rz4wxk;
 Fri, 12 Jul 2024 02:43:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKgWt0nyXz4wnx;
 Fri, 12 Jul 2024 02:43:05 +1000 (AEST)
Message-ID: <10c390dd-ff6f-414e-87aa-d17937d4cc71@kaod.org>
Date: Thu, 11 Jul 2024 18:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] ppc/pnv: Implement POWER10 PC xscom registers for
 direct controls
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
 <20240711141851.406677-18-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-18-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=SBUb=OL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/11/24 16:18, Nicholas Piggin wrote:
> The PC unit in the processor core contains xscom registers that provide
> low level status and control of the CPU.
> 
> This implements "direct controls" sufficient for OPAL (skiboot) firmware
> use, which is to stop threads and send them non-maskable IPIs in the
> form of SRESET interrupts.
> 
> POWER10 is sufficiently different (particularly QME and special wakeup)
> from POWER9 that it is not trivial to implement by reusing the code.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/core/cpu.h     |  8 ++++
>   include/hw/ppc/pnv.h      |  2 +
>   include/hw/ppc/pnv_core.h |  3 ++
>   hw/ppc/pnv.c              | 19 +++++++--
>   hw/ppc/pnv_core.c         | 88 ++++++++++++++++++++++++++++++++++++---
>   system/cpus.c             | 10 +++++
>   6 files changed, 122 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index a2c8536943..410e7d6f03 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -984,6 +984,14 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
>    */
>   void cpu_exit(CPUState *cpu);
>   
> +/**
> + * cpu_pause:
> + * @cpu: The CPU to pause.
> + *
> + * Resumes CPU, i.e. puts CPU into stopped state.
> + */
> +void cpu_pause(CPUState *cpu);
> +

I think cpu_pause() deserves to be in a separate patch.


Thanks,

C.


  
>   /**
>    * cpu_resume:
>    * @cpu: The CPU to resume.
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index c56d152889..b7858d310d 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -112,6 +112,8 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb);
>   #define PNV_FDT_ADDR          0x01000000
>   #define PNV_TIMEBASE_FREQ     512000000ULL
>   
> +void pnv_cpu_do_nmi_resume(CPUState *cs);
> +
>   /*
>    * BMC helpers
>    */
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index c8784777a4..1de79a818e 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -109,6 +109,9 @@ OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
>   struct PnvQuad {
>       DeviceState parent_obj;
>   
> +    bool special_wakeup_done;
> +    bool special_wakeup[4];
> +
>       uint32_t quad_id;
>       MemoryRegion xscom_regs;
>       MemoryRegion xscom_qme_regs;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 575f18958d..71b2b3806c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2747,11 +2747,24 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>            */
>           env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
>       }
> +    if (arg.host_int) {
> +        cpu_resume(cs);
> +    }
> +}
> +
> +static void pnv_cpu_do_nmi(CPUState *cs, int resume)
> +{
> +    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(resume));
> +}
> +
> +void pnv_cpu_do_nmi_resume(CPUState *cs)
> +{
> +    pnv_cpu_do_nmi(cs, 1);
>   }
>   
> -static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
> +static void do_pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
>   {
> -    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> +    pnv_cpu_do_nmi(CPU(cpu), 0);
>   }
>   
>   static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
> @@ -2760,7 +2773,7 @@ static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
>       int i;
>   
>       for (i = 0; i < pnv->num_chips; i++) {
> -        pnv_chip_foreach_cpu(pnv->chips[i], pnv_cpu_do_nmi, NULL);
> +        pnv_chip_foreach_cpu(pnv->chips[i], do_pnv_cpu_do_nmi, NULL);
>       }
>   }
>   
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index e03ac5441e..a685a5dc1b 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -185,16 +185,40 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>    */
>   
>   #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
> +#define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
> +#define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
> +#define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
>   
>   static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
>   {
> +    PnvCore *pc = PNV_CORE(opaque);
> +    int nr_threads = CPU_CORE(pc)->nr_threads;
> +    int i;
>       uint32_t offset = addr >> 3;
>       uint64_t val = 0;
>   
>       switch (offset) {
>       case PNV10_XSCOM_EC_CORE_THREAD_STATE:
> -        val = 0;
> +        for (i = 0; i < nr_threads; i++) {
> +            PowerPCCPU *cpu = pc->threads[i];
> +            CPUState *cs = CPU(cpu);
> +
> +            if (cs->halted) {
> +                val |= PPC_BIT(56 + i);
> +            }
> +        }
> +        break;
> +    case PNV10_XSCOM_EC_CORE_THREAD_INFO:
> +        break;
> +    case PNV10_XSCOM_EC_CORE_RAS_STATUS:
> +        for (i = 0; i < nr_threads; i++) {
> +            PowerPCCPU *cpu = pc->threads[i];
> +            CPUState *cs = CPU(cpu);
> +            if (cs->stopped) {
> +                val |= PPC_BIT(0 + 8*i) | PPC_BIT(1 + 8*i);
> +            }
> +        }
>           break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
> @@ -207,9 +231,45 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>   static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>                                            uint64_t val, unsigned int width)
>   {
> +    PnvCore *pc = PNV_CORE(opaque);
> +    int nr_threads = CPU_CORE(pc)->nr_threads;
> +    int i;
>       uint32_t offset = addr >> 3;
>   
>       switch (offset) {
> +    case PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS:
> +        for (i = 0; i < nr_threads; i++) {
> +            PowerPCCPU *cpu = pc->threads[i];
> +            CPUState *cs = CPU(cpu);
> +
> +            if (val & PPC_BIT(7 + 8*i)) { /* stop */
> +                val &= ~PPC_BIT(7 + 8*i);
> +                cpu_pause(cs);
> +            }
> +            if (val & PPC_BIT(6 + 8*i)) { /* start */
> +                val &= ~PPC_BIT(6 + 8*i);
> +                cpu_resume(cs);
> +            }
> +            if (val & PPC_BIT(4 + 8*i)) { /* sreset */
> +                val &= ~PPC_BIT(4 + 8*i);
> +                pnv_cpu_do_nmi_resume(cs);
> +            }
> +            if (val & PPC_BIT(3 + 8*i)) { /* clear maint */
> +                /*
> +                 * Hardware has very particular cases for where clear maint
> +                 * must be used and where start must be used to resume a
> +                 * thread. These are not modelled exactly, just treat
> +                 * this and start the same.
> +                 */
> +                val &= ~PPC_BIT(3 + 8*i);
> +                cpu_resume(cs);
> +            }
> +        }
> +        if (val) {
> +            qemu_log_mask(LOG_UNIMP, "%s: unimp bits in DIRECT_CONTROLS 0x%016lx\n", __func__, val);
> +        }
> +        break;
> +
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);
> @@ -528,6 +588,7 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
>   static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
>                                               unsigned int width)
>   {
> +    PnvQuad *eq = PNV_QUAD(opaque);
>       uint32_t offset = addr >> 3;
>       uint64_t val = -1;
>   
> @@ -535,10 +596,14 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
>        * Forth nibble selects the core within a quad, mask it to process read
>        * for any core.
>        */
> -    switch (offset & ~0xf000) {
> -    case P10_QME_SPWU_HYP:
> +    switch (offset & ~PPC_BITMASK32(16, 19)) {
>       case P10_QME_SSH_HYP:
> -        return 0;
> +        val = 0;
> +        if (eq->special_wakeup_done) {
> +            val |= PPC_BIT(1); /* SPWU DONE */
> +            val |= PPC_BIT(4); /* SSH SPWU DONE */
> +        }
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
> @@ -550,9 +615,22 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
>   static void pnv_qme_power10_xscom_write(void *opaque, hwaddr addr,
>                                            uint64_t val, unsigned int width)
>   {
> +    PnvQuad *eq = PNV_QUAD(opaque);
>       uint32_t offset = addr >> 3;
> +    bool set;
> +    int i;
>   
> -    switch (offset) {
> +    switch (offset & ~PPC_BITMASK32(16, 19)) {
> +    case P10_QME_SPWU_HYP:
> +        set = !!(val & PPC_BIT(0));
> +        eq->special_wakeup_done = set;
> +        for (i = 0; i < 4; i++) {
> +            /* These bits select cores in the quad */
> +            if (offset & PPC_BIT32(16 + i)) {
> +                eq->special_wakeup[i] = set;
> +            }
> +        }
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);
> diff --git a/system/cpus.c b/system/cpus.c
> index d3640c9503..083abbc393 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -613,6 +613,16 @@ void pause_all_vcpus(void)
>       bql_lock();
>   }
>   
> +void cpu_pause(CPUState *cpu)
> +{
> +    if (qemu_cpu_is_self(cpu)) {
> +        qemu_cpu_stop(cpu, true);
> +    } else {
> +        cpu->stop = true;
> +        qemu_cpu_kick(cpu);
> +    }
> +}
> +
>   void cpu_resume(CPUState *cpu)
>   {
>       cpu->stop = false;


