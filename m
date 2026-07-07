Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0553C44502
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJl-0001Tt-Ao; Tue, 07 Jul 2026 02:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJg-0001NW-J0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJe-0006xx-Qv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7yS9ctWuCmArMzFElGqdVRK3eIDdE+8aeTp8HDoPlk=;
 b=ROWLqHivlXzTXij2RiUNcCp9BhTVE3m443V2PDUlG57O99ymo2jcQAF/nYUrnoRRVWhou+
 7r6E/3Y9reNAYYDi3BwbSZQLv8KfnJILjZ+lr8hENjbBFSMytYcKaMWTQX3bf9mT4gaX5+
 JylEa/u09CcSo6EpQDT6KWXv29fcg34=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-8399qBiVOj-xjis-cqxcNQ-1; Tue,
 07 Jul 2026 02:29:55 -0400
X-MC-Unique: 8399qBiVOj-xjis-cqxcNQ-1
X-Mimecast-MFC-AGG-ID: 8399qBiVOj-xjis-cqxcNQ_1783405794
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69C7A1805C05; Tue,  7 Jul 2026 06:29:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA327180065F; Tue,  7 Jul 2026 06:29:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/27] vfio/migration: Extract VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
 sending to helper
Date: Tue,  7 Jul 2026 08:29:07 +0200
Message-ID: <20260707062920.317302-15-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Extract the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT flag sending logic from
vfio_save_iterate() into vfio_send_init_data_flag() for clarity. Also
add a trace while at it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-10-avihaih@nvidia.com
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


