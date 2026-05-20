Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9964ECD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfEW-0003sg-VM; Wed, 20 May 2026 07:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPfEI-0003gU-F8; Wed, 20 May 2026 07:36:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPfEG-0006Gp-Ox; Wed, 20 May 2026 07:36:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JIXgrU3605721; Wed, 20 May 2026 09:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=mZEGhhtyvlKtEnCm/nW6cZsCqn3LC9VZ6aJFGkJWK
 LE=; b=WPNlnEJ4fTu1Z0taBFgH2zibxHqFNeWQcsq1NpkwhNluPwwUr1XaTho4C
 BLpuGC6oqBSSL9Z2J9YM3nBBZBEqdsVSlcYmO49G6LS+CiTFgNQw6COTUaAzbVz8
 nNrSNbH3NZmiC/yKg8SXbh+lwyx6qJdI+OdcSYvf48f9C00Dlaiu77MZotuDBANI
 el3Q0YAjU/uD0drbdxgRslklR4w4bBn7H2pGSlFlU4/KzJ6Nx14JJrwpksPaL4WR
 rWVXBGII4mvGu9rMZ9uztvhpEo29Akm5u7LQG8/7ydzsWImE8u6ed8dqzf7sBijm
 z0ONm5Ic8xRONKeRBAJva6trWafYw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw8fu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 09:55:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K9sBis030687;
 Wed, 20 May 2026 09:55:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vxvym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 09:55:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K9suu553412206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 09:54:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81C102004D;
 Wed, 20 May 2026 09:54:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 201AE2004B;
 Wed, 20 May 2026 09:54:54 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 09:54:53 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v3 0/6] ppc/spapr: Add RTAS error injection support for VFIO
 EEH
Date: Wed, 20 May 2026 15:24:40 +0530
Message-ID: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5MiBTYWx0ZWRfX1jQL184gth3y
 sogkhxmtZ3TbNCzLmTtqaMkMumS2ob7MG2KpWjQHaZYD9kMWpRTvDuPn3tDF3s7m/fSY8dBEBhZ
 NAPH6awTey9mF/p6mKyp0pIj6LGWYLxyerK9oI6fgcjFhLvDwgYz8Vb/DYLU3yX7jZGjRpxdXZx
 kkMWCoc219bB8GfDsiedRIF7hmINQk7d9UCWF9BhAWG41AugkVBAQ0C2EHaFxrjto8pkZDMa9nV
 +5CI8KjPw/WNwoRiQKj2GGjwY8JgdLmUCZzuMO6t7gNu75uBlBcNYzAC1EI6OawmpLV8ee/5Wak
 GZxuaNrTHKzcphkS5fPgzDXQMKfhLiqfP+T7Wi5qzGNDHlQ4C87hhyndJY61QS1X5DSWMs2QLk1
 9xn6jbLcEF54NO6ZXVsbClXf51BwoehIsPUw9C5TMLbh3RbA4ltLYlr7BHXjyc/IBtH/5Y5Ex8O
 Y+uw3pPXW40faUWF7mQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0d84f5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dRcmrOfJHJXJGJuO5nYA:9
X-Proofpoint-ORIG-GUID: Xe-dEZG6uiNIZb7vPCyRifLwHCoKSM1w
X-Proofpoint-GUID: 2SZ5v4BRhNSGXYstHPKYJRcriUrm8O79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200092
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series implements comprehensive RTAS-based error injection
support for VFIO EEH (Enhanced Error Handling) on PowerPC sPAPR platforms.
The implementation enables guest-initiated PCI error injection for improved
testing and diagnostics of EEH recovery mechanisms.

Background
----------
EEH is a critical feature on PowerPC platforms that provides error detection,
isolation, and recovery for PCI devices. Testing EEH recovery paths requires
the ability to inject various types of errors into the system. While physical
hardware supports error injection through firmware interfaces, QEMU's VFIO
implementation previously lacked this capability.

This series bridges that gap by implementing the IBM RTAS error injection
interface, allowing guests to inject PCI errors through the same firmware
calls used on physical hardware. This enables comprehensive testing of device
drivers' EEH recovery code paths in virtualized environments.

Implementation Overview
-----------------------
The patch series introduces three new RTAS calls:
  - ibm,open-errinjct:  Opens an error injection session
  - ibm,errinjct:       Injects a specific error type
  - ibm,close-errinjct: Closes the error injection session

The implementation supports multiple error types including:
  - IOA bus errors (32-bit and 64-bit addressing)
  - Memory/IO/Config space load/store errors
  - DMA read/write errors
  - Cache and TLB corruption scenarios
  - Special recovery events

Tesed on pseries and powernv hosts on kvm guest with errinjct tool.

Patch Organization
------------------
Patch 1: Adds the VFIO backend for error injection
Patch 2: Implements the ibm,errinjct RTAS call handler
Patch 3: Adds session management (open/close) RTAS calls
Patch 4: Advertises capabilities via device tree properties
Patch 5: Refactors EEH specific code/stubs to new files.
Patch 6: Updates MAINTAINERS file

Changelog:
----------
v3: 
  - Fixed the build failure reported at https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
  - Also fixed a gitlab CI breakage in patch 2 (qemu_log_mask LOG_UNIMP)
v2: Addressed refactor suggestions from Cedric, Pierrick
v1: https://lore.kernel.org/all/20260512071112.9675-1-nnmlinux@linux.ibm.com/


Narayana Murty N (6):
  ppc/spapr: Add VFIO EEH error injection backend
  ppc/spapr: Add ibm,errinjct RTAS call handler
  ppc/spapr: Add support for 'ibm, open-errinjct' and 'ibm,
    close-errinjct'
  ppc/spapr: Advertise RTAS error injection call support via FDT
    property
  ppc/spapr: Split VFIO code and refactor EEH interface
  MAINTAINERS: Add entry for sPAPR PCI VFIO EEH support

 MAINTAINERS                  |   6 +
 hw/ppc/Kconfig               |   2 +-
 hw/ppc/meson.build           |   1 +
 hw/ppc/spapr.c               | 104 +++++++++++
 hw/ppc/spapr_pci.c           | 219 ++++++++++++++++++++++
 hw/ppc/spapr_pci_vfio.c      | 314 +------------------------------
 hw/ppc/spapr_pci_vfio_eeh.c  | 346 +++++++++++++++++++++++++++++++++++
 include/hw/pci-host/spapr.h  |  37 +---
 include/hw/ppc/spapr.h       |  57 +++++-
 include/hw/ppc/spapr_vfio.h  |  28 +++
 stubs/meson.build            |   1 +
 stubs/spapr_phb_vfio-stubs.c |  52 ++++++
 12 files changed, 816 insertions(+), 351 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_vfio_eeh.c
 create mode 100644 include/hw/ppc/spapr_vfio.h
 create mode 100644 stubs/spapr_phb_vfio-stubs.c

-- 
2.54.0


