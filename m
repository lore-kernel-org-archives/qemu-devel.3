Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9900FEEEC08
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxly-00029p-T7; Fri, 13 Sep 2024 00:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxlw-00021C-RW; Fri, 13 Sep 2024 00:19:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxlu-0002zQ-Dy; Fri, 13 Sep 2024 00:19:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CKpST5003716;
 Fri, 13 Sep 2024 04:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 RbiPxKrWMujBZPa4GbxXtF0wmzsqOiJrJSM3bG6xnzU=; b=XhvBb6n81dNWGKxy
 o6n+uSrbdNMskk1tmjG/t+2ToPIFHfWTtMBJSjh48z2ARGuEaGad2qxHdekRqZvd
 HxpvmD/7DemW8izU6OOlbVtMPo7Uh6MkzEG4d4xl/IbGAEyyUPHtDyq5Khe+n1Cp
 oPhvNuTBs4WNuAZcrJJr1zhLIChA/nXNdQbaJ2AlCK+V6VvDwmd4y8evpaT8Z6o/
 nvkm9BjXzE87pb9NeJLg1w3pd9Pt00x07og5h8v/iWerKsPxEtsdNNBrBluPhBTw
 RSN57E7jASsDMdvgwd6WhRjL4IA3N1AhjPNC3Up4Ufq0q0g2R1/ANAg5JhZvj7BA
 PtvpHw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kybg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:18:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4Iwsc016992;
 Fri, 13 Sep 2024 04:18:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kybfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:18:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D0nH19003130;
 Fri, 13 Sep 2024 04:18:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15uc163-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:18:57 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4IvQF18350756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:18:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 141EF58045;
 Fri, 13 Sep 2024 04:18:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2146458054;
 Fri, 13 Sep 2024 04:18:55 +0000 (GMT)
Received: from [9.124.214.206] (unknown [9.124.214.206])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:18:54 +0000 (GMT)
Message-ID: <85f6863b-ea74-4a4f-b8ab-1c5fb9b90d45@linux.ibm.com>
Date: Fri, 13 Sep 2024 09:48:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] target/ppc: optimize p9 exception handling
 routines for lpcr
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, danielhb413@gmail.com
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-6-harshpb@linux.ibm.com>
 <D2GL49UTJNSH.6R2M0BOU01I8@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <D2GL49UTJNSH.6R2M0BOU01I8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TVugZB8vRon-OwteDp4Du6v4sIFyweP4
X-Proofpoint-ORIG-GUID: tu7IkOr3eUy998FMNWl7fXG1F8ST6TCA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=928 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi Nick,

On 7/4/24 13:13, Nicholas Piggin wrote:
> On Thu May 23, 2024 at 3:14 PM AEST, Harsh Prateek Bora wrote:
>> Like pending_interrupts, env->spr[SPR_LPCR] is being used at multiple
>> places across p9 exception handlers. Pass the value during entry and
>> avoid multiple indirect accesses.
> 
> Ditto for this (does it help code, other CPU functions should
> be converted similarly).

Thanks for your review comments and apologies for a late response.
I have posted v3 with suggested updates and some additional patches.
Patch 7/7 of this series had been picked by Aditya and updated in his
patchset for P11 support so I have excluded that in v3 and just rebased
on top of his v6 series.

v3: 
https://lore.kernel.org/qemu-devel/20240913041337.912876-1-harshpb@linux.ibm.com/T/#t

