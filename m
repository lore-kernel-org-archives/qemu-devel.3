Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46065CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1R55-0001An-Ug; Wed, 24 Sep 2025 11:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1R4x-0001AR-PO; Wed, 24 Sep 2025 11:06:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1R4r-0002Ph-5T; Wed, 24 Sep 2025 11:06:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O5X2Yc001792;
 Wed, 24 Sep 2025 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=+2UQAA26mxZQ14AbaMPR2/ckOrF/8TVR/8XExQNSbAU=; b=P4Frem6RY2oI
 IkH1qe2zoQ2Kgm408ql1iTMIpgbQ0vjkc8vJ5TUfPpJaXiO7qeA2G8BBRn7/w4or
 VO2oQVWtKkRzNoC4TrknZvZehtPWuLyltlC+h3vlMoZZ9syWLgNp2tMgNUMWgn1a
 ykxSjCs4A1dOQBPnqz6dZ15es7+CEfqZBNDqIaz67p2yGVnE88PiSeZGSlRWTMwT
 Bj/mY0PsRGFZKATmC9AhwH4papQJ3PojpzQA/lIUgL1eommW++KQSSGw0rAsiRyL
 nraz4wIAa51HVp3nZC3k7pyKqW76uNSRGfLpUHQt9kjPYiyCpTLYHHJPrsouvFLk
 iUOlo39yPg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc0a8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 15:06:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OF4HpN029591;
 Wed, 24 Sep 2025 15:06:34 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc0a8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 15:06:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD0eem031166;
 Wed, 24 Sep 2025 15:06:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vda5d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 15:06:32 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58OF6Vok33227374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 15:06:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0C6A58060;
 Wed, 24 Sep 2025 15:06:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FC3C5805E;
 Wed, 24 Sep 2025 15:06:31 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Sep 2025 15:06:31 +0000 (GMT)
Message-ID: <a168b80b1fc1bb1b9fe9c41209271e644b441bb2.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/9] target/ppc: Add IBM PPE42 family of processors
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org
Date: Wed, 24 Sep 2025 10:06:30 -0500
In-Reply-To: <a136e0ef3c7d04b7cc4cc1ef370ee046deed6e47.camel@linux.ibm.com>
References: <20250918182731.528944-1-milesg@linux.ibm.com>
 <20250918182731.528944-3-milesg@linux.ibm.com>
 <2ac7b094-4365-46e6-9f44-50052e1b3827@linux.ibm.com>
 <a136e0ef3c7d04b7cc4cc1ef370ee046deed6e47.camel@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9p2_ck6rxM5FcyBiBtf04Bft1IapsIUC
X-Proofpoint-GUID: G4uIvyjXRrhC9N0sSmc6jI7R0QkVLJ0c
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d408fa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=jRLB2SoPAAAA:8 a=VnNF1IyMAAAA:8
 a=02QU8p618ZI_w2v3REkA:9 a=QEXdDO2ut3YA:10 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfXy2b1k/ugFOPr
 FGN0adQ99iRHoRCemU2Px1Qaskija4pNVx+03Yd7vupDC5o9tZ1YM8WgimNzVvpjWVcblyNFsu+
 C0XQFTR28u091+aEJUbOMPWlqtu9f8Hi/PRNvASONmqscr927JFDR6wtfmEPsqFS1UaVQII01Cv
 g0iqHTh6E3juqvSRRxIm1SFLg/Oq/Pok7AUHUDsC/KuNO3LBf59v6lQ+zU90iRbCPluoVxA2gIx
 SUZEaauvnqT48mX4qJIsT/EQ8FCw1BNhjJp29Ygse/sB9uT6yeOSYLsJQt45lN4vYSnoD7w9CCT
 k0MELfuuLdtXdFCz6n69O/h4HunqG+qqzrd64+Y86mQEySQOW2mrfFuIHcCHE5t+Phq+bcOnFck
 VHIy5djR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2025-09-24 at 09:52 -0500, Miles Glenn wrote:
