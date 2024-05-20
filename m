Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BCBC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 11:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s91Bn-0005ND-IF; Mon, 20 May 2024 07:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s91Bl-0005Kn-67; Mon, 20 May 2024 07:28:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s91Bj-0003LH-NT; Mon, 20 May 2024 07:28:20 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A7C814E6000;
 Mon, 20 May 2024 13:28:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id t_Y3qhrJjBio; Mon, 20 May 2024 13:28:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B31DE4E602E; Mon, 20 May 2024 13:28:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B11E7746E3B;
 Mon, 20 May 2024 13:28:15 +0200 (CEST)
Date: Mon, 20 May 2024 13:28:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: npiggin@gmail.com, qemu-ppc@nongnu.org, danielhb413@gmail.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/6] target/ppc: optimize hreg_compute_pmu_hflags_value
In-Reply-To: <20240520103329.381158-4-harshpb@linux.ibm.com>
Message-ID: <d77225d4-1139-e65a-ddcf-a07fbf9d0ff7@eik.bme.hu>
References: <20240520103329.381158-1-harshpb@linux.ibm.com>
 <20240520103329.381158-4-harshpb@linux.ibm.com>
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
> The second if-condition can be true only if the first one above is true.
> Enclose the latter into the former to avoid un-necessary check if first
> condition fails.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> target/ppc/helper_regs.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 5de0df5795..89aacdf212 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -66,9 +66,9 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
> #ifndef CONFIG_USER_ONLY
>     if (env->pmc_ins_cnt) {
>         hflags |= 1 << HFLAGS_INSN_CNT;
> -    }
> -    if (env->pmc_ins_cnt & 0x1e) {
> -        hflags |= 1 << HFLAGS_PMC_OTHER;
> +        if (env->pmc_ins_cnt & 0x1e) {
> +            hflags |= 1 << HFLAGS_PMC_OTHER;
> +        }
>     }
> #endif
> #endif
>

