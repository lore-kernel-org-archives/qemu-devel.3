Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4758EC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHM1-0000zS-Gf; Wed, 26 Aug 2026 13:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzHLt-0000xj-32; Wed, 26 Aug 2026 13:23:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzHLq-0001SS-0H; Wed, 26 Aug 2026 13:23:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1po9314345; Wed, 26 Aug 2026 17:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=YIolUnLeiHj/DSpda9CBCwGoZVKDR8
 E7zbHz7msA4Vc=; b=hsq3StoYxXQZQdrZ6QXp2hnXr7Se6NFtHzh9cr/mTV06Nn
 VF+n3Xprmmfn7rT0semqujGyBX/o3ii1Zqv7ep0ts9RNP/ajBCRge/NLwMz3Eu60
 pllSbibQweheWB3DP9obmT7gr2jTq8B5EYmGCmbE7/x2n2BxWeVeBCp8oEtbRYJl
 32tyRAKy/YjAvglM8xtEcDDiXxlyGo6ftjMdcV//jm/tT8uC7A3GVEbZIcxw9Dlx
 5OD2UZ8PB2CDi4GBKpRULua4iylgVU2xzX8lYy1QfS10ZGVbhl2eYpUFSYncBsIZ
 PFalPM8R2gLsA1AN1IREu8A5UD6DYQUOB3Hss8Bg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j07hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:23:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QHBNfo030208;
 Wed, 26 Aug 2026 17:23:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k365n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:23:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QHNgZu43975012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 17:23:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C64120043;
 Wed, 26 Aug 2026 17:23:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F020220040;
 Wed, 26 Aug 2026 17:23:38 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 17:23:38 +0000 (GMT)
Date: Wed, 26 Aug 2026 22:53:42 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 33/37] target/ppc: Use PPC2_ISA207 instead of
 PPC2_ALTIVEC_207
Message-ID: <20260826223348.9cef10ea-fe-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-34-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-34-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MiBTYWx0ZWRfXxfUxOF89oL2z
 ujCb8QRY9Uu2pFP/4oLOTBkyr8WhSi/DoRdoeotUn5UdIrFFy2QHz0z5MZWXDlQ1extKGUAkd/r
 Q81q33zfLi3Df1BNvvwdW2Dw+LNdIcM=
X-Proofpoint-GUID: yVl22JzthsLA9JHu4XgOGTThwC6z07nZ
X-Proofpoint-ORIG-GUID: 2_-bBTgGATQUTI8HGx-IQ4dHmzgYQJWd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MiBTYWx0ZWRfX/d/q3Q4pU7Nn
 Duz5iKz90q+JJ53Oam883huv6LKeE3Xjo+SGTRU5selntxoxQeGP5apckIARCT3ls2BfIePJ78A
 R7TwcdNu3D5rgaVgxhdxcOkaNIDMAj02bWnPEZfegxk7NVACjuwXPDSxDkWR7JaX3AU8tFfKjxB
 oWolEABdJ+kTSoedYfqTsEbaDvpBgn67MLJyHzhMi8a+eWlJv4gGItQcSBC/6fuOBAf0PaTUlY2
 gc7aIL8U1LE6jnZCfuBS7ux8fEZDIL56NzfN4I0FvnVsvKlXb4JL8Nekph6nWEZi9zFFgyByh+u
 p8FVa8TE6iHC7JbjVriHV9B5H+XT0zTWq27XCTYTmIm7hpyI1AgEQlqALygJvUTY/aYr/oxii+2
 iIzWPNKyiEkWlQJhSmHX7km0vczK3pJPB6EsG8igXn8hOCevL9YQUrPszVqRpQdj2w9lj+7J1un
 JlYMD1EiWJty+pNaUjQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f2123 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=2tRLy0P-N8UuIbIoC_kA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260142
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/26 10:38 AM, Chinmay Rath wrote:
> PPC2_ALTIVEC_207 is only ever set in the CPUPPCState's insns_flags2
> alongside PPC2_ISA207. Checks made by PPC2_ALTIVEC_207 could be
> replaced with PPC2_ISA207, hence rendering it useless and apt for
> removal. This patch does the same.
> 
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  linux-user/ppc/elfload.c            |   3 +-
>  target/ppc/cpu.h                    |   4 +-
>  target/ppc/cpu_init.c               |   2 +-
>  target/ppc/cpu_init.h               |   3 +-
>  target/ppc/translate/vmx-impl.c.inc | 102 ++++++++++++++--------------
>  target/ppc/translate/vmx-ops.c.inc  |  18 ++---
>  6 files changed, 64 insertions(+), 68 deletions(-)

