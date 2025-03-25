Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B6AC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7fE-0001R5-Qv; Tue, 25 Mar 2025 13:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7f8-0001Pn-Sv; Tue, 25 Mar 2025 13:02:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx7f7-0005wT-4y; Tue, 25 Mar 2025 13:02:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P9SBc3023743;
 Tue, 25 Mar 2025 17:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LQjDZB
 KoX0DLqMB6KBdO7jcnjcITSW9rweRHyR6Bn0Y=; b=GkMBOYTwIyJHaVLXkKIn5o
 IToDD3d4kATEUovJS/KRhXPs/tE0Q8LMLCv9l0/xaVkstcyyizomt437yFZbkTS/
 Hq4GxjDvOFbv2Rbw1+OLeZEmyTwXHoGdCE1JW54267HmziscDzavBbCpXBQwPDV5
 W2DVh34t+fWgv/rTdtNsc4A+cHBH/VPi8AIr4Be7o1iTfhCXr1pdFiLXlS//pqsa
 caQGhkGlgus7EnRR3y87RoViIBMgkLUWMpRyn75ivajPn2oEm45gVz4mXehlBS+P
 ZcmwLL5Cnm1wi47xVmzWeZ0cZy4uimg/Sgf/vGjFPxPmluDRbX+w8/K9mjPtR5Qw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyw0tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:01:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PGnq4x029570;
 Tue, 25 Mar 2025 17:01:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekyw0tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:01:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PFu6mf025443;
 Tue, 25 Mar 2025 17:01:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x04h99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:01:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PH1ko523396688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 17:01:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B95820067;
 Tue, 25 Mar 2025 17:01:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF4212004D;
 Tue, 25 Mar 2025 17:01:43 +0000 (GMT)
Received: from [9.39.16.55] (unknown [9.39.16.55])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 17:01:43 +0000 (GMT)
Message-ID: <359998f9-f74b-4b7e-8e7e-d3a7febe7b96@linux.ibm.com>
Date: Tue, 25 Mar 2025 22:31:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/10] ppc/pnv: Add HOMER for Power11
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-2-adityag@linux.ibm.com>
 <e5dbb0c2-b2a7-44eb-a5b1-9742c18d69ca@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <e5dbb0c2-b2a7-44eb-a5b1-9742c18d69ca@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rkVuZWO28gwzUk8U1kcK6k6H79qO9ZjI
X-Proofpoint-GUID: J3UunsDLTiKW3uc5GS3o6LqSzZ7yIwIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=780 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Cedric,

Thanks for your reviews.


On 25/03/25 20:04, Cédric Le Goater wrote:
> On 3/25/25 12:23, Aditya Gupta wrote:
>> <...snip...>
>>
>> @@ -238,6 +238,13 @@ static const TypeInfo 
>> pnv_homer_power10_type_info = {
>>       .parent        = TYPE_PNV_HOMER,
>>       .instance_size = sizeof(PnvHomer),
>>       .class_init    = pnv_homer_power10_class_init,
>> +    .class_base_init = pnv_homer_power10_class_init,
>
> I didn't see that previously.
>
> Why are you introducing new types for P11 if they are the same as
> P10 ?  Why not use them directly in the P11 chip instance ?
>
Cosmetic reasons only. The behavior is same for those models, p10 & p11, 
just the typenames and description are different.

I can use p10 models instead of declaring these, only difference will be 
that 'info qom-tree' in qemu will show p10 types for those models:


     (qemu) info qom-tree

         /homer (pnv-homer-POWER10)
           /homer-chip0-memory[0] (memory-region)
           /xscom-pba[0] (memory-region)


Will do it in v7 ?


Thanks,

- Aditya G

> C.
>
>> +};
>> +
>> +static const TypeInfo pnv_homer_power11_type_info = {
>> +    .name          = TYPE_PNV11_HOMER,
>> +    .parent        = TYPE_PNV10_HOMER,
>> +    .instance_size = sizeof(PnvHomer),
>>   };
>>     static void pnv_homer_realize(DeviceState *dev, Error **errp)
>> @@ -291,6 +298,7 @@ static void pnv_homer_register_types(void)
>>       type_register_static(&pnv_homer_power8_type_info);
>>       type_register_static(&pnv_homer_power9_type_info);
>>       type_register_static(&pnv_homer_power10_type_info);
>> +    type_register_static(&pnv_homer_power11_type_info);
>>   }
>>     type_init(pnv_homer_register_types);
>> diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
>> index a6f2710fa16b..ab7b43f4c910 100644
>> --- a/include/hw/ppc/pnv_homer.h
>> +++ b/include/hw/ppc/pnv_homer.h
>> @@ -35,6 +35,9 @@ DECLARE_INSTANCE_CHECKER(PnvHomer, PNV9_HOMER,
>>   #define TYPE_PNV10_HOMER TYPE_PNV_HOMER "-POWER10"
>>   DECLARE_INSTANCE_CHECKER(PnvHomer, PNV10_HOMER,
>>                            TYPE_PNV10_HOMER)
>> +#define TYPE_PNV11_HOMER TYPE_PNV_HOMER "-POWER11"
>> +DECLARE_INSTANCE_CHECKER(PnvHomer, PNV11_HOMER,
>> +                         TYPE_PNV11_HOMER)
>>     struct PnvHomer {
>>       DeviceState parent;
>

