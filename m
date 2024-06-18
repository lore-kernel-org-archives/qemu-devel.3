Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264A6C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbSX-00030f-VH; Tue, 18 Jun 2024 12:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSW-0002zr-An
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:24 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSU-0000qR-OO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:24 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSH-0001bF-Ao; Tue, 18 Jun 2024 18:13:09 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v1 04/13] migration: Add save_live_complete_precopy_{begin,
 end} handlers
Date: Tue, 18 Jun 2024 18:12:22 +0200
Message-ID: <ebcd3a48296564be553e26c064610e31aeaf6c16.1718717584.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718717584.git.maciej.szmigiero@oracle.com>
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

These SaveVMHandlers allow device to provide its own asynchronous
transmission of the remaining data at the end of a precopy phase.

In this use case the save_live_complete_precopy_begin handler is
supposed to start such transmission (for example, by launching
appropriate threads) while the save_live_complete_precopy_end
handler is supposed to wait until such transfer has finished (for
example, until the sending threads have exited).

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/register.h | 34 ++++++++++++++++++++++++++++++++++
 migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index f60e797894e5..f7b3df799991 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -103,6 +103,40 @@ typedef struct SaveVMHandlers {
      */
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
 
+    /**
+     * @save_live_complete_precopy_begin
+     *
+     * Called at the end of a precopy phase, before all @save_live_complete_precopy
+     * handlers. The handler might, for example, arrange for device-specific
+     * asynchronous transmission of the remaining data. When postcopy is enabled,
+     * devices that support postcopy will skip this step.
+     *
+     * @f: QEMUFile where the handler can synchronously send data before returning
+     * @idstr: this device section idstr
+     * @instance_id: this device section instance_id
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*save_live_complete_precopy_begin)(QEMUFile *f,
+                                            char *idstr, uint32_t instance_id,
+                                            void *opaque);
+    /**
+     * @save_live_complete_precopy_end
+     *
+     * Called at the end of a precopy phase, after all @save_live_complete_precopy
+     * handlers. The handler might, for example, wait for the asynchronous
+     * transmission started by the @save_live_complete_precopy_begin handler
+     * to complete. When postcopy is enabled, devices that support postcopy will
+     * skip this step.
+     *
+     * @f: QEMUFile where the handler can synchronously send data before returning
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);
+
     /* This runs both outside and inside the BQL.  */
 
     /**
diff --git a/migration/savevm.c b/migration/savevm.c
index c621f2359ba3..56fb1c4c2563 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1494,6 +1494,27 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     SaveStateEntry *se;
     int ret;
 
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
+            !se->ops->save_live_complete_precopy_begin) {
+            continue;
+        }
+
+        save_section_header(f, se, QEMU_VM_SECTION_END);
+
+        ret = se->ops->save_live_complete_precopy_begin(f,
+                                                        se->idstr, se->instance_id,
+                                                        se->opaque);
+
+        save_section_footer(f, se);
+
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
@@ -1525,6 +1546,20 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
                                     end_ts_each - start_ts_each);
     }
 
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
+            !se->ops->save_live_complete_precopy_end) {
+            continue;
+        }
+
+        ret = se->ops->save_live_complete_precopy_end(f, se->opaque);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
     trace_vmstate_downtime_checkpoint("src-iterable-saved");
 
     return 0;

