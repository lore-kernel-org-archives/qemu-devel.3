Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0007EC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYqK-0004Xa-2F; Fri, 03 Jul 2026 04:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYqE-0004Vn-Qb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:46 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYqC-0001iw-5M
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783065700; x=1814601700;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UUmDZnLxHb/740hRe2mHgGyprZ7ToOyz1L+j8UIFURc=;
 b=nmknWGk0YD9m0BFgOEGnUf848BaU+kpJyBViDgbVfjqdUGehJ7xjWMsK
 Ujkg/H2aCE9/Xd0qladBSrqVG0IylQQrtQGI9M21yQfWhZ0AS3uIxGU7M
 IDEnhIiWG7sOXoaNZzHObzM7f+rWY8MRqJ6brA8C+vaMT3eGko7sb/V0H
 IiVbwuvcyL039oxb5T7jefkTR8tnjXmflNYsBNxacUS0huz3a0sWAInA5
 xlKz9Gzf99LihjKWnzElHfnoo16ytm1jfsiEwJj8W/OdlZUcmL1ZzgL9L
 RZdXBQV62VfCi7sZFwavOZaN6GstDaaXwRbiPqgLzn4Urs5+F7Cl43yVg Q==;
X-CSE-ConnectionGUID: +nGwWnMXQZOW14lE8JMlnA==
X-CSE-MsgGUID: MRhNTzvMRX2Honxt9tnE+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94464689"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94464689"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:39 -0700
X-CSE-ConnectionGUID: cVdB8W08T9mWFN/p0ip/6Q==
X-CSE-MsgGUID: ZiBgp63WQ6CE1oBZpZoqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="277379660"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:36 -0700
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
Subject: [PATCH v1 3/3] tests/qtest: add IOTLB invalidation test for Intel
 IOMMU
Date: Fri,  3 Jul 2026 15:21:58 +0800
Message-ID: <20260703072200.463082-4-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703072200.463082-1-junjie.cao@intel.com>
References: <20260703072200.463082-1-junjie.cao@intel.com>
MIME-Version: 1.0
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

Nothing in tree exercises IOTLB invalidation for any emulated vIOMMU:
the existing iommu-testdev tests only check one-shot translation, so a
regression that failed to flush a stale IOTLB entry would go unnoticed.

Add a test that drives the queued-invalidation path end to end
(vtd_process_inv_desc -> vtd_process_iotlb_desc ->
vtd_iotlb_{global,domain,page}_invalidate).  For each
{legacy, scalable-slt, scalable-flt} x {global, domain, page}
combination it:

  1. maps IOVA -> PA_A and DMAs, populating the IOTLB;
  2. rewrites the leaf PTE to PA_B *without* invalidating and DMAs
     again, asserting the stale entry is still served (MISMATCH);
  3. submits the IOTLB invalidation plus a wait descriptor, then DMAs
     and asserts the fresh page walk now reaches PA_B.

Step 2 makes the flush observable: it fails loudly if the IOTLB
is not actually caching the first translation.

For scalable first-level (flt), QEMU keeps first- and second-level
mappings in a single IOTLB that the legacy VTD_INV_DESC_IOTLB descriptor
flushes for every level, so the test uses that descriptor across all
modes.  PASID-selective invalidation (VTD_INV_DESC_PIOTLB, vtd_piotlb_*)
is a separate path and is left for a follow-up.

It also adds three page-selective cases that cache a second page and check
its fate after invalidating the first: for second-level (legacy, scalable-slt)
the second page survives, while for first-level (scalable-flt) QEMU flushes all
first-stage entries of the domain, so it does not.  This distinguishes a
page-selective flush from a domain-wide or global one.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 MAINTAINERS                        |   1 +
 tests/qtest/iommu-intel-inv-test.c | 346 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   2 +-
 3 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/iommu-intel-inv-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded..906de6e39f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4103,6 +4103,7 @@ F: include/hw/i386/intel_iommu.h
 F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
 F: tests/qtest/iommu-intel-test.c
+F: tests/qtest/iommu-intel-inv-test.c
 
 AMD-Vi Emulation
 M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
