Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6C6D148AE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdjUq-000230-6w; Thu, 08 Jan 2026 01:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vdjUm-00022U-Jc
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:27:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vdjUj-0007qT-Gw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:27:43 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6084vUVQ022903;
 Thu, 8 Jan 2026 06:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=D918+9
 dHl/jdiL27rhgTxqhbe6Pl0LZi4nm9XtmjCSY=; b=h27HH0trTWgfZdOOtBAveC
 xzHjWjXZHV8FvrkaxxXg9KRXZBFOYy1aIaT0GvuTWibVmQybcT3ISH4pDPVBdVuY
 YW0gsrj4ysKfzW/hElPWRyn7oIq2BpRJ5PHAEFMtdbacA+K3TVGIJhwxDgthqQ8D
 glQ27xT++BEqGYj2mSRgH65By5+ygoQHHWmwVZ0BB3m0lt/VjGJRcsMsaLGPDBCX
 4BQa+wfmaLgja9lvpZs8A1Rv2ebF5dNIozXw0Z7kV3pBZXqHrsInge0bZIO1udKl
 IHu7iJdnN9zY8n8FFqvhVKemLRdcCj2cNNHTuB6/ECeMYcGGiXdpc38ZvArxyDZA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm7cuxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 06:27:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6086R6Nk011760;
 Thu, 8 Jan 2026 06:27:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm7cuxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 06:27:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6085oC1L005223;
 Thu, 8 Jan 2026 06:27:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexkd9dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 06:27:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6086RYpu2884194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Jan 2026 06:27:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7467D58058;
 Thu,  8 Jan 2026 06:27:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD8BE58057;
 Thu,  8 Jan 2026 06:27:31 +0000 (GMT)
Received: from [9.43.31.244] (unknown [9.43.31.244])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Jan 2026 06:27:31 +0000 (GMT)
Message-ID: <31a61dff-d30d-4c93-8fc1-391c99d32b42@linux.ibm.com>
Date: Thu, 8 Jan 2026 11:57:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/ppc: Fix env->quiesced migration
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, peterx@redhat.com, Fabian Vogt <fvogt@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, gautam@linux.ibm.com
References: <20251217164549.4311-1-farosas@suse.de>
 <20251217164549.4311-2-farosas@suse.de>
 <7c64764f-5f38-435f-a68d-a935891da864@linux.ibm.com>
In-Reply-To: <7c64764f-5f38-435f-a68d-a935891da864@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=695f4e59 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Osv9wCl-WL29zXqnJdgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AnO3hUJZQtCApDC2wexebPZeYllWg1LD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAzOSBTYWx0ZWRfX6Osl6TY7wuyU
 1kuXtLXg22+mrl06vMMalZQH1m74sE124WM47w6doOU5pH9RPOSpQ+ObX9XcI9qaLEieOIcDcsW
 6aaUOBaSmSCnW6IFkJ+kgHXcMDxE/+Yo2X4mZ3BvMrarUOPDdvqGymMTHmGXUinsg2St3tj5W9Z
 nQmLDD9uXeHPZgYOXfRjz7QfCS1zo1QprQfksf69mgTg/4GRttQKNs9UWpQsgC6L/92eRVrFaBS
 9wktnFtmWIJAOi2zs/++FMRsg2RA8II4hIj15IKKuYnH+B9Pfm/+6G9hCu1tRVQDP4ltkkzCpV5
 gxEWlnrRaHYKcS+S8rMsUddC+XGLGuPQW0FKkF9dZXRgdK7lbhFCQ2ZI0L5OtsZ1kAbO4PhAloE
 LGTHeR9NKrC4zKAG/t1NjbSFswWMy0wYl6ROLq7spBt7+Uvg03awof1V4D17PlFNaL9itW3BbWM
 Luch7fW2SPVp4iQFMLw==
X-Proofpoint-ORIG-GUID: 3YDjCMsAGYmsyfBjQ6Fc14SBKktYZTIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601080039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

