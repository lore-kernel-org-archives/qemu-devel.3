Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43CEDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4hh-0006Bp-1v; Tue, 10 Sep 2024 13:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=54h1=QI=kaod.org=clg@ozlabs.org>)
 id 1so4hW-0005Wc-C8; Tue, 10 Sep 2024 13:30:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=54h1=QI=kaod.org=clg@ozlabs.org>)
 id 1so4hT-0003yo-L7; Tue, 10 Sep 2024 13:30:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X39hf31Lyz4wb5;
 Wed, 11 Sep 2024 03:30:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X39hc0qykz4x8Y;
 Wed, 11 Sep 2024 03:30:39 +1000 (AEST)
Message-ID: <9f980ce0-04f3-4372-83d9-b10ed8688eca@kaod.org>
Date: Tue, 10 Sep 2024 19:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] pnv/xive: Update PIPR when updating CPPR
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240909211038.27440-1-kowal@linux.ibm.com>
 <20240909211038.27440-13-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240909211038.27440-13-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=54h1=QI=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 9/9/24 23:10, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
> 
> Current code was updating the PIPR inside the xive_tctx_accept() function
> instead of the xive_tctx_set_cppr function, which is where the HW would
> have it updated.
> 
> Moved the update to the xive_tctx_set_cppr function which required
> additional support for pool interrupts.
> 
> Fixes: cdd4de68edb6 ("ppc/xive: notify the CPU when the interrupt priority is more privileged")
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/xive.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 5c5c3a2dd6..738eaf624d 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -89,7 +89,6 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>   
>           /* Reset the pending buffer bit */
>           alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
> -        regs[TM_PIPR] = ipb_to_pipr(alt_regs[TM_IPB]);
>   
>           /* Drop Exception bit */
>           regs[TM_NSR] &= ~mask;
> @@ -143,6 +142,8 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
>   static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   {
>       uint8_t *regs = &tctx->regs[ring];
> +    uint8_t pipr_min;
> +    uint8_t ring_min;
>   
>       trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
>                                regs[TM_IPB], regs[TM_PIPR],
> @@ -154,8 +155,37 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
>   
>       tctx->regs[ring + TM_CPPR] = cppr;
>   
> +    /*
> +     * Recompute the PIPR based on local pending interrupts.  The PHYS
> +     * ring must take the minimum of both the PHYS and POOL PIPR values.
> +     */
> +    pipr_min = ipb_to_pipr(regs[TM_IPB]);
> +    ring_min = ring;
> +
> +    /* PHYS updates also depend on POOL values */
> +    if (ring == TM_QW3_HV_PHYS) {
> +        uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
> +
> +        /* POOL values only matter if POOL ctx is valid */
> +        if (pool_regs[TM_WORD2] & 0x80) {
> +
> +            uint8_t pool_pipr = ipb_to_pipr(pool_regs[TM_IPB]);
> +
> +            /*
> +             * Determine highest priority interrupt and
> +             * remember which ring has it.
> +             */
> +            if (pool_pipr < pipr_min) {
> +                pipr_min = pool_pipr;
> +                ring_min = TM_QW2_HV_POOL;
> +            }
> +        }
> +    }
> +
> +    regs[TM_PIPR] = pipr_min;
> +
>       /* CPPR has changed, check if we need to raise a pending exception */
> -    xive_tctx_notify(tctx, ring);
> +    xive_tctx_notify(tctx, ring_min);
>   }
>   
>   void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)


