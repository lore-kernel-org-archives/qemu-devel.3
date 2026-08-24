Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFA4C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWQE-0000lJ-5V; Mon, 24 Aug 2026 11:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWQA-0000l5-2j; Mon, 24 Aug 2026 11:17:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWQ7-000472-Ut; Mon, 24 Aug 2026 11:17:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1dAk085543; Mon, 24 Aug 2026 15:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=o3XfDvNG46HHvkCjxPILPP5D+GbPzxUrnUPXm3BkrIc=; b=AqKgR1M6X9Kf
 ptn5y/6CH3wV8z6DNoSRqn826Af7Kk6m6csHS13GUXNFtnN5U/EMh++HN5E9xzws
 10C3Ze2mws+RM921fLU9Qwb8dY3BhQhPLWbvbs18/YWQXqpiyH+72uSWrK5v7Aix
 CK4MjKzesfoNKMEF4ING8oof9u+5fePtmZE11wAh1Hz+311DAtNOdStHfvo46AHa
 FggmSuMVwZvtmMPUWkZinMWXS9jIBvWKn3UNrLFXamSHqItNL2hfd8J/xZ+YSeio
 JaTp9Ad02YXBNpSdhhSBuP/evhFHun0AvLf3z8+A3c9zM7APNxnizQ3dhT2gS48R
 VTEIPs/rxA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqj7b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:17:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFBL7n029288;
 Mon, 24 Aug 2026 15:17:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxvh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:17:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OFH1Fw35258648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 15:17:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CD2058060;
 Mon, 24 Aug 2026 15:17:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF6DF58054;
 Mon, 24 Aug 2026 15:16:59 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 15:16:59 +0000 (GMT)
