Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5118C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVZB-0000YC-DW; Mon, 24 Aug 2026 10:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVZ9-0000XS-M8; Mon, 24 Aug 2026 10:22:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVZ7-0008VC-Cg; Mon, 24 Aug 2026 10:22:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1XX4085114; Mon, 24 Aug 2026 14:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=nn5BKxjlRpLVh24558s74Oyziqg9IxkNfx2mk7YXalI=; b=sN8jiusnpTor
 j75a5dKCwz5aOkqAtnVhfTL+ZFqL1P7I9CNTQQGKtVim1HBV/aqilELfMm6kZJLr
 SoAUKfQvlDhS2lNCnHCO4a5X/X9yTvJifkax/a10r25/c2M2QZW2SGj32j6nU3RK
 ycKBVFjOTdEiHJmY9Gjw2xTl6XY+eYeDgIhYSKQ7gNFiMV5uVfA3+20fEcSrnpqG
 rnTJ43Ko5ZHhdh8snVRN7rv/QNoG5CJiKyCeT7DY4CfZdTeWyaALa1WdsMzNlb8U
 yHv5qSe8AsSWVE05FrAWkEA5cW6OmzcC1oo01OB+A/SJERJuIMyR4P13ETcZ7bWA
 q0NUklPjJA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhvg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:22:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEBFT2019989;
 Mon, 24 Aug 2026 14:22:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxx6t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:22:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEMEXe53477776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:22:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDB1558056;
 Mon, 24 Aug 2026 14:22:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7552058045;
 Mon, 24 Aug 2026 14:22:13 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:22:13 +0000 (GMT)
Message-ID: <2bbe5177b2a19b3bbd2e83e09ebea006cbd4dd9a.camel@linux.ibm.com>
Subject: Re: [PATCH 05/29] target/ppc: Move vector pack instructions to
 decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:22:12 -0500
In-Reply-To: <20260820140114.327023-6-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-6-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: L-qNO96S_i15mOCE6_UOo4p5n0nx2ebI
X-Proofpoint-ORIG-GUID: M-D-8EwfC26n8dhB5R5f5SrOjzLvZm1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX6sYiLxQaNxWm
 EMm8DS/wQ+ZoLPrbljT/XzZNGOZOGUYyxmdqdLdS+b+qTqqxChBHELX4Z4vW8wECzD5Z/uQHzgS
 a/lmSd6c/faH0HOAqZerHVBgQVM12lX0XGqJgEMkhnvwbbRp7YX2g2uxoFuuAuioIoBNfHE3SMc
 i2sWto+W9pqGbxsFo70RTOOhTy9iMm1tbj2z7kgw/REaHl1vX2/VclyPPWY999Z45ETVaJ532I4
 VcgI0HUE9CzV61vQriKYM2cDsTxjmJuz53ver9JRJOf5I70iXVl4SZOSVht3sd+ni/sJTtDx3wa
 dr+nuiutUUV8sBn2eRft1HfaYiMLo0hNPfXC+6VWBS+mWhEGV/QZd+XjqqWRhixgkRDHlOJMkrz
 ztPsTq3JVqqmVNIHAfDyssqJvScmDFoWCpQWuzOU6/XgAMW0W4ZBTQTTEX49f0mIjUPsodTdGiF
 KOyNipiPFySPoAfqBmw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c539a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=CWpoJGtTuhhmXwic9TIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX5sTXonjI3avN
 iVsqp0r2k3d4k3vqJ8haqEq1jevNR4zEvZws2AiN0fDXAdMS/TtIaznazEVlN3gg5Bk5KN6qCie
 4W7d2JX+8bmUU5pWTF3OTksBqZ//tUA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118
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

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> From: Aboorva Devarajan <aboorvad@linux.ibm.com>
> 

Why the 'From' tag?

-Glenn

