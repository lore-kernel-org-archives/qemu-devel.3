Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB5FEA854A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObW-0006Gp-KU; Sun, 08 Mar 2026 20:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObV-0006Fq-0X; Sun, 08 Mar 2026 20:36:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObT-0001dO-8K; Sun, 08 Mar 2026 20:36:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628HiSLH1342364; Mon, 9 Mar 2026 00:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=8aNHtuzDdYg5yRJkVdXQf3LwpnfrtdvnoP/qT7FhE
 70=; b=jmNJaqI+dF9CrwmPF/QWBQg0V4FGXgvBAd+eAV4QcKltcv/RCOXshAaMz
 YmN6VnYlZgL5kbciOjFDWvjjHdSjlXM24IhYn/tlY1y4G/UM/yWOqz3X6oVTHeRW
 k4PObxZV6iMPN8ds/d/ji5U8vQcbPJGFEWCa5a8LgV2awdwcvwr2CadzmIvjkzKx
 6Q452+PTF+oZXgwYXS+7FEMZu+uUufzwSGsEvZH5hXaepaks3/th7G6USyDSmSlg
 9TJLOPYMq+5PWAE33erbz5I3TVm6cnotTIit0T6mCPIApmeablohl3a+GXMaVKEs
 RQ82LGVb4K+23LTEuIRRVWY1GIKCg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm4mdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628NHdDo025085;
 Mon, 9 Mar 2026 00:36:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjtt97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290a4Qw8651460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A225858052;
 Mon,  9 Mar 2026 00:36:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ABB658054;
 Mon,  9 Mar 2026 00:36:03 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:03 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 00/15] s390x: Add support for virtio-blk-pci IPL device
Date: Sun,  8 Mar 2026 20:35:46 -0400
Message-ID: <20260309003601.242634-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c27MV5PCfcGl1le4rmvJhlmF8W9rwndz
X-Proofpoint-ORIG-GUID: c27MV5PCfcGl1le4rmvJhlmF8W9rwndz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX7gtBl9bb8Bfr
 1NsNnQXGraPbktVNrWnIekEVhH5NLOPZUxLAcj+Qdz4IgrZYvqkvnNy5krx2VInoEVOl61rWeqY
 bRpsTsfs305zauNyVm9bDABahf1pcfys4DAH60ml6ZZsA35GlJVpqitYB+aEp6tMWzF15TLO5s7
 Z0UrW45MC1V+mBsunGx35XFaNPkFkAMjHSfQJN2Za4w5GlZ13Ankj+wxGTFj0iDJh37Z2WuyiAm
 +f//0OdSt8N9A633PSNpjZMNPwbsBs3ts28OIyS4EACvTRWJoGXpIQVSMELlS3LAS74k4x1+nKa
 meEE+gZczQv0Sn0+wpr2SYJ8pGKF3vWVW/naCfOXFLrRpnYB6SZc+1HRKo8a4ZrHWiZ8wDZvpNG
 4PhDJJXuS6aUozX6SNrWUXow2O4o+yuUI+Uy/0BdP4iJeqFsmCjCpNpNaFLDfXke4tUTm2jS/3k
 Ueh/oIiw2zj9hzKLf8g==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69ae15f7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=in6QM8ftKe1XUtxz0FQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Changes v4 -> v5:
    - Fix incorrect switch/case for virtio block device ID
    - Use target_s390x() instead of qemu_arch_available(QEMU_ARCH_S390X)
    - Properly denote switch fallthrough
    - Remove reduntant RC checks in PCI read/write

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
 pc-bios/s390-ccw/main.c                   |  88 ++++-
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
 pc-bios/s390-ccw/virtio.h                 |  19 +-
 tests/qtest/cdrom-test.c                  |   7 +
 33 files changed, 1449 insertions(+), 273 deletions(-)
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


