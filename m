Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9BC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQk-0008IT-Fy; Wed, 06 Mar 2024 08:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQh-0008Hy-I8
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQe-0005WW-U8
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYMy2VRjz4wyh;
 Thu,  7 Mar 2024 00:35:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYMv172vz4wcF;
 Thu,  7 Mar 2024 00:35:22 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 09/25] migration: Add Error** argument to vmstate_save()
Date: Wed,  6 Mar 2024 14:34:24 +0100
Message-ID: <20240306133441.2351700-10-clg@redhat.com>
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

This will prepare ground for future changes adding an Error** argument
to qemu_savevm_state_setup().

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 63066f49f3ad5504be6d44ffdf9f7b759c0a25ef..ee31ffb5e88cea723039c754c30ce2c8a0ef35f3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1009,11 +1009,10 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
     }
 }
 
-static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
+static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
+                        Error **errp)
 {
     int ret;
-    Error *local_err = NULL;
-    MigrationState *s = migrate_get_current();
 
     if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
         return 0;
@@ -1035,10 +1034,9 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
+        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc,
+                                          errp);
         if (ret) {
-            migrate_set_error(s, local_err);
-            error_report_err(local_err);
             return ret;
         }
     }
@@ -1325,8 +1323,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
-            ret = vmstate_save(f, se, ms->vmdesc);
+            ret = vmstate_save(f, se, ms->vmdesc, &local_err);
             if (ret) {
+                migrate_set_error(ms, local_err);
+                error_report_err(local_err);
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1545,6 +1545,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     JSONWriter *vmdesc = ms->vmdesc;
     int vmdesc_len;
     SaveStateEntry *se;
+    Error *local_err = NULL;
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1555,8 +1556,10 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
-        ret = vmstate_save(f, se, vmdesc);
+        ret = vmstate_save(f, se, vmdesc, &local_err);
         if (ret) {
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
@@ -1571,7 +1574,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
          * bdrv_activate_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
         if (ret) {
-            Error *local_err = NULL;
             error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
                        __func__, ret);
             migrate_set_error(ms, local_err);
@@ -1767,6 +1769,8 @@ void qemu_savevm_live_state(QEMUFile *f)
 
 int qemu_save_device_state(QEMUFile *f)
 {
+    MigrationState *ms = migrate_get_current();
+    Error *local_err = NULL;
     SaveStateEntry *se;
 
     if (!migration_in_colo_state()) {
@@ -1781,8 +1785,10 @@ int qemu_save_device_state(QEMUFile *f)
         if (se->is_ram) {
             continue;
         }
-        ret = vmstate_save(f, se, NULL);
+        ret = vmstate_save(f, se, NULL, &local_err);
         if (ret) {
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             return ret;
         }
     }
-- 
2.44.0


