Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCF3C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCpQ-00049z-UF; Wed, 29 May 2024 02:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org>)
 id 1sCCpP-00043v-63; Wed, 29 May 2024 02:30:27 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org>)
 id 1sCCpM-0006Ii-RT; Wed, 29 May 2024 02:30:26 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Vpzyb1FLjz4wqM;
 Wed, 29 May 2024 16:30:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpzyW6xk2z4wyj;
 Wed, 29 May 2024 16:30:11 +1000 (AEST)
Message-ID: <53791846-3b8c-4da8-8cca-c2c521c59450@kaod.org>
Date: Wed, 29 May 2024 08:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/10] ppc/pnv: Extend chip_pir class method to TIR as
 well
To: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-6-npiggin@gmail.com>
 <39e4ac93-256b-424b-8ecb-7ed87afeb048@linux.ibm.com>
 <D1LP8QHR9GGW.2QAD6R00QARSG@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <D1LP8QHR9GGW.2QAD6R00QARSG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=oWzJ=NA=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 5/29/24 02:24, Nicholas Piggin wrote:
> On Tue May 28, 2024 at 6:32 PM AEST, Harsh Prateek Bora wrote:
>>
>>
>> On 5/26/24 17:56, Nicholas Piggin wrote:
>>> The chip_pir chip class method allows the platform to set the PIR
>>> processor identification register. Extend this to a more general
>>> ID function which also allows the TIR to be set. This is in
>>> preparation for "big core", which is a more complicated topology
>>> of cores and threads.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    include/hw/ppc/pnv_chip.h |  3 +-
>>>    hw/ppc/pnv.c              | 61 ++++++++++++++++++++++++---------------
>>>    hw/ppc/pnv_core.c         | 10 ++++---
>>>    3 files changed, 45 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
>>> index 8589f3291e..679723926a 100644
>>> --- a/include/hw/ppc/pnv_chip.h
>>> +++ b/include/hw/ppc/pnv_chip.h
>>> @@ -147,7 +147,8 @@ struct PnvChipClass {
>>>    
>>>        DeviceRealize parent_realize;
>>>    
>>> -    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id);
>>> +    void (*processor_id)(PnvChip *chip, uint32_t core_id, uint32_t thread_id,
>>> +                         uint32_t *pir, uint32_t *tir);
>>
>> Should it be named get_chip_core_thread_regs() ?
> 
> Yeah, the name isn't great. It is getting the regs, but the regs are the
> "pervasive id" used as well... but maybe that's not too relevant here.
> What about we drop chip_ since we have the chip and no other methods use
> such prefix, then call it get_thread_pir_tir()?

processor relates to chip and so, processor_id() is not great indeed.
get_pir_tir() would be enough I think.

What would be good though, since pnv is growing, is to start adding
documentation to these common helpers.


Thanks,

C.



>>> @@ -155,7 +155,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>>>        char *nodename;
>>>        int cpus_offset = get_cpus_node(fdt);
>>>    
>>> -    pir = pnv_cc->chip_pir(chip, pc->hwid, 0);
>>> +    pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);
>>
>> As a generic helper API and potentially expandable, it should allow
>> passing NULL for registers whose values are not really sought to avoid
>> having to create un-necessary local variables by the caller.
> 
> I'll do that.
> 
> Thanks,
> Nick


