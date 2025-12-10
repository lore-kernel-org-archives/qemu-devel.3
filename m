Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671FD3B9AB
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTRDB-0004X7-69; Wed, 10 Dec 2025 15:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRD9-0004Vo-Fw; Wed, 10 Dec 2025 15:54:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRD7-0000Ug-J1; Wed, 10 Dec 2025 15:54:58 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BABUIAt008779;
 Wed, 10 Dec 2025 20:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=uVfTXenzHp2Vqd31K2PKeq7cZglQSRjZ1zwCJ+KGF
 nU=; b=hsnIpTtj06Set1QqMfk5r7eyCAWWGaWj7mnFyLbvYY09n5/jH4+Q38eXc
 e9pEcpaMXv8Hv8ffHfa/8ZUH7Qw+zFwfKyuE5yg1whJZD+TzoccfaGej4/1EombH
 5QlIudxzDIXVToSgkfhpK6+5K772ISYJl1xtT4AXSb/uR4irSumUGQXPZVFJlSh5
 k2P1ydEP+BtckAlnTpdAeTsyGunWjNGupKAChN53IN8o3lgPTidNqWViSoIFJ1ST
 CD+c8k7ib8XzSfFciIkDOeMWALDJSyUC2aKKJWoWTBtXEOJt9EoYp5FZLw1fh87Y
 vgj+FFEbRts43m2eihcqXozlvBzDQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawvc08u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:54:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJseCW009026;
 Wed, 10 Dec 2025 20:54:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytn2t00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:54:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BAKsqiu26542692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 20:54:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40B6F58056;
 Wed, 10 Dec 2025 20:54:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B9AA58052;
 Wed, 10 Dec 2025 20:54:51 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.53.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Dec 2025 20:54:51 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH V2 0/10] s390x: Add support for virtio-blk-pci IPL device
Date: Wed, 10 Dec 2025 15:54:39 -0500
Message-ID: <20251210205449.2783111-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tqWXsmL4fRPHVXOnvUpclGLRLo5lJG1l
X-Proofpoint-ORIG-GUID: tqWXsmL4fRPHVXOnvUpclGLRLo5lJG1l
X-Authority-Analysis: v=2.4 cv=aY9sXBot c=1 sm=1 tr=0 ts=6939de1e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=2PI-BZlUfcLuvJe9EegA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwNyBTYWx0ZWRfX8B8asXGHQknj
 FpFQphJTorIpmxnJG69QUlvZ7BV8x19KRNVAxzHqfTfcxyk1kYAWSPg44oHBETmVB2g2tOcygOc
 CD5kZrCS8Ria4cnAxpagz697lxZNPqEvv6RTp9mcGu0KRfxZb66Z41R/ovKGKolRjrfa9L6Uutb
 asd/gsNdBibzB4/ylLhJLBvnZXv4NUxEzb6NYq+QxLxBm/CXxyIHAAwEVWLZSIIsV8txkUG8XUP
 grFFBdEcH2az4jJAvvonzGEBuvjUd9LnrxRQIne1gjqpFTctpxvNxbxiJ1ausYzUaIVXDHcKkoG
 /uBmoSNySG2p9A6HQuQJK5hfXCx4W+Xg8abDVaFEDfwXAmvCf/Vj1JW4aK+bKO/mxtuHS5qejV7
 RBdu+vfZSkNBOCXuS47Qp3U+0eS8mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060007
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

Boot support is only added for virtio-blk-pci at this time and is limited to
devices with an assigned bootindex.

A "loadparm" property is added to PCI boot devices on s390x.

A simple test to check basic functionality is added to the cdrom-tests in qtest.

Changes v1 -> v2:
- Store boot device type/bus as fields of VDev to reduce global variables
- Move existing CLP definitions for easier use in BIOS
- Define a constant for the configuration BAR rather than using a magic 15
- Read BARs from configuration space rather than assuming BAR 4 is always used
- Rework read/write logic to avoid potential buffer overflows
- Create wrappers to do byte swapping as part of common read/writes
- Add "loadparm" property to PCI boot devices on s390x

Jared Rossi (10):
  pc-bios/s390-ccw: Fix misattributed function prototypes
  pc-bios/s390-ccw: Store boot device type and bus separately
  pc-bios/s390-ccw: Split virtio-ccw and generic virtio
  include/hw/s390x: Move CLP definitions for easier BIOS access
  pc-bios/s390-ccw: Introduce CLP Architecture
  pc-bios/s390-ccw: Introduce PCI device
  pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
  s390x: Build IPLB for virtio-pci devices
  hw: Add "loadparm" property to PCI devices for booting on s390x
  tests/qtest: Add s390x PCI boot test to cdrom-test.c

 hw/s390x/ipl.h                            |   8 +-
 include/hw/pci/pci_device.h               |   3 +
 include/hw/s390x/ipl/qipl.h               |  17 +
 include/hw/s390x/{ => ipl}/s390-pci-clp.h |   0
 include/hw/s390x/s390-pci-bus.h           |   4 +-
 pc-bios/s390-ccw/clp.h                    |  24 ++
 pc-bios/s390-ccw/iplb.h                   |   4 -
 pc-bios/s390-ccw/pci.h                    |  88 ++++++
 pc-bios/s390-ccw/s390-ccw.h               |   7 -
 pc-bios/s390-ccw/virtio-ccw.h             |  24 ++
 pc-bios/s390-ccw/virtio-pci.h             |  79 +++++
 pc-bios/s390-ccw/virtio-scsi.h            |   2 +-
 pc-bios/s390-ccw/virtio.h                 |  15 +-
 hw/pci/pci.c                              |  39 +++
 hw/s390x/ipl.c                            |  63 +++-
 hw/s390x/s390-pci-bus.c                   |   2 +-
 hw/s390x/s390-pci-vfio.c                  |   2 +-
 pc-bios/s390-ccw/bootmap.c                |   2 +-
 pc-bios/s390-ccw/clp.c                    |  96 ++++++
 pc-bios/s390-ccw/main.c                   |  80 ++++-
 pc-bios/s390-ccw/netmain.c                |   2 +-
 pc-bios/s390-ccw/pci.c                    | 331 ++++++++++++++++++++
 pc-bios/s390-ccw/virtio-blkdev.c          |  59 ++--
 pc-bios/s390-ccw/virtio-ccw.c             | 242 +++++++++++++++
 pc-bios/s390-ccw/virtio-net.c             |   5 +-
 pc-bios/s390-ccw/virtio-pci.c             | 360 ++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c            |   6 +-
 pc-bios/s390-ccw/virtio.c                 | 239 +++-----------
 tests/qtest/cdrom-test.c                  |   7 +
 pc-bios/s390-ccw/Makefile                 |   3 +-
 30 files changed, 1552 insertions(+), 261 deletions(-)
 rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)
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


