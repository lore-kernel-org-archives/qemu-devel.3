Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7ACC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFQN-00035k-MM; Wed, 26 Aug 2026 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzFQL-000350-Mi; Wed, 26 Aug 2026 11:20:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzFQ7-0008Tv-2P; Wed, 26 Aug 2026 11:20:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1fsH4099711; Wed, 26 Aug 2026 15:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AHlRgO
 zV+vEOX93wYInBJ7h/hFuMoxHb3tYYBmfZ6nk=; b=XChIxgFHmUhKkjjwo4+CEW
 vwgWR1Yi632O5eLUaaFfNRHrtIB8TKfRty3R0xSmWmdhW91K90mi0q5oG18sOA/m
 3Gb90WywzK+uDlg2S4FP470+IhtCcPfJd8OyBbMnKXgJy5kc9i/HrtnA9LUVysYN
 VKYuDIEBYSdBXwVeDdp8sjgmkkQdpyH8Y39MpwaBkK2/KwXvhS3IUNxHMEaU5Fxm
 XH/Uhgb2pLykbgbumADv11BevJkhbHNOmVUChPsd0vSO7sgyeM1SYaR07qbwjRrK
 CnTMBKgjTlPa1BWk3Dstij95JvqWnnIcmAR764A5Rt9d+YIr5qrg0WyOSlG21gzQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hym1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 15:20:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QFBPtt006952;
 Wed, 26 Aug 2026 15:20:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k2nb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 15:20:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QFJxnw49152306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 15:19:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E94D20049;
 Wed, 26 Aug 2026 15:19:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B65D20040;
 Wed, 26 Aug 2026 15:19:56 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 15:19:55 +0000 (GMT)
Date: Wed, 26 Aug 2026 20:49:59 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 23/37] target/ppc: Move Fixed-Point Load/Store String
 instructions to decodetree.
Message-ID: <20260826203141.9ef11e8b-12-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-24-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826050923.74756-24-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXxuCJjhHULD9Y
 V5iQwZb22gNq1Z7rTqWHKzmMGo7B03ps+TKbjRizMPcoxDiB5kFJOD76V5KrfIoGw8FMnE3Uevl
 qjZLti9yE7R0VkOXe0bDAyCVILf+zOw=
