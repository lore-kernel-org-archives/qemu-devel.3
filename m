Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E4C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNfF-0004WE-H1; Tue, 05 Mar 2024 00:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNfE-0004Vo-2v
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:32 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNfC-0003fj-Eu
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709617710; x=1741153710;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bk1MITvvGkpGttrZKZiUpB7aMVkPIKAAmbCqKzhL4qA=;
 b=DgAxK3IWbAszbheUcyaHAlFH80LrClpKI2G46EfOUf8NhJc2kgckKC4b
 Qi8YgaYJfJEeYxvjb7nOkyDChjG1Nm1cvehHxuctlc7oTMtCqbjfmJDmw
 hA9zNmAcASTFwYWzxtr9SARt42u3a4BpTDqI8Z1h6/dIClLgm89Uefc2i
 XBIjgLqYdJ9cWtgpfTokEIFsPigdKE/nPn0s2+7JnoaytDLaXiQUFMSmY
 BwE556BhVH4ZlSCsFVUl9SnBfJeNFMNvHcuTVnwkRQhKZTLMTQVIQG91G
 y1sbM6co1/8tR5INa+s60W46eyl/XZYvE8vcs2bdlP7hakRG3lSdE6KAl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7096112"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7096112"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:48:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="46785297"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 21:48:28 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v4 8/8] tests/migration-test: add qpl compression test
Date: Mon,  4 Mar 2024 22:00:28 +0800
Message-Id: <20240304140028.1590649-9-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304140028.1590649-1-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.571, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 23d50fe599..96842f9515 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2653,6 +2653,15 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
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
@@ -2688,6 +2697,17 @@ static void test_multifd_tcp_zstd(void)
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
@@ -3574,6 +3594,10 @@ int main(int argc, char **argv)
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


