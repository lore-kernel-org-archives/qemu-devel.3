Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D10CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyWR-00075G-Lf; Wed, 14 Oct 2026 08:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu6b-0006MR-Eh; Wed, 14 Oct 2026 04:12:57 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu6Z-0000zQ-3z; Wed, 14 Oct 2026 04:12:57 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4P8J2HnFz59trB;
 Wed, 14 Oct 2026 16:12:48 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8Cmd3004088;
 Wed, 14 Oct 2026 16:12:48 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140812.69E8Cmd3004088@mse-fl2.zte.com.cn>
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 69E80Ma9079475;
 Wed, 14 Oct 2026 16:00:22 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:24 +0800
X-Zmail-TransId: 3e816acf3698024-0e2af
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 10/14] hw/riscv/riscv-iommu-accel: Add
 set/unset_iommu_device callback
Date: Wed, 14 Oct 2026 16:00:01 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8Cmd3004088
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:12:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF3980.002/4j4P8J2HnFz59trB
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:59 -0400
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

From: Wu Fei <wu.fei9@sanechips.com.cn>

Implement the VFIO/PCI callbacks to attach and detach a
HostIOMMUDevice to the vIOMMU when accel=on, following the ARM
SMMUv3 accel device.

In accelerated mode the guest IOMMU is backed by the host IOMMU
via IOMMUFD, a vIOMMU object provides the per-VM, isolated handle
to the physical IOMMU, so the attach callback allocates one when
the first device attaches. Two proxy nested HWPTs (bypass and
abort) are pre-allocated under the vIOMMU and one is installed
based on the DDTP mode. The detach callback re-attaches the device
to its default stage-2 HWPT and, once the last device detaches,
releases the proxy HWPTs and the vIOMMU.

Introduce RISCVIOMMUAccelState holding the vIOMMU object, the
bypass/abort proxy HWPT IDs, and the attached device list.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu-accel.c | 164 +++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-accel.h |  18 ++++
 hw/riscv/riscv-iommu.h       |   1 +
 hw/riscv/trace-events        |   4 +
 4 files changed, 187 insertions(+)

diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
index 2bafbfa5e0..6abdac6913 100644
--- a/hw/riscv/riscv-iommu-accel.c
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/gpex.h"
@@ -146,10 +147,172 @@ static uint64_t riscv_iommu_accel_get_viommu_flags(void *opaque)
     return VIOMMU_FLAG_WANT_NESTING_PARENT;
 }
 
+static uint32_t riscv_iommu_accel_ddtp_hwpt(RISCVIOMMUState *s,
+                                            RISCVIOMMUAccelState *accel)
+{
+    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
+    /*
+     * Initial proxy HWPT: with DDTP.Mode=OFF the IOMMU is
+     * disabled and all accesses abort; any other mode (Bare or a
+     * translation mode) starts with the bypass proxy until the guest
+     * programs a device context.
+     */
+    return (mode == RISCV_IOMMU_DDTP_MODE_OFF) ?
+               accel->abort_hwpt_id : accel->bypass_hwpt_id;
+}
+
+static bool riscv_iommu_accel_alloc_viommu(RISCVIOMMUState *s,
+                                           HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+    struct iommu_hwpt_riscv bypass_data = {
+        .tc = RISCV_IOMMU_DC_TC_V,
+        .iosatp = RISCV_IOMMU_DC_FSC_MODE_BARE,
+    };
+
+    struct iommu_hwpt_riscv abort_data = {
+        .tc = 0,  /* V = 0, invalid DC aborts */
+        .iosatp = 0,  /* don't care */
+    };
+
+    uint32_t s2_hwpt_id = idev->hwpt_id;
+    uint32_t viommu_id, hwpt_id;
+    IOMMUFDViommu *viommu;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_RISCV, s2_hwpt_id,
+                                      NULL, 0, &viommu_id, errp)) {
+        return false;
+    }
+
+    viommu = g_new0(IOMMUFDViommu, 1);
+    viommu->viommu_id = viommu_id;
+    viommu->s2_hwpt_id = s2_hwpt_id;
+    viommu->iommufd = idev->iommufd;
+    accel->viommu = viommu;
+
+    /*
+     * Pre-allocate HWPTs for the S1 bypass and abort cases, to be attached
+     * later based on a guest device context (DC) or the DDTP mode.
+     */
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+                                    0, IOMMU_HWPT_DATA_RISCV_S1,
+                                    sizeof(abort_data), &abort_data,
+                                    &accel->abort_hwpt_id, errp)) {
+        goto free_viommu;
+    }
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+                                    0, IOMMU_HWPT_DATA_RISCV_S1,
+                                    sizeof(bypass_data), &bypass_data,
+                                    &accel->bypass_hwpt_id, errp)) {
+        goto free_abort_hwpt;
+    }
+
+    /* Attach a HWPT based on ddtp.iommu_mode value */
+    hwpt_id = riscv_iommu_accel_ddtp_hwpt(s, accel);
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
+        goto free_bypass_hwpt;
+    }
+    return true;
+
+free_bypass_hwpt:
+    iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
+free_abort_hwpt:
+    iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
+    g_free(viommu);
+    accel->viommu = NULL;
+    return false;
+}
+
+static bool riscv_iommu_accel_set_iommu_device(PCIBus *bus, void *opaque,
+                                               int devfn,
+                                               HostIOMMUDevice *hiod,
+                                               Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
+    RISCVIOMMUAccelDevice *accel_dev = riscv_iommu_accel_get_dev(s, bus, devfn);
+
+    if (!idev) {
+        return true;
+    }
+
+    if (accel_dev->idev) {
+        if (accel_dev->idev != idev) {
+            error_setg(errp, "Device already has an associated idev 0x%x",
+                       idev->devid);
+            return false;
+        }
+        return true;
+    }
+
+    if (s->accel_state->viommu) {
+        goto done;
+    }
+
+    if (!riscv_iommu_accel_alloc_viommu(s, idev, errp)) {
+        error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
+                          idev->devid);
+        return false;
+    }
+
+done:
+    accel_dev->idev = idev;
+    accel_dev->accel = s->accel_state;
+    QLIST_INSERT_HEAD(&s->accel_state->device_list, accel_dev, next);
+    trace_riscv_iommu_accel_set_iommu_device(devfn, idev->devid);
+    return true;
+}
+
+static void riscv_iommu_accel_unset_iommu_device(PCIBus *bus, void *opaque,
+                                                 int devfn)
+{
+    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
+    HostIOMMUDeviceIOMMUFD *idev;
+    RISCVIOMMUAccelDevice *accel_dev;
+    RISCVIOMMUAccelState *accel;
+    RISCVIOMMUSpace *as;
+
+    as = riscv_iommu_get_space(s, bus, devfn);
+    if (!as) {
+        return;
+    }
+
+    accel_dev = container_of(as, RISCVIOMMUAccelDevice, as);
+    idev = accel_dev->idev;
+    accel = accel_dev->accel;
+    /* Re-attach the default s2 hwpt id */
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
+                                               idev->hwpt_id, NULL)) {
+        error_report("Unable to attach the default HW pagetable: idev devid "
+                     "0x%x", idev->devid);
+    }
+
+    accel_dev->idev = NULL;
+    accel_dev->accel = NULL;
+    QLIST_REMOVE(accel_dev, next);
+    trace_riscv_iommu_accel_unset_iommu_device(devfn, idev->devid);
+
+    if (QLIST_EMPTY(&accel->device_list)) {
+        iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
+        iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
+        iommufd_backend_free_id(accel->viommu->iommufd, accel->viommu->viommu_id);
+        g_free(accel->viommu);
+        accel->viommu = NULL;
+    }
+}
+
 static const PCIIOMMUOps riscv_iommu_accel_ops = {
     .supports_address_space = riscv_iommu_accel_supports_as,
     .get_address_space = riscv_iommu_accel_find_as,
     .get_viommu_flags = riscv_iommu_accel_get_viommu_flags,
+    .set_iommu_device = riscv_iommu_accel_set_iommu_device,
+    .unset_iommu_device = riscv_iommu_accel_unset_iommu_device,
 };
 
 static void riscv_iommu_accel_as_init(RISCVIOMMUState *s)
