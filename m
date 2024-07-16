Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20196C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlQM-0002Hw-Of; Tue, 16 Jul 2024 12:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlQ1-0001NE-HC; Tue, 16 Jul 2024 12:52:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlPx-0003Tz-TL; Tue, 16 Jul 2024 12:52:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNlVg4sz0z4wbh;
 Wed, 17 Jul 2024 02:52:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNlVd4Ljpz4wym;
 Wed, 17 Jul 2024 02:52:41 +1000 (AEST)
Message-ID: <3f3bc2d1-ba82-48c9-abbc-35fa87b2308d@kaod.org>
Date: Tue, 16 Jul 2024 18:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] ppc/pnv: Add an LPAR per core machine option
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240716162617.32161-1-npiggin@gmail.com>
 <20240716162617.32161-20-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716162617.32161-20-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/16/24 18:26, Nicholas Piggin wrote:
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
> with a single socket. Multi-threaded KVM guests still have problems,
> as does multi-socket Linux boot.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/pnv.h      |  2 ++
>   include/hw/ppc/pnv_chip.h |  1 +
>   include/hw/ppc/pnv_core.h |  1 +
>   hw/ppc/pnv.c              | 38 ++++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_core.c         |  8 ++++++++
>   target/ppc/cpu_init.c     |  3 ++-
>   6 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index b7858d310d..fcb6699150 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -77,6 +77,7 @@ struct PnvMachineClass {
>       const char *compat;
>       int compat_size;
>       int max_smt_threads;
> +    bool has_lpar_per_thread;
>       bool quirk_tb_big_core;
>   
>       void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
> @@ -104,6 +105,7 @@ struct PnvMachineState {
>       hwaddr       fw_load_addr;
>   
>       bool         big_core;
> +    bool         lpar_per_core;
>   };
>   
>   PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 69d8273efe..ee1649babc 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -28,6 +28,7 @@ struct PnvChip {
>       uint64_t     ram_size;
>   
>       bool         big_core;
> +    bool         lpar_per_core;
>       uint32_t     nr_cores;
>       uint32_t     nr_threads;
>       uint64_t     cores_mask;
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
> index f7580947ed..8d24fc2a45 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1026,6 +1026,11 @@ static void pnv_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    /* Set lpar-per-core mode if lpar-per-thread is not supported */
> +    if (!pmc->has_lpar_per_thread) {
> +        pnv->lpar_per_core = true;
> +    }
> +
>       pnv->num_chips =
>           machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
>   
> @@ -1102,6 +1107,8 @@ static void pnv_init(MachineState *machine)
>                                   &error_fatal);
>           object_property_set_bool(chip, "big-core", pnv->big_core,
>                                   &error_fatal);
> +        object_property_set_bool(chip, "lpar-per-core", pnv->lpar_per_core,
> +                                &error_fatal);
>           /*
>            * The POWER8 machine use the XICS interrupt interface.
>            * Propagate the XICS fabric to the chip and its controllers.
> @@ -2338,6 +2345,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>                                   &error_fatal);
>           object_property_set_bool(OBJECT(pnv_core), "quirk-tb-big-core",
>                                   pmc->quirk_tb_big_core, &error_fatal);
> +        object_property_set_bool(OBJECT(pnv_core), "lpar-per-core",
> +                                chip->lpar_per_core, &error_fatal);
>           object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
>                                    &error_abort);
>   
> @@ -2373,6 +2382,7 @@ static Property pnv_chip_properties[] = {
>       DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
>       DEFINE_PROP_UINT32("nr-threads", PnvChip, nr_threads, 1),
>       DEFINE_PROP_BOOL("big-core", PnvChip, big_core, false),
> +    DEFINE_PROP_BOOL("lpar-per-core", PnvChip, lpar_per_core, false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -2593,6 +2603,18 @@ static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
>       pnv->big_core = value;
>   }
>   
> +static bool pnv_machine_get_lpar_per_core(Object *obj, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    return pnv->lpar_per_core;
> +}
> +
> +static void pnv_machine_set_lpar_per_core(Object *obj, bool value, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    pnv->lpar_per_core = value;
> +}
> +
>   static bool pnv_machine_get_hb(Object *obj, Error **errp)
>   {
>       PnvMachineState *pnv = PNV_MACHINE(obj);
> @@ -2632,6 +2654,8 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->max_smt_threads = 8;
> +    /* POWER8 is always lpar-per-core mode */
> +    pmc->has_lpar_per_thread = false;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>   }
> @@ -2657,6 +2681,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->max_smt_threads = 4;
> +    pmc->has_lpar_per_thread = true;
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> @@ -2666,6 +2691,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>                                      pnv_machine_set_big_core);
>       object_class_property_set_description(oc, "big-core",
>                                 "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_lpar_per_core,
> +                                   pnv_machine_set_lpar_per_core);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
>   }
>   
>   static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
> @@ -2688,6 +2719,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->max_smt_threads = 4;
> +    pmc->has_lpar_per_thread = true;
>       pmc->quirk_tb_big_core = true;
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
> @@ -2713,6 +2745,12 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>                                      pnv_machine_set_big_core);
>       object_class_property_set_description(oc, "big-core",
>                                 "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_lpar_per_core,
> +                                   pnv_machine_set_lpar_per_core);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
>   }
>   
>   static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 8ed1cfe8a2..0384122054 100644
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
> @@ -321,6 +324,10 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
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
> @@ -427,6 +434,7 @@ static Property pnv_core_properties[] = {
>       DEFINE_PROP_BOOL("big-core", PnvCore, big_core, false),
>       DEFINE_PROP_BOOL("quirk-tb-big-core", PnvCore, tod_state.big_core_quirk,
>                        false),
> +    DEFINE_PROP_BOOL("lpar-per-core", PnvCore, lpar_per_core, false),
>       DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 81dd4e1a7a..4ba7f54510 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6803,7 +6803,8 @@ void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
>   
>       /*
>        * pseries SMT means "LPAR per core" mode, e.g., msgsndp is usable
> -     * between threads.
> +     * between threads. powernv be in either mode, and it mostly affects
> +     * supervisor visible registers and instructions.
>        */
>       if (env->flags & POWERPC_FLAG_SMT) {
>           env->flags |= POWERPC_FLAG_SMT_1LPAR;


