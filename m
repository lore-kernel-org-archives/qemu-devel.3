Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC61CCCD19F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mjH-0008HE-PN; Fri, 17 Oct 2025 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9mjF-0008GK-G6; Fri, 17 Oct 2025 11:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9mj5-0003kd-UY; Fri, 17 Oct 2025 11:50:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9IhvS021364;
 Fri, 17 Oct 2025 15:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T5xCPd
 bmYjCwmfWA4Qrk6oUknvUanRkhd4HaexMIWbs=; b=kgjMPf6U+wsZYMO8LDq2Xh
 ISN14geuKDqZC7RRc2wfL5FJEtmIWxwdajA9DtQX2NMzOebJ8Tvwvwd4nlKComGX
 USHxLPiW2nk0DVZ97xzOC/6C8DQGkCdC0TAqeOo7a9sgK59P9Tsx3i8ui/ZVSbOi
 QQdsQnZNgBWnO5v8WJQSG9bPXymUO80H0AYKPtKL0XugAm+SzEsxfhTDYlS3tUj0
 siA+3YAy7ASI7YifTk4vwHPcwWW06ckdAk3LRMVRn9i5+RxBBq3tmgsFjdZFJc9f
 0mKxY1PAGRC1yP8a/CNk458fXXWvFmNlQEjIG5H3KTamPXhjLCzY/ckDpmo5//5g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0j5kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 15:50:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HFmKla014037;
 Fri, 17 Oct 2025 15:50:33 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0j5kj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 15:50:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HEp8OT028035;
 Fri, 17 Oct 2025 15:50:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9n9da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 15:50:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HFoVqm64684360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 15:50:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60E6658052;
 Fri, 17 Oct 2025 15:50:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CC775805A;
 Fri, 17 Oct 2025 15:50:29 +0000 (GMT)
Received: from [9.39.26.64] (unknown [9.39.26.64])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 15:50:29 +0000 (GMT)
Message-ID: <295be472-7778-49f7-9ede-e5ef51dd908e@linux.ibm.com>
Date: Fri, 17 Oct 2025 21:20:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Remove the unusable e200 CPUs
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251017144504.563594-1-thuth@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251017144504.563594-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0_P_Kw4-yi65bZ4zjmeB65aTTVzBh-bB
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f265c9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=DFIoqxyI3ebVcn46rFQA:9 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX6WSS8ORtApdO
 dDW5kPHRtqiw2zFRlNzVFpA2cNWPS6jqsqUuVHVIlwYambQ3FZr8lgL1b38O+OUfJUTBr4P8sP8
 jwa7f1e8wkYC7d37Hgq7B5eiJ1bznGgRvNROvHF1JkP1CRSIMUsrra+an/YHsvUc4EFQwM4flsc
 X9q1igNWfZ6ZFo8/YMFvAPNrvuw5DeflQgssbApWZIlo30wq5+vXD9+ua7tMP0xHGe764gLRr7g
 xT2GC3MJJ2mmDFgbTefD9+XlXuTYAQqJhDWpmtsoefZIKnPm8V2+6nnByMUbJId+/XeidGpEKsP
 +ux8lU7AxHoXDmolOpigIGF+CcN4yhyJA3M2k36WDcHxfYLk2ATDR3Dj04GpkOZFjFE0YgPy9nx
 +U9qNv5FwpaMw14pZs3n7fijor1Kfg==
X-Proofpoint-GUID: -vw48SHvxmPFQeVibDpv1KPvsiwKFGy-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 10/17/25 20:15, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> There is currently no machine in QEMU (except the "none" machine)
> that can be run with one of the e200 ppc CPUs - all machines either
> complain about an invalid CPU type or crash QEMU immediatly.
> 
> Looking at the history of this CPU type, it seems like it has never
> been used in QEMU and only implemented as a placeholder (see e.g. the
> comment about unimplemented instructions in the POWERPC_FAMILY(e200)
> section of cpu_init.c). Being completely unused and unusable since
> such a long time, let's just remove it now.
> 
> Note: The init_excp_e200() is used by the e500 CPUs, too, so we
> rename this function to init_excp_e500() instead of removing it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/ppc/cpu-models.h |   4 --
>   target/ppc/cpu-models.c |   5 --
>   target/ppc/cpu_init.c   | 147 +---------------------------------------
>   3 files changed, 2 insertions(+), 154 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index c6cd27f390e..a439eb37ee4 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -120,10 +120,6 @@ enum {
>   #define CPU_POWERPC_MPC5200_v12      CPU_POWERPC_G2LEgp1
>   #define CPU_POWERPC_MPC5200B_v20     CPU_POWERPC_G2LEgp1
>   #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
> -    /* e200 family */
> -    /* e200 cores */
> -    CPU_POWERPC_e200z5             = 0x81000000,
> -    CPU_POWERPC_e200z6             = 0x81120000,
>       /* e300 family */
>       /* e300 cores */
>       CPU_POWERPC_e300c1             = 0x00830010,
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 89ae763c7f6..26b6debcfc9 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -244,11 +244,6 @@
>                       CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, G2LE)
>       POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
>                       CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2LE)
> -    /* e200 family                                                           */
> -    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 e200,
> -                "PowerPC e200z5 core")
> -    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 e200,
> -                "PowerPC e200z6 core")

