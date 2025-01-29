Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2041C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXF-0004sn-Dh; Wed, 29 Jan 2025 11:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVl-0003LF-AS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:56 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVi-0005KL-VM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:53 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC3CE21108;
 Wed, 29 Jan 2025 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jccUy2CdNNK+AFR9MDmMpa+JMnW6E1ZSY7XUmT22aI=;
 b=NnlRndMBPqPfeDJ/6GN//X1d4SRcu676QOlM1A2WhC9VzaEhkm0sFTRPO1/mK2bbI2I7T4
 c+FdLhrEQXebCnSSsQ1liSdkKcLZ4+x9/Y1D/109inVrUCWNOf+Veq6BK9R/Flo6cI6547
 sVcGVnpCq3g4Auol2iTKT41T1YFlQQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jccUy2CdNNK+AFR9MDmMpa+JMnW6E1ZSY7XUmT22aI=;
 b=/PLJISVLeDl+fbNet1nM6W3m3z1QMrilxKCoMimn3Icvqv6Z98p9d6WVmcKwhaklOqVKO0
 6+++e6/19WHpN9CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jccUy2CdNNK+AFR9MDmMpa+JMnW6E1ZSY7XUmT22aI=;
 b=NnlRndMBPqPfeDJ/6GN//X1d4SRcu676QOlM1A2WhC9VzaEhkm0sFTRPO1/mK2bbI2I7T4
 c+FdLhrEQXebCnSSsQ1liSdkKcLZ4+x9/Y1D/109inVrUCWNOf+Veq6BK9R/Flo6cI6547
 sVcGVnpCq3g4Auol2iTKT41T1YFlQQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jccUy2CdNNK+AFR9MDmMpa+JMnW6E1ZSY7XUmT22aI=;
 b=/PLJISVLeDl+fbNet1nM6W3m3z1QMrilxKCoMimn3Icvqv6Z98p9d6WVmcKwhaklOqVKO0
 6+++e6/19WHpN9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 783A2137DB;
 Wed, 29 Jan 2025 16:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YDmFDuxQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 22/42] tests/qtest: enhance migration channels
Date: Wed, 29 Jan 2025 13:00:39 -0300
Message-Id: <20250129160059.6987-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Change the migrate_qmp and migrate_qmp_fail channels argument to a QObject
type so the caller can manipulate the object before passing it to the
helper.  Define migrate_str_to_channel to aid such manipulation.
Add a channels argument to migrate_incoming_qmp.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-22-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c     | 15 ++++++--
 tests/qtest/migration/migration-qmp.c | 53 ++++++++++++++++++++++-----
 tests/qtest/migration/migration-qmp.h | 10 +++--
 tests/qtest/migration/misc-tests.c    |  9 ++++-
 tests/qtest/migration/precopy-tests.c |  6 +--
 tests/qtest/virtio-net-failover.c     |  8 ++--
 6 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 2611c31c1b..1228bd5bca 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -18,6 +18,8 @@
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
 #include "ppc-util.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -705,6 +707,7 @@ void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    QObject *out_channels = NULL;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -737,12 +740,16 @@ void test_precopy_common(MigrateCommon *args)
         }
     }
 
