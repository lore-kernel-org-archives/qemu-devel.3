Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6B2C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 03:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGWBV-0007lZ-6R; Sun, 09 Jun 2024 23:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sGWBT-0007ks-4V; Sun, 09 Jun 2024 23:59:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sGWBR-0001pQ-6o; Sun, 09 Jun 2024 23:59:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A2VTD3019563;
 Mon, 10 Jun 2024 03:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
 fK/UXi7+S8voEzfPkdfX4jKC+LEAgeNn2tl8j0bWA8=; b=FW/Qf5W8gm4dUsiVr
 Mz7Tqjx+nQ5n6fkpyluWe6iTRd43O7N9sQpcX0rx+RTjPxdSarza9Bk7SxFm5FjH
 cMZkssI3yB+ug9GGx3wmCfm6z8+luTViSe0nQW/rDZCJoAOaehFHoqu5plPQTpV3
 hLv+05WBGbrbS75+5oWC7d91I48RSN99gFuC5SVWRspfZRObCDjWIZN+bSCJWgdU
 HFzz4ZMGWzJq7jNHN5jH3SWiPZiuPTU5i/KWdU0N+KRgS2imlqZ2X1njeRnVNA5o
 BBNQ7yYkU/W+JEZ3gh+euCvOCmEgXAcw6oQ+VpmmqTN3Ns0sRiUF+Rrs9+ICImzI
 nptag==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynrqx04xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jun 2024 03:58:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45A3wv2D015585;
 Mon, 10 Jun 2024 03:58:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynrqx04xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jun 2024 03:58:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45A2pEUw027267; Mon, 10 Jun 2024 03:58:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn210dgjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jun 2024 03:58:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45A3wrQS26542826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jun 2024 03:58:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 975AD5804E;
 Mon, 10 Jun 2024 03:58:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E2858060;
 Mon, 10 Jun 2024 03:58:52 +0000 (GMT)
Received: from [9.67.189.165] (unknown [9.67.189.165])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 10 Jun 2024 03:58:52 +0000 (GMT)
Message-ID: <b650a629-6f0b-41fd-93e3-87de48feba94@linux.ibm.com>
Date: Sun, 9 Jun 2024 23:58:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] s390x: Add Full Boot Order Support
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <24bbebeb-9ce4-4f0f-9ae8-8a8ebf5979ed@redhat.com>
 <f9d9e666-7ed5-4acb-af25-884ca5e92615@linux.ibm.com>
 <cf48d601-0686-4ebd-a113-1357441db61d@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <cf48d601-0686-4ebd-a113-1357441db61d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5xYumTvKwSPq_I_k0_FrTH173mqcxfOw
X-Proofpoint-GUID: wFq43h2nBazk64xd-FIYubg1zoUEw_c8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_18,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/7/24 2:19 AM, Thomas Huth wrote:
> On 06/06/2024 21.22, Jared Rossi wrote:
>>
>>
>> On 6/5/24 4:02 AM, Thomas Huth wrote:
>>> On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
>>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>>
>>>> This patch set primarily adds support for the specification of 
>>>> multiple boot
>>>> devices, allowing for the guest to automatically use an alternative 
>>>> device on
>>>> a failed boot without needing to be reconfigured. It additionally 
>>>> provides the
>>>> ability to define the loadparm attribute on a per-device bases, 
>>>> which allows
>>>> boot devices to use different loadparm values if needed.
>>>>
>>>> In brief, an IPLB is generated for each designated boot device (up 
>>>> to a maximum
>>>> of 8) and stored in guest memory immediately before BIOS. If a 
>>>> device fails to
>>>> boot, the next IPLB is retrieved and we jump back to the start of 
>>>> BIOS.
>>>>
>>>> Devices can be specified using the standard qemu device tag 
>>>> "bootindex" as with
>>>> other architectures. Lower number indices are tried first, with 
>>>> "bootindex=0"
>>>> indicating the first device to try.
>>>
>>> Is this supposed with multiple scsi-hd devices, too? I tried to boot 
>>> a guest with two scsi disks (attached to a single virtio-scsi-ccw 
>>> adapter) where only the second disk had a bootable installation, but 
>>> that failed...?
>>>
>>>  Thomas
>>>
>>>
>>
>> Hi Thomas,
>>
>> Yes, I would expect that to work. I tried to reproduce this using a 
>> non-bootable scsi disk as the first boot device and then a known-good 
>> bootable scsi disk as the second boot device, with one controller.  
>> In my instance the BIOS was not able to identify the first disk as 
>> bootable and so that device failed to IPL, but it did move on to the 
>> next disk after that, and the guest successfully IPL'd from the 
>> second device.
>>
>> When you say it failed, do you mean the first disk failed to boot (as 
>> expected), but then the guest died without attempting to boot from 
>> the second disk?  Or did something else happen? I am either not 
>> understanding your configuration or I am not understanding your error.
>
> I did this:
>
>  $ ./qemu-system-s390x -bios pc-bios/s390-ccw/s390-ccw.img -accel kvm \
>    -device virtio-scsi-ccw  -drive if=none,id=d2,file=/tmp/bad.qcow2 \
>    -device scsi-hd,drive=d2,bootindex=2 \
>    -drive if=none,id=d8,file=/tmp/good.qcow2 \
>    -device scsi-hd,drive=d8,bootindex=3 -m 4G -nographic
>  LOADPARM=[        ]
>  Using virtio-scsi.
>  Using guessed DASD geometry.
>  Using ECKD scheme (block size   512), CDL
>  No zIPL section in IPL2 record.
>  zIPL load failed.
>
>  Trying next boot device...
>  LOADPARM=[        ]
>  Using virtio-scsi.
>  Using guessed DASD geometry.
>  Using ECKD scheme (block size   512), CDL
>  No zIPL section in IPL2 record.
>  zIPL load failed.
>
> So it claims to try to load from the second disk, but it fails.
> If I change the "bootindex=3" of the second disk to "bootindex=1", it 
> boots perfectly fine, so I'm sure that the installation on good.qcow2 
> is working fine.
>
>  Thomas
>

I am able to reproduce this now; I'll investigate the problem.


