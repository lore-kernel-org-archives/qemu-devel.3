Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF202C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwmV-0005rZ-Jl; Thu, 11 Jul 2024 12:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwmP-0005pA-9U; Thu, 11 Jul 2024 12:36:26 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwmM-00027A-GF; Thu, 11 Jul 2024 12:36:24 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKgN22Bglz4wcl;
 Fri, 12 Jul 2024 02:36:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKgN00qFtz4x04;
 Fri, 12 Jul 2024 02:36:15 +1000 (AEST)
Message-ID: <c957be4b-bc28-4f09-bc52-2277b019125a@kaod.org>
Date: Thu, 11 Jul 2024 18:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] ppc/pnv: Add a big-core mode that joins two regular
 cores
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
 <20240711141851.406677-12-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-12-npiggin@gmail.com>
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
> POWER9 and POWER10 machines come in two variants, big-core and
> small-core. Big-core machines are SMT8 from software's point of view,
> but the low level platform topology ("xscom registers and pervasive
> addressing"), these look more like a pair of small cores ganged
> together.
> 
> Presently the way this is modelled is to create one SMT8 PnvCore and add
> special cases to xscom and pervasive for big-core mode that tries to
> split this into two small cores, but this is becoming too complicated to
> manage.
> 
> A better approach is to create 2 core structures and ganging them
> together to look like an SMT8 core in TCG. Then the xscom and pervasive
> models mostly do not need to differentiate big and small core modes.
> 
> This change adds initial mode bits and QEMU topology handling to
> split SMT8 cores into 2xSMT4 cores.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv.h      |  2 +
>   include/hw/ppc/pnv_core.h |  1 +
>   hw/ppc/pnv.c              | 79 ++++++++++++++++++++++++++++++++-------
>   hw/ppc/pnv_core.c         |  7 +++-
>   4 files changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 1993dededf..283ddd50e7 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -101,6 +101,8 @@ struct PnvMachineState {
>       PnvPnor      *pnor;
>   
>       hwaddr       fw_load_addr;
> +
> +    bool         big_core;
>   };
>   
>   PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 693acb189b..50164e9e1f 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -49,6 +49,7 @@ struct PnvCore {
>   
>       /*< public >*/
>       PowerPCCPU **threads;
> +    bool big_core;
>       uint32_t pir;
>       uint32_t hwid;
>       uint64_t hrmor;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index b593a41f7c..d2ddc49142 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1002,14 +1002,39 @@ static void pnv_init(MachineState *machine)
>       pnv->num_chips =
>           machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
>   
> +    if (pnv->big_core) {
> +        if (machine->smp.threads % 2 == 1) {
> +            error_report("Cannot support %d threads with big-core option "
> +                         "because it must be an even number",
> +                         machine->smp.threads);
> +            exit(1);
> +        }
> +        max_smt_threads *= 2;
> +    }
> +
>       if (machine->smp.threads > max_smt_threads) {
>           error_report("Cannot support more than %d threads/core "
>                        "on %s machine", max_smt_threads, mc->desc);
> +        if (pmc->max_smt_threads == 4) {
> +            error_report("(use big-core=on for 8 threads per core)");
> +        }
>           exit(1);
>       }
>   
> +    if (pnv->big_core) {
> +        /*
> +         * powernv models PnvCore as a SMT4 core. Big-core requires 2xPnvCore
> +         * per core, so adjust topology here. pnv_dt_core() processor
> +         * device-tree and TCG SMT code make the 2 cores appear as one big core
> +         * from software point of view. pnv pervasive models and xscoms tend to
> +         * see the big core as 2 small core halves.
> +         */
> +        machine->smp.cores *= 2;
> +        machine->smp.threads /= 2;
> +    }
> +
>       if (!is_power_of_2(machine->smp.threads)) {
> -        error_report("Cannot support %d threads/core on a powernv"
> +        error_report("Cannot support %d threads/core on a powernv "
>                        "machine because it must be a power of 2",
>                        machine->smp.threads);
>           exit(1);
> @@ -1175,11 +1200,19 @@ static void pnv_get_pir_tir_p9(PnvChip *chip,
>                                   uint32_t core_id, uint32_t thread_id,
>                                   uint32_t *pir, uint32_t *tir)
>   {
> -    if (pir) {
> -        if (chip->nr_threads == 8) {
> -            *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) |
> -                   (core_id << 3) | (thread_id >> 1);
> -        } else {
> +    PnvMachineState *pnv = PNV_MACHINE(chip->pnv_machine);

The chip also needs a "big-core" property IMO.

Thanks,

C.



> +    if (pnv->big_core) {
> +        /* Big-core interleaves thread ID between small-cores */
> +        thread_id <<= 1;
> +        thread_id |= core_id & 1;
> +        core_id >>= 1;
> +
> +        if (pir) {
> +            *pir = (chip->chip_id << 8) | (core_id << 3) | thread_id;
> +        }
> +    } else {
> +        if (pir) {
>               *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
>           }
>       }
> @@ -1203,11 +1236,19 @@ static void pnv_get_pir_tir_p10(PnvChip *chip,
>                                   uint32_t core_id, uint32_t thread_id,
>                                   uint32_t *pir, uint32_t *tir)
>   {
> -    if (pir) {
> -        if (chip->nr_threads == 8) {
> -            *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
> -                    ((core_id % 2) << 3) | thread_id;
> -        } else {
> +    PnvMachineState *pnv = PNV_MACHINE(chip->pnv_machine);
> +
> +    if (pnv->big_core) {
> +        /* Big-core interleaves thread ID between small-cores */
> +        thread_id <<= 1;
> +        thread_id |= core_id & 1;
> +        core_id >>= 1;
> +
> +        if (pir) {
> +            *pir = (chip->chip_id << 8) | (core_id << 3) | thread_id;
> +        }
> +    } else {
> +        if (pir) {
>               *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
>           }
>       }
> @@ -2180,7 +2221,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>                                       &k->parent_realize);
>   }
>   
> -static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
> +static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
> +                                   Error **errp)
>   {
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
>       int cores_max;
> @@ -2201,6 +2243,17 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
>       }
>       chip->cores_mask &= pcc->cores_mask;
>   
> +    /* Ensure small-cores a paired up in big-core mode */
> +    if (pnv->big_core) {
> +        uint64_t even_cores = chip->cores_mask & 0x5555555555555555ULL;
> +        uint64_t odd_cores = chip->cores_mask & 0xaaaaaaaaaaaaaaaaULL;
> +
> +        if (even_cores ^ (odd_cores >> 1)) {
> +            error_setg(errp, "warning: unpaired cores in big-core mode !");
> +            return;
> +        }
> +    }
> +
>       /* now that we have a sane layout, let check the number of cores */
>       cores_max = ctpop64(chip->cores_mask);
>       if (chip->nr_cores > cores_max) {
> @@ -2224,7 +2277,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>       }
>   
>       /* Cores */
> -    pnv_chip_core_sanitize(chip, &error);
> +    pnv_chip_core_sanitize(pnv, chip, &error);
>       if (error) {
>           error_propagate(errp, error);
>           return;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 8cfa94fbfa..16d40392db 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -249,7 +249,12 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>       pir_spr->default_value = pir;
>       tir_spr->default_value = tir;
>   
> -    env->core_index = core_hwid;
> +    if (pc->big_core) {
> +        /* 2 "small cores" get the same core index for SMT operations */
> +        env->core_index = core_hwid >> 1;
> +    } else {
> +        env->core_index = core_hwid;
> +    }
>   
>       /* Set time-base frequency to 512 MHz */
>       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);


