Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF62CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyVq-0006hH-E3; Wed, 14 Oct 2026 08:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu7k-0006Wp-Hl; Wed, 14 Oct 2026 04:14:08 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu7i-00018W-73; Wed, 14 Oct 2026 04:14:08 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P9l3Tcrz4yjjN;
 Wed, 14 Oct 2026 16:14:03 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8E02F006416;
 Wed, 14 Oct 2026 16:14:00 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140814.69E8E02F006416@mse-fl2.zte.com.cn>
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl1.zte.com.cn with SMTP id 69E80ObS093822;
 Wed, 14 Oct 2026 16:00:24 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:26 +0800
X-Zmail-TransId: 3e816acf3699024-0e2e2
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
Subject: [RFC PATCH 13/14] hw/riscv/riscv-iommu-accel: Get host RISC-V IOMMU
 hw info and validate
Date: Wed, 14 Oct 2026 16:00:04 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8E02F006416
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:14:03 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF39CB.001/4j4P9l3Tcrz4yjjN
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:55:01 -0400
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

Fetch the host IOMMU hardware info before attaching a device and
reject a host IOMMU that cannot do S1 translation, following the
ARM SMMUv3 accel device.

The guest-visible capabilities are finalised once the machine
initialisation is done, the last write to the capabilities register
happening before the guest can observe it, host-controlled bits are
intersected with what every attached host IOMMU supports, while
QEMU-only properties are left as-is. A device attached after that
point whose host IOMMU lacks an already advertised capability is
refused.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 hw/riscv/riscv-iommu-accel.c | 145 ++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu-accel.h |  12 +++
 hw/riscv/riscv-iommu.c       |   5 ++
 3 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
index 1bfdad8dcb..7f7db1f135 100644
--- a/hw/riscv/riscv-iommu-accel.c
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
+#include "system/system.h"
 #include "trace.h"
 
 #include "hw/pci/pci_bridge.h"
