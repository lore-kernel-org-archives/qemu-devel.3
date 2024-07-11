Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96502C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 17:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRx9o-0002ba-KL; Thu, 11 Jul 2024 13:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRx9W-0002S6-Os; Thu, 11 Jul 2024 13:00:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRx9Q-0003J0-KD; Thu, 11 Jul 2024 13:00:17 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKgvT1lqwz4x12;
 Fri, 12 Jul 2024 03:00:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKgvR1kVGz4wbr;
 Fri, 12 Jul 2024 03:00:02 +1000 (AEST)
Message-ID: <d98c2029-1505-4d2c-93e3-b27877dbdea7@kaod.org>
Date: Thu, 11 Jul 2024 19:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] ppc/pnv: Add an LPAR per core machine option
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
 <20240711141851.406677-19-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-19-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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
> Recent POWER CPUs can operate in "LPAR per core" or "LPAR per thread"
> modes. In per-core mode, some SPRs and IPI doorbells are shared between
> threads in a core. In per-thread mode, supervisor and user state is
> not shared between threads.
> 
> OpenPOWER systems after POWER8 use LPAR per thread mode, and it is
> required for KVM. Enterprise systems use LPAR per core mode, as they
> partition the machine by core.
> 
> Implement a lpar-per-core machine option for powernv machines. This
> is fixed true for POWER8 machines, and defaults off for P9 and P10.
> 
> With this change, powernv8 SMT now works sufficiently to run Linux,
> including KVM.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv.h      |  1 +
>   include/hw/ppc/pnv_core.h |  1 +
>   hw/ppc/pnv.c              | 29 +++++++++++++++++++++++++++++
>   hw/ppc/pnv_core.c         |  8 ++++++++
>   target/ppc/cpu_init.c     |  3 ++-
>   5 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index b7858d310d..73f0d72f55 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -104,6 +104,7 @@ struct PnvMachineState {
>       hwaddr       fw_load_addr;
>   
>       bool         big_core;
> +    bool         lpar_per_core;
>   };
>   
>   PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 1de79a818e..d8afb4f95f 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -57,6 +57,7 @@ struct PnvCore {
>       /*< public >*/
>       PowerPCCPU **threads;
>       bool big_core;
> +    bool lpar_per_core;
>       uint32_t pir;
>       uint32_t hwid;
>       uint64_t hrmor;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 71b2b3806c..f9a05fa0ff 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1026,6 +1026,11 @@ static void pnv_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    if (!object_property_find(OBJECT(pnv), "lpar-per-core")) {
> +        /* POWER8 is always in lpar-per-core mode */
> +        pnv->lpar_per_core = true;
> +    }

yep.

A better alternative would be to introduce a PnvChipClass::lpar_per_core
attribute (set to true for POWER8) and OR PnvChipClass::lpar_per_core
with pnv->lpar_per_core to set the "lpar-per-core" property of PnvCore
in pnv_chip_core_realize().


Thanks,

C.



>       pnv->num_chips =
>           machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
>   
> @@ -2589,6 +2594,18 @@ static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
>       pnv->big_core = value;
>   }
>   
> +static bool pnv_machine_get_1lpar(Object *obj, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    return pnv->lpar_per_core;
> +}
> +
> +static void pnv_machine_set_1lpar(Object *obj, bool value, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    pnv->lpar_per_core = value;
> +}
> +
>   static bool pnv_machine_get_hb(Object *obj, Error **errp)
>   {
>       PnvMachineState *pnv = PNV_MACHINE(obj);
> @@ -2662,6 +2679,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>                                      pnv_machine_set_big_core);
>       object_class_property_set_description(oc, "big-core",
>                                 "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_1lpar,
> +                                   pnv_machine_set_1lpar);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
>   }
>   
>   static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
> @@ -2709,6 +2732,12 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>                                      pnv_machine_set_big_core);
>       object_class_property_set_description(oc, "big-core",
>                                 "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_1lpar,
> +                                   pnv_machine_set_1lpar);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
>   }
>   
>   static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a685a5dc1b..5a6fcb6edc 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -208,6 +208,9 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>                   val |= PPC_BIT(56 + i);
>               }
>           }
> +        if (pc->lpar_per_core) {
> +            val |= PPC_BIT(62);
> +        }
>           break;
>       case PNV10_XSCOM_EC_CORE_THREAD_INFO:
>           break;
> @@ -320,6 +323,10 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>           env->core_index = core_hwid;
>       }
>   
> +    if (pc->lpar_per_core) {
> +        cpu_ppc_set_1lpar(cpu);
> +    }
> +
>       /* Set time-base frequency to 512 MHz */
>       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
>   }
> @@ -352,6 +359,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>   
>       pc->big_core = pnv->big_core;
>       pc->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
> +    pc->lpar_per_core = pc->chip->pnv_machine->lpar_per_core;
>   
>       pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
>       for (i = 0; i < cc->nr_threads; i++) {
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 9349001b76..0fc83d5cc2 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6785,7 +6785,8 @@ void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
>   
>       /*
>        * pseries SMT means "LPAR per core" mode, e.g., msgsndp is usable
> -     * between threads.
> +     * between threads. powernv be in either mode, and it mostly affects
> +     * supervisor visible registers and instructions.
>        */
>       if (env->flags & POWERPC_FLAG_SMT) {
>           env->flags |= POWERPC_FLAG_SMT_1LPAR;


