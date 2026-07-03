Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A3BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYqE-0004Uu-ES; Fri, 03 Jul 2026 04:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYq9-0004UH-0U
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:37 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYq7-0001iw-3E
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783065695; x=1814601695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O89BeKg4AxgXXbHx+MKTu9C8fTGOCKAkuWa6bKKKYD8=;
 b=WFwPkMmZhq2Hdi4kUI6KCnD4U7H0htcoCxBBno1c3e12m6jHC2LXbZjT
 2ZHK8cJFJpZCZbrb5A0DqrdM5LhSrstFwA4uWjHHdWfWFIogyvHZ40Ym6
 qR3lfZPp+SYRvJNVa6CUQMvujE4V33Mkine4EWbouXxxhNtUsjtj7qcSe
 RcFCioz+GTOoZH2BD4vwqyleSiTZQNPw5FRFTxmkyVRdOjPkWkDl/hiZo
 J8kvfNbe2GhQRy4i+BSYtqUbeItZQ0+ntsVsEaPzHO3QHDVeq4prVku2x
 rMUPat8iGqCJMlXM9IvyvE0T5BcQOYfgAYSGtx4sTr8g04jA8HQCSM6zn g==;
X-CSE-ConnectionGUID: 92fP59o/S/aer1x0yX5grQ==
X-CSE-MsgGUID: 8/ZkIrB5TFC3eaIyjgiQ6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94464667"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94464667"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:32 -0700
X-CSE-ConnectionGUID: 2n7stN4MQrGC6K/3FMe+2A==
X-CSE-MsgGUID: wG2WigkwTuuBk0RrkB+f5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="277379589"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fengyuan Yu <15fengyuan@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, junjie.cao@intel.com
Subject: [PATCH v1 2/3] tests/qtest/libqos: add Intel IOMMU invalidation
 helpers
Date: Fri,  3 Jul 2026 15:21:57 +0800
Message-ID: <20260703072200.463082-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703072200.463082-1-junjie.cao@intel.com>
References: <20260703072200.463082-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add the building blocks a queued-invalidation test needs on top of the
existing translation helpers:

  - qvtd_leaf_pte_addr() / qvtd_make_leaf_pte() let a test locate and
    rewrite the leaf PTE built by qvtd_setup_translation_tables() without
    re-deriving the page-table index or leaf attributes by hand.  The
    attributes reuse qvtd_get_fl_pte_attrs()/qvtd_get_pte_attrs() so the
    first- and second-level leaf formats stay defined in one place.

  - qvtd_submit_iotlb_global_inv() / _domain_inv() / _page_inv() write an
    IOTLB Invalidation Descriptor (global / domain-selective /
    page-selective) into the Invalidation Queue and advance IQT_REG.

  - qvtd_submit_inv_wait_and_poll() submits an Invalidation Wait
    Descriptor with Status Write and polls the status word with a bounded
    retry loop, asserting on timeout.

No caller yet; used by the IOTLB invalidation test that follows.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/libqos/qos-intel-iommu.c | 108 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-intel-iommu.h |  51 +++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qos-intel-iommu.c
index 4095ac0917..c793ec899c 100644
--- a/tests/qtest/libqos/qos-intel-iommu.c
+++ b/tests/qtest/libqos/qos-intel-iommu.c
@@ -15,6 +15,10 @@
 #include "qos-iommu-testdev.h"
 #include "qos-intel-iommu.h"
 
+/* Bounded poll for the invalidation-wait Status Write. */
+#define QVTD_INV_WAIT_POLL_MAX_ITERS    1000
+#define QVTD_INV_WAIT_POLL_INTERVAL_US  1000
+
 #define QVTD_AW_48BIT_ENCODING    2
 
 uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx)
@@ -232,6 +236,30 @@ static uint64_t qvtd_get_fl_pte_attrs(bool is_leaf)
     return attrs;
 }
 
