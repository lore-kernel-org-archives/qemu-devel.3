Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B48EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKajy-0004ly-1a; Fri, 21 Jun 2024 05:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sKajv-0004af-Nn; Fri, 21 Jun 2024 05:39:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sKajs-0000Qq-Qe; Fri, 21 Jun 2024 05:39:27 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L9RDA4016743;
 Fri, 21 Jun 2024 09:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=j
 Taa/lXRYaBkXrkeLULZh7cFvC3wDRGW8uPmtvTEYWg=; b=qo5E9ABn5QN1oxFJ0
 D7n5pZlNQxi0Rey2VJHECI5fAffr4wV3egFKDQTJVHl16piJh98vEaZWB6+hxRje
 5Mt47QN6WFh7NqS6fX5D8z16l3qOGEBtk1fqfVg0eSpXhoexAyHpPLGTczEic/pr
 BvYaYAHyXwi6rGJAYArXmitv5t84bivAPcVi1juFt+HmHM3oDIxXLAn4EYMvABPB
 yZN/KtyT87FiZhUh89oSsWp0V6bk4pJO+PQMdwY6DO0sLGUC2rg59PBknqp197qD
 ePo/1qm8C3type6q75qtH/gL51wC2wTQy0MH8p0/c8mJwauICBKcJT8T+bMIAoA4
 rxkew==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw5krg6ry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 09:39:17 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L9dGxU004797;
 Fri, 21 Jun 2024 09:39:17 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw5krg6rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 09:39:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45L9DkiR025805; Fri, 21 Jun 2024 09:39:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrqv6caj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 09:39:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45L9dAjW53215568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 09:39:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F1F32004F;
 Fri, 21 Jun 2024 09:39:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 502222004B;
 Fri, 21 Jun 2024 09:39:10 +0000 (GMT)
Received: from [9.152.224.131] (unknown [9.152.224.131])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Jun 2024 09:39:10 +0000 (GMT)
Message-ID: <ae2a498e-e809-424b-93f8-d4e7d646df2c@linux.ibm.com>
Date: Fri, 21 Jun 2024 11:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20240621082422.136217-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240621082422.136217-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hy-zmOMlkTUAIAZQLAVN_ukmGVF3R5IC
X-Proofpoint-ORIG-GUID: G5xNElNu-uLuxwhwoq4a6aVVJOY6ojCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_03,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=415 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406210069
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

[...]
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

Shouldnt you also update the s390-ccw.img file?

>   25 files changed, 122 insertions(+), 383 deletions(-)
>   delete mode 100644 pc-bios/s390-ccw/netboot.mak
>   delete mode 100644 pc-bios/s390-ccw/libc.h
>   delete mode 100644 pc-bios/s390-ccw/libc.c
>   delete mode 100644 pc-bios/s390-netboot.img
> 

