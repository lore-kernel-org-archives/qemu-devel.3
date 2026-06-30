Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982CBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8b-0006km-C7; Tue, 30 Jun 2026 00:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8W-0006j3-Cs
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8T-00033u-8m
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQQs3VUP3Tf0DSLgKkdIU3GmQk0T2qvceYLI4B6CXEc=;
 b=UT1AYPateQ+krRsFmHfe+3Nef7/HeFiLmijrY11ROso3purbb0GmE5LboOhVvfCrdxVeiL
 6Cu+ZwJ9nONLDFQv8ZI4BAkOtndgu30Rulkg7Sn02cXTlAOQrfw6xRYJx+aG7d3MzGKgfj
 Hh5GcgL0H0aeoxqrmDpuI5Y2vlCquO0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-w9yaCnblOfeGD6xG3FcU3w-1; Tue,
 30 Jun 2026 00:31:46 -0400
X-MC-Unique: w9yaCnblOfeGD6xG3FcU3w-1
X-Mimecast-MFC-AGG-ID: w9yaCnblOfeGD6xG3FcU3w_1782793905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5711801BDC; Tue, 30 Jun 2026 04:31:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A85701956042; Tue, 30 Jun 2026 04:31:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/23] vfio/migration: Add new switchover-ack mechanism
Date: Tue, 30 Jun 2026 06:31:00 +0200
Message-ID: <20260630043107.1511076-17-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Add support for the new switchover-ack mechanism. This includes
requesting a switchover ACK on the first save_query_pending call (with
exact=false) if VFIO precopy is supported.

This achieves the same functionality of legacy switchover-ack but with
the new switchover-ack mechanism.

Keep legacy switchover-ack functionality for backward compatibility.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-12-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-migration-internal.h |  1 +
 hw/vfio/migration.c               | 13 ++++++++++++-
 hw/vfio/trace-events              |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a15fc74703998da1956a92c4fb8cfe9ff3a68867..dc741e51421eec6d4ad4d9ce0f9c0c2f6199788d 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -58,6 +58,7 @@ typedef struct VFIOMigration {
     bool multifd_transfer;
     VFIOMultifd *multifd;
     bool initial_data_sent;
+    bool request_switchover_ack;
 
     bool event_save_iterate_started;
     bool event_precopy_empty_hit;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3ab6b7248fea34dec3b58e508f97c8be4c962ce4..ebe2eafded50cdc3c1518a2f1e768fdfe6722c5a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -582,6 +582,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
             }
 
             vfio_query_precopy_size(migration);
+            if (migrate_switchover_ack() && !migrate_switchover_ack_legacy()) {
+                migration->request_switchover_ack = true;
+            }
 
             break;
         case VFIO_DEVICE_STATE_STOP:
@@ -634,6 +637,7 @@ static void vfio_save_cleanup(void *opaque)
     migration->precopy_init_size = 0;
     migration->precopy_dirty_size = 0;
     migration->initial_data_sent = false;
+    migration->request_switchover_ack = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
@@ -655,6 +659,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     uint64_t precopy_size, stopcopy_size;
+    bool request_switchover_ack = false;
 
     /*
      * The final pending query runs during switchover downtime. VFIO does not
@@ -676,10 +681,16 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
 
     pending->precopy_bytes += precopy_size;
     pending->stopcopy_bytes += stopcopy_size;
+    if (migration->request_switchover_ack) {
+        pending->switchover_ack_pending++;
+        request_switchover_ack = true;
+        migration->request_switchover_ack = false;
+    }
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-                             migration->precopy_dirty_size, exact, final);
+                             migration->precopy_dirty_size,
+                             request_switchover_ack, exact, final);
 }
 
 static bool vfio_is_active_iterate(void *opaque)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fe0d2cc06f946b3f0db28d13994fbd0dfd854fbd..c9d143826d38d77048ecf179cbda19a7184989a4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,7 +176,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
-vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
+vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool request_switchover_ack, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", request switchover ack %d, exact %d, final %d"
 vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-- 
2.54.0


