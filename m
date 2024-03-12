Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CF7C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjy5y-0004gO-5A; Tue, 12 Mar 2024 05:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjy5n-0004fi-AS; Tue, 12 Mar 2024 05:06:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rjy5l-0008PU-Cf; Tue, 12 Mar 2024 05:06:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C8WoDu003672; Tue, 12 Mar 2024 09:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iyZdgENo+MzeChYfW62BYgBOUa+9ixXK4d5CikQHVK8=;
 b=ldB6MTEKEbhhfZjoMNovy2x47ZU+3MnhXlMeWe0DMjxtXLd8JbcWnr6Uve9afj5hIEmQ
 9/Gjgvx6Fi7HOgcmgz++mgYUSIbPd0Lupd4rtGGiGO/w9WMBY5siVMFVPtHvPzbyCtJq
 c6n2hZY7/r5e/lP8lZbDcjX+EzXH+0Y1b4nwZ7LayJfY4wQD7TNaag2CnjVaZJoYymaG
 noBU3hAUZBaEzTwflqo/kc0ZlOxtvUXlhTECl0l156WRyXHxDPRYBEDefYzya6BmJqgN
 7YoOajdRq6zfbhNRbcorWugo8OTpx1VQUU/wD7kwSqMK7UnZJ3FnwO0FEMoKkDo5lbP2 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtkmsgdru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:06:28 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C8fwxV025092;
 Tue, 12 Mar 2024 09:06:28 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtkmsgdrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:06:28 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C7sfsl018557; Tue, 12 Mar 2024 09:06:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t1wj91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:06:27 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C96PIR32834038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 09:06:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C71775806A;
 Tue, 12 Mar 2024 09:06:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F05DF5807F;
 Tue, 12 Mar 2024 09:06:21 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 09:06:21 +0000 (GMT)
Message-ID: <7fd9a5be-b998-4a58-a98d-da587a9f7fa8@linux.ibm.com>
Date: Tue, 12 Mar 2024 14:36:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ppc: Drop support for POWER9 and POWER10 DD1 chips
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-2-npiggin@gmail.com>
 <5f8b269f-1f43-42ab-b4bf-d0314b739493@linux.ibm.com>
 <d1b34bf3-e9b7-48e6-9e46-ec396068b888@linux.ibm.com>
 <CZRNC9YHEMML.VNDNEAS6FEG2@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZRNC9YHEMML.VNDNEAS6FEG2@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XMBnScB14I6kYLI_GKVoQzMFaE33KxPW
X-Proofpoint-GUID: 7p4Iycbt0cvMXo_QD4TTLp-2rlPf33Q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=789 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403120070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 3/12/24 14:29, Nicholas Piggin wrote:
> On Tue Mar 12, 2024 at 2:55 PM AEST, Harsh Prateek Bora wrote:
>>
>>
>> On 3/12/24 10:20, Harsh Prateek Bora wrote:
>>>
>>>
>>> On 3/12/24 00:21, Nicholas Piggin wrote:
>>>> The POWER9 DD1 and POWER10 DD1 chips are not public and are no longer of
>>>> any use in QEMU. Remove them.
>>>>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>> ---
>>>>    hw/ppc/spapr_cpu_core.c |  2 --
>>>>    target/ppc/cpu-models.c |  4 ----
>>>>    target/ppc/cpu_init.c   |  7 ++-----
>>>>    target/ppc/kvm.c        | 11 -----------
>>>>    4 files changed, 2 insertions(+), 22 deletions(-)
>>>
>>> Do we want to squash in removal of the macro as well?
>>>
>>
>> <snip>
>> Actually both, correcting diff:
>>
>> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
>> index 0229ef3a9a..7d89b41214 100644
>> --- a/target/ppc/cpu-models.h
>> +++ b/target/ppc/cpu-models.h
>> @@ -348,11 +348,9 @@ enum {
>>        CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
>>        CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
>>        CPU_POWERPC_POWER9_BASE        = 0x004E0000,
>> -    CPU_POWERPC_POWER9_DD1         = 0x004E1100,
>>        CPU_POWERPC_POWER9_DD20        = 0x004E1200,
>>        CPU_POWERPC_POWER9_DD22        = 0x004E1202,
>>        CPU_POWERPC_POWER10_BASE       = 0x00800000,
>> -    CPU_POWERPC_POWER10_DD1        = 0x00801100,
>>        CPU_POWERPC_POWER10_DD20       = 0x00801200,
>>        CPU_POWERPC_970_v22            = 0x00390202,
>>        CPU_POWERPC_970FX_v10          = 0x00391100,
> 
> That would make sense, but we do seem to use this list as somewhat of a
> reference or at least historic graveyard too (note all the other CPUs we
> no longer support). So I was going to just leave them there.

Oh ok, in that case, it's fine.

regards,
Harsh
> 
> Thanks,
> Nick

