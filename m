Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D3C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNf1-0004T1-Cw; Tue, 05 Mar 2024 00:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNex-0004Sn-6K
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:15 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNev-0003eg-8g
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709617693; x=1741153693;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7sHmriUwSGMAnFTcA5AVBxwma0hCf6t82yyyCrzLIDI=;
 b=WYY8jTsHBSRlrqyXbaTrljy9wzbVxHJGFDo/S3Tctw+RPPYzsWcrIFVw
 b91Sv2k6vPuV85jbSCVYX8oFCNUqCV7jYZPrmERV1wOmG5JI2b2vep4vW
 +GHpAAiXkGdh3IxPAQDG/E9VDIe9CXwEHIQmYVDPFFb2mZ/okdjfTblo/
 9oIKi5ixsKeophk6Eviu/7EkgMhF8S019KyuWLVP9ZdrYHrgVMHTJcnqr
 AEvFwOylavYUz/s4lrf5mBHURrqv8m8fx+PGWQjNTqnnK1sYbWVKiTSUf
 RHFT70hIzYKR9W7T4DdApyzOMwYe3FQloyyn4AmVLNtFSMVd44+kFhi2s Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4006265"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4006265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="40135958"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa002.jf.intel.com with ESMTP; 04 Mar 2024 21:48:09 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v4 4/8] migration/multifd: add qpl compression method
Date: Mon,  4 Mar 2024 22:00:24 +0800
Message-Id: <20240304140028.1590649-5-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304140028.1590649-1-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yuan1.liu@intel.com;
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
 hw/core/qdev-properties-system.c |   2 +-
 migration/meson.build            |   1 +
 migration/multifd-qpl.c          | 158 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   1 +
 qapi/migration.json              |   7 +-
 5 files changed, 167 insertions(+), 2 deletions(-)
 create mode 100644 migration/multifd-qpl.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..b4f0e5cbdb 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -658,7 +658,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd",
+                   "none/zlib/zstd/qpl",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..c155c2d781 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
   system_ss.add(files('block.c'))
 endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
+system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
new file mode 100644
index 0000000000..6b94e732ac
--- /dev/null
+++ b/migration/multifd-qpl.c
@@ -0,0 +1,158 @@
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
+
+#include "qemu/osdep.h"
+#include "qemu/rcu.h"
+#include "exec/ramblock.h"
+#include "exec/target_page.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "trace.h"
+#include "options.h"
+#include "multifd.h"
+#include "qpl/qpl.h"
+
+struct qpl_data {
+    qpl_job **job_array;
+    /* the number of allocated jobs */
+    uint32_t job_num;
+    /* the size of data processed by a qpl job */
+    uint32_t data_size;
+    /* compressed data buffer */
+    uint8_t *zbuf;
+    /* the length of compressed data */
+    uint32_t *zbuf_hdr;
+};
+
+/**
+ * qpl_send_setup: setup send side
+ *
+ * Setup each channel with QPL compression.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+/**
+ * qpl_send_cleanup: cleanup send side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    /* Implement in next patch */
+}
+
+/**
+ * qpl_send_prepare: prepare data to be able to send
+ *
+ * Create a compressed buffer with all the pages that we are going to
+ * send.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+/**
+ * qpl_recv_setup: setup receive side
+ *
+ * Create the compressed channel and buffer.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+/**
+ * qpl_recv_cleanup: setup receive side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void qpl_recv_cleanup(MultiFDRecvParams *p)
+{
+    /* Implement in next patch */
+}
+
+/**
+ * qpl_recv_pages: read the data from the channel into actual pages
+ *
+ * Read the compressed buffer, and uncompress it into the actual
+ * pages.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_recv_pages(MultiFDRecvParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+/**
+ * qpl_get_iov_count: get the count of IOVs
+ *
+ * For QPL compression, in addition to requesting the same number of IOVs
+ * as the page, it also requires an additional IOV to store all compressed
+ * data lengths.
+ *
+ * Returns the count of the IOVs
+ *
+ * @page_count: Indicate the maximum count of pages processed by multifd
+ */
+static uint32_t qpl_get_iov_count(uint32_t page_count)
+{
+    return page_count + 1;
+}
+
+static MultiFDMethods multifd_qpl_ops = {
+    .send_setup = qpl_send_setup,
+    .send_cleanup = qpl_send_cleanup,
+    .send_prepare = qpl_send_prepare,
+    .recv_setup = qpl_recv_setup,
+    .recv_cleanup = qpl_recv_cleanup,
+    .recv_pages = qpl_recv_pages,
+    .get_iov_count = qpl_get_iov_count
+};
+
+static void multifd_qpl_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
+}
+
+migration_init(multifd_qpl_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index d82495c508..0e9361df2a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -33,6 +33,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
+#define MULTIFD_FLAG_QPL (4 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9b8d..e48e3d7065 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -625,11 +625,16 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qpl: use qpl compression method. Query Processing Library(qpl) is based on
+#       the deflate compression algorithm and use the Intel In-Memory Analytics
+#       Accelerator(IAA) hardware accelerated compression and decompression.
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


