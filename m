Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEC0E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7bT-0003PG-KY; Tue, 24 Dec 2024 11:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bJ-0003KW-4a
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bG-0003Dp-CX
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:40 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfaSw021753;
 Tue, 24 Dec 2024 16:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=r1srPJSQhfY4Hx0YIJee1U+LczokYroqvWXK2gjx+KI=; b=
 WAKJQxELxLukZhhhzUz9fM+pWWRaXCac8jvob7vRYe9f3AugPBcEekuojol8VCpi
 czRvnq1eD7QemI6o2UtzVO9NYQIAQym4OUTWBbLI3goXQdSKq+Le40FBaYII4axC
 m8VEIeXqNe+PUYfhUsiShDwJwmE9CgsozCPsxeuSKDxDrIuymu8bgiYPwufT81Rn
 H4yIts0q+YFhM50wOhjWrZ4AoUOwCWxVH9tVJiepAp1S62eoTdMFBQ+5ecf2TGaB
 xTyh7yFJzR+j1/8yCcNom0GomvASlwX3hNiK47gHRJtwnxp9psibtrUhVspTlXi7
 9dRPIdLwCCdZOb6ex6hfPg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq74cgjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOGG6Rd022588; Tue, 24 Dec 2024 16:17:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9Xu021973;
 Tue, 24 Dec 2024 16:17:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-21; Tue, 24 Dec 2024 16:17:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 20/23] tests/qtest: enhance migration channels
Date: Tue, 24 Dec 2024 08:17:05 -0800
Message-Id: <1735057028-308595-21-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-ORIG-GUID: 2cpGC0adRSsRDZvOF5osa1Cqui3aD4wa
X-Proofpoint-GUID: 2cpGC0adRSsRDZvOF5osa1Cqui3aD4wa
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Change the migrate_qmp and migrate_qmp_fail channels argument to a QObject
type so the caller can manipulate the object before passing it to the
helper.  Define migrate_str_to_channel to aid such manipulation.
Add a channels argument to migrate_incoming_qmp.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/framework.c     | 15 +++++++---
 tests/qtest/migration/migration-qmp.c | 53 +++++++++++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.h | 10 ++++---
 tests/qtest/migration/misc-tests.c    |  9 +++++-
 tests/qtest/migration/precopy-tests.c |  6 ++--
 tests/qtest/virtio-net-failover.c     |  8 +++---
 6 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b3c2c6e..c6ea3e1 100644
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
@@ -690,6 +692,7 @@ void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    QObject *out_channels = NULL;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -722,12 +725,16 @@ void test_precopy_common(MigrateCommon *args)
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
@@ -877,7 +884,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, "{}");
+    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -913,7 +920,7 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     return NULL;
 }
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 71b14b5..f7a597d 100644
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
index caaa787..faa8181 100644
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
index 6173430..dda3707 100644
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
index b709d90..b8a08dd 100644
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
index 08365ff..f04573f 100644
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
1.8.3.1


