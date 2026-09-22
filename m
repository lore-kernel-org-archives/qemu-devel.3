Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADA6C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95N9-0007eu-Tp; Tue, 22 Sep 2026 14:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mp-0007ap-KO; Tue, 22 Sep 2026 14:37:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mg-0005wA-6k; Tue, 22 Sep 2026 14:37:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7BNf1156938; Tue, 22 Sep 2026 18:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4Enjsi0GLAn9SjgbH
 arj3z2onmv3BxBaFXh7ASHT0vE=; b=tCUBteURMkTbFYWODLwuuTHXCCPkcmaRI
 4+JCU69LF5xqryYKFS6HNCt2jefgAv1vbjIuUvirC99bcq7c8Kn8UXxo1cn5dFjY
 KyCTgtPRdgsrqTekLnL3ab4wTDiqJ8pNFmus75KGGVQB+wVcK1qUJ3x+OOiZpKIP
 0LNGQYMcEFTrv3YgecXEatDMmSVFK6H4EkT3sYnDKnd4PgQI4BRce2GytvoUkULX
 d+MvixHHC2fRLmn1E8d20RB3C2PWayHJnH6dX434Q6gU+Rjh8fpgNiEd8htoB88O
 DjKU7KMVJ2WrRZAKTK96GdHoJfwLxyB2z3czr1AfyTib4GlvMcUew==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv73wj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHc853279459; Tue, 22 Sep 2026 18:37:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqb5bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MIb0pL57409814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 18:37:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50D2658052;
 Tue, 22 Sep 2026 18:37:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14B6758056;
 Tue, 22 Sep 2026 18:37:00 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.122])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 18:37:00 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v9 15/16] s390x/pci: Implement migration for emulated devices
Date: Tue, 22 Sep 2026 13:36:53 -0500
Message-Id: <20260922183654.798470-16-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922183654.798470-1-kshk@linux.ibm.com>
References: <20260922183654.798470-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TbvzlP5qIkms7PZXXEa-YtI551fRTYFF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX+q8282zn44G2
 kYTHy66UWojfChRftHBux2OhlNvxlbBA9w+neIkH8MNTkdeRra699V8X+QqMjfwdZgRjyccOh4V
 hRlAWzLyLGEi5nrHsbcgaqv72HtoynQ=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2cacd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=waVumpEa8DGoQk7sNJYA:9
X-Proofpoint-GUID: TbvzlP5qIkms7PZXXEa-YtI551fRTYFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfXxduy9DnE3X4E
 VKQXW9O4pBCEzLtx3X6pBCbdMYGBNqUhhMVWEnoi1lrXGF/jyGMWII6aEZt6NkD/SkY+BcYN3kD
 iWbp0eBL6SRwDsuuB3uoO9SFOgEFi1cAKoem6/itMlpZtAQGc/r2C7W2VlQXUFq2xo9a2snd+LU
 QVKIneY9wR39T5u/JCN3uHgEfrRjUGODS5a0JNJVHXuCgCKqD77SN9bEPviI9wiuXuEYqHeEZpp
 cQFT2pAwEfF1iUH1xM/wbDphHQXD3UmcP0YchqNYdasVSJXK8/XF2xmnjzXx381GupR3745BN/F
 aPFTSO7+VJdiXHdb3T95bbJ7fbMxCZJNsGa5H4pgccNyiFJZgSAD3FlOJvOEaeqmhHOQV1pOtn1
 BqDeY34zXIjFo6fnqQ9iWSPeeYizWSdWb97x662UgV21rDZ3kCrwMvdrGrjqBqcMPh1oPqR49bK
 xTENpGD6iaYhJOGuBQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220273
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Implement zPCI device state migration, consequently enabling migration
of VMs that have emulated PCI devices, whether virtio or not.
Migration is allowed for devices whose function handle has the
FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
state of its zPCI emulator.

This will enable emulated PCI migration starting with s390-ccw-virtio-11.2.

Passthrough devices will continue to block migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 298 ++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.c         |   2 +-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |  13 ++
 include/hw/s390x/s390-pci-inst.h |   1 +
 5 files changed, 310 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 79bef96c4d..39d506356f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -26,6 +26,8 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "exec/cpu-common.h"
