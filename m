Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B5FCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFL3-0000cq-7V; Fri, 09 Oct 2026 14:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKx-0000Zg-ET; Fri, 09 Oct 2026 14:28:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKs-0001hV-ND; Fri, 09 Oct 2026 14:28:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZtv1806271; Fri, 9 Oct 2026 18:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VHEfMLLqon0DN6O+g
 QGsg2niW3waqZJEF+ht0JBWtKs=; b=LwYK3qZJ0s5mzNG5sqtBa5ZQcxpWaGxEk
 bP5LnqnWVQVLFUXQDwN6PAcs2mVrrMoHMrXPpR0rzdNuZualcwJgGhwMARvt+9Dt
 gOGB9xYyvaBi2A2rPvaxIbsbnuc5WKYY65FPu3cP7dU9eKLLpjcliVoBHt9BsoFg
 DuaQc1/XOOvK1xKQVTFX5QWekEXzcrogYJtEzrF+f08oXAKPNA12aKiB0BlE/dFY
 HsmHn+7cUx+gzFzIZFIFTs6jGvK3OVF7gyeSocTTSBAS1wd3spN/+jJZ5kwZsefW
 4OceXEKP+1uLbiB3qK9ORlZ5/8IieajW0rDUcKZP+/e+5dr8tH18g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg8ru-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8P9m4125998; Fri, 9 Oct 2026 18:28:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u45ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISlJJ24248978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC8C358054;
 Fri,  9 Oct 2026 18:28:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E57435805A;
 Fri,  9 Oct 2026 18:28:45 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:45 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 16/19] s390x/pci: Implement migration for emulated devices
Date: Fri,  9 Oct 2026 14:28:22 -0400
Message-ID: <20261009182825.148054-17-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LqkHWXdc c=1 sm=1 tr=0 ts=6ac93261 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SYYICNKFp82yG71YkvsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX8arUgpKB0A8l
 4Je5PNGXQNbgp1Q4TKlG+o7n5/yI7gEo8vcxfeopNpQUTykNyrt5lMzpF5if3QmoI30OHtATvOv
 zlNHFso5hvWA0ZR/DWRd3C6HyB8Rv5UysN+mu1R6u/Jig0Uf0bPoe14yvmiJ2/pfw6EsMjhWAsc
 SyHcbyjWtL//pZNUi4UZ3oSmpB7oUGxWlQZp+rGH1S6H9qwAY5b332y/6s4w5vyoyk7y9JyxE6R
 U+BiJjKPkQiIwjCnMfbWCz5w+77nFEEyqYYJDN1ynC6Sqtt0OD9AdAtNAfYbfw+oGEoXmxe16Rn
 wNSoUUzTKI5Z0QVxoYwrLaAmQx6KXJwwx1oJp5fsbUtXjPNBMcwGbsdyzOuhAaYZ4JT+nuv2M5o
 7h8c/pMkaomDbolH9TN5kvPqOlSOCKFTXySlPaSt+toj36uHHzF1Jrl91L8uQvq2RojBHX23jFo
 UGlGmQYkaf0H8gKD4IA==
X-Proofpoint-GUID: kXpY6DPSrx2Cal2MFcAj_mOGdCrcS1Mp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXwV5VEdMHtbkV
 WgskfFCLyr3z+C+72FQMHb0LicAr6TUPMNwrK9BoYEqNnNeXJV8ClyHtyOU59spgBf/kiBG152S
 efHXQIqB/vJRB1uu8yRuJSbelUtyzPA=
X-Proofpoint-ORIG-GUID: kXpY6DPSrx2Cal2MFcAj_mOGdCrcS1Mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

Implement zPCI device state migration, consequently enabling migration
of VMs that have emulated PCI devices, whether virtio or not.
Migration is allowed for devices whose function handle has the
FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
state of its zPCI emulator.

This will enable emulated PCI migration starting with s390-ccw-virtio-11.2.

Passthrough devices will continue to block migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-17-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 346 ++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.c         |   2 +-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |   9 +-
 include/hw/s390x/s390-pci-inst.h |   1 +
 5 files changed, 353 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 7dff771ee6..5f8712ac76 100644
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
@@ -927,6 +929,8 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
 }
 
+static const VMStateDescription s390_pcihost_vmstate;
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -961,6 +965,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
+    vmstate_register(VMSTATE_IF(dev), 0, &s390_pcihost_vmstate, s);
     s390_pcihost_kvm_realize();
 }
 
