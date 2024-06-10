Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66634C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwRD-0008JP-GA; Tue, 11 Jun 2024 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwRB-0008In-0B
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:01:01 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwR9-0006mH-7Q
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718092859; x=1749628859;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WGHRQpYT3C5bZ0oqorLplTEDTqd7EbkdN8z3TwrEi70=;
 b=oEQg99FxtE01Euu3KyoNutEofsOJ10iH49x9iLCbvmok/Q6G5NN2EKMn
 exqyi6AjQTrL+0dH6LWo6bdzUNM/XPJeMD+mEuOsZ6zArFBGARnKEw62b
 dNuMzNJ1ePpy9ebfV5IH7s2FVk7VJ8O51tnEFt8PMYHOBnQXuWCAq1n9c
 3DyzrwEs+PSSN2vUm582gfIAx9coDTZlsnlV75/scaN5yKZHh9AkGbIH1
 w8MySwKp1Ywiu71FCOtqZ4BKhmvsQgJRmJWRJ6SZjpJBIlh5F0Fgu5xTP
 2CHuqyP8CmWXgaaJoM26as/64SoTlCCfIMBuOoADAq/F2m07bfQ9YJzul A==;
X-CSE-ConnectionGUID: SxwAqgxJTyu6A3oUDs9LYA==
X-CSE-MsgGUID: I3Pf03HrSxupzOXoHHYJ/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32271360"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="32271360"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 01:00:59 -0700
X-CSE-ConnectionGUID: mehtDSCORVeghpBKRjLzaQ==
X-CSE-MsgGUID: EF17SrGpRNuRVDW0kT2FJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="70140923"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa002.jf.intel.com with ESMTP; 11 Jun 2024 01:00:56 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v8 7/7] tests/migration-test: add qpl compression test
Date: Mon, 10 Jun 2024 18:21:10 +0800
Message-ID: <20240610102110.900410-8-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610102110.900410-1-yuan1.liu@intel.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.143, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

the qpl compression supports software path and hardware
path(IAA device), and the hardware path is used first by
default. If the hardware path is unavailable, it will
automatically fallback to the software path for testing.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7e3406471..ef0c3f5e28 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2661,6 +2661,15 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
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
 static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
@@ -2741,6 +2750,17 @@ static void test_multifd_tcp_zstd(void)
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
@@ -3626,6 +3646,10 @@ int main(int argc, char **argv)
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
2.43.0


