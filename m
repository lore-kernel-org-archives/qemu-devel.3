Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F15DD10F28
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqA-0002gu-7o; Sun, 17 Nov 2024 14:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkq8-0002gm-Tk
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:45 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkq7-0005sq-EG
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:44 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkq3-00000002GTj-2VyB; Sun, 17 Nov 2024 20:21:39 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 06/24] migration: Add qemu_loadvm_load_state_buffer() and
 its handler
Date: Sun, 17 Nov 2024 20:20:01 +0100
Message-ID: <d791cb76e8c43a30b49758ed641bf566f5325e2a.1731773021.git.maciej.szmigiero@oracle.com>
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

qemu_loadvm_load_state_buffer() and its load_state_buffer
SaveVMHandler allow providing device state buffer to explicitly
specified device via its idstr and instance id.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/register.h | 17 +++++++++++++++++
 migration/savevm.c           | 23 +++++++++++++++++++++++
 migration/savevm.h           |  3 +++
 3 files changed, 43 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index ff0faf5f68c8..39991f3cc5d0 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -229,6 +229,23 @@ typedef struct SaveVMHandlers {
      */
     int (*load_state)(QEMUFile *f, void *opaque, int version_id);
 
+    /* This runs outside the BQL. */
+
+    /**
+     * @load_state_buffer
+     *
+     * Load device state buffer provided to qemu_loadvm_load_state_buffer().
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @buf: the data buffer to load
+     * @len: the data length in buffer
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*load_state_buffer)(void *opaque, char *buf, size_t len,
+                             Error **errp);
+
     /**
      * @load_setup
      *
diff --git a/migration/savevm.c b/migration/savevm.c
index a254c38edcca..1f58a2fa54ae 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3085,6 +3085,29 @@ int qemu_loadvm_approve_switchover(void)
     return migrate_send_rp_switchover_ack(mis);
 }
 
+int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                  char *buf, size_t len, Error **errp)
+{
+    SaveStateEntry *se;
+
+    se = find_se(idstr, instance_id);
+    if (!se) {
+        error_setg(errp,
+                   "Unknown idstr %s or instance id %u for load state buffer",
+                   idstr, instance_id);
+        return -1;
+    }
+
+    if (!se->ops || !se->ops->load_state_buffer) {
+        error_setg(errp,
+                   "idstr %s / instance %u has no load state buffer operation",
+                   idstr, instance_id);
+        return -1;
+    }
+
+    return se->ops->load_state_buffer(se->opaque, buf, len, errp);
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index 4d402723bc3c..b5a4f8c8b440 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -71,4 +71,7 @@ int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy, bool inactivate_disks);
 
+int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                  char *buf, size_t len, Error **errp);
+
 #endif

