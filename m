Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61249C3ABD0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 04:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqQ0n-0003Mm-6K; Tue, 17 Sep 2024 00:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sqQ0m-0003Lr-J2; Tue, 17 Sep 2024 00:40:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sqQ0k-0005st-QF; Tue, 17 Sep 2024 00:40:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIUxhS031113;
 Tue, 17 Sep 2024 04:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=o
 h6ySI6hKImIjlyDIqDvXblLGirPSV2FSbcppFqrVjc=; b=MzZtg8ZNCY8V/Ms/9
 B+KTVqPHFJpwKgksBQbsHbNpAgmT2zP83JKpfe8Dvi2GblhN110E4+5vLgLb1Jkp
 se0YZCOcefP7DEcHnPSHVee7weFOOjeVMuKOOSXkSWhMBodY/NZbr9Px0IK6TOq/
 cWhzl0ZAS7HSI++vT0B0fXSeu0MRodUes+bRvbrJ7MSwFERCAzm8cwWFrBHYbxxF
 +Pu7vV9GTW1OqI4+fwS5nYThkSe3fFVqiCdz9dkHP0Tp7uDFg8z8NJk/E+uFwIOK
 KoGywphwvEjeZ/v2THX+WEeW6hcESwxIaS+CM0jbPPjuXQqjO8cOeTD3pXHfHtcE
 nQR+Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnnbwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:40:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H4eCxZ023397;
 Tue, 17 Sep 2024 04:40:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnnbw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:40:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H25xt3000742;
 Tue, 17 Sep 2024 04:40:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntq329e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:40:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48H4eBkW52691344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 04:40:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A86F5803F;
 Tue, 17 Sep 2024 04:40:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B98505805A;
 Tue, 17 Sep 2024 04:40:08 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2024 04:40:08 +0000 (GMT)
Message-ID: <5680289a-9a6c-442d-b4d1-d73826ef6a00@linux.ibm.com>
Date: Tue, 17 Sep 2024 10:10:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] target/ppc: simplify var usage in
 ppc_next_unmasked_interrupt
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-10-harshpb@linux.ibm.com>
 <e09919a0-061d-90e0-8107-68e509ce08aa@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <e09919a0-061d-90e0-8107-68e509ce08aa@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _fuxeCUUXc6RssTYVAlaeQeRSB7TJoO2
