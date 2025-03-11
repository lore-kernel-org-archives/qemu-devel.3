Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59844C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts49J-0001Oc-K2; Tue, 11 Mar 2025 14:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47S-00079B-Qm
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47L-0006kb-Td
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EdyhLjyE37lM3nS4PPAqlr0NpMtz5xMVxfCOm/yWis=;
 b=Qx6NZm8lR7XSV2sXX1Ti/FZPfU3VA4dFWOL+i18/RtaW9IwK/IufxU+UYzM8k0JgDoAa+J
 VwhSQbUWx4jQJkX1VKKAgGKfI4ebP2zcTbwdzYaS7gpaE9ceIMjLDc2Mx8tdtQnwJkIZ1z
 XrgEacUeNqhHR+k9oM8t6/prjX6SUWY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-WViuDMjTPe6G_ZLc6cMi8Q-1; Tue,
 11 Mar 2025 14:14:04 -0400
X-MC-Unique: WViuDMjTPe6G_ZLc6cMi8Q-1
X-Mimecast-MFC-AGG-ID: WViuDMjTPe6G_ZLc6cMi8Q_1741716841
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 248A91955DDF; Tue, 11 Mar 2025 18:14:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23D4618001E9; Tue, 11 Mar 2025 18:13:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/21] vfio/migration: Use BE byte order for device state wire
 packets
Date: Tue, 11 Mar 2025 19:13:18 +0100
Message-ID: <20250311181328.1200431-12-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Wire data commonly use BE byte order (including in the existing migration
protocol), use it also for for VFIO device state packets.

This will allow VFIO multifd device state transfer between hosts with
different endianness.
Although currently there is no such use case, it's good to have it now
for completeness.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/dcfc04cc1a50655650dbac8398e2742ada84ee39.1741611079.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration-multifd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 233724710b377afd40aabe5ef5b846f654f9865d..378f6f3bf01f6a4155fb424f8028cb5380f27f02 100644
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
@@ -155,12 +156,16 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
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
@@ -558,9 +563,9 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
 
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
@@ -610,7 +615,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
     }
 
     packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
-    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
+    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
 
     for (idx = 0; ; idx++) {
         ssize_t data_size;
@@ -631,7 +636,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
             break;
         }
 
-        packet->idx = idx;
+        packet->idx = cpu_to_be32(idx);
         packet_size = sizeof(*packet) + data_size;
 
         if (!multifd_queue_device_state(d->idstr, d->instance_id,
-- 
2.48.1


