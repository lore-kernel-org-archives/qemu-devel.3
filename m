Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BA2C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reu25-0004qp-WA; Tue, 27 Feb 2024 04:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1reu1e-0004kU-2s; Tue, 27 Feb 2024 04:45:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1reu1b-0001wX-8z; Tue, 27 Feb 2024 04:45:25 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41R8WPx2029812; Tue, 27 Feb 2024 09:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=O75TRh+3aJ70WOHYcPDX1cgbLfzW+4elD/hKyzT+R9g=;
 b=jK3wRuAlrqhHzG6+uTge87wIQvMpMZrOqE+IkHxwJ26cZ38tm5DFQvreq9gu1YhKNdN/
 KXilZraOOZAzID/Z6BUD4IxUF4zdnvBp55C2ff/s5nwG+yjdT1o67Z+NImpgVLaRpxe/
 fESMCgs1j/S5u+2Bwtm4E2WVNvGFvkIMJdGBvU8BV5eUIeK0PyaCS3qsaR0zG41hpKSl
 LQ95XAA4qYQuStbvtmkKJVjF8/r3rvqzJp7IKPatWPukEopiZADIAxdf4PQNhJr2oZHY
 L0M7SRLmuu8fgCL8eI+FeMPiSMTvrg4gqJebrr3BfnyZ3/BAcxzHFqP3omxIcQfBeX80 aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whcaej070-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 09:45:18 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41R9RBeX007085;
 Tue, 27 Feb 2024 09:45:18 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whcaej06j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 09:45:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41R95TE7008782; Tue, 27 Feb 2024 09:45:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstf4eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 09:45:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41R9jEDw44564758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 09:45:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2BEC58065;
 Tue, 27 Feb 2024 09:45:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD51458055;
 Tue, 27 Feb 2024 09:45:09 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Feb 2024 09:45:09 +0000 (GMT)
Message-ID: <992d980a-da74-4c61-843b-888facc5f813@linux.ibm.com>
Date: Tue, 27 Feb 2024 15:15:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] spapr: nested: keep nested-hv related code
 restricted to its API.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-5-harshpb@linux.ibm.com>
 <CZFQHBO2FUX6.30O1PDW79JW97@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFQHBO2FUX6.30O1PDW79JW97@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: huQHEsq6_Ibs1GjX3wlCeGdmYCnxm-2W
X-Proofpoint-GUID: SHjLNlHFjyohfcM9j66CMPWRAp1V0TM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2/27/24 14:24, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:35 PM AEST, Harsh Prateek Bora wrote:
>> spapr_exit_nested and spapr_get_pate_nested_hv contains code which
>> is specific to nested-hv API. Isolating code flows based on API
>> helps extending it to be used with different API as well.
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   include/hw/ppc/spapr_nested.h |  4 ++++
>>   hw/ppc/spapr.c                |  7 ++++++-
>>   hw/ppc/spapr_caps.c           |  1 +
>>   hw/ppc/spapr_nested.c         | 27 ++++++++++++++++++++++++---
>>   4 files changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 2488ea98da..3f07c81c3d 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -5,6 +5,8 @@
>>   
>>   typedef struct SpaprMachineStateNested {
>>       uint64_t ptcr;
>> +    uint8_t api;
>> +#define NESTED_API_KVM_HV  1
>>   } SpaprMachineStateNested;
>>   
>>   /*
>> @@ -103,4 +105,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
>>   typedef struct SpaprMachineState SpaprMachineState;
>>   bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>>                                 target_ulong lpid, ppc_v3_pate_t *entry);
>> +void spapr_nested_init(SpaprMachineState *spapr);
>> +uint8_t spapr_nested_api(SpaprMachineState *spapr);
>>   #endif /* HW_SPAPR_NESTED_H */
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 97b69c0e42..51a1be027a 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1376,7 +1376,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
>>           entry->dw1 = spapr->patb_entry;
>>           return true;
>>       } else {
>> -        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
>> +        assert(spapr_nested_api(spapr));
>> +        if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
>> +            return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
>> +        }
>> +        return false;
>>       }
>>   }
>>   
>> @@ -3443,6 +3447,7 @@ static void spapr_instance_init(Object *obj)
>>           spapr_get_host_serial, spapr_set_host_serial);
>>       object_property_set_description(obj, "host-serial",
>>           "Host serial number to advertise in guest device tree");
>> +    spapr_nested_init(spapr);
> 
> I would maybe make this init a reset instead, and then it could do
> the hypercall unregistering as well? You could rework that part of
> it into patch 1 (or reorder the patches).

If we do unregistering here, we still hit the assert during
spapr_machine_reset which tries to reapply the caps and thus re-register
hcalls. Also, We cant register hcalls in this since the caps havent been
applied when init is called here. So we can do as you have previously
suggested, reset in spapr_machine_reset based on caps applied.
Let me know if you think otherwise?

regards,
Harsh


> 
> Thanks,
> Nick

