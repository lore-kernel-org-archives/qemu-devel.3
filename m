Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0E2C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGxq-0000ZU-0n; Wed, 26 Aug 2026 12:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzGxo-0000XT-UW; Wed, 26 Aug 2026 12:59:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzGxm-0003Al-Qu; Wed, 26 Aug 2026 12:59:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1ZCt2333849; Wed, 26 Aug 2026 16:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=IsWgiknvjW6CCFpacNQG5cJNVHOqc+
 F1E8xSmf5oopQ=; b=K5WFr7/rkLTdqIW5/ZH25aQGof/SD9eDiMk/VBI39uEhvE
 by0C+86u+5u7AiyScfcxsR4oXte4hAH7vR6U9UDL4dnXO8JKTJSkBuKgAH1QJ+3r
 z3UG/sLOkkP+ymxHi38vLrmHDPXQLeITgPIicycGjsTpOgDZ8lmbppf7VxSaUz3U
 6DIWva/BVfUOKrXf3ubjDvF3XCET+DiZiAOIYQKRqyeSFA5FIZtdj4iQuuJE+FOq
 Xd/oOskRIy2Wq1ukcce7fkOA3Po3ajrOYiMrbdp7AEw4/QSoXehbUoyCnfSW1+vS
 qyG/xlEe2ZboT4LQgrAMNEt6PoO7PjBLCp3pQFtw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqyy1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 16:58:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGvSKA008857;
 Wed, 26 Aug 2026 16:58:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhb0ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 16:58:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QGwnIJ47382964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 16:58:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C87CD2004E;
 Wed, 26 Aug 2026 16:58:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE4F820040;
 Wed, 26 Aug 2026 16:58:46 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 16:58:46 +0000 (GMT)
Date: Wed, 26 Aug 2026 22:28:49 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 31/37] target/ppc: Use PPC2_ISA207 instead of
 PPC2_BCTAR_ISA207
Message-ID: <20260826222816.1aa48369-ad-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-32-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-32-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nvmfT37RGuqaysdaLvqQs0S0r4nW3Jiu
X-Proofpoint-ORIG-GUID: 8dbJ4piXK9u8fsqp0beWCuaw8UWMUt8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX/mDkFAP7zK77
 OcUAT0hI6MeKbB+4yhRnT4KD+Aqj+5Ridn6zU3cJFqmo+ouRi9Fa5Izk5vN7/TpmsuxQw95gvCR
 zF7xar6sFe/mui/8gwseBuOB0zWmO36AuuHYHYH8a+0ao+xSxTthXUjLPJd+KYoT9GnREwt5ICP
 YpaPBrA/0G1RWCsrYeJxAl3IwzokJ/Xx2W2AWWGZZlvM/IySpT99SQN0HfTiJ14D6x+doS00OYC
 pEjwM0GVh6j1/AJJrOoAC516BgwCBHVjP3D4r2ZRd46pcSRd+BP4iVm1KOKGKEuDDfRK/ZUa2eX
 fG9NP0yCf7OE7czRdKexCukh+NZvRWEffqStSH/dlG2kYPOE0lDSgOhoGwxAaGv+ru+2ngpsyqt
 38HN9HvGoPs/yjtWNC3j6xrS1UfTqZR1jgjXbkSfrTVtVJsCg5Ffv5mGu79OujJbnFu4J1pjDP+
 lHsvFMc7lp5KOaWlS3A==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f1b4f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=8mjLFy2ysuSsC_m2tQoA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX3NNO5qrxSrTv
 RVvNLS/qd7Ednhjp47TYI2Co5mBA0jpBrrVx64JKKx1mXAECsP3oPssdFdNtw0zcn2t41GkaRdD
 xOZVSR09eANBKVrQmfNFF3Orpsf89As=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260138
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/26 10:38 AM, Chinmay Rath wrote:
> PPC2_BCTAR_ISA207 is only ever set in the CPUPPCState's insns_flags2
> alongside PPC2_ISA207. Checks made by PPC2_BCTAR_ISA207 could be
> replaced with PPC2_ISA207, hence rendering it useless and apt for
> removal. This patch does the same.
> 
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  linux-user/ppc/elfload.c               | 7 +++----
>  target/ppc/cpu.h                       | 4 +---
>  target/ppc/cpu_init.c                  | 2 +-
>  target/ppc/cpu_init.h                  | 2 +-
>  target/ppc/translate/branch-impl.c.inc | 2 +-
>  5 files changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
> index 0d54da9803..5c6065e08a 100644
> --- a/linux-user/ppc/elfload.c
> +++ b/linux-user/ppc/elfload.c
> @@ -116,10 +116,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
>      do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
>  
>      GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
> -    GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
> -    GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> -                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07 |
> -                  QEMU_PPC_FEATURE2_VEC_CRYPTO);
> +    GET_FEATURE2((PPC2_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> +                  PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
> +                  QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
>      GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
>                   QEMU_PPC_FEATURE2_DARN | QEMU_PPC_FEATURE2_HAS_IEEE128);
>      GET_FEATURE2(PPC2_ISA310, QEMU_PPC_FEATURE2_ARCH_3_1 |
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 91ef34cb21..df1e943d8d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2577,8 +2577,6 @@ enum {
>      PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
>      /* ISA 2.06B floating point test instructions                            */
>      PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
> -    /* ISA 2.07 bctar instruction                                            */
> -    PPC2_BCTAR_ISA207  = 0x0000000000001000ULL,
>      /* ISA 2.07 load/store quadword                                          */
>      PPC2_LSQ_ISA207    = 0x0000000000002000ULL,
>      /* ISA 2.07 Altivec                                                      */
> @@ -2610,7 +2608,7 @@ enum {
>                          PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
>                          PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
>                          PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
> -                        PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
> +                        PPC2_LSQ_ISA207 | \
>                          PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
>                          PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index b913edd243..c250f805a7 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6349,7 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
>      pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
>                          PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>                          PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> -                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
> +                        PPC2_FP_TST_ISA206 |
>                          PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
> index 1c41c0d349..7dd587908e 100644
> --- a/target/ppc/cpu_init.h
> +++ b/target/ppc/cpu_init.h
> @@ -17,7 +17,7 @@
>  #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
>      (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
>       PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
> -     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
> +     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
>       PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
>       PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
>       PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
> diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
> index c2889c1d12..77eac0a239 100644
> --- a/target/ppc/translate/branch-impl.c.inc
> +++ b/target/ppc/translate/branch-impl.c.inc
> @@ -210,5 +210,5 @@ static bool bclr_helper(DisasContext *ctx, arg_bclr *a, int type)
>  
>  TRANS(BCLR, bclr_helper, BCOND_LR)
>  TRANS(BCCTR, bclr_helper, BCOND_CTR)
> -TRANS_FLAGS2(BCTAR_ISA207, BCTAR, bclr_helper, BCOND_TAR)
> +TRANS_FLAGS2(ISA207, BCTAR, bclr_helper, BCOND_TAR)
>  
> -- 
> 2.55.0
> 

