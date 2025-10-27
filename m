Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D904CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJ5J-0004Cv-Jz; Mon, 27 Oct 2025 05:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ5B-0004BK-AR
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ56-0002YZ-Pj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761555597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=4Drb6lCZuzrZTJv0a1dwSwvAAKw0dCj4rgic5dBYSMM=;
 b=K31+ykfD01t5KGwEwcePFgcSeTxvcqYfs0NNyfhWp6sGNjZ6jxBJ5YLSNL1oSLTsS7+zgk
 2GwlpYQhIHdC8iYBMEo4s8pjsk+VOpMzKWYADysieEvRbCq87iKUBkqbF+rz6KiCxLzN7a
 7915JwwgfRFsRG9nG3V/bwOAkiNW5qY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-MopAqorpPGu5MFFvqlJpDQ-1; Mon,
 27 Oct 2025 04:59:53 -0400
X-MC-Unique: MopAqorpPGu5MFFvqlJpDQ-1
X-Mimecast-MFC-AGG-ID: MopAqorpPGu5MFFvqlJpDQ_1761555592
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E974418002C1; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EB8019540EB; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCF9221E6935; Mon, 27 Oct 2025 09:59:48 +0100 (CET)
Resent-To: guobin@linux.alibaba.com, qemu-devel@nongnu.org, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 27 Oct 2025 09:59:48 +0100
Resent-Message-ID: <87ecqopvnf.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Oct 27 07:45:03 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8589421E6925; Mon, 27 Oct 2025 07:45:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 guobin@linux.alibaba.com
Subject: [PATCH 2/3] migration: Use bitset of MigMode instead of variable
 arguments
Date: Mon, 27 Oct 2025 07:45:02 +0100
Message-ID: <20251027064503.1074255-3-armbru@redhat.com>
In-Reply-To: <20251027064503.1074255-1-armbru@redhat.com>
References: <20251027064503.1074255-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

migrate_add_blocker_modes() and migration_add_notifier_modes use
variable arguments for a set of migration modes.  The variable
arguments get collected into a bitset for processsing.  Take a bitset
argument instead, it's simpler.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/migration/blocker.h |  9 +++-----
 include/migration/misc.h    | 10 ++++-----
 hw/vfio/container-legacy.c  |  6 +++---
 hw/vfio/cpr-iommufd.c       |  6 +++---
 hw/vfio/cpr-legacy.c        |  8 +++----
 hw/vfio/cpr.c               |  5 ++---
 hw/vfio/device.c            |  4 ++--
 migration/migration.c       | 43 ++++++-------------------------------
 stubs/migr-blocker.c        |  2 +-
 system/physmem.c            |  8 +++----
 10 files changed, 33 insertions(+), 68 deletions(-)

diff --git a/include/migration/blocker.h b/include/migration/blocker.h
index a687ac0efe..80b75ad5cb 100644
--- a/include/migration/blocker.h
+++ b/include/migration/blocker.h
@@ -16,8 +16,6 @@
 
 #include "qapi/qapi-types-migration.h"
 
-#define MIG_MODE_ALL MIG_MODE__MAX
-
 /**
  * @migrate_add_blocker - prevent all modes of migration from proceeding
  *
@@ -82,16 +80,15 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp);
  *
  * @reasonp - address of an error to be returned whenever migration is attempted
  *
- * @errp - [out] The reason (if any) we cannot block migration right now.
+ * @modes - the migration modes to be blocked, a bit set of MigMode
  *
- * @mode - one or more migration modes to be blocked.  The list is terminated
- *         by -1 or MIG_MODE_ALL.  For the latter, all modes are blocked.
+ * @errp - [out] The reason (if any) we cannot block migration right now.
  *
  * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
  *
  * *@reasonp is freed and set to NULL if failure is returned.
  * On success, the caller must not free *@reasonp before the blocker is removed.
  */
