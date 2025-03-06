Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A7C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC3f-0002uC-U2; Thu, 06 Mar 2025 09:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC17-0008U5-Ch
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC15-0001v2-Gj
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Vxi0S3m0kmWM2L3BzdSS+w3nmDL9rl89fpxIkNRBKs=;
 b=DQ2p2a8I61TQzkjjezv/We2/YzcjjVPhJs8si7VvAtNkcEIfPAyUgK/XmWVvxRHW+fAkbn
 rfrUQGn7REJs0tfWfBZFdjNshme3Tcx/4WSztUZVhuMUSbRaHM0yDBEmhk9YnKg9JXV56v
 Id6WIeFP8WHtlZe5pOBJwQ/7bmv0Ro0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-P6gtLt6GMraPGeO-r1Ql2w-1; Thu,
 06 Mar 2025 09:16:00 -0500
X-MC-Unique: P6gtLt6GMraPGeO-r1Ql2w-1
X-Mimecast-MFC-AGG-ID: P6gtLt6GMraPGeO-r1Ql2w_1741270559
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 424701828AA4; Thu,  6 Mar 2025 14:15:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A169C18001D3; Thu,  6 Mar 2025 14:15:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/42] vfio/migration: Multifd device state transfer support -
 basic types
Date: Thu,  6 Mar 2025 15:14:07 +0100
Message-ID: <20250306141419.2015340-32-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/4eedd529e6617f80f3d6a66d7268a0db2bc173fa.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration-multifd.h | 17 +++++++++++++++++
 hw/vfio/migration-multifd.c | 33 +++++++++++++++++++++++++++++++++
 hw/vfio/migration.c         |  1 +
 hw/vfio/meson.build         |  1 +
 4 files changed, 52 insertions(+)
 create mode 100644 hw/vfio/migration-multifd.h
 create mode 100644 hw/vfio/migration-multifd.c

diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
new file mode 100644
index 0000000000000000000000000000000000000000..5b221c6e16b0265314034a6060b588e984b8ac5e
--- /dev/null
+++ b/hw/vfio/migration-multifd.h
@@ -0,0 +1,17 @@
+/*
+ * Multifd VFIO migration
+ *
+ * Copyright (C) 2024,2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_MIGRATION_MULTIFD_H
+#define HW_VFIO_MIGRATION_MULTIFD_H
+
+#include "hw/vfio/vfio-common.h"
+
+#endif
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
new file mode 100644
index 0000000000000000000000000000000000000000..fa594b33fdd1112e1d3ecf52a35fecb551e29999
--- /dev/null
+++ b/hw/vfio/migration-multifd.c
@@ -0,0 +1,33 @@
+/*
+ * Multifd VFIO migration
+ *
+ * Copyright (C) 2024,2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index a9b0970604aa3e15fe2fb2412286e48cac3b03cc..dc1fe4e717a465f442634f6e65e9c56df3c084d7 100644
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
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bba776f75cc718956b37f68cb542b378a509d77f..260d65febd6bcd1935cfa9f59cc08aae21fc97fd 100644
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
-- 
2.48.1


