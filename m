Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AA1CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrO7-0004Xh-DU; Wed, 20 Mar 2024 04:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNt-0004WA-0R
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:18 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNr-0005UI-C3
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710923596; x=1742459596;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mz9Bf/tG16d1JBIuhsfID5eXSf48Pqg0iXFjNioFLYQ=;
 b=XSsF0yMzWgEIaZG4BABfuAtEtiqBUrOJKjLSV4rpoTloCg6KCPpiDIiR
 wZ9EDAYm9C5ZD9JuG6W/bkC2Iq1Q2wfvpaRso8EUMP+Px2cgfdGHMreyR
 JWnt4m8djUVz7imofCTXomsNbv8RLk5gKXEl3racsO16DMwNnAh7CM0gZ
 9wHiI5wIdiGPg8MZE9L7oNIPh95QP+qam0w3+rgcvvs6j44+DdAPjK9YP
 oCD3RXoJak3VDUEtaHwyFrWUlxEm9a9P6nGZ/zAlJCKFtEl6anzXK2hL/
 inpYQ3M9BZfVqa1rhyL/dAkeuKnyMGE3gwjpvu1LLrImuz9mL0U+iVHTj Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5952939"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5952939"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 01:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="13986727"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa010.jf.intel.com with ESMTP; 20 Mar 2024 01:33:10 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v5 4/7] migration/multifd: add qpl compression method
Date: Wed, 20 Mar 2024 00:45:24 +0800
Message-Id: <20240319164527.1873891-5-yuan1.liu@intel.com>
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

add the Query Processing Library (QPL) compression method

Although both qpl and zlib support deflate compression, qpl will
only use the In-Memory Analytics Accelerator(IAA) for compression
and decompression, and IAA is not compatible with the Zlib in
migration, so qpl is used as a new compression method for migration.

How to enable qpl compression during migration:
migrate_set_parameter multifd-compression qpl

The qpl only supports one compression level, there is no qpl
compression level parameter added, users do not need to specify
the qpl compression level.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 hw/core/qdev-properties-system.c |  2 +-
 migration/meson.build            |  1 +
 migration/multifd-qpl.c          | 20 ++++++++++++++++++++
 migration/multifd.h              |  1 +
 qapi/migration.json              |  7 ++++++-
 5 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 migration/multifd-qpl.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index d79d6f4b53..6ccd7224f6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -659,7 +659,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd",
+                   "none/zlib/zstd/qpl",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 1eeb915ff6..cb177de1d2 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -41,6 +41,7 @@ if get_option('live_block_migration').allowed()
   system_ss.add(files('block.c'))
 endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
+system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
new file mode 100644
index 0000000000..056a68a060
--- /dev/null
+++ b/migration/multifd-qpl.c
@@ -0,0 +1,20 @@
+/*
+ * Multifd qpl compression accelerator implementation
+ *
+ * Copyright (c) 2023 Intel Corporation
+ *
+ * Authors:
+ *  Yuan Liu<yuan1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+
+static void multifd_qpl_register(void)
+{
+    /* noop */
+}
+
+migration_init(multifd_qpl_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index c9d9b09239..5b7d9b15f8 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -40,6 +40,7 @@ MultiFDRecvData *multifd_get_recv_data(void);
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
+#define MULTIFD_FLAG_QPL (4 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index aa1b39bce1..dceb35db5b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -629,11 +629,16 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qpl: use qpl compression method. Query Processing Library(qpl) is based on
+#       the deflate compression algorithm and use the Intel In-Memory Analytics
+#       Accelerator(IAA) accelerated compression and decompression. (Since 9.0)
+#
 # Since: 5.0
 ##
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
-            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
+            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
+            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
 
 ##
 # @MigMode:
-- 
2.39.3


