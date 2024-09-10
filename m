Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477F1EDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4jQ-0005Ld-IY; Tue, 10 Sep 2024 13:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=54h1=QI=kaod.org=clg@ozlabs.org>)
 id 1so4jP-0005Fy-FH; Tue, 10 Sep 2024 13:32:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=54h1=QI=kaod.org=clg@ozlabs.org>)
 id 1so4jN-00044a-Ab; Tue, 10 Sep 2024 13:32:47 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X39ky709Xz4x4c;
 Wed, 11 Sep 2024 03:32:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X39kw4ps3z4wb5;
 Wed, 11 Sep 2024 03:32:40 +1000 (AEST)
Message-ID: <48351bd3-338e-4ebf-99a2-f2a1c39e5f51@kaod.org>
Date: Tue, 10 Sep 2024 19:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] pnv/xive: Add special handling for pool targets
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240909211038.27440-1-kowal@linux.ibm.com>
 <20240909211038.27440-12-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240909211038.27440-12-kowal@linux.ibm.com>
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
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> Hypervisor "pool" targets do not get their own interrupt line and instead
> must share an interrupt line with the hypervisor "physical" targets.
> This also means that the pool ring must use some of the registers from the
> physical ring in the TIMA.  Specifically, the NSR, PIPR and CPPR registers:
> 
>    NSR = Notification Source Register
>    PIPR = Post Interrupt Priority Register
>    CPPR = Current Processor Priority Register
> 
> The NSR specifies that there is an active interrupt.  The CPPR
> specifies the priority of the context and the PIPR specifies the
> priority of the interrupt.  For an interrupt to be presented to
> a context, the priority of the interrupt must be higher than the
> priority of the context it is interrupting (value must be lower).
> 
> The existing code was not aware of the sharing of these registers.
> This commit adds that support.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/xive.c | 36 ++++++++++++++++++++++++++----------
>   1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9d85da0999..5c5c3a2dd6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -74,33 +74,49 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>   
>       if (regs[TM_NSR] & mask) {
>           uint8_t cppr = regs[TM_PIPR];
> +        uint8_t alt_ring;
> +        uint8_t *alt_regs;
> +
> +        /* POOL interrupt uses IPB in QW2, POOL ring */
> +        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
> +            alt_ring = TM_QW2_HV_POOL;
> +        } else {
> +            alt_ring = ring;
> +        }
> +        alt_regs = &tctx->regs[alt_ring];
>   
>           regs[TM_CPPR] = cppr;
>   
>           /* Reset the pending buffer bit */
> -        regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
> -        regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
> +        alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
> +        regs[TM_PIPR] = ipb_to_pipr(alt_regs[TM_IPB]);
>   
>           /* Drop Exception bit */
>           regs[TM_NSR] &= ~mask;
>   
> -        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
> -                               regs[TM_IPB], regs[TM_PIPR],
> +        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
> +                               alt_regs[TM_IPB], regs[TM_PIPR],
>                                  regs[TM_CPPR], regs[TM_NSR]);
>       }
>   
> -    return (nsr << 8) | regs[TM_CPPR];
> +    return ((uint64_t)nsr << 8) | regs[TM_CPPR];
>   }
>   
>   static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
>   {
> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> +    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
> +    uint8_t *alt_regs = &tctx->regs[alt_ring];
>       uint8_t *regs = &tctx->regs[ring];
>   
> -    if (regs[TM_PIPR] < regs[TM_CPPR]) {
> +    if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
>           switch (ring) {
>           case TM_QW1_OS:
>               regs[TM_NSR] |= TM_QW1_NSR_EO;
>               break;
> +        case TM_QW2_HV_POOL:
> +            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6);
> +            break;
>           case TM_QW3_HV_PHYS:
>               regs[TM_NSR] |= (TM_QW3_NSR_HE_PHYS << 6);
>               break;
> @@ -108,8 +124,8 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
>               g_assert_not_reached();
>           }
>           trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
> -                               regs[TM_IPB], regs[TM_PIPR],
> -                               regs[TM_CPPR], regs[TM_NSR]);
> +                               regs[TM_IPB], alt_regs[TM_PIPR],
> +                               alt_regs[TM_CPPR], alt_regs[TM_NSR]);
>           qemu_irq_raise(xive_tctx_output(tctx, ring));
>       }
>   }
> @@ -217,14 +233,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
>   static const uint8_t xive_tm_hw_view[] = {
>       3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
>       3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
> -    0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
> +    0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
>       3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS */
>   };
>   
>   static const uint8_t xive_tm_hv_view[] = {
>       3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
>       3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
> -    0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
> +    0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
>       3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS */
>   };
>   


