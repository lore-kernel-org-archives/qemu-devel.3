Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1245C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwka-0000Ym-EH; Thu, 11 Jul 2024 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwkY-0000Xj-Bt; Thu, 11 Jul 2024 12:34:30 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwkV-0001AG-UF; Thu, 11 Jul 2024 12:34:30 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKgKp6tCQz4wnx;
 Fri, 12 Jul 2024 02:34:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKgKm6kvBz4wcl;
 Fri, 12 Jul 2024 02:34:20 +1000 (AEST)
Message-ID: <e13f36ed-bac5-40cf-b0cc-65934c664d26@kaod.org>
Date: Thu, 11 Jul 2024 18:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] ppc: Add has_smt_siblings property to CPUPPCState
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
 <20240711141851.406677-11-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> The decision to branch out to a slower SMT path in instruction
> emulation will become a bit more complicated with the way that
> "big-core" topology that will be implemented in subsequent changes.
> Hide these details from the wider CPU emulation code with a bool
> has_smt_siblings flag that can be set by machine initialisation.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


The distinction between what's done in pnv_core_realize() and
pnv_core_cpu_realize() is not clear. Not this patch fault though.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/ppc/cpu.h        |  3 ++-
>   hw/ppc/pnv_core.c       |  3 +++
>   hw/ppc/spapr_cpu_core.c | 15 +++++++++++----
>   3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a74b753c99..35a1cb65cb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1248,6 +1248,7 @@ struct CPUArchState {
>       int access_type;
>   
>       /* For SMT processors */
> +    bool has_smt_siblings;
>       int core_index;
>   
>   #if !defined(CONFIG_USER_ONLY)
> @@ -1516,7 +1517,7 @@ struct PowerPCCPUClass {
>   
>   static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
>   {
> -    return cs->nr_threads == 1;
> +    return !POWERPC_CPU(cs)->env.has_smt_siblings;
>   }
>   
>   static inline bool ppc_cpu_lpar_single_threaded(CPUState *cs)
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 7bda29b9c7..8cfa94fbfa 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -288,6 +288,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>           cpu = POWERPC_CPU(obj);
>   
>           pc->threads[i] = POWERPC_CPU(obj);
> +        if (cc->nr_threads > 1) {
> +            cpu->env.has_smt_siblings = true;
> +        }
>   
>           snprintf(name, sizeof(name), "thread[%d]", i);
>           object_property_add_child(OBJECT(pc), name, obj);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index d9116c8409..2c6eeb41a4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -314,12 +314,13 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
>        * and the rest are explicitly started up by the guest using an RTAS call.
>        */
>       qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
> -    env->core_index = cc->core_id;
>       cs->cpu_index = cc->core_id + i;
>       if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
>           return NULL;
>       }
>   
> +    env->core_index = cc->core_id;
> +
>       cpu->node_id = sc->node_id;
>   
>       id = g_strdup_printf("thread[%d]", i);
> @@ -350,9 +351,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>       qemu_register_reset(spapr_cpu_core_reset_handler, sc);
>       sc->threads = g_new0(PowerPCCPU *, cc->nr_threads);
>       for (i = 0; i < cc->nr_threads; i++) {
> -        sc->threads[i] = spapr_create_vcpu(sc, i, errp);
> -        if (!sc->threads[i] ||
> -            !spapr_realize_vcpu(sc->threads[i], spapr, sc, i, errp)) {
> +        PowerPCCPU *cpu;
> +
> +        cpu = spapr_create_vcpu(sc, i, errp);
> +        sc->threads[i] = cpu;
> +        if (cpu && cc->nr_threads > 1) {
> +            cpu->env.has_smt_siblings = true;
> +        }
> +
> +        if (!cpu || !spapr_realize_vcpu(cpu, spapr, sc, i, errp)) {
>               spapr_cpu_core_unrealize(dev);
>               return;
>           }


