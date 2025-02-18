Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404B0C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 06:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkGyD-0008G9-6Y; Tue, 18 Feb 2025 01:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org>)
 id 1tkGyA-0008FY-Sg; Tue, 18 Feb 2025 01:20:34 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OI5l=VJ=kaod.org=clg@ozlabs.org>)
 id 1tkGy7-00040A-II; Tue, 18 Feb 2025 01:20:34 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YxqBw5fQZz4x0t;
 Tue, 18 Feb 2025 17:20:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YxqBr4Vqmz4wc3;
 Tue, 18 Feb 2025 17:20:20 +1100 (AEDT)
Message-ID: <4ce36204-6c7f-4bd9-91fd-81d8a31123a6@kaod.org>
Date: Tue, 18 Feb 2025 07:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/28] hw/intc/aspeed: Refactor INTC to support
 separate input and output pin indices
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250213033531.3367697-10-jamin_lin@aspeedtech.com>
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
> Refactors the INTC to distinguish between input and output pin indices,
> improving interrupt handling clarity and accuracy.
> 
> Updated the functions to handle both input and output pin indices.
> Added detailed logging for input and output pin indices in trace events.
> 
> These changes ensure that the INTC controller can handle multiple input and
> output pins, improving support for the AST2700 A1.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/aspeed_intc.c | 97 +++++++++++++++++++++++++++----------------
>   hw/intc/trace-events  | 12 +++---
>   2 files changed, 67 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 32c4a3bb44..4e8f1e291e 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -36,20 +36,32 @@ REG32(GICINT136_STATUS,     0x1804)
>   
>   #define GICINT_STATUS_BASE     R_GICINT128_STATUS
>   
> -static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
> +/*
> + * Update the state of an interrupt controller pin by setting
> + * the specified output pin to the given level.
> + * The input pin index should be between 0 and the number of input pins.
> + * The output pin index should be between 0 and the number of output pins.
> + */
> +static void aspeed_intc_update(AspeedINTCState *s, int inpin_idx,
> +                               int outpin_idx, int level)
>   {
>       AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
>       const char *name = object_get_typename(OBJECT(s));
>   
> -    if (irq >= aic->num_inpins) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Invalid input pin index: %d\n",
> -                      __func__, irq);
> +    if (inpin_idx >= aic->num_inpins) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
> +                      __func__, inpin_idx);
>           return;
>       }
>   
> -    trace_aspeed_intc_update_irq(name, irq, level);
> -    qemu_set_irq(s->output_pins[irq], level);
> +    if (outpin_idx >= aic->num_outpins) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid output pin index: %d\n",
> +                      __func__, outpin_idx);
> +        return;
> +    }
> +
> +    trace_aspeed_intc_update_irq(name, inpin_idx, outpin_idx, level);
> +    qemu_set_irq(s->output_pins[outpin_idx], level);
>   }
>   
>   /*
> @@ -67,6 +79,11 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>       uint32_t select = 0;
>       uint32_t enable;
>       int i;
> +    int inpin_idx;
> +    int outpin_idx;
> +
> +    inpin_idx = irq;
> +    outpin_idx = irq;
>   
>       if (irq >= aic->num_inpins) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
> @@ -74,15 +91,15 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>           return;
>       }
>   
> -    trace_aspeed_intc_set_irq(name, irq, level);
> -    enable = s->enable[irq];
> +    trace_aspeed_intc_set_irq(name, inpin_idx, level);
> +    enable = s->enable[inpin_idx];
>   
>       if (!level) {
>           return;
>       }
>   
>       for (i = 0; i < aic->num_lines; i++) {
> -        if (s->orgates[irq].levels[i]) {
> +        if (s->orgates[inpin_idx].levels[i]) {
>               if (enable & BIT(i)) {
>                   select |= BIT(i);
>               }
> @@ -95,7 +112,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>   
>       trace_aspeed_intc_select(name, select);
>   
> -    if (s->mask[irq] || s->regs[status_addr]) {
> +    if (s->mask[inpin_idx] || s->regs[status_addr]) {
>           /*
>            * a. mask is not 0 means in ISR mode
>            * sources interrupt routine are executing.
> @@ -104,16 +121,17 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>            *
>            * save source interrupt to pending variable.
>            */
> -        s->pending[irq] |= select;
> -        trace_aspeed_intc_pending_irq(name, irq, s->pending[irq]);
> +        s->pending[inpin_idx] |= select;
> +        trace_aspeed_intc_pending_irq(name, inpin_idx, s->pending[inpin_idx]);
>       } else {
>           /*
>            * notify firmware which source interrupt are coming
>            * by setting status register
>            */
>           s->regs[status_addr] = select;
> -        trace_aspeed_intc_trigger_irq(name, irq, s->regs[status_addr]);
> -        aspeed_intc_update(s, irq, 1);
> +        trace_aspeed_intc_trigger_irq(name, inpin_idx, outpin_idx,
> +                                      s->regs[status_addr]);
> +        aspeed_intc_update(s, inpin_idx, outpin_idx, 1);
>       }
>   }
>   
> @@ -126,13 +144,15 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
>       uint32_t old_enable;
>       uint32_t change;
>       uint32_t irq;
> +    int inpin_idx;
>   
>       irq = (offset & 0x0f00) >> 8;
> +    inpin_idx = irq;
>   
> -    if (irq >= aic->num_inpins) {
> +    if (inpin_idx >= aic->num_inpins) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Invalid input pin index: %d\n",
> -                      __func__, irq);
> +                      __func__, inpin_idx);
>           return;
>       }
>   
> @@ -143,17 +163,17 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
>        */
>   
>       /* disable all source interrupt */
> -    if (!data && !s->enable[irq]) {
> +    if (!data && !s->enable[inpin_idx]) {
>           s->regs[addr] = data;
>           return;
>       }
>   
> -    old_enable = s->enable[irq];
> -    s->enable[irq] |= data;
> +    old_enable = s->enable[inpin_idx];
> +    s->enable[inpin_idx] |= data;
>   
>       /* enable new source interrupt */
> -    if (old_enable != s->enable[irq]) {
> -        trace_aspeed_intc_enable(name, s->enable[irq]);
> +    if (old_enable != s->enable[inpin_idx]) {
> +        trace_aspeed_intc_enable(name, s->enable[inpin_idx]);
>           s->regs[addr] = data;
>           return;
>       }
> @@ -161,11 +181,11 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
>       /* mask and unmask source interrupt */
>       change = s->regs[addr] ^ data;
>       if (change & data) {
> -        s->mask[irq] &= ~change;
> -        trace_aspeed_intc_unmask(name, change, s->mask[irq]);
> +        s->mask[inpin_idx] &= ~change;
> +        trace_aspeed_intc_unmask(name, change, s->mask[inpin_idx]);
>       } else {
> -        s->mask[irq] |= change;
> -        trace_aspeed_intc_mask(name, change, s->mask[irq]);
> +        s->mask[inpin_idx] |= change;
> +        trace_aspeed_intc_mask(name, change, s->mask[inpin_idx]);
>       }
>   
>       s->regs[addr] = data;
> @@ -178,6 +198,8 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
>       const char *name = object_get_typename(OBJECT(s));
>       uint32_t addr = offset >> 2;
>       uint32_t irq;
> +    int inpin_idx;
> +    int outpin_idx;
>   
>       if (!data) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid data 0\n", __func__);
> @@ -185,11 +207,13 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
>       }
>   
>       irq = (offset & 0x0f00) >> 8;
> +    inpin_idx = irq;
> +    outpin_idx = irq;
>   
> -    if (irq >= aic->num_inpins) {
> +    if (inpin_idx >= aic->num_inpins) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Invalid input pin index: %d\n",
> -                      __func__, irq);
> +                      __func__, inpin_idx);
>           return;
>       }
>   
> @@ -208,21 +232,22 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
>   
>       /* All source ISR execution are done */
>       if (!s->regs[addr]) {
> -        trace_aspeed_intc_all_isr_done(name, irq);
> -        if (s->pending[irq]) {
> +        trace_aspeed_intc_all_isr_done(name, inpin_idx);
> +        if (s->pending[inpin_idx]) {
>               /*
>                * handle pending source interrupt
>                * notify firmware which source interrupt are pending
>                * by setting status register
>                */
> -            s->regs[addr] = s->pending[irq];
> -            s->pending[irq] = 0;
> -            trace_aspeed_intc_trigger_irq(name, irq, s->regs[addr]);
> -            aspeed_intc_update(s, irq, 1);
> +            s->regs[addr] = s->pending[inpin_idx];
> +            s->pending[inpin_idx] = 0;
> +            trace_aspeed_intc_trigger_irq(name, inpin_idx, outpin_idx,
> +                                          s->regs[addr]);
> +            aspeed_intc_update(s, inpin_idx, outpin_idx, 1);
>           } else {
>               /* clear irq */
> -            trace_aspeed_intc_clear_irq(name, irq, 0);
> -            aspeed_intc_update(s, irq, 0);
> +            trace_aspeed_intc_clear_irq(name, inpin_idx, outpin_idx, 0);
> +            aspeed_intc_update(s, inpin_idx, outpin_idx, 0);
>           }
>       }
>   }
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index e9ca34755e..e97eea820b 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -82,12 +82,12 @@ aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64
>   # aspeed_intc.c
>   aspeed_intc_read(const char *s, uint64_t offset, unsigned size, uint32_t value) "%s: From 0x%" PRIx64 " of size %u: 0x%" PRIx32
>   aspeed_intc_write(const char *s, uint64_t offset, unsigned size, uint32_t data) "%s: To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> -aspeed_intc_set_irq(const char *s, int irq, int level) "%s: Set IRQ %d: %d"
> -aspeed_intc_clear_irq(const char *s, int irq, int level) "%s: Clear IRQ %d: %d"
> -aspeed_intc_update_irq(const char *s, int irq, int level) "%s: Update IRQ: %d: %d"
> -aspeed_intc_pending_irq(const char *s, int irq, uint32_t value) "%s: Pending IRQ: %d: 0x%x"
> -aspeed_intc_trigger_irq(const char *s, int irq, uint32_t value) "%s: Trigger IRQ: %d: 0x%x"
> -aspeed_intc_all_isr_done(const char *s, int irq) "%s: All source ISR execution are done: %d"
> +aspeed_intc_set_irq(const char *s, int inpin_idx, int level) "%s: Set IRQ %d: %d"
> +aspeed_intc_clear_irq(const char *s, int inpin_idx, int outpin_idx, int level) "%s: Clear IRQ %d-%d: %d"
> +aspeed_intc_update_irq(const char *s, int inpin_idx, int outpin_idx, int level) "%s: Update IRQ: %d-%d: %d"
> +aspeed_intc_pending_irq(const char *s, int inpin_idx, uint32_t value) "%s: Pending IRQ: %d: 0x%x"
> +aspeed_intc_trigger_irq(const char *s, int inpin_idx, int outpin_idx, uint32_t value) "%s: Trigger IRQ: %d-%d: 0x%x"
> +aspeed_intc_all_isr_done(const char *s, int inpin_idx) "%s: All source ISR execution are done: %d"
>   aspeed_intc_enable(const char *s, uint32_t value) "%s: Enable: 0x%x"
>   aspeed_intc_select(const char *s, uint32_t value) "%s: Select: 0x%x"
>   aspeed_intc_mask(const char *s, uint32_t change, uint32_t value) "%s: Mask: 0x%x: 0x%x"


