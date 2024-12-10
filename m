Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79734E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 01:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKpMn-0007sq-FR; Mon, 09 Dec 2024 20:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpMm-0007si-C3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 20:48:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tKpMk-0002E0-Pq
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 20:48:48 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Hwvxv025063;
 Tue, 10 Dec 2024 01:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xobWyBvT4Wd1TneVIuIM+0o2h4u2Q7hiFWEJqxiwNMs=; b=hRvmPS94D9cHsS24
 jshNCBSIwLf7YkEOC99gKAYaeJuINVoxcJNvBAaZIucofQ7O7lwUjb2woLejkkl/
 My1j3QKDgWVho/wSl3e0cOsSr0fz6EDbdBsRFr7Tejxtiz1pBkHOe+Eok44SZbaM
 pvAgVDOFoFFsa07MPXeb2KhUU7G+44/9t4QMNLf89LQTW2BchDEDa47JtYfTpIIz
 cgkXmYII8e/H5IqLMqCtwYhUIMxji6sZxruCAvtf/3t8oJLvX6UCiDaiodrnXjSC
 o444KQV+z9rP5VvM1jfrVsLrjLzqYNQKAbIAQFwnCiyf1daDOPID8F4aMEZtSeyU
 L7fVvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cek1xnhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 01:48:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA1mbPW013011
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 01:48:37 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 17:48:36 -0800
Message-ID: <b781fecf-6c99-4dc6-b88f-06e023dfa2fd@quicinc.com>
Date: Mon, 9 Dec 2024 19:48:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] target/hexagon: Use float32_muladd for helper_sffms
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-10-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: uDDXY8NcfIns13emthMP0JlgoqlWv4zs
X-Proofpoint-ORIG-GUID: uDDXY8NcfIns13emthMP0JlgoqlWv4zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=533 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100010
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
> There are no special cases for this instruction.  Since hexagon
> always uses default-nan mode, explicitly negating the first
> input is unnecessary.  Use float_muladd_negate_product instead.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/op_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 7d459cc6f3..aa5ab4a31f 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1208,10 +1208,9 @@ float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
>   float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
>                         float32 RsV, float32 RtV)
>   {
> -    float32 neg_RsV;
>       arch_fpop_start(env);
> -    neg_RsV = float32_set_sign(RsV, float32_is_neg(RsV) ? 0 : 1);
> -    RxV = internal_fmafx(neg_RsV, RtV, RxV, 0, &env->fp_status);
> +    RxV = float32_muladd(RsV, RtV, RxV, float_muladd_negate_product,
> +                         &env->fp_status);
>       arch_fpop_end(env);
>       return RxV;
>   }

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


