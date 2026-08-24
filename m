Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A324C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWRT-0001CX-Vz; Mon, 24 Aug 2026 11:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWRS-0001C6-E6; Mon, 24 Aug 2026 11:18:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWRQ-0004Xf-CI; Mon, 24 Aug 2026 11:18:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1WmS1935729; Mon, 24 Aug 2026 15:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=7T9SHUjPiciu2zew+vr01JpzM5K2DVgKHgmPU+D+zis=; b=dBk61OrgbLrz
 JylGDSm+jl9k27MK+QEXj+x7LGOUuXXtFElSqlNjNIbn1zGasSPONeQd6Zx3c7Hh
 6LLoXKFlno+Np8j2/WNW2E5CNzxZyczeQZgLo3tXSekPxM5LsIqB7YijrnQpbWpn
 Z1UosT7sSDT89DzS0HKXsBzUmfPFOeWnOyodCe+bFqr2MqCLNUFkpjUqRqstMrFs
 19Si5J9aY99c22foAumJFkIpuAVMeDe1EsBXlGLcUkw///1XKy9TAHeAI9AUC2qc
 TKZktwRnMn7dhNuv9bkjKOZNW9cfIxqRugBS3eFn93hKsTPHWkZxPq9OeYEvjZ9c
 eIK9woF7hA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t9f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:18:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFBK8R029272;
 Mon, 24 Aug 2026 15:18:23 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxvqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:18:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OFILwu18285172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 15:18:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9CDE58043;
 Mon, 24 Aug 2026 15:18:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83FF658059;
 Mon, 24 Aug 2026 15:18:20 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 15:18:20 +0000 (GMT)
Message-ID: <b39f23ecc488212e9abd1ff5452fed68eb2e07d1.camel@linux.ibm.com>
Subject: Re: [PATCH 21/29] target/ppc: Move Condition Register logical
 instructions to decodetree.
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 10:18:20 -0500
In-Reply-To: <20260820140114.327023-22-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-22-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KagtGOdZ4Te_8RMR1oyIHp4PzVUsWbit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXx9lsxqFwFlIL
 5FjjnbftHbxJZjFK6UW6TDqo+Tx7pft6wqvjHYgHXJxaAAyXPwYT2tkrQgUvws6dN+ykc1sNb2X
 PQoMWvJ7G23G5hyA9YgK72QX+0IHfVmo3YGEukQiXCjUU1KHysLFK/Gh8wIuoliXW+dB9AFnQVD
 PDlCsqvOdhwuMdTF5AiN/zzw2RCHHNzYgKD36Z8Xnmic3/qLYbhzwcCSuid3M5qI27yyYlz0wpx
 gvfhiuSSHQ5fx1nxCVQ9xj/BaSeMG93cHbEMWR18JuLEUiGo8UEUNGgC+wS4ZCft9ro/t/Vbxsv
 tbrUzHXcJGRgFAY6g16Zq/sDjfdRCuNVYWqzXE43z9a32R+3BdUz4EGi/qi0mBLVzxSpPbFtmfj
 wy32ctrDnMZuYSqTNpOz3IqLTRcjT3PILxiJWCH2fLTLbC0qUoNu8jlQZz36S1zwrmmIA86drka
 0Onx+D9hAlPEAGDltWw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c60c1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uQATh4VuCaFWsuC2iroA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX+FtslbfpH8Lr
 4zO7ka3/1JO3yujw5p4PEyD/fMGCXDc5oxeZGHgtQsVY3Cyw56U6IIobOzGFRAfhTF9rj/SRv2E
 vIA79EnVkiv2gkbgO1flLJyAenTS760=