For patches 33-36/37,

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
> index 76ab9f43de..8c40f1a663 100644
> --- a/linux-user/ppc/elfload.c
> +++ b/linux-user/ppc/elfload.c
> @@ -116,8 +116,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
>      do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
>  
>      GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
> -    GET_FEATURE2((PPC2_ISA207 | PPC2_ALTIVEC_207 |
> -                  PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
> +    GET_FEATURE2((PPC2_ISA207 | PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
>                    QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
>      GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
>                   QEMU_PPC_FEATURE2_DARN | QEMU_PPC_FEATURE2_HAS_IEEE128);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b3cd8d85df..00676cea2b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2577,8 +2577,6 @@ enum {
>      PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
>      /* ISA 2.06B floating point test instructions                            */
>      PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
> -    /* ISA 2.07 Altivec                                                      */
> -    PPC2_ALTIVEC_207   = 0x0000000000004000ULL,
>      /* PowerISA 2.07 Book3s specification                                    */
>      PPC2_ISA207S       = 0x0000000000008000ULL,
>      /* Double precision floating point conversion for signed integer 64      */
> @@ -2606,7 +2604,7 @@ enum {
>                          PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
>                          PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
>                          PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
> -                        PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
> +                        PPC2_ISA207S | PPC2_DFP | \
>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
>                          PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
>                          PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 4cc8b93dca..c251426b2e 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6349,7 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
>      pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
>                          PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>                          PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> -                        PPC2_FP_TST_ISA206 | PPC2_ALTIVEC_207 |
> +                        PPC2_FP_TST_ISA206 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
>                          PPC2_BCDA_ISA206;
> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
> index 6961007926..73f014c82a 100644
> --- a/target/ppc/cpu_init.h
> +++ b/target/ppc/cpu_init.h
> @@ -17,8 +17,7 @@
>  #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
>      (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
>       PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
> -     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
> -     PPC2_ALTIVEC_207 | PPC2_ISA205 |                                \
> +     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_ISA205 |         \
>       PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
>       PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
>  
> diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
> index 4e7fe22156..486f5c2151 100644
> --- a/target/ppc/translate/vmx-impl.c.inc
> +++ b/target/ppc/translate/vmx-impl.c.inc
> @@ -351,14 +351,14 @@ static bool do_vx_vaddsubm(DisasContext *ctx, arg_VX *a, MemOp vece,
>  TRANS_FLAGS(ALTIVEC, VADDUBM, do_vx_vaddsubm, MO_8, tcg_gen_gvec_add)
>  TRANS_FLAGS(ALTIVEC, VADDUHM, do_vx_vaddsubm, MO_16, tcg_gen_gvec_add)
>  TRANS_FLAGS(ALTIVEC, VADDUWM, do_vx_vaddsubm, MO_32, tcg_gen_gvec_add)
> -TRANS_FLAGS2(ALTIVEC_207, VADDUDM, do_vx_vaddsubm, MO_64, tcg_gen_gvec_add)
> +TRANS_FLAGS2(ISA207, VADDUDM, do_vx_vaddsubm, MO_64, tcg_gen_gvec_add)
>  
>  TRANS_FLAGS(ALTIVEC, VSUBUBM, do_vx_vaddsubm, MO_8, tcg_gen_gvec_sub)
>  TRANS_FLAGS(ALTIVEC, VSUBUHM, do_vx_vaddsubm, MO_16, tcg_gen_gvec_sub)
>  TRANS_FLAGS(ALTIVEC, VSUBUWM, do_vx_vaddsubm, MO_32, tcg_gen_gvec_sub)
> -TRANS_FLAGS2(ALTIVEC_207, VSUBUDM, do_vx_vaddsubm, MO_64, tcg_gen_gvec_sub)
> +TRANS_FLAGS2(ISA207, VSUBUDM, do_vx_vaddsubm, MO_64, tcg_gen_gvec_sub)
>  
> -TRANS_FLAGS2(ALTIVEC_207, VMULUWM, do_vx_vaddsubm, MO_32, tcg_gen_gvec_mul)
> +TRANS_FLAGS2(ISA207, VMULUWM, do_vx_vaddsubm, MO_32, tcg_gen_gvec_mul)
>  
>  TRANS_FLAGS2(ISA300, VMUL10CUQ, do_vx_vmul10, false, true)
>  TRANS_FLAGS2(ISA300, VMUL10ECUQ, do_vx_vmul10, true, true)
> @@ -699,22 +699,22 @@ static bool do_vector_gvec3_VX(DisasContext *ctx, arg_VX *a, int vece,
>  TRANS_FLAGS(ALTIVEC, VSLB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_shlv);
>  TRANS_FLAGS(ALTIVEC, VSLH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_shlv);
>  TRANS_FLAGS(ALTIVEC, VSLW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_shlv);
> -TRANS_FLAGS2(ALTIVEC_207, VSLD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_shlv);
> +TRANS_FLAGS2(ISA207, VSLD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_shlv);
>  
>  TRANS_FLAGS(ALTIVEC, VSRB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_shrv);
>  TRANS_FLAGS(ALTIVEC, VSRH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_shrv);
>  TRANS_FLAGS(ALTIVEC, VSRW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_shrv);
> -TRANS_FLAGS2(ALTIVEC_207, VSRD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_shrv);
> +TRANS_FLAGS2(ISA207, VSRD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_shrv);
>  
>  TRANS_FLAGS(ALTIVEC, VSRAB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_sarv);
>  TRANS_FLAGS(ALTIVEC, VSRAH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_sarv);
>  TRANS_FLAGS(ALTIVEC, VSRAW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_sarv);
> -TRANS_FLAGS2(ALTIVEC_207, VSRAD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_sarv);
> +TRANS_FLAGS2(ISA207, VSRAD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_sarv);
>  
>  TRANS_FLAGS(ALTIVEC, VRLB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_rotlv)
>  TRANS_FLAGS(ALTIVEC, VRLH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_rotlv)
>  TRANS_FLAGS(ALTIVEC, VRLW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_rotlv)
> -TRANS_FLAGS2(ALTIVEC_207, VRLD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_rotlv)
> +TRANS_FLAGS2(ISA207, VRLD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_rotlv)
>  
>  /* Logical operations */
>  TRANS_FLAGS(ALTIVEC, VAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_and);
> @@ -722,30 +722,30 @@ TRANS_FLAGS(ALTIVEC, VANDC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_andc);
>  TRANS_FLAGS(ALTIVEC, VOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_or);
>  TRANS_FLAGS(ALTIVEC, VXOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_xor);
>  TRANS_FLAGS(ALTIVEC, VNOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nor);
> -TRANS_FLAGS2(ALTIVEC_207, VEQV, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_eqv);
> -TRANS_FLAGS2(ALTIVEC_207, VNAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nand);
> -TRANS_FLAGS2(ALTIVEC_207, VORC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_orc);
> +TRANS_FLAGS2(ISA207, VEQV, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_eqv);
> +TRANS_FLAGS2(ISA207, VNAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nand);
> +TRANS_FLAGS2(ISA207, VORC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_orc);
>  
>  /* Integer Max/Min operations */
>  TRANS_FLAGS(ALTIVEC, VMAXUB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_umax);
>  TRANS_FLAGS(ALTIVEC, VMAXUH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_umax);
>  TRANS_FLAGS(ALTIVEC, VMAXUW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_umax);
> -TRANS_FLAGS2(ALTIVEC_207, VMAXUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umax);
> +TRANS_FLAGS2(ISA207, VMAXUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umax);
>  
>  TRANS_FLAGS(ALTIVEC, VMAXSB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_smax);
>  TRANS_FLAGS(ALTIVEC, VMAXSH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_smax);
>  TRANS_FLAGS(ALTIVEC, VMAXSW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_smax);
> -TRANS_FLAGS2(ALTIVEC_207, VMAXSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smax);
> +TRANS_FLAGS2(ISA207, VMAXSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smax);
>  
>  TRANS_FLAGS(ALTIVEC, VMINUB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_umin);
>  TRANS_FLAGS(ALTIVEC, VMINUH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_umin);
>  TRANS_FLAGS(ALTIVEC, VMINUW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_umin);
> -TRANS_FLAGS2(ALTIVEC_207, VMINUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umin);
> +TRANS_FLAGS2(ISA207, VMINUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umin);
>  
>  TRANS_FLAGS(ALTIVEC, VMINSB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_smin);
>  TRANS_FLAGS(ALTIVEC, VMINSH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_smin);
>  TRANS_FLAGS(ALTIVEC, VMINSW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_smin);
> -TRANS_FLAGS2(ALTIVEC_207, VMINSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smin);
> +TRANS_FLAGS2(ISA207, VMINSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smin);
>  
>  static TCGv_vec do_vrl_mask_vec(unsigned vece, TCGv_vec vrb)
>  {
> @@ -1091,16 +1091,16 @@ static bool do_vpk(DisasContext *ctx, arg_VX *a,
>  
>  TRANS_FLAGS(ALTIVEC, VPKUHUM, do_vpk_env, gen_helper_VPKUHUM)
>  TRANS_FLAGS(ALTIVEC, VPKUWUM, do_vpk_env, gen_helper_VPKUWUM)
> -TRANS_FLAGS2(ALTIVEC_207, VPKUDUM, do_vpk_env, gen_helper_VPKUDUM)
> +TRANS_FLAGS2(ISA207, VPKUDUM, do_vpk_env, gen_helper_VPKUDUM)
>  TRANS_FLAGS(ALTIVEC, VPKUHUS, do_vpk_env, gen_helper_VPKUHUS)
>  TRANS_FLAGS(ALTIVEC, VPKUWUS, do_vpk_env, gen_helper_VPKUWUS)
> -TRANS_FLAGS2(ALTIVEC_207, VPKUDUS, do_vpk_env, gen_helper_VPKUDUS)
> +TRANS_FLAGS2(ISA207, VPKUDUS, do_vpk_env, gen_helper_VPKUDUS)
>  TRANS_FLAGS(ALTIVEC, VPKSHUS, do_vpk_env, gen_helper_VPKSHUS)
>  TRANS_FLAGS(ALTIVEC, VPKSWUS, do_vpk_env, gen_helper_VPKSWUS)
> -TRANS_FLAGS2(ALTIVEC_207, VPKSDUS, do_vpk_env, gen_helper_VPKSDUS)
> +TRANS_FLAGS2(ISA207, VPKSDUS, do_vpk_env, gen_helper_VPKSDUS)
>  TRANS_FLAGS(ALTIVEC, VPKSHSS, do_vpk_env, gen_helper_VPKSHSS)
>  TRANS_FLAGS(ALTIVEC, VPKSWSS, do_vpk_env, gen_helper_VPKSWSS)
> -TRANS_FLAGS2(ALTIVEC_207, VPKSDSS, do_vpk_env, gen_helper_VPKSDSS)
> +TRANS_FLAGS2(ISA207, VPKSDSS, do_vpk_env, gen_helper_VPKSDSS)
>  TRANS_FLAGS(ALTIVEC, VPKPX, do_vpk, gen_helper_VPKPX)
>  GEN_VXFORM_ENV(vsum4ubs, 4, 24);
>  GEN_VXFORM_ENV(vsum4sbs, 4, 28);
> @@ -1114,12 +1114,12 @@ GEN_VXFORM_ENV(vminfp, 5, 17);
>  GEN_VXFORM_HETRO(vextublx, 6, 24)
>  GEN_VXFORM_HETRO(vextuhlx, 6, 25)
>  GEN_VXFORM_HETRO(vextuwlx, 6, 26)
> -GEN_VXFORM_TRANS_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
> +GEN_VXFORM_TRANS_DUAL(vmrgow, PPC_NONE, PPC2_ISA207,
>                  vextuwlx, PPC_NONE, PPC2_ISA300)
>  GEN_VXFORM_HETRO(vextubrx, 6, 28)
>  GEN_VXFORM_HETRO(vextuhrx, 6, 29)
>  GEN_VXFORM_HETRO(vextuwrx, 6, 30)
> -GEN_VXFORM_TRANS_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207,
> +GEN_VXFORM_TRANS_DUAL(vmrgew, PPC_NONE, PPC2_ISA207,
>                  vextuwrx, PPC_NONE, PPC2_ISA300)
>  
>  #define GEN_VXRFORM1(opname, name, str, opc2, opc3)                     \
> @@ -1209,16 +1209,16 @@ static bool do_vcmp(DisasContext *ctx, arg_VC *a, TCGCond cond, int vece)
>  TRANS_FLAGS(ALTIVEC, VCMPEQUB, do_vcmp, TCG_COND_EQ, MO_8)
>  TRANS_FLAGS(ALTIVEC, VCMPEQUH, do_vcmp, TCG_COND_EQ, MO_16)
>  TRANS_FLAGS(ALTIVEC, VCMPEQUW, do_vcmp, TCG_COND_EQ, MO_32)
> -TRANS_FLAGS2(ALTIVEC_207, VCMPEQUD, do_vcmp, TCG_COND_EQ, MO_64)
> +TRANS_FLAGS2(ISA207, VCMPEQUD, do_vcmp, TCG_COND_EQ, MO_64)
>  
>  TRANS_FLAGS(ALTIVEC, VCMPGTSB, do_vcmp, TCG_COND_GT, MO_8)
>  TRANS_FLAGS(ALTIVEC, VCMPGTSH, do_vcmp, TCG_COND_GT, MO_16)
>  TRANS_FLAGS(ALTIVEC, VCMPGTSW, do_vcmp, TCG_COND_GT, MO_32)
> -TRANS_FLAGS2(ALTIVEC_207, VCMPGTSD, do_vcmp, TCG_COND_GT, MO_64)
> +TRANS_FLAGS2(ISA207, VCMPGTSD, do_vcmp, TCG_COND_GT, MO_64)
>  TRANS_FLAGS(ALTIVEC, VCMPGTUB, do_vcmp, TCG_COND_GTU, MO_8)
>  TRANS_FLAGS(ALTIVEC, VCMPGTUH, do_vcmp, TCG_COND_GTU, MO_16)
>  TRANS_FLAGS(ALTIVEC, VCMPGTUW, do_vcmp, TCG_COND_GTU, MO_32)
> -TRANS_FLAGS2(ALTIVEC_207, VCMPGTUD, do_vcmp, TCG_COND_GTU, MO_64)
> +TRANS_FLAGS2(ISA207, VCMPGTUD, do_vcmp, TCG_COND_GTU, MO_64)
>  
>  TRANS_FLAGS2(ISA300, VCMPNEB, do_vcmp, TCG_COND_NE, MO_8)
>  TRANS_FLAGS2(ISA300, VCMPNEH, do_vcmp, TCG_COND_NE, MO_16)
> @@ -2330,11 +2330,11 @@ static bool do_va_helper(DisasContext *ctx, arg_VA *a,
>      return true;
>  }
>  
> -TRANS_FLAGS2(ALTIVEC_207, VADDECUQ, do_va_helper, gen_helper_VADDECUQ)
> -TRANS_FLAGS2(ALTIVEC_207, VADDEUQM, do_va_helper, gen_helper_VADDEUQM)
> +TRANS_FLAGS2(ISA207, VADDECUQ, do_va_helper, gen_helper_VADDECUQ)
> +TRANS_FLAGS2(ISA207, VADDEUQM, do_va_helper, gen_helper_VADDEUQM)
>  
> -TRANS_FLAGS2(ALTIVEC_207, VSUBEUQM, do_va_helper, gen_helper_VSUBEUQM)
> -TRANS_FLAGS2(ALTIVEC_207, VSUBECUQ, do_va_helper, gen_helper_VSUBECUQ)
> +TRANS_FLAGS2(ISA207, VSUBEUQM, do_va_helper, gen_helper_VSUBEUQM)
> +TRANS_FLAGS2(ISA207, VSUBECUQ, do_va_helper, gen_helper_VSUBECUQ)
>  
>  TRANS_FLAGS(ALTIVEC, VPERM, do_va_helper, gen_helper_VPERM)
>  TRANS_FLAGS2(ISA300, VPERMR, do_va_helper, gen_helper_VPERMR)
> @@ -2502,14 +2502,14 @@ GEN_VXFORM_NOA(vpopcntb, 1, 28)
>  GEN_VXFORM_NOA(vpopcnth, 1, 29)
>  GEN_VXFORM_NOA(vpopcntw, 1, 30)
>  GEN_VXFORM_NOA(vpopcntd, 1, 31)
> -GEN_VXFORM_DUAL(vclzb, PPC_NONE, PPC2_ALTIVEC_207, \
> -                vpopcntb, PPC_NONE, PPC2_ALTIVEC_207)
> -GEN_VXFORM_DUAL(vclzh, PPC_NONE, PPC2_ALTIVEC_207, \
> -                vpopcnth, PPC_NONE, PPC2_ALTIVEC_207)
> -GEN_VXFORM_DUAL(vclzw, PPC_NONE, PPC2_ALTIVEC_207, \
> -                vpopcntw, PPC_NONE, PPC2_ALTIVEC_207)
> -GEN_VXFORM_DUAL(vclzd, PPC_NONE, PPC2_ALTIVEC_207, \
> -                vpopcntd, PPC_NONE, PPC2_ALTIVEC_207)
> +GEN_VXFORM_DUAL(vclzb, PPC_NONE, PPC2_ISA207, \
> +                vpopcntb, PPC_NONE, PPC2_ISA207)
> +GEN_VXFORM_DUAL(vclzh, PPC_NONE, PPC2_ISA207, \
> +                vpopcnth, PPC_NONE, PPC2_ISA207)
> +GEN_VXFORM_DUAL(vclzw, PPC_NONE, PPC2_ISA207, \
> +                vpopcntw, PPC_NONE, PPC2_ISA207)
> +GEN_VXFORM_DUAL(vclzd, PPC_NONE, PPC2_ISA207, \
> +                vpopcntd, PPC_NONE, PPC2_ISA207)
>  GEN_VXFORM(vbpermd, 6, 23);
>  GEN_VXFORM(vbpermq, 6, 21);
>  GEN_VXFORM_TRANS(vgbbd, 6, 20);
> @@ -2589,8 +2589,8 @@ static bool do_bcd_tb_ps(DisasContext *ctx, arg_VX_tb_ps *a,
>      return true;
>  }
>  
> -TRANS_FLAGS2(ALTIVEC_207, BCDADD, do_bcd_ps, gen_helper_BCDADD)
> -TRANS_FLAGS2(ALTIVEC_207, BCDSUB, do_bcd_ps, gen_helper_BCDSUB)
> +TRANS_FLAGS2(ISA207, BCDADD, do_bcd_ps, gen_helper_BCDADD)
> +TRANS_FLAGS2(ISA207, BCDSUB, do_bcd_ps, gen_helper_BCDSUB)
>  TRANS_FLAGS2(ISA300, BCDUS, do_bcd, gen_helper_BCDUS)
>  TRANS_FLAGS2(ISA300, BCDS, do_bcd_ps, gen_helper_BCDS)
>  TRANS_FLAGS2(ISA300, BCDCFN, do_bcd_tb_ps, gen_helper_BCDCFN)
> @@ -2622,10 +2622,10 @@ GEN_VXFORM(vcipherlast, 4, 20)
>  GEN_VXFORM(vncipher, 4, 21)
>  GEN_VXFORM(vncipherlast, 4, 21)
>  
> -GEN_VXFORM_DUAL(vcipher, PPC_NONE, PPC2_ALTIVEC_207,
> -                vcipherlast, PPC_NONE, PPC2_ALTIVEC_207)
> -GEN_VXFORM_DUAL(vncipher, PPC_NONE, PPC2_ALTIVEC_207,
> -                vncipherlast, PPC_NONE, PPC2_ALTIVEC_207)
> +GEN_VXFORM_DUAL(vcipher, PPC_NONE, PPC2_ISA207,
> +                vcipherlast, PPC_NONE, PPC2_ISA207)
> +GEN_VXFORM_DUAL(vncipher, PPC_NONE, PPC2_ISA207,
> +                vncipherlast, PPC_NONE, PPC2_ISA207)
>  
>  #define VSHASIGMA(op)                         \
>  static void gen_##op(DisasContext *ctx)       \
> @@ -2647,7 +2647,7 @@ VSHASIGMA(vshasigmad)
>  
>  GEN_VXFORM3(vpermxor, 22, 0xFF)
>  GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
> -                vpermxor, PPC_NONE, PPC2_ALTIVEC_207)
> +                vpermxor, PPC_NONE, PPC2_ISA207)
>  
>  static bool trans_VCFUGED(DisasContext *ctx, arg_VX *a)
>  {
> @@ -2815,13 +2815,13 @@ static bool do_vx_helper(DisasContext *ctx, arg_VX *a,
>      return true;
>  }
>  
> -TRANS_FLAGS2(ALTIVEC_207, VADDCUQ, do_vx_helper, gen_helper_VADDCUQ)
> -TRANS_FLAGS2(ALTIVEC_207, VADDUQM, do_vx_helper, gen_helper_VADDUQM)
> +TRANS_FLAGS2(ISA207, VADDCUQ, do_vx_helper, gen_helper_VADDCUQ)
> +TRANS_FLAGS2(ISA207, VADDUQM, do_vx_helper, gen_helper_VADDUQM)
>  
> -TRANS_FLAGS2(ALTIVEC_207, VPMSUMD, do_vx_helper, gen_helper_VPMSUMD)
> +TRANS_FLAGS2(ISA207, VPMSUMD, do_vx_helper, gen_helper_VPMSUMD)
>  
> -TRANS_FLAGS2(ALTIVEC_207, VSUBCUQ, do_vx_helper, gen_helper_VSUBCUQ)
> -TRANS_FLAGS2(ALTIVEC_207, VSUBUQM, do_vx_helper, gen_helper_VSUBUQM)
> +TRANS_FLAGS2(ISA207, VSUBCUQ, do_vx_helper, gen_helper_VSUBCUQ)
> +TRANS_FLAGS2(ISA207, VSUBUQM, do_vx_helper, gen_helper_VSUBUQM)
>  
>  static void gen_VADDCUW_vec(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
>  {
> @@ -3092,10 +3092,10 @@ TRANS_FLAGS(ALTIVEC, VMULESH, do_vx_helper, gen_helper_VMULESH)
>  TRANS_FLAGS(ALTIVEC, VMULOSH, do_vx_helper, gen_helper_VMULOSH)
>  TRANS_FLAGS(ALTIVEC, VMULEUH, do_vx_helper, gen_helper_VMULEUH)
>  TRANS_FLAGS(ALTIVEC, VMULOUH, do_vx_helper, gen_helper_VMULOUH)
> -TRANS_FLAGS2(ALTIVEC_207, VMULESW, do_vx_helper, gen_helper_VMULESW)
> -TRANS_FLAGS2(ALTIVEC_207, VMULOSW, do_vx_helper, gen_helper_VMULOSW)
> -TRANS_FLAGS2(ALTIVEC_207, VMULEUW, do_vx_helper, gen_helper_VMULEUW)
> -TRANS_FLAGS2(ALTIVEC_207, VMULOUW, do_vx_helper, gen_helper_VMULOUW)
> +TRANS_FLAGS2(ISA207, VMULESW, do_vx_helper, gen_helper_VMULESW)
> +TRANS_FLAGS2(ISA207, VMULOSW, do_vx_helper, gen_helper_VMULOSW)
> +TRANS_FLAGS2(ISA207, VMULEUW, do_vx_helper, gen_helper_VMULEUW)
> +TRANS_FLAGS2(ISA207, VMULOUW, do_vx_helper, gen_helper_VMULOUW)
>  TRANS_FLAGS2(ISA310, VMULESD, do_vx_vmuleo, true , tcg_gen_muls2_i64)
>  TRANS_FLAGS2(ISA310, VMULOSD, do_vx_vmuleo, false, tcg_gen_muls2_i64)
>  TRANS_FLAGS2(ISA310, VMULEUD, do_vx_vmuleo, true , tcg_gen_mulu2_i64)
> diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
> index c1951c6975..2facbc7cb4 100644
> --- a/target/ppc/translate/vmx-ops.c.inc
> +++ b/target/ppc/translate/vmx-ops.c.inc
> @@ -2,7 +2,7 @@
>  GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_ALTIVEC)
>  
>  #define GEN_VXFORM_207(name, opc2, opc3) \
> -GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ALTIVEC_207)
> +GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ISA207)
>  
>  #define GEN_VXFORM_300(name, opc2, opc3)                                \
>  GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ISA300)
> @@ -26,10 +26,10 @@ GEN_HANDLER_E(name0##_##name1, 0x4, opc2, (opc3 | 0x10), 0x00000000, tp0, tp1),
>  
>  GEN_VXFORM_300(vextublx, 6, 24),
>  GEN_VXFORM_300(vextuhlx, 6, 25),
> -GEN_VXFORM_DUAL(vmrgow, vextuwlx, 6, 26, PPC_NONE, PPC2_ALTIVEC_207),
> +GEN_VXFORM_DUAL(vmrgow, vextuwlx, 6, 26, PPC_NONE, PPC2_ISA207),
>  GEN_VXFORM_300(vextubrx, 6, 28),
>  GEN_VXFORM_300(vextuhrx, 6, 29),
> -GEN_VXFORM_DUAL(vmrgew, vextuwrx, 6, 30, PPC_NONE, PPC2_ALTIVEC_207),
> +GEN_VXFORM_DUAL(vmrgew, vextuwrx, 6, 30, PPC_NONE, PPC2_ISA207),
>  GEN_VXFORM_300(vsrv, 2, 28),
>  GEN_VXFORM_300(vslv, 2, 29),
>  GEN_VXFORM(vslo, 6, 16),
> @@ -113,10 +113,10 @@ GEN_VXFORM_UIMM(vctsxs, 5, 15),
>      GEN_HANDLER(name0##_##name1, 0x04, opc2, 0xFF, 0x00000000, PPC_ALTIVEC)
>  GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23),
>  
> -GEN_VXFORM_DUAL(vclzb, vpopcntb, 1, 28, PPC_NONE, PPC2_ALTIVEC_207),
> -GEN_VXFORM_DUAL(vclzh, vpopcnth, 1, 29, PPC_NONE, PPC2_ALTIVEC_207),
> -GEN_VXFORM_DUAL(vclzw, vpopcntw, 1, 30, PPC_NONE, PPC2_ALTIVEC_207),
> -GEN_VXFORM_DUAL(vclzd, vpopcntd, 1, 31, PPC_NONE, PPC2_ALTIVEC_207),
> +GEN_VXFORM_DUAL(vclzb, vpopcntb, 1, 28, PPC_NONE, PPC2_ISA207),
> +GEN_VXFORM_DUAL(vclzh, vpopcnth, 1, 29, PPC_NONE, PPC2_ISA207),
> +GEN_VXFORM_DUAL(vclzw, vpopcntw, 1, 30, PPC_NONE, PPC2_ISA207),
> +GEN_VXFORM_DUAL(vclzd, vpopcntd, 1, 31, PPC_NONE, PPC2_ISA207),
>  
>  GEN_VXFORM_300(vbpermd, 6, 23),
>  GEN_VXFORM_207(vbpermq, 6, 21),
> @@ -127,8 +127,8 @@ GEN_VXFORM_207(vpmsumw, 4, 18),
>  
>  GEN_VXFORM_207(vsbox, 4, 23),
>  
> -GEN_VXFORM_DUAL(vcipher, vcipherlast, 4, 20, PPC_NONE, PPC2_ALTIVEC_207),
> -GEN_VXFORM_DUAL(vncipher, vncipherlast, 4, 21, PPC_NONE, PPC2_ALTIVEC_207),
> +GEN_VXFORM_DUAL(vcipher, vcipherlast, 4, 20, PPC_NONE, PPC2_ISA207),
> +GEN_VXFORM_DUAL(vncipher, vncipherlast, 4, 21, PPC_NONE, PPC2_ISA207),
>  
>  GEN_VXFORM_207(vshasigmaw, 1, 26),
>  GEN_VXFORM_207(vshasigmad, 1, 27),
> -- 
> 2.55.0
> 

