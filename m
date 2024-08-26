Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD17C5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 10:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWe0-0006Rj-NI; Mon, 26 Aug 2024 06:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siWdz-0006Qc-9S
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 06:08:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siWdx-00029j-Fb
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 06:08:15 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WsmZl2zdlz4x42
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:07:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WsmZk5Nynz4x2M
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:07:58 +1000 (AEST)
Message-ID: <cabfffe6-76a5-4c9a-a2a5-577e163ca961@kaod.org>
Date: Mon, 26 Aug 2024 12:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] ppc/pnv: Fix LPC serirq routing calculation
To: qemu-devel@nongnu.org
References: <20240806131318.275109-1-npiggin@gmail.com>
 <20240806131318.275109-2-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240806131318.275109-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 8/6/24 15:13, Nicholas Piggin wrote:
> The serirq routing table is split over two registers, the calculation
> for the high irqs in the second register did not subtract the irq
> offset. This was spotted by Coverity as a shift-by-negative. Fix this
> and change the open-coded shifting and masking to use extract32()
> function so it's less error-prone.
> 
> This went unnoticed because irqs >= 14 are not used in a standard
> QEMU/OPAL boot, changing the first QEMU serial-isa irq to 14 to test
> does demonstrate serial irqs aren't received, and that this change
> fixes that.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Resolves: Coverity CID 1558829 (partially)
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/ppc/cpu.h |  1 +
>   hw/ppc/pnv_lpc.c | 10 ++++++++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 321ed2da75..bd32a1a5f8 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -40,6 +40,7 @@
>   
>   #define PPC_BIT_NR(bit)         (63 - (bit))
>   #define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BIT32_NR(bit)       (31 - (bit))
>   #define PPC_BIT32(bit)          (0x80000000 >> (bit))
>   #define PPC_BIT8(bit)           (0x80 >> (bit))
>   #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index f8aad955b5..80b79dfbbc 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -435,13 +435,19 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
>           return;
>       }
>   
> +    /*
> +     * Each of the ISA irqs is routed to one of the 4 SERIRQ irqs with 2
> +     * bits, split across 2 OPB registers.
> +     */
>       for (irq = 0; irq <= 13; irq++) {
> -        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
> +        int serirq = extract32(lpc->opb_irq_route1,
> +                                    PPC_BIT32_NR(5 + irq * 2), 2);
>           lpc->irq_to_serirq_route[irq] = serirq;
>       }
>   
>       for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
> -        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
> +        int serirq = extract32(lpc->opb_irq_route0,
> +                               PPC_BIT32_NR(9 + (irq - 14) * 2), 2);
>           lpc->irq_to_serirq_route[irq] = serirq;
>       }
>   }


