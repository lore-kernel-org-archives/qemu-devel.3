Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C823E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 09:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOZ86-0006HV-Tj; Fri, 20 Dec 2024 04:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOZ82-0006CI-1s; Fri, 20 Dec 2024 04:17:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOZ80-0003MH-Dv; Fri, 20 Dec 2024 04:17:01 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNbeAe010906;
 Fri, 20 Dec 2024 09:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NsmbT8
 FDmR6KIqrcwY17U3paoKwiVaXtRYMj1B8lt64=; b=DaeMPwGEqARGQxjXygERbz
 ED3/LTpEIVCNEGXSUTPgA6Wo0VbJ1eWSNIVrT8wEu/gvWV58UHcwbnPqI9x9sWOc
 dpZ2dy/85QlaiVJl0LmXxZHGkfHN028BYD6JCXVTJ9KP3f9R1s1trbknIksHm9wZ
 dBPlXdFhflz7a/oyMzJoFuZU5QQfxXrryrt2ARhCQ9ag5S+/TwBDAZ60iRgaLRu+
 LVxmsKCDkMgjxLPIOWU7U3b78e6M0IyfF3SEKVYcEM7mVcWKZKpU1oHoYH8S8/sh
 xrzHBqGHMckfifdHD+MwxlaUY5j1wbi3sBqVoGE83uH7bIUCRc4zkfn7L56DrjbA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwaahx01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 09:16:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BK97EgL017880;
 Fri, 20 Dec 2024 09:16:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwaahwyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 09:16:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK8Qg5r029326;
 Fri, 20 Dec 2024 09:16:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbt1p36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 09:16:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BK9GvPr131712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 09:16:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3740458059;
 Fri, 20 Dec 2024 09:16:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E0458043;
 Fri, 20 Dec 2024 09:16:55 +0000 (GMT)
Received: from [9.124.215.200] (unknown [9.124.215.200])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Dec 2024 09:16:55 +0000 (GMT)
Message-ID: <3566256a-6149-42fd-9a88-06972e419658@linux.ibm.com>
Date: Fri, 20 Dec 2024 14:46:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] spapr: Generate random HASHPKEYR for spapr machines
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20241219034035.1826173-1-npiggin@gmail.com>
 <20241219034035.1826173-4-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241219034035.1826173-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q1osRQxyi9rG5QizCeXrK4EvzWAAyxaS
X-Proofpoint-GUID: 29cRTK_MvmF4EibqEwvQnP3xHv-Rq-uO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 12/19/24 09:10, Nicholas Piggin wrote:
> The hypervisor is expected to create a value for the HASHPKEY SPR for
> each partition. Currently it uses zero for all partitions, use a
> random number instead, which in theory might make kernel ROP protection
> more secure.
> 
> Signed-of-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   include/hw/ppc/spapr.h  | 1 +
>   hw/ppc/spapr.c          | 3 +++
>   hw/ppc/spapr_cpu_core.c | 2 ++
>   3 files changed, 6 insertions(+)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index af4aa1cb0fb..db44893689b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -201,6 +201,7 @@ struct SpaprMachineState {
>       uint32_t fdt_initial_size;
>       void *fdt_blob;
>       uint8_t fdt_rng_seed[32];
> +    uint64_t hashpkey_val;
>       long kernel_size;
>       bool kernel_le;
>       uint64_t kernel_addr;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fa05e0c5156..34934afd551 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2888,6 +2888,9 @@ static void spapr_machine_init(MachineState *machine)
>           spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>       }
>   
> +    qemu_guest_getrandom_nofail(&spapr->hashpkey_val,
> +                                sizeof(spapr->hashpkey_val));
> +
>       /* init CPUs */
>       spapr_init_cpus(spapr);
>   
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 88d743a3c3f..bf9f29f4ff3 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -273,6 +273,8 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
>       env->spr_cb[SPR_TIR].default_value = thread_index;
>   
> +    env->spr_cb[SPR_HASHPKEYR].default_value = spapr->hashpkey_val;
> +
>       cpu_ppc_set_1lpar(cpu);
>   
>       /* Set time-base frequency to 512 MHz. vhyp must be set first. */

