Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43F2CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyVg-0006eH-VT; Wed, 14 Oct 2026 08:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu6z-0006Ph-8g; Wed, 14 Oct 2026 04:13:22 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu6t-00011M-Ff; Wed, 14 Oct 2026 04:13:18 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P8l4tQcz8XrrJ;
 Wed, 14 Oct 2026 16:13:11 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8D93Y005064;
 Wed, 14 Oct 2026 16:13:09 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140813.69E8D93Y005064@mse-fl2.zte.com.cn>
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl1.zte.com.cn with SMTP id 69E80MIa093699;
 Wed, 14 Oct 2026 16:00:22 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:25 +0800
X-Zmail-TransId: 3e816acf3698024-0e2c2
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
Subject: [RFC PATCH 11/14] hw/riscv/riscv-iommu-accel: Add nested vDC
 install/uninstall support
Date: Wed, 14 Oct 2026 16:00:02 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8D93Y005064
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:13:11 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF3997.000/4j4P8l4tQcz8XrrJ
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A device behind an accelerated IOMMU must have a HWPT matching its
guest device context, bypass, abort, or translate. The bypass and
abort proxy HWPTs are pre-allocated; a translate HWPT needs a
vDEVICE object first, which provides the virtual-to-physical devid
mapping required for invalidations and event reporting.

When the guest issues IODIR.INVAL_DDT, invalidate the context cache
and re-install the HWPT matching the current DC. The DC is resolved
straight from guest memory via riscv_iommu_ctx_fetch(), so a freshly
written context always takes effect; a missing or invalid DC aborts
the device's DMA. The translate HWPT is released when the device is
detached.

This follows the approach of the ARM SMMUv3.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 hw/riscv/riscv-iommu-accel.c | 187 +++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-accel.h |  18 ++++
 hw/riscv/riscv-iommu.c       |  34 ++++++-
 hw/riscv/riscv-iommu.h       |   3 +
 hw/riscv/trace-events        |   2 +
 5 files changed, 239 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
index 6abdac6913..9846374468 100644
--- a/hw/riscv/riscv-iommu-accel.c
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -276,6 +276,7 @@ static void riscv_iommu_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     RISCVIOMMUAccelDevice *accel_dev;
     RISCVIOMMUAccelState *accel;
+    IOMMUFDVdev *vdev;
     RISCVIOMMUSpace *as;
 
     as = riscv_iommu_get_space(s, bus, devfn);