regards,
Harsh
> 
> Thanks,
> Nick
> 
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   target/ppc/excp_helper.c | 33 ++++++++++++++++++---------------
>>   1 file changed, 18 insertions(+), 15 deletions(-)
>>
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 704eddac63..d3db81e6ae 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -1843,13 +1843,14 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
>>        PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
>>   
>>   static int p9_interrupt_powersave(CPUPPCState *env,
>> -                                  uint32_t pending_interrupts)
>> +                                  uint32_t pending_interrupts,
>> +                                  target_ulong lpcr)
>>   {
>>   
>>       /* External Exception */
>>       if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
>> -        (env->spr[SPR_LPCR] & LPCR_EEE)) {
>> -        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
>> +        (lpcr & LPCR_EEE)) {
>> +        bool heic = !!(lpcr & LPCR_HEIC);
>>           if (!heic || !FIELD_EX64_HV(env->msr) ||
>>               FIELD_EX64(env->msr, MSR, PR)) {
>>               return PPC_INTERRUPT_EXT;
>> @@ -1857,11 +1858,11 @@ static int p9_interrupt_powersave(CPUPPCState *env,
>>       }
>>       /* Decrementer Exception */
>>       if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
>> -        (env->spr[SPR_LPCR] & LPCR_DEE)) {
>> +        (lpcr & LPCR_DEE)) {
>>           return PPC_INTERRUPT_DECR;
>>       }
>>       /* Machine Check or Hypervisor Maintenance Exception */
>> -    if (env->spr[SPR_LPCR] & LPCR_OEE) {
>> +    if (lpcr & LPCR_OEE) {
>>           if (pending_interrupts & PPC_INTERRUPT_MCK) {
>>               return PPC_INTERRUPT_MCK;
>>           }
>> @@ -1871,17 +1872,17 @@ static int p9_interrupt_powersave(CPUPPCState *env,
>>       }
>>       /* Privileged Doorbell Exception */
>>       if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
>> -        (env->spr[SPR_LPCR] & LPCR_PDEE)) {
>> +        (lpcr & LPCR_PDEE)) {
>>           return PPC_INTERRUPT_DOORBELL;
>>       }
>>       /* Hypervisor Doorbell Exception */
>>       if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
>> -        (env->spr[SPR_LPCR] & LPCR_HDEE)) {
>> +        (lpcr & LPCR_HDEE)) {
>>           return PPC_INTERRUPT_HDOORBELL;
>>       }
>>       /* Hypervisor virtualization exception */
>>       if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
>> -        (env->spr[SPR_LPCR] & LPCR_HVEE)) {
>> +        (lpcr & LPCR_HVEE)) {
>>           return PPC_INTERRUPT_HVIRT;
>>       }
>>       if (pending_interrupts & PPC_INTERRUPT_RESET) {
>> @@ -1891,7 +1892,8 @@ static int p9_interrupt_powersave(CPUPPCState *env,
>>   }
>>   
>>   static int p9_next_unmasked_interrupt(CPUPPCState *env,
>> -                                      uint32_t pending_interrupts)
>> +                                      uint32_t pending_interrupts,
>> +                                      target_ulong lpcr)
>>   {
>>       CPUState *cs = env_cpu(env);
>>   
>> @@ -1906,7 +1908,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
>>                * When PSSCR[EC] is set, LPCR[PECE] controls which interrupts can
>>                * wakeup the processor
>>                */
>> -            return p9_interrupt_powersave(env, pending_interrupts);
>> +            return p9_interrupt_powersave(env, pending_interrupts, lpcr);
>>           } else {
>>               /*
>>                * When it's clear, any system-caused exception exits power-saving
>> @@ -1924,7 +1926,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
>>       /* Hypervisor decrementer exception */
>>       if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>>           /* LPCR will be clear when not supported so this will work */
>> -        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
>> +        bool hdice = !!(lpcr & LPCR_HDICE);
>>           if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
>>               /* HDEC clears on delivery */
>>               return PPC_INTERRUPT_HDECR;
>> @@ -1934,7 +1936,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
>>       /* Hypervisor virtualization interrupt */
>>       if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>>           /* LPCR will be clear when not supported so this will work */
>> -        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
>> +        bool hvice = !!(lpcr & LPCR_HVICE);
>>           if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
>>               return PPC_INTERRUPT_HVIRT;
>>           }
>> @@ -1942,8 +1944,8 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
>>   
>>       /* External interrupt can ignore MSR:EE under some circumstances */
>>       if (pending_interrupts & PPC_INTERRUPT_EXT) {
>> -        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
>> -        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
>> +        bool lpes0 = !!(lpcr & LPCR_LPES0);
>> +        bool heic = !!(lpcr & LPCR_HEIC);
>>           /* HEIC blocks delivery to the hypervisor */
>>           if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
>>               !FIELD_EX64(env->msr, MSR, PR))) ||
>> @@ -1992,7 +1994,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>>           return p8_next_unmasked_interrupt(env);
>>       case POWERPC_EXCP_POWER9:
>>       case POWERPC_EXCP_POWER10:
>> -        return p9_next_unmasked_interrupt(env, env->pending_interrupts);
>> +        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
>> +                                          env->spr[SPR_LPCR]);
>>       default:
>>           break;
>>       }
> 

