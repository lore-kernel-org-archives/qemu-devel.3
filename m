Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2034CD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVK87-0005Qz-Ah; Thu, 04 Jun 2026 22:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK83-0005My-Nl; Thu, 04 Jun 2026 22:17:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7z-0001mp-BO; Thu, 04 Jun 2026 22:17:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654KkAPL1260942; Fri, 5 Jun 2026 02:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CvgUhiFHV7V+l0pLl
 t5cEOzooiRkobGBgEQTgfNx6rI=; b=lT+ZoL6HSJj807AbMxXs3aaKJx69kigIL
 d7C8Zb8T6nYTIlpe28Wqk0RbGjh3VyZGvplEbeDvsP6u47ZTU4giVITdq6ERtU3Q
 0Tgmgg6vBgd8msak/QvUWP1WjM2wF/PiEUbInFD8MDgdB6kKLEY3xpjfF2xNOQXI
 NJ8e24BC6+/yd02MjvN02i/qY1YkEjlTn5LzYVG+8XIQP8PNpREQbHepn86RdKl7
 GRpV4HV+LbYt1u0Q3z/wMw5IhsimfCSID2U8UG1bAXqqGtIsqG0kJVoCTi5YjcFV
 tuRB5n3UvKWmppubpyPz4yN3/Phko0EyDGNjMfhIg4897MGxM/kAQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4jkhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65529411025273;
 Fri, 5 Jun 2026 02:17:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegyh13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6552Had864946540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 02:17:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F2585805D;
 Fri,  5 Jun 2026 02:17:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFEF758056;
 Fri,  5 Jun 2026 02:17:35 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.240.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 02:17:35 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3 14/15] s390x/pci: Implement migration for emulated devices
Date: Thu,  4 Jun 2026 21:17:27 -0500
Message-Id: <20260605021728.1125090-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605021728.1125090-1-kshk@linux.ibm.com>
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxOCBTYWx0ZWRfX0vQ0XyCHsVPr
 N4hiFeP1/ymREet7UPNvDuxfSOlGCUR7woMMSO/d9lYLJ7mKLr/k8y4wqaRmv8vc8ADxtiY+FQf
 our//0SMgMqMvwiZ60BQYl9TSZg+2G6MWPO0uLRwyG41qoFaEKj6L+9qqsS91igq42a9ra4auO+
 jX/Iq51natq9+4YLLgn7/SSfLTSzy3qHvMlxNwpXv1fEfUdGzSLYmyd3kNy8de4ueQ8LQ8XgXni
 jj+XxoWl+uMXy51b9R5kEzbaAsyn49jGiYH78vpX3WNvyM8MpRLLiOZ6XLfu2eodTCp/EMKh4St
 /6wYiYX30eDOS2HKQUht4tJGUcoB0eRI1Pu32LwzpNT11ft6nnmqWZOf/FjQ/cPOmv6HHnbCEC4
 4opFIK4jBGMWyZRQyDVLMaQOlAKv0kbAgR2AARVHXCqCXJ7yLShyzt4eh5XeJ/NP0+I+B6BS+Cx
 Zc3kMJisD3Vxc+266mw==
X-Proofpoint-GUID: XW8uStAxLNo0XXmdUsNr7LSLqIyPEzeF
X-Proofpoint-ORIG-GUID: XW8uStAxLNo0XXmdUsNr7LSLqIyPEzeF
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2231c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=BaPdF8j1E3L0cLeJECkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
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

Implement zPCI device state migration, consequently enabling migration
of VMs that have emulated PCI devices, whether virtio or not.
Migration is allowed for devices whose function handle has the
FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
state of its zPCI emulator.

This will enable emulated PCI migration starting with s390-ccw-virtio-11.1.

Passthrough devices will continue to block migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 187 +++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.c        |   2 +-
 hw/s390x/s390-virtio-ccw.c      |   5 +
 include/hw/s390x/s390-pci-bus.h |   4 +
 4 files changed, 192 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 8505abcc90..b05c4b43d1 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -26,6 +26,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "exec/cpu-common.h"
