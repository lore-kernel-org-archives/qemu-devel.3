Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22431C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpls-0002BQ-J6; Wed, 20 Mar 2024 02:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplq-0002Ai-Jy
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpln-0001Uk-H9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1xsCesGr8DmRI05FnWGd3Fvm5jcY0vbWbDDFmosFLo=;
 b=O+8RAh+CTIbVuMOeo9nO77vDtWr+rweqZSmCc0ZwfvTnrvCIJ7hdPDBgLD/wIqSqTHF05q
 HbZYlgphAEivOLug9DoO/5WuzgM0O1qtFpJyb3d9wSzxLEv4jFriV7czxbXt+wmzgQZIy8
 QLcdV264V0wb6r+AT7VMZwrsglPRuUc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-PBUPMybKO3i41YP6mxB3DA-1; Wed,
 20 Mar 2024 02:49:49 -0400
X-MC-Unique: PBUPMybKO3i41YP6mxB3DA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EFCE3CBDF60;
 Wed, 20 Mar 2024 06:49:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 960761C060A4;
 Wed, 20 Mar 2024 06:49:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH for-9.1 v5 08/14] migration: Add Error** argument to
 .load_setup() handler
Date: Wed, 20 Mar 2024 07:49:04 +0100
Message-ID: <20240320064911.545001-9-clg@redhat.com>
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

This will be useful to report errors at a higher level, mostly in VFIO
today.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
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
index 5763c0b68376b1e24ef3e77c3d19fcd406922c79..06ae40969b6c19037e190008e14f28be646278cd 100644
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
index 6ea5a06e00e30d0d1e4d8a6defdeb86c81fa707b..4cd4f0158c8675e1515ef8476c64d1203eed4458 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3704,8 +3704,9 @@ void colo_release_ram_cache(void)
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
index 535ad5a32d67057dd172ce25d561a66a07172e97..8f42999a15d1685957de9ed517d6bc9ba49c3f11 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2747,8 +2747,9 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
     trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
 }
 
-static int qemu_loadvm_state_setup(QEMUFile *f)
+static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD(); /* error_prepend use */
     SaveStateEntry *se;
     int ret;
 
@@ -2763,10 +2764,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
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
@@ -2947,7 +2949,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f) != 0) {
+    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
+        error_report_err(local_err);
         return -EINVAL;
     }
 
-- 
2.44.0