One minor comment below:

<snip>

On 05/01/26 2:30 pm, Harsh Prateek Bora wrote:
>> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
>> index d72e5ecb94..ba63a7debb 100644
>> --- a/target/ppc/machine.c
>> +++ b/target/ppc/machine.c
>> @@ -6,6 +6,7 @@
>>   #include "mmu-hash64.h"
>>   #include "migration/cpu.h"
>>   #include "qapi/error.h"
>> +#include "qemu/error-report.h"

I do not see any error reporting being added in the patch below.
Does this header inclusion need to be removed ?

regards,
Harsh

>>   #include "kvm_ppc.h"
>>   #include "power8-pmu.h"
>>   #include "system/replay.h"
>> @@ -257,6 +258,45 @@ static int cpu_post_load(void *opaque, int 
>> version_id)
>>           ppc_store_sdr1(env, env->spr[SPR_SDR1]);
>>       }
>> +    if (!cpu->rtas_stopped_state) {
>> +        /*
>> +         * The source QEMU doesn't have fb802acdc8 and still uses halt +
>> +         * PM bits in LPCR to implement RTAS stopped state. The new 
>> (this)
>> +         * QEMU will have put the secondary vcpus in stopped state,
>> +         * waiting for the start-cpu RTAS call. That call will never 
>> come
>> +         * if the source cpus were already running. Try to infer the 
>> cpus
>> +         * state and set env->quiesced accordingly.
>> +         *
>> +         * env->quiesced = true  ==> the cpu is waiting to start
>> +         * env->quiesced = false ==> the cpu is running (unless halted)
>> +         */
>> +
>> +        /*
>> +         * Halted _could_ mean quiesced, but it could also be cede,
>> +         * confer_self, power management, etc.
>> +         */
>> +        if (CPU(cpu)->halted) {
>> +            PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>> +            /*
>> +             * Both the PSSCR_EC bit and LPCR PM bits set at cpu reset
>> +             * and rtas_stop and cleared at rtas_start, it's a good
>> +             * heuristic.
>> +             */
>> +            if ((env->spr[SPR_PSSCR] & PSSCR_EC) &&
>> +                (env->spr[SPR_LPCR] & pcc->lpcr_pm)) {
>> +                env->quiesced = true;
>> +            } else {
>> +                env->quiesced = false;
>> +            }
>> +        } else {
>> +            /*
>> +             * Old QEMU sets halted during rtas_stop_self. Not halted,
>> +             * therefore definitely not quiesced.
>> +             */
>> +            env->quiesced = false;
>> +        }
>> +    }
>> +
>>       post_load_update_msr(env);
>>       if (tcg_enabled()) {
>> @@ -649,6 +689,28 @@ static const VMStateDescription 
>> vmstate_reservation = {
>>       }
>>   };
>> +static bool rtas_stopped_needed(void *opaque)
>> +{
>> +    PowerPCCPU *cpu = opaque;
>> +
>> +    return cpu->rtas_stopped_state;
>> +}
>> +
>> +static const VMStateDescription vmstate_rtas_stopped = {
>> +    .name = "cpu/rtas_stopped",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = rtas_stopped_needed,
>> +    .fields = (const VMStateField[]) {
>> +        /*
>> +         * "RTAS stopped" state, independent of halted state. For QEMU
>> +         * < 10.0, this is taken from cpu->halted at cpu_post_load()
>> +         */
>> +        VMSTATE_BOOL(env.quiesced, PowerPCCPU),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   #ifdef TARGET_PPC64
>>   static bool bhrb_needed(void *opaque)
>>   {
>> @@ -715,6 +777,7 @@ const VMStateDescription vmstate_ppc_cpu = {
>>           &vmstate_tlbmas,
>>           &vmstate_compat,
>>           &vmstate_reservation,
>> +        &vmstate_rtas_stopped,
>>           NULL
>>       }
>>   };
> 