+uint64_t qvtd_leaf_pte_addr(uint64_t iova)
+{
+    return qvtd_get_table_addr(QVTD_PT_L1_BASE, 1, iova);
+}
+
+uint64_t qvtd_make_leaf_pte(uint64_t pa, QVTDTransMode mode)
+{
+    uint64_t attrs;
+
+    /*
+     * Reuse the same leaf attributes qvtd_setup_translation_tables() writes,
+     * so a rewritten PTE stays consistent with the initial mapping.  US=1 in
+     * the first-level format is required because the PASID entry runs with
+     * SRE=0, which makes every DMA appear as a user-mode access
+     * (VT-d 3.6.2 / 9.9).
+     */
+    if (mode == QVTD_TM_SCALABLE_FLT) {
+        attrs = qvtd_get_fl_pte_attrs(true);
+    } else {
+        attrs = qvtd_get_pte_attrs();
+    }
+    return (pa & VTD_PAGE_MASK_4K) | attrs;
+}
+
 void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
                                    QVTDTransMode mode)
 {
@@ -529,3 +557,83 @@ QPCIDevice *qvtd_setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
 
     return dev;
 }
+
+/*
+ * Write a 128-bit invalidation descriptor at the current tail and advance
+ * IQT_REG.  Internal helper for the IOTLB / wait variants below.
+ */
+static uint32_t qvtd_submit_inv_desc(QTestState *qts, uint64_t iommu_base,
+                                     uint64_t desc_lo, uint64_t desc_hi,
+                                     uint32_t tail)
+{
+    uint64_t desc_addr = QVTD_IQ_BASE + (uint64_t)tail * QVTD_IQ_DESC_SIZE;
+
+    qtest_writeq(qts, desc_addr, desc_lo);
+    qtest_writeq(qts, desc_addr + 8, desc_hi);
+    tail++;
+
+    qtest_writeq(qts, iommu_base + DMAR_IQT_REG,
+                 (uint64_t)tail << QVTD_IQT_SHIFT);
+    return tail;
+}
+
+uint32_t qvtd_submit_inv_wait_and_poll(QTestState *qts, uint64_t iommu_base,
+                                       uint32_t tail)
+{
+    uint64_t lo, hi;
+    uint32_t status = 0;
+    int i;
+
+    qtest_writel(qts, QVTD_INV_WAIT_ADDR, 0);
+
+    lo = VTD_INV_DESC_WAIT | VTD_INV_DESC_WAIT_SW |
+         ((uint64_t)QVTD_INV_WAIT_DATA << VTD_INV_DESC_WAIT_DATA_SHIFT);
+    hi = QVTD_INV_WAIT_ADDR;
+
+    tail = qvtd_submit_inv_desc(qts, iommu_base, lo, hi, tail);
+
+    for (i = 0; i < QVTD_INV_WAIT_POLL_MAX_ITERS; i++) {
+        status = qtest_readl(qts, QVTD_INV_WAIT_ADDR);
+        if (status == QVTD_INV_WAIT_DATA) {
+            return tail;
+        }
+        g_usleep(QVTD_INV_WAIT_POLL_INTERVAL_US);
+    }
+
+    g_assert_cmphex(status, ==, QVTD_INV_WAIT_DATA);
+    return tail;
+}
+
+uint32_t qvtd_submit_iotlb_global_inv(QTestState *qts, uint64_t iommu_base,
+                                      uint32_t tail)
+{
+    uint64_t lo = VTD_INV_DESC_IOTLB | VTD_INV_DESC_IOTLB_GLOBAL;
+
+    return qvtd_submit_inv_desc(qts, iommu_base, lo, 0, tail);
+}
+
+uint32_t qvtd_submit_iotlb_domain_inv(QTestState *qts, uint64_t iommu_base,
+                                      uint16_t domain_id, uint32_t tail)
+{
+    uint64_t lo = VTD_INV_DESC_IOTLB | VTD_INV_DESC_IOTLB_DOMAIN |
+                  ((uint64_t)domain_id << 16);
+
+    return qvtd_submit_inv_desc(qts, iommu_base, lo, 0, tail);
+}
+
+uint32_t qvtd_submit_iotlb_page_inv(QTestState *qts, uint64_t iommu_base,
+                                    uint16_t domain_id, uint64_t addr,
+                                    uint8_t am, uint32_t tail)
+{
+    uint64_t lo = VTD_INV_DESC_IOTLB | VTD_INV_DESC_IOTLB_PAGE |
+                  ((uint64_t)domain_id << 16);
+    /*
+     * AM selects the invalidation range per VT-d 6.5.2.4:
+     *   am=0  → 4 KB,  am=9 → 2 MB,  am=18 → 1 GB.
+     * IH (hi[6]) is left clear, requesting full invalidation
+     * including non-leaf paging-structure caches.
+     */
+    uint64_t hi = (addr & ~0xfffULL) | (am & 0x3fULL);
+
+    return qvtd_submit_inv_desc(qts, iommu_base, lo, hi, tail);
+}
diff --git a/tests/qtest/libqos/qos-intel-iommu.h b/tests/qtest/libqos/qos-intel-iommu.h
index dd6f920464..3a97d14786 100644
--- a/tests/qtest/libqos/qos-intel-iommu.h
+++ b/tests/qtest/libqos/qos-intel-iommu.h
@@ -40,6 +40,16 @@
  */
 #define QVTD_IQ_BASE              (QVTD_MEM_BASE + 0x00020000)
 #define QVTD_IQ_QS                0    /* QS=0 → 256 entries */
