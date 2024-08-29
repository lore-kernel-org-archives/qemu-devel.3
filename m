Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6355EC83F0A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjeHH-0002ez-31; Thu, 29 Aug 2024 08:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=t/gt=P4=kaod.org=clg@ozlabs.org>)
 id 1sjeHE-0002ap-Jk; Thu, 29 Aug 2024 08:29:24 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=t/gt=P4=kaod.org=clg@ozlabs.org>)
 id 1sjeHC-0000tH-5i; Thu, 29 Aug 2024 08:29:24 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WvgZM4MMkz4wxH;
 Thu, 29 Aug 2024 22:29:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WvgZK1xDHz4wb5;
 Thu, 29 Aug 2024 22:29:12 +1000 (AEST)
Message-ID: <5dad962a-0815-40b8-b62a-d0c67612fa5f@kaod.org>
Date: Thu, 29 Aug 2024 14:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] pnv/xive: Update PIPR when updating CPPR
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-12-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-12-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=t/gt=P4=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/1/24 22:30, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
> 
> Current code was updating the PIPR inside the xive_tctx_accept() function
> instead of the xive_tctx_set_cppr function, which is where the HW would
> have it updated.

Did you confirm with the HW designer ?

AFAIR, the PIPR is constructed from the IPB and the later is it updated
the better. However, if now, both PIPR (HW and Pool) are required to
identify the ctx to notify, I agree set_cppr() needs a change but what
about xive_tctx_ipb_update() which is called when an interrupt
needs a resend ?


Thanks,

C.



> Moved the update to the xive_tctx_set_cppr function which required
> additional support for pool interrupts.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   hw/intc/xive.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 5c4ca7f6e0..d951aac3a0 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -89,7 +89,6 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>   
>           /* Reset the pending buffer bit */
>           aregs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
> -        regs[TM_PIPR] = ipb_to_pipr(aregs[TM_IPB]);
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
> +        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
> +
> +        /* POOL values only matter if POOL ctx is valid */
> +        if (pregs[TM_WORD2] & 0x80) {
> +
> +            uint8_t pool_pipr = ipb_to_pipr(pregs[TM_IPB]);
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


