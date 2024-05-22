Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F3DC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ih3-0003ZJ-O1; Wed, 22 May 2024 05:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igq-0003S3-EG
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igo-0001Qv-R8
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JT/bVHrvMqyK5ucSJY0O+P5XBU+ZBQiDckhZnyN66vk=;
 b=TkhPxouE7B+dg/6UR9ULhXmXsRdDEPEn2UY3RtsFa/4KCXz5laSt5G0Pbs83agnR11qyHg
 tlvJ/9+0qpUnIC0JUAXxtmgklaizvbSMqHQxX8InCzQHpWgNFpM1PhigFTOzFv1LYI1Hbz
 MDxVEtqcyxXbe4cGNvZ8rUoNJW+Ln1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-O-ugEHkON0mPg8fxSqaXqQ-1; Wed, 22 May 2024 05:55:16 -0400
X-MC-Unique: O-ugEHkON0mPg8fxSqaXqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B3D9800994;
 Wed, 22 May 2024 09:55:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0934951BF;
 Wed, 22 May 2024 09:55:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/47] vfio/migration: Enhance VFIO migration state tracing
Date: Wed, 22 May 2024 11:54:13 +0200
Message-ID: <20240522095442.195243-19-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Move trace_vfio_migration_set_state() to the top of the function, add
recover_state to it, and add a new trace event to
vfio_migration_set_device_state().

This improves tracing of device state changes as state changes are now
also logged when vfio_migration_set_state() fails (covering recover
state and device reset transitions) and in no-op state transitions to
the same state.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c  | 8 ++++++--
 hw/vfio/trace-events | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 56edffaf6251e28e39ef32991394697abb1b9e55..34d4be2ce1b13626a8690d4787366ee41a9ebe1e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -129,6 +129,9 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
 {
     VFIOMigration *migration = vbasedev->migration;
 
+    trace_vfio_migration_set_device_state(vbasedev->name,
+                                          mig_state_to_str(state));
+
     migration->device_state = state;
     vfio_migration_send_event(vbasedev);
 }
@@ -150,6 +153,9 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         g_strdup_printf("%s: Failed setting device state to %s.",
                         vbasedev->name, mig_state_to_str(new_state));
 
+    trace_vfio_migration_set_state(vbasedev->name, mig_state_to_str(new_state),
+                                   mig_state_to_str(recover_state));
+
     if (new_state == migration->device_state) {
         return 0;
     }
@@ -209,8 +215,6 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         migration->data_fd = mig_state->data_fd;
     }
 
-    trace_vfio_migration_set_state(vbasedev->name, mig_state_to_str(new_state));
-
     return 0;
 
 reset_device:
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f0474b244bf04d044e8327c88bf49aef349afcca..64161bf6f44cffd73851a90b70694120a5fb2a82 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -152,7 +152,8 @@ vfio_load_device_config_state(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
 vfio_migration_realize(const char *name) " (%s)"
-vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
+vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
+vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
-- 
2.45.1


