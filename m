Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E93C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAWg-0007qH-Ev; Wed, 30 Apr 2025 12:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uAAWe-0007p0-7d
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:43:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uAAWc-0001I6-Cq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:43:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UAepD6010938;
 Wed, 30 Apr 2025 16:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zt86W+
 j1fy60rZRUvqomhtAu3bdSdwgRjVbIjdPk6gY=; b=B8P9syP28xV+3daxC1lcn2
 Id4ZaG+xfEUH/1ju5222eydvUA45tnGKd4Bs2Uwnn8UX01C9f6OoT9J8dPOJcD2l
 t0C+bSUprPrCfxOSXUIQAl1Urq6SuIh674LNLhm9LLtoDYbtzuza2Gz+WPfM6QIr
 fpWyU4wJLxgesWQ/SWBaU4gifMJurJ7LBZHN8U/H34AUXHHCalU1ZPaJl30nTomV
 rSsXFA8AAjCkIYnrmj1wLYufNr9EbG0naHcFdo0t5LjaZGCu2x/4iMp3I9Q++UO9
 BxaCfKrXTfaYY6wYUvftaAnyKIc9qC/iY5J4i4b1Kotagz+B279L5ORkrDkcEKrw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bjas1scc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 16:43:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDI2vA001893;
 Wed, 30 Apr 2025 16:43:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamrnkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 16:43:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53UGgxxK15991358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 16:42:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 973A058052;
 Wed, 30 Apr 2025 16:42:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A708A5805D;
 Wed, 30 Apr 2025 16:42:57 +0000 (GMT)
Received: from [9.61.242.230] (unknown [9.61.242.230])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Apr 2025 16:42:57 +0000 (GMT)
Message-ID: <cf1fffb7-1a37-4df5-8cf4-fa08d63368c9@linux.ibm.com>
Date: Wed, 30 Apr 2025 09:42:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] util: Add functions for s390x mmio read/write
To: Heiko Carstens <hca@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, stefanha@redhat.com,
 mjrosato@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-2-alifm@linux.ibm.com>
 <06f9244c-671c-4215-9d20-7bb69194fae6@redhat.com>
 <aae585ad4d9884e204ff1f153f4d1be5453b284a.camel@linux.ibm.com>
 <20250425140929.7180Fdb-hca@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250425140929.7180Fdb-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a5D7CZ1XP7i3OdKvoAXYMGaabYmKSBm3
X-Proofpoint-ORIG-GUID: a5D7CZ1XP7i3OdKvoAXYMGaabYmKSBm3
X-Authority-Analysis: v=2.4 cv=LKNmQIW9 c=1 sm=1 tr=0 ts=68125315 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=DOTw15dRPa_roqCFQC4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDExOSBTYWx0ZWRfX/1tBh/r8hVdq
 PoiJJimXV/IMr2phf2m58EEzNsUPky+peUmGrNXyiwG1sHwqhPZ13ZZw0quImHCEyItVpZNVNkT
 b20BAJbycGUEzRBUMFkGmra2oI9azcuqBcND3TPuDqN3b7amcxbkNR2yx97XD7F3BCKw9pt4IFw
 To0s6S0OP4/omgvo8iKRRVj9dXroD38LRcuGofgrKSij1koMlP0xeT6jGYPvL7Arm+LlZAQT9j0
 8r6R+tz/7SCCLSWyTZ0B8nc6+/lDVqF6yCLVO4WytUmIBF/bh7UGD3de+kuRTcLsL+oWN2zKhV8
 25s1KzzNzuouYd3a2/x4A+n+ijYM9XLtCEIWH8ioIznS3EGTqCXhhJvxlCZwj4hp/rbI5a79vso
 +8+k/VYpgwjF+tuUACiu7lgvuTjR6DvSSbpd73mytaz1xVI+FeZlUi6EioOdqu2e4Bk7uZVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=546 clxscore=1015
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/25/2025 7:09 AM, Heiko Carstens wrote:
> On Fri, Apr 25, 2025 at 12:29:35PM +0200, Niklas Schnelle wrote:
>> On Fri, 2025-04-25 at 11:00 +0200, Thomas Huth wrote:
>>> On 17/04/2025 19.37, Farhan Ali wrote:
>>>> +    asm volatile(
>>>> +        /* pcilgi */
>>>> +        ".insn   rre,0xb9d60000,%[val],%[ioaddr_len]\n"
>>>> +        "ipm     %[cc]\n"
>>>> +        "srl     %[cc],28\n"
>>>> +        : [cc] "=d"(cc), [val] "=d"(val),
>>>> +        [ioaddr_len] "+&d"(ioaddr_len.pair) :: "cc");
>>> Do we need the "&" modifier here? ... at least the kernel does not seem to
>>> use it ...
>>  From my understanding it's not strictly needed, but I also used it in
>> the rdma-core user-space code where I had pointed Farhan. I looked at
> It is not needed, since all inputs are consumed before to any output
> is written to.

Ack, will update the patch.


>>>> +    asm volatile (
>>>> +        /* pcistgi */
>>>> +        ".insn   rre,0xb9d40000,%[val],%[ioaddr_len]\n"
>>>> +        : [ioaddr_len] "+&d" (ioaddr_len.pair)
>>> dito
> Same here, it is not needed.

Ack, will update the patch here as well.

Thanks
Farhan



