Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D23C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 06:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trWdg-0006r3-0Y; Mon, 10 Mar 2025 02:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1trWdZ-0006qM-Sb; Mon, 10 Mar 2025 02:29:18 -0400
Received: from mail.csclub.uwaterloo.ca ([2620:101:f000:4901:c5c::5e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1trWdW-0000W0-Gp; Mon, 10 Mar 2025 02:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=csc; t=1741588148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+vKOETW+kr7aWqCx1htBYNXSAxU8w4lPIaWNo1sFnI=;
 b=Ke8XtXix9hXCyPGe9Kw9tCS9rZVuc77Kt57u6XChcwlWTtzxjW4xdHrGsd1Pjl+S9SKZwV
 VHTZw/MEt5H43MrKBz+gAQkvooV6P3GcPkn7Yfx+L0nJJmxzmL613r8FEUjxQwW4AHB0aB
 32FG+hINzsIUtpeKV0Dx2wVtRSh971o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=202502e; t=1741588148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+vKOETW+kr7aWqCx1htBYNXSAxU8w4lPIaWNo1sFnI=;
 b=1RrmSdFLG3UwI6PWlZlSwwS4AiOXrhfHOq4/60iQ36XUgfVAeIqdrXo2mncCJTR5Apq3xp
 BRjDZ5lyn7eD3MBA==
Message-ID: <3660e47b-0f37-4e6d-8bbd-7d646eb67207@csclub.uwaterloo.ca>
Date: Mon, 10 Mar 2025 02:29:08 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
 <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
 <aef79501-b99f-4e84-b6fe-14dec1e030e6@csclub.uwaterloo.ca>
 <CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com>
 <d714a7c2-2291-4a85-abcc-81648da1ef57@csclub.uwaterloo.ca>
 <CAFEAcA-9Nj9KrcPwoBBT88wK=NUPsorT71XbBbyLJYOemmkojQ@mail.gmail.com>
Content-Language: en-US
From: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
In-Reply-To: <CAFEAcA-9Nj9KrcPwoBBT88wK=NUPsorT71XbBbyLJYOemmkojQ@mail.gmail.com>
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

Hello,

So far I've figured out that I need to add a member called SplitIRQ
in the BCMSocPeripheralBaseState struct, which is of size defined
by `BCM2835_NUM_SPLITTERS`. Then from what I can tell through
reading through the codebase, I should do something similar to
what happens in `exynos4210.c` in the `exynos4210_init_board_irqs`
function?

Sorry for taking a while to get back and still having quite a few
questions about this. Thank you for helping me out with writting
this patch.

Sourojeet Adhikari

On 2025-03-01 09:09, Peter Maydell wrote:
> On Sat, 1 Mar 2025 at 01:47, Sourojeet Adhikari
> <s23adhik@csclub.uwaterloo.ca> wrote:
>> On 2025-02-27 10:17, Peter Maydell wrote:
>>
>> On Thu, 27 Feb 2025 at 09:15, Sourojeet Adhikari
>> <s23adhik@csclub.uwaterloo.ca> wrote:
>>
>> The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
>> being wired up in the function bcm_soc_peripherals_common_realize()
>> in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
>> interrupt controller), and it isn't valid to wire one input
>> directly to multiple outputs.
>>
>> In fact it looks like we are currently getting this wrong for
>> all of the interrupts that need to be wired to both the
>> "legacy interrupt controller" and the GIC. I think at the moment
>> what happens is that the wiring to the GIC will happen last
>> and this overrides the earlier wiring to the legacy interrupt
>> controller, so code using the latter won't work correctly.
>>
>> I'll try reading through the relevant sections and send an
>> updated patch later next week. From what I can tell it falls
>> under the bcm2835_pheripherals.c file, right?
>>
>> Yes. To expand a bit, QEMU's qemu_irq abstraction must
>> always be wired exactly 1-to-1, from a single output to
>> a single input. Wiring either one input to multiple outputs
>> or one output to multiple inputs will not behave correctly
>> (and unfortunately we don't have an easy way to assert()
>> if code in QEMU gets this wrong).
>>
>> So for cases where you want the one-to-many behaviour you need
>> to create an object of TYPE_SPLIT_IRQ. This has one input and
>> multiple outputs, so you can connect your wire from device A's
>> output to the splitter's input, and then connect outputs
>> from the splitter to devices B, C, etc. (In this case A
>> would be the timer, and B, C the two interrupt controllers.)
>> Searching the source code for TYPE_SPLIT_IRQ will give some
>> places where it's used. (Ignore the qdev_new(TYPE_SPLIT_IRQ)
>> ones, those are a code pattern we use in board models, not
>> in SoC device models.)
>>
>> In this specific bcm2838 case, it's a little more awkward,
>> because one of the two interrupt controllers is created inside
>> bcm2835_peripherals.c and one of them is created outside it.
>> Since bcm2838 is already reaching inside the bcm2835_peripherals
>> object I guess the simplest thing is:
>>   * create a splitter object in bcm2835_peripherals.c for
>>     every IRQ line that needs to be connected to both
>>     interrupt controllers (probably easiest to have an array
>>     of splitter objects, irq_splitter[])
>>   * in bcm2835_peripherals.c, connect the device's outbound
>>     IRQ to the input of the appropriate splitter, and
>>     connect output 0 of that splitter to the BCM2835_IC
>>     correct interrupt controller input
>>   * in bcm2838.c, connect output 0 of ps_base->irq_splitter[n]
>>     to the correct GIC input
>>
>> (This is kind of breaking the abstraction layer that ideally
>> exists where the code that creates and uses a device doesn't
>> try to look "inside" it at any subparts it might have. We
>> could, for instance, instead make the bcm2835_peripherals
>> object expose its own qemu_irq outputs which were the second
>> outputs of the splitters, so that the bcm2838.c code wasn't
>> looking inside and finding the splitters directly. But I
>> think that's more awkward than it's worth. It's also possible
>> that we have the split between the main SoC and the
>> peripheral object wrong and either both interrupt controllers
>> or neither should be inside the peripheral object; but
>> reshuffling things like that would be a lot of work too.)
>>
>> This weekend I'll try my best to mess around, and get the solution
>> you proposed working. From what I can tell, I (personally) think , the not-reshuffling things approach might be a bit better here. Since otherwise it'd turn into a somewhat sizeable patch pretty quick, and is a lot of work, for something that's not *too* big of an issue. I do have access to a raspberry pi if you think I should do any kind of testing before doing the reshuffling.
> Yeah, to be clear, what I'm suggesting is that we should
> not do that reshuffling, exactly because it is a lot of
> work and it's not that important. Better to just fix the bug.
>
>> On another note, do you think it's reasonable to add what you said
>> here into the development documentation (paraphrased, and if not
>> already documented). If I do write a patch to the documentation,
>> can/should I cc you on it?
> In general, yes, we should at least document this kind of
> beartrap. The difficulty is finding some good place to do it
> (there are two broad locations: in a doc comment on the
> function(s) for "connect a qemu_irq", and in some more
> general "how to do device/board stuff" place in docs/devel/).
> Feel free to cc me on any patch you send about that.
>
>> (PS: for the other "not 1:1" case, where you want to connect
>> many qemu_irqs outputs together into one input, the usual semantics
>> you want is to logically-OR the interrupt lines together, and
>> so you use TYPE_OR_IRQ for that.)
>>
>> (oh oki, I'll make sure to do that on the upcoming patch then,
>> thank you!)
> I think you won't need the OR gate part -- I mentioned it just
> for completeness.
>
>> (P.S the patch probably won't be coming till next week since I
>> have quite a bit of work outside of my programming stuff to do.
>> Should hopfully be done by Wednesday next week though?)
> That's fine -- since this is a bug fix we don't have to worry
> about getting it in before softfreeze.
>
> -- PMM

