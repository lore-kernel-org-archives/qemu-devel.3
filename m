Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97A7C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWWO-0003Ug-N9; Mon, 24 Aug 2026 11:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWWM-0003Ty-Jf; Mon, 24 Aug 2026 11:23:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWWK-0006jC-43; Mon, 24 Aug 2026 11:23:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1dlG1936003; Mon, 24 Aug 2026 15:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Cbiv2vSgn9nSKF8/fDBQSyWJkolEDNBda5z+5gmAPrc=; b=Cv6QkpEfa04Y
 3Ypm4qCTGaqqFsp+AxvYdyE2reaAw44fLQVbO24ldzXPpMrVmT1+rB4ycj8wOGaR
 IKZwVMVIUshjsYHVmWgJxqgLBLH2ucwuueHX+WKHTfLNObGZLP7dw0WGywPsg0nq
 M94c/KCZAtYnU/qu0Wf2i6wJnq+ICzMn4Z/AbbFXB86ogbJSc/b4aAIarg3Eiznn
 SQm8sbMiDAQhO5g0q3Pslzs9+qOXCP6Za32YjYDkk8ZsWfU18/TH9SwE9BDJSOW+
 0Rqr5PC4RDlk9Htvo8Wg4Z82Lsbgd9mljPHm9selevOnhv4iMi5RbtkGr5GAnDbq
 M0Pbu/FFIQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393tabu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:23:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFBLQS025590;
 Mon, 24 Aug 2026 15:23:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgxq0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:23:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OFNPja31326818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 15:23:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A776B58065;
 Mon, 24 Aug 2026 15:23:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B31458055;
 Mon, 24 Aug 2026 15:23:24 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 15:23:24 +0000 (GMT)
Message-ID: <11a50f7e875cce8bab06410837d7c37c86008d1e.camel@linux.ibm.com>
Subject: Re: [PATCH 25/29] target/ppc: Move rlwimi, rlwinm instructions to
 decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 10:23:23 -0500
In-Reply-To: <20260820140114.327023-26-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-26-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: WBwwkCcTg1_ZIFNeiF7XrTJFkK-GBOUA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX5Zbn7xrBR+UY
 isU1Dk4QO9LaHVXhj1JBiKpJJr931cgmsngU6mkcN4SOm2NCCIu6wVyIXDQ0Aze2urElb/Qj+Cq
 uP8Z1LNRKP+ngv+6SEOgU7ZPuPBDn0dzynTrN/TvpINdv2IorBASFdJB59zgT9AtAWSzcWb1N8f
 fPsni8pgZce5xKi0B90oJPL/SONXuZ5QTt92sZI8ZgeiJvLzxAa98SvTRrcCG84yP3dcXPvB+nu
 B/hucfZJxHz+V3hbR2muMOdvZWoRQeheV3GYaH7KigQwNYFskC/A+FRL8gBobDj7pK++P8l7zyC
 sAeZ+7kmSWOIR1NU/ISKMfjG/0MipwTAueHvlrITVVBuZtyl73ti7KUslXkDPVcawS7RPP5X+vq
 YPm6HT9jEztHWwFgwnsRe4/+5JyljXCGqV+CzFW57FNIjMfEyTN3nQjnt/bgr1HqasFfW/A/G08
 9fDTEMbi/YSsGJEhtow==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c61f1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=q2vIqlbgvv1_T1apIFsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXxK5FGFsJ4RQS
 F9kyc0BPTG73EOK8C9krimQc4wGDoSM3KUa35joL4Qd0FDWEq+2Y36um5QFLQDirdzxyOrkJyms
 NSnp9qrSydRn439XpJedgyXTVraCYTc=
