Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A075ACA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu96z-0008Kc-V0; Thu, 04 Sep 2025 08:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uu96y-0008KH-6P; Thu, 04 Sep 2025 08:30:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uu96r-0001yl-CE; Thu, 04 Sep 2025 08:30:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5846H2WC000426;
 Thu, 4 Sep 2025 12:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YewAaO
 I81pZjK3g6/hOSbo1bHK2ctz8k87VJ0kUL/70=; b=s1xXuOX9C5Hbx5hAejkQg9
 YqaDczJs9a/+p9LFyZ1TG+bi+5r69M15RYuZ9jgR1fu3Hkt7SmkIim2LDusaeexE
 DNCcG/v9OYqYx8YIduks0CuIqu+2Z4BxTndzH/uagK2sTW5AA6WrJS+p1BS8FXr4
 FAggYgjMQZyH6Hy9lLtiw1R8Nb6/vQk5GR/OvEleEKj2fxINhjjJ5ftXsDbQ8MLO
 /POG++Q+4XSF1zjgelSIDq3cUt9+jqzz13A+zs8GVDC2IOfdXe9zwrtRiQ4Y8VuQ
 mPy8UPJMiYIcqpVCm/kPcO3gik5UGqAM0ixAue508Qn/4ZhvvLX8FpsGJlU8T0Vg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf5tmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 12:30:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 584CKrUv024840;
 Thu, 4 Sep 2025 12:30:30 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf5tmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 12:30:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58491611014345;
 Thu, 4 Sep 2025 12:30:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3m4mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 12:30:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 584CUSUI25952884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Sep 2025 12:30:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9D1458059;
 Thu,  4 Sep 2025 12:30:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C45565805C;
 Thu,  4 Sep 2025 12:30:24 +0000 (GMT)
