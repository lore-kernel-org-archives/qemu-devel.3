Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B04C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uXB-0005LO-Hi; Mon, 06 May 2024 05:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uXA-0005In-2C
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uX6-0007CQ-WB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714987268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDa4d2Q3udQK17hTHe+N/FSKTMqI4XXTYCIV5977Ksg=;
 b=aTNSqvQnZfyudxEHA+euMdveTLAO4cZhgqr/QaK3RZ8AMlAJD1OzxNst2CKO8qZYYbwYEd
 jVfmXiy9ILMElPE7W3IKicaMzqo11NnSaoYBVajIefhkodSVNtdicLEYouMxfMEkarWFye
 0kOWOoDhw4BQZbtJ1RKxmFMYcf8YMCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-djvABN3BNfqj5cCfE56gRA-1; Mon, 06 May 2024 05:21:04 -0400
X-MC-Unique: djvABN3BNfqj5cCfE56gRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D0F2802E4D;
 Mon,  6 May 2024 09:21:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8414CAC6B;
 Mon,  6 May 2024 09:21:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 03/10] vfio: Extend migration_file_set_error() with Error**
 argument
Date: Mon,  6 May 2024 11:20:46 +0200
Message-ID: <20240506092053.388578-4-clg@redhat.com>
In-Reply-To: <20240506092053.388578-1-clg@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use it to update the current error of the migration stream if
available and if not, simply print out the error. Next changes will
update with an error to report.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h | 2 +-
 hw/vfio/common.c         | 2 +-
 hw/vfio/migration.c      | 4 ++--
 migration/migration.c    | 6 ++++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c9e200f4eb8f8a8ab2c8b8d0e0dbf871817b94fc..8da2f6454d82046c449f034eb978e1247a9be682 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -103,7 +103,7 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
 
 void migration_remove_notifier(NotifierWithReturn *notify);
 bool migration_is_running(void);
-void migration_file_set_error(int err);
+void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b5102f54a6474a50c6366e8fbce23812d55e384e..ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -150,7 +150,7 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
 static void vfio_set_migration_error(int err)
 {
     if (migration_is_setup_or_active()) {
-        migration_file_set_error(err);
+        migration_file_set_error(err, NULL);
     }
 }
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 06ae40969b6c19037e190008e14f28be646278cd..bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -726,7 +726,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        migration_file_set_error(ret);
+        migration_file_set_error(ret, NULL);
     }
 
     trace_vfio_vmstate_change_prepare(vbasedev->name, running,
@@ -756,7 +756,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        migration_file_set_error(ret);
+        migration_file_set_error(ret, NULL);
     }
 
     trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
diff --git a/migration/migration.c b/migration/migration.c
index b5af6b5105d58f358f6d4d31694e21debd8eb81d..9c648f5ba1c0104088e37baf90d9f94fbdc21570 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3033,13 +3033,15 @@ static MigThrError postcopy_pause(MigrationState *s)
     }
 }
 
-void migration_file_set_error(int err)
+void migration_file_set_error(int ret, Error *err)
 {
     MigrationState *s = current_migration;
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
-            qemu_file_set_error(s->to_dst_file, err);
+            qemu_file_set_error_obj(s->to_dst_file, ret, err);
+        } else if (err) {
+            error_report_err(err);
         }
     }
 }
-- 
2.45.0