+#include "migration/blocker.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/physmem.h"
@@ -922,6 +924,8 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
 }
 
+static const VMStateDescription vmstate_s390_pcihost;
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -956,6 +960,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
+    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_s390_pcihost, s);
     s390_pcihost_kvm_realize();
 }
 
@@ -1134,12 +1139,47 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
     return 0;
 }
 
+static int s390_set_zpci_migration_blocker(S390PCIBusDevice *pbdev,
+        S390pciState *s, Error **errp)
+{
+    if (s->zpci_migr_enabled) {
+        return 0;
+    }
+    error_setg(&pbdev->zpci_migr_blocker,
+               "Migration blocked on this machine type by zPCI device "
+               "uid %d", pbdev->uid);
+    return migrate_add_blocker(&pbdev->zpci_migr_blocker, errp);
+}
+
+static void s390_clear_zpci_migration_blocker(S390PCIBusDevice *pbdev)
+{
+    migrate_del_blocker(&pbdev->zpci_migr_blocker);
+}
+
+static int s390_set_passthrough_migration_blocker(S390PCIBusDevice *pbdev,
+                                            Error **errp)
+{
+    if (pbdev->fh & FH_SHM_EMUL) {
+        return 0;
+    }
+    error_setg(&pbdev->passthrough_migr_blocker,
+               "Migration blocked by passthrough zPCI device uid %d",
+               pbdev->uid);
+    return migrate_add_blocker(&pbdev->passthrough_migr_blocker, errp);
+}
+
+static void s390_clear_passthrough_migration_blocker(S390PCIBusDevice *pbdev)
+{
+    migrate_del_blocker(&pbdev->passthrough_migr_blocker);
+}
+
 static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
+    bool auto_pbdev = false;
     int rc;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -1199,6 +1239,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             if (!pbdev) {
                 return;
             }
+            auto_pbdev = true;
         }
 
         pbdev->pdev = pdev;
@@ -1218,7 +1259,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     if (rc) {
                         error_setg(errp, "Plug failed for zPCI device in "
                                    "interpretation mode: %d", rc);
-                        return;
+                        goto err_unlink_pbdev;
                     }
                 } else {
                     trace_s390_pcihost("zPCI interpretation missing");
@@ -1247,16 +1288,44 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             pbdev->rtr_avail = false;
         }
 
+        if (s390_set_passthrough_migration_blocker(pbdev, errp) != 0) {
+            goto err_unlink_pbdev;
+        }
+
         if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
-            return;
+            s390_clear_passthrough_migration_blocker(pbdev);
+            goto err_unlink_pbdev;
         }
 
         if (dev->hotplugged) {
             s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED ,
                                          pbdev->fh, pbdev->fid);
         }
+        return;
+
+err_unlink_pbdev:
+        if (pbdev->pft == ZPCI_PFT_ISM) {
+            notifier_remove(&pbdev->shutdown_notifier);
+        }
+        if (pbdev->dma_limit) {
+            s390_pci_end_dma_count(s, pbdev->dma_limit);
+            pbdev->dma_limit = NULL;
+        }
+        pbdev->fh &= ~FH_MASK_SHM;
+        pbdev->iommu = NULL;
+        pbdev->pdev = NULL;
+        if (auto_pbdev) {
+            QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
+            if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
+                g_hash_table_remove(s->zpci_table, &pbdev->idx);
+            }
+            g_hash_table_destroy(pbdev->iotlb);
+            s390_clear_zpci_migration_blocker(pbdev);
+            qdev_unrealize(DEVICE(pbdev));
+        }
+        return;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
 
@@ -1267,6 +1336,12 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                              NULL, g_free);
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
         g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
+        if (s390_set_zpci_migration_blocker(pbdev, s, errp) != 0) {
+            g_hash_table_remove(s->zpci_table, &pbdev->idx);
+            QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
+            g_hash_table_destroy(pbdev->iotlb);
+            return;
+        }
     } else {
         g_assert_not_reached();
     }
@@ -1289,6 +1364,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
             return;
         }
 
+        s390_clear_passthrough_migration_blocker(pbdev);
+
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
         bus = pci_get_bus(pci_dev);
@@ -1308,6 +1385,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
             s390_pci_end_dma_count(s, pbdev->dma_limit);
         }
         g_hash_table_destroy(pbdev->iotlb);
