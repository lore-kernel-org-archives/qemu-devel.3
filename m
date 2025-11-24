Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4776BCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 03:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNYK-00025A-3c; Sun, 23 Nov 2025 22:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vNNYF-00024o-W0
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:47:44 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vNNYA-00018H-M1
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:47:43 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ANKG6Bo2161900; Mon, 24 Nov 2025 03:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N2J/qlKZv0Rdpza4vLQF9s1U7uEW/LHejN9eMMJX83s=; b=byO1j67IuNaNk/3h
 wfIUWLt9tCe8J6YrGOb+TgPuGRXsmudAt3pIOSAfh4i05VGh9C06oCadW8LDrXmQ
 m0ee52dsek06DIOZym4jx1hhRZZXTVjwjGgKMwiXBIXGKFiEjn5eYqwLVS8w6nLC
 26+qTDNiTRZNaK6T9Dt1r6uA/qYYYV3t9n6DAxHsJztdht4EFm2Qz+r/Iotv86vF
 4cfgLBFblnh0I1x9CPbZ0AxOebKfGCINyuR0cQ87dek9UDDQU3qDiV2TYlAxUbzv
 4EZk5Q04dUe+mMnWXf4r2s0DxmezL0iDvkG9FsJbyia2KzaP9DRCkN3czY+8NT0V
 0wwiUA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak685uhuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Nov 2025 03:47:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5AO3lVZD027674
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Nov 2025 03:47:31 GMT
Received: from [10.239.105.87] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 23 Nov
 2025 19:47:29 -0800
Message-ID: <3062579c-2fc5-43f6-bbb5-baeb4a4c9a67@quicinc.com>
Date: Mon, 24 Nov 2025 11:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] virtio-spi: Add vhost-user-spi device support
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: <alex.bennee@linaro.org>, <viresh.kumar@linaro.org>,
 <quic_tsoni@quicinc.com>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <zhiqiang.tu@oss.qualcomm.com>
References: <20251030083413.1532360-1-quic_haixcui@quicinc.com>
 <20251030083413.1532360-4-quic_haixcui@quicinc.com>
 <CAAjaMXYRpRXxGcGA9B5=56=tgHNjCyaiWpJ7wQj4RHGXe24XLQ@mail.gmail.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <CAAjaMXYRpRXxGcGA9B5=56=tgHNjCyaiWpJ7wQj4RHGXe24XLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=Woom8Nfv c=1 sm=1 tr=0 ts=6923d554 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=Mc6MSTjDq2kS_NhvNFAA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wuSTRQ0AGzLti2MrfgXJmvaCfTrFJhKj
X-Proofpoint-ORIG-GUID: wuSTRQ0AGzLti2MrfgXJmvaCfTrFJhKj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDAzMCBTYWx0ZWRfXxC7MBsigrkZ5
 b7xVv20LWgLtp1dqUBKWRFa8d63/rAkDmY1+kS6OZHZm0+YsNxZ2HLes8lCip9YRvN6DKUVExwx
 O+VfT7SRimAGpDJtXcpMTaOqN14mzYKWe+ZdJL5G4sOAqoSwdvsRbOsBG2t32cIoixzVyId84uL
 nSdAkIV65a6rFfG9SmR2lTPZF0BzFEb+VaY5CT08ljCMQijIcaW1eeQRchNPgWcA1SCF7Ovy96l
 Bf9WGRv6a10e6p/yLGDDX34TwQdUS9QiD/6A54xPnrFQWgPx7gCSj7px/tMrwC5gSycjUV3EjCN
 WBm5KPOuUOYDs4voF6cXhBDO2NG9l4GbYPYZ0rK9TPZZzNKtfspyjcU9eJidRyFcA4+g7nWhUeF
 j14ZdB69bGJVNjq+hHy2RXVMQl83QA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_01,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240030
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0b-0031df01.pphosted.com
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

> 
> I unfortunately cannot test it since the rust-vmm daemon requires a
> host SPI device, but LGTM
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks Manos for reviewing and providing the feedback. I really 
appreciate your time and effort.

To QEMU community:
I would like to kindly ask if anyone else has additional comments or 
suggestions regarding this patch. If there are no further concerns, 
could you please advise whether it is ready to be merged?

Best Regards
Haixu Cui

