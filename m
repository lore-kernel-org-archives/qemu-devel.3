Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5A1C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZzT-0006wc-Ky; Thu, 27 Feb 2025 04:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1tnZzE-0006vH-TI; Thu, 27 Feb 2025 04:15:22 -0500
Received: from mail.csclub.uwaterloo.ca ([2620:101:f000:4901:c5c::5e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1tnZzB-0005CH-5X; Thu, 27 Feb 2025 04:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=csc; t=1740647712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05TWXLxxSWxWzqa01vyGWnLisLLuEypTrNYSHFlkzvI=;
 b=NSQnSJHObOmkg0NMiWBNDa0/zo+QN26qNhRPINcLIi1IXuehiw/QxkEIfYT+ct/fQ0X7IV
 VBOJtAS3wOezDdUUlmVr1GL8yrg7tAdA1TH0y+4oBfZsZGpVH4yUwS0h9trwXCqnifh0Ps
 4F73yW3AdlTvtgjPd/5wO/AKFWYqHoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=202502e; t=1740647712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05TWXLxxSWxWzqa01vyGWnLisLLuEypTrNYSHFlkzvI=;
 b=W0Kizpd0v24IqcbJ71QmGP6wofLDSzhCBh1u0+nX0ZGncmIQf6nUBQbBNRWPdJgjVVf1mJ
 uEpAcAbIYb73ibAQ==
Message-ID: <aef79501-b99f-4e84-b6fe-14dec1e030e6@csclub.uwaterloo.ca>
Date: Thu, 27 Feb 2025 04:15:11 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
 <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
Content-Language: en-US
From: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
In-Reply-To: <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2620:101:f000:4901:c5c::5e2d;
 envelope-from=s23adhik@csclub.uwaterloo.ca; helo=mail.csclub.uwaterloo.ca
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Hello, thank you for taking the time to review the patch,
and tell us what we could improve.

> The values passed to qdev_get_gpio_in(DEVICE(&s->gic), ...)
> should be GIC_SPI_INTERRUPT_* values, which we define in
> include/hw/arm/bcm2838_peripherals.h. You can add new ones for
> the four timers.
>
Hm, I'll make those changes (hopefully) by Wednesday next week.
I'm a bit busy, so it might take a bit of time to do it.

> The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
> being wired up in the function bcm_soc_peripherals_common_realize()
> in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
> interrupt controller), and it isn't valid to wire one input
> directly to multiple outputs.
>
> In fact it looks like we are currently getting this wrong for
> all of the interrupts that need to be wired to both the
> "legacy interrupt controller" and the GIC. I think at the moment
> what happens is that the wiring to the GIC will happen last
> and this overrides the earlier wiring to the legacy interrupt
> controller, so code using the latter won't work correctly.
I'll try reading through the relevant sections and send an
updated patch later next week. From what I can tell it falls
under the bcm2835_pheripherals.c file, right?


On 2025-02-24 08:22, Peter Maydell wrote:
> On Sun, 16 Feb 2025 at 03:54, Sourojeet Adhikari
> <s23adhik@csclub.uwaterloo.ca> wrote:
>> Hello everyone,
>>
>> This patch adds support for the system timer interrupts
>> in QEMU's BCM2838 model. It defines a new constant
>> called GIC400_TIMER_INT, and connects 4 timer interupts
>> to the GIC-400.
>> Previously timer interupts were not being routed to the
>> interupt controller, causing scheduling, and some other
>> stuff to have issues (me and a few friends bumped into
>> this, and that's why this was written lol).
>>
>> Signed-off-by: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
> Hi; thanks for sending this patch, but I'm afraid this doesn't
> look like a correct fix for the bug you've run into.
>
>> ---
>>    hw/arm/bcm2838.c | 11 +++++++++++
>>    1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
>> index ddb7c5f..0a4179f 100644
>> --- a/hw/arm/bcm2838.c
>> +++ b/hw/arm/bcm2838.c
>> @@ -21,6 +21,8 @@
>>    #define GIC400_TIMER_S_EL1_IRQ      13
>>    #define GIC400_TIMER_NS_EL1_IRQ     14
>>    #define GIC400_LEGACY_IRQ           15
>> +#define GIC400_TIMER_INT            (96 - 32)
>> +
>>
>>    /* Number of external interrupt lines to configure the GIC with */
>>    #define GIC_NUM_IRQS                192
>> @@ -176,6 +178,15 @@ static void bcm2838_realize(DeviceState *dev, Error
>> **errp)
>>                        qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
>>        }
>>
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 0,
>> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
>> INTERRUPT_TIMER0));
> The values passed to qdev_get_gpio_in(DEVICE(&s->gic), ...)
> should be GIC_SPI_INTERRUPT_* values, which we define in
> include/hw/arm/bcm2838_peripherals.h. You can add new ones for
> the four timers.
>
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 1,
>> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
>> INTERRUPT_TIMER1));
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 2,
>> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
>> INTERRUPT_TIMER2));
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 3,
>> +        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT +
>> INTERRUPT_TIMER3));
> The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
> being wired up in the function bcm_soc_peripherals_common_realize()
> in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
> interrupt controller), and it isn't valid to wire one input
> directly to multiple outputs.
>
> In fact it looks like we are currently getting this wrong for
> all of the interrupts that need to be wired to both the
> "legacy interrupt controller" and the GIC. I think at the moment
> what happens is that the wiring to the GIC will happen last
> and this overrides the earlier wiring to the legacy interrupt
> controller, so code using the latter won't work correctly.
>
> thanks
> -- PMM

