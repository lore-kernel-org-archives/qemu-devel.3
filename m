Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750D6C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Q3-0005hK-QQ; Tue, 27 Aug 2024 13:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Px-0005FK-2c
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:45 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Pv-0001Zz-IJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:44 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Pi-0002N6-7C; Tue, 27 Aug 2024 19:55:30 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 07/17] migration: Add qemu_loadvm_load_state_buffer() and
 its handler
Date: Tue, 27 Aug 2024 19:54:26 +0200
Message-ID: <fe14c841e40e294c05f8dae966e94cc12b3e5473.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

qemu_loadvm_load_state_buffer() and its load_state_buffer
SaveVMHandler allow providing device state buffer to explicitly
specified device via its idstr and instance id.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/register.h | 15 +++++++++++++++
 migration/savevm.c           | 25 +++++++++++++++++++++++++
 migration/savevm.h           |  3 +++
 3 files changed, 43 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 9de123252edf..4a578f140713 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -263,6 +263,21 @@ typedef struct SaveVMHandlers {
      */
     int (*load_state)(QEMUFile *f, void *opaque, int version_id);
 
+    /**
+     * @load_state_buffer
+     *
+     * Load device state buffer provided to qemu_loadvm_load_state_buffer().
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @data: the data buffer to load
+     * @data_size: the data length in buffer
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
+                             Error **errp);
+
     /**
      * @load_setup
      *
diff --git a/migration/savevm.c b/migration/savevm.c
index d43acbbf20cf..3fde5ca8c26b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3101,6 +3101,31 @@ int qemu_loadvm_approve_switchover(void)
     return migrate_send_rp_switchover_ack(mis);
 }
 
+int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                  char *buf, size_t len, Error **errp)
+{
+    SaveStateEntry *se;
+
+    se = find_se(idstr, instance_id);
+    if (!se) {
+        error_setg(errp, "Unknown idstr %s or instance id %u for load state buffer",
+                   idstr, instance_id);
+        return -1;
+    }
+
+    if (!se->ops || !se->ops->load_state_buffer) {
+        error_setg(errp, "idstr %s / instance %u has no load state buffer operation",
+                   idstr, instance_id);
+        return -1;
+    }
+
+    if (se->ops->load_state_buffer(se->opaque, buf, len, errp) != 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index 9ec96a995c93..d388f1bfca98 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -70,4 +70,7 @@ int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy, bool inactivate_disks);
 
+int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                  char *buf, size_t len, Error **errp);
+
 #endif

