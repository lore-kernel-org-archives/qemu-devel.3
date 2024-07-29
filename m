Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2D6C3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 01:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYEqh-0003Rx-0o; Sun, 28 Jul 2024 21:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sYEqe-0003RT-Ie
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 21:06:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sYEqc-00036K-8O
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 21:06:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SNjWaY011608;
 Mon, 29 Jul 2024 01:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8/Y5hhReJJ2cDE/rDamTSBOUGOo3QVOAl5TXeVpuPgA=; b=O0T+m1lfTa2DcTYo
 nNDpzk4+AXGce1ZlwNvEVCBbv5OAe2eLHEeYXIKbiwece4jrujc1jUxDeeWtfuYF
 S/XLN01QmPeYLT4ToAthFtkp6S2wn8QY4vB4YPX1r+K8r24HRtKnoz5t8Gi7YDPG
 cSB8eYBHjRfgudvQtqsiPSaHOfxZ1oBX1Ntxmy8/rlN6u8wVX+NQCvIzSZ+swMPt
 CkTrdRM4vCU3QFs1WBF9AJ1BiVP2FpX4xeeESlcoHHW3hy0ItLQj5OlIxqkWjzpP
 31i5w9WhbIgyiGUrmf6mchCTzaxDjDreN+hkUWUEI5W0/8B8UMFX6CmAEVn62egk
 ZJJ5Gw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mryttjkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 01:06:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46T16e7b007549
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 01:06:40 GMT
Received: from [10.110.44.57] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 28 Jul
 2024 18:06:39 -0700
Message-ID: <0291c94c-a489-4cb9-9c19-ad123b9a3248@quicinc.com>
Date: Sun, 28 Jul 2024 20:06:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon: fix F2_conv_* instructions for negative zero
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
CC: <ltaylorsimpson@gmail.com>, <bcain@quicinc.com>, <sidneym@quicinc.com>,
 <ale@rev.ng>, <anjo@rev.ng>
References: <9f3be6911db2dcff834ce6b530118fa383b9e46a.1722186937.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <9f3be6911db2dcff834ce6b530118fa383b9e46a.1722186937.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: JiCKDqg53BFlatdyBN6-KrU5yojsRenj
X-Proofpoint-GUID: JiCKDqg53BFlatdyBN6-KrU5yojsRenj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-28_17,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=633
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290006
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


On 7/28/2024 12:15 PM, Matheus Tavares Bernardino wrote:
> The implementation for these instructions handles -0 as an invalid float
> point value, whereas the Hexagon hardware considers it the same as +0
> (which is valid). Let's fix that and add a regression test.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---

Reviewed-by: Brian Cain <bcain@quicinc.com>


>   target/hexagon/op_helper.c | 16 ++++++++--------
>   tests/tcg/hexagon/usr.c    | 10 ++++++++++
>   2 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index ae5a605513..e1fc88aa0d 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -683,7 +683,7 @@ uint32_t HELPER(conv_sf2uw)(CPUHexagonState *env, float32 RsV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -713,7 +713,7 @@ uint64_t HELPER(conv_sf2ud)(CPUHexagonState *env, float32 RsV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> @@ -743,7 +743,7 @@ uint32_t HELPER(conv_df2uw)(CPUHexagonState *env, float64 RssV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -773,7 +773,7 @@ uint64_t HELPER(conv_df2ud)(CPUHexagonState *env, float64 RssV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> @@ -803,7 +803,7 @@ uint32_t HELPER(conv_sf2uw_chop)(CPUHexagonState *env, float32 RsV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -833,7 +833,7 @@ uint64_t HELPER(conv_sf2ud_chop)(CPUHexagonState *env, float32 RsV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV)) {
> +    if (float32_is_neg(RsV) && !float32_is_any_nan(RsV) && !float32_is_zero(RsV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> @@ -863,7 +863,7 @@ uint32_t HELPER(conv_df2uw_chop)(CPUHexagonState *env, float64 RssV)
>       uint32_t RdV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RdV = 0;
>       } else {
> @@ -893,7 +893,7 @@ uint64_t HELPER(conv_df2ud_chop)(CPUHexagonState *env, float64 RssV)
>       uint64_t RddV;
>       arch_fpop_start(env);
>       /* Hexagon checks the sign before rounding */
> -    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV)) {
> +    if (float64_is_neg(RssV) && !float64_is_any_nan(RssV) && !float64_is_zero(RssV)) {
>           float_raise(float_flag_invalid, &env->fp_status);
>           RddV = 0;
>       } else {
> diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c
> index 92bc86a213..95d04762bf 100644
> --- a/tests/tcg/hexagon/usr.c
> +++ b/tests/tcg/hexagon/usr.c
> @@ -1007,6 +1007,11 @@ int main()
>       TEST_P_OP_R(conv_sf2d_chop,   SF_QNaN,  0xffffffffffffffffULL,  USR_FPINVF);
>       TEST_P_OP_R(conv_sf2d_chop,   SF_SNaN,  0xffffffffffffffffULL,  USR_FPINVF);
>   
> +    TEST_R_OP_R(conv_sf2uw,       SF_zero_neg,  0, USR_CLEAR);
> +    TEST_R_OP_R(conv_sf2uw_chop,  SF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_R(conv_sf2ud,       SF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_R(conv_sf2ud_chop,  SF_zero_neg,  0, USR_CLEAR);
> +
>       TEST_R_OP_P(conv_df2sf,       DF_QNaN,  SF_HEX_NaN,             USR_CLEAR);
>       TEST_R_OP_P(conv_df2sf,       DF_SNaN,  SF_HEX_NaN,             USR_FPINVF);
>       TEST_R_OP_P(conv_df2uw,       DF_QNaN,  0xffffffff,             USR_FPINVF);
> @@ -1020,6 +1025,11 @@ int main()
>       TEST_R_OP_P(conv_df2uw_chop,  DF_QNaN,  0xffffffff,             USR_FPINVF);
>       TEST_R_OP_P(conv_df2uw_chop,  DF_SNaN,  0xffffffff,             USR_FPINVF);
>   
> +    TEST_R_OP_P(conv_df2uw,       DF_zero_neg,  0, USR_CLEAR);
> +    TEST_R_OP_P(conv_df2uw_chop,  DF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_P(conv_df2ud,       DF_zero_neg,  0, USR_CLEAR);
> +    TEST_P_OP_P(conv_df2ud_chop,  DF_zero_neg,  0, USR_CLEAR);
> +
>       /* Test for typo in HELPER(conv_df2uw_chop) */
>       TEST_R_OP_P(conv_df2uw_chop, 0xffffff7f00000001ULL, 0xffffffff, USR_FPINVF);
>   