@@ -1139,12 +1144,47 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
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
 static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
+    bool auto_pbdev = false;
     int rc;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -1204,6 +1244,7 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
             if (!pbdev) {
                 return;
             }
+            auto_pbdev = true;
         }
 
         pbdev->pdev = pdev;
@@ -1223,7 +1264,7 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
                     if (rc) {
                         error_setg(errp, "Plug failed for zPCI device in "
                                    "interpretation mode: %d", rc);
-                        return;
+                        goto err_unlink_pbdev;
                     }
                 } else {
                     trace_s390_pcihost("zPCI interpretation missing");
@@ -1252,16 +1293,46 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
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
+        pbdev->state = ZPCI_FS_RESERVED;
+        if (auto_pbdev) {
+            QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
+            if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
+                g_hash_table_remove(s->zpci_table, &pbdev->idx);
+            }
+            g_hash_table_destroy(pbdev->iotlb);
+            s390_clear_zpci_migration_blocker(pbdev);
+            qdev_unrealize(DEVICE(pbdev));
+            object_unparent(OBJECT(pbdev));
+        }
+        return;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
 
@@ -1272,6 +1343,12 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
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
@@ -1294,6 +1371,8 @@ static void s390_pcihost_unplug(const HotplugHandler *hotplug_dev, DeviceState *
             return;
         }
 
+        s390_clear_passthrough_migration_blocker(pbdev);
+
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
         bus = pci_get_bus(pci_dev);
@@ -1313,6 +1392,7 @@ static void s390_pcihost_unplug(const HotplugHandler *hotplug_dev, DeviceState *
             s390_pci_end_dma_count(s, pbdev->dma_limit);
         }
         g_hash_table_destroy(pbdev->iotlb);
+        s390_clear_zpci_migration_blocker(pbdev);
         qdev_unrealize(dev);
     }
 }
@@ -1417,6 +1497,16 @@ void s390_pci_ism_reset(void)
     }
 }
 
+static void s390_pci_clear_pending_sei(S390pciState *s)
+{
+    SeiContainer *sei_cont;
+
+    while ((sei_cont = QTAILQ_FIRST(&s->pending_sei))) {
+        QTAILQ_REMOVE(&s->pending_sei, sei_cont, link);
+        g_free(sei_cont);
+    }
+}
+
 static void s390_pcihost_reset(DeviceState *dev)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
@@ -1440,6 +1530,8 @@ static void s390_pcihost_reset(DeviceState *dev)
         }
     }
 
