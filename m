Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC61C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 07:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWWIQ-0007pr-VX; Wed, 24 Jul 2024 03:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sWWIO-0007mx-AS; Wed, 24 Jul 2024 03:20:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sWWIL-0008FJ-RS; Wed, 24 Jul 2024 03:20:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5rZtw001842;
 Wed, 24 Jul 2024 07:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=5
 1zKdTDIa1JUrdhwUVM2G0Y9qeF+Gpvz/zslSTeZzxQ=; b=cd67ffwc8NqEaJFE6
 Q8RgA+Pq8fKE2lp0D51fcYJgr4RMOHdUZXmq/wH3v0qV2e/0blVHw7Ic0SFrH24i
 eoeNsn6mLMnmSTq0igN2aJc6Z6+Cadm6A6UI4za/G/yvWofmEf1pRmIU3T0LphXu
 TRJgTaKS+BpmTL8NgJPwy1KKzoWXrcEjz6DLS/gj76pDZqxpFW/6K2WZwFEhK9iI
 xUYBQ+E/O/3hMdekHOrZ0QKJVDm0f2vYlWtvSxbt1ZuOXb5RYRBt2BGCjor0ax7F
 oJCoVaDeCnqBXmGaj84AEuMKD31DAjOItE3SvOqkolLhwQiVm5HrCBg9A86PM2Iv
 lCiow==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jtma09xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 07:20:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46O7K2sR020680;
 Wed, 24 Jul 2024 07:20:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jtma09xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 07:20:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46O52cbN007136; Wed, 24 Jul 2024 07:20:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72phdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 07:20:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46O7JtOA21365008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 07:19:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D5632004F;
 Wed, 24 Jul 2024 06:50:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47A7620043;
 Wed, 24 Jul 2024 06:50:16 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 06:50:16 +0000 (GMT)
Message-ID: <19c97ff6-6e25-4ae0-aab7-bbb3aa9ab3a8@linux.ibm.com>
Date: Wed, 24 Jul 2024 12:20:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] target/ppc: reduce code duplication across
 Power9/10 init code
To: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-2-adityag@linux.ibm.com>
 <D2WO0N28SBFF.DGV2VYFLHR8K@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D2WO0N28SBFF.DGV2VYFLHR8K@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yNrPnzws14SYWArqeCnJl58OrZ2CWiD3
X-Proofpoint-ORIG-GUID: kHsCZfOsDTDf0S384-0VvRTyTTRS4oN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_04,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407240050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Hi Nick,


While doing the renaming, codes similar to this come up:


 > #define PPC_INSNS_FLAGS_POWER9                                      \
 >     PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |             \
 >     PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |                   \
 >     PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES |      \
 >     PPC_FLOAT_STFIWX | PPC_FLOAT_EXT |PPC_CACHE | PPC_CACHE_ICBI |  \
 >     PPC_CACHE_DCBZ | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | \
 >     PPC_MEM_TLBSYNC | PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |  \
 >     PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD |       \
 >     PPC_CILDST

Will flag names starting with POWERPC_* be better ? (eg. 
POWERPC_INSNS_FLAGS_POWER9)

Idea behind that is, that POWERPC_* are the ones expected to be used in 
code, and the PPC_* are the flags that can be used in header files like 
this to make up some complex flags.

In above case, `PPC_INSNS_FLAGS_POWER9` and `PPC_INSNS_BASE` seem 
somewhat similar to me, but are very different considering the values.

What do you think ?


- Aditya Gupta


