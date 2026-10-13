Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED1DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGhrh-0004ue-5W; Tue, 13 Oct 2026 15:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGhrS-0004ts-Ub; Tue, 13 Oct 2026 15:08:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGhrN-00069v-SG; Tue, 13 Oct 2026 15:08:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DDRRKI1775178; Tue, 13 Oct 2026 19:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1uxYLS
 T2BnijjQNU0sqCpOywqn+d0NZLsFDVB0fgMPo=; b=IsHlAZc2pQnkPdyLZMZwKi
 vB2Bd2ue1xuEl0VXnYqj1G+CHiSXyqeoqS7R9xK+zANkU+rMcIJcNHM7O2lxGMu0
 uSvppr68PdbEE6TRu6bVe9IPOldntBKmxpkDEBc9GuHMkl0/M/FdYEmcwHX714MX
 a2QnjFoMb1FGQUYDCCDc6M9UDa+YPXAjTPer0wifoKtZBUEyTL62KspNY0Mpkd1E
 mmquub4Lvyt1lPEngId61J26ySLEBL6FPrlW7BrPzYjOtWIG9ikWIwMEl8T6D0Ka
 LhLQufAhtE1PxftY81T4NrwQgF3aKdoFPyGyVjYBLdvnw9fEt2+V/HfCBAymmHWQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhyyej-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:08:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DIMaAT1440160; Tue, 13 Oct 2026 19:08:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg3kuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:08:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DJ8Idh42664390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 19:08:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CB6420040;
 Tue, 13 Oct 2026 19:08:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 245E52004B;
 Tue, 13 Oct 2026 19:08:18 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 19:08:18 +0000 (GMT)
Message-ID: <83590b67-3a00-4534-a4e8-9ccf335ddf31@linux.ibm.com>
Date: Tue, 13 Oct 2026 21:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests/108: probe loop device setup
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20261013182804.103882-1-iii@linux.ibm.com>
 <as59GEf23kbWM-Kc@redhat.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <as59GEf23kbWM-Kc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfXzuACnn13c6yY
 hXetmjSzvd76eJQr2PR/MgqzrHtdg25l3xnCwRwQ/9/Y7l2KS8dcEOtTU0LKVYY8kLMuY5qC9f7
 nkLHfuHAWsfdnkn1e9ptnu3J9MXjalu9tuspwY4Q8M1YUTCu/K3aoPPXiTPlAblIlMj9m83pNbr
 K1xwMo9jkj7sI344pXZ12HbbS7iYaBePZRMSPSCwt5poSFh7eG4Mn24XfBmJCrubVIpEJ1mWuaP
 0jU5eNwQEpgUCsPIKM++++RVZp1AzxKq1VvUYPi31d5lbi4C0vzX/Ekpti3p4oAAk9R5rELllo2
 GPDFwEQzi9ZoChGhO55UoYFciy2B4SpluNbN9Qw5lx6BXqzhTm1AwRIakvd0hmtAmuOa9GF3t2t
 xaykC+lo55DSBm3yuEBkrpU09n29ffyXxM2E9LBb7hkxbVKGFZbitO7Y4NydKj4sbYqsTptcYSc
 /vouNU8uR1qFV3UZwsw==
X-Proofpoint-GUID: UBPyempd1sGs4RXfQSyxcUDg0EPy77AJ
X-Proofpoint-ORIG-GUID: UBPyempd1sGs4RXfQSyxcUDg0EPy77AJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfX2qrHbXFDdPzb
 kUledcRNhG7hGaqPPeWx/85xqVESqJ4P+cmHotsW1iBYIW+0HKwbsoSRbDuqkf/IULt/Sn+7YuD
 ofP9CgRUWir09Q1my6+j3Qn+a+Y0HwA=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ace81a4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Y_TtDOBzAAAA:20
 a=VnNF1IyMAAAA:8 a=sHSCvQiqtbygQqz67NoA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 10/13/26 20:53, Eric Blake wrote:
> On Tue, Oct 13, 2026 at 08:28:00PM +0200, Ilya Leoshkevich wrote:
>> Running iotests/108 in a Docker container, that has passwordless sudo
>> configured, fails with:
>>
>>      losetup: /home/user/src/qemu/build/scratch/qcow2-file-108/t.qcow2: failed to set up loop device: No such file or directory
>>
>> because it incorrectly assumes losetup is allowed to do loop device
>> setup, when in reality it can only list devices.
>>
>> Fix by probing loop device setup, using the test script as a backing
>> file. With this, the test is correctly skipped.
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>   tests/qemu-iotests/108 | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
>> index 1de718188aa..adbaaf87095 100755
>> --- a/tests/qemu-iotests/108
>> +++ b/tests/qemu-iotests/108
>> @@ -53,7 +53,8 @@ _supported_os Linux
>>   _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file
>>   
>>   # This test either needs sudo -n losetup or FUSE exports to work
>> -if sudo -n losetup &>/dev/null; then
>> +if probe_dev=$(sudo -n losetup -r --show -f "$0" 2>/dev/null); then
>> +    sudo -n losetup -d "$probe_dev"
> 
> Is 'sudo -n losetup -f' a simpler test?  It prints out the next
> /dev/loopN value available only if a mount would succeed, which means
> that it is a stronger test than the existing 'sudo -n losetup', but
> also does not require a subsequent cleanup.

I don't think 'losetup -f' attempts a mount, since it works fine without
privileges:

$ id -u
1000
$ losetup -f
/dev/loop0
$ losetup -r -f /bin/true
losetup: /bin/true: failed to set up loop device: Permission denied

A quick glance at the source code [1] seems to confirm this: the
iterator is immediately discarded after finding a free device name.
The loop-control logic above looks similar.

[1] 
https://github.com/util-linux/util-linux/blob/v2.42.4/lib/loopdev.c#L1760


