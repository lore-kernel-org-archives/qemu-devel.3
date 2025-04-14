Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBBCC369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 21:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4RTt-0007zC-Co; Mon, 14 Apr 2025 17:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4RTl-0007uo-Tx; Mon, 14 Apr 2025 17:36:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4RTj-0003GS-CD; Mon, 14 Apr 2025 17:36:33 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EL3Axh003755;
 Mon, 14 Apr 2025 21:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=RtOQiPCMco0lcAYswkOH5CxddvmR
 a4vS5SGSgopjDU0=; b=ViZ+hHUny12zl0D+bTTeTr5mC+jc5vht2tvb/87ZrHrj
 r/7piVcvpD53L46K5nglSmNq0h4vJ/rIfVSltHd/5fHzq+II4c9PUq5j3KqF2guy
 bIW/SqxX82SAe8GNWShbtZmH7Q+Ivov1FHOb6QOdEJimaifxjBVaEJezx8bwCpR9
 SZWG011HBjqVvKjRcznaD3nU0kVtM7fl+uGFGFTk/PXPcAst020l5eDKSb447ESp
 RNl84C7xTSFHMlo+sj7sZW9Kw7mQ8IwY+iokmXikeyMDagczxnl/UW9a1lJVIpmH
 r4bghB2E1UbDlV7vM7dRlEtzdkvuwpdCzGzf6EdJ4g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4619xfr3qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 21:36:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHkQsX010392;
 Mon, 14 Apr 2025 21:36:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjyu7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 21:36:21 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53ELaKB19306792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 21:36:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 378545804E;
 Mon, 14 Apr 2025 21:36:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B97CF5803F;
 Mon, 14 Apr 2025 21:36:18 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.75])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Apr 2025 21:36:18 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, stefanha@redhat.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net,
 alex.williamson@redhat.com
Subject: [PATCH v4 0/3] Enable QEMU NVMe userspace driver on s390x
Date: Mon, 14 Apr 2025 14:36:13 -0700
Message-ID: <20250414213616.2675-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sLZUbv9cISJ5FJYCTPyTUonbR_rKpDkl
X-Proofpoint-GUID: sLZUbv9cISJ5FJYCTPyTUonbR_rKpDkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=766 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

Recently on s390x we have enabled mmap support for vfio-pci devices [1].
This allows us to take advantage and use userspace drivers on s390x. However,
on s390x we have special instructions for MMIO access. Starting with z15 
(and newer platforms) we have new PCI Memory I/O (MIO) instructions which 
operate on virtually mapped PCI memory spaces, and can be used from userspace.
On older platforms we would fallback to using existing system calls for MMIO access.

This patch series introduces support the PCI MIO instructions, and enables s390x
support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
on the patches.

Thanks
Farhan

[1] https://lore.kernel.org/linux-s390/20250226-vfio_pci_mmap-v7-0-c5c0f1d26efd@linux.ibm.com/

ChangeLog
---------
v3 series https://lore.kernel.org/qemu-devel/20250401172246.2688-1-alifm@linux.ibm.com/
v3 -> v4
    - Use generic ld/st functions for non s390x PCI access suggested by Alex (patch 2).
    - Removed R-b for patch 2 as the host PCI MMIO access API changed for non-s390x.
    Would appreciate review on this again.

v2 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06847.html
v2 -> v3
    - Update the PCI MMIO APIs to reflect that its PCI MMIO access on host 
as suggested by Stefan(patch 2)
    - Move s390x ifdef check to s390x_pci_mmio.h as suggested by Philippe (patch 1)
    - Add R-bs for the respective patches.

v1 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06596.html
v1 -> v2
    - Add 8 and 16 bit reads/writes for completeness (patch 1)
    - Introduce new QEMU PCI MMIO read/write API as suggested by Stefan (patch 2)
    - Update NVMe userspace driver to use QEMU PCI MMIO functions (patch 3)

Farhan Ali (3):
  util: Add functions for s390x mmio read/write
  include: Add a header to define host PCI MMIO functions
  block/nvme: Use host PCI MMIO API

 block/nvme.c                  |  41 +++++-----
 include/qemu/host-pci-mmio.h  | 141 ++++++++++++++++++++++++++++++++
 include/qemu/s390x_pci_mmio.h |  24 ++++++
 util/meson.build              |   2 +
 util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
 5 files changed, 338 insertions(+), 18 deletions(-)
 create mode 100644 include/qemu/host-pci-mmio.h
 create mode 100644 include/qemu/s390x_pci_mmio.h
 create mode 100644 util/s390x_pci_mmio.c

-- 
2.43.0


