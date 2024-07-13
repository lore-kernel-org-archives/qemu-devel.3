Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994FFC3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 07:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSX5P-0006yb-AQ; Sat, 13 Jul 2024 03:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Qwf7=ON=kaod.org=clg@ozlabs.org>)
 id 1sSX5O-0006xd-JX; Sat, 13 Jul 2024 03:22:26 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Qwf7=ON=kaod.org=clg@ozlabs.org>)
 id 1sSX5M-0005xF-DV; Sat, 13 Jul 2024 03:22:26 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WLfzv02g8z4wxk;
 Sat, 13 Jul 2024 17:22:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WLfzs0108z4wbx;
 Sat, 13 Jul 2024 17:22:16 +1000 (AEST)
Message-ID: <6851adaa-b7ec-457b-84ec-c24539c19d75@kaod.org>
Date: Sat, 13 Jul 2024 09:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] ppc/pnv: Add POWER10 ChipTOD quirk for big-core
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240712120247.477133-1-npiggin@gmail.com>
 <20240712120247.477133-15-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240712120247.477133-15-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Qwf7=ON=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/12/24 14:02, Nicholas Piggin wrote:
> POWER10 has a quirk in its ChipTOD addressing that requires the even
> small-core to be selected even when programming the odd small-core.
> This allows skiboot chiptod init to run in big-core mode.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good, some more proposals below,

> ---
>   include/hw/ppc/pnv.h         | 1 +
>   include/hw/ppc/pnv_core.h    | 7 +++++++
>   hw/ppc/pnv.c                 | 7 ++++++-
>   target/ppc/timebase_helper.c | 9 +++++++++
>   4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 283ddd50e7..c56d152889 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -77,6 +77,7 @@ struct PnvMachineClass {
>       const char *compat;
>       int compat_size;
>       int max_smt_threads;
> +    bool quirk_tb_big_core;
>   
>       void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
>       void (*i2c_init)(PnvMachineState *pnv);
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 50164e9e1f..c8784777a4 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -27,6 +27,13 @@
>   
>   /* Per-core ChipTOD / TimeBase state */
>   typedef struct PnvCoreTODState {
> +    /*
> +     * POWER10 DD2.0 - big core TFMR drives the state machine on the even
> +     * small core. Skiboot has a workaround that targets the even small core
> +     * for CHIPTOD_TO_TB ops.
> +     */
> +    bool big_core_quirk;
> +
>       int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
>       int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
>   
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index fdf66323b8..24f7c007ce 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2288,11 +2288,12 @@ static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
>   
>   static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>   {
> +    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> +    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(pnv);
>       Error *error = NULL;
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
>       const char *typename = pnv_chip_core_typename(chip);
>       int i, core_hwid;
> -    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   
>       if (!object_class_by_name(typename)) {
>           error_setg(errp, "Unable to find PowerNV CPU Core '%s'", typename);
> @@ -2335,6 +2336,9 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>                                   &error_fatal);
>           object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
>                                    &error_abort);
> +
> +        pnv_core->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
> +

instead :

@@ -2363,6 +2364,9 @@ static void pnv_chip_core_realize(PnvChi
                                   &error_abort);
          object_property_set_bool(OBJECT(pnv_core), "big-core", chip->big_core,
                                   &error_abort);
+        object_property_set_bool(OBJECT(pnv_core), "big-core-quirk",
+                                 pmc->quirk_tb_big_core, &error_abort);
+
          qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
  
          /* Each core has an XSCOM MMIO region */

and in hw/ppc/pnv_core.c :


@@ -365,6 +365,7 @@ static Property pnv_core_properties[] =
      DEFINE_PROP_UINT64("hrmor", PnvCore, hrmor, 0),
      DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
      DEFINE_PROP_BOOL("big-core", PnvCore, big_core, false),
+    DEFINE_PROP_BOOL("big-core-quirk", PnvCore, tod_state.big_core_quirk, false),
      DEFINE_PROP_END_OF_LIST(),
  };
  

thanks,

C.


>           qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
>   
>           /* Each core has an XSCOM MMIO region */
> @@ -2647,6 +2651,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->max_smt_threads = 4;
> +    pmc->quirk_tb_big_core = true;
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
>       xfc->match_nvt = pnv10_xive_match_nvt;
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 44cacf065e..019b8ee41f 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -20,6 +20,7 @@
>   #include "cpu.h"
>   #include "hw/ppc/ppc.h"
>   #include "hw/ppc/pnv_core.h"
> +#include "hw/ppc/pnv_chip.h"
>   #include "exec/helper-proto.h"
>   #include "exec/exec-all.h"
>   #include "qemu/log.h"
> @@ -297,6 +298,14 @@ static PnvCoreTODState *cpu_get_tbst(PowerPCCPU *cpu)
>   {
>       PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
>   
> +    if (pc->big_core && pc->tod_state.big_core_quirk) {
> +        /* Must operate on the even small core */
> +        int core_id = CPU_CORE(pc)->core_id;
> +        if (core_id & 1) {
> +            pc = pc->chip->cores[core_id & ~1];
> +        }
> +    }
> +
>       return &pc->tod_state;
>   }
>   


