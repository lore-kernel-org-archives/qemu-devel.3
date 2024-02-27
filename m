Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06602C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4Kh-0005tz-6D; Tue, 27 Feb 2024 15:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1oX-0003P6-RR
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:28 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1oV-0001WB-4S
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tkljw40k5z4wyq;
 Wed, 28 Feb 2024 05:04:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tkljs6vMDz4wyj;
 Wed, 28 Feb 2024 05:04:17 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 07/21] migration: Add Error** argument to .load_setup()
 handler
Date: Tue, 27 Feb 2024 19:03:31 +0100
Message-ID: <20240227180345.548960-8-clg@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227180345.548960-1-clg@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GitP=KE=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 15:45:28 -0500
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
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h |  3 ++-
 hw/vfio/migration.c          |  2 +-
 migration/ram.c              |  3 ++-
 migration/savevm.c           | 10 ++++++----
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 96eae9dba2970552c379c732393e3ab6ef578a58..2cfc167f717de8e08c1ca8accdc3011c03eb1554 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -231,10 +231,11 @@ typedef struct SaveVMHandlers {
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
index 8bcb4bc73cd5ba5338e3ffa4d907d0e6bfbb9485..2dfbe671f6f45aa530c7341177bb532d8292cecd 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -580,7 +580,7 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
     }
 }
 
-static int vfio_load_setup(QEMUFile *f, void *opaque)
+static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
 
diff --git a/migration/ram.c b/migration/ram.c
index 745482899e18c86b73261b683c1bec04039a76d2..d648134133fc22cd91c7b2064198a90287ee733d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3498,8 +3498,9 @@ void colo_release_ram_cache(void)
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
index b5b3b51bad94dc4c04ae22cd687ba111299339aa..a4ef41d3ff5b471a1cd4166c2dc5813e44ea3a5a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2741,7 +2741,7 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
     trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
 }
 
-static int qemu_loadvm_state_setup(QEMUFile *f)
+static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
     SaveStateEntry *se;
     int ret;
@@ -2757,10 +2757,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
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
@@ -2941,7 +2942,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f) != 0) {
+    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
+        error_report_err(local_err);
         return -EINVAL;
     }
 
-- 
2.43.2


