Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D99C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVOv-0006Y5-QA; Fri, 07 Mar 2025 05:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVOn-0006QG-Rl
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:57:50 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVOl-0003DM-0l
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:57:49 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVOb-00000000RLy-0f2D; Fri, 07 Mar 2025 11:57:37 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/2] vfio/migration: Use BE byte order for device state wire
 packets
Date: Fri,  7 Mar 2025 11:57:25 +0100
Message-ID: <f0bf02377f18f3cf6b8942528b3b5bce97fb6ab7.1741344976.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
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

Wire data commonly use BE byte order (including in the existing migration
protocol), use it also for for VFIO device state packets.

Fixes: 3228d311ab18 ("vfio/migration: Multifd device state transfer support - received buffers queuing")
Fixes: 6d644baef203 ("vfio/migration: Multifd device state transfer support - send side")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index a9d41b9f1cb1..e816461e1652 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -13,6 +13,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
@@ -208,12 +209,16 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
         return false;
     }
 
+    packet->version = be32_to_cpu(packet->version);
     if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
         error_setg(errp, "%s: packet has unknown version %" PRIu32,
                    vbasedev->name, packet->version);
         return false;
     }
 
+    packet->idx = be32_to_cpu(packet->idx);
+    packet->flags = be32_to_cpu(packet->flags);
+
     if (packet->idx == UINT32_MAX) {
         error_setg(errp, "%s: packet index is invalid", vbasedev->name);
         return false;
@@ -682,9 +687,9 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
 
     packet_len = sizeof(*packet) + bioc->usage;
     packet = g_malloc0(packet_len);
-    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
-    packet->idx = idx;
-    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
+    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
+    packet->idx = cpu_to_be32(idx);
+    packet->flags = cpu_to_be32(VFIO_DEVICE_STATE_CONFIG_STATE);
     memcpy(&packet->data, bioc->data, bioc->usage);
 
     if (!multifd_queue_device_state(idstr, instance_id,
@@ -734,7 +739,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
     }
 
     packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
-    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
+    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
 
     for (idx = 0; ; idx++) {
         ssize_t data_size;
@@ -755,7 +760,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
             break;
         }
 
-        packet->idx = idx;
+        packet->idx = cpu_to_be32(idx);
         packet_size = sizeof(*packet) + data_size;
 
         if (!multifd_queue_device_state(d->idstr, d->instance_id,

