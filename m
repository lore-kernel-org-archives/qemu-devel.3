Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F72AFE5219
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGFSc-0002eb-Sz; Fri, 24 Apr 2026 08:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wGFS6-0002Wv-Nb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:16:14 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wGFS4-0002Dv-Jt
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777032968; x=1808568968;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wItBfHW6v9wsyjtAKVgJYEePhRBXmoutUyn+sJKbZ/w=;
 b=azATtsdKuYiJZWivOECgvE7F4zRfkijCyTa2q+BThLfNQmAiSTr9AKe4
 BhKcretq0IWMoBuh32ET8a+XlAD0ENHfUHPlpk+JwxAFDdgRCkj+nIt/S
 1gJAQ/Z5GknQcT3rt1lliZ+bGio46QDc5VyY0zFefcGdEaH49P1dg2zwk
 ZQROnbVugheAwBlX+/iMyHe2OyTe/AaOMPnVHkhLgGs4SlPdWncFTj308
 AKF7exLyULTXrQNYhk4/uECvABF6VkBTGEEL9KbvSOFTsLjLpGpruelcc
 j0P2ezVRz8E/pJIJvSnlGrjHY2Pg5if8T0DA8h1n19jX2tSAczQLC1oKI A==;
X-CSE-ConnectionGUID: Ah9P1AqlQEGSPWesXHzfoA==
X-CSE-MsgGUID: fvY4diYrRXyj7jgWum4xvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78029988"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="78029988"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 05:16:06 -0700
X-CSE-ConnectionGUID: Vm0cL1mES/yLh9mK6j55gA==
X-CSE-MsgGUID: UBNpuumnSU+kBVEf/8Wc1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="237935796"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 05:16:04 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: junjie.cao@intel.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@bull.com, philmd@linaro.org,
 zhenzhong.duan@intel.com
Subject: [PATCH v2 2/2] tests/qtest: add 8-byte MMIO access sweep for
 intel-iommu
Date: Sat, 25 Apr 2026 04:18:42 +0800
Message-ID: <20260424201842.176953-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424201842.176953-1-junjie.cao@intel.com>
References: <20260424201842.176953-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/intel-iommu-test.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
index e5cc6acaf0..b1763ed294 100644
--- a/tests/qtest/intel-iommu-test.c
+++ b/tests/qtest/intel-iommu-test.c
@@ -17,11 +17,39 @@
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
+static void test_intel_iommu_8byte_access(void)
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
+    g_assert_cmpuint(vtd_reg_readl(s, DMAR_VER_REG), !=, 0);
+
+    qtest_quit(s);
+}
+
 static void test_intel_iommu_stage_1(void)
 {
     uint8_t init_csr[DMAR_REG_SIZE];     /* register values */
@@ -58,6 +86,8 @@ static void test_intel_iommu_stage_1(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/q35/intel-iommu/8byte-access",
+                   test_intel_iommu_8byte_access);
     qtest_add_func("/q35/intel-iommu/stage-1", test_intel_iommu_stage_1);
 
     return g_test_run();
-- 
2.43.0


