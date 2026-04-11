Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04435F45A12
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBO40-0002DC-6u; Fri, 10 Apr 2026 22:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3x-00028y-I3; Fri, 10 Apr 2026 22:27:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3v-0000Ow-CF; Fri, 10 Apr 2026 22:27:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AFnwtG2592757; Sat, 11 Apr 2026 02:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RPnb/3oTyoLut9quX
 SeHc3lwxt57zRTjT6x6s+4abQw=; b=CdRXDpj4QuQU36rIG+WqqtHP3DMTSwzK7
 x3GpnO73X2j9St1xydyMDr7bd8mB4VzP9PZ65Tgs6fuTrGgGDsfqJmY6SpEULpMT
 ih8ymLrnOr3epuRNe2T64Slmh+lPkXx2jl1RVkgU5q98EDMIz3D4S9HkORe0Rtiv
 lpoEl65f7wBsn9EeP8PkGNhOtaxIqRxquJ4cmkfNUYjLZDJPnITiOw1LJDWw0sbd
 WB2uj7FJ1kth+fuD85oeWF4Hk0yC2YBN/iBpx12zTYE7jfxdSb90OKy2L8Exo7ji
 03SbjB4Nj7bXxrpoIE9tg7cwJSpcSuAU5IihQmP1OWpf5VPiFfzeg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2en5dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:27:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63B0M3Mn018987;
 Sat, 11 Apr 2026 02:27:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9u23p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:27:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63B2R0mR47251966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Apr 2026 02:27:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD3615805F;
 Sat, 11 Apr 2026 02:27:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20D1E5805C;
 Sat, 11 Apr 2026 02:27:00 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.248])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Apr 2026 02:27:00 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2 14/15] s390x/pci: Implement migration for emulated devices
Date: Fri, 10 Apr 2026 21:26:17 -0500
Message-Id: <20260411022618.2136588-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411022618.2136588-1-kshk@linux.ibm.com>
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -KekZNdbbEh_DN7-D2MkZhDY_ufHAcDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNiBTYWx0ZWRfX1d+N+rb7ZKP9
 UuL6kajzJ70/vHXImeipJxgZlani+MwWY1+MDfAZdK3++eOrGqNJPoRqE6igz7F3WEluYf8RL20
 wQYP9bh6hMJWV9ENyIRHlcYW9ZI19EnBqbV+XEUIo9TSHljmlmABm5hhQsFnO360Ay/DgTpmq7j
 7H5dAw4UX84yveoKmiHOuA+6B+AvVHHMp2oobu4SzXIhr8FdtLT9WOFnvdG1phwQSRMVeK63nST
 pFbbo3bqVE1+73YVrCp2m7XD6RZ5DwD/A0vovuCvzqQJ5h/E5xgHwcHazHh50TYviLLlEZAi5Gb
 5CAaRTWNKHMzGq52lYSGXQIzNYUYL7BalX8EpFDoA0u/FiwMqxceCpWr5HM+mPb1wR+g3Zhkjsr
 QNqoswFRAL+fRGRA3KV4AW63qn4vgKW6I6BD+1jdoSjeWBbSBexPRB3vipKBs4badhguZY6t/9G
 puOaz5uEufDg+rPVNrw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d9b177 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=lLb58Vng283uxITr1-gA:9
X-Proofpoint-GUID: -KekZNdbbEh_DN7-D2MkZhDY_ufHAcDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Implement zPCI device state migration, consequently enabling migration
of VMs that have emulated PCI devices, whether virtio or not.
Migration is allowed for devices whose function handle has the
FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
state of its zPCI emulator.

Passthrough devices will continue to block migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 139 ++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.c        |   2 +-
 hw/s390x/s390-virtio-ccw.c      |   5 ++
 include/hw/s390x/s390-pci-bus.h |   4 +
 4 files changed, 144 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f339a0fd94..ab9339bdc7 100644
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
@@ -904,6 +910,25 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
 }
 
+static int s390_set_emul_dev_migration_blocker(S390pciState *s, Error **errp)
+{
+    if (s->emul_dev_migr_enabled) {
+        return 0;
+    }
+    error_setg(&s->migr_blocker,
+               "Migration disabled for emulated zPCI devices on this machine type");
+    return migrate_add_blocker(&s->migr_blocker, errp);
+}
+
+static void s390_clear_emul_dev_migration_blocker(S390pciState *s)
+{
+    if (s->migr_blocker) {
+        migrate_del_blocker(&s->migr_blocker);
+        error_free(s->migr_blocker);
+        s->migr_blocker = NULL;
+    }
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -939,6 +964,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
     s390_pcihost_kvm_realize();
+    s390_set_emul_dev_migration_blocker(s, errp);
 }
 
 static void s390_pcihost_unrealize(DeviceState *dev)
@@ -946,6 +972,8 @@ static void s390_pcihost_unrealize(DeviceState *dev)
     S390PCIGroup *group;
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
 
+    s390_clear_emul_dev_migration_blocker(s);
+
     while (!QTAILQ_EMPTY(&s->zpci_groups)) {
         group = QTAILQ_FIRST(&s->zpci_groups);
         QTAILQ_REMOVE(&s->zpci_groups, group, link);
@@ -1116,6 +1144,27 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
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
@@ -1235,6 +1284,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -1271,6 +1325,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
             return;
         }
 
+        s390_clear_passthrough_migration_blocker(pbdev);
+
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
         bus = pci_get_bus(pci_dev);
@@ -1438,6 +1494,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, const void *data)
     hc->unplug_request = s390_pcihost_unplug_request;
     hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
+    device_class_set_props(dc, phb_props);
 }
 
 static const TypeInfo s390_pcihost_info = {
@@ -1600,13 +1657,85 @@ static const Property s390_pci_device_properties[] = {
                      true),
 };
 
-static const VMStateDescription s390_pci_device_vmstate = {
-    .name = TYPE_S390_PCI_DEVICE,
+static int s390_pci_device_post_load(void *opaque, int version_id)
+{
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
+
     /*
-     * TODO: add state handling here, so migration works at least with
-     * emulated pci devices on s390x
+     * Now that S390PCIBusDevice fields have been restored, regenerate IOMMU
+     * state - that includes IOTLB contents and QEMU memory regions.
      */
-    .unmigratable = 1,
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
+     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE instruction.
+     * The handler consequently starts fmb_timer. Now that fmb_addr has been
+     * restored, we may need to restart fmb_timer.
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
index 3ef009463d..da48a2edc0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -913,6 +913,11 @@ static void ccw_machine_11_0_instance_options(MachineState *machine)
 
 static void ccw_machine_11_0_class_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] = {
+        { TYPE_S390_PCI_HOST_BRIDGE, "x-zpci-emul-dev-migr-enabled", "off" },
+    };
+
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE_AS_LATEST(11, 0);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 2fab28e6e0..15cf004c31 100644
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
+    Error *migr_blocker;
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


