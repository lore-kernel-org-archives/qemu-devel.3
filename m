Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2A9C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzC1B-00029V-7B; Wed, 26 Aug 2026 07:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzC19-00029J-TY; Wed, 26 Aug 2026 07:42:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzC17-0006PK-KM; Wed, 26 Aug 2026 07:42:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAVXBr3739511; Wed, 26 Aug 2026 11:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=F3iIjBrh9JFyiQB9kEkTwhT3fzRvz8
 uA1AkBD+wq00c=; b=VZxEA1TrFPdAOiZXG2pqfqtXD7cfc9KY5PTGTnBpOKi72h
 2MltLlmTLOrpjFhA9u9ggzKkadc1FOdY6nCL+FxQ3vVfltwaEL8UoUaNFWk0jzAh
 G5GyXMsD1K0NmBwAwi3jfhjSZPABa5BSxX9p1v3YXBz3kExppnGmNzOIjPEQU1LR
 TjXucuVtdBZnVMTqC+GLdi8Kn3oIZibx7g0Y5rvTsoUp3uxYRfNow1DUov/XxPyS
 1EVomvfZOpZxuwclJeo9+SmQK7xLCZGcHwHILhhmaS+P6RaKcfBStxEbnsnYXxta
 qIq0pfFvSTV8aJWMeUpqdYCz3IbjyT/nFP/uPh4g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xbwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 11:42:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QBfHln009271;
 Wed, 26 Aug 2026 11:42:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy9emq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 11:42:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QBfvjq30802614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 11:41:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03DD12004B;
 Wed, 26 Aug 2026 11:41:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5CA520040;
 Wed, 26 Aug 2026 11:41:53 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 11:41:53 +0000 (GMT)
Date: Wed, 26 Aug 2026 17:11:56 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 08/37] target/ppc: convert sraw[i] instruction via
 decode spec
Message-ID: <20260826170141.eca7a46c-da-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-9-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-9-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YU9mc99vASJXmgV0__1COKroAMHLsMXl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5NiBTYWx0ZWRfX+ZW94nIE0zFa
 1W0lTmavIvW+PzwQqupyo3LhmuWEII+Ep0hurXYY8oYBn1UJ5mRaWHG6DJYfeaVUFeDufd7HJ5H
 KZFH/xddnz+OW+FEnNN4nb80pHe/Dxs=
X-Proofpoint-GUID: kb1pNV8eRW7gpGWrJNlYnVMvPrcbSDBZ
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ed10a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=8M8_vv8UltN0WuAFs38A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5NiBTYWx0ZWRfX2bx0Ufze3QQx
 9Cl6c42K3PpUdOnlR2H7OCmb3iu1jasEVjeYL4gpMmlxVWowvtBHbCYr9iVaOauhLlKK4I3uku+
 /87sRsf4x+YuoCp0tEvdpCbqZKO7c6RsPQYOAXEUAxdaj+TuHplKuWdy2sYSDtTRGPcF71ydTme
 r9z0NLgH3sYV87+HkxlS+JHqRe+ZZovQU4P8kxG8oEJ0Emat4esq5CnLFVfqTiLaMvTSRy0wWd8
 vBbJNXWUXElCFhVJn6633pPww+UpeRY3l0aGvbA7NGPFv5l1nZIprFf6S3nYItTYN0W6nINqULz
 Pn0ZVghVb7feXOHZyg62OaHDH7UwHOV9mmUZIuR7oJ9JGnkKfWmFttqHbBI41m+vi+1hWXjcVoo
 L4AGwShTTI583tuhg3HhrFwssDO7PHAuG30EtU7FAt4/6pj4xiQtH3PTS+tXWIXYnaxhayUBqKz
 Oh3g6nurftL7tsi0DZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260096
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/26 10:38 AM, Chinmay Rath wrote:
> From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
> 
> Instruction converted:
> 
> - sraw
> - srawi

This doesn't give the idea on what is being done - could have been more
explicit that the insns are being moved to decode tree spec. But its
upto you.

