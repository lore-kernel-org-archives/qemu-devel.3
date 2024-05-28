Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BA4C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsVh-00014C-1p; Tue, 28 May 2024 04:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBsVd-000139-3P; Tue, 28 May 2024 04:48:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sBsVb-0006yZ-9S; Tue, 28 May 2024 04:48:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S8fVVD001347; Tue, 28 May 2024 08:48:29 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3Dhvi?=
 =?UTF-8?Q?lWRNmx1fH+gATLTw5H8CKqTNiN4ktgf5dFyD/N1Y=3D;_b=3DMx7XuJjIU8HbLu?=
 =?UTF-8?Q?pAHNcNXTPYdQ5uIoSAlauBdtlZbMLDOVH09GYuvALSkhhMoxK1xqPX_PVjXWRfW?=
 =?UTF-8?Q?jam3FxAQ1g1KBXS3mUFJWnF//pMfAkHGBfSz7b+uJgggrCGucH+8FF2ly3uq_jT?=
 =?UTF-8?Q?TdPJDWcc9zJXINN5UGjxDENil4pT8ckyribeLdyE+dANyrdeAk8/1oMHHliYHzL?=
 =?UTF-8?Q?N44_IsY0AzHC5HyKxiLPwaGhzlb0+/2N8yOeJjGWzvSSiM4IktDl7vP4q6iuU54?=
 =?UTF-8?Q?CM+IKnbIe_OKpyNZUXiMkW+3DO0hYqQjNJY9be9tfzxmsn3SmYzMR7ekctRCFdi?=
 =?UTF-8?Q?tp2YxW+m5yslg6D_DQ=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydaceg8tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 08:48:28 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S8mSUp014564;
 Tue, 28 May 2024 08:48:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydaceg8tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 08:48:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S8QbGn006696; Tue, 28 May 2024 08:48:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybtate4ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 08:48:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S8mOjG48300628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 08:48:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7805B58043;
 Tue, 28 May 2024 08:48:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1783158063;
 Tue, 28 May 2024 08:48:22 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 08:48:21 +0000 (GMT)
Message-ID: <0d8011f6-653f-49fb-9cd8-008fc0029d78@linux.ibm.com>
Date: Tue, 28 May 2024 14:18:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/10] ppc: Add a core_index to CPUPPCState for SMT
 vCPUs
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-7-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240526122612.473476-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zoKkVeO6kgGv228p6Qiz9Ocac_Sa0LCB
X-Proofpoint-ORIG-GUID: O3y0mkwmVyjLx0LhVY-qGen1hTofO-yW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280064
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 5/26/24 17:56, Nicholas Piggin wrote:
> The way SMT thread siblings are matched is clunky, using hard-coded
> logic that checks the PIR SPR.
> 
> Change that to use a new core_index variable in the CPUPPCState,
> where all siblings have the same core_index. CPU realize routines have
> flexibility in setting core/sibling topology.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu.h        | 5 ++++-
>   hw/ppc/pnv_core.c       | 2 ++
>   hw/ppc/spapr_cpu_core.c | 3 +++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index dac13d4dac..9a89083932 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1247,6 +1247,9 @@ struct CPUArchState {
>       /* when a memory exception occurs, the access type is stored here */
>       int access_type;
>   
> +    /* For SMT processors */
> +    int core_index;
> +
>   #if !defined(CONFIG_USER_ONLY)
>       /* MMU context, only relevant for full system emulation */
>   #if defined(TARGET_PPC64)
> @@ -1404,7 +1407,7 @@ struct CPUArchState {
>   };
>   
>   #define _CORE_ID(cs)                                            \
> -    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
> +    (POWERPC_CPU(cs)->env.core_index)

Dont we want to keep the logical & with ~(cs->nr_threads - 1) ?
How's it taken care ?

>   
>   #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
>       CPU_FOREACH(cs_sibling)                                     \
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 9b5edd9e48..0f61aabb77 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -252,6 +252,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
>       pir_spr->default_value = pir;
>       tir_spr->default_value = tir;
>   
> +    env->core_index = core_hwid;
> +
>       /* Set time-base frequency to 512 MHz */
>       cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
>   }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index e7c9edd033..059d372c8a 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -300,16 +300,19 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
>       g_autofree char *id = NULL;
>       CPUState *cs;
>       PowerPCCPU *cpu;
> +    CPUPPCState *env;
>   
>       obj = object_new(scc->cpu_type);
>   
>       cs = CPU(obj);
>       cpu = POWERPC_CPU(obj);
> +    env = &cpu->env;
>       /*
>        * All CPUs start halted. CPU0 is unhalted from the machine level reset code
>        * and the rest are explicitly started up by the guest using an RTAS call.
>        */
>       qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
> +    env->core_index = cc->core_id;

We could just do cpu->env.core_index and avoid creating local var env.

regards,
Harsh

>       cs->cpu_index = cc->core_id + i;
>       if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
>           return NULL;

