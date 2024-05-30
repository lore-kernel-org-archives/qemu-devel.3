Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5AFC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaUa-0003e9-Tb; Thu, 30 May 2024 03:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Otnh=NB=kaod.org=clg@ozlabs.org>)
 id 1sCaUZ-0003bA-RO; Thu, 30 May 2024 03:46:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Otnh=NB=kaod.org=clg@ozlabs.org>)
 id 1sCaUW-0003PV-HX; Thu, 30 May 2024 03:46:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Vqdby6vsvz4wyY;
 Thu, 30 May 2024 17:46:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vqdbw3ZR1z4wyQ;
 Thu, 30 May 2024 17:46:20 +1000 (AEST)
Message-ID: <a124af35-7ff0-487c-9a9d-ae352e9f359f@kaod.org>
Date: Thu, 30 May 2024 09:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/10] ppc/pnv: Invert the design for big-core machine
 modelling
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-9-npiggin@gmail.com>
 <eb04e4c8-26ca-4330-ae32-a58737d2a78b@kaod.org>
 <D1MS4B4OOMP2.URZ3Y2R98BC8@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <D1MS4B4OOMP2.URZ3Y2R98BC8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Otnh=NB=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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


>>> @@ -157,6 +157,14 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>>>    
>>>        pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);
>>>    
>>> +    /* Only one DT node per (big) core */
>>> +    if (tir != 0) {
>>> +        g_assert(pc->big_core);
>>> +        g_assert(tir == 1);
>>> +        g_assert(pc->hwid & 1);
>>> +        return -1;
>>
>> return is -1 but it's not an error. right ?
> 
> Not an error just a "no CPU node to insert".
> 
> It's a bit ugly. Could return bool for yes/no and take a *offset
> maybe?

or we could pass the pa_features array  ?


>>> +        if (machine->smp.threads > 8) {
>>> +            error_report("Cannot support more than 8 threads/core "
>>> +                         "on a powernv9/10  machine");
>>> +            exit(1);
>>> +        }
>>> +        if (machine->smp.threads % 2 == 1) {
>>
>> is_power_of_2()
> 
> It does have that check later in pnv_init(), but I wanted
> to be careful that we're dividing by 2 below I think it makes
> it more obvious (and big-core can't have 1 thread per big core).

ok


> 
>>> @@ -1099,6 +1157,8 @@ static void pnv_power9_init(MachineState *machine)
>>>    
>>>    static void pnv_power10_init(MachineState *machine)
>>>    {
>>> +    PnvMachineState *pnv = PNV_MACHINE(machine);
>>> +    pnv->big_core_tbst_quirk = true;
>>>        pnv_power9_init(machine);
>>>    }
>>>    
>>> @@ -1169,9 +1229,15 @@ static void pnv_processor_id_p9(PnvChip *chip,
>>>                                    uint32_t core_id, uint32_t thread_id,
>>>                                    uint32_t *pir, uint32_t *tir)
>>>    {
>>> -    if (chip->nr_threads == 8) {
>>> -        *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
>>> -               (thread_id >> 1);
>>> +    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>>
>> arg. We should avoid these qdev_get_machine() calls. Could big_core be a
>> chip property instead ?
> 
> We could, but per machine probably makes more sense. It's
> funny there seems to be no good way to get machine from CPU.
> Maybe we can just add a machine pointer in PnvChip?


It would be easier/cleaner to propagate the machine settings to
the chip unit and subunits. If I remember correctly, real HW has a
scan init sequence doing something similar.

> I'l probably leave that for another series and try to convert
> most things.
> 
>>> +static bool pnv_machine_get_hb(Object *obj, Error **errp)
>>> +{
>>> +    PnvMachineState *pnv = PNV_MACHINE(obj);
>>> +
>>> +    return !!pnv->fw_load_addr;
>>> +}
>>> +
>>> +static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
>>> +{
>>> +    PnvMachineState *pnv = PNV_MACHINE(obj);
>>> +
>>> +    if (value) {
>>> +        pnv->fw_load_addr = 0x8000000;
>>> +    }
>>> +}
>>
>> we might want to get rid of the hostboot mode oneday. This was really
>> experimental stuff.
> 
> Okay sure, I don't use it. Although we may want to run the
> open source hostboot part of the firmware on QEMU one day,
> we can always add back some options for it.

It's not invasive either. Let's keep it. It use to work with a
trimdown Linux image.


Thanks,

C.


> 
> We do have a PowerVM mode too which tweaks a few things, but
> that's no use for upstream.
> 
>>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>>> index 059d372c8a..05195527a5 100644
>>> --- a/hw/ppc/spapr_cpu_core.c
>>> +++ b/hw/ppc/spapr_cpu_core.c
>>
>> This change should come in another patch preferably
> 
> Yeah this might have got into the wrong patch.
> 
> Thanks,
> Nick