X-Proofpoint-ORIG-GUID: 2zF0S6WVH7dBJ5hjVUSQL4LzfQcmNTHE
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
> From: Shivang Upadhyay <shivangu@linux.ibm.com>
> 
> Move below instructions to decodetree specification :
> 
>         cr{and, or, xor, nand, nor, eqv, andc, orc}  : XL-form
> 
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                   | 11 ++++
>  target/ppc/translate.c                     | 59 ----------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 45 +++++++++++++++++
>  3 files changed, 56 insertions(+), 59 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index dc708b5442..a3973e042d 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -516,6 +516,17 @@ CFUGED          011111 ..... ..... ..... 0011011100 -   @X
>  PDEPD           011111 ..... ..... ..... 0010011100 -   @X
>  PEXTD           011111 ..... ..... ..... 0010111100 -   @X
>  
> +## Condition Register Instructions
> +
> +CRAND           010011 ..... ..... ..... 0100000001 -  @X
> +CROR            010011 ..... ..... ..... 0111000001 -  @X
> +CRNAND          010011 ..... ..... ..... 0011100001 -  @X
> +CRXOR           010011 ..... ..... ..... 0011000001 -  @X
> +CRNOR           010011 ..... ..... ..... 0000100001 -  @X
> +CREQV           010011 ..... ..... ..... 0100100001 -  @X
> +CRANDC          010011 ..... ..... ..... 0010000001 -  @X
> +CRORC           010011 ..... ..... ..... 0110100001 -  @X
> +
>  # Fixed-Point Hash Instructions
>  
>  HASHST          011111 ..... ..... ..... 1011010010 .   @X_DW
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index d01981de73..5b08d9b282 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2920,53 +2920,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
>      tcg_gen_movi_tl(cpu_lr, nip);
>  }
>  
> -/***                      Condition register logical                       ***/
> -#define GEN_CRLOGIC(name, tcg_op, opc)                                        \
> -static void glue(gen_, name)(DisasContext *ctx)                               \
> -{                                                                             \
> -    uint8_t bitmask;                                                          \
> -    int sh;                                                                   \
> -    TCGv_i32 t0, t1;                                                          \
> -    sh = (crbD(ctx->opcode) & 0x03) - (crbA(ctx->opcode) & 0x03);             \
> -    t0 = tcg_temp_new_i32();                                                  \
> -    if (sh > 0)                                                               \
> -        tcg_gen_shri_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2], sh);            \
> -    else if (sh < 0)                                                          \
> -        tcg_gen_shli_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2], -sh);           \
> -    else                                                                      \
> -        tcg_gen_mov_i32(t0, cpu_crf[crbA(ctx->opcode) >> 2]);                 \
> -    t1 = tcg_temp_new_i32();                                                  \
> -    sh = (crbD(ctx->opcode) & 0x03) - (crbB(ctx->opcode) & 0x03);             \
> -    if (sh > 0)                                                               \
> -        tcg_gen_shri_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2], sh);            \
> -    else if (sh < 0)                                                          \
> -        tcg_gen_shli_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2], -sh);           \
> -    else                                                                      \
> -        tcg_gen_mov_i32(t1, cpu_crf[crbB(ctx->opcode) >> 2]);                 \
> -    tcg_op(t0, t0, t1);                                                       \
> -    bitmask = 0x08 >> (crbD(ctx->opcode) & 0x03);                             \
> -    tcg_gen_andi_i32(t0, t0, bitmask);                                        \
> -    tcg_gen_andi_i32(t1, cpu_crf[crbD(ctx->opcode) >> 2], ~bitmask);          \
> -    tcg_gen_or_i32(cpu_crf[crbD(ctx->opcode) >> 2], t0, t1);                  \
> -}
> -
> -/* crand */
> -GEN_CRLOGIC(crand, tcg_gen_and_i32, 0x08);
> -/* crandc */
> -GEN_CRLOGIC(crandc, tcg_gen_andc_i32, 0x04);
> -/* creqv */
> -GEN_CRLOGIC(creqv, tcg_gen_eqv_i32, 0x09);
> -/* crnand */
> -GEN_CRLOGIC(crnand, tcg_gen_nand_i32, 0x07);
> -/* crnor */
> -GEN_CRLOGIC(crnor, tcg_gen_nor_i32, 0x01);
> -/* cror */
> -GEN_CRLOGIC(cror, tcg_gen_or_i32, 0x0E);
> -/* crorc */
> -GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D);
> -/* crxor */
> -GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06);
> -
>  /***                           System linkage                              ***/
>  
>  /* rfi (supervisor only) */
> @@ -5120,18 +5073,6 @@ GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
>  GEN_STEPX(std, DEF_MEMOP(MO_UQ), 0x1D, 0x04)
>  #endif
>  
> -#undef GEN_CRLOGIC
> -#define GEN_CRLOGIC(name, tcg_op, opc)                                        \
> -GEN_HANDLER(name, 0x13, 0x01, opc, 0x00000001, PPC_INTEGER)
> -GEN_CRLOGIC(crand, tcg_gen_and_i32, 0x08),
> -GEN_CRLOGIC(crandc, tcg_gen_andc_i32, 0x04),
> -GEN_CRLOGIC(creqv, tcg_gen_eqv_i32, 0x09),
> -GEN_CRLOGIC(crnand, tcg_gen_nand_i32, 0x07),
> -GEN_CRLOGIC(crnor, tcg_gen_nor_i32, 0x01),
> -GEN_CRLOGIC(cror, tcg_gen_or_i32, 0x0E),
> -GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D),
> -GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06),
> -
>  #undef GEN_MAC_HANDLER
>  #define GEN_MAC_HANDLER(name, opc2, opc3)                                     \
>  GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_405_MAC)
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index d768a0454d..26b308e435 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -540,6 +540,51 @@ static bool trans_MFCR(DisasContext *ctx, arg_MFCR *a)
>      return true;
>  }
>  
> +static bool cr_logic_common(DisasContext *ctx, arg_X *a,
> +                            void (*tcg_op)(TCGv_i32, TCGv_i32, TCGv_i32))
> +{
> +
> +    uint8_t bitmask;
> +    int sh;
> +    TCGv_i32 t0, t1;
> +    sh = (a->rt & 0x03) - (a->ra & 0x03);
> +    t0 = tcg_temp_new_i32();
> +    if (sh > 0) {
> +        tcg_gen_shri_i32(t0, cpu_crf[a->ra >> 2], sh);
> +    } else if (sh < 0) {
> +        tcg_gen_shli_i32(t0, cpu_crf[a->ra >> 2], -sh);
> +    } else {
> +        tcg_gen_mov_i32(t0, cpu_crf[a->ra >> 2]);
> +    }
> +
> +    t1 = tcg_temp_new_i32();
> +    sh = (a->rt & 0x03) - (a->rb & 0x03);
> +    if (sh > 0) {
> +        tcg_gen_shri_i32(t1, cpu_crf[a->rb >> 2], sh);
> +    } else if (sh < 0) {
> +        tcg_gen_shli_i32(t1, cpu_crf[a->rb >> 2], -sh);
> +    } else {
> +        tcg_gen_mov_i32(t1, cpu_crf[a->rb >> 2]);
> +    }
> +    tcg_op(t0, t0, t1);
> +
> +    bitmask = 0x08 >> (a->rt & 0x03);
> +    tcg_gen_andi_i32(t0, t0, bitmask);
> +    tcg_gen_andi_i32(t1, cpu_crf[a->rt >> 2], ~bitmask);
> +    tcg_gen_or_i32(cpu_crf[a->rt >> 2], t0, t1);
> +
> +    return true;
> +}
> +
> +TRANS(CRAND, cr_logic_common, tcg_gen_and_i32);
> +TRANS(CROR, cr_logic_common, tcg_gen_or_i32);
> +TRANS(CRXOR, cr_logic_common, tcg_gen_xor_i32);
> +TRANS(CRNAND, cr_logic_common, tcg_gen_nand_i32);
> +TRANS(CRNOR, cr_logic_common, tcg_gen_nor_i32);
> +TRANS(CRANDC, cr_logic_common, tcg_gen_andc_i32);
> +TRANS(CREQV, cr_logic_common, tcg_gen_eqv_i32);
> +TRANS(CRORC, cr_logic_common, tcg_gen_orc_i32);
> +
>  static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
>                       bool compute_ov, bool compute_rc0)
>  {


