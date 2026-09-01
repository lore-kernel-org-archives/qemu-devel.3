Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FEDC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SUU-0002Gn-Ed; Tue, 01 Sep 2026 13:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUS-0002GN-Az; Tue, 01 Sep 2026 13:41:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUP-00017Q-F9; Tue, 01 Sep 2026 13:41:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H5Ead1668537; Tue, 1 Sep 2026 17:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=SH8+I15euMRCor96TZRo2LUb56VNaAnYt9Lqp9MrA
 0E=; b=JSQLizVxA9eBW1/ce8VyqXEJi1VM0ypKQ+BupF1PeL6IvtTxpstXtQL1V
 jzooU86yCgxBt58uZFWkklv5GxGpP56L2XPKZr0gwicquJBish3ehOuerd1HzQLg
 nsp60m9qXAkGwlPbgZNXHClphTK7cFGjv9RxpEhebOZYQolPx0vbYu/ty2wckuzo
 yeuYh2g8X2q0BYVNmBwN1onNCWbvJJLc3KMNntDouyWOUxURi5YzyU/Qdw9ELciI
 A79BWRrL2UN6TshK50maO4A6NmabjsAbxZx4TjR442Pcf0NfRqJ5YvGgEyQIXoMX
 kPQWO8ib1DL234aTlIshex1LJNW6g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhsffc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681HQGAr021854;
 Tue, 1 Sep 2026 17:41:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygcvbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 681HfUHZ36635038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 17:41:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4554E20043;
 Tue,  1 Sep 2026 17:41:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C43EA20040;
 Tue,  1 Sep 2026 17:41:26 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.219.126])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 17:41:26 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v5 0/6] ppc/spapr: Add RTAS error injection support for VFIO
 EEH
Date: Tue,  1 Sep 2026 23:11:04 +0530
Message-ID: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: b8K9xVRKy9xMqwsOfljjBRA_wR6EeD7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX2YMwQglfcHJ4
 Yh7jwp9FVsI2EGkrS+jwClb9wq0xrgiWwkUpu1hrqqzIYXwPaGpFRulqSr1jTMJYezNrI63eE3k
 VmaY11a1POOow3ieVbvAORxJCxwD7xtjAMnKMAOWFlzBFNV3XLQz9OXfGerzDq0YQy936ezkwMT
 pKqPQNLiIXbOFjOVayH/QVnH5kBd65Apq1oT+iQZNQlXmd9ox+4WIDtOg7Fleub2hnP0HFv5Whb
 YL5KtHz6WNSqUgBu5XJTq32jmsSWY9P9i3+iVOEbu/cuOmmxgDYbbiiaIHZXhbLSecGvsNGi6ex
 mPH3Ohja2QsOWeSNER0jEKgMHMWxSHv6SV+CaJiE8nQ8HEqdkU4UGa953dppoCLTHL/KFezXTTm
 3RMUcdOVKtJcbrZHvD9e+klACVKQVhn64GyvnvRqVac40Dwql6QPJGMmwv6/zZaPITcW2Umd3Wf
 057M/pnHZMPjAZ4C+Lg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a970e51 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8
 a=jd-kljAV4aIsPUV3Z5sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX7oyDQuqkmDBY
 jTQWOPzdDfSkd8sr459RVddpIAFXmOALjRlmlzBAP2HKG4EsFJTjF8mGRYETwcoFmdXSci3swMz
 fBvchRynLefuIuaXoJoCCjWxWvCc0GQ=
X-Proofpoint-ORIG-GUID: hoQzvfGkvKctzbBHTjDARldXoLVC9aSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010155
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

For IOA bus-error types, QEMU uses the BUID from the RTAS parameter buffer to
select the target PHB. For address-scoped IOA injections, QEMU translates the
guest BAR address to the corresponding host resource address before invoking
the VFIO EEH backend.

RTAS IOA error types are converted to the EEH type values expected by
VFIO_EEH_PE_INJECT_ERR:

 - RTAS_ERR_TYPE_IOA_BUS_ERROR    -> EEH_ERR_TYPE_32
 - RTAS_ERR_TYPE_IOA_BUS_ERROR_64 -> EEH_ERR_TYPE_64

Requests with addr=0 and mask=0 are treated as non-address-scoped IOA
injections and are forwarded without address translation.

