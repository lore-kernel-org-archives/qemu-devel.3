Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77DDC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVIr-0001pn-9B; Mon, 24 Aug 2026 10:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVIp-0001m4-Dq; Mon, 24 Aug 2026 10:05:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVIn-0003of-FE; Mon, 24 Aug 2026 10:05:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1jsb2004688; Mon, 24 Aug 2026 14:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=9Oza7HW2T8VsAh+2DeQJRhPT5MZm+50Q3JT8L9goF3o=; b=WESenaJhihxK
 /uY8QtLbec+erW4d02dfFvxSigucp7BJ0aOlfOlbRZqhPi766fhZlafimkGFjjie
 MkxV3k+fEBsVOchU0/FLKKGtUhVnWncFy/EuTbNeY3yOPPwLnHQ2bx5tznpmxYBE
 5YC1SjSu7rnn6tblaAzXxczG3v45AEv7FCSUxG4wQFNtbM6opbdJz4N0/TssHBUw
 SIsgiMGl/zEpcJJCVa3JUw7IqT1uyGR0DyLgtUxLAv0dfGnrwbdfN+Rh66W51Cwg
 aG6rDW5oT2njn7/YSSIXoRt2eXvJmjfgPWUuY8RqeGuAx32UFcjb4hmXgAGWPvfH
 adjdd6LhrQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx1m7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:05:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODuHcb030608;
 Mon, 24 Aug 2026 14:05:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag65gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:05:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OE5L5P26214998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:05:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 510C658052;
 Mon, 24 Aug 2026 14:05:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87CBD58056;
 Mon, 24 Aug 2026 14:05:20 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:05:20 +0000 (GMT)
Message-ID: <c5000f4958d15547d7b38e73e2e303ed1740dfd8.camel@linux.ibm.com>
Subject: Re: [PATCH 01/29] target/ppc: Migrate extswsli to decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:05:20 -0500
In-Reply-To: <20260820140114.327023-2-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-2-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX7McOHjZNrx11
 /5eSFYkeygH/BmaqekbTh9QHn+XCE1DZHa6DJQGkLXDIMMy4SsxD4LhZIZ1yocXxLX9E46JBtpA
 D+aJ6MfZv918pGFS5PmqD+k0LR+HJz0=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c4fa5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JUbyXaRwDNOV6VszScEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FYri33XiBZi2Z_KqCyUCnxhxFQO4G6GB
