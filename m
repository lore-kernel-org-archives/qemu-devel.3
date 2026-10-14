Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867BCCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyWV-0007Ev-Dj; Wed, 14 Oct 2026 08:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu71-0006QH-RX; Wed, 14 Oct 2026 04:13:24 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu6z-00012B-Sp; Wed, 14 Oct 2026 04:13:23 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P8v1ppXz4yjjB;
 Wed, 14 Oct 2026 16:13:19 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8DGoM005325;
 Wed, 14 Oct 2026 16:13:16 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140813.69E8DGoM005325@mse-fl2.zte.com.cn>
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 69E80O6W079479;
 Wed, 14 Oct 2026 16:00:24 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:26 +0800
X-Zmail-TransId: 3e816acf369a024-0e2ef
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
Subject: [RFC PATCH 14/14] hw/riscv/riscv-iommu-accel: Add accel property for
 iommu device
Date: Wed, 14 Oct 2026 16:00:05 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8DGoM005325
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:13:19 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF399F.000/4j4P8v1ppXz4yjjB
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

From: Wu Fei <wu.fei9@sanechips.com.cn>

Add an "accel" property to enable the RISC-V IOMMU accelerator
mode, following the ARM SMMUv3 accel device.

Migration is not supported in accel mode, as the host-side vIOMMU
and HWPT state cannot be migrated; a migration blocker is
registered.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h |  1 +
 2 files changed, 58 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 2a370ec474..7f47462306 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -23,6 +23,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
@@ -2723,12 +2724,63 @@ static void riscv_iommu_instance_finalize(Object *obj)
     g_hash_table_unref(s->iot_cache);
 }
 
+static bool riscv_iommu_validate_property(RISCVIOMMUState *s, Error **errp)
+{
+#ifndef CONFIG_RISCV_IOMMU_ACCEL
+    if (s->accel) {
+        error_setg(errp, "accel=on support not compiled in");
+        return false;
+    }
+#endif
+
+    if (!s->accel) {
+        return true;
+    }
+
+    if (!s->enable_s_stage) {
+        error_setg(errp,
+                   "Only stage-1 is supported for RISC-V IOMMU with accel=on");
+        return false;
+    }
+
+    return true;
+}
+
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    if (!riscv_iommu_validate_property(s, errp)) {
+        return;
+    }
+
     if (s->accel) {
         riscv_iommu_accel_init(s);
+        /*
+        * With accel=on, MSI remapping is done by the host IOMMU. Disable
+        * the emulated MSI capability so the guest's MSI message address
+        * is a plain GPA translated on the host side; the guest then sees
+        * no MSI capability bits and uses the base device context format.
+        */
+        s->enable_msi = false;
+        /* G-stage is managed by the host (VFIO) in accel mode */
+        s->enable_g_stage = false;
+        /*
+         * No ATS.INVAL path exists for the vIOMMU in accel mode now,
+         * vfio-pci devices are not notifiers of the emulated IOMMU and
+         * guest ATS.INVAL commands are not forwarded to the host, so hide
+         * ATS/PRI capabilities.
+         */
+        s->enable_ats = false;
+        /*
+         * Per-PASID contexts and PDT inval for vIOMMU are unimplemented,
+         * hide the process-directory capabilities.
+         */
+        s->cap &= ~(RISCV_IOMMU_CAP_PD8 | RISCV_IOMMU_CAP_PD17 |
+                    RISCV_IOMMU_CAP_PD20);
+        error_setg(&s->migration_blocker, "Migration not supported with "
+                   "RISC-V IOMMU accel=on");
+        migrate_add_blocker(&s->migration_blocker, errp);
     }
 
     /* Report QEMU target physical address space limits. */
@@ -2852,6 +2904,10 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    if (s->migration_blocker) {
+        migrate_del_blocker(&s->migration_blocker);
+    }
+
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
         g_hash_table_unref(s->hpm_event_ctr_map);
         timer_free(s->hpm_timer);
@@ -2909,6 +2965,7 @@ static const Property riscv_iommu_properties[] = {
         TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_UINT8("hpm-counters", RISCVIOMMUState, hpm_cntrs,
                       RISCV_IOMMU_IOCOUNT_NUM),
+    DEFINE_PROP_BOOL("accel", RISCVIOMMUState, accel, FALSE),
 };
 
 static void riscv_iommu_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index c21bccb131..f782a41b9a 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -114,6 +114,7 @@ struct RISCVIOMMUState {
     /* nested iommu support */
     bool accel;
     struct RISCVIOMMUAccelState *accel_state;
+    Error *migration_blocker;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.53.0


