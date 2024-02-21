Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C508C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoWf-0006hk-H0; Wed, 21 Feb 2024 10:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcoN7-0000wD-B1; Wed, 21 Feb 2024 10:19:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcj8A-0005gM-L1; Wed, 21 Feb 2024 04:43:13 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41L8VBo2011104; Wed, 21 Feb 2024 09:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2mcUGsz+G/CH4UyajAvWqzY66myYuYr8IqB6Vvmo+tU=;
 b=cccbxpE/p50MM/EYEwEnrRNQQE4TyELPF1N4yYjQtamHcIn4WYC+7DYVFb/gbrnMI52G
 M9lR5ILRtW/ghiMuFACRejlJSkOWKkwO5Kxu0rxYkp5aplRrj9J9CoPZ2Gb5na0VRerV
 u8kk6g7zNm7CO07pu/x7S8Ok9ABknX2C1R0BgTnpgYzmLWVvJ502FqsHWYPKFJYo/HrB
 JSWbFr9NmVErmMzWMAEvz35Q4UrjWa7GDxgeeotMhegwJYPWsF8jUHpAkA1qvdEwVFAk
 WyPAXTaqBcOOaEEOqhY88398jvWr+TJ4SUgOMAh2xw1PREBtGCRUoWfrhIDXOJWJyfdS 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdcqp31ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:42:50 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41L9Vghn015773;
 Wed, 21 Feb 2024 09:42:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdcqp31ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:42:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41L7DuOV031153; Wed, 21 Feb 2024 09:42:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bkws6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Feb 2024 09:42:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41L9gkpV18219564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 09:42:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7792A58055;
 Wed, 21 Feb 2024 09:42:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B44558076;
 Wed, 21 Feb 2024 09:42:44 +0000 (GMT)
Received: from [9.171.84.200] (unknown [9.171.84.200])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Feb 2024 09:42:43 +0000 (GMT)
Message-ID: <1309d0d0-f887-4634-9ba5-f3b9bb1eee1b@linux.ibm.com>
Date: Wed, 21 Feb 2024 15:12:42 +0530
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
X-Proofpoint-ORIG-GUID: lYG7DE7XiPMFS8ilEiYZLrSawSjL3JM_
X-Proofpoint-GUID: FX-ty8OAZ9bc1U2sttzmU1Hs0Ag2TZ_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=772
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402210075
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Nice cleanup.

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

