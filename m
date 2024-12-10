Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0388E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 02:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKpeV-0002Ca-B0; Mon, 09 Dec 2024 21:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpeQ-0002CF-2m
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 21:07:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpeO-0004RO-E1
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 21:07:01 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9E6kFF006932;
 Tue, 10 Dec 2024 02:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pf/mwR0ese7wEBBtLOwR9UyGOul2ytgCOGBdYJ7xV2Y=; b=XL59HyUAkqkmD0jn
 p69PBp/gKrgI936ZddXLVotebjsI7QqYgCfmndJrKCQ9pEYsf9xexAxDfwXQ1nTE
 lz6dv0UJYtizJpx7bIx+swu912nQQSwdaMiwHXHTMnj0+0El/aDtesYJn9F9z3cl
 67aRA02IS9ze9HP6OoW+h5Q3Qi3Piy/pV0lDp39aU3UFnPjES7tqbVKKf06G1vy1
 Ii7HkJFngMOpRc5A3BgrRCTDriv4kigQJxXVxQIaX3tbDpB3uEO8HPdO4DttMWFb
 FVUHSPguEq2eQtsKfhfnyUuXke42sw49FAG59UxGp6b2GZUaQiK4gHLe4MRbTVKk
 RMYXoQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e21bhr4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 02:06:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA26pg5006181
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 02:06:51 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 18:06:50 -0800
Message-ID: <a1291bcf-1521-4996-a800-d3f77bc3073d@quicinc.com>
Date: Mon, 9 Dec 2024 20:06:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] target/hexagon: Use mulu64 for int128_mul_6464
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-17-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: CJOp3tc_9RuPsbyvStNWvSvYS_xauLci
X-Proofpoint-ORIG-GUID: CJOp3tc_9RuPsbyvStNWvSvYS_xauLci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=542 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100013
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 12/8/2024 4:48 PM, Richard Henderson wrote:
> No need to open-code 64x64->128-bit multiplication.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/fma_emu.c | 32 +++-----------------------------
>   1 file changed, 3 insertions(+), 29 deletions(-)
>
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> index 343c40a686..6749538c09 100644
> --- a/target/hexagon/fma_emu.c
> +++ b/target/hexagon/fma_emu.c
> @@ -82,38 +82,12 @@ int32_t float32_getexp(float32 f32)
>       return -1;
>   }
>   
> -static uint32_t int128_getw0(Int128 x)
> -{
> -    return int128_getlo(x);
> -}
> -
> -static uint32_t int128_getw1(Int128 x)
> -{
> -    return int128_getlo(x) >> 32;
> -}
> -
>   static Int128 int128_mul_6464(uint64_t ai, uint64_t bi)
>   {
> -    Int128 a, b;
> -    uint64_t pp0, pp1a, pp1b, pp1s, pp2;
> +    uint64_t l, h;
>   
> -    a = int128_make64(ai);
> -    b = int128_make64(bi);
> -    pp0 = (uint64_t)int128_getw0(a) * (uint64_t)int128_getw0(b);
> -    pp1a = (uint64_t)int128_getw1(a) * (uint64_t)int128_getw0(b);
> -    pp1b = (uint64_t)int128_getw1(b) * (uint64_t)int128_getw0(a);
> -    pp2 = (uint64_t)int128_getw1(a) * (uint64_t)int128_getw1(b);
> -
> -    pp1s = pp1a + pp1b;
> -    if ((pp1s < pp1a) || (pp1s < pp1b)) {
> -        pp2 += (1ULL << 32);
> -    }
> -    uint64_t ret_low = pp0 + (pp1s << 32);
> -    if ((ret_low < pp0) || (ret_low < (pp1s << 32))) {
> -        pp2 += 1;
> -    }
> -
> -    return int128_make128(ret_low, pp2 + (pp1s >> 32));
> +    mulu64(&l, &h, ai, bi);
> +    return int128_make128(l, h);
>   }

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   
>   static Int128 int128_sub_borrow(Int128 a, Int128 b, int borrow)

