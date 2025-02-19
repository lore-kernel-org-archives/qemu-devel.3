Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6897C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqo8-0006tU-2X; Wed, 19 Feb 2025 15:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqo5-0006dv-DL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:36:33 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqo3-0004ni-BT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:36:32 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqnp-00000007VUx-3OZS; Wed, 19 Feb 2025 21:36:17 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 22/36] vfio/migration: Multifd device state transfer
 support - basic types
Date: Wed, 19 Feb 2025 21:34:04 +0100
Message-ID: <b93731a2e5b4d6fcb673606cfd19178525204c19.1739994627.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739994627.git.maciej.szmigiero@oracle.com>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Add basic types and flags used by VFIO multifd device state transfer
support.

Since we'll be introducing a lot of multifd transfer specific code,
add a new file migration-multifd.c to home it, wired into main VFIO
migration code (migration.c) via migration-multifd.h header file.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/meson.build         |  1 +
 hw/vfio/migration-multifd.c | 31 +++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h | 15 +++++++++++++++
 hw/vfio/migration.c         |  1 +
 4 files changed, 48 insertions(+)
 create mode 100644 hw/vfio/migration-multifd.c
 create mode 100644 hw/vfio/migration-multifd.h

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bba776f75cc7..260d65febd6b 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,6 +5,7 @@ vfio_ss.add(files(
   'container-base.c',
   'container.c',
   'migration.c',
+  'migration-multifd.c',
   'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
new file mode 100644
index 000000000000..0c3185a26242
--- /dev/null
+++ b/hw/vfio/migration-multifd.c
@@ -0,0 +1,31 @@
+/*
+ * Multifd VFIO migration
+ *
+ * Copyright (C) 2024,2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-common.h"
+#include "migration/misc.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "qemu/main-loop.h"
+#include "qemu/thread.h"
+#include "migration/qemu-file.h"
+#include "migration-multifd.h"
+#include "trace.h"
+
+#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
+
+#define VFIO_DEVICE_STATE_PACKET_VER_CURRENT (0)
+
+typedef struct VFIODeviceStatePacket {
+    uint32_t version;
+    uint32_t idx;
+    uint32_t flags;
+    uint8_t data[0];
+} QEMU_PACKED VFIODeviceStatePacket;
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
new file mode 100644
index 000000000000..64d117b27210
--- /dev/null
+++ b/hw/vfio/migration-multifd.h
@@ -0,0 +1,15 @@
+/*
+ * Multifd VFIO migration
+ *
+ * Copyright (C) 2024,2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VFIO_MIGRATION_MULTIFD_H
+#define HW_VFIO_MIGRATION_MULTIFD_H
+
+#include "hw/vfio/vfio-common.h"
+
+#endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 46adb798352f..7b79be6ad293 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -23,6 +23,7 @@
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "migration/blocker.h"
+#include "migration-multifd.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-vfio.h"
 #include "exec/ramlist.h"

