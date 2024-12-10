Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCECE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 21:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL8Ak-0002rw-Ed; Tue, 10 Dec 2024 16:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL8Ai-0002rI-Fg
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:53:36 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL8Ag-0000Xv-IO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:53:36 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAH53vp024799;
 Tue, 10 Dec 2024 21:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vmtn+LcxCVXVWUSqiloT7nkHZx6vEkBM1M/xRUneCpI=; b=JCkS825jya5EbWEy
 JOL2EGRc+4XIkI2OhjVnnp0MntReyoHZpCYA39ECyAr7D2yYsCXGeOWM98s6ATQv
 InDD3/N5gmJxx4h1YR0QCFC+zs3zrxc3MmwaIM4R4CfTNadVkhwoipj+2AEqX08u
 xKF8M104NKP3s7hkcNV2XaG521cPz7C1L8G5IX2WacLaNQELfdnOR0cL44gY728F
 bTmOjmTKGunA8hhD/2L2W3b8b9nA88sUlstBx1Q1ufjGppcIAEE4rcxE7+B6Q7rs
 iDT1Soo0wbZlnTbn1QrgxgzONKYCXW/QSm9WNqNA6h4kbdKthZhpwVQFVUQKB6Rk
 Tpcc9w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgswc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 21:53:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BALrQ6M032071
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 21:53:26 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 13:53:24 -0800
Message-ID: <874af98c-f536-453d-80f2-391b5f67efe9@quicinc.com>
Date: Tue, 10 Dec 2024 15:53:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] target/hexagon: Expand GEN_XF_ROUND
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-14-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: PLZGJLnHYzVAFEbNHsYBYYAHTr6AEA_F
X-Proofpoint-ORIG-GUID: PLZGJLnHYzVAFEbNHsYBYYAHTr6AEA_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=981 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100156
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
> This massive macro is now only used once.
> Expand it for use only by float64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/fma_emu.c | 253 +++++++++++++++++++--------------------
>   1 file changed, 125 insertions(+), 128 deletions(-)
>
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> index 0c7c7f636c..bce3bd4dfb 100644
> --- a/target/hexagon/fma_emu.c
> +++ b/target/hexagon/fma_emu.c
> @@ -354,136 +354,133 @@ float32 infinite_float32(uint8_t sign)
>   }
>   
>   /* Return a maximum finite value with the requested sign */
> -#define GEN_XF_ROUND(SUFFIX, MANTBITS, INF_EXP, INTERNAL_TYPE) \
> -static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
> -{ \
> -    if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0) \
> -        && ((a.guard | a.round | a.sticky) == 0)) { \
> -        /* result zero */ \
> -        switch (fp_status->float_rounding_mode) { \
> -        case float_round_down: \
> -            return zero_##SUFFIX(1); \
> -        default: \
> -            return zero_##SUFFIX(0); \
> -        } \
> -    } \
> -    /* Normalize right */ \
> -    /* We want MANTBITS bits of mantissa plus the leading one. */ \
> -    /* That means that we want MANTBITS+1 bits, or 0x000000000000FF_FFFF */ \
> -    /* So we need to normalize right while the high word is non-zero and \
> -    * while the low word is nonzero when masked with 0xffe0_0000_0000_0000 */ \
> -    while ((int128_gethi(a.mant) != 0) || \
> -           ((int128_getlo(a.mant) >> (MANTBITS + 1)) != 0)) { \
> -        a = accum_norm_right(a, 1); \
> -    } \
> -    /* \
> -     * OK, now normalize left \
> -     * We want to normalize left until we have a leading one in bit 24 \
> -     * Theoretically, we only need to shift a maximum of one to the left if we \
> -     * shifted out lots of bits from B, or if we had no shift / 1 shift sticky \
> -     * should be 0  \
> -     */ \
> -    while ((int128_getlo(a.mant) & (1ULL << MANTBITS)) == 0) { \
> -        a = accum_norm_left(a); \
> -    } \
> -    /* \
> -     * OK, now we might need to denormalize because of potential underflow. \
> -     * We need to do this before rounding, and rounding might make us normal \
> -     * again \
> -     */ \
> -    while (a.exp <= 0) { \
> -        a = accum_norm_right(a, 1 - a.exp); \
> -        /* \
> -         * Do we have underflow? \
> -         * That's when we get an inexact answer because we ran out of bits \
> -         * in a denormal. \
> -         */ \
> -        if (a.guard || a.round || a.sticky) { \
> -            float_raise(float_flag_underflow, fp_status); \
> -        } \
> -    } \
> -    /* OK, we're relatively canonical... now we need to round */ \
> -    if (a.guard || a.round || a.sticky) { \
> -        float_raise(float_flag_inexact, fp_status); \
> -        switch (fp_status->float_rounding_mode) { \
> -        case float_round_to_zero: \
> -            /* Chop and we're done */ \
> -            break; \
> -        case float_round_up: \
> -            if (a.sign == 0) { \
> -                a.mant = int128_add(a.mant, int128_one()); \
> -            } \
> -            break; \
> -        case float_round_down: \
> -            if (a.sign != 0) { \
> -                a.mant = int128_add(a.mant, int128_one()); \
> -            } \
> -            break; \
> -        default: \
> -            if (a.round || a.sticky) { \
> -                /* round up if guard is 1, down if guard is zero */ \
> -                a.mant = int128_add(a.mant, int128_make64(a.guard)); \
> -            } else if (a.guard) { \
> -                /* exactly .5, round up if odd */ \
> -                a.mant = int128_add(a.mant, int128_and(a.mant, int128_one())); \
> -            } \
> -            break; \
> -        } \
> -    } \
> -    /* \
> -     * OK, now we might have carried all the way up. \
> -     * So we might need to shr once \
> -     * at least we know that the lsb should be zero if we rounded and \
> -     * got a carry out... \
> -     */ \
> -    if ((int128_getlo(a.mant) >> (MANTBITS + 1)) != 0) { \
> -        a = accum_norm_right(a, 1); \
> -    } \
> -    /* Overflow? */ \
> -    if (a.exp >= INF_EXP) { \
> -        /* Yep, inf result */ \
> -        float_raise(float_flag_overflow, fp_status); \
> -        float_raise(float_flag_inexact, fp_status); \
> -        switch (fp_status->float_rounding_mode) { \
> -        case float_round_to_zero: \
> -            return maxfinite_##SUFFIX(a.sign); \
> -        case float_round_up: \
> -            if (a.sign == 0) { \
> -                return infinite_##SUFFIX(a.sign); \
> -            } else { \
> -                return maxfinite_##SUFFIX(a.sign); \
> -            } \
> -        case float_round_down: \
> -            if (a.sign != 0) { \
> -                return infinite_##SUFFIX(a.sign); \
> -            } else { \
> -                return maxfinite_##SUFFIX(a.sign); \
> -            } \
> -        default: \
> -            return infinite_##SUFFIX(a.sign); \
> -        } \
> -    } \
> -    /* Underflow? */ \
> -    if (int128_getlo(a.mant) & (1ULL << MANTBITS)) { \
> -        /* Leading one means: No, we're normal. So, we should be done... */ \
> -        INTERNAL_TYPE ret; \
> -        ret.i = 0; \
> -        ret.sign = a.sign; \
> -        ret.exp = a.exp; \
> -        ret.mant = int128_getlo(a.mant); \
> -        return ret.i; \
> -    } \
> -    assert(a.exp == 1); \
> -    INTERNAL_TYPE ret; \
> -    ret.i = 0; \
> -    ret.sign = a.sign; \
> -    ret.exp = 0; \
> -    ret.mant = int128_getlo(a.mant); \
> -    return ret.i; \
> +static float64 accum_round_float64(Accum a, float_status * fp_status)
> +{
> +    if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0)
> +        && ((a.guard | a.round | a.sticky) == 0)) {
> +        /* result zero */
> +        switch (fp_status->float_rounding_mode) {
> +        case float_round_down:
> +            return zero_float64(1);
> +        default:
> +            return zero_float64(0);
> +        }
> +    }
> +    /* Normalize right */
> +    /* We want DF_MANTBITS bits of mantissa plus the leading one. */
> +    /* That means that we want DF_MANTBITS+1 bits, or 0x000000000000FF_FFFF */
> +    /* So we need to normalize right while the high word is non-zero and
> +    * while the low word is nonzero when masked with 0xffe0_0000_0000_0000 */
> +    while ((int128_gethi(a.mant) != 0) ||
> +           ((int128_getlo(a.mant) >> (DF_MANTBITS + 1)) != 0)) {
> +        a = accum_norm_right(a, 1);
> +    }
> +    /*
> +     * OK, now normalize left
> +     * We want to normalize left until we have a leading one in bit 24
> +     * Theoretically, we only need to shift a maximum of one to the left if we
> +     * shifted out lots of bits from B, or if we had no shift / 1 shift sticky
> +     * should be 0
> +     */
> +    while ((int128_getlo(a.mant) & (1ULL << DF_MANTBITS)) == 0) {
> +        a = accum_norm_left(a);
> +    }
> +    /*
> +     * OK, now we might need to denormalize because of potential underflow.
> +     * We need to do this before rounding, and rounding might make us normal
> +     * again
> +     */
> +    while (a.exp <= 0) {
> +        a = accum_norm_right(a, 1 - a.exp);
> +        /*
> +         * Do we have underflow?
> +         * That's when we get an inexact answer because we ran out of bits
> +         * in a denormal.
> +         */
> +        if (a.guard || a.round || a.sticky) {
> +            float_raise(float_flag_underflow, fp_status);
> +        }
> +    }
> +    /* OK, we're relatively canonical... now we need to round */
> +    if (a.guard || a.round || a.sticky) {
> +        float_raise(float_flag_inexact, fp_status);
> +        switch (fp_status->float_rounding_mode) {
> +        case float_round_to_zero:
> +            /* Chop and we're done */
> +            break;
> +        case float_round_up:
> +            if (a.sign == 0) {
> +                a.mant = int128_add(a.mant, int128_one());
> +            }
> +            break;
> +        case float_round_down:
> +            if (a.sign != 0) {
> +                a.mant = int128_add(a.mant, int128_one());
> +            }
> +            break;
> +        default:
> +            if (a.round || a.sticky) {
> +                /* round up if guard is 1, down if guard is zero */
> +                a.mant = int128_add(a.mant, int128_make64(a.guard));
> +            } else if (a.guard) {
> +                /* exactly .5, round up if odd */
> +                a.mant = int128_add(a.mant, int128_and(a.mant, int128_one()));
> +            }
> +            break;
> +        }
> +    }
> +    /*
> +     * OK, now we might have carried all the way up.
> +     * So we might need to shr once
> +     * at least we know that the lsb should be zero if we rounded and
> +     * got a carry out...
> +     */
> +    if ((int128_getlo(a.mant) >> (DF_MANTBITS + 1)) != 0) {
> +        a = accum_norm_right(a, 1);
> +    }
> +    /* Overflow? */
> +    if (a.exp >= DF_INF_EXP) {
> +        /* Yep, inf result */
> +        float_raise(float_flag_overflow, fp_status);
> +        float_raise(float_flag_inexact, fp_status);
> +        switch (fp_status->float_rounding_mode) {
> +        case float_round_to_zero:
> +            return maxfinite_float64(a.sign);
> +        case float_round_up:
> +            if (a.sign == 0) {
> +                return infinite_float64(a.sign);
> +            } else {
> +                return maxfinite_float64(a.sign);
> +            }
> +        case float_round_down:
> +            if (a.sign != 0) {
> +                return infinite_float64(a.sign);
> +            } else {
> +                return maxfinite_float64(a.sign);
> +            }
> +        default:
> +            return infinite_float64(a.sign);
> +        }
> +    }
> +    /* Underflow? */
> +    if (int128_getlo(a.mant) & (1ULL << DF_MANTBITS)) {
> +        /* Leading one means: No, we're normal. So, we should be done... */
> +        Double ret;
> +        ret.i = 0;
> +        ret.sign = a.sign;
> +        ret.exp = a.exp;
> +        ret.mant = int128_getlo(a.mant);
> +        return ret.i;
> +    }
> +    assert(a.exp == 1);
> +    Double ret;
> +    ret.i = 0;
> +    ret.sign = a.sign;
> +    ret.exp = 0;
> +    ret.mant = int128_getlo(a.mant);
> +    return ret.i;
>   }
>   
> -GEN_XF_ROUND(float64, DF_MANTBITS, DF_INF_EXP, Double)
> -
>   float64 internal_mpyhh(float64 a, float64 b,
>                         unsigned long long int accumulated,
>                         float_status *fp_status)
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

