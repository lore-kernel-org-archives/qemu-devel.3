Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3EBC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 11:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s91A1-0004Qg-HK; Mon, 20 May 2024 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s919y-0004Q9-UB; Mon, 20 May 2024 07:26:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s919w-0003DN-Lq; Mon, 20 May 2024 07:26:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9AC0A4E601B;
 Mon, 20 May 2024 13:26:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id oc-JkqLVzuSg; Mon, 20 May 2024 13:26:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A5F4A4E6000; Mon, 20 May 2024 13:26:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A4092746E3B;
 Mon, 20 May 2024 13:26:16 +0200 (CEST)
Date: Mon, 20 May 2024 13:26:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: npiggin@gmail.com, qemu-ppc@nongnu.org, danielhb413@gmail.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] target/ppc: optimize hreg_compute_pmu_hflags_value
In-Reply-To: <20240520103329.381158-3-harshpb@linux.ibm.com>
Message-ID: <cda77a72-e30c-88ec-c09a-6104fd9f1312@eik.bme.hu>
References: <20240520103329.381158-1-harshpb@linux.ibm.com>
 <20240520103329.381158-3-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 20 May 2024, Harsh Prateek Bora wrote:
> Cache env->spr[SPR_POWER_MMCR0] in a local variable as used in multiple
> conditions to avoid multiple indirect accesses.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
> target/ppc/helper_regs.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 945fa1a596..5de0df5795 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -50,15 +50,16 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
> static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
> {
>     uint32_t hflags = 0;
> -
> #if defined(TARGET_PPC64)
> -    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC0) {
> +    target_ulong spr_power_mmcr0 = env->spr[SPR_POWER_MMCR0];

I think this is simple enough so the compiler should be able to find out 
on its own but adding a local is also simple and may make it more readable 
but I'd call it just mmcr0 for readability.

Regards,
BALATON Zoltan

> +
> +    if (spr_power_mmcr0 & MMCR0_PMCC0) {
>         hflags |= 1 << HFLAGS_PMCC0;
>     }
> -    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC1) {
> +    if (spr_power_mmcr0 & MMCR0_PMCC1) {
>         hflags |= 1 << HFLAGS_PMCC1;
>     }
> -    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
> +    if (spr_power_mmcr0 & MMCR0_PMCjCE) {
>         hflags |= 1 << HFLAGS_PMCJCE;
>     }
>
>

