Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74580C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 00:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLXg4-0001QE-HM; Sun, 23 Jun 2024 20:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sLXg2-0001Pd-JG; Sun, 23 Jun 2024 20:35:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sLXg0-0004IB-HV; Sun, 23 Jun 2024 20:35:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O0RFGK005911;
 Mon, 24 Jun 2024 00:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=O
 eJ8n61oI476UUBAYGuW3N5y52Q3HA6akuERemfbvr0=; b=kSgyasVwL/wM0wKqR
 v6xQRmMorv6GBj9FUE+485sKDX7TmrTULh3qpANnLpwEYXVA6CCplOaVOmc2YOSe
 bMJebeaKx/fCybQIITgRtEMr+9fuqzlW4ua8JJvsnhJHcJZhSRBvx/QR1oz62erd
 6GPstPzwC74r6Hr6gQNhC157eaCXo9QLKokg9UP9jIjj2J3ik6kJHw6QycDKHJ5k
 1HVWNcPiWE02U96bZDAL6gGZ0u/Wlqbyou9NfQLQaNyJ4cgFvPDjal61aHVhylEG
 upLu8v3Gk6k6gzboJmHGdVTH8vXO78HV6VVokwvDz8IJQ94aIpCHPmsIhddqThZu
 7MIFQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yxnxjgqwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2024 00:35:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45O0ZFjQ016934;
 Mon, 24 Jun 2024 00:35:15 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yxnxjgqwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2024 00:35:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45NKsDWg000402; Mon, 24 Jun 2024 00:35:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn2v8rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jun 2024 00:35:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45O0ZBII28639752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jun 2024 00:35:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B7CB5805D;
 Mon, 24 Jun 2024 00:35:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE9AD58067;
 Mon, 24 Jun 2024 00:35:09 +0000 (GMT)
Received: from [9.67.72.93] (unknown [9.67.72.93])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 24 Jun 2024 00:35:09 +0000 (GMT)
Message-ID: <5ad9a903-acfc-4b7c-81bd-538baeb5ae76@linux.ibm.com>
Date: Sun, 23 Jun 2024 20:35:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20240621082422.136217-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20240621082422.136217-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lQcBRR2SRUIOU2E-dIJ8VVbEdb_ytj5y
X-Proofpoint-ORIG-GUID: UM9p1hB7ce8u0wCtjjckQa3jo9PsXLOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_16,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=478
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Thomas, One area that could possibly be cleaned up further are places 
where net devices are treated as corner cases due to the separate 
bootloader. Off the top of my head I know in pc-bios main.c, the 
is_dev_possibly_bootable() function rejects net devices for this reason. 
I'm not sure if that is the only place though. Otherwise it looks good 
to me. I can work on a v2 of the boot order support that assumes the 
network bootloader is integrated. Regards, Jared Rossi

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


