Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0DBC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoRf-0002aX-7z; Wed, 21 Feb 2024 10:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcoML-0000sX-JP; Wed, 21 Feb 2024 10:18:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcimk-0002Ru-HV; Wed, 21 Feb 2024 04:21:04 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41L8GDjQ004748; Wed, 21 Feb 2024 09:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ldh9yRatQyxc43HtonugSqEvgSZNPYO0MBupbfMxIc4=;
 b=rQf4MGE6gAP540d2Ul6ap3IZB8aeVwcApx9SbErFuhV8Zs6OnTZ6VvJfMXipIFqyeR4e
 4SPgHTlzlewURgs9lTqICouvo+xJCyw8LZOO8qa6qy9PFf5PKyms0v7eTa8ds0Dsjgdl
 bSDFiB268TCLoHc05teqkBoEZ+xojSQgY5qGenNcyCLlzoKVRYFecKa6peguhb1akMW0
 vH7FcPHYChuviU/4Y/Hoogl0/FAZdGXgetUUIvzpAp4e3B1+wL9hCBTqTUnaN2lNLgB+
 RI6IxpludgQgcd41Id1i3ZegZHJ2aNRUnHXQX9sYRst8YGKsLP9UtzCSmuSUqVzUh6dU Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdcy2tduw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:20:51 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41L923d9001751;
 Wed, 21 Feb 2024 09:20:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdcy2tduj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:20:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41L7a2np003611; Wed, 21 Feb 2024 09:20:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tpcwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:20:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41L9Ko8k50397552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 09:20:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2198958065;
 Wed, 21 Feb 2024 09:20:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26D1258067;
 Wed, 21 Feb 2024 09:20:48 +0000 (GMT)
Received: from [9.171.67.90] (unknown [9.171.67.90])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Feb 2024 09:20:47 +0000 (GMT)
Message-ID: <43a57235-3025-4de5-aaad-7657d3024bba@linux.ibm.com>
Date: Wed, 21 Feb 2024 14:50:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] target/ppc: Simplify syscall exception handlers
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <cover.1705614747.git.balaton@eik.bme.hu>
 <62f95b82597580aadc559114992675bee721e887.1705614747.git.balaton@eik.bme.hu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <62f95b82597580aadc559114992675bee721e887.1705614747.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UQpIbG7Ck9kGFOkPTLZv-GAlDtdLv-kY
X-Proofpoint-GUID: DUsHseVB8zaGA7fKZ1Q1RZXmmyy0BVlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=850 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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



On 1/19/24 03:31, BALATON Zoltan wrote:
> After previous changes the hypercall handling in 7xx and 74xx
> exception handlers can be folded into one if statement to simpilfy
> this code. Also add "unlikely" to mark the less freqiently used branch
> for the compiler.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/excp_helper.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 411d67376c..035a9fd968 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -762,26 +762,22 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>       {
>           int lev = env->error_code;
> -
> -        if (lev == 1 && cpu->vhyp) {
> -            dump_hcall(env);
> -        } else {
> -            dump_syscall(env);
> -        }
>           /*
>            * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>            * instruction to communicate with QEMU. The pegasos2 machine
>            * uses VOF and the 7xx CPUs, so although the 7xx don't have
>            * HV mode, we need to keep hypercall support.
>            */
> -        if (lev == 1 && cpu->vhyp) {
> +        if (unlikely(lev == 1 && cpu->vhyp)) {
>               PPCVirtualHypervisorClass *vhc =
>                   PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +            dump_hcall(env);
>               vhc->hypercall(cpu->vhyp, cpu);
>               powerpc_reset_excp_state(cpu);
>               return;
> +        } else {
> +            dump_syscall(env);
>           }
> -
>           break;
>       }
>       case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
> @@ -907,26 +903,22 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>       {
>           int lev = env->error_code;
> -
> -        if (lev == 1 && cpu->vhyp) {
> -            dump_hcall(env);
> -        } else {
> -            dump_syscall(env);
> -        }
>           /*
>            * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>            * instruction to communicate with QEMU. The pegasos2 machine
>            * uses VOF and the 74xx CPUs, so although the 74xx don't have
>            * HV mode, we need to keep hypercall support.
>            */
> -        if (lev == 1 && cpu->vhyp) {
> +        if (unlikely(lev == 1 && cpu->vhyp)) {
>               PPCVirtualHypervisorClass *vhc =
>                   PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +            dump_hcall(env);
>               vhc->hypercall(cpu->vhyp, cpu);
>               powerpc_reset_excp_state(cpu);
>               return;
> +        } else {
> +            dump_syscall(env);
>           }
> -
>           break;
>       }
>       case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */

