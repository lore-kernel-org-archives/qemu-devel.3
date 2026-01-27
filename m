Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E617D340A2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkf-0004P7-LR; Tue, 27 Jan 2026 11:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljt-0003jk-Q4; Tue, 27 Jan 2026 11:16:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljr-0000pv-9Q; Tue, 27 Jan 2026 11:16:24 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6Jtef006097;
 Tue, 27 Jan 2026 16:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nuEXrXClCcw9qm8Gx
 4OdV6JjOc3lRlq97N5u97+TJDQ=; b=pGVzAZH4SKKZvT+Uk8hFqmhktS1XJoBTJ
 zDQIW9lRjWyza9DnpKvEeXsgT61tsm6edpGItp/ZXMcGqnqyqc/W2y00P2GeDOom
 NKcBDppGknQYJ5THc1Va425VifhHwP5iavefWEyGeadc9ggB6tLzU1wEuuDRzvT1
 vitKQDGwSPmQTuOYgOmGCt1RSbn1pfICwaH5PDO4Jgu6tmSCUpI2a34md1L3oBj6
 GmUbFPgtBRZApC9dJzLSVz4VvpFU+t0wgTWdmhiUaes+RMJQxH4+XTwR33Mi/lPB
 S3XLFt8QQOUibqLJxQfg+ziSAS7YkMRuMHcKRgO1wYg2i0IThnBAA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6xer5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD5pWB006707;
 Tue, 27 Jan 2026 16:16:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy9e3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGGIsi13369918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CC895805C;
 Tue, 27 Jan 2026 16:16:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E40285805A;
 Tue, 27 Jan 2026 16:16:16 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:16 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 13/14] hw: Add "loadparm" property to virtio block PCI
 devices booting on s390x
Date: Tue, 27 Jan 2026 11:15:46 -0500
Message-ID: <20260127161547.459443-14-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NWh-N5wZfhujI3q4pJr2QOm4gG6TcrOl
X-Proofpoint-ORIG-GUID: NWh-N5wZfhujI3q4pJr2QOm4gG6TcrOl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX8XdU13edoYup
 /yq9844bNxsZjJJbMRGiq1oV42tmH7+apg0qLrQEvCj/pTqGu3abByQMXhnpnrdcezGmFiWPzwP
 bwkuwt67AXnx7AltUUThiwKra7YdcFQEGVTIsVFKyfqrcr6hrgYqsg0NoHk6DEMvebNCDtPjQgk
 C5zZvQg77j2gRL2G90UQYu5xCzNlWNTR3Nuxc9TV4OBhmt0fvCO9/7TQV0R76vl0YHpa1/VGFps
 kOHBC0KfzqGwSCJ5USOocIlwSfYNLRAua4rxRfIoclNZ3WLhJCxf3REYno/3bTePrlmRe4P2pzV
 zCCGiCRguacQ+c59r+fVBeIX1mZNZJUfX2adhqdLeXBwfW0mpwXx+7ZSKHosprOI/t42Pa/jWav
 8+J7Xcb5CRhGcPxOrvpFnPr2NRusHP9sXkuLdDSSNxr6rQ0gOA0SYSBmOt83hyIMXVMUSkXsOfX
 Jwe/JSkO9Z7aWP06nCQ==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978e4d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=F4WGF4pRLNDXqq0IcGUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/pci/pci.c                | 39 +++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.c              | 11 +++++++++--
 hw/virtio/virtio-blk-pci.c  |  1 +
 include/hw/pci/pci.h        |  1 +
 include/hw/pci/pci_device.h |  3 +++
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8cbf5f5d70..34b2bf1442 100644
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
@@ -2825,6 +2826,43 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
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
@@ -2843,6 +2881,7 @@ static void pci_device_class_init(ObjectClass *klass, const void *data)
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     device_class_set_props(k, pci_props);
+
     object_class_property_set_description(
         klass, "x-max-bounce-buffer-size",
         "Maximum buffer size allocated for bounce buffers used for mapped "
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
index 6fd8984c99..191ed92141 100644
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