X-Proofpoint-ORIG-GUID: iufIrB7yBJ2jA-afAGM04Kkux-tJFDX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126
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
> From: Tanushree Shah <tshah@linux.ibm.com>
> 
> -Moving the following instructions to decodetree specification:
>             rlwimi                           : M-form
>             rlwimi.                          : M-form
>             rlwinm                           : M-form
>             rlwinm.                          : M-form
>  The changes were verified by validating that the tcg ops generated by
>  those instructions remain the same, which were captured with the
>  "-d in_asm,op" flag.
> 
>  Additionally, validated using small assembly tests confirming the
>  destination register is correctly updated based on rotated and masked
>  source values and confirmed that the value was same before and after
>  the change
> 
> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                   |   6 ++
>  target/ppc/translate.c                     | 106 ---------------------
>  target/ppc/translate/fixedpoint-impl.c.inc |  98 +++++++++++++++++++
>  3 files changed, 104 insertions(+), 106 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index eed963bd71..8f027e7ff5 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -312,6 +312,9 @@
>  
>  @Z23_te_tbp     ...... ....0 te:5 ....0 rmc:2 ........ rc:1     &Z23_te_tb frt=%z23_frtp frb=%z23_frbp
>  
> +&M              ra rs sh mb me rc:bool
> +@M              ...... rs:5 ra:5 sh:5 mb:5 me:5 rc:1 &M
> +
>  ### Fixed-Point Load Instructions
>  
>  LBZ             100010 ..... ..... ................     @D
> @@ -561,6 +564,9 @@ SRADI           011111 ..... ..... ..... 110011101 . .  @XS
>  
>  EXTSWSLI        011111 ..... ..... ..... 110111101 . .  @XS
>  
> +RLWIMI          010100 ..... ..... ..... ..... ......   @M
> +RLWINM          010101 ..... ..... ..... ..... ......   @M
> +
>  ## BCD Assist
>  
>  ADDG6S          011111 ..... ..... ..... - 001001010 -  @X
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 712990cf2d..d2c51b4d59 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2012,110 +2012,6 @@ static void gen_pause(DisasContext *ctx)
>  
>  /***                             Integer rotate                            ***/
>  
> -/* rlwimi & rlwimi. */
> -static void gen_rlwimi(DisasContext *ctx)
> -{
> -    TCGv t_ra = cpu_gpr[rA(ctx->opcode)];
> -    TCGv t_rs = cpu_gpr[rS(ctx->opcode)];
> -    uint32_t sh = SH(ctx->opcode);
> -    uint32_t mb = MB(ctx->opcode);
> -    uint32_t me = ME(ctx->opcode);
> -
> -    if (sh == (31 - me) && mb <= me) {
> -        tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
> -    } else {
> -        target_ulong mask;
> -        bool mask_in_32b = true;
> -        TCGv t1;
> -
> -#if defined(TARGET_PPC64)
> -        mb += 32;
> -        me += 32;
> -#endif
> -        mask = MASK(mb, me);
> -
> -#if defined(TARGET_PPC64)
> -        if (mask > 0xffffffffu) {
> -            mask_in_32b = false;
> -        }
> -#endif
> -        t1 = tcg_temp_new();
> -        if (mask_in_32b) {
> -            TCGv_i32 t0 = tcg_temp_new_i32();
> -            tcg_gen_trunc_tl_i32(t0, t_rs);
> -            tcg_gen_rotli_i32(t0, t0, sh);
> -            tcg_gen_extu_i32_tl(t1, t0);
> -        } else {
> -#if defined(TARGET_PPC64)
> -            tcg_gen_deposit_i64(t1, t_rs, t_rs, 32, 32);
> -            tcg_gen_rotli_i64(t1, t1, sh);
> -#else
> -            g_assert_not_reached();
> -#endif
> -        }
> -
> -        tcg_gen_andi_tl(t1, t1, mask);
> -        tcg_gen_andi_tl(t_ra, t_ra, ~mask);
> -        tcg_gen_or_tl(t_ra, t_ra, t1);
> -    }
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, t_ra);
> -    }
> -}
> -
> -/* rlwinm & rlwinm. */
> -static void gen_rlwinm(DisasContext *ctx)
> -{
> -    TCGv t_ra = cpu_gpr[rA(ctx->opcode)];
> -    TCGv t_rs = cpu_gpr[rS(ctx->opcode)];
> -    int sh = SH(ctx->opcode);
> -    int mb = MB(ctx->opcode);
> -    int me = ME(ctx->opcode);
> -    int len = me - mb + 1;
> -    int rsh = (32 - sh) & 31;
> -
> -    if (sh != 0 && len > 0 && me == (31 - sh)) {
> -        tcg_gen_deposit_z_tl(t_ra, t_rs, sh, len);
> -    } else if (me == 31 && rsh + len <= 32) {
> -        tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
> -    } else {
> -        target_ulong mask;
> -        bool mask_in_32b = true;
> -#if defined(TARGET_PPC64)
> -        mb += 32;
> -        me += 32;
> -#endif
> -        mask = MASK(mb, me);
> -#if defined(TARGET_PPC64)
> -        if (mask > 0xffffffffu) {
> -            mask_in_32b = false;
> -        }
> -#endif
> -        if (mask_in_32b) {
> -            if (sh == 0) {
> -                tcg_gen_andi_tl(t_ra, t_rs, mask);
> -            } else {
> -                TCGv_i32 t0 = tcg_temp_new_i32();
> -                tcg_gen_trunc_tl_i32(t0, t_rs);
> -                tcg_gen_rotli_i32(t0, t0, sh);
> -                tcg_gen_andi_i32(t0, t0, mask);
> -                tcg_gen_extu_i32_tl(t_ra, t0);
> -            }
> -        } else {
> -#if defined(TARGET_PPC64)
> -            tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
> -            tcg_gen_rotli_i64(t_ra, t_ra, sh);
> -            tcg_gen_andi_i64(t_ra, t_ra, mask);
> -#else
> -            g_assert_not_reached();
> -#endif
> -        }
> -    }
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, t_ra);
> -    }
> -}
> -
>  /* rlwnm & rlwnm. */
>  static void gen_rlwnm(DisasContext *ctx)
>  {
> @@ -4807,8 +4703,6 @@ GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
>  GEN_HANDLER_E(copy, 0x1F, 0x06, 0x18, 0x03C00001, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  /* handles lfdp, lxsd, lxssp */
>  GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 82fb645279..8fcee7a89d 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -1874,6 +1874,104 @@ static bool trans_SRAWI(DisasContext *ctx, arg_SRAWI *a)
>      return true;
>  }
>  
> +static bool trans_RLWIMI(DisasContext *ctx, arg_RLWIMI *a)
> +{
> +    TCGv t_ra = cpu_gpr[a->ra];
> +    TCGv t_rs = cpu_gpr[a->rs];
> +
> +    if (a->sh == (31 - a->me) && a->mb <= a->me) {
> +        tcg_gen_deposit_tl(t_ra, t_ra, t_rs, a->sh, a->me - a->mb + 1);
> +    } else {
> +        target_ulong mask;
> +        bool mask_in_32b = true;
> +        TCGv t1;
> +
> +#if defined(TARGET_PPC64)
> +        a->mb += 32;
> +        a->me += 32;
> +#endif
> +        mask = MASK((uint32_t)a->mb, (uint32_t)a->me);
> +
> +#if defined(TARGET_PPC64)
> +        if (mask > 0xffffffffu) {
> +            mask_in_32b = false;
> +        }
> +#endif
> +        t1 = tcg_temp_new();
> +        if (mask_in_32b) {
> +            TCGv_i32 t0 = tcg_temp_new_i32();
> +            tcg_gen_trunc_tl_i32(t0, t_rs);
> +            tcg_gen_rotli_i32(t0, t0, a->sh);
> +            tcg_gen_extu_i32_tl(t1, t0);
> +        } else {
> +#if defined(TARGET_PPC64)
> +            tcg_gen_deposit_i64(t1, t_rs, t_rs, 32, 32);
> +            tcg_gen_rotli_i64(t1, t1, a->sh);
> +#else
> +            g_assert_not_reached();
> +#endif
> +        }
> +
> +        tcg_gen_andi_tl(t1, t1, mask);
> +        tcg_gen_andi_tl(t_ra, t_ra, ~mask);
> +        tcg_gen_or_tl(t_ra, t_ra, t1);
> +    }
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, t_ra);
> +    }
> +    return true;
> +}
> +
> +static bool trans_RLWINM(DisasContext *ctx, arg_RLWINM *a)
> +{
> +    TCGv t_ra = cpu_gpr[a->ra];
> +    TCGv t_rs = cpu_gpr[a->rs];
> +    int len = a->me - a->mb + 1;
> +    int rsh = (32 - a->sh) & 31;
> +
> +    if (a->sh != 0 && len > 0 && a->me == (31 - a->sh)) {
> +        tcg_gen_deposit_z_tl(t_ra, t_rs, a->sh, len);
> +    } else if (a->me == 31 && rsh + len <= 32) {
> +        tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
> +    } else {
> +        target_ulong mask;
> +        bool mask_in_32b = true;
> +#if defined(TARGET_PPC64)
> +        a->mb += 32;
> +        a->me += 32;
> +#endif
> +        mask = MASK(a->mb, a->me);
> +#if defined(TARGET_PPC64)
> +        if (mask > 0xffffffffu) {
> +            mask_in_32b = false;
> +        }
> +#endif
> +        if (mask_in_32b) {
> +            if (a->sh == 0) {
> +                tcg_gen_andi_tl(t_ra, t_rs, mask);
> +            } else {
> +                TCGv_i32 t0 = tcg_temp_new_i32();
> +                tcg_gen_trunc_tl_i32(t0, t_rs);
> +                tcg_gen_rotli_i32(t0, t0, a->sh);
> +                tcg_gen_andi_i32(t0, t0, mask);
> +                tcg_gen_extu_i32_tl(t_ra, t0);
> +            }
> +        } else {
> +#if defined(TARGET_PPC64)
> +            tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
> +            tcg_gen_rotli_i64(t_ra, t_ra, a->sh);
> +            tcg_gen_andi_i64(t_ra, t_ra, mask);
> +#else
> +            g_assert_not_reached();
> +#endif
> +        }
> +    }
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, t_ra);
> +    }
> +    return true;
> +}
> +
>  static void do_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
>                                       TCGv EA, int rt,
>                                       TCGCond cond, int addend)


