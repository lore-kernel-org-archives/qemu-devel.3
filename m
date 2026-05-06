Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44EBCD342F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKSoF-0005zd-2a; Tue, 05 May 2026 23:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wKSoD-0005zA-BH
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:20:25 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wKSoB-0002an-Oy
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778037623; x=1809573623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wItBfHW6v9wsyjtAKVgJYEePhRBXmoutUyn+sJKbZ/w=;
 b=VbuAF1CcxL4WRgdwCnGnRXxRMrb7V/L+mBACtOOFEA2Nn8g2OjIWAcHO
 ejlYtc6ss0tA0W7aMvHrIb21bzVYWKf6sgx+VPPjgl6V4vq68/9W6l8tn
 2ech70LytiyfMYznTMbKyDci0ek34rpwgB97UvvOhqrpHDoihDiDmZN57
 POQQTX3RzlLzY9QLD7OH4sJXS9JZz7L7HdRI7AfVsmuccF3dKnBUxd/fG
 DCe/Qtn+w1M4VJgqRNJztfS5OR17jeAl29AE/TEKy5PJ7Vn8sqptIMo0A
 1fUhX4s+ju32s1XxdGb1EbrGyBSVS3LRueu5X2sEid3RtiE7ltdFr4Wu6 A==;
X-CSE-ConnectionGUID: YQu2PSAtQXmlxCrhAVcSeg==
X-CSE-MsgGUID: NoQiF7q3R4S4DiT5jYsalw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78783065"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78783065"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:20:22 -0700
X-CSE-ConnectionGUID: lPWmmaJSTFmsp7PBRX3IZg==
X-CSE-MsgGUID: 5OLvUpkDRLKC+XWB47r2/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="231417016"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:20:19 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: junjie.cao@intel.com, zhenzhong.duan@intel.com, philmd@linaro.org,
 mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@bull.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v3 2/2] tests/qtest: add 8-byte MMIO access sweep for
 intel-iommu
Date: Wed,  6 May 2026 11:19:42 +0800
Message-ID: <20260506031942.251335-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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


