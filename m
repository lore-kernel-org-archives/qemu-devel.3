Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BEDC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jSX-0005Bi-13; Wed, 02 Sep 2026 07:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1jSV-0005BA-4N; Wed, 02 Sep 2026 07:48:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1jST-0002Ri-AV; Wed, 02 Sep 2026 07:48:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6829Vrsv2682987; Wed, 2 Sep 2026 11:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AwD1aylYY2X4Fz305
 M4RE/oo+keZ0tJCOnpKkTKYQzg=; b=JDN9UYG+I7llpt5vVtO4u5UImk5CnVLWi
 NC2pT+y8l2eliScsC9M2dGUIED9wUSIMP2pAsnlff1wRCamgZnkaHFYf9aGa5C3h
 VKGvZVwVKkT1S334cQLn6fNsMIXSDc7hr61Sww0uX1rMdm9qm4wcWxOReLiQ+YRW
 y5G/PzmSulgjel7rGpGiDAnctguk0kT5G/49/80irAs4MoyfkitVJ/yjwjOZdh4q
 NpDecUWH0lQvIv99HB792QWpC35gQ83ugNNpRSNRzH7f4TKVo7kjBnryFWJqLX80
 qT5EST5SrD2IAG2Kx00q9gwQoBrPfo7jU5l85qFLq0QDkSiDAlhEA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudww9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 11:48:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682BfMii019060;
 Wed, 2 Sep 2026 11:48:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark9e99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 11:48:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682Bme3g46661906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 11:48:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 510252004B;
 Wed,  2 Sep 2026 11:48:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EB7B20043;
 Wed,  2 Sep 2026 11:48:38 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 11:48:37 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 adityag@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH v1 2/2] ppc/spapr: Temporarily disable VFIO BAR mmap during
 EEH PE reset
Date: Wed,  2 Sep 2026 17:17:58 +0530
Message-ID: <20260902114758.85160-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902114758.85160-1-nnmlinux@linux.ibm.com>
References: <20260902114758.85160-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Y8hIS8FSXvZx5ceJZPjmPj_FovICK85P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX6Sj1uU5fqTwg
 COq46iNhPBqEtBPp/EwIts83oNiqc37qPN2yyBpUZOso+SGcgFfnnQqHTISz/JvFh1uZ4rCjgml
 BoXkK+sCmacUtDjNixeuI3OKGNJMbXQWIKYNaC9zce5uHcmimTiLlu4xL7IDUDb7Ys3r5T7vEH0
 +JVY4lNx/Q0Zf+a7yo4t28nfRAxDdsqcOHGlTLRXrJybJsWNcZ3pRd7l3+5hWCsyvEUzEo+6M5c
 L6l/pN2cSI3WwX79JwANfhKIl3LGbLVJdTVnP1TPriaEBrl11mkMgBOyaqAWbMKo92PjjMwdNHc
 59oq6eTWN2lFDzbLK03rNQbsBQOEG0837M0kL5VMjdfgcpYk7AyH1WlSFczot+xoi2/HjGtu19P
 S/qajcnHlqy5rF+Oyldu7kVq/hb8G8yHzsE8WOc3UiRzgb+QGJjiog897Xzn639PLkB8HwQhJVP
 joN2xuTlphAuuj11QZA==
X-Proofpoint-ORIG-GUID: R-YxeuR5HMIVvASuoLj8U_vkkdzRXIq0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX0Okjd78By9Eh
 T+KFM7o1fWNoVsLIdAlggLxJo0cziJZxtaWo7HnL2OLpXVjA+65zaeCS5Y+pNEblW4eRTe11ePM
 A/t2nqxAknqCu8O89TQ7YaSbXNhL+bw=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a980d1f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=DWdBjL4F_57hvwjeMwgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020102
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

An EEH PE hot or fundamental reset involves a synchronous kernel ioctl
(VFIO_EEH_PE_RESET_HOT / VFIO_EEH_PE_RESET_FUNDAMENTAL) that asserts
then de-asserts a PCI reset signal to the endpoint.  During this window
the device's BARs are inaccessible, but QEMU may still have those BARs
memory-mapped for direct guest access.  A guest MMIO fault that arrives
while the hardware is in reset can cause an unexpected host kernel page
fault or an indeterminate read value.

