Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DC3C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwR3-0008G2-Cp; Tue, 11 Jun 2024 04:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwR1-0008Ez-AY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:51 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwQz-0006mH-Am
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718092849; x=1749628849;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WRf9grLHtl23f86fVCmsEJbqolIsjXAVmYr8+xyFWww=;
 b=dJjNEbveihBFps30x/G0EfG0Zlo3DOFP/y2f5TFskd+I41w0nwW7iH06
 0ByCXQEj76oSM6zJlb2B2xm8ofaw+RBqFzYE6W3E7dGoTNMjfgMrut1Tv
 e1ycSs+YjJnIOjh3trbgc3w7DRJLMf4OuMhccGzEHJY0A/8Ys79ILkVij
 3WnH8OkMd4bXqE5+oUU/HNqJ2QaMSQebnCMlhLdoX3PU80uaiME3NrLEg
 FYZT1qrAyoZAXCNfybE/K3qT5ZAx75K91/ZVloBRV94W42vfbf3yvtuhx
 15DcDtSdL1FOepUEvX1+hobYVts+TqwsOL7OdaSSbE1MASMuZsEXYz/2L A==;
X-CSE-ConnectionGUID: Hvv9KXudSlSFQVW+yI+5hw==
X-CSE-MsgGUID: Uhmp8xEJSe2fHyMBBliD0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32271350"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="32271350"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 01:00:47 -0700
X-CSE-ConnectionGUID: XZRTI5/fSmWdeTfDVmyMLA==
X-CSE-MsgGUID: +dLE2fcfQQ2Ti+3W0Aj2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="70140901"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa002.jf.intel.com with ESMTP; 11 Jun 2024 01:00:45 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v8 4/7] migration/multifd: add qpl compression method
Date: Mon, 10 Jun 2024 18:21:07 +0800
Message-ID: <20240610102110.900410-5-yuan1.liu@intel.com>
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


