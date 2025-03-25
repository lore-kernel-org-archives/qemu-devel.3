Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4584BC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx8EK-0000rS-I1; Tue, 25 Mar 2025 13:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx8EI-0000r8-Kx; Tue, 25 Mar 2025 13:38:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx8EG-00022d-Qi; Tue, 25 Mar 2025 13:38:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCS9Om012569;
 Tue, 25 Mar 2025 17:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GPvyRy
 yLcYdvXxwIzgNUofGZLjxOMwN7Pu4qWVHfWds=; b=kxC8yD833FHJ2ISJj6aUIR
 KaBmVv8szotMlRfvBHzmeLQ/O3KNseoIHe6mJ7kK8kG2jZKxUTB9zq/+gUlBZro/
 7IVAqw83wG8k5Q6sZU6xHwJ+3B7jFogQMsXnjAu/JLaTmCwHlOXTRTsXQyAT5S18
 bmXBFOTWTjQuzdo2+KvhtoXNQ1HaZX6jPRatQMG3hdZBsIWLyqh61xb/sdCqrf0C
 OyvYoUrbK6CDsSoauzl8+8ipZmy0dPKBb2zIP/9q2x/ZYuEGwPkH6sYcqNCuTFEI
 8AruInOSXsCRbgT4Q/cbJPiW8evCxLNZVjSD/rVToHdQQrylvjl3VY1dq//l6U/w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kvh31phs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:38:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PHaaqa013475;
 Tue, 25 Mar 2025 17:38:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kvh31php-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:38:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGxmtx012262;
 Tue, 25 Mar 2025 17:38:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91m4evu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 17:38:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PHcB5d42140022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 17:38:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07B2420043;
 Tue, 25 Mar 2025 17:38:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E64D20040;
 Tue, 25 Mar 2025 17:38:09 +0000 (GMT)
Received: from [9.39.16.55] (unknown [9.39.16.55])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 17:38:08 +0000 (GMT)
Message-ID: <6d610966-cdc0-42c2-abb8-e80b4be1178d@linux.ibm.com>
Date: Tue, 25 Mar 2025 23:08:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ppc/pnv: Introduce Power11 PowerNV machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-8-adityag@linux.ibm.com>
 <952b3afa-dc63-4230-bdff-5decabc8c25c@kaod.org>
 <8567b41e-f2b8-413c-93b8-15c74788c171@linux.ibm.com>
 <5a08e139-a18d-4aae-836f-0ec0bb8fadc9@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <5a08e139-a18d-4aae-836f-0ec0bb8fadc9@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4pdOF4weGgu6_LbsCkSZ5UJMJ9ka9eMQ
X-Proofpoint-GUID: LA5IYh6ddNkSopXqf4QZvhI_up6o3FDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=825 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/03/25 22:45, Cédric Le Goater wrote:

> On 3/25/25 18:07, Aditya Gupta wrote:
>> On 25/03/25 20:17, Cédric Le Goater wrote:
>>
>>> On 3/25/25 12:23, Aditya Gupta wrote:
>>>> <...snip...>
>>>>
>>>> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>>>
>>> There was a lot of work done to have dynamic PHBs in the PowerNV
>>> machines. This was to add support in libvirt and this goal was
>>> abandoned when people left. I think we should consider removing
>>> it as it adds unnecessary complexity.
>>>
>> Thanks for telling the history behind it, agreed this is unnecessary, 
>> will remove in v7.
>
> One nice about it IIRC was being able to tune the number of
> PHBs per chip, which reduced booting time (for 16s) and also
> provided support to test various chip configs. Check that first.
>
I tried some variations of 'device_add/device_del'. Unable to see how to 
dynamically add/remove phbs.

Do you have any options to device_add/del which I can try, I want to see 
if the dynamic addition/removal of PHB changes if i remove that 
'_allow_dynamic_sysbus_dev' call.


> Also, you should add functional tests for the powernv11 machine.
>
> See under tests/functional/test_ppc64_powernv.py.
>
Currently the test uses op-build kernels, which don't support Power11, 
working on that side, will post as soon as op-build creates a new 
release with p11 support (any linux >= 6.9).


Thanks,

- Aditya Gupta

>
> Thanks,
>
> C.
>

