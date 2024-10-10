Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291FCEDDAB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syi7q-0002uc-H7; Wed, 09 Oct 2024 21:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7h-0002tv-KB; Wed, 09 Oct 2024 21:37:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7f-0007UZ-Bb; Wed, 09 Oct 2024 21:37:49 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499NwlB3013186;
 Thu, 10 Oct 2024 01:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=M
 1itT2cpni1vP9oMgY0PXDDUkfMmuNE/BIlhRQpBbRk=; b=kHCJG84hFgOiGJXeJ
 FYVXtZbuIPSYQHF6mtxRZxkleSVl7A+64LhdO3Al+x5wCIgnGhLnegKM1ZAc3yYF
 opXJU6BP6aJqqFcUxcwYmolcvcrNMbSLuePwEwsTHE7L2hH/1UgYjvCDPa/2IPhH
 VUiGPy/2liiZVmYZ4pAqd6U356fyI8Ki7ug6agv2G+JuaMl2xr+HWNCpFUdK/760
 2+beT0xPHagFzrop539npCkZNXZqlDHwmxHNlRUsv5itgfqLzIMyMbdVmA9GNN2y
 cgY9ppMZm15k5RPtR/6UnAzXWVFJ4a7piuLy+HrvpgirKEL/xh36vD0AvbQEwNrt
 tcm+Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4263yt8990-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A1bhRQ009228;
 Thu, 10 Oct 2024 01:37:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4263yt898x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0qDJq011512;
 Thu, 10 Oct 2024 01:37:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xwa8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A1bg2p22086308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 01:37:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E389258056;
 Thu, 10 Oct 2024 01:37:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B46E58052;
 Thu, 10 Oct 2024 01:37:41 +0000 (GMT)
Received: from [9.61.177.235] (unknown [9.61.177.235])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Oct 2024 01:37:41 +0000 (GMT)
Message-ID: <95a53006-7a91-4f9c-a421-a11796af134d@linux.ibm.com>
Date: Wed, 9 Oct 2024 21:37:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] tests/qtest: Add s390x boot order tests to
 cdrom-test.c
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-20-jrossi@linux.ibm.com>
 <f483f958-5b42-42f6-9bd6-c4b1f8fe8d7a@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <f483f958-5b42-42f6-9bd6-c4b1f8fe8d7a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ebxvasr88rliBwWHnvQw-p5ASv4Gu9wm
X-Proofpoint-ORIG-GUID: agmURvV6hoFCAMFex6mOydmnBXnfkimF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_22,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100005
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/9/24 8:48 AM, Thomas Huth wrote:
> On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Add two new qtests to verify that a valid IPL device can successfully 
>> boot after
>> failed IPL attempts from one or more invalid devices.
>>
>> cdrom-test/as-fallback-device: Defines the primary boot target as a 
>> device that
>> is invalid for IPL and a second boot target that is valid for IPL. 
>> Ensures that
>> the valid device will be selected after the initial failed IPL.
>>
>> cdrom-test/as-last-option: Defines the maximum number of boot devices 
>> (8)
>> where only the final entry in the boot order is valid. Ensures that a 
>> valid
>> device will be selected even after multiple failed IPL attempts from 
>> both
>> virtio-blk and virtio-scsi device types.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   tests/qtest/cdrom-test.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>> index 9d72b24e4b..123c067589 100644
>> --- a/tests/qtest/cdrom-test.c
>> +++ b/tests/qtest/cdrom-test.c
>> @@ -213,6 +213,30 @@ static void add_s390x_tests(void)
>>                           "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d1 "
>>                           "-device virtio-blk,drive=d2,bootindex=1 "
>>                           "-drive if=none,id=d2,media=cdrom,file=", 
>> test_cdboot);
>> +    qtest_add_data_func("cdrom/boot/as-fallback-device",
>> +                        "-device virtio-serial -device virtio-scsi "
>> +                        "-device virtio-blk,drive=d1,bootindex=1 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d1 "
>> +                        "-device virtio-blk,drive=d2,bootindex=2 "
>> +                        "-drive if=none,id=d2,media=cdrom,file=", 
>> test_cdboot);
>> +    qtest_add_data_func("cdrom/boot/as-last-option",
>> +                        "-device virtio-serial -device virtio-scsi "
>> +                        "-device virtio-blk,drive=d1,bootindex=1 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d1 "
>> +                        "-device virtio-blk,drive=d2,bootindex=2 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d2 "
>> +                        "-device virtio-blk,drive=d3,bootindex=3 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d3 "
>> +                        "-device scsi-hd,drive=d4,bootindex=4 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d4 "
>> +                        "-device scsi-hd,drive=d5,bootindex=5 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d5 "
>> +                        "-device virtio-blk,drive=d6,bootindex=6 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d6 "
>> +                        "-device scsi-hd,drive=d7,bootindex=7 "
>> +                        "-drive 
>> driver=null-co,read-zeroes=on,if=none,id=d7 "
>> +                        "-device virtio-blk,drive=d8,bootindex=8 "
>> +                        "-drive if=none,id=d8,media=cdrom,file=", 
>> test_cdboot);
>
> Could you please use a scsi-hd for the good device here in the second 
> test, too? ... so we make sure that the good drive detection also 
> works with virtio-scsi devices and not only with virtio-blk devices.
>
>  Thanks,
>   Thomas
>

Do you mean use "scsi-cd" instead?

     Jared

