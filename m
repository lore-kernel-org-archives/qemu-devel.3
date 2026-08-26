Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FEBC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD5G-0005oF-B7; Wed, 26 Aug 2026 08:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzD5B-0005nl-6o; Wed, 26 Aug 2026 08:50:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzD59-0001SH-Bf; Wed, 26 Aug 2026 08:50:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW79F3893912; Wed, 26 Aug 2026 12:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eODb4B
 gNumXh0DM5Hma5ZcsfoFGayDcYWGkSyNRCxzw=; b=AwjZaPS63Vwxju8KcZ5Pch
 MHJolTqJ27ULe3hzpgrCr1FxPvgbIEcNccD03zBIiFQMAphiV3xzbDgsxw3aNN/w
 O9oM+PXtlw0elfGTkEFSvTawNHNgbnHpbLeJmBOaTrPNg6d21OBwUelgWZm24xjA
 3heR39EigFiVuANBTPqyxv58WLKF3oXBQsAwlcMW2hsJyMjJ7tOV5a4BRUL9f2Dk
 2NT98DaEqFKfYbuXDdjNMWCWoCIBQxb7YgYOaTh4aBeEsXJq0kId25aBZRnTrHyc
 bpKjcLy0k0KokOE4pe7UK1Iedtv7dIGozQX/WjfL+m1hrLLFJy35pHUieNFRKFmw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hxrxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:50:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfLaY003033;
 Wed, 26 Aug 2026 12:50:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qa5b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:50:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCoCoC37028186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:50:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32C122004E;
 Wed, 26 Aug 2026 12:50:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A9A02004B;
 Wed, 26 Aug 2026 12:50:09 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 12:50:08 +0000 (GMT)
Date: Wed, 26 Aug 2026 18:20:11 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 16/37] target/ppc: Fix TRANS* macro variadic arguments
 handling
Message-ID: <20260826181944.3417e88d-f2-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-17-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826050923.74756-17-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXyBHPimOVjZ9o
 RklJmiziFaNjcMue2quq/BvWWU0JThD+YhL9lvPv39GVsoRZudeVlb4sLu7zyLvZbQ7f59bqVGI
 eR0yosSsZ9I7LUgSPLMWYNsdBrCgfKc=
X-Proofpoint-GUID: 42UrpxKzY_ulPUV2UUPrFlvdRzjTVY5v
X-Proofpoint-ORIG-GUID: TsheFn4bnClnsbXB2bkEgxBmsve1PxpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX2R7S4EbdKhUZ
 Onuu6dqSx0yXAhQR9JFpoQt/KgLiPmRW+Sp0+/d01KckPTbdAEE9VKyhPj9Fld2tQQUDVWMjDuG
 GDXWgyArhsrvjt+suHTqrM+9IEswUCz35S/wc9Wt3jOVAdiBYBAgkoIxbL1zoRkvHK0SdYBymYW
 0kIgG9eKbvd5ChdXxSlejVQQMOx5ISUFxzPPF+EZ5RccM6rhaEdEjBYUuDfi20aMVa682FAyF/p
 XoCluLeL83EtYTaoJGw1wBvup/K2hNeBij2mGNIDtiDjJ3A0wSK87A3njyXOO4tmHNkLRh8RxmP
 csQmMompvKJA2u45hH5KRGQ5sy6lPRJzRUhmv1AUJzq4UthTyDew7Vw6m8Gm8hBL5SZvMm9lSiO
 8bY0WptwZdvblK5O1vuU+OX2gZEakjbPYeciDhJfKo5V1xWd3ypSVbuo9ulHZbMpy7cKK6nASv7
 PSz4r+PVDikyJpY/IEg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ee109 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=-9IhrnDSo1nYYMnsen4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
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
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Use ##__VA_ARGS__ in TRANS* macros to allow variadic arguments to be
> optional instead of mandatory. "##" removes the preceding comma when
> __VA_ARGS__ is empty, enabling macros to work with functions that don't
> need extra parameters.
> 
> This avoid compilation errors when using a pattern like below:
> 
>   static bool do_wait(DisasContext *ctx, arg_X_wait *a)
>   {...}
> 
>   TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)
> 
> Compilation Error:
> ../target/ppc/translate.c:5526:40: error: expected expression before ‘)’ token
>  5526 |         return FUNC(ctx, a, __VA_ARGS__);                      \
>       |                                        ^
> ../target/ppc/translate/storage-ctrl-impl.c.inc:368:1: note: in expansion of macro ‘TRANS_FLAGS’
>   368 | TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/translate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 7100787a25..f7c7f53d82 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4719,29 +4719,29 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
>   */
>  #define TRANS(NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
> -    { return FUNC(ctx, a, __VA_ARGS__); }
> +    { return FUNC(ctx, a, ##__VA_ARGS__); }
>  #define TRANS_FLAGS(FLAGS, NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
>      {                                                          \
>          REQUIRE_INSNS_FLAGS(ctx, FLAGS);                       \
> -        return FUNC(ctx, a, __VA_ARGS__);                      \
> +        return FUNC(ctx, a, ##__VA_ARGS__);                    \
>      }
>  #define TRANS_FLAGS2(FLAGS2, NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
>      {                                                          \
>          REQUIRE_INSNS_FLAGS2(ctx, FLAGS2);                     \
> -        return FUNC(ctx, a, __VA_ARGS__);                      \
> +        return FUNC(ctx, a, ##__VA_ARGS__);                    \
>      }
>  
>  #define TRANS64(NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
> -    { REQUIRE_64BIT(ctx); return FUNC(ctx, a, __VA_ARGS__); }
> +    { REQUIRE_64BIT(ctx); return FUNC(ctx, a, ##__VA_ARGS__); }
>  #define TRANS64_FLAGS2(FLAGS2, NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
>      {                                                          \
>          REQUIRE_64BIT(ctx);                                    \
>          REQUIRE_INSNS_FLAGS2(ctx, FLAGS2);                     \
> -        return FUNC(ctx, a, __VA_ARGS__);                      \
> +        return FUNC(ctx, a, ##__VA_ARGS__);                    \
>      }
>  
>  /* TODO: More TRANS* helpers for extra insn_flags checks. */
> -- 
> 2.55.0
> 
> 

