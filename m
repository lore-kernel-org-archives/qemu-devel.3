Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA2ECCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lq-00013p-Pi; Mon, 03 Nov 2025 16:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1ln-000131-0B
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lW-0005Me-In
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNwsgUgfgeWWiy0ih7qNfqRLsac0y4EvH0bl57XKbX4=;
 b=b135Rwxla6BC/JMUCSl3adPXkVNb3hEQ07cLD40b2qoU11i3N279QDa1mm4nxHaf7t3egN
 Ni96+l2yKQBUnFW1mucX8uORSOdC3Rzeec3OBcANHQYXHocbPjzCRAdgHtPpNVUgXfBm7c
 gap5WOhthQ678XLg81cAgPd72FHDxzY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-MHSsEQfoN0K0L-5zPVY4kg-1; Mon, 03 Nov 2025 16:06:58 -0500
X-MC-Unique: MHSsEQfoN0K0L-5zPVY4kg-1
X-Mimecast-MFC-AGG-ID: MHSsEQfoN0K0L-5zPVY4kg_1762204018
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e884663b25so141332421cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204017; x=1762808817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNwsgUgfgeWWiy0ih7qNfqRLsac0y4EvH0bl57XKbX4=;
 b=LMoUR/R+9Epd8CmRm9GJKhbRp85DL0yWS2kQZyZN6ljY0NQHy1gkwoV31VJ2bKonzJ
 Z1Phk1f27a8rgaZtbTRIaAA9m0VVVnK0UXv/9ql1hRKrMsA5oqWUaGcxu4yH2F8zZCxn
 pwcF0OCXHh/ePaYCj8uPV7FzmwAdzo/A29ow8Yx0v0LkfxZg37JEij7SHMQQEicUFxO7
 o7kIhyk+vtTLWLwUyeRUro1EhWxmlCo3ue+qL65TnGkWRoW6nLehjnG5mg/jYK7VY1ua
 a3w8dxO5kQiRkzChLpSqhjqOIZ17BcwS7ZLP8tGMPS4Wz06sFjPqJRBL+3QjKBpj0KNk
 IJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204017; x=1762808817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNwsgUgfgeWWiy0ih7qNfqRLsac0y4EvH0bl57XKbX4=;
 b=ZkJKgXSOnbTct176FXEoUQ9Ar3mwA+Y0AwZAQVI2kVD6dDQll55spvcoq0iFt5d54D
 rCuxVXtF87bsl5U947M1W3ZD68K4M95e2GL6vz+Eb+HL9mb7lRyo41kWkqj5h4p0ex8t
 w2tlpyZwnNglpyO1wm9A2cUXdwri6czkKrA5SrumMy7TNKNEEESmQ98qaWLnSz7h6QMA
 DdCNNwMg2MfKwictWvbBjs+UHNeRqcVUI6I+Y06Q2bnpNv7R0HvAbDHiFMih3T1w9Ruv
 U5ElExeoJ2MfYvkjGFfZCMY2LdKN43avR3F9EyeBokYLKhhG31LjouCGVcsveXt4EAv/
 nXAg==
X-Gm-Message-State: AOJu0YwmbcOuvmnp8o2DKM3H+6MuwAiGoR0WjPEA889Y5KXcJP5z3Hu8
 Y1/zbGewokT+zsjCYjsOi8DiYV/KPl2saxTZqUDYgLtbbIzsRe7en6kAdEtj2MdOH7fVOR531Zf
 w54+Aab3/l9w+veOjSHzgRs0wFMxF72Zs0FouGVu6s2lPNcb1GechAd7zASlFJeYFZPPMOl0nQ+
 aT6O12dJj3xH9z/gNtkj7uMt+5VR8tbpx2gmvsRQ==
X-Gm-Gg: ASbGncvUwRIH0tqHL9sTny3XISNYWaBN3uJ7D5d759jgfP1Z1D0FEApvwwR78NVxrat
 IJdhf0R/PgIULdjDIcFQSdeckLbU03fqH2ZDMfxLJBBkLe6gtVapjZesSR74vjjSK03ejNKErx/
 ZrC6vWRD1aZbM5YCnYXsnzXH33I7/FfZkHh5W9DPO2tzGoPPCRqDz7R3czHxtTRIljmdqsivv6O
 hVxHJg0ritqXegg8hNT00godhoYYBLEbg8E35gn0duPerZCcTjntYNboc6/um8W1crpETTph7id
 +njLjKvZlMCRFJar5wSqVmxNrr5UxM7SMyLnLYWToeU75XUy9cpIwhbFgJK0TbFM
X-Received: by 2002:a05:622a:424d:b0:4ec:f023:b589 with SMTP id
 d75a77b69052e-4ed31055c71mr200949621cf.63.1762204017198; 
 Mon, 03 Nov 2025 13:06:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk8gSXZS/bdr9fQe7q5is4zbAXxzGPLluwezGWb0n2yFjEaTlkOt8Qq/wnkC41aelikBny9g==
X-Received: by 2002:a05:622a:424d:b0:4ec:f023:b589 with SMTP id
 d75a77b69052e-4ed31055c71mr200948891cf.63.1762204016564; 
 Mon, 03 Nov 2025 13:06:56 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:55 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 19/36] migration: Use bitset of MigMode instead of variable
 arguments
Date: Mon,  3 Nov 2025 16:06:08 -0500
Message-ID: <20251103210625.3689448-20-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

migrate_add_blocker_modes() and migration_add_notifier_modes use
variable arguments for a set of migration modes.  The variable
arguments get collected into a bitset for processsing.  Take a bitset
argument instead, it's simpler.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251027064503.1074255-3-armbru@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
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
index 478c76bc25..f613b95287 100644
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
2.50.1


