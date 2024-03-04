Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327CEC5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNfC-0004Vh-6O; Tue, 05 Mar 2024 00:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNfA-0004VC-Vi
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:29 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNf9-0003fB-AS
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709617707; x=1741153707;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I60mSo2+idY+1i00U4px6xKXXI7NrmIgiiKujhHDfHM=;
 b=mcfTUFkLZQCYsKWEBfm6Knojo9okPOaAPIKwnQ23KwmMFUA20F45QnW/
 YGOKJf5SFwtK7NLhoLPnKRs41GZrfgZt0pEQzL+iGdSdsC2Kx9XmaM1Cx
 43GBK0T9IxN37CqfTNT1pqZBPpScw9Fu/gSJzmZv/fFKtD/Sy9UpU+n9X
 SgmkJ7N6kCuqs3rg9e4miZCvPzZvQ7LPR8bV75h5QBUNtXPLwmsLygvfr
 PCqn9M4aieD9+3V/skU4EySK35et5HiqXDENLYeitt/XQ4k+agLjVsOVl
 60BFlbAoX9jIZh7CEyjz0GlKe6fSURp9NzqJ6h9Vrv5uVcV1GNLRklv31 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7096103"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7096103"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="46785291"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 21:48:25 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v4 7/8] migration/multifd: fix zlib and zstd compression
 levels not working
Date: Mon,  4 Mar 2024 22:00:27 +0800
Message-Id: <20240304140028.1590649-8-yuan1.liu@intel.com>
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

add zlib and zstd compression levels in multifd parameter
testing and application and add compression level tests

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reported-by: Xiaohui Li <xiaohli@redhat.com>
---
 migration/options.c          | 12 ++++++++++++
 tests/qtest/migration-test.c | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 3e3e0b93b4..1cd3cc7c33 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1312,6 +1312,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_zlib_level) {
+        dest->multifd_zlib_level = params->multifd_zlib_level;
+    }
+    if (params->has_multifd_zstd_level) {
+        dest->multifd_zstd_level = params->multifd_zstd_level;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
@@ -1447,6 +1453,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_zlib_level) {
+        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
+    }
+    if (params->has_multifd_zstd_level) {
+        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
+    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8a5bb1752e..23d50fe599 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2621,10 +2621,24 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
+static void
+test_and_set_multifd_compression_level(QTestState *who, const char *param)
+{
+    /* The default compression level is 1, test a level other than 1 */
+    int level = 2;
+
+    migrate_set_parameter_int(who, param, level);
+    migrate_check_parameter_int(who, param, level);
+    /* only test compression level 1 during migration */
+    migrate_set_parameter_int(who, param, 1);
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
 {
+    /* the compression level is used only on the source side. */
+    test_and_set_multifd_compression_level(from, "multifd-zlib-level");
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
 }
 
@@ -2633,6 +2647,8 @@ static void *
 test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
                                             QTestState *to)
 {
+    /* the compression level is used only on the source side. */
+    test_and_set_multifd_compression_level(from, "multifd-zstd-level");
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
 }
 #endif /* CONFIG_ZSTD */
-- 
2.39.3


