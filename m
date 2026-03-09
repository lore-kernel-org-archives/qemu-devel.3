Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56233EA854A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObx-0006TS-Ue; Sun, 08 Mar 2026 20:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObt-0006SD-Ki; Sun, 08 Mar 2026 20:36:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObs-0001gx-09; Sun, 08 Mar 2026 20:36:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628NdiGS1679369; Mon, 9 Mar 2026 00:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2SID591dKD6r59nTB
 4EY6gwXeAW8y05Ol0a4hhnvmSs=; b=B/W6YiswBIB6DM54909UrO8tOdvy4Z7NB
 Go1aSGcFaDva+y4Oi4/IRmGCR34ZsgOq0PPt6mA515LQfo00591WSom8tAJrGjQG
 MwS7lLw9xLqW2zSx4VwluXYAW3HuEIdP0tefM53/lQR49lRNhaylw2jaX0XfJ/Ic
 I0A2KH20KHOZftFE6cO65XGQ+tu125BWXZiouffTo/eujyN59pba3VsB5Z/1kOJZ
 o2tgDuttKJLy7jj9r0Rrf8ri+VMdat89cfnjkgTybw7Y+NJ81JUjJ7sfssvn+245
 K8zuAfh4gKaB0raxAQSr0Vm/eMKvWbw3ksxpcYfXImdfO9IINF4Bg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun4ebh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628NZYO0015706;
 Mon, 9 Mar 2026 00:36:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121tqng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:33 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290aWbh64225702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B78958052;
 Mon,  9 Mar 2026 00:36:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2500258045;
 Mon,  9 Mar 2026 00:36:31 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:31 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 14/15] hw: Add "loadparm" property to virtio block PCI
 devices booting on s390x
Date: Sun,  8 Mar 2026 20:36:00 -0400
Message-ID: <20260309003601.242634-15-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UWp7TpX7tci833EL9P-hsjpIew4a1ogX
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69ae1612 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=F4WGF4pRLNDXqq0IcGUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfXylGuPQuTphXR
 XPbB6zvGfdoai6XQFW3haiKNc9UHYMwEd8aJnwmoBzE1LgUERtL7P3FvYl7HUOIiGh0UNPP8PPu
 C2Q/jHiv0sqoiDDApRBK8VuNjYJn/jLgVmg2O9G5dP8pBIz+dTmQqdD0IqyaWnactuBqhjJ6vvo
 PDlIYfKU4FNjZeyaGJw/yNs/HTTVtB3mDTKOhkZ+E0DdYCRaVm7o8FNFNqJg8A+0+2HaiR0f2O1
 x1TCz0ooVtNEF73xK/KQywVzNKOSHIlSmHwbXe55ONROl1u2/nEZgqSALXlfAl3q9hanX5iJ2O/
 8ty6URb6f5bKns8ybWi32jAn1CyBvw4k37zSE7Ou1RxYJ49Ni8q53p7tug6RX0zB/7WIVIgq536
 yI298W+4OWQvH8ED4oKKwB3E6IMLF0fK4AzaBkdQatvmWJt2lYzs6VnuGZxmfIKsA6qTFbeXU5p
 RzXmROqp4GP0WSglrqg==
X-Proofpoint-ORIG-GUID: UWp7TpX7tci833EL9P-hsjpIew4a1ogX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/pci/pci.c                | 38 +++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.c              | 11 +++++++++--
 hw/virtio/virtio-blk-pci.c  |  1 +
 include/hw/pci/pci.h        |  1 +
 include/hw/pci/pci_device.h |  3 +++
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6399ebd41c..2c3657d00d 100644
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
@@ -2843,6 +2844,43 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
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
+    if (target_s390x()) {
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
index 64141e92fe..5b179091de 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -380,6 +380,7 @@ const char *pci_root_bus_path(PCIDevice *dev);
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


