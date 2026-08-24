Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790F6C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVij-00043h-M6; Mon, 24 Aug 2026 10:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyViJ-0003z1-7n; Mon, 24 Aug 2026 10:31:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyViD-0002vo-5B; Mon, 24 Aug 2026 10:31:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1Vwc084949; Mon, 24 Aug 2026 14:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=9AKrJvpL0YMai7aUX8Pmuzq0kVBtVosADqXHJGvS3YE=; b=h8mizE4U8HHn
 PIWdCg+TzqfLMMKVKVTsvYQUNj63Ai/jugyIluTpW5clGcwOS0jpvFJ+cZDnVUMD
 GBFglxUyo0dYngG/O1KWesKV6RRPt3aBHRW2gJY++cWeMc62HNjvk4/LXE3b0zyB
 fpbXOqYcieNNtgaDpQm69hi1xoosAbM5PoMSsUvUoJ4Zu4qgrbG4JFzmr9fb5XFz
 kESuPiS6y1R4wOPFeQr6rBGcSTpICz97xGc+ft/mGSP9NJBKSADs/ZpMHr/DMzxB
 u/Ms8P5sf6SvSh08+R7u1hVqP5yO9XpMkgm2p2TZHqzCz+dNyljoZrmIbbngp38l
 yrVVLcGKpw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhxqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:31:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQGvj011155;
 Mon, 24 Aug 2026 14:31:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag6bk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:31:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEVcj433817076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:31:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10F3358061;
 Mon, 24 Aug 2026 14:31:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9D9F5805E;
 Mon, 24 Aug 2026 14:31:36 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:31:36 +0000 (GMT)
