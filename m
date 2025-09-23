Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D029CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zap-0003tt-DE; Tue, 23 Sep 2025 05:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v0zaj-0003so-U1; Tue, 23 Sep 2025 05:45:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v0zaZ-0006iu-U1; Tue, 23 Sep 2025 05:45:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MMNVMp009728;
 Tue, 23 Sep 2025 09:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AYRP4G
 r1O3e5jzyqfJgAE2jnEHrOYECUrP3rvHkcLNI=; b=ce7n2fc62LGyQMZeNYYpez
 FfiEtdTsu8yM1VkrUg1g+zMg0fklBaOgbClSrR4to6tF6kmKYxQDSjqvva8noMXP
 cUW9trJ5YMARWNaRf9qRlWicFWtQsfDa+LZZd0MpSNas5xI0DrRcJRCfBcgH4QbC
 gn3qZJYu9cTwVZcR01ULvZYS5lVrodZD2tDpof86tyGc58m9LcyKcV4Oxy6DZRCQ
 5fVhkJjkQ+6yjBl6XPUm05k1KBp+4XbG/bDjLlHES610qPdw7Tmtk0tLrQ7moOB/
 hXX1UgJq/onSJDn7uXEx6WNPgsMHEjgIEz24RStL9kvTaM/rDpKnAOOSgpj447jQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq7y6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 09:45:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58N9eeag001115;
 Tue, 23 Sep 2025 09:45:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq7y68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 09:45:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6Bc4u019671;
 Tue, 23 Sep 2025 09:45:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83k2j3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 09:45:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58N9jUBj38142552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Sep 2025 09:45:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58B8058056;
 Tue, 23 Sep 2025 09:45:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE7B25803F;
 Tue, 23 Sep 2025 09:45:28 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Sep 2025 09:45:28 +0000 (GMT)
Message-ID: <c4bdf58f-324a-485f-8144-96faf5cb515c@linux.ibm.com>
Date: Tue, 23 Sep 2025 15:15:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-7-richard.henderson@linaro.org>
 <5ed7c59b-5e61-4e79-b4e0-a8441ac5b784@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <5ed7c59b-5e61-4e79-b4e0-a8441ac5b784@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d26c3c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=LsL_S21RDTfDaaqpU3cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: oM44NwV4xKIAMQx75qZYvMNOhg2BzEQ_
X-Proofpoint-GUID: SDiIeQ5InkNdymwqctiZNu9FCxDR06dz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfXwqRGXMhNVX0H
 vXjzXVf1P27ae3blyRLayT7EvEkU+4vCl+2KeA65LYMpR4dBmgTIhPdaFSbCeIc/e9+JDG/eAis
 K6Y2vgDOlQm6BzFs2heQukbdxus3FBATaY2N7Uh6VNFG1Vw8JTIgb7GO7UD9RL3vvxWFk+tHtEf
 fMwZAe6CjtoPlXUw5xyHZbaTERhlmr3UId0EIcLUELAXpHQok9rfdWqfHnP7/ty/l2/f1eWzmmY
 cCzxdCstiVoTdRGVUTgvtad5msQOZma73EqbtlZoON/LL2+K2YiHu/06zq2Znw6ECL2Pb5om7S5
 DsN0uePZ6pd5YndweQk15jC0pyAUWBbKXSz4XJOw+grzVLYGUp5g1wqtVW00lNnYNyYBb6HG2O4
 +dE5rVmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/23/25 14:25, Philippe Mathieu-Daudé wrote:
> On 23/9/25 04:39, Richard Henderson wrote:
>> We only need invalidate tbs from a single page, not flush
>> all translations.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: qemu-ppc@nongnu.org
>> ---
>>   hw/ppc/spapr_hcall.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index c594d4b916..feb31d5dd8 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -8,7 +8,7 @@
>>   #include "qemu/main-loop.h"
>>   #include "qemu/module.h"
>>   #include "qemu/error-report.h"
>> -#include "exec/tb-flush.h"
>> +#include "exec/translation-block.h"
>>   #include "exec/target_page.h"
>>   #include "helper_regs.h"
>>   #include "hw/ppc/ppc.h"
>> @@ -301,7 +301,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, 
>> SpaprMachineState *spapr,
>>           if (kvm_enabled()) {
>>               kvmppc_icbi_range(cpu, pdst, len);
>>           } else if (tcg_enabled()) {
>> -            tb_flush(CPU(cpu));
>> +            tb_invalidate_phys_range(CPU(cpu), dst, len);
> 
> Shouldn't this be:
> 
>                 tb_invalidate_phys_range(CPU(cpu), dst, dst + len - 1);
> 
> ?

I think you're right. I overlooked it in my review.

regards,
Harsh

> 
>>           } else {
>>               g_assert_not_reached();
>>           }
> 
> 

