Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B52AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQ54-0000ID-Fa; Tue, 05 Mar 2024 03:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rhQ51-0000He-O7; Tue, 05 Mar 2024 03:23:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rhQ50-0005uw-0S; Tue, 05 Mar 2024 03:23:19 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4257qIRT005269; Tue, 5 Mar 2024 08:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ntHM9VA3GbVwcpUr6/gb2RjtSYf4iJK4cnMEUOLbyTA=;
 b=PuvexDhNFt0KVC4QEpSGF3GelT1Cik38puG3QsWhsVfAA/892pdNO8zJ46S9ld6v2mpe
 QH5BrZlmhrkEh7bCo9kTSh0mb2dUpUuJXrE46XXV/EWmQHEXeZovl0XHVeWvSZjuJMcC
 /3bl094Qf2ygDMSOSBB+MeFzxMFuEcEBlb0pw1XdhgLdr2szlY5eTwaWFz0Z7YbqyUWG
 iGokgVEuvEiBQMjyGhlMXyQmTBDfWu/g7rjYArrY1SdhIkywo2LHNw84KnBBiMk1RsN2
 ABAGUSVeOtxrpbrCPq9q0zCSTr5eAQ1+qYfJeNeDu8ft0xa5mHklQuAK5q2mkyedgWYo LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnycqgvvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:23:12 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4257q56T004881;
 Tue, 5 Mar 2024 08:23:08 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnycqgv5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:23:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4255sSDT010910; Tue, 5 Mar 2024 08:21:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh525rey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:21:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4258LHEw25821868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Mar 2024 08:21:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFDE458043;
 Tue,  5 Mar 2024 08:21:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCE5458055;
 Tue,  5 Mar 2024 08:21:14 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Mar 2024 08:21:14 +0000 (GMT)
Message-ID: <de98bb30-6632-4938-b3c6-964ab867b2ad@linux.ibm.com>
Date: Tue, 5 Mar 2024 13:51:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] spapr: nested: Use correct source for parttbl
 info for nested PAPR API.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-13-harshpb@linux.ibm.com>
 <CZFS7NVV22F1.11DDO9RYBJG5P@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFS7NVV22F1.11DDO9RYBJG5P@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zGoWU4llXJlVQULeWoSHuZ5SxMmPmD5z
X-Proofpoint-GUID: m1x43WSGaIPXXuontPAycvVDLPzT4JL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_05,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Nick,

On 2/27/24 15:46, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
>> For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
>> partition table info, use the same in spapr_get_pate_nested() via
>> helper.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr_nested.h |  4 ++++
>>   hw/ppc/spapr.c                |  2 ++
>>   hw/ppc/spapr_nested.c         | 20 +++++++++++++++++++-
>>   3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 1b7e55f12a..da918d2dd0 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -511,4 +511,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>>   void spapr_nested_init(SpaprMachineState *spapr);
>>   uint8_t spapr_nested_api(SpaprMachineState *spapr);
>>   void spapr_nested_gsb_init(void);
>> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
>> +                                target_ulong lpid, ppc_v3_pate_t *entry);
>> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
>> +                                                     target_ulong lpid);
>>   #endif /* HW_SPAPR_NESTED_H */
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 51a1be027a..3453b30a57 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1379,6 +1379,8 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
>>           assert(spapr_nested_api(spapr));
>>           if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
>>               return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
>> +        } else if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
>> +            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
>>           }
>>           return false;
>>       }
> 
> BTW. I would change these asserts to } else { g_assert_not_reached(); }

Sure, updating as suggested.

> 
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index aba4b25da6..0edb362709 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -52,6 +52,19 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>>       return true;
>>   }
>>   
>> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
>> +                                target_ulong lpid, ppc_v3_pate_t *entry)
>> +{
>> +    SpaprMachineStateNestedGuest *guest;
>> +    assert(lpid != 0);
>> +    guest = spapr_get_nested_guest(spapr, lpid);
>> +    assert(guest != NULL);
>> +
>> +    entry->dw0 = guest->parttbl[0];
>> +    entry->dw1 = guest->parttbl[1];
>> +    return true;
>> +}
> 
> Asserts should not need to be changed to proper error handling, right?

Hmm, changing !guest check to return false as more appropriate.
lpid check shall remain an assert.

regards,
Harsh

> 
> Thanks,
> Nick