> Move below instructions to decodetree specification:
> 
>         vpkuhum, vpkuwum, vpkuhus, vpkuwus  : VX-form (PPC_ALTIVEC)
>         vpkshus, vpkswus, vpkshss, vpkswss  : VX-form (PPC_ALTIVEC)
>         vpkpx                                : VX-form (PPC_ALTIVEC)
>         vpkudum, vpkudus, vpksdus, vpksdss  : VX-form (PPC2_ALTIVEC_207)
> 
> The legacy GEN_VXFORM_ENV/GEN_VXFORM macros that generated gen_vpk*()
> functions reading register fields from ctx->opcode are replaced by new
> do_vpk_env()/do_vpk() helpers in vmx-impl.c.inc that use the
> pre-extracted decodetree argument fields (a->vrt, a->vra, a->vrb)
> directly.  The existing gen_helper_vpk*() implementations in
> int_helper.c are reused without changes.
> 
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' option before and after the patch.
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/helper.h                 | 26 +++++++--------
>  target/ppc/insn32.decode            | 16 +++++++++
>  target/ppc/int_helper.c             | 28 ++++++++--------
>  target/ppc/translate/vmx-impl.c.inc | 51 +++++++++++++++++++++--------
>  target/ppc/translate/vmx-ops.c.inc  | 13 --------
>  5 files changed, 81 insertions(+), 53 deletions(-)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 6db917935c..6df3de6516 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -249,19 +249,19 @@ DEF_HELPER_FLAGS_4(VMSUMUBM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
>  DEF_HELPER_FLAGS_4(VMSUMMBM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
>  DEF_HELPER_FLAGS_4(VPERM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
>  DEF_HELPER_FLAGS_4(VPERMR, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
> -DEF_HELPER_4(vpkshss, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkshus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkswss, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkswus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpksdss, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpksdus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuhus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuwus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkudus, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuhum, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkuwum, void, env, avr, avr, avr)
> -DEF_HELPER_4(vpkudum, void, env, avr, avr, avr)
> -DEF_HELPER_FLAGS_3(vpkpx, TCG_CALL_NO_RWG, void, avr, avr, avr)
> +DEF_HELPER_4(VPKSHSS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSHUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSWSS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSWUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSDSS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKSDUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUHUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUWUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUDUS, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUHUM, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUWUM, void, env, avr, avr, avr)
> +DEF_HELPER_4(VPKUDUM, void, env, avr, avr, avr)
> +DEF_HELPER_FLAGS_3(VPKPX, TCG_CALL_NO_RWG, void, avr, avr, avr)
>  DEF_HELPER_5(VMHADDSHS, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(VMHRADDSHS, void, env, avr, avr, avr, avr)
>  DEF_HELPER_FLAGS_4(VMSUMUHM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 8aca8a00c0..c51efbfd33 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1054,6 +1054,22 @@ VSTRIHR         000100 ..... 00011 ..... . 0000001101   @VX_tb_rc
>  VCLRLB          000100 ..... ..... ..... 00110001101    @VX
>  VCLRRB          000100 ..... ..... ..... 00111001101    @VX
>  
> +## Vector Pack Instructions
> +
> +VPKUHUM         000100 ..... ..... ..... 0000000111 0    @VX
> +VPKUWUM         000100 ..... ..... ..... 0000100111 0    @VX
> +VPKUDUM         000100 ..... ..... ..... 1000100111 0    @VX
> +VPKUHUS         000100 ..... ..... ..... 0001000111 0    @VX
> +VPKUWUS         000100 ..... ..... ..... 0001100111 0    @VX
> +VPKUDUS         000100 ..... ..... ..... 1001100111 0    @VX
> +VPKSHUS         000100 ..... ..... ..... 0010000111 0    @VX
> +VPKSWUS         000100 ..... ..... ..... 0010100111 0    @VX
> +VPKSDUS         000100 ..... ..... ..... 1010100111 0    @VX
> +VPKSHSS         000100 ..... ..... ..... 0011000111 0    @VX
> +VPKSWSS         000100 ..... ..... ..... 0011100111 0    @VX
> +VPKSDSS         000100 ..... ..... ..... 1011100111 0    @VX
> +VPKPX           000100 ..... ..... ..... 0110000111 0    @VX
> +
>  # VSX Load/Store Instructions
>  
>  LXSD            111001 ..... ..... .............. 10    @DS
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index a3adf746bd..dc55ccadf7 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1465,7 +1465,7 @@ void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>  #else
>  #define PKBIG 0
>  #endif
> -void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> +void helper_VPKPX(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>  {
>      int i, j;
>      ppc_avr_t result;
> @@ -1488,7 +1488,7 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>  }
>  
>  #define VPK(suffix, from, to, cvt, dosat)                               \
> -    void helper_vpk##suffix(CPUPPCState *env, ppc_avr_t *r,             \
> +    void helper_VPK##suffix(CPUPPCState *env, ppc_avr_t *r,             \
>                              ppc_avr_t *a, ppc_avr_t *b)                 \
>      {                                                                   \
>          int i;                                                          \
> @@ -1507,18 +1507,18 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>          }                                                               \
>      }
>  #define I(x, y) (x)
> -VPK(shss, s16, s8, cvtshsb, 1)
> -VPK(shus, s16, u8, cvtshub, 1)
> -VPK(swss, s32, s16, cvtswsh, 1)
> -VPK(swus, s32, u16, cvtswuh, 1)
> -VPK(sdss, s64, s32, cvtsdsw, 1)
> -VPK(sdus, s64, u32, cvtsduw, 1)
> -VPK(uhus, u16, u8, cvtuhub, 1)
> -VPK(uwus, u32, u16, cvtuwuh, 1)
> -VPK(udus, u64, u32, cvtuduw, 1)
> -VPK(uhum, u16, u8, I, 0)
> -VPK(uwum, u32, u16, I, 0)
> -VPK(udum, u64, u32, I, 0)
> +VPK(SHSS, s16, s8, cvtshsb, 1)
> +VPK(SHUS, s16, u8, cvtshub, 1)
> +VPK(SWSS, s32, s16, cvtswsh, 1)
> +VPK(SWUS, s32, u16, cvtswuh, 1)
> +VPK(SDSS, s64, s32, cvtsdsw, 1)
> +VPK(SDUS, s64, u32, cvtsduw, 1)
> +VPK(UHUS, u16, u8, cvtuhub, 1)
> +VPK(UWUS, u32, u16, cvtuwuh, 1)
> +VPK(UDUS, u64, u32, cvtuduw, 1)
> +VPK(UHUM, u16, u8, I, 0)
> +VPK(UWUM, u32, u16, I, 0)
> +VPK(UDUM, u64, u32, I, 0)
>  #undef I
>  #undef VPK
>  #undef PKBIG
> diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
> index 00b359f031..65230f3461 100644
> --- a/target/ppc/translate/vmx-impl.c.inc
> +++ b/target/ppc/translate/vmx-impl.c.inc
> @@ -1070,19 +1070,44 @@ TRANS(VRLQMI, do_vector_rotl_quad, false, true)
>  
>  GEN_VXFORM_TRANS(vsl, 2, 7);
>  GEN_VXFORM_TRANS(vsr, 2, 11);
> -GEN_VXFORM_ENV(vpkuhum, 7, 0);
> -GEN_VXFORM_ENV(vpkuwum, 7, 1);
> -GEN_VXFORM_ENV(vpkudum, 7, 17);
> -GEN_VXFORM_ENV(vpkuhus, 7, 2);
> -GEN_VXFORM_ENV(vpkuwus, 7, 3);
> -GEN_VXFORM_ENV(vpkudus, 7, 19);
> -GEN_VXFORM_ENV(vpkshus, 7, 4);
> -GEN_VXFORM_ENV(vpkswus, 7, 5);
> -GEN_VXFORM_ENV(vpksdus, 7, 21);
> -GEN_VXFORM_ENV(vpkshss, 7, 6);
> -GEN_VXFORM_ENV(vpkswss, 7, 7);
> -GEN_VXFORM_ENV(vpksdss, 7, 23);
> -GEN_VXFORM(vpkpx, 7, 12);
> +static bool do_vpk_env(DisasContext *ctx, arg_VX *a,
> +                       void (*gen_helper)(TCGv_ptr, TCGv_ptr,
> +                                          TCGv_ptr, TCGv_ptr))
> +{
> +    TCGv_ptr ra, rb, rd;
> +    REQUIRE_VECTOR(ctx);
> +    ra = gen_avr_ptr(a->vra);
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +    gen_helper(tcg_env, rd, ra, rb);
> +    return true;
> +}
> +
> +static bool do_vpk(DisasContext *ctx, arg_VX *a,
> +                   void (*gen_helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr))
> +{
> +    TCGv_ptr ra, rb, rd;
> +    REQUIRE_VECTOR(ctx);
> +    ra = gen_avr_ptr(a->vra);
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +    gen_helper(rd, ra, rb);
> +    return true;
> +}
> +
> +TRANS_FLAGS(ALTIVEC, VPKUHUM, do_vpk_env, gen_helper_VPKUHUM)
> +TRANS_FLAGS(ALTIVEC, VPKUWUM, do_vpk_env, gen_helper_VPKUWUM)
> +TRANS_FLAGS2(ALTIVEC_207, VPKUDUM, do_vpk_env, gen_helper_VPKUDUM)
> +TRANS_FLAGS(ALTIVEC, VPKUHUS, do_vpk_env, gen_helper_VPKUHUS)
> +TRANS_FLAGS(ALTIVEC, VPKUWUS, do_vpk_env, gen_helper_VPKUWUS)
> +TRANS_FLAGS2(ALTIVEC_207, VPKUDUS, do_vpk_env, gen_helper_VPKUDUS)
> +TRANS_FLAGS(ALTIVEC, VPKSHUS, do_vpk_env, gen_helper_VPKSHUS)
> +TRANS_FLAGS(ALTIVEC, VPKSWUS, do_vpk_env, gen_helper_VPKSWUS)
> +TRANS_FLAGS2(ALTIVEC_207, VPKSDUS, do_vpk_env, gen_helper_VPKSDUS)
> +TRANS_FLAGS(ALTIVEC, VPKSHSS, do_vpk_env, gen_helper_VPKSHSS)
> +TRANS_FLAGS(ALTIVEC, VPKSWSS, do_vpk_env, gen_helper_VPKSWSS)
> +TRANS_FLAGS2(ALTIVEC_207, VPKSDSS, do_vpk_env, gen_helper_VPKSDSS)
> +TRANS_FLAGS(ALTIVEC, VPKPX, do_vpk, gen_helper_VPKPX)
>  GEN_VXFORM_ENV(vsum4ubs, 4, 24);
>  GEN_VXFORM_ENV(vsum4sbs, 4, 28);
>  GEN_VXFORM_ENV(vsum4shs, 4, 25);
> diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
> index b8f77d3d2c..2820976c0f 100644
> --- a/target/ppc/translate/vmx-ops.c.inc
> +++ b/target/ppc/translate/vmx-ops.c.inc
> @@ -59,19 +59,6 @@ GEN_VXFORM_300(bcdtrunc, 0, 20),
>  GEN_VXFORM_300(bcdutrunc, 0, 21),
>  GEN_VXFORM(vsl, 2, 7),
>  GEN_VXFORM(vsr, 2, 11),
> -GEN_VXFORM(vpkuhum, 7, 0),
> -GEN_VXFORM(vpkuwum, 7, 1),
> -GEN_VXFORM_207(vpkudum, 7, 17),
> -GEN_VXFORM(vpkuhus, 7, 2),
> -GEN_VXFORM(vpkuwus, 7, 3),
> -GEN_VXFORM_207(vpkudus, 7, 19),
> -GEN_VXFORM(vpkshus, 7, 4),
> -GEN_VXFORM(vpkswus, 7, 5),
> -GEN_VXFORM_207(vpksdus, 7, 21),
> -GEN_VXFORM(vpkshss, 7, 6),
> -GEN_VXFORM(vpkswss, 7, 7),
> -GEN_VXFORM_207(vpksdss, 7, 23),
> -GEN_VXFORM(vpkpx, 7, 12),
>  GEN_VXFORM(vsum4ubs, 4, 24),
>  GEN_VXFORM(vsum4sbs, 4, 28),
>  GEN_VXFORM(vsum4shs, 4, 25),


