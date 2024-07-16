Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244B7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlP8-0005e0-T3; Tue, 16 Jul 2024 12:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlP6-0005Ui-HX; Tue, 16 Jul 2024 12:51:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlP4-0003Pg-EO; Tue, 16 Jul 2024 12:51:52 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNlTc0bgmz4wc4;
 Wed, 17 Jul 2024 02:51:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNlTY73L7z4wbh;
 Wed, 17 Jul 2024 02:51:45 +1000 (AEST)
Message-ID: <3926e0aa-26f0-4c81-857b-2b3cf47652bd@kaod.org>
Date: Tue, 16 Jul 2024 18:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/19] ppc/pnv: Add big-core machine property
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240716162617.32161-1-npiggin@gmail.com>
 <20240716162617.32161-16-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716162617.32161-16-npiggin@gmail.com>
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
> Big-core implementation is complete, so expose it as a machine
> property that may be set with big-core=on option on powernv9 and
> powernv10 machines.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/pnv.c | 61 ++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 322ab9073b..08aaac359b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2581,6 +2581,34 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
>       return total_count;
>   }
>   
> +static bool pnv_machine_get_big_core(Object *obj, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    return pnv->big_core;
> +}
> +
> +static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +    pnv->big_core = value;
> +}
> +
> +static bool pnv_machine_get_hb(Object *obj, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +
> +    return !!pnv->fw_load_addr;
> +}
> +
> +static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
> +{
> +    PnvMachineState *pnv = PNV_MACHINE(obj);
> +
> +    if (value) {
> +        pnv->fw_load_addr = 0x8000000;
> +    }
> +}
> +
>   static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -2632,6 +2660,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
> +
> +    object_class_property_add_bool(oc, "big-core",
> +                                   pnv_machine_get_big_core,
> +                                   pnv_machine_set_big_core);
> +    object_class_property_set_description(oc, "big-core",
> +                              "Use big-core (aka fused-core) mode");
>   }
>   
>   static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
> @@ -2668,6 +2702,17 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>   
>       pnv_machine_p10_common_class_init(oc, data);
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
> +
> +    /*
> +     * This is the parent of POWER10 Rainier class, so properies go here
> +     * rather than common init (which would add them to both parent and
> +     * child which is invalid).
> +     */
> +    object_class_property_add_bool(oc, "big-core",
> +                                   pnv_machine_get_big_core,
> +                                   pnv_machine_set_big_core);
> +    object_class_property_set_description(oc, "big-core",
> +                              "Use big-core (aka fused-core) mode");
>   }
>   
>   static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
> @@ -2680,22 +2725,6 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
>       pmc->i2c_init = pnv_rainier_i2c_init;
>   }
>   
> -static bool pnv_machine_get_hb(Object *obj, Error **errp)
> -{
> -    PnvMachineState *pnv = PNV_MACHINE(obj);
> -
> -    return !!pnv->fw_load_addr;
> -}
> -
> -static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
> -{
> -    PnvMachineState *pnv = PNV_MACHINE(obj);
> -
> -    if (value) {
> -        pnv->fw_load_addr = 0x8000000;
> -    }
> -}
> -
>   static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>   {
>       CPUPPCState *env = cpu_env(cs);


