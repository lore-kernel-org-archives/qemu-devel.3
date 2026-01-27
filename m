Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00AAD3409C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkljt-0003gb-94; Tue, 27 Jan 2026 11:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljX-0003XJ-7C; Tue, 27 Jan 2026 11:16:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljQ-0000jZ-Vv; Tue, 27 Jan 2026 11:15:58 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6a1Jo030543;
 Tue, 27 Jan 2026 16:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tFf+JZZ06RxRy2Rry9OUKA4Q/mA8/azk4Zw4G6+Xm
 J0=; b=GUFWcjO7HJ3lYZpnVNQw1FulF8C+pLNtN4CEmdLEH+cWWeaYGeX4du2Ho
 qVH5MXIEvt6ROD62SeQZUb0I4MT7+rLLqZgzWHkBoP7h1IMNMNstwHA9A4fL3MeM
 0meA1A0EfHIV894J2Vv1fqBaONQBeDD8yiW9r/HbUuMIwzphh2zgKIGujZs5qPxv
 U27cQSp50B7NcIXTnRYFctQYjBdSzMpYpUV4v3F2TRHDakesRqaj/V0f0zAPRFmf
 kW5cNJcL1SwD38jpz4GzkGxgtc6BAHuvusJY+rCOl/zptHlthfRDiUlq/25yp7sE
 n9oGjRhWHeucsoY920z6uuvYTGfFQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7pcx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:15:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REgnLK023641;
 Tue, 27 Jan 2026 16:15:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjs517-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:15:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGFp6p33358396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:15:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93BE95805C;
 Tue, 27 Jan 2026 16:15:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 762365805A;
 Tue, 27 Jan 2026 16:15:50 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:15:50 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 00/14] s390x: Add support for virtio-blk-pci IPL device
Date: Tue, 27 Jan 2026 11:15:33 -0500
Message-ID: <20260127161547.459443-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0HujVW8TzO0eo-fk_wdLujRjiiO5EUpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfXyYpwQ2xTGAYU
 LU85umac7ReXq4oRrvRP//pDLmXYsAS+VFyS1CBz290paHUKayhIjfURcVDd5hs49B/dsRo6VEw
 JxaL8E4XusNggl0QwANylj43/fpie/3alfPGq74wbvd7BJG5ILIw9qXLcXUWSPeUMfb7ChKSU7P
 BUD1pzMPmrUcjb+HabeYtu73YbjsgGXoBYQdzxYgz9fyiujOxO0Ik6kTYFAP1+D+rnAV7D+rw7l
 nnexk1kRCA0JBTmQWJxVJzfOuxVCoGWoaKYr1naYRyQlSCpQuaeYkRHUDqlwbbz5QmQqvfeoy/S
 JXIYxkbQ479o8crp14jzgBJv2upwlmnPCsJ/rElbHxCRQN0lXR9uOKpun/75gbtZt/rPizeqwRp
 ASqKvhojdAoV1KnxTfD3EmV2aS29BwNdXgnTE6bLNrg0T5XUNQPDLH0vxgZZgO5WEwdFaFfxYop
 eAYswFbYgGH7lpVpnpg==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6978e4ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=2kWigFolkMFzDznCNMwA:9
X-Proofpoint-ORIG-GUID: 0HujVW8TzO0eo-fk_wdLujRjiiO5EUpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes v2 -> v3:
    - Negotiate VIRTIO_F_VERSION_1 and support PCI native little endian
    - Split patches further to isolate clean-up and substantive changes
    - Move byteswap helpers from pci.c to virtio-pci.c to avoid passing the file
        handle throughout
    - Convert IPL type to enum and add defaults for switch cases
    - Add PCI loadparm only to virtio-blk devices
    - Do not assume PCI devices are virtio when building IPLB

Jared Rossi (14):
  pc-bios/s390-ccw: Fix misattributed function prototypes
  pc-bios/s390-ccw: Remove redundant vring schid attribute
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

 hw/pci/pci.c                              |  39 ++
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
 pc-bios/s390-ccw/clp.c                    |  96 +++++
 pc-bios/s390-ccw/clp.h                    |  24 ++
 pc-bios/s390-ccw/iplb.h                   |   4 -
 pc-bios/s390-ccw/main.c                   |  79 +++-
 pc-bios/s390-ccw/netmain.c                |   2 +-
 pc-bios/s390-ccw/pci.c                    | 194 ++++++++++
 pc-bios/s390-ccw/pci.h                    |  80 ++++
 pc-bios/s390-ccw/s390-ccw.h               |   7 -
 pc-bios/s390-ccw/virtio-blkdev.c          |  74 ++--
 pc-bios/s390-ccw/virtio-ccw.c             | 241 ++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h             |  24 ++
 pc-bios/s390-ccw/virtio-net.c             |   5 +-
 pc-bios/s390-ccw/virtio-pci.c             | 424 ++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h             |  88 +++++
 pc-bios/s390-ccw/virtio-scsi.c            |   6 +-
 pc-bios/s390-ccw/virtio-scsi.h            |   2 +-
 pc-bios/s390-ccw/virtio.c                 | 285 +++++----------
 pc-bios/s390-ccw/virtio.h                 |  17 +-
 tests/qtest/cdrom-test.c                  |   7 +
 32 files changed, 1543 insertions(+), 265 deletions(-)
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

