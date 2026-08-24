Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED3BC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVlq-0006Y0-0u; Mon, 24 Aug 2026 10:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVlj-0006Uq-QK; Mon, 24 Aug 2026 10:35:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVlg-0004qL-CV; Mon, 24 Aug 2026 10:35:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1ZEl085360; Mon, 24 Aug 2026 14:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=3GOCpmd2yQbWbAAzogvlYdM4V/lWEQxJ7yoyhNG8fvQ=; b=tAiOuRBfOh5o
 4kMJo7fVlcF4neZR3Zh/LWT5PhLpLSGhGuh1j8rHCbJ3mjaQiKGGhQegTrrehwaO
 L+0/XHBB6jgUd1QuowHhwpHOhsctFLxz6Yxrw1/cZ9+7JTzKsmyqqi8zGi8ihaT5
 jjLJKFaSizrJd8CCXTHY2PSdqA39KH9yiF39WH8d4d1Os1f3rDKmi0xokRCmsb1s
 WpBOf6mMo4QMr4yiH+p4DK4vi4ErUUdJqtkcyE2VuuLGBA9Vd7Vc05krvu/TlRgL
 DIiAQP0u8a9s03MbjQIwAqsN9vP3pk/UOUONfWddK02GLP4Dd+U2i8u8LxRjC1MO
 NSr8NChMhg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhyb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:35:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQJsi001439;
 Mon, 24 Aug 2026 14:35:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxncd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:35:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEZExU50987286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:35:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0D3A5805D;
 Mon, 24 Aug 2026 14:35:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DCDE58057;
 Mon, 24 Aug 2026 14:35:13 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:35:13 +0000 (GMT)
Message-ID: <1112755a21f50fdfb196eba9f5eb697c33ca0ae0.camel@linux.ibm.com>
Subject: Re: [PATCH 10/29] target/ppc: Move fixed-point Shift insns to
 decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:35:12 -0500
