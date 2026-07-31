Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C38C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFo-0002lE-0Z; Fri, 31 Jul 2026 01:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM7-0005u2-Po; Thu, 30 Jul 2026 23:56:19 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM1-0002Il-Td; Thu, 30 Jul 2026 23:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470170; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=g0QlwMTJgF93LRCAL5WkuhLzxPKgvA6nP6b0CC6j0SM=;
 b=VG9m03NaXvG3afWPmzSYG4tHPtVgWKF1GOFOatLsRY60jNfNu7bT70ivOu1F5lSttg/BsVgHzSrHF5pBicdPoIcpm6UQMPTqt2/0CLZmpu5IXkjZwo6tX9DU7WXotqVYoG7ct9HXtivcdkUontHaW3GkLcxemfcppzz0Rx+mOa8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R451e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwUk_1785469857; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwUk_1785469857 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:58 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 11/17] hw/virtio: force modern virtio for a CoVE guest
Date: Fri, 31 Jul 2026 11:50:05 +0800
Message-Id: <20260731035011.4178103-12-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:34 -0400
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

Devices have no direct access to the memory of a CoVE guest, so DMA has
to be bounced through buffers that the guest shares explicitly.  Offer
VIRTIO_F_ACCESS_PLATFORM unconditionally, together with
VIRTIO_F_VERSION_1 which Linux requires whenever ACCESS_PLATFORM is
offered.

Such a device therefore always negotiates in modern mode, so the legacy
IOMMU_PLATFORM check in virtio-pci does not apply to it either.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/virtio/virtio-bus.c | 12 ++++++++++++
 hw/virtio/virtio-pci.c |  9 ++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 9b545acda3..2e2917236f 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -29,6 +29,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio.h"
 #include "system/address-spaces.h"
+#include "hw/riscv/cove.h"
 
 /* #define DEBUG_VIRTIO_BUS */
 
@@ -75,6 +76,17 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
         return;
     }
 
+    /*
+     * Devices cannot access the memory of a CoVE guest directly, so all DMA
+     * has to be bounced through buffers the guest shares explicitly: offer
+     * VIRTIO_F_ACCESS_PLATFORM unconditionally. VIRTIO_F_VERSION_1 has to be
+     * offered as well because Linux refuses ACCESS_PLATFORM without it.
+     */
+    if (riscv_cove_vm_active()) {
+        vdev->host_features |= 1ULL << VIRTIO_F_ACCESS_PLATFORM;
+        vdev->host_features |= 1ULL << VIRTIO_F_VERSION_1;
+    }
+
     if (klass->device_plugged != NULL) {
         klass->device_plugged(qbus->parent, &local_err);
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6f5db5fc42..b257d4a09f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -34,6 +34,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/core/loader.h"
+#include "hw/riscv/cove.h"
 #include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "hw/virtio/virtio-pci.h"
@@ -2048,7 +2049,13 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
                 return;
             }
         }
-        if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+        /*
+         * A CoVE guest always negotiates in modern mode: ACCESS_PLATFORM,
+         * which shares its feature bit with IOMMU_PLATFORM, is forced
+         * together with VERSION_1, so this check does not apply.
+         */
+        if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) &&
+            !riscv_cove_vm_active()) {
             error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
                        " neither legacy nor transitional device");
             return;
-- 
2.34.1