X-Proofpoint-GUID: _VMMpc7zsm6Is2Ec_q8Krh_vqaXMZtIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_01,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170030
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/13/24 18:20, BALATON Zoltan wrote:
> On Fri, 13 Sep 2024, Harsh Prateek Bora wrote:
>> As previously done for arch specific handlers, simplify var usage in
>> ppc_next_unmasked_interrupt by caching the env->pending_interrupts and
>> env->spr[SPR_LPCR] in local vars and using it later at multiple places.
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>> target/ppc/excp_helper.c | 54 ++++++++++++++++++++--------------------
>> 1 file changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index d0e0f609a0..4eeeedff5b 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -2022,31 +2022,31 @@ static int 
>> p9_next_unmasked_interrupt(CPUPPCState *env,
>>
>> static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>> {
>> +    uint32_t pending_interrupts = env->pending_interrupts;
>> +    target_ulong lpcr = env->spr[SPR_LPCR];
>> +    bool async_deliver;
> 
> Maybe easier to review if split into one patch for each variable added 
> so it's easier to see what's replaced and that nothing is missed.
> 

Thanks for the reviews. I shall split as suggested in v4.

regards,
Harsh

> Regards,
> BALATON Zoltan
> 
>> +
>> #ifdef TARGET_PPC64
>>     switch (env->excp_model) {
>>     case POWERPC_EXCP_POWER7:
>> -        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
>> -                                          env->spr[SPR_LPCR]);
>> +        return p7_next_unmasked_interrupt(env, pending_interrupts, 
>> lpcr);
>>     case POWERPC_EXCP_POWER8:
>> -        return p8_next_unmasked_interrupt(env, env->pending_interrupts,
>> -                                          env->spr[SPR_LPCR]);
>> +        return p8_next_unmasked_interrupt(env, pending_interrupts, 
>> lpcr);
>>     case POWERPC_EXCP_POWER9:
>>     case POWERPC_EXCP_POWER10:
>>     case POWERPC_EXCP_POWER11:
>> -        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
>> -                              env->spr[SPR_LPCR]);
>> +        return p9_next_unmasked_interrupt(env, pending_interrupts, 
>> lpcr);
>>     default:
>>         break;
>>     }
>> #endif
>> -    bool async_deliver;
>>
>>     /* External reset */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
>> +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
>>         return PPC_INTERRUPT_RESET;
>>     }
>>     /* Machine check exception */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
>> +    if (pending_interrupts & PPC_INTERRUPT_MCK) {
>>         return PPC_INTERRUPT_MCK;
>>     }
>> #if 0 /* TODO */
>> @@ -2065,9 +2065,9 @@ static int 
>> ppc_next_unmasked_interrupt(CPUPPCState *env)
>>     async_deliver = FIELD_EX64(env->msr, MSR, EE) || 
>> env->resume_as_sreset;
>>
>>     /* Hypervisor decrementer exception */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
>> +    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>>         /* LPCR will be clear when not supported so this will work */
>> -        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
>> +        bool hdice = !!(lpcr & LPCR_HDICE);
>>         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hdice) {
>>             /* HDEC clears on delivery */
>>             return PPC_INTERRUPT_HDECR;
>> @@ -2075,18 +2075,18 @@ static int 
>> ppc_next_unmasked_interrupt(CPUPPCState *env)
>>     }
>>
>>     /* Hypervisor virtualization interrupt */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
>> +    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>>         /* LPCR will be clear when not supported so this will work */
>> -        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
>> +        bool hvice = !!(lpcr & LPCR_HVICE);
>>         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hvice) {
>>             return PPC_INTERRUPT_HVIRT;
>>         }
>>     }
>>
>>     /* External interrupt can ignore MSR:EE under some circumstances */
>> -    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
>> -        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
>> -        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
>> +    if (pending_interrupts & PPC_INTERRUPT_EXT) {
>> +        bool lpes0 = !!(lpcr & LPCR_LPES0);
>> +        bool heic = !!(lpcr & LPCR_HEIC);
>>         /* HEIC blocks delivery to the hypervisor */
>>         if ((async_deliver && !(heic && FIELD_EX64_HV(env->msr) &&
>>             !FIELD_EX64(env->msr, MSR, PR))) ||
>> @@ -2096,45 +2096,45 @@ static int 
>> ppc_next_unmasked_interrupt(CPUPPCState *env)
>>     }
>>     if (FIELD_EX64(env->msr, MSR, CE)) {
>>         /* External critical interrupt */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_CEXT) {
>> +        if (pending_interrupts & PPC_INTERRUPT_CEXT) {
>>             return PPC_INTERRUPT_CEXT;
>>         }
>>     }
>>     if (async_deliver != 0) {
>>         /* Watchdog timer on embedded PowerPC */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
>> +        if (pending_interrupts & PPC_INTERRUPT_WDT) {
>>             return PPC_INTERRUPT_WDT;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
>> +        if (pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
>>             return PPC_INTERRUPT_CDOORBELL;
>>         }
>>         /* Fixed interval timer on embedded PowerPC */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
>> +        if (pending_interrupts & PPC_INTERRUPT_FIT) {
>>             return PPC_INTERRUPT_FIT;
>>         }
>>         /* Programmable interval timer on embedded PowerPC */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_PIT) {
>> +        if (pending_interrupts & PPC_INTERRUPT_PIT) {
>>             return PPC_INTERRUPT_PIT;
>>         }
>>         /* Decrementer exception */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
>> +        if (pending_interrupts & PPC_INTERRUPT_DECR) {
>>             return PPC_INTERRUPT_DECR;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>> +        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>>             return PPC_INTERRUPT_DOORBELL;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
>> +        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
>>             return PPC_INTERRUPT_HDOORBELL;
>>         }
>> -        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
>> +        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
>>             return PPC_INTERRUPT_PERFM;
>>         }
>>         /* Thermal interrupt */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_THERM) {
>> +        if (pending_interrupts & PPC_INTERRUPT_THERM) {
>>             return PPC_INTERRUPT_THERM;
>>         }
>>         /* EBB exception */
>> -        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
>> +        if (pending_interrupts & PPC_INTERRUPT_EBB) {
>>             /*
>>              * EBB exception must be taken in problem state and
>>              * with BESCR_GE set.
>>

