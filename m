Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F09AE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2BJ-0000sM-IO; Tue, 10 Dec 2024 10:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL2B1-0000dt-Nt
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:29:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL2Az-0000P3-9b
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:29:31 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACkV3f014059;
 Tue, 10 Dec 2024 15:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2szg2KQnE3LLCrAdDqyvAF8+w4uL4RRzd+go3VFNtWE=; b=lyHvSQoDSVfDG19A
 6Abg0Q/I3R+wBXFso/ZeSoQDsQrVfR7utEPKVLlAarmrLk+Tt96eMegaFQa3DeLU
 OwEZfU10T59YM3HVYjfmE8iejMKKNm9ABQk4JKBxYxiTVct5pgHBPFHG7foGjwdH
 sKnRcTRhfqRWGKHVzCUdhmIvjDmFCJNc19Q8QbE0TZqw8PsMVToe5L9ldltS3xc9
 yGO4RiUHpE021CqHCXgIpqAqdD1NfbBh6WOPXBdrryddknXwS4lMXWjjoIrIddmq
 C4ELtZF2yLEXOMNgF8DAmuTQBxBiFYLqwX8Nratmx0KbA6AFOoHJWgeb5vhMqy9c
 qSleQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dvyan3j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 15:29:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BAFTJqw022651
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 15:29:19 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 07:29:18 -0800
Message-ID: <8b52c8af-2f85-4849-989d-0e64fa64e635@quicinc.com>
Date: Tue, 10 Dec 2024 09:29:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] target/hexagon: Use float32_muladd for
 helper_sffm[as]_lib
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-12-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Z3V98NDEO3W7ZGcoY3RtbCU3fA9vylQP
X-Proofpoint-ORIG-GUID: Z3V98NDEO3W7ZGcoY3RtbCU3fA9vylQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxlogscore=593 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412100115
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
> There are multiple special cases for this instruction.
> (1) The saturate to normal maximum instead of overflow to infinity is
>      handled by the new float_round_nearest_even_max rounding mode.
> (2) The 0 * n + c special case is handled by the new
>      float_muladd_suppress_add_product_zero flag.
> (3) The Inf - Inf -> 0 special case can be detected after the fact
>      by examining float_flag_invalid_isi.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/op_helper.c | 105 +++++++++----------------------------
>   1 file changed, 26 insertions(+), 79 deletions(-)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index eb010422bf..26e329f7b9 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1171,24 +1171,6 @@ float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,
>       return RxV;
>   }
>   
> -static bool is_zero_prod(float32 a, float32 b)
> -{
> -    return ((float32_is_zero(a) && is_finite(b)) ||
> -            (float32_is_zero(b) && is_finite(a)));
> -}
> -
> -static float32 check_nan(float32 dst, float32 x, float_status *fp_status)
> -{
> -    float32 ret = dst;
> -    if (float32_is_any_nan(x)) {
> -        if (extract32(x, 22, 1) == 0) {
> -            float_raise(float_flag_invalid, fp_status);
> -        }
> -        ret = make_float32(0xffffffff);    /* nan */
> -    }
> -    return ret;
> -}
> -
>   float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
>                            float32 RsV, float32 RtV, float32 PuV)
>   {
> @@ -1210,78 +1192,43 @@ float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
>       return RxV;
>   }
>   
> -static bool is_inf_prod(int32_t a, int32_t b)
> +static float32 do_sffma_lib(CPUHexagonState *env, float32 RxV,
> +                            float32 RsV, float32 RtV, int negate)
>   {
> -    return (float32_is_infinity(a) && float32_is_infinity(b)) ||
> -           (float32_is_infinity(a) && is_finite(b) && !float32_is_zero(b)) ||
> -           (float32_is_infinity(b) && is_finite(a) && !float32_is_zero(a));
> +    int flags;
> +
> +    arch_fpop_start(env);
> +
> +    set_float_rounding_mode(float_round_nearest_even_max, &env->fp_status);
> +    RxV = float32_muladd(RsV, RtV, RxV,
> +                         negate | float_muladd_suppress_add_product_zero,
> +                         &env->fp_status);
> +
> +    flags = get_float_exception_flags(&env->fp_status);
> +    if (flags) {
> +        /* Flags are suppressed by this instruction. */
> +        set_float_exception_flags(0, &env->fp_status);
> +
> +        /* Return 0 for Inf - Inf. */
> +        if (flags & float_flag_invalid_isi) {
> +            RxV = 0;
> +        }
> +    }
> +
> +    arch_fpop_end(env);
> +    return RxV;
>   }
>   
>   float32 HELPER(sffma_lib)(CPUHexagonState *env, float32 RxV,
>                             float32 RsV, float32 RtV)
>   {
> -    bool infinp;
> -    bool infminusinf;
> -    float32 tmp;
> -
> -    arch_fpop_start(env);
> -    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
> -    infminusinf = float32_is_infinity(RxV) &&
> -                  is_inf_prod(RsV, RtV) &&
> -                  (fGETBIT(31, RsV ^ RxV ^ RtV) != 0);
> -    infinp = float32_is_infinity(RxV) ||
> -             float32_is_infinity(RtV) ||
> -             float32_is_infinity(RsV);
> -    RxV = check_nan(RxV, RxV, &env->fp_status);
> -    RxV = check_nan(RxV, RsV, &env->fp_status);
> -    RxV = check_nan(RxV, RtV, &env->fp_status);
> -    tmp = internal_fmafx(RsV, RtV, RxV, 0, &env->fp_status);
> -    if (!(float32_is_zero(RxV) && is_zero_prod(RsV, RtV))) {
> -        RxV = tmp;
> -    }
> -    set_float_exception_flags(0, &env->fp_status);
> -    if (float32_is_infinity(RxV) && !infinp) {
> -        RxV = RxV - 1;
> -    }
> -    if (infminusinf) {
> -        RxV = 0;
> -    }
> -    arch_fpop_end(env);
> -    return RxV;
> +    return do_sffma_lib(env, RxV, RsV, RtV, 0);
>   }
>   
>   float32 HELPER(sffms_lib)(CPUHexagonState *env, float32 RxV,
>                             float32 RsV, float32 RtV)
>   {
> -    bool infinp;
> -    bool infminusinf;
> -    float32 tmp;
> -
> -    arch_fpop_start(env);
> -    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
> -    infminusinf = float32_is_infinity(RxV) &&
> -                  is_inf_prod(RsV, RtV) &&
> -                  (fGETBIT(31, RsV ^ RxV ^ RtV) == 0);
> -    infinp = float32_is_infinity(RxV) ||
> -             float32_is_infinity(RtV) ||
> -             float32_is_infinity(RsV);
> -    RxV = check_nan(RxV, RxV, &env->fp_status);
> -    RxV = check_nan(RxV, RsV, &env->fp_status);
> -    RxV = check_nan(RxV, RtV, &env->fp_status);
> -    float32 minus_RsV = float32_sub(float32_zero, RsV, &env->fp_status);
> -    tmp = internal_fmafx(minus_RsV, RtV, RxV, 0, &env->fp_status);
> -    if (!(float32_is_zero(RxV) && is_zero_prod(RsV, RtV))) {
> -        RxV = tmp;
> -    }
> -    set_float_exception_flags(0, &env->fp_status);
> -    if (float32_is_infinity(RxV) && !infinp) {
> -        RxV = RxV - 1;
> -    }
> -    if (infminusinf) {
> -        RxV = 0;
> -    }
> -    arch_fpop_end(env);
> -    return RxV;
> +    return do_sffma_lib(env, RxV, RsV, RtV, float_muladd_negate_product);
>   }
>   
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
>   float64 HELPER(dfmpyfix)(CPUHexagonState *env, float64 RssV, float64 RttV)