> 
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/helper.h                        |  2 +-
>  target/ppc/insn32.decode                   |  6 ++--
>  target/ppc/int_helper.c                    |  2 +-
>  target/ppc/translate.c                     | 42 ----------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 41 +++++++++++++++++++++
>  5 files changed, 47 insertions(+), 46 deletions(-)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 6df3de6516..3aff559504 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -64,7 +64,7 @@ DEF_HELPER_4(DIVWE, tl, env, tl, tl, i32)
>  
>  DEF_HELPER_FLAGS_1(POPCNTB, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_2(CMPB, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> -DEF_HELPER_3(sraw, tl, env, tl, tl)
> +DEF_HELPER_3(SRAW, tl, env, tl, tl)
>  DEF_HELPER_FLAGS_2(CFUGED, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>  DEF_HELPER_FLAGS_2(PDEPD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>  DEF_HELPER_FLAGS_2(PEXTD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 66d2f455a9..af35a44223 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -507,8 +507,10 @@ HASHCHKP        011111 ..... ..... ..... 1010110010 .   @X_DW
>  
>  # Fixed-Point Shift Instructions
>  
> -SLW		011111 ..... ..... ..... 0000011000 .	@X_rc
> -SRW		011111 ..... ..... ..... 1000011000 .	@X_rc
> +SLW             011111 ..... ..... ..... 0000011000 .   @X_rc
> +SRAW            011111 ..... ..... ..... 1100011000 .   @X_rc
> +SRAWI           011111 ..... ..... ..... 1100111000 .   @X_rc
> +SRW             011111 ..... ..... ..... 1000011000 .   @X_rc
>  
> 

Nit: extra blank line can be removed. Otherwise, the changes look good
to me.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

>  ## BCD Assist
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index dc55ccadf7..b161f930ec 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -235,7 +235,7 @@ target_ulong helper_CMPB(target_ulong rs, target_ulong rb)
>  }
>  
>  /* shift right arithmetic helper */
> -target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
> +target_ulong helper_SRAW(CPUPPCState *env, target_ulong value,
>                           target_ulong shift)
>  {
>      int32_t ret;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f2b7505634..f00071aa91 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2316,46 +2316,6 @@ GEN_PPC64_R4(rldimi, 0x1E, 0x06);
>  /***                             Integer shift                             ***/
>  
>  
> -/* sraw & sraw. */
> -static void gen_sraw(DisasContext *ctx)
> -{
> -    gen_helper_sraw(cpu_gpr[rA(ctx->opcode)], tcg_env,
> -                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
> -    }
> -}
> -
> -/* srawi & srawi. */
> -static void gen_srawi(DisasContext *ctx)
> -{
> -    int sh = SH(ctx->opcode);
> -    TCGv dst = cpu_gpr[rA(ctx->opcode)];
> -    TCGv src = cpu_gpr[rS(ctx->opcode)];
> -    if (sh == 0) {
> -        tcg_gen_ext32s_tl(dst, src);
> -        tcg_gen_movi_tl(cpu_ca, 0);
> -        if (is_isa300(ctx)) {
> -            tcg_gen_movi_tl(cpu_ca32, 0);
> -        }
> -    } else {
> -        TCGv t0;
> -        tcg_gen_ext32s_tl(dst, src);
> -        tcg_gen_andi_tl(cpu_ca, dst, (1ULL << sh) - 1);
> -        t0 = tcg_temp_new();
> -        tcg_gen_sari_tl(t0, dst, TARGET_LONG_BITS - 1);
> -        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
> -        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
> -        if (is_isa300(ctx)) {
> -            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
> -        }
> -        tcg_gen_sari_tl(dst, dst, sh);
> -    }
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, dst);
> -    }
> -}
> -
>  #if defined(TARGET_PPC64)
>  /* sld & sld. */
>  static void gen_sld(DisasContext *ctx)
> @@ -5730,8 +5690,6 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(sraw, 0x1F, 0x18, 0x18, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(srawi, 0x1F, 0x18, 0x19, 0x00000000, PPC_INTEGER),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(sld, 0x1F, 0x1B, 0x00, 0x00000000, PPC_64B),
>  GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 9d04b96316..234404e459 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -1454,3 +1454,44 @@ static bool trans_SRW(DisasContext *ctx, arg_SRW *a)
>      }
>      return true;
>  }
> +
> +/* sraw & sraw. */
> +static bool trans_SRAW(DisasContext *ctx, arg_SRAW *a)
> +{
> +    gen_helper_SRAW(cpu_gpr[a->ra], tcg_env,
> +                    cpu_gpr[a->rt], cpu_gpr[a->rb]);
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
> +    }
> +    return true;
> +}
> +
> +/* srawi & srawi. */
> +static bool trans_SRAWI(DisasContext *ctx, arg_SRAWI *a)
> +{
> +    TCGv dst = cpu_gpr[a->ra];
> +    TCGv src = cpu_gpr[a->rt];
> +    if (a->rb == 0) {
> +        tcg_gen_ext32s_tl(dst, src);
> +        tcg_gen_movi_tl(cpu_ca, 0);
> +        if (is_isa300(ctx)) {
> +            tcg_gen_movi_tl(cpu_ca32, 0);
> +        }
> +    } else {
> +        TCGv t0;
> +        tcg_gen_ext32s_tl(dst, src);
> +        tcg_gen_andi_tl(cpu_ca, dst, (1ULL << a->rb) - 1);
> +        t0 = tcg_temp_new();
> +        tcg_gen_sari_tl(t0, dst, TARGET_LONG_BITS - 1);
> +        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
> +        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
> +        if (is_isa300(ctx)) {
> +            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
> +        }
> +        tcg_gen_sari_tl(dst, dst, a->rb);
> +    }
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, dst);
> +    }
> +    return true;
> +}
> -- 
> 2.55.0
> 