While I hope removal of e200 should be fine, I am thinking if we want to
deprecate it in this cycle and remove it in next ?

We did deprecate Power8E, Power8NVL recently for 10.2 though.
See commit:

commit 264a604e71636bd04bfbbe3cf887259f246dccb3
Author: Aditya Gupta <adityag@linux.ibm.com>
Date:   Sat Jun 7 16:34:12 2025 +0530

     target/ppc: Deprecate Power8E and Power8NVL

Otherwise, the patch looks fine to me.

regards,
Harsh

>       /* e300 family                                                           */
>       POWERPC_DEF("e300c1",        CPU_POWERPC_e300c1,                 e300,
>                   "PowerPC e300c1 core")
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 3aa3aefc136..c3284bcbd3f 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -1825,7 +1825,7 @@ static void init_excp_G2(CPUPPCState *env)
>   #endif
>   }
>   
> -static void init_excp_e200(CPUPPCState *env, target_ulong ivpr_mask)
> +static void init_excp_e500(CPUPPCState *env, target_ulong ivpr_mask)
>   {
>   #if !defined(CONFIG_USER_ONLY)
>       env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000FFC;
> @@ -2796,149 +2796,6 @@ POWERPC_FAMILY(G2LE)(ObjectClass *oc, const void *data)
>                    POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
>   }
>   
> -static void init_proc_e200(CPUPPCState *env)
> -{
> -    register_BookE_sprs(env, 0x000000070000FFFFULL);
> -
> -    spr_register(env, SPR_BOOKE_SPEFSCR, "SPEFSCR",
> -                 &spr_read_spefscr, &spr_write_spefscr,
> -                 &spr_read_spefscr, &spr_write_spefscr,
> -                 0x00000000);
> -    /* Memory management */
> -    register_BookE206_sprs(env, 0x0000005D, NULL, 0);
> -    register_usprgh_sprs(env);
> -
> -    spr_register(env, SPR_HID0, "HID0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_HID1, "HID1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_ALTCTXCR, "ALTCTXCR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_BUCSR, "BUCSR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_CTXCR, "CTXCR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_DBCNT, "DBCNT",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_DBCR3, "DBCR3",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_L1CFG0, "L1CFG0",
> -                 &spr_read_generic, SPR_NOACCESS,
> -                 &spr_read_generic, SPR_NOACCESS,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_L1CSR0, "L1CSR0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_Exxx_L1FINV0, "L1FINV0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_MMUCSR0, "MMUCSR0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000); /* TOFIX */
> -
> -    init_tlbs_emb(env);
> -    init_excp_e200(env, 0xFFFF0000UL);
> -    env->dcache_line_size = 32;
> -    env->icache_line_size = 32;
> -    /* XXX: TODO: allocate internal IRQ controller */
> -}
> -
> -POWERPC_FAMILY(e200)(ObjectClass *oc, const void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(oc);
> -    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> -
> -    dc->desc = "e200 core";
> -    pcc->init_proc = init_proc_e200;
> -    pcc->check_pow = check_pow_hid0;
> -    pcc->check_attn = check_attn_none;
> -    /*
> -     * XXX: unimplemented instructions:
> -     * dcblc
> -     * dcbtlst
> -     * dcbtstls
> -     * icblc
> -     * icbtls
> -     * tlbivax
> -     * all SPE multiply-accumulate instructions
> -     */
> -    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL |
> -                       PPC_SPE | PPC_SPE_SINGLE |
> -                       PPC_WRTEE | PPC_RFDI |
> -                       PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
> -                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
> -                       PPC_MEM_TLBSYNC | PPC_TLBIVAX |
> -                       PPC_BOOKE;
> -    pcc->msr_mask = (1ull << MSR_UCLE) |
> -                    (1ull << MSR_SPE) |
> -                    (1ull << MSR_POW) |
> -                    (1ull << MSR_CE) |
> -                    (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_FE0) |
> -                    (1ull << MSR_DWE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_FE1) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR);
> -    pcc->mmu_model = POWERPC_MMU_BOOKE206;
> -    pcc->excp_model = POWERPC_EXCP_BOOKE;
> -    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
> -    pcc->bfd_mach = bfd_mach_ppc_860;
> -    pcc->flags = POWERPC_FLAG_SPE | POWERPC_FLAG_CE |
> -                 POWERPC_FLAG_UBLE | POWERPC_FLAG_DE |
> -                 POWERPC_FLAG_BUS_CLK;
> -}
> -
>   enum fsl_e500_version {
>       fsl_e500v1,
>       fsl_e500v2,
> @@ -3173,7 +3030,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
>       }
>   #endif
>   
> -    init_excp_e200(env, ivpr_mask);
> +    init_excp_e500(env, ivpr_mask);
>       /* Allocate hardware IRQ controller */
>       ppce500_irq_init(env_archcpu(env));
>   }

