Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A57C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7Sw-0000pt-IP; Mon, 04 Mar 2024 07:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7S6-0000JU-QL
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:00 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7Ry-0004lG-GN
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ111DjNz4x1H;
 Mon,  4 Mar 2024 23:29:41 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ0y25QNz4x0m;
 Mon,  4 Mar 2024 23:29:38 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 13/26] migration: Add Error** argument to .load_setup()
 handler
Date: Mon,  4 Mar 2024 13:28:31 +0100
Message-ID: <20240304122844.1888308-14-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
index 5152783e01c39edaf4ab37035924f8e495cf48d8..20eb7dad1a909d49a810294d87a07262ec5f1e9d 100644
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
index 84e718c562c72310092114c438eb94e0077775f2..20c6ad9e759b2b8ec7ae26b7ca72d5cbd20d481f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3506,8 +3506,9 @@ void colo_release_ram_cache(void)
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
index 0ff2c4d97d475b81603bc2387cfaa3c000a25cdc..a495676fab928b86df33911ea2f24d250efe1876 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2749,8 +2749,9 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
     trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
 }
 
-static int qemu_loadvm_state_setup(QEMUFile *f)
+static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD(); /* error_prepend use */
     SaveStateEntry *se;
     int ret;
 
@@ -2765,10 +2766,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
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
@@ -2949,7 +2951,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f) != 0) {
+    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
+        error_report_err(local_err);
         return -EINVAL;
     }
 
-- 
2.44.0


