Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1222FC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJe-0001JY-Bi; Tue, 07 Jul 2026 02:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJV-0001AI-9k
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJT-0006ie-Pv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7u/V06wBuEW+NjIDBIXIQOYPjyU39Z3GvXCDs8zL44=;
 b=cNUyQjhkaF/6wnJ/Jk+ZESurj89PzQa0t03NaHRLKq1qFf2Y6i0Sgnf9ZvpGfvM1YciJ35
 2IXbOAbTX7Kdg1x8C1yqyQ6WThIfj5MHXvzOnCD8+4ZFF66iX8OTqWq2DTnzhKtxwbx/Z7
 MkQKtfZ5mHTbB1ihKqrV6gH9+PLi5Eo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-iikCYM0eN0WMdncB1FdylA-1; Tue,
 07 Jul 2026 02:29:46 -0400
X-MC-Unique: iikCYM0eN0WMdncB1FdylA-1
X-Mimecast-MFC-AGG-ID: iikCYM0eN0WMdncB1FdylA_1783405785
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1332B1955D72; Tue,  7 Jul 2026 06:29:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A9EF180067F; Tue,  7 Jul 2026 06:29:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/27] migration: Log the approver in
 qemu_loadvm_approve_switchover()
Date: Tue,  7 Jul 2026 08:29:02 +0200
Message-ID: <20260707062920.317302-10-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Pass the device name that approved switchover to
qemu_loadvm_approve_switchover() and log it in the trace for debugging
purposes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-5-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.h     | 2 +-
 hw/vfio/migration.c    | 2 +-
 migration/savevm.c     | 4 ++--
 migration/trace-events | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 81abd96dda94c6c95cc40b3c188df23d11c19463..44424be347494c51e6976749d7c60d27ca7f0628 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -71,7 +71,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
-int qemu_loadvm_approve_switchover(void);
+int qemu_loadvm_approve_switchover(const char *approver);
 int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 195498845ed95d6a55cf68537a100b4e83221fb0..180b316baecb980fbd475b1426726697f340ccc8 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -847,7 +847,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
                 return -EINVAL;
             }
 
-            ret = qemu_loadvm_approve_switchover();
+            ret = qemu_loadvm_approve_switchover(vbasedev->name);
             if (ret) {
                 error_report(
                     "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
diff --git a/migration/savevm.c b/migration/savevm.c
index 74d622583e345bdc96b9189aad0c8f6bad41964d..be81de26160d195488e5fb09a88dc37a7a06a3fe 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3174,7 +3174,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover(void)
+int qemu_loadvm_approve_switchover(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -3183,7 +3183,7 @@ int qemu_loadvm_approve_switchover(void)
     }
 
     mis->switchover_ack_pending_num--;
-    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
+    trace_loadvm_approve_switchover(approver, mis->switchover_ack_pending_num);
 
     if (mis->switchover_ack_pending_num) {
         return 0;
diff --git a/migration/trace-events b/migration/trace-events
index 1c9212d3e20555902f008e4c999f32642cc8fa48..c0c433744cd33d7e28496831bb8ce93c65670bf5 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -24,7 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
-loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
+loadvm_approve_switchover(const char *approver, unsigned int switchover_ack_pending_num) "Approver %s, switchover_ack_pending_num %u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
-- 
2.54.0


