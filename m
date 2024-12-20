Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C89E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOZtz-0000N5-5g; Fri, 20 Dec 2024 05:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOZtm-0000MD-Ur; Fri, 20 Dec 2024 05:06:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOZtl-0001Wa-0U; Fri, 20 Dec 2024 05:06:22 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNw1Ht000873;
 Fri, 20 Dec 2024 10:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5JZfPm
 KWXtoVIOJ6yrF2Fh0zX6hxlN2t58YyXrwoh9Y=; b=D+aIlxh2ql9qDqQJz/5g9y
 MIbZdjiq9x4NNaW3ljvXmditt3gsYCRHahyZZKfKpFngZTdqvmGakrHEJlROCCLY
 yBKXt7OFLOr/eymaoHjQ1oHHofuovk4uaplNbsolrOjV0Zmbyv9fwWm460UO5kCj
 HTY7oSPe9dTMnQfnQDy5GMxKBxZiLNV2v1jV+QpVrCb1yj0RyJIB8QMORFfP1Xit
 3B4c1p2XKGexLdtPJD63SiqbomOC76Z4rZZrxmp6ggRFpY03HtT/dfie20pRvoVs
 pqRQrd4ORivhqaSehiGJ1qoqXyZTD3tWxZ1P9XS2FC6hm5KNEtdroEK9L/aaKWgg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwmhj4uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 10:06:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BKA3lUg004909;
 Fri, 20 Dec 2024 10:06:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwmhj4ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 10:06:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6EoVQ011271;
 Fri, 20 Dec 2024 10:06:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjkhcct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 10:06:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BKA67q532113238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 10:06:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAF2258043;
 Fri, 20 Dec 2024 10:06:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E88005805D;
 Fri, 20 Dec 2024 10:06:05 +0000 (GMT)
Received: from [9.124.215.200] (unknown [9.124.215.200])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Dec 2024 10:06:05 +0000 (GMT)
Message-ID: <d56ab09a-e301-4cd2-ad04-fec6bd84dc24@linux.ibm.com>
Date: Fri, 20 Dec 2024 15:36:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] spapr: Fix vpa dispatch count for record-replay
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20241219034035.1826173-1-npiggin@gmail.com>
 <20241219034035.1826173-3-npiggin@gmail.com>
 <4b3897e1-c9dd-45aa-bb6f-d8679fc78d25@linux.ibm.com>
 <alpine.LMD.2.03.2412201027180.18242@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <alpine.LMD.2.03.2412201027180.18242@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cw1v39kKq463PRzLaZUTMtZf1DaNptUI
X-Proofpoint-GUID: nEXKh63T4q1TWGOU6GTgjr0hbk2I4Bvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=855
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 12/20/24 14:59, BALATON Zoltan wrote:
> On Fri, 20 Dec 2024, Harsh Prateek Bora wrote:
>> Hi Nick,
>>
>> On 12/19/24 09:10, Nicholas Piggin wrote:
>>> The dispatch count is a field in guest memory that the hypervisor
>>> increments when preempting and dispatching the guest. This was not
>>> being done deterministically with respect to icount, because tcg
>>> exec exit is not deterministic (e.g., an async event could cause it).
>>>
>>> Change vpa dispatch count increment to keep track of whether the
>>> vCPU is considered dispatched or not, and only consider it preempted
>>> when calling cede / confer / join / stop-self / etc.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>   include/hw/ppc/spapr_cpu_core.h |  3 +++
>>>   hw/ppc/spapr.c                  | 36 ++-------------------------------
>>>   hw/ppc/spapr_hcall.c            | 33 ++++++++++++++++++++++++++++++
>>>   hw/ppc/spapr_rtas.c             |  1 +
>>>   4 files changed, 39 insertions(+), 34 deletions(-)
>>>
>>
>> <snipped>
>>
>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>> index 5e1d020e3df..907e09c2c36 100644
>>> --- a/hw/ppc/spapr_hcall.c
>>> +++ b/hw/ppc/spapr_hcall.c
>>> @@ -487,6 +487,36 @@ static target_ulong h_register_vpa(PowerPCCPU 
>>> *cpu, SpaprMachineState *spapr,
>>>       return ret;
>>>   }
>>>   +void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool 
>>> dispatch)
>>> +{
>>> +    uint32_t counter;
>>> +
>>> +    if (!dispatch) {
>>> +        assert(spapr_cpu->dispatched);
>>> +    } else {
>>> +        assert(!spapr_cpu->dispatched);
>>> +    }
>>
>> Would it look better as:
>>       assert(!(dispatch == spapr_cpu->dispatched));
> 
> That's more cryptic than the one above. Maybe with ternary operator to 
> avoid the if? Like
> assert(dispatch ? spapr_cpu->dispatched : !spapr_cpu->dispatched)
> 

Yeh, initially I thought of ternary op, but thought of it as more 
cryptic. I guess either is fine. Minor correction though:

   assert(dispatch ? !spapr_cpu->dispatched : spapr_cpu->dispatched)

regards,
Harsh

> Regards,
> BALATON Zoltan
> 
>>> +    spapr_cpu->dispatched = dispatch;
>>> +
>>> +    return;
>>
>> Returning here unconditionally makes below code unreachable.
>>
>>> +
>>> +    if (!spapr_cpu->vpa_addr) {
>>> +        return;
>>> +    }
>>
>> This could be moved to beginning or just after assert.
>>
>> regards,
>> Harsh
>>
>>> +
>>> +    /* These are only called by TCG, KVM maintains dispatch state */
>>> +    counter = ldl_be_phys(cs->as, spapr_cpu->vpa_addr + 
>>> VPA_DISPATCH_COUNTER);
>>> +    counter++;
>>> +    if ((counter & 1) != dispatch) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "VPA: incorrect dispatch counter value for "
>>> +                      "%s partition %u, correcting.\n",
>>> +                      dispatch ? "preempted" : "running", counter);
>>> +        counter++;
>>> +    }
>>> +    stl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, 
>>> counter);
>>> +}
>>> +
>>>   static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>                              target_ulong opcode, target_ulong *args)
>>>   {
>>> @@ -505,6 +535,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, 
>>> SpaprMachineState *spapr,
>>>         if (!cpu_has_work(cs)) {
>>>           cs->halted = 1;
>>> +        vpa_dispatch(cs, spapr_cpu, false);
>>>           cs->exception_index = EXCP_HLT;
>>>           cs->exit_request = 1;
>>>           ppc_maybe_interrupt(env);
>>> @@ -531,6 +562,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
>>>       cs->exit_request = 1;
>>>       ppc_maybe_interrupt(&cpu->env);
>>>   +    vpa_dispatch(cs, spapr_cpu, false);
>>> +
>>>       return H_SUCCESS;
>>>   }
>>>   diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>> index f329693c554..8ce42302234 100644
>>> --- a/hw/ppc/spapr_rtas.c
>>> +++ b/hw/ppc/spapr_rtas.c
>>> @@ -216,6 +216,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, 
>>> SpaprMachineState *spapr,
>>>        */
>>>       env->spr[SPR_PSSCR] |= PSSCR_EC;
>>>       cs->halted = 1;
>>> +    vpa_dispatch(cs, spapr_cpu_state(cpu), false);
>>>       ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
>>>       kvmppc_set_reg_ppc_online(cpu, 0);
>>>       qemu_cpu_kick(cs);
>>
>>

