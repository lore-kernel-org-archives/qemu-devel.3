Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0E1EEE26C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 12:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp5UY-0006KN-Ly; Fri, 13 Sep 2024 08:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sp5UW-0006JL-Mn; Fri, 13 Sep 2024 08:33:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sp5UU-0004pz-Ez; Fri, 13 Sep 2024 08:33:36 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 715C84E602B;
 Fri, 13 Sep 2024 14:33:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id bfmMls0nhNZy; Fri, 13 Sep 2024 14:33:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7D8D84E6004; Fri, 13 Sep 2024 14:33:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7B9C6746F60;
 Fri, 13 Sep 2024 14:33:26 +0200 (CEST)
Date: Fri, 13 Sep 2024 14:33:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com, 
 danielhb413@gmail.com
Subject: Re: [PATCH v3 01/10] target/ppc: use locally stored msr and avoid
 indirect access
In-Reply-To: <20240913041337.912876-2-harshpb@linux.ibm.com>
Message-ID: <593fa102-32bf-162e-7908-318346d7defe@eik.bme.hu>
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-2-harshpb@linux.ibm.com>
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

On Fri, 13 Sep 2024, Harsh Prateek Bora wrote:
> hreg_compute_hflags_value already stores msr locally to be used in most
> of the logic in the routine however some instances are still using
> env->msr which is unnecessary. Use locally stored value as available.
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
> target/ppc/helper_regs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 02076e96fb..fe543ab3b8 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -143,10 +143,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
>
>     if (ppc_flags & POWERPC_FLAG_DE) {
>         target_ulong dbcr0 = env->spr[SPR_BOOKE_DBCR0];
> -        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(env->msr, MSR, DE)) {
> +        if ((dbcr0 & DBCR0_ICMP) && FIELD_EX64(msr, MSR, DE)) {
>             hflags |= 1 << HFLAGS_SE;
>         }
> -        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(env->msr, MSR, DE)) {
> +        if ((dbcr0 & DBCR0_BRT) && FIELD_EX64(msr, MSR, DE)) {
>             hflags |= 1 << HFLAGS_BE;
>         }
>     } else {
>