Fix this by disabling the BAR mmap windows for every VFIO PCI device
under the PHB before issuing the PE reset ioctl, and re-enabling them
after VFIO_EEH_PE_CONFIGURE succeeds.

A new spapr_phb_vfio_eeh_post_configure() bus walker calls
vfio_region_mmaps_set_enabled(..., true) on the configure success
path inside spapr_phb_vfio_eeh_configure().  On failure the mmaps
remain disabled; the next EEH reset attempt will call pre_reset
again.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr_pci_vfio.c | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index c233822d14..1cf058cbde 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -252,17 +252,28 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
  * pci_host_config_write_common() so that the VFIO config-write handler calls
  * vfio_msix_disable(), cleanly releasing vectors and KVM irqfd routes while
  * leaving the shadow intact.
+ *
+ * After disabling interrupts, disable BAR mmap windows so that the host
+ * kernel PE reset ioctl does not race with QEMU direct-mapped guest accesses.
+ * The timer that would ordinarily re-enable mmaps after an INTx quiet period
+ * is cancelled here; mmaps are restored after VFIO_EEH_PE_CONFIGURE succeeds
+ * in spapr_phb_vfio_eeh_configure().
  */
 static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
                                            PCIDevice *pdev,
                                            void *opaque)
 {
+    VFIOPCIDevice *vdev;
     uint16_t flags;
+    int i;
 
     if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
         return;
     }
 
+    vdev = VFIO_PCI_DEVICE(pdev);
+
+    /* Step 1: disable MSI-X without wiping the shadow table (see above). */
     if (msix_enabled(pdev)) {
         flags = pci_get_word(pdev->config + pdev->msix_cap + PCI_MSIX_FLAGS);
         flags &= ~PCI_MSIX_FLAGS_ENABLE;
@@ -270,6 +281,19 @@ static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
                                      pdev->msix_cap + PCI_MSIX_FLAGS,
                                      pci_config_size(pdev), flags, 2);
     }
+
+    /*
+     * Step 2: cancel any pending INTx mmap re-enable timer.  The timer is
+     * only allocated when PCI_INTERRUPT_PIN is non-zero, so guard the call.
+     */
+    if (vdev->intx.mmap_timer) {
+        timer_del(vdev->intx.mmap_timer);
+    }
+
+    /* Step 3: disable BAR mmaps last, after interrupt teardown. */
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, false);
+    }
 }
 
 static void spapr_phb_vfio_eeh_prepare_bus(PCIBus *bus, void *opaque)
@@ -286,6 +310,43 @@ static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
     pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_prepare_bus, NULL);
 }
 
+/*
+ * Re-enable BAR mmap windows for a single VFIO PCI device after a successful
+ * EEH PE configure.  Called only on the configure success path; on failure the
+ * mmaps remain disabled until the next hot/fundamental reset attempt.
+ */
+static void spapr_phb_vfio_eeh_post_configure_dev(PCIBus *bus,
+                                                   PCIDevice *pdev,
+                                                   void *opaque)
+{
+    VFIOPCIDevice *vdev;
+    int i;
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
+        return;
+    }
+
+    vdev = VFIO_PCI_DEVICE(pdev);
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, true);
+    }
+}
+
+static void spapr_phb_vfio_eeh_post_configure_bus(PCIBus *bus, void *opaque)
+{
+    pci_for_each_device_under_bus(bus,
+                                  spapr_phb_vfio_eeh_post_configure_dev,
+                                  NULL);
+}
+
+static void spapr_phb_vfio_eeh_post_configure(SpaprPhbState *sphb)
+{
+    PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
+
+    pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_post_configure_bus, NULL);
+}
+
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
 {
     uint32_t op;
@@ -293,6 +354,11 @@ int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
 
     switch (option) {
     case RTAS_SLOT_RESET_DEACTIVATE:
+        /*
+         * Deactivate does not perform a full PE reset; BAR mmaps were already
+         * disabled by the preceding HOT or FUNDAMENTAL reset call and must not
+         * be re-enabled here.
+         */
         op = VFIO_EEH_PE_RESET_DEACTIVATE;
         break;
     case RTAS_SLOT_RESET_HOT:
@@ -324,6 +390,8 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
         return RTAS_OUT_PARAM_ERROR;
     }
 
+    spapr_phb_vfio_eeh_post_configure(sphb);
+
     return RTAS_OUT_SUCCESS;
 }
 
-- 
2.51.1