+    if (args->connect_channels) {
+        out_channels = qobject_from_json(args->connect_channels, &error_abort);
+    }
+
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+        migrate_qmp_fail(from, args->connect_uri, out_channels, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
+    migrate_qmp(from, to, args->connect_uri, out_channels, "{}");
 
     if (args->start.defer_target_connect) {
         qtest_connect(to);
@@ -892,7 +899,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, "{}");
+    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -928,7 +935,7 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     return NULL;
 }
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 9431d2beda..5610f6d15d 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -15,9 +15,13 @@
 #include "migration-qmp.h"
 #include "migration-util.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
 
 /*
  * Number of seconds we wait when looking for migration
@@ -47,8 +51,33 @@ void migration_event_wait(QTestState *s, const char *target)
     } while (!found);
 }
 
+/*
+ * Convert a string representing a single channel to an object.
+ * @str may be in JSON or dotted keys format.
+ */
+QObject *migrate_str_to_channel(const char *str)
+{
+    Visitor *v;
+    MigrationChannel *channel;
+    QObject *obj;
+
+    /* Create the channel */
+    v = qobject_input_visitor_new_str(str, "channel-type", &error_abort);
+    visit_type_MigrationChannel(v, NULL, &channel, &error_abort);
+    visit_free(v);
+
+    /* Create the object */
+    v = qobject_output_visitor_new(&obj);
+    visit_type_MigrationChannel(v, NULL, &channel, &error_abort);
+    visit_complete(v, &obj);
+    visit_free(v);
+
+    qapi_free_MigrationChannel(channel);
+    return obj;
+}
+
 void migrate_qmp_fail(QTestState *who, const char *uri,
-                      const char *channels, const char *fmt, ...)
+                      QObject *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -64,8 +93,7 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
 
     g_assert(!qdict_haskey(args, "channels"));
     if (channels) {
-        QObject *channels_obj = qobject_from_json(channels, &error_abort);
-        qdict_put_obj(args, "channels", channels_obj);
+        qdict_put_obj(args, "channels", channels);
     }
 
     err = qtest_qmp_assert_failure_ref(
@@ -82,7 +110,7 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *channels, const char *fmt, ...)
+                 QObject *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
@@ -102,10 +130,9 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 
     g_assert(!qdict_haskey(args, "channels"));
     if (channels) {
-        QObject *channels_obj = qobject_from_json(channels, &error_abort);
-        QList *channel_list = qobject_to(QList, channels_obj);
+        QList *channel_list = qobject_to(QList, channels);
         migrate_set_ports(to, channel_list);
-        qdict_put_obj(args, "channels", channels_obj);
+        qdict_put_obj(args, "channels", channels);
     }
 
     qtest_qmp_assert_success(who,
@@ -123,7 +150,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
-void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
+void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
+                          const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *rsp;
@@ -133,7 +161,14 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        qdict_put_obj(args, "channels", channels);
+    }
 
     /* This function relies on the event to work, make sure it's enabled */
     migrate_set_capability(to, "events", true);
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index caaa78722a..faa8181d91 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -4,17 +4,19 @@
 
 #include "migration-util.h"
 
+QObject *migrate_str_to_channel(const char *str);
+
 G_GNUC_PRINTF(4, 5)
 void migrate_qmp_fail(QTestState *who, const char *uri,
-                      const char *channels, const char *fmt, ...);
+                      QObject *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *channels, const char *fmt, ...);
+                 QObject *channels, const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
+G_GNUC_PRINTF(4, 5)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
-                          const char *fmt, ...);
+                          QObject *channels, const char *fmt, ...);
 
 void migration_event_wait(QTestState *s, const char *target);
 void migrate_set_capability(QTestState *who, const char *capability,
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 6173430748..dda3707cf3 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -11,6 +11,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qjson.h"
 #include "libqtest.h"
 #include "migration/framework.h"
 #include "migration/migration-qmp.h"
@@ -205,6 +207,7 @@ static void test_validate_uuid_dst_not_set(void)
 static void do_test_validate_uri_channel(MigrateCommon *args)
 {
     QTestState *from, *to;
+    QObject *channels;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -217,7 +220,11 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
      * 'uri' and 'channels' validation is checked even before the migration
      * starts.
      */
-    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+    channels = args->connect_channels ?
+               qobject_from_json(args->connect_channels, &error_abort) :
+               NULL;
+    migrate_qmp_fail(from, args->connect_uri, channels, "{}");
+
     migrate_end(from, to, false);
 }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 23599b29ee..436dbd98e8 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -152,7 +152,7 @@ static void *migrate_hook_start_fd(QTestState *from,
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
+    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
@@ -479,7 +479,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -518,7 +518,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
 
     migrate_ensure_non_converge(from);
 
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 08365ffa11..f04573f98c 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -773,7 +773,7 @@ static void test_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
@@ -895,7 +895,7 @@ static void test_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
@@ -1022,7 +1022,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
@@ -1747,7 +1747,7 @@ static void test_multi_in(gconstpointer opaque)
     check_one_card(qts, true, "standby1", MAC_STANDBY1);
     check_one_card(qts, false, "primary1", MAC_PRIMARY1);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
-- 
2.35.3


