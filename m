Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E356AC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwd-0005co-M5; Sun, 05 Jul 2026 10:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwc-0005cR-96
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwZ-0001Qf-Vn
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gzvm/baNSTAbavpHAQf6bg/1oIizBvPeR+NV/37wdU=;
 b=fWNYUZyJY9mvQAhqEDRBVqtFModBpZ7+XREZulxNl/f7AR3vN+XtQoxcuugn+9UwZomtwN
 NT0EDisStOVtT2XVLvDttq0jZ/sqeY6ZjReSdJJGH7thYCQ5gz/PQDcLf3bOQiMW5xoRmR
 t02xGPkbnImPzaCqvvGCCeA5CFpL+Ig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-x26Vn7OsMo2DH1devNIDew-1; Sun, 05 Jul 2026 10:35:38 -0400
X-MC-Unique: x26Vn7OsMo2DH1devNIDew-1
X-Mimecast-MFC-AGG-ID: x26Vn7OsMo2DH1devNIDew_1783262137
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493c588b6f2so15001135e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262137; x=1783866937; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7gzvm/baNSTAbavpHAQf6bg/1oIizBvPeR+NV/37wdU=;
 b=FlxwdEv4EHj1hTPGcVR0WzC6+jRf3Rn8BUZ8UuTYfU9WVnomgiImRWbV+SWBwtiw4x
 k6C+tTt/EpGJq+BkqXLR62ypE9nK4qrLlMBMEVA6HFXyZP/F6TX0gxPL5MfIQYVq4fiF
 S99Rcj5fvGz1Ewe9c1cQYhzvSHGb5UkQQc+yuE88kLDkvlKK02s7zbtekZWWLEhqU+c+
 2IDh2f7n8H0C15ho0d4saZaRd3bFEGqjXOTexaPVBiBESjqYXXyeuKYDmpzcaWXnqb+/
 aCud8eXcSCRXqUXXcbRMIPXOT1O1vG96p0ZsyjyGnf91caManJRPK7oDL4JuJa9rXdNW
 +iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262137; x=1783866937;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gzvm/baNSTAbavpHAQf6bg/1oIizBvPeR+NV/37wdU=;
 b=HBfJteY44EHAZUJCxt+gOhP6D+uW+d3CXpEVF/X6bBWm2MmHJqF0+tCNcy6MH9KUKo
 gBpon5X6+jJEh82TihykdUGjqM6XnOJeyoIZzgNCzP2cLMtsllUkH2OPybfVvMXl2e0B
 i4+V2pdsJX8JN5gE2z+hqEt0+r9as0gJJboHgigCgKfZ3OIMEyZ+tmxS/CqZTYwhGang
 /aRV4znx+dy4V/dPrB72tQbMvaD/P0JGtjoPVUwj/iTengQFy52gJH0XUBRKpDY4mShv
 v54jUOVwCG/TtkYgAruz66gJNyay99G+EjQUVoFgeKmmkBPzh8qR1guZBzX9bhOO+GLV
 7Sgw==
X-Gm-Message-State: AOJu0YxpJr631MYX43S23MFq9gNPWitn3wPNxyucuaduMUiriZyWeMz9
 qy5JRnmzM6LvTuAYirBOlUsj1692KUZS9E/6uK7oEBkjXW+rGevc58dsk+bpAJzDTnSZ6kWG2CN
 klhLJibBXIohOwULHJ0/PRDctawoR6206urJb0yAVxlIAF6+hvySJZ5QFnBw4Ces/2RfQvwrKtH
 UeFh5Ed7+raxUeNHWGABH1W/xDmEo8X5DYpA==
X-Gm-Gg: AfdE7cldFbU4dYFZNb7m+zTJEGJh+CUj8dg0y5NThUdouxU0K+jCDHe0HkKgXjcrr8Z
 F9gL/Ccy7sf/nelIO6V7g6Wor+w+K5vxJg3OXi9jkxRHDh+fgQAIt3dEHDriPlq6xeSZy+/1Z5s
 /NbTzovtmp3fzjNs3JvazLcBI1EBdc630msXHdUfTZAaWcupPOiVoK3Q6Cvh9qErTkW693fnaM6
 pHoUzbM02VmjrC9LZWvJDKLutpbf6AqVpfZSk3z07ZbUUxHKBWSBqeYD6oJIWHqq0Q2AIhlhyxN
 +Q8pXVPh3cjRg7pfqB3B7zJvIcCAu24EgwSv6ifBdm1Y7sn0eiDsgZx2Gtr1jTOINM+0Bndg8qp
 27DYCTwmjLZKInN7v+5o49+3NcwMnf7yu
X-Received: by 2002:a05:600c:3506:b0:493:be08:c372 with SMTP id
 5b1f17b1804b1-493d11dd320mr76655735e9.17.1783262136726; 
 Sun, 05 Jul 2026 07:35:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3506:b0:493:be08:c372 with SMTP id
 5b1f17b1804b1-493d11dd320mr76655325e9.17.1783262136167; 
 Sun, 05 Jul 2026 07:35:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637568dsm313847125e9.4.2026.07.05.07.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:35 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 22/44] tests/qtest/libqos: add Intel IOMMU invalidation helpers
Message-ID: <3c774326fe1ee8182666b00748609a7751b9d0b6.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260703072200.463082-3-junjie.cao@intel.com>
---
 tests/qtest/libqos/qos-intel-iommu.h |  51 +++++++++++++
 tests/qtest/libqos/qos-intel-iommu.c | 108 +++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

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
-- 
MST


