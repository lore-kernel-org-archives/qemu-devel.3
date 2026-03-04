Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BA9EDEC02
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcSQ-0002Jm-He; Tue, 03 Mar 2026 21:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSO-0002JQ-UH; Tue, 03 Mar 2026 21:59:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSN-0000TQ-7g; Tue, 03 Mar 2026 21:59:28 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623DCLeB383634; Wed, 4 Mar 2026 02:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ygVnaAdeObPWdVrmG2A9lgv8EtZ2bLZcmrFpjRnW1
 u0=; b=qX3Na2a4nvmggVC6VdROxu8guyrLABH2bQkYdaek8m1ZKzxxLyHs8beKv
 Co1zKkoKTGS9tQUWQw2CklCUv+OYNMM8mIge8U93Rv7136/pYJ9Q4qnMgz55ENqc
 1+g69Pa0NBLg4QcAy7twntPksYUB0H3vsBEhXrFmbZXDUGOR2+62vl70qcu4aXl3
 qPyshbTHDS4Rm3G8YDMu53BN8rXuUHOVFsCOFvTdGGZOVTxEdp4MAkqxoKDQr4ln
 +/vF/DB+r3ENalAjSyIE9FSaMT6TqhExQ6drb2/nOARllW6y1fCShfQsA3B1N+7b
 1fOOnkfss/rP8JySMRCFWdIYnpzvA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjddq6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6241gKNW008769;
 Wed, 4 Mar 2026 02:59:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1cpws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xLDF33620654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B70E58053;
 Wed,  4 Mar 2026 02:59:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE84558043;
 Wed,  4 Mar 2026 02:59:19 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:19 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 00/15]  s390x: Add support for virtio-blk-pci IPL device
Date: Tue,  3 Mar 2026 21:59:02 -0500
Message-ID: <20260304025917.2157032-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a7a00b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gA-sDKjtC9KJYzxFQoUA:9
X-Proofpoint-ORIG-GUID: a8Lkp0wawD6vzsvARK_hdga0gZ2LOwEE
X-Proofpoint-GUID: a8Lkp0wawD6vzsvARK_hdga0gZ2LOwEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX/CvtssbZD0jB
 blNuqbaTToUMHKeGuoVx3dE43xpEkInc0gcKit2zrfRQq/pvESi9ycXXpwvMOHgPQZ8SNb1x1TG
 EA4HbN2P2XRw3cqZXCB+dE6g88vjIG1JGLsV/3ZUxG7a6aw+Z4OQppphwRa8sjUkcnCLyBebh4q
 KZEkifRIQklAuLdA9uEAyhecs8Qa1nvmv+va/wtxnUVAPQQxOOuBWMDivSaYDoq7mmK2gsfZaDO
 GCuJ7grzb0c8jDLkDT6VkdAXjT1vCuVNvWDm53HJdr9JPZO1nsH/7CcdZVl2v+N89b8bsLRAL0T
 Wyo5zk7lp9Bsc9eIrAIHHGgs7Zq1CqAcsnzn1F4anuUWVIUL+gQf7TH8dk3Pln1ttfYTCUl0oAv
 Jj/sp1clvoi8qrOkBC4RxaU4AjG4h04DA9pinwvfQ92WhP91l8qH56pBuQWlOL9S1pclN1atmFC
 k79ZUkdxoxq6vBmW+KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

A "loadparm" property is added to virtio-blk-pci boot devices on s390x.

A simple test to check basic functionality is added to the cdrom-tests in qtest.

Changes v3 -> v4:
    - Reset virtio device after failed boot (not PCI specific)
    - Use defined constant for CLP block size
    - Enable PCI bus master bit
    - Refactor where some byte swaps happen
    - Fix an incorrect offset during PCI config read
    - Update maintainers when moving CLP definitions
    - Improve various error messages to include more info/codes

Jared Rossi (15):
  pc-bios/s390-ccw: Fix misattributed function prototypes
  pc-bios/s390-ccw: Remove redundant vring schid attribute
  pc-bios/s390-ccw: Always reset virtio device on failed boot attempt
  s390x: Remove duplicate definitions of IPL types
  pc-bios/s390-ccw: Store device type independent of sense data
  pc-bios/s390-ccw: Split virtio-ccw and generic virtio
  include/hw/s390x: Move CLP definitions for easier BIOS access
  pc-bios/s390-ccw: Introduce CLP Architecture
  s390x: Add definitions for PCI IPL type
  pc-bios/s390-ccw: Introduce PCI device
  pc-bios/s390-ccw: Introduce virtio-pci functions
  pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
  s390x: Build IPLB for virtio-pci devices
  hw: Add "loadparm" property to virtio block PCI devices booting on
    s390x
  tests/qtest: Add s390x PCI boot test to cdrom-test.c

 MAINTAINERS                               |   1 +
 hw/pci/pci.c                              |  38 ++
 hw/s390x/ipl.c                            |  63 +++-
 hw/s390x/ipl.h                            |   8 +-
 hw/s390x/s390-pci-bus.c                   |   3 +-
 hw/s390x/s390-pci-vfio.c                  |   2 +-
 hw/virtio/virtio-blk-pci.c                |   1 +
 include/hw/pci/pci.h                      |   1 +
 include/hw/pci/pci_device.h               |   3 +
 include/hw/s390x/ipl/qipl.h               |  20 +
 include/hw/s390x/{ => ipl}/s390-pci-clp.h |   0
 include/hw/s390x/s390-pci-bus.h           |   4 +-
 pc-bios/s390-ccw/Makefile                 |   3 +-
 pc-bios/s390-ccw/bootmap.c                |   2 +-
 pc-bios/s390-ccw/clp.c                    |  99 +++++
 pc-bios/s390-ccw/clp.h                    |  24 ++
 pc-bios/s390-ccw/iplb.h                   |   4 -
 pc-bios/s390-ccw/main.c                   |  83 ++++-
 pc-bios/s390-ccw/netmain.c                |   2 +-
 pc-bios/s390-ccw/pci.c                    | 118 ++++++
 pc-bios/s390-ccw/pci.h                    |  42 +++
 pc-bios/s390-ccw/s390-ccw.h               |   7 -
 pc-bios/s390-ccw/virtio-blkdev.c          |  76 ++--
 pc-bios/s390-ccw/virtio-ccw.c             | 241 ++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h             |  24 ++
 pc-bios/s390-ccw/virtio-net.c             |   5 +-
 pc-bios/s390-ccw/virtio-pci.c             | 432 ++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h             |  82 ++++
 pc-bios/s390-ccw/virtio-scsi.c            |   8 +-
 pc-bios/s390-ccw/virtio-scsi.h            |   2 +-
 pc-bios/s390-ccw/virtio.c                 | 293 +++++----------
 pc-bios/s390-ccw/virtio.h                 |  21 +-
 tests/qtest/cdrom-test.c                  |   7 +
 33 files changed, 1448 insertions(+), 271 deletions(-)
 rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)
 create mode 100644 pc-bios/s390-ccw/clp.c
 create mode 100644 pc-bios/s390-ccw/clp.h
 create mode 100644 pc-bios/s390-ccw/pci.c
 create mode 100644 pc-bios/s390-ccw/pci.h
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.h
 create mode 100644 pc-bios/s390-ccw/virtio-pci.c
 create mode 100644 pc-bios/s390-ccw/virtio-pci.h

-- 
2.52.0


