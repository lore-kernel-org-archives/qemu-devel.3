Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2221C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVkZ-0005h2-In; Mon, 24 Aug 2026 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVkY-0005go-35; Mon, 24 Aug 2026 10:34:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVkU-0004DU-Cs; Mon, 24 Aug 2026 10:34:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1Yj4085271; Mon, 24 Aug 2026 14:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=mnMmtiQ6NVreIDu0/spJzXG+77U2K+6LXfCdrjiz0IY=; b=KQIuwZpt9lbi
 cO4FSwyQEt8/MHUpqXqRe4vYB+ekiDs1Xpm+bqadmFO5qQQ5R1vcbu5s0aRXPaiy
 oLyBPNa1dCURlYNk/D6DzFEBigjQy4rnu2CJd2HjwvBguo0zAVmJ6BbUFixITAtk
 3WplkmQdIPazaYrEK63U+ORayIIG4KD2/ZSf5m9tljNHvgifxZve03FF+TEZHazU
 pt/daL8Lfzvw1MWx9cce0BI0ho7Ro89f19jDiU2VtA41Bl8+A7a5SZI1/99Y8Po/
 10sC3CyRLQFWCmyrXUYY0DnIl56kOruHBxmpaBLLDlqtSyf4bQCnNop4buNO7XCj
 GgynqGLFuw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhy3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:34:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQGhH029414;
 Mon, 24 Aug 2026 14:34:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pxqb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:34:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEXxH849676564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:34:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB55758056;
 Mon, 24 Aug 2026 14:33:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 042DA58052;
 Mon, 24 Aug 2026 14:33:59 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:33:58 +0000 (GMT)
Message-ID: <56068c494b441f6be03bf20fc8df70b832f67c07.camel@linux.ibm.com>
Subject: Re: [PATCH 09/29] target/ppc: Convert mcrf to decode tree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:33:58 -0500
In-Reply-To: <20260820140114.327023-10-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-10-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zFMpTj-nSavoKZ3owZ31WBjmhb5yH51D
X-Proofpoint-ORIG-GUID: 4ea-vWRlk6n_tuh_KMDIwBMV2B5G3NIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX3Xke7Xg0XeLp
 S8KY0AL1HbWbEFKms/8A/9o3qsiBViv4EiIuOjMnwY/rDRu3e1AA6oLjZbQObc23PU4mukZwsCo
 w2JyTJsYs0vTCMdxZWk7Tn4DqTJUVu6rG45P4jfAZnbDhlmNOeDmV0WzwTC43xObYiozJ/Qhxq+
 odv9JNAhxeYGxHgNZpa8ozsKlBkc8DJPEKDr999ulwpjNnmRTt9iPNfdvBD8wDbLAfQyzgDXwm+
 wjyF25gCiTlEOceB7KXzV7iHdWild0m0Y6kXObNxxA5tP7RGeFXWzds0plXCOUhGhJIWTSDY6rh
 b3gJ2vsC/znaSrS0bYLUy6Wwwrnxo62gDuAa45XXuQnEljNmwkfP8vkF9uDivjkp4jLQKm31NYI
 AYb5GGoFq0QzuQxSe4ley2S2H7uXVDqVMAb8MfdZOwUzjPdAs5XZm0oz6fD8yhxQgSnXaOJO3QQ
 gpoBogTphu7c6PfSNsA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c565b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aE_0g3WlLBe9KuISDJoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXx1GMlr/Bx9ah
 IccYkRgHZS3F25/cOXejkOSfeoIOpe7c89fGSDeTxmRxWHRKOZN2iOTaNwzVx9tYRXLujPBfRug
 x58vgNuNfvDBcGDlg3kTmlU8FFLuGQM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122
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
> From: Shivani Nittor <shivani@linux.ibm.com>
> 
> Convert mcrf to decode tree specification.The functionality
> was tested by comparing the qemu -D log -d op,in_asm output
> as well as single stepping gdb.
> 
> Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode             | 6 ++++++
>  target/ppc/translate.c               | 7 -------
>  target/ppc/translate/misc-impl.c.inc | 6 ++++++
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index af35a44223..7d792d2318 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1455,6 +1455,12 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
>  SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
>  EIEIO           011111 ----- ----- ----- 1101010110 -
>  
> +# Condition Register Field Instruction
> +
> +&XL_bfa         bf bfa
> +@XL_bfa         ...... bf:3 .. bfa:3 .. ..... ..... ..... .
> +MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
> +
>  # Branch History Rolling Buffer (BHRB) Instructions
>  
>  &XFX_bhrbe      rt bhrbe
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f00071aa91..55b515cec7 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3642,12 +3642,6 @@ GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D);
>  /* crxor */
>  GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06);
>  
> -/* mcrf */
> -static void gen_mcrf(DisasContext *ctx)
> -{
> -    tcg_gen_mov_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfS(ctx->opcode)]);
> -}
> -
>  /***                           System linkage                              ***/
>  
>  /* rfi (supervisor only) */
> @@ -5722,7 +5716,6 @@ GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
>  GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
>  GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
>  GEN_HANDLER_E(bctar, 0x13, 0x10, 0x11, 0x0000E000, PPC_NONE, PPC2_BCTAR_ISA207),
> -GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PPC_INTEGER),
>  GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
> diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
> index cbf82b1ea0..890fbb209e 100644
> --- a/target/ppc/translate/misc-impl.c.inc
> +++ b/target/ppc/translate/misc-impl.c.inc
> @@ -155,3 +155,9 @@ static bool trans_ATTN(DisasContext *ctx, arg_ATTN *a)
>      return false;
>  #endif
>  }
> +
> +static bool trans_MCRF(DisasContext *ctx, arg_MCRF *a)
> +{
> +    tcg_gen_mov_i32(cpu_crf[a->bf], cpu_crf[a->bfa]);
> +    return true;
> +}


