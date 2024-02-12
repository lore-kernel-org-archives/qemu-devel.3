Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82350C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 06:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZPZD-0006Yo-Ax; Mon, 12 Feb 2024 01:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZPZB-0006YZ-Dg; Mon, 12 Feb 2024 01:13:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZPZ8-0004Dd-M7; Mon, 12 Feb 2024 01:13:21 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C5TWIu023664; Mon, 12 Feb 2024 06:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lTPVRJxkMHBeviQ6dC7oFlBhsNgCOJUQoTqaTajB7Ko=;
 b=miK+JXCLwAas8hGE5XYnkFbAn/MntZJpUAxr7YQUeSBDlrJnzaogbZ/6/AomxerwkwAU
 98R0LJ8T9uA/A49YmQczhmwWGs49dHFcRqigALdBrdyZIntM3f5GoZOMzK+p1o9ykBk/
 ufCaV9/sEcErNdCnnFLitYmDlKa54+m8u9Z9DA7fS9qv+YfHyqMli3asPyeu6nwO8cX5
 j4VhHVLnmTaP1vhI57Y6wLzJfqCW8mXPwMQEq1V40FO5ZvsYAkUnKG5Zfj14RP6eFT4y
 ZTEEFMzwKqcLbSuwBfvgh1nKhB4+DAXGiSg/XbWh7twnFdVAxO3HN8QyKtyGzYeIBKuD UA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w76jsp7aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 06:13:14 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41C5UWhl026544;
 Mon, 12 Feb 2024 06:13:13 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w76jsp7ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 06:13:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C4rbEw009680; Mon, 12 Feb 2024 06:13:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkegmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 06:13:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41C6DAfC21430572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 06:13:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EB0C58061;
 Mon, 12 Feb 2024 06:13:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7559058067;
 Mon, 12 Feb 2024 06:13:07 +0000 (GMT)
Received: from [9.179.18.54] (unknown [9.179.18.54])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 06:13:07 +0000 (GMT)
Message-ID: <d7136794-31b9-44ea-ae92-7dd85f9cfc22@linux.ibm.com>
Date: Mon, 12 Feb 2024 11:43:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Move add and subf type fixed-point
 arithmetic instructions to decodetree
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com
Cc: sbhat@linux.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240209113532.580983-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240209113532.580983-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ftZM_ciSGfe1oP-imV6eou6lE2985gIY
X-Proofpoint-GUID: dn_kxItlh84hprvNVlwopD5v41nJK93a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_04,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+ Daniel, Cedric, Richard - for review comments, if any.