@@ -25,6 +26,120 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+/* All S1 translation modes. */
+#define RISCV_IOMMU_CAP_S1_MODES \
+    (RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 | \
+     RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57)
+
+/*
+ * Advertised only if the host IOMMU supports them, since the host
+ * performs the S1 translation. Finalised when the machine initialisation
+ * completes. Currently just the S1 modes.
+ */
+#define RISCV_IOMMU_ACCEL_HOST_CAP_MASK RISCV_IOMMU_CAP_S1_MODES
+
+static bool
+riscv_iommu_accel_check_hw_compatible(RISCVIOMMUState *s,
+                                      struct iommu_hw_info_riscv *info,
+                                      Error **errp)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+
+    /*
+     * S1 translation is required for accelerated mode; reject a host
+     * IOMMU that cannot do any S1 mode.
+     */
+    if (!(info->capabilities & RISCV_IOMMU_CAP_S1_MODES)) {
+        error_setg(errp, "Host RISC-V IOMMU does not support S1 translation");
+        return false;
+    }
+
+    /*
+     * Once the capabilities are finalised the register is read-only from
+     * the guest point of view, a device whose host IOMMU cannot provide
+     * an advertised capability cannot be attached.
+     *
+     * Reachable only by a hotplugged device whose host IOMMU is weaker
+     * than the finalised vIOMMU capabilities; A hotplug sharing the
+     * cold-plug host never hits this.
+     */
+    if (accel->finalised &&
+        (s->cap & RISCV_IOMMU_ACCEL_HOST_CAP_MASK) &
+        ~info->capabilities) {
+        error_setg(errp, "Host RISC-V IOMMU capabilities (0x%"PRIx64") "
+                   "do not provide the advertised capabilities (0x%"PRIx64")",
+                   (uint64_t)info->capabilities,
+                   (uint64_t)(s->cap & RISCV_IOMMU_ACCEL_HOST_CAP_MASK));
+        return false;
+    }
+
+    return true;
+}
+
+static bool riscv_iommu_accel_hw_compatible(RISCVIOMMUState *s,
+                                            HostIOMMUDeviceIOMMUFD *idev,
+                                            uint64_t *host_caps,
+                                            Error **errp)
+{
+    struct iommu_hw_info_riscv info;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_RISCV;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid,
+                                         &data_type, &info, sizeof(info),
+                                         &caps, NULL, errp)) {
+        return false;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_RISCV) {
+        error_setg(errp, "Wrong data type (%d) for Host RISC-V IOMMU device info",
+                     data_type);
+        return false;
+    }
+
+    if (!riscv_iommu_accel_check_hw_compatible(s, &info, errp)) {
+        return false;
+    }
+
+    *host_caps = info.capabilities;
+    return true;
+}
+
+/*
+ * Finalise the guest-visible capabilities register. Runs at machine init
+ * done and before the guest may observe the register. This is the last
+ * write to the register.
+ */
+static void riscv_iommu_accel_finalize_caps(RISCVIOMMUState *s)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+    RISCVIOMMUAccelDevice *accel_dev;
+    uint64_t host_caps = ~0ULL;
+
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        host_caps &= accel_dev->host_caps;
+    }
+
+    s->cap &= host_caps | ~RISCV_IOMMU_ACCEL_HOST_CAP_MASK;
+    accel->finalised = true;
+
+    if (!(s->cap & RISCV_IOMMU_CAP_S1_MODES)) {
+        error_report("riscv-iommu: host IOMMUs of accelerated devices do "
+                     "not share a common S1 translation mode");
+        exit(1);
+    }
+
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_CAP], s->cap);
+}
+
+static void riscv_iommu_accel_machine_done(Notifier *notifier, void *data)
+{
+    RISCVIOMMUAccelState *accel = container_of(notifier, RISCVIOMMUAccelState,
+                                               machine_done);
+
+    riscv_iommu_accel_finalize_caps(accel->iommu);
+}
+
 static RISCVIOMMUAccelDevice *riscv_iommu_accel_get_dev(RISCVIOMMUState *s,
                                                         PCIBus *bus, int devfn)
 {
@@ -281,6 +396,7 @@ static bool riscv_iommu_accel_set_iommu_device(PCIBus *bus, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
     RISCVIOMMUAccelDevice *accel_dev = riscv_iommu_accel_get_dev(s, bus, devfn);
+    uint64_t host_caps;
 
     if (!idev) {
         return true;
@@ -295,6 +411,16 @@ static bool riscv_iommu_accel_set_iommu_device(PCIBus *bus, void *opaque,
         return true;
     }
 
+    /*
+     * Check the host IOMMU associated with the dev is compatible with the
+     * QEMU RISC-V IOMMU accel. The reported host_caps will be intersected
+     * into the final capabilities register when the machine initialisation
+     * completes.
+     */
+    if (!riscv_iommu_accel_hw_compatible(s, idev, &host_caps, errp)) {
+        return false;
+    }
+
     if (s->accel_state->viommu) {
         goto done;
     }
@@ -306,6 +432,7 @@ static bool riscv_iommu_accel_set_iommu_device(PCIBus *bus, void *opaque,
     }
 
 done:
+    accel_dev->host_caps = host_caps;
     accel_dev->idev = idev;
     accel_dev->accel = s->accel_state;
     QLIST_INSERT_HEAD(&s->accel_state->device_list, accel_dev, next);
@@ -564,7 +691,23 @@ static void riscv_iommu_accel_as_init(RISCVIOMMUState *s)
 
 void riscv_iommu_accel_init(RISCVIOMMUState *s)
 {
-    s->accel_state = g_new0(RISCVIOMMUAccelState, 1);
+    RISCVIOMMUAccelState *accel = g_new0(RISCVIOMMUAccelState, 1);
+
+    accel->iommu = s;
+    s->accel_state = accel;
     s->iommu_ops = &riscv_iommu_accel_ops;
     riscv_iommu_accel_as_init(s);
 }
+
+/*
+ * Register the machine-done notifier. Kept separate from
+ * riscv_iommu_accel_init() so that registration happens only after
+ * riscv_iommu_realize() has done.
+ */
+void riscv_iommu_accel_register_machine_done(RISCVIOMMUState *s)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+
+    accel->machine_done.notify = riscv_iommu_accel_machine_done;
+    qemu_add_machine_init_done_notifier(&accel->machine_done);
+}
diff --git a/hw/riscv/riscv-iommu-accel.h b/hw/riscv/riscv-iommu-accel.h
index 55d3c0dc62..5d42575747 100644
--- a/hw/riscv/riscv-iommu-accel.h
+++ b/hw/riscv/riscv-iommu-accel.h
@@ -7,6 +7,7 @@
 #ifndef HW_RISCV_RISCV_IOMMU_ACCEL_H
 #define HW_RISCV_RISCV_IOMMU_ACCEL_H
 
+#include "qemu/notify.h"
 #include "hw/riscv/riscv-iommu.h"
 #include "system/iommufd.h"
 #ifdef CONFIG_LINUX
@@ -19,10 +20,15 @@
  * Holds bypass and abort proxy HWPT IDs used for device attachment.
  */
 typedef struct RISCVIOMMUAccelState {
+    RISCVIOMMUState *iommu;
     IOMMUFDViommu *viommu;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, RISCVIOMMUAccelDevice) device_list;
+    /* Machine init done notifier */
+    Notifier machine_done;
+    /* Set once machine init is done */
+    bool finalised;
 } RISCVIOMMUAccelState;
 
 typedef struct RISCVIOMMUS1Hwpt {
@@ -34,6 +40,8 @@ typedef struct RISCVIOMMUAccelDevice {
     HostIOMMUDeviceIOMMUFD *idev;
     RISCVIOMMUS1Hwpt *s1_hwpt;
     IOMMUFDVdev *vdev;
+    /* Host IOMMU capabilities */
+    uint64_t host_caps;
     QLIST_ENTRY(RISCVIOMMUAccelDevice) next;
     RISCVIOMMUAccelState *accel;
 } RISCVIOMMUAccelDevice;
@@ -44,6 +52,7 @@ bool riscv_iommu_accel_install_dc(RISCVIOMMUState *s, int devid);
 bool riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s);
 bool riscv_iommu_accel_issue_inv_cmd(RISCVIOMMUState *s,
                                      const struct riscv_iommu_command *cmd);
+void riscv_iommu_accel_register_machine_done(RISCVIOMMUState *s);
 #else
 static inline void riscv_iommu_accel_init(RISCVIOMMUState *s)
 {
@@ -64,6 +73,9 @@ riscv_iommu_accel_issue_inv_cmd(RISCVIOMMUState *s,
 {
     return true;
 }
+static inline void riscv_iommu_accel_register_machine_done(RISCVIOMMUState *s)
+{
+}
 #endif
 
 #endif /* HW_RISCV_RISCV_IOMMU_ACCEL_H */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index baec21390c..2a370ec474 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2841,6 +2841,11 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
             timer_new_ns(QEMU_CLOCK_VIRTUAL, riscv_iommu_hpm_timer_cb, s);
         s->hpm_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
     }
+
+    /* Register the machine-done notifier last. */
+    if (s->accel) {
+        riscv_iommu_accel_register_machine_done(s);
+    }
 }
 
 static void riscv_iommu_unrealize(DeviceState *dev)
-- 
2.53.0


