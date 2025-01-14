Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58302E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXjsF-00062R-KL; Tue, 14 Jan 2025 11:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tXjsD-00061B-A9; Tue, 14 Jan 2025 11:34:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tXjsA-0007iY-CW; Tue, 14 Jan 2025 11:34:36 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EFUKdO020097;
 Tue, 14 Jan 2025 16:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=b6H7NS
 +hC1CS4WJm0yAKm3OEKxFMoKKtrT0iOmXgCz8=; b=dqR13Ftf/jIXuWLti1QuWr
 rD6JRu9Unmd2tn9KnyMcc6CvX1mkL9C2u5BQlUqsc64e9r+eR2h/Zl2myg9642hQ
 ZA7XayPLQ5/xYKhpsPj3mYUHWfZNYUrKa5iJ2wAkd/gG4jc0X1wyq+T/Nj2ytzU9
 0ezaVHqke517pz/yi1DTTTU4oIPo9skjeNgyNuX9hYckH/tVLmotVpc9gKYnel4t
 kFl/gbuUvlehcY89aR2yrHuHybPJ1ZA2Qaa/p8jjyxgetHZd+qNBPt9PVlISvjdz
 x2U2JEAWMhVK7bOaiIEC0Zqb7wRYpS8EX+8hJGsM+ao5bwyCaGKpJixbR1BBN2rw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445tmgg9ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 16:34:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EDdBiw002693;
 Tue, 14 Jan 2025 16:34:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by44dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 16:34:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50EGYRxJ64880944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 16:34:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF65C5805E;
 Tue, 14 Jan 2025 16:34:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EB3758059;
 Tue, 14 Jan 2025 16:34:26 +0000 (GMT)
Received: from [9.61.248.9] (unknown [9.61.248.9])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jan 2025 16:34:26 +0000 (GMT)
Message-ID: <38d5c9ea-f6cc-4260-9bba-6a0e47ec5e7a@linux.ibm.com>
Date: Tue, 14 Jan 2025 11:34:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Report vfio-ap configuration changes
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 borntraeger@linux.ibm.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107140634.35cb33ba.alex.williamson@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <20250107140634.35cb33ba.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ElqUoi-FrviCDC1G-8TAkQ0s6A6TZERR
X-Proofpoint-ORIG-GUID: ElqUoi-FrviCDC1G-8TAkQ0s6A6TZERR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=736 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.794, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/7/25 2:06 PM, Alex Williamson wrote:

> Why are configuration changes to the device allowed while the device is
> in use?
>
> Would a uevent be considered an inefficient mechanism?  Why?
>
> Thanks,
> Alex

I believe a vfio device is typically used to pass through a single I/O 
device, like a VGPU or PCI device. VFIO allows direct access to the 
memory of the underlying device to perform the I/O. Our vfio device does 
not follow that model. It represents a guest's AP configuration, not 
individual AP devices. Granting guest access to the AP devices in the 
configuration is controlled outside of VFIO. The purpose of the mediated 
device is to provide a means for specifying the AP configuration for the 
guest. When the mediated device is attached to the guest, the vfio_ap 
device driver sets the AP configuration assigned to the mdev into the 
control blocks used to start the guest.

We could use the sysfs attributes of the mediated device to do hot 
plug/unplug of devices for the guest. The vfio_ap host device driver 
would perform the hot plug/unplug via an IBM Z mechanism. It was left up 
to the AP bus driver running in the guest to detect these changes via a 
polling mechanism. My patches allow us to notify the AP bus driver 
immediately - via an eventfd to userspace - of those changes which is 
far more efficient than relying on a polling mechanism.