@@ -293,6 +294,20 @@ static void riscv_iommu_accel_unset_iommu_device(PCIBus *bus, void *opaque,
                      "0x%x", idev->devid);
     }
 
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(accel_dev->idev->iommufd,
+                                accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+        accel_dev->s1_hwpt = NULL;
+    }
+
+    vdev = accel_dev->vdev;
+    if (vdev) {
+        iommufd_backend_free_id(accel->viommu->iommufd, vdev->vdevice_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     accel_dev->idev = NULL;
     accel_dev->accel = NULL;
     QLIST_REMOVE(accel_dev, next);
@@ -307,6 +322,178 @@ static void riscv_iommu_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static bool riscv_iommu_accel_alloc_vdev(RISCVIOMMUAccelDevice *accel_dev,
+                                         int devid, Error **errp)
+{
+    RISCVIOMMUAccelState *accel = accel_dev->accel;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    IOMMUFDVdev *vdev = accel_dev->vdev;
+    uint32_t vdevice_id;
+
+    if (!idev || vdev) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_vdev(idev->iommufd, idev->devid,
+                                    accel->viommu->viommu_id, devid,
+                                    &vdevice_id, errp)) {
+        return false;
+    }
+
+    vdev = g_new(IOMMUFDVdev, 1);
+    vdev->vdevice_id = vdevice_id;
+    vdev->virt_id = devid;
+    accel_dev->vdev = vdev;
+    return true;
+}
+
+static RISCVIOMMUS1Hwpt *
+riscv_iommu_accel_dev_alloc_translate(RISCVIOMMUAccelDevice *accel_dev,
+                                      RISCVIOMMUContext *ctx, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    RISCVIOMMUAccelState *accel = accel_dev->accel;
+    struct iommu_hwpt_riscv nested_data = {
+        .tc = ctx->tc,
+        .iosatp = ctx->satp,
+    };
+    uint32_t hwpt_id = 0, flags = 0;
+    RISCVIOMMUS1Hwpt *s1_hwpt;
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    accel->viommu->viommu_id, flags,
+                                    IOMMU_HWPT_DATA_RISCV_S1,
+                                    sizeof(nested_data), &nested_data,
+                                    &hwpt_id, errp)) {
+        return NULL;
+    }
+
+    s1_hwpt = g_new0(RISCVIOMMUS1Hwpt, 1);
+    s1_hwpt->hwpt_id = hwpt_id;
+    trace_riscv_iommu_accel_translate_dc(accel_dev->vdev->virt_id, hwpt_id,
+                                     nested_data.tc, nested_data.iosatp);
+    return s1_hwpt;
+}
+
+bool riscv_iommu_accel_install_dc(RISCVIOMMUState *s, int devid)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+    RISCVIOMMUAccelDevice *accel_dev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    uint32_t hwpt_id = 0;
+    RISCVIOMMUS1Hwpt *s1_hwpt = NULL;
+    const char *type;
+    RISCVIOMMUContext ctx;
+    RISCVIOMMUSpace *as;
+    Error *local_err = NULL;
+    Error **errp = &local_err;
+
+    /*
+     * Nothing to install when accelerated mode is inactive, or when no
+     * vIOMMU has been allocated yet.
+     */
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    as = riscv_iommu_get_space_from_devid(s, devid);
+    if (!as) {
+        return true;
+    }
+
+    accel_dev = container_of(as, RISCVIOMMUAccelDevice, as);
+    if (!accel_dev->accel) {
+        return true;
+    }
+
+    idev = accel_dev->idev;
+    if (!riscv_iommu_accel_alloc_vdev(accel_dev, devid, errp)) {
+        goto err;
+    }
+
+    /*
+     * Resolve the DC straight from guest memory so INVAL_DDT sees the
+     * freshly written context. Abort the device's DMA if the DC is
+     * missing or invalid.
+     *
+     * The vdev stays attached even if HWPT alloc/attach fails, since the
+     * Guest-Host DEVID mapping remains valid.
+     */
+    if (riscv_iommu_ctx_fetch(s, devid, 0, &ctx)) {
+        /* DC missing or invalid, abort all device DMA */
+        hwpt_id = accel->abort_hwpt_id;
+    } else if (get_field(ctx.satp, RISCV_IOMMU_DC_FSC_MODE) ==
+               RISCV_IOMMU_DC_FSC_MODE_BARE) {
+        hwpt_id = accel->bypass_hwpt_id;
+    } else {
+        s1_hwpt = riscv_iommu_accel_dev_alloc_translate(accel_dev, &ctx, errp);
+        if (!s1_hwpt) {
+            goto err;
+        }
+        hwpt_id = s1_hwpt->hwpt_id;
+    }
+
+    if (!hwpt_id) {
+        error_setg(errp, "Invalid DC for device 0x%x", devid);
+        goto err;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
+                                               errp)) {
+        if (s1_hwpt) {
+            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
+            g_free(s1_hwpt);
+        }
+        error_append_hint(errp, "fail to attach hwpt for device 0x%x", devid);
+        goto err;
+    }
+
+    /* Free the previous s1_hwpt */
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+    }
+
+    accel_dev->s1_hwpt = s1_hwpt;
+    if (hwpt_id == accel->abort_hwpt_id) {
+        type = "abort";
+    } else if (hwpt_id == accel->bypass_hwpt_id) {
+        type = "bypass";
+    } else {
+        type = "translate";
+    }
+
+    trace_riscv_iommu_accel_install_dc(devid, type, hwpt_id);
+    return true;
+
+err:
+    if (local_err) {
+        error_report_err(local_err);
+    }
+    return false;
+}
+
+bool riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+    RISCVIOMMUAccelDevice *accel_dev;
+    bool all_ok = true;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        uint32_t devid = riscv_iommu_space_devid(&accel_dev->as);
+        if (!riscv_iommu_accel_install_dc(s, devid)) {
+            error_report("Device 0x%x: Failed to install DC", devid);
+            all_ok = false;
+        }
+    }
+
+    return all_ok;
+}
+
 static const PCIIOMMUOps riscv_iommu_accel_ops = {
     .supports_address_space = riscv_iommu_accel_supports_as,
     .get_address_space = riscv_iommu_accel_find_as,
diff --git a/hw/riscv/riscv-iommu-accel.h b/hw/riscv/riscv-iommu-accel.h
index 49d022817c..85a1ab6d42 100644
--- a/hw/riscv/riscv-iommu-accel.h
+++ b/hw/riscv/riscv-iommu-accel.h
@@ -25,19 +25,37 @@ typedef struct RISCVIOMMUAccelState {
     QLIST_HEAD(, RISCVIOMMUAccelDevice) device_list;
 } RISCVIOMMUAccelState;
 
+typedef struct RISCVIOMMUS1Hwpt {
+    uint32_t hwpt_id;
+} RISCVIOMMUS1Hwpt;
+
 typedef struct RISCVIOMMUAccelDevice {
     RISCVIOMMUSpace as;
     HostIOMMUDeviceIOMMUFD *idev;
+    RISCVIOMMUS1Hwpt *s1_hwpt;
+    IOMMUFDVdev *vdev;
     QLIST_ENTRY(RISCVIOMMUAccelDevice) next;
     RISCVIOMMUAccelState *accel;
 } RISCVIOMMUAccelDevice;
 
 #ifdef CONFIG_RISCV_IOMMU_ACCEL
 void riscv_iommu_accel_init(RISCVIOMMUState *s);
+bool riscv_iommu_accel_install_dc(RISCVIOMMUState *s, int devid);
+bool riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s);
 #else
 static inline void riscv_iommu_accel_init(RISCVIOMMUState *s)
 {
 }
