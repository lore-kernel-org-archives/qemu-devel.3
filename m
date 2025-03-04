Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3993C282E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaOE-0008Lg-0V; Tue, 04 Mar 2025 17:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOC-0008Kq-Ls
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:24 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOA-0000ie-1l
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:23 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaO6-00000000LXG-0LsK; Tue, 04 Mar 2025 23:05:18 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 06/36] migration: Add qemu_loadvm_load_state_buffer() and
 its handler
Date: Tue,  4 Mar 2025 23:03:33 +0100
Message-ID: <71ca753286b87831ced4afd422e2e2bed071af25.1741124640.git.maciej.szmigiero@oracle.com>
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

qemu_loadvm_load_state_buffer() and its load_state_buffer
SaveVMHandler allow providing device state buffer to explicitly
specified device via its idstr and instance id.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/register.h | 15 +++++++++++++++
 migration/savevm.c           | 23 +++++++++++++++++++++++
 migration/savevm.h           |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index ff0faf5f68c8..58891aa54b76 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -229,6 +229,21 @@ typedef struct SaveVMHandlers {
      */
     int (*load_state)(QEMUFile *f, void *opaque, int version_id);
 
+    /**
+     * @load_state_buffer (invoked outside the BQL)
+     *
+     * Load device state buffer provided to qemu_loadvm_load_state_buffer().
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @buf: the data buffer to load
+     * @len: the data length in buffer
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns true to indicate success and false for errors.
+     */
+    bool (*load_state_buffer)(void *opaque, char *buf, size_t len,
+                              Error **errp);
+
     /**
      * @load_setup
      *
diff --git a/migration/savevm.c b/migration/savevm.c
index faebf47ef51f..7c1aa8ad7b9d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3060,6 +3060,29 @@ int qemu_loadvm_approve_switchover(void)
     return migrate_send_rp_switchover_ack(mis);
 }
 
+bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                   char *buf, size_t len, Error **errp)
+{
+    SaveStateEntry *se;
+
+    se = find_se(idstr, instance_id);
+    if (!se) {
+        error_setg(errp,
+                   "Unknown idstr %s or instance id %u for load state buffer",
+                   idstr, instance_id);
+        return false;
+    }
+
+    if (!se->ops || !se->ops->load_state_buffer) {
+        error_setg(errp,
+                   "idstr %s / instance %u has no load state buffer operation",
+                   idstr, instance_id);
+        return false;
+    }
+
+    return se->ops->load_state_buffer(se->opaque, buf, len, errp);
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index 58f871a7ed9c..cb58434a9437 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -71,4 +71,7 @@ int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);
 
+bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                   char *buf, size_t len, Error **errp);
+
 #endif

