Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEB9C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFxj-00074C-Nw; Wed, 26 Aug 2026 11:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzFxX-000733-4l; Wed, 26 Aug 2026 11:54:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzFxU-0003Q2-7t; Wed, 26 Aug 2026 11:54:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1ZxN4185132; Wed, 26 Aug 2026 15:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fFqS0l
 Fa9bOPJxUB1btabRpvSxG7341rX3iEj+tommM=; b=p9DCtPztO8NwRx43kG5zNx
 PlhjNYeRmFrdDMDsWXidwKV4t3FtLaC1XwPLhjIOQq1xC073/sRebEgBFaJAwyTq
 MP2WHZAUutHRd4C1huoIBOb3erl+QXD25jwAiu3Hg2KVaSpKWXoexBD/kOsfVsg7
 3k5czk+Z5wLYunrofMEvdrfJHEoORn0J7W4uJR50oFm24beVZoT81sxlAYiH/dhZ
 o3JDhzzy3H4AX2oOAKi9hrgbeai5Www+dP5J7zrR+yt7YW7DOaYV92Rs/p6vkeul
 RoaktCZN7y0JbKeC6uTI7ZmLePud4mQ/LxgCOh5bJ1gAluBtyJq5TrSmkz4Csp/Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73947q24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 15:54:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QFfLOt014332;
 Wed, 26 Aug 2026 15:54:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwawbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 15:54:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QFsRIS45941036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 15:54:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBE2420043;
 Wed, 26 Aug 2026 15:54:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C864820040;
 Wed, 26 Aug 2026 15:54:23 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 15:54:23 +0000 (GMT)
Date: Wed, 26 Aug 2026 21:24:26 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 28/37] target/ppc: Move byte-reverse instructions to
 decodetree
Message-ID: <20260826212240.e4941caf-e6-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-29-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826050923.74756-29-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: oWw7bhastulU9c_bwEdA8U_HT1p9pdw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyOSBTYWx0ZWRfX1oANTPxzS/yB
 x/rfwBcjnVu0Z3UI8HvzONnnwvvIXhhBzP86J+TvLid1XANl7HN0jO+YyIKW9MqiuzFv4J7Lav3
 lxSFgCm+ePJ7VVC8vPpqXoEq/9IhY7JtQKx90skEuL9aw7oFz2D1TxYjPIt73fOZZaxSi1S6b1D
 RTXrjUo/xH7Ty663pimoeXjkUG65a+WJU2ul0dQ714nQ8dk+kdinXFNjY8uZsMdvH2jxD05I2ZG
 XLtU82YK0FZoj3tdJYuL0KqHQ2xwTTJO/Y9rGc5LIRr8w4I8yt0fRMfGAo4AiMBRy9HooWNpz8v
 Y8nm+Q/iYuYlBLRyKiuGos0rjtQLgxzz4LDpLDTuleAyfIo7USQ9s87zUENFmhK+DICPttfv5ag
 IStYuTXIaTQtdGZw7w5yYB1Ltg2RT9R5ozrE+WL6hacVFxr0IgFeU5Xafykmkl9mRTNt70ixjMS
 +ehpJN+hy6tFFQu+A1A==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8f0c38 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mDV3o1hIAAAA:8
 a=VnNF1IyMAAAA:8 a=Z3Pe7eb-piHrGaCcTuUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyOSBTYWx0ZWRfX+IS0CO7pyPKl
 kPd0Re6SHV21xmuIaIGo6ktuKTJdAHy+LwY4rX9XcblH9ndMWP/6fzgO8O0ZwztT0VqjpH9aAHC
 KqpGJVdjs5qpTkGP3dADOl4kom9i/pY=
X-Proofpoint-ORIG-GUID: DxGIqOtu1Bt4BFFX7DnDNqegVzVzD9sT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260129
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
>  target/ppc/translate.c                     | 35 -------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 40 ++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index f7ab08704f..7614655f72 100644
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
> index 9d29134fa1..8950476be7 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4532,42 +4532,7 @@ static void gen_dform3D(DisasContext *ctx)
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
> index a75279022c..cef67d6431 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -17,6 +17,46 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +/*
> + * Byte-Reverse Instructions
> + */
> +static bool do_byte_reverse_X_sa(DisasContext *ctx, arg_X_sa *a, int kind)
> +{
> +#if defined(TARGET_PPC64)
> +    switch (kind) {
> +    case 0: /* brd */
> +        tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
> +        break;
> +    case 1: /* brw */
> +        tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
> +        tcg_gen_rotli_i64(cpu_gpr[a->ra], cpu_gpr[a->ra], 32);
> +        break;
> +    case 2: /* brh */
> +    {
> +        TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +        TCGv_i64 t2 = tcg_temp_new_i64();
> +
> +        tcg_gen_shri_i64(t1, cpu_gpr[a->rs], 8);
> +        tcg_gen_and_i64(t2, t1, mask);
> +        tcg_gen_and_i64(t1, cpu_gpr[a->rs], mask);
> +        tcg_gen_shli_i64(t1, t1, 8);
> +        tcg_gen_or_i64(cpu_gpr[a->ra], t1, t2);
> +        break;
> +    }
> +    default:
> +        g_assert_not_reached();
> +    }
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +TRANS64_FLAGS2(ISA310, BRD, do_byte_reverse_X_sa, 0)
> +TRANS64_FLAGS2(ISA310, BRW, do_byte_reverse_X_sa, 1)
> +TRANS64_FLAGS2(ISA310, BRH, do_byte_reverse_X_sa, 2)

The kind values 0, 1, 2 are opaque at the call site — a reader has to
cross-reference the switch inside do_byte_reverse_X_sa to know which is
which. The more common pattern in this series is three small separate
translators, which avoids the switch entirely and is self-documenting:

static bool trans_BRD(DisasContext *ctx, arg_BRD *a)
{
    REQUIRE_64BIT(ctx);
    REQUIRE_INSNS_FLAGS2(ctx, ISA310);
    tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
    return true;
}

...and similarly for BRW and BRH. This also eliminates the
do_byte_reverse_X_sa wrapper and the #else qemu_build_not_reached()
block entirely, since REQUIRE_64BIT already handles 32-bit builds.

~Amit


