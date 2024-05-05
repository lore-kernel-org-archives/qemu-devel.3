Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAB5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tz9-0003Qj-OL; Mon, 06 May 2024 04:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s3tyv-0003Ee-VI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:45:58 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s3tyu-0003R3-34
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714985156; x=1746521156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z2l/kZxF6ucmve0nR6QM982kPczxoQOncFJ70CSOlCI=;
 b=dZpAYYsQxfmM6ijVJU1K18lK7Qc+QpvXcg3ufz3zmgxyEWYg6R5sbh62
 0l7ZwOVGbVBKx5ee8iMvTvuYOTHQax4Tg7QWWrm5AXXAGvs99I0Oo4ztC
 7qxylQAUby477ZpCM6Y87XgeaDIvBEtx8bpS2tVOoBI7JwbNRxZJJSym9
 v+qC3RRH5UaKjezLUnWHBUz5mmNSzQvAauiYmeSrteoHzfctJ3a0ZC0pP
 /8JIAK0QupkhuwwjkQSMslwkAXjH4Anmbxg+ewufdMdy6Ns7lhAqT5NPz
 vdY7XGuXJDnpYCFp3wKXXUMTtWA8lrLi6w8B73swguYyh60Ash1fjFR0H Q==;
X-CSE-ConnectionGUID: 7K+G+mxoSVaPwbxmvsbY+g==
X-CSE-MsgGUID: oftrFUSOSei7LGHGyVrEyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="11254997"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="11254997"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:45:55 -0700
X-CSE-ConnectionGUID: Xr3dABfyTWmdf4Reg9LjpQ==
X-CSE-MsgGUID: kRAOcOy3SBWFAVETf+bmxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="51287533"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa002.fm.intel.com with ESMTP; 06 May 2024 01:45:54 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v6 4/7] migration/multifd: add qpl compression method
Date: Mon,  6 May 2024 00:57:48 +0800
Message-Id: <20240505165751.2392198-5-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240505165751.2392198-1-yuan1.liu@intel.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.431, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The qpl method only supports one compression level, there is no qpl
compression level parameter added, users do not need to specify the
qpl compression level.

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
index f76b1ba328..1d432d5328 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -43,6 +43,7 @@ if get_option('live_block_migration').allowed()
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
index 8c65b90328..854e8609bd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -628,11 +628,16 @@
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
2.39.3


