Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732B0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYV1-0000Ye-FY; Tue, 29 Sep 2026 10:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBYUz-0000Xy-Fu; Tue, 29 Sep 2026 10:08:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBYUx-0007rK-TI; Tue, 29 Sep 2026 10:08:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5TNr4017549; Tue, 29 Sep 2026 14:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Yg5+sh
 2UoS9GehTkwzYFbfeWWiledZkGzoxsVBLgvws=; b=H2+SAi5Ot7aIhl00fEZGFQ
 3I+MuChMPjvE1bjePcucUTVHprVCNZMuUvo8OPLLV+vbSiH4jkJe4D6veYEMRGmT
 RQ88QufSdZOK6oVpGwzqlthErGGgxFauvy/uDuu9J5ZNrbiSKq48rRGrPxpS2zfl
 YDCGBNRzyMY6FraZj09z0wyXSl8rh1gK7MEVbMoXHe2+UKdwXU0hkk+acE6FRI9J
 +ce2AIAz0v0Qb62zd9W5g2KgSfuwmRnHPgz0OjWqlsPkHslrVOpaWitd45bHvRx1
 7+zFU1CSKedZpvP1wAjipcdwopFClqgHmKJrcjVHlHyC3KFetJ2zwdVSdH/ymJEg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt6p2m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 14:07:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAm0xs1647480; Tue, 29 Sep 2026 14:07:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y9t3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 14:07:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TE7rWo28705452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 14:07:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8951D5803F;
 Tue, 29 Sep 2026 14:07:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E77B58054;
 Tue, 29 Sep 2026 14:07:52 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 14:07:52 +0000 (GMT)
Message-ID: <b55ab15b-588c-4466-bbfe-f8ee7a31cf01@linux.ibm.com>
Date: Tue, 29 Sep 2026 10:07:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390x/pci: Use qemu_log_mask() for guest-triggered
 errors in reg_ioat()
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
 <20260928202325.309353-3-mjrosato@linux.ibm.com>
 <f9255bb1-3193-4b7f-a2ae-13610a0fc014@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <f9255bb1-3193-4b7f-a2ae-13610a0fc014@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wfWZvtEpp-ZzcX-Yxkvy4v5fd7q52eyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NiBTYWx0ZWRfXw5lUFGHK+bae
 95QwbLQ2Kpv2lkZuIpB0zGuTWBtV+qhLLsbOVJlOAM9QOy5gGQFsqi/9j9csMaDidPX8XPqeBuH
 7fiHOMprWngeTthRUXAQvgqxU74H1nb/5oiLpsn3hYWVqkF0tgDmqVlMQE8E4ijmMP+ARvaiatG
 AqTAj/yrMYA9iHzO5oqc3lY4dYOcUQNVImBenjl00yV01Kz7iJMLZukqV5lHJeRwYER0jUFoTLC
 PNmzXxwLRiL18kjRebLog2nMCkcNcU5XsgwBWWHQ8yPbY/0Cxk0Rm8893APanb2xFZy+um4GAbL
 VUtD4dPS66y7l7+zc+NRzVGC8BNEEYWKw4jjUedM0Gwf6JMY5ooccsNNVBOdyBH0uTSmZZ6wQUo
 vXYyP1AdhH8NJj0jzyArE3cm+0e0/P2zDQQFEB5wEn34jEBepLPny/cPw/Q0CyN2nVX1UzCD4WB
 +aTxLMlh/NqASyyJ32A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NiBTYWx0ZWRfX9DU03+PtVXxu
 I76VGt+czxI1b39J4zGByUOycoQ3kYfcxXgfqi6sBfRRP7+f1CExi49/CsmUNgMuHL8zOXBN8YD
 OZ8USA7XN+iwpf5iAIoJKMdpVzNb7i8=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbc63b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=_Uow2E4VVDY-kjhPWZMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: wfWZvtEpp-ZzcX-Yxkvy4v5fd7q52eyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290056
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/29/26 8:22 AM, Christian Borntraeger wrote:
> 
> 
> Am 28.09.26 um 22:23 schrieb Matthew Rosato:
>> The error paths in reg_ioat() that are triggered by a guest providing
>> invalid MPCIFC arguments use error_report(), which writes unconditionally
>> to stderr.  A misbehaving guest can exploit this to flood the host log
>> by repeatedly issuing the instruction with bad arguments.
>>
>> Replace these with qemu_log_mask(LOG_GUEST_ERROR, ...) so that the
>> messages are suppressible.
>>
>> Fixes: 863f6f52b713 ("s390: implement pci instructions")
>> Fixes: dfcee1ea4c52 ("s390x/pci: add support for guests that request
>> direct mapping")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index a51543df44..c6da3b4c07 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -17,6 +17,7 @@
>>   #include "system/memory.h"
>>   #include z
> 
> can we drop that now?

Looks like yes, will drop

> 
>>   #include "qemu/bswap.h"
>> +#include "qemu/log.h"
>>   #include "system/hw_accel.h"
>>   #include "hw/core/boards.h"
>>   #include "hw/pci/pci_device.h"
>> @@ -1044,11 +1045,12 @@ static int reg_ioat(CPUS390XState *env,
>> S390PCIBusDevice *pbdev, ZpciFib fib,
>>         /* currently we only support designation type 1 with
>> translation */
>>       if (t && dt != ZPCI_IOTA_RTTO) {
>> -        error_report("unsupported ioat dt %d t %d", dt, t);
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "unsupported ioat dt %d t %d", dt, t);
>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>           return -EINVAL;
>>       } else if (!t && !pbdev->rtr_avail) {
>> -        error_report("relaxed translation not allowed");
>> +        qemu_log_mask(LOG_GUEST_ERROR, "relaxed translation not
>> allowed");
> 
> I think we need "\n" here. error_report does add it, qemu_log_mask not.
>

ACK, just verified - will fix here and in patch 3.
 
> 
>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>           return -EINVAL;
>>       }
> 


