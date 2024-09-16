Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9C9C3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqB5n-00026Y-Ro; Mon, 16 Sep 2024 08:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqB5k-00025G-70
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:44:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqB5Y-0003E9-Nx
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:44:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCaRF4024670;
 Mon, 16 Sep 2024 12:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mTFWbtWsoXJtYTHuenz162Gw89Jjq4YY7wjEt1cIT3w=; b=ed4lY44eo2doeZcs
 xJsht6CDgJz5VfPE9E8+thrNLG6/FVrjRczEHfIP/C1CISZ+1jU7ozOohWNGM0R/
 bY1RuGEpGSSHduu7NHno5Pc06K5z9J15sTIUb050BaZWBYjN2xUOssMNL922bgjA
 E6U4MxZHwcuQj02DNy4bnVi6VKDPCMqaZeHSICp3Uw2JR/D0AA1XEz5Wcat0yh5W
 9IIlsQuvmZPWpRA0nGYug0te4KWtPCQ+/W/z3AsxfvX0b1Jbtrekr6dvufEivIDI
 Aiz3+h2uK/GZibPCaoMVWi+UOw9LD3wzY6NXs1jmZalS7Z5X6txvtD3N2RjQ+9Mm
 TgHiag==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gnkyps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 12:44:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GCi0er018346
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 12:44:00 GMT
Received: from [10.110.8.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 05:43:59 -0700
Message-ID: <8c8e878c-ce03-444e-92fe-725e643c287e@quicinc.com>
Date: Mon, 16 Sep 2024 07:43:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/qemu_test: Use Python hashlib instead of
 external programs
To: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 <qemu-devel@nongnu.org>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20240910201742.239559-1-thuth@redhat.com>
 <1823ff97-b305-453b-b3a6-b24cc1987002@comstyle.com>
 <ce4daa98-0b3c-426d-95e0-59320eb29be8@quicinc.com>
 <81699a4a-1740-4b65-90d9-4f3ce8f48922@comstyle.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <81699a4a-1740-4b65-90d9-4f3ce8f48922@comstyle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: jdPW4Daa809ncp0LEDwxNBA8XiIyaqz1
X-Proofpoint-ORIG-GUID: jdPW4Daa809ncp0LEDwxNBA8XiIyaqz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 mlxlogscore=495 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 9/13/2024 9:30 PM, Brad Smith wrote:
> On 2024-09-10 10:06 p.m., Brian Cain wrote:
>>
>> On 9/10/2024 5:26 PM, Brad Smith wrote:
>>> On 2024-09-10 4:17 p.m., Thomas Huth wrote:
>>>> Some systems (like OpenBSD) do not have the sha256sum or sha512sum 
>>>> programs
>>>> installed by default. Use the Python hashlib instead so we don't 
>>>> have to
>>>> rely on the external programs.
>>>
>>> On OpenBSD they're named sha256 and sha512.
>>>
>> Rather than port the test to each OS's particular program names, we 
>> should use the portable solution that's included w/Python.
>
> I wasn't trying to imply that the patch wasn't the right direction, it 
> is when it comes portability. Just commenting
> on what it says in the commit message. This isn't the first time such 
> differences have come up.
>
I see.  Good point.


