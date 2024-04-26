Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786C1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0P1p-0006rX-G1; Fri, 26 Apr 2024 13:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0P1m-0006rF-Dz; Fri, 26 Apr 2024 13:06:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0P1j-0007q2-VU; Fri, 26 Apr 2024 13:06:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGxkls029964; Fri, 26 Apr 2024 17:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=kh8xNmkS73EuNKfpzNPg6n+5VIM68/EOSPtn6KH6SSc=;
 b=CKxQJj589qJLrAADgEsoX6XeMFk9+0KcANYAkV5e8+/KpAxPVZlDTHbn81oJAOk46mgu
 sMWA1tbv5El4mlubzXNFLA1qKfrZGYV8v2VDuYK3ztN49fbk1lD269DgtD0GmlPhY3a/
 bZYFODYzmoaX8P4u65IbBxSbc/LalEcfMRKqDknCOzkn2k5ebQdN4VBPeNqEpmOQqXXy
 X98ya/7gQv8mFVffnraojg/TR/mgbNRCPYZuVp/STBW0jG9/fH8yYWM+DPheexz6/kFn
 QgRyCS1O6UVutP/I9S0Jq/GjN79DUYVJrRUUVIZ4rvyT2sKjQd+quef62BVmR/sir0v/ JA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrg1a81ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:06:10 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QH69nH008793;
 Fri, 26 Apr 2024 17:06:09 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrg1a81h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:06:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QF5IMe029873; Fri, 26 Apr 2024 17:06:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmr1u13ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:06:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QH63XM25428316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:06:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DC2E20043;
 Fri, 26 Apr 2024 17:06:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE85C2005A;
 Fri, 26 Apr 2024 17:06:00 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:06:00 +0000 (GMT)
Date: Fri, 26 Apr 2024 22:35:57 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 01/10] ppc/pseries: Add Power11 cpu type
Message-ID: <p57z4il36laqlccge3llmbzveepyzad7dokxpoipxh22t2y2s3@tsiegjpijeas>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-2-adityag@linux.ibm.com>
 <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Hqq_8zAekFuv40bXAQCo_3e2erCVlKH
X-Proofpoint-GUID: q5Zd2xgNNBb-Md9lkOYpYAHa_F2KWBQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Cédric,

Thanks for your reviews.

On Fri, Apr 26, 2024 at 04:27:04PM +0200, Cédric Le Goater wrote:
> Hello Aditya
> 
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Add base support for "--cpu power11" in QEMU.
> > 
> > Power11 core is same as Power10, hence reuse functions defined for
> > Power10.
> 
> Power11 uses the same ISA it seems. What's the value then ?

Yes, it uses the same ISA. But I added this option so we can have a
Power11 PVR in QEMU, which should be identified as Power11 in skiboot
and linux, hence defined Power11 cpu type, even though code here is
almost same as Power10.

> 
> > 
> > Cc: Cédric Le Goater <clg@kaod.org>
> > Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >   docs/system/ppc/pseries.rst |  6 +--
> >   hw/ppc/spapr_cpu_core.c     |  1 +
> 
> 
> I would separate the CPU target code adding support for a new POWER
> Processor from the machine code (pseries).

Sure, I will split it in v3.

