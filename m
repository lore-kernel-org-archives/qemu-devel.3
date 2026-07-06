Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6EAC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf5z-0000gP-2q; Mon, 06 Jul 2026 04:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wgf5n-0000V9-J3; Mon, 06 Jul 2026 04:54:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wgf5l-0006ul-6L; Mon, 06 Jul 2026 04:54:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIfYH2198707; Mon, 6 Jul 2026 08:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0kfakv
 VFZSUpL804IgziIlj1UZpDCfFwjRWYcLL/Q5c=; b=j8U9Agj3yjj82yUDEvO9Jj
 5KRZyIOPjxXf1Dbo23iGrSxHfyZ4oCQWribh/hEwjvPzvbn2+YbzREXTUO/kAztz
 STLMRdUmXDPujWxgrilRyu9Kfr8JSsYtRHwdAPOgLv5Q4gigipFALApEXdg/n4Kc
 fvuuH+Rie7OwRzF771MJvH81yYEsYKWiZNWAlmSBeyXqvI96/XVDBq6etGUkTfIV
 wRLh/PITdUJ468ZfWdznJiR92prHbSiy1aly7iWk62mrMgfgHjH98iURCgV5YXuO
 V7kVnXj7nyFJ7L9zg+7BJ0sH5OtfysQczIGqN7FZA8dAvFBSw7la+3E78pC0aBAQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ghp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:54:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nddJ023229;
 Mon, 6 Jul 2026 08:54:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvyp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:54:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668sBkc7209700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:54:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDA0C5805D;
 Mon,  6 Jul 2026 08:54:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE2AF58054;
 Mon,  6 Jul 2026 08:54:09 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:54:09 +0000 (GMT)
Message-ID: <a1b01852-701d-421d-a72e-0d357f40e16b@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:24:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/28] target/ppc: Move Fixed-Point Load/Store String
 instructions to decodetree.
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, shivangu@linux.ibm.com
Cc: milesg@linux.ibm.com, harshpb@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-23-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-23-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BeZMtkLESa_SAHvzPGJeZWgcUf-uvChi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX7T8d558oU36M
 JInd8B6vIvsnLHT9lbOiO9Mt/pUdwX7QT7yTSkpH9QKxY3G2zApY9wh5Iq0oFGckD1A3tn1jJgw
 sjfn/cv1S0n3gWa80JGKgjjsp8EpFf7ZKU7ZTPEJiJCPQ2pwCjaJhtZXr5RTUfsk8SJ/U7BWs7C
 ELQ1NOoQ7OciMiYlEEf0iiEXWqp8wSPdYnDEhDT6CYzoxwYs9+ka/Hx1NoBCqEK/vv/ybZSAo0U
 vSLibAwJD8e97IGxTc3kiYt3NOJlwxYpFAHLQYjjXpasCgpQZBvmH3UaOMQtrYU5RoKB94oiCfb
 7bdXpkf6TWKt5YEIdY2dBRlc6267RyOBDAZcA3EJRCUalohjx/7/Dk0u7TCu4vLvEW8nuvVTJTg
 nLRDtmZNYKaUj2yEO4cNi+keBD1IFHeKDaVP3mEZ022Gq1eN4fcOw/paEbwl4p1gpVBuqcI967q
 RJbE6sO7hmSg5qZpk2g==
X-Proofpoint-ORIG-GUID: BeZMtkLESa_SAHvzPGJeZWgcUf-uvChi
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6d36 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=S40DjwmI8Mk8vhn0oP0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX+AjPSSKqdVo3
 kYyMq1k01kAxBT8l6k91wzx7Rkx/xWhopWK9BGOLOKExorxb/1DHGx+EFkSCh8UCHNLoaYKyUUw
 1RTF5o9q5eMiKvjPjaqpEchLmx0Ds/Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 5/20/26 21:37, Chinmay Rath wrote:
> From: Shivang Upadhyay <shivangu@linux.ibm.com>
>
> Move below instructions to decodetree specification :
>
>          lsw{i, x},
>          stsw{i, x}                       : X-form
>
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                        |   6 +-
>   target/ppc/insn32.decode                   |   7 ++
>   target/ppc/mem_helper.c                    |   6 +-
>   target/ppc/translate.c                     | 102 --------------------
>   target/ppc/translate/fixedpoint-impl.c.inc | 103 +++++++++++++++++++++
>   5 files changed, 116 insertions(+), 108 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index dacc4e223e..50493a72a5 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -45,9 +45,9 @@ DEF_HELPER_1(check_tlb_flush_global, void, env)
>   
>   DEF_HELPER_3(lmw, void, env, tl, i32)
>   DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
> -DEF_HELPER_4(lsw, void, env, tl, i32, i32)
> -DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
> -DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> +DEF_HELPER_4(LSW, void, env, tl, i32, i32)
> +DEF_HELPER_5(LSWX, void, env, tl, i32, i32, i32)
> +DEF_HELPER_FLAGS_4(STSW, TCG_CALL_NO_WG, void, env, tl, i32, i32)
>   DEF_HELPER_FLAGS_3(DCBZ, TCG_CALL_NO_WG, void, env, tl, int)
>   #ifdef TARGET_PPC64
>   DEF_HELPER_FLAGS_2(DCBZL, TCG_CALL_NO_WG, void, env, tl)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index f3a1f7970e..0ec9a4d5de 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -527,6 +527,13 @@ CREQV           010011 ..... ..... ..... 0100100001 -  @X
>   CRANDC          010011 ..... ..... ..... 0010000001 -  @X
>   CRORC           010011 ..... ..... ..... 0110100001 -  @X
>   
> +# Fixed Point Move Assist Instructions
> +
> +LSWI            011111 ..... ..... ..... 1 001010101 -  @X
> +LSWX            011111 ..... ..... ..... 1 000010101 -  @X
> +STSWI           011111 ..... ..... ..... 1 011010101 -  @X
> +STSWX           011111 ..... ..... ..... 1 010010101 -  @X
> +
>   # Fixed-Point Hash Instructions
>   
>   HASHST          011111 ..... ..... ..... 1011010010 .   @X_DW
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 5d3d377261..303eec4ee5 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -190,7 +190,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>       env->gpr[reg] = val;
>   }
>   
> -void helper_lsw(CPUPPCState *env, target_ulong addr,
> +void helper_LSW(CPUPPCState *env, target_ulong addr,
>                   uint32_t nb, uint32_t reg)
>   {
>       do_lsw(env, addr, nb, reg, GETPC());
> @@ -202,7 +202,7 @@ void helper_lsw(CPUPPCState *env, target_ulong addr,
>    * this is valid, but rA won't be loaded.  For now, I'll follow the
>    * spec...
>    */
> -void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
> +void helper_LSWX(CPUPPCState *env, target_ulong addr, uint32_t reg,
>                    uint32_t ra, uint32_t rb)
>   {
>       if (likely(xer_bc != 0)) {
> @@ -218,7 +218,7 @@ void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
>       }
>   }
>   
> -void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
> +void helper_STSW(CPUPPCState *env, target_ulong addr, uint32_t nb,
>                    uint32_t reg)
>   {
>       uintptr_t raddr = GETPC();
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 85bdb7deab..fc107399db 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2597,104 +2597,6 @@ static void gen_stmw(DisasContext *ctx)
>       gen_helper_stmw(tcg_env, t0, t1);
>   }
>   
> -/***                    Integer load and store strings                     ***/
> -
> -/* lswi */
> -/*
> - * PowerPC32 specification says we must generate an exception if rA is
> - * in the range of registers to be loaded.  In an other hand, IBM says
> - * this is valid, but rA won't be loaded.  For now, I'll follow the
> - * spec...
> - */
> -static void gen_lswi(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2;
> -    int nb = NB(ctx->opcode);
> -    int start = rD(ctx->opcode);
> -    int ra = rA(ctx->opcode);
> -    int nr;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    if (nb == 0) {
> -        nb = 32;
> -    }
> -    nr = DIV_ROUND_UP(nb, 4);
> -    if (unlikely(lsw_reg_in_range(start, nr, ra))) {
> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_register(ctx, t0);
> -    t1 = tcg_constant_i32(nb);
> -    t2 = tcg_constant_i32(start);
> -    gen_helper_lsw(tcg_env, t0, t1, t2);
> -}
> -
> -/* lswx */
> -static void gen_lswx(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2, t3;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    t1 = tcg_constant_i32(rD(ctx->opcode));
> -    t2 = tcg_constant_i32(rA(ctx->opcode));
> -    t3 = tcg_constant_i32(rB(ctx->opcode));
> -    gen_helper_lswx(tcg_env, t0, t1, t2, t3);
> -}
> -
> -/* stswi */
> -static void gen_stswi(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2;
> -    int nb = NB(ctx->opcode);
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_register(ctx, t0);
> -    if (nb == 0) {
> -        nb = 32;
> -    }
> -    t1 = tcg_constant_i32(nb);
> -    t2 = tcg_constant_i32(rS(ctx->opcode));
> -    gen_helper_stsw(tcg_env, t0, t1, t2);
> -}
> -
> -/* stswx */
> -static void gen_stswx(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    t1 = tcg_temp_new_i32();
> -    tcg_gen_trunc_tl_i32(t1, cpu_xer);
> -    tcg_gen_andi_i32(t1, t1, 0x7F);
> -    t2 = tcg_constant_i32(rS(ctx->opcode));
> -    gen_helper_stsw(tcg_env, t0, t1, t2);
> -}
>   
>   #if !defined(CONFIG_USER_ONLY)
>   static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
> @@ -4940,10 +4842,6 @@ GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>   GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>   GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>   GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
> -GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
> -GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
> -GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
Looks like you have missed adding those ^ PPC_STRING flag checks in the 
new trans_XXX() handlers.

Regards,
Chinmay
>   /* ISA v3.0 changed the extended opcode from 62 to 30 */
>   GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>   #if defined(TARGET_PPC64)
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 26b308e435..76b1011fad 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -585,6 +585,109 @@ TRANS(CRANDC, cr_logic_common, tcg_gen_andc_i32);
>   TRANS(CREQV, cr_logic_common, tcg_gen_eqv_i32);
>   TRANS(CRORC, cr_logic_common, tcg_gen_orc_i32);
>   
> +
> +/***                    Integer load and store strings                     ***/
> +
> +/* lswi */
> +static bool trans_LSWI(DisasContext *ctx, arg_LSWI *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2;
> +    int nb = a->rb;
> +    int start = a->rt;
> +    int ra = a->ra;
> +    int nr;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    if (nb == 0) {
> +        nb = 32;
> +    }
> +    nr = DIV_ROUND_UP(nb, 4);
> +    if (unlikely(lsw_reg_in_range(start, nr, ra))) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_register(ctx, t0);
> +    t1 = tcg_constant_i32(nb);
> +    t2 = tcg_constant_i32(start);
> +    gen_helper_LSW(tcg_env, t0, t1, t2);
> +
> +    return true;
> +}
> +
> +/* lswx */
> +static bool trans_LSWX(DisasContext *ctx, arg_LSWX *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2, t3;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    t1 = tcg_constant_i32(a->rt);
> +    t2 = tcg_constant_i32(a->ra);
> +    t3 = tcg_constant_i32(a->rb);
> +    gen_helper_LSWX(tcg_env, t0, t1, t2, t3);
> +
> +    return true;
> +}
> +
> +/* stswi */
> +static bool trans_STSWI(DisasContext *ctx, arg_STSWI *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2;
> +    int nb = a->rb;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_register(ctx, t0);
> +    if (nb == 0) {
> +        nb = 32;
> +    }
> +    t1 = tcg_constant_i32(nb);
> +    t2 = tcg_constant_i32(a->rt);
> +    gen_helper_STSW(tcg_env, t0, t1, t2);
> +
> +    return true;
> +}
> +
> +/* stswx */
> +static bool trans_STSWX(DisasContext *ctx, arg_STSWX *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    t1 = tcg_temp_new_i32();
> +    tcg_gen_trunc_tl_i32(t1, cpu_xer);
> +    tcg_gen_andi_i32(t1, t1, 0x7F);
> +    t2 = tcg_constant_i32(a->rt);
> +    gen_helper_STSW(tcg_env, t0, t1, t2);
> +
> +    return true;
> +}
> +
>   static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
>                        bool compute_ov, bool compute_rc0)
>   {