+        s390_clear_zpci_migration_blocker(pbdev);
         qdev_unrealize(dev);
     }
 }
@@ -1443,6 +1521,65 @@ static void s390_pcihost_reset(DeviceState *dev)
     pci_for_each_device_under_bus(bus, s390_pci_enumerate_bridge, s);
 }
 
+/*
+ * TYPE_S390_PCI_HOST_BRIDGE device state migration is registered via
+ * vmstate_register() rather than dc->vmsd because dc->vmsd is already assigned
+ * by our base, TYPE_PCI_HOST_BRIDGE, to &vmstate_pcihost which migrates
+ * PCIHostState.config_reg. There is no mechanism to add a subclass vmsd to the
+ * parent's.
+ */
+static bool vmstate_s390_pcihost_pending_sei_needed(void *opaque)
+{
+    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
+    return s->zpci_migr_enabled && !QTAILQ_EMPTY(&s->pending_sei);
+}
+
+/* Per-element descriptor for pending_sei list */
+static const VMStateDescription vmstate_sei_container = {
+    .name = "s390_sei_container",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(fid, SeiContainer),
+        VMSTATE_UINT32(fh, SeiContainer),
+        VMSTATE_UINT8(cc, SeiContainer),
+        VMSTATE_UINT16(pec, SeiContainer),
+        VMSTATE_UINT64(faddr, SeiContainer),
+        VMSTATE_UINT32(e, SeiContainer),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_s390_pcihost_pending_sei = {
+    .name = TYPE_S390_PCI_HOST_BRIDGE "/pending-sei",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_s390_pcihost_pending_sei_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_QTAILQ_V(pending_sei, S390pciState, 1,
+                         vmstate_sei_container, SeiContainer, link),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_s390_pcihost = {
+    .name = TYPE_S390_PCI_HOST_BRIDGE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_s390_pcihost_pending_sei,
+        NULL
+    }
+};
+
+static const Property phb_props[] = {
+    DEFINE_PROP_BOOL("x-zpci-migr-enabled", S390pciState,
+                     zpci_migr_enabled, true),
+};
+
 static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1456,6 +1593,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
     hc->unplug_request = s390_pcihost_unplug_request;
     hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
+    device_class_set_props(dc, phb_props);
 }
 
 static const TypeInfo s390_pcihost_info = {
@@ -1469,10 +1607,33 @@ static const TypeInfo s390_pcihost_info = {
     }
 };
 
+/* Return a unique bus "path" for zpci device */
+static char *s390_pci_bus_get_dev_path(DeviceState *dev)
+{
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+    return g_strdup_printf("uid-%04x", pbdev->uid);
+}
+
+static void s390_pcibus_class_init(ObjectClass *oc, const void *data)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->get_dev_path = s390_pci_bus_get_dev_path;
+}
+
 static const TypeInfo s390_pcibus_info = {
     .name = TYPE_S390_PCI_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(S390PCIBus),
+    /*
+     * Implement get_dev_path() to provide each zpci device with a unique
+     * stable UID-based bus "path". The "path" is used as part of idstr in the
+     * migration stream, making idstr unique and instance_id always 0.
+     * For migration to succeed, (idstr+instance_id) must match those generated
+     * during QEMU start. Without unique idstr, QEMU will generate variable
+     * instance_id to distinguish devices, and that instance_id can change
+     * if a device is unplugged and plugged back, preventing migration.
+     */
+    .class_init = s390_pcibus_class_init,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
@@ -1618,13 +1779,136 @@ static const Property s390_pci_device_properties[] = {
                      true),
 };
 
