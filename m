Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A481BC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzFN-0001CN-Bt; Mon, 17 Aug 2026 11:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzFC-0001AT-Rm; Mon, 17 Aug 2026 11:27:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzF7-00051d-Jh; Mon, 17 Aug 2026 11:27:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HCW2eN1392861; Mon, 17 Aug 2026 15:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=ANfYrCtwo9DI38ySs3jJfKV9TGm7/FOK6WeakKpglik=; b=ToFNR09CdNFw
 EYSAw6gmktF6S+SnScO5lNll/ylf7JZ9kqGSux/2QLtlQtjxi8//rrFOppMIVk/V
 oCKfXbyrlRGYx7Oql36NJZzq2uhrguHdZnvsJ8WLTcmHWc/+6A3IfgcxEMbLlO/a
 5i6fmdhP+XYnmQb1ylZYC1pJttvSaDfzhjw1AACzr5gNk+gfALYq8jrPVpNj/dm8
 g0LsIxNkezXMt6MI/kx4FkgBauN5zKfNaFFA+i+5jck1IpBq4/TGNInynX8onvra
 TMMWiAyCkM4usN6RKncfqPsnOsWm1DSi197eHYS0Reops46NqxVpryUmqbwWIP/n
 f4cRLlinOw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4k0rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:27:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFBQH7005026;
 Mon, 17 Aug 2026 15:27:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y6a9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:27:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HFRBF14522706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:27:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 169BE58059;
 Mon, 17 Aug 2026 15:27:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5063458055;
 Mon, 17 Aug 2026 15:27:10 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 15:27:10 +0000 (GMT)
Message-ID: <06de4e9aaa67d961bfe259683152bc434355ae1e.camel@linux.ibm.com>
Subject: Re: [PATCH 4/7] target/ppc: Use PPC2_ISA207 instead of
 PPC2_ALTIVEC_207
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, shivangu@linux.ibm.com
Date: Mon, 17 Aug 2026 10:27:09 -0500
In-Reply-To: <20260715125634.2107320-5-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-5-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EeCbgS8IMDT242EFbrBi6bKz_O69gSCv
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a832851 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=2tRLy0P-N8UuIbIoC_kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfXxxtcjKVTcFfZ
 /gKSVgI+xr7owT4OVoVyRM/JxStdHrl5gPdWCwc3TDvqNYyUyvHlrv9uDyoJnpoa3/VZIPPyqf/
 1O6rrPvXzMvVFL8++UPJuGisxGgQb+s=
X-Proofpoint-ORIG-GUID: sMkEjJC_CIIS3utV6_HEnj8em3_Uxfoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX/24FO8ruHDaB
 jT5woqfaQgKP8AKZs8zKFFEAxv4ocmSMjLuDCRrXiOnVVKqlJIELB6KoVG/XiWDvWBQqt8UVqAX
 BFz0av6XhqbeZtjXhTxp0GD11+LEzfF/fswNz8dHoshxZy6qxQfd3MaL81Z+DNogh9RGGmWG5kk
 h9drBFO7qKRuUxs0E2+IBK7nTr0Tv+n1FXx3aUHj/KTAA4ed5P5WwQOlyUOaskT3FDo4X3LlXyj
 7aYM1T3l+nuIHChVZzuVlq++ZFuZWAshpjSu7rcrYOiC1GtWFrswlNJK/mkZOQ5gRhry9wrmGZR
 XnCSBsprRslDp6gAu4/1nba10RT5gBKUme+IABO5qmoZiE/ZOTVfuwu8DZvKKp2FL/r3NlMGuvr
 ghoLjwoJFrAf7Ag7UAcP8hnC4Ofn8y+KTUph4ABu7x6d5kaFsOYkiUNNFs69YPMkuCMGrfxXYFH
 a6jLfq7x+O6lWMExPOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Wed, 2026-07-15 at 18:26 +0530, Chinmay Rath wrote:
> PPC2_ALTIVEC_207 is only ever set in the CPUPPCState's insns_flags2
> alongside PPC2_ISA207. Checks made by PPC2_ALTIVEC_207 could be
> replaced with PPC2_ISA207, hence rendering is useless and apt for
> removal. This patch does the same.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  linux-user/ppc/elfload.c            |   3 +-
>  target/ppc/cpu.h                    |   4 +-
>  target/ppc/cpu_init.c               |   2 +-
>  target/ppc/cpu_init.h               |   3 +-
>  target/ppc/translate/vmx-impl.c.inc | 102 ++++++++++++++--------------
>  target/ppc/translate/vmx-ops.c.inc  |  18 ++---
>  6 files changed, 64 insertions(+), 68 deletions(-)
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
> index 9b0d19ba20..7a5cef32b7 100644
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
> index 78ed7eccf0..0bdb250d9e 100644
> --- a/target/ppc/translate/vmx-impl.c.inc
> +++ b/target/ppc/translate/vmx-impl.c.inc
> @@ -366,14 +366,14 @@ static bool do_vx_vaddsubm(DisasContext *ctx, arg_VX *a, MemOp vece,
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
> @@ -714,22 +714,22 @@ static bool do_vector_gvec3_VX(DisasContext *ctx, arg_VX *a, int vece,
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
> @@ -737,30 +737,30 @@ TRANS_FLAGS(ALTIVEC, VANDC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_andc);
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
> @@ -1106,16 +1106,16 @@ static bool do_vpk(DisasContext *ctx, arg_VX *a,
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
> @@ -1129,12 +1129,12 @@ GEN_VXFORM_ENV(vminfp, 5, 17);
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
> @@ -1224,16 +1224,16 @@ static bool do_vcmp(DisasContext *ctx, arg_VC *a, TCGCond cond, int vece)
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
> @@ -2345,11 +2345,11 @@ static bool do_va_helper(DisasContext *ctx, arg_VA *a,
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
> @@ -2517,14 +2517,14 @@ GEN_VXFORM_NOA(vpopcntb, 1, 28)
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
> @@ -2604,8 +2604,8 @@ static bool do_bcd_tb_ps(DisasContext *ctx, arg_VX_tb_ps *a,
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
> @@ -2637,10 +2637,10 @@ GEN_VXFORM(vcipherlast, 4, 20)
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
> @@ -2662,7 +2662,7 @@ VSHASIGMA(vshasigmad)
>  
>  GEN_VXFORM3(vpermxor, 22, 0xFF)
>  GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
> -                vpermxor, PPC_NONE, PPC2_ALTIVEC_207)
> +                vpermxor, PPC_NONE, PPC2_ISA207)
>  
>  static bool trans_VCFUGED(DisasContext *ctx, arg_VX *a)
>  {
> @@ -2830,13 +2830,13 @@ static bool do_vx_helper(DisasContext *ctx, arg_VX *a,
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
> @@ -3107,10 +3107,10 @@ TRANS_FLAGS(ALTIVEC, VMULESH, do_vx_helper, gen_helper_VMULESH)
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