> 
> 
> >   target/ppc/compat.c         |  7 +++
> >   target/ppc/cpu-models.c     |  2 +
> >   target/ppc/cpu-models.h     |  2 +
> >   target/ppc/cpu_init.c       | 99 +++++++++++++++++++++++++++++++++++++
> >   6 files changed, 114 insertions(+), 3 deletions(-)
> > 
> > diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
> > index a876d897b6e4..3277564b34c2 100644
> > --- a/docs/system/ppc/pseries.rst
> > +++ b/docs/system/ppc/pseries.rst
> > @@ -15,9 +15,9 @@ Supported devices
> >   =================
> >    * Multi processor support for many Power processors generations: POWER7,
> > -   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
> > -   but its state is unknown.
> > - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
> > +   POWER7+, POWER8, POWER8NVL, POWER9, Power10 and Power11. Support for POWER5+
> > +   exists, but its state is unknown.
> 
> The POWER5+ pseries machine seems functionnal with SLOF
> (Sep 18 2023 18:57:48) and Linux 6.6.3 under TCG. May be worth
> to mention (for AIX users) in another patch.
> 
> > + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9, Power10, Power11)
> >    * vPHB PCIe Host bridge.
> >    * vscsi and vnet devices, compatible with the same devices available on a
> >      PowerVM hypervisor with VIOS managing LPARs.
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index e7c9edd033c8..c6e85c031178 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -401,6 +401,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
> >       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
> >       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
> >       DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power11"),
> >   #ifdef CONFIG_KVM
> >       DEFINE_SPAPR_CPU_CORE_TYPE("host"),
> >   #endif
> > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > index ebef2cccecf3..12dd8ae290ca 100644
> > --- a/target/ppc/compat.c
> > +++ b/target/ppc/compat.c
> > @@ -100,6 +100,13 @@ static const CompatInfo compat_table[] = {
> >           .pcr_level = PCR_COMPAT_3_10,
> >           .max_vthreads = 8,
> >       },
> > +    { /* POWER11, ISA3.10 */
> > +        .name = "power11",
> > +        .pvr = CPU_POWERPC_LOGICAL_3_10_PLUS,
> > +        .pcr = PCR_COMPAT_3_10,
> > +        .pcr_level = PCR_COMPAT_3_10,
> > +        .max_vthreads = 8,
> > +    },
> >   };
> >   static const CompatInfo *compat_by_pvr(uint32_t pvr)
> > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > index f2301b43f78b..1870e69b63df 100644
> > --- a/target/ppc/cpu-models.c
> > +++ b/target/ppc/cpu-models.c
> > @@ -734,6 +734,8 @@
> >                   "POWER9 v2.2")
> >       POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
> >                   "POWER10 v2.0")
> > +    POWERPC_DEF("power11",  CPU_POWERPC_POWER11,           POWER11,
> > +                "POWER11")
> >   #endif /* defined (TARGET_PPC64) */
> >   /***************************************************************************/
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index 0229ef3a9a5c..a1b540c3aa9e 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> > @@ -354,6 +354,7 @@ enum {
> >       CPU_POWERPC_POWER10_BASE       = 0x00800000,
> >       CPU_POWERPC_POWER10_DD1        = 0x00801100,
> >       CPU_POWERPC_POWER10_DD20       = 0x00801200,
> > +    CPU_POWERPC_POWER11            = 0x00821200,
> 
> is that a DD2.2 PVR ? If so, It should be mentionned in the definition.
> 

Yes, I have kept the last 2 bytes same as P10 DD2. I will mention it
above the line I have added it, in v3.

Thanks,
Aditya Gupta

> 
> 
> Thanks,
> 
> C.
> 
> 
> 
> >       CPU_POWERPC_970_v22            = 0x00390202,
> >       CPU_POWERPC_970FX_v10          = 0x00391100,
> >       CPU_POWERPC_970FX_v20          = 0x003C0200,
> > @@ -391,6 +392,7 @@ enum {
> >       CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
> >       CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
> >       CPU_POWERPC_LOGICAL_3_10       = 0x0F000006,
> > +    CPU_POWERPC_LOGICAL_3_10_PLUS  = 0x0F000007,
> >   };
> >   /* System version register (used on MPC 8xxx)                                */
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index 6d82f24c8756..17c159c8187b 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -6655,6 +6655,105 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
> >       pcc->l1_icache_size = 0x8000;
> >   }
> > +static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
> > +{
> > +    uint32_t base = pvr & CPU_POWERPC_POWER_SERVER_MASK;
> > +    uint32_t pcc_base = pcc->pvr & CPU_POWERPC_POWER_SERVER_MASK;
> > +
> > +    if (!best && (base == CPU_POWERPC_POWER11))
> > +        return true;
> > +
> > +    if (base != pcc_base)
> > +        return false;
> > +
> > +    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00))
> > +        return true;
> > +
> > +    return false;
> > +}
> > +
> > +POWERPC_FAMILY(POWER11)(ObjectClass * oc, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > +    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> > +
> > +    dc->fw_name = "PowerPC,POWER11";
> > +    dc->desc = "POWER11";
> > +    pcc->pvr_match = ppc_pvr_match_power11;
> > +    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
> > +                    PCR_COMPAT_3_00 | PCR_COMPAT_3_10;
> > +    pcc->pcr_supported = PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
> > +                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
> > +    pcc->init_proc = init_proc_POWER10;
> > +    pcc->check_pow = check_pow_nocheck;
> > +    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
> > +                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
> > +                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> > +                       PPC_FLOAT_FRSQRTES |
> > +                       PPC_FLOAT_STFIWX |
> > +                       PPC_FLOAT_EXT |
> > +                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
> > +                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
> > +                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
> > +                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
> > +                       PPC_SEGMENT_64B | PPC_SLBI |
> > +                       PPC_POPCNTB | PPC_POPCNTWD |
> > +                       PPC_CILDST;
> > +    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
> > +                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
> > +                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> > +                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
> > +                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> > +                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> > +                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
> > +                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
> > +    pcc->msr_mask = (1ull << MSR_SF) |
> > +                    (1ull << MSR_HV) |
> > +                    (1ull << MSR_TM) |
> > +                    (1ull << MSR_VR) |
> > +                    (1ull << MSR_VSX) |
> > +                    (1ull << MSR_EE) |
> > +                    (1ull << MSR_PR) |
> > +                    (1ull << MSR_FP) |
> > +                    (1ull << MSR_ME) |
> > +                    (1ull << MSR_FE0) |
> > +                    (1ull << MSR_SE) |
> > +                    (1ull << MSR_DE) |
> > +                    (1ull << MSR_FE1) |
> > +                    (1ull << MSR_IR) |
> > +                    (1ull << MSR_DR) |
> > +                    (1ull << MSR_PMM) |
> > +                    (1ull << MSR_RI) |
> > +                    (1ull << MSR_LE);
> > +    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> > +        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
> > +        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
> > +        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
> > +                             LPCR_DEE | LPCR_OEE))
> > +        | LPCR_MER | LPCR_GTSE | LPCR_TC |
> > +        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
> > +    /* DD2 adds an extra HAIL bit */
> > +    pcc->lpcr_mask |= LPCR_HAIL;
> > +
> > +    pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
> > +    pcc->mmu_model = POWERPC_MMU_3_00;
> > +#if !defined(CONFIG_USER_ONLY)
> > +    /* segment page size remain the same */
> > +    pcc->hash64_opts = &ppc_hash64_opts_POWER7;
> > +    pcc->radix_page_info = &POWER10_radix_page_info;
> > +    pcc->lrg_decr_bits = 56;
> > +#endif
> > +    pcc->excp_model = POWERPC_EXCP_POWER10;
> > +    pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
> > +    pcc->bfd_mach = bfd_mach_ppc64;
> > +    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
> > +                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
> > +                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> > +                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
> > +    pcc->l1_dcache_size = 0x8000;
> > +    pcc->l1_icache_size = 0x8000;
> > +}
> > +
> >   #if !defined(CONFIG_USER_ONLY)
> >   void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
> >   {
> 