+static inline bool
+riscv_iommu_accel_install_dc(RISCVIOMMUState *s, int devid)
+{
+    return true;
+}
+static inline bool
+riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_RISCV_RISCV_IOMMU_ACCEL_H */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e43cf656db..55cabc4f45 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -65,7 +65,7 @@ struct RISCVIOMMUEntry {
 /* IOMMU index for transactions without process_id specified. */
 #define RISCV_IOMMU_NOPROCID 0
 
-static uint32_t riscv_iommu_space_devid(RISCVIOMMUSpace *as)
+uint32_t riscv_iommu_space_devid(RISCVIOMMUSpace *as)
 {
     uint32_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
 
@@ -1555,6 +1555,19 @@ RISCVIOMMUSpace *riscv_iommu_get_space(RISCVIOMMUState *s, PCIBus *bus, int devf
     return as;
 }
 
+RISCVIOMMUSpace *riscv_iommu_get_space_from_devid(RISCVIOMMUState *s,
+                                                  uint32_t devid)
+{
+    RISCVIOMMUSpace *as;
+    QLIST_FOREACH(as, &s->spaces, list) {
+        if (riscv_iommu_space_devid(as) == devid) {
+            break;
+        }
+    }
+
+    return as;
+}
+
 /* Find or allocate address space for a given device */
 AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus, int devfn)
 {
@@ -2090,19 +2103,30 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
                              RISCV_IOMMU_CMD_IODIR_OPCODE):
+        {
+            uint32_t devid = get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID);
+
             if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
-                /* invalidate all device context cache mappings */
+                /* DV=0, invalidate and re-install every accelerated device */
                 func = riscv_iommu_ctx_inval_all;
+                riscv_iommu_ctx_inval(s, func, devid, 0);
+                if (!riscv_iommu_accel_install_dc_all(s)) {
+                    goto cmd_ill;
+                }
             } else {
-                /* invalidate all device context matching DID */
+                /* DV=1, invalidate and re-install device matching DID */
                 func = riscv_iommu_ctx_inval_devid;
+                riscv_iommu_ctx_inval(s, func, devid, 0);
+                if (!riscv_iommu_accel_install_dc(s, devid)) {
+                    goto cmd_ill;
+                }
             }
-            riscv_iommu_ctx_inval(s, func,
-                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
             break;
+        }
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT,
                              RISCV_IOMMU_CMD_IODIR_OPCODE):
+            /* FIXME: add support for PDT inval for vIOMMU */
             if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
                 /* illegal command arguments IODIR_PDT & DV == 0 */
                 goto cmd_ill;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index d1f916885c..c21bccb131 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -130,6 +130,9 @@ void riscv_iommu_init_space(RISCVIOMMUState *s, RISCVIOMMUSpace *as,
                             PCIBus *bus, int devfn);
 AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus, int devfn);
 RISCVIOMMUSpace *riscv_iommu_get_space(RISCVIOMMUState *s, PCIBus *bus, int devfn);
+RISCVIOMMUSpace *riscv_iommu_get_space_from_devid(RISCVIOMMUState *s,
+                                                  uint32_t devid);
+uint32_t riscv_iommu_space_devid(RISCVIOMMUSpace *as);
 
 typedef struct RISCVIOMMUContext RISCVIOMMUContext;
 /* Device translation context state. */
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 9834f108b9..55f7d1f0f3 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,3 +28,5 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 #riscv-iommu-accel.c
 riscv_iommu_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
 riscv_iommu_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
+riscv_iommu_accel_translate_dc(uint32_t vsid, uint32_t hwpt_id, uint64_t tc, uint64_t iosatp) "vSID=0x%x hwpt_id=0x%x dc=%"PRIx64":%"PRIx64
+riscv_iommu_accel_install_dc(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x dc type=%s hwpt_id=0x%x"
-- 
2.53.0