+    s390_pci_clear_pending_sei(s);
+
     /*
      * When resetting a PCI bridge, the assigned numbers are set to 0. So
      * on every system reset, we also have to reassign numbers.
@@ -1448,6 +1540,109 @@ static void s390_pcihost_reset(DeviceState *dev)
     pci_for_each_device_under_bus(bus, s390_pci_enumerate_bridge, s);
 }
 
+/*
+ * TYPE_S390_PCI_HOST_BRIDGE device state migration is registered via
+ * vmstate_register() rather than dc->vmsd because dc->vmsd is already assigned
+ * by our base, TYPE_PCI_HOST_BRIDGE, to &vmstate_pcihost which migrates
+ * PCIHostState.config_reg. There is no mechanism to add a subclass vmsd to the
+ * parent's.
+ */
+static bool s390_pcihost_vmstate_needed(void *opaque)
+{
+    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
+    return s->zpci_migr_enabled;
+}
+
+static bool s390_pcihost_pending_sei_vmstate_needed(void *opaque)
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
+/*
+ * When pending_sei load is executed, pending_sei can already contain SEIs
+ * generated here in the target QEMU, for example, by state loads of zpci
+ * devices. A dumb load here would place the older SEIs from the source QEMU
+ * after the new SEIs. To fix this, we have pre_load() stash the new SEIs from
+ * pending_sei and post_load() unstash them after the old ones.
+ */
+static void s390_pci_move_sei_list(SeiContainerList *dst, SeiContainerList *src)
+{
+    SeiContainer *sei_cont;
+
+    while ((sei_cont = QTAILQ_FIRST(src))) {
+        QTAILQ_REMOVE(src, sei_cont, link);
+        QTAILQ_INSERT_TAIL(dst, sei_cont, link);
+    }
+}
+
+static int s390_pcihost_pending_sei_vmstate_pre_load(void *opaque)
+{
+    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
+
+    QTAILQ_INIT(&s->pending_sei_stash);
+    s390_pci_move_sei_list(&s->pending_sei_stash, &s->pending_sei);
+    return 0;
+}
+
+static int s390_pcihost_pending_sei_vmstate_post_load(void *opaque,
+                                                      int version_id)
+{
+    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
+
+    s390_pci_move_sei_list(&s->pending_sei, &s->pending_sei_stash);
+    return 0;
+}
+
+static const VMStateDescription s390_pcihost_pending_sei_vmstate = {
+    .name = TYPE_S390_PCI_HOST_BRIDGE "/pending-sei",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = s390_pcihost_pending_sei_vmstate_needed,
+    .pre_load = s390_pcihost_pending_sei_vmstate_pre_load,
+    .post_load = s390_pcihost_pending_sei_vmstate_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_QTAILQ_V(pending_sei, S390pciState, 1,
+                         vmstate_sei_container, SeiContainer, link),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription s390_pcihost_vmstate = {
+    .name = TYPE_S390_PCI_HOST_BRIDGE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = s390_pcihost_vmstate_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &s390_pcihost_pending_sei_vmstate,
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
@@ -1461,6 +1656,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
     hc->unplug_request = s390_pcihost_unplug_request;
     hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
+    device_class_set_props(dc, phb_props);
 }
 
 static const TypeInfo s390_pcihost_info = {
@@ -1646,13 +1842,149 @@ static const Property s390_pci_device_properties[] = {
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
     /*
-     * TODO: add state handling here, so migration works at least with
-     * emulated pci devices on s390x
+     * Guard against the scenario that s390_pcihost_plug() of the target PCI
+     * device succeeded in the source QEMU, but failed on this destination
+     * QEMU, before migration state load. In this case we'll find !pbdev->pdev
+     * but the pbdev->state != ZPCI_FS_RESERVED as just loaded from the stream.
+     * Such value combination is invalid and migration should fail.
      */
-    .unmigratable = 1,
+    if (pbdev->state != ZPCI_FS_RESERVED && !pbdev->pdev) {
+        error_setg(errp, "zpci device uid 0x%x state %d has no PCI device",
+                   pbdev->uid, pbdev->state);
+        return false;
+    }
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
+    /*
+     * Regenerate IOMMU state, including IOTLB contents and QEMU memory regions.
+     */
+    if (pbdev->iommu_enabled) {
+        if (!pbdev->iommu) {
+            error_setg(errp, "iommu is NULL");
+            return false;
+        }
+        if (!s390_pci_ioat_validate(pbdev, pbdev->pba, pbdev->pal,
+                                    pbdev->g_iota, errp)) {
+            error_prepend(errp, "migration stream error: ");
+            return false;
+        }
+        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
+            s390_pci_iommu_enable(pbdev);
+            s390_pci_ioat_replay(pbdev);
+        } else {
+            /*
+             * TODO: if/when either emulated devices are allowed to set
+             * rtr_avail or migration of VFIO devices is added, this path
+             * will need to call s390_pci_iommu_direct_map_enable(pbdev).
+             */
+            g_assert_not_reached();
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
index 98b0ac4990..f620d45e6c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1156,7 +1156,7 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
     return ret;
 }
 
-static void fmb_update(void *opaque)
+void fmb_update(void *opaque)
 {
     S390PCIBusDevice *pbdev = opaque;
     int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 9e2db872fb..fda5ecc9ad 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1018,12 +1018,16 @@ static void ccw_machine_11_1_instance_options(MachineState *machine)
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
index 5c2d07e38e..71f956700b 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -338,6 +338,8 @@ struct S390PCIBusDevice {
     uint16_t uid;
     uint32_t idx;
     uint32_t fh;
+    Error *zpci_migr_blocker; /* machines 11.1 or older */
+    Error *passthrough_migr_blocker;
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
@@ -379,6 +381,8 @@ struct S390PCIBus {
     BusState qbus;
 };
 
+typedef QTAILQ_HEAD(SeiContainerList, SeiContainer) SeiContainerList;
+
 struct S390pciState {
     PCIHostState parent_obj;
     uint32_t next_idx;
@@ -386,11 +390,14 @@ struct S390pciState {
     S390PCIBus *bus;
     GHashTable *iommu_table;
     GHashTable *zpci_table;
-    QTAILQ_HEAD(, SeiContainer) pending_sei;
+    SeiContainerList pending_sei;
+    /* Only used temporarily between migration pre_load and post_load. */
+    SeiContainerList pending_sei_stash;
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
2.56.0


