Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C02C54F2E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 13:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIScK-0007fl-2s; Fri, 23 May 2025 09:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIScE-0007c8-Py; Fri, 23 May 2025 09:39:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIScD-0001Yq-01; Fri, 23 May 2025 09:39:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N2UEst005898;
 Fri, 23 May 2025 13:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QuG5IQ
 Qu/fvgPCo2Od9L3rflnjYaRB9xopDzE3GWU2A=; b=c+K4od04pvE6/WM/DoN1Vy
 FUMDYqGvWDUGAxz66BSGP7Gku748Rkud+FriZt4mNxCwrKD+hqPec7ND2BxHQWxw
 MT6iAdhKuCO5xpBRoaP+y6UzacMFp/cy570VfXzWH69sxh1aKA7QY6aR0kX8dc3A
 MAD9vai0n+y2u9HqQOv7n5BN9T6ldG/EuMU9Xs4phCZncemZl2Qh5FBvJ7tf47pI
 XRyL9XIxetz9QpJCxQT/pyv7PxTUAq+XU+kBgHiMniXHIFEA3PnbvDKEuk+qcvFS
 I2+gvSvrdL+5HO3emi/4Bcjlzoyn+aS8DgCY1OaBERhzWoBondmLQfJHf6JLXvRA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t14jq4q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 13:39:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NAi0la024711;
 Fri, 23 May 2025 13:39:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkres8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 13:39:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54NDd8tm36176466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 13:39:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2B7458057;
 Fri, 23 May 2025 13:39:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18E4458058;
 Fri, 23 May 2025 13:39:08 +0000 (GMT)
Received: from [9.61.240.236] (unknown [9.61.240.236])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 13:39:08 +0000 (GMT)
Message-ID: <63ce16e5-b318-4eff-b757-68a3dbd7dd9f@linux.ibm.com>
Date: Fri, 23 May 2025 09:39:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 4/4] s390: implementing CHSC SEI for AP config
 change
To: Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250523044741.59936-1-rreyes@linux.ibm.com>
 <20250523044741.59936-5-rreyes@linux.ibm.com>
 <f743c32c-439d-483b-b4db-78e6871fdb35@linux.ibm.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <f743c32c-439d-483b-b4db-78e6871fdb35@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O0yeeS6XN5xsKZ9rurapCFLHzHozbD9c
X-Authority-Analysis: v=2.4 cv=XOkwSRhE c=1 sm=1 tr=0 ts=68307a7f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=mPdsSDuPDpI5zoGbeOYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMCBTYWx0ZWRfX0RHZJbCo2gzz
 KH1S1M6l5afOOrqlq+6Fjv9/DGmW4fzPRGzDbmVeB9dKBz+bU89GcTjdPOBzYwt95NSP8iwShZ6
 325CdJZTi3br9D3iXvxpiGLu2tQFMRwhb+LyviZslhb9FrT5iLmXtnLvFHJLGB0kowF7LaMeBEJ
 ZRwCx0JRMX5NZGtZvReJm691AsKmPj/0OK95CZwHfLB7Ryd0ty/6Z6sSWtdDkqiHtfcyDItshB3
 CaU5X1yG6Nz3BtaX8+ljoPlm6GSsKN/8ZC2SIvh+ivM+zrQqPo11m4iuNRv20cBOOBp8HIMGLAi
 xlPjejmflJgiVnWl+PNTEIMfKvsHFUIY2o7dWuXXs2B6wV5FFsMbV74wRkOQ4zBUFGU6GPIArHf
 OqdZiK94dPdZDA/bBYJMf/2y7Xro+Wi7A6Z5Pa6Wlf2IvxZldt32Boc6O1fl+Nx9BpuCIRT5
X-Proofpoint-GUID: O0yeeS6XN5xsKZ9rurapCFLHzHozbD9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

>> diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
>> new file mode 100644
>> index 0000000000..e2dacff959
>> --- /dev/null
>> +++ b/hw/s390x/ap-stub.c
>> @@ -0,0 +1,25 @@
>> +/*
>> + * VFIO based AP matrix device assignment
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 
>> or (at
>> + * your option) any later version. See the COPYING file in the 
>> top-level
>> + * directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/s390x/ap-bridge.h"
>> +
>> +int ap_chsc_sei_nt0_get_event(void *res)
>> +{
>> +    return 0;
>> +}
>> +
>> +int ap_chsc_sei_nt0_have_event(void)
>> +{
>> +    return 0;
>> +}
>
> Shouldn't these stub function signatures match those in
> ap-bridge.h?
>
I'll update 'ap_chsc_sei_nt0_have_event' to be a boolean function, but 
keep the get_event as an int. The definition that I'll use from the 
header file will keep the integrity of function type