+#include "migration/blocker.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/reset.h"
@@ -33,6 +34,11 @@
 
 #include "trace.h"
 
+static const Property phb_props[] = {
+    DEFINE_PROP_BOOL("x-zpci-emul-dev-migr-enabled", S390pciState,
+                     emul_dev_migr_enabled, true),
+};
+
 S390pciState *s390_get_phb(void)
 {
     static S390pciState *phb;
@@ -916,6 +922,23 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
 }
 
+static int s390_set_emul_dev_migration_blocker(S390pciState *s, Error **errp)
+{
+    if (s->emul_dev_migr_enabled) {
+        return 0;
+    }
+    error_setg(&s->emul_dev_migr_blocker,
+               "Migration disabled for emulated zPCI devices on this machine type");
+    return migrate_add_blocker(&s->emul_dev_migr_blocker, errp);
+}
+
+static void s390_clear_emul_dev_migration_blocker(S390pciState *s)
+{
+    if (s->emul_dev_migr_blocker) {
+        migrate_del_blocker(&s->emul_dev_migr_blocker);
+    }
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -951,6 +974,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
     s390_pcihost_kvm_realize();
+    s390_set_emul_dev_migration_blocker(s, errp);
 }
 
 static void s390_pcihost_unrealize(DeviceState *dev)
@@ -958,6 +982,8 @@ static void s390_pcihost_unrealize(DeviceState *dev)
     S390PCIGroup *group;
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
 
+    s390_clear_emul_dev_migration_blocker(s);
+
     while (!QTAILQ_EMPTY(&s->zpci_groups)) {
         group = QTAILQ_FIRST(&s->zpci_groups);
         QTAILQ_REMOVE(&s->zpci_groups, group, link);
@@ -1128,6 +1154,27 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
     return 0;
 }
 
+static int s390_set_passthrough_migration_blocker(S390PCIBusDevice *pbdev,
+                                            Error **errp)
+{
+    pbdev->passthrough_migr_blocker = NULL;
+
+    if (pbdev->fh & FH_SHM_EMUL) {
+        return 0;
+    }
+    error_setg(&pbdev->passthrough_migr_blocker,
+               "Migration blocked by passthrough zPCI device "
+               "fh 0x%x uid %d fid %d", pbdev->fh, pbdev->uid, pbdev->fid);
+    return migrate_add_blocker(&pbdev->passthrough_migr_blocker, errp);
+}
+
+static void s390_clear_passthrough_migration_blocker(S390PCIBusDevice *pbdev)
+{
+    if (pbdev->passthrough_migr_blocker) {
+        migrate_del_blocker(&pbdev->passthrough_migr_blocker);
+    }
+}
+
 static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
@@ -1247,6 +1294,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             return;
         }
 
+        if (s390_set_passthrough_migration_blocker(pbdev, errp)) {
+            s390_pci_msix_free(pbdev);
+            return;
+        }
+
         if (dev->hotplugged) {
             s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED ,
                                          pbdev->fh, pbdev->fid);
@@ -1283,6 +1335,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
             return;
         }
 
+        s390_clear_passthrough_migration_blocker(pbdev);
+
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
         bus = pci_get_bus(pci_dev);
@@ -1450,6 +1504,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
     hc->unplug_request = s390_pcihost_unplug_request;
     hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
