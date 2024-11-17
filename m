Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14ABD10F26
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqw-0003g6-UH; Sun, 17 Nov 2024 14:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqu-0003XX-BH
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:32 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqr-0005we-Mq
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:32 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqn-00000002GVP-43q7; Sun, 17 Nov 2024 20:22:25 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 15/24] migration/multifd: Add
 migration_has_device_state_support()
Date: Sun, 17 Nov 2024 20:20:10 +0100
Message-ID: <ca43afdc742ccf8070b1146014ce33c333e85d8b.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Since device state transfer via multifd channels requires multifd
channels with packets and is currently not compatible with multifd
compression add an appropriate query function so device can learn
whether it can actually make use of it.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h         | 1 +
 migration/multifd-device-state.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 118e205bbcc6..43558d9198f7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -112,5 +112,6 @@ bool migration_in_bg_snapshot(void);
 /* migration/multifd-device-state.c */
 bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                 char *data, size_t len);
+bool migration_has_device_state_support(void);
 
 #endif
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 8cf5a6c2668c..bcbea926b6be 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -11,6 +11,7 @@
 #include "qemu/lockable.h"
 #include "migration/misc.h"
 #include "multifd.h"
+#include "options.h"
 
 static QemuMutex queue_job_mutex;
 
@@ -99,3 +100,9 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
 
     return true;
 }
+
+bool migration_has_device_state_support(void)
+{
+    return migrate_multifd() && !migrate_mapped_ram() &&
+        migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
+}