> On Wed, 2025-09-24 at 18:02 +0530, Chinmay Rath wrote:
> > On 9/18/25 23:57, Glenn Miles wrote:
> > > Adds the IBM PPE42 family of 32-bit processors supporting
> > > the PPE42, PPE42X and PPE42XM processor versions.  These
> > > processors are used as embedded processors in the IBM
> > > Power9, Power10 and Power12 processors for various
> > > tasks.  It is basically a stripped down version of the
> > > IBM PowerPC 405 processor, with some added instructions
> > > for handling 64-bit loads and stores.
> > > 
> > > For more information on the PPE 42 processor please visit:
> > > 
> > > https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
> > > 
> > > Supports PPE42 SPR's (Including the MSR).
> > > 
> > > Does not yet support exceptions, new PPE42 instructions and
> > > does not prevent access to some invalid instructions and
> > > registers (currently allows access to invalid GPR's and CR
> > > fields).
> > > 
> > > Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> > > ---
> > >   target/ppc/cpu-models.c  |   7 ++
> > >   target/ppc/cpu_init.c    | 204 ++++++++++++++++++++++++++++++++-------
> > >   target/ppc/helper_regs.c |  41 +++++---
> > >   target/ppc/translate.c   |   6 +-
> > >   4 files changed, 203 insertions(+), 55 deletions(-)
> > > 
> > > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > > index ea86ea202a..09f73e23a8 100644
> > > --- a/target/ppc/cpu-models.c
> > > +++ b/target/ppc/cpu-models.c
> > > @@ -116,6 +116,13 @@
> > >                   NULL)
> > >       POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
> > >                   NULL)
> > > +    /* PPE42 Embedded Controllers                                            */
> > > +    POWERPC_DEF("PPE42",         CPU_POWERPC_PPE42,                  ppe42,
> > > +                "Generic PPE 42")
> > > +    POWERPC_DEF("PPE42X",        CPU_POWERPC_PPE42X,                 ppe42x,
> > > +                "Generic PPE 42X")
> > > +    POWERPC_DEF("PPE42XM",       CPU_POWERPC_PPE42XM,                ppe42xm,
> > > +                "Generic PPE 42XM")
> > >       /* PowerPC 440 family                                                    */
> > >   #if defined(TODO_USER_ONLY)
> > >       POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
> > > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > > index db841f1260..b42673c6b5 100644
> > > --- a/target/ppc/cpu_init.c
> > > +++ b/target/ppc/cpu_init.c
> > > @@ -1653,6 +1653,47 @@ static void register_8xx_sprs(CPUPPCState *env)
> > >    * ... and more (thermal management, performance counters, ...)
> > >    */
> > >   
> > > +static void register_ppe42_sprs(CPUPPCState *env)
> > > +{
> > > +    spr_register(env, SPR_PPE42_EDR, "EDR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_generic,
> > > +                 0x00000000);
> > > +    spr_register(env, SPR_PPE42_ISR, "ISR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_generic,
> > > +                 0x00000000);
> > > +    spr_register(env, SPR_PPE42_IVPR, "IVPR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, SPR_NOACCESS,
> > > +                 0xfff80000);
> > > +    spr_register(env, SPR_PPE42_PIR, "PIR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_pir,
> > > +                 0x00000000);
> > > +    spr_register(env, SPR_PPE42_DBCR, "DBCR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_40x_dbcr0,
> > > +                 0x00000000);
> > > +    spr_register(env, SPR_PPE42_DACR, "DACR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_generic,
> > > +                 0x00000000);
> > > +    /* Timer */
> > > +    spr_register(env, SPR_DECR, "DECR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_decr, &spr_write_decr,
> > > +                 0x00000000);
> > > +    spr_register(env, SPR_PPE42_TSR, "TSR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_booke_tsr,
> > > +                 0x00000000);
> > > +    spr_register(env, SPR_BOOKE_TCR, "TCR",
> > > +                 SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_booke_tcr,
> > > +                 0x00000000);
> > > +}
> > > +
> > >   /*****************************************************************************/
> > >   /* Exception vectors models                                                  */
> > >   static void init_excp_4xx(CPUPPCState *env)
> > > @@ -2200,6 +2241,79 @@ POWERPC_FAMILY(405)(ObjectClass *oc, const void *data)
> > >                    POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
> > >   }
> > >   
> > > +static void init_proc_ppe42(CPUPPCState *env)
> > > +{
> > > +    register_ppe42_sprs(env);
> > > +
> > > +    env->dcache_line_size = 32;
> > > +    env->icache_line_size = 32;
> > > +    /* Allocate hardware IRQ controller */
> > > +    ppc40x_irq_init(env_archcpu(env));
> > > +
> > > +    SET_FIT_PERIOD(8, 12, 16, 20);
> > > +    SET_WDT_PERIOD(16, 20, 24, 28);
> > > +}
> > > +
> > > +static void ppe42_class_common_init(PowerPCCPUClass *pcc)
> > > +{
> > > +    pcc->init_proc = init_proc_ppe42;
> > > +    pcc->check_pow = check_pow_nocheck;
> > > +    pcc->check_attn = check_attn_none;
> > > +    pcc->insns_flags = PPC_INSNS_BASE |
> > > +                       PPC_WRTEE |
> > > +                       PPC_CACHE |
> > > +                       PPC_CACHE_DCBZ |
> > > +                       PPC_MEM_SYNC;
> > > +    pcc->msr_mask = R_MSR_SEM_MASK |
> > > +                    (1ull << MSR_IS0) |
> > > +                    R_MSR_SIBRC_MASK |
> > > +                    (1ull << MSR_LP) |
> > > +                    (1ull << MSR_WE) |
> > > +                    (1ull << MSR_IS1) |
> > > +                    (1ull << MSR_UIE) |
> > > +                    (1ull << MSR_EE) |
> > > +                    (1ull << MSR_ME) |
> > > +                    (1ull << MSR_IS2) |
> > > +                    (1ull << MSR_IS3) |
> > > +                    (1ull << MSR_IPE) |
> > > +                    R_MSR_SIBRCA_MASK;
> > > +    pcc->mmu_model = POWERPC_MMU_REAL;
> > > +    pcc->excp_model = POWERPC_EXCP_40x;
> > > +    pcc->bus_model = PPC_FLAGS_INPUT_PPE42;
> > > +    pcc->bfd_mach = bfd_mach_ppc_403;
> > > +    pcc->flags = POWERPC_FLAG_PPE42 | POWERPC_FLAG_BUS_CLK;
> > > +}
> > > +
> > > +POWERPC_FAMILY(ppe42)(ObjectClass *oc, const void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > > +    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> > > +
> > > +    dc->desc = "PPE 42";
> > > +    pcc->insns_flags2 = PPC2_PPE42;
> > > +    ppe42_class_common_init(pcc);
> > > +}
> > > +
> > > +POWERPC_FAMILY(ppe42x)(ObjectClass *oc, const void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > > +    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> > > +
> > > +    dc->desc = "PPE 42X";
> > > +    pcc->insns_flags2 = PPC2_PPE42 | PPC2_PPE42X;
> > > +    ppe42_class_common_init(pcc);
> > > +}
> > > +
> > > +POWERPC_FAMILY(ppe42xm)(ObjectClass *oc, const void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > > +    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> > > +
> > > +    dc->desc = "PPE 42XM";
> > > +    pcc->insns_flags2 = PPC2_PPE42 | PPC2_PPE42X | PPC2_PPE42XM;
> > > +    ppe42_class_common_init(pcc);
> > > +}
> > > +
> > >   static void init_proc_440EP(CPUPPCState *env)
> > >   {
> > >       register_BookE_sprs(env, 0x000000000000FFFFULL);
> > > @@ -6802,53 +6916,63 @@ static void init_ppc_proc(PowerPCCPU *cpu)
> > >   
> > >       /* MSR bits & flags consistency checks */
> > >       if (env->msr_mask & (1 << 25)) {
> > > -        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
> > > +        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE |
> > > +                              POWERPC_FLAG_PPE42)) {
> > >           case POWERPC_FLAG_SPE:
> > >           case POWERPC_FLAG_VRE:
> > > +        case POWERPC_FLAG_PPE42:
> > >               break;
> > >           default:
> > >               fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > > -                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n");
> > > +                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n"
> > > +                    "or POWERPC_FLAG_PPE42\n");
> > >               exit(1);
> > >           }
> > >       } else if (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
> > 
> > Hey Glenn,
> > 
> > Did you miss adding the POWERPC_FLAG_PPE42 flag here  ^  ?
> > 
> > Thanks,
> > Chinmay
> 
> No. All PPE42 processors will have bit 1 << 25 set in env->msr_mask, so
> it will always fall into the previous condition block and never enter
> the 2nd check.
> 
> Glenn
> 

Ah, sorry, I should have looked closer!  This is supposed to be
checking that if 1 << 25 is not set that we shouldn't be setting the
PPE42 flag either.  So, yes, I'll add that in v6.

Thanks,

Glenn

> > >           fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > > -                "Should not define POWERPC_FLAG_SPE nor POWERPC_FLAG_VRE\n");
> > > +                "Should not define POWERPC_FLAG_SPE nor POWERPC_FLAG_VRE\n"
> > > +                "nor POWERPC_FLAG_PPE42\n");
> > >           exit(1);
> > >       }
> > >       if (env->msr_mask & (1 << 17)) {
> > > -        switch (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE)) {
> > > +        switch (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE |
> > > +                              POWERPC_FLAG_PPE42)) {
> > >           case POWERPC_FLAG_TGPR:
> > >           case POWERPC_FLAG_CE:
> > > +        case POWERPC_FLAG_PPE42:
> > >               break;
> > >           default:
> > >               fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > > -                    "Should define POWERPC_FLAG_TGPR or POWERPC_FLAG_CE\n");
> > > +                    "Should define POWERPC_FLAG_TGPR or POWERPC_FLAG_CE\n"
> > > +                    "or POWERPC_FLAG_PPE42\n");
> > >               exit(1);
> > >           }
> > > -    } else if (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE)) {
> > > +    } else if (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE |
> > > +                             POWERPC_FLAG_PPE42)) {
> > >           fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > > -                "Should not define POWERPC_FLAG_TGPR nor POWERPC_FLAG_CE\n");
> > > +                "Should not define POWERPC_FLAG_TGPR nor POWERPC_FLAG_CE\n"
> > > +                "nor POWERPC_FLAG_PPE42\n");
> > >           exit(1);
> > >       }
> > >       if (env->msr_mask & (1 << 10)) {
> > >           switch (env->flags & (POWERPC_FLAG_SE | POWERPC_FLAG_DWE |
> > > -                              POWERPC_FLAG_UBLE)) {
> > > +                              POWERPC_FLAG_UBLE | POWERPC_FLAG_PPE42)) {
> > >           case POWERPC_FLAG_SE:
> > >           case POWERPC_FLAG_DWE:
> > >           case POWERPC_FLAG_UBLE:
> > > +        case POWERPC_FLAG_PPE42:
> > >               break;
> > >           default:
> > >               fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > >                       "Should define POWERPC_FLAG_SE or POWERPC_FLAG_DWE or "
> > > -                    "POWERPC_FLAG_UBLE\n");
> > > +                    "POWERPC_FLAG_UBLE or POWERPC_FLAG_PPE42\n");
> > >               exit(1);
> > >           }
> > >       } else if (env->flags & (POWERPC_FLAG_SE | POWERPC_FLAG_DWE |
> > > -                             POWERPC_FLAG_UBLE)) {
> > > +                             POWERPC_FLAG_UBLE | POWERPC_FLAG_PPE42)) {
> > >           fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > >                   "Should not define POWERPC_FLAG_SE nor POWERPC_FLAG_DWE nor "
> > > -                "POWERPC_FLAG_UBLE\n");
> > > +                "POWERPC_FLAG_UBLE nor POWERPC_FLAG_PPE42\n");
> > >               exit(1);
> > >       }
> > >       if (env->msr_mask & (1 << 9)) {
> > > @@ -6867,18 +6991,23 @@ static void init_ppc_proc(PowerPCCPU *cpu)
> > >           exit(1);
> > >       }
> > >       if (env->msr_mask & (1 << 2)) {
> > > -        switch (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM)) {
> > > +        switch (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM |
> > > +                              POWERPC_FLAG_PPE42)) {
> > >           case POWERPC_FLAG_PX:
> > >           case POWERPC_FLAG_PMM:
> > > +        case POWERPC_FLAG_PPE42:
> > >               break;
> > >           default:
> > >               fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > > -                    "Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM\n");
> > > +                    "Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM\n"
> > > +                    "or POWERPC_FLAG_PPE42\n");
> > >               exit(1);
> > >           }
> > > -    } else if (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM)) {
> > > +    } else if (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM |
> > > +                             POWERPC_FLAG_PPE42)) {
> > >           fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > > -                "Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM\n");
> > > +                "Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM\n"
> > > +                "nor POWERPC_FLAG_PPE42\n");
> > >           exit(1);
> > >       }
> > >       if ((env->flags & POWERPC_FLAG_BUS_CLK) == 0) {
> > > @@ -7243,39 +7372,40 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
> > >       }
> > >   
> > >       msr = (target_ulong)0;
> > > -    msr |= (target_ulong)MSR_HVB;
> > > -    msr |= (target_ulong)1 << MSR_EP;
> > > +    if (!(env->flags & POWERPC_FLAG_PPE42)) {
> > > +        msr |= (target_ulong)MSR_HVB;
> > > +        msr |= (target_ulong)1 << MSR_EP;
> > >   #if defined(DO_SINGLE_STEP) && 0
> > > -    /* Single step trace mode */
> > > -    msr |= (target_ulong)1 << MSR_SE;
> > > -    msr |= (target_ulong)1 << MSR_BE;
> > > +        /* Single step trace mode */
> > > +        msr |= (target_ulong)1 << MSR_SE;
> > > +        msr |= (target_ulong)1 << MSR_BE;
> > >   #endif
> > >   #if defined(CONFIG_USER_ONLY)
> > > -    msr |= (target_ulong)1 << MSR_FP; /* Allow floating point usage */
> > > -    msr |= (target_ulong)1 << MSR_FE0; /* Allow floating point exceptions */
> > > -    msr |= (target_ulong)1 << MSR_FE1;
> > > -    msr |= (target_ulong)1 << MSR_VR; /* Allow altivec usage */
> > > -    msr |= (target_ulong)1 << MSR_VSX; /* Allow VSX usage */
> > > -    msr |= (target_ulong)1 << MSR_SPE; /* Allow SPE usage */
> > > -    msr |= (target_ulong)1 << MSR_PR;
> > > +        msr |= (target_ulong)1 << MSR_FP; /* Allow floating point usage */
> > > +        msr |= (target_ulong)1 << MSR_FE0; /* Allow floating point exceptions */
> > > +        msr |= (target_ulong)1 << MSR_FE1;
> > > +        msr |= (target_ulong)1 << MSR_VR; /* Allow altivec usage */
> > > +        msr |= (target_ulong)1 << MSR_VSX; /* Allow VSX usage */
> > > +        msr |= (target_ulong)1 << MSR_SPE; /* Allow SPE usage */
> > > +        msr |= (target_ulong)1 << MSR_PR;
> > >   #if defined(TARGET_PPC64)
> > > -    msr |= (target_ulong)1 << MSR_TM; /* Transactional memory */
> > > +        msr |= (target_ulong)1 << MSR_TM; /* Transactional memory */
> > >   #endif
> > >   #if !TARGET_BIG_ENDIAN
> > > -    msr |= (target_ulong)1 << MSR_LE; /* Little-endian user mode */
> > > -    if (!((env->msr_mask >> MSR_LE) & 1)) {
> > > -        fprintf(stderr, "Selected CPU does not support little-endian.\n");
> > > -        exit(1);
> > > -    }
> > > +        msr |= (target_ulong)1 << MSR_LE; /* Little-endian user mode */
> > > +        if (!((env->msr_mask >> MSR_LE) & 1)) {
> > > +            fprintf(stderr, "Selected CPU does not support little-endian.\n");
> > > +            exit(1);
> > > +        }
> > >   #endif
> > >   #endif
> > >   
> > >   #if defined(TARGET_PPC64)
> > > -    if (mmu_is_64bit(env->mmu_model)) {
> > > -        msr |= (1ULL << MSR_SF);
> > > -    }
> > > +        if (mmu_is_64bit(env->mmu_model)) {
> > > +            msr |= (1ULL << MSR_SF);
> > > +        }
> > >   #endif
> > > -
> > > +    }
> > >       hreg_store_msr(env, msr, 1);
> > >   
> > >   #if !defined(CONFIG_USER_ONLY)
> > > diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> > > index 5f21739749..41b7b939ec 100644
> > > --- a/target/ppc/helper_regs.c
> > > +++ b/target/ppc/helper_regs.c
> > > @@ -308,9 +308,6 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
> > >           value &= ~(1 << MSR_ME);
> > >           value |= env->msr & (1 << MSR_ME);
> > >       }
> > > -    if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
> > > -        cpu_interrupt_exittb(cs);
> > > -    }
> > >       if ((env->mmu_model == POWERPC_MMU_BOOKE ||
> > >            env->mmu_model == POWERPC_MMU_BOOKE206) &&
> > >           ((value ^ env->msr) & R_MSR_GS_MASK)) {
> > > @@ -321,8 +318,14 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
> > >           /* Swap temporary saved registers with GPRs */
> > >           hreg_swap_gpr_tgpr(env);
> > >       }
> > > -    if (unlikely((value ^ env->msr) & R_MSR_EP_MASK)) {
> > > -        env->excp_prefix = FIELD_EX64(value, MSR, EP) * 0xFFF00000;
> > > +    /* PPE42 uses IR, DR and EP MSR bits for other purposes */
> > > +    if (likely(!(env->flags & POWERPC_FLAG_PPE42))) {
> > > +        if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
> > > +            cpu_interrupt_exittb(cs);
> > > +        }
> > > +        if (unlikely((value ^ env->msr) & R_MSR_EP_MASK)) {
> > > +            env->excp_prefix = FIELD_EX64(value, MSR, EP) * 0xFFF00000;
> > > +        }
> > >       }
> > >       /*
> > >        * If PR=1 then EE, IR and DR must be 1
> > > @@ -464,6 +467,23 @@ void register_generic_sprs(PowerPCCPU *cpu)
> > >                    SPR_NOACCESS, SPR_NOACCESS,
> > >                    &spr_read_generic, &spr_write_generic,
> > >                    0x00000000);
> > > +
> > > +    spr_register(env, SPR_PVR, "PVR",
> > > +                 /* Linux permits userspace to read PVR */
> > > +#if defined(CONFIG_LINUX_USER)
> > > +                 &spr_read_generic,
> > > +#else
> > > +                 SPR_NOACCESS,
> > > +#endif
> > > +                 SPR_NOACCESS,
> > > +                 &spr_read_generic, SPR_NOACCESS,
> > > +                 pcc->pvr);
> > > +
> > > +    /* PPE42 doesn't support SPRG1-3, SVR or TB regs */
> > > +    if (env->insns_flags2 & PPC2_PPE42) {
> > > +        return;
> > > +    }
> > > +
> > >       spr_register(env, SPR_SPRG1, "SPRG1",
> > >                    SPR_NOACCESS, SPR_NOACCESS,
> > >                    &spr_read_generic, &spr_write_generic,
> > > @@ -477,17 +497,6 @@ void register_generic_sprs(PowerPCCPU *cpu)
> > >                    &spr_read_generic, &spr_write_generic,
> > >                    0x00000000);
> > >   
> > > -    spr_register(env, SPR_PVR, "PVR",
> > > -                 /* Linux permits userspace to read PVR */
> > > -#if defined(CONFIG_LINUX_USER)
> > > -                 &spr_read_generic,
> > > -#else
> > > -                 SPR_NOACCESS,
> > > -#endif
> > > -                 SPR_NOACCESS,
> > > -                 &spr_read_generic, SPR_NOACCESS,
> > > -                 pcc->pvr);
> > > -
> > >       /* Register SVR if it's defined to anything else than POWERPC_SVR_NONE */
> > >       if (pcc->svr != POWERPC_SVR_NONE) {
> > >           if (pcc->svr & POWERPC_SVR_E500) {
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index 27f90c3cc5..fc817dab54 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -4264,8 +4264,10 @@ static void gen_mtmsr(DisasContext *ctx)
> > >           /* L=1 form only updates EE and RI */
> > >           mask &= (1ULL << MSR_RI) | (1ULL << MSR_EE);
> > >       } else {
> > > -        /* mtmsr does not alter S, ME, or LE */
> > > -        mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S));
> > > +        if (likely(!(ctx->insns_flags2 & PPC2_PPE42))) {
> > > +            /* mtmsr does not alter S, ME, or LE */
> > > +            mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S));
> > > +        }
> > >   
> > >           /*
> > >            * XXX: we need to update nip before the store if we enter