Received: from [9.124.217.170] (unknown [9.124.217.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Sep 2025 12:30:24 +0000 (GMT)
Message-ID: <377d87e5-2ce9-4cd5-a1e2-530aea9cac3d@linux.ibm.com>
Date: Thu, 4 Sep 2025 18:00:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/ppc: Add IBM PPE42 special instructions
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org
References: <20250826201920.335308-1-milesg@linux.ibm.com>
 <20250826201920.335308-3-milesg@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20250826201920.335308-3-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bl-MDDAzAB6j_YrQXO0ynG6IfiIgTQmU
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b98667 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=jRLB2SoPAAAA:8
 a=VnNF1IyMAAAA:8 a=KbD8WSA0bXuLjDI5e8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-ORIG-GUID: GH0blw30rC6Qj-UIhN-EBZIccnKiEClR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX3QnG5kxYFle+
 aoCemZev+DR25v9r/q8Fe7MMnx0WiajNm9oDqFYm0a+1ncAfLmSRQxzhhxN7rSzgYJu0C1w8T4C
 87ZHfZjf4j0Gpcagsn/SFYQ5pIzKMjYScVfsSPSaS4RBz3ARy6WgbfLWHs2uOv+kgwCjyTGWe49
 eyAjNTJVfhOhaU+7aREj6gYW2P0LTLMBKn9nxAnpFFTKufXHEXl+lNzomdXIrWJI5HabDX0Qelw
 a6BH88chFK7ew7+sp2AxGcvTnkXH6Joz+Fh0sO/JPW6ovgFVoDxAWYljNVcvpgxxaQ1tE/iYG/j
 R9d+0S16CL5QJcH6DA4DmIHGGEsGdFmr5kKhFth5tWbxGhWjuNZzmKokSQhvJtbvQx+hO+IlZtG
 NoILCeHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 8/27/25 01:47, Glenn Miles wrote:
> Adds the following instructions exclusively for
> IBM PPE42 processors:
>
>    LSKU
>    LCXU
>    STSKU
>    STCXU
>    LVD
>    LVDU
>    LVDX
>    STVD
>    STVDU
>    STVDX
>    SLVD
>    SRVD
>    CMPWBC
>    CMPLWBC
>    CMPWIBC
>    BNBWI
>    BNBW
>    CLRBWIBC
>    CLRWBC
>    DCBQ
>    RLDICL
>    RLDICR
>    RLDIMI
>
> A PPE42 GCC compiler is available here:
> https://github.com/open-power/ppe42-gcc
>
> For more information on the PPE42 processors please visit:
> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   target/ppc/insn32.decode            |  66 ++-
>   target/ppc/translate.c              |  29 +-
>   target/ppc/translate/ppe-impl.c.inc | 805 ++++++++++++++++++++++++++++
>   3 files changed, 890 insertions(+), 10 deletions(-)
>   create mode 100644 target/ppc/translate/ppe-impl.c.inc
>
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index e53fd2840d..8beb588a2a 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -58,6 +58,10 @@
>   %ds_rtp         22:4   !function=times_2
>   @DS_rtp         ...... ....0 ra:5 .............. ..             &D rt=%ds_rtp si=%ds_si
>   
> +%dd_si          3:s13
> +&DD             rt ra si:int64_t
> +@DD             ...... rt:5 ra:5 ............. . ..             &DD si=%dd_si
> +
>   &DX_b           vrt b
>   %dx_b           6:10 16:5 0:1
>   @DX_b           ...... vrt:5  ..... .......... ..... .          &DX_b b=%dx_b
> @@ -66,6 +70,11 @@
>   %dx_d           6:s10 16:5 0:1
>   @DX             ...... rt:5  ..... .......... ..... .           &DX d=%dx_d
>   
> +%md_sh          1:1 11:5
> +%md_mb          5:1 6:5
> +&MD             rs ra sh mb rc
> +@MD             ...... rs:5 ra:5 ..... ...... ... . rc:1        &MD sh=%md_sh mb=%md_mb
> +
>   &VA             vrt vra vrb rc
>   @VA             ...... vrt:5 vra:5 vrb:5 rc:5 ......            &VA
>   
> @@ -322,6 +331,13 @@ LDUX            011111 ..... ..... ..... 0000110101 -   @X
>   
>   LQ              111000 ..... ..... ............ ----    @DQ_rtp
>   
> +LVD             000101 ..... ..... ................     @D
> +LVDU            001001 ..... ..... ................     @D
> +LVDX            011111 ..... ..... ..... 0000010001 -   @X
> +LSKU            111010 ..... ..... ............. 0 11   @DD
> +LCXU            111010 ..... ..... ............. 1 11   @DD
> +
> +
>   ### Fixed-Point Store Instructions
>   
>   STB             100110 ..... ..... ................     @D
> @@ -346,6 +362,11 @@ STDUX           011111 ..... ..... ..... 0010110101 -   @X
>   
>   STQ             111110 ..... ..... ..............10     @DS_rtp
>   
> +STVDU           010110 ..... ..... ................     @D
> +STVDX           011111 ..... ..... ..... 0010010001 -   @X
> +STSKU           111110 ..... ..... ............. 0 11   @DD
> +STCXU           111110 ..... ..... ............. 1 11   @DD
> +
>   ### Fixed-Point Compare Instructions
>   
>   CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
> @@ -461,8 +482,14 @@ PRTYD           011111 ..... ..... ----- 0010111010 -   @X_sa
>   
>   BPERMD          011111 ..... ..... ..... 0011111100 -   @X
>   CFUGED          011111 ..... ..... ..... 0011011100 -   @X
> -CNTLZDM         011111 ..... ..... ..... 0000111011 -   @X
> -CNTTZDM         011111 ..... ..... ..... 1000111011 -   @X
> +{
> +  SLVD            011111 ..... ..... ..... 0000111011 .   @X_rc
> +  CNTLZDM         011111 ..... ..... ..... 0000111011 -   @X
> +}
> +{
> +  SRVD            011111 ..... ..... ..... 1000111011 .   @X_rc
> +  CNTTZDM         011111 ..... ..... ..... 1000111011 -   @X
> +}
>   PDEPD           011111 ..... ..... ..... 0010011100 -   @X
>   PEXTD           011111 ..... ..... ..... 0010111100 -   @X
>   
> @@ -981,8 +1008,16 @@ LXSSP           111001 ..... ..... .............. 11    @DS
>   STXSSP          111101 ..... ..... .............. 11    @DS
>   LXV             111101 ..... ..... ............ . 001   @DQ_TSX
>   STXV            111101 ..... ..... ............ . 101   @DQ_TSX
> -LXVP            000110 ..... ..... ............ 0000    @DQ_TSXP
> -STXVP           000110 ..... ..... ............ 0001    @DQ_TSXP
> +
> +# STVD PPE instruction overlaps with the LXVP and STXVP instructions
> +{
> +  STVD          000110 ..... ..... ................     @D
> +  [
> +    LXVP        000110 ..... ..... ............ 0000    @DQ_TSXP
> +    STXVP       000110 ..... ..... ............ 0001    @DQ_TSXP
> +  ]
> +}
> +
>   LXVX            011111 ..... ..... ..... 0100 - 01100 . @X_TSX
>   STXVX           011111 ..... ..... ..... 0110001100 .   @X_TSX
>   LXVPX           011111 ..... ..... ..... 0101001101 -   @X_TSXP
> @@ -1300,3 +1335,26 @@ CLRBHRB         011111 ----- ----- ----- 0110101110 -
>   ## Misc POWER instructions
>   
>   ATTN            000000 00000 00000 00000 0100000000 0
> +
> +# Fused compare-branch instructions for PPE only
> +%fcb_bdx        1:s10  !function=times_4
> +&FCB            px:bool ra rb:uint64_t bdx lk:bool
> +@FCB            ...... .. px:1 .. ra:5 rb:5 .......... lk:1       &FCB bdx=%fcb_bdx
> +&FCB_bix        px:bool bix ra rb:uint64_t bdx lk:bool
> +@FCB_bix        ...... .. px:1 bix:2 ra:5 rb:5 .......... lk:1    &FCB_bix bdx=%fcb_bdx
> +
> +CMPWBC          000001 00 . .. ..... ..... .......... .     @FCB_bix
> +CMPLWBC         000001 01 . .. ..... ..... .......... .     @FCB_bix
> +CMPWIBC         000001 10 . .. ..... ..... .......... .     @FCB_bix
> +BNBWI           000001 11 . 00 ..... ..... .......... .     @FCB
> +BNBW            000001 11 . 01 ..... ..... .......... .     @FCB
> +CLRBWIBC        000001 11 . 10 ..... ..... .......... .     @FCB
> +CLRBWBC         000001 11 . 11 ..... ..... .......... .     @FCB
> +
> +# Data Cache Block Query for PPE only
> +DCBQ            011111 ..... ..... ..... 0110010110 -       @X
> +
> +# Rotate Doubleword Instructions for PPE only (if TARGET_PPC64 not defined)
> +RLDICL          011110 ..... ..... ..... ...... 000 . .     @MD
> +RLDICR          011110 ..... ..... ..... ...... 001 . .     @MD
> +RLDIMI          011110 ..... ..... ..... ...... 011 . .     @MD
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index fc817dab54..d422789a1d 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -209,6 +209,11 @@ struct DisasContext {
>   #define DISAS_CHAIN        DISAS_TARGET_2  /* lookup next tb, pc updated */
>   #define DISAS_CHAIN_UPDATE DISAS_TARGET_3  /* lookup next tb, pc stale */
>   
> +static inline bool is_ppe(const DisasContext *ctx)
> +{
> +    return !!(ctx->flags & POWERPC_FLAG_PPE42);
> +}
> +
>   /* Return true iff byteswap is needed in a scalar memop */
>   static inline bool need_byteswap(const DisasContext *ctx)
>   {
> @@ -556,11 +561,8 @@ void spr_access_nop(DisasContext *ctx, int sprn, int gprn)
>   
>   #endif
>   
> -/* SPR common to all PowerPC */
> -/* XER */
> -void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
> +static void gen_get_xer(DisasContext *ctx, TCGv dst)
>   {
> -    TCGv dst = cpu_gpr[gprn];
>       TCGv t0 = tcg_temp_new();
>       TCGv t1 = tcg_temp_new();
>       TCGv t2 = tcg_temp_new();
> @@ -579,9 +581,16 @@ void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
>       }
>   }
>   
> -void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
> +/* SPR common to all PowerPC */
> +/* XER */
> +void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
> +{
> +    TCGv dst = cpu_gpr[gprn];
> +    gen_get_xer(ctx, dst);
> +}
> +
> +static void gen_set_xer(DisasContext *ctx, TCGv src)
>   {
> -    TCGv src = cpu_gpr[gprn];
>       /* Write all flags, while reading back check for isa300 */
>       tcg_gen_andi_tl(cpu_xer, src,
>                       ~((1u << XER_SO) |
> @@ -594,6 +603,12 @@ void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
>       tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
>   }
>   
> +void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
> +{
> +    TCGv src = cpu_gpr[gprn];
> +    gen_set_xer(ctx, src);
> +}
> +
>   /* LR */
>   void spr_read_lr(DisasContext *ctx, int gprn, int sprn)
>   {
> @@ -5755,6 +5770,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
>   
>   #include "translate/bhrb-impl.c.inc"
>   
> +#include "translate/ppe-impl.c.inc"
> +
>   /* Handles lfdp */
>   static void gen_dform39(DisasContext *ctx)
>   {
> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
> new file mode 100644
> index 0000000000..98fd794aa4
> --- /dev/null
> +++ b/target/ppc/translate/ppe-impl.c.inc
> @@ -0,0 +1,805 @@
> +/*
> + * IBM PPE Instructions
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +#if !defined(TARGET_PPC64)
> +static bool vdr_is_valid(uint32_t vdr)
> +{
> +    const uint32_t valid_bitmap = 0xf00003ff;
> +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
> +}
> +
> +static bool ppe_gpr_is_valid(uint32_t reg)
> +{
> +    const uint32_t valid_bitmap = 0xf00027ff;
> +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
> +}
> +#endif
> +
> +#define CHECK_VDR(CTX, VDR)                             \
> +    do {                                                \
> +        if (unlikely(!vdr_is_valid(VDR))) {             \
> +            gen_invalid(CTX);                           \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
> +
> +#define CHECK_PPE_GPR(CTX, REG)                         \
> +    do {                                                \
> +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
> +            gen_invalid(CTX);                           \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
> +
> +#define CHECK_VDR(CTX, VDR)                             \
> +    do {                                                \
> +        if (unlikely(!vdr_is_valid(VDR))) {             \
> +            gen_invalid(CTX);                           \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
> +
> +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
> +
> +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
> +    do {                                                \
> +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
> +            gen_invalid(CTX);                           \
> +            return true;                                \
> +        }                                               \
> +    } while (0)
> +
> +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int i;
> +    TCGv base, EA;
> +    TCGv lo, hi;
> +    TCGv_i64 t8;
> +    const uint8_t vd_list[] = {9, 7, 5, 3, 0};
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) || (a->si < 0xB))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    base = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(base, cpu_gpr[a->ra], a->si * 8);
> +    gen_store_spr(SPR_PPE42_EDR, base);
> +
> +    t8 = tcg_temp_new_i64();
> +
> +    tcg_gen_addi_tl(EA, base, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(cpu_gpr[31], cpu_gpr[30], t8);
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(cpu_gpr[29], cpu_gpr[28], t8);
> +
> +    lo = tcg_temp_new();
> +    hi = tcg_temp_new();
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(lo, hi, t8);
> +    gen_store_spr(SPR_SRR0, hi);
> +    gen_store_spr(SPR_SRR1, lo);
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(lo, hi, t8);
> +    gen_set_xer(ctx, hi);
> +    tcg_gen_mov_tl(cpu_ctr, lo);
> +
> +    for (i = 0; i < sizeof(vd_list); i++) {
> +        int vd = vd_list[i];
> +        tcg_gen_addi_tl(EA, EA, -8);
> +        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +        tcg_gen_extr_i64_tl(cpu_gpr[VDR_PAIR_REG(vd)], cpu_gpr[vd], t8);
> +    }
> +
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    tcg_gen_extr_i64_tl(lo, hi, t8);
> +    tcg_gen_shri_tl(hi, hi, 28);
> +    tcg_gen_trunc_tl_i32(cpu_crf[0], hi);
> +    gen_store_spr(SPR_SPRG0, lo);
> +
> +    tcg_gen_addi_tl(EA, base, 4);
> +    tcg_gen_qemu_ld_tl(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], base);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_LSKU(DisasContext *ctx, arg_LSKU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int64_t n;
> +    TCGv base, EA;
> +    TCGv_i32 lo, hi;
> +    TCGv_i64 t8;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) ||
> +                 (a->si & PPC_BIT(0)) || (a->si == 0))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    base = tcg_temp_new();
> +    gen_addr_register(ctx, base);
> +
> +
> +    tcg_gen_addi_tl(base, base, a->si * 8);
> +    gen_store_spr(SPR_PPE42_EDR, base);
> +
> +    n = a->si - 1;
> +    t8 = tcg_temp_new_i64();
> +    if (n > 0) {
> +        tcg_gen_addi_tl(EA, base, -8);
> +        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +        hi = cpu_gpr[30];
> +        lo = cpu_gpr[31];
> +        tcg_gen_extr_i64_i32(lo, hi, t8);
> +    }
> +    if (n > 1) {
> +        tcg_gen_addi_tl(EA, base, -16);
> +        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +        hi = cpu_gpr[28];
> +        lo = cpu_gpr[29];
> +        tcg_gen_extr_i64_i32(lo, hi, t8);
> +    }
> +    tcg_gen_addi_tl(EA, base, 4);
> +    tcg_gen_qemu_ld_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], base);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_STCXU(DisasContext *ctx, arg_STCXU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv EA;
> +    TCGv lo, hi;
> +    TCGv_i64 t8;
> +    int i;
> +    const uint8_t vd_list[] = {9, 7, 5, 3, 0};
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) || !(a->si & PPC_BIT(0)))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], 4);
> +    tcg_gen_qemu_st_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +
> +    gen_store_spr(SPR_PPE42_EDR, cpu_gpr[a->ra]);
> +
> +    t8 = tcg_temp_new_i64();
> +
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[31], cpu_gpr[30]);
> +    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[29], cpu_gpr[28]);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    lo = tcg_temp_new();
> +    hi = tcg_temp_new();
> +
> +    gen_load_spr(hi, SPR_SRR0);
> +    gen_load_spr(lo, SPR_SRR1);
> +    tcg_gen_concat_tl_i64(t8, lo, hi);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    gen_get_xer(ctx, hi);
> +    tcg_gen_mov_tl(lo, cpu_ctr);
> +    tcg_gen_concat_tl_i64(t8, lo, hi);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    for (i = 0; i < sizeof(vd_list); i++) {
> +        int vd = vd_list[i];
> +        tcg_gen_concat_tl_i64(t8, cpu_gpr[VDR_PAIR_REG(vd)], cpu_gpr[vd]);
> +        tcg_gen_addi_tl(EA, EA, -8);
> +        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    }
> +
> +    gen_load_spr(lo, SPR_SPRG0);
> +    tcg_gen_extu_i32_tl(hi, cpu_crf[0]);
> +    tcg_gen_shli_tl(hi, hi, 28);
> +    tcg_gen_concat_tl_i64(t8, lo, hi);
> +    tcg_gen_addi_tl(EA, EA, -8);
> +    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +
> +    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], a->si * 8);
> +    tcg_gen_qemu_st_i32(cpu_gpr[a->rt], EA, ctx->mem_idx, DEF_MEMOP(MO_32) |
> +                                                          MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], EA);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_STSKU(DisasContext *ctx, arg_STSKU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int64_t n;
> +    TCGv base, EA;
> +    TCGv_i32 lo, hi;
> +    TCGv_i64 t8;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_PPE_GPR(ctx, a->rt);
> +
> +    if (unlikely((a->rt != a->ra) || (a->ra == 0) || !(a->si & PPC_BIT(0)))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +
> +    EA = tcg_temp_new();
> +    base = tcg_temp_new();
> +    gen_addr_register(ctx, base);
> +    tcg_gen_addi_tl(EA, base, 4);
> +    tcg_gen_qemu_st_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
> +
> +    gen_store_spr(SPR_PPE42_EDR, base);
> +
> +    n = ~(a->si);
> +
> +    t8 = tcg_temp_new_i64();
> +    if (n > 0) {
> +        hi = cpu_gpr[30];
> +        lo = cpu_gpr[31];
> +        tcg_gen_concat_i32_i64(t8, lo, hi);
> +        tcg_gen_addi_tl(EA, base, -8);
> +        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    }
> +    if (n > 1) {
> +        hi = cpu_gpr[28];
> +        lo = cpu_gpr[29];
> +        tcg_gen_concat_i32_i64(t8, lo, hi);
> +        tcg_gen_addi_tl(EA, base, -16);
> +        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
> +    }
> +
> +    tcg_gen_addi_tl(EA, base, a->si * 8);
> +    tcg_gen_qemu_st_i32(cpu_gpr[a->rt], EA, ctx->mem_idx, DEF_MEMOP(MO_32) |
> +                                                          MO_ALIGN);
> +    tcg_gen_mov_tl(cpu_gpr[a->ra], EA);
> +    return true;
> +#endif
> +}
> +
> +#if !defined(TARGET_PPC64)
> +static bool do_ppe_ldst(DisasContext *ctx, int rt, int ra, TCGv displ,
> +                        bool update, bool store)
> +{
> +    TCGv ea;
> +    int rt_lo;
> +    TCGv_i64 t8;
> +
> +    CHECK_VDR(ctx, rt);
> +    CHECK_PPE_GPR(ctx, ra);
> +    rt_lo = VDR_PAIR_REG(rt);
> +    if (update && (ra == 0 || (!store && ((ra == rt) || (ra == rt_lo))))) {
> +        gen_invalid(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +
> +    ea = do_ea_calc(ctx, ra, displ);
> +    t8 = tcg_temp_new_i64();
> +    if (store) {
> +        tcg_gen_concat_i32_i64(t8, cpu_gpr[rt_lo], cpu_gpr[rt]);
> +        tcg_gen_qemu_st_i64(t8, ea, ctx->mem_idx, DEF_MEMOP(MO_64));
> +    } else {
> +        tcg_gen_qemu_ld_i64(t8, ea, ctx->mem_idx, DEF_MEMOP(MO_64));
> +        tcg_gen_extr_i64_i32(cpu_gpr[rt_lo], cpu_gpr[rt], t8);
> +    }
> +    if (update) {
> +        tcg_gen_mov_tl(cpu_gpr[ra], ea);
> +    }
> +    return true;
> +}
> +#endif
> +
> +static bool trans_LVD(DisasContext *ctx, arg_LVD *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    return do_ppe_ldst(ctx, a->rt, a->ra, tcg_constant_tl(a->si), false, false);
> +#endif
> +}
> +
> +static bool trans_LVDU(DisasContext *ctx, arg_LVDU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    return do_ppe_ldst(ctx, a->rt, a->ra, tcg_constant_tl(a->si), true, false);
> +#endif
> +}
> +
> +static bool trans_LVDX(DisasContext *ctx, arg_LVDX *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    return do_ppe_ldst(ctx, a->rt, a->ra, cpu_gpr[a->rb], false, false);
> +#endif
> +}
> +
> +static bool trans_STVD(DisasContext *ctx, arg_STVD *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    return do_ppe_ldst(ctx, a->rt, a->ra, tcg_constant_tl(a->si), false, true);
> +#endif
> +}
> +
> +static bool trans_STVDU(DisasContext *ctx, arg_STVDU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    return do_ppe_ldst(ctx, a->rt, a->ra, tcg_constant_tl(a->si), true, true);
> +#endif
> +}
> +
> +static bool trans_STVDX(DisasContext *ctx, arg_STVDX *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    return do_ppe_ldst(ctx, a->rt, a->ra, cpu_gpr[a->rb], false, true);
> +#endif
> +}
> +
> +#if !defined(TARGET_PPC64)
> +static bool do_fcb(DisasContext *ctx, TCGv ra_val, TCGv rb_val, int bix,
> +                          int32_t bdx, bool s, bool px, bool lk)
> +{
> +    TCGCond cond;
> +    uint32_t mask;
> +    TCGLabel *no_branch;
> +    target_ulong dest;
> +
> +    /* Update CR0 */
> +    gen_op_cmp32(ra_val, rb_val, s, 0);
> +
> +    if (lk) {
> +        gen_setlr(ctx, ctx->base.pc_next);
> +    }
> +
> +
> +    mask = PPC_BIT32(28 + bix);
> +    cond = (px) ? TCG_COND_TSTEQ : TCG_COND_TSTNE;
> +    no_branch = gen_new_label();
> +    dest = ctx->cia + bdx;
> +
> +    /* Do the branch if CR0[bix] == PX */
> +    tcg_gen_brcondi_i32(cond, cpu_crf[0], mask, no_branch);
> +    gen_goto_tb(ctx, 0, dest);
> +    gen_set_label(no_branch);
> +    gen_goto_tb(ctx, 1, ctx->base.pc_next);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +}
> +#endif
> +
> +#if !defined(TARGET_PPC64)
> +static bool do_cmp_branch(DisasContext *ctx, int ra, TCGv rb_val, int bix,
> +                          int32_t bdx, bool s, bool px, bool lk)
> +{
> +    TCGv old_ra;
> +
> +    CHECK_PPE_GPR(ctx, ra);
> +    if (bix == 3) {
> +        old_ra = tcg_temp_new();
> +        tcg_gen_mov_tl(old_ra, cpu_gpr[ra]);
> +        tcg_gen_sub_tl(cpu_gpr[ra], cpu_gpr[ra], rb_val);
> +        return do_fcb(ctx, old_ra, rb_val, 2,
> +                  bdx, s, px, lk);
> +    } else {
> +        return do_fcb(ctx, cpu_gpr[ra], rb_val, bix,
> +                  bdx, s, px, lk);
> +    }
> +}
> +#endif
> +
> +#if !defined(TARGET_PPC64)
> +static bool do_mask_branch(DisasContext *ctx, int ra, TCGv mask,
> +                          int32_t bdx, bool invert, bool px, bool lk,
> +                          bool update)
> +{
> +    TCGv r;
> +    CHECK_PPE_GPR(ctx, ra);
> +    if (invert) {
> +        tcg_gen_not_tl(mask, mask);
> +    }
> +
> +    /* apply mask to ra */
> +    r = tcg_temp_new();
> +    tcg_gen_and_tl(r, cpu_gpr[ra], mask);
> +    if (update) {
> +        tcg_gen_mov_tl(cpu_gpr[ra], r);
> +    }
> +    return do_fcb(ctx, r, tcg_constant_tl(0), 2,
> +                  bdx, false, px, lk);
> +}
> +#endif
> +
> +static bool trans_CMPWBC(DisasContext *ctx, arg_CMPWBC *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    return do_cmp_branch(ctx, a->ra, cpu_gpr[a->rb], a->bix, a->bdx,
> +                         true, a->px, a->lk);
> +#endif
> +}
> +
> +static bool trans_CMPLWBC(DisasContext *ctx, arg_CMPLWBC *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    return do_cmp_branch(ctx, a->ra, cpu_gpr[a->rb], a->bix, a->bdx,
> +                         false, a->px, a->lk);
> +#endif
> +}
> +
> +static bool trans_CMPWIBC(DisasContext *ctx, arg_CMPWIBC *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    return do_cmp_branch(ctx, a->ra, tcg_constant_tl(a->rb), a->bix, a->bdx,
> +                         true, a->px, a->lk);
> +#endif
> +}
> +
> +static bool trans_BNBWI(DisasContext *ctx, arg_BNBWI *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    return do_mask_branch(ctx, a->ra, tcg_constant_tl(PPC_BIT32(a->rb)),
> +                          a->bdx, false, a->px, a->lk, false);
> +#endif
> +}
> +
> +static bool trans_BNBW(DisasContext *ctx, arg_BNBW *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv mask, shift;
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    mask = tcg_temp_new();
> +    shift = tcg_temp_new();
> +    tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
> +    tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
> +    return do_mask_branch(ctx, a->ra, mask, a->bdx, false, a->px, a->lk, false);
> +#endif
> +}
> +
> +static bool trans_CLRBWIBC(DisasContext *ctx, arg_CLRBWIBC *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    return do_mask_branch(ctx, a->ra, tcg_constant_tl(PPC_BIT32(a->rb)),
> +                          a->bdx, true, a->px, a->lk, true);
> +#endif
> +}
> +
> +static bool trans_CLRBWBC(DisasContext *ctx, arg_CLRBWBC *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv mask, shift;
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    mask = tcg_temp_new();
> +    shift = tcg_temp_new();
> +    tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
> +    tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
> +    return do_mask_branch(ctx, a->ra, mask, a->bdx, true, a->px, a->lk, true);
> +#endif
> +}
> +
> +#if !defined(TARGET_PPC64)
> +static void gen_set_Rc0_i64(DisasContext *ctx, TCGv_i64 reg)
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i32 t = tcg_temp_new_i32();
> +
> +    tcg_gen_movi_i64(t0, CRF_EQ);
> +    tcg_gen_movi_i64(t1, CRF_LT);
> +    tcg_gen_movcond_i64(TCG_COND_LT, t0, reg, tcg_constant_i64(0), t1, t0);
> +    tcg_gen_movi_i64(t1, CRF_GT);
> +    tcg_gen_movcond_i64(TCG_COND_GT, t0, reg, tcg_constant_i64(0), t1, t0);
> +    tcg_gen_extrl_i64_i32(t, t0);
> +    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
> +    tcg_gen_or_i32(cpu_crf[0], cpu_crf[0], t);
> +}
> +#endif
> +
> +#if !defined(TARGET_PPC64)
> +static bool do_shift64(DisasContext *ctx, arg_X_rc *a, bool left)
> +{
> +    int rt_lo, ra_lo;
> +    TCGv_i64 t0, t8;
> +
> +    /* Check for PPE since opcode overlaps with CNTTZDM instruction */
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_VDR(ctx, a->rt);
> +    CHECK_VDR(ctx, a->ra);
> +    CHECK_PPE_GPR(ctx, a->rb);
> +    rt_lo = VDR_PAIR_REG(a->rt);
> +    ra_lo = VDR_PAIR_REG(a->ra);
> +    t8 = tcg_temp_new_i64();
> +
> +    /* AND rt with a mask that is 0 when rb >= 0x40 */
> +    t0 = tcg_temp_new_i64();
> +    tcg_gen_extu_tl_i64(t0, cpu_gpr[a->rb]);
> +    tcg_gen_shli_i64(t0, t0, 0x39);
> +    tcg_gen_sari_i64(t0, t0, 0x3f);
> +
> +    /* form 64bit value from two 32bit regs */
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[rt_lo], cpu_gpr[a->rt]);
> +
> +    /* apply mask */
> +    tcg_gen_andc_i64(t8, t8, t0);
> +
> +    /* do the shift */
> +    tcg_gen_extu_tl_i64(t0, cpu_gpr[a->rb]);
> +    tcg_gen_andi_i64(t0, t0, 0x3f);
> +    if (left) {
> +        tcg_gen_shl_i64(t8, t8, t0);
> +    } else {
> +        tcg_gen_shr_i64(t8, t8, t0);
> +    }
> +
> +    /* split the 64bit word back into two 32bit regs */
> +    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t8);
> +
> +    /* update CR0 if requested */
> +    if (unlikely(a->rc != 0)) {
> +        gen_set_Rc0_i64(ctx, t8);
> +    }
> +    return true;
> +}
> +#endif
> +
> +static bool trans_SRVD(DisasContext *ctx, arg_SRVD *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    return do_shift64(ctx, a, false);
> +#endif
> +}
> +
> +static bool trans_SLVD(DisasContext *ctx, arg_SLVD *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    return do_shift64(ctx, a, true);
> +#endif
> +}
> +
> +static bool trans_DCBQ(DisasContext *ctx, arg_DCBQ *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +
> +    CHECK_PPE_GPR(ctx, a->rt);
> +    CHECK_PPE_GPR(ctx, a->ra);
> +    CHECK_PPE_GPR(ctx, a->rb);
> +
> +    /* No cache exists, so just set RT to 0 */
> +    tcg_gen_movi_tl(cpu_gpr[a->rt], 0);
> +    return true;
> +#endif
> +}
> +
> +static bool trans_RLDIMI(DisasContext *ctx, arg_RLDIMI *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    TCGv_i64 t_rs, t_ra;
> +    int ra_lo, rs_lo;
> +    uint32_t sh = a->sh;
> +    uint32_t mb = a->mb;
> +    uint32_t me = 63 - sh;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_VDR(ctx, a->rs);
> +    CHECK_VDR(ctx, a->ra);
> +
> +    rs_lo = VDR_PAIR_REG(a->rs);
> +    ra_lo = VDR_PAIR_REG(a->ra);
> +
> +    t_rs = tcg_temp_new_i64();
> +    t_ra = tcg_temp_new_i64();
> +
> +    tcg_gen_concat_tl_i64(t_rs, cpu_gpr[rs_lo], cpu_gpr[a->rs]);
> +    tcg_gen_concat_tl_i64(t_ra, cpu_gpr[ra_lo], cpu_gpr[a->ra]);
> +
> +    if (mb <= me) {
> +        tcg_gen_deposit_i64(t_ra, t_ra, t_rs, sh, me - mb + 1);
> +    } else {
> +        uint64_t mask = mask_u64(mb, me);
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +
> +        tcg_gen_rotli_i64(t1, t_rs, sh);
> +        tcg_gen_andi_i64(t1, t1, mask);
> +        tcg_gen_andi_i64(t_ra, t_ra, ~mask);
> +        tcg_gen_or_i64(t_ra, t_ra, t1);
> +    }
> +
> +    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t_ra);
> +
> +    if (unlikely(a->rc != 0)) {
> +        gen_set_Rc0_i64(ctx, t_ra);
> +    }
> +    return true;
> +#endif
> +}
> +
> +
> +#if !defined(TARGET_PPC64)
> +static bool gen_rldinm_i64(DisasContext *ctx, arg_MD *a, int mb, int me, int sh)
> +{
> +    int len = me - mb + 1;
> +    int rsh = (64 - sh) & 63;
> +    int ra_lo, rs_lo;
> +    TCGv_i64 t8;
> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }
> +    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
> +    CHECK_VDR(ctx, a->rs);
> +    CHECK_VDR(ctx, a->ra);
> +
> +    rs_lo = VDR_PAIR_REG(a->rs);
> +    ra_lo = VDR_PAIR_REG(a->ra);
> +    t8 = tcg_temp_new_i64();
> +    tcg_gen_concat_tl_i64(t8, cpu_gpr[rs_lo], cpu_gpr[a->rs]);
> +    if (sh != 0 && len > 0 && me == (63 - sh)) {
> +        tcg_gen_deposit_z_i64(t8, t8, sh, len);
> +    } else if (me == 63 && rsh + len <= 64) {
> +        tcg_gen_extract_i64(t8, t8, rsh, len);
> +    } else {
> +        tcg_gen_rotli_i64(t8, t8, sh);
> +        tcg_gen_andi_i64(t8, t8, mask_u64(mb, me));
> +    }
> +    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t8);
> +    if (unlikely(a->rc != 0)) {
> +        gen_set_Rc0_i64(ctx, t8);
> +    }
> +    return true;
> +}
> +#endif
> +
> +static bool trans_RLDICL(DisasContext *ctx, arg_RLDICL *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    return gen_rldinm_i64(ctx, a, a->mb, 63, a->sh);
> +#endif
> +}
> +
> +static bool trans_RLDICR(DisasContext *ctx, arg_RLDICR *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    return gen_rldinm_i64(ctx, a, 0, a->mb, a->sh);
> +#endif
> +}
> +

Sorry about the formatting error in the last mail, please ignore.

Hey Glenn,

Do you think we can make use of TRANS macros here for insns using the 
common methods. Something like :

TRANS(RLDICL, gen_rldinm_i64, a->mb, 63, a->sh)
TRANS(RLDICR, gen_rldinm_i64, 0, a->mb, a->sh)

And then have gen_rldinm_i64 like :

static bool gen_rldinm_i64(...)
{

#if defined(TARGET_PPC64)
     return false;
#else
     ...
     ...
#endif
}

Similarlly for other insns above where possible ?
Or is there something that I'm not seeing that prevents this ??

Thanks,
Chinmay

