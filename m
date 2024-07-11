Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47639C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwMh-0004VJ-7u; Thu, 11 Jul 2024 12:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwMg-0004Tg-1Z; Thu, 11 Jul 2024 12:09:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SBUb=OL=kaod.org=clg@ozlabs.org>)
 id 1sRwMd-0000wo-Tc; Thu, 11 Jul 2024 12:09:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WKfnH5wGBz4wbr;
 Fri, 12 Jul 2024 02:09:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WKfnF3ZM6z4x04;
 Fri, 12 Jul 2024 02:09:37 +1000 (AEST)
Message-ID: <e215ddf3-d96d-44fc-b1a7-b61d4678a557@kaod.org>
Date: Thu, 11 Jul 2024 18:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] ppc/pnv: Add a pointer from PnvChip to
 PnvMachineState
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240711141851.406677-1-npiggin@gmail.com>
 <20240711141851.406677-4-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240711141851.406677-4-npiggin@gmail.com>
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
> This helps avoid qdev_get_machine() calls.

I see two uses of this pointer in pnv_core_realize() :

     ...
     PnvMachineState *pnv = pc->chip->pnv_machine;
     ....
     pc->big_core = pnv->big_core;
     pc->lpar_per_core = pc->chip->pnv_machine->lpar_per_core;

Instead of this (ugly) machine pointer, why not add "lpar-per-core"
and "big-core" properties to PnvCore and simply set them in
pnv_chip_core_realize() ? I would prefer this solution.


Thanks,

C.



> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_chip.h | 2 ++ 
>   hw/ppc/pnv.c              | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 4eaa7d3999..decfbc0ff7 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -23,6 +23,8 @@ struct PnvChip {
>       SysBusDevice parent_obj;
>   
>       /*< public >*/
> +    PnvMachineState *pnv_machine;
> +
>       uint32_t     chip_id;
>       uint64_t     ram_start;
>       uint64_t     ram_size;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7878fed43c..3bcf11984c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2202,6 +2202,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>           return;
>       }
>   
> +    chip->pnv_machine = pnv;
>       chip->cores = g_new0(PnvCore *, chip->nr_cores);
>   
>       for (i = 0, core_hwid = 0; (core_hwid < sizeof(chip->cores_mask) * 8)
> @@ -2614,7 +2615,7 @@ static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
>   
>   static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
>   {
> -    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> +    PnvMachineState *pnv = PNV_MACHINE(n);
>       int i;
>   
>       for (i = 0; i < pnv->num_chips; i++) {


