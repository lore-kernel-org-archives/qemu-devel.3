Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58B6C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzCF-0001w5-BB; Mon, 17 Aug 2026 11:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzCD-0001oq-PC; Mon, 17 Aug 2026 11:24:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzCC-0004IB-0k; Mon, 17 Aug 2026 11:24:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HCW9C91442512; Mon, 17 Aug 2026 15:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Fup164CRur8m4SQbrcx+CFFPKS2IzjPoPy5nhMiNJ2M=; b=IgXzgUEh0Vqf
 SbxmAoXORunvLtr40YyxLqnMisx5RxosXIoWte2ce4QeAjTh6CnfrGRatcRadMGq
 uUOqSQ/o0oU+UwyENXA3X8mHhcf/Exum0GY8ncCKcMBReJKg2h4lgY0B9rRRh5lK
 xfZW/sOp9HaVojr5WsyxIwlko2pedZ1oUjkuIZBkzD4LoTGQDJo9J0873ttYzIK0
 bOf+MGuob2yDHe6UBcmVRvnMgxoc4b8lv5KsNlfc810mJRb9XsdaSGYMaFmonLf4
 UZbGMliIKJb9qYLtd41E4IjmPu6jt3fSCIjfnv/4dGqDgeQsOjDRw4eO6G0V1Plr
 g6tEz9rSlg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt2jhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:24:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFBLLE029367;
 Mon, 17 Aug 2026 15:24:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejxjq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:24:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HFOB8U7340874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:24:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACF8B5805D;
 Mon, 17 Aug 2026 15:24:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE66158043;
 Mon, 17 Aug 2026 15:24:10 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 15:24:10 +0000 (GMT)
Message-ID: <d4c3b1748eb6ed9a2a7dfd6976febef0b80aba29.camel@linux.ibm.com>
Subject: Re: [PATCH 2/7] target/ppc: Use PPC2_ISA207 instead of
 PPC2_BCTAR_ISA207
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, shivangu@linux.ibm.com
Date: Mon, 17 Aug 2026 10:24:10 -0500
In-Reply-To: <20260715125634.2107320-3-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-3-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a83279d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=kshhySTPaHNGVXVxPAUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfXzT1NUuN421To
 JZ6Ukzj+PP/mwQPxhwV5J1+KUqaIdLZQMeaz0NE+MUa+Go45cxyIfGXwHqRO9M8Vf7z0bI8uK9J
 GeVUiipwxrDFlgi9Y/fcaRd1tty2iC8=
X-Proofpoint-GUID: JYwRw-yjQyyDiNdTKd12L9Y7mu6K7Lvj
X-Proofpoint-ORIG-GUID: oKhSi5B5a3uQsHUFIqIXA562CGhjE8pE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX5eCKTOWdiGkw
 Ibg1YxESETd1x23RS7drq8linLecnS5WlT97R7b1S3WIFl6Nm8jIRsB1GOlLxamxT8ZOeIlnuI3
 DX7e+m5flPQp2Lly33Bd7Rz1K7VBmYIeh5lDgOoiByaEui3rI0e8qCItyC+V9Ay+TOC9lH9tAgf
 1a+qQfKMUXDCJGJlDFQJvZXXdAKdmlS3nh9TwQvoc231EnadOyRAqf0nEq/g14v8LkzSWVfZpRF
 TOJRAr9G+58tO4w9yHDxz60eX7uvewqrUEQkrPVkooY8GOoUiVnT0aVu3l9tl9OUxYfJNvulwbR
 n1PEG8v+2wQtWF+N4Vn353yYpyeos8a0MUEPSc5Z9mwlmWiGnxpzjsDbpAaTRz/pe8f81hOe3k1
 D1HSyNrmIoM5QOXDrMJ8OPuJO/DF8z/hCUkUvd9WIL3t42nKKBh2yVJFa9h7bPwoEfYtBz4o8fD
 1OJ9+x9bpI20zjUsQhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170115
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Wed, 2026-07-15 at 18:26 +0530, Chinmay Rath wrote:
> PPC2_BCTAR_ISA207 is only ever set in the CPUPPCState's insns_flags2
> alongside PPC2_ISA207. Checks made by PPC2_BCTAR_ISA207 could be
> replaced with PPC2_ISA207, hence rendering is useless and apt for
> removal. This patch does the same.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  linux-user/ppc/elfload.c | 7 +++----
>  target/ppc/cpu.h         | 4 +---
>  target/ppc/cpu_init.c    | 2 +-
>  target/ppc/cpu_init.h    | 2 +-
>  4 files changed, 6 insertions(+), 9 deletions(-)
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
> index de33ac3a88..be8b3c447d 100644
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