On 23/07/24 10:52, Nicholas Piggin wrote:
> On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
>> From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>
>> Power9/10 initialization code consists of a lot of logical OR of
>> various flag bits as supported by respective Power platform during its
>> initialization, most of which is duplicated and only selected bits are
>> added or removed as needed with each new platform support being added.
>> Remove the duplicate code and share using common macros.
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   target/ppc/cpu_init.c | 124 +++++-------------------------------------
>>   target/ppc/cpu_init.h |  78 ++++++++++++++++++++++++++
>>   2 files changed, 93 insertions(+), 109 deletions(-)
>>   create mode 100644 target/ppc/cpu_init.h
>>
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 01e358a4a5ac..3d8a112935ae 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -51,6 +51,7 @@
>>   #include "kvm_ppc.h"
>>   #endif
>>   
>> +#include "cpu_init.h"
>>   /* #define PPC_DEBUG_SPR */
>>   /* #define USE_APPLE_GDB */
>>   
>> @@ -6508,58 +6509,15 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>>       dc->fw_name = "PowerPC,POWER9";
>>       dc->desc = "POWER9";
>>       pcc->pvr_match = ppc_pvr_match_power9;
>> -    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
>> -    pcc->pcr_supported = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
>> -                         PCR_COMPAT_2_05;
>> +    pcc->pcr_mask = POWERPC_POWER9_PCC_PCR_MASK;
>> +    pcc->pcr_supported = POWERPC_POWER9_PCC_PCR_SUPPORTED;
>>       pcc->init_proc = init_proc_POWER9;
>>       pcc->check_pow = check_pow_nocheck;
>>       pcc->check_attn = check_attn_hid0_power9;
>> -    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
>> -                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
>> -                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
>> -                       PPC_FLOAT_FRSQRTES |
>> -                       PPC_FLOAT_STFIWX |
>> -                       PPC_FLOAT_EXT |
>> -                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
>> -                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
>> -                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
>> -                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
>> -                       PPC_SEGMENT_64B | PPC_SLBI |
>> -                       PPC_POPCNTB | PPC_POPCNTWD |
>> -                       PPC_CILDST;
>> -    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
>> -                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>> -                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
>> -                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
>> -                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>> -                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>> -                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_MEM_LWSYNC |
>> -                        PPC2_BCDA_ISA206;
>> -    pcc->msr_mask = (1ull << MSR_SF) |
>> -                    (1ull << MSR_HV) |
>> -                    (1ull << MSR_TM) |
>> -                    (1ull << MSR_VR) |
>> -                    (1ull << MSR_VSX) |
>> -                    (1ull << MSR_EE) |
>> -                    (1ull << MSR_PR) |
>> -                    (1ull << MSR_FP) |
>> -                    (1ull << MSR_ME) |
>> -                    (1ull << MSR_FE0) |
>> -                    (1ull << MSR_SE) |
>> -                    (1ull << MSR_DE) |
>> -                    (1ull << MSR_FE1) |
>> -                    (1ull << MSR_IR) |
>> -                    (1ull << MSR_DR) |
>> -                    (1ull << MSR_PMM) |
>> -                    (1ull << MSR_RI) |
>> -                    (1ull << MSR_LE);
>> -    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
>> -        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
>> -        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
>> -        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
>> -                             LPCR_DEE | LPCR_OEE))
>> -        | LPCR_MER | LPCR_GTSE | LPCR_TC |
>> -        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
>> +    pcc->insns_flags = POWERPC_FAMILY_POWER9_INSNS_FLAGS;
>> +    pcc->insns_flags2 = POWERPC_FAMILY_POWER9_INSNS_FLAGS2;
>> +    pcc->msr_mask = POWERPC_POWER9_PCC_MSR_MASK;
>> +    pcc->lpcr_mask = POWERPC_POWER9_PCC_LPCR_MASK;
>>       pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
>>       pcc->mmu_model = POWERPC_MMU_3_00;
>>   #if !defined(CONFIG_USER_ONLY)
>> @@ -6572,10 +6530,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>>       pcc->excp_model = POWERPC_EXCP_POWER9;
>>       pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
>>       pcc->bfd_mach = bfd_mach_ppc64;
>> -    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>> -                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
>> -                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
>> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
>> +    pcc->flags = POWERPC_POWER9_PCC_FLAGS;
>>       pcc->l1_dcache_size = 0x8000;
>>       pcc->l1_icache_size = 0x8000;
>>   }
>> @@ -6688,60 +6643,15 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
>>       dc->fw_name = "PowerPC,POWER10";
>>       dc->desc = "POWER10";
>>       pcc->pvr_match = ppc_pvr_match_power10;
>> -    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
>> -                    PCR_COMPAT_3_00;
>> -    pcc->pcr_supported = PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
>> -                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
>> +    pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
>> +    pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;
>>       pcc->init_proc = init_proc_POWER10;
>>       pcc->check_pow = check_pow_nocheck;
>>       pcc->check_attn = check_attn_hid0_power9;
>> -    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
>> -                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
>> -                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
>> -                       PPC_FLOAT_FRSQRTES |
>> -                       PPC_FLOAT_STFIWX |
>> -                       PPC_FLOAT_EXT |
>> -                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
>> -                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
>> -                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
>> -                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
>> -                       PPC_SEGMENT_64B | PPC_SLBI |
>> -                       PPC_POPCNTB | PPC_POPCNTWD |
>> -                       PPC_CILDST;
>> -    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
>> -                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>> -                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
>> -                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
>> -                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>> -                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>> -                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
>> -                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
>> -    pcc->msr_mask = (1ull << MSR_SF) |
>> -                    (1ull << MSR_HV) |
>> -                    (1ull << MSR_VR) |
>> -                    (1ull << MSR_VSX) |
>> -                    (1ull << MSR_EE) |
>> -                    (1ull << MSR_PR) |
>> -                    (1ull << MSR_FP) |
>> -                    (1ull << MSR_ME) |
>> -                    (1ull << MSR_FE0) |
>> -                    (1ull << MSR_SE) |
>> -                    (1ull << MSR_DE) |
>> -                    (1ull << MSR_FE1) |
>> -                    (1ull << MSR_IR) |
>> -                    (1ull << MSR_DR) |
>> -                    (1ull << MSR_PMM) |
>> -                    (1ull << MSR_RI) |
>> -                    (1ull << MSR_LE);
>> -    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
>> -        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
>> -        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
>> -        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
>> -                             LPCR_DEE | LPCR_OEE))
>> -        | LPCR_MER | LPCR_GTSE | LPCR_TC |
>> -        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
>> -    /* DD2 adds an extra HAIL bit */
>> -    pcc->lpcr_mask |= LPCR_HAIL;
>> +    pcc->insns_flags = POWERPC_FAMILY_POWER9_INSNS_FLAGS; /* same as P9 */
>> +    pcc->insns_flags2 = POWERPC_FAMILY_POWER10_INSNS_FLAGS2;
>> +    pcc->msr_mask = POWERPC_POWER10_PCC_MSR_MASK;
>> +    pcc->lpcr_mask = POWERPC_POWER10_PCC_LPCR_MASK;
>>   
>>       pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
>>       pcc->mmu_model = POWERPC_MMU_3_00;
>> @@ -6754,11 +6664,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
>>       pcc->excp_model = POWERPC_EXCP_POWER10;
>>       pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
>>       pcc->bfd_mach = bfd_mach_ppc64;
>> -    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>> -                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
>> -                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
>> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV |
>> -                 POWERPC_FLAG_BHRB;
>> +    pcc->flags = POWERPC_POWER10_PCC_FLAGS;
>>       pcc->l1_dcache_size = 0x8000;
>>       pcc->l1_icache_size = 0x8000;
>>   }
>> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
>> new file mode 100644
>> index 000000000000..e04be6a655d8
>> --- /dev/null
>> +++ b/target/ppc/cpu_init.h
>> @@ -0,0 +1,78 @@
>> +#ifndef TARGET_PPC_CPU_INIT_H
>> +#define TARGET_PPC_CPU_INIT_H
>> +
>> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS                           \
> I would call this PPC_INSNS_FLAGS_POWER9
>
>> +    PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |             \
>> +    PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |                   \
>> +    PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES |      \
>> +    PPC_FLOAT_STFIWX | PPC_FLOAT_EXT |PPC_CACHE | PPC_CACHE_ICBI |  \
>> +    PPC_CACHE_DCBZ | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | \
>> +    PPC_MEM_TLBSYNC | PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |  \
>> +    PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD |       \
>> +    PPC_CILDST
> Add this here
>
> #define PPC_INSNS_FLAGS_POWER10 PPC_INSNS_FLAGS_POWER9
>
>> +
>> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON                   \
> Suggest some other name change -
>
>             PPC_INSNS_FLAGS2_POWER_COMMON
>
>> +    PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
>> +    PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
>> +    PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
>> +    PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
>> +    PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
>> +    PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206
>> +
>> +#define POWERPC_FAMILY_POWER9_INSNS_FLAGS2                          \
>> +    POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON | PPC2_TM
>> +#define POWERPC_FAMILY_POWER10_INSNS_FLAGS2                         \
>> +    POWERPC_FAMILY_POWER9_INSNS_FLAGS2_COMMON | PPC2_ISA310
>> +
>> +#define POWERPC_POWER9_COMMON_PCC_MSR_MASK \
> PPC_MSR_MASK_POWER_COMMON
>
>> +    (1ull << MSR_SF) |                     \
>> +    (1ull << MSR_HV) |                     \
>> +    (1ull << MSR_VR) |                     \
>> +    (1ull << MSR_VSX) |                    \
>> +    (1ull << MSR_EE) |                     \
>> +    (1ull << MSR_PR) |                     \
>> +    (1ull << MSR_FP) |                     \
>> +    (1ull << MSR_ME) |                     \
>> +    (1ull << MSR_FE0) |                    \
>> +    (1ull << MSR_SE) |                     \
>> +    (1ull << MSR_DE) |                     \
>> +    (1ull << MSR_FE1) |                    \
>> +    (1ull << MSR_IR) |                     \
>> +    (1ull << MSR_DR) |                     \
>> +    (1ull << MSR_PMM) |                    \
>> +    (1ull << MSR_RI) |                     \
>> +    (1ull << MSR_LE)
>> +
>> +#define POWERPC_POWER9_PCC_MSR_MASK \
>> +    POWERPC_POWER9_COMMON_PCC_MSR_MASK | (1ull << MSR_TM)
> PPC_MSR_MASK_POWER9
>
>> +#define POWERPC_POWER10_PCC_MSR_MASK \
>> +    POWERPC_POWER9_COMMON_PCC_MSR_MASK
>> +#define POWERPC_POWER9_PCC_PCR_MASK \
> PPC_PCR_MASK_POWER9
>
>> +    PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07
>> +#define POWERPC_POWER10_PCC_PCR_MASK \
>> +    POWERPC_POWER9_PCC_PCR_MASK | PCR_COMPAT_3_00
>> +#define POWERPC_POWER9_PCC_PCR_SUPPORTED \
> PPC_PCR_SUPPORED_POWER9
>
> etc
>
>> +    PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
>> +#define POWERPC_POWER10_PCC_PCR_SUPPORTED \
>> +    POWERPC_POWER9_PCC_PCR_SUPPORTED | PCR_COMPAT_3_10
>> +#define POWERPC_POWER9_PCC_LPCR_MASK                                        \
>> +    LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                           \
>> +    (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |                  \
>> +    LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |                 \
>> +    (LPCR_PECE_L_MASK & (LPCR_PDEE|LPCR_HDEE|LPCR_EEE|LPCR_DEE|LPCR_OEE)) | \
>> +    LPCR_MER | LPCR_GTSE | LPCR_TC | LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE |  \
>> +    LPCR_HDICE
>> +/* DD2 adds an extra HAIL bit */
>> +#define POWERPC_POWER10_PCC_LPCR_MASK \
>> +    POWERPC_POWER9_PCC_LPCR_MASK | LPCR_HAIL
>> +#define POWERPC_POWER9_PCC_FLAGS_COMMON                                 \
> POWERPC_FLAG_POWER9
>
>> +    POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              \
>> +    POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |       \
>> +    POWERPC_FLAG_VSX | POWERPC_FLAG_SCV
>> +
>> +#define POWERPC_POWER9_PCC_FLAGS  \
>> +    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_TM
>> +#define POWERPC_POWER10_PCC_FLAGS \
>> +    POWERPC_POWER9_PCC_FLAGS_COMMON | POWERPC_FLAG_BHRB
>> +
>> +#endif /* TARGET_PPC_CPU_INIT_H */

