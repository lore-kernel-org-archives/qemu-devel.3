Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28E2C54E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQz-0008Uq-4z; Wed, 06 Mar 2024 08:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQu-0008Nl-K1
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:44 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQs-00062n-OU
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYND51Scz4wyr;
 Thu,  7 Mar 2024 00:35:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYN92v8Gz4wcF;
 Thu,  7 Mar 2024 00:35:37 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 12/25] migration: Add Error** argument to .load_setup()
 handler
Date: Wed,  6 Mar 2024 14:34:27 +0100
Message-ID: <20240306133441.2351700-13-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This will be useful to report errors at a higher level, mostly in VFIO
today.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v3:

 - ERRP_GUARD() because of error_prepend use 
 - Made sure an error is always set in case of failure in
   vfio_load_setup()

 include/migration/register.h |  3 ++-
 hw/vfio/migration.c          |  9 +++++++--
 migration/ram.c              |  3 ++-
 migration/savevm.c           | 11 +++++++----
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 64fc7c11036c82edd6d69513e56a0216d36c17aa..f60e797894e5faacdf55d2d6de175074ac58944f 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -234,10 +234,11 @@ typedef struct SaveVMHandlers {
      *
      * @f: QEMUFile where to receive the data
      * @opaque: data pointer passed to register_savevm_live()
+     * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error
      */
-    int (*load_setup)(QEMUFile *f, void *opaque);
+    int (*load_setup)(QEMUFile *f, void *opaque, Error **errp);
 
     /**
      * @load_cleanup
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3e893093ea6191fda35b7fdaddad5bff23e97a13..a3bb1a92ba0b9c2c585efe54cfda0b774a81dcb9 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -588,12 +588,17 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
     }
 }
 
-static int vfio_load_setup(QEMUFile *f, void *opaque)
+static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
+    int ret;
 
-    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
                                    vbasedev->migration->device_state);
+    if (ret) {
+        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
+    }
+    return ret;
 }
 
 static int vfio_load_cleanup(void *opaque)
diff --git a/migration/ram.c b/migration/ram.c
index 52ad519b305532284003d78b93dd4a7186c767af..c5149b7d717aefad7f590422af0ea4a40e7507be 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3678,8 +3678,9 @@ void colo_release_ram_cache(void)
  *
  * @f: QEMUFile where to receive the data
  * @opaque: RAMState pointer
+ * @errp: pointer to Error*, to store an error if it happens.
  */
-static int ram_load_setup(QEMUFile *f, void *opaque)
+static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     xbzrle_load_setup();
     ramblock_recv_map_init();
diff --git a/migration/savevm.c b/migration/savevm.c
index 52d35b2a72c6238bfe5dcb4d81c1af8d2bf73013..ed0d1f31bee9b671698a75c29ab448ee2812685d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2750,8 +2750,9 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
     trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
 }
 
-static int qemu_loadvm_state_setup(QEMUFile *f)
+static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD(); /* error_prepend use */
     SaveStateEntry *se;
     int ret;
 
@@ -2766,10 +2767,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
             }
         }
 
-        ret = se->ops->load_setup(f, se->opaque);
+        ret = se->ops->load_setup(f, se->opaque, errp);
         if (ret < 0) {
+            error_prepend(errp, "Load state of device %s failed: ",
+                          se->idstr);
             qemu_file_set_error(f, ret);
-            error_report("Load state of device %s failed", se->idstr);
             return ret;
         }
     }
@@ -2950,7 +2952,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f) != 0) {
+    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
+        error_report_err(local_err);
         return -EINVAL;
     }
 
-- 
2.44.0