X-Proofpoint-GUID: cbFshVcrdwG4KNmcVVSbBA3Rb7xiUIRS
X-Proofpoint-ORIG-GUID: PqEcLSnqr8OAHujHDcrSGNw2rTe8uRpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX1MmclOqJ8xKJ
 jqMiZIPx0GQvmJ2INX/AgSmy1DgEKrwVsXtmvhZVixUhTwC12sQxmus8xT+3zKuGDuZ+LWcJAhS
 HaU34VzebSkTnLtJSKts2wFT1vd2LaPfPvDCrUvdQ+6Po2lhUDMoOqI57JGqlAxEamV952gyBjy
 j7a3/Q9E+vv9ZLrrdotS1DthjMxMwBV2tCETbFaOf94hsxl9O4xSwygJLHImjXbSgQQTvdDQSCf
 Tqews/h+mLYQTJgDd0bz1PDjtPQEf61sDziDAinLcDgxlvunjenukPjOuYjRajDff5udQ8Xopbk
 Jx2vNHaUoUyM3jNI0jLQYej+2GLaTS8a4TrFUH3UbZMTOvgBOd+hBoTxTWgYyUIcrxGqPDE8Gd1
 Ddjnvmhpq3Y+x+HGOZ7We1QlXcbg48UBVg2o2tvKyd5DQStkOSI6BHIr6H9v1bpirdf0KEPcLws
 NTkW+qYyz1wGOyKnvNg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f0424 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=tYh36PFVI03M1B_yqkwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125
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
> From: Shivang Upadhyay <shivangu@linux.ibm.com>
> 
> Move below instructions to decodetree specification :
> 
>         lsw{i, x},
>         stsw{i, x}                       : X-form
> 
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/helper.h                        |   6 +-
>  target/ppc/insn32.decode                   |   7 ++
>  target/ppc/mem_helper.c                    |   6 +-
>  target/ppc/translate.c                     | 102 --------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 103 +++++++++++++++++++++
>  5 files changed, 116 insertions(+), 108 deletions(-)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 7e15676122..0e8b96d0ec 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -45,9 +45,9 @@ DEF_HELPER_1(check_tlb_flush_global, void, env)
>  
>  DEF_HELPER_3(lmw, void, env, tl, i32)
>  DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
> -DEF_HELPER_4(lsw, void, env, tl, i32, i32)
> -DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
> -DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> +DEF_HELPER_4(LSW, void, env, tl, i32, i32)
> +DEF_HELPER_5(LSWX, void, env, tl, i32, i32, i32)
> +DEF_HELPER_FLAGS_4(STSW, TCG_CALL_NO_WG, void, env, tl, i32, i32)
>  DEF_HELPER_FLAGS_3(DCBZ, TCG_CALL_NO_WG, void, env, tl, int)
>  #ifdef TARGET_PPC64
>  DEF_HELPER_FLAGS_2(DCBZL, TCG_CALL_NO_WG, void, env, tl)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index a3973e042d..e7b5d19cde 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -527,6 +527,13 @@ CREQV           010011 ..... ..... ..... 0100100001 -  @X
>  CRANDC          010011 ..... ..... ..... 0010000001 -  @X
>  CRORC           010011 ..... ..... ..... 0110100001 -  @X
>  
> +# Fixed Point Move Assist Instructions
> +
> +LSWI            011111 ..... ..... ..... 1 001010101 -  @X
> +LSWX            011111 ..... ..... ..... 1 000010101 -  @X
> +STSWI           011111 ..... ..... ..... 1 011010101 -  @X
> +STSWX           011111 ..... ..... ..... 1 010010101 -  @X
> +
>  # Fixed-Point Hash Instructions
>  
>  HASHST          011111 ..... ..... ..... 1011010010 .   @X_DW
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 95a224e74c..582180cf88 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -190,7 +190,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>      env->gpr[reg] = val;
>  }
>  
> -void helper_lsw(CPUPPCState *env, target_ulong addr,
> +void helper_LSW(CPUPPCState *env, target_ulong addr,
>                  uint32_t nb, uint32_t reg)
>  {
>      do_lsw(env, addr, nb, reg, GETPC());
> @@ -202,7 +202,7 @@ void helper_lsw(CPUPPCState *env, target_ulong addr,
>   * this is valid, but rA won't be loaded.  For now, I'll follow the
>   * spec...
>   */
> -void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
> +void helper_LSWX(CPUPPCState *env, target_ulong addr, uint32_t reg,
>                   uint32_t ra, uint32_t rb)
>  {
>      if (likely(xer_bc != 0)) {
> @@ -218,7 +218,7 @@ void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
>      }
>  }
>  
> -void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
> +void helper_STSW(CPUPPCState *env, target_ulong addr, uint32_t nb,
>                   uint32_t reg)
>  {
>      uintptr_t raddr = GETPC();
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e40841b68e..712990cf2d 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2595,104 +2595,6 @@ static void gen_stmw(DisasContext *ctx)
>      gen_helper_stmw(tcg_env, t0, t1);
>  }
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
>  #if !defined(CONFIG_USER_ONLY)
>  static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
> @@ -4914,10 +4816,6 @@ GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>  GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>  GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
> -GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
> -GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
> -GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>  /* ISA v3.0 changed the extended opcode from 62 to 30 */
>  GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>  #if defined(TARGET_PPC64)
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 26b308e435..82fb645279 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -585,6 +585,109 @@ TRANS(CRANDC, cr_logic_common, tcg_gen_andc_i32);
>  TRANS(CREQV, cr_logic_common, tcg_gen_eqv_i32);
>  TRANS(CRORC, cr_logic_common, tcg_gen_orc_i32);
>  
> +

This is extra blank line. Please remove.

> +/***                    Integer load and store strings                     ***/

This banner-comment might not needed. But don't have any strong feelings
about it.

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
> +    REQUIRE_INSNS_FLAGS(ctx, STRING);
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
> +    t0 = do_ea_calc_ra(ctx, ra);
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
> +    REQUIRE_INSNS_FLAGS(ctx, STRING);
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
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
> +    REQUIRE_INSNS_FLAGS(ctx, STRING);
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = do_ea_calc_ra(ctx, a->ra);
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
> +    REQUIRE_INSNS_FLAGS(ctx, STRING);
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = do_ea_calc_ra(ctx, a->ra);

STSWX is X-form indexed. As per Power ISA:

  EA ← (RA=0 ? 0 : (RA)) + (RB)

do_ea_calc_ra only computes (RA=0 ? 0 : GPR[RA]) — GPR[RB] is never
added. Any stswx with a non-zero RB will store to the wrong address.

The old gen_stswx correctly called gen_addr_reg_index() which includes
the RB addition. trans_LSWX (three functions above) also gets this
right. Fix:

-    t0 = do_ea_calc_ra(ctx, a->ra);
+    t0 = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);

Note: do_ea_calc_ra is correct for trans_LSWI and trans_STSWI because
those are the immediate forms — their ISA EA is also (RA==0 ? 0 :
GPR[RA]) with no RB term; the RB field carries NB, not a register EA
operand.

> +    t1 = tcg_temp_new_i32();
> +    tcg_gen_trunc_tl_i32(t1, cpu_xer);
> +    tcg_gen_andi_i32(t1, t1, 0x7F);
> +    t2 = tcg_constant_i32(a->rt);
> +    gen_helper_STSW(tcg_env, t0, t1, t2);
> +
> +    return true;
> +}
> +
>  static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
>                       bool compute_ov, bool compute_rc0)
>  {
> -- 
> 2.55.0
> 