-int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...);
+int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp);
 
 #endif
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 592b93021e..e26d418a6e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -90,18 +90,18 @@ void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
 
 /*
- * Same as migration_add_notifier, but applies to be specified @mode.
+ * Same as migration_add_notifier, but applies to the specified @mode
+ * instead of MIG_MODE_NORMAL.
  */
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
 /*
- * Same as migration_add_notifier, but applies to all @mode in the argument
- * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
- * the notifier is added for all modes.
+ * Same as migration_add_notifier, but applies to the specified @modes
+ * (a bitset of MigMode).
  */
 void migration_add_notifier_modes(NotifierWithReturn *notify,
-                                  MigrationNotifyFunc func, MigMode mode, ...);
+                                  MigrationNotifyFunc func, unsigned modes);
 
 /*
  * Remove a notifier from all modes.
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 8e9639603e..32c260b345 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -977,9 +977,9 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     if (vbasedev->mdev) {
         error_setg(&vbasedev->cpr.mdev_blocker,
                    "CPR does not support vfio mdev %s", vbasedev->name);
-        if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
-                                      MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
-                                      -1) < 0) {
+        if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker,
+                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC),
+                    errp) < 0) {
             goto hiod_unref_exit;
         }
     }
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 8a4d65de5e..c244db88fb 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -158,9 +158,9 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
     Error **cpr_blocker = &be->cpr_blocker;
 
     if (!vfio_cpr_supported(be, cpr_blocker)) {
-        return migrate_add_blocker_modes(cpr_blocker, errp,
-                                         MIG_MODE_CPR_TRANSFER,
-                                         MIG_MODE_CPR_EXEC, -1) == 0;
+        return migrate_add_blocker_modes(cpr_blocker,
+                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_TRANSFER),
+                    errp);
     }
 
     vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 7184c93991..86c943158e 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -176,9 +176,9 @@ bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
                                 MIG_MODE_CPR_REBOOT);
 
     if (!vfio_cpr_supported(container, cpr_blocker)) {
-        return migrate_add_blocker_modes(cpr_blocker, errp,
-                                         MIG_MODE_CPR_TRANSFER,
-                                         MIG_MODE_CPR_EXEC, -1) == 0;
+        return migrate_add_blocker_modes(cpr_blocker,
+                        BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC),
+                        errp) == 0;
     }
 
     vfio_cpr_add_kvm_notifier();
@@ -187,7 +187,7 @@ bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
 
     migration_add_notifier_modes(&container->cpr.transfer_notifier,
                                  vfio_cpr_fail_notifier,
-                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
+                                 BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC));
     return true;
 }
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index db462aabcb..998230d271 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -197,8 +197,7 @@ void vfio_cpr_add_kvm_notifier(void)
     if (!kvm_close_notifier.notify) {
         migration_add_notifier_modes(&kvm_close_notifier,
                                      vfio_cpr_kvm_close_notifier,
-                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
-                                     -1);
+                                     BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC));
     }
 }
 
@@ -285,7 +284,7 @@ void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
 {
     migration_add_notifier_modes(&vdev->cpr.transfer_notifier,
                                  vfio_cpr_pci_notifier,
-                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
+                                 BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC));
 }
 
 void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 8b63e765ac..76869828fc 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -345,8 +345,8 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
                            "vfio device with fd=%d needs an id property",
                            vbasedev->fd);
                 return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker,
-                                                 errp, MIG_MODE_CPR_TRANSFER,
-                                                 -1) == 0;
+                                                 BIT(MIG_MODE_CPR_TRANSFER),
+                                                 errp) == 0;
             }
         }
     }
diff --git a/migration/migration.c b/migration/migration.c
index 9f0a91b1d9..5f1c83aafd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1672,8 +1672,6 @@ void migration_cancel(void)
     }
 }
 
-static unsigned get_modes(MigMode mode, va_list ap);
-
 static void add_notifiers(NotifierWithReturn *notify, unsigned modes)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
@@ -1685,15 +1683,8 @@ static void add_notifiers(NotifierWithReturn *notify, unsigned modes)
 }
 
 void migration_add_notifier_modes(NotifierWithReturn *notify,
-                                  MigrationNotifyFunc func, MigMode mode, ...)
+                                  MigrationNotifyFunc func, unsigned modes)
 {
-    unsigned modes;
-    va_list ap;
-
-    va_start(ap, mode);
-    modes = get_modes(mode, ap);
-    va_end(ap);
-
     notify->notify = (NotifierWithReturnFunc)func;
     add_notifiers(notify, modes);
 }
@@ -1701,13 +1692,13 @@ void migration_add_notifier_modes(NotifierWithReturn *notify,
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode)
 {
-    migration_add_notifier_modes(notify, func, mode, -1);
+    migration_add_notifier_modes(notify, func, BIT(mode));
 }
 
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func)
 {
-    migration_add_notifier_modes(notify, func, MIG_MODE_NORMAL, -1);
+    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
 }
 
 void migration_remove_notifier(NotifierWithReturn *notify)
@@ -1890,21 +1881,6 @@ static bool is_only_migratable(Error **reasonp, Error **errp, unsigned modes)
     return false;
 }
 
-static unsigned get_modes(MigMode mode, va_list ap)
-{
-    unsigned modes = 0;
-
-    while (mode != -1 && mode != MIG_MODE_ALL) {
-        assert(mode >= MIG_MODE_NORMAL && mode < MIG_MODE__MAX);
-        modes |= BIT(mode);
-        mode = va_arg(ap, MigMode);
-    }
-    if (mode == MIG_MODE_ALL) {
-        modes = BIT(MIG_MODE__MAX) - 1;
-    }
-    return modes;
-}
-
 static int add_blockers(Error **reasonp, Error **errp, unsigned modes)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
@@ -1918,23 +1894,16 @@ static int add_blockers(Error **reasonp, Error **errp, unsigned modes)
 
 int migrate_add_blocker(Error **reasonp, Error **errp)
 {
-    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_ALL);
+    return migrate_add_blocker_modes(reasonp, -1u, errp);
 }
 
 int migrate_add_blocker_normal(Error **reasonp, Error **errp)
 {
-    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_NORMAL, -1);
+    return migrate_add_blocker_modes(reasonp, BIT(MIG_MODE_NORMAL), errp);
 }
 
-int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
+int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
 {
-    unsigned modes;
-    va_list ap;
-
-    va_start(ap, mode);
-    modes = get_modes(mode, ap);
-    va_end(ap);
-
     if (is_only_migratable(reasonp, errp, modes)) {
         return -EACCES;
     } else if (is_busy(reasonp, errp)) {
diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index 11cbff268f..e54c7160d3 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -11,7 +11,7 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp)
     return 0;
 }
 
-int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
+int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
 {
     return 0;
 }
diff --git a/system/physmem.c b/system/physmem.c
index a340ca3e61..a7e2a5d07f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2255,8 +2255,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        "Memory region %s uses guest_memfd, "
                        "which is not supported with CPR.",
                        memory_region_name(new_block->mr));
-            migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
-                                      MIG_MODE_CPR_TRANSFER, -1);
+            migrate_add_blocker_modes(&new_block->cpr_blocker,
+                                      BIT(MIG_MODE_CPR_TRANSFER), errp);
         }
     }
 
@@ -4462,8 +4462,8 @@ void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
                "Memory region %s is not compatible with CPR. share=on is "
                "required for memory-backend objects, and aux-ram-share=on is "
                "required.", memory_region_name(rb->mr));
-    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TRANSFER,
-                              -1);
+    migrate_add_blocker_modes(&rb->cpr_blocker, BIT(MIG_MODE_CPR_TRANSFER),
+                              errp);
 }
 
 void ram_block_del_cpr_blocker(RAMBlock *rb)
-- 
2.49.0



