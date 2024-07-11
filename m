Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A8FC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwba-0003fO-0j; Thu, 11 Jul 2024 12:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwbR-0003Zy-9I; Thu, 11 Jul 2024 12:25:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwbP-0005Vz-8z; Thu, 11 Jul 2024 12:25:05 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKg6z1DYQz4x0t;
 Fri, 12 Jul 2024 02:24:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKg6x166hz4x04;
 Fri, 12 Jul 2024 02:24:56 +1000 (AEST)
Message-ID: <639bb117-38db-4717-863d-214e5a630673@kaod.org>
Date: Thu, 11 Jul 2024 18:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] ppc: Add a core_index to CPUPPCState for SMT vCPUs
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
 <20240711141851.406677-9-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> The way SMT thread siblings are matched is clunky, using hard-coded
> logic that checks the PIR SPR.
> 
> Change that to use a new core_index variable in the CPUPPCState,
> where all siblings have the same core_index. CPU realize routines have
> flexibility in setting core/sibling topology.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu.h        | 5 ++++-
>   hw/ppc/pnv_core.c       | 2 ++
>   hw/ppc/spapr_cpu_core.c | 3 +++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 95ba9e7590..c3a33d2965 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1247,6 +1247,9 @@ struct CPUArchState {
>       /* when a memory exception occurs, the access type is stored here */
>       int access_type;
>   
> +    /* For SMT processors */
> +    int core_index;
> +
>   #if !defined(CONFIG_USER_ONLY)
>       /* MMU context, only relevant for full system emulation */
>   #if defined(TARGET_PPC64)
> @@ -1403,7 +1406,7 @@ struct CPUArchState {
>   };
>   
>   #define _CORE_ID(cs)                                            \

That's a very short name for a macro in an header file. May be add a prefix.

Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> -    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
> +    (POWERPC_CPU(cs)->env.core_index)
>   
>   #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
>       CPU_FOREACH(cs_sibling)                                     \
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 28ca61926d..7bda29b9c7 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -249,6 +249,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>       pir_spr->default_value = pir;
>       tir_spr->default_value = tir;
>   
> +    env->core_index = core_hwid;
> +
>       /* Set time-base frequency to 512 MHz */
>       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
>   }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 21920ea054..d9116c8409 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -302,16 +302,19 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
>       g_autofree char *id = NULL;
>       CPUState *cs;
>       PowerPCCPU *cpu;
> +    CPUPPCState *env;
>   
>       obj = object_new(scc->cpu_type);
>   
>       cs = CPU(obj);
>       cpu = POWERPC_CPU(obj);
> +    env = &cpu->env;
>       /*
>        * All CPUs start halted. CPU0 is unhalted from the machine level reset code
>        * and the rest are explicitly started up by the guest using an RTAS call.
>        */
>       qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
> +    env->core_index = cc->core_id;
>       cs->cpu_index = cc->core_id + i;
>       if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
>           return NULL;