+#define QVTD_IQ_DESC_SIZE         16   /* 128-bit descriptor (iq_dw=0) */
+#define QVTD_IQT_SHIFT            4    /* IQT_REG[18:4] is the tail index */
+
+/*
+ * Invalidation Wait Descriptor with Status Write (VT-d 6.5.2.8).
+ * The IOMMU writes QVTD_INV_WAIT_DATA to QVTD_INV_WAIT_ADDR after all
+ * preceding invalidation descriptors complete.
+ */
+#define QVTD_INV_WAIT_ADDR        (QVTD_MEM_BASE + 0x00040000)
+#define QVTD_INV_WAIT_DATA        0x1u
 
 /*
  * Fault Event MSI configuration.
@@ -205,4 +215,45 @@ bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode);
 QPCIDevice *qvtd_setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
                                         QPCIBar *bar);
 
+/*
+ * qvtd_leaf_pte_addr - Address of the leaf (L1) PTE for @iova, assuming
+ *                      the hierarchy was built by
+ *                      qvtd_setup_translation_tables() with 4 KB leaves.
+ */
+uint64_t qvtd_leaf_pte_addr(uint64_t iova);
+
+/*
+ * qvtd_make_leaf_pte - Build a leaf PTE value mapping @pa, for the
+ *                      4-level / 4 KB-leaf layout used by
+ *                      qvtd_setup_translation_tables().
+ *                      Selects FLT or SLT/legacy attributes from @mode.
+ */
+uint64_t qvtd_make_leaf_pte(uint64_t pa, QVTDTransMode mode);
+
+/*
+ * qvtd_submit_inv_wait_and_poll - Submit an Invalidation Wait Descriptor
+ *                                 with Status Write and poll until the
+ *                                 IOMMU writes the expected status data.
+ *
+ * Asserts on timeout.  Returns the new tail index.
+ */
+uint32_t qvtd_submit_inv_wait_and_poll(QTestState *qts, uint64_t iommu_base,
+                                       uint32_t tail);
+
+/*
+ * qvtd_submit_iotlb_global_inv  - global IOTLB invalidation.
+ * qvtd_submit_iotlb_domain_inv  - domain-selective IOTLB invalidation.
+ * qvtd_submit_iotlb_page_inv    - page-selective IOTLB invalidation;
+ *                                 @addr must be 4 KB aligned.  @am
+ *                                 selects the address mask per VT-d
+ *                                 6.5.2.4 (am=0 → single 4 KB page).
+ */
+uint32_t qvtd_submit_iotlb_global_inv(QTestState *qts, uint64_t iommu_base,
+                                      uint32_t tail);
+uint32_t qvtd_submit_iotlb_domain_inv(QTestState *qts, uint64_t iommu_base,
+                                      uint16_t domain_id, uint32_t tail);
+uint32_t qvtd_submit_iotlb_page_inv(QTestState *qts, uint64_t iommu_base,
+                                    uint16_t domain_id, uint64_t addr,
+                                    uint8_t am, uint32_t tail);
+
 #endif /* QTEST_LIBQOS_INTEL_IOMMU_H */
-- 
2.43.0


