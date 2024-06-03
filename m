Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD35CC27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU5o-0001fR-M8; Tue, 04 Jun 2024 09:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5n-0001eq-ER
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:47 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5l-0000YV-9g
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717507246; x=1749043246;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qKBr5xnyvZqzkLheeiw0t24J8uWKU5VJBsRmV6jqV6Y=;
 b=Tk17WXfcU8ehjvHQzoxCJWiLc1YxHlG0i1i781WAPWthpKyf9SMD7yMp
 fwpEuaA6lUQ8ww8ms1E9VjzGSu5xSKsFkE0y45eVxoFXSInlz3Y/yP6T7
 qKpwVKWs1X33gGvm+Nsb0qMBR6PMYNOh8eL6Zwy17D+ld5lHsqaguaEcB
 pfJ6eHWwBTd/oSEf3v8w9RyJPYh2x0OPmy788uFnM07cCWJ6uAIm5FKr4
 vKHGJOC1/hjnLx0oIAtxmLU8e4UsECzM7CzhImuyNZRXlNt8XXW3qXAZ3
 Z2u2lK8K76wVBSX1BTULWkGHlj3m9rN8aaNHOylQYA/TLNlXRlyidLr7l Q==;
X-CSE-ConnectionGUID: JdVWG/ePQrCEmqeaLUUpDw==
X-CSE-MsgGUID: lT9qkaI/RUyY53amECXs1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24628675"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24628675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 06:20:45 -0700
X-CSE-ConnectionGUID: flV193EFT7Sl8QtL9ukplA==
X-CSE-MsgGUID: lTHKi1HrQ5SsEcOHF7LC2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37246929"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2024 06:20:40 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v7 4/7] migration/multifd: add qpl compression method
Date: Mon,  3 Jun 2024 23:41:03 +0800
Message-ID: <20240603154106.764378-5-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603154106.764378-1-yuan1.liu@intel.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
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

add the Query Processing Library (QPL) compression method

Introduce the qpl as a new multifd migration compression method, it can
use In-Memory Analytics Accelerator(IAA) to accelerate compression and
decompression, which can not only reduce network bandwidth requirement
but also reduce host compression and decompression CPU overhead.

How to enable qpl compression during migration:
migrate_set_parameter multifd-compression qpl

There is no qpl compression level parameter added since it only supports
level one, users do not need to specify the qpl compression level.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
index bdc3244bce..5f146fe8a9 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -39,6 +39,7 @@ endif
 
 system_ss.add(when: rdma, if_true: files('rdma.c'))
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
index a351fd3714..f97bc3bb93 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -554,11 +554,16 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qpl: use qpl compression method. Query Processing Library(qpl) is based on
+#       the deflate compression algorithm and use the Intel In-Memory Analytics
+#       Accelerator(IAA) accelerated compression and decompression. (Since 9.1)
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
2.43.0


