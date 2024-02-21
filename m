Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695AFC5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoZa-0002Vp-Jn; Wed, 21 Feb 2024 10:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcoOs-00046s-Tn; Wed, 21 Feb 2024 10:20:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcid3-0000kA-MM; Wed, 21 Feb 2024 04:11:09 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41L98EiO028466; Wed, 21 Feb 2024 09:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tOoAxY65poesa/yfu6OWk3/sVPjfbnX2t7J9/8nNxz4=;
 b=JArS48ia3b9ZpsG2cWirQm604gumJkltWR6Xs0OMMq3EGyVShduG1hJ40Kp2PA9H06Mp
 x5I+pfsF8AYoN8KqX89jYZa37ElIaXo+fvJQmvsU/Ozlz6xTuZL0FiiKjKFqPejI2QxS
 AlmRC8CEXgTe8xcOQInD+crh/dKruH/0UkZTG8sUZgWyjSvQeFaDxJACDE1qyjt1hSmM
 w561GTXQ05a43A0ikaujM4dlB8r/4EsUFF70LnUjErqxHJxNIHQ0IvyMyfxcfaaI0+Zx
 5wUnTeT7y3rxFCTkL+Xu+ef19/QBYV+e3SiWkV91AVOp/QC/Ggg5Hh1VJLuMLZ9Twk5b xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wde96021k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:10:46 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41L9AgW8003469;
 Wed, 21 Feb 2024 09:10:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wde960212-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:10:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41L6Md20017257; Wed, 21 Feb 2024 09:10:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmdvra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:10:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41L9Ag4p54591770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 09:10:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B46A5805E;
 Wed, 21 Feb 2024 09:10:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D44635805A;
 Wed, 21 Feb 2024 09:10:39 +0000 (GMT)
Received: from [9.171.67.90] (unknown [9.171.67.90])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Feb 2024 09:10:39 +0000 (GMT)
Message-ID: <81762fe1-38a9-4892-a1fb-4ea41fd0d9c6@linux.ibm.com>
Date: Wed, 21 Feb 2024 14:40:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] target/ppc: Use env_cpu for cpu_abort in
 excp_helper
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <cover.1705614747.git.balaton@eik.bme.hu>
 <dd4c596af0c12b6a2b4935e4571ef88f866178a6.1705614747.git.balaton@eik.bme.hu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <dd4c596af0c12b6a2b4935e4571ef88f866178a6.1705614747.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YtOjX7MjNwSJPfsDmyUztP1xCWflLlNb
X-Proofpoint-ORIG-GUID: U6on0QiJfpf4OT48SNAyi2PKlIh_aROf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=647 priorityscore=1501 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210071
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
> Use the env_cpu function to get the CPUState for cpu_abort. These are
> only needed in case of fatal errors so this allows to avoid casting
> and storing CPUState in a local variable wnen not needed.
> 

