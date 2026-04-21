Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3DBF94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFItp-0003rE-CT; Tue, 21 Apr 2026 17:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wFItn-0003qv-Fl; Tue, 21 Apr 2026 17:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wFItl-00060k-6k; Tue, 21 Apr 2026 17:44:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LImRW9878213; Tue, 21 Apr 2026 21:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VCApe/
 VWdyQzagZqcwxLWdJue6oW8B03mRomX5w1R68=; b=DPvHdmYjB/Q4CD2sl8lfiZ
 JzmCGzo4F88W62NXTzyw8NiuUtsOQKpoKtC3AfePIUQTQODEM7K5fX8aU7qy//mF
 FWUsh/jgqUk/z1gz6qsYyQBppVXvqQMUysk9dHKuL4VZi7SkkjsSD+e2rq+TZaxv
 DyvhBe+/WmPWKNA9X9lfywJwtz8quEnkLj4x1NAy0IjGa0Eg8d+M5HuG1QnBzasP
 lTL0RtdMiFejq2dz6njCIrgeqHeFD1uTRJ63p7X/pyq9ShroQetSji10g++Ca7XZ
 baiUVCQTi1a1Ld6Jqdszn7oZaRp/tcZ6+Fqrav13ve9g4ZVsHaf3zfRHvpgI1jpA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu20k07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 21:44:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LLalkE027310;
 Tue, 21 Apr 2026 21:44:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q2mj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 21:44:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LLig4E3670648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 21:44:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F4C458059;
 Tue, 21 Apr 2026 21:44:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB9E15804B;
 Tue, 21 Apr 2026 21:44:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 21:44:40 +0000 (GMT)
Message-ID: <0dccc934-78f3-4423-8a75-214243f6f855@linux.ibm.com>
Date: Tue, 21 Apr 2026 17:44:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <70bd2f29-9f33-43e0-897f-52f0b2af111f@linaro.org>
 <ece64b0e-7f05-43de-b326-38788a9abe8b@linux.ibm.com>
 <2c06e37f-477a-49d6-a65b-fd826fcdc5b2@linux.ibm.com>
 <184a1a43-d41b-4b23-bc53-768a12631884@linux.ibm.com>
 <01eb4b4a-b77f-421c-8ff8-bbd061482c8d@linaro.org>
 <082b5146-23ca-422f-854b-807ceab50427@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <082b5146-23ca-422f-854b-807ceab50427@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIxMiBTYWx0ZWRfXyPXCzGyUyScR
 5bTr3jkadAZnkxEzs3X1WF8mUzdapCL84FFbiCpmgvjuOIQ0bClorrEUhIVLLFI+DChwmzJFRPM
 8KfwrVw/BKGXYzvALg1mQTJgziclHkzs63rRHTw+L+q+WdlbqBDzw9J7qhOeTNnhaocpAC4m7x6
 2tTl065RC+7FeDJr0mYbgax4c6YFb88vcpISuUerBpQYUnjyRcyPojnUsekRbm6M0RJpXZZCmwV
 OzKn4zkmc9bTAx/GdrdzNmBmqG+nkbQbeD39oYZVV/kcK3wlPk/cURnVKZZFuwEG1a/OIqty39j
 ZgbMNuFZqQaEUXlVikqnFMzn1WbC/fo6Q83xgZay+hoScXpZXw1EUi2ZtS+FXvGNJ6y8nlKY1np
 KciezyGmYFBpTL4RspCrXvfyi9YYON4/KXyUt7Zat45pdFriYkR9WtruXS2sg/0zmZD/JyPN83J
 SANBVH3bgTvB5nS1Cwg==
X-Proofpoint-ORIG-GUID: YNUpPMRpol_fWxrP8Gyn1IxXNGpQse_8
X-Proofpoint-GUID: BvPIr3gfddnGoQLKYBthnwvriLkpe0Rk
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e7efcc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=NwbmgKXE1EHItE1rRsAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210212
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/20/26 4:31 PM, Philippe Mathieu-Daudé wrote:
> Hi Stefan,
> 
> On 28/3/26 00:37, Philippe Mathieu-Daudé wrote:
>> On 27/3/26 19:17, Stefan Berger wrote:
>>>
>>>
>>> On 3/27/26 11:21 AM, Stefan Berger wrote:
>>>>
>>>>
>>>> On 3/27/26 11:18 AM, Stefan Berger wrote:
>>>>>
>>>>>
>>>>> On 3/23/26 5:56 AM, Philippe Mathieu-Daudé wrote:
>>>>>> On 17/3/26 13:02, Philippe Mathieu-Daudé wrote:
>>>>>>
>>>>>>> Philippe Mathieu-Daudé (5):
>>>>>>>    hw/tpm: Factor tpm_ppi_enabled() out
>>>>>>>    hw/tpm: Add TPMIfClass::ppi_enabled field
>>>>>>>    hw/tpm: Remove CRBState::ppi_enabled field
>>>>>>>    hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>>>>>>>      TPMState
>>>>>>>    hw/tpm: Simplify tpm_ppi_enabled()
>>>>>>
>>>>>> Series queued for 11.1 (typo fixed), thanks.
>>>>>>
>>>>>
>>>>> Here's another TPM PPI related series. It would make sense to 
>>>>> upstream them together. Do you want to queue that one as well?
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/20260327-tpm-tis-sysbus-ppi- 
>>>>> v2-0- d8ec84d25dbc@redhat.com/T/#t
>>>>>
>>>>
>>>> Actually, they will have to rebase on this series first...
>>>>>
>>>>
>>>
>>> v3 is good now:
>>>
>>> https://lore.kernel.org/qemu-devel/20260327173209.148180-1- 
>>> mbawa@redhat.com/T/#t
>>>
>>> If you want to take it let me know, otherwise I will have to wait for 
>>> your series.
> 
> I'm not seeing your R-b tag on v3 on the mailing list, did you
> sent it? (asking because the list had some issue the last weeks).
> 
>>
>> Thanks for the head up, I'll queue it along and send the pull
>> request after 11.0 is released.

https://lore.kernel.org/qemu-devel/20260327173209.148180-1-mbawa@redhat.com/T/#m42a888b82b87432799e53c0426e65f95e9a27708

All 3 patches have my R-b as far as I can see...

>>
>> Regards,
>>
>> Phil.
> 
> 


