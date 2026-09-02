Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F64C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jSS-0005Ak-8z; Wed, 02 Sep 2026 07:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1jSQ-0005AH-UC; Wed, 02 Sep 2026 07:48:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1jSP-0002Ql-Bo; Wed, 02 Sep 2026 07:48:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6829VtR33694632; Wed, 2 Sep 2026 11:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1KfLH1
 JXMaR2g4wWlgr8lmiM3in9NyhRsL+TxVacxeU=; b=iZ+WR7QoXThKia37Syyfyf
 GgGaAtRseTG3xFXSih3zsUoqsnpzTkSIKOWo3NyYA80sIOJhFHGbm9iDXAG7yVPx
 m1Acc2J1goYdxuwz09ZAcJ07wQyg34+F5KnckdE4rBGGVZNIJVy8iuLquPGajGLU
 nt+ASf7J2L7708zJWBodNS8ViPh63faIzTdzUvaCYf/lhfr2OeflwzpFGro4EBBn
 jwb3RmqG/C+d5zC1K/VeZpaicEIq2HkQ5whcX20iVVEZ3oirqYnstV8yZTR3/zpe
 0mahbkFXSznhvqhIxUOb83JmbBG1CbeA+DqBSVTt5OkIhfQYIQRH30mWHIdICHsQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhx1ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 11:48:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682BfNwf031227;
 Wed, 2 Sep 2026 11:48:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hhc47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 11:48:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682BmbGL51249658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 11:48:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5D3F20040;
 Wed,  2 Sep 2026 11:48:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75AD92004D;
 Wed,  2 Sep 2026 11:48:35 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 11:48:35 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 adityag@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH v1 1/2] ppc/spapr: Preserve MSI-X shadow across EEH PE reset
Date: Wed,  2 Sep 2026 17:17:57 +0530
Message-ID: <20260902114758.85160-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902114758.85160-1-nnmlinux@linux.ibm.com>
References: <20260902114758.85160-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: U-sW4tgoOK9HVA-y5kw2klqhyIid2EOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfXzgxF+WU7r+mC
 USyy/nGrDx/acqLr8AX+GZ4e0dw+THM6/+XEhkGBX+LZQo9f6kH7KIt9XaAv1jarSPmOBaR0vro
 wAXvmChXsYUCCzVPReZUEJIuJxVXnbVsawO6Rome2n04LueSSHjaFI5TWJ3Mne3+3mY1QV3W5/8
 UQroGEkl0FYXG5LzwgM1Rs5iKZddJwAKF/ZCxOJi6uKWbZ1LXS8lzr8OktO8GkoQnFF+0gAj4Ie
 wy6pfG8qSTrFFFSB5UNeBwHvGLVBKg98zSDeQJU3xgXKNReq+FTAgQYQqkykUNXYEgKSa5YvAqG
 laQaZAA91oCIFZGAGGjbp/hKkQk1qs1T7z8qbzP+IjKhilMVdYEdcwnwbjE2Av7y9X1+o/tbe3j
 Uqai3yOtyttIxVgEy+qF07lCXEMi9LPMEQaLWgOqrxVwCUTFNvYU8xaiRGI0jFMX2ryxtQjBMpA
 mC7U+qaH1pkxDYxKmJQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a980d1b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=OvJMSl6P30iQFxEnM-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfXxJvvUobpyjRl
 WC0FGulx3s/WrPyF/ciHRpsU8YRmZhgo7LUGD0SLI4dK1ednjrv/v1yZ7N/Fb+vejAXBcsBn8bx
 Agf+punnefr8d8DDcg20v0jvXsy5Wro=
X-Proofpoint-ORIG-GUID: R9NP4urkbnzOAdABOmaKTxRVAd_7gB70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020102
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

On pSeries, the MSI-X table shadow in QEMU is not sourced from the
physical device.  It is populated by sPAPR RTAS through the
ibm,change-msi call path:

  ibm,change-msi
    -> spapr_msi_setmsg()
      -> msix_set_message()      /* writes each shadow entry */

