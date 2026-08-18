Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0E2C5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNZR-0007aZ-Q2; Tue, 18 Aug 2026 13:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZO-0007X9-Bx; Tue, 18 Aug 2026 13:25:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZM-00037s-0b; Tue, 18 Aug 2026 13:25:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3aNA542402; Tue, 18 Aug 2026 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aiuWxU/CyQ3owHLW5
 cuM3gpzUsRfwxyz47HZh4H4AvI=; b=ma1ZOlh4UfTtP4T8Y8oimqVAzGkZ+KVHi
 uoWHpN5VNR5hX+NSop1HP9ZrcVlw5fmllkiyjnIVcHI6c6hMTHTCbn6OIAYP4c2G
 /LprRSCGU2+Ketr61GeHMXxSR2ke8GKimP/mivd7IU0fmfNcnkO0CK0M9WcM4J/2
 pD95RnIZxdtsVgjQmnRfz0kiqIvtQChbO5QUP8htQHBmT41uRGmYeUMBUSesvU8t
 Up1xh5fm1X9gzDrzQkY8mCnEkihyqB3MTwp92gZ+3aOLmxd01cLmJPNwtz10oXdL
 c/pMXFbEuyuc1EG78fLujWWQ8EgHXdngYZ5scUMGZDTLjRRM6fuPA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt969c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDeqS002851;
 Tue, 18 Aug 2026 17:25:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yc70p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHPghn7078474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:25:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE0D5805C;
 Tue, 18 Aug 2026 17:25:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFFD45805E;
 Tue, 18 Aug 2026 17:25:41 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:25:41 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v7 14/15] s390x/pci: Implement migration for emulated devices
Date: Tue, 18 Aug 2026 12:25:20 -0500
Message-Id: <20260818172521.223460-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818172521.223460-1-kshk@linux.ibm.com>
References: <20260818172521.223460-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a849598 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=BaPdF8j1E3L0cLeJECkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX0xLIOy7fol8K
 7qF3PeTGLJMfiJKHgFcdVLQyq3JN6mTmqXsxhB9DP91mOrxyKr0l3n3FBOP+89Db/J7l7lRCRZj
 jClg3sqV73WUgEL2lWnzkwQbRrox7Ew=
X-Proofpoint-GUID: 7sS0OzW8JJ9g0vAPo-v8VfNGr7JfklT3
X-Proofpoint-ORIG-GUID: 7sS0OzW8JJ9g0vAPo-v8VfNGr7JfklT3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX9kMNWD6hOZJn
 nKr1J/hi9+DYiWVjt6YtbRTf6zyREXLC6N2s6z4bd4PdX91UIvqZlFnrrMK1riKAtesyRh6jhuS
 iYPly31zrqiS7q0kOegPJvgnp1gOxAeLtdDJSHdO2bbq0VQWVW7DKmDN7QibkX3+9wDG/tDzSyk
 LHNZj7Sh/6EOZcWajNsGOmmsZLRarSCD+d05YcCxuUH79SfM6wb4zTTUxOpa0E9iWnaLNuXSNAQ
 dbebs/qchwVjMLPWgZctaSGbw4woLsmPmabUp6Gmy6G18iKYNDFL3vKSL6IQPUz9JI+wNSM4qvo
 SAuf7fsZ2zJ6gz1t8qothL+kOUrUjA+dJYUXAi5U1L38K8/l+iOVwZqGaL+NnRPtUu+kXTSVEp5
 Q1UzR36nJ/YeNdien2lAtVM3Hob6W80kWrA2smPsAhgUda6Ng51vK7CqHfK/JXuvGLX+eiuG658
 BGKoxtWLOq9Hsl2dYSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
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

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 195 +++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.c        |   2 +-
 hw/s390x/s390-virtio-ccw.c      |   4 +
 include/hw/s390x/s390-pci-bus.h |   4 +
 4 files changed, 199 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index a94e24a2ac..4ac845328f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -26,6 +26,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "exec/cpu-common.h"
+#include "migration/blocker.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/physmem.h"
@@ -34,6 +35,11 @@
 
 #include "trace.h"
 
+static const Property phb_props[] = {
+    DEFINE_PROP_BOOL("x-zpci-emul-dev-migr-enabled", S390pciState,
+                     emul_dev_migr_enabled, true),
+};
+
 S390pciState *s390_get_phb(void)
 {
     static S390pciState *phb;
@@ -1129,6 +1135,46 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
     return 0;
 }
 
