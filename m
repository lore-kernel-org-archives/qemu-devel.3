Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD95FCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWuY-00075D-VI; Tue, 13 Oct 2026 03:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xGWuX-00074e-A0; Tue, 13 Oct 2026 03:26:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xGWuU-0000aE-JE; Tue, 13 Oct 2026 03:26:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D2F2Yf1892967; Tue, 13 Oct 2026 07:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G9a3MX
 fukH7n3hAnxTgb36RdKHfnVzDaM4ByOEfOr8w=; b=Tjp5SyARPOgJsGaAn3RGmQ
 Ni13jHx1hn8I9wsK4jbDbJHP1vc7slDmlyCTfDQJVobrboL3+RORWIhHLqGWOwWq
 BowgCqV6r5IZYNBjMB/g8ROR3ep73q0UKib/QVfpy10iZyNxhBm35YO+R64M+htY
 y+bOk36Ne9WsBY3zjhPzc4pDX3NX1vKmed6AF6sP1GMVQ5DtAPEFuZZbpCMyBn3W
 Q0grdhc8MciMjAEKO7C2gcr/mYwuAr2lRduYpwuAZm2XIipaFkk+zJR0cFLSqlcu
 NCxDbA9LOjfw+yyb8N1Kf/F3yT12DhAK/itw3GGe1oYvDkr7y1hZTBkz14JfVKPA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3cp97-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 07:26:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D7K83b2295602; Tue, 13 Oct 2026 07:26:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h0m45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 07:26:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69D7Qlj729688428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 07:26:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B0AF58059;
 Tue, 13 Oct 2026 07:26:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A72A58061;
 Tue, 13 Oct 2026 07:26:44 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 07:26:43 +0000 (GMT)
Message-ID: <e04f44f4-a86a-41f6-9d09-0c08a26cac89@linux.ibm.com>
Date: Tue, 13 Oct 2026 12:56:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/ppc: Split the ISA 2.05 instruction feature
 group
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20261006094921.110871-1-bin.meng@processmission.com>
 <20261006094921.110871-13-bin.meng@processmission.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20261006094921.110871-13-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cc5SRUg6BqyqvUJTGBq7M10B0X72T5-5
