Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7527FC27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 19:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFIh0-00053p-P6; Thu, 06 Jun 2024 15:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sFIgy-00053J-Qy; Thu, 06 Jun 2024 15:22:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sFIgw-0006qv-LL; Thu, 06 Jun 2024 15:22:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 456JH0pi023000; Thu, 6 Jun 2024 19:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=3xrS8c12I8Uybg8vWbOP1KYSpNg6VnOvHBHSSF7qoPo=;
 b=IAenTbGDVZue8H8sxa2ABle1BbYn/OUV3CiyLH/O2m+SLkMDGBBeb3UQfkRxwMTDlvW4
 JNeq4XGtv3esziHYq/1ojEg81fPyZVuuhzTrUxqL6pyAZz640TwW/l2cWU2HMWQiiSIW
 sHcCJCZU9AlV67SF59FeVRQ/GbXSdeOGMCRUD73VnYYUW520eZdyheYnOUnWlvgNnz1h
 ZEDgRQrqzTu4fVDxzc7179o6x3U3GoPZ23hsCks2DdRjKaPgDveLuVddDZTYwiVwckut
 A0B2C4idpsw5N/vEGdlIv4kW8GfdrsIPOc/EA7z5VXEgI7Fqrr+IP41meidY2e8v7MzW EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykk4rr0cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 19:22:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456JMRVO031402;
 Thu, 6 Jun 2024 19:22:27 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykk4rr0ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 19:22:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 456HtYdH000815; Thu, 6 Jun 2024 19:22:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdyuchme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 19:22:26 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 456JMMax2359938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2024 19:22:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8C1658066;
 Thu,  6 Jun 2024 19:22:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 357F458063;
 Thu,  6 Jun 2024 19:22:22 +0000 (GMT)
Received: from [9.67.184.112] (unknown [9.67.184.112])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Jun 2024 19:22:22 +0000 (GMT)
Message-ID: <f9d9e666-7ed5-4acb-af25-884ca5e92615@linux.ibm.com>
Date: Thu, 6 Jun 2024 15:22:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] s390x: Add Full Boot Order Support
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <24bbebeb-9ce4-4f0f-9ae8-8a8ebf5979ed@redhat.com>
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <24bbebeb-9ce4-4f0f-9ae8-8a8ebf5979ed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s3W4T0ixHVqdi0XMi1RDtz78wor45zYs
X-Proofpoint-GUID: aUd4F7RsONSvQhNG7LmIq8uIaOhBLXla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_15,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=987 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406060133
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/5/24 4:02 AM, Thomas Huth wrote:
> On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> This patch set primarily adds support for the specification of 
>> multiple boot
>> devices, allowing for the guest to automatically use an alternative 
>> device on
>> a failed boot without needing to be reconfigured. It additionally 
>> provides the
>> ability to define the loadparm attribute on a per-device bases, which 
>> allows
>> boot devices to use different loadparm values if needed.
>>
>> In brief, an IPLB is generated for each designated boot device (up to 
>> a maximum
>> of 8) and stored in guest memory immediately before BIOS. If a device 
>> fails to
>> boot, the next IPLB is retrieved and we jump back to the start of BIOS.
>>
>> Devices can be specified using the standard qemu device tag 
>> "bootindex" as with
>> other architectures. Lower number indices are tried first, with 
>> "bootindex=0"
>> indicating the first device to try.
>
> Is this supposed with multiple scsi-hd devices, too? I tried to boot a 
> guest with two scsi disks (attached to a single virtio-scsi-ccw 
> adapter) where only the second disk had a bootable installation, but 
> that failed...?
>
>  Thomas
>
>

Hi Thomas,

Yes, I would expect that to work. I tried to reproduce this using a 
non-bootable scsi disk as the first boot device and then a known-good 
bootable scsi disk as the second boot device, with one controller.  In 
my instance the BIOS was not able to identify the first disk as bootable 
and so that device failed to IPL, but it did move on to the next disk 
after that, and the guest successfully IPL'd from the second device.

When you say it failed, do you mean the first disk failed to boot (as 
expected), but then the guest died without attempting to boot from the 
second disk?  Or did something else happen? I am either not 
understanding your configuration or I am not understanding your error.

Regards,

Jared Rossi