-static const VMStateDescription s390_pci_device_vmstate = {
-    .name = TYPE_S390_PCI_DEVICE,
+static int s390_pci_device_pre_load(void *opaque)
+{
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
+    S390PCIBusDevice *found_pbdev;
+
+    /*
+     * Because state loading can change pbdev->idx make sure pbdev is removed
+     * from the table before that happens. The table type used stores a pointer
+     * to pbdev->idx and becomes corrupt if idx is changed from outside. But be
+     * careful to not remove instead another pbdev whose state might have been
+     * loaded earlier and that got assigned this idx value and had therefore
+     * already replaced our pbdev in the table. post_load() will reinsert our
+     * pbdev into the table. (found_pbdev could even be 0 if a previous
+     * vmstate_load_vmsd() on this device failed before reaching post_load().)
+     */
+    found_pbdev = g_hash_table_lookup(s390_get_phb()->zpci_table, &pbdev->idx);
+    if (found_pbdev == pbdev) {
+        g_hash_table_remove(s390_get_phb()->zpci_table, &pbdev->idx);
+    }
+
+    return 0;
+}
+
+static bool s390_pci_device_post_load_errp(void *opaque, int version_id,
+                                           Error **errp)
+{
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
+
+    pbdev->zpci_fn.fid = pbdev->fid;
+    pbdev->zpci_fn.uid = pbdev->uid;
+
+    /*
+     * Now that pbdev->idx has been loaded, use it to place pbdev back into
+     * the table. This may replace a different not-yet-state-loaded pbdev,
+     * but pre_load() handles this case.
+     */
+    g_hash_table_replace(s390_get_phb()->zpci_table, &pbdev->idx, pbdev);
+
     /*
-     * TODO: add state handling here, so migration works at least with
-     * emulated pci devices on s390x
+     * Regenerate IOMMU state, including IOTLB contents and QEMU memory regions.
      */
-    .unmigratable = 1,
+    if (pbdev->iommu_enabled) {
+        if (!pbdev->iommu) {
+            error_setg(errp, "iommu is NULL");
+            return false;
+        }
+        if (!s390_pci_ioat_validate(pbdev, pbdev->pba, pbdev->pal,
+                                    pbdev->g_iota, errp)) {
+            if (*errp) {
+                error_prepend(errp, "invalid pba, pal or g_iota in migration stream: ");
+            } else {
+                error_setg(errp, "invalid pba, pal or g_iota in migration stream");
+            }
+            return false;
+        }
+        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
+            s390_pci_iommu_enable(pbdev);
+            s390_pci_ioat_replay(pbdev);
+        } else {
+            /* TODO: unreachable until vfio passthrough migration is enabled */
+            s390_pci_iommu_direct_map_enable(pbdev);
+        }
+    }
+
+    /*
+     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE instruction,
+     * whose handler consequently starts fmb_timer. We may need to restart it.
+     */
+    if (pbdev->fmb_addr) {
+        if (pbdev->fmb_timer) {
+            error_setg(errp, "fmb_timer is not NULL");
+            return false;
+        }
+        if (!pbdev->pci_group) {
+            error_setg(errp, "pci_group is NULL");
+            return false;
+        }
+        pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                        fmb_update, pbdev);
+        timer_mod(pbdev->fmb_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                                    pbdev->pci_group->zpci_group.mui);
+    }
+    return true;
+}
+
+static const VMStateDescription s390_pci_device_vmstate = {
+    .name = TYPE_S390_PCI_DEVICE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .priority = MIG_PRI_IOMMU,
+    .pre_load = s390_pci_device_pre_load,
+    .post_load_errp = s390_pci_device_post_load_errp,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(state, S390PCIBusDevice),
+        VMSTATE_UINT16(uid, S390PCIBusDevice),
+        VMSTATE_UINT32(idx, S390PCIBusDevice),
+        VMSTATE_UINT32(fh, S390PCIBusDevice),
+        VMSTATE_UINT32(fid, S390PCIBusDevice),
+        VMSTATE_BOOL(fid_defined, S390PCIBusDevice),
+        VMSTATE_UINT64(fmb_addr, S390PCIBusDevice),
+        VMSTATE_UINT32(fmb.format, S390PCIBusDevice),
+        VMSTATE_UINT32(fmb.sample, S390PCIBusDevice),
+        VMSTATE_UINT64(fmb.last_update, S390PCIBusDevice),
+        VMSTATE_UINT64_ARRAY(fmb.counter, S390PCIBusDevice,
+                ARRAY_SIZE(((S390PCIBusDevice *)0)->fmb.counter)),
+        VMSTATE_UINT64(fmb.fmt0.dma_rbytes, S390PCIBusDevice),
+        VMSTATE_UINT64(fmb.fmt0.dma_wbytes, S390PCIBusDevice),
+        VMSTATE_UINT8(isc, S390PCIBusDevice),
+        VMSTATE_UINT16(noi, S390PCIBusDevice),
+        VMSTATE_UINT8(sum, S390PCIBusDevice),
+        VMSTATE_UINT8(pft, S390PCIBusDevice),
+        VMSTATE_UINT64(routes.adapter.ind_addr, S390PCIBusDevice),
+        VMSTATE_UINT64(routes.adapter.summary_addr, S390PCIBusDevice),
+        VMSTATE_UINT64(routes.adapter.ind_offset, S390PCIBusDevice),
+        VMSTATE_UINT32(routes.adapter.summary_offset, S390PCIBusDevice),
+        VMSTATE_UINT32(routes.adapter.adapter_id, S390PCIBusDevice),
+        VMSTATE_BOOL(iommu_enabled, S390PCIBusDevice),
+        VMSTATE_UINT64(g_iota, S390PCIBusDevice),
+        VMSTATE_UINT64(pba, S390PCIBusDevice),
+        VMSTATE_UINT64(pal, S390PCIBusDevice),
+        VMSTATE_PTR_TO_IND_ADDR(summary_ind, S390PCIBusDevice),
+        VMSTATE_PTR_TO_IND_ADDR(indicator, S390PCIBusDevice),
+        VMSTATE_BOOL(unplug_requested, S390PCIBusDevice),
+        VMSTATE_BOOL(interp, S390PCIBusDevice),
+        VMSTATE_BOOL(forwarding_assist, S390PCIBusDevice),
+        VMSTATE_BOOL(aif, S390PCIBusDevice),
+        VMSTATE_BOOL(rtr_avail, S390PCIBusDevice),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index a1cd96f647..ac8bdb2978 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1136,7 +1136,7 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
     return ret;
 }
 
