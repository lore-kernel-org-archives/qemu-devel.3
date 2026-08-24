Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D98EC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVjO-0004ie-C1; Mon, 24 Aug 2026 10:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVjI-0004as-Oj; Mon, 24 Aug 2026 10:32:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVjG-0003eV-13; Mon, 24 Aug 2026 10:32:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1dXq2004276; Mon, 24 Aug 2026 14:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=yZ+isrNqX9kWFSPF/AWFGDJI/8UhGknODDQR7Fbj5/k=; b=LkMdrQeUsg0z
 4D9HvTzKJ7It9TQpmwgvs0m0Ei+8LvCMnkHcvioPPN12jNpCYc2ysvRUUyG/moAd
 NsksxOgRPUvc/QGrqGy1V0WsXAicai6hzXFjCPBIAGwQAmhrgbsSWLO43dMG7S8b
 qdvvl7/kve0qKgbLFdv6RRmqLU8LdZaC+ojRkmvVd/IBiGtjRpGY/7I2A9ZVAiej
 stePviI3P8/UkMVStQlqtco+dM83ZKTg7vCaUJKdf7fXJgeECl8KuEMIBZYP0AJi
 25SzvjRP2ywYY4dT1eu0znaGugBFZubx2t29ve23BjSno3kI+UGJl+ARK5bVNiFD
 V1778iWVww==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx1t7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:32:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQHQP009805;
 Mon, 24 Aug 2026 14:32:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxx95k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:32:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEWhVp51839480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:32:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BA3D58060;
 Mon, 24 Aug 2026 14:32:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E4F858056;
 Mon, 24 Aug 2026 14:32:42 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:32:42 +0000 (GMT)
Message-ID: <ba55bddc90af36c2747c6a0d63a6d46936172bcf.camel@linux.ibm.com>
Subject: Re: [PATCH 08/29] target/ppc: convert sraw[i] instruction via
 decode spec
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:32:42 -0500
In-Reply-To: <20260820140114.327023-9-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-9-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX0+0fbR9wKZ3w
 XD9MZiCbAJILcxHbXVGtBui96L2NRK4gFaRrWyfyQrrOa69fHpTTshEcQqawGKnq9+KgFWeOEKK
 LWti2lfGGix6PgSpdqoU4TS4k5fH4pY=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c560f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=MkwwkY082pzkzX8y5OsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4E_3pLVULoz-eJn-jBjQJ5TBIl2nywri
X-Proofpoint-GUID: fe3mWS8k38D9LsF7y2G-qilEanfuMh3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXy0Xxtites6C2
 rbfXLMLSo7QWj9bT4VWsWZ9rZLcC9mqNVyAjd53YFUS0+nKyOraq4CeZ8a/k4tf9KmB8VwtBOGa
 KL9E7Ygk5aLX0uCU1GwsZfHO4L6VMaZPpuARlpiVZ7/1qhJ5ZuTyqoZHWWgwmkr+9G1iFFG5rkv
 vC5WWABKSfJG/cAP65bQbMup1za3skZOV+kxCzvWkcosCSmWCasvRHd9ABWRYIRwN3wYstHcXhp
 YQEvKnD19QyyydustPDFYSjwJW+8+2D2RPsipQTT9hdPRekz2BrFroiukaL0QvKYZkwMPlqDfEa
 wfWEPYZbp/8td86HQ0kK4vDq6BSRAXJA5tIhxgectEtk5LdzDpgyxIN66L9JbMI+Ok6hTJG/Nic
 PUUaKkNYSk0jFRQewckmAL9PldiAkMBI5HplN/rCDOpH/br+bp0hJGQ5BWMErN/hsk7n0h01PSI
 FtgXROHgEzZFkR2IhrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
> 
> Instruction converted:
> 
> - sraw
> - srawi
> 
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
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


