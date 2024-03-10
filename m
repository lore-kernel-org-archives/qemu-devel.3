Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C90C54E67
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 19:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjOi2-0006BB-B9; Sun, 10 Mar 2024 15:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org>)
 id 1rjOi0-0006Ai-9J
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:19:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org>)
 id 1rjOhw-0001Qy-R9
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 15:19:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tt8qC3ptxz4wyq;
 Mon, 11 Mar 2024 06:19:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tt8qB0gGjz4wcl;
 Mon, 11 Mar 2024 06:19:33 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/2] vfio: allow cpr-reboot migration if suspended
Date: Sun, 10 Mar 2024 20:19:24 +0100
Message-ID: <20240310191924.201680-3-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240310191924.201680-1-clg@redhat.com>
References: <20240310191924.201680-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=sXSr=KQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

From: Steve Sistare <steven.sistare@oracle.com>

Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
guest drivers' suspend methods flush outstanding requests and re-initialize
the devices, and thus there is no device state to save and restore.  The
user is responsible for suspending the guest before initiating cpr, such as
by issuing guest-suspend-ram to the qemu guest agent.

Relax the vfio blocker so it does not apply to cpr, and add a notifier that
verifies the guest is suspended.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      |  2 +-
 hw/vfio/cpr.c                         | 20 ++++++++++++++++++++
 hw/vfio/migration.c                   |  2 +-
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b2813b0c117985425c842d91f011bb895955d738..3582d5f97a37877b2adfc0d0b06996c82403f8b7 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -49,6 +49,7 @@ typedef struct VFIOContainerBase {
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
+    NotifierWithReturn cpr_reboot_notifier;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc07a85e2eb908df828c1f42104d683e911..ff88c3f31ca660b3c0a790601100fdc6116192a0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
 
     return ret;
 }
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3bede5494804e4aa291663c1e7c01d5dc5d3a407..392c2dd95d14664bade0ae74655e91bc839504c0 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -7,13 +7,33 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-common.h"
+#include "migration/misc.h"
 #include "qapi/error.h"
+#include "sysemu/runstate.h"
+
+static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
+                                    MigrationEvent *e, Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_SETUP &&
+        !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
+
+        error_setg(errp,
+            "VFIO device only supports cpr-reboot for runstate suspended");
+
+        return -1;
+    }
+    return 0;
+}
 
 int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
 {
+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
+                                vfio_cpr_reboot_notifier,
+                                MIG_MODE_CPR_REBOOT);
     return 0;
 }
 
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
 {
+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 50140eda872b3d5c9438459e207682de9be06511..2050ac8897231ff89cc223f0570d5c7a65dede9e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -889,7 +889,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
     vbasedev->migration_blocker = error_copy(err);
     error_free(err);
 
-    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
+    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
 }
 
 /* ---------------------------------------------------------------------- */
-- 
2.44.0


