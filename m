Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF7C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzb7u-0006y4-It; Thu, 27 Aug 2026 10:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzb7p-0006xD-Bl; Thu, 27 Aug 2026 10:30:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzb7n-0001L4-0g; Thu, 27 Aug 2026 10:30:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVfZL1871829; Thu, 27 Aug 2026 14:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=iRh5aHi6oynj6AuxedlWU/d/ggbjFD
 /trMndcC/5NQE=; b=psHhXWXcRxRjV+rnSl3yMj2j9qy1uGGIpvhHsh00OtRkKZ
 RBIOHzrWo5xqX5fm+k0hsF08yPdJ7wGre21iQoHihdZ8xQxCDoQFUWbuguIc6rQt
 /eO0BwlcEt2wG+y2wv9SbWBIzttNThyHhxcub78kZNZiPvyVvsGN6rCpGgW25V8S
 3h9FASyNSgXJPT8wwkVO0WDKzVrKbShB5Rba+gWMiiLaYgchUgnkUxQl8WwL1qyK
 EwB0ORJuo/0qfdS3f9RavEJiisqkZkwNN3T0D/a77xrPKOY2wWKFLb0S+qiNjk22
 G6m5Cho7BgG8ygF2adpp+yEJIomqizqK5Ewiegrw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ewt4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 14:30:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67REQViJ020817;
 Thu, 27 Aug 2026 14:30:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhgf9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 14:30:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67REUQrV32309760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 14:30:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F0A520043;
 Thu, 27 Aug 2026 14:30:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CBF42004D;
 Thu, 27 Aug 2026 14:30:23 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 27 Aug 2026 14:30:22 +0000 (GMT)
Date: Thu, 27 Aug 2026 19:59:51 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v3 02/37] target/ppc: Migrate atomic loads to decodetree
Message-ID: <20260827195658.90577edc-2c-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260827133010.278889-1-rathc@linux.ibm.com>
 <20260827133010.278889-3-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827133010.278889-3-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a904a0b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=MCnIianJWhgdr52yIC4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExOCBTYWx0ZWRfX6uMSYHyLYGPE
 PMs71InXKjuVw5EC49PZ1hxCB0EapzNTTdxJNvCvIyG9GQDE3rbBVIWFBFRQsnK24shxIZ1saUL
 NbHF9Tr2lsvz4TvApbQJH27YDGbTomY=
X-Proofpoint-GUID: W_jqJddaiWro5PXBlDDlMZQK5DZXmSNl
X-Proofpoint-ORIG-GUID: 07uHlX8AWtjB6u-DC6J142IxTq_yRAG6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExOCBTYWx0ZWRfX/vsfckpxJAjv
 25cr6B4wYyyPenTVRtMSaY/bBAwMucmJbp37hVmXZCa6KZvOzZmpkxYxRozxgn/zpz3WuYhIIoJ
 L5etLgh6NDHhc5qFfdzNPViV2RmKUyXAYyCvJJMyg7W8UDfKhBwlrkqMPwJWEW0I8OELS3fs8/F
 6bUBjBzA67zh+YyW7aUBZp7/DB8Zrbh86Dv7KYvpODUW+I13JqLxHbmoxdX7XL7s+OmW+UZlwch
 UeYgB7aTjQqjoWIA1Vvq1RrV8skJ9KsXK0b3XVwo9B1TjfX8N6h8D+V+5ExW/5vZEv8DVYflgbd
 1qZANcRkFY11KOX5TN+GdMDDVtIsXvDTUqW/UoymMtF5wXbO4IuNz+rJn8SoL5AbguO1FWs9cs+
 gn7jhiMoVuvnR+Tnvp4rlZ4YNSF9ACq38Dm/VvBKp92kOX4VGAJOFGnTDqxc0E/QwqStVT3JCA2
 fXxhNgEJey14GVXiGnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270118
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

Hi Chinmay,

Thanks for addressing the reviews comments on v2 and sending the v3.