I wish the patch could have broader scope to cover whole file and not
just cpu_abort, however, this is good to begin with.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
>   1 file changed, 63 insertions(+), 55 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 2ec6429e36..b8fd01d04c 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -445,7 +445,6 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
>   
>   static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>   {
> -    CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>       target_ulong msr, new_msr, vector;
>       int srr0, srr1;
> @@ -473,8 +472,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>   
>       vector = env->excp_vectors[excp];
>       if (vector == (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", excp);
>       }
>   
>       vector |= env->excp_prefix;
> @@ -523,7 +522,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>               env->spr[SPR_40x_ESR] = ESR_PTR;
>               break;
>           default:
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
>                         env->error_code);
>               break;
>           }
> @@ -550,11 +549,12 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>           trace_ppc_excp_print("PIT");
>           break;
>       case POWERPC_EXCP_DEBUG:     /* Debug interrupt                          */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                     powerpc_excp_name(excp));
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
> +                  excp);
>           break;
>       }
>   
> @@ -569,7 +569,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>   
>   static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>   {
> -    CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>       target_ulong msr, new_msr, vector;
>   
> @@ -592,8 +591,8 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>   
>       vector = env->excp_vectors[excp];
>       if (vector == (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", excp);
>       }
>   
>       vector |= env->excp_prefix;
> @@ -653,7 +652,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>               break;
>           default:
>               /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
>                         env->error_code);
>               break;
>           }
> @@ -675,8 +674,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>           break;
>       case POWERPC_EXCP_RESET:     /* System reset exception                   */
>           if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> -                      "exception %d with no HV support\n", excp);
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset exception "
> +                      "%d with no HV support\n", excp);
>           }
>           break;
>       case POWERPC_EXCP_TRACE:     /* Trace exception                          */
> @@ -703,11 +703,12 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_SMI:       /* System management interrupt              */
>       case POWERPC_EXCP_MEXTBR:    /* Maskable external breakpoint             */
>       case POWERPC_EXCP_NMEXTBR:   /* Non maskable external breakpoint         */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                     powerpc_excp_name(excp));
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
> +                  excp);
>           break;
>       }
>   
> @@ -730,7 +731,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>   
>   static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>   {
> -    CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>       target_ulong msr, new_msr, vector;
>   
> @@ -753,8 +753,8 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>   
>       vector = env->excp_vectors[excp];
>       if (vector == (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", excp);
>       }
>   
>       vector |= env->excp_prefix;
> @@ -812,7 +812,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>               break;
>           default:
>               /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
>                         env->error_code);
>               break;
>           }
> @@ -854,8 +854,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>           break;
>       case POWERPC_EXCP_RESET:     /* System reset exception                   */
>           if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> -                      "exception %d with no HV support\n", excp);
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset exception "
> +                      "%d with no HV support\n", excp);
>           }
>           break;
>       case POWERPC_EXCP_TRACE:     /* Trace exception                          */
> @@ -875,11 +876,12 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_SMI:       /* System management interrupt              */
>       case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
>       case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                     powerpc_excp_name(excp));
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
> +                  excp);
>           break;
>       }
>   
> @@ -902,7 +904,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>   
>   static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>   {
> -    CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>       target_ulong msr, new_msr, vector;
>   
> @@ -925,8 +926,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>   
>       vector = env->excp_vectors[excp];
>       if (vector == (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", excp);
>       }
>   
>       vector |= env->excp_prefix;
> @@ -984,7 +985,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>               break;
>           default:
>               /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
>                         env->error_code);
>               break;
>           }
> @@ -1026,7 +1027,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>           break;
>       case POWERPC_EXCP_RESET:     /* System reset exception                   */
>           if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset "
>                         "exception %d with no HV support\n", excp);
>           }
>           break;
> @@ -1039,11 +1041,12 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
>       case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
>       case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                     powerpc_excp_name(excp));
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
> +                  excp);
>           break;
>       }
>   
> @@ -1066,7 +1069,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>   
>   static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>   {
> -    CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>       target_ulong msr, new_msr, vector;
>       int srr0, srr1;
> @@ -1103,8 +1105,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>   
>       vector = env->excp_vectors[excp];
>       if (vector == (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", excp);
>       }
>   
>       vector |= env->excp_prefix;
> @@ -1135,6 +1137,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>           break;
>       case POWERPC_EXCP_EXTERNAL:  /* External input                           */
>           if (env->mpic_proxy) {
> +            CPUState *cs = env_cpu(env);
>               /* IACK the IRQ on delivery */
>               env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
>           }
> @@ -1173,7 +1176,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>               break;
>           default:
>               /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
>                         env->error_code);
>               break;
>           }
> @@ -1214,7 +1217,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>   
>               /* DBSR already modified by caller */
>           } else {
> -            cpu_abort(cs, "Debug exception triggered on unsupported model\n");
> +            cpu_abort(env_cpu(env),
> +                      "Debug exception triggered on unsupported model\n");
>           }
>           break;
>       case POWERPC_EXCP_SPEU:   /* SPE/embedded floating-point unavailable/VPU  */
> @@ -1228,17 +1232,19 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>           break;
>       case POWERPC_EXCP_RESET:     /* System reset exception                   */
>           if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset "
>                         "exception %d with no HV support\n", excp);
>           }
>           break;
>       case POWERPC_EXCP_EFPDI:     /* Embedded floating-point data interrupt   */
>       case POWERPC_EXCP_EFPRI:     /* Embedded floating-point round interrupt  */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                     powerpc_excp_name(excp));
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
> +                  excp);
>           break;
>       }
>   
> @@ -1367,7 +1373,6 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
>   
>   static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   {
> -    CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>       target_ulong msr, new_msr, vector;
>       int srr0, srr1, lev = -1;
> @@ -1406,8 +1411,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   
>       vector = env->excp_vectors[excp];
>       if (vector == (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", excp);
>       }
>   
>       vector |= env->excp_prefix;
> @@ -1503,7 +1508,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>               break;
>           default:
>               /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
>                         env->error_code);
>               break;
>           }
> @@ -1569,7 +1574,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>               new_msr |= (target_ulong)MSR_HVB;
>           } else {
>               if (FIELD_EX64(env->msr, MSR, POW)) {
> -                cpu_abort(cs, "Trying to deliver power-saving system reset "
> +                cpu_abort(env_cpu(env),
> +                          "Trying to deliver power-saving system reset "
>                             "exception %d with no HV support\n", excp);
>               }
>           }
> @@ -1641,11 +1647,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
>       case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
>       case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                     powerpc_excp_name(excp));
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
> +                  excp);
>           break;
>       }
>   
> @@ -1678,8 +1685,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>       } else {
>           /* Sanity check */
>           if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
> -            cpu_abort(cs, "Trying to deliver HV exception (HSRR) %d with "
> -                      "no HV support\n", excp);
> +            cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSRR) %d "
> +                      "with no HV support\n", excp);
>           }
>   
>           /* This can update new_msr and vector if AIL applies */
> @@ -1697,11 +1704,11 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>   
>   static void powerpc_excp(PowerPCCPU *cpu, int excp)
>   {
> -    CPUState *cs = CPU(cpu);
>       CPUPPCState *env = &cpu->env;
>   
>       if (excp <= POWERPC_EXCP_NONE || excp >= POWERPC_EXCP_NB) {
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
> +                  excp);
>       }
>   
>       qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
> @@ -2235,7 +2242,6 @@ void ppc_maybe_interrupt(CPUPPCState *env)
>   static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
>   {
>       PowerPCCPU *cpu = env_archcpu(env);
> -    CPUState *cs = env_cpu(env);
>   
>       switch (interrupt) {
>       case PPC_INTERRUPT_MCK: /* Machine check exception */
> @@ -2279,14 +2285,14 @@ static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
>           assert(!env->resume_as_sreset);
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
> +                  interrupt);
>       }
>   }
>   
>   static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
>   {
>       PowerPCCPU *cpu = env_archcpu(env);
> -    CPUState *cs = env_cpu(env);
>   
>       switch (interrupt) {
>       case PPC_INTERRUPT_MCK: /* Machine check exception */
> @@ -2350,7 +2356,8 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
>           assert(!env->resume_as_sreset);
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
> +                  interrupt);
>       }
>   }
>   
> @@ -2429,7 +2436,8 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
>           assert(!env->resume_as_sreset);
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
> +                  interrupt);
>       }
>   }
>   #endif
> @@ -2437,7 +2445,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
>   static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
>   {
>       PowerPCCPU *cpu = env_archcpu(env);
> -    CPUState *cs = env_cpu(env);
>   
>       switch (interrupt) {
>       case PPC_INTERRUPT_RESET: /* External reset */
> @@ -2534,7 +2541,8 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
>           assert(!env->resume_as_sreset);
>           break;
>       default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
> +                  interrupt);
>       }
>   }
>   

