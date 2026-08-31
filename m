Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C4FC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wLp-0006nA-7j; Mon, 31 Aug 2026 03:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wLn-0006mb-1P; Mon, 31 Aug 2026 03:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wLl-0007Dm-58; Mon, 31 Aug 2026 03:22:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52qjC1271130; Mon, 31 Aug 2026 07:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tQtPz5I9iUFg/gibO3veoIDietnWqM7xaj0++tPBz
 Sc=; b=ezL2CGA4A9/W3sy3mwtfiaLA79/RS++HaZYnYfygZnef0SCIasLb/rEWg
 kKEGz4htRLV9Dxd6A3bxLHfrzX0WBtTpYgjVxuulj9AR6eb68XaAgnUm0z69/FY9
 GKN9koPmxeBMDy8a+cSdAC9Z99knsFLkA6MHLFzMFAm9BdEK47jNcokh+cI2tKX+
 /4+0ekaRBmfp7hALTxZg7Mzt3N27Q1n0HnB86OM+QNxqovQWdjydZpFKM9K/qpUS
 4MBdnBQeEdRF5sm6dfKJHDVQyzK7kgRtbLzu75iJd3eipU8EGAS0K5hOPCA2IFO6
 oiqz+RxFAPtdh6HGIajHpDpOPi0Sg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54fs1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V6uUcI007343;
 Mon, 31 Aug 2026 07:22:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h4gfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67V7MP1e42074556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 07:22:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7176520040;
 Mon, 31 Aug 2026 07:22:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9635520049;
 Mon, 31 Aug 2026 07:22:22 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 07:22:22 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v4 0/6] ppc/spapr: Add RTAS error injection support for VFIO
 EEH
Date: Mon, 31 Aug 2026 12:49:52 +0530
Message-ID: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX5vPVj94P3kE8
 QQF38klDm87kp1GWctTXxFl3wlQHOZvgSfD3+wFhUZhBJ2jRrZVZjo7pPQAI4y8br5KJv07u91V
 c90zM+YOXXajmAgA81lUdalbP0TGkvpog/gdF5TiwA+NE9vtiYEu4akexqT7bsWN5a3urCJQZOz
 REBbjdTF42lKahgqbrlXPQaaMYta7Jj0HV1kfxzvki8UxHMF2e3HJBPHDFJamWHlf1+0jEMDEJi
 aWZwJZYRV2vGKwzCpvoI483wrD0uKtXD5v6UJxsgKjNLJZBg8aVZuppLpXxwsiI+MHjBDOxHtNQ
 Qvp29o3fiP5nI1zh3JCMsFnY3utHJ2uc+5JtISwkOwnKI/zDW9gk0nNG86YMAh/yaSc2vGCzdAo
 jaQjjoayvFV4ZWIQSMXH1net2Q2twy1GCXiDwPN6E9LYPIXeT1A5mM5Nly7R0+G3gsFVRSBTm4b
 +NrSlOTv1iX77+BE8Aw==
X-Proofpoint-ORIG-GUID: SOIkIRJGI99rD7HCT9gzlGdBhl1n3lWX
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a952bb9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8
 a=ae3sn-e1oJBP7Y9sRTIA:9
X-Proofpoint-GUID: QyDhahv7CmCfi0mPleh_bwx0-f5MSAR1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX4dlbLvu6owwo
 PnRrXDOoZ+wzVbZHKuVtPJ0eDsV0SmVAhK9TfJFv3SRqZTeDXMp1zZBaxh3Bsr5MBN4qcz6v9dV
 7PboX/EP3pTT2eTySjdKW6hNJruDdmM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310059
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
errinjct tool.
Kernel side EEH patch v4:
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
----------
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
  - Adding self as sPAPR EEH reviewer.
v3: 
  - Fixed the build failure reported at https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
  - Also fixed a gitlab CI breakage in patch 2 (qemu_log_mask LOG_UNIMP)
v2: Addressed refactor suggestions from Cedric, Pierrick
v1: https://lore.kernel.org/all/20260512071112.9675-1-nnmlinux@linux.ibm.com/

Narayana Murty N (6):
  ppc/spapr: Add VFIO EEH error injection backend
  ppc/spapr: Add ibm,errinjct RTAS call handler
  ppc/spapr: Add support for ibm,open-errinjct and ibm,close-errinjct
  ppc/spapr: Advertise RTAS error injection call support via FDT
    property
  ppc/spapr: Split VFIO EEH support from general VFIO code
  MAINTAINERS: Add self as sPAPR EEH reviewer under PPC RAS

 MAINTAINERS                 |   3 +-
 hw/ppc/meson.build          |   6 +-
 hw/ppc/spapr.c              |  61 ++++
 hw/ppc/spapr_eeh.c          | 572 ++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c          | 192 ++++++++++++
 hw/ppc/spapr_pci_vfio.c     | 317 ++------------------
 include/hw/pci-host/spapr.h |  19 ++
 include/hw/ppc/spapr.h      |  69 ++++-
 8 files changed, 936 insertions(+), 303 deletions(-)
 create mode 100644 hw/ppc/spapr_eeh.c

-- 
2.54.0