In-Reply-To: <20260820140114.327023-11-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-11-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dYrQnjDXeD4xkxbtS0smSj0X8wwSufoU
X-Proofpoint-ORIG-GUID: AJqKfTWsUwhdLGXP9CB61XdASugtKKK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXwy/ZtNf+X8Ff
 RO+xWgVC78o90TjtOSHGdWxGV6t/xBP+/sY00bViXt7VTsBkI1nTq0jrknmJ0oBAg8pbsSv3fuj
 kDFt978hwOwUqnNkSbOG7KOG/Gwn5dNiqoF9Upte/fq1j/ArDRCsGESmTInWQoIs4sjltUFoSZb
 DTo/ZPC5rlHYi0g8gVCFd3H9mc7AzS4o6GqOvhv5Sx8u/AdbD9kHPw0citf9YY59XdDkUgJja3I
 VqIIvENX8we+OgkDq5kk3Co0n32RQ6pxN28+MX9RgNMN3nlkraw4F0JlrG5RDOsfhN/aw3+adki
 /0/Pj8oPo9+5v5aQu7aG1io1m+J3+nNkwISU9+b721Kz5qnEsYNfShIYtPoqXuuj2wnMF1CrZAB
 PNn7+O06YDEmdxk5alp2KyNOVA1wmy2uRu6vj2DDZ7r0V5XUyMyc8lgLlUuh/4Ryq+iaXSL8Wxx
 WPW/u4ZORh+aPHYhSSA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c56a5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=nS5i6hYCZiJu3-3QlJkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX4xm8oYRowvm/
 fL4AMdn69U/drMAFDLOPk61X38Jbx/hZ3RhT6nIH3WReiKIGuAToOgYV35XLSNeRYWHIwJOPXrd
 g86PkJiP/dUd5NE/10TGXwaSeYvLUIQ=
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
> From: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> Move the below instructions to decodetree specification:
> 
>   s{r,l}d, and srad[i]					: X-form
> 
> The changes were verified by validating that the TCG ops generated by
> these instructions remain the same after these changes. The TCG
> micro-ops were captured with the '-d op,in_asm' QEMU flag.
> 
> Move all shift insntructions to one place in insn32.decode
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/helper.h                        |  2 +-
>  target/ppc/insn32.decode                   | 11 ++-
>  target/ppc/int_helper.c                    |  2 +-
>  target/ppc/translate.c                     | 96 ----------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 72 ++++++++++++++++
>  5 files changed, 81 insertions(+), 102 deletions(-)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 3aff559504..cd2a0948a3 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -74,7 +74,7 @@ DEF_HELPER_FLAGS_1(CBCDTD, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_2(CMPEQB, TCG_CALL_NO_RWG_SE, i32, tl, tl)
>  DEF_HELPER_FLAGS_1(POPCNTW, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_2(BPERMD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> -DEF_HELPER_3(srad, tl, env, tl, tl)
> +DEF_HELPER_3(SRAD, tl, env, tl, tl)
>  DEF_HELPER_FLAGS_0(DARN32, TCG_CALL_NO_RWG, tl)
>  DEF_HELPER_FLAGS_0(DARN64, TCG_CALL_NO_RWG, tl)
>  #endif
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 7d792d2318..d34094d717 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -119,7 +119,7 @@
>  
>  # XS-form with fractured shift amount
>  %xs_sh           1:1 11:5
> -&XS              rs ra sh rc
> +&XS              rs ra sh rc:bool
>  @XS              ...... rs:5 ra:5 ..... ......... . rc:1        &XS sh=%xs_sh
>  
>  %x_frtp         22:4 !function=times_2
> @@ -512,6 +512,12 @@ SRAW            011111 ..... ..... ..... 1100011000 .   @X_rc
>  SRAWI           011111 ..... ..... ..... 1100111000 .   @X_rc
>  SRW             011111 ..... ..... ..... 1000011000 .   @X_rc
>  
> +SLD             011111 ..... ..... ..... 0000011011 .   @X_rc
> +SRD             011111 ..... ..... ..... 1000011011 .   @X_rc
> +SRAD            011111 ..... ..... ..... 1100011010 .   @X_rc
> +SRADI           011111 ..... ..... ..... 110011101 . .  @XS
> +
> +EXTSWSLI        011111 ..... ..... ..... 110111101 . .  @XS
>  
>  ## BCD Assist
>  
> @@ -1382,9 +1388,6 @@ DST             011111 ----- ..... ..... 0101010110 -   @X_ea
>  DSTST           011111 ----- ..... ..... 0101110110 -   @X_ea
>  DSS             011111 ----- ..... ..... 1100110110 -   @X_ea
>  
> -##Extend Sign Word and Shift Left Immediate XS-form
> -EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
> -
>  ## Load and Reserve Instructions
>  LBARX           011111 ..... ..... ..... 0000110100 .   @X_rc
>  LHARX           011111 ..... ..... ..... 0001110100 .   @X_rc
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index b161f930ec..8e8076a92c 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -261,7 +261,7 @@ target_ulong helper_SRAW(CPUPPCState *env, target_ulong value,
>  }
>  
>  #if defined(TARGET_PPC64)
> -target_ulong helper_srad(CPUPPCState *env, target_ulong value,
> +target_ulong helper_SRAD(CPUPPCState *env, target_ulong value,
>                           target_ulong shift)
>  {
>      int64_t ret;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 55b515cec7..09a461dd63 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2313,95 +2313,6 @@ static void gen_rldimi(DisasContext *ctx, int mbn, int shn)
>  GEN_PPC64_R4(rldimi, 0x1E, 0x06);
>  #endif
>  
> -/***                             Integer shift                             ***/
> -
> -
> -#if defined(TARGET_PPC64)
> -/* sld & sld. */
> -static void gen_sld(DisasContext *ctx)
> -{
> -    TCGv t0, t1;
> -
> -    t0 = tcg_temp_new();
> -    /* AND rS with a mask that is 0 when rB >= 0x40 */
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x39);
> -    tcg_gen_sari_tl(t0, t0, 0x3f);
> -    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
> -    t1 = tcg_temp_new();
> -    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x3f);
> -    tcg_gen_shl_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
> -    }
> -}
> -
> -/* srad & srad. */
> -static void gen_srad(DisasContext *ctx)
> -{
> -    gen_helper_srad(cpu_gpr[rA(ctx->opcode)], tcg_env,
> -                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
> -    }
> -}
> -/* sradi & sradi. */
> -static inline void gen_sradi(DisasContext *ctx, int n)
> -{
> -    int sh = SH(ctx->opcode) + (n << 5);
> -    TCGv dst = cpu_gpr[rA(ctx->opcode)];
> -    TCGv src = cpu_gpr[rS(ctx->opcode)];
> -    if (sh == 0) {
> -        tcg_gen_mov_tl(dst, src);
> -        tcg_gen_movi_tl(cpu_ca, 0);
> -        if (is_isa300(ctx)) {
> -            tcg_gen_movi_tl(cpu_ca32, 0);
> -        }
> -    } else {
> -        TCGv t0;
> -        tcg_gen_andi_tl(cpu_ca, src, (1ULL << sh) - 1);
> -        t0 = tcg_temp_new();
> -        tcg_gen_sari_tl(t0, src, TARGET_LONG_BITS - 1);
> -        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
> -        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
> -        if (is_isa300(ctx)) {
> -            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
> -        }
> -        tcg_gen_sari_tl(dst, src, sh);
> -    }
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, dst);
> -    }
> -}
> -
> -static void gen_sradi0(DisasContext *ctx)
> -{
> -    gen_sradi(ctx, 0);
> -}
> -
> -static void gen_sradi1(DisasContext *ctx)
> -{
> -    gen_sradi(ctx, 1);
> -}
> -
> -/* srd & srd. */
> -static void gen_srd(DisasContext *ctx)
> -{
> -    TCGv t0, t1;
> -
> -    t0 = tcg_temp_new();
> -    /* AND rS with a mask that is 0 when rB >= 0x40 */
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x39);
> -    tcg_gen_sari_tl(t0, t0, 0x3f);
> -    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
> -    t1 = tcg_temp_new();
> -    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x3f);
> -    tcg_gen_shr_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
> -    }
> -}
> -#endif
> -
>  /***                           Addressing modes                            ***/
>  /* Register indirect with immediate index : EA = (rA|0) + SIMM */
>  static inline void gen_addr_imm_index(DisasContext *ctx, TCGv EA,
> @@ -5684,13 +5595,6 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -#if defined(TARGET_PPC64)
> -GEN_HANDLER(sld, 0x1F, 0x1B, 0x00, 0x00000000, PPC_64B),
> -GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
> -GEN_HANDLER2(sradi0, "sradi", 0x1F, 0x1A, 0x19, 0x00000000, PPC_64B),
> -GEN_HANDLER2(sradi1, "sradi", 0x1F, 0x1B, 0x19, 0x00000000, PPC_64B),
> -GEN_HANDLER(srd, 0x1F, 0x1B, 0x10, 0x00000000, PPC_64B),
> -#endif
>  /* handles lfdp, lxsd, lxssp */
>  GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>  /* handles stfdp, stxsd, stxssp */
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 234404e459..9f669894a3 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -486,6 +486,76 @@ static bool do_add_const_XO(DisasContext *ctx, arg_XO_ta *a, TCGv const_val,
>      return true;
>  }
>  
> +static bool do_shift_X_rc(DisasContext *ctx, arg_X_rc *a,
> +                                void(*op)(TCGv, TCGv, TCGv))
> +{
> +    REQUIRE_64BIT(ctx);
> +#if defined(TARGET_PPC64)
> +    TCGv t0 = tcg_temp_new();
> +    TCGv t1 = tcg_temp_new();
> +
> +    /* AND rt with a mask that is 0 when rb >= 0x40 */
> +    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x39);
> +    tcg_gen_sari_tl(t0, t0, 0x3f);
> +    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
> +    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x3f);
> +    op(cpu_gpr[a->ra], t0, t1);
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
> +    }
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_SRAD(DisasContext *ctx, arg_SRAD *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +#if defined(TARGET_PPC64)
> +    gen_helper_SRAD(cpu_gpr[a->ra], tcg_env, cpu_gpr[a->rt], cpu_gpr[a->rb]);
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
> +    }
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_SRADI(DisasContext *ctx, arg_SRADI *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +#if defined(TARGET_PPC64)
> +    int sh = a->sh;
> +    TCGv dst = cpu_gpr[a->ra];
> +    TCGv src = cpu_gpr[a->rs];
> +    if (sh == 0) {
> +        tcg_gen_mov_tl(dst, src);
> +        tcg_gen_movi_tl(cpu_ca, 0);
> +        if (is_isa300(ctx)) {
> +            tcg_gen_movi_tl(cpu_ca32, 0);
> +        }
> +    } else {
> +        TCGv t0 = tcg_temp_new();
> +        tcg_gen_andi_tl(cpu_ca, src, (1ULL << sh) - 1);
> +        tcg_gen_sari_tl(t0, src, TARGET_LONG_BITS - 1);
> +        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
> +        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
> +        if (is_isa300(ctx)) {
> +            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
> +        }
> +        tcg_gen_sari_tl(dst, src, sh);
> +    }
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, dst);
> +    }
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
>  TRANS(ADD, do_add_XO, false, false);
>  TRANS(ADDC, do_add_XO, false, true);
>  TRANS(ADDE, do_add_XO, true, true);
> @@ -493,6 +563,8 @@ TRANS(ADDME, do_add_const_XO, tcg_constant_tl(-1LL), true, true);
>  TRANS(ADDZE, do_add_const_XO, tcg_constant_tl(0), true, true);
>  TRANS(ADDIC, do_add_D, false, true, false, false);
>  TRANS(ADDIC_, do_add_D, false, true, false, true);
> +TRANS(SLD, do_shift_X_rc, tcg_gen_shl_tl);
> +TRANS(SRD, do_shift_X_rc, tcg_gen_shr_tl);
>  
>  static bool trans_SUBFIC(DisasContext *ctx, arg_D *a)
>  {


