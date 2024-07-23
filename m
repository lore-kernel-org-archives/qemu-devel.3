Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92784C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8In-0000tK-De; Tue, 23 Jul 2024 01:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW8Ij-0000sQ-MT; Tue, 23 Jul 2024 01:43:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW8Ih-000664-4C; Tue, 23 Jul 2024 01:43:05 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N5RJvm023231;
 Tue, 23 Jul 2024 05:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
 4j+UDxVeoBtxNh4WE2yyVn12DFxpXjR2B3+LHYQlB0=; b=GNK2cGtprnMCyLy3r
 teIFu21brvTQu+nwhC9hntrf37Fmowtlc+s13IfCgeCn01hQbc0AM8O5ZfzGvMYW
 Kl8UH2AFJnsyfnOM3xKeNjk8cJYRkiNjKCrZWxqsVrJAxWfWsDU39lzgVvE+ubim
 beSFJhbUOn3bZuXyXvS1bfgtb3SOlDBMlEbAwOVS34oGS8mpbpALs7y7rh98Kw1g
 WQq1/73VEvnyKrzIDKCW9phOKvGKzU+Ktsc9Fp7t45lNJ3Apai5Oyp9ahH4XjEJ+
 qjssxRFhpX3Dna4qxE/NqmmBUrmX79BpEWvLbs435Wq5xvfZppPOWYBc2jPUZR/i
 bb7Hg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j53385k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:42:52 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N5gqD6012920;
 Tue, 23 Jul 2024 05:42:52 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j53385k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:42:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46N4pFW3007087; Tue, 23 Jul 2024 05:42:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72h17n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:42:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46N5gjQO18874866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 05:42:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B73432005A;
 Tue, 23 Jul 2024 05:42:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1EB52004D;
 Tue, 23 Jul 2024 05:42:43 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2024 05:42:43 +0000 (GMT)
Message-ID: <626b1b13-6b35-417a-8625-9564d269f719@linux.ibm.com>
Date: Tue, 23 Jul 2024 11:12:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] target/ppc: Introduce
 'PowerPCCPUClass::logical_pvr'
To: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-5-adityag@linux.ibm.com>
 <D2WNU7STYWG0.326OR9H3OWQHK@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D2WNU7STYWG0.326OR9H3OWQHK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AFx-szpBSe-DFwnUO0UVaoReEwm9-y1g
X-Proofpoint-GUID: H3q6GVvdj3T0gu-iN6DnI-LxuNhrae8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407230038
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 23/07/24 10:43, Nicholas Piggin wrote:
> On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
>> Introduce 'PnvChipClass::logical_pvr' to know corresponding logical PVR
>> of a PowerPC CPU.
>> This helps to have a one-to-one mapping between PVR and logical PVR for
>> a CPU, and used in a later commit to handle cases where PCR of two
>> generations of Power chip is same, which causes regressions with compat-mode.
>> Cc: Cédric Le Goater <clg@kaod.org>
>> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   target/ppc/cpu.h      | 1 +
>>   target/ppc/cpu_init.c | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 2015e603d4e0..ff43e3645228 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1504,6 +1504,7 @@ struct PowerPCCPUClass {
>>       void (*parent_parse_features)(const char *type, char *str, Error **errp);
>>   
>>       uint32_t pvr;
>> +    uint32_t logical_pvr;
>>       /*
>>        * If @best is false, match if pcc is in the family of pvr
>>        * Else match only if pcc is the best match for pvr in this family.
> I suppose so. pvr_match() is for hardware PVR, not logical. It's all
> quite a maze.
>
> I'll get you to re-post the series with paches 4-5 reordered ahead
> of the power11 addition, so you can do the renaming and tweaking :)
> Maybe call this 'spapr_logical_pvr' so it's clearly separate from the
> other pvr matching.

Sure, I am reading your reviews about the renaming. Will do them, should 
send next version by today.

Thanks for all reviews !


- Aditya Gupta

>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 9aa098935d05..50f136cca7f0 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -6152,6 +6152,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
>>   
>>       dc->fw_name = "PowerPC,POWER7";
>>       dc->desc = "POWER7";
>> +    pcc->logical_pvr = CPU_POWERPC_LOGICAL_2_06_PLUS;
>>       pcc->pvr_match = ppc_pvr_match_power7;
>>       pcc->pcr_mask = PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
>>       pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
>> @@ -6315,6 +6316,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>>   
>>       dc->fw_name = "PowerPC,POWER8";
>>       dc->desc = "POWER8";
>> +    pcc->logical_pvr = CPU_POWERPC_LOGICAL_2_07;
>>       pcc->pvr_match = ppc_pvr_match_power8;
>>       pcc->pcr_mask = PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
>>       pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
>> @@ -6508,6 +6510,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>>   
>>       dc->fw_name = "PowerPC,POWER9";
>>       dc->desc = "POWER9";
>> +    pcc->logical_pvr = CPU_POWERPC_LOGICAL_3_00;
>>       pcc->pvr_match = ppc_pvr_match_power9;
>>       pcc->pcr_mask = POWERPC_POWER9_PCC_PCR_MASK;
>>       pcc->pcr_supported = POWERPC_POWER9_PCC_PCR_SUPPORTED;
>> @@ -6642,6 +6645,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
>>   
>>       dc->fw_name = "PowerPC,POWER10";
>>       dc->desc = "POWER10";
>> +    pcc->logical_pvr = CPU_POWERPC_LOGICAL_3_10;
>>       pcc->pvr_match = ppc_pvr_match_power10;
>>       pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
>>       pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;
>> @@ -6696,6 +6700,7 @@ POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
>>   
>>       dc->fw_name = "PowerPC,POWER11";
>>       dc->desc = "POWER11";
>> +    pcc->logical_pvr = CPU_POWERPC_LOGICAL_3_10_PLUS;
>>       pcc->pvr_match = ppc_pvr_match_power11;
>>       pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
>>       pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;

