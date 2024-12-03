Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E418E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIY6x-00079L-3p; Tue, 03 Dec 2024 13:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tIY6q-0006yY-Ma
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:58:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tIY6l-0001ZY-HU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:58:53 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3G5UUc010254;
 Tue, 3 Dec 2024 18:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uAsa1SBLvThLxog17lenkZd9LW8Kyc7ZkeXKhd7db70=; b=VYNjYabkJUIwTx2F
 FUpkThadK/npvPOM0jyqfs5Arneijr5G4F7oIojC8LxziLLVR9CAatBJNMGezEVI
 04Fobqa9kUZ+zcmy/g3KbRbRqQrttk2Ga0jvmU3eQ7IIW/BH03B9mqPdaYLq1q72
 RnvgkzezTsq2E6+bD7/fJS2Cxb6S17Pa6vnntaIq/FUkf2pJ8wJBdcN4jPulTHHS
 maDsizjWa/yKwHraBCRIO9WYW5AWMPipfJ/f7s98zPs41ZdXqAJNU+94e58JI0L9
 23d5z9k+qnDVJGtv66TnTT6PTmkENjyZDfjD+Zw6BW6+/ybb3bEQEv20geHlc7hA
 DdHAAg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v7yt170-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Dec 2024 18:58:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3Iwl2W007194
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 3 Dec 2024 18:58:47 GMT
Received: from [10.111.174.1] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 10:58:45 -0800
Message-ID: <b5f00bbb-7125-4fb7-8f6a-bd9343642d42@quicinc.com>
Date: Tue, 3 Dec 2024 12:58:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 37/43] target/hexagon: Make HVX vector args.
 restrict *
To: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <ale@rev.ng>, <ltaylorsimpson@gmail.com>,
 <bcain@quicinc.com>, <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-38-anjo@rev.ng>
 <30a70eef-01ac-46a2-8e34-458c579dcf27@linaro.org>
 <689a4c48-af1f-44b1-9575-56c75ec0b830@redhat.com>
 <baawemaxxlh7kjecgw6zi6b6lk4i6m3ckq62teao6bctcoblzx@ncy5pot3loed>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <baawemaxxlh7kjecgw6zi6b6lk4i6m3ckq62teao6bctcoblzx@ncy5pot3loed>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 7mqYtDneUle1po9vaAryp3AT6sYfsg2Y
X-Proofpoint-GUID: 7mqYtDneUle1po9vaAryp3AT6sYfsg2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=526 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030157
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


On 12/3/2024 12:57 PM, Anton Johansson via wrote:
> On 25/11/24, Paolo Bonzini wrote:
>> On 11/25/24 12:36, Philippe Mathieu-Daudé wrote:
>>>> +#define QeV      (*(MMQReg * restrict)(QeV_void))
>>>> +#define QdV      (*(MMQReg * restrict)(QdV_void))
>>>> +#define QsV      (*(MMQReg * restrict)(QsV_void))
>>>> +#define QtV      (*(MMQReg * restrict)(QtV_void))
>>>> +#define QuV      (*(MMQReg * restrict)(QuV_void))
>>>> +#define QvV      (*(MMQReg * restrict)(QvV_void))
>>>> +#define QxV      (*(MMQReg * restrict)(QxV_void))
>>>>    #endif
>>> Maybe we need to fix scripts/checkpatch.pl along?
>>>
>>> ERROR: "foo * bar" should be "foo *bar"
>>> #31: FILE: target/hexagon/mmvec/macros.h:26:
>>> +#define VdV      (*(MMVector * restrict)(VdV_void))
>>>
>>> ERROR: "foo * bar" should be "foo *bar"
>>> #32: FILE: target/hexagon/mmvec/macros.h:27:
>>> +#define VsV      (*(MMVector * restrict)(VsV_void))
>>>
>>> ERROR: "foo * bar" should be "foo *bar"
>>> #33: FILE: target/hexagon/mmvec/macros.h:28:
>>> +#define VuV      (*(MMVector * restrict)(VuV_void))
>> I think checkpatch.pl has a point here. :)
> I'll switch to `*restrict`!:)


With this change to fix checkpatch,

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>
> //Anton
>

