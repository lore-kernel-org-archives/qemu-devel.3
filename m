Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD25BC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVmw-0007LO-E1; Mon, 24 Aug 2026 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVmv-0007Kt-BY; Mon, 24 Aug 2026 10:36:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVmt-0005bn-AF; Mon, 24 Aug 2026 10:36:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD22ln1847117; Mon, 24 Aug 2026 14:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Taw3ro8lR6WuGdlZWxwQ4H+edivjDg9mFfNLSqo3wsU=; b=G/j+uNPLDoyt
 PladblPZAPxc/Ssb439vDb6bnMb4LJbhpDW1itRKPN2Cc3qbVljc79j38ykkPjtK
 iUQJxzuEOh9oOAD6BkiY9Ye/HJ+GRKMfJsFd98ti98/lrxZA9RbUFiceJWXkwLjL
 PLpgwBZfze8rEXUIcwwWJdFTmkxcHUQuQwvzSYRbwyxlt0zpSCpyekzLclqewO8h
 gUqntHUqkJYc4DJxnaXEYivFivvOrzdBZ7kySk/qDhdZJGnf6TZM/AAEmRX63c3n
 1vkjTdr6ZYCfT8ShhOV8xMN7lxQjQb/kFUkLN92ZJggT1ihN8+rp0myLIY6QZKnr
 /anOqkimrg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hj72c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:36:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQPMo029842;
 Mon, 24 Aug 2026 14:36:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jphy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:36:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEaUhR8585846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:36:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47D2458058;
 Mon, 24 Aug 2026 14:36:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD69958059;
 Mon, 24 Aug 2026 14:36:28 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:36:28 +0000 (GMT)
Message-ID: <bbe6eb836c5301291e7d20b9d5d4eb7990499144.camel@linux.ibm.com>
Subject: Re: [PATCH 11/29] target/ppc: Move fixed-point byte-reversal store
 insns to decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:36:28 -0500
In-Reply-To: <20260820140114.327023-12-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-12-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX0WkeMuzvlQXt
 RfaQrgPhtE46jDgrEHA0wqspW9wOys0GpxH22a8Dzrb34jumcUojHpr5VPOuhh/QhR5EE+Bs4Oa
 E6E9wd2XuNbMu0dLOxg5mSokII8cch4=
