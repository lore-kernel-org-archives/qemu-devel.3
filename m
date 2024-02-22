Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4182C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5y7-0004T3-6A; Thu, 22 Feb 2024 05:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rd5y5-0004SZ-Ao; Thu, 22 Feb 2024 05:06:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rd5y2-0000da-VW; Thu, 22 Feb 2024 05:06:17 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41M9m2df018071; Thu, 22 Feb 2024 10:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7yCuldceSyJz3Ap78sQDAsienMAXu3g0BfrHBqSf+qs=;
 b=SLInFg9gt4X1Frq7kkpIJEfZbDczP7xvLl9xVhXyHuQvAOKu2KA3HcXel8kb4IkRe1tN
 TJwEbBlzhD4jVJ3n5e4btEi3Wqd8utJDEBdYfMwIT/ZQK4EuY0zlnSJXEcQrJj9vWAtj
 8fEYsszezkfa2ZyMRdDvuK8ihkY+nkm6D5Kzifp36zVQVkzhF26SFOOjqMenSehuf2Q6
 N6VYL4qIYLD8xNoC4W/Wm4kHLymoBgkaSAa2e+opzpnlTqRFi+c4zgV/HnuDt8+eSDnV
 +ncXSki60voLR7zbA+YzAQtoi5JBMwMZrvj6h2/uQgT9r4TCZ6rfS0NtMForDr1ux4jo UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we3y10fkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 10:06:03 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41M9mdbI019300;
 Thu, 22 Feb 2024 10:06:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we3y10fk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 10:06:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41M97Otl009540; Thu, 22 Feb 2024 10:06:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pnbs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 10:06:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41MA606q13304444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 10:06:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08E495806F;
 Thu, 22 Feb 2024 10:06:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D63A5805D;
 Thu, 22 Feb 2024 10:05:58 +0000 (GMT)
Received: from [9.179.15.237] (unknown [9.179.15.237])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Feb 2024 10:05:57 +0000 (GMT)
Message-ID: <b8ea8222-ee3b-4bf9-85b0-636d6a4d6f3a@linux.ibm.com>
Date: Thu, 22 Feb 2024 15:35:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] target/ppc: Remove interrupt handler wrapper
 functions
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <cover.1705614747.git.balaton@eik.bme.hu>
 <281ce504db0192be0673f3525ea59d425bb1e5e0.1705614747.git.balaton@eik.bme.hu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <281ce504db0192be0673f3525ea59d425bb1e5e0.1705614747.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XssZUiIHfmnZ2AWfq6QdfN7HhH7X9mtr
X-Proofpoint-GUID: Sc2u4RgddR_pHhQt1KBQe6iJ8MPL3E-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220078
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
> These wrappers call out to handle POWER7 and newer in separate
> functions but reduce to the generic case when TARGET_PPC64 is not
> defined. It is easy enough to include the switch in the beginning of
> the generic functions to branch out to the specific functions and get
> rid of these wrappers. This avoids one indirection and entitely

s/entitely/entirely

> compiles out the switch without TARGET_PPC64.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   target/ppc/excp_helper.c | 70 ++++++++++++++++++----------------------
>   1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 5124c3e6b5..de51627c4c 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1921,8 +1921,21 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
>   }
>   #endif /* TARGET_PPC64 */
>   
> -static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
> +static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>   {
> +#ifdef TARGET_PPC64
> +    switch (env->excp_model) {
> +    case POWERPC_EXCP_POWER7:
> +        return p7_next_unmasked_interrupt(env);
> +    case POWERPC_EXCP_POWER8:
> +        return p8_next_unmasked_interrupt(env);
> +    case POWERPC_EXCP_POWER9:
> +    case POWERPC_EXCP_POWER10:
> +        return p9_next_unmasked_interrupt(env);
> +    default:
> +        break;
> +    }
> +#endif
>       bool async_deliver;
>   
>       /* External reset */
> @@ -2033,23 +2046,6 @@ static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
>       return 0;
>   }
>   
> -static int ppc_next_unmasked_interrupt(CPUPPCState *env)
> -{
> -    switch (env->excp_model) {
> -#ifdef TARGET_PPC64
> -    case POWERPC_EXCP_POWER7:
> -        return p7_next_unmasked_interrupt(env);
> -    case POWERPC_EXCP_POWER8:
> -        return p8_next_unmasked_interrupt(env);
> -    case POWERPC_EXCP_POWER9:
> -    case POWERPC_EXCP_POWER10:
> -        return p9_next_unmasked_interrupt(env);
> -#endif
> -    default:
> -        return ppc_next_unmasked_interrupt_generic(env);
> -    }
> -}
> -
>   /*
>    * Sets CPU_INTERRUPT_HARD if there is at least one unmasked interrupt to be
>    * delivered and clears CPU_INTERRUPT_HARD otherwise.
> @@ -2279,8 +2275,24 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
>   }
>   #endif /* TARGET_PPC64 */
>   
> -static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
> +static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
>   {
> +#ifdef TARGET_PPC64
> +    switch (env->excp_model) {
> +    case POWERPC_EXCP_POWER7:
> +        p7_deliver_interrupt(env, interrupt);
> +        return;
> +    case POWERPC_EXCP_POWER8:
> +        p8_deliver_interrupt(env, interrupt);
> +        return;
> +    case POWERPC_EXCP_POWER9:
> +    case POWERPC_EXCP_POWER10:
> +        p9_deliver_interrupt(env, interrupt);
> +        return;

These return statements could be clubbed with the function call itself.

With the suggested fixes,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> +    default:
> +        break;
> +    }
> +#endif
>       PowerPCCPU *cpu = env_archcpu(env);
>   
>       switch (interrupt) {
> @@ -2383,26 +2395,6 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
>       }
>   }
>   
> -static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
> -{
> -    switch (env->excp_model) {
> -#ifdef TARGET_PPC64
> -    case POWERPC_EXCP_POWER7:
> -        p7_deliver_interrupt(env, interrupt);
> -        break;
> -    case POWERPC_EXCP_POWER8:
> -        p8_deliver_interrupt(env, interrupt);
> -        break;
> -    case POWERPC_EXCP_POWER9:
> -    case POWERPC_EXCP_POWER10:
> -        p9_deliver_interrupt(env, interrupt);
> -        break;
> -#endif
> -    default:
> -        ppc_deliver_interrupt_generic(env, interrupt);
> -    }
> -}
> -
>   void ppc_cpu_do_system_reset(CPUState *cs)
>   {
>       PowerPCCPU *cpu = POWERPC_CPU(cs);

