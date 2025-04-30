Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2BCC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACVq-0003Ie-9Z; Wed, 30 Apr 2025 14:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uACVm-0003IK-Uz
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uACVk-0008B7-U3
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UAf8qg011499;
 Wed, 30 Apr 2025 18:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=baWpGNL8T3OSrJdXv0X5O+FsLM/A
 b46or0Y1MxyJPQE=; b=aNozGEWW2QU/182tsaPdtgZm8wGNGCoNAWqywgUWbuoi
 PnsB5SixJQ9NvtpgOWWeIDZfpiin2TaBL1SXvq+oQjpLNvH9x97MW1Z2xRl7IW21
 oviVn0Ton4KAJNm+xZ4E1Q1II8/1hpMr0YLzw8YbFeDweCOxOpMkIgGIVHHyQBJF
 WYL06667vDVYtAV1tm0UE0SBvX0qoJLTkTOi2D2XOiz9bi3o1SVqjeUU3cFRFYMD
 1d6JiC1LXEVHA+nOPQxymQMhp9h4OVQh03e+ttPcJ6wuEx335Rah2EkUkt4DdiWE
 B6BpTO/M7RsoWl3wf7yuo5JttnkaoPwSeBp08+XOCg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bjas2e4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 18:50:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHicwS008490;
 Wed, 30 Apr 2025 18:50:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 469ch3903e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 18:50:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53UIoHB917498758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 18:50:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A521458065;
 Wed, 30 Apr 2025 18:50:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDF495804B;
 Wed, 30 Apr 2025 18:50:14 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.230])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Apr 2025 18:50:14 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, alifm@linux.ibm.com,
 mjrosato@linux.ibm.com, schnelle@linux.ibm.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net
Subject: [PATCH v6 0/3] Enable QEMU NVMe userspace driver on s390x
Date: Wed, 30 Apr 2025 11:50:09 -0700
Message-ID: <20250430185012.2303-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CcsCDg9yHdI9-nFp0l7WoI-KnkSnOikI
X-Proofpoint-ORIG-GUID: CcsCDg9yHdI9-nFp0l7WoI-KnkSnOikI
X-Authority-Analysis: v=2.4 cv=LKNmQIW9 c=1 sm=1 tr=0 ts=681270eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mDV3o1hIAAAA:8 a=crsOB1bfPne2PFP59U0A:9
 a=QEXdDO2ut3YA:10 a=WQTGfJf2NMsA:10 a=ZPqX8Ogbq0EA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEzNiBTYWx0ZWRfXzIv+4g2NZ7Bw
 oH8t1On5YOwXXUNUtSfQ1ray8PC7hTPJatquMxUp8lCf5num+mysy06pjcXUxal+mvfEQEomz7Q
 TzK48P7117DtrlMl3ZsnCVOI2eutuQ3YN4U2AUYtRtfmvcvuehN+9VwRgBRLyqQ7I91NsTOYhWo
 zdXLJhA28Z93PY5Qg4/09f/LgTPlWCCeN5LnuIa51RIGP0EgQWzXNtJz4RV2bNSM2UifYNdf3Vr
 UkKtDWg/djFVDTP8h27GcVt/UayiLoD7/pcd0r38NIbdlCTqjoiAMV7Ol8r3Ks5o/rb4SpXSWI5
 Du4dJHTFqcH0R2GR5LUAqKIa7n2AxzfsBoFIcDza1pcd0FPP6hcn771E/j8fgW4u7pNakYLbuge
 Iu8scdDRDxojzZd1/6e3kBUZk02zbCmsjqC2jd+pR8YSp9gO5TH4w7w+lKFHecpizn8TSwMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=879 clxscore=1015
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300136
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
v5 series https://lore.kernel.org/qemu-devel/20250417173801.827-1-alifm@linux.ibm.com/
v5 -> v6
    - Address Thomas's comments/nits (patch 1 and patch 2).

v4 series https://lore.kernel.org/qemu-devel/20250414213616.2675-1-alifm@linux.ibm.com/
v4 -> v5
    - Fixup typo in PCI MMIO API (patch 2).

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
 include/qemu/host-pci-mmio.h  | 136 +++++++++++++++++++++++++++++++
 include/qemu/s390x_pci_mmio.h |  24 ++++++
 util/meson.build              |   2 +
 util/s390x_pci_mmio.c         | 146 ++++++++++++++++++++++++++++++++++
 5 files changed, 331 insertions(+), 18 deletions(-)
 create mode 100644 include/qemu/host-pci-mmio.h
 create mode 100644 include/qemu/s390x_pci_mmio.h
 create mode 100644 util/s390x_pci_mmio.c

-- 
2.43.0


