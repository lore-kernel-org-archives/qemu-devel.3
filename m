Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077AEEDEC02
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcTi-0002uC-En; Tue, 03 Mar 2026 22:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSo-0002TO-Mi; Tue, 03 Mar 2026 21:59:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSn-0000Z1-6n; Tue, 03 Mar 2026 21:59:54 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623MpSl52415161; Wed, 4 Mar 2026 02:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GWn/6rYhR0rpD0SBe
 LiQ3dpQYj4q5dlm9sUGhpLz37Q=; b=ap3nMOr8S6+fjxTVwZRSpDHUjffYxpP4g
 +QXTPheY5DjwZBteAFTrWH6ZZOaFvKiedhUUwShnqCmjJNLDSMB9AFZ+b0Tq5wGa
 n6FLkJrvtiOUMUTgdpSRCSLWYpPmBttxvaJtvnPmS1BPArmw/2enICU93vtYK7v7
 6eOlDyD5d86Dzse7mXawKjRpXKOufRMnC5/wyIjONGrYzYyULtJfJ3FhgOJ0UZNh
 XVdMCN/Cw7H3s9UF+m2HK9TRsaOPmPgtiuq49jqI1YPFfye8I/tXlj/hHN/taMx8
 qGRJ0v3gNGjP52RtFmgGYOAiEnunxbfyuFuvsYj4GVQ0G77BULedQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbwau1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623MIwLL003210;
 Wed, 4 Mar 2026 02:59:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y54ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xnl917367700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 943AD58053;
 Wed,  4 Mar 2026 02:59:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7344358043;
 Wed,  4 Mar 2026 02:59:48 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:48 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 14/15] hw: Add "loadparm" property to virtio block PCI
 devices booting on s390x
Date: Tue,  3 Mar 2026 21:59:16 -0500
Message-ID: <20260304025917.2157032-15-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rG5pgsFhkFMRNEucadVai0k1hBtSWLE3
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a7a027 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=F4WGF4pRLNDXqq0IcGUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX6hKVMOcqwZms
 MHzwJaBm0k1lAe3rOgwJe0hdWwdELfPImf679YllwZ0sHKOFXb3EJ0X+UjMNin58X4fc7jj48CO
 JkiGoLhWdAhsrVg8ORKFII8GXLINu+8ItWw+LSf2jsU2eT0NPLrEadfHgB6IEinsJHQoVRuVV9D
 R92zCRoB+RHCMrExA0VEHbgaW94oMHKue6Kvv9hbhQJPymTD3O+25dXOPtefepoNnzV7UVKyorm
 gDzfPdLcMRwAuSfmN44yDdspEex9toktxPDHTjPE38CnCP+ggZbemtgfvq6IzYHDc3+3oHjaiwN
 ruIFRWWkT+Mdhga5FdmspbsnQVThsEljEay9aojoWSDF7TYMoGq49k4C3EsylPwaCNtNMUzExVU
 K2f1dDya7A0sft5m2jQmN6ZF1+XXW8kMO6BBEfT/ARsvZlcIqwMgoj07UnbeJr5NWobVDWftYPh
 JZGrywzzt2VrItuzRFQ==
X-Proofpoint-GUID: rG5pgsFhkFMRNEucadVai0k1hBtSWLE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

The loadparm is required on s390x to pass the information to the boot loader
such as which kernel should be started or whether the boot menu should be shown.

Because PCI devices do not naturally allocate space for this, the property is
added on an architecture specific basis for supported device types.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/pci/pci.c                | 38 +++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.c              | 11 +++++++++--
 hw/virtio/virtio-blk-pci.c  |  1 +
 include/hw/pci/pci.h        |  1 +
 include/hw/pci/pci_device.h |  3 +++
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 90d6d71efd..04559f8312 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,6 +36,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
+#include "system/arch_init.h"
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -2845,6 +2846,43 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
     return rc;
 }
 
+static char *pci_qdev_property_get_loadparm(Object *obj, Error **errp)
+{
+    return g_strdup(PCI_DEVICE(obj)->loadparm);
+}
+
+static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
+                                       Error **errp)
+{
+    void *lp_str;
+
+    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
+        error_setg(errp, "'loadparm' is only valid for boot devices");
+        return;
+    }
+
+    lp_str = g_malloc0(strlen(value) + 1);
+    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
+        g_free(lp_str);
+        return;
+    }
+    PCI_DEVICE(obj)->loadparm = lp_str;
+}
+
+void pci_qdev_property_add_specifics(DeviceClass *dc)
+{
+    ObjectClass *oc = OBJECT_CLASS(dc);
+
+    /* The loadparm property is only supported on s390x */
+    if (qemu_arch_available(QEMU_ARCH_S390X)) {
+        object_class_property_add_str(oc, "loadparm",
+                                      pci_qdev_property_get_loadparm,
+                                      pci_qdev_property_set_loadparm);
+        object_class_property_set_description(oc, "loadparm",
+                                              "load parameter (s390x only)");
+    }
+}
+
 MemoryRegion *pci_address_space(PCIDevice *dev)
 {
     return pci_get_bus(dev)->address_space_mem;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 53dd3deafa..c231084c18 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -461,6 +461,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     int devtype;
     uint8_t *lp;
     g_autofree void *scsi_lp = NULL;
+    g_autofree void *pci_lp = NULL;
 
     ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     if (ccw_dev) {
@@ -513,6 +514,14 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 
     pbdev = s390_get_pci_device(dev_st, &devtype);
     if (pbdev) {
+        pci_lp = object_property_get_str(OBJECT(pbdev->pdev), "loadparm", NULL);
+        if (pci_lp && strlen(pci_lp) > 0) {
+            lp = pci_lp;
+        } else {
+            /* Use machine loadparm as a place holder if PCI LP is unset */
+            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
+        }
+
         switch (devtype) {
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = S390_IPLB_MIN_PCI_LEN;
@@ -523,8 +532,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             return false;
         }
 
-        /* Per-device loadparm not yet supported for non-ccw IPL */
-        lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 64a434c81b..3eecc23a65 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -71,6 +71,7 @@ static void virtio_blk_pci_class_init(ObjectClass *klass, const void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     device_class_set_props(dc, virtio_blk_pci_properties);
+    pci_qdev_property_add_specifics(dc);
     k->realize = virtio_blk_pci_realize;
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d9835dfd0d..53c6e87b14 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -382,6 +382,7 @@ const char *pci_root_bus_path(PCIDevice *dev);
 bool pci_bus_bypass_iommu(PCIBus *bus);
 PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn);
 int pci_qdev_find_device(const char *id, PCIDevice **pdev);
+void pci_qdev_property_add_specifics(DeviceClass *dc);
 void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 88ccea5011..5cac6e1688 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -62,6 +62,9 @@ struct PCIDevice {
     bool partially_hotplugged;
     bool enabled;
 
+    /* only for s390x */
+    char *loadparm;
+
     /* PCI config space */
     uint8_t *config;
 
-- 
2.52.0