Non-IOA RTAS error types are parsed and validated, but return
RTAS_OUT_NOT_SUPPORTED in this series because their RTAS work buffers do not
carry enough target information to safely select a VFIO PE.

Tested on pseries and PowerNV hosts with KVM guests using the powerpc-utils
errinjct tool, together with the corresponding host kernel EEH RTAS error
injection patches:
https://lore.kernel.org/all/20260831065441.48654-1-nnmlinux@linux.ibm.com/

Patch Organization
------------------
Patch 1: Adds the VFIO backend for error injection
Patch 2: Implements the ibm,errinjct RTAS call handler
Patch 3: Adds session management (open/close) RTAS calls
Patch 4: Advertises capabilities via device tree properties
Patch 5: Refactors EEH specific code/stubs to new files.
Patch 6: Updates MAINTAINERS file

Changelog:

v5:
 - added the missing files on patch 0005.
 - move the VFIO EEH stubs into a separate stub file.
 - Keep spapr_pci_vfio.c as the Linux/non-VFIO fallback path
  and build the real EEH implementation from spapr_eeh.c 
  when CONFIG_VFIO_PCI is enabled.
v4: 
  - Removed the first-PHB assumption in ibm,errinjct.
  - Use BUID from the IOA RTAS parameter buffer to select the target PHB.
  - Added guest BAR to host resource address translation for address-scoped
  IOA injections.
  - Skip address translation for addr=0 and mask=0 IOA requests.
  - Convert RTAS IOA error types to VFIO EEH type values before issuing
  VFIO_EEH_PE_INJECT_ERR.
  - Keep spapr_phb_vfio_errinjct() signature unchanged.
  - Validate non-IOA RTAS error types but return RTAS_OUT_NOT_SUPPORTED.
  - Removed host /proc/device-tree/rtas/ibm,errinjct-tokens probing.
  - Always build the guest-facing ibm,errinjct-tokens blob in QEMU.
  - Fixed ibm,open-errinjct return-cell layout on error paths.
  - Fixed ibm,close-errinjct token validation when no session is open.
  - Initialized errinject_tokens to NULL.
  - Removed stale CONFIG_DEVICES include after dropping the associated ifdefs
  - Renamed the split EEH file to hw/ppc/spapr_eeh.c.
  - Added Pierrick's Reviewed-by tag on the refactor patch.
  - Added sPAPR VFIO EEH reviewer entry in MAINTAINERS.
v3: 
  - Fixed the build failure reported at https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
  - Also fixed a gitlab CI breakage in patch 2 (qemu_log_mask LOG_UNIMP)
v2: Addressed refactor suggestions from Cedric, Pierrick
v1: https://lore.kernel.org/all/20260512071112.9675-1-nnmlinux@linux.ibm.com/

Narayana Murty N (6):
  ppc/spapr: Add VFIO EEH error injection backend
  ppc/spapr: Add ibm,errinjct RTAS call handler
  ppc/spapr: Add support for ibm, open-errinjct and ibm, close-errinjct
  ppc/spapr: Advertise RTAS error injection call support via FDT
    property
  ppc/spapr: Split VFIO EEH support from general VFIO code
  MAINTAINERS: Add self as sPAPR EEH reviewer under PPC RAS

 include/hw/pci-host/spapr.h  |  37 +--
 include/hw/ppc/spapr.h       |  69 ++++-
 include/hw/ppc/spapr_vfio.h  |  31 ++
 hw/ppc/spapr.c               |  61 ++++
 hw/ppc/spapr_eeh.c           | 571 +++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c           | 193 ++++++++++++
 hw/ppc/spapr_pci_vfio.c      | 315 +------------------
 stubs/spapr_phb_vfio-stubs.c |  62 ++++
 MAINTAINERS                  |   2 +
 hw/ppc/Kconfig               |   2 +-
 hw/ppc/meson.build           |   1 +
 stubs/meson.build            |   1 +
 12 files changed, 994 insertions(+), 351 deletions(-)
 create mode 100644 include/hw/ppc/spapr_vfio.h
 create mode 100644 hw/ppc/spapr_eeh.c
 create mode 100644 stubs/spapr_phb_vfio-stubs.c

-- 
2.51.1