Message-ID: <4c399776d9c210fb4f2165f80004e5d62f12c114.camel@linux.ibm.com>
Subject: Re: [PATCH 07/29] target/ppc: convert slw, srw instruction via
 decode spec
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:31:36 -0500
In-Reply-To: <20260820140114.327023-8-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-8-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: CtgN4mZEoOj3RNVLVDP2Qtk0_WTvKlns
X-Proofpoint-ORIG-GUID: D89oDsphDR0_cLS8HP_LO-LNfv9n6xpo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX5R+xzQGzz2fB
 REkaoVCuXrklC4o9azyUt+3gTFhALdkE9V3jJVy75Rr7EGC7EmUP+8IQbQCaJwygm1vif+wYwcP
 9Va7aPyh+JYBBoh6kTz+LJoVZI1YTyRHQw8wevh3fUfUetsguvpIA8G/bxvlOn/O53pI+U5nnMa
 otE4A1hUo+KRrOPRq7OLYsbOhJspG3opK12TXt2lEMbcYZ9an7m1In31MWbsygm1bN9yyf39WHo
 /RV5JwggCNxWO/DHHyK3lcATGxESXUN2I9znqwAU2t0W3LM2Abh3BQvyoL4zAwM8/Xu/t5TPc21
 zQkM2CMCIQl3gzICbflPAwUy2ksurVjCc0dxidd+di18WdZKZ1X6QJGgtQF++YfNY4p/iFZqT82
 S1J/I67m+WIWQ562hKMz/qE+mTrZbVDMYTvi6l0yvhOWi0c+XMDNtzsN3joBh0a+7wBmZRde0az
 TcOzkgT559pkay7QbxQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c55cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=MkwwkY082pzkzX8y5OsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX/zaoQAfCkK9m
 r2jwex8/VEoQvRV26Wee21QTr5UzG4RUAT5w+1rkcWv7X566EwV+OUCEh2FI/RpwV2QeJTKqPnd
 5eNhuadq9gYiw16iVfht4n0zkCTlV+4=
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
> From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
> 
> Instructions converted:
> 
> - slw
> - srw
> 
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                   |  6 +++
>  target/ppc/translate.c                     | 49 ----------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 48 +++++++++++++++++++++
>  3 files changed, 54 insertions(+), 49 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 701c66b347..66d2f455a9 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -505,6 +505,12 @@ HASHCHK         011111 ..... ..... ..... 1011110010 .   @X_DW
>  HASHSTP         011111 ..... ..... ..... 1010010010 .   @X_DW
>  HASHCHKP        011111 ..... ..... ..... 1010110010 .   @X_DW
>  
> +# Fixed-Point Shift Instructions
> +
> +SLW		011111 ..... ..... ..... 0000011000 .	@X_rc
> +SRW		011111 ..... ..... ..... 1000011000 .	@X_rc
> +
> +
>  ## BCD Assist
>  
>  ADDG6S          011111 ..... ..... ..... - 001001010 -  @X
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index ee14fbfd96..f2b7505634 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2315,29 +2315,6 @@ GEN_PPC64_R4(rldimi, 0x1E, 0x06);
>  
>  /***                             Integer shift                             ***/
>  
> -/* slw & slw. */
> -static void gen_slw(DisasContext *ctx)
> -{
> -    TCGv t0, t1;
> -
> -    t0 = tcg_temp_new();
> -    /* AND rS with a mask that is 0 when rB >= 0x20 */
> -#if defined(TARGET_PPC64)
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
> -    tcg_gen_sari_tl(t0, t0, 0x3f);
> -#else
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
> -    tcg_gen_sari_tl(t0, t0, 0x1f);
> -#endif
> -    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
> -    t1 = tcg_temp_new();
> -    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x1f);
> -    tcg_gen_shl_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
> -    tcg_gen_ext32u_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
> -    }
> -}
>  
>  /* sraw & sraw. */
>  static void gen_sraw(DisasContext *ctx)
> @@ -2379,30 +2356,6 @@ static void gen_srawi(DisasContext *ctx)
>      }
>  }
>  
> -/* srw & srw. */
> -static void gen_srw(DisasContext *ctx)
> -{
> -    TCGv t0, t1;
> -
> -    t0 = tcg_temp_new();
> -    /* AND rS with a mask that is 0 when rB >= 0x20 */
> -#if defined(TARGET_PPC64)
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
> -    tcg_gen_sari_tl(t0, t0, 0x3f);
> -#else
> -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
> -    tcg_gen_sari_tl(t0, t0, 0x1f);
> -#endif
> -    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
> -    tcg_gen_ext32u_tl(t0, t0);
> -    t1 = tcg_temp_new();
> -    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x1f);
> -    tcg_gen_shr_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
> -    }
> -}
> -
>  #if defined(TARGET_PPC64)
>  /* sld & sld. */
>  static void gen_sld(DisasContext *ctx)
> @@ -5777,10 +5730,8 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(slw, 0x1F, 0x18, 0x00, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(sraw, 0x1F, 0x18, 0x18, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(srawi, 0x1F, 0x18, 0x19, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(srw, 0x1F, 0x18, 0x10, 0x00000000, PPC_INTEGER),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(sld, 0x1F, 0x1B, 0x00, 0x00000000, PPC_64B),
>  GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 91f9c6c391..9d04b96316 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -1406,3 +1406,51 @@ TRANS(HASHST, do_hash, false, gen_helper_HASHST)
>  TRANS(HASHCHK, do_hash, false, gen_helper_HASHCHK)
>  TRANS(HASHSTP, do_hash, true, gen_helper_HASHSTP)
>  TRANS(HASHCHKP, do_hash, true, gen_helper_HASHCHKP)
> +
> +static bool trans_SLW(DisasContext *ctx, arg_SLW *a)
> +{
> +    TCGv t0, t1;
> +
> +    t0 = tcg_temp_new();
> +    /* AND rt with a mask that is 0 when rB >= 0x20 */
> +#if defined(TARGET_PPC64)
> +    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x3a);
> +    tcg_gen_sari_tl(t0, t0, 0x3f);
> +#else
> +    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x1a);
> +    tcg_gen_sari_tl(t0, t0, 0x1f);
> +#endif
> +    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
> +    t1 = tcg_temp_new();
> +    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x1f);
> +    tcg_gen_shl_tl(cpu_gpr[a->ra], t0, t1);
> +    tcg_gen_ext32u_tl(cpu_gpr[a->ra], cpu_gpr[a->ra]);
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
> +    }
> +    return true;
> +}
> +
> +static bool trans_SRW(DisasContext *ctx, arg_SRW *a)
> +{
> +    TCGv t0, t1;
> +
> +    t0 = tcg_temp_new();
> +    /* AND rt with a mask that is 0 when rB >= 0x20 */
> +#if defined(TARGET_PPC64)
> +    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x3a);
> +    tcg_gen_sari_tl(t0, t0, 0x3f);
> +#else
> +    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x1a);
> +    tcg_gen_sari_tl(t0, t0, 0x1f);
> +#endif
> +    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
> +    tcg_gen_ext32u_tl(t0, t0);
> +    t1 = tcg_temp_new();
> +    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x1f);
> +    tcg_gen_shr_tl(cpu_gpr[a->ra], t0, t1);
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
> +    }
> +    return true;
> +}


