Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5A4C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJo-0001iD-59; Tue, 07 Jul 2026 02:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJg-0001NX-JU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJd-0006xq-AC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5q2mnAdIQtPhNzdphqSInaXNkpfTLZku26D0w7YULzo=;
 b=APcwu6bcvi0iz71tLBygyWGTF586joFrEtnNBEDlAQDJpsQMw8Qe47rQRqBJyTb0w/TBbb
 RZsTbcjEp1jdkfj3sFhANie64MESw8wf0m2SWSL9GmuKW8wkMaK1SLJZ+vpLrXxU/rVP8M
 x/RJ56fwwkfhQ0LKyNAc45mNhZkX6AY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-HZ0FF7qZMVmHht9brX44Aw-1; Tue,
 07 Jul 2026 02:29:53 -0400
X-MC-Unique: HZ0FF7qZMVmHht9brX44Aw-1
X-Mimecast-MFC-AGG-ID: HZ0FF7qZMVmHht9brX44Aw_1783405792
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 699B91805C1E; Tue,  7 Jul 2026 06:29:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38AF11800678; Tue,  7 Jul 2026 06:29:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/27] migration: Fail migration if switchover-ack is requested
 after switchover decision
Date: Tue,  7 Jul 2026 08:29:06 +0200
Message-ID: <20260707062920.317302-14-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Switchover ACK is checked only during precopy while the guest is still
running. The last migration_can_switchover() decision and guest stop are
not atomic, so a device may want to request another switchover ACK in
the gap after switchover decision has been made but before the guest is
stopped. Migration would then miss that request, which can increase
downtime.

Cover this case by failing the migration if a switchover-ack was
requested during that time.

Ideally, precopy iterations should be resumed in this case, however,
VFIO doesn't support going back to precopy after being stopped, so
implementing such logic would require non-trivial changes to the guest
start/stop flow. Given the above and that this case should be rare,
failing the migration seems reasonable.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-9-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.h    |  4 ++--
 migration/colo.c      |  6 +++++-
 migration/migration.c |  4 +++-
 migration/savevm.c    | 19 ++++++++++++++++++-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index fb92d3bc8586553c490eb03d68be3cb56c8d0554..415198423f578049c209a1e40b796cfe63b410f0 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -47,8 +47,8 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
 void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
                                     bool exact);
-void qemu_savevm_query_pending_final(MigrationState *s,
-                                     MigPendingData *pending);
+bool qemu_savevm_query_pending_final(MigrationState *s,
+                                     MigPendingData *pending, Error **errp);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/migration/colo.c b/migration/colo.c
index 0cef0f6b0e650500496f51f49b2149154166a90f..0f30a5926fdd83c7dca10e89601bced6e7af7124 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -473,7 +473,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * state is saved. Unlike a regular switchover, COLO reaches completion
      * repeatedly for every checkpoint, so this must be done on each one.
      */
-    qemu_savevm_query_pending_final(s, &pending);
+    if (!qemu_savevm_query_pending_final(s, &pending, &local_err)) {
+        ret = -1;
+        bql_unlock();
+        goto out;
+    }
 
     /*
      * Only save VM's live state, which not including device state.
diff --git a/migration/migration.c b/migration/migration.c
index 2b625da114dbfbbc8f77a359d896eb4b8c10378e..98603ee19c34531d069400d1ab0ed36b65bb228e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2833,7 +2833,9 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
      * properly update all the dirty bitmaps to finally generate the
      * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
      */
-    qemu_savevm_query_pending_final(s, &pending);
+    if (!qemu_savevm_query_pending_final(s, &pending, errp)) {
+        return false;
+    }
 
     /* Inactivate disks except in COLO */
     if (!migrate_colo()) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 1f6e696c50d189370a311c25d8eb092bc41c2b24..f654a1c563df40d546e42018a3706e92fb11cfa7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1852,11 +1852,28 @@ void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
     qemu_savevm_query_pending(s, pending, exact, false);
 }
 
-void qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *pending)
+bool qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *pending,
+                                     Error **errp)
 {
     g_assert(bql_locked());
 
     qemu_savevm_query_pending(s, pending, true, true);
+
+    /*
+     * Switchover-ack requests done after switchover decision are not allowed.
+     * Fail the migration in this case since we currently don't support going
+     * back to precopy.
+     */
+    if (migrate_switchover_ack() && !migrate_switchover_ack_legacy() &&
+        pending->switchover_ack_pending > 0) {
+        error_setg(errp,
+                   "Switchover ACK was requested by %" PRIu32
+                   " devices during switchover",
+                   pending->switchover_ack_pending);
+        return false;
+    }
+
+    return true;
 }
 
 void qemu_savevm_state_cleanup(void)
-- 
2.54.0