X-Proofpoint-GUID: snrukavX8SLqyMUhLsPglgYQ_9s_YY3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX9fbRWpDiv7L+
 Xx96e+yGGobldam1rF9Q6m+dF2gvK8zIkHv4Au4HZ/zKqri+LAWtVMLuEwWTW+VKAlGFaGHZvMU
 BLU8OcKwBHIZJlywIEbsRxpv+lXdGwdVY5nlREzJ2MDJq07u0EhgEcVTwHB2HbnUfBELtU+OC0y
 woGKy7dytvmT/2cB86EaZSEoRhr5QzSJYHlVDx3M40M5Hza8Eiu9ySDFV7J5HMGpi97L6qjeCWB
 XgodKDw7pyf6OOZYCKBlbxHeaLtVuJVBqDu7AkEiwIKSA05oqZswyAY8FQocHh/KfNuf7mShZ7X
 Psxy5TUGg6Iad7FR0rfeUNtYA1XiFJEjqr8Rc2JQSLMNe4dfmHrGNXmheB9IONfJZViTLgDyBhK
 vLl6lWfdf3nzx6V7fmLjgA0zcT3xEqg0uswtNP1eUtQIr4o7n7/73uz1uisQDnmff92Rwv4JrEP
 rFKq1uDa6SwD3BThCug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240118
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
> From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> 
> Move EXTSWSLI to decodetree using the XS-form layout with a custom
> %xs_sh field to represent the fractured shift encoding.
> 
> This replaces legacy GEN_HANDLER-based implementations with a single
> trans_EXTSWSLI() handler.
> 
> The implementation intentionally operates directly on the destination
> GPR to preserve exact TCG output and avoid introducing temporary
> variables, matching legacy behavior.
> 
> Testing:
>   - Verified TCG equivalence with legacy implementation.
> 
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode |  8 ++++++++
>  target/ppc/translate.c   | 43 ++++++++++++++--------------------------
>  2 files changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 0e9c68f2fb..342e65dadf 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -117,6 +117,11 @@
>  &X_sa_rc        rs ra rc
>  @X_sa_rc        ...... rs:5 ra:5 ..... .......... rc:1          &X_sa_rc
>  
> +# XS-form with fractured shift amount
> +%xs_sh           1:1 11:5
> +&XS              rs ra sh rc
> +@XS              ...... rs:5 ra:5 ..... ......... . rc:1        &XS sh=%xs_sh
> +
>  %x_frtp         22:4 !function=times_2
>  %x_frap         17:4 !function=times_2
>  %x_frbp         12:4 !function=times_2
> @@ -1301,6 +1306,9 @@ XVF64GERPN      111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
>  XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
>  XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
>  
> +##Extend Sign Word and Shift Left Immediate XS-form
> +EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
> +
>  ## Vector Division Instructions
>  
>  VDIVSW          000100 ..... ..... ..... 00110001011    @VX
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 06ed2adf10..e627f48f9e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2470,30 +2470,6 @@ static void gen_sradi1(DisasContext *ctx)
>      gen_sradi(ctx, 1);
>  }
>  
> -/* extswsli & extswsli. */
> -static inline void gen_extswsli(DisasContext *ctx, int n)
> -{
> -    int sh = SH(ctx->opcode) + (n << 5);
> -    TCGv dst = cpu_gpr[rA(ctx->opcode)];
> -    TCGv src = cpu_gpr[rS(ctx->opcode)];
> -
> -    tcg_gen_ext32s_tl(dst, src);
> -    tcg_gen_shli_tl(dst, dst, sh);
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> -        gen_set_Rc0(ctx, dst);
> -    }
> -}
> -
> -static void gen_extswsli0(DisasContext *ctx)
> -{
> -    gen_extswsli(ctx, 0);
> -}
> -
> -static void gen_extswsli1(DisasContext *ctx)
> -{
> -    gen_extswsli(ctx, 1);
> -}
> -
>  /* srd & srd. */
>  static void gen_srd(DisasContext *ctx)
>  {
> @@ -5750,6 +5726,21 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
>      return true;
>  }
>  
> +static bool trans_EXTSWSLI(DisasContext *ctx, arg_XS *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
> +
> +    /* Mimic legacy behavior: operate directly on dst */
> +    tcg_gen_ext32s_tl(cpu_gpr[a->ra], cpu_gpr[a->rs]);
> +    tcg_gen_shli_tl(cpu_gpr[a->ra], cpu_gpr[a->ra], a->sh);
> +
> +    if (unlikely(a->rc)) {
> +        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
> +    }
> +    return true;
> +}
> +
>  #include "translate/fixedpoint-impl.c.inc"
>  
>  #include "translate/fp-impl.c.inc"
> @@ -5850,10 +5841,6 @@ GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
>  GEN_HANDLER2(sradi0, "sradi", 0x1F, 0x1A, 0x19, 0x00000000, PPC_64B),
>  GEN_HANDLER2(sradi1, "sradi", 0x1F, 0x1B, 0x19, 0x00000000, PPC_64B),
>  GEN_HANDLER(srd, 0x1F, 0x1B, 0x10, 0x00000000, PPC_64B),
> -GEN_HANDLER2_E(extswsli0, "extswsli", 0x1F, 0x1A, 0x1B, 0x00000000,
> -               PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER2_E(extswsli1, "extswsli", 0x1F, 0x1B, 0x1B, 0x00000000,
> -               PPC_NONE, PPC2_ISA300),
>  #endif
>  /* handles lfdp, lxsd, lxssp */
>  GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),


