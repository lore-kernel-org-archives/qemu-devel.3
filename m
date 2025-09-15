Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AFFCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7sc-00046j-2z; Mon, 15 Sep 2025 08:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7sL-00045X-4S
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7s7-0004ZY-AF
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757937586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2UP8i+XysbpcmQ+9CUYa5lGbv29nNSPR9oZG3/6NeA=;
 b=OyZekJ/Qr5By3n+4XO9c4PMw1oWDhQfbK76+yYpWtZktZMeASNnyKZtdfXdvvLICeBuMzT
 rSPY0+zKzii7f2cqnKYK3udtuwZGkwgTUg5Tv+gMUpd7mtGO5yR3Seqyxjr/zWgJh6xOA2
 V7UEcUztjVizuVH9zAydSMRL7tI2nic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-A0vxFNLPMF-mAykjCH3LZw-1; Mon,
 15 Sep 2025 07:59:44 -0400
X-MC-Unique: A0vxFNLPMF-mAykjCH3LZw-1
X-Mimecast-MFC-AGG-ID: A0vxFNLPMF-mAykjCH3LZw_1757937583
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C25D21800378; Mon, 15 Sep 2025 11:59:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.193])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BB641954128; Mon, 15 Sep 2025 11:59:40 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/4] migration: Accept MigrationStatus in
 migration_has_failed()
Date: Mon, 15 Sep 2025 13:59:13 +0200
Message-ID: <20250915115918.3520735-3-jmarcin@redhat.com>
In-Reply-To: <20250915115918.3520735-1-jmarcin@redhat.com>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

This allows to reuse the helper also with MigrationIncomingState.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c | 8 ++++----
 migration/migration.h | 2 +-
 migration/multifd.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 54dac3db88..2c0b3a7229 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1542,7 +1542,7 @@ static void migration_cleanup(MigrationState *s)
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
     }
-    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
+    type = migration_has_failed(s->state) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
     migration_call_notifiers(s, type, NULL);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1700,10 +1700,10 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
     return ret;
 }
 
-bool migration_has_failed(MigrationState *s)
+bool migration_has_failed(MigrationStatus state)
 {
-    return (s->state == MIGRATION_STATUS_CANCELLED ||
-            s->state == MIGRATION_STATUS_FAILED);
+    return (state == MIGRATION_STATUS_CANCELLED ||
+            state == MIGRATION_STATUS_FAILED);
 }
 
 bool migration_in_postcopy(void)
diff --git a/migration/migration.h b/migration/migration.h
index 01329bf824..2c2331f40d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -535,7 +535,7 @@ bool migration_is_blocked(Error **errp);
 bool migration_in_postcopy(void);
 bool migration_postcopy_is_alive(MigrationStatus state);
 MigrationState *migrate_get_current(void);
-bool migration_has_failed(MigrationState *);
+bool migration_has_failed(MigrationStatus state);
 bool migrate_mode_is_cpr(MigrationState *);
 
 uint64_t ram_get_total_transferred_pages(void);
diff --git a/migration/multifd.c b/migration/multifd.c
index b255778855..c569f91f2c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -568,7 +568,7 @@ void multifd_send_shutdown(void)
              * already failed. If the migration succeeded, errors are
              * not expected but there's no need to kill the source.
              */
-            if (local_err && !migration_has_failed(migrate_get_current())) {
+            if (local_err && !migration_has_failed(migrate_get_current()->state)) {
                 warn_report(
                     "multifd_send_%d: Failed to terminate TLS connection: %s",
                     p->id, error_get_pretty(local_err));
-- 
2.51.0


