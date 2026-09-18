Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAE2C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7XJu-0000LH-Qb; Fri, 18 Sep 2026 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqI-0006qW-QF; Fri, 18 Sep 2026 05:25:14 -0400
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqB-0002IA-TH; Fri, 18 Sep 2026 05:25:13 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=dtMd+wjWdeZCTRTx7A2HQTJCsoRVybQIeSHKRP1uVA4=;
 b=tv9V44Ie7oCBg3cmTYZ93b6UWbe3KcInLIdDQyef6TdjOTeHETlYfo54pKFqpM3GO/QOEDODa
 K51R7PH4MT4tk6NIahioNxl4Zg/XESMISDMRoACaJmLs5IjAWI+2hKi8x6xyQWllmWVHdE6W0ym
 CFuOydApr8+zIw8E4A8ZD1A=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hmRkb0Dt3zcb44;
 Fri, 18 Sep 2026 17:13:43 +0800 (CST)
Received: from dggpemr200003.china.huawei.com (unknown [7.185.36.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 245F920333;
 Fri, 18 Sep 2026 17:24:58 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemr200003.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 17:24:57 +0800
From: Yize Wang <wangyize7@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <zhengchuan@huawei.com>,
 <jiangjiacheng@huawei.com>, <wangyize7@huawei.com>, <yize_w1110@163.com>
Subject: [PATCH 2/4] hw/intc/arm_gicv3_kvm: Add batch helper structures and
 functions
Date: Fri, 18 Sep 2026 17:18:54 +0800
Message-ID: <20260918092120.370805-3-wangyize7@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918092120.370805-1-wangyize7@huawei.com>
References: <20260918092120.370805-1-wangyize7@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr200003.china.huawei.com (7.185.36.25)
Received-SPF: pass client-ip=113.46.200.217; envelope-from=wangyize7@huawei.com;
 helo=canpmsgout02.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2026 08:02:13 -0400
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

Add GICv3BatchEntry typedef and three helper functions for batch register
access to KVM ARM64 VGICv3:
- kvm_arm_gic_batch_add: Accumulates register operations into a dynamic array
- kvm_arm_gic_batch_commit: Submits the batch array to kernel via a single ioctl
- kvm_arm_gic_batch_supported: Probes kernel support for the batch interface

These helpers will be used by kvm_arm_gicv3_get and kvm_arm_gicv3_put in subsequent
patches to enable efficient batch register access.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yize Wang <wangyize7@huawei.com>
---
 hw/intc/arm_gicv3_kvm.c | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 22fcac1668..ea6c8462c7 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -118,6 +118,101 @@ static inline void kvm_gic_line_level_access(GICv3State *s, int irq, int cpu,
                       val, write, &error_abort);
 }
 
+typedef struct {
+    uint32_t group;
+    uint64_t attr;
+    uint32_t *val;
+} GICv3BatchEntry;
+
+/* Accumulates register operations into a dynamic array. */
+static void kvm_arm_gic_batch_add(GICv3BatchEntry **entries, int *n,
+                                  int *capacity, uint32_t group,
+                                  uint64_t attr, uint32_t *val)
+{
+    if (*n >= *capacity) {
+        *capacity = MAX(*capacity * 2, 256);
+        *entries = g_renew(GICv3BatchEntry, *entries, *capacity);
+    }
+    (*entries)[*n].group = group;
+    (*entries)[*n].attr = attr;
+    /* Store the pointer, not the value, to avoid copying data now. */
+    (*entries)[*n].val = val;
+    (*n)++;
+}
+
+/*
+ * Submit the batched GIC register operations to the kernel via a single ioctl.
+ *
+ * Workflow:
+ * 1. Allocate a kernel-compatible structure array
+ *    (kvm_dev_arm_vgic_batch_entry).
+ * 2. Convert QEMU's internal format to the kernel's expected format.
+ *    - For WRITE: Copy the actual values from QEMU's buffers into the
+ *      kernel struct.
+ *    - For READ:  Only set the register IDs; the kernel will fill in
+ *      the values.
+ * 3. Perform a single ioctl() to send/receive all data at once.
+ * 4. For READ: Copy the values returned by the kernel back into QEMU's
+ *    buffers.
+ */
+static void kvm_arm_gic_batch_commit(int dev_fd, GICv3BatchEntry *entries,
+                                     int n, bool write)
+{
+    struct kvm_dev_arm_vgic_batch_entry *batch;
+    struct kvm_device_attr attr;
+    int i, ret;
+
+    if (!n) {
+        return;
+    }
+
+    batch = g_new0(struct kvm_dev_arm_vgic_batch_entry, n);
+    for (i = 0; i < n; i++) {
+        batch[i].group = entries[i].group;
+        batch[i].attr = entries[i].attr;
+        if (write) {
+            batch[i].val = *entries[i].val;
+        }
+    }
+
+    attr.group = KVM_DEV_ARM_VGIC_GRP_BATCH_REGS;
+    attr.addr = (uint64_t)batch;
+    attr.attr = n;
+
+    if (write) {
+        ret = kvm_device_ioctl(dev_fd, KVM_SET_DEVICE_ATTR, &attr);
+    } else {
+        ret = kvm_device_ioctl(dev_fd, KVM_GET_DEVICE_ATTR, &attr);
+    }
+
+    if (ret < 0) {
+        error_report("KVM_%s_DEVICE_ATTR failed on batch regs: %s",
+                     write ? "SET" : "GET", strerror(-ret));
+        abort();
+    }
+
+    if (!write) {
+        for (i = 0; i < n; i++) {
+            *entries[i].val = batch[i].val;
+        }
+    }
+
+    g_free(batch);
+}
+
+/*
+ * Check if the kernel supports GIC batch register operations.
+ * Returns: true if the kernel supports the BATCH_REGS group,
+ * false otherwise.
+ */
+static bool kvm_arm_gic_batch_supported(int dev_fd)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_ARM_VGIC_GRP_BATCH_REGS,
+    };
+    return kvm_device_ioctl(dev_fd, KVM_HAS_DEVICE_ATTR, &attr) == 0;
+}
+
 /* Loop through each distributor IRQ related register; since bits
  * corresponding to SPIs and PPIs are RAZ/WI when affinity routing
  * is enabled, we skip those.
-- 
2.43.0