-static void fmb_update(void *opaque)
+void fmb_update(void *opaque)
 {
     S390PCIBusDevice *pbdev = opaque;
     int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 17266779a6..db0b49375e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1005,12 +1005,16 @@ static void ccw_machine_11_1_instance_options(MachineState *machine)
 static void ccw_machine_11_1_class_options(MachineClass *mc)
 {
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
+    static GlobalProperty compat[] = {
+        { TYPE_S390_PCI_HOST_BRIDGE, "x-zpci-migr-enabled", "off" },
+    };
 
     s390mc->use_certs = false;
     s390mc->use_secure = false;
 
     ccw_machine_11_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(11, 1);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 0a59be1fd0..d310a46e8f 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -337,6 +337,8 @@ struct S390PCIBusDevice {
     uint16_t uid;
     uint32_t idx;
     uint32_t fh;
+    Error *zpci_migr_blocker; /* machines 11.1 or older */
+    Error *passthrough_migr_blocker;
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
@@ -385,11 +387,22 @@ struct S390pciState {
     S390PCIBus *bus;
     GHashTable *iommu_table;
     GHashTable *zpci_table;
+    /*
+     * pending_sei is the zPCI payload queue drained by CHSC SEI (one
+     * SeiContainer per instruction execution).  It is the zPCI-layer
+     * counterpart of ChannelSubSys.pending_crws, which carries the
+     * architectural CRW notifications that prompt the guest to issue
+     * CHSC SEI in the first place.  pending_crws is migrated by
+     * vmstate_css; pending_sei is migrated by vmstate_s390_pcihost_pending_sei
+     * in s390-pci-bus.c so that the two queues remain consistent on the
+     * destination.
+     */
     QTAILQ_HEAD(, SeiContainer) pending_sei;
     QTAILQ_HEAD(, S390PCIBusDevice) zpci_devs;
     QTAILQ_HEAD(, S390PCIDMACount) zpci_dma_limit;
     QTAILQ_HEAD(, S390PCIGroup) zpci_groups;
     uint8_t next_sim_grp;
+    bool zpci_migr_enabled;
 };
 
 S390pciState *s390_get_phb(void);
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index 3493d2ced0..e31497069b 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -113,6 +113,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra);
 void fmb_timer_free(S390PCIBusDevice *pbdev);
+void fmb_update(void *opaque);
 uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev, S390IOTLBEntry *entry);
 
 #define ZPCI_IO_BAR_MIN 0
-- 
2.34.1


