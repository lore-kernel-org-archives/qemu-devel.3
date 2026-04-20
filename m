Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D4EF557ED
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEkWp-0007sV-3p; Mon, 20 Apr 2026 05:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEkWf-0007r9-EW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:02:41 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEkWd-0002EW-Uj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776675760; x=1808211760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yxCLbt9+8utUs+QSmodG/CdePKqwm4ukEkB8XjX2Bxk=;
 b=JItsd2ejIRcLsiLsnXv94pC5fOGoyQ2INp36NTx5AqbwD+hLrmA4AWAg
 4Moma0yljhi/eW8muIlpLX/j3QNKfGQRyE/LfksUZP3/NBcdGfT1mJGyF
 ahnukNLBegUw6Iu1tx2WbcmaqMeoCVYFYSa7FejJCHWtcLhfLbKBAPu5w
 b0IZhq9VvUuXjydufw9r4ZFqp2Wz95nCx+gzGcpWDx3WJjmn7fbl3bV7c
 t8kLygpS2I5C89P+ipkKK9GkVSZX6+0/258SXYQlVhC+sSrX9VMBwGWCH
 UvXi2DbvtYI60J+R+txtkTXGO1o021jb5t/dkHzSagtzszmeaha1itpCZ Q==;
X-CSE-ConnectionGUID: zYGCnLl8RYKwnMxpN/z3Hw==
X-CSE-MsgGUID: 6tikYRxXQhmrDUS3McPIyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81457571"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="81457571"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 02:02:38 -0700
X-CSE-ConnectionGUID: P4CPNNLQRbSR69NJKFo4cQ==
X-CSE-MsgGUID: 69PrzR9ARh+kdbkTcw3tTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="262049227"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa002-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:02:34 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 yi.l.liu@intel.com,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, farosas@suse.de, lvivier@redhat.com,
 junjie.cao@intel.com
Subject: [PATCH 2/2] tests/qtest: Add regression test for intel-iommu 8-byte
 MMIO access
Date: Tue, 21 Apr 2026 01:05:23 +0800
Message-ID: <20260420170523.17908-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420170523.17908-1-junjie.cao@intel.com>
References: <20260420170523.17908-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sweep every 4-byte-aligned offset in the VT-d MMIO register space
with 8-byte reads and writes to verify that no register handler
aborts on an oversized access.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/intel-iommu-test.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
index e5cc6acaf0..87a26b6910 100644
--- a/tests/qtest/intel-iommu-test.c
+++ b/tests/qtest/intel-iommu-test.c
@@ -17,11 +17,45 @@
 #define ECAP_STAGE_1_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IR | VTD_ECAP_IRO | \
                               VTD_ECAP_MHMV | VTD_ECAP_SMTS | VTD_ECAP_FSTS)
 
+static inline uint32_t vtd_reg_readl(QTestState *s, uint64_t offset)
+{
+    return qtest_readl(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
+}
+
 static inline uint64_t vtd_reg_readq(QTestState *s, uint64_t offset)
 {
     return qtest_readq(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
 }
 
+static inline void vtd_reg_writeq(QTestState *s, uint64_t offset,
+                                  uint64_t value)
+{
+    qtest_writeq(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset, value);
+}
+
+/*
+ * Sweep every 4-byte-aligned offset in the VT-d register space with
+ * an 8-byte read and write to verify that no 32-bit-only register
+ * handler aborts on an oversized access.
+ */
+static void test_intel_iommu_8byte_access_sweep(void)
+{
+    QTestState *s;
+    uint64_t off;
+
+    s = qtest_init("-M q35 -device intel-iommu");
+
+    for (off = 0; off < DMAR_REG_SIZE; off += 4) {
+        vtd_reg_readq(s, off);
+        vtd_reg_writeq(s, off, 0);
+    }
+
+    /* Liveness check: QEMU must still respond after the sweep */
+    g_assert_cmpuint(vtd_reg_readl(s, DMAR_VER_REG), !=, 0);
+
+    qtest_quit(s);
+}
+
 static void test_intel_iommu_stage_1(void)
 {
     uint8_t init_csr[DMAR_REG_SIZE];     /* register values */
@@ -58,6 +92,8 @@ static void test_intel_iommu_stage_1(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/q35/intel-iommu/8byte-access-sweep",
+                   test_intel_iommu_8byte_access_sweep);
     qtest_add_func("/q35/intel-iommu/stage-1", test_intel_iommu_stage_1);
 
     return g_test_run();
-- 
2.43.0


