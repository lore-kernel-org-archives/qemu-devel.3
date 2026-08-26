Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA4AC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCfx-0004ma-Ch; Wed, 26 Aug 2026 08:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzCfv-0004kq-HW; Wed, 26 Aug 2026 08:24:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzCfs-0000Vc-Oj; Wed, 26 Aug 2026 08:24:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAVfQb3793926; Wed, 26 Aug 2026 12:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Fgq1u/4TBe0v9vwGjQLo3IUArXpXgP
 z6l2mTf8V0xds=; b=c66p6WanB8p7DSMn0GaNQI7SJb++VweHPkAPKuIsCIt0IP
 jrqboMvZz+BwIiITaFXqEWT2Mb+Eo/pWp81+aIWsa7h+ZfuhdfcQeH7BskoMG0uT
 8E8EJGRTw0jqLr5WLe4gj/W+tEwBuVtQXVknXxqyH+b7W/jUtmCBqpZf1yM841so
 ZXrlLx2usowAl4ADEgCi5HqjtHZ3TK/M/gO58an/5a8WVsu++nseCHVJ3jUMrhLg
 p7LJQkB7BJg+ae+9mKQ/2tedEvVpKONLlgTdcezGFbDcQpT7eUp6bmWRTZbbOGtz
 3uIq22rz/tUnalWFvbpJ4Ms26jNUam8TAjzSWv+w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxe7kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:24:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCF4Gk003291;
 Wed, 26 Aug 2026 12:24:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k1uja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:24:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCO4g543450856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:24:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE8732004B;
 Wed, 26 Aug 2026 12:24:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD1902004E;
 Wed, 26 Aug 2026 12:24:01 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 12:24:01 +0000 (GMT)
Date: Wed, 26 Aug 2026 17:54:04 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 14/37] target/ppc: Convert b{a, l, la} to decode tree
Message-ID: <20260826175322.7df47372-fb-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-15-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-15-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwMCBTYWx0ZWRfXzpaLQrPKZ241
 aVwtXWttikSHnN5m+aPwKMGX46HXMuWiZsqURxp8251elStVBKJmkk69guX6e76ajadYXWsZHZU
 jjDASeVnSah0iiHoVXYrvV9gxYXwj0A=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8edaea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=LGaGeA6owJB2NDCQWS8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: gE9mwn7aszxE3LhwcXolTFm7F8QE8IIJ
X-Proofpoint-GUID: Ks6X1bJHcuyng0uC4XxOgsxDRbdH3Q76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwMCBTYWx0ZWRfX83gGaZmKKlbV
 HjNnIpS0UsJOsZXyA9HbDmcOuN+JcnS4ZRpgArboX9zP78yslXlebpVO9A8nMIfG241YyQC2edE
 c8yqqDjeC1/fBjUHb27YIyX6b57BS8rE/GOkuUccMQvBbwXvh6HqHYyd80J1UK8nkaCeob5p/Id
 2oWR7xppxTP9hRa0EaD8Inbt/1FFpkMbvFWReSpO8jZ1kFZP4BiOi8JrVhvMYBlzdDfmr/AoM3W
 43sskVJdHbFN6uIqUVnwGpIuJ7zcgcFYb6CRiqtG0JXUN/QGE7q3uGrCmJjSn5PMZql9LrvX3eA
 gBASGcgJ/gZ2bbba5j8ZYaPvr/V7lHW9AFum8otc1/uWJKGLmTOGed1RX0utGTbyAbdfDBP8KN6
 Gnlmu7jrRUK8ngDhOvm+DRld/VX5MyOxRtghBSE4H3ThVYQnHnED+PVkG75jduuIt87Geg50jRG
 ROd1HnYRkDjZbi9rc4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260100
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
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Convert b, ba, bl and bla to decode tree specification. The functionality
> was tested by comparing the qemu -D log -d op,in_asm output as well as
> single stepping gdb to confirm LR was correctly populated only when LK
> is set.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode               |  7 +++++++
>  target/ppc/internal.h                  |  7 -------
>  target/ppc/translate.c                 | 24 ------------------------
>  target/ppc/translate/branch-impl.c.inc | 24 ++++++++++++++++++++++++
>  4 files changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 91ece88a70..6a3254aaf6 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1488,6 +1488,13 @@ MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
>  MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
>  CLRBHRB         011111 ----- ----- ----- 0110101110 -
>  
> +# Branch Instructions
> +%li             2:24 !function=times_4
> +&I_b            li aa:bool lk:bool
> +@I_b            ...... ........................ aa:1 lk:1 &I_b li=%li
> +
> +B               010010 ........................ . .  @I_b
> +
>  ## Misc POWER instructions
>  
>  ATTN            000000 00000 00000 00000 0100000000 0
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index a3bb12afd9..a20a0f9f7e 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -197,13 +197,6 @@ EXTRACT_HELPER(L, 16, 2);
>  EXTRACT_HELPER(WC, 21, 2);
>  EXTRACT_HELPER(PL, 16, 2);
>  
> -/***                            Jump target decoding                       ***/
> -/* Immediate address */
> -static inline target_ulong LI(uint32_t opcode)
> -{
> -    return (opcode >> 0) & 0x03FFFFFC;
> -}
> -
>  static inline uint32_t BD(uint32_t opcode)
>  {
>      return (opcode >> 0) & 0xFFFC;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index a31cda4490..b528cab17d 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3089,29 +3089,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
>      tcg_gen_movi_tl(cpu_lr, nip);
>  }
>  
> -/* b ba bl bla */
> -static void gen_b(DisasContext *ctx)
> -{
> -    target_ulong li, target;
> -
> -    /* sign extend LI */
> -    li = LI(ctx->opcode);
> -    li = (li ^ 0x02000000) - 0x02000000;
> -    if (likely(AA(ctx->opcode) == 0)) {
> -        target = ctx->cia + li;
> -    } else {
> -        target = li;
> -    }
> -    if (LK(ctx->opcode)) {
> -        gen_setlr(ctx, ctx->base.pc_next);
> -        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
> -    } else {
> -        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
> -    }
> -    gen_goto_tb(ctx, 0, target);
> -    ctx->base.is_jmp = DISAS_NORETURN;
> -}
> -
>  #define BCOND_IM  0
>  #define BCOND_LR  1
>  #define BCOND_CTR 2
> @@ -5366,7 +5343,6 @@ GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>  /* ISA v3.0 changed the extended opcode from 62 to 30 */
>  GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
>  GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER(b, 0x12, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
>  GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
>  GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
>  GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
> diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
> index 9ade0c659a..745f71afd1 100644
> --- a/target/ppc/translate/branch-impl.c.inc
> +++ b/target/ppc/translate/branch-impl.c.inc
> @@ -31,3 +31,27 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
>      return true;
>  }
>  #endif
> +
> +static bool trans_B(DisasContext *ctx, arg_I_b *a)
> +{
> +    target_ulong target, li;
> +
> +    /* sign extend LI */
> +    li = (a->li ^ 0x02000000) - 0x02000000;
> +
> +    if (likely(a->aa == 0)) {
> +        target = ctx->cia + li;
> +    } else {
> +        target = li;
> +    }
> +    if (a->lk) {
> +        gen_setlr(ctx, ctx->base.pc_next);
> +        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
> +    } else {
> +        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
> +    }
> +    gen_goto_tb(ctx, 0, target);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    return true;
> +}
> -- 
> 2.55.0
> 

