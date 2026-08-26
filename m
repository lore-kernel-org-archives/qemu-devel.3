Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D932FC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCcq-0003j2-TD; Wed, 26 Aug 2026 08:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzCco-0003ig-Up; Wed, 26 Aug 2026 08:21:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzCcm-0007RP-L5; Wed, 26 Aug 2026 08:21:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAVXFN3739511; Wed, 26 Aug 2026 12:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=2jsioRxwQWXVl7FESnVo+r/kO/zOE8
 zlj2Tp0uXvNr8=; b=Ls5eTO8NUijUwHb07uZN7awyd+rSA/EXUJoTS3UNd4p+QO
 dLuB5EyLM8v41URHF9T6alIOuwKhVDT+3LGmYHevMgah9nh6hy+Qu1WGHBCaEqHL
 uDggfL3/kgGgj/aFsE5mKqEHfpYsLsjloposxIocjPgGZUzuLuNZZwsg0cBXTN9+
 UOJKKP/YRDbO0Aa44rwT+EFlkDgIOIKtX9yOhS7Ov9pOH1sZwdHro/AgZb26hiXA
 nQSYbs3dGKQWkuEjwS0bcvdtAlt5CprWg3sjaVXLfeFHj7+5HGPBakcDVeQisO5X
 VWsN4ROy3RsXDMUg3Y4fwEpGeXnoIhdVHVePyJwQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xhme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:20:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCF5rd019408;
 Wed, 26 Aug 2026 12:20:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7raghp93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:20:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCKqOr34079088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:20:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2CC22004B;
 Wed, 26 Aug 2026 12:20:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D219620040;
 Wed, 26 Aug 2026 12:20:48 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 12:20:48 +0000 (GMT)
Date: Wed, 26 Aug 2026 17:50:51 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 13/37] target/ppc: Move isync instruction to decodetree.
Message-ID: <20260826175014.a2a12c0d-39-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-14-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-14-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: s4tSPpFB6xbQDl_JsrlwQrFf2yeEOL63
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwMCBTYWx0ZWRfX+YSTyP0ZsmXJ
 cL5mJUgAdT2eShhxQ72dSRdQ39jjhCvgbCMXY1Jsz9dUiCqrwhEXbyoE3Uh7pZ/oQxmdPd3UEEx
 z6yTqE7qNpJ3eatD8Zpyal0a/ZkigFc=
X-Proofpoint-GUID: PywaoRxUtfkb_bx2bC80cGydoA57Bq7R
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8eda29 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=1VKqNc-gu6NC59ff_LEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwMCBTYWx0ZWRfX3+dtu8jQaXQa
 wNTFspWo93bG3An3KuyfSxGblCPfzLDEbONzyZCp6cUWbcGRztBceWFcpUXh47KXYFEf7sBhUYd
 mtAjnoBkAwRfDkbBqjvKy6sF5E4ENhFlkg/3R29PPYxMnYDuGuMKFNJH3aS6NraJ2nWPaT+GWIw
 0IVnoj+UXFhrWLyy01HlBT1KyWOFJcKktCSQqwizMFmXGw8OR+SetB3LZ6YEh3qFnqqwAFmo+AR
 9moFom87PCY3h7Kn34OfQ3iY6xbfx6qvwEMQzOpCOodEGIUfAFfle1EjveJOyeg8JxxwHQzBxxR
 0lT30+VzVeWzMyxcKjtcJZ+QWv6+gzd+QHdznpb3S9JPLEn4BIn+Ib3sL0B08uEp/ugbyxCAzV6
 zpIf3ZBq93UVDqKzjY0Wb/kzRQg+8Rky+nulim11q6TYdu5FpShOaxUZEb+rTY3LjywXnqgJJqa
 eWEox7Q9LXnKANCysjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260100
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
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Moving the following instructions to decodetree specification :
> isync
> 
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.

Nit: Trailing period in subject line. Otherwise,

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                     |  1 +
>  target/ppc/translate.c                       | 15 ---------------
>  target/ppc/translate/storage-ctrl-impl.c.inc | 17 +++++++++++++++++
>  3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index a1c2f549bd..91ece88a70 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1472,6 +1472,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
>  @X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
>  SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
>  EIEIO           011111 ----- ----- ----- 1101010110 -
> +ISYNC           010011 ----- ----- ----- 0010010110 -
>  
>  # Condition Register Field Instruction
>  
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 179cb69dc5..a31cda4490 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2727,20 +2727,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
>  static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
>  #endif
>  
> -/* isync */
> -static void gen_isync(DisasContext *ctx)
> -{
> -    /*
> -     * We need to check for a pending TLB flush. This can only happen in
> -     * kernel mode however so check MSR_PR
> -     */
> -    if (!ctx->pr) {
> -        gen_check_tlb_flush(ctx, false);
> -    }
> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
> -}
> -
>  /* wait */
>  static void gen_wait(DisasContext *ctx)
>  {
> @@ -5377,7 +5363,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
>  GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> -GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>  /* ISA v3.0 changed the extended opcode from 62 to 30 */
>  GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
>  GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
> diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
> index b8b4454663..943229c438 100644
> --- a/target/ppc/translate/storage-ctrl-impl.c.inc
> +++ b/target/ppc/translate/storage-ctrl-impl.c.inc
> @@ -155,6 +155,23 @@ static bool trans_SLBFEE(DisasContext *ctx, arg_SLBFEE *a)
>      return true;
>  }
>  
> +static bool trans_ISYNC(DisasContext *ctx, arg_ISYNC *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, MEM);
> +
> +    /*
> +     * We need to check for a pending TLB flush. This can only happen in
> +     * kernel mode however so check MSR_PR
> +     */
> +    if (!ctx->pr) {
> +        gen_check_tlb_flush(ctx, false);
> +    }
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
> +
> +    return true;
> +}
> +
>  static bool trans_SLBSYNC(DisasContext *ctx, arg_SLBSYNC *a)
>  {
>      REQUIRE_64BIT(ctx);
> -- 
> 2.55.0
> 