X-Proofpoint-ORIG-GUID: EEUhudErAii2wjy_hRHCqrUFIfrxNi0I
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acddd3a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=FRSEYCzRAAAA:8
 a=xZX0-5J-fjlRuG5LxAQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyOCBTYWx0ZWRfX2W+Mgqd+azqg
 +0eJgA3BvmJiB06yWPdN2k1ZL6bmaGJDYYHybf52SQVhc1+5qgsXTFT6iKsAdsW7RMRyVQEFrlT
 42kj8zLuHcwJvuY7uA7y96HTUev/HYo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyOCBTYWx0ZWRfX8vnFxQtu8agl
 ufC1DOWWPOZ4av/uVKwtudES5vIpJjMV26/fvorZlkXipA8vQOUX6ImOhwckFqdopexRIQ30fjq
 UEroz82Tq0vyu6S2YRtYRBV+2UDaIc7aWkA2nNBC+uoW/9icRvl9qfghtWiAi0riNn7tLlXnvb9
 4RRWkK9KG+Px1vIm2M9gRvq2kJKYU1n4V1cRJbQ1/i4lkKHfx6CwaOxOpUg6KyIQfR8nQf3u7nv
 gj52M66BKChFJYAIBrySojH/hBr5jAUtxHJKjZf1vpJoDRLO1+JQYmkRX2Bmw9fXfzykKoegqmp
 5XqEf7OImLFm7gga0I4P74yV2kT0+aOpzk6AbMhqbCmSnP5u0twIby6hVlosWI3vpyWs3nDZoTU
 ZiHhmgwfPJvNYK7daoHPqoQnQq7PIMroqJkxaUBRrLmSLg+4WIOv7Jn38f77chC8S1y/U1XraV4
 L/4Fep1+xkj2v0wfLsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130028
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/6/26 15:19, Bin Meng wrote:
> The ISA 2.05 flag couples integer instructions to floating-point
> instructions and extended FPSCR access. The e5500 and e6500 implement
> cmpb and parity instructions but lack these floating-point features,
> so enabling the entire group cannot describe their hardware.
>
> Give byte comparison, parity, copy sign, integer word loads, paired
> floating-point transfers and extended FPSCR access separate flags.
> Keep the existing capabilities of POWER7 and later models, and include
> all new flags in the TCG supported instruction mask.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
>   target/ppc/cpu.h                           | 20 ++++++++++++++++----
>   target/ppc/cpu_init.h                      |  5 ++++-
>   target/ppc/cpu_init.c                      | 10 ++++++++--
>   target/ppc/translate.c                     | 10 ++++++----
>   target/ppc/translate/fixedpoint-impl.c.inc |  6 +++---
>   target/ppc/translate/fp-impl.c.inc         |  8 ++++----
>   target/ppc/translate/fp-ops.c.inc          |  9 ++++++---
>   7 files changed, 47 insertions(+), 21 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b716ccf540..78fa4653fb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2568,8 +2568,8 @@ enum {
>       PPC2_PRCNTL        = 0x0000000000000008ULL,
>       /* Byte-reversed, indexed, double-word load and store                    */
>       PPC2_DBRX          = 0x0000000000000010ULL,
> -    /* Book I 2.05 PowerPC specification                                     */
> -    PPC2_ISA205        = 0x0000000000000020ULL,
> +    /* ISA 2.05 cmpb */
> +    PPC2_CMPB_ISA205   = 0x0000000000000020ULL,
>       /* POWER ISA 2.07                                                        */
>       PPC2_ISA207        = 0x0000000000000040ULL,
>       /* ISA 2.06B bpermd                                                      */
> @@ -2602,15 +2602,27 @@ enum {
>       PPC2_PPE42X        = 0x0000000000100000ULL,
>       /* PPE42XM instructions                                                  */
>       PPC2_PPE42XM       = 0x0000000000200000ULL,
> +    /* ISA 2.05 prtyw and prtyd */
> +    PPC2_PRTY_ISA205   = 0x0000000000800000ULL,
Hey,
You have skipped a bit in the flag here. PPC2_PRTY_ISA205 flag should 
be  0x0000000000400000ULL instead of 0x0000000000800000ULL.
> +    /* ISA 2.05 fcpsgn */
> +    PPC2_FCPSGN_ISA205 = 0x0000000001000000ULL,
> +    /* ISA 2.05 lfiwax */
> +    PPC2_LFIWAX_ISA205 = 0x0000000002000000ULL,
> +    /* ISA 2.05 floating-point pair loads and stores */
> +    PPC2_FP_PAIR_ISA205 = 0x0000000004000000ULL,
> +    /* ISA 2.05 FPSCR access through the W and L fields */
> +    PPC2_FPSCR_EXT_ISA205 = 0x0000000008000000ULL,
Please keep the '=' sign in the flag definitions aligned so as to help 
prevent error as the one pointed out above.
While we are at it, please keep the comment end '*/' aligned as well.

Thanks,
Chinmay
>   
>   #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
> -                        PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
> +                        PPC2_CMPB_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
>                           PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
>                           PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_DFP | \
>                           PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
>                           PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
>                           PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
> -                        PPC2_PPE42XM)
> +                        PPC2_PPE42XM | PPC2_PRTY_ISA205 | \
> +                        PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 | \
> +                        PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205)
>   };
>   
>   /*****************************************************************************/
> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
> index 4ba559d8af..e70f1baa74 100644
> --- a/target/ppc/cpu_init.h
> +++ b/target/ppc/cpu_init.h
> @@ -17,7 +17,10 @@
>   #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
>       (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
>        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
> -     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_ISA205 |         \
> +     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
> +     PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205 |                          \
> +     PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 |                      \
> +     PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205 |                   \
>        PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |                   \
>        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
>   
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 5077f3300e..f2a342b076 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6220,7 +6220,10 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, const void *data)
>                          PPC_SEGMENT_64B | PPC_SLBI |
>                          PPC_POPCNTB | PPC_POPCNTWD |
>                          PPC_CILDST;
> -    pcc->insns_flags2 = PPC2_VSX | PPC2_DFP | PPC2_DBRX | PPC2_ISA205 |
> +    pcc->insns_flags2 = PPC2_VSX | PPC2_DFP | PPC2_DBRX |
> +                        PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205 |
> +                        PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 |
> +                        PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205 |
>                           PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>                           PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
>                           PPC2_FP_TST_ISA206 | PPC2_FP_CVT_S64 |
> @@ -6381,7 +6384,10 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
>       pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
>                           PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>                           PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> -                        PPC2_FP_TST_ISA206 | PPC2_ISA205 | PPC2_FP_CVT_S64 |
> +                        PPC2_FP_TST_ISA206 | PPC2_FP_CVT_S64 |
> +                        PPC2_CMPB_ISA205 | PPC2_PRTY_ISA205 |
> +                        PPC2_FCPSGN_ISA205 | PPC2_LFIWAX_ISA205 |
> +                        PPC2_FP_PAIR_ISA205 | PPC2_FPSCR_EXT_ISA205 |
>                           PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
>                           PPC2_BCDA_ISA206;
>       pcc->msr_mask = (1ull << MSR_SF) |
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 467b8f3d4e..c00581fc36 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4403,7 +4403,7 @@ static bool trans_ICBIEP(DisasContext *ctx, arg_X_ea *a)
>   static void gen_dform39(DisasContext *ctx)
>   {
>       if ((ctx->opcode & 0x3) == 0) {
> -        if (ctx->insns_flags2 & PPC2_ISA205) {
> +        if (ctx->insns_flags2 & PPC2_FP_PAIR_ISA205) {
>               return gen_lfdp(ctx);
>           }
>       }
> @@ -4415,7 +4415,7 @@ static void gen_dform3D(DisasContext *ctx)
>   {
>       if ((ctx->opcode & 3) == 0) { /* DS-FORM */
>           /* stfdp */
> -        if (ctx->insns_flags2 & PPC2_ISA205) {
> +        if (ctx->insns_flags2 & PPC2_FP_PAIR_ISA205) {
>               return gen_stfdp(ctx);
>           }
>       }
> @@ -4429,9 +4429,11 @@ GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
>   GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
>   GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>   /* handles lfdp, lxsd, lxssp */
> -GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
> +GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000,
> +              PPC_NONE, PPC2_FP_PAIR_ISA205),
>   /* handles stfdp, stxsd, stxssp */
> -GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
> +GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000,
> +              PPC_NONE, PPC2_FP_PAIR_ISA205),
>   GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
>   GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
>   GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index c3d8bbf267..0c6ec91400 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -1545,7 +1545,7 @@ static bool trans_XOR(DisasContext *ctx, arg_XOR *a)
>   
>   static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
>   {
> -    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
> +    REQUIRE_INSNS_FLAGS2(ctx, CMPB_ISA205);
>       gen_helper_CMPB(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
>       return true;
>   }
> @@ -1636,7 +1636,7 @@ static bool trans_PRTYW(DisasContext *ctx, arg_PRTYW *a)
>       TCGv rs = cpu_gpr[a->rs];
>       TCGv t0 = tcg_temp_new();
>   
> -    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
> +    REQUIRE_INSNS_FLAGS2(ctx, PRTY_ISA205);
>       tcg_gen_shri_tl(t0, rs, 16);
>       tcg_gen_xor_tl(ra, rs, t0);
>       tcg_gen_shri_tl(t0, ra, 8);
> @@ -1652,7 +1652,7 @@ static bool trans_PRTYD(DisasContext *ctx, arg_PRTYD *a)
>       TCGv t0 = tcg_temp_new();
>   
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
> +    REQUIRE_INSNS_FLAGS2(ctx, PRTY_ISA205);
>       tcg_gen_shri_tl(t0, rs, 32);
>       tcg_gen_xor_tl(ra, rs, t0);
>       tcg_gen_shri_tl(t0, ra, 16);
> diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
> index e0d9fa2e24..fef770368a 100644
> --- a/target/ppc/translate/fp-impl.c.inc
> +++ b/target/ppc/translate/fp-impl.c.inc
> @@ -324,7 +324,7 @@ TRANS(FNABS, do_move_b, 1ULL << 63, tcg_gen_ori_i64);
>   static bool trans_FCPSGN(DisasContext *ctx, arg_FCPSGN *a)
>   {
>       TCGv_i64 t0, t1, t2;
> -    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
> +    REQUIRE_INSNS_FLAGS2(ctx, FCPSGN_ISA205);
>       REQUIRE_FPU(ctx);
>       t0 = tcg_temp_new_i64();
>       t1 = tcg_temp_new_i64();
> @@ -592,13 +592,13 @@ static void gen_mtfsf(DisasContext *ctx)
>       flm = FPFLM(ctx->opcode);
>       l = FPL(ctx->opcode);
>       w = FPW(ctx->opcode);
> -    if (unlikely(w & !(ctx->insns_flags2 & PPC2_ISA205))) {
> +    if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
>           gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>           return;
>       }
>       if (!l) {
>           t0 = tcg_constant_i32(flm << (w * 8));
> -    } else if (ctx->insns_flags2 & PPC2_ISA205) {
> +    } else if (ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205) {
>           t0 = tcg_constant_i32(0xffff);
>       } else {
>           t0 = tcg_constant_i32(0xff);
> @@ -627,7 +627,7 @@ static void gen_mtfsfi(DisasContext *ctx)
>       }
>       w = FPW(ctx->opcode);
>       bf = FPBF(ctx->opcode);
> -    if (unlikely(w & !(ctx->insns_flags2 & PPC2_ISA205))) {
> +    if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
>           gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>           return;
>       }
> diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
> index 9bc9c3a3c3..e6a0d88dd4 100644
> --- a/target/ppc/translate/fp-ops.c.inc
> +++ b/target/ppc/translate/fp-ops.c.inc
> @@ -1,14 +1,17 @@
>   GEN_HANDLER_E(lfdepx, 0x1F, 0x1F, 0x12, 0x00000001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001, PPC_NONE, PPC2_ISA205),
> +GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001,
> +              PPC_NONE, PPC2_LFIWAX_ISA205),
>   GEN_HANDLER_E(lfiwzx, 0x1f, 0x17, 0x1b, 0x1, PPC_NONE, PPC2_FP_CVT_ISA206),
> -GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001, PPC_NONE, PPC2_ISA205),
> +GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001,
> +              PPC_NONE, PPC2_FP_PAIR_ISA205),
>   
>   #define GEN_STXF(name, stop, opc2, opc3, type)                                \
>   GEN_HANDLER(name##x, 0x1F, opc2, opc3, 0x00000001, type),
>   
>   GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
>   GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
> +GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001,
> +              PPC_NONE, PPC2_FP_PAIR_ISA205),
>   
>   GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
>   GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),

