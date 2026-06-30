Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B728C43638
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8a-0006kD-S8; Tue, 30 Jun 2026 00:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8S-0006iQ-GZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8O-00032n-MP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tae1QMQyfrh+Q+13TG7Lqz0YSkMFkjUFAigXNQvKLH0=;
 b=htv640qVSyqbhLinQnIV7Tqadj24C+qhx5mYHr/Kku5LYnT9T4dvf787B0h3T4P1kJuB/U
 /Kc8mvj/aZ4QK8jDtcq2hDnLwGCjyNLvJNhkPLk4JOc0ChVm3ggBpvxcruXGOTOJFcZKlG
 7WJqRQJgQ4OnyKNxXZlw12BM64QzAFE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-LZ8opLGGPNWOl0mduPxJ-Q-1; Tue,
 30 Jun 2026 00:31:42 -0400
X-MC-Unique: LZ8opLGGPNWOl0mduPxJ-Q-1
X-Mimecast-MFC-AGG-ID: LZ8opLGGPNWOl0mduPxJ-Q_1782793901
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E8DB1977404; Tue, 30 Jun 2026 04:31:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CE5F1956042; Tue, 30 Jun 2026 04:31:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/23] vfio/migration: Extract VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
 sending to helper
Date: Tue, 30 Jun 2026 06:30:58 +0200
Message-ID: <20260630043107.1511076-15-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Extract the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT flag sending logic from
vfio_save_iterate() into vfio_send_init_data_flag() for clarity. Also
add a trace while at it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-10-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c  | 26 +++++++++++++++++++++-----
 hw/vfio/trace-events |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b7acb2fa19d3ee618e73365ca995bbdb4676055..45f8e346b4a69a798366d460eccf028f35e7a47f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -480,6 +480,26 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
                                          data_size);
 }
 
+/* Returns true if the init data flag was sent, false otherwise */
+static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
+{
+    VFIODevice *vbasedev = migration->vbasedev;
+
+    if (!migrate_switchover_ack()) {
+        return false;
+    }
+
+    if (migration->precopy_init_size || migration->initial_data_sent) {
+        return false;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
+    migration->initial_data_sent = true;
+    trace_vfio_send_init_data_flag(vbasedev->name);
+
+    return true;
+}
+
 static bool vfio_precopy_supported(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -693,11 +713,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
 
     vfio_update_estimated_pending_data(migration, data_size);
 
-    if (migrate_switchover_ack() && !migration->precopy_init_size &&
-        !migration->initial_data_sent) {
-        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
-        migration->initial_data_sent = true;
-    } else {
+    if (!vfio_send_init_data_flag(f, migration)) {
         qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fa2204f002970c31eb987ae13113a9a5edb3e172..fe0d2cc06f946b3f0db28d13994fbd0dfd854fbd 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -177,6 +177,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
+vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.54.0