X-Proofpoint-GUID: FOhThLa_CjEPvWVVZhRnGV_9rM3-Gp36
X-Proofpoint-ORIG-GUID: kDS5eJDBXKbAriDt6KnCoxvAJHxo42vC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX3/5BZ5nXPdSS
 H7b4FG1X7zsTOO4tiRVYbN99SaiQ8B5/I4D8A+anxpsl28mksvFO/3a3kX7yvZWKOt08J4l6ImX
 q4hxvlgzol1/zXUU7WNaOwU9rSjlN6aC2X/Ysjojw2UXvf4DC2P8AycGpt/WGHp45cFfNswyxOG
 TVn6POPFJ9OXxWYa61WyCjPuShYPrIx+KetaV61dTB3XpKwxcqm6mJyfUMVTKlvZ7T7OF4O4Krj
 0q84W420EN7UbV5uv+xMuQ+/k/X4/1sbK7tLnK2enK6TqJQySYKQnAMkHYKM/5Q+LCWijlN3/kB
 vJkPFOhNPjq4TH8WBQEIiUdV/pmM29GODeUAPsoUfo1uln8tmsGh4IGCdmFarTWlL5gJVZ4nz19
 Z4SairsEe77XVyngLBI8TZsKJHh7HSaDvE+ZnLKXpsKE1UqaF7txXn6Kx28mIk3NVLzAAH5CW/n
 Qb+HUzpH7UOQ/gIYHbg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c56f1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=W5bMDWzCAKVaO9EUQNcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122
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
> From: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> Move the below PPC instructions to decodetree specification:
> 
>   st{d,h,w}brx, st{d,w,h,b}cix				: X-form
> 
> The changes were verified by validating that the TCG micro-ops generated
> by those insns remain the same. These TCG micro-ops were captured with
> the `-d op,in_asm` QEMU flag.
> 
> Additionally, remove GEN_STX and GEN_STX_E macros as they are no longer
> used anywhere else.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                   |  8 +++
>  target/ppc/translate.c                     | 52 +++-----------
>  target/ppc/translate/fixedpoint-impl.c.inc | 79 ++++++++++++++++++++++
>  3 files changed, 95 insertions(+), 44 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index d34094d717..8425c70b9d 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -372,6 +372,14 @@ STVDX           011111 ..... ..... ..... 0010010001 -   @X
>  STSKU           111110 ..... ..... ............. 0 11   @DD
>  STCXU           111110 ..... ..... ............. 1 11   @DD
>  
> +STDBRX          011111 ..... ..... ..... 1010010100 -   @X
> +STDCIX          011111 ..... ..... ..... 1111110101 -   @X
> +STWCIX          011111 ..... ..... ..... 1110010101 -   @X
> +STHCIX          011111 ..... ..... ..... 1110110101 -   @X
> +STBCIX          011111 ..... ..... ..... 1111010101 -   @X
> +STHBRX          011111 ..... ..... ..... 1110010110 -   @X
> +STWBRX          011111 ..... ..... ..... 1010010110 -   @X
> +
>  ### Fixed-Point Compare Instructions
>  
>  CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 09a461dd63..548a7c0437 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2529,23 +2529,6 @@ GEN_LDX_HVRM(lhzcix, ld16u, 0x15, 0x19, PPC_CILDST)
>  GEN_LDX_HVRM(lbzcix, ld8u, 0x15, 0x1a, PPC_CILDST)
>  #endif
>  
> -/***                              Integer store                            ***/
> -#define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
> -static void glue(gen_, name##x)(DisasContext *ctx)                            \
> -{                                                                             \
> -    TCGv EA;                                                                  \
> -    chk(ctx);                                                                 \
> -    gen_set_access_type(ctx, ACCESS_INT);                                     \
> -    EA = tcg_temp_new();                                                      \
> -    gen_addr_reg_index(ctx, EA);                                              \
> -    gen_qemu_##stop(ctx, cpu_gpr[rS(ctx->opcode)], EA);                       \
> -}
> -#define GEN_STX(name, stop, opc2, opc3, type)                                 \
> -    GEN_STX_E(name, stop, opc2, opc3, type, PPC_NONE, CHK_NONE)
> -
> -#define GEN_STX_HVRM(name, stop, opc2, opc3, type)                            \
> -    GEN_STX_E(name, stop, opc2, opc3, type, PPC_NONE, CHK_HVRM)
> -
>  #define GEN_STEPX(name, stop, opc2, opc3)                                     \
>  static void glue(gen_, name##epx)(DisasContext *ctx)                          \
>  {                                                                             \
> @@ -2565,12 +2548,6 @@ GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
>  GEN_STEPX(std, DEF_MEMOP(MO_UQ), 0x1d, 0x04)
>  #endif
>  
> -#if defined(TARGET_PPC64)
> -GEN_STX_HVRM(stdcix, st64_i64, 0x15, 0x1f, PPC_CILDST)
> -GEN_STX_HVRM(stwcix, st32, 0x15, 0x1c, PPC_CILDST)
> -GEN_STX_HVRM(sthcix, st16, 0x15, 0x1d, PPC_CILDST)
> -GEN_STX_HVRM(stbcix, st8, 0x15, 0x1e, PPC_CILDST)
> -#endif
>  /***                Integer load and store with byte reverse               ***/
>  
>  /* lhbrx */
> @@ -2582,15 +2559,8 @@ GEN_LDX(lwbr, ld32ur, 0x16, 0x10, PPC_INTEGER);
>  #if defined(TARGET_PPC64)
>  /* ldbrx */
>  GEN_LDX_E(ldbr, ld64ur_i64, 0x14, 0x10, PPC_NONE, PPC2_DBRX, CHK_NONE);
> -/* stdbrx */
> -GEN_STX_E(stdbr, st64r_i64, 0x14, 0x14, PPC_NONE, PPC2_DBRX, CHK_NONE);
>  #endif  /* TARGET_PPC64 */
>  
> -/* sthbrx */
> -GEN_STX(sthbr, st16r, 0x16, 0x1C, PPC_INTEGER);
> -/* stwbrx */
> -GEN_STX(stwbr, st32r, 0x16, 0x14, PPC_INTEGER);
> -
>  /***                    Integer load and store multiple                    ***/
>  
>  /* lmw */
> @@ -5117,9 +5087,17 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
>              return true;                            \
>          }                                           \
>      } while (0)
> +#define REQUIRE_HVRM(CTX)                               \
> +    do {                                                \
> +        if (unlikely(ctx->pr || !ctx->hv || ctx->dr)) { \
> +            gen_priv_opc(CTX);                          \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
>  #else
>  #define REQUIRE_SV(CTX) do { gen_priv_opc(CTX); return true; } while (0)
>  #define REQUIRE_HV(CTX) do { gen_priv_opc(CTX); return true; } while (0)
> +#define REQUIRE_HVRM(CTX) do { gen_priv_opc(CTX); return true; } while (0)
>  #endif
>  
>  /*
> @@ -5767,20 +5745,6 @@ GEN_LDEPX(lw, DEF_MEMOP(MO_UL), 0x1F, 0x00)
>  GEN_LDEPX(ld, DEF_MEMOP(MO_UQ), 0x1D, 0x00)
>  #endif
>  
> -#undef GEN_STX_E
> -#define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
> -GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000000, type, type2),
> -
> -#if defined(TARGET_PPC64)
> -GEN_STX_E(stdbr, st64r_i64, 0x14, 0x14, PPC_NONE, PPC2_DBRX, CHK_NONE)
> -GEN_STX_HVRM(stdcix, st64_i64, 0x15, 0x1f, PPC_CILDST)
> -GEN_STX_HVRM(stwcix, st32, 0x15, 0x1c, PPC_CILDST)
> -GEN_STX_HVRM(sthcix, st16, 0x15, 0x1d, PPC_CILDST)
> -GEN_STX_HVRM(stbcix, st8, 0x15, 0x1e, PPC_CILDST)
> -#endif
> -GEN_STX(sthbr, st16r, 0x16, 0x1C, PPC_INTEGER)
> -GEN_STX(stwbr, st32r, 0x16, 0x14, PPC_INTEGER)
> -
>  #undef GEN_STEPX
>  #define GEN_STEPX(name, ldop, opc2, opc3)                                     \
>  GEN_HANDLER_E(name##epx, 0x1F, opc2, opc3,                                    \
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 9f669894a3..25a60d3d3a 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -566,6 +566,85 @@ TRANS(ADDIC_, do_add_D, false, true, false, true);
>  TRANS(SLD, do_shift_X_rc, tcg_gen_shl_tl);
>  TRANS(SRD, do_shift_X_rc, tcg_gen_shr_tl);
>  
> +static bool do_stxx(DisasContext *ctx, arg_X *a,
> +                       void(*op)(DisasContext *, TCGv, TCGv), bool is_hvrm)
> +{
> +    TCGv ea;
> +
> +    if (is_hvrm) {
> +            REQUIRE_HVRM(ctx);
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    op(ctx, cpu_gpr[a->rt], ea);
> +
> +    return true;
> +}
> +
> +TRANS(STHBRX, do_stxx, gen_qemu_st16r, 0);
> +TRANS(STWBRX, do_stxx, gen_qemu_st32r, 0);
> +
> +static bool trans_STDBRX(DisasContext *ctx, arg_STDBRX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, DBRX);
> +#if defined(TARGET_PPC64)
> +    return do_stxx(ctx, a, gen_qemu_st64r_i64, false);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_STDCIX(DisasContext *ctx, arg_STDCIX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> +#if defined(TARGET_PPC64)
> +    return do_stxx(ctx, a, gen_qemu_st64_i64, true);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_STWCIX(DisasContext *ctx, arg_STWCIX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> +#if defined(TARGET_PPC64)
> +    return do_stxx(ctx, a, gen_qemu_st32, true);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_STHCIX(DisasContext *ctx, arg_STHCIX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> +#if defined(TARGET_PPC64)
> +    return do_stxx(ctx, a, gen_qemu_st16, true);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_STBCIX(DisasContext *ctx, arg_STBCIX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> +#if defined(TARGET_PPC64)
> +    return do_stxx(ctx, a, gen_qemu_st8, true);
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
>  static bool trans_SUBFIC(DisasContext *ctx, arg_D *a)
>  {
>      gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra],