Message-ID: <68606f7537636ca2d6149561355619bd59ea1ac2.camel@linux.ibm.com>
Subject: Re: [PATCH 20/29] target/ppc: Move Condition Register access
 instructions to decodetree.
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 10:16:59 -0500
In-Reply-To: <20260820140114.327023-21-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-21-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Z78zOF5e38kHir3n-8xOrV-elX_jqrb-
X-Proofpoint-ORIG-GUID: BXrru9WzXApF6G7HSO2zSZMQF-pGdbEq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX2d9wM6Nk0+NK
 kCD1JjL+fBa8r2xSq2pv8JUoKR+kRm78+jVMIk6zVhU4uMO0AFmKGheTeZha8BcWx9UkjDF7TbR
 CnJxRPaf4R0na526Vg74JMxcGq4JL+wCIXRRQ7JLGFCY5NSA1IA7VyCmWtloW4jCo1hXj4g5fWX
 cXKvpUHfoPexduAoKM2/JAd9J94zN7OmiRiO/JoHgsxFKMvCpyAPwKTfpVfgu0cSITWQib6n5k1
 RYHZ72xftLetwhw7WWgRjIlrLN/zbBQS8mLybO286cxlDodSJZ8TvhonuqF+qKY9J6crmslTRYA
 SXrOWkNwSLcdLZRf8+VUlz2YICkr9SuZTtA22EtTwCgvqWDEbFgvJ/MiUyVQkybj2/I68tIH5Ab
 hQofEcPsE9CDiS6/+Ja03V1OClUOUFxq0kpke7AzZm4pqOSXQpWeKT78i5/qf6JyuFae+qz2lDm
 TszI3ftwmRkchLBEPRw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c6070 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_AhxRZSWwkdppd6cuIwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX7CYrTzGkORJA
 scSNjXInk9bbyzo9zDRID0y+rJ87+/HAWmaPF3HCWoVQJBXkadmdSTl5lpY9vh31/3Hg+haxumz
 yUA3vqFv/qgpQ4CwXy6IvHSWQQt7HIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
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
> From: Shivang Upadhyay <shivangu@linux.ibm.com>
> 
> Move below instructions to decodetree specification :
> 
>         mfcr, mfocr,
>         mtcrf, mtocrf                    : XFX-form
> 
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                   |  8 +++
>  target/ppc/translate.c                     | 62 -----------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 79 ++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 62 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index d23168a303..dc708b5442 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -70,6 +70,9 @@
>  %dx_d           6:s10 16:5 0:1
>  @DX             ...... rt:5  ..... .......... ..... .           &DX d=%dx_d
>  
> +&XFX            rt fxm
> +@XFX            ...... rt:5  . fxm:8 ...... ..... .             &XFX
> +
>  %md_sh          1:1 11:5
>  %md_mb          5:1 6:5
>  &MD             rs ra sh mb rc
> @@ -648,6 +651,11 @@ FSEL            111111 ..... ..... ..... ..... 10111 .  @A
>  
>  ### Move To/From System Register Instructions
>  
> +MFCR            011111 ..... 0.... ....- 0000010011 -   @XFX
> +MFOCR           011111 ..... 1.... ....- 0000010011 -   @XFX
> +MTCRF           011111 ..... 0.... ....- 0010010000 -   @XFX
> +MTOCRF          011111 ..... 1.... ....- 0010010000 -   @XFX
> +
>  SETBC           011111 ..... ..... ----- 0110000000 -   @X_bi
>  SETBCR          011111 ..... ..... ----- 0110100000 -   @X_bi
>  SETNBC          011111 ..... ..... ----- 0111000000 -   @X_bi
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f6f7bb4e6b..d01981de73 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3131,40 +3131,6 @@ static void gen_mcrxrx(DisasContext *ctx)
>  }
>  #endif
>  
> -/* mfcr mfocrf */
> -static void gen_mfcr(DisasContext *ctx)
> -{
> -    uint32_t crm, crn;
> -
> -    if (likely(ctx->opcode & 0x00100000)) {
> -        crm = CRM(ctx->opcode);
> -        if (likely(crm && ((crm & (crm - 1)) == 0))) {
> -            crn = ctz32(crm);
> -            tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], cpu_crf[7 - crn]);
> -            tcg_gen_shli_tl(cpu_gpr[rD(ctx->opcode)],
> -                            cpu_gpr[rD(ctx->opcode)], crn * 4);
> -        }
> -    } else {
> -        TCGv_i32 t0 = tcg_temp_new_i32();
> -        tcg_gen_mov_i32(t0, cpu_crf[0]);
> -        tcg_gen_shli_i32(t0, t0, 4);
> -        tcg_gen_or_i32(t0, t0, cpu_crf[1]);
> -        tcg_gen_shli_i32(t0, t0, 4);
> -        tcg_gen_or_i32(t0, t0, cpu_crf[2]);
> -        tcg_gen_shli_i32(t0, t0, 4);
> -        tcg_gen_or_i32(t0, t0, cpu_crf[3]);
> -        tcg_gen_shli_i32(t0, t0, 4);
> -        tcg_gen_or_i32(t0, t0, cpu_crf[4]);
> -        tcg_gen_shli_i32(t0, t0, 4);
> -        tcg_gen_or_i32(t0, t0, cpu_crf[5]);
> -        tcg_gen_shli_i32(t0, t0, 4);
> -        tcg_gen_or_i32(t0, t0, cpu_crf[6]);
> -        tcg_gen_shli_i32(t0, t0, 4);
> -        tcg_gen_or_i32(t0, t0, cpu_crf[7]);
> -        tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t0);
> -    }
> -}
> -
>  /* mfmsr */
>  static void gen_mfmsr(DisasContext *ctx)
>  {
> @@ -3245,32 +3211,6 @@ static void gen_mftb(DisasContext *ctx)
>      gen_op_mfspr(ctx);
>  }
>  
> -/* mtcrf mtocrf*/
> -static void gen_mtcrf(DisasContext *ctx)
> -{
> -    uint32_t crm, crn;
> -
> -    crm = CRM(ctx->opcode);
> -    if (likely((ctx->opcode & 0x00100000))) {
> -        if (crm && ((crm & (crm - 1)) == 0)) {
> -            TCGv_i32 temp = tcg_temp_new_i32();
> -            crn = ctz32(crm);
> -            tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
> -            tcg_gen_shri_i32(temp, temp, crn * 4);
> -            tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
> -        }
> -    } else {
> -        TCGv_i32 temp = tcg_temp_new_i32();
> -        tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
> -        for (crn = 0 ; crn < 8 ; crn++) {
> -            if (crm & (1 << crn)) {
> -                    tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
> -                    tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
> -            }
> -        }
> -    }
> -}
> -
>  /* mtmsr */
>  #if defined(TARGET_PPC64)
>  static void gen_mtmsrd(DisasContext *ctx)
> @@ -5043,11 +4983,9 @@ GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
>  GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
>  GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
>  GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
> -GEN_HANDLER(mfcr, 0x1F, 0x13, 0x00, 0x00000801, PPC_MISC),
>  GEN_HANDLER(mfmsr, 0x1F, 0x13, 0x02, 0x001FF801, PPC_MISC),
>  GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
>  GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
> -GEN_HANDLER(mtcrf, 0x1F, 0x10, 0x04, 0x00000801, PPC_MISC),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(mtmsrd, 0x1F, 0x12, 0x05, 0x001EF801, PPC_64B),
>  GEN_HANDLER_E(setb, 0x1F, 0x00, 0x04, 0x0003F801, PPC_NONE, PPC2_ISA300),
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 4d35133adc..d768a0454d 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -461,6 +461,85 @@ static bool trans_ADDEX(DisasContext *ctx, arg_X *a)
>      return true;
>  }
>  
> +static bool trans_MTCRF(DisasContext *ctx, arg_MTCRF *a)
> +{
> +    uint32_t crm, crn;
> +
> +    crm = a->fxm;
> +
> +    TCGv_i32 temp = tcg_temp_new_i32();
> +    tcg_gen_trunc_tl_i32(temp, cpu_gpr[a->rt]);
> +
> +    for (crn = 0 ; crn < 8 ; crn++) {
> +        if (crm & (1 << crn)) {
> +                tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
> +                tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static bool trans_MTOCRF(DisasContext *ctx, arg_MTOCRF *a)
> +{
> +
> +    uint32_t crm, crn;
> +
> +    crm = a->fxm;
> +
> +    /* Checking crm > 0 and set_bits(crm) == 1 */
> +    if (crm && ((crm & (crm - 1)) == 0)) {
> +        TCGv_i32 temp = tcg_temp_new_i32();
> +        crn = ctz32(crm);
> +        tcg_gen_trunc_tl_i32(temp, cpu_gpr[a->rt]);
> +        tcg_gen_shri_i32(temp, temp, crn * 4);
> +        tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
> +    }
> +
> +    return true;
> +}
> +
> +static bool trans_MFOCR(DisasContext *ctx, arg_MFOCR *a)
> +{
> +    uint32_t crm, crn;
> +
> +    crm = a->fxm;
> +
> +    /* Checking crm > 0 and set_bits(crm) == 1 */
> +    if (likely(crm && ((crm & (crm - 1)) == 0))) {
> +        crn = ctz32(crm);
> +        tcg_gen_extu_i32_tl(cpu_gpr[a->rt], cpu_crf[7 - crn]);
> +        tcg_gen_shli_tl(cpu_gpr[a->rt],
> +                        cpu_gpr[a->rt], crn * 4);
> +    }
> +
> +    return true;
> +}
> +
> +static bool trans_MFCR(DisasContext *ctx, arg_MFCR *a)
> +{
> +
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    tcg_gen_mov_i32(t0, cpu_crf[0]);
> +    tcg_gen_shli_i32(t0, t0, 4);
> +    tcg_gen_or_i32(t0, t0, cpu_crf[1]);
> +    tcg_gen_shli_i32(t0, t0, 4);
> +    tcg_gen_or_i32(t0, t0, cpu_crf[2]);
> +    tcg_gen_shli_i32(t0, t0, 4);
> +    tcg_gen_or_i32(t0, t0, cpu_crf[3]);
> +    tcg_gen_shli_i32(t0, t0, 4);
> +    tcg_gen_or_i32(t0, t0, cpu_crf[4]);
> +    tcg_gen_shli_i32(t0, t0, 4);
> +    tcg_gen_or_i32(t0, t0, cpu_crf[5]);
> +    tcg_gen_shli_i32(t0, t0, 4);
> +    tcg_gen_or_i32(t0, t0, cpu_crf[6]);
> +    tcg_gen_shli_i32(t0, t0, 4);
> +    tcg_gen_or_i32(t0, t0, cpu_crf[7]);
> +    tcg_gen_extu_i32_tl(cpu_gpr[a->rt], t0);
> +
> +    return true;
> +}
> +
>  static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
>                       bool compute_ov, bool compute_rc0)
>  {