+    device_class_set_props(dc, phb_props);
 }
 
 static const TypeInfo s390_pcihost_info = {
@@ -1463,10 +1518,33 @@ static const TypeInfo s390_pcihost_info = {
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
+     ^ migration stream, making idstr unique and instance_id always 0.
+     * For migration to succeed, (idstr+instance_id) must match those generated
+     * during QEMU start. Without unique idstr, QEMU will generate variable
+     * instance_id to distinquish devices, and that instance_id can change
+     * if a device is unplugged and plugged back, preventing migration.
+     */
+    .class_init = s390_pcibus_class_init,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
@@ -1612,13 +1690,112 @@ static const Property s390_pci_device_properties[] = {
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
+     * Make sure pbdev is removed from the table before state load. The change
+     * of pbdev->idx means it needs to be moved to a different position anyway,
+     * and is illegal while in the table. But be careful to not remove
+     * instead another pbdev whose state might have been loaded earlier and
+     * that has then replaced our pbdev. (post_load() will put our pbdev back.)
+     */
+    found_pbdev = g_hash_table_lookup(s390_get_phb()->zpci_table, &pbdev->idx);
+    assert(found_pbdev);
+    if (found_pbdev == pbdev) {
+        g_hash_table_remove(s390_get_phb()->zpci_table, &pbdev->idx);
+    }
+
+    return 0;
+}
+
+static int s390_pci_device_post_load(void *opaque, int version_id)
+{
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
+
     /*
-     * TODO: add state handling here, so migration works at least with
-     * emulated pci devices on s390x
+     * Now that pbdev->idx has been loaded, use it to place pbdev back into
+     * the table. This may replace a different not-yet-state-loaded pbdev,
+     * but pre_load() handles this case.
      */
-    .unmigratable = 1,
+    g_hash_table_replace(s390_get_phb()->zpci_table, &pbdev->idx, pbdev);
+
+    /*
+     * Regenerate IOMMU state, including IOTLB contents and QEMU memory regions.
+     */
+    if (pbdev->iommu_enabled) {
+        assert(pbdev->iommu);
+        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
+            s390_pci_iommu_enable(pbdev);
+            s390_pci_ioat_replay(pbdev);
+        } else {
+            s390_pci_iommu_direct_map_enable(pbdev);
+        }
+    }
+
+    /*
+     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE instruction,
+     * whose handler consequently starts fmb_timer. We may need to restart it.
+     */
+    if (pbdev->fmb_addr) {
+        assert(!pbdev->fmb_timer);
+        assert(pbdev->pci_group);
+        pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                        fmb_update, pbdev);
+        timer_mod(pbdev->fmb_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                                    pbdev->pci_group->zpci_group.mui);
+    }
+    return 0;
+}
+
+static const VMStateDescription s390_pci_device_vmstate = {
+    .name = TYPE_S390_PCI_DEVICE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = s390_pci_device_pre_load,
+    .post_load = s390_pci_device_post_load,
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
+        VMSTATE_UINT64(max_dma_limit, S390PCIBusDevice),
+        VMSTATE_PTR_TO_IND_ADDR(summary_ind, S390PCIBusDevice),
+        VMSTATE_PTR_TO_IND_ADDR(indicator, S390PCIBusDevice),
+        VMSTATE_BOOL(pci_unplug_request_processed, S390PCIBusDevice),
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
index 191f549ba7..a9c0a4effb 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1094,7 +1094,7 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
     return ret;
 }
 
-static void fmb_update(void *opaque)
+void fmb_update(void *opaque)
 {
     S390PCIBusDevice *pbdev = opaque;
     int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cc768daeb0..5900d919d2 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -923,8 +923,13 @@ static void ccw_machine_11_0_instance_options(MachineState *machine)
 
 static void ccw_machine_11_0_class_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] = {
+        { TYPE_S390_PCI_HOST_BRIDGE, "x-zpci-emul-dev-migr-enabled", "off" },
+    };
+
     ccw_machine_11_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(11, 0);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 2fab28e6e0..3840f6a48f 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -337,6 +337,7 @@ struct S390PCIBusDevice {
     uint16_t uid;
     uint32_t idx;
     uint32_t fh;
+    Error *passthrough_migr_blocker;
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
@@ -390,6 +391,8 @@ struct S390pciState {
     QTAILQ_HEAD(, S390PCIDMACount) zpci_dma_limit;
     QTAILQ_HEAD(, S390PCIGroup) zpci_groups;
     uint8_t next_sim_grp;
+    bool emul_dev_migr_enabled;
+    Error *emul_dev_migr_blocker;
 };
 
 S390pciState *s390_get_phb(void);
@@ -415,5 +418,6 @@ S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
+void fmb_update(void *opaque);
 
 #endif
-- 
2.34.1


