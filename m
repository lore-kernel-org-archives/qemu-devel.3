Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104C1C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 09:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJjb-0001Dv-Hv; Tue, 18 Feb 2025 04:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org>)
 id 1tkJjM-0001C1-PG; Tue, 18 Feb 2025 04:17:30 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org>)
 id 1tkJjJ-0007E8-NI; Tue, 18 Feb 2025 04:17:28 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Yxv751gCwz4wcm;
 Tue, 18 Feb 2025 20:17:21 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Yxv723VVPz4wb0;
 Tue, 18 Feb 2025 20:17:18 +1100 (AEDT)
Message-ID: <5ec569c6-f7a7-4a0d-b60e-abb727cf1330@kaod.org>
Date: Tue, 18 Feb 2025 10:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/28] hw/intc/aspeed: Introduce IRQ handler function
 to reduce code duplication
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-12-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250213033531.3367697-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 2/13/25 04:35, Jamin Lin wrote:
> The behavior of the INTC set IRQ is almost identical between INTC and INTCIO.
> To reduce duplicated code, introduce the "aspeed_intc_set_irq_handler" function
> to handle both INTC and INTCIO IRQ behavior.


It's good practice to add "No functional change".

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/intc/aspeed_intc.c | 62 ++++++++++++++++++++++++-------------------
>   1 file changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 59c1069294..fd4f75805a 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -92,11 +92,40 @@ static void aspeed_intc_update(AspeedINTCState *s, int inpin_idx,
>       qemu_set_irq(s->output_pins[outpin_idx], level);
>   }
>   
> +static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
> +                                        const AspeedINTCIRQ *intc_irq,
> +                                        uint32_t select)
> +{
> +    const char *name = object_get_typename(OBJECT(s));
> +
> +    if (s->mask[intc_irq->inpin_idx] || s->regs[intc_irq->status_addr]) {
> +        /*
> +         * a. mask is not 0 means in ISR mode
> +         * sources interrupt routine are executing.
> +         * b. status register value is not 0 means previous
> +         * source interrupt does not be executed, yet.
> +         *
> +         * save source interrupt to pending variable.
> +         */
> +        s->pending[intc_irq->inpin_idx] |= select;
> +        trace_aspeed_intc_pending_irq(name, intc_irq->inpin_idx,
> +                                      s->pending[intc_irq->inpin_idx]);
> +    } else {
> +        /*
> +         * notify firmware which source interrupt are coming
> +         * by setting status register
> +         */
> +        s->regs[intc_irq->status_addr] = select;
> +        trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
> +                                      intc_irq->outpin_idx,
> +                                      s->regs[intc_irq->status_addr]);
> +        aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 1);
> +    }
> +}
> +
>   /*
> - * The address of GICINT128 to GICINT136 are from 0x1000 to 0x1804.
> - * Utilize "address & 0x0f00" to get the irq and irq output pin index
> - * The value of irq should be 0 to num_inpins.
> - * The irq 0 indicates GICINT128, irq 1 indicates GICINT129 and so on.
> + * GICINT128 to GICINT136 map 1:1 to input and output IRQs 0 to 8.
> + * The value of input IRQ should be between 0 and the number of inputs.
>    */
>   static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>   {
> @@ -135,30 +164,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>       }
>   
>       trace_aspeed_intc_select(name, select);
> -
> -    if (s->mask[intc_irq->inpin_idx] || s->regs[intc_irq->status_addr]) {
> -        /*
> -         * a. mask is not 0 means in ISR mode
> -         * sources interrupt routine are executing.
> -         * b. status register value is not 0 means previous
> -         * source interrupt does not be executed, yet.
> -         *
> -         * save source interrupt to pending variable.
> -         */
> -        s->pending[intc_irq->inpin_idx] |= select;
> -        trace_aspeed_intc_pending_irq(name, intc_irq->inpin_idx,
> -                                      s->pending[intc_irq->inpin_idx]);
> -    } else {
> -        /*
> -         * notify firmware which source interrupt are coming
> -         * by setting status register
> -         */
> -        s->regs[intc_irq->status_addr] = select;
> -        trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
> -                                      intc_irq->outpin_idx,
> -                                      s->regs[intc_irq->status_addr]);
> -        aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 1);
> -    }
> +    aspeed_intc_set_irq_handler(s, intc_irq, select);
>   }
>   
>   static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,


