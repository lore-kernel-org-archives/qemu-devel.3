Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE41D3B7E7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 13:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSbe3-0003uS-Sb; Mon, 08 Dec 2025 08:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vSbe2-0003qv-2f
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 08:51:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vSbe0-0000ZQ-FZ
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 08:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765201875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7snRi4k6OL50UuXEsAz1w2MO1BL+GPtsicaFpNiI3xo=;
 b=IVQlpTaBJImzYNdAcoIDSLH6MRM2sTsUdsgBKBVPy3LpdbzFauXzt+zmQ/GLlWNjmqvm2e
 Mk8fr6xK/fEjZs8G7ToIgGAvEcMgZBzhyUrNX8BIYDsrcOCBoO6NYjtMCJivQwFaXebNEi
 YeL2DN614jS9s3fRGDVvw36T0njWShU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-U1s6szEFNcivNt7eV_JTbw-1; Mon,
 08 Dec 2025 08:51:12 -0500
X-MC-Unique: U1s6szEFNcivNt7eV_JTbw-1
X-Mimecast-MFC-AGG-ID: U1s6szEFNcivNt7eV_JTbw_1765201870
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7062B18002ED; Mon,  8 Dec 2025 13:51:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.22.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06C73180035A; Mon,  8 Dec 2025 13:51:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] migration: Fix a possible crash when halting a guest during
 migration
Date: Mon,  8 Dec 2025 14:51:01 +0100
Message-ID: <20251208135101.271417-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When shutting down a guest that is currently in progress of being
migrated, there is a chance that QEMU might crash during bdrv_delete().
The backtrace looks like this:

 Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.

 [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
 0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
 5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
 (gdb) bt
 #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
 #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
 Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0

The problem is apparently that the migration thread is still active
(migration_shutdown() only asks it to stop the current migration, but
does not wait for it to finish), while the main thread continues to
bdrv_close_all() that will destroy all block drivers. So the two threads
are racing here for the destruction of the migration-related block drivers.

I was able to bisect the problem and the race has apparently been introduced
by commit c2a189976e211c9ff782 ("migration/block-active: Remove global active
flag"), so reverting it might be an option as well, but waiting for the
migration thread to finish before continuing with the further clean-ups
during shutdown seems less intrusive.

Note: I used the Claude AI assistant for analyzing the crash, and it
came up with the idea of waiting for the migration thread to finish
in migration_shutdown() before proceeding with the further clean-up,
but the patch itself has been 100% written by myself.

Fixes: c2a189976e ("migration/block-active: Remove global active flag")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 migration/migration.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b316ee01ab2..6f4bb6d8438 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -380,6 +380,16 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
     qemu_bh_schedule(bh);
 }
 
+static void migration_thread_join(MigrationState *s)
+{
+    if (s && s->migration_thread_running) {
+        bql_unlock();
+        qemu_thread_join(&s->thread);
+        s->migration_thread_running = false;
+        bql_lock();
+    }
+}
+
 void migration_shutdown(void)
 {
     /*
@@ -393,6 +403,13 @@ void migration_shutdown(void)
      * stop the migration using this structure
      */
     migration_cancel();
+    /*
+     * Wait for migration thread to finish to prevent a possible race where
+     * the migration thread is still running and accessing host block drivers
+     * while the main cleanup proceeds to remove them in bdrv_close_all()
+     * later.
+     */
+    migration_thread_join(migrate_get_current());
     object_unref(OBJECT(current_migration));
 
     /*
@@ -1499,12 +1516,7 @@ static void migration_cleanup(MigrationState *s)
 
     close_return_path_on_source(s);
 
-    if (s->migration_thread_running) {
-        bql_unlock();
-        qemu_thread_join(&s->thread);
-        s->migration_thread_running = false;
-        bql_lock();
-    }
+    migration_thread_join(s);
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         /*
-- 
2.52.0


