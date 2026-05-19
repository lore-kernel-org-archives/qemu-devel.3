Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335C2CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHlo-0001kG-DY; Tue, 19 May 2026 06:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHlm-0001jy-2h; Tue, 19 May 2026 06:33:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHlj-0004v3-VM; Tue, 19 May 2026 06:33:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J1faTg1588176; Tue, 19 May 2026 10:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=IjIlisRXua7wq66+wx+4blksupYxvyGfemi1/KH2l
 Mg=; b=s8MjqzIsEwSRP2XbtYKtOeKMWvWOx16ZYmKczvM1d9hn2untZ32mZESKA
 wBomHTUmMY81vKksCas1hVTC75y2wtdUHGX9P6EdyWrVK1C6iaurMzwKN+iSVlkz
 HUCKgZzQfqTa3CVRqXeuO0BOiucT7MAyunQ+I3Qhvcee9iU+oXXppaXA+xyvB5JD
 f5wMZ/ZCdUl2xVC44kCzZzr6TiksC/6bTgTR83QSd/ADjaRf/Ga8cypPDracyW0G
 I1Km2hw/aEtPX9fIFk9Ef7huSCmi0L0HwbJ9/ZDsuw1OhTBxPeyifF18GHDHsrOq
 XulxQsbtrT8s51okm2xOzp7RoEPfA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8brc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAOAhx005324;
 Tue, 19 May 2026 10:33:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk2434-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64JAXdcd44368206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 10:33:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E094920043;
 Tue, 19 May 2026 10:33:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 888A520040;
 Tue, 19 May 2026 10:33:37 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 May 2026 10:33:37 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v2 0/6] ppc/spapr: Add RTAS error injection support for VFIO
 EEH
Date: Tue, 19 May 2026 16:03:18 +0530
Message-ID: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5OSBTYWx0ZWRfX1VbKvOD+cWnY
 bur8T69hBqUJI6IHs86NcpwF4dvtysGQMwI8IRQsNT6fLfixTqMesL2M2vA0p0zA9LTDO4vhu9g
 w0jNuuLeCz6L0SkBcMWn8401dTHyMEUqjnf8mW5E6aMPooso5jUNqtYSSNCEwgEYFeUS95e/IF6
 bFh+rQNUFFcnEfXmYu376sWz/TvnndEUV8HEYWUWTP6Q5jyGlK976+RR/nUrSE1syItFAkaPmqr
 z9wT3pPLvJSFra7yGNgTlgUQf6i9Z6fNp0tsRMjNRnyMgHG8dk6mtuqINsrk58UPq8jmnsJKx5Y
 ltbcS3FzhnT10BZiwAwBJruCTargYkhfgYAC2KlhkAUj/XHjFux6QaEkzuG5auPB8+tiCtMZfFx
 zqeHi7oZtRa+LCscu8iESMw+Lgm3DAui7+qL+MqsRPdAfy5G3YwtSS908ORGyO3b7IaWcBLx5GD
 2rjKn0i1dY11XiG5rpw==
X-Proofpoint-GUID: jHycSm9Mc0dfr9g_pZaqfJQ_EDu_LM22
X-Proofpoint-ORIG-GUID: 8JHGobuR0yIpAXtJcO-Ub9eE8uTiQZ9v
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0c3c88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dRcmrOfJHJXJGJuO5nYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190099
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
 hw/ppc/spapr.c               | 106 +++++++++++
 hw/ppc/spapr_pci.c           | 219 ++++++++++++++++++++++
 hw/ppc/spapr_pci_vfio.c      | 314 +------------------------------
 hw/ppc/spapr_pci_vfio_eeh.c  | 346 +++++++++++++++++++++++++++++++++++
 include/hw/pci-host/spapr.h  |  37 +---
 include/hw/ppc/spapr.h       |  57 +++++-
 include/hw/ppc/spapr_vfio.h  |  28 +++
 stubs/meson.build            |   1 +
 stubs/spapr_phb_vfio-stubs.c |  52 ++++++
 12 files changed, 818 insertions(+), 351 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_vfio_eeh.c
 create mode 100644 include/hw/ppc/spapr_vfio.h
 create mode 100644 stubs/spapr_phb_vfio-stubs.c

-- 
2.54.0