+static int s390_set_emul_dev_migration_blocker(S390PCIBusDevice *pbdev,
+        S390pciState *s, Error **errp)
+{
+    if (s->emul_dev_migr_enabled) {
+        return 0;
+    }
+    error_setg(&pbdev->emul_dev_migr_blocker,
+               "Migration blocked on this machine type by emulated zPCI device "
+               "fh 0x%x uid %d fid %d", pbdev->fh, pbdev->uid, pbdev->fid);
+    return migrate_add_blocker(&pbdev->emul_dev_migr_blocker, errp);
+}
+
+static void s390_clear_emul_dev_migration_blocker(S390PCIBusDevice *pbdev)
+{
+    if (pbdev->emul_dev_migr_blocker) {
+        migrate_del_blocker(&pbdev->emul_dev_migr_blocker);
+    }
+}
+
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
@@ -1242,9 +1288,20 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             pbdev->rtr_avail = false;
         }
 
+        if (s390_set_passthrough_migration_blocker(pbdev, errp) != 0) {
+            return;
+        }
+
+        if (s390_set_emul_dev_migration_blocker(pbdev, s, errp) != 0) {
+            s390_clear_passthrough_migration_blocker(pbdev);
+            return;
+        }
+
         if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
+            s390_clear_emul_dev_migration_blocker(pbdev);
+            s390_clear_passthrough_migration_blocker(pbdev);
             return;
         }
 
@@ -1284,6 +1341,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
             return;
         }
 
+        s390_clear_emul_dev_migration_blocker(pbdev);
+        s390_clear_passthrough_migration_blocker(pbdev);
+
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
         bus = pci_get_bus(pci_dev);
@@ -1451,6 +1511,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
     hc->unplug_request = s390_pcihost_unplug_request;
     hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
+    device_class_set_props(dc, phb_props);
 }
 
 static const TypeInfo s390_pcihost_info = {
@@ -1464,10 +1525,33 @@ static const TypeInfo s390_pcihost_info = {
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
+     * instance_id to distinquish devices, and that instance_id can change
+     * if a device is unplugged and plugged back, preventing migration.
+     */
+    .class_init = s390_pcibus_class_init,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
@@ -1613,13 +1697,114 @@ static const Property s390_pci_device_properties[] = {
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
+     * pbdev into the table.
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
+        assert(pbdev->iommu);
+        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
+            s390_pci_iommu_enable(pbdev);
+            s390_pci_ioat_replay(pbdev);
+        } else {
+            s390_pci_iommu_direct_map_enable(pbdev);
+        }
+    }
+
     /*
-     * TODO: add state handling here, so migration works at least with
-     * emulated pci devices on s390x
+     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE instruction,
+     * whose handler consequently starts fmb_timer. We may need to restart it.
      */
-    .unmigratable = 1,
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
index f93db10c81..6b0742d143 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1122,7 +1122,7 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
     return ret;
 }
 
-static void fmb_update(void *opaque)
+void fmb_update(void *opaque)
 {
     S390PCIBusDevice *pbdev = opaque;
     int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 06e5def909..b22c27b066 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -939,8 +939,12 @@ static void ccw_machine_11_1_instance_options(MachineState *machine)
 
 static void ccw_machine_11_1_class_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] = {
+        { TYPE_S390_PCI_HOST_BRIDGE, "x-zpci-emul-dev-migr-enabled", "off" },
+    };
     ccw_machine_11_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(11, 1);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 17ecf3e0da..66c1f04ead 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -340,6 +340,8 @@ struct S390PCIBusDevice {
     uint16_t uid;
     uint32_t idx;
     uint32_t fh;
+    Error *emul_dev_migr_blocker;
+    Error *passthrough_migr_blocker;
     uint32_t fid;
     bool fid_defined;
     uint64_t fmb_addr;
@@ -393,6 +395,7 @@ struct S390pciState {
     QTAILQ_HEAD(, S390PCIDMACount) zpci_dma_limit;
     QTAILQ_HEAD(, S390PCIGroup) zpci_groups;
     uint8_t next_sim_grp;
+    bool emul_dev_migr_enabled;
 };
 
 S390pciState *s390_get_phb(void);
@@ -418,5 +421,6 @@ S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
+void fmb_update(void *opaque);
 
 #endif
-- 
2.34.1


