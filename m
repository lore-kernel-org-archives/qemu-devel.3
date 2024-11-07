Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA21FD5D689
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t99Kj-0004FK-Gn; Thu, 07 Nov 2024 15:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t99Ki-0004Er-2b; Thu, 07 Nov 2024 15:42:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t99Kg-0000vE-8p; Thu, 07 Nov 2024 15:42:23 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7KeCJ5032620;
 Thu, 7 Nov 2024 20:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Kk12Nh
 cYM+jn08x3N73UIbM3Eh4m9IExz9BzV/rR3OI=; b=afG3mvh6enKxk+pQBKg7gm
 oOpaCeKYZSmr94oOsgYCA1ttocDM5L0tGioJueegQNi+dQkPFfyDsS599pFSJYXo
 UdGvYKvaNnO5RsX30gCQgcFuSHwvvUQRg6MLEKpSygapOSHH4oYuwIn8UJR4GvIQ
 X65//Kz00bBX9o4WfkKusmYwgGjUdyG2jfdPDZ/DacrWADJccj6R/SFXYS3HZaNX
 Qj/tKNYc9Cr/wsGONVwYbFsv2JArW7FgQ0qqyrab7vlupf+D0+JbGqimq6SbgwA8
 1o2k3TB05kzh825irp6ymYsCMqh/JBgKpmkkFxLOKW/xnhYE0PtX26UN15+Dyagw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s4sng089-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 20:42:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7JxsGc023916;
 Thu, 7 Nov 2024 20:42:18 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxt02nc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 20:42:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A7KgHC28389162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Nov 2024 20:42:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 949E858057;
 Thu,  7 Nov 2024 20:42:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32F3558058;
 Thu,  7 Nov 2024 20:42:17 +0000 (GMT)
Received: from [9.61.96.17] (unknown [9.61.96.17])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  7 Nov 2024 20:42:17 +0000 (GMT)
Message-ID: <af01b629-7df1-4f55-9b18-3f3bc1d393c9@linux.ibm.com>
Date: Thu, 7 Nov 2024 15:42:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] s390x: Add Full Boot Order Support
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel@nongnu.org
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <7800f880-d362-40b6-aaef-2085dcb78ad0@redhat.com>
 <c5bff27a-0aae-4356-9403-89d126426610@linux.ibm.com>
 <6d6466b5-1d6c-49b3-abb0-f268aa617c6a@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <6d6466b5-1d6c-49b3-abb0-f268aa617c6a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tS3P9ZmWMRJ_n-CDUUOyWBaUrstu3CD6
X-Proofpoint-ORIG-GUID: tS3P9ZmWMRJ_n-CDUUOyWBaUrstu3CD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 11/6/24 6:10 AM, Thomas Huth wrote:
> On 05/11/2024 17.42, Jared Rossi wrote:
>> Hi Thomas, Sebastian,
>>
>> It looks like this is simply caused by the "is_cdrom" value only ever 
>> being set
>> to true.  I think it is a one-line fix that just makes sure to 
>> initialize the
>> value to false each time we try a new device:
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index a4d1c05aac..3fdba0bedc 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -214,6 +214,7 @@ static void boot_setup(void)
>>   static bool find_boot_device(void)
>>   {
>>       VDev *vdev = virtio_get_device();
>> +    vdev->is_cdrom = false;
>>       bool found = false;
>>
>>       switch (iplb.pbt) {
>>
>> I tested it with the two scenarios you mention and with the existing 
>> qtests,
>> and it seems to work correctly now.
>
> Agreed, this seems to fix the issue when all devices are properly 
> marked with bootindex properties. But it still persists in case the 
> BIOS has to scan for the boot device, e.g.:
>
> qemu-system-s390x -accel kvm -m 2G -nographic \
>  -drive if=none,id=d1,file=/tmp/bad.dat,format=raw,media=cdrom \
>  -device virtio-scsi -device scsi-cd,drive=d1 \
>  -drive if=none,id=d2,file=good.qcow2 -device virtio-blk,drive=d2
>
> Isn't there a better place to set the is_cdrom variable?
>
>  Thomas
>

Hi Thomas,

What I found is that the original issue with clearing the "is_cdrom" 
value is
just as easily fixed for both indexed devices and probed devices by moving
where "is_cdrom" is set to false:

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a4d1c05aac..7509755e36 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -242,6 +242,7 @@ static bool find_boot_device(void)
  static int virtio_setup(void)
  {
      VDev *vdev = virtio_get_device();
+    vdev->is_cdrom = false;
      int ret;

      switch (vdev->senseid.cu_model) {

Unfortunately when verifying the fix I found another unrelated issue with
probing, which is that only the first device attached to the scsi controller
will be found.  This is because virtio_scsi_setup() itself contains a 
probing
loop to find a LUN when none is specified, and, unsurprisingly, it returns
the first thing it finds attached to the controller.  As a result, the main
device probing loop will move on after trying only one LUN per controller.

Fixing this won't be a simple one-liner because it will require 
implementation
of nested probing for scsi devices, such that all LUNS on the controller are
probed before moving to the next device.

Regards,
  Jared Rossi

