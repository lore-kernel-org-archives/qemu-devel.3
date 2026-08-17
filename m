Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC61C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzDY-0005nU-Io; Mon, 17 Aug 2026 11:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzDW-0005bZ-0Q; Mon, 17 Aug 2026 11:25:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzDT-0004kY-NU; Mon, 17 Aug 2026 11:25:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HCVm181392522; Mon, 17 Aug 2026 15:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=qlT1vzhjHubw8MQMDjWBKQTXSIYK6CyBi1M+/ionPhk=; b=k6xhZZKbD/c0
 Ecmb/6Ncag1KBKhlmOgyXh9Bt+731e5cFQnnVfdOQj9Jf42ia6GPwAJmA+GW8VRg
 W3/y6M9Y+zCRIgtXo0HX+3eBzkzdpIZo5VXHCKzqKrw4WFgMLE3LYFS9m1tNpWYi
 +ZYqWASp1KGPG/GlKGGVRKW6JeRkb91wnHjRDoZpl0p3cIbZEyFkDanQI7STwHQl
 jAZflNLYKtH5wwozCLywlhll3jqJGxzCV26riJNN2KI97EZvhhSviDXIhsk5IosO
 rvZOjSCfl5b7rJS3qv2XmtqnoiScvD8MTg3iHv4JnMNC15BQ5TM+Kt3e1fhr1NMJ
 94gjkZEDXQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4k0fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:25:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFBK9c009354;
 Mon, 17 Aug 2026 15:25:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng6c1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:25:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HFPTMB36700470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:25:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BE9158050;
 Mon, 17 Aug 2026 15:25:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEC2458056;
 Mon, 17 Aug 2026 15:25:28 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 15:25:28 +0000 (GMT)
Message-ID: <734810e67ecf83457926e12f325ff0bd05a097ed.camel@linux.ibm.com>
Subject: Re: [PATCH 3/7] target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, shivangu@linux.ibm.com
Date: Mon, 17 Aug 2026 10:25:28 -0500
In-Reply-To: <20260715125634.2107320-4-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-4-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ddMWw0oM7_2lSdhIoYp-6cPBv2Y_Wu0G
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a8327ec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=-gZqQ3hT50n4G0il6jYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX67zTGRwsqmiD
 uB7zsDz+WkVyNxeQ0msOb9pewPz9ztYsTinBaA3XvcXzJpDYUZ5vga6xKkdmuDbTdqJChR1jxoB
 d3SQ6MK8T4BJHFptpQSO0YTCuiFIwNc=
X-Proofpoint-ORIG-GUID: 5AKEXSioWGdn9lFCKrGWd_N_lEh5eFBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX0UbSK0Py/Rdw
 CYMupeBtDydny1GZwOVL0qPGaQfRVal9HXdc8RbL5tRInAtlV55jK4vOHYc4FFyZOrDKyugeNpK
 d6SPKszGdXoEihNlzYIIBgPxkL4hgX7kjy/yCBfNgER+MqzS5Mmzlj1aYEW/qaUJso8qIZsh0j4
 LBZw9ADuj85uBoGJA0yf+JfWvTdAJnMYP/G02yfi39QyTBQJead1VwgTDvO+TwsxzMfBOze6a4G
 WOMciuBUICjY9l++m0yAGXI3aIc4Ff7RpSGPnvGlABEkMApTD1w10CuohmrI8bIujMOUgXuJl7N
 t8paPk8zA3o9rgkgwZTm1AEhZc0WjSQF5Dq1GYXXbvcLQ6oFVYNLxH9oL6PWag+Hnxg7i5xnztb
 8gkyQm6zgJB+ACN26xJ+UT0BDyCA5BCXBD8w1z2xnnYB7u03muS/O8K+olv2oeMJJroz+0QkeKn
 YF2Anb/yE0lvzqSwoXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
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
> PPC2_LSQ_ISA207 is only ever set in the CPUPPCState's insns_flags2
> alongside PPC2_ISA207. Checks made by PPC2_LSQ_ISA207 could be
> replaced with PPC2_ISA207, hence rendering is useless and apt for
> removal. This patch does the same.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  linux-user/ppc/elfload.c                   | 2 +-
>  target/ppc/cpu.h                           | 3 ---
>  target/ppc/cpu_init.c                      | 3 +--
>  target/ppc/cpu_init.h                      | 2 +-
>  target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
>  5 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
> index 5c6065e08a..76ab9f43de 100644
> --- a/linux-user/ppc/elfload.c
> +++ b/linux-user/ppc/elfload.c
> @@ -116,7 +116,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
>      do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
>  
>      GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
> -    GET_FEATURE2((PPC2_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> +    GET_FEATURE2((PPC2_ISA207 | PPC2_ALTIVEC_207 |
>                    PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
>                    QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
>      GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index df1e943d8d..b3cd8d85df 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2577,8 +2577,6 @@ enum {
>      PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
>      /* ISA 2.06B floating point test instructions                            */
>      PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
> -    /* ISA 2.07 load/store quadword                                          */
> -    PPC2_LSQ_ISA207    = 0x0000000000002000ULL,
>      /* ISA 2.07 Altivec                                                      */
>      PPC2_ALTIVEC_207   = 0x0000000000004000ULL,
>      /* PowerISA 2.07 Book3s specification                                    */
> @@ -2608,7 +2606,6 @@ enum {
>                          PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
>                          PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
>                          PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
> -                        PPC2_LSQ_ISA207 | \
>                          PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
>                          PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index be8b3c447d..9b0d19ba20 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6349,8 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
>      pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
>                          PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>                          PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> -                        PPC2_FP_TST_ISA206 |
> -                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> +                        PPC2_FP_TST_ISA206 | PPC2_ALTIVEC_207 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
>                          PPC2_BCDA_ISA206;
> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
> index 7dd587908e..6961007926 100644
> --- a/target/ppc/cpu_init.h
> +++ b/target/ppc/cpu_init.h
> @@ -18,7 +18,7 @@
>      (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
>       PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
>       PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
> -     PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
> +     PPC2_ALTIVEC_207 | PPC2_ISA205 |                                \
>       PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
>       PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
>  
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 9c7c754db1..6e4c8c34b3 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -116,7 +116,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
>  
>      REQUIRE_INSNS_FLAGS(ctx, 64BX);
>  
> -    if (!prefixed && !(ctx->insns_flags2 & PPC2_LSQ_ISA207)) {
> +    if (!prefixed && !(ctx->insns_flags2 & PPC2_ISA207)) {
>          /* lq and stq were privileged prior to V. 2.07 */
>          REQUIRE_SV(ctx);
>  
> @@ -280,7 +280,7 @@ TRANS64(STDCX, do_store_cond, MO_UQ);
>  static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
>  {
>      REQUIRE_64BIT(ctx);
> -    REQUIRE_INSNS_FLAGS2(ctx, LSQ_ISA207);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
>  #if defined(TARGET_PPC64)
>      TCGLabel *lfail = gen_new_label();
>      TCGv ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);