@@ -170,6 +333,7 @@ static void riscv_iommu_accel_as_init(RISCVIOMMUState *s)
 
 void riscv_iommu_accel_init(RISCVIOMMUState *s)
 {
+    s->accel_state = g_new0(RISCVIOMMUAccelState, 1);
     s->iommu_ops = &riscv_iommu_accel_ops;
     riscv_iommu_accel_as_init(s);
 }
diff --git a/hw/riscv/riscv-iommu-accel.h b/hw/riscv/riscv-iommu-accel.h
index c69fea87dd..49d022817c 100644
--- a/hw/riscv/riscv-iommu-accel.h
+++ b/hw/riscv/riscv-iommu-accel.h
@@ -8,10 +8,28 @@
 #define HW_RISCV_RISCV_IOMMU_ACCEL_H
 
 #include "hw/riscv/riscv-iommu.h"
+#include "system/iommufd.h"
+#ifdef CONFIG_LINUX
+#include <linux/iommufd.h>
+#endif
 #include CONFIG_DEVICES
 
+/*
+ * Represents an accelerated IOMMU instance backed by an iommufd vIOMMU object.
+ * Holds bypass and abort proxy HWPT IDs used for device attachment.
+ */
+typedef struct RISCVIOMMUAccelState {
+    IOMMUFDViommu *viommu;
+    uint32_t bypass_hwpt_id;
+    uint32_t abort_hwpt_id;
+    QLIST_HEAD(, RISCVIOMMUAccelDevice) device_list;
+} RISCVIOMMUAccelState;
+
 typedef struct RISCVIOMMUAccelDevice {
     RISCVIOMMUSpace as;
+    HostIOMMUDeviceIOMMUFD *idev;
+    QLIST_ENTRY(RISCVIOMMUAccelDevice) next;
+    RISCVIOMMUAccelState *accel;
 } RISCVIOMMUAccelDevice;
 
 #ifdef CONFIG_RISCV_IOMMU_ACCEL
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 5544de595c..d1f916885c 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -113,6 +113,7 @@ struct RISCVIOMMUState {
 
     /* nested iommu support */
     bool accel;
+    struct RISCVIOMMUAccelState *accel_state;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index b50b14a654..9834f108b9 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -24,3 +24,7 @@ riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%"PRIx64
 riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
 riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x%"PRIx64
 riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx 0x%x ovf 0x%x val 0x%"PRIx64
+
+#riscv-iommu-accel.c
+riscv_iommu_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
+riscv_iommu_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
-- 
2.53.0


