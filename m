Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E98C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcC7-0004nx-G1; Mon, 27 May 2024 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBcC5-0004nD-9k; Mon, 27 May 2024 11:23:25 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBcC3-0001DF-0v; Mon, 27 May 2024 11:23:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VnztX2hSjz4x11;
 Tue, 28 May 2024 01:23:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VnztN5dbRz4wcq;
 Tue, 28 May 2024 01:23:08 +1000 (AEST)
Message-ID: <e3a34415-cc08-4927-a4d6-60c8e4566db2@kaod.org>
Date: Mon, 27 May 2024 17:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] ppc/pnv: Add pointer from PnvCPUState to PnvCore
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-2-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240526122612.473476-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=e5bn=M6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/26/24 14:26, Nicholas Piggin wrote:
> This helps move core state from CPU to core structures.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_core.h | 1 +
>   hw/ppc/pnv_core.c         | 3 +++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index c6d62fd145..30c1e5b1a3 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -54,6 +54,7 @@ struct PnvCoreClass {
>   #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
>   
>   typedef struct PnvCPUState {
> +    PnvCore *core;
>       Object *intc;
>   } PnvCPUState;
>   
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index f40ab721d6..7b0ea7812b 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -225,6 +225,7 @@ static const MemoryRegionOps pnv_core_power10_xscom_ops = {
>   static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>                                    int thread_index)
>   {
> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
>       CPUPPCState *env = &cpu->env;
>       int core_hwid;
>       ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
> @@ -232,6 +233,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>       Error *local_err = NULL;
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
>   
> +    pnv_cpu->core = pc;

I would do the assignment in pnv_core_realize() after cpu->machine_data is
allocated. it's minor.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


>       if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>           return;
>       }


