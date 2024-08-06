Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2253CC52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 16:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbMtL-0003VF-98; Tue, 06 Aug 2024 12:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sbMtI-0003Tz-SF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:18:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sbMtG-0004Yy-QS
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:18:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476B2jl5014253;
 Tue, 6 Aug 2024 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EPhkMMQuMfMhVnAOgDFn5cyTIJzRxB3jdN26T56A0/M=; b=QQXlFlmWXgLqt0KZ
 uYgfuVowhRXOuUO/Qk+2IAdZNmKagAG0GkxocuL1lwz7yLXAmXgByUER0nGQd7GF
 0BWY6G89fzGI171ujhb13GXKJDn0Jrk/7fdgzyPwl4OYdw5i1NDUR+FYb9XQ/vhc
 oYdbZZEOqaBX9cE7pTD2J5ai8EqwHemu9YfHJtdatNJXNmCWxr4B7sRFbieMhhK6
 bYozMM7ECARjxrl70HRusHXEJ+32TnFkXKh3j+90gKta6DUkF4hSs4KU8++DLx6q
 0Z+RqFnKdZmS9usj2tvGTOSjKnQPl7bv69vfRKWI/wj4ENFXykT4xIpO/lSo0IMV
 h0h2iQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdu97w29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 16:18:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 476GIJRC014229
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 6 Aug 2024 16:18:19 GMT
Received: from [10.110.63.1] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 Aug 2024
 09:18:18 -0700
Message-ID: <81fc7759-0312-439c-98a3-e5cf582cdf1c@quicinc.com>
Date: Tue, 6 Aug 2024 11:18:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: don't look for static glib
To: Alyssa Ross <hi@alyssa.is>, Brian Cain <bcain@quicinc.com>
CC: <qemu-devel@nongnu.org>
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
X-Proofpoint-ORIG-GUID: hIcMJ77Xm0GB977m1iW_MSSMrlVNcRAt
X-Proofpoint-GUID: hIcMJ77Xm0GB977m1iW_MSSMrlVNcRAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408060114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Brian Cain <bcain@quicinc.com>


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

