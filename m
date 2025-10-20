Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D96FCCD1A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAscg-0003hH-Oo; Mon, 20 Oct 2025 12:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAsce-0003gG-Bh; Mon, 20 Oct 2025 12:20:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAscb-0000s3-JX; Mon, 20 Oct 2025 12:20:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7b6ll013852;
 Mon, 20 Oct 2025 16:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+7RVkQphPBI9uc1emd7t+KOiFYLoFApwpsZu9p1jY
 Wg=; b=V1A4Y+JzTuMnGb6+VurUMK0HcezGr4ol8ldMKg9j37L06efxa8/h2NUWA
 c+1BIWd6LuQdLotDTdWDQSAhtc+27WeHUCf2NuxqPicnSf+ABm5U2pF1SJoueaJM
 PfgsCq0kl9Hgd5BCXcv3liDu9sj5KSGouzpaqIIElhQ89BHz0e3PnnmdQ/q9yacM
 9J/d4D5c1/Ea9b6PQZgCxWV+E78b+J2KFfNBL4GVC5YCuG0oY/FcpiWO5BZf4rHz
 w5drbCWQxaJYSoVpDuVB5mff/K18wsGJ9ePvEH4ogCz4aCUreSOsPQ5O5XjCFWrD
 fXgB7wzNeUVgZxJ44L0bqbvvPnKgQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vhbye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KEPCYA017117;
 Mon, 20 Oct 2025 16:20:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxpmw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KGKESx17760840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 16:20:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AACC58056;
 Mon, 20 Oct 2025 16:20:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1CC15805D;
 Mon, 20 Oct 2025 16:20:25 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.78.141])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 16:20:25 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 0/7] s390x: Add support for virtio-blk-pci IPL device
Date: Mon, 20 Oct 2025 12:20:16 -0400
Message-ID: <20251020162023.3649165-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W_VZM80rJpKO1Q6Rs5314CUL433TSfNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7WHqZBhdwKBQ
 O8YnLLxfA2BkkABWYknc3kL8l/uPXcjuSXg+bS+zYMnUz1QDmzjYSfpl8jpqqaw2zwpsE9PBHss
 gf9iSXXA0Gjl8G8i/TwITEUDu57EO0wVNcG8xlXpZxzhgV7rznFUnIVGLWe88Rh9AqsetgS1QfR
 T1+zIAw9FQVdKzZ2eKTCT8yyD1nFEbNEtupW7IVGVHWgW2QFFzBj/MJeJWLHV9Xhp+WO4Rnwra/
 dbGVSw1mmj0u3VzxggjeYHsVOfL5/zrUr862tp+WzBa0s11ztPD1YoBbcS3l5EimR0JltOyR6Lb
 JSWjqbUTI1CqKHNSkNVvSs32gZPN7th2UMpcOS895CjqTdNPAEmr/pRDLfcxBAtYKX2phz1/X9x
 yK/7UkN5GdVr+mZQFcz+FtnSuFsEiw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f6614d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=SM3XVfEbigzPBRV1TjsA:9 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: W_VZM80rJpKO1Q6Rs5314CUL433TSfNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

This patch series introduces an IPLB subtype to support PCI devices, which may
be built if a device has been assigned a boot index and is identified as a PCI
device with a corresponding s390 PCI Bus device.

A simple test to check basic functionality is added to the cdrom-tests in qtest.

Boot support is only added for virtio-blk-pci at this time and has the
following limitations:
    1) A PCI device must be assigned a boot index to be eligible for boot
    2) A PCI boot device cannot be assigned a per-device loadparm

Point 1 relates to boot device probing, which occurs if no device has been
assigned a boot index.  Currently, there is a basic probing routine to scan
through the CCW devices for any devices that *might* boot, and to then try
booting them; however, the routine provides limited coverage even for CCW
devices (some CCW devices, such as net devices, are not probed).  The PCI bus
could be added to this routine in a similarly limited form, or it may be more
desirable to do a comprehensive enhancement of the probing routine as a separate
patch series.

Point 2 relates to the QOM device properties.  The loadparm is specific to s390x
and has generally only been relevant for CCW devices, of which bootable types
have a corresponding QOM property for the loadparm.  There is some precedence
for making the s390x loadparm property assignable to non-CCW devices (see QEMU
commit 429442e), but it may not be an acceptable solution for generic PCI
devices, in which case an alternative solution would be needed.

Further consideration is needed on how to best handle to above points and
feedback is encouraged.  Additionally, it is worth noting that all of the s390 
BIOS code lives in the "s390-ccw" directory.  Should the entire directory be
renamed, given that non-ccw devices will be supported?

Referenced commit ID 429442e: hw: Add "loadparm" property to scsi disk devices
for booting on s390x (https://gitlab.com/qemu-project/qemu/-/commit/429442e52d94f890fa194a151e8cd649b04e9e63)

Jared Rossi (7):
  pc-bios/s390-ccw: Fix Misattributed Function Prototypes
  pc-bios/s390-ccw: Split virtio-ccw and generic virtio
  pc-bios/s390-ccw: Introduce CLP Architecture
  pc-bios/s390-ccw: Introduce PCI device IPL format
  pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
  s390x: Build IPLB for virtio-pci devices
  tests/qtest: Add s390x PCI boot test to cdrom-test.c

 hw/s390x/ipl.h                   |   8 +-
 include/hw/s390x/ipl/qipl.h      |  15 ++
 include/hw/s390x/s390-pci-bus.h  |   2 +
 pc-bios/s390-ccw/clp.h           |  24 +++
 pc-bios/s390-ccw/iplb.h          |   4 -
 pc-bios/s390-ccw/pci.h           |  77 +++++++
 pc-bios/s390-ccw/s390-ccw.h      |   4 -
 pc-bios/s390-ccw/virtio-ccw.h    |  25 +++
 pc-bios/s390-ccw/virtio-pci.h    |  73 +++++++
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 pc-bios/s390-ccw/virtio.h        |  17 +-
 hw/s390x/ipl.c                   |  56 ++++-
 hw/s390x/s390-pci-bus.c          |   2 +-
 pc-bios/s390-ccw/bootmap.c       |   2 +-
 pc-bios/s390-ccw/clp.c           | 106 +++++++++
 pc-bios/s390-ccw/main.c          |  72 ++++++-
 pc-bios/s390-ccw/pci.c           | 191 +++++++++++++++++
 pc-bios/s390-ccw/virtio-blkdev.c |  62 ++++--
 pc-bios/s390-ccw/virtio-ccw.c    | 240 +++++++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c    |   5 +-
 pc-bios/s390-ccw/virtio-pci.c    | 357 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c   |   7 +-
 pc-bios/s390-ccw/virtio.c        | 214 ++++--------------
 tests/qtest/cdrom-test.c         |   7 +
 pc-bios/s390-ccw/Makefile        |   3 +-
 25 files changed, 1342 insertions(+), 233 deletions(-)
 create mode 100644 pc-bios/s390-ccw/clp.h
 create mode 100644 pc-bios/s390-ccw/pci.h
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.h
 create mode 100644 pc-bios/s390-ccw/virtio-pci.h
 create mode 100644 pc-bios/s390-ccw/clp.c
 create mode 100644 pc-bios/s390-ccw/pci.c
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
 create mode 100644 pc-bios/s390-ccw/virtio-pci.c

-- 
2.49.0


