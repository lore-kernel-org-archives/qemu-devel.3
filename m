Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65893D10F28
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkr1-0004BY-Qa; Sun, 17 Nov 2024 14:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqz-0003u7-5C
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:37 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqx-0005x2-Et
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:36 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqt-00000002GVd-0SzF; Sun, 17 Nov 2024 20:22:31 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 16/24] migration/multifd: Send final SYNC only after device
 state is complete
Date: Sun, 17 Nov 2024 20:20:11 +0100
Message-ID: <0b8131dc6107841969d254e88e9d6e14220f1ea5.1731773021.git.maciej.szmigiero@oracle.com>
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

Currently, ram_save_complete() sends a final SYNC multifd packet near this
function end, after sending all of the remaining RAM data.

On the receive side, this SYNC packet will cause multifd channel threads
to block, waiting for the final sem_sync posting in
multifd_recv_terminate_threads().

However, multifd_recv_terminate_threads() won't be called until the
migration is complete, which causes a problem if multifd channels are
still required for transferring device state data after RAM transfer is
complete but before finishing the migration process.

Defer sending the final SYNC packet to the end of sending of
post-switchover iterable data instead if device state transfer is possible.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd-nocomp.c | 18 +++++++++++++++++-
 migration/multifd.h        |  1 +
 migration/ram.c            | 10 +++++++++-
 migration/savevm.c         | 11 +++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 90c0927b9bcb..db87b1262ffa 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -348,7 +348,7 @@ retry:
     return true;
 }
 
-int multifd_ram_flush_and_sync(void)
+int multifd_ram_flush(void)
 {
     if (!migrate_multifd()) {
         return 0;
@@ -361,6 +361,22 @@ int multifd_ram_flush_and_sync(void)
         }
     }
 
+    return 0;
+}
+
+int multifd_ram_flush_and_sync(void)
+{
+    int ret;
+
+    if (!migrate_multifd()) {
+        return 0;
+    }
+
+    ret = multifd_ram_flush();
+    if (ret) {
+        return ret;
+    }
+
     return multifd_send_sync_main();
 }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 05ddfb4bf119..3abf9578e2ae 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -376,6 +376,7 @@ static inline uint32_t multifd_ram_page_count(void)
 
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
+int multifd_ram_flush(void);
 int multifd_ram_flush_and_sync(void);
 void multifd_ram_payload_alloc(MultiFDPages_t *pages);
 void multifd_ram_payload_free(MultiFDPages_t *pages);
diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb32876..cf7bea3f073b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3283,7 +3283,15 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_ram_flush_and_sync();
+    if (migration_has_device_state_support()) {
+        /*
+         * Can't do the final SYNC here since device state might still
+         * be transferring via multifd channels.
+         */
+        ret = multifd_ram_flush();
+    } else {
+        ret = multifd_ram_flush_and_sync();
+    }
     if (ret < 0) {
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 6ea9054c4083..98049cb9b09a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -37,6 +37,7 @@
 #include "migration/register.h"
 #include "migration/global_state.h"
 #include "migration/channel-block.h"
+#include "multifd.h"
 #include "ram.h"
 #include "qemu-file.h"
 #include "savevm.h"
@@ -1496,6 +1497,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
     int ret;
+    bool multifd_device_state = migration_has_device_state_support();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
@@ -1528,6 +1530,15 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
                                     end_ts_each - start_ts_each);
     }
 
+    if (multifd_device_state) {
+        /* Send the final SYNC */
+        ret = multifd_send_sync_main();
+        if (ret) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
     trace_vmstate_downtime_checkpoint("src-iterable-saved");
 
     return 0;

