Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CF8CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 07:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMhIJ-0002jg-G3; Tue, 12 May 2026 03:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHh-0002cd-EU; Tue, 12 May 2026 03:12:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHc-0002jl-K2; Tue, 12 May 2026 03:12:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7B1n2760204; Tue, 12 May 2026 07:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NT7/BzFaSt0PGWjC7
 EzZEGgjIuk6ErHcC/mLQ+QDjVs=; b=MzfUAYZLvOtASU33raI/TOH0uRgCGTQ6W
 D4pJqwhkJcTihScrHpDQ4xSAEYcQ2xpocGs9iF3dCH61o+LsUPdGO9SqQbCaaDa8
 oU1G9eseHqIxhz7oAWzpYdf9DkPOBeAwT/64ptVeTse9m1KCE1yL4gXTg0N5C1Ue
 AJPZZgky9oBDcQmL0gpJoQPf+ON/oeL2tFRoey7m3jjITVnOBpITGBp6GW3yBtdw
 XevJJNlV5Q3g5iB7/doLmoOJQiz4uCs2xUokoK78TjRKZou1BRFeS0P61+cXo64n
 vbl6aLomOFsqr8cHjnY2yX/AprPF8Cy7ULBcgPPyzuKhgjvn8J5ZQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6hsby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C79PSC012545;
 Tue, 12 May 2026 07:11:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgt35w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64C7BrWG59703676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 07:11:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6AC22004D;
 Tue, 12 May 2026 07:11:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BDB120040;
 Tue, 12 May 2026 07:11:50 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 07:11:49 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH 5/6] hw/ppc: Rename spapr_pci_vfio.c to spapr_pci_vfio_eeh.c
Date: Tue, 12 May 2026 12:41:10 +0530
Message-ID: <20260512071112.9675-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Y2qpYFKvYX3xOiLKnxy0g3ZN4Ur3l6RK
X-Proofpoint-GUID: j8PWzHs7n37R7-GwJTARJ3ZUFzN-WVx9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2OCBTYWx0ZWRfX0UhE7FEz7AHR
 K0/D+U7iXEANeQQv9eD3vdW/OKkYHwp0x7ED3UMsmfXbfzdaqgduo2t+VtE1O32zP0qkJQpVcV4
 p8pFVAlLee5ka0TRrIn6ku1Lcfl78HRnWAy6xf8Y6LIi8RXRjKcMFgNc+pvwl3W/rWzfhb06cnt
 WF+jcTCqoi7ZqM6Dvpzrvue8j/+4ot2oMrzb5NyDGMchZRPS/nX0ZFUZNGlGiowtsY33GieH+cF
 I/UmFwRWZi+JQZDbUzMAnvAbo2R6ES221Cq/hb9RYhk8ktXuQ/KJ1vTbHC/M0wbsALBGxkQxnN+
 e6i+9MVJQjl3pqb0kEC6FefdIzs0WBSZnvnSDXJxMrbdHYjUFXSYWzfU/ovVI7yp5B4xj1/jEpp
 Y/EZq69umLEy/wytoWnKt/Yz/KKWpvMmcPLft+lzcBM+sDYEpQubH3A3cQ7ks3lQM4NXYnfArx+
 gfA7QQCl40sZj86svfw==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a02d2be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HwzBOX78but4wOTT2bgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120068
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

The file spapr_pci_vfio.c contains exclusively EEH (Enhanced Error
Handling) related functions for VFIO devices on sPAPR platforms.
To better reflect its specific purpose and improve code organization,
this commit:

1. Renames spapr_pci_vfio.c to spapr_pci_vfio_eeh.c
2. Moves spapr_phb_vfio_eeh_reenable() from spapr_pci_vfio_eeh.c to
   spapr_pci.c, as it's a general PHB operation not specific to
   VFIO EEH error injection/recovery

After this change, spapr_pci_vfio_eeh.c contains only the core VFIO
EEH error handling functions, making the file's purpose more focused
and clear.

This is a refactoring change with no functional impact.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/Kconfig                                    |  2 +-
 hw/ppc/meson.build                                |  2 +-
 hw/ppc/spapr_pci.c                                | 14 ++++++++++++++
 hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} | 12 +-----------
 include/hw/pci-host/spapr.h                       |  1 +
 5 files changed, 18 insertions(+), 13 deletions(-)
 rename hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} (96%)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 347dcce690..886ce71ef8 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -6,7 +6,7 @@ config PSERIES
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_VGA
-    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
+    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio_eeh.c
     select NVDIMM
     select DIMM
     select PCI
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 37aa535db2..7cf0226b5e 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -35,7 +35,7 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
 ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 if host_os == 'linux'
   ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
-    'spapr_pci_vfio.c',
+    'spapr_pci_vfio_eeh.c',
   ))
 endif
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b00f71d92a..fcb7b850c0 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2215,6 +2215,20 @@ void spapr_phb_dma_reset(SpaprPhbState *sphb)
     tcet->def_win = true;
 }
 
+void spapr_phb_vfio_reset(DeviceState *qdev)
+{
+    /*
+     * The PE might be in frozen state. To reenable the EEH
+     * functionality on it will clean the frozen state, which
+     * ensures that the contained PCI devices will work properly
+     * after reboot.
+     */
+    spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
+}
+
+
+
+
 static void spapr_phb_reset(DeviceState *qdev)
 {
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(qdev);
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio_eeh.c
similarity index 96%
rename from hw/ppc/spapr_pci_vfio.c
rename to hw/ppc/spapr_pci_vfio_eeh.c
index ed0b22a84a..c00cf1d24b 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio_eeh.c
@@ -131,21 +131,11 @@ bool spapr_phb_eeh_available(SpaprPhbState *sphb)
     return vfio_eeh_as_ok(&sphb->iommu_as);
 }
 
-static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
+void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
 {
     vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_ENABLE);
 }
 
-void spapr_phb_vfio_reset(DeviceState *qdev)
-{
-    /*
-     * The PE might be in frozen state. To reenable the EEH
-     * functionality on it will clean the frozen state, which
-     * ensures that the contained PCI devices will work properly
-     * after reboot.
-     */
-    spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
-}
 
 static void spapr_eeh_pci_find_device(PCIBus *bus, PCIDevice *pdev,
                                       void *opaque)
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 417d1f6c31..5ca122a5f1 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -125,6 +125,7 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
 int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
+void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb);
 int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t func,
                             uint64_t addr, uint64_t mask, uint32_t type);
 #else
-- 
2.54.0


