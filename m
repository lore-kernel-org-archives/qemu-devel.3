Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F85C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQpr-0000dY-E6; Thu, 16 Jan 2025 09:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQpo-0000co-Lo; Thu, 16 Jan 2025 09:27:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQpn-0007X6-7t; Thu, 16 Jan 2025 09:27:00 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G8646p021118;
 Thu, 16 Jan 2025 14:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5UyopB
 KL6FUpLOBTregaYabkTM69ktH4YnES0zugdAk=; b=mPFKvLb7fr9HFFG7YVPTuv
 LjWUQAIs3AsAANWce85bcCvdkPefwkOaGmNHtqKgYl8XEcgLbycFdCN14L6ULcFi
 C5M2qDgjt20ioNMXtXiMcyHsayPQSzRjqA/TWgm10kyk5sMVjQojxrvXrKHDZhZX
 WbA4NeC1Rsq1hH4mg84awq7wavTxeegSczZFDQ1i/MwvfliiaIWFwdcFiu84UxvK
 4s0UAGM8CknTDkBHiS83CMDvIYo9WJ3SQG6KbPtZq3t1wcRoc6DmPlJxX2MM5nxq
 1ddGmLpTAtu7B/xn3j43+TR93inF0jcGbyRlbGw4AgIcGV1vUxHLhc47Ik2XbXhg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa39rsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:26:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GB8OMl016582;
 Thu, 16 Jan 2025 14:26:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1wuh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:26:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GEQuZc28902136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 14:26:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51FD758062;
 Thu, 16 Jan 2025 14:26:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1D2E58056;
 Thu, 16 Jan 2025 14:26:55 +0000 (GMT)
Received: from [9.61.78.171] (unknown [9.61.78.171])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 14:26:55 +0000 (GMT)
Message-ID: <2c96f4ae-97d7-455a-a236-a8a8e99c1e56@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:26:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] pc-bios/s390-ccw: Fix problems related to network
 booting
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>
References: <20250116115826.192047-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250116115826.192047-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L0Cms0K_jCnjOzPegKrHI9J4st2h3TwH
X-Proofpoint-ORIG-GUID: L0Cms0K_jCnjOzPegKrHI9J4st2h3TwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=906 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Thanks Thomas,

Looks good to me. I've tested and verified that the problem is fixed.

Tested-by: Jared Rossi <jrossi@linux.ibm.com>

On 1/16/25 6:58 AM, Thomas Huth wrote:
> The boot can currently fail after the s390-ccw bios used a network
> device since we do not properly shut down the device afterwards, so
> that incoming network packets can corrupt the memory. We have to make
> sure to put the virtio-net device into a sane state again afterwards.
>
> The third patch is unrelated, but I spotted this rather cosmetic
> problem while working on the code in netmain.c, so I included it here,
> too.
>
> Thomas Huth (3):
>    pc-bios/s390-ccw/virtio: Add a function to reset a virtio device
>    pc-bios/s390-ccw: Fix boot problem with virtio-net devices
>    pc-bios/s390-ccw/netmain: Fix error messages with regards to the TFTP
>      server
>
>   pc-bios/s390-ccw/virtio.h     |  2 ++
>   pc-bios/s390-ccw/netmain.c    | 52 +++++++++++++++++++++--------------
>   pc-bios/s390-ccw/virtio-net.c |  5 ++++
>   pc-bios/s390-ccw/virtio.c     |  7 ++++-
>   4 files changed, 44 insertions(+), 22 deletions(-)
>


