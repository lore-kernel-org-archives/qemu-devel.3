Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ABDC369CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TBx-0000wp-Mr; Thu, 17 Apr 2025 13:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u5TBq-0000lE-79
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:38:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u5TBn-0002OS-3Q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:38:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9eJdI017979;
 Thu, 17 Apr 2025 17:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=A1FBml6zuZV5S1znSsHgy7kEIVoS
 Aq5F74qFFcUZK5w=; b=ks2q3VEW3j/v1oYdeDuF8/1FUt8V1emmCEdu2aX8J2WR
 XEgycv1Q/xIPYNqNWyK4t6J+hxEfmgJwfUVIZAxkPGMq7MaWdhi+vz/8Y2T6BONt
 0Wd6gWCA5isFduNAb0g2PnmhKGZ65gGW/YNRWma13JD3I8ZbziasjxuEO/BTCqgM
 XLOVfqQIVeEP6HzziVS5C8vo9fiQR3Vfa7D1h6aNCXqxavJIncVuClp5xauKt023
 TqJou2Jcc7vAktAr5RsFlr5Z2VPH96Ke96Dq1E47R90cKMdmC3oIVoQj3NqkO/lf
 qW17neFt0+KlO2ebPBv3h2w7KuMFxCKGMh0Cwv0ivA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu54qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 17:38:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGwslm024888;
 Thu, 17 Apr 2025 17:38:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtq4kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 17:38:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HHc48o33227390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 17:38:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1683B58060;
 Thu, 17 Apr 2025 17:38:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7530E58056;
 Thu, 17 Apr 2025 17:38:02 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.65])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Apr 2025 17:38:02 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, alifm@linux.ibm.com,
 mjrosato@linux.ibm.com, schnelle@linux.ibm.com, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net
Subject: [PATCH v5 0/3]  Enable QEMU NVMe userspace driver on s390x
Date: Thu, 17 Apr 2025 10:37:58 -0700
Message-ID: <20250417173801.827-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=68013c7e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mDV3o1hIAAAA:8 a=crsOB1bfPne2PFP59U0A:9
 a=QEXdDO2ut3YA:10 a=WQTGfJf2NMsA:10 a=ZPqX8Ogbq0EA:10
X-Proofpoint-ORIG-GUID: 98Q1a8eqT0x9w11rWjrep0wLmIWNS_GI
X-Proofpoint-GUID: 98Q1a8eqT0x9w11rWjrep0wLmIWNS_GI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=812 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170128
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