As per PAPR+ §7.3.10.5.1 R1–14, the platform must restore the IOA's MSI
configuration space across a reset; the guest therefore does not
re-issue ibm,change-msi after EEH recovery, and the QEMU shadow must
survive the PE reset intact.

EEH recovery does not necessarily cause the guest to re-issue
ibm,change-msi.  The guest VFIO PCI driver restores interrupt delivery
by writing MSI-X Enable = 1 directly via config space.  QEMU then
dispatches through:

  vfio_msix_enable()
    -> vfio_msix_vector_do_use()  /* re-arms KVM irqfd from shadow */

The existing EEH pre-reset helper calls msix_reset() after clearing
MSI-X Enable.  msix_reset() zeroes every shadow entry.  Without the
shadow, vfio_msix_vector_do_use() cannot reconstruct the KVM irqfd
routes and device interrupts do not recover after EEH.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr_pci_vfio.c | 56 ++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index a748a0bf4c..c233822d14 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -25,6 +25,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
 #include "hw/vfio/vfio-container-legacy.h"
+#include "hw/vfio/pci.h"
 #include "qemu/error-report.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
@@ -233,47 +234,56 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
     return RTAS_OUT_SUCCESS;
 }
 
-static void spapr_phb_vfio_eeh_clear_dev_msix(PCIBus *bus,
-                                              PCIDevice *pdev,
-                                              void *opaque)
+/*
+ * Prepare a single VFIO PCI device for an EEH PE hot or fundamental reset.
+ *
+ * On pSeries the MSI-X table shadow is populated by ibm,change-msi via
+ * spapr_msi_setmsg() -> msix_set_message().  EEH recovery does not
+ * necessarily re-issue ibm,change-msi; the guest restores MSI-X Enable
+ * directly, causing QEMU to dispatch through vfio_msix_enable() ->
+ * vfio_msix_vector_do_use(), which re-arms the KVM irqfd routes from the
+ * existing shadow entries.
+ *
+ * Therefore, msix_reset() must NOT be called here.  Calling it would wipe
+ * those shadow entries and prevent interrupt delivery after EEH recovery.
+ *
+ * Instead, clear MSI-X Enable using the cached pdev->config shadow (avoiding
+ * a read from potentially frozen device config space) and write through
+ * pci_host_config_write_common() so that the VFIO config-write handler calls
+ * vfio_msix_disable(), cleanly releasing vectors and KVM irqfd routes while
+ * leaving the shadow intact.
+ */
+static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
+                                           PCIDevice *pdev,
+                                           void *opaque)
 {
-    /* Check if the device is VFIO PCI device */
-    if (!object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
+    uint16_t flags;
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
         return;
     }
 
-    /*
-     * The MSIx table will be cleaned out by reset. We need
-     * disable it so that it can be reenabled properly. Also,
-     * the cached MSIx table should be cleared as it's not
-     * reflecting the contents in hardware.
-     */
     if (msix_enabled(pdev)) {
-        uint16_t flags;
-
-        flags = pci_host_config_read_common(pdev,
-                                            pdev->msix_cap + PCI_MSIX_FLAGS,
-                                            pci_config_size(pdev), 2);
+        flags = pci_get_word(pdev->config + pdev->msix_cap + PCI_MSIX_FLAGS);
         flags &= ~PCI_MSIX_FLAGS_ENABLE;
         pci_host_config_write_common(pdev,
                                      pdev->msix_cap + PCI_MSIX_FLAGS,
                                      pci_config_size(pdev), flags, 2);
     }
-
-    msix_reset(pdev);
 }
 
-static void spapr_phb_vfio_eeh_clear_bus_msix(PCIBus *bus, void *opaque)
+static void spapr_phb_vfio_eeh_prepare_bus(PCIBus *bus, void *opaque)
 {
-       pci_for_each_device_under_bus(bus, spapr_phb_vfio_eeh_clear_dev_msix,
-                                     NULL);
+    pci_for_each_device_under_bus(bus,
+                                  spapr_phb_vfio_eeh_prepare_dev,
+                                  NULL);
 }
 
 static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
 {
-       PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
+    PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
 
-       pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_clear_bus_msix, NULL);
+    pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_prepare_bus, NULL);
 }
 
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
-- 
2.51.1


