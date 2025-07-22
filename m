Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A4EC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 18:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHaF-0002hh-Ha; Tue, 22 Jul 2025 14:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ueHM1-0000Ys-6l; Tue, 22 Jul 2025 14:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ueHLy-00010H-Lm; Tue, 22 Jul 2025 14:04:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHsjf5027830;
 Tue, 22 Jul 2025 18:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GTjaky
 eBJqFCYbcSCsNPwr9Goa9gjVpmZei+W2RkmZM=; b=IQV+mi6w2vziNv8J+PN3R2
 XHvSqnQLgSZw18MPkO6RuSJ1+sabTkSVwSuDY8eve/0uw58mTXM7PivsF5DgJPmJ
 ceoKgN9F2nl9YdV9Iz7/HTNT5NLzEgHGGwg2VncT8yE27d7+yQiTjpCdYe8Roatd
 AuVRgi3Yxkr4DaLNozcA+ol6LvEV2V721PbvW4icnV9KIO/ZbLlq1cvmBWzCOz7R
 Uefl5VTVjJiecGx96RLEG6wzX3jiD2Nnju2Vx1xGqjIKbt8p1QGlNsvppCqfreG0
 mJpsvQnig0+sG4W3mppe2HhaMGK2Sz/sYCwu2g6ruKwtr3kfoQHUugzhc4G5SWUQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5g2k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 18:04:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56MI4Yep019097;
 Tue, 22 Jul 2025 18:04:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5g2k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 18:04:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56MF6LJ3012823;
 Tue, 22 Jul 2025 18:04:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p3047j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 18:04:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56MI4UYt20906390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 18:04:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F20820043;
 Tue, 22 Jul 2025 18:04:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D4ED20040;
 Tue, 22 Jul 2025 18:04:26 +0000 (GMT)
Received: from [9.39.18.220] (unknown [9.39.18.220])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Jul 2025 18:04:26 +0000 (GMT)
Message-ID: <7a537212-3634-4fe4-b574-b9287c75cb2c@linux.ibm.com>
Date: Tue, 22 Jul 2025 23:34:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/ppc: Add stub for pnv_chip_find_core()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-4-philmd@linaro.org>
 <eff37ca7-d977-450e-85e0-ca8e4f6f3d5a@redhat.com>
 <ba766eae-e8e0-436a-ad30-625744b872e4@linaro.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ba766eae-e8e0-436a-ad30-625744b872e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE0OSBTYWx0ZWRfXzt+Azii/PpEZ
 LcBpA5n6d1673OgmvQhOpDByj2zvd1H0gfrjJUR7lzTLXc+Fw/aTxeNaIF0MAt8BMkaNCwJL3a5
 5P6i+tjVmX3Ezpbrt5y21wQSbOnl5+cZgVtjVG4DBsdJDSRfGvlfhWh8rUUODLoAjeCwqNxzsy1
 Uep47YcH9rOEsX7tKqZVAbYn36rAnuNlskHTmy+ZQfypjm+xTvLs7g1HyxmJf3mKh4QseycZoFK
 mQp4WishQsQoaN7B2M4JMkMAZKzzCArCdaZ5wIxEIHzToy12qheWSu9mALUgt1i+tB7moLx5OLB
 VHFJHgoXjnjCEs64EYM2cIzI1bOClvCfO1eFmpTB3ZEg8uGgSAEgMWBH5/qIE1uJju+uN7NQAP4
 YPTf5vbd0Tt4Jbrqx6lsfrXSDMro/86jqtzkzAbKDyUM2+R1YocDsV5lZ7hJhWnbuxR6yRrb
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=687fd2b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=3k9ylfmYWhEEyks9udkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9H9MFCpnfSdSZSaGm24kfj6lsm47zYeZ
X-Proofpoint-ORIG-GUID: KtwzzJr_OPJtBrv_SMXj2cWTgZkU9wuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=940 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Cédric and Philippe,


On 26/05/25 17:21, Philippe Mathieu-Daudé wrote:
> On 26/5/25 13:48, Cédric Le Goater wrote:
>> On 5/26/25 13:23, Philippe Mathieu-Daudé wrote:
>>> Since commit 9808ce6d5cb, building QEMU configured with
>>> '--without-default-devices' fails:
>>>
>>>    Undefined symbols for architecture arm64:
>>>      "_pnv_chip_find_core", referenced from:
>>>          _helper_load_sprd in target_ppc_misc_helper.c.o
>>>          _helper_store_sprd in target_ppc_misc_helper.c.o
>>>    ld: symbol(s) not found for architecture arm64
>>>    clang: error: linker command failed with exit code 1
>>> > Fix by adding a stub when CONFIG_POWERNV is not available.
>>
>> The fix would be to add an abstract handler to implement SPRD accesses
>> on the PowerNV machine.


Is this what you meant by an abstract handler ?
https://github.com/adi-g15-ibm/qemu/commit/0abac37032a5ef66d64a649ce04f24876bf9007d


The thing done, is just to introduce a function pointer in 
'PowerPCCPUClass',
namely 'handle_sprd_store' and 'handle_sprd_load'


These will be set in the PNV chip realize path, so now the SPRD code in
target/ppc, will only call this for PowerNV.

Separated the powernv specific code, so target/ppc code doesn't depend
on pnv calls now.


Not well tested, will try somethings.


Thanks,

Aditya Gupta


>
> I don't know what "SPRD" is so I'll let someone more familiar with
> this area do the proper cleanup.
>
> Regards,
>
> Phil.
>
>>
>> Thanks,
>>
>> C.
>
>

