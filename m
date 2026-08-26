Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF50C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBnk-0005oJ-SG; Wed, 26 Aug 2026 07:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzBnj-0005o4-Tr; Wed, 26 Aug 2026 07:28:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzBng-0000vO-Sr; Wed, 26 Aug 2026 07:28:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAVUfR3739166; Wed, 26 Aug 2026 11:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=YEfxJDW8syEq+klYoDdYPURyInjTrz
 2w7flSpMeCjws=; b=LmL8YqscpePmjuEAEUUqFFmjrmrIQqSr3+2WM2GlsPgWfS
 2wA8a1I9s2AEcpPbhD9rXFt9/6330urwwrhscQdlT5OdhSPhvZn4XCbWRLFk+rXX
 5HNx7fEcB5CtLo5vArfeEPgKhUEA3C3cSST9U9idGGvzfmsLhYQcJgCSb32MQlkU
 fH8eS4UXKacojJAgz7oIgD+aEO9QAgf2MbVBVsqkyz8f4jyRlqd9mz/H2kWGFuwB
 2Lw5IyAuXNleHxymBka1+9Vef63HFX35xpLd7MnCiHcolbKhfBGuo9bGuQS2/3kh
 pbOX2Z3F48mJhxIZqxs8UtIk/hShOWJEViaPZmOQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xa09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 11:28:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QBQJ7I005433;
 Wed, 26 Aug 2026 11:28:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh9jsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 11:28:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QBS4XA46268830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 11:28:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3934A20043;
 Wed, 26 Aug 2026 11:28:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18C2B20040;
 Wed, 26 Aug 2026 11:28:01 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 11:28:00 +0000 (GMT)
Date: Wed, 26 Aug 2026 16:58:03 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 07/37] target/ppc: convert slw, srw instruction via
 decode spec
Message-ID: <20260826165102.b217b451-99-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-8-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-8-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LsRmxPkoR8VYrlrHPJBvsCE_9ULD47uo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfX6BdFObiAVR/K
 almqBQLfYBFWh7ajEyclkJ5EoFLdnGS3cljXiQA7iiziZJlUZwgYSTWlNvKZA1Ye8R9AHD/9YGr
 7keVcffpl1TVQdQkCt1vUv0UI8ajo4g=
X-Proofpoint-GUID: AcvPplX72ZKfX2uDP9SGyI5gG1h38Y2Q
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ecdc9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=pjPVRt5YC1-jTNigy1AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfXx2iRg+tSDDUh
 UeX8e+7Y/KwGtzgxuNwsFw2/M8z4DO0d0vAlNR1w1MQP3WgdU3V1M7C5WNiAqt5R08D5RFQn9IS
 aC/L9bNhhegf+3/kI+3aOXcl3afOUMndOVIVedIjkMZEG9RuZE2r8j7xf7MAIacHmT3GV8kqEKF
 9lgZGGjHmltAS5kGgHsYdL2nXamvt4PrXDfkMdEgsS0img5SPMf/3ipWlLmLf0TX2+ih+/vhnbG
 lGn0/97afnN3Zjp1qEH75meJaXh3AjLHXLuYJTg/ZQk1xc/NZtZXF4PQ95/25KfU28y9kB0LgKp
 fYTtFBqdH2NAFUTjs7Ds7+W2lOoz1QtPIUiTkiLGV2gNDuKGZLbAJpZ91Grl98JYvnPeYNq1l/k
 aSAkP4/0SIjSjXJbqXZMqj1PrizweZHMxYw8uP+ICThgjko51GuzcC2xK5fIwbT2Oe1cTGBl66i
 drhAuYJT1W3VX25BzEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260092
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
> Instructions converted:
> 
> - slw
> - srw
> 
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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

Nit: this looks like an extra blank line - can be removed. Otherwise,

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

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
> -- 
> 2.55.0
> 

