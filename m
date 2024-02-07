Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49441C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4A-0006hW-Ei; Wed, 07 Feb 2024 08:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi42-0006fV-Mi
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:14 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi3y-0008OS-PP
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgD42NFz4wyx;
 Thu,  8 Feb 2024 00:34:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgB5ZFsz4wc6;
 Thu,  8 Feb 2024 00:33:58 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 02/14] migration: Add Error** argument to .load_setup() handler
Date: Wed,  7 Feb 2024 14:33:35 +0100
Message-ID: <20240207133347.1115903-3-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h |  2 +-
 hw/vfio/migration.c          |  2 +-
 migration/ram.c              |  2 +-
 migration/savevm.c           | 10 ++++++----
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 831600a00eae4efd0464b60925d65de4d9dbcff8..e6bc226c98b27c1fb0f9e2b56d8aff491aa14d65 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -72,7 +72,7 @@ typedef struct SaveVMHandlers {
     void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
                                 uint64_t *can_postcopy);
     LoadStateHandler *load_state;
-    int (*load_setup)(QEMUFile *f, void *opaque);
+    int (*load_setup)(QEMUFile *f, void *opaque, Error **errp);
     int (*load_cleanup)(void *opaque);
     /* Called when postcopy migration wants to resume from failure */
     int (*resume_prepare)(MigrationState *s, void *opaque);
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
index 136c237f4079f68d4e578cf1c72eec2efc815bc8..8dac9bac2fe8b8c19e102c771a7ef6e976252906 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3498,7 +3498,7 @@ void colo_release_ram_cache(void)
  * @f: QEMUFile where to receive the data
  * @opaque: RAMState pointer
  */
-static int ram_load_setup(QEMUFile *f, void *opaque)
+static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     xbzrle_load_setup();
     ramblock_recv_map_init();
diff --git a/migration/savevm.c b/migration/savevm.c
index f2ae799bad13e631bccf733a34c3a8fd22e8dd48..990f4249a26d28117ee365d8b20fc5bbca0d43d6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2737,7 +2737,7 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
     trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
 }
 
-static int qemu_loadvm_state_setup(QEMUFile *f)
+static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
     SaveStateEntry *se;
     int ret;
@@ -2753,10 +2753,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
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
@@ -2937,7 +2938,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f) != 0) {
+    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
+        error_report_err(local_err);
         return -EINVAL;
     }
 
-- 
2.43.0


