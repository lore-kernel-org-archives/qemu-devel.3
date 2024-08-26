Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84102C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 17:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sidBT-0005Nd-R7; Mon, 26 Aug 2024 13:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sidBR-0005LI-93; Mon, 26 Aug 2024 13:07:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sidBP-0007BC-8U; Mon, 26 Aug 2024 13:07:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QGAcpW005258;
 Mon, 26 Aug 2024 17:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:references:from:cc
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=M
 aNmAufTAlbwnuudvPI5ud5lf2/tFPxWRiagFcDPdXM=; b=PaVdV7XhSGCwLK9Qi
 48Utyfj/scws6/P8PhB+f4H8JMyiK8tlb0wya9c8L68KUCRWxhRY9ZG+DIpofPf/
 81585+ilXmHSrm24j6WBw9/sG9/fvGJcyvnvq9oYbFizB5qbIIEGrB2NlQl2kyzQ
 4HLPBraBWdnEXjYibEbKfuNqmlQ0kSCgK254I9DjXEgtz7Ihpg3CJqOMfOFtMrGw
 8rEel53LJ0nBozy/qt/Q7CtbFaWkp/vprTvl3LALABTk56DUmHkJ4uiuWM/ZQEIF
 HOAQ2AaB1a7sQmgMFTFISOyz/VWwQx2RQX1wZydqQT8rVjWC9BICGwWZ6LL7YzsM
 IY7qw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417ged7nkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 17:07:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47QH77x1027605;
 Mon, 26 Aug 2024 17:07:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417ged7nkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 17:07:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEjSSg024692;
 Mon, 26 Aug 2024 17:07:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj36n8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 17:07:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47QH75V934865786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Aug 2024 17:07:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D69358050;
 Mon, 26 Aug 2024 17:07:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D72A58052;
 Mon, 26 Aug 2024 17:07:05 +0000 (GMT)
Received: from [9.61.35.97] (unknown [9.61.35.97])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Aug 2024 17:07:05 +0000 (GMT)
Message-ID: <fbe8a4cb-e33a-4aac-aa00-1ccbd1eb7326@linux.ibm.com>
Date: Mon, 26 Aug 2024 13:07:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
References: <20240621082422.136217-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20240621082422.136217-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wYtN1CpFDc7wNz36H2bAasXXHFwYBhC0
X-Proofpoint-GUID: e4P5RfXpiH5-o8OADvQjXTTvXhB8OwQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=448
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Thomas,

I just wanted to get your thoughts on the status of the netboot loader merge.
I see that the first patch from this series was merged, but not the others. Is
there any issue with the rest of the changes?

I would like to put together a comprehensive rework for all device types that
replaces the IPL panics with returns, but as we discussed this is best applied
after the netboot loader has been unified with the main s390-ccw.img file.

I can base my patches on either current master (with a special case for netboot)
or the combined bootloader, depending on how you would like to proceed. Let me
know if there is anything I can do to help with test/review of the changes from
your side.

Thanks,
Jared Rossi

On 6/21/24 4:24 AM, Thomas Huth wrote:

> We originally built a separate binary for the netboot code since it
> was considered as experimental and we could not be sure that the
> necessary SLOF module had been checked out. Time passed, the netboot
> code proved its usefulness, and the build system nowadays makes sure
> that the SLOF module is checked out if you have a s390x compiler available
> for building the s390-ccw bios. In fact, the possibility to build the
> s390-ccw.img without s390-netboot.img has been removed in commit
> bf6903f6944f ("pc-bios/s390-ccw: always build network bootloader")
> already.
>
> So it does not make too much sense anymore to keep the netboot code
> in a separate binary. To make it easier to support a more flexible
> boot process soon that supports more than one boot device via the
> bootindex properties, let's finally merge the netboot code into the
> main s390-ccw.img binary now.
>
> Thomas Huth (7):
>    pc-bios/s390-ccw: Remove duplicated LDFLAGS
>    hw/s390x/ipl: Provide more memory to the s390-ccw.img firmware
>    pc-bios/s390-ccw: Use the libc from SLOF for the main s390-ccw.img
>      binary, too
>    pc-bios/s390-ccw: Link the netboot code into the main s390-ccw.img
>      binary
>    hw/s390x: Remove the possibility to load the s390-netboot.img binary
>    pc-bios/s390-ccw: Merge netboot.mak into the main Makefile
>    docs/system/s390x/bootdevices: Update the documentation about network
>      booting
>
>   docs/system/s390x/bootdevices.rst |  20 +++----
>   pc-bios/s390-ccw/netboot.mak      |  62 ---------------------
>   hw/s390x/ipl.h                    |  12 ++--
>   pc-bios/s390-ccw/cio.h            |   2 +
>   pc-bios/s390-ccw/iplb.h           |   4 +-
>   pc-bios/s390-ccw/libc.h           |  89 ------------------------------
>   pc-bios/s390-ccw/s390-ccw.h       |  10 +++-
>   pc-bios/s390-ccw/virtio.h         |   1 -
>   hw/s390x/ipl.c                    |  65 +++-------------------
>   hw/s390x/s390-virtio-ccw.c        |  10 +---
>   pc-bios/s390-ccw/bootmap.c        |   4 +-
>   pc-bios/s390-ccw/cio.c            |   2 +-
>   pc-bios/s390-ccw/dasd-ipl.c       |   2 +-
>   pc-bios/s390-ccw/jump2ipl.c       |   2 +-
>   pc-bios/s390-ccw/libc.c           |  88 -----------------------------
>   pc-bios/s390-ccw/main.c           |  15 +++--
>   pc-bios/s390-ccw/menu.c           |  25 ++++-----
>   pc-bios/s390-ccw/netmain.c        |  15 +----
>   pc-bios/s390-ccw/sclp.c           |   2 +-
>   pc-bios/s390-ccw/virtio-blkdev.c  |   1 -
>   pc-bios/s390-ccw/virtio-scsi.c    |   2 +-
>   pc-bios/s390-ccw/virtio.c         |   2 +-
>   pc-bios/meson.build               |   1 -
>   pc-bios/s390-ccw/Makefile         |  69 +++++++++++++++++++----
>   pc-bios/s390-netboot.img          | Bin 67232 -> 0 bytes
>   25 files changed, 122 insertions(+), 383 deletions(-)
>   delete mode 100644 pc-bios/s390-ccw/netboot.mak
>   delete mode 100644 pc-bios/s390-ccw/libc.h
>   delete mode 100644 pc-bios/s390-ccw/libc.c
>   delete mode 100644 pc-bios/s390-netboot.img
>