diff --git a/tests/qtest/iommu-intel-inv-test.c b/tests/qtest/iommu-intel-inv-test.c
new file mode 100644
index 0000000000..1467eef647
--- /dev/null
+++ b/tests/qtest/iommu-intel-inv-test.c
@@ -0,0 +1,346 @@
+/*
+ * QTest for Intel IOMMU (VT-d) IOTLB invalidation via Invalidation Queue
+ *
+ * Validates that IOTLB invalidation descriptors submitted through the
+ * queued invalidation interface correctly flush cached translations,
+ * forcing the IOMMU to re-walk page tables on subsequent DMA.
+ *
+ * Copyright (c) 2026 Intel Corporation.
+ *
+ * Author: Junjie Cao <junjie.cao@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+#include "hw/i386/intel_iommu_internal.h"
+#include "hw/misc/iommu-testdev.h"
+#include "libqos/qos-intel-iommu.h"
+#include "libqos/qos-iommu-testdev.h"
+
+#define DMA_LEN                4
+
+/*
+ * Second DMA target page, chosen to fall well outside any address used by
+ * qos-intel-iommu's fixed structure layout.
+ */
+#define QVTD_PT_VAL_B          (QVTD_MEM_BASE + 0x00200000)
+
+/*
+ * A second IOVA/target page for the page-selectivity test.  QVTD_IOVA_2 is
+ * QVTD_IOVA + 4K: it shares the L4/L3/L2 walk built by
+ * qvtd_build_translation() and differs only in the leaf (L1) slot, so mapping
+ * it costs one extra leaf PTE.  QVTD_PT_VAL_2 is its distinct target page.
+ */
+#define QVTD_IOVA_2            (QVTD_IOVA + 0x1000)
+#define QVTD_PT_VAL_2          (QVTD_MEM_BASE + 0x00300000)
+
+typedef enum {
+    IOTLB_INV_GLOBAL,
+    IOTLB_INV_DOMAIN,
+    IOTLB_INV_PAGE,
+} IOTLBInvGranularity;
+
+/*
+ * Core invalidation test, parameterized by translation mode and
+ * invalidation granularity.
+ *
+ * The iommu-testdev device performs DMA writes via the IOMMU (using the
+ * IOVA) and verifies by reading back from the expected GPA directly.  If
+ * the IOTLB is stale, the DMA write lands at the old PA while readback
+ * uses the GPA we supply, causing a mismatch (ITD_DMA_ERR_MISMATCH).
+ *
+ * Test sequence:
+ *   1. Setup translation: IOVA -> PA_A
+ *   2. DMA(gpa=PA_A) -> success (IOTLB populates cache)
+ *   3. Modify PTE: IOVA -> PA_B (no invalidation)
+ *   4. DMA(gpa=PA_B) -> MISMATCH (stale IOTLB directs write to PA_A)
+ *   5. Issue IOTLB invalidation + wait
+ *   6. DMA(gpa=PA_B) -> success (cache flushed, fresh page walk)
+ *
+ * Phase 4 depends on QEMU's IOTLB caching the Phase 1 translation; if a
+ * future change makes IOTLB caching lazy this assertion would no longer
+ * exercise the stale-cache path.
+ */
+static void run_iotlb_inv_test(QVTDTransMode mode, IOTLBInvGranularity gran)
+{
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint32_t tail = 0;
+    uint32_t result;
+    uint64_t pa_a, pa_b;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    qts = qtest_initf("-machine q35 -smp 1 -m 512 -net none "
+                      "%s -device iommu-testdev",
+                      qvtd_iommu_args(mode));
+
+    if (!qvtd_check_caps(qts, mode)) {
+        qtest_quit(qts);
+        return;
+    }
+
+    dev = qvtd_setup_qtest_pci_device(qts, &pcibus, &bar);
+
+    /*
+     * The IOMMU translates an IOVA to a page base, then the page offset
+     * from the IOVA is added.  So GPA = page_base + (IOVA & 0xfff).
+     */
+    pa_a = (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (QVTD_IOVA & 0xfff);
+    pa_b = (QVTD_PT_VAL_B & VTD_PAGE_MASK_4K) + (QVTD_IOVA & 0xfff);
+
+    /* --- Phase 1: Setup and initial DMA (populates IOTLB) --- */
+    qvtd_build_translation(qts, mode, dev->devfn);
+    qvtd_program_regs(qts, Q35_HOST_BRIDGE_IOMMU_ADDR, mode);
+
+    qtest_memset(qts, pa_a, 0, DMA_LEN);
+    qtest_memset(qts, pa_b, 0, DMA_LEN);
+
+    result = qos_iommu_testdev_trigger_dma(dev, bar, QVTD_IOVA, pa_a,
+                                           DMA_LEN, 0);
+    g_assert_cmpuint(result, ==, 0);
+
+    /* --- Phase 2: Modify PTE without invalidation -> stale IOTLB --- */
+    qtest_writeq(qts, qvtd_leaf_pte_addr(QVTD_IOVA),
+                 qvtd_make_leaf_pte(QVTD_PT_VAL_B & VTD_PAGE_MASK_4K, mode));
+    qtest_memset(qts, pa_a, 0, DMA_LEN);
+    qtest_memset(qts, pa_b, 0, DMA_LEN);
+
+    result = qos_iommu_testdev_trigger_dma(dev, bar, QVTD_IOVA, pa_b,
+                                           DMA_LEN, 0);
+    g_assert_cmpuint(result, ==, ITD_DMA_ERR_MISMATCH);
+
+    /* --- Phase 3: Invalidate IOTLB -> fresh page walk succeeds --- */
+    switch (gran) {
+    case IOTLB_INV_GLOBAL:
+        tail = qvtd_submit_iotlb_global_inv(qts, Q35_HOST_BRIDGE_IOMMU_ADDR,
+                                            tail);
+        break;
+    case IOTLB_INV_DOMAIN:
+        tail = qvtd_submit_iotlb_domain_inv(qts, Q35_HOST_BRIDGE_IOMMU_ADDR,
+                                            QVTD_DOMAIN_ID, tail);
+        break;
+    case IOTLB_INV_PAGE:
+        tail = qvtd_submit_iotlb_page_inv(qts, Q35_HOST_BRIDGE_IOMMU_ADDR,
+                                          QVTD_DOMAIN_ID, QVTD_IOVA, 0,
+                                          tail);
+        break;
+    }
+    tail = qvtd_submit_inv_wait_and_poll(qts, Q35_HOST_BRIDGE_IOMMU_ADDR,
+                                         tail);
+
+    qtest_memset(qts, pa_a, 0, DMA_LEN);
+    qtest_memset(qts, pa_b, 0, DMA_LEN);
+
+    result = qos_iommu_testdev_trigger_dma(dev, bar, QVTD_IOVA, pa_b,
+                                           DMA_LEN, 0);
+    g_assert_cmpuint(result, ==, 0);
+
+    g_free(dev);
+    qpci_free_pc(pcibus);
+    qtest_quit(qts);
+}
+
+/*
+ * Page-selectivity test: verify that a page-selective invalidation flushes
+ * the named page and touches other cached pages only as far as the model
+ * intends.  run_iotlb_inv_test() caches a single entry, so it cannot tell a
+ * page-selective flush from a domain-wide or global one; this test caches two
+ * pages in the same domain and checks the second one's fate.
+ *
+ * The expected fate of the second page depends on the translation level:
+ *
+ *   - second-level (legacy / scalable-slt): a page-selective descriptor
+ *     evicts only the matching gfn, so IOVA_2 survives.
+ *   - first-level (scalable-flt): QEMU invalidates all first-stage entries of
+ *     the domain on a page-selective descriptor (vtd_hash_remove_by_page()
+ *     returns true for any pgtt==FST entry of the domain, matching the VT-d
+ *     spec for first-stage IOTLB invalidation), so IOVA_2 is flushed too.
+ *
+ * Method: map IOVA -> PA_A and IOVA_2 -> PA_A_2, DMA both to populate two
+ * IOTLB entries, rewrite both leaf PTEs to PA_B* without invalidating, then
+ * page-invalidate IOVA only.  IOVA always re-walks to PA_B.  For IOVA_2 we
+ * verify the DMA against its *original* page PA_A_2: if the entry survived,
+ * the stale cache still serves PA_A_2 (success); if it was flushed, the fresh
+ * walk reaches PA_B_2 and mismatches PA_A_2.  So a survived entry gives
+ * success and a flushed entry gives MISMATCH, and we assert whichever the
+ * mode requires -- catching both an over-matching second-level flush and a
+ * regression that stopped flushing first-stage entries domain-wide.
+ */
+static void run_page_selectivity_test(QVTDTransMode mode)
+{
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint32_t tail = 0;
+    uint32_t result;
+    uint64_t pa_a, pa_b, pa_a2, pa_b2;
+    bool fl_domain_wide = (mode == QVTD_TM_SCALABLE_FLT);
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    qts = qtest_initf("-machine q35 -smp 1 -m 512 -net none "
+                      "%s -device iommu-testdev",
+                      qvtd_iommu_args(mode));
+
+    if (!qvtd_check_caps(qts, mode)) {
+        qtest_quit(qts);
+        return;
+    }
+
+    dev = qvtd_setup_qtest_pci_device(qts, &pcibus, &bar);
+
+    pa_a = (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (QVTD_IOVA & 0xfff);
+    pa_b = (QVTD_PT_VAL_B & VTD_PAGE_MASK_4K) + (QVTD_IOVA & 0xfff);
+    pa_a2 = (QVTD_PT_VAL_2 & VTD_PAGE_MASK_4K) + (QVTD_IOVA_2 & 0xfff);
+    pa_b2 = (QVTD_PT_VAL_B & VTD_PAGE_MASK_4K) + (QVTD_IOVA_2 & 0xfff);
+
+    /* --- Setup: IOVA -> PA_A (built by helper) and IOVA_2 -> PA_A_2 --- */
+    qvtd_build_translation(qts, mode, dev->devfn);
+    qtest_writeq(qts, qvtd_leaf_pte_addr(QVTD_IOVA_2),
+                 qvtd_make_leaf_pte(QVTD_PT_VAL_2 & VTD_PAGE_MASK_4K, mode));
+    qvtd_program_regs(qts, Q35_HOST_BRIDGE_IOMMU_ADDR, mode);
+
+    /* Populate both IOTLB entries. */
+    qtest_memset(qts, pa_a, 0, DMA_LEN);
+    qtest_memset(qts, pa_a2, 0, DMA_LEN);
+    result = qos_iommu_testdev_trigger_dma(dev, bar, QVTD_IOVA, pa_a,
+                                           DMA_LEN, 0);
+    g_assert_cmpuint(result, ==, 0);
+    result = qos_iommu_testdev_trigger_dma(dev, bar, QVTD_IOVA_2, pa_a2,
+                                           DMA_LEN, 0);
+    g_assert_cmpuint(result, ==, 0);
+
+    /* Rewrite both leaf PTEs to PA_B* without invalidating. */
+    qtest_writeq(qts, qvtd_leaf_pte_addr(QVTD_IOVA),
+                 qvtd_make_leaf_pte(QVTD_PT_VAL_B & VTD_PAGE_MASK_4K, mode));
+    qtest_writeq(qts, qvtd_leaf_pte_addr(QVTD_IOVA_2),
+                 qvtd_make_leaf_pte(QVTD_PT_VAL_B & VTD_PAGE_MASK_4K, mode));
+
+    /* Page-selective invalidation of IOVA only. */
+    tail = qvtd_submit_iotlb_page_inv(qts, Q35_HOST_BRIDGE_IOMMU_ADDR,
+                                      QVTD_DOMAIN_ID, QVTD_IOVA, 0, tail);
+    tail = qvtd_submit_inv_wait_and_poll(qts, Q35_HOST_BRIDGE_IOMMU_ADDR,
+                                         tail);
+
+    /* IOVA was flushed: fresh walk reaches PA_B. */
+    qtest_memset(qts, pa_a, 0, DMA_LEN);
+    qtest_memset(qts, pa_b, 0, DMA_LEN);
+    result = qos_iommu_testdev_trigger_dma(dev, bar, QVTD_IOVA, pa_b,
+                                           DMA_LEN, 0);
+    g_assert_cmpuint(result, ==, 0);
+
+    /*
+     * IOVA_2's fate, verified against its original page PA_A_2:
+     *   - second-level: entry survives, stale cache serves PA_A_2 -> success;
+     *   - first-level: entry was flushed domain-wide, fresh walk reaches
+     *     PA_B_2 -> MISMATCH against PA_A_2.
+     */
+    qtest_memset(qts, pa_a2, 0, DMA_LEN);
+    qtest_memset(qts, pa_b2, 0, DMA_LEN);
+    result = qos_iommu_testdev_trigger_dma(dev, bar, QVTD_IOVA_2, pa_a2,
+                                           DMA_LEN, 0);
+    if (fl_domain_wide) {
+        g_assert_cmpuint(result, ==, ITD_DMA_ERR_MISMATCH);
+    } else {
+        g_assert_cmpuint(result, ==, 0);
+    }
+
+    g_free(dev);
+    qpci_free_pc(pcibus);
+    qtest_quit(qts);
+}
+
+/*
+ * scalable-flt is covered here even though, per the VT-d spec, first-level
+ * mappings are invalidated with the PASID-based descriptor
+ * (VTD_INV_DESC_PIOTLB).  QEMU keeps first- and second-level mappings in a
+ * single IOTLB that the legacy VTD_INV_DESC_IOTLB descriptor flushes for
+ * every level, so this test drives that descriptor across all modes.
+ * PASID-selective (PIOTLB) invalidation is a separate path, left for a
+ * follow-up.
+ */
+static const struct {
+    const char *name;
+    QVTDTransMode mode;
+} trans_modes[] = {
+    { "legacy",        QVTD_TM_LEGACY_TRANS },
+    { "scalable-slt",  QVTD_TM_SCALABLE_SLT },
+    { "scalable-flt",  QVTD_TM_SCALABLE_FLT },
+};
+
+static const struct {
+    const char *name;
+    IOTLBInvGranularity gran;
+} granularities[] = {
+    { "global", IOTLB_INV_GLOBAL },
+    { "domain", IOTLB_INV_DOMAIN },
+    { "page",   IOTLB_INV_PAGE   },
+};
+
+typedef struct {
+    QVTDTransMode mode;
+    IOTLBInvGranularity gran;
+} TestCase;
+
+static void test_iotlb_inv(const void *opaque)
+{
+    const TestCase *tc = opaque;
+
+    run_iotlb_inv_test(tc->mode, tc->gran);
+}
+
+static void test_page_selectivity(const void *opaque)
+{
+    const QVTDTransMode *mode = opaque;
+
+    run_page_selectivity_test(*mode);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    for (size_t m = 0; m < ARRAY_SIZE(trans_modes); m++) {
+        for (size_t g = 0; g < ARRAY_SIZE(granularities); g++) {
+            TestCase *tc = g_new(TestCase, 1);
+            char *path;
+
+            tc->mode = trans_modes[m].mode;
+            tc->gran = granularities[g].gran;
+
+            path = g_strdup_printf("/iommu-testdev/intel/iotlb-inv/%s-%s",
+                                   granularities[g].name,
+                                   trans_modes[m].name);
+            qtest_add_data_func_full(path, tc, test_iotlb_inv, g_free);
+            g_free(path);
+        }
+    }
+
+    for (size_t m = 0; m < ARRAY_SIZE(trans_modes); m++) {
+        QVTDTransMode *mode = g_new(QVTDTransMode, 1);
+        char *path;
+
+        *mode = trans_modes[m].mode;
+        path = g_strdup_printf(
+            "/iommu-testdev/intel/iotlb-inv/page-selective/%s",
+            trans_modes[m].name);
+        qtest_add_data_func_full(path, mode, test_page_selectivity, g_free);
+        g_free(path);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5e18b947c7..7da66802e1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -99,7 +99,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_AMD_IOMMU') ? ['amd-iommu-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_VTD') and
-   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
+   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test', 'iommu-intel-inv-test'] : []) +      \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
-- 
2.43.0


