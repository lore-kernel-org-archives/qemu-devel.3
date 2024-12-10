Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451DEE7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 02:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKpZA-0000kF-4D; Mon, 09 Dec 2024 21:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpZ8-0000k6-J4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 21:01:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpZ6-0003qk-MT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 21:01:34 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Hsv8V023058;
 Tue, 10 Dec 2024 02:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ce0p577OCc0uHPF2VwwRlPC7Avr84LTZlTzuBk8EmZQ=; b=E7yQc7pAurPZ+RUB
 Ae5/M/J6KKLZR0jddU1ELRcBhBAWg7n1TR4c2+OcYB3/kvi2n6d+MTrI2G+03lqT
 C/U/e7qQXfwiFZVZ5GUeTPtRKA276U3QG4WIqir3BRvLM4xQAStUfg3yyOMsyaLZ
 nBp/C6yOskJWU6aIL1SwlJAUtJ0SDfcdS7pnrM+ftczbkujgglCszUUFEcFCAm3l
 S9Ab9Qp2SlJ2u/I+pua2AEeaqTdGqsOlF4c3yXt0H69fCuSnYSFhHjTK5qocMLUD
 DUAeb8TSlzDeN5pa9j+NHVYrAl7Lu2WxmTcH/xu2tUBs7Zvp/vEyawccD8tDQUzo
 InxXKA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e5c7s00d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 02:01:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA21NWZ030844
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 02:01:23 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 18:01:22 -0800
Message-ID: <83563e41-6302-4403-ba48-61164796ab0a@quicinc.com>
Date: Mon, 9 Dec 2024 20:01:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] target/hexagon: Use float32_muladd_scalbn for
 helper_sffma_sc
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-11-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Gg9iX-17TsIZHWFmO6PzaDHDscMhgf6z
X-Proofpoint-ORIG-GUID: Gg9iX-17TsIZHWFmO6PzaDHDscMhgf6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=636 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100012
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
> This instruction has a special case that 0 * x + c returns c
> without the normal sign folding that comes with 0 + -0.
> Use the new float_muladd_suppress_add_product_zero to
> describe this.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/op_helper.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index aa5ab4a31f..eb010422bf 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1192,15 +1192,10 @@ static float32 check_nan(float32 dst, float32 x, float_status *fp_status)
>   float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
>                            float32 RsV, float32 RtV, float32 PuV)
>   {
> -    size4s_t tmp;
>       arch_fpop_start(env);
> -    RxV = check_nan(RxV, RxV, &env->fp_status);
> -    RxV = check_nan(RxV, RsV, &env->fp_status);
> -    RxV = check_nan(RxV, RtV, &env->fp_status);
> -    tmp = internal_fmafx(RsV, RtV, RxV, fSXTN(8, 64, PuV), &env->fp_status);
> -    if (!(float32_is_zero(RxV) && is_zero_prod(RsV, RtV))) {
> -        RxV = tmp;
> -    }
> +    RxV = float32_muladd_scalbn(RsV, RtV, RxV, fSXTN(8, 64, PuV),
> +                                float_muladd_suppress_add_product_zero,
> +                                &env->fp_status);
>       arch_fpop_end(env);
>       return RxV;
>   }


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


