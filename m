Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010FBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8U-0006iu-6c; Tue, 30 Jun 2026 00:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8O-0006hw-PF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8M-00032E-Ac
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsQ3r20dWJ/sbw+RO5G2Osf8/wn0Bi9DM3VVxkTPYTQ=;
 b=CJ81TeyKdVHpcgAPWpS0I51S//9Cw1yDZ7/vimrcb2xJyBZ1F/Klfwj52gPrtIpTJR4dLG
 5pYtvGG+Zs0txSki7IBoMmFFKU2PBE+Id19+ffp/+DJ3CkBNo2g7a4sPmLtb/JoCWHiexb
 dB8V78wdQkqzXPcrA5SkU6H8QDw1az0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-JxFw9DobM26dx2CaMTHjnw-1; Tue,
 30 Jun 2026 00:31:40 -0400
X-MC-Unique: JxFw9DobM26dx2CaMTHjnw-1
X-Mimecast-MFC-AGG-ID: JxFw9DobM26dx2CaMTHjnw_1782793899
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29C9F1956062; Tue, 30 Jun 2026 04:31:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A365E1956045; Tue, 30 Jun 2026 04:31:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/23] migration: Fail migration if switchover-ack is requested
 after switchover decision
Date: Tue, 30 Jun 2026 06:30:57 +0200
Message-ID: <20260630043107.1511076-14-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-9-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.h    |  4 ++--
 migration/migration.c |  4 +++-
 migration/savevm.c    | 19 ++++++++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

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
diff --git a/migration/migration.c b/migration/migration.c
index 7da86fb08aa4d694155d87b8603aeecbd31e27c0..898695a81920b7b255c7ed17b13a9065d66d8c44 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2827,7 +2827,9 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
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


