Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513DEC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz88x-0002mg-C7; Wed, 26 Aug 2026 03:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wz88v-0002lz-J4; Wed, 26 Aug 2026 03:33:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wz88t-0008Tv-PI; Wed, 26 Aug 2026 03:33:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6VfOK3101899; Wed, 26 Aug 2026 07:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=N/JX7FJd1fyaj/Kz4GWOFdTHBSFc2S
 y4q81Ze7gzxKI=; b=npqQ42zEjalI6Knv5RQxnjgyK7qf3z3DgaailwP2dWdA6J
 2rNw4kcfJfhUKsytEnGS+UESg82RE0bd8IXPODVwQp9ixotsOOuq7Y97ItGeaylw
 Rfk4oPWX6Zo8At4+HP1FpWHvBi04lPJ0/3xzOUIn4KQBPKg82HVxNsKWtA5BVdVE
 ZRRQfYHRLInS3Zc/3vDLapg5EbChRsb5lF0YKQNhasIiUx4hsgfSH0J3TV/BunWA
 yMx19u5oMFI7OCDbIX8lnurHkb96x5kgdGeMQhIyx0AUxNtgpETvB1untlozN8kO
 qAkkjeDj71/9Zd9PPkJ38do2fbGI4m0jMg/Q7kkQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hwb91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 07:33:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q7QIRb001093;
 Wed, 26 Aug 2026 07:33:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q8x7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 07:33:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q7Xgmn38207938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 07:33:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA32D20043;
 Wed, 26 Aug 2026 07:33:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97F262004F;
 Wed, 26 Aug 2026 07:33:39 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 07:33:39 +0000 (GMT)
Date: Wed, 26 Aug 2026 13:03:41 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 01/37] target/ppc: Migrate extswsli to decodetree
Message-ID: <20260826125508.9fd22ade-b1-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-2-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-2-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfX9QewcfHGYkWo
 nRkMVF8e8/sR5i8/L8XeGNEDItMsU8XeCZ3MM5PAuzDOM10Q1Yz9Jfr8jvxC1ZEY6ZKvUvBewKB
 5FOYZfXOMSaiTN/PHJGkaVDHsCcjt8w=
X-Proofpoint-GUID: UQkcpnre7vdzWBbaD2vBTBeCgyZDBA1v
X-Proofpoint-ORIG-GUID: dMcmpuu1A5MmScxQQkKlgzq-TqXvA21W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2MSBTYWx0ZWRfXzh8TX91vJUcN
 0AmLbCLLMTv9F+QTksNJDbhpS1aK0nWWbGUHvchcB0zDfVVTzTLSPNB6pTuN9nHUreVt/BmeTqk
 T0J0sPdKGC44Ld82EIm+l7wZWRUjxLC54jcApOAZMWxTVNb5OtL3B/qrFLFr6degqiHx8Z9j3Ri
 bHzg60G/KEAsFNtfgCWQL2t6RXTS8PdP4PEIiA3dRYY6eEfP77aiBMs/Wcdur2bcbRITPwkUtoO
 EMMGanmyTTX8gKJb/0OKW/DmgDO6jf4m4ST54bfI2Dm3wScEtq3W5MFqjDtlClvolM8BTl8pQGt
 4m84s1pmDUrWr2riYjsDa3xaUICQESbp8LY+w8y3RLpzbydgmOw0w0/SbFzz3fsqrSi7hsXtTlP
 JCRz7lylg3Yf8NqwgVdilQqNPQ0T3uCFCjATX7kvmGsyqiCK8OIj/xXcAyng69vchlZePZ4zU9t
 jA2LR3PULoMn5nv9gkg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8e96db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=6ppuHksS41P94sLXCEoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260061
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/26 10:38 AM, Chinmay Rath wrote:
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
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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

TRANS64_FLAGS2 exists and could technically be used here, but it would
require splitting into a do_extswsli helper + a macro expansion, adding
an extra indirection with no benefit since the logic is unique to
EXTSWSLI and not shared with any other instruction. The hand-written
trans_EXTSWSLI looks the right choice.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