On 2026/08/27 06:59 PM, Chinmay Rath wrote:
> From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> 
> Migrate load-and-reserve instructions (lbarx, lharx, lwarx, ldarx,
> lqarx) to decodetree using the X-form layout.
> 
> A shared helper (do_load_locked) is introduced for standard-width
> variants, while LQARX is handled separately due to its 128-bit
> semantics and register pairing constraints.
> 
> The implementation preserves legacy behavior, including:
>   - Reservation granularity and overwrite semantics
>   - Alignment requirements
>   - Invalid instruction cases for LQARX
> 
> Testing:
>   - Verified TCG equivalence with legacy implementation
> 
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode |   7 +++
>  target/ppc/translate.c   | 118 +++++++++++++++++++--------------------
>  2 files changed, 63 insertions(+), 62 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 342e65dadf..26948e08a7 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1309,6 +1309,13 @@ XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
>  ##Extend Sign Word and Shift Left Immediate XS-form
>  EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
>  
> +## Load and Reserve Instructions
> +LBARX           011111 ..... ..... ..... 0000110100 .   @X_rc
> +LHARX           011111 ..... ..... ..... 0001110100 .   @X_rc
> +LWARX           011111 ..... ..... ..... 0000010100 .   @X_rc
> +LDARX           011111 ..... ..... ..... 0001010100 .   @X_rc
> +LQARX           011111 ..... ..... ..... 0100010100 .   @X_rc
> +
>  ## Vector Division Instructions
>  
>  VDIVSW          000100 ..... ..... ..... 00110001011    @VX
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e627f48f9e..69c4443dda 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2947,30 +2947,6 @@ static void gen_isync(DisasContext *ctx)
>      ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>  }
>  
> -static void gen_load_locked(DisasContext *ctx, MemOp memop)
> -{
> -    TCGv gpr = cpu_gpr[rD(ctx->opcode)];
> -    TCGv t0 = tcg_temp_new();
> -
> -    gen_set_access_type(ctx, ACCESS_RES);
> -    gen_addr_reg_index(ctx, t0);
> -    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | MO_ALIGN);
> -    tcg_gen_mov_tl(cpu_reserve, t0);
> -    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
> -    tcg_gen_mov_tl(cpu_reserve_val, gpr);
> -}
> -
> -#define LARX(name, memop)                  \
> -static void gen_##name(DisasContext *ctx)  \
> -{                                          \
> -    gen_load_locked(ctx, memop);           \
> -}
> -
> -/* lwarx */
> -LARX(lbarx, MO_UB)
> -LARX(lharx, MO_UW)
> -LARX(lwarx, MO_UL)
> -
>  static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
>                                        TCGv EA, TCGCond cond, int addend)
>  {
> @@ -3219,42 +3195,9 @@ STCX(sthcx_, MO_UW)
>  STCX(stwcx_, MO_UL)
>  
>  #if defined(TARGET_PPC64)
> -/* ldarx */
> -LARX(ldarx, MO_UQ)
>  /* stdcx. */
>  STCX(stdcx_, MO_UQ)
>  
> -/* lqarx */
> -static void gen_lqarx(DisasContext *ctx)
> -{
> -    int rd = rD(ctx->opcode);
> -    TCGv EA, hi, lo;
> -    TCGv_i128 t16;
> -
> -    if (unlikely((rd & 1) || (rd == rA(ctx->opcode)) ||
> -                 (rd == rB(ctx->opcode)))) {
> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> -        return;
> -    }
> -
> -    gen_set_access_type(ctx, ACCESS_RES);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> -
> -    /* Note that the low part is always in RD+1, even in LE mode.  */
> -    lo = cpu_gpr[rd + 1];
> -    hi = cpu_gpr[rd];
> -
> -    t16 = tcg_temp_new_i128();
> -    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
> -    tcg_gen_extr_i128_i64(lo, hi, t16);
> -
> -    tcg_gen_mov_tl(cpu_reserve, EA);
> -    tcg_gen_movi_tl(cpu_reserve_length, 16);
> -    tcg_gen_st_tl(hi, tcg_env, offsetof(CPUPPCState, reserve_val));
> -    tcg_gen_st_tl(lo, tcg_env, offsetof(CPUPPCState, reserve_val2));
> -}
> -
>  /* stqcx. */
>  static void gen_stqcx_(DisasContext *ctx)
>  {
> @@ -5741,6 +5684,62 @@ static bool trans_EXTSWSLI(DisasContext *ctx, arg_XS *a)
>      return true;
>  }
>  
> +/*
> + * Load-and-reserve core
> + */
> +static bool do_load_locked(DisasContext *ctx, arg_X_rc *a, MemOp memop)
> +{
> +    TCGv EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    TCGv gpr = cpu_gpr[a->rt];
> +
> +    gen_set_access_type(ctx, ACCESS_RES);
> +
> +    tcg_gen_qemu_ld_tl(gpr, EA, ctx->mem_idx, memop | MO_ALIGN);
> +
> +    tcg_gen_mov_tl(cpu_reserve, EA);
> +    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
> +
> +    tcg_gen_mov_tl(cpu_reserve_val, gpr);
> +
> +    return true;
> +}
> +
> +TRANS_FLAGS2(ATOMIC_ISA206, LBARX, do_load_locked, DEF_MEMOP(MO_UB))
> +TRANS_FLAGS2(ATOMIC_ISA206, LHARX, do_load_locked, DEF_MEMOP(MO_UW))
> +TRANS(LWARX, do_load_locked, DEF_MEMOP(MO_UL))
> +TRANS64(LDARX, do_load_locked, DEF_MEMOP(MO_UQ))
> +
> +static bool trans_LQARX(DisasContext *ctx, arg_LQARX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
> +#if defined(TARGET_PPC64)
> +    TCGv EA;
> +    TCGv_i128 t16;
> +    /* Must use even register and avoid overlap */
> +    if (unlikely((a->rt & 1) || (a->rt == a->ra) || (a->rt == a->rb))) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_RES);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    t16 = tcg_temp_new_i128();
> +
> +    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
> +    tcg_gen_extr_i128_i64(cpu_gpr[a->rt + 1], cpu_gpr[a->rt], t16);
> +    tcg_gen_mov_tl(cpu_reserve, EA);
> +    tcg_gen_movi_tl(cpu_reserve_length, 16);

LGTM.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> +    tcg_gen_st_i64(cpu_gpr[a->rt], tcg_env,
> +                   offsetof(CPUPPCState, reserve_val));
> +    tcg_gen_st_i64(cpu_gpr[a->rt + 1], tcg_env,
> +                   offsetof(CPUPPCState, reserve_val2));
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
>  #include "translate/fixedpoint-impl.c.inc"
>  
>  #include "translate/fp-impl.c.inc"
> @@ -5853,9 +5852,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>  GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
> -GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> -GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> -GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
>  GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> @@ -5864,8 +5860,6 @@ GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
> -GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
>  GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
>  GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, PPC2_LSQ_ISA207),
>  #endif
> -- 
> 2.55.0
> 

