Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEE1C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 04:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxtr-0005m3-MD; Tue, 07 Jul 2026 00:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxtq-0005la-05; Tue, 07 Jul 2026 00:59:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxto-0001Bu-3F; Tue, 07 Jul 2026 00:59:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674JLa21633985; Tue, 7 Jul 2026 04:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I8LFmZ
 HDfC/OfkAerzggxc2mdzL5Lcy66luY7YnGqgE=; b=NkB/GZo6ypiT+IYu6bd0u8
 BL8snRGQCY+aNQ35Hu/TVT1OfTgmVWEzTu+w9OtreGVAIrnjkUhTY4/SrP3WQYUw
 kvoyXa8VspGpYlYhEsPQPT6b7DfLLtVKLEn/9jgGweivlA/Q3EwbZC0zMgk4uRvI
 p2hQ5w9Ekm1xouRPq24EwqR/IkrRS0ZuISTZtfpnt2eplqGksHYIZRoaKEKX/hUs
 FiUPuUrLMBu9q7CiQRz1draoIu1UpsL8l0my5Im14uIX/SZBwI6vhrKwORsvGLgc
 rcDmGOOqsVHvNtof/mIiIt6SwDq1e8zzsg/U7sk4XgzaydQp8B9ZewwqAKOiLPBw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsnjax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:59:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6674o32h026430;
 Tue, 7 Jul 2026 04:59:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk0y4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:59:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6674x4DI50004392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 04:59:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B21720049;
 Tue,  7 Jul 2026 04:59:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CAF020040;
 Tue,  7 Jul 2026 04:58:56 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 04:58:55 +0000 (GMT)
Message-ID: <0c698458-faba-4fcd-8dd1-6d19e16a52b7@linux.ibm.com>
Date: Tue, 7 Jul 2026 10:28:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/28] target/ppc: Convert b{a, l, la} to decode tree
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-15-rathc@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-15-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: SEsIx94CHN2FTtLXSFwwwtP8Kqn0cnZk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfX0qyIvqksU+tz
 t8FSFQ16rZ0xWJa0RhgO2r1oZwPhSEo4dnAndbVFYagVlM9mXKjB4ihVs9xXR573tQ87spsKgub
 vXRyngZlnrOntFK/mpoU5i3Ui0Wlal0=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c879d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=bT9LjrbIX8BFcSz0XZ0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zzou2wlktAhaJFN3YVVmCBQm5nzI2AsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfX0vRv2Os1bdqi
 SzlyIVbA6a+2DDOpEJpxNBzcJ9RXzb2cEf2WQFCjPomi4WxV/4Wb6YPXixYKXg86Z+ffWDoEy0u
 MjrkysZMR2253BobMb4vdRBatpeEWqeaa9VjvGEuKvDRzCKTpYLgIRC8V0DR0A25ClSkntWdgMv
 lWeZaXQWZIB7nnMjp6/uYcv7ez6nInP0r6OxKCYbEOtMEibuLrsQZriBcvYn4X9JdlgPzxLTaE2
 Qajka69qi9f76w2auHlNXyR3J1b3cedjYunN9j4O2UC/FU+K+hdq1C0sCvQPIvy9np7ENx1x9F4
 ZOjLvRqt9WRMyXoTEdq0S1zDUBXzvW6RAxhdme7EhIuVTFr2oHX2Qoii0hnTIm3psXbG1EvbGx+
 OPCDtilqaEnkNBxkr6mGTGZ3pRorbqeIUCJUdSgT7vbi7jLMraVt7gXnTgJSX2WsIhN0b61JuGK
 NphP+ZCdF83I4Qgu38g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070043
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil

On 20/05/26 21:37, Chinmay Rath wrote:
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>
> Convert b, ba, bl and bla to decode tree specification. The functionality
> was tested by comparing the qemu -D log -d op,in_asm output as well as
> single stepping gdb to confirm LR was correctly populated only when LK
> is set.
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode               |  7 +++++++
>   target/ppc/internal.h                  |  7 -------
>   target/ppc/translate.c                 | 24 ------------------------
>   target/ppc/translate/branch-impl.c.inc | 24 ++++++++++++++++++++++++
>   4 files changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index cbb7a2ed51..b98fe01a84 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1478,6 +1478,13 @@ MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
>   MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
>   CLRBHRB         011111 ----- ----- ----- 0110101110 -
>   
> +# Branch Instructions
> +%li             2:24 !function=times_4
> +&I_b            li aa:bool lk:bool
> +@I_b            ...... ........................ aa:1 lk:1 &I_b li=%li
> +
> +B               010010 ........................ . .  @I_b
> +
>   ## Misc POWER instructions
>   
>   ATTN            000000 00000 00000 00000 0100000000 0
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index dda23b6609..fe58cba627 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -198,13 +198,6 @@ EXTRACT_HELPER(L, 16, 2);
>   EXTRACT_HELPER(WC, 21, 2);
>   EXTRACT_HELPER(PL, 16, 2);
>   
> -/***                            Jump target decoding                       ***/
> -/* Immediate address */
> -static inline target_ulong LI(uint32_t opcode)
> -{
> -    return (opcode >> 0) & 0x03FFFFFC;
> -}
> -
>   static inline uint32_t BD(uint32_t opcode)
>   {
>       return (opcode >> 0) & 0xFFFC;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 770f52e7d4..37a164951f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3089,29 +3089,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
>       tcg_gen_movi_tl(cpu_lr, nip);
>   }
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
>   #define BCOND_IM  0
>   #define BCOND_LR  1
>   #define BCOND_CTR 2
> @@ -5390,7 +5367,6 @@ GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>   /* ISA v3.0 changed the extended opcode from 62 to 30 */
>   GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
>   GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER(b, 0x12, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
>   GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
>   GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
>   GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
> diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
> index 9ade0c659a..745f71afd1 100644
> --- a/target/ppc/translate/branch-impl.c.inc
> +++ b/target/ppc/translate/branch-impl.c.inc
> @@ -31,3 +31,27 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
>       return true;
>   }
>   #endif
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

