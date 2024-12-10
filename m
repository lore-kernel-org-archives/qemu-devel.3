Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAC5E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 01:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKpJb-0006fw-CJ; Mon, 09 Dec 2024 20:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpJR-0006fK-Qi
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 20:45:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpJP-0001y1-OO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 20:45:21 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9GpNS9012697;
 Tue, 10 Dec 2024 01:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BtvffuVlAg1Pu2qBdcvgXKM3oTIbVeY98jMcJTh1dwI=; b=c3swrdJnC714g9Bg
 66u4juMICzpTw/ktzZjWy00Vq1jPdwd4HPUSVFZiIETr6spAnuH5C5Sw+mGh0xRB
 acEP6MKBf/mSGZWZIeDGC6mreVvwdrkK6sI9UflRRxOE+8zrhz6bK8XOLZ8Q/sLC
 KLkwSS/Jo1lCMjgI3lSP7LNLcELg6CcdPY4S7tjtfn7jEbgHIJUpkdus81qFhDB3
 Og0gUyyn4SRWM67UGUriP7JekabbO01SOEnnUW2xDwOZ8tNFVDPsrtl3fTtdDtM1
 jZzNLIVF83Vr4BXcpekzOQJJADeJ6yNxZaoHj7RvHblHo2wNrFY5CmGFwYe8Mo6J
 gpbCcA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ceetpv34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 01:45:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA1j9RV012676
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 01:45:09 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 17:45:07 -0800
Message-ID: <b168c589-53fb-4819-b9e2-f4616d9a145d@quicinc.com>
Date: Mon, 9 Dec 2024 19:45:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] target/hexagon: Use float32_mul in helper_sfmpy
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <bcain@oss.qualcomm.com>, <peter.maydell@linaro.org>,
 <mark.cave-ayland@ilande.co.uk>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-8-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 7gPw631SJ56J7MsE6zhKcn8UNrmpsJuk
X-Proofpoint-ORIG-GUID: 7gPw631SJ56J7MsE6zhKcn8UNrmpsJuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0 mlxlogscore=465
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100009
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
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
> There are no special cases for this instruction.
> Remove internal_mpyf as unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/fma_emu.h   | 1 -
>   target/hexagon/fma_emu.c   | 8 --------
>   target/hexagon/op_helper.c | 2 +-
>   3 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
> index 91591d6050..ad5df5d038 100644
> --- a/target/hexagon/fma_emu.h
> +++ b/target/hexagon/fma_emu.h
> @@ -32,7 +32,6 @@ int32_t float32_getexp(float32 f32);
>   float32 infinite_float32(uint8_t sign);
>   float32 internal_fmafx(float32 a, float32 b, float32 c,
>                          int scale, float_status *fp_status);
> -float32 internal_mpyf(float32 a, float32 b, float_status *fp_status);
>   float64 internal_mpyhh(float64 a, float64 b,
>                          unsigned long long int accumulated,
>                          float_status *fp_status);
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> index 05a56d8c10..35971b8b99 100644
> --- a/target/hexagon/fma_emu.c
> +++ b/target/hexagon/fma_emu.c
> @@ -655,14 +655,6 @@ float32 internal_fmafx(float32 a, float32 b, float32 c, int scale,
>       return accum_round_float32(result, fp_status);
>   }
>   
> -float32 internal_mpyf(float32 a, float32 b, float_status *fp_status)
> -{
> -    if (float32_is_zero(a) || float32_is_zero(b)) {
> -        return float32_mul(a, b, fp_status);
> -    }
> -    return internal_fmafx(a, b, float32_zero, 0, fp_status);
> -}
> -
>   float64 internal_mpyhh(float64 a, float64 b,
>                         unsigned long long int accumulated,
>                         float_status *fp_status)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 90e7aaa097..b8b556f4c6 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1157,7 +1157,7 @@ float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV)
>   {
>       float32 RdV;
>       arch_fpop_start(env);
> -    RdV = internal_mpyf(RsV, RtV, &env->fp_status);
> +    RdV = float32_mul(RsV, RtV, &env->fp_status);
>       arch_fpop_end(env);
>       return RdV;
>   }


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


