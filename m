Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2923EE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCWr-0005MA-2s; Tue, 07 Jan 2025 11:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tVCWp-0005IH-8F
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tVCWn-0003wu-Hq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736267640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEZ7NzmsOAgICps73F7U4pdkWShouEtqCTMhvdwKzOc=;
 b=Dl7IktsZKOIxkwgGz3QyGW1jP9DirySM5QOkm/Q9T5N5prbL9IxXOrO1gZf8e6DLKwQOYb
 s/ihaKGcodqfk/fUlUTXvA3Mzrp1TRmOpuX6mSN9nwgL4wlQMOQxczeNuXXy5hVQwnIwQx
 mcKWMqtNmnOTuXp1HzE7BK+07EjJxF4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-3nEif75jMvizgWgVN8UOqg-1; Tue,
 07 Jan 2025 11:32:41 -0500
X-MC-Unique: 3nEif75jMvizgWgVN8UOqg-1
X-Mimecast-MFC-AGG-ID: 3nEif75jMvizgWgVN8UOqg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38F5719560AE; Tue,  7 Jan 2025 16:32:40 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.226.131])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37791195606B; Tue,  7 Jan 2025 16:32:37 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/2] tests/qtest/migration: Use out-of-band execution for
 migrate-recover
Date: Tue,  7 Jan 2025 17:31:54 +0100
Message-ID: <20250107163156.310226-3-jmarcin@redhat.com>
In-Reply-To: <20250107163156.310226-1-jmarcin@redhat.com>
References: <20250107163156.310226-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In real use cases, the migrate-recover command requires out-of-band
execution, because the thread processing normal commands is blocked by a
page fault in the guest memory. With this change, the tests will be
closer to real use cases and could help detect regressions and other
bugs in migration recovery.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 tests/qtest/migration/framework.c     | 23 +++++++++++++++++++++--
 tests/qtest/migration/framework.h     |  2 ++
 tests/qtest/migration/migration-qmp.c |  2 +-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 47ce07856e..4550cda129 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -194,6 +194,16 @@ static void cleanup(const char *filename)
     unlink(path);
 }
 
+static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
+{
+    QList *capabilities = qlist_new();
+
+    if (args->oob) {
+        qlist_append_str(capabilities, "oob");
+    }
+    return capabilities;
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -210,6 +220,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
     const char *bootpath;
+    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -314,7 +325,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
+        *from = qtest_init_with_env_and_capabilities(QEMU_ENV_SRC, cmd_source,
+                                                     capabilities);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
@@ -334,7 +346,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
+    *to = qtest_init_with_env_and_capabilities(QEMU_ENV_DST, cmd_target,
+                                               capabilities);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
@@ -601,6 +614,12 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     QTestState *from, *to;
     g_autofree char *uri = NULL;
 
+    /*
+     * Always enable OOB QMP capability for recovery tests, migrate-recover is
+     * executed out-of-band
+     */
+    args->start.oob = true;
+
     /* Always hide errors for postcopy recover tests since they're expected */
     args->start.hide_stderr = true;
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index e9fc4ec363..7991ee56b6 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -109,6 +109,8 @@ typedef struct {
     const char *opts_target;
     /* suspend the src before migrating to dest. */
     bool suspend_me;
+    /* enable OOB QMP capability */
+    bool oob;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 71b14b51b2..9431d2beda 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -464,7 +464,7 @@ void migrate_continue(QTestState *who, const char *state)
 void migrate_recover(QTestState *who, const char *uri)
 {
     qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate-recover', "
+                             "{ 'exec-oob': 'migrate-recover', "
                              "  'id': 'recover-cmd', "
                              "  'arguments': { 'uri': %s } }",
                              uri);
-- 
2.47.1


