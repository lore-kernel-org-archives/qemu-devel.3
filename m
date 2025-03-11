Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B9EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0NQ-0001m4-VO; Tue, 11 Mar 2025 10:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0NO-0001Y5-BB; Tue, 11 Mar 2025 10:14:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0NH-0007Dt-56; Tue, 11 Mar 2025 10:14:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwd245Fyz6FGWY;
 Tue, 11 Mar 2025 22:09:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 21667140CB9;
 Tue, 11 Mar 2025 22:14:24 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:14:16 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 16/20] hw/arm/smmuv3-accel: Read host SMMUv3 device info
Date: Tue, 11 Mar 2025 14:10:41 +0000
Message-ID: <20250311141045.66620-17-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicolin Chen <nicolinc@nvidia.com>

Read the underlying SMMUv3 device info and set corresponding IDR
bits. We need at least one cold-plugged vfio-pci dev associated
with the smmuv3-accel instance to do this now.  Hence fail if it
is not available.

ToDo: The above requirement will be relaxed in future when we add
support in the kernel.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-accel.c         | 104 ++++++++++++++++++++++++++++++++++
 hw/arm/trace-events           |   1 +
 include/hw/arm/smmuv3-accel.h |   2 +
 3 files changed, 107 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 09be838d22..fb08e1d66b 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -15,6 +15,96 @@
 
 #include "smmuv3-internal.h"
 
+static int
+smmuv3_accel_dev_get_info(SMMUv3AccelDevice *accel_dev, uint32_t *data_type,
+                          uint32_t data_len, void *data)
+{
+    uint64_t caps;
+
+    if (!accel_dev || !accel_dev->idev) {
+        return -ENOENT;
+    }
+
+    return !iommufd_backend_get_device_info(accel_dev->idev->iommufd,
+                                            accel_dev->idev->devid,
+                                            data_type, data,
+                                            data_len, &caps, NULL);
+}
+
+static void smmuv3_accel_init_regs(SMMUv3AccelState *s_accel)
+{
+    SMMUv3State *s = ARM_SMMUV3(s_accel);
+    SMMUv3AccelDevice *accel_dev;
+    uint32_t data_type;
+    uint32_t val;
+    int ret;
+
+    if (!s_accel->viommu || QLIST_EMPTY(&s_accel->viommu->device_list)) {
+        error_report("At least one cold-plugged vfio-pci is required for smmuv3-accel!");
+        exit(1);
+    }
+
+    accel_dev = QLIST_FIRST(&s_accel->viommu->device_list);
+    if (accel_dev->info.idr[0]) {
+        info_report("reusing the previous hw_info");
+        goto out;
+    }
+
+    ret = smmuv3_accel_dev_get_info(accel_dev, &data_type,
+                                    sizeof(accel_dev->info), &accel_dev->info);
+    if (ret) {
+        error_report("failed to get SMMU device info");
+        return;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+        error_report("Wrong data type (%d)!", data_type);
+        return;
+    }
+
+out:
+    trace_smmuv3_accel_get_device_info(accel_dev->info.idr[0],
+                                       accel_dev->info.idr[1],
+                                       accel_dev->info.idr[3],
+                                       accel_dev->info.idr[5]);
+
+    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, BTM);
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, BTM, val);
+    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, ATS);
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, val);
+    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, ASID16);
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, val);
+    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, TERM_MODEL);
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, val);
+    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, STALL_MODEL);
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, val);
+    val = FIELD_EX32(accel_dev->info.idr[0], IDR0, STLEVEL);
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
+
+    val = FIELD_EX32(accel_dev->info.idr[1], IDR1, SIDSIZE);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SIDSIZE, val);
+    val = FIELD_EX32(accel_dev->info.idr[1], IDR1, SSIDSIZE);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, val);
+
+    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, HAD);
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, val);
+    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, RIL);
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, val);
+    val = FIELD_EX32(accel_dev->info.idr[3], IDR3, BBML);
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, val);
+
+    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN4K);
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
+    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN16K);
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
+    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, GRAN64K);
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
+    val = FIELD_EX32(accel_dev->info.idr[5], IDR5, OAS);
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, val);
+
+    /* FIXME check iidr and aidr registrs too */
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
                                                 PCIBus *bus, int devfn)
 {
@@ -484,11 +574,25 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
     bs->unset_iommu_device = smmuv3_accel_unset_iommu_device;
 }
 
+static void smmuv3_accel_reset_hold(Object *obj, ResetType type)
+{
+    SMMUv3AccelState *s = ARM_SMMUV3_ACCEL(obj);
+    SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_GET_CLASS(s);
+
+    if (c->parent_phases.hold) {
+        c->parent_phases.hold(obj, type);
+    }
+    smmuv3_accel_init_regs(s);
+}
+
 static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     SMMUv3AccelClass *c = ARM_SMMUV3_ACCEL_CLASS(klass);
 
+    resettable_class_set_parent_phases(rc, NULL, smmuv3_accel_reset_hold, NULL,
+                                       &c->parent_phases);
     device_class_set_parent_realize(dc, smmu_accel_realize,
                                     &c->parent_realize);
     dc->hotpluggable = false;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cd2eac31c2..c7a7e58291 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -62,6 +62,7 @@ smmu_reset_exit(void) ""
 smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
 smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
+smmuv3_accel_get_device_info(uint32_t idr0, uint32_t idr1, uint32_t idr3, uint32_t idr5) "idr0=0x%x idr1=0x%x idr3=0x%x idr5=0x%x"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
index 58e68534c0..9e30d7d351 100644
--- a/include/hw/arm/smmuv3-accel.h
+++ b/include/hw/arm/smmuv3-accel.h
@@ -52,6 +52,7 @@ typedef struct SMMUv3AccelDevice {
     SMMUViommu *viommu;
     SMMUVdev   *vdev;
     AddressSpace as_sysmem;
+    struct iommu_hw_info_arm_smmuv3 info;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
@@ -68,6 +69,7 @@ struct SMMUv3AccelClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
 };
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
-- 
2.34.1


