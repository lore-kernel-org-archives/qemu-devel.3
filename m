Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872FEFCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq62-0001Fw-LP; Tue, 10 Mar 2026 01:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5Z-0000ob-Ne
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5X-0006LO-7v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HFTSQSGTDzITAOxJjwZ6A8S8EXuNQDFAnJqDDfwx/M=;
 b=NIXO+X3MlDaBtBK36OGtHZ3BPfgBvq4iNmh10A5SIlnfSzN28JOdPjJditvYDxd0bzGuEC
 iTUCVZJrZac12HFXSQXGIrtKZQd787YT1593GGBs0NOYSHzgNeSdM719Xj3SxdD3r5bsT/
 c/by+iwVtgZdcoa5y0PpZ/ASO4ARGzY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-oAGewyd3MhWex9koD4Bikw-1; Tue,
 10 Mar 2026 01:56:57 -0400
X-MC-Unique: oAGewyd3MhWex9koD4Bikw-1
X-Mimecast-MFC-AGG-ID: oAGewyd3MhWex9koD4Bikw_1773122215
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD1A719560AE; Tue, 10 Mar 2026 05:56:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 007811956095; Tue, 10 Mar 2026 05:56:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 21/25] s390x: Build IPLB for virtio-pci devices
Date: Tue, 10 Mar 2026 06:55:26 +0100
Message-ID: <20260310055530.8893-22-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Search for a corresponding S390PCIBusDevice and build an IPLB if a device has
been indexed for boot but does not identify as a CCW device,

PCI devices are not yet included in boot probing (they must have a boot index).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-14-jrossi@linux.ibm.com>
[thuth: Fix endianness issue when running on a little endian host]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.h                  |  3 ++
 include/hw/s390x/s390-pci-bus.h |  2 ++
 hw/s390x/ipl.c                  | 56 ++++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-bus.c         |  3 +-
 4 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index c542d30ce2d..403cd08450d 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -107,6 +107,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
+#define S390_IPLB_MIN_PCI_LEN 376
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 
 static inline bool iplb_valid_len(IplParameterBlock *iplb)
@@ -179,6 +180,8 @@ static inline bool iplb_valid(IplParameterBlock *iplb)
         return len >= S390_IPLB_MIN_FCP_LEN;
     case S390_IPL_TYPE_CCW:
         return len >= S390_IPLB_MIN_CCW_LEN;
+    case S390_IPL_TYPE_PCI:
+        return len >= S390_IPLB_MIN_PCI_LEN;
     case S390_IPL_TYPE_QEMU_SCSI:
     default:
         return false;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index f643e130579..9228523ce8e 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -402,6 +402,8 @@ S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
 S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
 S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
                                               const char *target);
+S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
+                                           PCIDevice *pci_dev);
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d34adb55220..7e09a8cf80d 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -28,6 +28,8 @@
 #include "hw/s390x/ebcdic.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/s390x/s390-pci-bus.h"
 #include "exec/cpu-common.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
@@ -340,7 +342,8 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     ipl->qipl.boot_menu_timeout = cpu_to_be32(splash_time);
 }
 
-#define CCW_DEVTYPE_NONE        0x00
+#define S390_DEVTYPE_NONE       0x00
+
 #define CCW_DEVTYPE_VIRTIO      0x01
 #define CCW_DEVTYPE_VIRTIO_NET  0x02
 #define CCW_DEVTYPE_SCSI        0x03
@@ -349,7 +352,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
 static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 {
     CcwDevice *ccw_dev = NULL;
-    int tmp_dt = CCW_DEVTYPE_NONE;
+    int tmp_dt = S390_DEVTYPE_NONE;
 
     if (dev_st) {
         VirtIONet *virtio_net_dev = (VirtIONet *)
@@ -396,6 +399,31 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
     return ccw_dev;
 }
 
+#define PCI_DEVTYPE_VIRTIO       0x05
+
+static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
+{
+    S390PCIBusDevice *pbdev = NULL;
+    int tmp_dt = S390_DEVTYPE_NONE;
+
+    if (dev_st) {
+        PCIDevice *pci_dev = (PCIDevice *)
+            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
+                                       TYPE_VIRTIO_PCI);
+        if (pci_dev) {
+            pbdev = s390_pci_find_dev_by_pci(s390_get_phb(), pci_dev);
+            if (pbdev) {
+                tmp_dt = PCI_DEVTYPE_VIRTIO;
+            }
+        }
+    }
+    if (devtype) {
+        *devtype = tmp_dt;
+    }
+
+    return pbdev;
+}
+
 static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -428,14 +456,12 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
+    S390PCIBusDevice *pbdev = NULL;
     SCSIDevice *sd;
     int devtype;
     uint8_t *lp;
     g_autofree void *scsi_lp = NULL;
 
-    /*
-     * Currently allow IPL only from CCW devices.
-     */
     ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     if (ccw_dev) {
         lp = ccw_dev->loadparm;
@@ -485,6 +511,26 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         return true;
     }
 
+    pbdev = s390_get_pci_device(dev_st, &devtype);
+    if (pbdev) {
+        switch (devtype) {
+        case PCI_DEVTYPE_VIRTIO:
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
+            iplb->pbt = S390_IPL_TYPE_PCI;
+            iplb->pci.fid = cpu_to_be32(pbdev->fid);
+            break;
+        default:
+            return false;
+        }
+
+        /* Per-device loadparm not yet supported for non-ccw IPL */
+        lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
+        s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
+        iplb->flags |= DIAG308_FLAGS_LP_VALID;
+
+        return true;
+    }
+
     return false;
 }
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3166b91c461..4de7b587e8a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -250,8 +250,7 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
     return NULL;
 }
 
-static S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
-                                                  PCIDevice *pci_dev)
+S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s, PCIDevice *pci_dev)
 {
     S390PCIBusDevice *pbdev;
 
-- 
2.53.0


