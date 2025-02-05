Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99B9C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjMN-00067j-GA; Wed, 05 Feb 2025 12:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfjMK-00067D-EE; Wed, 05 Feb 2025 12:38:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfjMI-0001dP-PB; Wed, 05 Feb 2025 12:38:44 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515F1laW001815;
 Wed, 5 Feb 2025 17:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9b1eS1
 F0KiE9G0EB/RzDRg//BB7W5NuD730cIcebpWE=; b=AG5rCRlWx9YSoKN6s251Wu
 GYaWhiqZ/RKFDrT4ZQOr2ris2fUipAzY58/vaP3R90Qf8UsCQzZKvw976+KwrSrh
 pXr1rf1Trs+htCcFctB299E4PdQZmAMfAGXah647TsrrS6/S40HoJQnXNeDE99A3
 ZA3w8P+15UQOA3yX6oIGkqZJUW7mxCHSDelFYLvkBLm0nQz4XxBZcfDwmzBE1eqx
 Z1qojV0OeHPu4yr0Rnzu5EvjCmeL086NOp5KnFf9jpJJ8c7W/fvNHcivkJC8WDab
 u6sx8YZOfeK9Amb/OFpbD/n4KkcbwxGuR9nCrNuWJQG7SS5gRLVxYTVTxO7DBvEg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ma8yrwph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2025 17:38:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515HYBtu021477;
 Wed, 5 Feb 2025 17:38:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1hnk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2025 17:38:38 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 515Hca4632309972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2025 17:38:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CCC958054;
 Wed,  5 Feb 2025 17:38:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2201E5805A;
 Wed,  5 Feb 2025 17:38:35 +0000 (GMT)
Received: from [9.61.244.212] (unknown [9.61.244.212])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Feb 2025 17:38:35 +0000 (GMT)
Message-ID: <8633a62e-eb18-4b87-ae35-600c076034b5@linux.ibm.com>
Date: Wed, 5 Feb 2025 12:38:34 -0500
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
X-Proofpoint-ORIG-GUID: wJF2OZ8Z0-L7v0wMVIY2aFBkxzqEdLyx
X-Proofpoint-GUID: wJF2OZ8Z0-L7v0wMVIY2aFBkxzqEdLyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=846 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
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


On 1/7/25 2:06 PM, Alex Williamson wrote:
> On Tue,  7 Jan 2025 13:43:49 -0500
> Rorie Reyes <rreyes@linux.ibm.com> wrote:
>
>> This patch series creates and registers a handler that is called when
>> userspace is notified by the kernel that a guest's AP configuration has
>> changed. The handler in turn notifies the guest that its AP configuration
>> has changed. This allows the guest to immediately respond to AP
>> configuration changes rather than relying on polling or some other
>> inefficient mechanism for detecting config changes.
> Why are configuration changes to the device allowed while the device is
> in use?
>
> Would a uevent be considered an inefficient mechanism?  Why?
>
> Thanks,
> Alex
>
Hey Alex,

Sorry for the long delay, but to answer your question, the VFIO device 
is typically used to pass through a single I/O

device, like a VGPU or PCI device. VFIO allows direct access to the 
memory of the underlying device to perofrm the I/O.

Our VFIO device does not follow that model and it represents a guest's 
AP configuration, not an individual AP device. Granting

guest access to AP devices in the configuration is controlled outside of 
the VFIO. The purpose of the mdev is to provide

a means for specifying the AP configuration for the guest. When the mdev 
is attached to the guest, the vfio_ap device driver

set the AP configuration assigned to the mdev into the control blocks 
used to start the guest.


