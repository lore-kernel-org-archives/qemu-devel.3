Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47A3C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWo7-0000NN-Hg; Mon, 24 Aug 2026 11:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWo5-0000Mf-Rh; Mon, 24 Aug 2026 11:41:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWo3-0004yF-SG; Mon, 24 Aug 2026 11:41:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1eMH2004320; Mon, 24 Aug 2026 15:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=z1QC8kj5qm4uzstwfhjWjQ1BtsYTo97q5lDg8cNpe7Q=; b=gq8bwKVRado3
 Ee8JUSC0QfdP5mBbLmCsmVBRA8VQSpsbK727UE8bo+cjmbqfoKPBEh4m+xV2do+C
 UE5/nEYJGlb6wOUW3makoI8Tg0ryRdo7NxkvezDEK6rUp80PjxZUTd+tXGsgeDdj
 zovLbhTkUMIpw+EwwzwqB5sIRFlSvzO3x+wHvmFnOMHyPoGe+/OQ6CPXd1TfHmFv
 2AhxT7DMETb8GWZvXQh4JbnsXXvYFmSwxsVmtzeXnhR+cTF9WBsog8J0+pS+o835
 d63faXj/wzb5X8nOPGG+ipRq52Lac2BDyPBUpLZC7nUKS3WbMhq3wPVcPIVc4+A4
 MvHloLt+IQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx26jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:41:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFfL7s030510;
 Mon, 24 Aug 2026 15:41:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpvcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:41:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OFfkwF22151890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 15:41:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2CEE5803F;
 Mon, 24 Aug 2026 15:41:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C11058055;
 Mon, 24 Aug 2026 15:41:45 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 15:41:45 +0000 (GMT)
Message-ID: <4fdbe85d9ce0610984be3c28a86077fee3b69d11.camel@linux.ibm.com>
Subject: Re: [PATCH 28/29] target/ppc: Move byte-reverse instructions to
 decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 10:41:45 -0500
In-Reply-To: <20260820140114.327023-29-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-29-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzMSBTYWx0ZWRfX4XZBl0KAErAU
 WAqXO7PHSX6eIqV8wI/ZReZs2hJpgm7Kmtez6AjlmVp+Kn5f1MhPuK4C1uHoWiBnD61ZLRAovRg
 BMQpt27g8/wKN/7XkzLJQ/XCyE6cZP4=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c663d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=mDV3o1hIAAAA:8
 a=VnNF1IyMAAAA:8 a=Z3Pe7eb-piHrGaCcTuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RLbW7Zh2khdWgEJ3Jpn808raGgK1Zitt
X-Proofpoint-GUID: rLTnwpRf_s5Yu93df7EJVlFKM6x1SyZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzMSBTYWx0ZWRfX9//BkOn1P8fJ
 yLB9AdeCUpt4Wh7cbpPlXzXIL2j0u/J36qhllqvaeoloQtfkkRr0Ym+6aHSYVct8/T+47EZ4cCD
 6ErjwcZPnA9tBytu8dr9B26aCIe4sgFwPhc233InHEuXW742W+FwdeGTLKu5w8y5hooCWw3oG/W
 LmOEauJ/UD+BRyQxyRiUUf/qNR/5Zlb0m+s8YLUw+rUvkHR+8h6XsXCKv/i5VP9SfMXOtfdWlxx
 hV3+TBe6LPAIl4xBe6HzDCd482S7JpAhH2Q3Nhh+JY/ERa8MAfGet7rlh9cK2oKZ22HUEjS9XR7
 Sb3hZdzP1C5m3FtJQVHZFLevOg1fLAntnCXu3TmrzEOM2taOs4DET4ZtS8a03rBBv44QMOjdv4m
 nPdrvckkfrYAIjgXpI/DFpQA/9N1LwOQVaq0BhYxZnoyDQKtoreG0ApnlNsgoB1S0K6fx8qhpBf
 DiExhRlFbaF0e44qLlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240131
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
> +
>  /*
>   * Fixed-Point Load/Store Instructions
>   */


