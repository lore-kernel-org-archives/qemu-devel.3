Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE93C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVrX-0000ns-KD; Mon, 24 Aug 2026 10:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVrS-0000mq-Of; Mon, 24 Aug 2026 10:41:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVrQ-000735-6E; Mon, 24 Aug 2026 10:41:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1gfw085620; Mon, 24 Aug 2026 14:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=y6hm9bQe/rApf2LBdnUaOBb/BFjzrbFZ9GOBYLJMKws=; b=IVm8YNHhBvuR
 bX+J/kcYB8r1PrYcDjINHYKtXKStp5AA966zgl5N7nuox8T/ywu1pEA+bTIAVXXx
 9xESFPK/Ie6giQDV6u5sBAeoDI9s76WG8mHMlkiWKT0Lhf5YcM4suzP85afknHlx
 OnKhxnuTrrLCcykpq1ypz8rQmNinAQwN7mbkuWd33t9aBRrLY1GrQ//He6Yzf9oP
 FX2sqjCmK5sS5EyoJx2CnsBMKLZISQXEcY7jq0iCnthHqO7pFEROM/OsFFdMLm+R
 FqNa3nBG7at5sKeROdTR2wn05Tv/8kJrG6WzJPjv3JinhzdDbsNBLMVpxel/mf3E
 6yqL6WbJsQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqj0b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:41:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQKQj029458;
 Mon, 24 Aug 2026 14:41:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pxrat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:41:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEeTIp27329202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:40:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54DE55805E;
 Mon, 24 Aug 2026 14:41:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AADF58051;
 Mon, 24 Aug 2026 14:41:08 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:41:08 +0000 (GMT)
Message-ID: <2c94a532266f08b9744095716b9c52d46227a082.camel@linux.ibm.com>
Subject: Re: [PATCH 14/29] target/ppc: Convert b{a, l, la} to decode tree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:41:03 -0500
In-Reply-To: <20260820140114.327023-15-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-15-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: O9ZeaRRQabNMqmC4xtma7caIiJeVzeiv
X-Proofpoint-ORIG-GUID: Wc0HjsUW6JnivhJx-zoLjibaYYkS1mRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX5ZWFGUzPvPDH
 ZXslMcT4EtGKGSJVEepCr3ISxVq0rR6kKXzt+G5pa09YJtBjDb2SZ3z0IQkyedO/8TXbceQVRg9
 PlnCrVW97f6j+yY6Uq7QFtCZTJyIhHVVLgZfXxE1S1zZ6KkOcnjSCq4Y1IlIuHKLjGy6HLlB7PR
 xE2+iRx1fNqYsQI+UQrMJ4pccuKtbu09ujnjbTMt8MO3FSd7wVAc5em2exQ73cbSR2JnuT5Poc/
 ZorcyVBFV6KcHcKrFwn+1BMTao+DW5zu05T3MvWBxUhCYRhc5B/QXHl0zU2pv7Nnod1jG8HGyG2
 8lLxlB1vPnNBLxNlfUxMy3NVrU0ZMgmiH4N4ffPEFHfdWsdLguhH4idGFKyldNu3oAOhIrVCmjr
 y4qhNi6TN3SKxu781FPS+0RRg7IQZvygDlRS+h/DwvVM2mSpTGR/8Jn1Nv39xwmm/BT6OtDTAcF
 TUXc+BZRDS1Z4r+fwhQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c5809 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=LGaGeA6owJB2NDCQWS8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX7HV3ndDZHzHp
 EuyTdxWhW7DPjJvzfrY7wOPMYmzHr90uiD5D2MDy6NRDBHc5HEa5XIApEhJ7tP7kGRujxWYa4Mv
 z2Qb4ciVDd8j6fPIOn6RjBKfDMl2Jew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122
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

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Convert b, ba, bl and bla to decode tree specification. The functionality
> was tested by comparing the qemu -D log -d op,in_asm output as well as
> single stepping gdb to confirm LR was correctly populated only when LK
> is set.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode               |  7 +++++++
>  target/ppc/internal.h                  |  7 -------
>  target/ppc/translate.c                 | 24 ------------------------
>  target/ppc/translate/branch-impl.c.inc | 24 ++++++++++++++++++++++++
>  4 files changed, 31 insertions(+), 31 deletions(-)
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


