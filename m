Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D31FCD11DC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrOF-0004c7-MU; Wed, 20 Mar 2024 04:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrOA-0004am-Hx
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:34 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrO5-0005XU-04
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710923609; x=1742459609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ojS7//kmXedbnaPprHSWdUIukwbzAZV70hqMHOhV4NQ=;
 b=RTHq2iA41H94oAS4yqD1qq4xKRUsRLQC3F2tdLHBFrXrMnrhMcmdZXAh
 WEsHlgpzwt1//WTUyRICF8Baf5EJCqPavE5aZsI4BHSDzFXBmchR9K3bA
 rxoaHDC3jCd+U75dwn77Vmb0kJldreztb955BujFIzaGJcNezpRtK2Eqt
 y8rJbM18C56PnGnxFmZutgbQgM7ah3c9ViifVBq6RT3iK2FOBd7FnFfJD
 DpvNWMXS2jiuQAGfBJ3/VFfxQn2xZ/y9bA3WKQUObz7V0QyUDG3UYPOVg
 +eanlXZ3ay3HvtHlRIyBWUYmJKu/VBSGl8+R+Ge1Tin90VoKgrf71gmrB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5952974"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5952974"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 01:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="13986755"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa010.jf.intel.com with ESMTP; 20 Mar 2024 01:33:26 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v5 7/7] tests/migration-test: add qpl compression test
Date: Wed, 20 Mar 2024 00:45:27 +0800
Message-Id: <20240319164527.1873891-8-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240319164527.1873891-1-yuan1.liu@intel.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.422, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

add qpl to compression method test for multifd migration

the migration with qpl compression needs to access IAA hardware
resource, please run "check-qtest" with sudo or root permission,
otherwise migration test will fail

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 tests/qtest/migration-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 71895abb7f..052d0d60fd 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2815,6 +2815,15 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
+#ifdef CONFIG_QPL
+static void *
+test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
+                                            QTestState *to)
+{
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
+}
+#endif /* CONFIG_QPL */
+
 static void test_multifd_tcp_none(void)
 {
     MigrateCommon args = {
@@ -2880,6 +2889,17 @@ static void test_multifd_tcp_zstd(void)
 }
 #endif
 
+#ifdef CONFIG_QPL
+static void test_multifd_tcp_qpl(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_qpl_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_GNUTLS
 static void *
 test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
@@ -3789,6 +3809,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QPL
+    migration_test_add("/migration/multifd/tcp/plain/qpl",
+                       test_multifd_tcp_qpl);
+#endif
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/multifd/tcp/tls/psk/match",
                        test_multifd_tcp_tls_psk_match);
-- 
2.39.3


