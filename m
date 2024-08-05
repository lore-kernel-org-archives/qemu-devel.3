Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72E4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sayDv-0007wE-Mo; Mon, 05 Aug 2024 09:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sayDt-0007vf-Eh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:58:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sayDr-0008QX-A0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:58:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BQq1P021372;
 Mon, 5 Aug 2024 13:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PRYoI8zke/GoIENwyJlswyBB44EAmBQw+H0ZHeGD0KM=; b=bO5j3gnb82uXKGsS
 b0pSkDp34df65qvebXX60GhtVlzWuyfrDZICpONxrX23xsDYMFkGoTx6fkfXYZS+
 qmE5B3zQa2eZBmP9rD6wXWR6yB8TC+cKnH/Rg2Yka45qs0pBcaGOGzNwuxILK3cR
 ALXmz8OerYcCLbEvRjDunvZ/1yABkj/JgoKgmCRaJtCfx+5HILnvH+sZ8/CfWlt4
 sUW7llJp/ShUWGGjv/5ve3HfUaxVcDOfs08aIWfzMeJ5FfA4s866m07LvoEERhTR
 1att2CszdulitcnkP/7S1YKRWswgxjgungmMLqJncI8stjcZo4yefBWtnV4FvSqO
 G2973g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scmtv5u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Aug 2024 13:57:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 475DvvSr010897
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 5 Aug 2024 13:57:57 GMT
Received: from [10.110.63.1] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 06:57:57 -0700
Message-ID: <11ae16b4-8d3f-4b45-8a66-95b6d431471c@quicinc.com>
Date: Mon, 5 Aug 2024 08:57:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: don't look for static glib
To: Alyssa Ross <hi@alyssa.is>, Brian Cain <bcain@quicinc.com>
CC: <qemu-devel@nongnu.org>, Anton Johansson <anjo@rev.ng>, <ale@rev.ng>
References: <20240805104921.4035256-1-hi@alyssa.is>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240805104921.4035256-1-hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: RK_K4t2g-iqYK9D0QeSCeVUS7pBoeN2Y
X-Proofpoint-GUID: RK_K4t2g-iqYK9D0QeSCeVUS7pBoeN2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050099
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


On 8/5/2024 5:49 AM, Alyssa Ross wrote:
> When cross compiling QEMU configured with --static, I've been getting
> configure errors like the following:
>
>      Build-time dependency glib-2.0 found: NO
>
>      ../target/hexagon/meson.build:303:15: ERROR: Dependency lookup for glib-2.0 with method 'pkgconfig' failed: Could not generate libs for glib-2.0:
>      Package libpcre2-8 was not found in the pkg-config search path.
>      Perhaps you should add the directory containing `libpcre2-8.pc'
>      to the PKG_CONFIG_PATH environment variable
>      Package 'libpcre2-8', required by 'glib-2.0', not found
>
> This happens because --static sets the prefer_static Meson option, but
> my build machine doesn't have a static libpcre2.  I don't think it
> makes sense to insist that native dependencies are static, just
> because I want the non-native QEMU binaries to be static.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---

Thanks for the patch, Alyssa - I'll give it a try.


>   target/hexagon/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index b0b253aa6b..9ea1f4fc59 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -300,7 +300,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>           arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@']
>       )
>   
> -    glib_dep = dependency('glib-2.0', native: true)
> +    glib_dep = dependency('glib-2.0', native: true, static: false)
>   
>       idef_parser = executable(
>           'idef-parser',
>
> base-commit: f9851d2ffef59b3a7f39513469263ab3b019480f

