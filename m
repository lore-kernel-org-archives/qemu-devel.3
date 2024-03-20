Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212F1C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmplh-00028k-3r; Wed, 20 Mar 2024 02:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplf-00027u-Pr
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmple-0001SK-9f
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNMmB6yyUsytDhCm7nfitLmmtGZ74w4pG32k0qd59oQ=;
 b=I1Z4T8ujijRmgX+zyd7vkNfp2nbccKYuacicR5rV/gv1AohEIN/WbXlRQ1j2SlvdnYbgOZ
 yc1nRmVrq0+JJrZAZKcwCkuTaNJ+q3UR8/HtQxTfnHTz8gGLevSNAX4fbB/Rbj6mez8YF/
 oxUJyqDN2eFCWIEWN/ls2WaHYfU4Q+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-FuHdDsyJMGqvMOc4D6AEcw-1; Wed, 20 Mar 2024 02:49:38 -0400
X-MC-Unique: FuHdDsyJMGqvMOc4D6AEcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72777800265;
 Wed, 20 Mar 2024 06:49:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7967E1C060A6;
 Wed, 20 Mar 2024 06:49:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 05/14] migration: Add Error** argument to
 vmstate_save()
Date: Wed, 20 Mar 2024 07:49:01 +0100
Message-ID: <20240320064911.545001-6-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This will prepare ground for future changes adding an Error** argument
to qemu_savevm_state_setup().

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 388d7af7cdd842ec94fe782ed53979b800ffd4f6..1a7b5cb78a912c36ae16db703afc90ef2906b61f 100644
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
@@ -1542,6 +1542,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     JSONWriter *vmdesc = ms->vmdesc;
     int vmdesc_len;
     SaveStateEntry *se;
+    Error *local_err = NULL;
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1552,8 +1553,10 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
-        ret = vmstate_save(f, se, vmdesc);
+        ret = vmstate_save(f, se, vmdesc, &local_err);
         if (ret) {
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
@@ -1568,7 +1571,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
          * bdrv_activate_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
         if (ret) {
-            Error *local_err = NULL;
             error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
                        __func__, ret);
             migrate_set_error(ms, local_err);
@@ -1764,6 +1766,8 @@ void qemu_savevm_live_state(QEMUFile *f)
 
 int qemu_save_device_state(QEMUFile *f)
 {
+    MigrationState *ms = migrate_get_current();
+    Error *local_err = NULL;
     SaveStateEntry *se;
 
     if (!migration_in_colo_state()) {
@@ -1778,8 +1782,10 @@ int qemu_save_device_state(QEMUFile *f)
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


