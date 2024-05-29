Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A761C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFsM-0005Ec-2f; Wed, 29 May 2024 05:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFsJ-00059f-Gk
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFsG-0000Tj-HF
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq4C361THz6K6lL;
 Wed, 29 May 2024 17:41:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 8D04C140A35;
 Wed, 29 May 2024 17:45:33 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:45:27 +0100
To: <peterx@redhat.com>, <farosas@suse.de>, <yuan1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>,
 <linwenkai6@hisilicon.com>, <zhangfei.gao@linaro.org>,
 <huangchenghai2@huawei.com>
Subject: [PATCH 3/7] migration/multifd: add uadk compression framework
Date: Wed, 29 May 2024 10:44:23 +0100
Message-ID: <20240529094435.11140-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds the skeleton to support uadk compression method.
Complete functionality will be added in subsequent patches.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/core/qdev-properties-system.c |  2 +-
 migration/meson.build            |  1 +
 migration/multifd-uadk.c         | 20 ++++++++++++++++++++
 migration/multifd.h              |  5 +++--
 qapi/migration.json              |  5 ++++-
 5 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100644 migration/multifd-uadk.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6ccd7224f6..f13350b4fb 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -659,7 +659,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd/qpl",
+                   "none/zlib/zstd/qpl/uadk",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 1d432d5328..ed687ae286 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -44,6 +44,7 @@ if get_option('live_block_migration').allowed()
 endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
+system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
new file mode 100644
index 0000000000..c2bb07535b
--- /dev/null
+++ b/migration/multifd-uadk.c
@@ -0,0 +1,20 @@
+/*
+ * Multifd UADK compression accelerator implementation
+ *
+ * Copyright (c) 2024 Huawei Technologies R & D (UK) Ltd
+ *
+ * Authors:
+ *  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+
+static void multifd_uadk_register(void)
+{
+    /* noop for now */
+}
+migration_init(multifd_uadk_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index 5b7d9b15f8..0ecd6f47d7 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -34,13 +34,14 @@ MultiFDRecvData *multifd_get_recv_data(void);
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
 
-/* We reserve 3 bits for compression methods */
-#define MULTIFD_FLAG_COMPRESSION_MASK (7 << 1)
+/* We reserve 4 bits for compression methods */
+#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
 /* we need to be compatible. Before compression value was 0 */
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
 #define MULTIFD_FLAG_QPL (4 << 1)
+#define MULTIFD_FLAG_UADK (8 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index 854e8609bd..0eaea9b0c3 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -632,12 +632,15 @@
 #       the deflate compression algorithm and use the Intel In-Memory Analytics
 #       Accelerator(IAA) accelerated compression and decompression. (Since 9.1)
 #
+# @uadk: use UADK library compression method. (Since 9.1)
+#
 # Since: 5.0
 ##
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
-            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
+            { 'name': 'qpl', 'if': 'CONFIG_QPL' },
+            { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
 
 ##
 # @MigMode:
-- 
2.17.1


