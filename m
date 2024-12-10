Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462E2E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 02:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKpai-0001Kx-R2; Mon, 09 Dec 2024 21:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpai-0001Kp-8k
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 21:03:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpag-0003wg-Rz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 21:03:12 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9GoggY025954;
 Tue, 10 Dec 2024 02:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Woq25RfnvZIW1dzu6aBeRV0lnOvy/q8Ci2AZoTF87D8=; b=OzT4IdT4MEs4VAUP
 HI4MCBX5BtJEw5hCxDduohcn09KiMXjrmP1ea23xq6AjdAJ+boO8HMYhF9tTjD58
 RR5MBhvYBkC6lMTHeuBcyPMZwsZYXirnGoyxsSaxyewIgjPh2KR1FubdxdF8cWwT
 XexJ3UPs2lnExD0JdrW+NBtgoJoS7YGbNmdvnk3wE7GBjReKfhjwr4W+aLxVHwxW
 ywjo10Rw64vF14ZHauoPZwB0LBvLwoHAEQgaTrxibaryh+iPE0qFYVo1ZJpVpe1G
 KHMl82lCoxaa7qWLk94buEXoiRjlaES7j1N/I4W/BJkSbC4TdyAHXijz8fLpdn7U
 RD9V1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ceetpw9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 02:03:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA232eF000856
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 02:03:02 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 18:03:01 -0800
Message-ID: <d9033533-966d-4588-809a-5054cd9f91f0@quicinc.com>
Date: Mon, 9 Dec 2024 20:02:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] target/hexagon: Simplify internal_mpyhh setup
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-18-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: SZfjjUdWxE11fNyfw-yD7YWAvdLJmx7d
X-Proofpoint-ORIG-GUID: SZfjjUdWxE11fNyfw-yD7YWAvdLJmx7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=703
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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
> Initialize x with accumulated via direct assignment,
> rather than multiplying by 1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/fma_emu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> index 6749538c09..bc6e742639 100644
> --- a/target/hexagon/fma_emu.c
> +++ b/target/hexagon/fma_emu.c
> @@ -453,7 +453,7 @@ float64 internal_mpyhh(float64 a, float64 b,
>           float64_is_infinity(b)) {
>           return float64_mul(a, b, fp_status);
>       }
> -    x.mant = int128_mul_6464(accumulated, 1);
> +    x.mant = int128_make64(accumulated);
>       x.sticky = sticky;
>       prod = fGETUWORD(1, float64_getmant(a)) * fGETUWORD(1, float64_getmant(b));
>       x.mant = int128_add(x.mant, int128_mul_6464(prod, 0x100000000ULL));

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


