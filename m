Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BA5C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcE3-0005gO-NJ; Thu, 27 Aug 2026 11:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzcE2-0005fr-RM; Thu, 27 Aug 2026 11:41:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzcDz-0000Wu-6A; Thu, 27 Aug 2026 11:41:10 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RF5Xjb3410087; Thu, 27 Aug 2026 15:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=oY4ihoGRCxdXgIZzxAFqmHaIKwm/pC
 3LuhbYMX7pe4A=; b=E99KkmzWFTy2+oGqAHJuiBChQT73u5HWZhiLqN2oNwwCUc
 8mBG9p7SyzY5JRLUlxvWrznVYco2G9qDWZvwQFJJ6F0kEfrOoPGwJRhrYBfGuEZD
 r6kIreGN/FEB3XnN0wx7T4LOciyrXsiFmu1p26BZz2Gmptrk+gNx9nSSsVd+swYU
 a/bpYkjvgvnhpq+Agl+FkU/aO+EYlNqhX9MEa48mBRWGC+lvYWMPlUjkyiLFEUDC
 3uhK4Zhxmj3rfQ2RyOXZ/mXoZEVmQP4MWWM+JuHgcv02HyYlHTF9y+81OwWqwG45
 S5j2uF+TCTi3/KtFrsbYiMDq3tWkOZGjVY3rvTEw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxny5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 15:41:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFBgs4013467;
 Thu, 27 Aug 2026 15:41:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhgsct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 15:41:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RFev9d43122994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 15:40:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EB3920049;
 Thu, 27 Aug 2026 15:40:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 284042004B;
 Thu, 27 Aug 2026 15:40:54 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 27 Aug 2026 15:40:53 +0000 (GMT)
Date: Thu, 27 Aug 2026 21:10:22 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v3 28/37] target/ppc: Move byte-reverse instructions to
 decodetree
Message-ID: <20260827210923.2fdf9504-a2-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260827133010.278889-1-rathc@linux.ibm.com>
 <20260827133010.278889-29-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827133010.278889-29-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXx8eU9QSWnCyf
 RJ7+Kjgi9eO04vSYEiN36zGBQjD7FCsuaKtfZNNVwiPTyNQoVx3MLNiHfjecbgPJjJjUYrw86dy
 1oi5/6OqqHSHciiVVG7ULhUIlNr7PiU=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a905a90 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=mDV3o1hIAAAA:8
 a=VnNF1IyMAAAA:8 a=uWzhBOzaoYH7udKmc4wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6-fDMm-QnfRS7-GQtxAE8oqkPufytULH
X-Proofpoint-GUID: 3mBiQjM8lSjz7jWUG7a5qcnti2IhQWMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXxNfQNghMkhYO
 pIwDFXJWuYexA0qdS7ZZ7QICV0rF2Y9pIauogUCYySbKCCEfL1GPzLEO72A16HPp0lbC4dIGUXz
 ONXP7oVW65Ep7tKYLz33Yq8/bpm1Vif6999dGqAaMvZKfOXkqtYiQK1z4DAUukbMdLhTSmuOzwn
 vK8OrlwR0rI8QvUeiHL8WOeNkZOZTlUMosAB6twjDY1foMcbibpy0ofIxOzKeDxl/o/O5gb9jxt
 uAk3pSUiFUETJSOIxojJ+mXd3pzsRc1y4W46H/Y6m9HD6x/X79V9sGZTvsQiTcJ4Wq7ZE6KJ/Gs
 2J51/wg8QFuNcZPRsMxJMD8Bslvjz/AKNzECOu7S6Io3lITxJMbyPf7SUXEmtTxH0e9hHo4qBQc
 oLtZKzVSNpvDvLe9EGrdM+EygUNXkZT88X/+WurrU/KHg1Y7wt4oG0S/EspqN72U4eLQLt4ytIq
 HE5IXEGM7cJZh6URsFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270131
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

On 2026/08/27 06:59 PM, Chinmay Rath wrote:
> From: Vishal Chourasia <vishalc@linux.ibm.com>
> 
> Moving the following instructions to decodetree specification:
>             brd, brw, brh                   : X-form
> 
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the
> `-d in_asm,op` flag.
> 
> This also includes improvements from review feedback:
> - Add TARGET_PPC64 guards with qemu_build_not_reached() for 32-bit builds
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                   |  5 +++
>  target/ppc/translate.c                     | 35 ----------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 48 ++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 35 deletions(-)

Thanks for incorporating the review comments.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 1e263449a5..7bbe1f8838 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -320,6 +320,11 @@ MFMSR           011111 ..... ----- ----- 0001010011 -   @X_t
>  MTMSR           011111 ..... ---- . ----- 0010010010 -  @X_rs_l
>  MTMSRD          011111 ..... ---- . ----- 0010110010 -  @X_rs_l
>  
> +### Fixed-Point Byte-Reverse Instructions
> +BRW             011111 ..... ..... ----- 0010011011 -   @X_sa
> +BRD             011111 ..... ..... ----- 0010111011 -   @X_sa
> +BRH             011111 ..... ..... ----- 0011011011 -   @X_sa
> +
>  ### Fixed-Point Load Instructions
>  
>  LBZ             100010 ..... ..... ................     @D
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 1d069c5250..20d3e7c1ab 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4519,42 +4519,7 @@ static void gen_dform3D(DisasContext *ctx)
>      return gen_invalid(ctx);
>  }
>  
> -#if defined(TARGET_PPC64)
> -/* brd */
> -static void gen_brd(DisasContext *ctx)
> -{
> -    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
> -}
> -
> -/* brw */
> -static void gen_brw(DisasContext *ctx)
> -{
> -    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
> -    tcg_gen_rotli_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], 32);
> -
> -}
> -
> -/* brh */
> -static void gen_brh(DisasContext *ctx)
> -{
> -    TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
> -    TCGv_i64 t1 = tcg_temp_new_i64();
> -    TCGv_i64 t2 = tcg_temp_new_i64();
> -
> -    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
> -    tcg_gen_and_i64(t2, t1, mask);
> -    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], mask);
> -    tcg_gen_shli_i64(t1, t1, 8);
> -    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
> -}
> -#endif
> -
>  static opcode_t opcodes[] = {
> -#if defined(TARGET_PPC64)
> -GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
> -GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
> -GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
> -#endif
>  GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
>  GEN_HANDLER_E(copy, 0x1F, 0x06, 0x18, 0x03C00001, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 8475205f14..0e1960a272 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -17,6 +17,54 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +/*
> + * Byte-Reverse Instructions
> + */
> +static bool trans_BRD(DisasContext *ctx, arg_BRD *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA310);
> +#if defined(TARGET_PPC64)
> +    tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_BRW(DisasContext *ctx, arg_BRW *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA310);
> +#if defined(TARGET_PPC64)
> +    tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
> +    tcg_gen_rotli_i64(cpu_gpr[a->ra], cpu_gpr[a->ra], 32);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_BRH(DisasContext *ctx, arg_BRH *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA310);
> +#if defined(TARGET_PPC64)
> +    TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +
> +    tcg_gen_shri_i64(t1, cpu_gpr[a->rs], 8);
> +    tcg_gen_and_i64(t2, t1, mask);
> +    tcg_gen_and_i64(t1, cpu_gpr[a->rs], mask);
> +    tcg_gen_shli_i64(t1, t1, 8);
> +    tcg_gen_or_i64(cpu_gpr[a->ra], t1, t2);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
>  /*
>   * Fixed-Point Load/Store Instructions
>   */
> -- 
> 2.55.0
> 

