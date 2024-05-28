Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAB8C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBrWR-0001cr-Cg; Tue, 28 May 2024 03:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBrWP-0001cJ-Mv; Tue, 28 May 2024 03:45:25 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBrWN-0003vI-Ky; Tue, 28 May 2024 03:45:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VpPgj2Z3Fz4x2d;
 Tue, 28 May 2024 17:45:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpPgf0cy6z4wyw;
 Tue, 28 May 2024 17:45:17 +1000 (AEST)
Message-ID: <d56be3f2-0e63-4db3-aba5-112cda695cfe@kaod.org>
Date: Tue, 28 May 2024 09:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/10] ppc/pnv: specialise init for powernv8/9/10
 machines
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-5-npiggin@gmail.com>
 <721d6b4b-0026-44c9-a97b-a007cc1ff5eb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <721d6b4b-0026-44c9-a97b-a007cc1ff5eb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=HxTW=M7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 5/28/24 09:10, Harsh Prateek Bora wrote:
> Hi Nick,
> 
> On 5/26/24 17:56, Nicholas Piggin wrote:
>> This will allow different settings and checks for different
>> machine types with later changes.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/ppc/pnv.c | 35 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 6e3a5ccdec..a706de2e36 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -976,11 +976,6 @@ static void pnv_init(MachineState *machine)
>>       pnv->num_chips =
>>           machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
>> -    if (machine->smp.threads > 8) {
>> -        error_report("Cannot support more than 8 threads/core "
>> -                     "on a powernv machine");
>> -        exit(1);
>> -    }
>>       if (!is_power_of_2(machine->smp.threads)) {
>>           error_report("Cannot support %d threads/core on a powernv"
>>                        "machine because it must be a power of 2",
>> @@ -1076,6 +1071,33 @@ static void pnv_init(MachineState *machine)
>>       }
>>   }
>> +static void pnv_power8_init(MachineState *machine)
>> +{
>> +    if (machine->smp.threads > 8) {
>> +        error_report("Cannot support more than 8 threads/core "
>> +                     "on a powernv POWER8 machine");
> 
> We could use mc->desc for machine name above, so that ..
> 
>> +        exit(1);
>> +    }
> 
> with this patch, we can reuse p8 init for both p9 and p10 (and not just reuse p9 for p10 with hard coded string?).

Good idea. You could add a 'max_smt' attribute to PnvMachineClass to limit
POWER8 to one.


Thanks,

C.


> 
> With that,
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
>> +
>> +    pnv_init(machine);
>> +}
>> +
>> +static void pnv_power9_init(MachineState *machine)
>> +{
>> +    if (machine->smp.threads > 8) {
>> +        error_report("Cannot support more than 8 threads/core "
>> +                     "on a powernv9/10 machine");
>> +        exit(1);
>> +    }
>> +
>> +    pnv_init(machine);
>> +}
>> +
>> +static void pnv_power10_init(MachineState *machine)
>> +{
>> +    pnv_power9_init(machine);
>> +}
>> +
>>   /*
>>    *    0:21  Reserved - Read as zeros
>>    *   22:24  Chip ID
>> @@ -2423,6 +2445,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>>       };
>>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER8";
>> +    mc->init = pnv_power8_init;
>>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>> @@ -2449,6 +2472,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>>       };
>>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER9";
>> +    mc->init = pnv_power9_init;
>>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
>>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>> @@ -2473,6 +2497,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>>           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
>>       };
>> +    mc->init = pnv_power10_init;
>>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));