On 2/9/24 17:05, Chinmay Rath wrote:
> This patch moves the below instructions to decodetree specification:
> 
>          {add, subf}[c,e,me,ze][o][.]       : XO-form
>          addic[.], subfic                   : D-form
>          addex                              : Z23-form
> 
> This patch introduces XO form instructions into decode tree specification, for
> which all the four variations([o][.]) have been handled with a single pattern.
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode                   |  26 ++++
>   target/ppc/translate.c                     | 136 ---------------------
>   target/ppc/translate/fixedpoint-impl.c.inc |  69 +++++++++++
>   3 files changed, 95 insertions(+), 136 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 4fcf3af8d0..ddaa47210a 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -187,6 +187,12 @@
>   &X_a            ra
>   @X_a            ...... ra:3 .. ..... ..... .......... .         &X_a
>   
> +&XO             rt ra rb oe:bool rc:bool
> +@XO             ...... rt:5 ra:5 rb:5 oe:1 ......... rc:1       &XO
> +
> +&XO_ta          rt ra oe:bool rc:bool
> +@XO_ta          ...... rt:5 ra:5 ..... oe:1 ......... rc:1      &XO_ta
> +
>   %xx_xt          0:1 21:5
>   %xx_xb          1:1 11:5
>   %xx_xa          2:1 16:5
> @@ -239,6 +245,9 @@
>   &Z23_tab        frt fra frb rmc rc:bool
>   @Z23_tab        ...... frt:5 fra:5 frb:5 rmc:2 ........ rc:1    &Z23_tab
>   
> +&Z23_tab_cy     rt ra rb cy
> +@Z23_tab_cy     ...... rt:5 ra:5 rb:5 cy:2 ........ .           &Z23_tab_cy
> +
>   %z23_frtp       22:4 !function=times_2
>   %z23_frap       17:4 !function=times_2
>   %z23_frbp       12:4 !function=times_2
> @@ -322,10 +331,27 @@ CMPLI           001010 ... - . ..... ................   @D_bfu
>   
>   ### Fixed-Point Arithmetic Instructions
>   
> +ADD             011111 ..... ..... ..... . 100001010 .  @XO
> +ADDC            011111 ..... ..... ..... . 000001010 .  @XO
> +ADDE            011111 ..... ..... ..... . 010001010 .  @XO
> +ADDEX           011111 ..... ..... ..... .. 10101010 -  @Z23_tab_cy
> +
>   ADDI            001110 ..... ..... ................     @D
>   ADDIS           001111 ..... ..... ................     @D
> +ADDIC           001100 ..... ..... ................     @D
> +ADDIC_          001101 ..... ..... ................     @D
>   
>   ADDPCIS         010011 ..... ..... .......... 00010 .   @DX
> +ADDME           011111 ..... ..... ----- . 011101010 .  @XO_ta
> +ADDZE           011111 ..... ..... ----- . 011001010 .  @XO_ta
> +
> +SUBF            011111 ..... ..... ..... . 000101000 .  @XO
> +SUBFIC          001000 ..... ..... ................     @D
> +SUBFC           011111 ..... ..... ..... . 000001000 .  @XO
> +SUBFE           011111 ..... ..... ..... . 010001000 .  @XO
> +
> +SUBFME          011111 ..... ..... ----- . 011101000 .  @XO_ta
> +SUBFZE          011111 ..... ..... ----- . 011001000 .  @XO_ta
>   
>   ## Fixed-Point Logical Instructions
>   
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 049f636927..51dc1e79cc 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1697,61 +1697,6 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
>           tcg_gen_mov_tl(ret, t0);
>       }
>   }
> -/* Add functions with two operands */
> -#define GEN_INT_ARITH_ADD(name, opc3, ca, add_ca, compute_ca, compute_ov)     \
> -static void glue(gen_, name)(DisasContext *ctx)                               \
> -{                                                                             \
> -    gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                           \
> -                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],      \
> -                     ca, glue(ca, 32),                                        \
> -                     add_ca, compute_ca, compute_ov, Rc(ctx->opcode));        \
> -}
> -/* Add functions with one operand and one immediate */
> -#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val, ca,                    \
> -                                add_ca, compute_ca, compute_ov)               \
> -static void glue(gen_, name)(DisasContext *ctx)                               \
> -{                                                                             \
> -    TCGv t0 = tcg_constant_tl(const_val);                                     \
> -    gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                           \
> -                     cpu_gpr[rA(ctx->opcode)], t0,                            \
> -                     ca, glue(ca, 32),                                        \
> -                     add_ca, compute_ca, compute_ov, Rc(ctx->opcode));        \
> -}
> -
> -/* add  add.  addo  addo. */
> -GEN_INT_ARITH_ADD(add, 0x08, cpu_ca, 0, 0, 0)
> -GEN_INT_ARITH_ADD(addo, 0x18, cpu_ca, 0, 0, 1)
> -/* addc  addc.  addco  addco. */
> -GEN_INT_ARITH_ADD(addc, 0x00, cpu_ca, 0, 1, 0)
> -GEN_INT_ARITH_ADD(addco, 0x10, cpu_ca, 0, 1, 1)
> -/* adde  adde.  addeo  addeo. */
> -GEN_INT_ARITH_ADD(adde, 0x04, cpu_ca, 1, 1, 0)
> -GEN_INT_ARITH_ADD(addeo, 0x14, cpu_ca, 1, 1, 1)
> -/* addme  addme.  addmeo  addmeo.  */
> -GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, cpu_ca, 1, 1, 0)
> -GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, cpu_ca, 1, 1, 1)
> -/* addex */
> -GEN_INT_ARITH_ADD(addex, 0x05, cpu_ov, 1, 1, 0);
> -/* addze  addze.  addzeo  addzeo.*/
> -GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, cpu_ca, 1, 1, 0)
> -GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, cpu_ca, 1, 1, 1)
> -/* addic  addic.*/
> -static inline void gen_op_addic(DisasContext *ctx, bool compute_rc0)
> -{
> -    TCGv c = tcg_constant_tl(SIMM(ctx->opcode));
> -    gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
> -                     c, cpu_ca, cpu_ca32, 0, 1, 0, compute_rc0);
> -}
> -
> -static void gen_addic(DisasContext *ctx)
> -{
> -    gen_op_addic(ctx, 0);
> -}
> -
> -static void gen_addic_(DisasContext *ctx)
> -{
> -    gen_op_addic(ctx, 1);
> -}
>   
>   static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
>                                        TCGv arg2, int sign, int compute_ov)
> @@ -2172,47 +2117,6 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>           tcg_gen_mov_tl(ret, t0);
>       }
>   }
> -/* Sub functions with Two operands functions */
> -#define GEN_INT_ARITH_SUBF(name, opc3, add_ca, compute_ca, compute_ov)        \
> -static void glue(gen_, name)(DisasContext *ctx)                               \
> -{                                                                             \
> -    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)],                          \
> -                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
> -                      add_ca, compute_ca, compute_ov, Rc(ctx->opcode));       \
> -}
> -/* Sub functions with one operand and one immediate */
> -#define GEN_INT_ARITH_SUBF_CONST(name, opc3, const_val,                       \
> -                                add_ca, compute_ca, compute_ov)               \
> -static void glue(gen_, name)(DisasContext *ctx)                               \
> -{                                                                             \
> -    TCGv t0 = tcg_constant_tl(const_val);                                     \
> -    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)],                          \
> -                      cpu_gpr[rA(ctx->opcode)], t0,                           \
> -                      add_ca, compute_ca, compute_ov, Rc(ctx->opcode));       \
> -}
> -/* subf  subf.  subfo  subfo. */
> -GEN_INT_ARITH_SUBF(subf, 0x01, 0, 0, 0)
> -GEN_INT_ARITH_SUBF(subfo, 0x11, 0, 0, 1)
> -/* subfc  subfc.  subfco  subfco. */
> -GEN_INT_ARITH_SUBF(subfc, 0x00, 0, 1, 0)
> -GEN_INT_ARITH_SUBF(subfco, 0x10, 0, 1, 1)
> -/* subfe  subfe.  subfeo  subfo. */
> -GEN_INT_ARITH_SUBF(subfe, 0x04, 1, 1, 0)
> -GEN_INT_ARITH_SUBF(subfeo, 0x14, 1, 1, 1)
> -/* subfme  subfme.  subfmeo  subfmeo.  */
> -GEN_INT_ARITH_SUBF_CONST(subfme, 0x07, -1LL, 1, 1, 0)
> -GEN_INT_ARITH_SUBF_CONST(subfmeo, 0x17, -1LL, 1, 1, 1)
> -/* subfze  subfze.  subfzeo  subfzeo.*/
> -GEN_INT_ARITH_SUBF_CONST(subfze, 0x06, 0, 1, 1, 0)
> -GEN_INT_ARITH_SUBF_CONST(subfzeo, 0x16, 0, 1, 1, 1)
> -
> -/* subfic */
> -static void gen_subfic(DisasContext *ctx)
> -{
> -    TCGv c = tcg_constant_tl(SIMM(ctx->opcode));
> -    gen_op_arith_subf(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
> -                      c, 0, 1, 0, 0);
> -}
>   
>   /* neg neg. nego nego. */
>   static inline void gen_op_arith_neg(DisasContext *ctx, bool compute_ov)
> @@ -6486,8 +6390,6 @@ GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
>   GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
>   GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
>   GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
> -GEN_HANDLER(addic, 0x0C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER2(addic_, "addic.", 0x0D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>   GEN_HANDLER(mulhw, 0x1F, 0x0B, 0x02, 0x00000400, PPC_INTEGER),
>   GEN_HANDLER(mulhwu, 0x1F, 0x0B, 0x00, 0x00000400, PPC_INTEGER),
>   GEN_HANDLER(mullw, 0x1F, 0x0B, 0x07, 0x00000000, PPC_INTEGER),
> @@ -6498,7 +6400,6 @@ GEN_HANDLER(mulld, 0x1F, 0x09, 0x07, 0x00000000, PPC_64B),
>   #endif
>   GEN_HANDLER(neg, 0x1F, 0x08, 0x03, 0x0000F800, PPC_INTEGER),
>   GEN_HANDLER(nego, 0x1F, 0x08, 0x13, 0x0000F800, PPC_INTEGER),
> -GEN_HANDLER(subfic, 0x08, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>   GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>   GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>   GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
> @@ -6709,25 +6610,6 @@ GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
>   GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
>   #endif
>   
> -#undef GEN_INT_ARITH_ADD
> -#undef GEN_INT_ARITH_ADD_CONST
> -#define GEN_INT_ARITH_ADD(name, opc3, add_ca, compute_ca, compute_ov)         \
> -GEN_HANDLER(name, 0x1F, 0x0A, opc3, 0x00000000, PPC_INTEGER),
> -#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val,                        \
> -                                add_ca, compute_ca, compute_ov)               \
> -GEN_HANDLER(name, 0x1F, 0x0A, opc3, 0x0000F800, PPC_INTEGER),
> -GEN_INT_ARITH_ADD(add, 0x08, 0, 0, 0)
> -GEN_INT_ARITH_ADD(addo, 0x18, 0, 0, 1)
> -GEN_INT_ARITH_ADD(addc, 0x00, 0, 1, 0)
> -GEN_INT_ARITH_ADD(addco, 0x10, 0, 1, 1)
> -GEN_INT_ARITH_ADD(adde, 0x04, 1, 1, 0)
> -GEN_INT_ARITH_ADD(addeo, 0x14, 1, 1, 1)
> -GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, 1, 1, 0)
> -GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, 1, 1, 1)
> -GEN_HANDLER_E(addex, 0x1F, 0x0A, 0x05, 0x00000000, PPC_NONE, PPC2_ISA300),
> -GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, 1, 1, 0)
> -GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, 1, 1, 1)
> -
>   #undef GEN_INT_ARITH_DIVW
>   #define GEN_INT_ARITH_DIVW(name, opc3, sign, compute_ov)                      \
>   GEN_HANDLER(name, 0x1F, 0x0B, opc3, 0x00000000, PPC_INTEGER)
> @@ -6766,24 +6648,6 @@ GEN_INT_ARITH_MUL_HELPER(mulhd, 0x02),
>   GEN_INT_ARITH_MUL_HELPER(mulldo, 0x17),
>   #endif
>   
> -#undef GEN_INT_ARITH_SUBF
> -#undef GEN_INT_ARITH_SUBF_CONST
> -#define GEN_INT_ARITH_SUBF(name, opc3, add_ca, compute_ca, compute_ov)        \
> -GEN_HANDLER(name, 0x1F, 0x08, opc3, 0x00000000, PPC_INTEGER),
> -#define GEN_INT_ARITH_SUBF_CONST(name, opc3, const_val,                       \
> -                                add_ca, compute_ca, compute_ov)               \
> -GEN_HANDLER(name, 0x1F, 0x08, opc3, 0x0000F800, PPC_INTEGER),
> -GEN_INT_ARITH_SUBF(subf, 0x01, 0, 0, 0)
> -GEN_INT_ARITH_SUBF(subfo, 0x11, 0, 0, 1)
> -GEN_INT_ARITH_SUBF(subfc, 0x00, 0, 1, 0)
> -GEN_INT_ARITH_SUBF(subfco, 0x10, 0, 1, 1)
> -GEN_INT_ARITH_SUBF(subfe, 0x04, 1, 1, 0)
> -GEN_INT_ARITH_SUBF(subfeo, 0x14, 1, 1, 1)
> -GEN_INT_ARITH_SUBF_CONST(subfme, 0x07, -1LL, 1, 1, 0)
> -GEN_INT_ARITH_SUBF_CONST(subfmeo, 0x17, -1LL, 1, 1, 1)
> -GEN_INT_ARITH_SUBF_CONST(subfze, 0x06, 0, 1, 1, 0)
> -GEN_INT_ARITH_SUBF_CONST(subfzeo, 0x16, 0, 1, 1, 1)
> -
>   #undef GEN_LOGICAL1
>   #undef GEN_LOGICAL2
>   #define GEN_LOGICAL2(name, tcg_op, opc, type)                                 \
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 51c6fa7330..12374b78cf 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -325,6 +325,75 @@ static bool trans_ADDPCIS(DisasContext *ctx, arg_DX *a)
>       return true;
>   }
>   
> +static bool trans_ADDEX(DisasContext *ctx, arg_Z23_tab_cy *a)
> +{
> +    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
> +                     cpu_ov, cpu_ov32, true, true, false, false);
> +    return true;
> +}
> +
> +static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
> +                     bool compute_ov, bool compute_rc0)
> +{
> +    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra],
> +                     tcg_constant_tl(a->si), cpu_ca, cpu_ca32,
> +                     add_ca, compute_ca, compute_ov, compute_rc0);
> +    return true;
> +}
> +
> +static bool do_add_XO(DisasContext *ctx, arg_XO *a, bool add_ca,
> +                      bool compute_ca)
> +{
> +    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
> +                     cpu_ca, cpu_ca32, add_ca, compute_ca, a->oe, a->rc);
> +    return true;
> +}
> +
> +static bool do_add_const_XO(DisasContext *ctx, arg_XO_ta *a, TCGv const_val,
> +                            bool add_ca, bool compute_ca)
> +{
> +    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], const_val,
> +                     cpu_ca, cpu_ca32, add_ca, compute_ca, a->oe, a->rc);
> +    return true;
> +}
> +
> +TRANS(ADD, do_add_XO, false, false);
> +TRANS(ADDC, do_add_XO, false, true);
> +TRANS(ADDE, do_add_XO, true, true);
> +TRANS(ADDME, do_add_const_XO, tcg_constant_tl(-1LL), true, true);
> +TRANS(ADDZE, do_add_const_XO, tcg_constant_tl(0), true, true);
> +TRANS(ADDIC, do_add_D, false, true, false, false);
> +TRANS(ADDIC_, do_add_D, false, true, false, true);
> +
> +static bool trans_SUBFIC(DisasContext *ctx, arg_D *a)
> +{
> +    gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra],
> +                      tcg_constant_tl(a->si), false, true, false, false);
> +    return true;
> +}
> +
> +static bool do_subf_XO(DisasContext *ctx, arg_XO *a, bool add_ca,
> +                       bool compute_ca)
> +{
> +    gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
> +                      add_ca, compute_ca, a->oe, a->rc);
> +    return true;
> +}
> +
> +static bool do_subf_const_XO(DisasContext *ctx, arg_XO_ta *a, TCGv const_val,
> +                             bool add_ca, bool compute_ca)
> +{
> +    gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], const_val,
> +                      add_ca, compute_ca, a->oe, a->rc);
> +    return true;
> +}
> +
> +TRANS(SUBF, do_subf_XO, false, false)
> +TRANS(SUBFC, do_subf_XO, false, true)
> +TRANS(SUBFE, do_subf_XO, true, true)
> +TRANS(SUBFME, do_subf_const_XO, tcg_constant_tl(-1LL), true, true)
> +TRANS(SUBFZE, do_subf_const_XO, tcg_constant_tl(0), true, true)
> +
>   static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
>   {
>       gen_invalid(ctx);

