Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E08FC36017
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 17:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzfKa-0004k0-KY; Tue, 01 Apr 2025 13:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKF-0004fi-1H; Tue, 01 Apr 2025 13:23:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tzfKC-0005ut-HS; Tue, 01 Apr 2025 13:22:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531Gf56b025868;
 Tue, 1 Apr 2025 17:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6Khw9ioB9eIU3WuoUvGr7YttATKuVFOdVv2h4h7Cm
 I4=; b=Uw9J7jK4feQ1YbB2Ag2flXgEQzCjvjRCI8W2KkekvzPfjkFLFKdYclFD8
 1GSOBr+FTwvsE7UCW0u3W7nBnKyu0aEz+YrxT2Sf5pX6kAo0Diw718vnvxud8nYl
 leVJR0Vdu9bD8pRA1/MXMlpSB5dS7Bs+CzrWag+znRUazRYS4dsxxC8Y1zCF+7Gh
 ZoEb9073AIUOk+Ma4gpWzI81QRJJZtPEGDta4WUikUktn1koXpEwfZzmLegDow1A
 ZRtV9Pv/qqjSig6GEhJAkx5zQnmkVOnFLzMDqgnp1pwpQeB7dCd1aeXgQYdX+D2H
 vAAWWcrA5BAnHW6q0Q5Ej+VKmwD+A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q52ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531Fl2h6019742;
 Tue, 1 Apr 2025 17:22:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6t3s01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 17:22:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 531HMlc040698514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 17:22:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6652F58063;
 Tue,  1 Apr 2025 17:22:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 611AE58061;
 Tue,  1 Apr 2025 17:22:46 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.127])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Apr 2025 17:22:46 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com
Subject: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
Date: Tue,  1 Apr 2025 10:22:43 -0700
Message-ID: <20250401172246.2688-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E5CZi7-P35wKkuHSuF526kPFtZkSxNbH
X-Proofpoint-GUID: E5CZi7-P35wKkuHSuF526kPFtZkSxNbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=738
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010104
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

 block/nvme.c                  |  37 +++++----
 include/qemu/host-pci-mmio.h  | 116 ++++++++++++++++++++++++++
 include/qemu/s390x_pci_mmio.h |  24 ++++++
 util/meson.build              |   2 +
 util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
 5 files changed, 311 insertions(+), 16 deletions(-)
 create mode 100644 include/qemu/host-pci-mmio.h
 create mode 100644 include/qemu/s390x_pci_mmio.h
 create mode 100644 util/s390x_pci_mmio.c

-- 
2.43.0


