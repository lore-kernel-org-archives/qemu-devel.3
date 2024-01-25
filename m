Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DF5C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSxEC-0003hH-FD; Thu, 25 Jan 2024 05:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSxE9-0003cH-C3; Thu, 25 Jan 2024 05:44:59 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSxE7-0007Ii-Fr; Thu, 25 Jan 2024 05:44:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLHX26WDwz4x7q;
 Thu, 25 Jan 2024 21:44:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLHX05kPgz4wbR;
 Thu, 25 Jan 2024 21:44:48 +1100 (AEDT)
Message-ID: <32abb1e0-ef9b-4b6a-b848-7f01ac010cb6@kaod.org>
Date: Thu, 25 Jan 2024 11:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/ppc: 440 optimise tlbwe TLB flushing
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20240117151238.93323-1-npiggin@gmail.com>
 <20240117151238.93323-5-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117151238.93323-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Usek=JD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 1/17/24 16:12, Nicholas Piggin wrote:
> Have 440 tlbwe flush only the range corresponding to the addresses
> covered by the software TLB entry being modified rather than the
> entire TLB. This matches what 4xx does.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/mmu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 923779d052..ba965f1779 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -864,7 +864,7 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
>   
>       /* Invalidate previous TLB (if it's valid) */
>       if (tlb->prot & PAGE_VALID) {
> -        tlb_flush(env_cpu(env));
> +        ppcemb_tlb_flush(env_cpu(env), tlb);
>       }
>   
>       switch (word) {


