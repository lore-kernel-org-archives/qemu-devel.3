Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21935C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 06:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcfPY-0008TW-Be; Tue, 28 Jan 2025 01:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcfPX-0008TK-IB; Tue, 28 Jan 2025 01:49:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tcfPV-0007bb-NZ; Tue, 28 Jan 2025 01:49:23 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S20jqg006728;
 Tue, 28 Jan 2025 06:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3SM56l
 985Ng2lteGtfVoV7p9EOzLKe48HapXUIYSqFk=; b=kVasngqpcKuZWRHb4UQqPW
 zY3+MXWRNHdvvwy5W/GwLu3aLSCCyP8iRHE2EPnvMYcr3xAsqbKWnPRYgtTjASK0
 quRgu45BdZBt7UDr81Ki6dGALMkKT0WPCitd8UuFhisYSieGiNKvTL2hnUm/zha1
 HhWyZE07dy6Ejc26N241nHUefi4Y0vfW5V9c6fXFJ3/YQuJLkemYC/qkVDciM+d6
 XyPkM/k3Efap6expuk2ZbuFPRlCsGV3+JzLJQoSnFRkHi0tPd9JKs7EDLEKtknJ9
 KsaU2jR6U3fEP01i8K8auLsoaWnM+FN0nlpBSoQmPNftmFxtNHt+O9RBwN04gZKQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ep2ygvwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:49:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S6nJh2016234;
 Tue, 28 Jan 2025 06:49:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ep2ygvwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:49:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S4BV5X012476;
 Tue, 28 Jan 2025 06:49:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dany25jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 06:49:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S6nHlV30737010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 06:49:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD9CF58052;
 Tue, 28 Jan 2025 06:49:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 848F358056;
 Tue, 28 Jan 2025 06:49:15 +0000 (GMT)
Received: from [9.124.214.156] (unknown [9.124.214.156])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 06:49:15 +0000 (GMT)
Message-ID: <083eba50-9f79-4cf4-b5bb-ff9b3eb78322@linux.ibm.com>
Date: Tue, 28 Jan 2025 12:19:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] target/ppc: Ensure powerpc_checkstop() is only
 called under TCG
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-7-philmd@linaro.org>
 <fe541a6b-ab7b-4d61-aad2-2674b1fd3c9b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <fe541a6b-ab7b-4d61-aad2-2674b1fd3c9b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WT3M_xeXyiIKrHlOspnjtD1CP4nDVLWg
X-Proofpoint-GUID: hlq6JkO1Q0-ohiT0JxtJloDHLX_Thk4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=614 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 1/28/25 12:13, Harsh Prateek Bora wrote:
> 
> 
> On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/excp_helper.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 8956466db1d..b08cd53688c 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -19,6 +19,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/main-loop.h"
>>   #include "qemu/log.h"
>> +#include "system/tcg.h"
>>   #include "system/system.h"
>>   #include "system/runstate.h"
>>   #include "cpu.h"
>> @@ -30,7 +31,6 @@
>>   #include "trace.h"
>>   #ifdef CONFIG_TCG
>> -#include "system/tcg.h"
>>   #include "exec/helper-proto.h"
>>   #include "exec/cpu_ldst.h"
>>   #endif
>> @@ -443,13 +443,11 @@ void helper_attn(CPUPPCState *env)
>>   static void powerpc_mcheck_checkstop(CPUPPCState *env)
>>   {
>>       /* KVM guests always have MSR[ME] enabled */
>> -#ifdef CONFIG_TCG
>>       if (FIELD_EX64(env->msr, MSR, ME)) {
>>           return;
>>       }
>> -
>> +    assert(tcg_enabled());
> 
> Shouldn't this be a no-op if not TCG ?
> 
> Nick, please advise ?
> 

Also, patch title needs update - it's powerpc_mcheck_checkstop.

> regards,
> Harsh
>>       powerpc_checkstop(env, "machine check with MSR[ME]=0");
>> -#endif
>>   }
>>   static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
> 

