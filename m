Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD430CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 07:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMhHs-0002cU-1d; Tue, 12 May 2026 03:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHL-0002bQ-H8; Tue, 12 May 2026 03:11:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHJ-0002Ih-Pb; Tue, 12 May 2026 03:11:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6xAf3178617; Tue, 12 May 2026 07:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=zosfJQ08Anx3YBUYabH+YxUBuPubB0dNv9F994/bv
 yY=; b=hdPRDpUB7S1XOJb4ozL/nTcRx//H6L4JhduEpNq3O5V5cJzgSys1EN7GY
 NLkho5VBgJwk/dRxliomv+ADYBvipVkBwi3OXRI8afoxIPp0A4i/1VV1Qw+onB4U
 fOLIQzKrZMXS1uJFU0uXIQOCNe4mlhv6VCjoZoGY0gTPNNeky7E+evK9gsuTK75P
 ZHTCWkoTPHDWw0wa5hJLiWYmv9mT68BEkmt75AnCfVEyepWzcmY3cdCNXvkGAfsE
 /Nxk/b6VY6SXmpVtE9F3qcVyGYu4HbMYCNzQ+mW9SVj3OLCnct6TtptcA0uaqYr/
 S36SS6uZT71y9wR23G5+uGJuULnDw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6hs3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C79Ptj015812;
 Tue, 12 May 2026 07:11:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgj31d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64C7BXGm61932030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 07:11:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E623320043;
 Tue, 12 May 2026 07:11:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FECC2004B;
 Tue, 12 May 2026 07:11:30 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 07:11:29 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH 0/6] ppc/spapr: Add RTAS error injection support for VFIO EEH
Date: Tue, 12 May 2026 12:41:05 +0530
Message-ID: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a02d2aa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=cikDAJVF2zCEbyfCmuUA:9
X-Proofpoint-GUID: g4PQ9fyT84-ARNxTYNkFRjUbzy6-OeGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2OCBTYWx0ZWRfX56rADapSKXwP
 cO6ubRkxxM7fPP+9RqQHZ9lopLgns51sw+ORu5+HAcfn7gSgcn2ucomWth1+CEPYKyQuU3YUHqh
 MTXnhDnWwkLpedrgef/+Hyf/pSbwcE5gAeYNJvDDBLDvJcG/Z5EWy3OXY9RnVylH+XHo7RcHvEW
 iCxar33vlofK2Tt/CKRDHGCODKhelWlRDLxd3QjEai7sHACKdITCOAZW/d2taUCKA0aIMrV2SVU
 8msCNNJIu8r0BzATkS/paTP6g/RbUoJdDzpCX/yxtMz916N3CHcCpfWF6dlULrLmHFO9ouPESYt
 WZzdrkWQZGxmaEC3P+tKkabFGOTRyhxdJIwlU+Ca/dmra1XDUtUeIs261pZaeNYFJf1jOMJi2Ek
 SYho01+aMHEB3EWuvkFRbW3YIqyDHZHKvUUVpGq+eQgc7EJwBkRa8fCYqQTGrtIjYdo8p7e9BH9
 pF5sW4Dft2ZH0alXCXQ==
X-Proofpoint-ORIG-GUID: mTOKJOSCTk8SL98poGLDMxQ5mQG3c5ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120068
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
Patch 5: Refactors file naming for clarity
Patch 6: Updates MAINTAINERS file


Narayana Murty N (6):
  ppc/spapr: Add VFIO EEH error injection backend
  ppc/spapr: Add ibm,errinjct RTAS call handler
  ppc/spapr: Add support for 'ibm,open-errinjct' and 'ibm,
    close-errinjct'
  ppc/spapr: Advertise RTAS error injection call support via FDT
    property
  hw/ppc: Rename spapr_pci_vfio.c to spapr_pci_vfio_eeh.c
  MAINTAINERS: Add entry for sPAPR PCI VFIO EEH support

 MAINTAINERS                                   |   6 +
 hw/ppc/Kconfig                                |   2 +-
 hw/ppc/meson.build                            |   2 +-
 hw/ppc/spapr.c                                | 106 ++++++++
 hw/ppc/spapr_pci.c                            | 232 ++++++++++++++++++
 ...{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} |  65 ++++-
 include/hw/pci-host/spapr.h                   |   8 +
 include/hw/ppc/spapr.h                        |  57 ++++-
 8 files changed, 464 insertions(+), 14 deletions(-)
 rename hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} (85%)

-- 
2.54.0


