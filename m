Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B5CC3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 07:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSXAm-0001DR-QH; Sat, 13 Jul 2024 03:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Qwf7=ON=kaod.org=clg@ozlabs.org>)
 id 1sSXAk-00017U-Rd; Sat, 13 Jul 2024 03:27:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Qwf7=ON=kaod.org=clg@ozlabs.org>)
 id 1sSXAj-00089a-3c; Sat, 13 Jul 2024 03:27:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WLg6K5plLz4w2K;
 Sat, 13 Jul 2024 17:27:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WLg6H5pJWz4w2J;
 Sat, 13 Jul 2024 17:27:51 +1000 (AEST)
Message-ID: <fc47a6ef-0407-4333-8610-b74f1fdfc8d8@kaod.org>
Date: Sat, 13 Jul 2024 09:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/19] ppc/pnv: Add a CPU nmi and resume function
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240712120247.477133-1-npiggin@gmail.com>
 <20240712120247.477133-18-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240712120247.477133-18-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Power CPUs have an execution control facility that can pause, resume,
> and cause NMIs, among other things. Add a function that will nmi a CPU
> and resume it if it was paused, in preparation for implementing the
> control facility.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/ppc/pnv.h |  2 ++
>   hw/ppc/pnv.c         | 14 +++++++++++++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
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
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index e405d416ff..cd96cde6c9 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2749,11 +2749,23 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>            */
>           env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
>       }
> +    if (arg.host_int == 1) {
> +        cpu_resume(cs);
> +    }
> +}
> +
> +/*
> + * Send a SRESET (NMI) interrupt to the CPU, and resume execution if it was
> + * paused.
> + */
> +void pnv_cpu_do_nmi_resume(CPUState *cs)
> +{
> +    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(1));
>   }
>   
>   static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
>   {
> -    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> +    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
>   }
>   
>   static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)


